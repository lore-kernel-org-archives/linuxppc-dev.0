Date: Fri, 11 Jul 2003 09:33:11 +1200
From: Dmytro Bablinyuk <dmytro.bablinyuk@tait.co.nz>
Subject: telnetd: All network ports in use!
To: linuxppc mail list <linuxppc-embedded@lists.linuxppc.org>
Message-id: <3F0DDB97.2060902@tait.co.nz>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Finally we got u-boot with linux working, but I am experiencing problem with telnetd: "telnetd: All network ports in use!"
I've seen around quite a few reports about the same problem but no one solution really works.
Below I attached some info about my system in hope that somebody may be come across this problem.
Thank you in advance for any help.
-------
/ # cat /etc/fstab
# /etc/fstab: static file system information.
#
# <file system> <mount pt>     <type>   <options>         <dump> <pass>
/dev/root       /              ext2     rw,noauto         0      1
tmpfs           /tmp           tmpfs    defaults          0      0

none            /proc          proc     defaults          0      0
none            /dev/pts       devpts   mode=0620         0      0
-------
/ # mount
/dev/ram0 on / type ext2 (rw)
/proc on /proc type proc (rw)
tmpfs on /tmp type tmpfs (rw)
none on /dev/pts type devpts (rw)
-------
/ # netstat -a
Active Internet connections (servers and established)
Proto Recv-Q Send-Q Local Address           Foreign Address         State
tcp        0      0 *:telnet                *:*                     LISTEN
Active UNIX domain sockets (servers and established)
Proto RefCnt Flags       Type       State         I-Node Path
unix  2      [ ]         DGRAM                    51     /dev/log
/ #
-------
## Transferring control to Linux (at address 00000000) ...
Linux version 2.4.21-erik (root@sardine.tait.co.nz) (gcc version 3.3) #35 Thu Jul 10 19:39:05 NZST 2003
On node 0 totalpages: 2048
zone(0): 2048 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/ram rw
Decrementer Frequency = 187500000/60
Calibrating delay loop... 49.86 BogoMIPS
Memory: 6196k available (848k kernel code, 344k data, 48k init, 0k highmem)
Dentry cache hash table entries: 1024 (order: 1, 8192 bytes)
Inode cache hash table entries: 512 (order: 0, 4096 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 2048 (order: 1, 8192 bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
CPM UART driver version 0.03
ttyS00 at 0x0280 is a SMC
pty: 2048 Unix98 ptys configured
eth0: FEC ENET Version 0.2, FEC irq 3, MII irq 4, addr 00:24:20:10:18:6a
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 512 bind 1024)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 644k freed
VFS: Mounted root (ext2 filesystem).
Freeing unused kernel memory: 48k init
init started:  BusyBox v0.61.pre (2003.07.10-04:42+0000) multi-caip: RTNETLINK answers: File exists


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
