Message-Id: <200201151021.EAA18816@lists.linuxppc.org>
Date: Tue, 15 Jan 2002 18:22:38 +0800
From: =?GB2312?Q?=D7=DE=CC=CE?= <stone@pocketix.com>
To: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: 8240 booting:bootp time out and hd lost interrupt
Mime-Version: 1.0
Content-Type: text/plain;
      charset="GB2312"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello:
  I'm a newer to PowerPC. when i port linux to PowerPC 8240,i met some problem.anyone give me advices will be appreciate.
  i use board sandpoint 3, the cpu board is mpc8240.
  I mark the line i wish you pay attention to.i have two questions: one is why the hdc lost the interrupt. the other is why the bootp time out. i test the host dhcp configuration with win98 as client.
  The dip switch on cpu board is set to : sw2 01111,sw3 11011 (1 means ON)
  BTW,who could tell me every bit of the two dip switch mean? I couldn't find document about it.
  The dip switch on main board is set to: sw1 11111010 ,sw2 11111111.
  The type of main board is "ppceval-sp3 rev x3". the CPU board is
"m98ppmc8240 rev x2" .linux kernel is Mvista Hard Hat Linux 2.0 for
 ppc 82xx. My hard disk type is "Quantum fireball 3.5series 30.0GB".
  the following is bootup message:

       DINK32_KAHLUA >>dl -k
     #>ascii-xfr -svn -l 10 vmlinuz-motolola-sandpoint.srec>/dev/ttyS0
     DINK32_KAHLUA >>go 900000
loaded at:     00900000 009091B8
relocated to:  00800000 008091B8
zimage at:     00906000 00998F41
avail ram:     00400000 00800000

