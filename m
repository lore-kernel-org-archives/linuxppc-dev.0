Message-ID: <3BA231CD.8020600@mvista.com>
Date: Fri, 14 Sep 2001 09:35:25 -0700
From: Matthew Locke <mlocke@mvista.com>
MIME-Version: 1.0
To: Claire Troussier <troussier@digigram.com>
Cc: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Problems with Sandpoint and IDE access
References: <3BA21822.B39B3B0A@digigram.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


you probably are missing /dev/hda .  Try "MAKEDEV hda"  in the /dev
directory.

Claire Troussier wrote:

> Hi,
>
> I am using Montavista 2.4.2_hhl20 with a Sanpoint (8240) board and I am
> trying to add a hard disk on the IDE interface. I include the IDE driver
> in my kernel and I boot using an ethernet board. The driver seems to be
> correctly initialized but when I try to access the hard disk I always
> got the same error message
>
> sh-2.03# fdisk /dev/hda
>
> Unable to open /dev/hda
> sh-2.03#
>
> Any idea ?
>
> Thanks for your help.
>
> Claire
>
> Here are the boot messages
>
> Linux/PPC load:
> Uncompressing Linux...done.
> Now booting the kernel
> Total memory = 16MB; using 0kB for hash table (at 00000000)
> Linux version 2.4.2_hhl20 (claire@claire) (gcc version 2.95.2 19991030
> (2.95.3 p
> rerelease/franzo)) #48 lun sep 10 16:41:47 CEST 2001
> Motorola SPS Sandpoint Test Platform
> Sandpoint port (C) 2000, 2001 MontaVista Software, Inc.
> (source@mvista.com)
> On node 0 totalpages: 4096
> zone(0): 4096 pages.
> zone(1): 0 pages.
> zone(2): 0 pages.
> Kernel command line:
> OpenPIC Version 1.2 (1 CPUs and 24 IRQ sources) at f7fd0000
> time_init: decrementer frequency = 24.997563 MHz
> Calibrating delay loop... 166.29 BogoMIPS
> Memory: 14600k available (968k kernel code, 436k data, 72k init, 0k
> highmem)
> Dentry-cache hash table entries: 2048 (order: 2, 16384 bytes)
> Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
> Page-cache hash table entries: 4096 (order: 2, 16384 bytes)
> Inode-cache hash table entries: 1024 (order: 1, 8192 bytes)
> POSIX conformance testing by UNIFIX
> PCI: Probing PCI hardware
> CI: device 00:11.0 has unknown header type 7f, ignoring.
> Linux NET4.0 for Linux 2.4
> Based upon Swansea University Computer Society NET3.039
> Starting kswapd v1.8
> pty: 256 Unix98 ptys configured
> block: queued sectors max/low 9637kB/3212kB, 64 slots per queue
> Uniform Multi-Platform E-IDE driver Revision: 6.31
> ide: Assuming 33MHz system bus speed for PIO modes; override with
> idebus=xx
> W82C105: IDE controller on PCI bus 00 dev 59
> W82C105: chipset revision 5
> W82C105: 100% native mode on irq 17
>     ide0: BM-DMA at 0xbfffd0-0xbfffd7, BIOS settings: hda:pio, hdb:pio
> SL82C105 command word: 5
> IDE timing: 00000909, resetting to PIO0 timing
>     ide1: BM-DMA at 0xbfffd8-0xbfffdf, BIOS settings: hdc:pio, hdd:pio
> SL82C105 command word: 5
> IDE timing: 000003e4, resetting to PIO0 timing
> Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ
> SERIAL_PCI ena
> bled
> ttyS00 at 0x03f8 (irq = 4) is a 16550A
> ttyS01 at 0x02f8 (irq = 3) is a 16550A
> 8139too Fast Ethernet driver 0.9.13 loaded
> eth0: RealTek RTL8139 Fast Ethernet at 0xbfffff00, 00:50:fc:21:19:ca,
> IRQ 18
> NET4: Linux TCP/IP 1.0 for NET4.0
> IP Protocols: ICMP, UDP, TCP
> IP: routing cache hash table of 512 buckets, 4Kbytes
> TCP: Hash tables configured (established 1024 bind 1024)
> Sending BOOTP requests.... OK
> IP-Config: Got BOOTP answer from 192.168.254.20, my address is
> 192.168.254.203
> NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
> Looking up port of RPC 100003/2 on 192.168.254.20
> Looking up port of RPC 100005/2 on 192.168.254.20
> VFS: Mounted root (nfs filesystem) readonly.
> Freeing unused kernel memory: 72k init 4k openfirmware
> INIT: version 2.77 booting
> INIT: Entering runlevel: 3
> sh-2.03#
>
>
> sh-2.03# cat /proc/pci
> PCI devices found:
>   Bus  0, device   0, function  0:
>     Class 0600: PCI device 1057:0003 (rev 17).
>       Master Capable.  Latency=32.
>       Prefetchable 32 bit memory at 0x0 [0xffffffff].
>       Non-prefetchable 32 bit memory at 0x0 [0xfff].
>   Bus  0, device  11, function  0:
>     Class 0601: PCI device 10ad:0565 (rev 16).
>       IRQ 17.
>   Bus  0, device  11, function  1:
>     Class 0101: PCI device 10ad:0105 (rev 5).
>       IRQ 17.
>       Master Capable.  Latency=128.  Min Gnt=2.Max Lat=40.
>       I/O at 0xbffff8 [0xbfffff].
>       I/O at 0xbffff4 [0xbffff7].
>       I/O at 0xbfffe8 [0xbfffef].
>       I/O at 0xbfffe4 [0xbfffe7].
>       I/O at 0xbfffd0 [0xbfffdf].
>       I/O at 0xbfffc0 [0xbfffcf].
>   Bus  0, device  15, function  0:
>     Class 0200: PCI device 10ec:8139 (rev 16).
>       IRQ 18.
>       Master Capable.  Latency=128.  Min Gnt=32.Max Lat=64.
>       I/O at 0xbffe00 [0xbffeff].
>       Non-prefetchable 32 bit memory at 0xbfffff00 [0xbfffffff].
> sh-2.03#
>
>
> sh-2.03# cat /proc/ioports
> 00000000-0000001f : dma1
> 00000020-0000003f : pic1
> 00000040-0000005f : timer
> 00000080-0000008f : dma page reg
> 000000a0-000000bf : pic2
> 000000c0-000000df : dma2
> 000002f8-000002ff : serial(auto)
> 000003f8-000003ff : serial(auto)
> 00bffe00-00bffeff : PCI device 10ec:8139
>   00bffe00-00bffeff : eth0
> 00bfffc0-00bfffcf : PCI device 10ad:0105
> 00bfffd0-00bfffdf : PCI device 10ad:0105
>   00bfffd0-00bfffd7 : ide0
>   00bfffd8-00bfffdf : ide1
> 00bfffe4-00bfffe7 : PCI device 10ad:0105
> 00bfffe8-00bfffef : PCI device 10ad:0105
> 00bffff4-00bffff7 : PCI device 10ad:0105
> 00bffff8-00bfffff : PCI device 10ad:0105
> sh-2.03#
>
> sh-2.03# ls -l /dev/hda*
> brw-rw----   1 root     disk       3,   0 Sep 10  2001 /dev/hda
> brw-rw----   1 root     disk       3,   1 Sep 10  2001 /dev/hda1
> brw-rw----   1 root     disk       3,  10 Sep 10  2001 /dev/hda10
> brw-rw----   1 root     disk       3,  11 Sep 10  2001 /dev/hda11
> brw-rw----   1 root     disk       3,  12 Sep 10  2001 /dev/hda12
> brw-rw----   1 root     disk       3,  13 Sep 10  2001 /dev/hda13
> brw-rw----   1 root     disk       3,  14 Sep 10  2001 /dev/hda14
> brw-rw----   1 root     disk       3,  15 Sep 10  2001 /dev/hda15
> brw-rw----   1 root     disk       3,  16 Sep 10  2001 /dev/hda16
> brw-rw----   1 root     disk       3,   2 Sep 10  2001 /dev/hda2
> brw-rw----   1 root     disk       3,   3 Sep 10  2001 /dev/hda3
> brw-rw----   1 root     disk       3,   4 Sep 10  2001 /dev/hda4
> brw-rw----   1 root     disk       3,   5 Sep 10  2001 /dev/hda5
> brw-rw----   1 root     disk       3,   6 Sep 10  2001 /dev/hda6
> brw-rw----   1 root     disk       3,   7 Sep 10  2001 /dev/hda7
> brw-rw----   1 root     disk       3,   8 Sep 10  2001 /dev/hda8
> brw-rw----   1 root     disk       3,   9 Sep 10  2001 /dev/hda9
> sh-2.03#
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
