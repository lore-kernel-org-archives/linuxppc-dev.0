Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
From: "Etienne van der Linde" <evdl@ananzi.co.za>
Subject: Kernel oops, sig: 7 at last init / modules
To: linuxppc-embedded@lists.linuxppc.org
Date: Wed, 10 Mar 2004 19:33:44 +0200
Message-ID: <web-18194238@mail01.ananzi.co.za>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi guys

I'm really desperate for some help - I've been struggling
with this embedded system for a few months now (I'm still
new at this) and are so close to getting my first login
prompt...

We are using an MPC8260 on a custom board with 16MB RAM,
16MB FLASH, DS1558W RTC, LAN83C183 PHY etc. I use Denx's
U-Boot 0.4.0 for the boot loader, and then their PPC82xx
embedded linux from their ELDK.

For me it seems that the problem comes from executing a
module on the file system (either on NFS or Ramdisk).

Here is the output when using NFS:
#####################################################
Total memory = 16MB; using 64kB for hash table (at
c0190000)
Linux version 2.4.4 (root@infineon.parsec) (gcc version
2.95.4 20010319 (prerelease/franzo/20011204)) #4 Mon Mar 8
144On node 0 totalpages: 4096
zone(0): 4096 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/nfs rw
nfsroot=172.17.5.125:/predator
ip=172.17.5.238:172.17.5.125:172.17.0.1:255.255.1Warning:
real time clock seems stuck!
Calibrating delay loop... 175.71 BogoMIPS
Memory: 14412k available (1032k kernel code, 520k data, 48k
init, 0k highmem)
Dentry-cache hash table entries: 2048 (order: 2, 16384
bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096
bytes)
Page-cache hash table entries: 4096 (order: 2, 16384 bytes)
Inode-cache hash table entries: 1024 (order: 1, 8192 bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd v1.8
CPM UART driver version 0.02
ttyS0 on SMC1 at 0x0000, BRG1
ttyS1 on SCC1 at 0x8000, BRG1
ttyS2 on SCC2 at 0x8100, BRG1
pty: 256 Unix98 ptys configured
block: queued sectors max/low 9488kB/3162kB, 64 slots per
queue
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024
blocksize
eth0: FCC ENET Version 0.3, 00:00:00:80:00:01
eth0: Phy @ 0xe, type LAN83C183 (0x0016f840)
JFFS version 1.0, (C) 1999, 2000  Axis Communications AB
JFFS2 version 2.1. (C) 2001 Red Hat, Inc., designed by Axis
Communications AB.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 1024 bind 1024)
eth0: config: auto-negotiation on, 100FDX, 100HDX, 10FDX,
10HDX.
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Looking up port of RPC 100003/2 on 172.17.5.125
Looking up port of RPC 100005/2 on 172.17.5.125
VFS: Mounted root (nfs filesystem).
Freeing unused kernel memory: 48k init
Machine check in kernel mode.
Caused by (from SRR1=49030): Transfer error ack signal
Oops: machine check, sig: 7
NIP: C000D594 XER: 20000000 LR: C0040238 SP: C0EE1DB0 REGS:
c0ee1d00 TRAP: 0200
MSR: 00049030 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c0ee0000[8] 'modprobe' Last syscall: 5
last math c0ee0000 last altivec 00000000
GPR00: 00000040 C0EE1DB0 C0EE0000 C0EDE000 0FFE0C58
00001000 C0EDDFFF 0FFDF304
GPR08: C01F25C0 00000000 C0EDE000 00000001 24888088
1003A1A8 00FFB000 007FFF79
GPR16: C013B478 C013B578 C0EE1F08 84888024 00009032
00EE1DF0 00000000 C0003DE4
GPR24: C0003B20 0FFEAA94 0FFED6A0 100389E8 00000008
C0EDE000 00001000 0FFE0C58
Call backtrace:
C00401C8 C0033434 C0003B7C 00000000 0FF1A05C 0FF4FBF8
0FF4EA04
0FF4F858 0FF4C4C8 0FF85B60 0FF85998 10015108 0FEE67B8
0FECFF74
00000000
INIT: version 2.78 booting
Machine check in kernel mode.
Caused by (from SRR1=49030): Transfer error ack signal
Oops: machine check, sig: 7
NIP: C000D594 XER: 20000000 LR: C0040238 SP: C01F1DF0 REGS:
c01f1d40 TRAP: 0200
MSR: 00049030 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c01f0000[1] 'init' Last syscall: 33
last math 00000000 last altivec 00000000
GPR00: 00000040 C01F1DF0 C01F0000 C0E7E000 0FFE6DA8
00001000 C0E7DFFF FEFEFEFF
GPR08: C01F25E0 00000000 C0E7E000 00000001 4444408D
1001F5A8 00FFB000 007FFF79
GPR16: 00000001 00000000 007FFF00 10010000 00009032
001F1E70 00000000 C0003DE4
GPR24: C0003B20 10006BF0 7FFFFAD8 00000000 C01F1E38
C0E7E000 00001000 0FFE6DA8
Call backtrace:
C00401C8 C00417FC C0032784 C0003B7C 3000B178 0FFB5D08
0FFB5F6C
1000660C 10006690 10003384 10004328 10005C64 10006088
0FECFF70
00000000
Kernel panic: Attempted to kill init!
Rebooting in 1 seconds..
#####################################################

