Subject: MPC8266 kernel hang
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Tue, 6 Jan 2004 16:20:05 -0600
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B06DA30@ismail.innsys.innovsys.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi

I have a problem on a MPC8266 with 512MB or RAM
If I boot Linux (2.4.21rc1) with the full amount of memory, it hangs
right after initializing kswapd
If I reduce the amount of memory (either by using a 256MB stick or
adding mem=0x1e000000 to the boot args) the kernel boots normally

Non working log:
Memory BAT mapping: BAT2=256Mb, BAT3=128Mb, residual: 368Mb
Linux version 2.4.21-rc1 (runet@ernie.innovsys.com) (gcc version 2.95.4
20010319 (prerelease/franzo/20011204)) #10 Tue Jan 6 14:12:1
7 EST 2004
On node 0 totalpages: 126976
zone(0): 126976 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: console=ttyS0,115200 root=/dev/nfs rw
ip=172.23.11.121:172.23.14.39::255.255.248.0:ngap:eth0:none
mem=0x1F00000
0
Warning: real time clock seems stuck!
Calibrating delay loop... 160.15 BogoMIPS
Memory: 500456k available (1016k kernel code, 392k data, 56k init, 0k
highmem)
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd


U-Boot 1.0.0 (Jan  6 2004 - 13:50:53)

MPC8260 Reset Status: Check Stop, External Soft, External Hard

***************************************
Working log:
CPU2 => setenv bootargs console=ttyS0,$(baudrate) root=/dev/nfs rw
ip=$(ipaddr):$(serverip):$(gatewayip):$(netmask):$(hostname):eth0
:none mem=0x1E000000; tftp 100000 $(linuximage); bootm 100000
TFTP from server 172.23.14.39; our IP address is 172.23.11.121
Filename 'uImage'.
Load address: 0x100000
Loading:
#################################################################
         #############################################
done
Bytes transferred = 558602 (8860a hex)
## Booting image at 00100000 ...
   Image Name:   Linux Kernel Image
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    558538 Bytes = 545.4 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
Memory BAT mapping: BAT2=256Mb, BAT3=128Mb, residual: 352Mb
Linux version 2.4.21-rc1 (runet@ernie.innovsys.com) (gcc version 2.95.4
20010319 (prerelease/franzo/20011204)) #10 Tue Jan 6 14:12:1
7 EST 2004
On node 0 totalpages: 122880
zone(0): 122880 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: console=ttyS0,115200 root=/dev/nfs rw
ip=172.23.11.121:172.23.14.39::255.255.248.0:ngap:eth0:none
mem=0x1E00000
0
Warning: real time clock seems stuck!
Calibrating delay loop... 160.15 BogoMIPS
Memory: 484264k available (1016k kernel code, 392k data, 56k init, 0k
highmem)
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
CPM UART driver version 0.01
ttyS0 on SMC1 at 0x0000, BRG1
ttyS1 on SCC1 at 0x8000, BRG2
ttyS2 on SCC2 at 0x8100, BRG3
pty: 256 Unix98 ptys configured
eth0: FCC ENET Version 0.3, 00:30:d7:40:01:03
eth1: FCC ENET Version 0.3, 00:30:d7:20:01:03
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
IP-Config: Complete:
      device=eth0, addr=172.23.11.121, mask=255.255.248.0,
gw=255.255.255.255,
     host=ngap, domain=, nis-domain=(none),
     bootserver=172.23.14.39, rootserver=172.23.14.39, rootpath=
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Looking up port of RPC 100003/2 on 172.23.14.39
Looking up port of RPC 100005/1 on 172.23.14.39
VFS: Mounted root (nfs filesystem).
Freeing unused kernel memory: 56k init
INIT: version 2.78 booting
                Welcome to DENX Embedded Linux Environment
                Press 'I' to enter interactive startup.
Mounting proc filesystem:  [  OK  ]
Configuring kernel parameters:  [  OK  ]
Cannot access the Hardware Clock via any known method.
Use the --debug option to see the details of our search for an access
method.
Setting clock : Wed Dec 31 19:00:05 EST 1969 [  OK  ]
Activating swap partitions:  [  OK  ]
Setting hostname ngap:  [  OK  ]
can't link lock file /etc/mtab~: No such file or directory (use -n flag
to override)
Finding module dependencies:  /lib/modules/2.4.21-rc1/misc/atm8260: No
such file or directory
[  OK  ]
Checking filesystems
[  OK  ]
Mounting local filesystems:  [FAILED]
Enabling swap space:  [  OK  ]
INIT: Entering runlevel: 3
Entering non-interactive startup
Starting system logger: [  OK  ]
Starting kernel logger: [  OK  ]
Starting xinetd: [  OK  ]

ngap login:



Rune Torgersen
System Developer
Innovative Systems LLC
1000 Innovative Drive
Mitchell, SD 57301
Ph: 605-995-6120
www.innovsys.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
