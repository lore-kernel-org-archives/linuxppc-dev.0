Message-ID: <0B0A39652BB0D411BCCF00508B9512EC08AEBD4E@tx14exm05.ftw.mot.com>
From: Yu Bo-BOYU1 <Bo.Yu@motorola.com>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: 21143 driver question
Date: Tue, 29 Apr 2003 21:35:26 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I finally got the hardhat preview 2.1 linux boot on my 7410+107 custom
board.
Now I am trying to get the network work. The board has a 21143 MAC and one
intel
8-port PHY but the 21143 has no direct MDIO connection with such PHY.
The tulip driver did not complain about the 21143 during boot except I saw
the PHY LED
is blinking like crazy and of course I could not ping the target either.

1. How to disable all MDIO related operation from the driver?  I just want
to configure
the device as MII mode and the PHY should work out of reset. This has been
proven
in our vxWorks based driver code.

2. How to correctly configure target ip address ? Is "ip=192.168.0.100"
enough ?
I saw something like "gw=255.255.255.255" in init log but I really don't
care gateway. All 1s look odd.

Thanks.

Bo





Linux/PPC load: console=ttyS0,9600 console=tty0 root=/dev/ram
ip=192.168.0.100
Uncompressing Linux...done.
Now booting the kernel
Memory BAT mapping: BAT2=128Mb, BAT3=0Mb, residual: 0Mb
Total memory = 128MB; using 256kB for hash table (at c0180000)
Linux version 2.4.17_mvl21 (root@ibm-t30) (gcc version 2.95.3 20010315
(release/
MontaVista)) #152 Tue Apr 29 20:34:01 CDT 2003
Host bridge init okay
Motorola SPS Sandpoint Test Platform
Sandpoint port (C) 2000, 2001 MontaVista Software, Inc. (source@mvista.com)
On node 0 totalpages: 32768
zone(0): 32768 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: console=ttyS0,9600 console=tty0 root=/dev/ram
ip=192.168.0.
100
OpenPIC Version 1.2 (1 CPUs and 26 IRQ sources) at fdfd0000
time_init: decrementer frequency = 1.000000 MHz
Calibrating delay loop... 31.84 BogoMIPS
Memory: 126680k available (984k kernel code, 392k data, 72k init, 0k
highmem)
Dentry-cache hash table entries: 16384 (order: 5, 131072 bytes)
Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
Mount-cache hash table entries: 2048 (order: 2, 16384 bytes)
Buffer-cache hash table entries: 8192 (order: 3, 32768 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
POSIX conformance testing by UNIFIX
PCI: Probing PCI hardware
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Disabling the Out Of Memory Killer
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ
SERIAL_PCI en
abled
ttyS00 at 0xfdfce000 (irq = 16) is a TI16750
block: 128 slots per queue, batch=32
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
Linux Tulip driver version 0.9.15-pre9 (Nov 6, 2001)
tulip0: Old style EEPROM with no media selection information.
eth0: Digital DS21143 Tulip rev 65 at 0xbfff80, EEPROM not present,
00:4C:69:6E:
75:79, IRQ 20.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 1024 buckets, 8Kbytes
TCP: Hash tables configured (established 8192 bind 8192)
IP-Config: Guessing netmask 255.255.255.0
IP-Config: Complete:
      device=eth0, addr=192.168.0.100, mask=255.255.255.0,
gw=255.255.255.255,
     host=192.168.0.100, domain=, nis-domain=(none),
     bootserver=255.255.255.255, rootserver=255.255.255.255, rootpath=
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 494k freed
VFS: Mounted root (ext2 filesystem).
Freeing unused kernel memory: 72k init
done open console...
bash#
bash# ping
init: ping: command not found
bash#
bash#
bash#


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
