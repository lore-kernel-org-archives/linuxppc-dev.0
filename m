Return-Path: <jhautbois@gmail.com>
Received: from mail-bw0-f17.google.com (mail-bw0-f17.google.com
	[209.85.218.17]) by ozlabs.org (Postfix) with ESMTP id E6FF1DDF38
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jan 2009 22:04:43 +1100 (EST)
Received: by bwz10 with SMTP id 10so184616bwz.9
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jan 2009 03:04:41 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4970CBA9.60809@freescale.com>
References: <8cad0aa0901150342s2362e53bqf9472c1dc239636c@mail.gmail.com>
	<496F318D.6010302@denx.de>
	<8cad0aa0901150510o7a8146f1m2045e252c5e1cf24@mail.gmail.com>
	<496F4760.1010007@denx.de>
	<8cad0aa0901150706u72538941rbc22655d5a8905ea@mail.gmail.com>
	<8cad0aa0901160406l3db9c025ubdcac40b4b464d23@mail.gmail.com>
	<20090116172903.GA722@ld0162-tx32.am.freescale.net>
	<8cad0aa0901160944l48bd0e99wa13f23907838376d@mail.gmail.com>
	<8cad0aa0901160953te6c7d1cg3a4df7de7da7d182@mail.gmail.com>
	<4970CBA9.60809@freescale.com>
Date: Tue, 20 Jan 2009 11:56:58 +0100
Message-ID: <8cad0aa0901200256n6122d17eh90f56e9cb8cae775@mail.gmail.com>
Subject: Re: [MPC8272ADS]Cannot start my Linux Kernel
From: Jean-Michel Hautbois <jhautbois@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

2009/1/16 Scott Wood <scottwood@freescale.com>:
> Jean-Michel Hautbois wrote:
>>
>> OK, I just tried a make of my kernel (already compiled yesterday), and
>> it generated a cuImage.mpc8272ads kernel image (which it didn't do
>> yesterday).
>> I don't know why this image was generated, but I tried to reboot using
>> this one.
>
> Use uImage if you are providing a device tree from u-boot.  cuImage is fo=
r
> older u-boots that don't support this, though you could still try using i=
t
> on a modern u-boot with a one- or two-argument bootm command to try to
> isolate the problem.
>
> -Scott
>

OK, I just tried a cuImage and a ramdisk without a FDT. I am starting
to boot, but it freezes. Following is the boot evolution.

Thx & Regards,
JM

bootm 1000000 2000000
## Booting kernel from Legacy Image at 01000000 ...
   Image Name:   Linux-2.6.29-rc1-01197-g5a7b6e7-
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1529877 Bytes =3D  1.5 MB
   Load Address: 00400000
   Entry Point:  00400b94
   Verifying Checksum ... OK
## Loading init Ramdisk from Legacy Image at 02000000 ...
   Image Name:   Sofrel RAM Disk
   Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
   Data Size:    3130063 Bytes =3D  3 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
   Loading Ramdisk to 03882000, end 03b7e2cf ... OK
Memory <- <0x0 0x4000000> (64MB)
ENET0: local-mac-address <- 00:04:9f:11:22:33
ENET1: local-mac-address <- 00:00:00:00:00:00
CPU clock-frequency <- 0x17d78400 (400MHz)
CPU timebase-frequency <- 0x17d7840 (25MHz)
CPU bus-frequency <- 0x5f5e100 (100MHz)

zImage starting: loaded at 0x00400000 (sp: 0x03b7ebe8)
Allocating 0x329908 bytes for kernel ...
gunzipping (0x00000000 <- 0x0040d000:0x007591d8)...done 0x308b0c bytes
Using loader supplied ramdisk at 0x3882000-0x3b7e2cf
initrd head: 0x1f8b0800

Linux/PowerPC load: root=3D/dev/ram rw
Finalizing device tree... flat tree at 0x767300
id mach(): done
MMU:enter
MMU:hw init
MMU:mapin
MMU:setio
MMU:exit
Using Freescale MPC8272 ADS machine description
Linux version 2.6.29-rc1-01197-g5a7b6e7-dirty (dev@gforge) (gcc
version 4.2.2) #2 Thu Jan 15 18:31:04 CET 2009
Found initrd at 0xc3882000:0xc3b7e2cf
console [udbg0] enabled
setup_arch: bootmem
mpc8272_ads_setup_arch()
PCI host bridge /pci@f0010800 (primary) ranges:
 MEM 0x0000000080000000..0x000000009fffffff -> 0x0000000080000000 Prefetch
 MEM 0x00000000a0000000..0x00000000bfffffff -> 0x00000000a0000000
  IO 0x00000000f6000000..0x00000000f7ffffff -> 0x0000000000000000
mpc8272_ads_setup_arch(), finish
arch: exit
Top of RAM: 0x4000000, Total RAM: 0x4000000
Memory hole size: 0MB
Zone PFN ranges:
  DMA      0x00000000 -> 0x00004000
  Normal   0x00004000 -> 0x00004000
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0: 0x00000000 -> 0x00004000
On node 0 totalpages: 16384
free_area_init_node: node 0, pgdat c02ffc90, node_mem_map c0330000
  DMA zone: 128 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 16256 pages, LIFO batch:3
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 16256
Kernel command line: root=3D/dev/ram rw
PID hash table entries: 256 (order: 8, 1024 bytes)
time_init: decrementer frequency =3D 25.000000 MHz
time_init: processor frequency   =3D 400.000000 MHz
clocksource: timebase mult[a000000] shift[22] registered
clockevent: decrementer mult[666] sh=EF=BF=BD
