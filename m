Date: Mon, 24 Jul 2000 08:42:26 -0400
From: Josh Huber <huber@mclx.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: Kernel build headers [was: Re: problems about __cli()]
Message-ID: <20000724084226.C263@mclx.com>
References: <200007240811.JAA05417@hyperion.valhalla.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="1ccMZA6j1vT5UqiK"
In-Reply-To: <200007240811.JAA05417@hyperion.valhalla.net>; from iain@sandoe.co.uk on Mon, Jul 24, 2000 at 09:11:08AM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--1ccMZA6j1vT5UqiK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 24, 2000 at 09:11:08AM +0100, Iain Sandoe wrote:
> On 2.2.17pre10 (having done a make mrproper, menuconfig, dep):
>=20
> [root@athena stable-dma-int]# make vmlinux
> gcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -o
> scripts/split-include scripts/split-include.c
> In file included from /usr/include/errno.h:36,
>                  from scripts/split-include.c:26:
> /usr/include/bits/errno.h:25: linux/errno.h: No such file or directory

The reason this is failing is split-include isn't part of the kernel,
it's part of the build process and is a regular user-space binary,
which should be including the header files that your libc was built
against.

> So, if you are (habitually) building different kernels what *is* the right
> solution?  Point to the source for the delivered kernel? (this won't work=
 if
> you make new headers in asm-ppc BTW) Point to the current source? Maintain
> several parallel installations? (not sure how practical that is)...

Ok, in the case of redhat systems which use the symlinks, they should
point to /usr/src/linux/include/{linux,asm,etc}, and /usr/src/linux
should point to /usr/src/kernel_that_shipped_with_distro

IMHO, you should never have to change this setup, unless perhaps you
rebuild libc against a newer kernel.

Please read this:
http://www.debian.org/Lists-Archives/debian-policy-9907/msg00182.html

This is a good explanation as to why pointing the symlinks to the
newest kernels can be bad sometimes by Linus.  He makes some good
points, and can discribe the situation better than me :)  Also, he
explains why building a new kernel against it's own (newer) header
files does NOT break binary compatibility, but building user space
programs against new header files, without a new libc will (sometimes)
break things.

> Also, as I am doing, if you have a user-land program that accesses a
> kernel-maintained structure via a syscall - the layout of the kernel
> structure is (properly) defined in a header in linux/include/asm - but you
> also need to get at it when compiling the user-land program.

In this case you should ship the corresponding header files that your
user space program uses with that user-space utility.  This makes sure
that it gets things right and doesn't depend on having a kernel tree
around that you know the location of.  For example, for a program I'm
working with, which uses an ioctl interface on a /dev entry (used to
use system calls, but switched), I've set up a directory tree like:
src    all the code
include
    linux  header files copied from the kernel tree (just the ones I
           need)
    other header files

This way, when autoconf places a -Ibuild_root/include with each
compile, it uses the local header files.

Before I did this, building was hell -- it's SO much better being able
to build the user-space code on any box without having to untar kernel
source.

Again, just my opinion, but I've found that this works very well.

I believe in general, unless the program you're writing needs to track
the kernel very closely, it's bad practice to include kernel headers
in user-space code.

--=20
Josh
6B21489A | GnuPG ID/Fingerprint | huber@mclx.com |
61F0 6138 BE7B FEBF A223  E9D1 BFE1 2065 6B21 489A

--1ccMZA6j1vT5UqiK
Content-Type: application/pgp-signature
Content-Disposition: inline


--1ccMZA6j1vT5UqiK--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
