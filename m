Message-ID: <000801c3354e$18401540$11a2a2c8@scomguo>
From: "yong_guo" <yong_guo@scomcenter.com>
To: <Christophe.LINDHEIMER@fr.thalesgroup.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
References: <D96E2AFA0DF3D211B139009027454948034CBDFF@helios.gnv.tcc.thomson-csf.com>
Subject: Re: how to do:root filesystem on flash?
Date: Wed, 18 Jun 2003 11:59:56 +0800
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hi Christophe,
    I do just as your sugguestions, and all seems ok, but when i cp the
filesystem image to /dev/mtdx using "cp jffs2.imge /dev/mtd2",  he tell me
"cp: cannot create regular file `/dev/mtd2': No such device", i am confused!
     I use "more /proc/mtd", it displays:
    dev:    size   erasesize  name
    mtd0: 00020000 00010000 "ppcboot"
    mtd1: 000a0000 00010000 "kernel"
    mtd2: 00140000 00010000 "filesystem"

    (the mtd2 looks so small^_^, but now i only want test whether it's can
work)

    The follow is the informations at linux start time:
=>bootm 0x100000
## Booting image at 00100000 ...
   Image Name:   Linux-2.4.4
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    575632 Bytes = 562.1 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
Linux version 2.4.4 (root@linux-guo) (gcc version 2.95.3 20010111
(prerelease/f3
On node 0 totalpages: 8192
zone(0): 8192 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/nfs rw
nfsroot=200.162.162.239:/opt/fel8xx-2.0/tf
Decrementer Frequency: 3125000
Warning: real time clock seems stuck!
Calibrating delay loop... 49.76 BogoMIPS
Memory: 30580k available (1116k kernel code, 424k data, 52k init, 0k
highmem)
Dentry-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 2048 (order: 2, 16384 bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd v1.8
CPM UART driver version 0.03
ttyS0 on SMC1 at 0x0280, BRG1
pty: 256 Unix98 ptys configured
block: queued sectors max/low 20224kB/6741kB, 64 slots per queue
eth0: FEC ENET Version 0.2, FEC irq 9, MII irq 12, addr 08:00:3e:26:9d:5b
devfs: v0.102 (20000622) Richard Gooch (rgooch@atnf.csiro.au)
devfs: devfs_debug: 0x0
devfs: boot_options: 0x2
JFFS version 1.0, (C) 1999, 2000  Axis Communications AB
JFFS2 version 2.1. (C) 2001 Red Hat, Inc., designed by Axis Communications
AB.
init_tqm_mtd: chip probing count 0
Number of erase regions: 4
Primary Vendor Command Set: 0002 (AMD/Fujitsu Standard)
Primary Algorithm Table at 0040
Alternative Vendor Command Set: 0000 (None)
No Alternate Algorithm Table
Vcc Minimum: 2.7 V
Vcc Maximum: 3.6 V
No Vpp line
Typical byte/word write timeout: 16 ?
Maximum byte/word write timeout: 512 ?
Full buffer write not supported
Typical block erase timeout: 1024 ?
Maximum block erase timeout: 16384 ?
Chip erase not supported
Device size: 0x200000 bytes (2 MiB)
Flash Device Interface description: 0x0002
  - supports x8 and x16 via BYTE# with asynchronous interface
Max. bytes in buffer write: 0x1
Number of Erase Block Regions: 4
  Erase Region #0: BlockSize 0x4000 bytes, 1 blocks
  Erase Region #1: BlockSize 0x2000 bytes, 2 blocks
  Erase Region #2: BlockSize 0x8000 bytes, 1 blocks
  Erase Region #3: BlockSize 0x10000 bytes, 31 blocks
 Amd/Fujitsu Extended Query Table v1.0 at 0x0040
TQM8xxL Bank 0: JEDEC Device ID is 0xC4. Assuming broken CFI table.
TQM8xxL Bank 0: Swapping erase regions for broken CFI table.
number of JEDEC chips: 1
0: offset=0x0,size=0x10000,blocks=31
1: offset=0x1f0000,size=0x8000,blocks=1
2: offset=0x1f8000,size=0x2000,blocks=2
3: offset=0x1fc000,size=0x4000,blocks=1
init_tqm_mtd: bank1, name:TQM8xxL Bank 0, size:2097152bytes
TQM flash bank 0: Using static image partition definition
Creating 3 MTD partitions on "TQM8xxL Bank 0":
0x00000000-0x00020000 : "ppcboot"
mtd: Giving out device 0 to ppcboot
0x00020000-0x000c0000 : "kernel"
mtd: Giving out device 1 to kernel
0x000c0000-0x00200000 : "filesystem"
mtd: Giving out device 2 to filesystem
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 2048 bind 2048)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Looking up port of RPC 100003/2 on 200.162.162.239
Looking up port of RPC 100005/2 on 200.162.162.239
VFS: Mounted root (nfs filesystem).
Freeing unused kernel memory: 52k init
INIT: version 2.78 booting
                Welcome to Scom Linux 2.0 (Summer)
                Press 'I' to enter interactive startup.
Mounting proc filesystem:  [  OK  ]
Configuring kernel parameters:  [  OK  ]
Activating swap partitions:  [  OK  ]
Setting hostname summer:  [  OK  ]
INIT: Entering runlevel: 3
Entering non-interactive startup
Starting xinetd: [  OK  ]

Scom Linux 2.0 (Summer)
Kernel 2.4.4 on an MPC8xx
summer login: root

Is it correctly?

Thank you!

----- Original Message -----
From: <Christophe.LINDHEIMER@fr.thalesgroup.com>
Sent: Friday, June 13, 2003 4:19 PM
Subject: RE: RE :how to do:root filesystem on flash?

> > > I,
> > > 1 : Create a cramfs filesystem with the right endianess from your
> > > nfs filesystem using mkcramfs. Burn it into the flash( at the
> > > start of the flash).
> >
> > Is it must be burned from the start of the flash? My u-boot bin code
> > is burned at the start of the flash.
>
> No it is not necessary to burn your fs at the beginning of the flash.
> But if you don't, you must use partitions. First select the option
> to use partitions in the kernel. Then give a look in sources of
> /drivers/mtd/... to see how to declare your own partition for your
> custom board. ( there are somes files for custom boards that you will
> give you ideas...) I had to change the config.in to add my own board.
> Then you will have
> /dev/mtdblock/0 mapping UBoot.
> &
> /dev/mtdblock/1 mapping your fs.
>
> So you will have to use
> root=/dev/mtdblock/1
>
> > > 2 : In your kernel config set the "root=" option to :
> > > "/dev/mtdblock0"
> >
> > In my system, the flash is registered as /dev/flasha, should i pass
> > the parameter "root=/dev/flasha" to kernel?
>
> ?
> I don't know.
> Selecting MTD in the kernel config gave me /dev/mtdblock/x...
>
> > > Enable Flash MTDBlock support and the right options like CFI,...
> > > Set up the start of the flash and its length
> > > Enable Cramfs in filesystem
> > > Disable NFS as root filesystem.
> > >
> > > Rebuild your kernel and flash it.
> > > Reboot the board en enjoy.
> > >
> > > PS : This question was already a 100 times answered. Search in
> > > the mailing list before asking such a question. Or maybe a better
> > > idea : One may build a FAQ or a list of Howtos on such common
> > > questions.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
