From: Jim Thompson <jim@musenki.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15560.58358.727412.510022@zaphod.musenki.com>
Date: Fri, 26 Apr 2002 00:21:58 -0500
To: andrew may <acmay@acmay.homeip.net>
Cc: Nye Liu <nyet@zumanetworks.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: [Ppcboot-users] JFFS2 root
In-Reply-To: <20020425175822.C25207@ecam.san.rr.com>
References: <20020425141425.D22212@ecam.san.rr.com>
	<20020425212455.33DC1FF65@denx.denx.de>
	<15560.39638.379369.974640@zaphod.musenki.com>
	<20020425173121.B25207@ecam.san.rr.com>
	<20020426003653.GB19603@raj>
	<15560.41971.326898.368664@zaphod.musenki.com>
	<20020425175822.C25207@ecam.san.rr.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


(:ppcboot-users removed, seems to be a kernel problem)

andrew may writes:
> On Thu, Apr 25, 2002 at 07:48:51PM -0500, Jim Thompson wrote:

> > /dev/mtdblock1 .vs /dev/mtdblock/1 doesn't make a lot of difference.
> > (I'd tried that.)  Yes, the kernel has devfs (and automounting of
> > same) compiled in.
>
> Do you have just JFFS2 and not JFFS1. Last time I tried it was one or the other
> that you should compile in. Is your mtd stuff up to date? The locking has not
> always been correct.

Just JFFS
build> grep JFFS .config
# CONFIG_JFFS_FS is not set
CONFIG_JFFS2_FS=y
CONFIG_JFFS2_FS_DEBUG=2

> when I try /dev/mtdblock/1 it will really try to read /dev/mtdblock/0

What does this mean?


I've discovered something though if I have the 'ip=' boot arg in
there, I get the previous behavior, without it, I get:

    => setenv bootargs root=/dev/mtdblock1 rw panic=5 S
    => bootm fff40000
    ## Booting image at fff40000 ...
       Image Name:   Musenki kernel 2.4.19pre1
       Image Type:   PowerPC Linux Kernel Image (gzip compressed)
       Data Size:    684718 Bytes = 668 kB = 0 MB
       Load Address: 00000000
       Entry Point:  00000000
       Verifying Checksum ... OK
       Uncompressing Kernel Image ... OK
    Memory BAT mapping: BAT2=32Mb, BAT3=0Mb, residual: 0Mb
    Linux version 2.4.19pre1 (jim@ford) (gcc version 2.95.4 20011002 (Debian prerelease)) #10 Wed Apr 24 23:01:13 CDT 2002
    Musenki M3/M1: See www.musenki.com for details
    On node 0 totalpages: 8192
    zone(0): 8192 pages.
    zone(1): 0 pages.
    zone(2): 0 pages.
    Kernel command line: root=/dev/mtdblock1 rw panic=5 S
    OpenPIC Version 1.2 (1 CPUs and 138 IRQ sources) at fc040000
    time_init: decrementer frequency = 25.000000 MHz
    Calibrating delay loop... 133.12 BogoMIPS
    Memory: 30428k available (1220k kernel code, 484k data, 88k init, 0k highmem)
    Dentry-cache hash table entries: 4096 (order: 3, 32768 bytes)
    Inode-cache hash table entries: 2048 (order: 2, 16384 bytes)
    Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
    Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
    Page-cache hash table entries: 8192 (order: 3, 32768 bytes)
    POSIX conformance testing by UNIFIX
    PCI: Probing PCI hardware
    Linux NET4.0 for Linux 2.4
    Based upon Swansea University Computer Society NET3.039
    Initializing RT netlink socket
    Starting kswapd
    devfs: v1.10 (20020120) Richard Gooch (rgooch@atnf.csiro.au)
    devfs: boot_options: 0x1
    JFFS2 version 2.1. (C) 2001 Red Hat, Inc., designed by Axis Communications AB.
    i2c-core.o: i2c core module
    i2c-proc.o version 2.6.1 (20010825)
    pty: 256 Unix98 ptys configured
    Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
    ttyS00 at 0xfc004500x (irq = 137) is a 16550A
    ttyS01 at 0xfc004600x (irq = 138) is a 16550A
    block: 64 slots per queue, batch=16
    RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
    loop: loaded (max 8 devices)
    Linux Tulip driver version 0.9.15-pre9 (Nov 6, 2001)
    tulip0: Old style EEPROM with no media selection information.
    tulip0:  MII transceiver #1 config 1000 status 782d advertising 01e1.
    eth0: Davicom DM9102/DM9102A rev 49 at 0xfebfff00, EEPROM not present, 00:4C:69:6E:75:79, IRQ 16.
    physmap flash device: 800000 at ff800000
    mtd: Giving out device 0 to Physically mapped flash
    init_musenki_m1_mtd: chip probing count 0
    init_musenki_m1_mtd: bank1, name:Musenki Bank 0, size:8388608bytes
    Musenki M1 flash bank 0: Using static image partition definition
    Creating 3 MTD partitions on "Musenki Bank 0":
    0x00000000-0x00700000 : "jffs2"
    mtd: Giving out device 1 to jffs2
    0x00700000-0x00740000 : "ppcboot"
    mtd: Giving out device 2 to ppcboot
    0x00740000-0x00800000 : "kernel"
    mtd: Giving out device 3 to kernel
    NET4: Linux TCP/IP 1.0 for NET4.0
    IP Protocols: ICMP, UDP, TCP
    IP: routing cache hash table of 512 buckets, 4Kbytes
    TCP: Hash tables configured (established 2048 bind 2048)
    NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
    NET4: Ethernet Bridge 008 for NET4.0
    mtdblock_open
    ok
    mtdblock_open
    mtdblock: read on "jffs2" at 0x400, size 0x400
    mtdblock_release
    ok
    mtdblock_open
    mtdblock_release

(and here we seemingly hang again (my JTAG probe is on the wonk right now..)

Does this sound familiar to anyone?

Nye, what version of MTD/JFFS2 are you running?

Jim


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
