Message-Id: <m12uJGo-001SyaC@bucks>
From: diekema@bucks.si.com (diekema_jon)
Subject: "eth0: transmit timed out" / "nfs: task can't get a request slot" msgs
To: linuxppc-embedded@lists.linuxppc.org
Date: Tue, 23 May 2000 14:19:10 -0400 (EDT)
Cc: all@cideas.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


To: linuxppc-embedded@lists.linuxppc.org

Platform: EST SBC8260 w/ MPC8260 Rev A.1 running at 166 Mhz
Ethernet: 10 Mbs (SCC)
Root file system: Hard Hat Linux 1.1 from MontaVista
Linux: 2.3.99-pre9

Problem:

We are experiencing "eth0: transmit timed out" and "nfs: task XXXX
can't get a request slot" messages during high NFS activity.  When
this happens, the system performance is significantly degraded.  The
Ethernet Tx LED only flashes infrequently.  I have experienced this
problem under two cases:

1. A -mhard-float floating point application writing its results to a
   NFS mounted log file.

2. Using cp to copy a 100 MB file to/from a NFS mounted partition.

In either case, the task never runs to completion in a reasonable
amount of time.

Does anybody have any hints in how to isolate/debug this problem?


Here is the console output from the first case:

Starting at 0x400000...

loaded at:     00400000 0040B270
board data at: 00FFFFC0 00FFFFE4
relocated to:  00200100 00200124
zimage at:     0040B270 0047CE72
avail ram:     0047D000 01000000

Linux/PPC load: root=/dev/nfs rw nfsroot=126.28.1.117:/target nfsaddrs=126.1.4.5:126.28.1.117::255.0.0.0 init=/bin/sash
Uncompressing Linux...done.
Now booting the kernel
Total memory = 16MB; using 0kB for hash table (at 00000000)
Linux version 2.3.99-pre9 (diekema@dell) (gcc version 2.95.2 19991024 (release)) #49 Mon May 22 14:44:39 EDT 2000
Boot arguments: root=/dev/nfs rw nfsroot=126.28.1.117:/target nfsaddrs=126.1.4.5:126.28.1.117::255.0.0.0 init=/bin/sash
On node 0 totalpages: 4096
zone(0): 4096 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Calibrating delay loop... 164.66 BogoMIPS
Memory: 14736k available (860k kernel code, 416k data, 48k init) [c0000000,c1000000]
Dentry-cache hash table entries: 2048 (order: 2, 16384 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 4096 (order: 2, 16384 bytes)
kmem_create: Poisoning requested, but con given - bdev_cache
Inode-cache hash table entries: 1024 (order: 1, 8192 bytes)
kmem_create: Poisoning requested, but con given - inode_cache
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.3
Based upon Swansea University Computer Society NET3.039
kmem_create: Poisoning requested, but con given - skbuff_head_cache
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 1024 bind 1024)
Starting kswapd v1.6
CPM UART driver version 0.01
ttyS00 at 0x0000 is a SMC
ttyS01 at 0x0040 is a SMC
ttyS02 at 0x8100 is a SCC
ttyS03 at 0x8200 is a SCC
pty: 256 Unix98 ptys configured
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: registered device at major 7
loop: enabling 8 loop devices
eth0: SCC ENET Version 0.1, 00:a0:1e:01:04:05
kmem_create: Forcing size word alignment - nfs_fh
Looking up port of RPC 100003/2 on 126.28.1.117
Looking up port of RPC 100005/2 on 126.28.1.117
VFS: Mounted root (nfs filesystem).
Freeing unused kernel memory: 48k init
Stand-alone shell (version 3.4)
> ls -al z.in
-rw-rw-r--   1 root     root     117575680 May 23  2000 z.in
> cp z.in z.out &
> NETDEV WATCHDOG: eth0: transmit timed out
eth0: transmit timed out.
 Ring data dump: cur_tx f00001f8 cur_rx f00001c0.
