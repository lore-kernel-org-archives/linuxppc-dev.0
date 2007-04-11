Return-Path: <miltonm@sullivan.realtime.net>
Received: from sullivan.realtime.net (sullivan.realtime.net [205.238.132.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 23E40DDF0C
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Apr 2007 18:29:16 +1000 (EST)
Date: Wed, 11 Apr 2007 03:28:38 -0500 (CDT)
Subject: [PATCH 0/3+2+8] powerpc zImage kexec
From: Milton Miller <miltonm@bga.com>
Sender: Milton Miller <miltonm@realtime.net>
To: <linuxppc-dev@ozlabs.org>, <fastboot@lists.osdl.org>
Message-Id: <boot-4-00.miltonm@bga.com>
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The patches following this message implement support for creating a
compressed zImage that can be used where a vmlinux image with a
flat device-tree would be.  It has been tested with kexec-tools
on 64 bit platforms with upto 8 threads, and with an external
bootloader. that supplies a device tree and initrd.

The patches are:

(1) a series of 3 patches for kexec-tools
	(a) a hack to fix memory corruption in the testing tree
	(b) a fix for @ha relocations
	(c) a major change to the handling of SMP slaves during purgatory
(2) a related patch for increasing the times for slaves to transiton
(3) a convinence patch to expose a retained initrd for testing kexec-reboot
(4) and a series of 8 patches for the zImage wrapper
	(a) a debug message
	(b) smp handling code
	(c) coarse memory allocation for finding malloc pool, vmlinux, etc.
	(d) 64 bit support
	(e) kexec entrypoint base support
		-- or any environment that can supply a flat tree that
		fully describes the machine, and wishes to use it to
		find memory for the machine.
	(f) support for converting older versions of the flat device tree
	(g) support for writing to an rtas put-term-char console
	(h) alternative example code for using a-f on another palatform.


The kernel series is based on the patches I extracted from the
for-2.6.22 branch of powerpc.git as well as 1, 3, and 4 from my
last series.

I did not include my external payload patch at this point because
I still have to debug the initramfs search code, but the plan
is to allow the base code to find the vmlinux in a compressed cpio.gz
in the initrd area, with the file to decompress being selected by
a property in the device-tree.

Because of the vaired nature of the patches, each has its own CC list.

I ask that the non-bootwrapper patchs and the debug message be queued
now.   I expect the last one be discussion only, and the others to
provoke discussion.

I have been running a loop on 4 and 8 thread pSeries boxes of continous
kexecs for several thousand interations now.

Thanks,
milton

kexec-tools:
	ppc64-miscount-exlude-hack
	ppc64-reloc-ha
	ppc64-steal-kernel-slaves

misc:
	initrd-debugfs
	kexec-slaves-earlier

Patch: [PATCH 1/4] bootwrapper: missing relocation in crt0.S
http://patchwork.ozlabs.org/linuxppc/patch?id=10219
Message ID	<boot-3-01.miltonm@bga.com>

Patch: Re: Patch: [PATCH 3/4] bootwrapper: no gzip fixes
http://patchwork.ozlabs.org/linuxppc/patch?id=10223
Message ID	<boot-3-03.miltonm@bga.com>

Patch: Re: [PATCH 4/4] bootwrapper: decompress less, check more
http://patchwork.ozlabs.org/linuxppc/patch?id=10232
Message ID	<boot-3-04-a.miltonm@bga.com>

boot-exact-debug
boot-marshal-smp
boot-memranges
boot-64
boot-kexec
boot-flat-conv-2-16
boot-rtas
boot-bml.patch

Patch: [RFC] bootwrapper: allow vmlinuz to be an external payload
Submitter	Milton Miller
Date	2007-03-28 18:21:03
Message ID	<boot-3-05.miltonm@bga.com>
