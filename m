Message-Id: <m13o2oH-001Sy8C@bucks>
From: diekema@bucks.si.com (diekema_jon)
Subject: Problems with fast ethernet on the EST SBC8260 and the CTX-1170
To: linuxppc-embedded@lists.linuxppc.org
Date: Tue, 24 Oct 2000 08:04:05 -0400 (EDT)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am having a difficult time getting the 100Mb ethernet running on the
EST SBC8260.  Does anybody have any suggestions?

Does Linux 2.4.0-test10-pre3 support the CTX-1170 MII?  The
arch/ppc/8260_io/fcc_enet.c source code talks about the QS6612.  Will
I need to extended fcc_enet.c to support the CTX-1170?

I know that the hardware can work, because the VxWorks boot rom loads
via this same interface and MII.

Board:     EST SBC8260
Processor: MPC8260 200/133/33 CPU/CPM/BUS
MII:       Canary CTX-1170
Linux:     2.4.0-test10-pre3
           w/ MontaVista realtime scheduler
	   w/ low latency patch

Using the FCC2 interface for the fast ethernet interface:

>From .config:

#
# MPC8260 Communication Options
#
# CONFIG_SCC_ENET is not set
CONFIG_FEC_ENET=y
# CONFIG_FCC1_ENET is not set
CONFIG_FCC2_ENET=y
# CONFIG_FCC3_ENET is not set

Boot messages:

[VxWorks Boot]: @

boot device          : motfcc
unit number          : 0
processor number     : 0
host name            : motfcc0
file name            : zImage
inet on ethernet (e) : 207.75.228.193
host inet (h)        : 207.75.228.195
user (u)             : lftp
ftp password (pw)    : linux4me
flags (f)            : 0x0
target name (tn)     : est8260

Attached TCP/IP interface to motfcc0.
Attaching network interface lo0... done.
Loading... 45684 + 454049
Starting at 0x400000...

CPU/CPM/BUS: 198/132/33 Mhz

Ethernet (in decimal): 0:160:30:75:228:193

loaded at:     00400000 0040B274
board data at: 00FFFFC0 00FFFFEC
relocated to:  00200100 0020012C
zimage at:     0040B274 0047A015
avail ram:     0047B000 01000000

Linux/PPC load: root=/dev/nfs rw nfsroot=207.75.228.195:/target nfsaddrs=207.75.228.193:207.75.228.195
Uncompressing Linux...done.
Now booting the kernel
Total memory = 16MB; using 0kB for hash table (at 00000000)
Linux version 2.4.0-test10 (diekema@dell) (gcc version 2.95.2 19991030 (2.95.3 prerelease/franzo)) #12 Tue Oct 24 07:35:09 EDT 2000
Boot arguments: root=/dev/nfs rw nfsroot=207.75.228.195:/target nfsaddrs=207.75.228.193:207.75.228.195
On node 0 totalpages: 4096
zone(0): 4096 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/nfs rw nfsroot=207.75.228.195:/target nfsaddrs=207.75.228.193:207.75.228.195
Warning: real time clock seems stuck!
Calibrating delay loop... 131.89 BogoMIPS
Memory: 14836k available (844k kernel code, 352k data, 44k init, 0k highmem)
Dentry-cache hash table entries: 2048 (order: 2, 16384 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 4096 (order: 2, 16384 bytes)
Inode-cache hash table entries: 1024 (order: 1, 8192 bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd v1.8
CPM UART driver version 0.01
ttyS00 at 0x0000 is a SMC
ttyS01 at 0x0040 is a SMC
pty: 256 Unix98 ptys configured
eth0: FCC ENET Version 0.2, 00:a0:1e:4b:e4:c1
fec: Phy @ 0x0, type 0x010fd04b
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 1024 bind 1024)
IP-Config: Guessing netmask 255.255.255.0
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kmem_create: Forcing size word alignment - nfs_fh
Looking up port of RPC 100003/2 on 207.75.228.195
portmap: server 207.75.228.195 not responding, timed out
Root-NFS: Unable to get nfsd port number from server, using default
Looking up port of RPC 100005/2 on 207.75.228.195

Note: Ethereal shows no ethernet activity, however the TX light on the
      MII does flash.  Is is trying, but it doesn't seem to get out.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
