Message-Id: <200001261853.SAA07221@cthulhu.dircon.co.uk>
Subject: MBX experiences
To: linuxppc-embedded@lists.linuxppc.org
Date: Wed, 26 Jan 2000 18:53:08 +0000 (GMT/BST)
From: Digby Tarvin <digbyt@acm.org>
Reply-To: digbyt@acm.org (Digby Tarvin)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Greetings all,

I am new to this list, and am trying to get Linux going on a
Motorola MBX821, and am hoping someone can give me an update on the
state of the art in this area to save me doing too much re-invention.

The following is a summary of where I have gotten so far, in case it is
of any help/interest to anyone. I would welcome any suggestions from
those that have gotten further or can see things that I am doing
wrong.

My board identifies itself as follows:
  Copyright Motorola Inc. 1988-1998, All Rights Reserved

  MBX Debugger/Diagnostics Release Version 1.4 - 04/01/98 RM01
  COLD Start

  Local Memory Found =01000000 (&16777216)

  MPU Clock Speed =40Mhz

  WARNING: Keyboard Not Connected

  WARNING: Low Battery Status - On_Board Battery


  EPPC-Bug>ver
  Debugger/Diagnostics Type/Revision..................=MBX/1.4
  Debugger/Diagnostics Revision Date..................=04/01/98 RM01
  MicroProcessor Version/Revision.....................=0050/0000
  MicroProcessor Internal Clock Speed (MHZ)...........=40
  MicroProcessor External Clock Speed (MHZ)...........=40
  Communication Processor Module (CPM) Part/Mask......=00/20
  Internal Memory Map Pointer.........................=FA200000
  Local Memory Size...................................=01000000 (16MB)
  PCI Device (00009800) ID/Revision...................=056510AD/10
  PCI Device (00009900) ID/Revision...................=010510AD/05

My initial search for MBX and Linux located the archive:
	ftp://linuxppc.cs.nmt.edu/pub/linuxppc/embedded/
which contains:
-rw-r--r--   1 dmalek   1000        17293 Nov 10 11:41 dl-machine.h
-rw-r--r--   1 dmalek   1000         6018 Jul  8  1999 embedded_notes
-rw-r--r--   1 dmalek   1000        32876 Oct 22 17:31 fadsrom.tgz
-rw-r--r--   1 dmalek   dmalek      31153 Jan 19 09:15 fec.c
-rw-r--r--   1 dmalek   1000       166978 Nov  5 18:55 gdbserver.tgz
-rw-r--r--   1 dmalek   1000         7492 Oct 28 12:28 getting_started.rpx
-rw-r--r--   1 dmalek   1000      3446575 Nov  8 17:07 glibc-0.961212-1r.src.rpm
-rw-r--r--   1 dmalek   1000       707994 Mar  4  1999 libc-1.99-8xx.tar.gz
-rw-r--r--   1 dmalek   1000     13402725 Sep 14 19:41 linux-2.3.18.tgz
-rw-r--r--   1 dmalek   1000         6345 Jul  8  1999 mbxnotes
-rw-r--r--   1 dmalek   1000     133029168 Feb 12  1999 mbxroot.full.tgz
-rw-r--r--   1 dmalek   1000       910617 Sep 18  1998 mbxroot.min.tgz
-rw-r--r--   1 dmalek   1000     17172560 Oct 22 17:38 mpc8xx-2.2.13.tgz
-rw-r--r--   1 dmalek   1000      5335914 Jul 28  1999 xppc_tools.tgz
-rw-r--r--   1 dmalek   dmalek       2042 Nov 30 11:23 zsrec.c

These look a little old, but at the time was all I could find, so I
gave them a try.

I Downloaded mbxroot.min.tgz and and mbxroot.full.tgz (as well as mbxnotes)
and configured BOOTP on my host system to use the kernel from mbxroot.min.tgz
(zImage.mbx), and unpacked mbxroot.full.tgz to give me a filesystem via NFS.

