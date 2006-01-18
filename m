Return-Path: <grant.likely@secretlab.ca>
Received: from outbound-mail-33.bluehost.com (outbound-mail-33.bluehost.com
	[70.96.188.153]) by ozlabs.org (Postfix) with SMTP id 7AE6B689E2
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 19 Jan 2006 07:47:56 +1100 (EST)
Message-ID: <43CEA971.6050409@secretlab.ca>
Date: Wed, 18 Jan 2006 13:47:45 -0700
From: Grant Likely <grant.likely@secretlab.ca>
MIME-Version: 1.0
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: inconsistent gdbserver behaviour on Virtex-4
Content-Type: multipart/mixed; boundary="------------020108000501080405070402"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------020108000501080405070402
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I need some help;

I'm seeing odd inconsistent behaviour when debugging userspace on a 
Virtex-4 (don't yet know if it's a gdbserver or kernel issue).

Here's the scenario:

- tested on kernel versions: 2.6.15, 2.6.16-rc1  both w/ ml403 patches
- tested with gdb versions 6.1, 6.3 & 6.4
- root file system contains: busybox-1.01, glibc-2.3.5, gdbserver
- gcc version: 3.4.4 compiled with crosstool-0.38
- BDI *not* attached, and CONFIG_BDI_SWITCH is *not set*

simple hello.c compiled for the target.  Program loops 20 times over 
some printf's and simple math.

On target, I start the program with:
$ gdbserver 192.168.0.37:2345 ./hello
Process ./hello created; pid = 268
Listening on port 2345

On the host, I connect gdb and set a breakpoint at main(), and at two 
places in the loop.

Whenever I continue (c), I see one of the following behaviours (randomly 
it seems):

1. gdb stops exactly where it started from.  ie. no code gets executed,
2. continue behaves properly, and execution stops at the next breakpoint, or
3. the program runs to completion, and no other breakpoints get hit. 
program exits normally

When I do a single instruction step (si), I see either:
1. the pc does not move, or
2. the program runs freely until the next breakpoint.

I've attached a gdb log with 'set debug remote 1' turned on.  It looks 
to me that the kernel single step support is still busted on my board. 
It also seems to be that gdb single steps off of the previous breakpoint 
before reestablishing all the breakpoints and letting the process run 
again.  Therefore, if single step is busted, then it makes sense that 
continue is busted to.

Any help would be appreciated.

Thanks,
g.





-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
(403) 663-0761

--------------020108000501080405070402
Content-Type: text/x-log;
 name="gda.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="gda.log"

U-Boot 1.1.3 (Oct 20 2005 - 16:57:02)

CPU:   8560, Version: 2.0, (0x80700020)
Core:  E500, Version: 2.0, (0x80200020)
Clock Configuration:
       CPU: 660 MHz, CCB: 264 MHz,
       DDR: 132 MHz, LBC:  33 MHz
L1:    D-cache 32 kB enabled
       I-cache 32 kB enabled
Board: GDA 04SB006
I2C:   ready
DRAM:      DDR: 256 MB
FLASH:  8 MB
L2 cache 256KB: enabled
In:    serial
Out:   serial
Err:   serial
Net:   TSEC1 ETHERNET: PHY is Marvell 88E1011S (1410c67)
FCC3 ETHERNET, TSEC1 ETHERNET
=> printenv

bootdelay=5
baudrate=38400
loads_echo=1
bootargs=root=/dev/mtdblock1 mtdparts=phys:1536K(kernel),6272K(JFFS2),128K(env),256K(u-boot)ro ip=192.168.0.26:192.168.0.101::255.255.255.0::eth0 rootfstype=jffs2
flashboot=setenv bootargs root=/dev/mtdblock1 mtdparts=phys:1536K(kernel),6272K(JFFS2),128K(env),256K(u-boot)ro ip=$ipaddr:$serverip:$gatewayip:$netmask:$hostname:eth0 rootfstype=jffs2; bootm ff800000
netboot=tftp 200000 gda/uImage; setenv bootargs nfsroot=/nfsroot/gda rw ip=$ipaddr:$serverip:$gatewayip:$netmask:$hostname:eth0:off  mtdparts=phys:1536K(kernel),6272K(JFFS2),128K(env),256K(u-boot)ro; bootm 200000
ethaddr=00:01:af:07:9b:8a
eth1addr=00:01:af:07:9b:8b
filesize=11139e
fileaddr=200000
gatewayip=192.168.0.1
netmask=255.255.255.0
ipaddr=192.168.0.26
serverip=192.168.0.102
stdin=serial
stdout=serial
stderr=serial
ethact=FCC3 ETHERNET

