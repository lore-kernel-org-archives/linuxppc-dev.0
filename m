Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Problem debugging ppc kernel with DDD/GDB/BDI2000 on a custom MPC8260 board
Date: Wed, 15 Oct 2003 18:47:11 +0100
Message-ID: <DEF39A0710293E489D45B10E06645CBD0243B3B2@dub-msx1.spectelcorp.com>
From: "Joao Vicente" <joao.vicente@spectel.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all

Just want to post the resolution to the problem(s) causing the kernel
code to reset the target.

on u-boot IMMR was set to 0x04700000, which is acceptable as far as
u-boot is concerned, but not allowed once the kernel is initialised.

The other issue was that the Chip Select was not configured properly on
u-boot (2MB instead of 32MB), which was not noticed in u-boot since the
u-boot never tried to access memory above that region, but caused the
kernel to reset the target.

I was still not able to debug the kernel (with gdb) before the kernel
turned on the MMU, but since the kernel code is running past the MMU
initialisation, I am now able to debug with source.

I would also like to take this opportunity to thank all the people who
replied to this post.

Best regards

Joao Vicente

-----Original Message-----
From: Joao Vicente
Sent: Thursday, October 09, 2003 10:52 AM
To: linuxppc-embedded@lists.linuxppc.org
Subject: Problem debugging ppc kernel with DDD/GDB/BDI2000 on a custom
MPC8260 board



Hi

I am trying to boot the ppc kernel on a MPC8260 based custom board.
I am using the denx distribution linuxppc_2_4_devel, and I am
configuring it using the TQM8260 default configuration, customising some
CPM settings for UART and FEC.

I have managed to port the u-boot loader for this board, and am at a
stage where I am decompressing the kernel image onto the top of the RAM.
I have debug enabled on the u-boot loader and the last line I see is

## Transferring control to Linux (at address 00000000) ...

And then the board resets when allowed to run free, past this point.

One of the doubts that I have is that when I look into the system.map
file, it shows that the start address is at 0xc0000000 (as shown below)

c0000000 T _start
c0000000 T _stext
c000000c T __start
c000002c t __after_mmu_off
c0000060 t turn_on_mmu
c00000c4 T __secondary_hold
c0000100 t Reset
...

To the best of my knowledge the kernel image is not relocatable, so I am
wondering if this could be my problem or just one of them ...
Should the map file be showing

00000000 T _start
...

If so, where should I change the .text address so that that happens ?

I am also trying to debug the code from that address with gdb/BDI2000,
but I am not getting very far.
Basically I can see the program counter incrementing when I single step,
but I cannot see the source even though I am trying to load the symbol
table at 0x00000000 with the  'add-symbol-file vmlinux 0x00000000' gdb
command, after invoking gdb from the kernel base directory (where
vmlinux is)
I also have tried to load the code with 'File|Open Program' command (I
am using DDD), and then tried to execute the gdb 'target remote
10.121.10.22:2001' command, and I can see the code (head.S file) on my
DDD code window, but the lines are not bound to any address, and I
cannot follow the code when I try to step though it.

Again does this not work because the code is not relocatable, or fo I
need to use any additional compiler switches that are not switched on
the default kernel configuration, or by any other reason I fail to see ?

I would appreciate any help on this issue

Thanks in advance

Joao Vicente,
Software Engineer.
www.spectel.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