Linux/PPC load:
Uncompressing Linux...done.
Now booting the kernel
Total memory = 32MB; using 0kB for hash table (at 00000000)
Linux version 2.4.2_hhl20 (root@tony) (gcc version 2.95.3 20010315 (release/Mon1Motorola SPS Sandpoint Test Platform
Sandpoint port (C) 2000, 2001 MontaVista Software, Inc. (source@mvista.com)
On node 0 totalpages: 8192
zone(0): 8192 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line:
OpenPIC Version 1.2 (1 CPUs and 24 IRQ sources) at f7fd0000
OpenPIC timer frequency is 100.000000 MHz
time_init: decrementer frequency = 24.752286 MHz
Calibrating delay loop... 131.89 BogoMIPS
Memory: 30596k available (1048k kernel code, 440k data, 88k init, 0k highmem)
Dentry-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 2048 (order: 2, 16384 bytes)
POSIX conformance testing by UNIFIX
PCI: Probing PCI hardware
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd v1.8
pty: 256 Unix98 ptys configured
block: queued sectors max/low 20256kB/6752kB, 64 slots per queue
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
W82C105: IDE controller on PCI bus 00 dev 59
W82C105: chipset revision 5
W82C105: 100% native mode on irq 17
    ide0: BM-DMA at 0xbfffd0-0xbfffd7, BIOS settings: hda:pio, hdb:pio
SL82C105 command word: 5
IDE timing: 00000909, resetting to PIO0 timing
  ide1: BM-DMA at 0xbfffd8-0xbfffdf, BIOS settings: hdc:pio, hdd:pio
SL82C105 command word: 5
IDE timing: 000003e4, resetting to PIO0 timing
hdc: QUANTUM FIREBALLP AS30.0, ATA DISK drive
ide1 at 0xbfffe8-0xbfffef,0xbfffe6 on irq 15
hdc: 58633344 sectors (30020 MB) w/1902KiB Cache, CHS=58168/16/63
/*******************************************************************************
Partition check:
 hdc:hdc: lost interrupt
hdc: lost interrupt
hdc: lost interrupt
hdc: lost interrupt
hdc: lost interrupt
 [PTBL] [3649/255/63] hdc1 <hdc: lost interrupt
hdc: lost interrupt
 hdc5hdc: lost interrupt
hdc: lost interrupt
 hdc6 >
*******************************************************************************/
loop: loaded (max 8 devices)
Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ SERIAL_PCI endttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 2048 bind 2048)
/*******************************************************************************
Sending BOOTP requests.......<6>NETDEV WATCHDOG: eth0: transmit timed out
....<6>NETDEV WATCHDOG: eth0: transmit timed out .. timed out!
********************************************************************************/
IP-Config: No network devices available.
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Root-NFS: No NFS server available, giving up.
VFS: Unable to mount root fs via NFS, trying floppy.
request_module[block-major-2]: Root fs not mounted
VFS: Cannot open root device "" or 02:00
Please append a correct "root=" boot option
Kernel panic: VFS: Unable to mount root fs on 02:00



    and I use tcpdump to listen to the eth0, and receive something like that:

          14:34:27.591370 eth0 B 0.0.0.0.bootpc > 255.255.255.255.bootps: xid:0xc6c3f016 secs:88 [|bootp] (DF)
14:34:27.591925 eth0 > 192.168.10.13.bootps > 255.255.255.255.bootpc: xid:0xc6c3f016 secs:88 Y:192.168.10.100 S:192.168.10.13 ether 0:e0:4c:45:56:af [|bootp] (DF)
14:34:27.595609 eth0 > arp who-has 192.168.10.1 tell 192.168.10.13 (0:e0:4c:3b:f6:ca)
14:34:28.591256 eth0 > arp who-has 192.168.10.1 tell 192.168.10.13 (0:e0:4c:3b:f6:ca)
14:34:29.591256 eth0 > arp who-has 192.168.10.1 tell 192.168.10.13 (0:e0:4c:3b:f6:ca)
14:34:30.591402   lo > 192.168.10.13 > 192.168.10.13: icmp: host 192.168.10.1 unreachable [tos 0xc0]
14:34:30.591402   lo < 192.168.10.13 > 192.168.10.13: icmp: host 192.168.10.1 unreachable [tos 0xc0]
14:34:32.601383 eth0 > arp who-has 192.168.10.1 tell 192.168.10.13 (0:e0:4c:3b:f6:ca)
14:34:33.601256 eth0 > arp who-has 192.168.10.1 tell 192.168.10.13 (0:e0:4c:3b:f6:ca)
14:34:34.601256 eth0 > arp who-has 192.168.10.1 tell 192.168.10.13 (0:e0:4c:3b:f6:ca)
14:34:35.601276   lo > 192.168.10.13 > 192.168.10.13: icmp: host 192.168.10.1 unreachable [tos 0xc0]
14:34:35.601276   lo < 192.168.10.13 > 192.168.10.13: icmp: host 192.168.10.1 unreachable [tos 0xc0]
14:34:37.612096 eth0 > arp who-has 192.168.10.1 tell 192.168.10.13 (0:e0:4c:3b:f6:ca)
14:34:38.611257 eth0 > arp who-has 192.168.10.1 tell 192.168.10.13 (0:e0:4c:3b:f6:ca)
14:34:39.611257 eth0 > arp who-has 192.168.10.1 tell 192.168.10.13 (0:e0:4c:3b:f6:ca)
14:34:40.611278   lo > 192.168.10.13 > 192.168.10.13: icmp: host 192.168.10.1 unreachable [tos 0xc0]
14:34:40.611278   lo < 192.168.10.13 > 192.168.10.13: icmp: host 192.168.10.1 unreachable [tos 0xc0]
14:34:42.621330 eth0 > arp who-has 192.168.10.1 tell 192.168.10.13 (0:e0:4c:3b:f6:ca)
14:34:43.621256 eth0 > arp who-has 192.168.10.1 tell 192.168.10.13 (0:e0:4c:3b:f6:ca)
14:34:44.621256 eth0 > arp who-has 192.168.10.1 tell 192.168.10.13 (0:e0:4c:3b:f6:ca)
14:34:45.621277   lo > 192.168.10.13 > 192.168.10.13: icmp: host 192.168.10.1 unreachable [tos 0xc0]
14:34:45.621277   lo < 192.168.10.13 > 192.168.10.13: icmp: host 192.168.10.1 unreachable [tos 0xc0]
14:34:47.633769 eth0 > arp who-has 192.168.10.1 tell 192.168.10.13 (0:e0:4c:3b:f6:ca)
14:34:48.631263 eth0 > arp who-has 192.168.10.1 tell 192.168.10.13 (0:e0:4c:3b:f6:ca)
14:34:49.631256 eth0 > arp who-has 192.168.10.1 tell 192.168.10.13 (0:e0:4c:3b:f6:ca)
14:34:50.631277   lo > 192.168.10.13 > 192.168.10.13: icmp: host 192.168.10.1 unreachable [tos 0xc0]
14:34:50.631277   lo < 192.168.10.13 > 192.168.10.13: icmp: host 192.168.10.1 unreachable [tos 0xc0]
14:34:52.641343 eth0 > arp who-has 192.168.10.1 tell 192.168.10.13 (0:e0:4c:3b:f6:ca)
14:34:53.641271 eth0 > arp who-has 192.168.10.1 tell 192.168.10.13 (0:e0:4c:3b:f6:ca)
14:34:54.641268 eth0 > arp who-has 192.168.10.1 tell 192.168.10.13 (0:e0:4c:3b:f6:ca)
14:34:55.641289   lo > 192.168.10.13 > 192.168.10.13: icmp: host 192.168.10.1 unreachable [tos 0xc0]
14:34:55.641289   lo < 192.168.10.13 > 192.168.10.13: icmp: host 192.168.10.1 unreachable [tos 0xc0]
14:34:55.711924 eth0 B 0.0.0.0.bootpc > 255.255.255.255.bootps: xid:0xc6c3f016 secs:117 [|bootp] (DF)
14:34:55.712391 eth0 > 192.168.10.13.bootps > 255.255.255.255.bootpc: xid:0xc6c3f016 secs:117 Y:192.168.10.100 S:192.168.10.13 ether 0:e0:4c:45:56:af [|bootp] (DF)
14:35:25.712515 eth0 B 0.0.0.0.bootpc > 255.255.255.255.bootps: xid:0xc6c3f016 secs:147 [|bootp] (DF)
14:35:25.713052 eth0 > 192.168.10.13.bootps > 255.255.255.255.bootpc: xid:0xc6c3f016 secs:147 Y:192.168.10.100 S:192.168.10.13 ether 0:e0:4c:45:56:af [|bootp] (DF)



     It seems that the host ack the target's require, but target did't accept . So the target has no right IP address.

     regards.
																			stone




　　　　　　　　　　　　　　stone@pocketix.com
　　　　　　　　　　　　　　　　　2002-01-15

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
