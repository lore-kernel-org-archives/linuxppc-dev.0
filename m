Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Issues configuring the network interafce on a 8260 board with multiple eth ports
Date: Tue, 3 Feb 2004 14:45:06 -0000
Message-ID: <DEF39A0710293E489D45B10E06645CBD02842EEF@dub-msx1.spectelcorp.com>
From: "Joao Vicente" <joao.vicente@spectel.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi

I am trying to bring up a second network interface, on a MPC8260 based custom board
If I configure the kernel with only one FCC, it does bring up both the ethernet and IP services.
If I configure the second eth port, by choosing FCC2 on the menuconfig, it configures both eth0 and eth1 properly, but if fails to resolve the IP interfaces.

When I try checking the intefaces with ifconfig I can only see the loopback device.

I have have also noticed that the MAC address selected for the eth1 is an increment from eth0. Does this apply to the default IP address chosen, or do I need to pass it though the kernel cmdline ?

I was also looking for details/examples on the kernel cmdline. All I could find was a brief reference on the kernel folder Documentation/kernel-parameters.txt. Does anybody know of good reference for selecting kernel parameters.

Find below the boot-up sequence that I get when I have both FCC1 and FCC2 eth interfaces enabled.

## cmdline at 0x007FFF00 ... 0x007FFF8D
bd address  = 0x01FB2FB4
memstart    = 0x00000000
memsize     = 0x02000000
flashstart  = 0xE2400000
flashsize   = 0x00400000
flashoffset = 0x00000000
sramstart   = 0x00000000
sramsize    = 0x00000000
immr_base   = 0xF0000000
bootflags   = 0x00000001
vco         =    240 MHz
sccfreq     =     60 MHz
brgfreq     =     15 MHz
intfreq     =    180 MHz
cpmfreq     =    120 MHz
busfreq     =     60 MHz
ethaddr     = 00:D0:9B:00:00:B9
IP addr     = 10.121.10.21
baudrate    = 115200 bps
## Loading RAMDisk Image at e2400000 ...
   Image Name:   RAM Disk
   Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
   Data Size:    1439292 Bytes =  1.4 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
## initrd at 0xE2400040 ... 0xE255F67B (len=1439292=0x15F63C)
   Loading Ramdisk to 01e52000, end 01fb163c ... OK
## Transferring control to Linux (at address 00000000) ...
Memory BAT mapping: BAT2=32Mb, BAT3=0Mb, residual: 0Mb
Linux version 2.4.20 (jvicente@lab00056l.localdomain) (gcc version 2.95.4
20010319 (prerelease/franzo/20011204)) #32 Tue Feb 3 14:05:14 GMT 2004
On node 0 totalpages: 8192
zone(0): 8192 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/ram rw
ip=10.121.10.21:10.121.10.150:10.121.10.254:255.255.255.0:voip_lnx_joao::off
mem=32M console=ttyS3,115200 ramdisk_size=8192k
IP-Config: Parameter #0: `10.121.10.21'
IP-Config: Parameter #1: `10.121.10.150'
IP-Config: Parameter #2: `10.121.10.254'
IP-Config: Parameter #3: `255.255.255.0'
IP-Config: Parameter #4: `voip_lnx_joao'
IP-Config: Parameter #6: `off'
Warning: real time clock seems stuck!
Calibrating delay loop... 119.60 BogoMIPS
Memory: 29172k available (1084k kernel code, 400k data, 52k init, 0k highmem)
Dentry cache hash table entries: 4096 (order: 3, 32768 bytes)
Inode cache hash table entries: 2048 (order: 2, 16384 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 8192 (order: 3, 32768 bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
JFFS version 1.0, (C) 1999, 2000  Axis Communications AB
JFFS2 version 2.1. (C) 2001 Red Hat, Inc., designed by Axis Communications AB.
CPM UART driver version 0.01
ttyS0 on SCC1 at 0x8000, BRG1
ttyS1 on SCC2 at 0x8100, BRG2
ttyS2 on SCC3 at 0x8200, BRG3
ttyS3 on SCC4 at 0x8300, BRG4
pty: 256 Unix98 ptys configured
eth0: FCC1 ENET Version 0.4, 00:D0:9B:00:00:B9
eth0: Phy @ 0x0, type LXT973 (0x00137a10)
eth1: FCC2 ENET Version 0.4, 00:D0:9B:00:00:BA
eth1: Phy @ 0x1, type LXT973 (0x00137a10)
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 2048 bind 2048)
IP-Config: Entered.
eth0: config: auto-negotiation on, 100FDX, 100HDX, 10FDX, 10HDX.
IP-Config: eth0 UP (able=0, xid=00000000)
eth0: status: link up, 10 Mbps Half Duplex, auto-negotiation complete.
eth1: config: auto-negotiation on, 100FDX, 100HDX, 10FDX, 10HDX.
IP-Config: eth1 UP (able=0, xid=00000000)
IP-Config: (REVISIT) ic_myaddr = 10.121.10.21
IP-Config: (REVISIT) root_server_addr = 255.255.255.255
IP-Config: (REVISIT) ic_servaddr = 10.121.10.150
IP-Config: (REVISIT) ic_first_dev->next = c1e50500
IP-Config: Incomplete network configuration information.
IP-Config: Downing eth0
IP-Config: Downing eth1
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
eth1: status: link up, 10 Mbps Half Duplex, auto-negotiation complete.
eth0: status: link down.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 1405k freed
VFS: Mounted root (ext2 filesystem).
Freeing unused kernel memory: 52k init
eth0: status: link up, 10 Mbps Half Duplex, auto-negotiation complete.
INIT: version 2.78 booting
INIT: Entering runlevel: 2
Starting Network

   *********************************************************
   *      Welcome to Linux for Spectel VoIP CPU board      *
   *********************************************************

bash-2.05# ifconfig
lo        Link encap:Local Loopback
          inet addr:127.0.0.1  Mask:255.0.0.0
          UP LOOPBACK RUNNING  MTU:16436  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)


Thanks in advance

Joao Vicente,
Embedded Firmware/Software Engineer.
Spectel.
21 Stillorgan Ind. Park, Dublin 18, Ireland.

visit www.spectel.com

Phone: + 353 1 207 5600, Fax:   + 353 1 295 3740
email:	joao.vicente@spectel.com

Business.Conferencing.Solutions.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
