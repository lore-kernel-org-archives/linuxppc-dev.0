Return-Path: <rober@opnet.com.tw>
Received: from opnet2.opnet.com.tw (unknown [210.243.240.244])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AF7296802A
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 24 Aug 2005 12:58:28 +1000 (EST)
Received: from [10.0.14.26] (h248-210-243-240.opnet.com.tw [210.243.240.248]
	(may be forged))
	by opnet2.opnet.com.tw (8.13.3/8.13.1) with ESMTP id j7OAqnax031993
	for <linuxppc-embedded@ozlabs.org>; Wed, 24 Aug 2005 10:52:51 GMT
	(envelope-from rober@opnet.com.tw)
From: =?UTF-8?Q?=E5=BE=90=E5=B0=8F=E5=A8=81=E7=9A=84EMAIL?=
	<rober@opnet.com.tw>
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain; charset=Big5
Date: Wed, 24 Aug 2005 10:58:14 +0800
Message-Id: <1124852294.11078.8.camel@banana>
Mime-Version: 1.0
Subject: An old problem ...about linux mount rootfs with nfs
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi All:

    I used u-boot-1.1.3 and 2.4.25 linux on my custom MPC852T board, I
can't mount /opt/eldk/ppc_8xx as rootfs.

   I used SCC4 (10M Ethernet) for download port.I also try to change to
FEC (100M) as download port, but still fail.I want to know the problem
is cause by u-boot or linux kernel config.
 
Boot 1.0.0 (Aug 24 2005 - 10:00:37)

CPU:   MPC852TxxZPnn at 100 MHz: 4 kB I-Cache 4 kB D-Cache FEC present
DRAM:  32 MB
FLASH:  8 MB

In:    serial
Out:   serial
Err:   serial
Net:   SCC ETHERNET [PRIME]
PCMCIA:   No Card found

Hit any key to stop autoboot:  0
=> setenv hostname banana
=> setenv bootargs root=/dev/nfs rw nfsroot=$(serverip):$(rootpath) ip=
$(ipaddr):$(serverip):$(gatewayip):$(netmask):$(hostname)::off
=> printenv
bootcmd=bootm 40040000 40100000
bootdelay=3
baudrate=115200
loads_echo=1
ethprime=SCC ETHERNET
ipaddr=10.0.14.110
serverip=10.0.14.26
netmask=255.255.0.0
preboot=echo;
netdev=eth0
nfsargs=setenv bootargs root=/dev/nfs rw nfsroot=$(serverip):$(rootpath)
ramargs=setenv bootargs root=/dev/ram rw
addip=setenv bootargs $(bootargs) ip=$(ipaddr):$(serverip):$(gatewayip):
$(netmask):$(hostname):$(netdev):off panic=1
flash_nfs=run nfsargs addip;bootm $(kernel_addr)
flash_self=run ramargs addip;bootm $(kernel_addr) $(ramdisk_addr)
net_nfs=tftp 200000 $(bootfile);run nfsargs addip;bootm
rootpath=/opt/eldk/ppc_8xx
bootfile=/tftpboot/uImage
kernel_addr=40040000
ramdisk_addr=40100000
ethaddr=00:01:02:B4:36:56
stdin=serial
stdout=serial
stderr=serial
ethact=SCC ETHERNET
bootcount=9
hostname=banana
bootargs=root=/dev/nfs rw nfsroot=10.0.14.26:/opt/eldk/ppc_8xx
ip=10.0.14.110:10.0.14.26::255.255.0.0:banana::off

Environment size: 907/16379 bytes

=> bootm 40040000
## Booting image at 40040000 ...
   Image Name:   Linux-2.4.25-rthal5
   Created:      2005-08-22   3:20:52 UTC
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    724462 Bytes = 707.5 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
Linux version 2.4.25-rthal5 (root@banana) (gcc version 3.3.3 (DENX ELDK
3.1.1 3.3.3-9)) #17 д@ 8ды 22 11:15:26 CST 2005
On node 0 totalpages: 8192
zone(0): 8192 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/nfs rw
nfsroot=10.0.14.26:/opt/eldk/ppc_8xx
ip=10.0.14.110:10.0.14.26::255.255.0.0:banana::off
Decrementer Frequency = 375000000/60
Calibrating delay loop... 99.73 BogoMIPS
Memory: 30692k available (1264k kernel code, 360k data, 52k init, 0k
highmem)
Dentry cache hash table entries: 4096 (order: 3, 32768 bytes)
Inode cache hash table entries: 2048 (order: 2, 16384 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 8192 (order: 3, 32768 bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
CPM UART driver version 0.04
ttyS0 at 0x0280 is on SMC1 using BRG1
eth0: CPM ENET Version 0.2 on SCC4, 00:01:02:b4:36:56
eth1: FEC ENET Version 0.3, FEC irq 9, MII irq 12, addr
00:01:02:b4:36:57
RAMDISK driver initialized: 16 RAM disks of 20480K size 1024 blocksize
loop: loaded (max 8 devices)
PPP generic driver version 2.4.2
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 2048 bind 4096)
ip_conntrack version 2.1 (256 buckets, 2048 max) - 292 bytes per
conntrack
ip_tables: (C) 2000-2002 Netfilter core team
ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>.
http://snowman.net/projects/ipt_recent/
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
NET4: Ethernet Bridge 008 for NET4.0
VFS: Cannot open root device "nfs" or 00:ff
Please append a correct "root=" boot option
Kernel panic: VFS: Unable to mount root fs on 00:ff
