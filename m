Date: Sun, 21 May 2000 18:28:35 -0600 (MDT)
From: Brent <bimhoff@ns1.planetspork.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: MBX boot problems
Message-ID: <Pine.GSO.4.05.10005211739380.9894-100000@ns1.planetspork.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


So I've searched the archives and read the readme's, and it still won't
boot. :)

Story so far- I got the mbxboot.min downloaded and put on a box with tftp
and NFS access. The initial load seems to work fine, based on the
following portion of output:

EPPC-Bug>pl 20 0
Network Booting from: MPC860, Controller 20, Device 0
Loading: zImage
Client IP Address = 205.170.190.252
Server IP Address = 205.170.190.3
Gateway IP Address = 0.0.0.0
Subnet IP Address Mask = 255.255.255.0
Boot File Name = zImage
Argument File Name =

Bytes Received =&492532, Bytes Loaded =&492532
Bytes/Second =&246266, Elapsed Time =2 Secondloaded at:  00210000 0030E42C

relocated to:	00100000 001FE42C
board data at:	043F4558 043F4580
relocated to:	00200100 00200128
zimage at:	00216000 00276D6D
avail ram:	0030E42C 043F5000

Linux/PPC load:

At this point, things go bad.  I've tried two things. 1) hitting enter and
letting things fall as they may.  This didn't work since there seemed to
be a problem with it dropping the middle digit of the first octet of the
src/dst IP addresses in the boot args.  2)  explicitly defining the boot
arguments with appropriate settings.

Both return approximately the same results (shown below).


Uncompressing Linux...done.
Now booting the kernel
Linux version 2.1.119 (dan@pbdan.clearone.com) (gcc version egcs-2.90.25
980302 (egcs-1.0.2 prerelease)) #31 Mon Sep 7 18:14:20 EDT 1998
Boot arguments: root=/dev/nfs nfsaddrs=205.170.190.252:205.170.190.3
nfsroot=205 .170.190.3:/nfs/mbxroot
time_init: decrementer frequency = 187500000/60
Memory: 67572k available (732k kernel code, 1292k data, 36k init)
[c0000000,c440 0000]
PCI: Probing PCI hardware
NIP: C00085A4 XER: 20000000 LR: C0008314 REGS: c00ce958 TRAP: 0200
MSR: 00001932 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c00ccb08[0] 'swapper' mm->pgd c00ca000 Last syscall: 0
last math 00000000
GPR00: 0000000C C00CEA48 C00CCB08 00000086 00000000 0000000E C00CEA80
00000000
GPR08: FA210500 0000000D 0000000C FA210500 C00CEA68 00000000 00000000
00000000
GPR16: 00000000 00000000 00000000 00000000 00000000 043F4558 00000000
FFFFFFFF
GPR24: C011FD30 C00CEA90 00000000 00000000 00000000 C011FD20 00000000
C00CEA84
Call backtrace: 00000182 C00CEAD0 C00E1E84 C00E2340 C00DB6A4 C00021A8
Kernel panic: kernel access of bad area pc c00085a4 lr c0008314 address
C000FFF0 tsk swapper/0 In swapper task - not syncing
Rebooting in 180 seconds..

I'm sure that all means something to someone, but not me. :)  Can anyone
offer suggestions?

Thanks

-brent


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