Environment size: 851/8188 bytes
=> run flashboot

## Booting image at ff800000 ...
   Image Name:   Linux-2.6.12
   Created:      2005-11-23  15:02:05 UTC
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1119070 Bytes =  1.1 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
PQ3/GDA8560 board support by Arabella

Memory CAM mapping: CAM0=256Mb, CAM1=0Mb, CAM2=0Mb residual: 0Mb

Linux version 2.6.12 (root@ellas) (gcc version 3.3.2) #289 Wed Nov 23 17:02:01 IST 2005

GDA8560 setup arch

Built 1 zonelists

Kernel command line: root=/dev/mtdblock1 mtdparts=phys:1536K(kernel),6272K(JFFS2),128K(env),256K(u-boot)ro ip=192.168.0.26:192.168.0.102:192.168.0.1:255.255.255.0::eth0 rootfstype=jffs2

GDA8560 init IRQ. NR_IRQS=108

OpenPIC Version 1.2 (1 CPUs and 44 IRQ sources) at ff740000

CPM_IRQ_OFFSET = 0 NR_CPM_INTS = 64

PID hash table entries: 2048 (order: 11, 32768 bytes)

GDA8560 calibrate decrementer. FREQ=264000000, tb_ticks_per_jiffy=33000

Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)

Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)

Memory: 257152k available (1772k kernel code, 612k data, 96k init, 0k highmem)

Mount-cache hash table entries: 512

NET: Registered protocol family 16

GDA8560 init

PCI: Probing PCI hardware

JFFS2 version 2.2. (C) 2001-2003 Red Hat, Inc.

Generic RTC Driver v1.07

GPIO: Init

io scheduler noop registered

io scheduler anticipatory registered

io scheduler deadline registered

io scheduler cfq registered

RAMDISK driver initialized: 16 RAM disks of 32768K size 1024 blocksize

loop: loaded (max 8 devices)

eth0: Gianfar Ethernet Controller Version 1.1, 00:01:af:07:9b:8a 

eth0: Running with NAPI enabled

eth0: 256/256 RX/TX BD ring size

Flash physmap: 0x800000 bytes at 0xFF800000, mapped to 0xD1080000

phys: Found 1 x16 devices at 0x0 in 16-bit bank

 Intel/Sharp Extended Query Table at 0x0031

Using buffer write method

cfi_cmdset_0001: Erase suspend on write enabled

4 cmdlinepart partitions found on MTD device phys

Creating 4 MTD partitions on "phys":

0x00000000-0x00180000 : "kernel"

0x00180000-0x007a0000 : "JFFS2"

0x007a0000-0x007c0000 : "env"

0x007c0000-0x00800000 : "u-boot"

i2c /dev entries driver

I2C bus support for MPC82xx, MPC85xx by Arabella Software

SPI bus support for MPC82xx,MPC85xx by Arabella Software

MPC8xxx I2C driver by Arabella Software

MPC8xxx SPI driver by Arabella Software

Serial: pqsxc_uart driver init

MPC FCC Ethernet driver

devsoc_xcc_create c07c0000

Created eth1

NET: Registered protocol family 2

IP: routing cache hash table of 2048 buckets, 16Kbytes

TCP established hash table entries: 16384 (order: 5, 131072 bytes)

TCP bind hash table entries: 16384 (order: 4, 65536 bytes)

TCP: Hash tables configured (established 16384 bind 16384)

NET: Registered protocol family 1

NET: Registered protocol family 17

eth0: PHY is Marvell 88E1101 (1410c67)

IP-Config: Complete:

      device=eth0, addr=192.168.0.26, mask=255.255.255.0, gw=192.168.0.1,

     host=192.168.0.26, domain=, nis-domain=(none),

     bootserver=192.168.0.102, rootserver=192.168.0.102, rootpath=

VFS: Mounted root (jffs2 filesystem) readonly.

Freeing unused kernel memory: 96k init


init started:  BusyBox v1.1.0-pre1 (2005.11.21-12:45+0000) multi-call binary
Mounting a tmpfs over /dev...done.
Creating initial device nodes...done.
Mounting local filesystems...
Setting up IP spoofing protection: rp_filter.
Configuring network interfaces...done.
Starting internet superserver: inetd.
eth0: Full Duplex

eth0: Speed 100BT

eth0: Link is up


