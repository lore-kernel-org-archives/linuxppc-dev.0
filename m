From: Daniel Wu <Daniel.Wu@alcatel.com.au>
Subject: Using zImage.initrd
To: linuxppc-embedded@lists.linuxppc.org
Message-Id: <00Jun9.083821est.115346@border.alcanet.com.au>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Date: Fri, 9 Jun 2000 08:38:20 +1000
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Does anyone what the difference between making a kernel with "make zImage" and
"Make zImage.initrd"? - Apart from the obvious fact that the later builds a
kernel which expects the rootfs to be on the RAM disk.

Anyway, the problem I'm having is that with the "make zImage" kernel, I get
alot further in the boot sequence. Here is my output:

loaded at:     00200000 0020B1E4
relocated to:  00600000 0060B1E4
board data at: 00600190 006001B8
relocated to:  001F0100 001F0128
zimage at:     00206000 00275065
avail ram:     0060B1E4 02000000

Linux/PPC load: root=/dev/nfs rw
Uncompressing Linux...done.
Now booting the kernel
Linux version 2.2.13 (aaluser@c1rb) (gcc version 2.95.2 19991024 (release)
) #21 Fri Jun 9 08:06:48 EST 2000
Boot arguments: root=/dev/nfs rw
time_init: decrementer frequency = 187500000/60
Calibrating delay loop... 49.87 BogoMIPS
Memory: 31268k available (800k kernel code, 668k data, 32k init)
[c0000000,c2000
000]
DENTRY hash table entries: 262144 (order: 9, 2097152 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 8192 (order: 3, 32768 bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.2
Based upon Swansea University Computer Society NET3.039
NET4: Unix domain sockets 1.0 for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
TCP: Hash tables configured (ehash 32768 bhash 32768)
Starting kswapd v 1.5
CPM UART driver version 0.03
ttyS00 at 0x0280 is a SMC
ttyS01 at 0x0380 is a SMC
ttyS02 at 0x0100 is a SCC
ttyS03 at 0x0200 is a SCC
pty: 256 Unix98 ptys configured
RAM disk driver initialized:  16 RAM disks of 4096K size
PPP: version 2.3.7 (demand dialling)
TCP compression code copyright 1989 Regents of the University of California
PPP line discipline registered.
SLIP: version 0.8.4-NET3.019-NEWTTY (dynamic channels, max=256).
VFS: Cannot open root device 00:00
Kernel panic: VFS: Unable to mount root fs on 00:00
Rebooting in 180 seconds..


Whereas the kernel produced using "make zImage.initrd" crashed alot earlier:

loaded at:     00200000 0020B1E4
relocated to:  00600000 0060B1E4
board data at: 00600190 006001B8
relocated to:  001F0100 001F0128
zimage at:     00206000 0027508F
initrd at:     0027508F 003535A8
avail ram:     00354000 02000000

Linux/PPC load: root=/dev/ram
Uncompressing Linux...done.
Now booting the kernel
Linux version 2.2.13 (aaluser@c1rb) (gcc version 2.95.2 19991024 (release)
) #20 Fri Jun 9 07:56:09 EST 2000
Boot arguments: root=/dev/ram
time_init: decrementer frequency = 187500000/60
Calibrating delay loop... 49.87 BogoMIPS
Memory: 30376k available (800k kernel code, 668k data, 32k init)
[c0000000,c2000
000]
DENTRY hash table entries: 262144 (order: 9, 2097152 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 8192 (order: 3, 32768 bytes)
NIP: C000D23C XER: 2000E32F LR: C00B8474 REGS: c00e6a90 TRAP: 0300
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c00e4d20[0] 'swapper' mm->pgd c00e3000 Last syscall: 0
last math 00000000
GPR00: C00B8474 C00E6B40 C00E4D20 FFFFFEFF 00000001 00000016 0000002D FFFFFFFF
GPR08: FFFFFFFF 00000004 00000004 00000000 00000040 00000000 00000000 00000000
GPR16: 00000000 00000000 00000000 00000000 00000000 00600190 0000013E C0110000
GPR24: 00000000 00000004 C00F579C 00000004 00000001 C00FF160 FFFFFFFF C00E6B40
Call backtrace:
C00FF71B C00B8474 C00B8648 C00FA2B4 C00F7774 C000221C
Kernel panic: kernel access of bad area pc c000d23c lr c00b8474 address
FFFFFEFF
 tsk swapper/0
In swapper task - not syncing
Rebooting in 180 seconds..

The crash location is in the __wake_up function according to the map.

Thanks,
Daniel


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
