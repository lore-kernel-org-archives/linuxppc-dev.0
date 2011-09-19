Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D6C89B6F9C
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Sep 2011 06:26:05 +1000 (EST)
Received: from mail96-ch1 (localhost.localdomain [127.0.0.1])	by
	mail96-ch1-R.bigfish.com (Postfix) with ESMTP id D96645782D0	for
	<linuxppc-dev@ozlabs.org>; Mon, 19 Sep 2011 20:26:01 +0000 (UTC)
Received: from CH1EHSMHS033.bigfish.com (snatpool1.int.messaging.microsoft.com
	[10.43.68.254])	by mail96-ch1.bigfish.com (Postfix) with ESMTP id
	9F72514D804C	for <linuxppc-dev@ozlabs.org>;
	Mon, 19 Sep 2011 20:25:59 +0000 (UTC)
Message-ID: <4E77A554.9080808@freescale.com>
Date: Mon, 19 Sep 2011 15:25:56 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Timur Tabi <timur@freescale.com>
Subject: Re: WARNING: vmlinux.o (.PPC.EMB.apuinfo): unexpected non-allocatable
	section.
References: <4E77A378.3040306@freescale.com>
In-Reply-To: <4E77A378.3040306@freescale.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/19/2011 03:18 PM, Timur Tabi wrote:
> This kernel continues to compile and link, but when I try to boot it, it stops
> here (this is under the hypervisor):

"The hypervisor" is ambiguous.  We have Topaz, and KVM.

> Linux version 3.0.4-31-00029-g06d86c8-dirty (b04825@efes) (gcc version 4.5.1
> (Sourcery G++ Lite 2010.09-55) ) #1 SMP Mon Sep 19 14:49:48 CDT 2011
> [boot]0012 Setup Arch
> Found FSL PCI host bridge at 0x0000000ffe200000. Firmware bus number: 0->1
> PCI host bridge /devices/pci0  ranges:
>  MEM 0x0000000c00000000..0x0000000c1fffffff -> 0x00000000e0000000
>   IO 0x0000000ff8000000..0x0000000ff800ffff -> 0x0000000000000000
> /devices/pci0: PCICSRBAR @ 0xdf000000
> Found FSL PCI host bridge at 0x0000000ffe202000. Firmware bus number: 0->1
> PCI host bridge /devices/pci2  ranges:
>  MEM 0x0000000c40000000..0x0000000c5fffffff -> 0x00000000e0000000
>   IO 0x0000000ff8020000..0x0000000ff802ffff -> 0x0000000000000000
> /devices/pci2: PCICSRBAR @ 0xdf000000
> P5020 DS board from Freescale Semiconductor
> Zone PFN ranges:
>   DMA      0x00000000 -> 0x00020000
>   Normal   empty
> Movable zone start PFN for each node
> early_node_map[1] active PFN ranges
>     0: 0x00000000 -> 0x00020000
> MMU: Allocated 2112 bytes of context maps for 255 contexts
> [boot]0015 Setup Done
> PERCPU: Embedded 13 pages/cpu @c000000002d00000 s23872 r0 d29376 u524288
> Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 129280
> Kernel command line:
> PID hash table entries: 2048 (order: 2, 16384 bytes)
> Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
> Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
> Memory: 425104k/524288k available (8500k kernel code, 99184k reserved, 968k
> data, 702k bss, 300k init)
> Hierarchical RCU implementation.
> 	RCU debugfs-based tracing is enabled.
> 	CONFIG_RCU_FANOUT set to non-default value of 32
> NR_IRQS:512 nr_irqs:512 16
> clocksource: timebase mult[a000000] shift[22] registered
> Console: colour dummy device 80x25
> console [tty0] enabled
> console [ttyEHV0] enabled
> ehv-bc: registered console driver for byte channel 300
> pid_max: default: 32768 minimum: 301
> Mount-cache hash table entries: 256
> e500 family performance monitor hardware support registered
> 
> If I disable performance counter support, it just stops at the "Mount-cache hash
> table entries: 256" line.

These messages generally tell you what the kernel just did, not what
it's about to do (and thus what hung).

Have you tried using CCS (or Topaz's debug functionality) to see where
it's hung?

-Scott
