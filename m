Message-ID: <3895256C.250C6FC0@m2tech.co.nz>
Date: Mon, 31 Jan 2000 19:02:20 +1300
From: ben bodley <benb@m2tech.co.nz>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: 403gcx nfs boot problem
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


managed to get the 403gcx eval board booting via nfs.. (with a hacked up
serial console :)

Linux version 2.3.39 (root@zone.m2) (gcc version egcs-2.91.66 19990314
(egcs-1.1.2 release)) #64 Mon Jan 31 12:32:09 NZDT 2000
On node 0 totalpages: 00000400
zone(0): 1024 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Calibrating delay loop... 66.56 BogoMIPS
Memory: 2268k available (960k kernel code, 740k data, 44k init)
[c0000000,c0400000]
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 1024 (order: 0, 4096 bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.3
Based upon Swansea University Computer Society NET3.039
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 512 bind 1024)
IPv4 over IPv4 tunneling driver
early initialization of device tunl0 is deferred
Starting kswapd v1.6
Serial driver version 4.91 (1999-11-17) with no serial options enabled
ttyS00 at 0x7e000000 (irq = 28) is a 16550A
pty: 256 Unix98 ptys configured
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: registered device at major 7
loop: enabling 8 loop devices
eth0: National DP83902AV at 00:04:ac:e3:09:c6, found at 0xf4000000,
using IRQ 27.
SLIP: version 0.8.4-NET3.019-NEWTTY (dynamic channels, max=256).
PPP generic driver version 2.4.0
PPP Deflate compression module registered
Looking up port of RPC 100003/2 on 10.0.0.240
Looking up port of RPC 100005/1 on 10.0.0.240
VFS: Mounted root (NFS filesystem) readonly.
Freeing unused kernel memory: 44k init

the tcpdump of the nfs follows::

