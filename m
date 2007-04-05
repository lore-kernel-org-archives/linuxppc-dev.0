Return-Path: <MBenedict@twacs.com>
Received: from outbound1-blu-R.bigfish.com (outbound-blu.frontbridge.com
	[65.55.251.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 035D6DDE3C
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  6 Apr 2007 05:18:00 +1000 (EST)
Received: from outbound1-blu.bigfish.com (localhost.localdomain [127.0.0.1])
	by outbound1-blu-R.bigfish.com (Postfix) with ESMTP id 0920C128A1DF
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  5 Apr 2007 19:17:57 +0000 (UTC)
Received: from mail15-blu-R.bigfish.com (unknown [10.1.252.3])
	by outbound1-blu.bigfish.com (Postfix) with ESMTP id F112B12E004C
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  5 Apr 2007 19:17:56 +0000 (UTC)
Received: from mail15-blu (localhost.localdomain [127.0.0.1])
	by mail15-blu-R.bigfish.com (Postfix) with ESMTP id 9FCB71BB808C
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  5 Apr 2007 19:17:56 +0000 (UTC)
Received: from mail.twacs.com (unknown [68.89.149.4])
	by mail15-blu.bigfish.com (Postfix) with ESMTP id 3754ACC807A
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  5 Apr 2007 19:17:55 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Unable to boot kernel on MPC8349ITX eval board
Date: Thu, 5 Apr 2007 14:17:35 -0500
Message-ID: <CF7E46FCFF66AD478BB72724345289EC2795B1@twx-exch01.twacs.local>
In-Reply-To: <OFCBEB6783.BEA8A149-ON882572B4.0065E63D-882572B4.0065ED92@selinc.com>
References: <OFCBEB6783.BEA8A149-ON882572B4.0065E63D-882572B4.0065ED92@selinc.com>
From: "Benedict, Michael" <MBenedict@twacs.com>
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

I have a similar problem with Gentoo NFS root.  I wasn't fortunate
enough to get an oops though, just a hang.  I wish I had a fix for you,
but here are some things that have worked for us:

1) init=3D/bin/sh (obviously sub-optimal)
2) rootfs from Freescale
3) rootfs built from buildroot

I wish I had tracked this down further and could be more helpful, but
maybe that is a start or can get you a step further.
	Cheers,
		Michael

-----Original Message-----
From: linuxppc-embedded-bounces+mbenedict=3Dtwacs.com@ozlabs.org
[mailto:linuxppc-embedded-bounces+mbenedict=3Dtwacs.com@ozlabs.org] On
Behalf Of Bruce_Leonard@selinc.com
Sent: Thursday, April 05, 2007 1:33 PM
To: linuxppc-embedded@ozlabs.org
Subject: Unable to boot kernel on MPC8349ITX eval board

Hi,

I'm trying to bring up the 2.6.20.4 kernel on a MPC8349ITX eval board
and not having any success.  The root FS is ubuntu/dapper via NFS.
U-boot is 1.2.0.  I'm not a kernel hacker (though I'm learning :)  ) and
I want to learn, but I don't understand enough about the kernel to
understand what is happening.  There is an engineer in the next room who
is a kernel hacker, but he's not sure what the problem is either.
Following I've put the dump from the boot process and my .config file.
I'm using the default=20

DTS file (./arch/powerpc/boot/dts/mpc8349emitx.dts) from the 2.6.20.4
tree.  Any thoughts/pointers where to look?  Thanks

Bruce


MPC8349E-mITX> run bdlboot2
Speed: 100, half duplex
Using TSEC0 device
TFTP from server 10.202.10.161; our IP address is 10.202.10.165 Filename
'8349.blob'.
Load address: 0x400000
Loading: #
done
Bytes transferred =3D 4050 (fd2 hex)
Speed: 100, half duplex
Using TSEC0 device
TFTP from server 10.202.10.161; our IP address is 10.202.10.165 Filename
'/8349-brucle/uImage'.
Load address: 0x1000000
Loading:
#################################################################
=20
#################################################################
=20
#################################################################
         ################################################
done
Bytes transferred =3D 1239360 (12e940 hex) ## Booting image at 01000000
...
   Image Name:   Linux-2.6.20.4
   Created:      2007-04-05  17:04:52 UTC
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1239296 Bytes =3D  1.2 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
   Booting using flat device tree at 0x400000 Using MPC834x ITX machine
