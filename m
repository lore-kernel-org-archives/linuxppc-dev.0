Date: Tue, 5 Sep 2000 21:36:39 +0300
From: Alex Shnitman <alexsh@hectic.net>
To: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: More Sandpoint woes
Message-ID: <20000905213639.B22842@hectic.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="OXfL5xGRrasGEqWY"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii

Hi,

I've got the Sandpoint/PPMC7400 to boot the kernel, mount the root
filesystem via NFS, and try to execute init. By the way, does anyone
have any idea why if I disable initrd support in the kernel config, it
doesn't succeed booting via BOOTP -- it times out, but the sniffer
doesn't even show that it sends any packets to the cable; while if I
enable initrd support, it just fails to mount the ramdisk, but then
proceeds to do a network boot all right? I tried it countless times,
and there's absolutely nothing else causing this -- it's that kernel
option. Some timing issue perhaps? This really puzzles me, even though
it's not a show-stopper.

In any case, when it tries to execute init it oopses. I've attached
the full bootlog to this mail, but in any case, here's the ksymoops of
the first oops:

>>EIP; 00000300 Before first symbol   <=====
Trace; ffffffea <END_OF_CODE+3bf364df/????>
Trace; c004b8c4 <load_elf_interp+28c/2d4>
Trace; c004c148 <load_elf_binary+6e8/950>
Trace; c003c9e4 <search_binary_handler+5c/160>
Trace; c003cc54 <do_execve+16c/1fc>
Trace; c0007218 <sys_execve+70/f0>
Trace; c0004e34 <ret_from_syscall_1+0/a0>
Trace; c0003f14 <init+18/1a8>
Trace; c0009670 <kernel_thread+2c/38>

Here's the ksymoops of the second:

>>EIP; 00000300 Before first symbol   <=====
Trace; c0007328 <print_backtrace+90/c8>
Trace; c0005268 <_exception+34/68>
Trace; c00054b8 <ProgramCheckException+4c/5c>
Trace; c0005090 <ret_from_except+0/c>
Trace; ffffffea <END_OF_CODE+3bf299e7/????>
Trace; c004b8c4 <load_elf_interp+28c/2d4>
Trace; c004c148 <load_elf_binary+6e8/950>
Trace; c003c9e4 <search_binary_handler+5c/160>
Trace; c003cc54 <do_execve+16c/1fc>
Trace; c0007218 <sys_execve+70/f0>
Trace; c0004e34 <ret_from_syscall_1+0/a0>
Trace; c0003f14 <init+18/1a8>
Trace; c0009670 <kernel_thread+2c/38>

And then the rest continue in the same vein -- an oops inside an oops
inside an oops.

Any idea what causes this?

I wanted to do some debugging on this, so I tried to enable kgdb in
the kernel config, but then it didn't link, complainig about
unresolved symbols getDebugChar, putDebugChar and
kgdb_uninterruptible.  I saw them defined in 8xx_boot/uart.c; does
this mean that on my board it's not supported? How hard would it be to
add it? (I *do* want to do it myself, perhaps with a little
bootstrapping from you as to *how*.)


--
Alex Shnitman                            | http://www.debian.org
alexsh@hectic.net, alexsh@linux.org.il   +-----------------------
http://alexsh.hectic.net    UIN 188956    PGP key on web page
       E1 F2 7B 6C A0 31 80 28  63 B8 02 BA 65 C7 8B BA

"I think there is a world market for about five computers."
	-- Thomas Watson, chairman of IBM, 1943

--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename=bootlog
Content-Transfer-Encoding: 8bit

DINK32_MAX >>go 200000
loaded at:     00200000 00214E20
relocated to:  00800000 00814E20
zimage at:     0020B000 00289A6C
relocated to:  00815000 00893A6C
avail ram:     00400000 00800000

Linux/PPC load: root=nfs
Uncompressing Linux...done.
Now booting the kernel
mem_pieces_remove: [780,f00) not in any region
Total memory = 32MB; using 128kB for hash table (at c0180000)
Linux version 2.4.0-test2 (alexsh@debian) (gcc version 2.95.2 20000313 (Debian GNU/Linux)) #5 Mon Sep 4 15:09:03 IDT 2000
Boot arguments: root=nfs console=ttyS0
On node 0 totalpages: 8192
zone(0): 8192 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=nfs
OpenPIC Version 1.2 (1 CPUs and 24 IRQ sources) at fcf40000
OpenPIC timer frequency is not set
Calibrating delay loop... 527.56 BogoMIPS
Memory: 30572k available (876k kernel code, 396k data, 168k init) [c0000000,c2000000]
Dentry-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 8192 (order: 3, 32768 bytes)
kmem_create: Poisoning requested, but con given - bdev_cache
Inode-cache hash table entries: 2048 (order: 2, 16384 bytes)
kmem_create: Poisoning requested, but con given - inode_cache
POSIX conformance testing by UNIFIX
PCI: Probing PCI hardware
רררררררררררררררררררררררררררררררררררררררררררררררררררררררררררAuto Config PCI Bars
PCI device 1057:0004 (Motorola) bus 0 dev 0
	BAR 0, Mem, 	BAR 1, Mem, size=0x1000, address=0xfbffec00