1c04 05ea 00e61802
1c04 05ea 00e60002
1c04 0512 00120802
1c04 05ea 00120002
1c04 05ea 00f96002
1c00 05ea 00f97802
1c00 05ea 00f96802
3c00 0512 00e60802
9c00 011c 001f8000
9c00 0040 001f8800
9c00 0066 001ed000
9c00 0040 001ed800
9c00 0075 001ec000
9c00 00ba 001ec800
9c00 0040 001eb000
bc00 0066 001eb800
NETDEV WATCHDOG: eth0: transmit timed out
eth0: transmit timed out.
 Ring data dump: cur_tx f00001f8 cur_rx f00001b0.
1c00 009e 001fbda2
1c00 009e 001fbec2
1c00 009e 00d9c002
1c00 009e 00d9c122
1c00 009e 00d9c242
1c00 009e 001fba42
1c00 009e 001fbb62
3c00 009e 001fbc82
9c00 0040 001f8000
9c00 0040 001f8800
9c00 0060 001ed000
9c00 0040 001ed800
9c00 0040 001ec000
9c00 0040 001ec800
9c00 0040 001eb000
bc00 0060 001eb800
nfs_refresh_inode: inode number mismatch
expected (0x305/0x104a5), got (0x305/0x4fd4)
nfs_refresh_inode: inode number mismatch
expected (0x305/0x104a5), got (0x305/0x4fd4)
nfs_refresh_inode: inode number mismatch
expected (0x305/0x104a5), got (0x305/0x4fd4)
nfs_refresh_inode: inode number mismatch
expected (0x305/0x104a5), got (0x305/0x4fd4)
nfs_refresh_inode: inode number mismatch
expected (0x305/0x104a5), got (0x305/0x4fd4)
nfs_refresh_inode: inode number mismatch
expected (0x305/0x104a5), got (0x305/0x4fd4)
nfs_refresh_inode: inode number mismatch
expected (0x305/0x104a5), got (0x305/0x4fd4)

> ls
bin   dev  lib	    mnt  proc  share	  tmp  z.in
boot  etc  libexec  opt  sbin  simsystem  web  z.out
> ls -al
total 118988
drwxr-xr-x  15 root     root         4096 May 23  2000 .
drwxr-xr-x  15 root     root         4096 May 23  2000 ..
drwxr-xr-x   2 root     root         4096 May 18  2000 bin
drwxr-xr-x   2 root     root         4096 May 22  2000 boot
drwxr-xr-x   2 root     root         4096 May 18  2000 dev
drwxr-xr-x   3 root     root         4096 May 23  2000 etc
drwxr-xr-x   3 root     root         4096 May 18  2000 lib
drwxr-xr-x   2 root     root         4096 May 18  2000 libexec
drwxr-xr-x   2 root     root         4096 May  2  2000 mnt
drwxr-xr-x   3 root     root         4096 May 18  2000 opt
dr-xr-xr-x  16 root     root            0 Dec 31 16:00 proc
lrwxrwxrwx   1 root     root            3 May 18  2000 sbin -> bin
drwxr-xr-x   5 root     root         4096 Apr 20  2000 share
drwxr-xr-x   2 4637     1100         4096 May 23  2000 simsystem
drwxr-xr-x   2 root     root         4096 May  2  2000 tmp
drwxr-xr-x  12 root     root         4096 May 18  2000 web
-rw-rw-r--   1 root     root     117575680 May 23  2000 z.in
-rw-------   1 root     root      4141056 May 23  2000 z.out
> ls -CF
VM: killing process ls
pid 47: killed by signal 9
> cp: z.out: Cannot allocate memory
VM: killing process cp


Here is the console output from the second case after Linux has booted
sash:

> ./simsystem
Block length: 2048
Antialias FIR: 128
Unable to open Drive.dat.  Using defaults
NETDEV WATCHDOG: eth0: transmit timed out
eth0: transmit timed out.
 Ring data dump: cur_tx f00001f0 cur_rx f0000190.
