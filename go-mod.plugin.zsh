function go_mod_cwd() {
  if [[ -z "$GO_MOD_CWD" ]]; then
    local GO_MOD_CWD=1
    # Check if this is a Git repo
    local GIT_REPO_ROOT=""
    local GIT_TOPLEVEL="$(git rev-parse --show-toplevel 2> /dev/null)"
    if [[ $? == 0 ]]; then
      GIT_REPO_ROOT="$GIT_TOPLEVEL"
    fi
    if [[ "${PWD##$GOPATH/src}" != "${PWD}" && "$GIT_REPO_ROOT" != "" ]]; then
      # Check if this is a go project
      if [[ -f $GIT_REPO_ROOT/go.mod ]]; then
	# Check if this project is enable go module
        export GO111MODULE=on
      fi
    fi
  fi
}

if ! (( $chpwd_functions[(I)go_mod_cwd] )); then
  chpwd_functions+=(go_mod_cwd)
fi