Symphony Labs W83C553 bus 0 dev 11
Symphony Labs SL82c105 bus 0 dev 11
	BAR 0, I/O, size=0x8, address=0xaffbf8
	BAR 1, I/O, size=0x4, address=0xaff7f4
	BAR 2, I/O, size=0x8, address=0xaff3e8
	BAR 3, I/O, size=0x4, address=0xafefe4
	BAR 4, I/O, size=0x10, address=0xafebd0
	BAR 5, I/O, size=0x10, address=0xafe7c0
Intel Corporation 82557 [Ethernet Pro 100] bus 0 dev 15
	BAR 0, Mem, size=0x1000, address=0xfbffcc00
	BAR 1, I/O, size=0x40, address=0xafe380
	BAR 2, Mem, size=0x100000, address=0xfbdffc00
	IRQ 18
Linux NET4.0 for Linux 2.3
Based upon Swansea University Computer Society NET3.039
kmem_create: Poisoning requested, but con given - skbuff_head_cache
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 2048 bind 2048)
Starting kswapd v1.6
pty: 256 Unix98 ptys configured
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: registered device at major 7
loop: enabling 8 loop devices
RAMDISK: Couldn't find valid RAM disk image starting at 0.
Freeing initrd memory: 4194301k freed
Serial driver version 5.01 (2000-05-29) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
eepro100.c:v1.09j-t 9/29/99 Donald Becker http://cesdis.gsfc.nasa.gov/linux/drivers/eepro100.html
eepro100.c: $Revision: 1.33 $ 2000/05/24 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
PCI: Enabling device 00:0f.0 (0000 -> 0003)
eth0: OEM i82557/i82558 10/100 Ethernet, 00:D0:B7:7E:0D:86, IRQ 18.
  Receiver lock-up bug exists -- enabling work-around.
  Board assembly 734938-003, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x8b51f404).
