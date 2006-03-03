Return-Path: <pankaj.patil@hp.com>
Received: from ccerelbas01.cce.hp.com (ccerelbas01.cce.hp.com [161.114.21.104])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ccerelbas01.cce.hp.com", Issuer "RSA Data Security,
	Inc." (verified OK)) by ozlabs.org (Postfix) with ESMTP id 272B967A3A
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  4 Mar 2006 05:58:14 +1100 (EST)
Received: from cceexg11.americas.cpqcorp.net (cceexg11.americas.cpqcorp.net
	[16.81.1.59])
	by ccerelbas01.cce.hp.com (Postfix) with ESMTP id E26F5347F7
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  3 Mar 2006 12:58:11 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: INIT:
Date: Fri, 3 Mar 2006 11:58:10 -0700
Message-ID: <9B832BEB407A774AA0520CCFC23221970663EA35@CXOEXC11.AMERICAS.CPQCORP.NET>
From: "Patil, Pankaj P." <Pankaj.Patil@hp.com>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I do have  /dev/console in my file system. In fact , i used ethereal on =
the host to see how far the INIT goes.
I saw all the usual NFS Lookup calls like /lib, /ld-2.3.1.so ..... =
/libc-2.31.so
The last NFS lookup call looks like DH:0xbea72a4a/tty0
There are bunch of read replys after that but no more NFS lookups. Is it =
normal to see a NFS Lookup that looks like 0xbea72a4a/tty0 ??
What should be the next NFS Lookup call?
I did some searching from previous posts but haven't found exactly what =
i am looking for. I am attaching a link to something that looks similar =
to my problem. Just in case, someone's having trouble understanding my =
issue.
http://ozlabs.org/pipermail/linuxppc-embedded/2004-August/015250.html

Thanks
pankaj

-----Original Message-----
From: atul.sabharwal@exgate.tek.com
[mailto:atul.sabharwal@exgate.tek.com]
Sent: Tuesday, February 28, 2006 6:03 PM
To: Patil, Pankaj P.
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: INIT:


Easy answer is do you have /dev/console in your file system.  Glibc
opens
/dev/console and the kernel uses /dev/ttyS0 as specified on the command
line.  There should not be any app calling uart_close as the console
deriver
should be opening it.=20

--
Atul

Hi,
I am running u-boot & linux2.6.12 on a custom ppc board(functional HW).
I can get to the point where u-boot loads the kernel, kernel does all
the initialization,  loads the Root File System over NFS & calls the
Init process.
Next, i am expecting to see a shell prompt. I am not sure where in the
Init process i am failing. I have written my own serial driver(Philips
SC28L194 Quad UART--under development-possible culprit). The printks
work just fine.
All i see is the kernel calling the Init process & after a minute or so
i see uart_close call.
The kernel runs just fine & responds to ping.
What can trigger a uart_close??(tty_release calls release_dev calls
uart_close) I have a JTAG debugger. What's the best way to debug once
Init process is running??



I am attaching a dump of my console:
U-Boot 1.1.3 (Dec 16 2005 - 16:00:23), Build: 0.4.1

SysClock =3D 120Mhz , TClock =3D 120Mhz=20
CPU:   MPC7447A v1.1 @ 960 MHz
CPU bus mode : 60x

DRAM:  SPD Checksum ok!
-- DIMM1 has 2 banks
-- DIMM2 has 0 banks
ECC Initialization of Bank 0: Done
CAS Latency =3D 2 tRP =3D 3 tRAS =3D 6 tRCD=3D3
Total SDRAM memory is 1024 MB
Now running in RAM - U-Boot at: 00fc0000
Remapped Internal SRAM to 0xf2000000
Remapped Flash Card to 0xffc00000
FLASH:  4 MB
Addresses 32M - 0M are saved for the U-Boot usage.
Mem malloc Initialization (32M - 16M): Done

Internal SRAM ECC Initialization: Done
***Phy Reset***
Phy Auto-Negotiation Bit ReEnabled in SW
Net:   , mv_enet1 [PRIME]
Hit any key to stop autoboot:  0=20
Ethernet status port 1: Link up, Full Duplex, Speed 100 Mbps
Using mv_enet1 device
TFTP from server 192.168.1.1; our IP address is 192.168.1.2
Filename 'uImage'.
Load address: 0x400000
Loading:
#################################################################
=20
#################################################################
=20
#################################################################
         ########################
