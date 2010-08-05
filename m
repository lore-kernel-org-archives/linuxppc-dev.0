Return-Path: <shawnxjin@gmail.com>
Received: from mail-pv0-f170.google.com (mail-pv0-f170.google.com
	[74.125.83.170]) by ozlabs.org (Postfix) with ESMTP id 711CBB70A9
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Aug 2010 14:11:49 +1000 (EST)
Received: by pvg6 with SMTP id 6so1393264pvg.15
	for <linuxppc-dev@ozlabs.org>; Wed, 04 Aug 2010 21:11:48 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 4 Aug 2010 21:11:47 -0700
Message-ID: <AANLkTi=x-EA59xfn_r5xMuJL6mufObSvSSEOeY9KTjQS@mail.gmail.com>
Subject: Relocating bootwrapper causes kernel panic
From: Shawn Jin <shawnxjin@gmail.com>
To: ppcdev <linuxppc-dev@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

I'm trying to relocate the bootwrapper from the default address
(0x400000) to a higher address (e.g. 0x800000) in order to support a
larger than 4MB initramfs. However the kernel panic when trying to
access the device tree blob which was relocated accordingly to a
higher address. The kernel message from __log_buf is shown below.

The flat tree located at 0xbe4300 as the kerne message showed. Why
cannot the kernel access this area? No TLB set for this area?

<1>Unable to handle kernel paging request for data at address 0xc0be4308
<1>Faulting instruction address: 0xc01fdabc
<4>Oops: Kernel access of bad area, sig: 11 [#1]
<4>
<4>NIP: c01fdabc LR: c01fdc38 CTR: 00000000
<4>REGS: c0383ee0 TRAP: 0300   Not tainted  (2.6.33.5)
<4>MSR: 00001032 <ME,IR,DR>  CR: 28558922  XER: 00000504
<4>DAR: c0be4308, DSISR: c0000000
<4>TASK = c0375328[0] 'swapper' THREAD: c0382000
<4>GPR00: c01fdc38 c0383f90 c0375328 c01fd4c8 00000000 00000000
00be4300 00000010
<4>GPR08: c01dbd94 c0be4300 04000000 00000000 00000000 00000000
07fff000 00000001
<4>GPR16: 007fff0d 00800554 00000001 007fff00 07ff9d78 ffffffff
00000000 07d5d2a0
<4>GPR24: 00000891 00000000 c0390000 c01fd4c8 00000000 00be4300
00000000 00be4300
<4>NIP [c01fdabc] of_scan_flat_dt+0x20/0x174
<4>LR [c01fdc38] early_init_devtree+0x28/0x288
<4>Call Trace:
<4>[c0383fb0] [c01fdc38] early_init_devtree+0x28/0x288
<4>[c0383fd0] [c01fe9c0] machine_init+0x20/0x5c
<4>[c0383ff0] [c0002244] start_here+0x48/0xc4
<4>Instruction dump:
<4>7fe5fb78 4bfff899 90610008 4bfffeb4 9421ffe0 7c0802a6 bf410008 90010024
<4>7c7b1b78 7c9c2378 3f40c039 813a9070 <80090008> 7fe90214 38600000 3ba0ffff
<4>---[ end trace 31fd0ba7d8756001 ]---
<0>Kernel panic - not syncing: Attempted to kill the idle task!
<4>Call Trace:
<4>[c0383dd0] [c0006c90] show_stack+0x40/0x168 (unreliable)
<4>[c0383e10] [c001cbfc] panic+0x8c/0x178
<4>[c0383e60] [c00209b0] do_exit+0x5c4/0x5d0
<4>[c0383ea0] [c000bb08] kernel_bad_stack+0x0/0x4c
<4>[c0383ec0] [c000ede8] bad_page_fault+0x90/0xd8
<4>[c0383ea0] [c000bb08] kernel_bad_stack+0x0/0x4c
<4>[c0383ec0] [c000ede8] bad_page_fault+0x90/0xd8
<4>[c0383ed0] [c000e2b8] handle_page_fault+0x7c/0x80
<4>[c0383f90] [00000000] (null)
<4>[c0383fb0] [c01fdc38] early_init_devtree+0x28/0x288
<4>[c0383fd0] [c01fe9c0] machine_init+0x20/0x5c
<4>[c0383ff0] [c0002244] start_here+0x48/0xc4

The kernel message from uboot and the bootwrapper is shown below.
=> bootm 5000000
## Booting image at 05000000 ...
   Image Name:   Linux-2.6.33.5
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1757351 Bytes =  1.7 MB
   Load Address: 00800000
   Entry Point:  00800554
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
Memory <- <0x0 0x8000000> (128MB)
ENET0: local-mac-address <- 00:09:9b:01:58:64
CPU clock-frequency <- 0x7270e00 (120MHz)
CPU timebase-frequency <- 0x7270e0 (8MHz)
CPU bus-frequency <- 0x3938700 (60MHz)

zImage starting: loaded at 0x00800000 (sp: 0x07d1cbd0)
Allocating 0x3a15a4 bytes for kernel ...
gunzipping (0x00000000 <- 0x0080c000:0x00bd702c)...done 0x3886ec bytes

Linux/PowerPC load: root=/dev/ram
Finalizing device tree... flat tree at 0xbe4300

Thanks,
-Shawn.
