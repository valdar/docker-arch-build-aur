FROM archlinux:latest

RUN pacman -Syu --noconfirm --needed base base-devel devtools && \
    useradd -d /home/makepkg makepkg && \
    mkdir -p /home/makepkg/{.config/pacman,.gnupg,out} && \
    echo 'MAKEFLAGS="-j$(nproc)"' >> /home/makepkg/.config/pacman/makepkg.conf && \
    echo 'PKGDEST="/home/makepkg/out"' >> /home/makepkg/.config/pacman/makepkg.conf && \
    echo 'keyserver-options auto-key-retrieve' > /home/makepkg/.gnupg/gpg.conf && \
    chown -R makepkg:users /home/makepkg

VOLUME /pkg /build

COPY sudoers /etc/sudoers
COPY build-aur build-pkgbuild build-repo /