done
Bytes transferred =3D 1119847 (111667 hex)

### Network statistics: ###
--------------------------
 Packets received:              2192
 Packets send:                  2191
 Received bytes:                2347583
 Send bytes:                    100803
## Booting image at 00400000 ...
   Image Name:   Linux-2.6.12
   Created:      2006-02-14   0:37:17 UTC
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1119783 Bytes =3D  1.1 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
## cmdline at 0x007FFF00 ... 0x007FFF98
memstart    =3D 0x00000000
memsize     =3D 0x40000000
flashstart  =3D 0xFFC00000
flashsize   =3D 0x00400000
flashoffset =3D 0x00000000
sramstart   =3D 0xF8000000
sramsize    =3D 0x00400000
bootflags   =3D 0x00000001
intfreq     =3D    960 MHz
busfreq     =3D    120 MHz
ethaddr     =3D 64:00:00:00:00:00
IP addr     =3D 192.168.1.2
baudrate    =3D 115200 bps
tclk        =3D      0 MHz
uboot_ver   =3D 0.4.1a=20
L3 was init =3D 0
Total memory =3D 768MB; using 2048kB for hash table (at c0400000)
Linux version 2.6.12 (root@RHEL40) (gcc version 3.3.3 (DENX ELDK 3.1.1
3.3.3-10)) #154 Mon Feb 13 17:36:35 MST 2006
System Identification:=20
Freescale 74XX port=20
Built 1 zonelists                        =20
Kernel command line: console=3DttyS0,115200 root=3D/dev/nfs rw
nfsroot=3D192.168.1.1:/target/chestnut/rootfs
ip=3D192.168.1.2:192.168.1.1:192.168.1.1:255.255.255.0:DB64xxx:eth0:non
e
PID hash table entries: 4096 (order: 12, 65536 bytes)
time_init: decrementer frequency =3D 30.000000 MHz    =20
Console: colour dummy device 80x25             =20
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes) =20
Memory: 774400k available (1596k kernel code, 556k data, 344k init, 0k
highmem)
Mount-cache hash table entries: 512

NET: Registered protocol family 16=20
PCI: Probing PCI hardware        =20
JFFS2 version 2.2. (C) 2001-2003 Red Hat, Inc.
Generic RTC Driver v1.07                     =20
Serial: SC28L194 driver 4 ports
ttyS0 at MMIO 0x0 (irq =3D 17) is a PHILIPS SC28L194
ttyS1 at MMIO 0x0 (irq =3D 17) is a PHILIPS SC28L194
ttyS2 at MMIO 0x0 (irq =3D 17) is a PHILIPS SC28L194
ttyS3 at MMIO 0x0 (irq =3D 17) is a PHILIPS SC28L194
io scheduler noop registered                     =20
io scheduler anticipatory registered
io scheduler deadline registered   =20
io scheduler cfq registered    =20
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)                                        =20
MV-643xx 10/100/1000 Ethernet Driver
eth0: port 1 with MAC address 00:11:85:da:0b:02
eth0: RX NAPI Enabled                         =20
physmap flash device: 400000 at ffc00000
mice: PS/2 mouse device common for all mice
NET: Registered protocol family 2         =20
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
TCP bind hash table entries: 65536 (order: 6, 262144 bytes)        =20
TCP: Hash tables configured (established 131072 bind 65536)
NET: Registered protocol family 1                         =20
NET: Registered protocol family 17
IP-Config: Complete:             =20
      device=3Deth0, addr=3D192.168.1.2, mask=3D255.255.255.0, =
gw=3D192.168.1.1,
     host=3DDB64xxx, domain=3D, nis-domain=3D(none),                     =
    =20
     bootserver=3D192.168.1.1, rootserver=3D192.168.1.1, rootpath=3D
Looking up port of RPC 100003/2 on 192.168.1.1               =20
Looking up port of RPC 100005/1 on 192.168.1.1
VFS: Mounted root (nfs filesystem).          =20
Freeing unused kernel memory: 344k init


Any help appreceated.
Thanks
pankaj


_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
