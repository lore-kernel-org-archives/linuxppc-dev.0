Message-Id: <200109171432.JAA27268@lists.linuxppc.org>
From: "Boerner, Brian" <bmb@pirus.com>
To: linuxppc-embedded@lists.linuxppc.org
Cc: "Boerner, Brian" <bmb@pirus.com>
Subject: Walnut Crash
Date: Mon, 17 Sep 2001 10:35:48 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I'm looking for a bit of assistance in debugging a crash. The following
console output is from a stock walnut.

Some messages I see as interesting are:
1. BogoMIPs is 8.9, shouldn't this be more like 198?
2. NIP points to an eieio instruction in rtc_init

Things I find weird:
1. From my experience machine checks result (as the messages indicate) from
   bad values in the MSR. The messages indicate that it progressed at least
   to the serial driver init, so why is it taking so long for the machine
   check to happen. This can't have been disabled for this long...

2. Kernel panic: Attempted to kill init!
   Has init even started yet??? I thought init was a process started
   from the root filesystem.

BUI> bootm 100000
## Booting image at 00100000 ...
   Image Name:   New Kernel Image
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    554368 Bytes = 541 kB = 0 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
## Current stack ends at 0x01F9FBB0 => set upper limit to 0x00800000
## cmdline at 0x007FFF00 ... 0x007FFF0D
No initrd
## Transferring control to Linux (at address 00000000) ...
Linux version 2.4.2 (administrator@BBOERNER_LT) (gcc version 2.95.3-2
(cygwin special)) #2 Fri Sep 14 16:19:51 2001
On node 0 totalpages: 8192
zone(0): 8192 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/ram
time_init: decrementer frequency = 499999980/60
Warning: real time clock seems stuck!
Calibrating delay loop... 8.19 BogoMIPS
Memory: 30660k available (1032k kernel code, 432k data, 40k init, 0k
highmem)
Dentry-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 2048 (order: 2, 16384 bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd v1.8
pty: 256 Unix98 ptys configured
block: queued sectors max/low 20301kB/6767kB, 64 slots per queue
RAMDISK driver initialized: 16 RAM disks of 12288K size 1024 blocksize
loop: enabling 8 loop devices
phy speed read failed
phy duplex read failed
<5>eth0: PPC405 EMAC 10 Mbs Half duplex MAC 08:2b:00:1f:30:08
Serial driver version 5.02 (2000-08-09) with no serial options enabled
ttyS00 at 0x0000 (irq = 0) is a 16550A
ttyS01 at 0x0000 (irq = 1) is a 16550A
Machine check in kernel mode.
Caused by (from SRR1=1230): Unknown values in msr
Oops: machine check, sig: 7
NIP: C014F50C XER: 00000000 LR: C014F4FC SP: C0235EE8 REGS: c0235e38 TRAP:
0200
MSR: 00001230 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c0234000[1] 'swapper' Last syscall: 120
last math 00000000 last altivec 00000000
PLB0: bear= 0x852f9bc0 acr=   0x00000000 besr=  0x08000000
PLB0 to OPB: bear= 0xe8000070 besr0= 0x00000000 besr1= 0x00000000

GPR00: 0000000A C0235EE8 C0234000 00000001 C022DE60 00000000 C022DEB0
00000000
GPR08: C015A844 E8000070 C0160000 C0166F9C 00000000 02000000 01FF0000
007FFF0D
GPR16: 00000000 00000001 007FFE80 FFFFFFFF 007FFF00 01FEA790 00000000
01F9FE50
GPR24: 00000000 01F9FF8C 01FF13A8 007FFF0D 007FFF00 C0140000 C0140000
C00B28F4
Call backtrace:
C014F4C0: <rtc_init+184>:      mr.     r3,r3
C0148820: <do_initcalls+48>:   cmplw   r31,r30
C01488C0: <do_basic_setup+128>:        bl      0xc014c840 <filesystem_setup>
C0002428: <init+20>:   bl      0xc000bc98 <free_initmem>
C0005030: <kernel_thread+44>:  li      r0,1
Kernel panic: Attempted to kill init!
Rebooting in 180 seconds..<NULL>

Brian Boerner
Member of Technical Staff
Pirus Networks

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