1c08 05ea 00ec2002
1c04 0512 00b89802
1c10 05ea 00b89002
1c04 05ea 00b88802
1c00 05ea 00120802
1c00 05ea 00120002
1c00 0512 00ec3802
3c00 05ea 00ec2802
9c00 0076 001f8000
9c00 0076 001f8800
9c00 0066 001ed000
9c00 0075 001ed800
9c00 00cc 001ec000
9c00 00ee 001ec800
9c00 0060 001eb000
bc00 0060 001eb800
NETDEV WATCHDOG: eth0: transmit timed out
eth0: transmit timed out.
 Ring data dump: cur_tx f00001f0 cur_rx f0000190.
1c00 05ea 00b85802
1c08 05ea 00b85002
1c00 0512 00b84802
1c04 05ea 00b84002
1c00 0512 00b87802
1c00 05ea 00b87002
1c00 05ea 00b86802
3c00 0512 00b86002
9c00 00ba 001f8000
9c00 0060 001f8800
9c00 0066 001ed000
9c00 01f5 001ed800
9c00 0066 001ec000
9c00 005a 001ec800
9c00 0076 001eb000
bc00 0076 001eb800
nfs: server 126.28.1.117 not responding, still trying
NETDEV WATCHDOG: eth0: transmit timed out
eth0: transmit timed out.
 Ring data dump: cur_tx f00001f0 cur_rx f00001c0.
1c04 0512 00d7d802
1c04 05ea 00d7d002
1c04 05ea 00d7c802
1c00 0512 00d7c002
1c00 05ea 00b83802
1c00 0512 00b83002
1c00 05ea 00b82802
3c08 05ea 00b82002
9c00 0075 001f8000
9c00 0040 001f8800
9c00 0040 001ed000
9c00 0040 001ed800
9c00 0040 001ec000
9c00 0066 001ec800
9c00 0072 001eb000
bc00 0040 001eb800
NETDEV WATCHDOG: eth0: transmit timed out
eth0: transmit timed out.
 Ring data dump: cur_tx f00001f0 cur_rx f00001b0.
1c08 05ea 00d77802
1c08 0512 00d77002
1c04 05ea 00d76802
1c04 05ea 00d76002
1c00 05ea 00d7b802
1c00 05ea 00d7b002
1c00 0512 00d7a802
3c00 05ea 00d7a002
9c00 0040 001f8000
9c00 0075 001f8800
9c00 0075 001ed000
9c00 0075 001ed800
9c00 0076 001ec000
9c00 0075 001ec800
9c00 0075 001eb000
bc00 0040 001eb800
NETDEV WATCHDOG: eth0: transmit timed out
eth0: transmit timed out.
 Ring data dump: cur_tx f00001f0 cur_rx f00001c8.
1c00 05ea 00d74802
1c00 0512 00d74002
1c04 05ea 00d73802
1c04 05ea 00d73002
5c00 002a 00e4faa2
5c00 002a 00e4f642
1c00 0512 00d75802
3c00 05ea 00d75002
9c00 0060 001f8000
9c00 0060 001f8800
9c00 0066 001ed000
9c00 0040 001ed800
9c00 0072 001ec000
9c00 0066 001ec800
9c00 00ba 001eb000
bc00 0066 001eb800
NETDEV WATCHDOG: eth0: transmit timed out
eth0: transmit timed out.
 Ring data dump: cur_tx f00001f0 cur_rx f0000190.
5c00 002a 00e4fa02
5c00 002a 00e4fc82
5c00 002a 00e4fdc2
5c00 002a 00e4fe62
1c00 0512 00d72802
1c00 05ea 00d72002
1c00 05ea 00d71802
7c00 002a 00e4fb42
9c00 0075 001f8000
9c00 0076 001f8800
9c00 0040 001ed000
9c00 0075 001ed800
9c00 0076 001ec000
9c00 0075 001ec800
9c00 00ba 001eb000
bc00 0076 001eb800
nfs: task 1365 can't get a request slot
nfs: task 1366 can't get a request slot
nfs: task 1367 can't get a request slot
nfs: task 1368 can't get a request slot
nfs: task 1369 can't get a request slot

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
