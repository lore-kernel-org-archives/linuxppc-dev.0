From: kd@flaga.is
Subject: ext2fs or ramdisk problems......
To: linuxppc-embedded@lists.linuxppc.org
Message-ID: <OF18903253.173E814B-ON00256945.00432B3E@flaga.is>
Date: Thu, 24 Aug 2000 12:25:04 +0000
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

Is it for shure that the ext2fs is endian independent?
fs created with the commands (issued in Debian 2.2. (potato) on an i386
machine) :

dd if=/dev/zero of=fs bs=1k count=4096
mke2fs -m0   fs 4096
mount fs /mnt/ramdisk/ -o loop
cd /mnt/ramdisk/
tar -xvf /tmp/fs.tar
cd /tmp
umount /mnt/ramdisk/
gzip -9 fs

results in the following......

loaded at:     FE020000 FE02C204
relocated to:  00100000 0010C204
board data at: 001001C4 001001E8
relocated to:  00200100 00200124
zimage at:     FE027000 FE0758CB
initrd at:     FE0758CB FE167ECB
relocated to:  00F0D000 00FFF600
avail ram:     00201000 00F0D000

Linux/PPC load: root=/dev/ram
Uncompressing Linux...done.
Now booting the kernel
Linux version 2.2.13 (kd@BigTits) (gcc version 2.95.2 19991024 (release))
#31 Thu Aug 24 09:40:59 GMT 2000
Boot arguments: root=/dev/ram
time_init: decrementer frequency = 90000000/60
Calibrating delay loop... 23.71 BogoMIPS
Memory: 14400k available (572k kernel code, 412k data, 28k init)
[c0000000,c1000000]
DENTRY hash table entries: 262144 (order: 9, 2097152 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 4096 (order: 2, 16384 bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.2
Based upon Swansea University Computer Society NET3.039
NET4: Unix domain sockets 1.0 for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
TCP: Hash tables configured (ehash 16384 bhash 16384)
Starting kswapd v 1.5
CPM UART driver version 0.03
ttyS00 at 0x0280 is a SMC
pty: 256 Unix98 ptys configured
RAM disk driver initialized:  1 RAM disks of 4096K size
loop: registered device at major 7
eth0: CPM ENET Version 0.2, 00:01:02:03:04:07
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).
Freeing unused kernel memory: 28k init
attempt to access beyond end of device
01:00: rw=0, want=2036662601, limit=4096
dev 01:00 blksize=1024 blocknr=-110821048 sector=-221642096 size=1024
count=1
attempt to access beyond end of device
01:00: rw=0, want=1879073169, limit=4096
dev 01:00 blksize=1024 blocknr=1879073168 sector=-536820960 size=1024
count=1
attempt to access beyond end of device
01:00: rw=0, want=201441084, limit=4096
dev 01:00 blksize=1024 blocknr=-1946042565 sector=402882166 size=1024
count=1
attempt to access beyond end of device
etc.......
and then it hangs.

Or is this still the ramdisk driver teesing me?

Board is custom board with mpc823.
Kernel is the hard hat 2.2.13 with no nfs support, bootp or rarp support
built in.

Totally pussled!
K.D.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
