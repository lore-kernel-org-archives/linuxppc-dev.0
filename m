Message-ID: <3D483468.CB6DAE54@broadcom.com>
Date: Wed, 31 Jul 2002 12:03:04 -0700
From: "James Dougherty" <jfd@broadcom.com>
MIME-Version: 1.0
To: "bhupinder sahran" <bhup_sah@yahoo.com>,
	linuxppc-embedded@lists.linuxppc.org, wd@denx.de, jfd@broadcom.com
Subject: Re: Problems with mount system call -- cannot mount procfs!
References: <20020731033106.39762.qmail@web20705.mail.yahoo.com>
Content-Type: text/plain;
 charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Thanks Bhupi,

I checked out my ppcboot early_init.S and the ppcboot startup files.
In ppcboot-1.1.4/cpu/mpc824x/start.S

#ifndef CONFIG_MUSENKI
	/* Enable and invalidate data cache.
	 */
	mfspr	r3, HID0
	mr	r2, r3
	ori	r3, r3, HID0_DCE | HID0_DCI
	ori	r2, r2, HID0_DCE
	sync
	mtspr	HID0, r3
	mtspr	HID0, r2
	sync

	/* Allocate Initial RAM in data cache.
	 */
	lis	r3, CFG_INIT_RAM_ADDR@h
	ori	r3, r3, CFG_INIT_RAM_ADDR@l
	li	r2, 128
	mtctr	r2
1:
	dcbz	r0, r3
	addi	r3, r3, 32
	bdnz	1b

	/* Lock way0 in data cache.
	 */
	mfspr	r3, 1011
	lis	r2, 0xffff
	ori	r2, r2, 0xff1f
	and	r3, r3, r2
	ori	r3, r3, 0x0080
	sync
	mtspr	1011, r3

#endif /* CONFIG_MUSENKI */


I remove this code with an ifdef:

#if !defined(CONFIG_MUSENKI) && !defined(CONFIG_BMW)

And then rebuilt and boot linux-2.4.19-rc3 (latest rsync from mvista.com yesterday)!
Does the setup code above work on Sandpoint, or another MPC824x system?


					-James

eth0:Broadcom BCM5701 1000Base-T,HALT,POWER DOWN,done - offline.
## Booting image at 00100000 ...
   Image Name:   vmlinux.bin.gz
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    771776 Bytes = 753 kB = 0 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
Memory BAT mapping: BAT2=64Mb, BAT3=0Mb, residual: 0Mb
Linux version 2.4.19-rc3 (jfd@que) (gcc version 2.95.3 20010111 (prerelease/franzo/20010111)) #34 Wed Jul 31 11:49:35 PDT 2002
CPU:82xx: 32 I-Cache Block Size, 32 D-Cache Block Size PVR: 0x810000
PPCBoot Environment: 0xc01af57c
IP PNP: 802.3 Ethernet Address=<0:0:10:18:10:10>
cpu0: MPC8245/KAHLUA-II : BMW Platform : 64MB RAM: BPLD Rev. 6e
NOTICE: mounting root file system via NFS
IP PNP: switch-2: eth0 IP 172.16.40.114/255.255.240.0 gateway 10.16.64.1 server 172.16.40.111
On node 0 totalpages: 16384
zone(0): 16384 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line:
time_init: decrementer frequency = 16.501146 MHz
Calibrating delay loop... 175.71 BogoMIPS
Memory: 62556k available (1376k kernel code, 476k data, 96k init, 0k highmem)
Dentry cache hash table entries: 8192 (order: 4, 65536 bytes)
Inode cache hash table entries: 4096 (order: 3, 32768 bytes)
Mount-cache hash table entries: 1024 (order: 1, 8192 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
POSIX conformance testing by UNIFIX
PCI: Probing PCI hardware
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
devfs: v1.12a (20020514) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
JFFS version 1.0, (C) 1999, 2000  Axis Communications AB
JFFS2 version 2.1. (C) 2001 Red Hat, Inc., designed by Axis Communications AB.
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
Testing ttyS0 (0xf7f51500, 0xf7f51500)...
Testing ttyS1 (0xfc004600, 0xfc004600)...
ttyS00 at 0xf7f51500 (irq = 24) is a ST16650
ttyS01 at 0xfc004600 (irq = 25) is a 16550A
Real Time Clock Driver v1.10e
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Broadcom Gigabit Ethernet Driver bcm5700 ver. 3.0.7 (07/17/02)
eth0: Broadcom BCM5701 found at mem bfff0000, IRQ 1, node addr 000010181010
eth0: Broadcom BCM5701 Integrated Copper transceiver found
eth0: Scatter-gather ON, 64-bit DMA ON, Tx Checksum ON, Rx Checksum ON, 802.1Q VLAN ON
bond0 registered without MII link monitoring, in bonding mode.
NFTL driver: nftlcore.c $Revision: 1.85 $, nftlmount.c $Revision: 1.25 $
rtc: unable to get misc minor
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 4096)
bcm5700: eth0 NIC Link is UP, 100 Mbps half duplex
IP-Config: Gateway not on directly connected network.
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
802.1Q VLAN Support v1.7 Ben Greear <greearb@candelatech.com>
All bugs added by David S. Miller <davem@redhat.com>
Looking up port of RPC 100003/2 on 172.16.40.111
Looking up port of RPC 100005/1 on 172.16.40.111
VFS: Mounted root (nfs filesystem).
Mounted devfs on /dev
Freeing unused kernel memory: 96k init
INIT: version 2.78 booting
Mounting local filesystems...
not mounted anything
Setting up symlinks in /dev...done.
Setting up extra devices in /dev...done.
Starting devfsd...Started device management daemon for /dev
INIT: Entering runlevel: 2
Starting internet superserver: inetd.


Welcome to Linux/PPC
MPC8245/BMW



switch-2 login:



>
> Hi ,
> Disabling the cache in ppcbot will not help because
> linux will again enable in arch/ppc/kernel/head.S.
>
> So u pls disable the cache there & try to run the
> linux.
>
> LEt's ...see
>
> Deep into silicon with linux....
> www.gdatech.com
> Somthing good after beer...........Linux
>
> --- James Dougherty <jfd@broadcom.com> wrote:
> > Hi Bhupi,
> >
> > >
> > > hi ,
> > > By seeing ur kernel log it seems that u r having
> > some
> > > problem with ur SDRAM.
> > >
> > Interesting... I came to this conclusion last week
> > and am now
> > using the same SDRAM settings that VxWorks is using.
> > Then again, Linux is more memory intensive then
> > VxWorks.
> >
> > > Can u try to do complete SDRAM test in ur ppcboot.
> > U
> > > are getting illegal instruction-- sig 4.
> > >
> > How do I set this up?
> >
> > > It may also be cache problem. If ur instruction
> > cache
> > > is not intialized properly.
> > >
> > I am enabling the ICACHE in PPCBoot. Perhaps I
> > should
> > disable this?
> >
> > > So u will have to verify both the things.
> > >
> > Thanks for the pointers. I will verify this...
> >
> > More soon ...
> >
> >                       -James
> >
> > --
> > James F. Dougherty, III
> > Broadcom Corporation
> > jfd@broadcom.com
> > (408) 501-8273
> >
>

--
James F. Dougherty, III
Broadcom Corporation
jfd@broadcom.com
(408) 501-8273


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