description Linux version 2.6.20.4 (root@bruclenb3.selinc.com) (gcc
version 4.0.3 (Ubuntu 4.0.3-1ubuntu5)) #9 Thu Apr 5 10:04:36 PDT 2007
setup_arch: bootmem
mpc834x_itx_setup_arch()
Found MPC83xx PCI host bridge at 0x00000000e0008500. Firmware bus
number:=20
0->0
Found MPC83xx PCI host bridge at 0x00000000e0008600. Firmware bus
number:=20
1->1
arch: exit
Zone PFN ranges:
  DMA             0 ->    65536
  Normal      65536 ->    65536
early_node_map[1] active PFN ranges
    0:        0 ->    65536
Built 1 zonelists.  Total pages: 65024
Kernel command line: root=3D/dev/nfs rw
nfsroot=3D10.202.10.161:/SEL3500/home/brucle/vobs/bob ip=3Ddhcp
console=3DttyS0,115200 IPIC (128 IRQ sources) at fbffb700 PID hash table
entries: 1024 (order: 10, 4096 bytes)

Using MPC834x ITX machine description
Linux version 2.6.20.4 (root@bruclenb3.selinc.com) (gcc version 4.0.3
(Ubuntu 4.0.3-1ubuntu5)) #9 Thu Apr 5 10:04:36 PDT 2007 Found MPC83xx
PCI host bridge at 0x00000000e0008500. Firmware bus number:=20
0->0
Found MPC83xx PCI host bridge at 0x00000000e0008600. Firmware bus
number:=20
1->1
Zone PFN ranges:
  DMA             0 ->    65536
  Normal      65536 ->    65536
early_node_map[1] active PFN ranges
    0:        0 ->    65536
Built 1 zonelists.  Total pages: 65024
Kernel command line: root=3D/dev/nfs rw
nfsroot=3D10.202.10.161:/SEL3500/home/brucle/vobs/bob ip=3Ddhcp
console=3DttyS0,115200 IPIC (128 IRQ sources) at fbffb700 PID hash table
entries: 1024 (order: 10, 4096 bytes)
Console: colour dummy device 80x25
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 256896k/262144k available (2396k kernel code, 4976k reserved,
112k=20

data, 93k bss, 120k init)
Mount-cache hash table entries: 512
NET: Registered protocol family 16
PCI: Probing PCI hardware
Generic PHY: Registered new driver
SCSI subsystem initialized
NET: Registered protocol family 2
IP route cache hash table entries: 2048 (order: 1, 8192 bytes) TCP
established hash table entries: 8192 (order: 3, 32768 bytes) TCP bind
hash table entries: 4096 (order: 2, 16384 bytes)
TCP: Hash tables configured (established 8192 bind 4096) TCP reno
registered io scheduler noop registered io scheduler anticipatory
registered io scheduler deadline registered io scheduler cfq registered
(default)
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing
disabled
serial8250.0: ttyS0 at MMIO 0xe0004500 (irq =3D 16) is a 16550A
serial8250.0: ttyS1 at MMIO 0xe0004600 (irq =3D 17) is a 16550A Gianfar
MII Bus: probed
eth0: Gianfar Ethernet Controller Version 1.2, 08:00:3e:03:01:10
eth0: Running with NAPI enabled
eth0: 256/256 RX/TX BD ring size
eth1: Gianfar Ethernet Controller Version 1.2, 00:00:00:00:00:00
eth1: Running with NAPI enabled
eth1: 256/256 RX/TX BD ring size
sata_sil 0000:00:10.0: Applying R_ERR on DMA activate FIS errata fix
ata1: SATA max UDMA/100 cmd 0xD100A080 ctl 0xD100A08A bmdma 0xD100A000
irq=20

22
ata2: SATA max UDMA/100 cmd 0xD100A0C0 ctl 0xD100A0CA bmdma 0xD100A008
irq=20

22
ata3: SATA max UDMA/100 cmd 0xD100A280 ctl 0xD100A28A bmdma 0xD100A200
irq=20

22
ata4: SATA max UDMA/100 cmd 0xD100A2C0 ctl 0xD100A2CA bmdma 0xD100A208
irq=20

22
scsi0 : sata_sil
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: ATA-7, max UDMA/133, 321672960 sectors: LBA48 NCQ (depth 0/32)
ata1.00: ata1: dev 0 multi count 0
ata1.00: configured for UDMA/100
scsi1 : sata_sil
ata2: SATA link down (SStatus 0 SControl 310)
scsi2 : sata_sil
ata3: SATA link down (SStatus 0 SControl 310)
scsi3 : sata_sil
ata4: SATA link down (SStatus 0 SControl 310)
scsi 0:0:0:0: Direct-Access     ATA      HDT722516DLA380  V43O PQ: 0
ANSI:=20

