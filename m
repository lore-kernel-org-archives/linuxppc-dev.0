Return-Path: <sebastian.haepe@eads.com>
Received: from mail.eads.net (mail.eads.net [53.122.156.212])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "mail-in1.intra.corp",
	Issuer "mail-in1.intra.corp" (not verified))
	by ozlabs.org (Postfix) with ESMTP id CD4AE67C39
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 20 Jul 2005 20:43:54 +1000 (EST)
Received: from ohm.smart.lfk.eads.net ([53.146.48.56])
	by mail.eads.net (8.12.3/8.12.3/Debian-6.6) with ESMTP id
	j6KAZFNJ029809
	for <linuxppc-embedded@ozlabs.org>; Wed, 20 Jul 2005 12:35:15 +0200
Message-ID: <2D9AB865A49FD511914700105A0EF6790252BDCE@morse.smart.lfk.eads.net>
From: =?iso-8859-1?Q?=22H=E4pe=2C_Sebastian=2C_HRD/AB=22?=
	<sebastian.haepe@eads.com>
To: "'linuxppc-embedded@ozlabs.org'" <linuxppc-embedded@ozlabs.org>
Date: Wed, 20 Jul 2005 12:35:16 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Problem mounting ramdisk image
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi everybody,

I have a litte problem with an initrd-image on a custom board:

I created a gzip-compressed image of an initrd which is loaded to RAM =
by the
bootloader (U-Boot) before it starts the kernel. The kernel is compiled =
with
support for initial ramdisks and knows the right addresses of the image =
in
RAM.
Now the following effects occur:

 -  if i do not tell the kernel which filesystem I have in my image =
(only
entering: 'root=3D/dev/ram rw init=3D/bin/busybox')
    he tells me the following:
   =20
    RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 =
blocksize
    RAMDISK: Compressed image found at block 0
    Freeing initrd memory: 709k freed
    Kernel panic: VFS: Unable to mount root fs on 01:00

 -  if I tell the kernel to use TMPFS or RAMFS (rootfs=3Dtmpfs or
rootfs=3Dramfs), the error is

    RAMDISK: Compressed image found at block 0
    Freeing initrd memory: 709k freed
    VFS: Mounted root filesystem (tmpfs/ramfs)
    Kernel panic: No init found. Try to pass init=3D... To the kernel =
command
line    =20

    When I examine the return value of the execve() function, I get
error-code 2, which means: File or directory not found

My distribution (ELinOS) creates two files, 'Image.gz' and =
'Image.initrd'.
If I extract Image.gz, the full filesystem is extracted.=20
How can I check wheather the 'Image.initrd' file is correct?
(U-Boot tells me it is correct if I enter 'imi [address of image]')

Or does anyone did have the same problem? Have I forgotten any kernel
options?

Greetings,
Sebastian H=E4pe
