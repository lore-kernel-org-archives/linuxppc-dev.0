Return-Path: <stephane.fillod@thomson.net>
Received: from dmzraw2.extranet.tce.com (dmzraw2.extranet.tce.com
	[157.254.234.138]) by ozlabs.org (Postfix) with ESMTP id 54BAA67A70
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 18 Mar 2005 03:17:47 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Thu, 17 Mar 2005 17:17:36 +0100
Message-ID: <1CFEB358338412458B21FAA0D78FE86D4F0D16@rennsmail02.eu.thmulti.com>
From: "Fillod Stephane" <stephane.fillod@thomson.net>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: looking for a model for building CRAMFS(?)-based system
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Robert P. J. Day wrote:
> now this is the sticky part.  imagine this system out in the field,
> where you need to make an update to something in the initrd in the
> root filesystem.

You could get away with mirrored partitions, having version N and N-1
in flash, so a rollback is possible. But static partitions suck,
they are either too big (space wasted), either too small (!!).

Here's an idea I'd enjoy having feedback from: why not dedicating
the whole flash to a jffs2 space, allowing a kind of "dynamic"=20
partitioning with the composing filesystems in image files accessed
trough
loop devices? For example, the base system (libc, busybox, startup=20
scripts, ..) would be packed as a cramfs/squashfs file, put in the jffs2
storage. This image file would be mounted as root fs in 2 steps through=20
a loop device, thanks to a small patch against linux/init/do_mounts.c.=20
I've named this idea "Initial loopback (initlo) support", patch's
available.
Choosing the rootfs image is done through kernel command line.=20
For example, let's say /dev/mtdblock0 is the jffs2 storage, and the real
rootfs is a cramfs image file "rev1/rootfs.img" (from base of
mtdblock0).
The command line would be:
		root=3D/dev/mtdblock0 lofile=3Drev1/rootfs.img
After bootup, the rootfs.img is the rootfs /, and the mtdblock0 space
is pivoted to /initlo, hence still accessible.
It's easy to have whatever number of rootfs versions, switching from=20
one another, and updating the kernel command line only when install
succeeded (=3Dno power fail,..).
During normal operation, the jffs2 storage is kept read-only for safety.

Only during install it is remounted read-write.
Applications can be packaged the same way (image file). jffs2 will be
happy
to store also configuration files/data and at least 2 kernel versions
(for=20
safe update). Great monitors like U-Boot are able to load the kernel
image
(and other firmwares) from jffs2. The jffs2 loader is portable.

Note: these filesystems in a filesystem look inefficient (read slow
startup),
but who cares, you're already relying on compression. Please note that
once
loaded in pagecache, the system runs at full speed. cramfs/squashfs are
at
advantage here over initrd, because only needed files make it into the
pagecache.

Comments welcome

--=20
Stephane
