Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <294FD9D3403A0340BDAC38E48DCEFFDCA751@RES-EXCH>
From: Lokesh Kumar <kumar.lokesh@wrx-us.com>
To: "'Wolfgang Denk'" <wd@denx.de>,
	Lokesh Kumar <kumar.lokesh@wrx-us.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: cramfs mpc8xx 2.4.18 
Date: Fri, 27 Feb 2004 19:03:44 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Sorry gentlemen,
I got stuck with some other issues, but I am back to my problem. Here is
what is happening.

booting image at 00400000 ...
   Image Name:   Linux Kernel
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    554008 Bytes = 541 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
## Current stack ends at 0x01FB9C10 => set upper limit to 0x00800000
## cmdline at 0x007FFF00 ... 0x007FFF39
bd address  = 0x01FB9FC4
memstart    = 0x00000000
memsize     = 0x02000000
flashstart  = 0xF8000000
flashsize   = 0x00800000
flashoffset = 0x00020200
sramstart   = 0x00000000
sramsize    = 0x00000000
immr_base   = 0x80000000
bootflags   = 0x00000001
intfreq     = 49.152 MHz
busfreq     = 49.152 MHz
ethaddr     = 00:50:C2:02:C4:02
IP addr     = 192.4.88.20
baudrate    =   9600 bps
No initrd
## Transferring control to Linux (at address 00000000) ...
Linux version 2.4.18 (root@test) (gcc version 2.95.3 20010315 (release))
#437 Fri Feb 27 19:11:03 EST 2004
On node 0 totalpages: 8192
zone(0): 8192 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/mtdblock1 rootfstype=cramfs console=ttyS0,
9600
Decrementer Frequency = 184320000/60
Calibrating delay loop... 48.94 BogoMIPS
Memory: 30688k available (1052k kernel code, 408k data, 40k init, 0k
highmem)
Dentry-cache hash table entries: 4096 (order: 3, 32768 bytes)
Inode-cache hash table entries: 2048 (order: 2, 16384 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 8192 (order: 3, 32768 bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
CPM UART driver version 0.03
ttyS00 at 0x0280 is a SMC
ttyS01 at 0x0380 is a SMC
ttyS02 at 0x0000 is a SCC
pty: 256 Unix98 ptys configured
block: 64 slots per queue, batch=16
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
eth0: FEC ENET Version 0.2, FEC irq 5, addr 00:50:c2:02:c4:02
PPP generic driver version 2.4.1
PPP Deflate Compression module registered
init_wrx_mtd: chip probing count 0
  Feature/Command Support: CE000000
     - Chip Erase:         unsupported
     - Suspend Erase:      unsupported
     - Suspend Program:    unsupported
     - Legacy Lock/Unlock: unsupported
     - Queued Erase:       unsupported
     - Instant block lock: unsupported
     - Protection Bits:    unsupported
     - Page-mode read:     unsupported
     - Synchronous read:   unsupported
     - Unknown Bit 19:      supported
     - Unknown Bit 1A:      supported
     - Unknown Bit 1B:      supported
     - Unknown Bit 1E:      supported
     - Unknown Bit 1F:      supported
  Supported functions after Suspend: 01
     - Program after Erase Suspend: supported
  Block Status Register Mask: 0100
     - Lock Bit Active:      no
     - Valid Bit Active:     no
     - Unknown Bit 8 Active: yes
  Vcc Logic Supply Optimum Program/Erase Voltage: 0.3 V
init_wrx_mtd: bank1, name:WRXFLASH0, size:8388608bytes
WRX flash0: Using Static image partition definition
Creating 2 MTD partitions on "WRXFLASH0":
0x00000000-0x00040000 : "ppcboot"
mtd: Giving out device 0 to ppcboot
0x00040000-0x007e0000 : "cramfs"
mtd: Giving out device 1 to cramfs
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 2048 bind 2048)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
mtdblock_open
ok
mtdblock_open
mtdblock: read on "cramfs" at 0x0, size 0x1000
mtdblock: read on "cramfs" at 0x1000, size 0x1000
mtdblock: read on "cramfs" at 0x2000, size 0x1000
mtdblock: read on "cramfs" at 0x3000, size 0x1000
mtdblock_release

And after this, I do not get the prompt back, and the target hangs. My
cramfs rootfilesystem has

/bin, /dev, /etc, /sbin, /lib and /usr/sbin

Please help....

Lokesh Kumar

-----Original Message-----
From: Wolfgang Denk [mailto:wd@denx.de]
Sent: Friday, February 13, 2004 3:00 PM
Subject: Re: cramfs mpc8xx 2.4.18

In message <294FD9D3403A0340BDAC38E48DCEFFDCA729@RES-EXCH> you wrote:
>
> I have a custom board running 2.4.18 with initrd. Now, I want to make
> cramfs as root filesystem. When I built cramfs support in the kernel
> and gave it root=/dev/mtdblock1 (where my cramfs in correct endian
> order is stored on flash) rootfstype=cramfs, the kernel hangs. MTD
> support is built in the kernel. If I build cramfs as module, then boot
> my kernel with initrd (ext2) and then mount it (on say /mnt), I can
> read cramfs correctly.

Where does the kernel hang? Which exact boot messages are printed?

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
