MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: linuxppc_2_4_dev tree
Date: Mon, 12 Aug 2002 16:33:42 -0500
Message-ID: <45B36A38D959B44CB032DA427A6E10640167D022@cceexc18.americas.cpqcorp.net>
From: "Cameron, Steve" <Steve.Cameron@hp.com>
To: "Khai Trinh" <kqtrinh@yahoo.com>,
	<linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Khai Trinh wrote:

> How can I build a kernel image with target filesystem
> mounted via NFS fro mthe dev tree? The dev tree
> doesn't seem to have the target filesystem directory
> structure like the ones distributed by MVista for NFS
> mount.
>

The bitkeeper tree is the kernel only.  A root filesystem
you have to make or get elsewhere.

I've had good luck with the DENX Embedded Linux Development Kit.

Here:  http://www.denx.de/ELDK/
It has a working rootfs that can be mounted via NFS.  You
can then pare that down to make it smaller if you need to.

Busybox and Tinylogin are also useful for creating user-land
to go with your kernel.

http://www.busybox.net/
http://tinylogin.busybox.net/

Busybox can act as init, though the inittab needs to
be a bit different than a regular inittab, if I remember
right.

I found getting a satisfactory rootfs
was not exactly easy.  Not too hard, but a lot of details to
get just right, especially if you need to make it small.  You'll
want to make a script to create your root fs, which you can then use
from a kernel which mounts it by NFS (useful for debugging
applications) or by cramfs/initrd setup where the whole image,
kernel and rootfs, is loaded into RAM.

Hope that helps some.

-- steve

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