5
SCSI device sda: 321672960 512-byte hdwr sectors (164697 MB)
sda: Write Protect is off
SCSI device sda: write cache: enabled, read cache: enabled, doesn't
support DPO or FUA SCSI device sda: 321672960 512-byte hdwr sectors
(164697 MB)
sda: Write Protect is off
SCSI device sda: write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
 sda: sda1
sd 0:0:0:0: Attached scsi disk sda
sd 0:0:0:0: Attached scsi generic sg0 type 0
mice: PS/2 mouse device common for all mice TCP cubic registered
NET: Registered protocol family 1
Sending DHCP requests .<6>PHY: e0024520:1c - Link is Up - 100/Half ., OK
IP-Config: Got DHCP answer from 10.100.0.11, my address is 10.202.10.48
IP-Config: Complete:
      device=3Deth0, addr=3D10.202.10.48, mask=3D255.255.255.0,
gw=3D10.202.10.1,
     host=3D10.202.10.48, domain=3Dad.selinc.com, nis-domain=3D(none),
     bootserver=3D10.100.0.11, rootserver=3D10.202.10.161, rootpath=3D =
Looking
up port of RPC 100003/2 on 10.202.10.161 Looking up port of RPC 100005/1
on 10.202.10.161
VFS: Mounted root (nfs filesystem).
Freeing unused kernel memory: 120k init
 * INIT: version 2.86 booting
[ ok ]rting basic networking...
[ ok ]rting kernel event manager...
 * Loading hardware drivers...        Page fault in user mode=20