14:35:03.694220 eth0 B arp who-has linuxbox.m2 tell gcx.m2
14:35:03.694387 eth0 P arp reply linuxbox.m2 is-at 0:40:5:3f:3f:dc
(0:4:ac:e3:9:c6)
14:35:03.694987 eth0 P gcx.m2.800 > linuxbox.m2.sunrpc: udp 56 (ttl 64,
id 59944)
14:35:03.696301 eth0 P linuxbox.m2.sunrpc > gcx.m2.800: udp 28 (ttl 64,
id 19660)
14:35:03.750605 eth0 P gcx.m2.800 > linuxbox.m2.sunrpc: udp 56 (ttl 64,
id 59945)
14:35:03.751761 eth0 P linuxbox.m2.sunrpc > gcx.m2.800: udp 28 (ttl 64,
id 19661)
14:35:03.753102 eth0 P gcx.m2.800 > linuxbox.m2.604: udp 64 (ttl 64, id
59946)
14:35:03.757779 eth0 P linuxbox.m2.604 > gcx.m2.800: udp 60 (ttl 64, id
19663)
14:35:03.759661 eth0 P gcx.m2.3 > linuxbox.m2.nfs: 96 getattr fh
Unknown/1 (ttl 64, id 59947)
14:35:03.760111 eth0 P linuxbox.m2.nfs > gcx.m2.3: reply ok 96 getattr
DIR 40755 ids 0/0 sz 1024  (ttl 64, id 19664)
14:35:03.859114 eth0 P gcx.m2.4 > linuxbox.m2.nfs: 104 lookup fh
Unknown/1 "dev" (ttl 64, id 59948)
14:35:03.859576 eth0 P linuxbox.m2.nfs > gcx.m2.4: reply ok 128 lookup
fh Unknown/1 DIR 40755 ids 0/0 sz 1024  (ttl 64, id 19665)
14:35:03.860929 eth0 P gcx.m2.5 > linuxbox.m2.nfs: 108 lookup fh
Unknown/1 "console" (ttl 64, id 59949)
14:35:03.861367 eth0 P linuxbox.m2.nfs > gcx.m2.5: reply ok 128 lookup
fh Unknown/1 LNK 120777 ids 0/0 sz 5  (ttl 64, id 19666)
14:35:03.862656 eth0 P gcx.m2.6 > linuxbox.m2.nfs: 96 readlink fh
Unknown/1 (ttl 64, id 59950)
14:35:03.862941 eth0 P linuxbox.m2.nfs > gcx.m2.6: reply ok 40 readlink
"ttyS0" (ttl 64, id 19667)
14:35:03.864130 eth0 P gcx.m2.7 > linuxbox.m2.nfs: 108 lookup fh
Unknown/1 "ttyS0" (ttl 64, id 59951)
14:35:03.864576 eth0 P linuxbox.m2.nfs > gcx.m2.7: reply ok 128 lookup
fh Unknown/1 CHR 20644 ids 0/0 sz 0  (ttl 64, id 19668)
14:35:03.866550 eth0 P gcx.m2.8 > linuxbox.m2.nfs: 104 lookup fh
Unknown/1 "bin" (ttl 64, id 59952)
14:35:03.867015 eth0 P linuxbox.m2.nfs > gcx.m2.8: reply ok 128 lookup
fh Unknown/1 DIR 40755 ids 1000/0 sz 1024  (ttl 64, id 19669)
14:35:03.868352 eth0 P gcx.m2.9 > linuxbox.m2.nfs: 104 lookup fh
Unknown/1 "sh" (ttl 64, id 59953)
14:35:03.868784 eth0 P linuxbox.m2.nfs > gcx.m2.9: reply ok 128 lookup
fh Unknown/1 REG 100755 ids 1000/0 sz 375704  (ttl 64, id 19670)
14:35:03.870171 eth0 P gcx.m2.10 > linuxbox.m2.nfs: 108 read fh
Unknown/1 4096 bytes @ 0 (ttl 64, id 59954)
14:35:03.872401 eth0 P linuxbox.m2 > gcx.m2: (frag 19671:1244@2960) (ttl
64)
14:35:03.873770 eth0 P linuxbox.m2 > gcx.m2: (frag 19671:1480@1480+)
(ttl 64)
14:35:03.875011 eth0 P linuxbox.m2.nfs > gcx.m2.10: reply ok 1472 read
REG 100755 ids 1000/0 sz 375704  (frag 19671:1480@0+) (ttl 64)
14:35:03.881167 eth0 P gcx.m2.11 > linuxbox.m2.nfs: 104 lookup fh
Unknown/1 "lib" (ttl 64, id 59955)
14:35:03.881623 eth0 P linuxbox.m2.nfs > gcx.m2.11: reply ok 128 lookup
fh Unknown/1 DIR 40755 ids 1000/0 sz 2048  (ttl 64, id 19672)
14:35:03.882973 eth0 P gcx.m2.12 > linuxbox.m2.nfs: 108 lookup fh
Unknown/1 "ld.so.1" (ttl 64, id 59956)
14:35:03.883419 eth0 P linuxbox.m2.nfs > gcx.m2.12: reply ok 128 lookup
fh Unknown/1 LNK 120777 ids 0/0 sz 11  (ttl 64, id 19673)
14:35:03.884721 eth0 P gcx.m2.13 > linuxbox.m2.nfs: 96 readlink fh
Unknown/1 (ttl 64, id 59957)
14:35:03.885002 eth0 P linuxbox.m2.nfs > gcx.m2.13: reply ok 44 readlink
"ld-2.1.2.so" (ttl 64, id 19674)
14:35:03.886209 eth0 P gcx.m2.14 > linuxbox.m2.nfs: 112 lookup fh
Unknown/1 "ld-2.1.2.so" (ttl 64, id 59958)
14:35:03.886660 eth0 P linuxbox.m2.nfs > gcx.m2.14: reply ok 128 lookup
fh Unknown/1 REG 100755 ids 0/0 sz 392042  (ttl 64, id 19675)
14:35:03.888068 eth0 P gcx.m2.15 > linuxbox.m2.nfs: 108 read fh
Unknown/1 4096 bytes @ 0 (ttl 64, id 59959)
14:35:03.890266 eth0 P linuxbox.m2 > gcx.m2: (frag 19676:1244@2960) (ttl
64)
14:35:03.891642 eth0 P linuxbox.m2 > gcx.m2: (frag 19676:1480@1480+)
(ttl 64)
14:35:03.892887 eth0 P linuxbox.m2.nfs > gcx.m2.15: reply ok 1472 read
REG 100755 ids 0/0 sz 392042  (frag 19676:1480@0+) (ttl 64)
14:35:07.351745 eth0 P gcx.m2.15 > linuxbox.m2.nfs: 108 read [|nfs] (ttl
64, id 59959)
14:35:08.687005 eth0 P arp who-has gcx.m2 tell linuxbox.m2
14:35:09.687022 eth0 P arp who-has gcx.m2 tell linuxbox.m2
14:35:10.687046 eth0 P arp who-has gcx.m2 tell linuxbox.m2
14:35:11.687062 eth0 B arp who-has gcx.m2 tell linuxbox.m2
14:35:12.687080 eth0 B arp who-has gcx.m2 tell linuxbox.m2
14:35:13.687103 eth0 B arp who-has gcx.m2 tell linuxbox.m2.


now.. thing is, can anyone tell me what has happened at the end of this
transcript?? that last [|nfs] message from the gcx, is that incomplete??
or just an ack?? all that happens on the serial console now is a whole
lot of garbage.. i think its caused from some exceptions while handling
the irqs.

does anyone know of a description of how nfs works?? is it supposed to
load entire files into memory, or just the pieces of code it needs??
from the transcript, it looks like the kernel doesnt like my glibc very
much :)

any input would be well received..

ben


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