There was a mysterious error when I un-tar'd the mbxroot.full.tgz
archive as follows:
 /usr/home/digbyt/embedded/tmp> sudo tar -xf ../mbxroot.full.tar
 tar: mbxroot/usr/bin/sperl5.00401: Could not link to `mbxroot/usr/bin/suidperl': No such file or directory
 tar: Error exit delayed from previous errors

I have only seen this sort of message in the past when the filesystem
was being changed while the archive was being built. It didn't seem to
serious, but seemed strange that such a flaw would have gone uncorrected.

The first hiccup I encountered when trying to boot was that the kernel seems
to mis-read the IP addresses used to boot it, causing the NFS mount to fail
as follows:
 EPPC-Bug>pl 20, 0
 Network Booting from: MPC860, Controller 20, Device 0
 Loading: /tftpboot/zImage.mbx

 Client IP Address      = 203.27.41.9
 Server IP Address      = 203.27.41.5
 Gateway IP Address     = 203.27.41.5
 Subnet IP Address Mask = 255.255.255.192
 Boot File Name         = /tftpboot/zImage.mbx
 Argument File Name     =

 Bytes Received =&492532, Bytes Loaded =&492532
 Bytes/Second   =&98506, Elapsed Time =5 Second(s)
 loaded at:     00210000 0030E42C
 relocated to:  00100000 001FE42C
 board data at: 00FF4558 00FF4580
 relocated to:  00200100 00200128
 zimage at:     00216000 00276D6D
 avail ram:     0030E42C 00FF5000

 Linux/PPC load:
 Uncompressing Linux...done.
 Now booting the kernel
 Linux version 2.1.119 (dan@pbdan.clearone.com) (gcc version egcs-2.90.25 980302
 (egcs-1.0.2 prerelease)) #31 Mon Sep 7 18:14:20 EDT 1998
 Boot arguments: root=/dev/nfs nfsaddrs=23.27.41.9:23.27.41.5 nfsroot=23.27.41.5:
 /tftpboot

Note that what should have been '203' became '23'.....
giving the appropriate commands to override this at the 'Linux/PPC load:'
prompt overcomes this, and I was able to boot with the following result:

 EPPC-Bug>pl 20 0
 Network Booting from: MPC860, Controller 20, Device 0
 Loading: /tftpboot/zImage.mbx

 Client IP Address      = 203.27.41.9
 Server IP Address      = 203.27.41.5
 Gateway IP Address     = 203.27.41.5
 Subnet IP Address Mask = 255.255.255.192
 Boot File Name         = /tftpboot/zImage.mbx
 Argument File Name     =

 Bytes Received =&492532, Bytes Loaded =&492532
 Bytes/Second   =&82088, Elapsed Time =6 Second(s)
 loaded at:     00210000 0030E42C
 relocated to:  00100000 001FE42C
 board data at: 00FF4558 00FF4580
 relocated to:  00200100 00200128
 zimage at:     00216000 00276D6D
 avail ram:     0030E42C 00FF5000

 Linux/PPC load: root=/dev/nfs nfsaddr=203.27.41.9:203.27.41.10 nfsroot=203.27.41.10:
 /usr/home/digbyt/embedded/mbxroot
 Uncompressing Linux...done.
 Now booting the kernel
 Linux version 2.1.119 (dan@pbdan.clearone.com) (gcc version egcs-2.90.25 980302 (egc
 s-1.0.2 prerelease)) #31 Mon Sep 7 18:14:20 EDT 1998
 Boot arguments: root=/dev/nfs nfsaddr=203.27.41.9:203.27.41.10 nfsroot=203.27.41.10:
 /usr/home/digbyt/embedded/mbxroot
 time_init: decrementer frequency = 150000000/60
 Memory: 15004k available (732k kernel code, 612k data, 36k init) [c0000000,c1000000]
 PCI: Probing PCI hardware
 Calibrating delay loop... 39.73 BogoMIPS
 POSIX conformance testing by UNIFIX
 Swansea University Computer Society NET3.039 for Linux 2.1
 NET3: Unix domain sockets 0.16 for Linux NET3.038.
 Swansea University Computer Society TCP/IP for NET3.037
 IP Protocols: ICMP, UDP, TCP, IGMP
 Starting kswapd v 1.5
 CPM UART driver version 0.02
 ttyS00 at 0x0280 is a SMC
 ttyS01 at 0x0380 is a SMC
 ttyS02 at 0x0100 is a SCC
 ttyS03 at 0x0200 is a SCC
 CPM ENET Version 0.1, 08:00:3e:27:b8:fd
 PPP: version 2.3.3 (demand dialling)
 TCP compression code copyright 1989 Regents of the University of California
 PPP line discipline registered.
 Sending BOOTP and RARP requests.... OK
 IP-Config: Got BOOTP answer from 203.27.41.5, my address is 203.27.41.9
 Looking up port of RPC 100003/2 on 203.27.41.10
 Looking up port of RPC 100005/1 on 203.27.41.10
 VFS: Mounted root (nfs filesystem).
 Freeing unused kernel memory: 36k init 28k prep
 #

after which I can run commands like:

 # mount /proc
 # cat /proc/cpuinfo
 processor       : 0
 cpu             : 860
 clock           : 132MHz
 bus clock       : 136MHz
 revision        : 0.0
 bogomips        : 39.73
 zero pages      : total 0 (0Kb) current: 0 (0Kb) hits: 0/9 (0%)
 # cat /proc/version
 Linux version 2.1.119 (dan@pbdan.clearone.com) (gcc version egcs-2.90.25 980302 (egc
 s-1.0.2 prerelease)) #31 Mon Sep 7 18:14:20 EDT 1998
 #

I can successfully telnet out of the MBX, so the network driver seems fine
(obviously, since my filesystem is coming from the net...), but the
filesystem did not seem to contain the necessary binaries to run
servers to let me telnet in from outside, or go into multi-user mode.

The main problem now, apart from the incomplete set of tools, is that many
key programs fail, for instance:
 # ps
 Bad emulation ps/9
  NIP: 300d00e0 instruction: fc200090 opcode: 3f A: 0 B: 0 C: 2 code: 8 rc: 0
  pte @ 0x300d00e0:  (0xc0f3d300)->(0xc0f3b340)->0x00f14881
  RPN: 00f14 PP: 2 SPS: 0 SH: 0 CI: 0 v: 1
 Kernel VA for NIP c0f140e0  pte @ 0xc0f140e0:  (0xc0f3dc0c)->(0xc0123c50)->0x00f141c
 5
  RPN: 00f14 PP: 0 SPS: 0 SH: 1 CI: 0 v: 1
 Software Emulation ps/9 NIP: 300d00e0 *NIP: 0xfc200090 code: 1Illegal Instruction
 #
This also happens if I try to set the date. Is this a floating point emulation
problem? Given that the tree was built for MBX targets, I am not sure why
mine should fail and others not. Is anyone else having more success with
this?

Also, if I try to use gcc, the system seems to just hang.

Finally, I tried configuring a cross compiler to run on an Intel Linux
system (Red Hat 5.2), using a set of instructions I found by
mmporter@home.com (for Egcs 1.1.2), which seemed to work fine, except
that my compiles failed the link stage due to a missing crt1.o and crti.o
libc.o and crtn.o

I copied these across from /usr/lib of the mbxroot.full file tree, and managed
to get an executable, and when I copied it across to my MBX file system,
lo and behold:
  # ./hello
  Hello from MBX world

However I am still curious to know where the crt1.o, crti.o libc.o and crtn.o
that were missing after my build from source of the compiler come from,
so that I can have a cross compiler built completely from source....

Regards,
DigbyT
--
Digby R. S. Tarvin                                              digbyt@acm.org
http://www.cthulhu.dircon.co.uk

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
