Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
From: m.venkatraj@exgate.tek.com
Message-ID: <301A812E6528D511A8F70008C71E578601FCF557@ap-bang-m02.india.tek.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: problems with NFS root for ADS860
Date: Wed, 10 Mar 2004 22:03:18 -0800
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C4072D.C217CF40"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C4072D.C217CF40
Content-Type: text/plain;
	charset="iso-8859-1"

Hello,

I am trying to mount Root FS via NFS on a ADS860 board.

Here is the configuration I am using:

- gcc-3.3.1, glibc-2.3.2
- u-boot-1.0.1, built for ADS860 config.
- Linux-2.4.22 with NFS-root option selected. (standard kernel, not ELDK)
- An x86 box is configured as the BOOTP and NFS server. The root file system
folder is entered in the /etc/exports, and I have also made an entry in
/etc/hosts/allow

When the kernel tries NFS mount of the root file system, error 101 results,
followed by a message
"Please append a correct "root=" boot option
Kernel panic: VFS: Unable to mount root fs on 02:00".

I verified with various sources on the net that the bootargs that I was
passing was in the correct format. Google led me to a lot of posts with the
same problem, but no leads.. Since I am relatively new around here, looking
up the kernel sources for the error 101 didn't lead me anywheer

Relevant portions of the monitor trace are attached:
Could you please guide me as to what is wrong, or am I missing something?
The same NFS server serves a 405GP walnut board that a colleaue is working
on, and there it loads just fine. That rules out NFS server configuration
errors, I think..

Just to add: I am able to mount RAMDISK root file system.

Any pointers to getting out of this muddle will be tremendously helpful..

Best regards
Venkat


------_=_NextPart_000_01C4072D.C217CF40
Content-Type: text/plain;
	name="nfserror.txt"
Content-Disposition: attachment;
	filename="nfserror.txt"

## Booting image at 00100000 ...

   Image Name:

   Image Type:   PowerPC Linux Kernel Image (gzip compressed)

   Data Size:    600102 Bytes = 586 kB

   Load Address: 00000000

   Entry Point:  00000000

   Verifying Checksum ... OK

   Uncompressing Kernel Image ... OK

Linux version 2.4.22 (root@helios) (gcc version 3.3.1) #36 Wed Mar 3 12:04:49 IS
T 2004

On node 0 totalpages: 1024

zone(0): 1024 pages.

zone(1): 0 pages.

zone(2): 0 pages.

Kernel command line: root=/dev/nfs rw nfsroot=192.158.97.38:/tftpboot/powerpc-ro
otfs/ ip=192.158.98.116:192.158.97.38:192.158.96.1:255.255.252.0:MPC860ADS_VENKA
T::off

Decrementer Frequency = 180000000/60

Calibrating delay loop... 47.61 BogoMIPS

Memory: 2620k available (1064k kernel code, 300k data, 52k init, 0k highmem)

Dentry cache hash table entries: 512 (order: 0, 4096 bytes)

Inode cache hash table entries: 512 (order: 0, 4096 bytes)

Mount cache hash table entries: 512 (order: 0, 4096 bytes)

Buffer cache hash table entries: 1024 (order: 0, 4096 bytes)

Page-cache hash table entries: 1024 (order: 0, 4096 bytes)

POSIX conformance testing by UNIFIX

Linux NET4.0 for Linux 2.4

Based upon Swansea University Computer Society NET3.039

Initializing RT netlink socket

Starting kswapd

CPM UART driver version 0.03

ttyS00 at 0x0280 is a SMC

pty: 256 Unix98 ptys configured

SLIP: version 0.8.4-NET3.019-NEWTTY (dynamic channels, max=256).

CSLIP: code copyright 1989 Regents of the University of California.

RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize

loop: loaded (max 8 devices)

NET4: Linux TCP/IP 1.0 for NET4.0

IP Protocols: ICMP, UDP, TCP, IGMP

IP: routing cache hash table of 512 buckets, 4Kbytes

TCP: Hash tables configured (established 512 bind 1024)

IP-Config: No network devices available.

NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.

Looking up port of RPC 100003/1 on 192.158.97.38

RPC: sendmsg returned error 101

portmap: RPC call returned error 101

Root-NFS: Unable to get nfsd port number from server, using default

Looking up port of RPC 100005/1 on 192.158.97.38

RPC: sendmsg returned error 101

portmap: RPC call returned error 101

Root-NFS: Unable to get mountd port number from server, using default

RPC: sendmsg returned error 101

mount: RPC call returned error 101

Root-NFS: Server returned error -101 while mounting /tftpboot/powerpc-rootfs/

VFS: Unable to mount root fs via NFS, trying floppy.

VFS: Cannot open root device "nfs" or 02:00

Please append a correct "root=" boot option

Kernel panic: VFS: Unable to mount root fs on 02:00

 <0>Rebooting in 180 seconds..

------_=_NextPart_000_01C4072D.C217CF40--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