Here is the output when using a the ELDK ramdisk:
#####################################################
Total memory = 16MB; using 64kB for hash table (at
c0190000)
Linux version 2.4.4 (root@infineon.parsec) (gcc version
2.95.4 20010319 (prerelease/franzo/20011204)) #4 Mon Mar 8
144On node 0 totalpages: 4096
zone(0): 4096 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/ram rw init=/bin/sh
ip=172.17.5.238:172.17.5.125:172.17.0.1:255.255.0.0:predator::off
1Warning: real time clock seems stuck!
Calibrating delay loop... 175.71 BogoMIPS
Memory: 13044k available (1032k kernel code, 520k data, 48k
init, 0k highmem)
Dentry-cache hash table entries: 2048 (order: 2, 16384
bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096
bytes)
Page-cache hash table entries: 4096 (order: 2, 16384 bytes)
Inode-cache hash table entries: 1024 (order: 1, 8192 bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd v1.8
CPM UART driver version 0.02
ttyS0 on SMC1 at 0x0000, BRG1
ttyS1 on SCC1 at 0x8000, BRG1
ttyS2 on SCC2 at 0x8100, BRG1
pty: 256 Unix98 ptys configured
block: queued sectors max/low 8576kB/2858kB, 64 slots per
queue
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024
blocksize
eth0: FCC ENET Version 0.3, 00:00:00:80:00:01
eth0: Phy @ 0xe, type LAN83C183 (0x0016f840)
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 1367k freed
JFFS version 1.0, (C) 1999, 2000  Axis Communications AB
JFFS2 version 2.1. (C) 2001 Red Hat, Inc., designed by Axis
Communications AB.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 1024 bind 1024)
eth0: config: auto-negotiation on, 100FDX, 100HDX, 10FDX,
10HDX.
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem).
Freeing unused kernel memory: 48k init
Machine check in kernel mode.
Caused by (from SRR1=49030): Transfer error ack signal
Oops: machine check, sig: 7
NIP: C000D594 XER: 20000000 LR: C0040238 SP: C01FBE30 REGS:
c01fbd80 TRAP: 0200
MSR: 00049030 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c01fa000[1] 'sh' Last syscall: 5
last math c01fa000 last altivec 00000000
GPR00: 00000040 C01FBE30 C01FA000 C0F72000 0FFE0C58
00001000 C0F71FFF 0FFDF304
GPR08: C01EE800 00000000 C0F72000 00000001 40444084
10063E5C 00FFB000 007FFF67
GPR16: 00000001 00000000 007FFF00 00FF6084 00009032
001FBE70 00000000 C0003DE4
GPR24: C0003B20 0FFEAA94 0FFED6A0 10070378 00000008
C0F72000 00001000 0FFE0C58
Call backtrace:
C00401C8 C0033434 C0003B7C 00FF6084 0FF1A05C 0FF4FBF8
0FF4EA04
0FF4F858 0FF4C4C8 0FF85B60 0FF85998 1000F14C 1000F5C8
100106F0
1003A5E0 1003A200 0FECFF70 00000000
Kernel panic: Attempted to kill init!
#####################################################

Furthermore, if I cross-compile my own simple program (that
opens devices etc) I am able to run it flawlessly for a
long time by passing an init=/tmp/myprogram argument to the
kernel - no oops generated there...?

Please let me know if any more information is required...

Can someone please be so kind to help me debug this...what
might be wrong / what should I do to try and get a better
understanding of what is going wrong? I've tried getting
ksymoops working (it was not included in my ELDK package,
so I downloaded it from ftp.au.kernel.org), but I do not
realy grasp the concept... Correct me if I'm wrong, but the
kernel should create an oops report somewhere on the file
system on which I can then run ksymoops (on my Redhat8 host
machine?) to reconstruct the events of the oops?

Thank you in advance

Regards

Etienne van der Linde
Parsec (Pty) Ltd
http://www.parsec.co.za
_________________________________________________________________________________
Cut out the middle man with Dial Direct Insurance, click here for a free e-Quote!
http://www.directquote.co.za/emailquote.asp?vdn=5800&tel=0860%2010%2022%2046

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
