#!/usr/bin/env bash

# Install Rust
if [[ -z ${TRAVIS_RUST_VERSION+w} ]]; then
  curl https://sh.rustup.rs -sSf | bash -s -- -y
fi

if [[ ${TRAVIS_OS_NAME} == "osx" ]] && [[ ${PYTHON_TESTS} == "true" ]]; then
  # install pyenv
  git clone --depth 1 https://github.com/pyenv/pyenv ~/.pyenv
  PYENV_ROOT="$HOME/.pyenv"
  PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init -)"

  case "${TOXENV}" in
    "py36")
      pyenv install 3.6.1
      pyenv global 3.6.1
      ;;
    "py37")
      pyenv install 3.7.2
      pyenv global 3.7.2
      ;;
    "py38")
      pyenv install 3.8.1
      pyenv global 3.8.1
      ;;
  esac
  pyenv rehash

  # A manual check that the correct version of Python is running.
  python --version
fi
