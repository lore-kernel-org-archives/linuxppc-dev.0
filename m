Return-Path: <edjubenville@adelphia.net>
Received: from mta3.adelphia.net (mta3.adelphia.net [68.168.78.181])
	by ozlabs.org (Postfix) with ESMTP id 3239867B74
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 26 Jul 2006 02:45:46 +1000 (EST)
Received: from EJ1 ([70.37.70.76]) by mta10.adelphia.net
	(InterMail vM.6.01.05.02 201-2131-123-102-20050715) with SMTP
	id <20060725162733.UNWI22971.mta10.adelphia.net@EJ1>
	for <linuxppc-embedded@ozlabs.org>; Tue, 25 Jul 2006 12:27:33 -0400
From: "Edward Jubenville" <edjubenville@adelphia.net>
To: <linuxppc-embedded@ozlabs.org>
Subject: Slow boot with NFS, server not responding
Date: Tue, 25 Jul 2006 09:27:31 -0700
Message-ID: <GPECLCIGPLHEOMGPMCPAOEIIDNAA.edjubenville@adelphia.net>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_002A_01C6AFCC.8E1C8220"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------=_NextPart_000_002A_01C6AFCC.8E1C8220
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

I am having trouble booting the kernel with a root file system over NFS.
Once the kernel has mounted the file system, it cycles through this pair of
messages, endlessly:

	nfs: server 192.168.0.39 not responding, still trying
	nfs: server 192.168.0.39 OK

I can't figure out if this is a configuration problem or a hardware problem
with our new board.  Booting in EXTREMELY slow, but manages to make some
progress.  At first, I thought that I had an NFS server configuration or
firewall problem.  But eventually, I discovered that the kernel had some
success mounting the root file system because I started seeing messages from
the init scripts.  Neither the BDI2000 or u-boot had any problem using the
network hardware, so I suspect something must be misconfigured in the
kernel.  While these messages are appearing, I can ping the board without
any dropped packets.

The board is modeled after the Freescale Lite5200 (IceCube), but uses an
MPC5200B processor.  The development environment is ELDK 3.1.1 with the
ELDK's CVS development tree of Linux 2.4.25.

Here is the console log during kernel startup...
I've also attached our kernel .config file.

****************************************
==> bootm 0xff100000
bootm 0xff100000
## Booting image at ff100000 ...
   Image Name:   Linux PPC MPC5200 2.4
   Created:      2006-07-19  22:31:09 UTC
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    884063 Bytes = 863.3 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
Memory BAT mapping: BAT2=64Mb, BAT3=0Mb, residual: 0Mb
Linux version 2.4.25 (ejubenville@cvs) (gcc version 3.3.3 (DENX ELDK 3.1.1
3.3.3-9)) #3 Wed Jul 19 15:30:56 PDT 2006
On node 0 totalpages: 16384
zone(0): 16384 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/nfs rw nfsroot=192.168.0.39:/opt/eldk/ppc_6xx
ip=192.168.0.73:192.168.0.39:192.168.0.3:255.255.255.0:mmt1::off
Calibrating delay loop... 307.20 BogoMIPS
Memory: 62176k available (1496k kernel code, 504k data, 76k init, 0k
highmem)
Dentry cache hash table entries: 8192 (order: 4, 65536 bytes)
Inode cache hash table entries: 4096 (order: 3, 32768 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
POSIX conformance testing by UNIFIX
PCI: Probing PCI hardware
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Journalled Block Device driver loaded
devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)
devfs: devfs_debug: 0x0
devfs: boot_options: 0x1
JFFS2 version 2.2. (NAND) (C) 2001-2003 Red Hat, Inc.
pty: 256 Unix98 ptys configured
devfs_register(cua): could not append to parent, err: -17
devfs_register(cua): could not append to parent, err: -17
ttyS0 on PSC1
ttyS1 on PSC2
ttyS2 on PSC3
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
loop: loaded (max 8 devices)
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Port Config is: 0x11050004
ipb=132MHz, set clock period to 7
GPIO config: 11050004
ATA invalid: 01000000
ATA hostcnf: 03000000
ATA pio1   : 100a0a00
ATA pio2   : 02040600
XLB Arb cnf: 0000a366
mpc5xxx_ide: Setting up IDE interface ide0...
ATA DMA task: 5
Probing IDE interface ide0...
hda: SanDisk SDCFB-4096, CFA DISK drive
hda: Setting MDMA 2 timings
hda: Setting PIO 4 timings
ide0 at 0xf0003a60-0xf0003a67,0xf0003a5c on irq 45
hda: attached ide-disk driver.
hda: 8005536 sectors (4099 MB) w/1KiB Cache, CHS=7942/16/63, DMA
Partition check:
 /dev/ide/host0/bus0/target0/lun0:<7>Unhandled interrupt 1a, disabled
 [PTBL] [992/128/63] p1
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 8192)
eth0: Phy @ 0x0, type LXT971 (0x001378e2)
IP-Config: Complete:
      device=eth0, addr=192.168.0.73, mask=255.255.255.0, gw=192.168.0.3,
     host=mmt1, domain=, nis-domain=(none),
     bootserver=192.168.0.39, rootserver=192.168.0.39, rootpath=
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Looking up port of RPC 100003/2 on 192.168.0.39
Looking up port of RPC 100005/1 on 192.168.0.39
VFS: Mounted root (nfs filesystem).
Mounted devfs on /dev
Freeing unused kernel memory: 76k init
nfs: server 192.168.0.39 not responding, still trying
nfs: server 192.168.0.39 OK
****************************************

The "not responding" and "OK" keep repeating at a slow rate,
eventually interspersed with messages from the init process.

Any help would be appreciated.  Thanks.

Ed Jubenville

------=_NextPart_000_002A_01C6AFCC.8E1C8220
Content-Type: text/plain;
	name="config.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="config.txt"