within_atomic() =3D 1 mm =3D c0254040
NIP =3D fe741b0  MSR =3D d032
Oops: Weird page fault, sig: 11 [#1]

Modules linked in:
NIP: 0FE741B0 LR: 0FE76464 CTR: 00000000
REGS: c0001f50 TRAP: 0301   Not tainted  (2.6.20.4)
MSR: 0000D032 <EE,PR,ME,IR,DR>  CR: 00000000  XER: 00000000
DAR: 7F9A26C8, DSISR: 20000000
TASK =3D c0656030[865] 'udevd' THREAD: cfb00000
GPR00: 00000019 7F99E6A0 30023290 100155F8 000028D8 0FE76464 00000019
0FF521C0
GPR08: 100155F8 3D407265 FFFFFFD0 00000000 22004442 NIP [0FE741B0]
0xfe741b0 LR [0FE76464] 0xfe76464 Call Trace:
 <0>Kernel panic - not syncing: Fatal exception in interrupt
<0>Rebooting in 180 seconds..



++++++++++++++++++++++++++++++++++++++++++++++++ Config file follows=20
+++++++++++++++++++++++++++++++++++++


#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.20.4
# Thu Apr  5 10:04:17 2007
#
# CONFIG_PPC64 is not set
CONFIG_PPC32=3Dy
CONFIG_PPC_MERGE=3Dy
CONFIG_MMU=3Dy
CONFIG_GENERIC_HARDIRQS=3Dy
CONFIG_IRQ_PER_CPU=3Dy
CONFIG_RWSEM_XCHGADD_ALGORITHM=3Dy
CONFIG_ARCH_HAS_ILOG2_U32=3Dy
CONFIG_GENERIC_HWEIGHT=3Dy
CONFIG_GENERIC_CALIBRATE_DELAY=3Dy
CONFIG_GENERIC_FIND_NEXT_BIT=3Dy
CONFIG_PPC=3Dy
CONFIG_EARLY_PRINTK=3Dy
CONFIG_GENERIC_NVRAM=3Dy
CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=3Dy
CONFIG_ARCH_MAY_HAVE_PC_FDC=3Dy
CONFIG_PPC_OF=3Dy
CONFIG_PPC_UDBG_16550=3Dy
# CONFIG_GENERIC_TBSYNC is not set
CONFIG_AUDIT_ARCH=3Dy
CONFIG_GENERIC_BUG=3Dy
CONFIG_DEFAULT_UIMAGE=3Dy

#
# Processor support
#
# CONFIG_CLASSIC32 is not set
# CONFIG_PPC_82xx is not set
CONFIG_PPC_83xx=3Dy
# CONFIG_PPC_85xx is not set
# CONFIG_PPC_86xx is not set
# CONFIG_40x is not set
# CONFIG_44x is not set
# CONFIG_8xx is not set
# CONFIG_E200 is not set
CONFIG_6xx=3Dy
CONFIG_83xx=3Dy
CONFIG_PPC_FPU=3Dy
# CONFIG_PPC_DCR_NATIVE is not set
# CONFIG_PPC_DCR_MMIO is not set
CONFIG_PPC_STD_MMU=3Dy
CONFIG_PPC_STD_MMU_32=3Dy
# CONFIG_SMP is not set
CONFIG_DEFCONFIG_LIST=3D"/lib/modules/$UNAME_RELEASE/.config"

#
# Code maturity level options
#
# CONFIG_EXPERIMENTAL is not set
CONFIG_BROKEN_ON_SMP=3Dy
CONFIG_INIT_ENV_ARG_LIMIT=3D32

#
# General setup
#
CONFIG_LOCALVERSION=3D""
CONFIG_LOCALVERSION_AUTO=3Dy
CONFIG_SWAP=3Dy
# CONFIG_SYSVIPC is not set
# CONFIG_BSD_PROCESS_ACCT is not set
# CONFIG_TASKSTATS is not set
# CONFIG_UTS_NS is not set
# CONFIG_AUDIT is not set
# CONFIG_IKCONFIG is not set
CONFIG_SYSFS_DEPRECATED=3Dy
# CONFIG_RELAY is not set
CONFIG_INITRAMFS_SOURCE=3D""
CONFIG_SYSCTL=3Dy
# CONFIG_EMBEDDED is not set
CONFIG_SYSCTL_SYSCALL=3Dy
CONFIG_KALLSYMS=3Dy
# CONFIG_KALLSYMS_ALL is not set
# CONFIG_KALLSYMS_EXTRA_PASS is not set
CONFIG_HOTPLUG=3Dy
CONFIG_PRINTK=3Dy
CONFIG_BUG=3Dy
CONFIG_ELF_CORE=3Dy
CONFIG_BASE_FULL=3Dy
CONFIG_FUTEX=3Dy
CONFIG_EPOLL=3Dy
CONFIG_SHMEM=3Dy
CONFIG_SLAB=3Dy
CONFIG_VM_EVENT_COUNTERS=3Dy
CONFIG_RT_MUTEXES=3Dy
# CONFIG_TINY_SHMEM is not set
CONFIG_BASE_SMALL=3D0
# CONFIG_SLOB is not set

#
# Loadable module support
#
CONFIG_MODULES=3Dy
CONFIG_MODULE_UNLOAD=3Dy
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
# CONFIG_KMOD is not set

#
# Block layer
#
CONFIG_BLOCK=3Dy
# CONFIG_LBD is not set
# CONFIG_BLK_DEV_IO_TRACE is not set
# CONFIG_LSF is not set

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=3Dy
CONFIG_IOSCHED_AS=3Dy
CONFIG_IOSCHED_DEADLINE=3Dy
CONFIG_IOSCHED_CFQ=3Dy
# CONFIG_DEFAULT_AS is not set
# CONFIG_DEFAULT_DEADLINE is not set
CONFIG_DEFAULT_CFQ=3Dy
# CONFIG_DEFAULT_NOOP is not set
CONFIG_DEFAULT_IOSCHED=3D"cfq"
CONFIG_PPC_GEN550=3Dy
# CONFIG_WANT_EARLY_SERIAL is not set

#
# Platform support
#
# CONFIG_MPC832x_MDS is not set
# CONFIG_MPC834x_SYS is not set
CONFIG_MPC834x_ITX=3Dy
# CONFIG_MPC8360E_PB is not set
CONFIG_MPC834x=3Dy
# CONFIG_MPIC is not set

#
# Kernel options
#
# CONFIG_HIGHMEM is not set
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=3Dy
CONFIG_HZ=3D1000
CONFIG_PREEMPT_NONE=3Dy
# CONFIG_PREEMPT_VOLUNTARY is not set
# CONFIG_PREEMPT is not set
CONFIG_BINFMT_ELF=3Dy
# CONFIG_BINFMT_MISC is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=3Dy
CONFIG_ARCH_FLATMEM_ENABLE=3Dy
CONFIG_ARCH_POPULATES_NODE_MAP=3Dy
CONFIG_FLATMEM=3Dy
CONFIG_FLAT_NODE_MEM_MAP=3Dy
# CONFIG_SPARSEMEM_STATIC is not set
CONFIG_SPLIT_PTLOCK_CPUS=3D4
# CONFIG_RESOURCES_64BIT is not set
CONFIG_PROC_DEVICETREE=3Dy
# CONFIG_CMDLINE_BOOL is not set
# CONFIG_PM is not set
CONFIG_SECCOMP=3Dy
CONFIG_ISA_DMA_API=3Dy

#
# Bus options
#
CONFIG_GENERIC_ISA_DMA=3Dy
# CONFIG_MPIC_WEIRD is not set
# CONFIG_PPC_I8259 is not set
CONFIG_PPC_INDIRECT_PCI=3Dy
CONFIG_FSL_SOC=3Dy
CONFIG_PCI=3Dy
CONFIG_PCI_DOMAINS=3Dy
# CONFIG_PCIEPORTBUS is not set
# CONFIG_PCI_DEBUG is not set

#
# PCCARD (PCMCIA/CardBus) support
#
# CONFIG_PCCARD is not set

#
# PCI Hotplug Support
#

#
# Advanced setup
#
# CONFIG_ADVANCED_OPTIONS is not set

#
# Default settings for advanced configuration options are used
#
CONFIG_HIGHMEM_START=3D0xfe000000
CONFIG_LOWMEM_SIZE=3D0x30000000
CONFIG_KERNEL_START=3D0xc0000000
CONFIG_TASK_SIZE=3D0x80000000
CONFIG_BOOT_LOAD=3D0x00800000

#
# Networking
#
CONFIG_NET=3Dy

#
# Networking options
#
# CONFIG_NETDEBUG is not set
# CONFIG_PACKET is not set
CONFIG_UNIX=3Dy
CONFIG_XFRM=3Dy
# CONFIG_XFRM_USER is not set
# CONFIG_NET_KEY is not set
CONFIG_INET=3Dy
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_FIB_HASH=3Dy
CONFIG_IP_PNP=3Dy
CONFIG_IP_PNP_DHCP=3Dy
CONFIG_IP_PNP_BOOTP=3Dy
CONFIG_IP_PNP_RARP=3Dy
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_SYN_COOKIES is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
# CONFIG_INET_XFRM_TUNNEL is not set
# CONFIG_INET_TUNNEL is not set
CONFIG_INET_XFRM_MODE_TRANSPORT=3Dy
CONFIG_INET_XFRM_MODE_TUNNEL=3Dy
CONFIG_INET_XFRM_MODE_BEET=3Dy
CONFIG_INET_DIAG=3Dy
CONFIG_INET_TCP_DIAG=3Dy
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_CUBIC=3Dy
CONFIG_DEFAULT_TCP_CONG=3D"cubic"
# CONFIG_IPV6 is not set
# CONFIG_INET6_XFRM_TUNNEL is not set
# CONFIG_INET6_TUNNEL is not set
# CONFIG_NETWORK_SECMARK is not set
# CONFIG_NETFILTER is not set
# CONFIG_BRIDGE is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_HAMRADIO is not set
# CONFIG_IRDA is not set
# CONFIG_BT is not set
# CONFIG_IEEE80211 is not set

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_STANDALONE=3Dy
CONFIG_PREVENT_FIRMWARE_BUILD=3Dy
# CONFIG_FW_LOADER is not set
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_SYS_HYPERVISOR is not set

#
# Connector - unified userspace <-> kernelspace linker
#
# CONFIG_CONNECTOR is not set

#
# Memory Technology Devices (MTD)
#
CONFIG_MTD=3Dy
# CONFIG_MTD_DEBUG is not set
# CONFIG_MTD_CONCAT is not set
# CONFIG_MTD_PARTITIONS is not set

#
# User Modules And Translation Layers
#
# CONFIG_MTD_CHAR is not set
# CONFIG_MTD_BLKDEVS is not set
# CONFIG_MTD_BLOCK is not set
# CONFIG_MTD_BLOCK_RO is not set
# CONFIG_FTL is not set
# CONFIG_NFTL is not set
# CONFIG_INFTL is not set
# CONFIG_RFD_FTL is not set
# CONFIG_SSFDC is not set

#
# RAM/ROM/Flash chip drivers
#
CONFIG_MTD_CFI=3Dy
# CONFIG_MTD_JEDECPROBE is not set
CONFIG_MTD_GEN_PROBE=3Dy
# CONFIG_MTD_CFI_ADV_OPTIONS is not set
CONFIG_MTD_MAP_BANK_WIDTH_1=3Dy
CONFIG_MTD_MAP_BANK_WIDTH_2=3Dy
CONFIG_MTD_MAP_BANK_WIDTH_4=3Dy
# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
# CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
CONFIG_MTD_CFI_I1=3Dy
CONFIG_MTD_CFI_I2=3Dy
# CONFIG_MTD_CFI_I4 is not set
# CONFIG_MTD_CFI_I8 is not set
CONFIG_MTD_CFI_INTELEXT=3Dy
CONFIG_MTD_CFI_AMDSTD=3Dy
CONFIG_MTD_CFI_STAA=3Dy
CONFIG_MTD_CFI_UTIL=3Dy
# CONFIG_MTD_RAM is not set
# CONFIG_MTD_ROM is not set
# CONFIG_MTD_ABSENT is not set
# CONFIG_MTD_OBSOLETE_CHIPS is not set

#
# Mapping drivers for chip access
#
# CONFIG_MTD_COMPLEX_MAPPINGS is not set
# CONFIG_MTD_PHYSMAP is not set
# CONFIG_MTD_PHYSMAP_OF is not set
# CONFIG_MTD_PLATRAM is not set

#
# Self-contained MTD device drivers
#
# CONFIG_MTD_PMC551 is not set
# CONFIG_MTD_SLRAM is not set
# CONFIG_MTD_PHRAM is not set
# CONFIG_MTD_MTDRAM is not set
# CONFIG_MTD_BLOCK2MTD is not set

#
# Disk-On-Chip Device Drivers
#
# CONFIG_MTD_DOC2000 is not set
# CONFIG_MTD_DOC2001 is not set
# CONFIG_MTD_DOC2001PLUS is not set

#
# NAND Flash Device Drivers
#
# CONFIG_MTD_NAND is not set
# CONFIG_MTD_NAND_CAFE is not set

#
# OneNAND Flash Device Drivers
#
# CONFIG_MTD_ONENAND is not set

#
# Parallel port support
#
# CONFIG_PARPORT is not set

#
# Plug and Play support
#

#
# Block devices
#
# CONFIG_BLK_DEV_FD is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_COW_COMMON is not set
# CONFIG_BLK_DEV_LOOP is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SX8 is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_BLK_DEV_INITRD is not set
# CONFIG_CDROM_PKTCDVD is not set
# CONFIG_ATA_OVER_ETH is not set

#
# Misc devices
#
# CONFIG_SGI_IOC4 is not set

#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=3Dy
# CONFIG_BLK_DEV_IDE is not set
# CONFIG_BLK_DEV_HD_ONLY is not set
# CONFIG_BLK_DEV_HD is not set

#
# SCSI device support
#
# CONFIG_RAID_ATTRS is not set
CONFIG_SCSI=3Dy
# CONFIG_SCSI_NETLINK is not set
CONFIG_SCSI_PROC_FS=3Dy

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=3Dy
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
# CONFIG_BLK_DEV_SR is not set
CONFIG_CHR_DEV_SG=3Dy
# CONFIG_CHR_DEV_SCH is not set

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
# CONFIG_SCSI_MULTI_LUN is not set
# CONFIG_SCSI_CONSTANTS is not set
# CONFIG_SCSI_LOGGING is not set
# CONFIG_SCSI_SCAN_ASYNC is not set

#
# SCSI Transports
#
# CONFIG_SCSI_SPI_ATTRS is not set
# CONFIG_SCSI_FC_ATTRS is not set
# CONFIG_SCSI_ISCSI_ATTRS is not set
# CONFIG_SCSI_SAS_ATTRS is not set
# CONFIG_SCSI_SAS_LIBSAS is not set

#
# SCSI low-level drivers
#
# CONFIG_ISCSI_TCP is not set
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_AIC94XX is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ARCMSR is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_MEGARAID_SAS is not set
# CONFIG_SCSI_HPTIOP is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_STEX is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_QLA_FC is not set
# CONFIG_SCSI_QLA_ISCSI is not set
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set
# CONFIG_SCSI_SRP is not set

#
# Serial ATA (prod) and Parallel ATA (experimental) drivers
#
CONFIG_ATA=3Dy
# CONFIG_ATA_NONSTANDARD is not set
CONFIG_SATA_AHCI=3Dy
CONFIG_SATA_SVW=3Dy
CONFIG_ATA_PIIX=3Dy
CONFIG_SATA_NV=3Dy
CONFIG_PDC_ADMA=3Dy
CONFIG_SATA_QSTOR=3Dy
CONFIG_SATA_PROMISE=3Dy
CONFIG_SATA_SIL=3Dy
CONFIG_SATA_SIL24=3Dy
CONFIG_SATA_SIS=3Dy
CONFIG_SATA_ULI=3Dy
CONFIG_SATA_VIA=3Dy
CONFIG_SATA_VITESSE=3Dy
CONFIG_SATA_INTEL_COMBINED=3Dy
CONFIG_PATA_AMD=3Dy
CONFIG_PATA_CS5520=3Dy
CONFIG_PATA_EFAR=3Dy
CONFIG_ATA_GENERIC=3Dy
CONFIG_PATA_HPT3X3=3Dy
CONFIG_PATA_JMICRON=3Dy
CONFIG_PATA_TRIFLEX=3Dy
CONFIG_PATA_MARVELL=3Dy
CONFIG_PATA_MPIIX=3Dy
CONFIG_PATA_NETCELL=3Dy
CONFIG_PATA_RZ1000=3Dy
CONFIG_PATA_PDC2027X=3Dy
CONFIG_PATA_SIL680=3Dy
CONFIG_PATA_VIA=3Dy
CONFIG_PATA_WINBOND=3Dy

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set
# CONFIG_FUSION_SPI is not set
# CONFIG_FUSION_FC is not set
# CONFIG_FUSION_SAS is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set

#
# Macintosh device drivers
#
# CONFIG_MAC_EMUMOUSEBTN is not set
# CONFIG_WINDFARM is not set

#
# Network device support
#
CONFIG_NETDEVICES=3Dy
# CONFIG_DUMMY is not set
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set

#
# ARCnet devices
#
# CONFIG_ARCNET is not set

#
# PHY device support
#
CONFIG_PHYLIB=3Dy

#
# MII PHY device drivers
#
# CONFIG_MARVELL_PHY is not set
# CONFIG_DAVICOM_PHY is not set
# CONFIG_QSEMI_PHY is not set
# CONFIG_LXT_PHY is not set
# CONFIG_CICADA_PHY is not set
# CONFIG_VITESSE_PHY is not set
# CONFIG_SMSC_PHY is not set
# CONFIG_BROADCOM_PHY is not set
# CONFIG_FIXED_PHY is not set

#
# Ethernet (10 or 100Mbit)
#
# CONFIG_NET_ETHERNET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_R8169 is not set
# CONFIG_SIS190 is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
# CONFIG_SK98LIN is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2 is not set
CONFIG_GIANFAR=3Dy
CONFIG_GFAR_NAPI=3Dy
# CONFIG_QLA3XXX is not set

#
# Ethernet (10000 Mbit)
#
# CONFIG_CHELSIO_T1 is not set
# CONFIG_IXGB is not set
# CONFIG_S2IO is not set
# CONFIG_MYRI10GE is not set
# CONFIG_NETXEN_NIC is not set

#
# Token Ring devices
#
# CONFIG_TR is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set
# CONFIG_FDDI is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
# CONFIG_NET_FC is not set
# CONFIG_NETPOLL is not set
# CONFIG_NET_POLL_CONTROLLER is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set

#
# Input device support
#
CONFIG_INPUT=3Dy
# CONFIG_INPUT_FF_MEMLESS is not set

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=3Dy
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=3D1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=3D768
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_TSDEV is not set
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
# CONFIG_INPUT_KEYBOARD is not set
# CONFIG_INPUT_MOUSE is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set

#
# Hardware I/O ports
#
# CONFIG_SERIO is not set
# CONFIG_GAMEPORT is not set

#
# Character devices
#
CONFIG_VT=3Dy
CONFIG_VT_CONSOLE=3Dy
CONFIG_HW_CONSOLE=3Dy
# CONFIG_VT_HW_CONSOLE_BINDING is not set
# CONFIG_SERIAL_NONSTANDARD is not set

#
# Serial drivers
#
CONFIG_SERIAL_8250=3Dy
CONFIG_SERIAL_8250_CONSOLE=3Dy
CONFIG_SERIAL_8250_PCI=3Dy
CONFIG_SERIAL_8250_NR_UARTS=3D4
CONFIG_SERIAL_8250_RUNTIME_UARTS=3D4
# CONFIG_SERIAL_8250_EXTENDED is not set

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=3Dy
CONFIG_SERIAL_CORE_CONSOLE=3Dy
# CONFIG_SERIAL_JSM is not set
CONFIG_UNIX98_PTYS=3Dy
CONFIG_LEGACY_PTYS=3Dy
CONFIG_LEGACY_PTY_COUNT=3D256

#
# IPMI
#
# CONFIG_IPMI_HANDLER is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
CONFIG_HW_RANDOM=3Dy
# CONFIG_NVRAM is not set
# CONFIG_GEN_RTC is not set
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_AGP is not set
# CONFIG_DRM is not set
# CONFIG_RAW_DRIVER is not set

#
# TPM devices
#

#
# I2C support
#
# CONFIG_I2C is not set

#
# SPI support
#
# CONFIG_SPI is not set
# CONFIG_SPI_MASTER is not set

#
# Dallas's 1-wire bus
#
# CONFIG_W1 is not set

#
# Hardware Monitoring support
#
# CONFIG_HWMON is not set
# CONFIG_HWMON_VID is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set

#
# Graphics support
#
# CONFIG_FIRMWARE_EDID is not set
# CONFIG_FB is not set
# CONFIG_FB_IBM_GXT4500 is not set

#
# Console display driver support
#
# CONFIG_VGA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=3Dy
# CONFIG_BACKLIGHT_LCD_SUPPORT is not set

#
# Sound
#
# CONFIG_SOUND is not set

#
# HID Devices
#
# CONFIG_HID is not set

#
# USB support
#
CONFIG_USB_ARCH_HAS_HCD=3Dy
CONFIG_USB_ARCH_HAS_OHCI=3Dy
CONFIG_USB_ARCH_HAS_EHCI=3Dy
# CONFIG_USB is not set

#
# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
#

#
# USB Gadget Support
#
# CONFIG_USB_GADGET is not set

#
# MMC/SD Card support
#
# CONFIG_MMC is not set

#
# LED devices
#
# CONFIG_NEW_LEDS is not set

#
# LED drivers
#

#
# LED Triggers
#

#
# InfiniBand support
#
# CONFIG_INFINIBAND is not set

#
# EDAC - error detection and reporting (RAS) (EXPERIMENTAL)
#

#
# Real Time Clock
#

#
# DMA Engine support
#
# CONFIG_DMA_ENGINE is not set

#
# DMA Clients
#

#
# DMA Devices
#

#
# Virtualization
#

#
# File systems
#
CONFIG_EXT2_FS=3Dy
# CONFIG_EXT2_FS_XATTR is not set
# CONFIG_EXT2_FS_XIP is not set
# CONFIG_EXT3_FS is not set
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
# CONFIG_FS_POSIX_ACL is not set
# CONFIG_XFS_FS is not set
# CONFIG_OCFS2_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_INOTIFY=3Dy
CONFIG_INOTIFY_USER=3Dy
# CONFIG_QUOTA is not set
CONFIG_DNOTIFY=3Dy
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set
# CONFIG_FUSE_FS is not set

#
# CD-ROM/DVD Filesystems
#
# CONFIG_ISO9660_FS is not set
# CONFIG_UDF_FS is not set

#
# DOS/FAT/NT Filesystems
#
# CONFIG_MSDOS_FS is not set
# CONFIG_VFAT_FS is not set
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=3Dy
# CONFIG_PROC_KCORE is not set
CONFIG_PROC_SYSCTL=3Dy
CONFIG_SYSFS=3Dy
CONFIG_TMPFS=3Dy
# CONFIG_TMPFS_POSIX_ACL is not set
# CONFIG_HUGETLB_PAGE is not set
CONFIG_RAMFS=3Dy

#
# Miscellaneous filesystems
#
# CONFIG_HFSPLUS_FS is not set
# CONFIG_JFFS2_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
CONFIG_NFS_FS=3Dy
CONFIG_NFS_V3=3Dy
# CONFIG_NFS_V3_ACL is not set
CONFIG_NFS_DIRECTIO=3Dy
# CONFIG_NFSD is not set
CONFIG_ROOT_NFS=3Dy
CONFIG_LOCKD=3Dy
CONFIG_LOCKD_V4=3Dy
CONFIG_NFS_COMMON=3Dy
CONFIG_SUNRPC=3Dy
# CONFIG_SMB_FS is not set
# CONFIG_CIFS is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=3Dy

#
# Native Language Support
#
# CONFIG_NLS is not set

#
# Library routines
#
CONFIG_BITREVERSE=3Dy
# CONFIG_CRC_CCITT is not set
# CONFIG_CRC16 is not set
CONFIG_CRC32=3Dy
# CONFIG_LIBCRC32C is not set
CONFIG_PLIST=3Dy
CONFIG_IOMAP_COPY=3Dy

#
# Kernel hacking
#
# CONFIG_PRINTK_TIME is not set
CONFIG_ENABLE_MUST_CHECK=3Dy
# CONFIG_MAGIC_SYSRQ is not set
# CONFIG_UNUSED_SYMBOLS is not set
# CONFIG_DEBUG_FS is not set
# CONFIG_HEADERS_CHECK is not set
CONFIG_DEBUG_KERNEL=3Dy
CONFIG_LOG_BUF_SHIFT=3D14
CONFIG_DETECT_SOFTLOCKUP=3Dy
# CONFIG_SCHEDSTATS is not set
# CONFIG_DEBUG_SLAB is not set
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_RT_MUTEX_TESTER is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_RWSEMS is not set
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=3Dy
CONFIG_DEBUG_INFO=3Dy
# CONFIG_DEBUG_VM is not set
# CONFIG_DEBUG_LIST is not set
CONFIG_FORCED_INLINING=3Dy
# CONFIG_RCU_TORTURE_TEST is not set
# CONFIG_DEBUGGER is not set
CONFIG_BDI_SWITCH=3Dy
# CONFIG_BOOTX_TEXT is not set
# CONFIG_SERIAL_TEXT_DEBUG is not set
# CONFIG_PPC_EARLY_DEBUG is not set

#
# Security options
#
# CONFIG_KEYS is not set
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
# CONFIG_CRYPTO is not set

_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
