Subject: Re: Non NFS boot
To: dulimart@egr.msu.edu (Hans - Dulimarta)
Date: Fri, 21 Jan 2000 12:39:45 +1100 (EST)
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <Pine.GSO.4.10.10001201541460.15391-100000@scully> from "Hans - Dulimarta" at Jan 20, 2000 04:26:56 PM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20000121013945.A4B981B298@elph.research.canon.com.au>
From: greyham@research.canon.com.au (Graham Stoney)
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hans - Dulimarta writes:
> I'm looking for information on a similar kind of kernel which does not
> require NFS root.

Sure. Here's a section from a brief LinuxPPC Embedded HOWTO I've been working
on which may get you started: (feedback from all is welcome)

Root File System

Minimal and complete root file system images are available on the ftp site at:
ftp://linuxppc.cs.nmt.edu/pub/linuxppc/embedded/mbxroot.min.tgz and
ftp://linuxppc.cs.nmt.edu/pub/linuxppc/embedded/mbxroot.full.tgz

During development, the embedded system can NFS-mount its root file system to
provide a complete diskless Linux system. Answer "Y" to the configuration
questions regarding NFS client and root filesystem via NFS, and "make zImage".

To make your system standalone, you need an initial ramdisk image containing
an ext2 filesystem to put in arch/ppc/mbxboot/ramdisk.image.gz. Then, build
with "make zImage.initrd" and the ramdisk image will be mounted as the root
filesystem at startup. An example ramdisk.image.gz is already included in many
of the kernel source tarballs on the ftp site. The easiest way to create or
modify the ramdisk image is to use the loop device on your Linux development
host to mount the file as a local filesystem, and then copy the files you
require into it.

Note that the minix file system code in Linux is not endian-independant, so
you can't build a minix file system on an x86 machine and expect to read it
on a PowerPC machine. ext2 does not suffer from this problem.

If your system has a hard disk, you can start by using NFS then build a root
file system on the disk and boot from that.

If your system has no ethernet, you may want to start developing on a board
that does.

Regards,
Graham

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
