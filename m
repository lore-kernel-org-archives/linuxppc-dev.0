Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Date: Sat, 8 May 2004 21:22:14 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: partial boot progress with 2.6 kernel and MPC850 board
Message-ID: <Pine.LNX.4.58.0405082115200.25141@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


  after fixing the previously-mentioned glitch in the kernel source,
and throwing together a configuration, i compiled a new kernel with
the ELDK 3.0 toolchain, crammed it into a ramdisk image, and booted
from it, to get the following.

  note that i didn't spend a lot of time selecting the configuration --
i just tossed something together to see whether i could at least get
a configure, build and at least the beginning of a boot.  so, in that
light, it's sort of a success.

======================================================================

>g
[Go 00400000]

loaded at:     00400000 0067F1F4
board data at: 0067C128 0067C144
relocated to:  00405314 00405330
zimage at:     0040583C 004DBD00
initrd at:     004DC000 0067B129
avail ram:     00680000 02000000

Linux/PPC load: console=ttyS0,9600 rw root=/dev/ram0 init=/sbin/minit
Uncompressing Linux...done.
Now booting the kernel
Linux version 2.6.6-rc3 (rpjday@localhost.localdomain) (gcc version 3.2.2
200304
              ^^^^^^^^^ yee ha

On node 0 totalpages: 8192
  DMA zone: 8192 pages, LIFO batch:2
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 0 pages, LIFO batch:1
Built 1 zonelists
Kernel command line: console=ttyS0,9600 rw root=/dev/ram0 init=/sbin/minit
PID hash table entries: 256 (order 8: 2048 bytes)
Decrementer Frequency = 187500000/60
Memory: 28768k available (1524k kernel code, 372k data, 76k init, 0k
highmem)
Calibrating delay loop... 47.36 BogoMIPS
Dentry cache hash table entries: 4096 (order: 2, 16384 bytes)
Inode-cache hash table entries: 2048 (order: 1, 8192 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
POSIX conformance testing by UNIFIX
NET: Registered protocol family 16
devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
JFFS2 version 2.2. (C) 2001-2003 Red Hat, Inc.
Generic RTC Driver v1.07
RAMDISK driver initialized: 16 RAM disks of 6144K size 1024 blocksize
loop: loaded (max 8 devices)
PPP generic driver version 2.4.2
PPP Deflate Compression module registered
PPP BSD Compression module registered
Using anticipatory io scheduler
RPX Lite or CLLF flash device: 2000000 at fe000000
Oops: Kernel Mode Software FPU Emulation, sig: 8 [#1]
NIP: 00000200 LR: C010A270 SP: C04D3CF0 REGS: c04d3c40 TRAP: 1000    Not
tainted
MSR: 00000000 EE: 0 PR: 0 FP: 0 ME: 0 IR/DR: 00
TASK = c04d9870[1] 'swapper' THREAD: c04d2000Last syscall: 120
GPR00: 00F000F0 C04D3CF0 C04D9870 C01C2490 00000000 00000000 C04D3D58
00000000
GPR08: 00000000 C3050000 00000004 00000004 C04D3D58 FA202210 814D9590
04294A49
GPR16: 800C1000 86A18F36 01243440 8099A0B1 32901AA8 14C18630 4CCA2080
181021E0
GPR24: 0E54A064 44810080 C04D3D58 00000002 C01C2444 C01C2490 00000000
00000004
Call trace: [c010a270]  [c010a00c]  [c0109f38]  [c0103c60]  [c0102788]
[c01d58
Kernel panic: Attempted to kill init!
 <0>Rebooting in 180 seconds..



  not quite sure what the "Software FPU Emulation" oops is all about;
i get the same problem with and without the math emulation compiled into
the kernel.

  anyway, i think it's time to pack it in for the evening; i'm open to
pointers as to how to get this further along.

rday

p.s.  as i said, i was really pretty cavalier with the kernel
configuration.  i'll most likely spend more time tomorrow going over it
more carefully to see if i did anything blatantly stupid.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
