Message-ID: <3936790D.9BD7680E@lucent.com>
Date: Thu, 01 Jun 2000 08:54:05 -0600
From: Steve Tarr <tarr@lucent.com>
MIME-Version: 1.0
To: LINUX-PPC <linuxppc-embedded@lists.linuxppc.org>
Subject: Motorola MPC8260-ADS Boot hassel
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


OK, I' stumped. I'm trying to do a port to Motorola's
MPC8260 evaluation board using 2.3.99-pre7. Aside from
hacking the loader and the 8260_io/uart.c to handle
the console on SCC1, I've done nothing. The following is the
boot messages:

loaded at:     00600000 0060B288
relocated to:  00400000 0040B288
board data at: 00407140 00407164
relocated to:  00200100 00200124
zimage at:     00606000 00675258
initrd at:     00675258 0084C0A3
avail ram:     0084D000 01000000

Linux/PPC load:
Uncompressing Linux...done.
Now booting the kernel
Total memory = 16MB; using 0kB for hash table (at 00000000)
Linux version 2.3.99-pre7 (tarr@norton) (gcc version 2.95.2 19991024
(release))0
Boot arguments: root=/dev/ram ip=off
On node 0 totalpages: 4096
zone(0): 4096 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Calibrating delay loop... 66.15 BogoMIPS
Memory: 12884k available (876k kernel code, 364k data, 48k init)
[c0000000,c100]
Dentry-cache hash table entries: 2048 (order: 2, 16384 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 4096 (order: 2, 16384 bytes)
Inode-cache hash table entries: 1024 (order: 1, 8192 bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.3
Based upon Swansea University Computer Society NET3.039
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
CPM UART driver version 0.02
ttyS00 at 0x8000 is a SCC
ttyS01 at 0x8100 is a SCC
pty: 256 Unix98 ptys configured
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: registered device at major 7
loop: enabling 8 loop devices
RAMDISK: Compressed image found at block 0
NIP: C0010D90 XER: 20000000 LR: C0010D8C REGS: c085f260 TRAP: 0300
MSR: 00001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c085e000[1] 'swapper' Last syscall: 120
last math 00000000 last altivec 00000000
GPR00: 00000000 C085F310 C085E000 00000001 00009032 C085F348 C085F368
01234567
GPR08: C085E000 C0008540 00000000 C085F358 00000000 FFFFFFFF 00000000
00000400
GPR16: 00000000 C0876C00 00007000 00001000 00000100 00001000 0000099C
C0120000
GPR24: 00000000 00000000 C085F358 C085F348 C01033E0 C0100000 00000000
C085F310
Call backtrace:
C0005038 C00347AC C0032080 C0032124 C00381C8 C01198BC C0080AA4
C00814F0 C0081638 C00816C4 C0081BDC C0119A24 C01193B4 C0119794
C0117AF4 C01137E0 C0113878 C0003A1C C0008C08
Kernel panic: kernel access of bad area pc c0010d90 lr c0010d8c address
3C tsk 1Rebooting in 180 seconds..

Based on my simple attempts it appears that I am taking a DSI exception
on an access to
0xC010000 which should be a pointer to a struct task_struct.

I noticed in System.map that data does not the first data entry is at
c0101000 - empty_zero_page

My guess is that I don't memory properly configured or something like
that.
Note: they put the SUNI-Lite and board registers at
0x04500000-0x04700000.

Any thoughts?

Thanks --

--
Steven Tarr
Lucent Technologies - Bell Labs
303-538-4056
tarr@lucent.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
