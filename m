Return-Path: <blacklites@gmail.com>
Received: from mail-px0-f177.google.com (mail-px0-f177.google.com
	[209.85.216.177]) by ozlabs.org (Postfix) with ESMTP id EF2A7B7B70
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 24 Sep 2009 00:49:27 +1000 (EST)
Received: by pxi7 with SMTP id 7so626790pxi.17
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 23 Sep 2009 07:49:26 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 23 Sep 2009 20:19:26 +0530
Message-ID: <a9b543570909230749g5bb9c302wa48f310250068f5b@mail.gmail.com>
Subject: linux booting fails on ppc440x5 with SRAM
From: Vineeth _ <blacklites@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I am trying to port linux on IBM powerpc-440x5. I have this board
which has this processor, a 16MB SRAM sits on location 0x0, uart and a
flash.I have a simple bootloader which does the following.
    1. Initialize the processor (as part of it, we Generates the tlbs
for UART,16MB flash,16MB SRAM)
    2. Initialize the UART
    3. Copy the simple-boot linux_image (binary file) from flash to
0x400000 location of SRAM.
    4. Kernel entry to 0x400000

I also have a device tree structure file (image.dts) which i am
passing while generating the linux image.
It all went through and linux got extracted to the 0x0th location of
SRAM. and started executing.
(plz find the log below)

it always crashed @ "Unable to handle kernel paging request for data
at address 0x0xxxxxxx"
is there anything i have to change in the boot loader or kernel with
respect to the MMU initialization ?

in the kernel code @ /arch/powerpc/kernel/head_44x.s; there is a
comment saying "its trying to invalidate all the TLB entries except
the one it currently working on". Will it make any issues as in our
case we have only one TLB for the entire 16MB sram, which will be the
current working one..

Can someone suggest us some clue or details on this.

Thanks & Regards,
Vineeth

LINUX BOOT LOG
----------------------------------------------------------------------------------------
Initialized the System
Initialized the UART
Copying Linux Image to RAM > !!!!!!!!!!!!!!!!!!!!!!!!!!!
Copying Image Done
-KERNEL ENTRY-
-
zImage starting: loaded at 0x00400000 (sp: 0x004deeb0)
Allocating 0x1dad84 bytes for kernel ...
gunzipping (0x00000000 <- 0x0040c000:0x004dd3f1)...done 0x1c31cc bytes

Linux/PowerPC load: console=ttyS0 root=/dev/ram
Finalizing device tree... flat tree at 0x4eb300
id mach(): done
inside skybeam_register_console function
MMU:enterMMU:hw initMMU:mapinMMU:setioMMU:exitinside
_setup_arch-begininginside _setup_arch-1inside
_setup_arch-2setup_arch: bootmemarch: exit<7>Top of RAM: 0x1000000,
Total RAM: 0x1000000
Zone PFN ranges:
 DMA      0x00000000 -> 0x00001000
 Normal   0x00001000 -> 0x00001000
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
   0: 0x00000000 -> 0x00001000
MMU: Allocated 1088 bytes of context maps for 255 contexts
Built 1 zonelists in Zone order, mobility grouping off.  Total pages: 4064
Kernel command line: console=ttyS0 root=/dev/ram
Unable to handle kernel paging request for data at address 0x00021000
Faulting instruction address: 0xc010a7c4
Oops: Kernel access of bad area, sig: 11 [#1]
PREEMPT PowerPC 44x Platform
Modules linked in:
NIP: c010a7c4 LR: c010dc50 CTR: 00000000
REGS: c01bfeb0 TRAP: 0300   Not tainted  (2.6.30)
MSR: 00021000 <ME,CE>  CR: 24000044  XER: 00000000
DEAR: 00021000, ESR: 00000000
TASK = c01a94b8[0] 'swapper' THREAD: c01be000
GPR00: 00001180 c01bff60 c01a94b8 00021000 00000025 00000008 c0104968 00000000
GPR08: 2f72616d c0110000 c0155938 c01a0000 22000024 00000000 fffff104 00000000
GPR16: 00000000 00000000 00000000 00000000 fffffff8 000008b8 c010d758 c0104968
GPR24: 00001198 00001190 c018a001 c01c5498 000008c0 00001188 00021000 c01c42f0
NIP [c010a7c4] strchr+0x0/0x3c
LR [c010dc50] match_token+0x138/0x228
Call Trace:
[c01bff60] [c016b99c] 0xc016b99c (unreliable)
[c01bffa0] [c0104a00] sort_extable+0x28/0x38
[c01bffb0] [c01938ec] sort_main_extable+0x20/0x30
[c01bffc0] [c018c734] start_kernel+0x140/0x288
[c01bfff0] [c0000200] skpinv+0x190/0x1cc
Instruction dump:
7ca903a6 88040000 38a5ffff 38840001 2f800000 98090000 39290001 419e0010
4200ffe4 98a90000 4e800020 4e800020 <88030000> 5484063e 7f802000 4d9e0020
---[ end trace 31fd0ba7d8756001 ]---
Kernel panic - not syncing: Attempted to kill the idle task!
Call Trace:
[c01bfd90] [c0005d5c] show_stack+0x4c/0x16c (unreliable)
[c01bfdd0] [c002f17c] panic+0xa0/0x168
[c01bfe20] [c0032eb8] do_exit+0x61c/0x638
[c01bfe60] [c000b60c] kernel_bad_stack+0x0/0x4c
[c01bfe90] [c000f310] bad_page_fault+0x90/0xd8
[c01bfea0] [c000e184] handle_page_fault+0x7c/0x80
[c01bff60] [c016b99c] 0xc016b99c
[c01bffa0] [c0104a00] sort_extable+0x28/0x38
[c01bffb0] [c01938ec] sort_main_extable+0x20/0x30
[c01bffc0] [c018c734] start_kernel+0x140/0x288
[c01bfff0] [c0000200] skpinv+0x190/0x1cc
Rebooting in 180 seconds..