192.168.0.26 login: root
Password: 
login[311]: root login  on `tts/0'




BusyBox v1.1.0-pre1 (2005.11.21-12:45+0000) Built-in shell (ash)
Enter 'help' for a list of built-in commands.

~ # ping 192.168.0.102
PING 192.168.0.102 (192.168.0.102): 56 data bytes
64 bytes from 192.168.0.102: icmp_seq=0 ttl=64 time=3.1 ms
64 bytes from 192.168.0.102: icmp_seq=1 ttl=64 time=1.2 ms
64 bytes from 192.168.0.102: icmp_seq=2 ttl=64 time=1.1 ms
64 bytes from 192.168.0.102: icmp_seq=3 ttl=64 time=1.1 ms

--- 192.168.0.102 ping statistics ---
4 packets transmitted, 4 packets received, 0% packet loss
round-trip min/avg/max = 1.1/1.6/3.1 ms
~ # ifconfig eth1 192.168.1.26 up
eth1: OPEN

BD rings initialised, RBASE=7D8220, TBASE=7D8420

~ # ping 192.168.0.102
PING 192.168.0.102 (192.168.0.102): 56 data bytes
64 bytes from 192.168.0.102: icmp_seq=0 ttl=64 time=3.0 ms
64 bytes from 192.168.0.102: icmp_seq=1 ttl=64 time=1.1 ms
64 bytes from 192.168.0.102: icmp_seq=2 ttl=64 time=1.1 ms
64 bytes from 192.168.0.102: icmp_seq=3 ttl=64 time=1.1 ms
64 bytes from 192.168.0.102: icmp_seq=4 ttl=64 time=1.1 ms
64 bytes from 192.168.0.102: icmp_seq=5 ttl=64 time=1.1 ms

--- 192.168.0.102 ping statistics ---
6 packets transmitted, 6 packets received, 0% packet loss
round-trip min/avg/max = 1.1/1.4/3.0 ms
~ # /sb
~ # /sbin/[Jifco[10D
~ # /sbin/ifconfig [J
eth0      Link encap:Ethernet  HWaddr 00:01:AF:07:9B:8A  
          inet addr:192.168.0.26  Bcast:192.168.0.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:346 errors:0 dropped:0 overruns:0 frame:0
          TX packets:14 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000 
          RX bytes:107354 (104.8 KiB)  TX bytes:1148 (1.1 KiB)
          Base address:0x4000 

eth1      Link encap:Ethernet  HWaddr 00:01:AF:07:9B:8B  
          inet addr:192.168.1.26  Bcast:192.168.1.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000 
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)

lo        Link encap:Local Loopback  
          inet addr:127.0.0.1  Mask:255.0.0.0
          UP LOOPBACK RUNNING  MTU:16436  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0 
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)

~ # eth0: Link is down


~ # ping 192.168.1.102
PING 192.168.1.102 (192.168.1.102): 56 data bytes

--- 192.168.1.102 ping statistics ---
15 packets transmitted, 0 packets received, 100% packet loss
~ # /sbin/ifconfig
eth0      Link encap:Ethernet  HWaddr 00:01:AF:07:9B:8A  
          inet addr:192.168.0.26  Bcast:192.168.0.255  Mask:255.255.255.0
          UP BROADCAST MULTICAST  MTU:1500  Metric:1
          RX packets:347 errors:0 dropped:0 overruns:0 frame:0
          TX packets:14 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000 
          RX bytes:107520 (105.0 KiB)  TX bytes:1148 (1.1 KiB)
          Base address:0x4000 

eth1      Link encap:Ethernet  HWaddr 00:01:AF:07:9B:8B  
          inet addr:192.168.1.26  Bcast:192.168.1.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:14 errors:0 dropped:0 overruns:0 frame:0
          TX packets:15 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000 
          RX bytes:4528 (4.4 KiB)  TX bytes:630 (630.0 B)

lo        Link encap:Local Loopback  
          inet addr:127.0.0.1  Mask:255.0.0.0
          UP LOOPBACK RUNNING  MTU:16436  Metric:1
          RX packets:15 errors:0 dropped:0 overruns:0 frame:0
          TX packets:15 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0 
          RX bytes:1680 (1.6 KiB)  TX bytes:1680 (1.6 KiB)

~ # ifconfig eth0 192.168.2.26
~ # eth0: Full Duplex

eth0: Speed 100BT

eth0: Link is up


~ # 
~ # ping 192.168.2.102[J
PING 192.168.2.102 (192.168.2.102): 56 data bytes
64 bytes from 192.168.2.102: icmp_seq=0 ttl=64 time=3.0 ms
64 bytes from 192.168.2.102: icmp_seq=1 ttl=64 time=1.1 ms
64 bytes from 192.168.2.102: icmp_seq=2 ttl=64 time=1.1 ms

--- 192.168.2.102 ping statistics ---
3 packets transmitted, 3 packets received, 0% packet loss
round-trip min/avg/max = 1.1/1.7/3.0 ms

--------------020108000501080405070402--
