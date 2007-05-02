Return-Path: <cthomas@Soneticom.com>
Received: from Soneticom.com (soneticom.com [209.114.210.150])
	by ozlabs.org (Postfix) with ESMTP id 11DC0DDF7A
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  3 May 2007 04:47:54 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: Inconsistent ramdisk generation
Date: Wed, 2 May 2007 14:48:50 -0400
Message-ID: <3C02138692C13C4BB675FE7EA240952936D0B0@bluefin.Soneticom.local>
From: "Clint Thomas" <cthomas@Soneticom.com>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a very generic ramdisk question, which I would think somebody
here might have an explanation for.

I wrote a small script that automates the process of creating my
ramdisks. It basically zeros out a block device file, formats it ext2,
drops my root file system into the file, zips it up and runs it through
the U-boot mkimage utility. Here is the gist of the steps it goes
through.

dd if=3D/dev/zero of=3DRAM_RFS bs=3D1k count=3D32768  (zero out device)
mke2fs -F -m0 RAM_RFS 	(format ext2)
tune2fs -c 0 -i 0 RAM_RFS (tune so it does not check FS)
mount -o loop RAM_RFS tmp_dir (mount block device to temp directory)
find . -depth -print | cpio -VBpdum ../tmp_dir (copy RFS into block
device)
dd if=3DRAM_RFS bs=3D1k | gzip -v9 > RAM_RFS.gz (compress block device)
./mkimage -T ramdisk -C gzip -n 'RFS Ramdisk' -d RAM_RFS.gz RAM_RFS
(make u-boot image)

The problem seems to be that whether this is done in a script, or by
hand, there are inconsistent builds that occur at random. Every couple
of times I build this, what happens is I program it into flash through
u-boot, and when the system boots up, it either boots correctly, or it
hiccups in one way or another. The problems range from either the kernel
trying to access an area of memory outside the 32MB, or the serial
console will stop accepting input, or the programs set to run on startup
will not run at all, etc..

This happens at random intervals, whether I have actually changed
anything in the file system or not, so even if I run through the exact
same process, without modifying anything going into the file system, it
will have this problem. There does not seem to be a clear explanation of
this behaviour. Just to be sure it was not my script, I added time
delays between the commands, just to be sure all the IO was finished
before any of the compression began, but that did not change anything
either. Any suggestions?
=20

Cheers,

Clinton Thomas