#=0A=
# Automatically generated by make menuconfig: don't edit=0A=
#=0A=
# CONFIG_UID16 is not set=0A=
# CONFIG_RWSEM_GENERIC_SPINLOCK is not set=0A=
CONFIG_RWSEM_XCHGADD_ALGORITHM=3Dy=0A=
CONFIG_HAVE_DEC_LOCK=3Dy=0A=
=0A=
#=0A=
# Code maturity level options=0A=
#=0A=
CONFIG_EXPERIMENTAL=3Dy=0A=
CONFIG_ADVANCED_OPTIONS=3Dy=0A=
=0A=
#=0A=
# Loadable module support=0A=
#=0A=
CONFIG_MODULES=3Dy=0A=
# CONFIG_MODVERSIONS is not set=0A=
# CONFIG_KMOD is not set=0A=
=0A=
#=0A=
# Platform support=0A=
#=0A=
CONFIG_PPC=3Dy=0A=
CONFIG_PPC32=3Dy=0A=
CONFIG_6xx=3Dy=0A=
# CONFIG_40x is not set=0A=
# CONFIG_44x is not set=0A=
# CONFIG_E500 is not set=0A=
# CONFIG_POWER3 is not set=0A=
# CONFIG_POWER4 is not set=0A=
# CONFIG_8xx is not set=0A=
# CONFIG_8260 is not set=0A=
# CONFIG_83xx is not set=0A=
CONFIG_PPC_STD_MMU=3Dy=0A=
# CONFIG_ALL_PPC is not set=0A=
# CONFIG_APUS is not set=0A=
# CONFIG_INKA4X0 is not set=0A=
# CONFIG_WILLOW is not set=0A=
# CONFIG_TOP5200 is not set=0A=
# CONFIG_CPCI690 is not set=0A=
# CONFIG_PCORE is not set=0A=
# CONFIG_POWERPMC250 is not set=0A=
# CONFIG_PPMC260 is not set=0A=
# CONFIG_EV64260 is not set=0A=
# CONFIG_SPRUCE is not set=0A=
# CONFIG_HMI1001 is not set=0A=
# CONFIG_PP01 is not set=0A=
# CONFIG_CPC45 is not set=0A=
# CONFIG_CU824 is not set=0A=
# CONFIG_PM520 is not set=0A=
# CONFIG_MCC200 is not set=0A=
# CONFIG_PUMA_A is not set=0A=
# CONFIG_ALASKA is not set=0A=
# CONFIG_GLACIER is not set=0A=
CONFIG_ICECUBE=3Dy=0A=
# CONFIG_LITE5200B is not set=0A=
# CONFIG_HXEB100 is not set=0A=
# CONFIG_LOPEC is not set=0A=
# CONFIG_MCPN765 is not set=0A=
# CONFIG_MVME5100 is not set=0A=
# CONFIG_PPLUS is not set=0A=
# CONFIG_PRPMC750 is not set=0A=
# CONFIG_PRPMC800 is not set=0A=
# CONFIG_SANDPOINT is not set=0A=
# CONFIG_P3G4 is not set=0A=
# CONFIG_ADIR is not set=0A=
# CONFIG_K2 is not set=0A=
# CONFIG_PAL4 is not set=0A=
# CONFIG_SL8245 is not set=0A=
# CONFIG_SMMACO4 is not set=0A=
# CONFIG_GEMINI is not set=0A=
# CONFIG_TQM5200 is not set=0A=
# CONFIG_O2DNT is not set=0A=
# CONFIG_SORCERY is not set=0A=
CONFIG_PPC_5xxx=3Dy=0A=
# CONFIG_SMP is not set=0A=
# CONFIG_ALTIVEC is not set=0A=
# CONFIG_TAU is not set=0A=
CONFIG_PPC_ISATIMER=3Dy=0A=
# CONFIG_MPC5100 is not set=0A=
CONFIG_MPC5200=3Dy=0A=
CONFIG_PPC_5xxx_PSC_CONSOLE_BAUD=3D115200=0A=
CONFIG_UBOOT=3Dy=0A=
CONFIG_PPC_5xxx_PSC_CONSOLE_PORT=3D0=0A=
=0A=
#=0A=
# General setup=0A=
#=0A=
# CONFIG_BIGPHYS_AREA is not set=0A=
# CONFIG_HIGHMEM is not set=0A=
# CONFIG_LOWMEM_SIZE_BOOL is not set=0A=
# CONFIG_KERNEL_START_BOOL is not set=0A=
# CONFIG_TASK_SIZE_BOOL is not set=0A=
CONFIG_HIGHMEM_START=3D0xfe000000=0A=
CONFIG_LOWMEM_SIZE=3D0x30000000=0A=
CONFIG_KERNEL_START=3D0xc0000000=0A=
CONFIG_TASK_SIZE=3D0x80000000=0A=
# CONFIG_ISA is not set=0A=
# CONFIG_EISA is not set=0A=
# CONFIG_SBUS is not set=0A=
# CONFIG_MCA is not set=0A=
CONFIG_PCI=3Dy=0A=
CONFIG_NET=3Dy=0A=
CONFIG_SYSCTL=3Dy=0A=
CONFIG_SYSVIPC=3Dy=0A=
# CONFIG_BSD_PROCESS_ACCT is not set=0A=
CONFIG_KCORE_ELF=3Dy=0A=
CONFIG_BINFMT_ELF=3Dy=0A=
CONFIG_KERNEL_ELF=3Dy=0A=
# CONFIG_BINFMT_MISC is not set=0A=
# CONFIG_OOM_KILLER is not set=0A=
# CONFIG_PCI_NAMES is not set=0A=
# CONFIG_HOTPLUG is not set=0A=
# CONFIG_PCMCIA is not set=0A=
=0A=
#=0A=
# Parallel port support=0A=
#=0A=
# CONFIG_PARPORT is not set=0A=
# CONFIG_GEN_RTC is not set=0A=
CONFIG_PPC_RTC=3Dy=0A=
CONFIG_CMDLINE_BOOL=3Dy=0A=
CONFIG_CMDLINE=3D"ip=3Doff"=0A=
=0A=
#=0A=
# Embedded options=0A=
#=0A=
# CONFIG_EMBEDDED is not set=0A=
=0A=
#=0A=
# Memory Technology Devices (MTD)=0A=
#=0A=
CONFIG_MTD=3Dy=0A=
# CONFIG_MTD_DEBUG is not set=0A=
CONFIG_MTD_PARTITIONS=3Dy=0A=
# CONFIG_MTD_CONCAT is not set=0A=
# CONFIG_MTD_REDBOOT_PARTS is not set=0A=
# CONFIG_MTD_CMDLINE_PARTS is not set=0A=
CONFIG_MTD_CHAR=3Dy=0A=
CONFIG_MTD_BLOCK=3Dy=0A=
# CONFIG_FTL is not set=0A=
# CONFIG_NFTL is not set=0A=
# CONFIG_INFTL is not set=0A=
=0A=
#=0A=
# RAM/ROM/Flash chip drivers=0A=
#=0A=
CONFIG_MTD_CFI=3Dy=0A=
# CONFIG_MTD_JEDECPROBE is not set=0A=
CONFIG_MTD_GEN_PROBE=3Dy=0A=
# CONFIG_MTD_CFI_ADV_OPTIONS is not set=0A=
CONFIG_MTD_MAP_BANK_WIDTH_1=3Dy=0A=
CONFIG_MTD_MAP_BANK_WIDTH_2=3Dy=0A=
CONFIG_MTD_MAP_BANK_WIDTH_4=3Dy=0A=
CONFIG_MTD_CFI_I1=3Dy=0A=
CONFIG_MTD_CFI_I2=3Dy=0A=
# CONFIG_MTD_CFI_INTELEXT is not set=0A=
CONFIG_MTD_CFI_AMDSTD=3Dy=0A=
# CONFIG_MTD_CFI_STAA is not set=0A=
CONFIG_MTD_CFI_UTIL=3Dy=0A=
# CONFIG_MTD_RAM is not set=0A=
# CONFIG_MTD_ROM is not set=0A=
# CONFIG_MTD_ABSENT is not set=0A=
# CONFIG_MTD_OBSOLETE_CHIPS is not set=0A=
# CONFIG_MTD_AMDSTD is not set=0A=
# CONFIG_MTD_SHARP is not set=0A=
# CONFIG_MTD_JEDEC is not set=0A=
=0A=
#=0A=
# Mapping drivers for chip access=0A=
#=0A=
CONFIG_MTD_COMPLEX_MAPPINGS=3Dy=0A=
# CONFIG_MTD_PHYSMAP is not set=0A=
# CONFIG_MTD_PUMA_A is not set=0A=
# CONFIG_MTD_CHESTNUT is not set=0A=
# CONFIG_MTD_K2 is not set=0A=
# CONFIG_MTD_HXEB100 is not set=0A=
# CONFIG_MTD_PPMC260 is not set=0A=
# CONFIG_MTD_CU824 is not set=0A=
# CONFIG_MTD_CPC45 is not set=0A=
# CONFIG_MTD_HMI1001 is not set=0A=
# CONFIG_MTD_ICECUBE is not set=0A=
# CONFIG_MTD_ICECUBE is not set=0A=
# CONFIG_MTD_INKA4X0 is not set=0A=
# CONFIG_MTD_O2DNT is not set=0A=
# CONFIG_MTD_P3G4 is not set=0A=
# CONFIG_MTD_PP01 is not set=0A=
# CONFIG_MTD_MCC200 is not set=0A=
# CONFIG_MTD_PM520 is not set=0A=
# CONFIG_MTD_SL8245 is not set=0A=
# CONFIG_MTD_SMMACO4 is not set=0A=
# CONFIG_MTD_SORCERY is not set=0A=
# CONFIG_MTD_TQM5200 is not set=0A=
# CONFIG_MTD_PCI is not set=0A=
# CONFIG_MTD_PCMCIA is not set=0A=
=0A=
#=0A=
# Self-contained MTD device drivers=0A=
#=0A=
# CONFIG_MTD_PMC551 is not set=0A=
# CONFIG_MTD_SLRAM is not set=0A=
# CONFIG_MTD_MTDRAM is not set=0A=
# CONFIG_MTD_BLKMTD is not set=0A=
# CONFIG_MTD_DOC2000 is not set=0A=
# CONFIG_MTD_DOC2001 is not set=0A=
# CONFIG_MTD_DOC2001PLUS is not set=0A=
# CONFIG_MTD_DOCPROBE is not set=0A=
# CONFIG_MTD_DOCECC is not set=0A=
=0A=
#=0A=
# NAND Flash Device Drivers=0A=
#=0A=
# CONFIG_MTD_NAND is not set=0A=
# CONFIG_MTD_NAND_DISKONCHIP is not set=0A=
# CONFIG_MTD_NAND_NANDSIM is not set=0A=
=0A=
#=0A=
# Plug and Play configuration=0A=
#=0A=
# CONFIG_PNP is not set=0A=
# CONFIG_ISAPNP is not set=0A=
=0A=
#=0A=
# Block devices=0A=
#=0A=
# CONFIG_BLK_DEV_FD is not set=0A=
# CONFIG_BLK_DEV_XD is not set=0A=
# CONFIG_PARIDE is not set=0A=
# CONFIG_BLK_CPQ_DA is not set=0A=
# CONFIG_BLK_CPQ_CISS_DA is not set=0A=
# CONFIG_CISS_SCSI_TAPE is not set=0A=
# CONFIG_CISS_MONITOR_THREAD is not set=0A=
# CONFIG_BLK_DEV_DAC960 is not set=0A=
# CONFIG_BLK_DEV_UMEM is not set=0A=
CONFIG_BLK_DEV_LOOP=3Dy=0A=
# CONFIG_BLK_DEV_NBD is not set=0A=
CONFIG_BLK_DEV_RAM=3Dy=0A=
CONFIG_BLK_DEV_RAM_SIZE=3D16384=0A=
CONFIG_BLK_DEV_INITRD=3Dy=0A=
# CONFIG_BLK_STATS is not set=0A=
=0A=
#=0A=
# Multi-device support (RAID and LVM)=0A=
#=0A=
# CONFIG_MD is not set=0A=
# CONFIG_BLK_DEV_MD is not set=0A=
# CONFIG_MD_LINEAR is not set=0A=
# CONFIG_MD_RAID0 is not set=0A=
# CONFIG_MD_RAID1 is not set=0A=
# CONFIG_MD_RAID5 is not set=0A=
# CONFIG_MD_MULTIPATH is not set=0A=
# CONFIG_BLK_DEV_LVM is not set=0A=
=0A=
#=0A=
# Networking options=0A=
#=0A=
CONFIG_PACKET=3Dy=0A=
# CONFIG_PACKET_MMAP is not set=0A=
# CONFIG_NETLINK_DEV is not set=0A=
# CONFIG_NETFILTER is not set=0A=
# CONFIG_FILTER is not set=0A=
CONFIG_UNIX=3Dy=0A=
CONFIG_INET=3Dy=0A=
CONFIG_IP_MULTICAST=3Dy=0A=
# CONFIG_IP_ADVANCED_ROUTER is not set=0A=
CONFIG_IP_PNP=3Dy=0A=
CONFIG_IP_PNP_DHCP=3Dy=0A=
# CONFIG_IP_PNP_BOOTP is not set=0A=
# CONFIG_IP_PNP_RARP is not set=0A=
# CONFIG_NET_IPIP is not set=0A=
# CONFIG_NET_IPGRE is not set=0A=
# CONFIG_IP_MROUTE is not set=0A=
# CONFIG_ARPD is not set=0A=
# CONFIG_INET_ECN is not set=0A=
CONFIG_SYN_COOKIES=3Dy=0A=
# CONFIG_IPV6 is not set=0A=
# CONFIG_KHTTPD is not set=0A=
=0A=
#=0A=
#    SCTP Configuration (EXPERIMENTAL)=0A=
#=0A=
CONFIG_IPV6_SCTP__=3Dy=0A=
# CONFIG_IP_SCTP is not set=0A=
# CONFIG_ATM is not set=0A=
# CONFIG_VLAN_8021Q is not set=0A=
# CONFIG_IPX is not set=0A=
# CONFIG_ATALK is not set=0A=
=0A=
#=0A=
# Appletalk devices=0A=
#=0A=
# CONFIG_DEV_APPLETALK is not set=0A=
# CONFIG_DECNET is not set=0A=
# CONFIG_BRIDGE is not set=0A=
# CONFIG_X25 is not set=0A=
# CONFIG_LAPB is not set=0A=
# CONFIG_LLC is not set=0A=
# CONFIG_NET_DIVERT is not set=0A=
# CONFIG_ECONET is not set=0A=
# CONFIG_WAN_ROUTER is not set=0A=
# CONFIG_NET_FASTROUTE is not set=0A=
# CONFIG_NET_HW_FLOWCONTROL is not set=0A=
=0A=
#=0A=
# QoS and/or fair queueing=0A=
#=0A=
# CONFIG_NET_SCHED is not set=0A=
=0A=
#=0A=
# Network testing=0A=
#=0A=
# CONFIG_NET_PKTGEN is not set=0A=
=0A=
#=0A=
# ATA/IDE/MFM/RLL support=0A=
#=0A=
CONFIG_IDE=3Dy=0A=
=0A=
#=0A=
# IDE, ATA and ATAPI Block devices=0A=
#=0A=
CONFIG_BLK_DEV_IDE=3Dy=0A=
# CONFIG_BLK_DEV_HD_IDE is not set=0A=
# CONFIG_BLK_DEV_HD is not set=0A=
CONFIG_BLK_DEV_IDEDISK=3Dy=0A=
CONFIG_IDEDISK_MULTI_MODE=3Dy=0A=
CONFIG_IDEDISK_STROKE=3Dy=0A=
# CONFIG_BLK_DEV_IDECS is not set=0A=
CONFIG_BLK_DEV_IDECD=3Dy=0A=
# CONFIG_BLK_DEV_IDETAPE is not set=0A=
# CONFIG_BLK_DEV_IDEFLOPPY is not set=0A=
# CONFIG_BLK_DEV_IDESCSI is not set=0A=
# CONFIG_IDE_TASK_IOCTL is not set=0A=
# CONFIG_BLK_DEV_CMD640 is not set=0A=
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set=0A=
# CONFIG_BLK_DEV_ISAPNP is not set=0A=
CONFIG_BLK_DEV_IDEPCI=3Dy=0A=
# CONFIG_BLK_DEV_GENERIC is not set=0A=
# CONFIG_IDEPCI_SHARE_IRQ is not set=0A=
CONFIG_BLK_DEV_IDEDMA_PCI=3Dy=0A=
# CONFIG_BLK_DEV_OFFBOARD is not set=0A=
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set=0A=
# CONFIG_IDEDMA_PCI_AUTO is not set=0A=
# CONFIG_IDEDMA_ONLYDISK is not set=0A=
CONFIG_BLK_DEV_IDEDMA=3Dy=0A=
# CONFIG_IDEDMA_PCI_WIP is not set=0A=
# CONFIG_BLK_DEV_ADMA100 is not set=0A=
# CONFIG_BLK_DEV_AEC62XX is not set=0A=
# CONFIG_BLK_DEV_ALI15X3 is not set=0A=
# CONFIG_WDC_ALI15X3 is not set=0A=
# CONFIG_BLK_DEV_AMD74XX is not set=0A=
# CONFIG_AMD74XX_OVERRIDE is not set=0A=
# CONFIG_BLK_DEV_CMD64X is not set=0A=
# CONFIG_BLK_DEV_TRIFLEX is not set=0A=
# CONFIG_BLK_DEV_CY82C693 is not set=0A=
# CONFIG_BLK_DEV_CS5530 is not set=0A=
# CONFIG_BLK_DEV_HPT34X is not set=0A=
# CONFIG_HPT34X_AUTODMA is not set=0A=
# CONFIG_BLK_DEV_HPT366 is not set=0A=
# CONFIG_BLK_DEV_PIIX is not set=0A=
# CONFIG_BLK_DEV_NS87415 is not set=0A=
# CONFIG_BLK_DEV_OPTI621 is not set=0A=
# CONFIG_BLK_DEV_PDC202XX_OLD is not set=0A=
# CONFIG_PDC202XX_BURST is not set=0A=
# CONFIG_BLK_DEV_PDC202XX_NEW is not set=0A=
# CONFIG_BLK_DEV_RZ1000 is not set=0A=
# CONFIG_BLK_DEV_SC1200 is not set=0A=
# CONFIG_BLK_DEV_SVWKS is not set=0A=
# CONFIG_BLK_DEV_SIIMAGE is not set=0A=
# CONFIG_BLK_DEV_SIS5513 is not set=0A=
# CONFIG_BLK_DEV_SLC90E66 is not set=0A=
# CONFIG_BLK_DEV_TRM290 is not set=0A=
# CONFIG_BLK_DEV_VIA82CXXX is not set=0A=
# CONFIG_BLK_DEV_SL82C105 is not set=0A=
CONFIG_BLK_DEV_IDE_MPC5xxx=3Dy=0A=
CONFIG_BLK_DEV_IDE_MPC5xxx_MDMA=3Dy=0A=
CONFIG_BLK_DEV_IDE_MPC5xxx_UDMA=3Dy=0A=
# CONFIG_IDE_CHIPSETS is not set=0A=
# CONFIG_IDEDMA_AUTO is not set=0A=
# CONFIG_IDEDMA_IVB is not set=0A=
# CONFIG_DMA_NONPCI is not set=0A=
# CONFIG_BLK_DEV_ATARAID is not set=0A=
# CONFIG_BLK_DEV_ATARAID_PDC is not set=0A=
# CONFIG_BLK_DEV_ATARAID_HPT is not set=0A=
# CONFIG_BLK_DEV_ATARAID_SII is not set=0A=
=0A=
#=0A=
# SCSI support=0A=
#=0A=
# CONFIG_SCSI is not set=0A=
=0A=
#=0A=
# Fusion MPT device support=0A=
#=0A=
# CONFIG_FUSION is not set=0A=
# CONFIG_FUSION_BOOT is not set=0A=
# CONFIG_FUSION_ISENSE is not set=0A=
# CONFIG_FUSION_CTL is not set=0A=
# CONFIG_FUSION_LAN is not set=0A=
=0A=
#=0A=
# IEEE 1394 (FireWire) support (EXPERIMENTAL)=0A=
#=0A=
# CONFIG_IEEE1394 is not set=0A=
=0A=
#=0A=
# I2O device support=0A=
#=0A=
# CONFIG_I2O is not set=0A=
# CONFIG_I2O_PCI is not set=0A=
# CONFIG_I2O_BLOCK is not set=0A=
# CONFIG_I2O_LAN is not set=0A=
# CONFIG_I2O_SCSI is not set=0A=
# CONFIG_I2O_PROC is not set=0A=
=0A=
#=0A=
# Network device support=0A=
#=0A=
CONFIG_NETDEVICES=3Dy=0A=
=0A=
#=0A=
# ARCnet devices=0A=
#=0A=
# CONFIG_ARCNET is not set=0A=
# CONFIG_DUMMY is not set=0A=
# CONFIG_BONDING is not set=0A=
# CONFIG_EQUALIZER is not set=0A=
# CONFIG_TUN is not set=0A=
# CONFIG_ETHERTAP is not set=0A=
=0A=
#=0A=
# Ethernet (10 or 100Mbit)=0A=
#=0A=
CONFIG_NET_ETHERNET=3Dy=0A=
# CONFIG_MACE is not set=0A=
# CONFIG_BMAC is not set=0A=
# CONFIG_GMAC is not set=0A=
# CONFIG_SUNLANCE is not set=0A=
# CONFIG_HAPPYMEAL is not set=0A=
# CONFIG_SUNBMAC is not set=0A=
# CONFIG_SUNQE is not set=0A=
# CONFIG_SUNGEM is not set=0A=
# CONFIG_NET_VENDOR_3COM is not set=0A=
# CONFIG_LANCE is not set=0A=
# CONFIG_NET_VENDOR_SMC is not set=0A=
# CONFIG_NET_VENDOR_RACAL is not set=0A=
# CONFIG_HP100 is not set=0A=
# CONFIG_NET_ISA is not set=0A=
# CONFIG_NET_PCI is not set=0A=
# CONFIG_NET_POCKET is not set=0A=
=0A=
#=0A=
# Ethernet (1000 Mbit)=0A=
#=0A=
# CONFIG_ACENIC is not set=0A=
# CONFIG_DL2K is not set=0A=
# CONFIG_E1000 is not set=0A=
# CONFIG_MYRI_SBUS is not set=0A=
# CONFIG_NS83820 is not set=0A=
# CONFIG_HAMACHI is not set=0A=
# CONFIG_YELLOWFIN is not set=0A=
# CONFIG_R8169 is not set=0A=
# CONFIG_SK98LIN is not set=0A=
# CONFIG_TIGON3 is not set=0A=
# CONFIG_GIANFAR is not set=0A=
# CONFIG_GFAR_NAPI is not set=0A=
# CONFIG_GFAR_BDSTASH is not set=0A=
# CONFIG_GFAR_BUFSTASH is not set=0A=
# CONFIG_FDDI is not set=0A=
# CONFIG_NETCONSOLE is not set=0A=
# CONFIG_HIPPI is not set=0A=
# CONFIG_PLIP is not set=0A=
# CONFIG_PPP is not set=0A=
# CONFIG_SLIP is not set=0A=
=0A=
#=0A=
# Wireless LAN (non-hamradio)=0A=
#=0A=
# CONFIG_NET_RADIO is not set=0A=
=0A=
#=0A=
# Token Ring devices=0A=
#=0A=
# CONFIG_TR is not set=0A=
# CONFIG_NET_FC is not set=0A=
# CONFIG_RCPCI is not set=0A=
# CONFIG_SHAPER is not set=0A=
=0A=
#=0A=
# Wan interfaces=0A=
#=0A=
# CONFIG_WAN is not set=0A=
=0A=
#=0A=
# Amateur Radio support=0A=
#=0A=
# CONFIG_HAMRADIO is not set=0A=
=0A=
#=0A=
# IrDA (infrared) support=0A=
#=0A=
# CONFIG_IRDA is not set=0A=
=0A=
#=0A=
# ISDN subsystem=0A=
#=0A=
# CONFIG_ISDN is not set=0A=
=0A=
#=0A=
# Old CD-ROM drivers (not SCSI, not IDE)=0A=
#=0A=
# CONFIG_CD_NO_IDESCSI is not set=0A=
=0A=
#=0A=
# Console drivers=0A=
#=0A=
# CONFIG_VGA_CONSOLE is not set=0A=
=0A=
#=0A=
# Frame-buffer support=0A=
#=0A=
# CONFIG_FB is not set=0A=
=0A=
#=0A=
# Input core support=0A=
#=0A=
# CONFIG_INPUT is not set=0A=
# CONFIG_INPUT_KEYBDEV is not set=0A=
# CONFIG_INPUT_MOUSEDEV is not set=0A=
# CONFIG_INPUT_JOYDEV is not set=0A=
# CONFIG_INPUT_EVDEV is not set=0A=
# CONFIG_INPUT_UINPUT is not set=0A=
=0A=
#=0A=
# Macintosh device drivers=0A=
#=0A=
=0A=
#=0A=
# Character devices=0A=
#=0A=
# CONFIG_VT is not set=0A=
# CONFIG_SERIAL is not set=0A=
# CONFIG_SERIAL_EXTENDED is not set=0A=
CONFIG_SERIAL_NONSTANDARD=3Dy=0A=
# CONFIG_COMPUTONE is not set=0A=
# CONFIG_ROCKETPORT is not set=0A=
# CONFIG_CYCLADES is not set=0A=
# CONFIG_DIGIEPCA is not set=0A=
# CONFIG_DIGI is not set=0A=
# CONFIG_ESPSERIAL is not set=0A=
# CONFIG_MOXA_INTELLIO is not set=0A=
# CONFIG_MOXA_SMARTIO is not set=0A=
# CONFIG_ISI is not set=0A=
# CONFIG_SYNCLINK is not set=0A=
# CONFIG_SYNCLINKMP is not set=0A=
# CONFIG_N_HDLC is not set=0A=
# CONFIG_RISCOM8 is not set=0A=
# CONFIG_SPECIALIX is not set=0A=
# CONFIG_SX is not set=0A=
# CONFIG_RIO is not set=0A=
# CONFIG_STALDRV is not set=0A=
# CONFIG_PS2MULT is not set=0A=
# CONFIG_KEYMAP_DE_LATIN1 is not set=0A=
CONFIG_UNIX98_PTYS=3Dy=0A=
CONFIG_UNIX98_PTY_COUNT=3D256=0A=
=0A=
#=0A=
# I2C support=0A=
#=0A=
# CONFIG_I2C is not set=0A=
=0A=
#=0A=
# SPI support=0A=
#=0A=
# CONFIG_SPI is not set=0A=
=0A=
#=0A=
# Mice=0A=
#=0A=
# CONFIG_BUSMOUSE is not set=0A=
# CONFIG_MOUSE is not set=0A=
=0A=
#=0A=
# Joysticks=0A=
#=0A=
# CONFIG_INPUT_GAMEPORT is not set=0A=
# CONFIG_QIC02_TAPE is not set=0A=
# CONFIG_IPMI_HANDLER is not set=0A=
# CONFIG_IPMI_PANIC_EVENT is not set=0A=
# CONFIG_IPMI_DEVICE_INTERFACE is not set=0A=
# CONFIG_IPMI_KCS is not set=0A=
# CONFIG_IPMI_WATCHDOG is not set=0A=
=0A=
#=0A=
# Watchdog Cards=0A=
#=0A=
# CONFIG_WATCHDOG is not set=0A=
# CONFIG_SCx200 is not set=0A=
# CONFIG_SCx200_GPIO is not set=0A=
# CONFIG_AMD_PM768 is not set=0A=
# CONFIG_NVRAM is not set=0A=
# CONFIG_RTC is not set=0A=
# CONFIG_RTC_11_MINUTE_MODE is not set=0A=
# CONFIG_DTLK is not set=0A=
# CONFIG_R3964 is not set=0A=
# CONFIG_APPLICOM is not set=0A=
# CONFIG_FLASH is not set=0A=
=0A=
#=0A=
# Ftape, the floppy tape device driver=0A=
#=0A=
# CONFIG_FTAPE is not set=0A=
# CONFIG_AGP is not set=0A=
=0A=
#=0A=
# Direct Rendering Manager (XFree86 DRI support)=0A=
#=0A=
# CONFIG_DRM is not set=0A=
=0A=
#=0A=
# Multimedia devices=0A=
#=0A=
# CONFIG_VIDEO_DEV is not set=0A=
=0A=
#=0A=
# File systems=0A=
#=0A=
# CONFIG_QUOTA is not set=0A=
# CONFIG_QFMT_V2 is not set=0A=
# CONFIG_AUTOFS_FS is not set=0A=
# CONFIG_AUTOFS4_FS is not set=0A=
# CONFIG_REISERFS_FS is not set=0A=
# CONFIG_REISERFS_CHECK is not set=0A=
# CONFIG_REISERFS_PROC_INFO is not set=0A=
# CONFIG_ADFS_FS is not set=0A=
# CONFIG_ADFS_FS_RW is not set=0A=
# CONFIG_AFFS_FS is not set=0A=
# CONFIG_HFS_FS is not set=0A=
# CONFIG_HFSPLUS_FS is not set=0A=
# CONFIG_BEFS_FS is not set=0A=
# CONFIG_BEFS_DEBUG is not set=0A=
# CONFIG_BFS_FS is not set=0A=
CONFIG_EXT3_FS=3Dy=0A=
CONFIG_JBD=3Dy=0A=
# CONFIG_JBD_DEBUG is not set=0A=
CONFIG_FAT_FS=3Dy=0A=
CONFIG_MSDOS_FS=3Dy=0A=
# CONFIG_UMSDOS_FS is not set=0A=
CONFIG_VFAT_FS=3Dy=0A=
# CONFIG_EFS_FS is not set=0A=
# CONFIG_JFFS_FS is not set=0A=
CONFIG_JFFS2_FS=3Dy=0A=
CONFIG_JFFS2_FS_DEBUG=3D0=0A=
CONFIG_JFFS2_FS_WRITEBUFFER=3Dy=0A=
CONFIG_JFFS2_ZLIB=3Dy=0A=
CONFIG_JFFS2_RTIME=3Dy=0A=
# CONFIG_JFFS2_RUBIN is not set=0A=
# CONFIG_JFFS2_LZO is not set=0A=
# CONFIG_JFFS2_LZARI is not set=0A=
# CONFIG_JFFS2_CMODE_NONE is not set=0A=
CONFIG_JFFS2_CMODE_PRIORITY=3Dy=0A=
# CONFIG_JFFS2_CMODE_SIZE is not set=0A=
CONFIG_JFFS2_PROC=3Dy=0A=
CONFIG_CRAMFS=3Dy=0A=
CONFIG_TMPFS=3Dy=0A=
CONFIG_RAMFS=3Dy=0A=
CONFIG_ISO9660_FS=3Dy=0A=
CONFIG_JOLIET=3Dy=0A=
# CONFIG_ZISOFS is not set=0A=
# CONFIG_JFS_FS is not set=0A=
# CONFIG_JFS_DEBUG is not set=0A=
# CONFIG_JFS_STATISTICS is not set=0A=
# CONFIG_MINIX_FS is not set=0A=
# CONFIG_VXFS_FS is not set=0A=
# CONFIG_NTFS_FS is not set=0A=
# CONFIG_NTFS_RW is not set=0A=
# CONFIG_HPFS_FS is not set=0A=
CONFIG_PROC_FS=3Dy=0A=
CONFIG_DEVFS_FS=3Dy=0A=
CONFIG_DEVFS_MOUNT=3Dy=0A=
CONFIG_DEVFS_DEBUG=3Dy=0A=
CONFIG_DEVPTS_FS=3Dy=0A=
# CONFIG_QNX4FS_FS is not set=0A=
# CONFIG_QNX4FS_RW is not set=0A=
CONFIG_ROMFS_FS=3Dy=0A=
CONFIG_EXT2_FS=3Dy=0A=
# CONFIG_SYSV_FS is not set=0A=
# CONFIG_UDF_FS is not set=0A=
# CONFIG_UDF_RW is not set=0A=
# CONFIG_UFS_FS is not set=0A=
# CONFIG_UFS_FS_WRITE is not set=0A=
# CONFIG_XFS_FS is not set=0A=
# CONFIG_XFS_QUOTA is not set=0A=
# CONFIG_XFS_RT is not set=0A=
# CONFIG_XFS_TRACE is not set=0A=
# CONFIG_XFS_DEBUG is not set=0A=
=0A=
#=0A=
# Network File Systems=0A=
#=0A=
# CONFIG_CODA_FS is not set=0A=
# CONFIG_INTERMEZZO_FS is not set=0A=
CONFIG_NFS_FS=3Dy=0A=
CONFIG_NFS_V3=3Dy=0A=
# CONFIG_NFS_DIRECTIO is not set=0A=
CONFIG_ROOT_NFS=3Dy=0A=
# CONFIG_NFSD is not set=0A=
# CONFIG_NFSD_V3 is not set=0A=
# CONFIG_NFSD_TCP is not set=0A=
CONFIG_SUNRPC=3Dy=0A=
CONFIG_LOCKD=3Dy=0A=
CONFIG_LOCKD_V4=3Dy=0A=
# CONFIG_SMB_FS is not set=0A=
# CONFIG_NCP_FS is not set=0A=
# CONFIG_NCPFS_PACKET_SIGNING is not set=0A=
# CONFIG_NCPFS_IOCTL_LOCKING is not set=0A=
# CONFIG_NCPFS_STRONG is not set=0A=
# CONFIG_NCPFS_NFS_NS is not set=0A=
# CONFIG_NCPFS_OS2_NS is not set=0A=
# CONFIG_NCPFS_SMALLDOS is not set=0A=
# CONFIG_NCPFS_NLS is not set=0A=
# CONFIG_NCPFS_EXTRAS is not set=0A=
# CONFIG_ZISOFS_FS is not set=0A=
=0A=
#=0A=
# Partition Types=0A=
#=0A=
CONFIG_PARTITION_ADVANCED=3Dy=0A=
# CONFIG_ACORN_PARTITION is not set=0A=
# CONFIG_OSF_PARTITION is not set=0A=
# CONFIG_AMIGA_PARTITION is not set=0A=
# CONFIG_ATARI_PARTITION is not set=0A=
# CONFIG_MAC_PARTITION is not set=0A=
CONFIG_MSDOS_PARTITION=3Dy=0A=
# CONFIG_BSD_DISKLABEL is not set=0A=
# CONFIG_MINIX_SUBPARTITION is not set=0A=
# CONFIG_SOLARIS_X86_PARTITION is not set=0A=
# CONFIG_UNIXWARE_DISKLABEL is not set=0A=
# CONFIG_LDM_PARTITION is not set=0A=
# CONFIG_SGI_PARTITION is not set=0A=
# CONFIG_ULTRIX_PARTITION is not set=0A=
# CONFIG_SUN_PARTITION is not set=0A=
# CONFIG_EFI_PARTITION is not set=0A=
# CONFIG_SMB_NLS is not set=0A=
CONFIG_NLS=3Dy=0A=
=0A=
#=0A=
# Native Language Support=0A=
#=0A=
CONFIG_NLS_DEFAULT=3D"iso8859-1"=0A=
# CONFIG_NLS_CODEPAGE_437 is not set=0A=
# CONFIG_NLS_CODEPAGE_737 is not set=0A=
# CONFIG_NLS_CODEPAGE_775 is not set=0A=
# CONFIG_NLS_CODEPAGE_850 is not set=0A=
# CONFIG_NLS_CODEPAGE_852 is not set=0A=
# CONFIG_NLS_CODEPAGE_855 is not set=0A=
# CONFIG_NLS_CODEPAGE_857 is not set=0A=
# CONFIG_NLS_CODEPAGE_860 is not set=0A=
# CONFIG_NLS_CODEPAGE_861 is not set=0A=
# CONFIG_NLS_CODEPAGE_862 is not set=0A=
# CONFIG_NLS_CODEPAGE_863 is not set=0A=
# CONFIG_NLS_CODEPAGE_864 is not set=0A=
# CONFIG_NLS_CODEPAGE_865 is not set=0A=
# CONFIG_NLS_CODEPAGE_866 is not set=0A=
# CONFIG_NLS_CODEPAGE_869 is not set=0A=
# CONFIG_NLS_CODEPAGE_936 is not set=0A=
# CONFIG_NLS_CODEPAGE_950 is not set=0A=
# CONFIG_NLS_CODEPAGE_932 is not set=0A=
# CONFIG_NLS_CODEPAGE_949 is not set=0A=
# CONFIG_NLS_CODEPAGE_874 is not set=0A=
# CONFIG_NLS_ISO8859_8 is not set=0A=
# CONFIG_NLS_CODEPAGE_1250 is not set=0A=
# CONFIG_NLS_CODEPAGE_1251 is not set=0A=
CONFIG_NLS_ISO8859_1=3Dy=0A=
# CONFIG_NLS_ISO8859_2 is not set=0A=
# CONFIG_NLS_ISO8859_3 is not set=0A=
# CONFIG_NLS_ISO8859_4 is not set=0A=
# CONFIG_NLS_ISO8859_5 is not set=0A=
# CONFIG_NLS_ISO8859_6 is not set=0A=
# CONFIG_NLS_ISO8859_7 is not set=0A=
# CONFIG_NLS_ISO8859_9 is not set=0A=
# CONFIG_NLS_ISO8859_13 is not set=0A=
# CONFIG_NLS_ISO8859_14 is not set=0A=
CONFIG_NLS_ISO8859_15=3Dy=0A=
# CONFIG_NLS_KOI8_R is not set=0A=
# CONFIG_NLS_KOI8_U is not set=0A=
# CONFIG_NLS_UTF8 is not set=0A=
=0A=
#=0A=
# Sound=0A=
#=0A=
# CONFIG_SOUND is not set=0A=
=0A=
#=0A=
# MPC5xxx I/O Options=0A=
#=0A=
CONFIG_BESTCOMM_API=3Dy=0A=
CONFIG_PPC_5xxx_FEC=3Dy=0A=
CONFIG_USE_MDIO=3Dy=0A=
CONFIG_FEC_GENERIC_PHY=3Dy=0A=
CONFIG_FEC_LXT971=3Dy=0A=
# CONFIG_FEC_DP83847 is not set=0A=
# CONFIG_USB_USEBOTH is not set=0A=
CONFIG_PPC_5xxx_PSC=3Dy=0A=
CONFIG_PPC_5xxx_PSC_CONSOLE=3Dy=0A=
CONFIG_SERIAL_CONSOLE=3Dy=0A=
# CONFIG_5200_I2S is not set=0A=
# CONFIG_5200_I2S_RING is not set=0A=
=0A=
#=0A=
# USB support=0A=
#=0A=
# CONFIG_USB is not set=0A=
=0A=
#=0A=
# Support for USB gadgets=0A=
#=0A=
# CONFIG_USB_GADGET is not set=0A=
=0A=
#=0A=
# Bluetooth support=0A=
#=0A=
# CONFIG_BLUEZ is not set=0A=
=0A=
#=0A=
# Cryptographic options=0A=
#=0A=
# CONFIG_CRYPTO is not set=0A=
=0A=
#=0A=
# Library routines=0A=
#=0A=
# CONFIG_CRC32 is not set=0A=
CONFIG_ZLIB_INFLATE=3Dy=0A=
CONFIG_ZLIB_DEFLATE=3Dy=0A=
# CONFIG_REED_SOLOMON is not set=0A=
=0A=
#=0A=
# Kernel hacking=0A=
#=0A=
CONFIG_DEBUG_KERNEL=3Dy=0A=
# CONFIG_MAGIC_SYSRQ is not set=0A=
# CONFIG_DEBUG_HIGHMEM is not set=0A=
# CONFIG_DEBUG_SLAB is not set=0A=
# CONFIG_DEBUG_IOVIRT is not set=0A=
# CONFIG_DEBUG_SPINLOCK is not set=0A=
# CONFIG_DEBUG_WAITQ is not set=0A=
# CONFIG_KGDB is not set=0A=
# CONFIG_XMON is not set=0A=
CONFIG_BDI_SWITCH=3Dy=0A=
CONFIG_MORE_COMPILE_OPTIONS=3Dy=0A=
CONFIG_COMPILE_OPTIONS=3D"-g -ggdb"=0A=
# CONFIG_SERIAL_TEXT_DEBUG is not set=0A=
CONFIG_LOG_BUF_SHIFT=3D0=0A=

------=_NextPart_000_002A_01C6AFCC.8E1C8220--
