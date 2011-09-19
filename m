Return-Path: <B04825@freescale.com>
Received: from TX2EHSOBE005.bigfish.com (tx2ehsobe003.messaging.microsoft.com
	[65.55.88.13]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CFE11B70BC
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Sep 2011 06:19:19 +1000 (EST)
Received: from mail71-tx2 (localhost.localdomain [127.0.0.1])	by
	mail71-tx2-R.bigfish.com (Postfix) with ESMTP id 8951112E81F9	for
	<linuxppc-dev@ozlabs.org>; Mon, 19 Sep 2011 20:19:16 +0000 (UTC)
Received: from TX2EHSMHS023.bigfish.com (unknown [10.9.14.242])	by
	mail71-tx2.bigfish.com (Postfix) with ESMTP id 3C8F71A8004D	for
	<linuxppc-dev@ozlabs.org>; Mon, 19 Sep 2011 20:18:05 +0000 (UTC)
Received: from [10.82.123.3] (efes.am.freescale.net [10.82.123.3])	by
	az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id
	p8JKI0F5028347	for
	<linuxppc-dev@ozlabs.org>; Mon, 19 Sep 2011 15:18:00 -0500 (CDT)
Message-ID: <4E77A378.3040306@freescale.com>
Date: Mon, 19 Sep 2011 15:18:00 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: WARNING: vmlinux.o (.PPC.EMB.apuinfo): unexpected non-allocatable
	section.
Content-Type: text/plain; charset="ISO-8859-1"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When trying to build a 64-bit kernel, I'm getting this warning message:

WARNING: vmlinux.o (.PPC.EMB.apuinfo): unexpected non-allocatable section.
Did you forget to use "ax"/"aw" in a .S file?
Note that for example <linux/init.h> contains
section definitions for use in .S files.

This kernel continues to compile and link, but when I try to boot it, it stops
here (this is under the hypervisor):

Linux version 3.0.4-31-00029-g06d86c8-dirty (b04825@efes) (gcc version 4.5.1
(Sourcery G++ Lite 2010.09-55) ) #1 SMP Mon Sep 19 14:49:48 CDT 2011
[boot]0012 Setup Arch
Found FSL PCI host bridge at 0x0000000ffe200000. Firmware bus number: 0->1
PCI host bridge /devices/pci0  ranges:
 MEM 0x0000000c00000000..0x0000000c1fffffff -> 0x00000000e0000000
  IO 0x0000000ff8000000..0x0000000ff800ffff -> 0x0000000000000000
/devices/pci0: PCICSRBAR @ 0xdf000000
Found FSL PCI host bridge at 0x0000000ffe202000. Firmware bus number: 0->1
PCI host bridge /devices/pci2  ranges:
 MEM 0x0000000c40000000..0x0000000c5fffffff -> 0x00000000e0000000
  IO 0x0000000ff8020000..0x0000000ff802ffff -> 0x0000000000000000
/devices/pci2: PCICSRBAR @ 0xdf000000
P5020 DS board from Freescale Semiconductor
Zone PFN ranges:
  DMA      0x00000000 -> 0x00020000
  Normal   empty
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0: 0x00000000 -> 0x00020000
MMU: Allocated 2112 bytes of context maps for 255 contexts
[boot]0015 Setup Done
PERCPU: Embedded 13 pages/cpu @c000000002d00000 s23872 r0 d29376 u524288
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 129280
Kernel command line:
PID hash table entries: 2048 (order: 2, 16384 bytes)
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
Memory: 425104k/524288k available (8500k kernel code, 99184k reserved, 968k
data, 702k bss, 300k init)
Hierarchical RCU implementation.
	RCU debugfs-based tracing is enabled.
	CONFIG_RCU_FANOUT set to non-default value of 32
NR_IRQS:512 nr_irqs:512 16
clocksource: timebase mult[a000000] shift[22] registered
Console: colour dummy device 80x25
console [tty0] enabled
console [ttyEHV0] enabled
ehv-bc: registered console driver for byte channel 300
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 256
e500 family performance monitor hardware support registered

If I disable performance counter support, it just stops at the "Mount-cache hash
table entries: 256" line.


-- 
Timur Tabi
Linux kernel developer at Freescale
