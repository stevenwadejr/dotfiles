#!/usr/bin/env zsh

cd "$(dirname "${ZSH_SOURCE}")";

git pull origin master;

function doIt() {
	rsync --exclude ".git/" \
		--exclude ".DS_Store" \
		--exclude ".osx" \
		--exclude "bootstrap.sh" \
		--exclude "install.sh" \
		--exclude "README.md" \
		--exclude "LICENSE-MIT.txt" \
		-avh --no-perms . ~;
	source ~/.zshrc;
}

if [ "$1" = "--force" ] || [ "$1"  = "-f" ]; then
	doIt;
else
        read "REPLY?This may overwrite existing files in your home directory. Are you sure? (y/n)?"
	echo "";
	if [[ "$REPLY" =~ ^[Yy]$ ]]; then
		doIt;
	fi;
fi;
unset doIt;