Sending BOOTP requests.... OK
IP-Config: Got BOOTP answer from 10.0.0.1, my address is 10.0.0.2
kmem_create: Forcing size word alignment - nfs_fh
Looking up port of RPC 100003/2 on 10.0.0.1
Looking up port of RPC 100005/2 on 10.0.0.1
VFS: Mounted root (nfs filesystem).
Freeing unused kernel memory: 168k init
NIP: 00000300 XER: 20000000 LR: C004B278 REGS: c0279a80 TRAP: 0700
MSR: 00081000 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 00
TASK = c0278000[1] 'init' Last syscall: 11
last math 00000000 last altivec 00000000
GPR00: 00000000 C0279B30 C0278000 00000000 00000968 00000000 30026694 30026C64
GPR08: 30026698 30026C64 00000003 00000000 24448044 00000000 100174E8 100171E0
GPR16: 10000000 C0279C4C 00000060 00000001 C0274F00 00000003 C0144160 30026C64
GPR24: 30000000 30026698 00023A70 00000812 C0279BD8 30023000 C0274F60 00000007
Call backtrace:
FFFFFFEA C004B8C4 C004C148 C003C9E4 C003CC54 C0007218 C0004E34
C0003F14 C0009670 NIP: 00000300 XER: 20000000 LR: C0007328 REGS: c0279970 TRAP: 0700
MSR: 00081000 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 00
TASK = c0278000[1] 'init' Last syscall: 11
last math 00000000 last altivec 00000000
GPR00: 00000000 C0279A20 C0278000 00000009 00001032 C010D734 C0140000 C0140000
GPR08: C0140000 09786FBE C0120000 C0279960 44448024 00000000 100174E8 100171E0
GPR16: 10000000 C0279C4C 00000060 00000001 00001032 00279A70 00000000 C0005090
GPR24: C000546C C00E0000 C00E0000 92492493 C0009670 00000009 09786FBA 00000000
Call backtrace:
C0007328 C0005268 C00054B8 C0005090 FFFFFFEA C004B8C4 C004C148
C003C9E4 C003CC54 C0007218 C0004E34 C0003F14 C0009670 NIP: 00000300 XER: 20000000 LR: C0007328 REGS: c0279860 TRAP: 0700
MSR: 00081000 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 00
TASK = c0278000[1] 'init' Last syscall: 11
last math 00000000 last altivec 00000000
GPR00: 00000000 C0279910 C0278000 00000009 00001032 C010D734 C0140000 C0140000
GPR08: C0140000 09786FBE C0120000 C0279850 44448024 00000000 100174E8 100171E0
GPR16: 10000000 C0279C4C 00000060 00000001 00001032 00279960 00000000 C0005090
GPR24: C000546C C00E0000 C00E0000 92492493 C0009670 0000000D 09786FBA 00000000
Call backtrace:
C0007328 C0005268 C00054B8 C0005090 C0007328 C0005268 C00054B8
C0005090 FFFFFFEA C004B8C4 C004C148 C003C9E4 C003CC54 C0007218
C0004E34 C0003F14 C0009670 NIP: 00000300 XER: 20000000 LR: C0007328 REGS: c0279750 TRAP: 0700
MSR: 00081000 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 00
TASK = c0278000[1] 'init' Last syscall: 11
last math 00000000 last altivec 00000000
GPR00: 00000000 C0279800 C0278000 00000009 00001032 C010D734 C0140000 C0140000
GPR08: C0140000 09786FBE C0120000 C0279740 44448024 00000000 100174E8 100171E0
GPR16: 10000000 C0279C4C 00000060 00000001 00001032 00279850 00000000 C0005090
GPR24: C000546C C00E0000 C00E0000 92492493 C0009670 00000011 09786FBA 00000000
Call backtrace:
C0007328 C0005268 C00054B8 C0005090 C0007328 C0005268 C00054B8
C0005090 C0007328 C0005268 C00054B8 C0005090 FFFFFFEA C004B8C4
C004C148 C003C9E4 C003CC54 C0007218 C0004E34 C0003F14 C0009670 NIP: 00000300 XER: 20000000 LR: C0007328 REGS: c0279640 TRAP: 0700
MSR: 00081000 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 00
TASK = c0278000[1] 'init' Last syscall: 11
last math 00000000 last altivec 00000000
GPR00: 00000000 C02796F0 C0278000 00000009 00001032 C010D734 C0140000 C0140000
GPR08: C0140000 09786FBE C0120000 C0279630 44448024 00000000 100174E8 100171E0
GPR16: 10000000 C0279C4C 00000060 00000001 00001032 00279740 00000000 C0005090
GPR24: C000546C C00E0000 C00E0000 92492493 C0009670 00000015 09786FBA 00000000
Call backtrace:
C0007328 C0005268 C00054B8 C0005090 C0007328 C0005268 C00054B8
C0005090 C0007328 C0005268 C00054B8 C0005090 C0007328 C0005268
C00054B8 C0005090 FFFFFFEA C004B8C4 C004C148 C003C9E4 C003CC54
C0007218 C0004E34 C0003F14 C0009670 NIP: 00000300 XER: 20000000 LR: C0007328 REGS: c0279530 TRAP: 0700
MSR: 00081000 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 00
TASK = c0278000[1] 'init' Last syscall: 11
last math 00000000 last altivec 00000000
GPR00: 00000000 C02795E0 C0278000 00000009 00001032 C010D734 C0140000 C0140000
GPR08: C0140000 09786FBE C0120000 C0279520 44448024 00000000 100174E8 100171E0
GPR16: 10000000 C0279C4C 00000060 00000001 00001032 00279630 00000000 C0005090
GPR24: C000546C C00E0000 C00E0000 92492493 C0009670 00000019 09786FBA 00000000
Call backtrace:
C0007328 C0005268 C00054B8 C0005090 C0007328 C0005268 C00054B8
C0005090 C0007328 C0005268 C00054B8 C0005090 C0007328 C0005268
C00054B8 C0005090 C0007328 C0005268 C00054B8 C0005090 FFFFFFEA
C004B8C4 C004C148 C003C9E4 C003CC54 C0007218 C0004E34 C0003F14
C0009670 NIP: 00000300 XER: 20000000 LR: C0007328 REGS: c0279420 TRAP: 0700
MSR: 00081000 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 00
TASK = c0278000[1] 'init' Last syscall: 11
last math 00000000 last altivec 00000000
GPR00: 00000000 C02794D0 C0278000 00000009 00001032 C010D734 C0140000 C0140000
GPR08: C0140000 09786FBE C0120000 C0279410 24448024 00000000 100174E8 100171E0
GPR16: 10000000 C0279C4C 00000060 00000001 00001032 00279520 00000000 C0005090
GPR24: C000546C C00E0000 C00E0000 92492493 C0009670 0000001D 09786FBA 00000000
Call backtrace:
C0007328 C0005268 C00054B8 C0005090 C0007328 C0005268 C00054B8
C0005090 C0007328 C0005268 C00054B8 C0005090 C0007328 C0005268
C00054B8 C0005090 C0007328 C0005268 C00054B8 C0005090 C0007328
C0005268 C00054B8 C0005090 FFFFFFEA C004B8C4 C004C148 C003C9E4
C003CC54 C0007218 C0004E34 C0003F14 C0009670
Kernel panic: Exception in kernel pc 300 signal 4
Rebooting in 180 seconds..

--OXfL5xGRrasGEqWY--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
