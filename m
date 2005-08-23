Return-Path: <johnsoncheng@qnap.com.tw>
Received: from qnap.com.tw (unknown [211.75.85.27])
	by ozlabs.org (Postfix) with SMTP id 7A34E68153
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 23 Aug 2005 19:49:46 +1000 (EST)
From: "JohnsonCheng" <johnsoncheng@qnap.com.tw>
To: "'Stefan Nickl'" <Stefan.Nickl@kontron.com>
Date: Tue, 23 Aug 2005 17:42:24 +0800
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0063_01C5A80A.150DEA60"
In-Reply-To: <1124783301.14274.49.camel@lucy.pep-kaufbeuren.de>
Message-Id: <20050823094946.7A34E68153@ozlabs.org>
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: How NEC uPD720101 USB chip work well on linux2.6.12
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

------=_NextPart_000_0063_01C5A80A.150DEA60
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Right. My USB architecture is the same as you describe. I have also support
EHCI, but I disable it now.
The attach files are my kernel configuration and kernel oops while plug-in
USB mouse.

Thanks,
Johnson Cheng


-----Original Message-----
From: Stefan Nickl [mailto:Stefan.Nickl@kontron.com] 
Sent: Tuesday, August 23, 2005 3:48 PM
To: JohnsonCheng
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: How NEC uPD720101 USB chip work well on linux2.6.12

On Sat, 2005-07-23 at 10:37 +0800, JohnsonCheng wrote:
> Correct it. 
> I only turn on OHCI in kernel configuration, not UHCI.

I guess what you have is like this:

 ---------
| MPC8241 |
 ---------
     |
     | PCI bus
     |
 --------------------------
| OHCI host controller(s?) |
 --------------------------
     |
     | USB
     |
 -----------
| uPD720101 |
 -----------
     |
  USB mouse

So the IRQ is all up to your PCI setup and board wiring.

Please send the output of ksymoops as described in
linux/Documentation/oops-tracing.txt.
Note that you need to run it something like this:
ksymoops -v <vmlinux-of-target> -m <System.map-of-target> -t elf32-big
-a ppc -K -L

PS: Please check your PC's clock, your emails date back to July...

-- 
Stefan Nickl
Kontron Modular Computers




------=_NextPart_000_0063_01C5A80A.150DEA60
Content-Type: application/octet-stream;
	name="kernel_config"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="kernel_config"

#=0A=
# Automatically generated make config: don't edit=0A=
# Linux kernel version: 2.6.12.3=0A=
# Tue Aug 23 17:22:59 2005=0A=
#=0A=
CONFIG_MMU=3Dy=0A=
CONFIG_GENERIC_HARDIRQS=3Dy=0A=
CONFIG_RWSEM_XCHGADD_ALGORITHM=3Dy=0A=
CONFIG_GENERIC_CALIBRATE_DELAY=3Dy=0A=
CONFIG_HAVE_DEC_LOCK=3Dy=0A=
CONFIG_PPC=3Dy=0A=
CONFIG_PPC32=3Dy=0A=
CONFIG_GENERIC_NVRAM=3Dy=0A=
CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=3Dy=0A=
=0A=
#=0A=
# Code maturity level options=0A=
#=0A=
CONFIG_EXPERIMENTAL=3Dy=0A=
CONFIG_CLEAN_COMPILE=3Dy=0A=
CONFIG_BROKEN_ON_SMP=3Dy=0A=
CONFIG_INIT_ENV_ARG_LIMIT=3D32=0A=
=0A=
#=0A=
# General setup=0A=
#=0A=
CONFIG_LOCALVERSION=3D""=0A=
# CONFIG_SWAP is not set=0A=
CONFIG_SYSVIPC=3Dy=0A=
# CONFIG_POSIX_MQUEUE is not set=0A=
# CONFIG_BSD_PROCESS_ACCT is not set=0A=
CONFIG_SYSCTL=3Dy=0A=
# CONFIG_AUDIT is not set=0A=
CONFIG_HOTPLUG=3Dy=0A=
CONFIG_KOBJECT_UEVENT=3Dy=0A=
# CONFIG_IKCONFIG is not set=0A=
CONFIG_EMBEDDED=3Dy=0A=
CONFIG_KALLSYMS=3Dy=0A=
# CONFIG_KALLSYMS_EXTRA_PASS is not set=0A=
CONFIG_PRINTK=3Dy=0A=
CONFIG_BUG=3Dy=0A=
CONFIG_BASE_FULL=3Dy=0A=
CONFIG_FUTEX=3Dy=0A=
CONFIG_EPOLL=3Dy=0A=
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set=0A=
CONFIG_SHMEM=3Dy=0A=
CONFIG_CC_ALIGN_FUNCTIONS=3D0=0A=
CONFIG_CC_ALIGN_LABELS=3D0=0A=
CONFIG_CC_ALIGN_LOOPS=3D0=0A=
CONFIG_CC_ALIGN_JUMPS=3D0=0A=
# CONFIG_TINY_SHMEM is not set=0A=
CONFIG_BASE_SMALL=3D0=0A=
=0A=
#=0A=
# Loadable module support=0A=
#=0A=
CONFIG_MODULES=3Dy=0A=
CONFIG_MODULE_UNLOAD=3Dy=0A=
# CONFIG_MODULE_FORCE_UNLOAD is not set=0A=
CONFIG_OBSOLETE_MODPARM=3Dy=0A=
# CONFIG_MODVERSIONS is not set=0A=
# CONFIG_MODULE_SRCVERSION_ALL is not set=0A=
CONFIG_KMOD=3Dy=0A=
=0A=
#=0A=
# Processor=0A=
#=0A=
CONFIG_6xx=3Dy=0A=
# CONFIG_40x is not set=0A=
# CONFIG_44x is not set=0A=
# CONFIG_POWER3 is not set=0A=
# CONFIG_POWER4 is not set=0A=
# CONFIG_8xx is not set=0A=
# CONFIG_E500 is not set=0A=
CONFIG_PPC_FPU=3Dy=0A=
# CONFIG_ALTIVEC is not set=0A=
# CONFIG_TAU is not set=0A=
# CONFIG_CPU_FREQ is not set=0A=
CONFIG_PPC_GEN550=3Dy=0A=
# CONFIG_PM is not set=0A=
CONFIG_PPC_STD_MMU=3Dy=0A=
=0A=
#=0A=
# Platform options=0A=
#=0A=
# CONFIG_PPC_MULTIPLATFORM is not set=0A=
# CONFIG_APUS is not set=0A=
# CONFIG_KATANA is not set=0A=
# CONFIG_WILLOW is not set=0A=
# CONFIG_CPCI690 is not set=0A=
# CONFIG_PCORE is not set=0A=
# CONFIG_POWERPMC250 is not set=0A=
# CONFIG_CHESTNUT is not set=0A=
# CONFIG_SPRUCE is not set=0A=
# CONFIG_HDPU is not set=0A=
# CONFIG_EV64260 is not set=0A=
# CONFIG_LOPEC is not set=0A=
# CONFIG_MCPN765 is not set=0A=
# CONFIG_MVME5100 is not set=0A=
# CONFIG_PPLUS is not set=0A=
# CONFIG_PRPMC750 is not set=0A=
# CONFIG_PRPMC800 is not set=0A=
CONFIG_SANDPOINT=3Dy=0A=
# CONFIG_RADSTONE_PPC7D is not set=0A=
# CONFIG_ADIR is not set=0A=
# CONFIG_K2 is not set=0A=
# CONFIG_PAL4 is not set=0A=
# CONFIG_GEMINI is not set=0A=
# CONFIG_EST8260 is not set=0A=
# CONFIG_SBC82xx is not set=0A=
# CONFIG_SBS8260 is not set=0A=
# CONFIG_RPX8260 is not set=0A=
# CONFIG_TQM8260 is not set=0A=
# CONFIG_ADS8272 is not set=0A=
# CONFIG_PQ2FADS is not set=0A=
# CONFIG_LITE5200 is not set=0A=
# CONFIG_MPC834x_SYS is not set=0A=
CONFIG_EPIC_SERIAL_MODE=3Dy=0A=
CONFIG_MPC10X_BRIDGE=3Dy=0A=
CONFIG_FSL_OCP=3Dy=0A=
CONFIG_MPC10X_OPENPIC=3Dy=0A=
# CONFIG_MPC10X_STORE_GATHERING is not set=0A=
# CONFIG_SMP is not set=0A=
# CONFIG_PREEMPT is not set=0A=
# CONFIG_HIGHMEM is not set=0A=
CONFIG_BINFMT_ELF=3Dy=0A=
CONFIG_BINFMT_MISC=3Dm=0A=
CONFIG_CMDLINE_BOOL=3Dy=0A=
CONFIG_CMDLINE=3D"console=3DttyS0,115200n8 root=3D/dev/ram"=0A=
CONFIG_ISA_DMA_API=3Dy=0A=
=0A=
#=0A=
# Bus options=0A=
#=0A=
CONFIG_GENERIC_ISA_DMA=3Dy=0A=
CONFIG_PCI=3Dy=0A=
CONFIG_PCI_DOMAINS=3Dy=0A=
CONFIG_PCI_LEGACY_PROC=3Dy=0A=
CONFIG_PCI_NAMES=3Dy=0A=
=0A=
#=0A=
# PCCARD (PCMCIA/CardBus) support=0A=
#=0A=
# CONFIG_PCCARD is not set=0A=
=0A=
#=0A=
# Advanced setup=0A=
#=0A=
# CONFIG_ADVANCED_OPTIONS is not set=0A=
=0A=
#=0A=
# Default settings for advanced configuration options are used=0A=
#=0A=
CONFIG_HIGHMEM_START=3D0xfe000000=0A=
CONFIG_LOWMEM_SIZE=3D0x30000000=0A=
CONFIG_KERNEL_START=3D0xc0000000=0A=
CONFIG_TASK_SIZE=3D0x80000000=0A=
CONFIG_BOOT_LOAD=3D0x00800000=0A=
=0A=
#=0A=
# Device Drivers=0A=
#=0A=
=0A=
#=0A=
# Generic Driver Options=0A=
#=0A=
CONFIG_STANDALONE=3Dy=0A=
CONFIG_PREVENT_FIRMWARE_BUILD=3Dy=0A=
# CONFIG_FW_LOADER is not set=0A=
=0A=
#=0A=
# Memory Technology Devices (MTD)=0A=
#=0A=
CONFIG_MTD=3Dy=0A=
CONFIG_MTD_DEBUG=3Dy=0A=
CONFIG_MTD_DEBUG_VERBOSE=3D3=0A=
# CONFIG_MTD_CONCAT is not set=0A=
CONFIG_MTD_PARTITIONS=3Dy=0A=
# CONFIG_MTD_REDBOOT_PARTS is not set=0A=
# CONFIG_MTD_CMDLINE_PARTS is not set=0A=
=0A=
#=0A=
# User Modules And Translation Layers=0A=
#=0A=
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
# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set=0A=
# CONFIG_MTD_MAP_BANK_WIDTH_16 is not set=0A=
# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set=0A=
CONFIG_MTD_CFI_I1=3Dy=0A=
CONFIG_MTD_CFI_I2=3Dy=0A=
# CONFIG_MTD_CFI_I4 is not set=0A=
# CONFIG_MTD_CFI_I8 is not set=0A=
# CONFIG_MTD_CFI_INTELEXT is not set=0A=
CONFIG_MTD_CFI_AMDSTD=3Dy=0A=
CONFIG_MTD_CFI_AMDSTD_RETRY=3D0=0A=
# CONFIG_MTD_CFI_STAA is not set=0A=
CONFIG_MTD_CFI_UTIL=3Dy=0A=
# CONFIG_MTD_RAM is not set=0A=
CONFIG_MTD_ROM=3Dy=0A=
# CONFIG_MTD_ABSENT is not set=0A=
=0A=
#=0A=
# Mapping drivers for chip access=0A=
#=0A=
# CONFIG_MTD_COMPLEX_MAPPINGS is not set=0A=
CONFIG_MTD_PHYSMAP=3Dy=0A=
CONFIG_MTD_PHYSMAP_START=3D0xFF000000=0A=
CONFIG_MTD_PHYSMAP_LEN=3D0x01000000=0A=
CONFIG_MTD_PHYSMAP_BANKWIDTH=3D2=0A=
=0A=
#=0A=
# Self-contained MTD device drivers=0A=
#=0A=
# CONFIG_MTD_PMC551 is not set=0A=
# CONFIG_MTD_SLRAM is not set=0A=
# CONFIG_MTD_PHRAM is not set=0A=
# CONFIG_MTD_MTDRAM is not set=0A=
# CONFIG_MTD_BLKMTD is not set=0A=
# CONFIG_MTD_BLOCK2MTD is not set=0A=
=0A=
#=0A=
# Disk-On-Chip Device Drivers=0A=
#=0A=
# CONFIG_MTD_DOC2000 is not set=0A=
# CONFIG_MTD_DOC2001 is not set=0A=
# CONFIG_MTD_DOC2001PLUS is not set=0A=
=0A=
#=0A=
# NAND Flash Device Drivers=0A=
#=0A=
# CONFIG_MTD_NAND is not set=0A=
=0A=
#=0A=
# Parallel port support=0A=
#=0A=
# CONFIG_PARPORT is not set=0A=
=0A=
#=0A=
# Plug and Play support=0A=
#=0A=
=0A=
#=0A=
# Block devices=0A=
#=0A=
# CONFIG_BLK_DEV_FD is not set=0A=
# CONFIG_BLK_CPQ_DA is not set=0A=
# CONFIG_BLK_CPQ_CISS_DA is not set=0A=
# CONFIG_BLK_DEV_DAC960 is not set=0A=
# CONFIG_BLK_DEV_UMEM is not set=0A=
# CONFIG_BLK_DEV_COW_COMMON is not set=0A=
CONFIG_BLK_DEV_LOOP=3Dy=0A=
# CONFIG_BLK_DEV_CRYPTOLOOP is not set=0A=
# CONFIG_BLK_DEV_NBD is not set=0A=
# CONFIG_BLK_DEV_SX8 is not set=0A=
# CONFIG_BLK_DEV_UB is not set=0A=
CONFIG_BLK_DEV_RAM=3Dy=0A=
CONFIG_BLK_DEV_RAM_COUNT=3D16=0A=
CONFIG_BLK_DEV_RAM_SIZE=3D40960=0A=
CONFIG_BLK_DEV_INITRD=3Dy=0A=
CONFIG_INITRAMFS_SOURCE=3D""=0A=
CONFIG_LBD=3Dy=0A=
# CONFIG_CDROM_PKTCDVD is not set=0A=
=0A=
#=0A=
# IO Schedulers=0A=
#=0A=
CONFIG_IOSCHED_NOOP=3Dy=0A=
CONFIG_IOSCHED_AS=3Dy=0A=
CONFIG_IOSCHED_DEADLINE=3Dy=0A=
CONFIG_IOSCHED_CFQ=3Dy=0A=
# CONFIG_ATA_OVER_ETH is not set=0A=
=0A=
#=0A=
# ATA/ATAPI/MFM/RLL support=0A=
#=0A=
# CONFIG_IDE is not set=0A=
=0A=
#=0A=
# SCSI device support=0A=
#=0A=
CONFIG_SCSI=3Dy=0A=
CONFIG_SCSI_PROC_FS=3Dy=0A=
=0A=
#=0A=
# SCSI support type (disk, tape, CD-ROM)=0A=
#=0A=
CONFIG_BLK_DEV_SD=3Dy=0A=
# CONFIG_CHR_DEV_ST is not set=0A=
# CONFIG_CHR_DEV_OSST is not set=0A=
# CONFIG_BLK_DEV_SR is not set=0A=
CONFIG_CHR_DEV_SG=3Dy=0A=
=0A=
#=0A=
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs=0A=
#=0A=
# CONFIG_SCSI_MULTI_LUN is not set=0A=
# CONFIG_SCSI_CONSTANTS is not set=0A=
# CONFIG_SCSI_LOGGING is not set=0A=
=0A=
#=0A=
# SCSI Transport Attributes=0A=
#=0A=
# CONFIG_SCSI_SPI_ATTRS is not set=0A=
# CONFIG_SCSI_FC_ATTRS is not set=0A=
# CONFIG_SCSI_ISCSI_ATTRS is not set=0A=
=0A=
#=0A=
# SCSI low-level drivers=0A=
#=0A=
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set=0A=
# CONFIG_SCSI_3W_9XXX is not set=0A=
# CONFIG_SCSI_ACARD is not set=0A=
# CONFIG_SCSI_AACRAID is not set=0A=
# CONFIG_SCSI_AIC7XXX is not set=0A=
# CONFIG_SCSI_AIC7XXX_OLD is not set=0A=
# CONFIG_SCSI_AIC79XX is not set=0A=
# CONFIG_SCSI_DPT_I2O is not set=0A=
# CONFIG_MEGARAID_NEWGEN is not set=0A=
# CONFIG_MEGARAID_LEGACY is not set=0A=
CONFIG_SCSI_SATA=3Dy=0A=
# CONFIG_SCSI_SATA_AHCI is not set=0A=
# CONFIG_SCSI_SATA_SVW is not set=0A=
# CONFIG_SCSI_ATA_PIIX is not set=0A=
# CONFIG_SCSI_SATA_NV is not set=0A=
# CONFIG_SCSI_SATA_PROMISE is not set=0A=
# CONFIG_SCSI_SATA_QSTOR is not set=0A=
# CONFIG_SCSI_SATA_SX4 is not set=0A=
CONFIG_SCSI_SATA_SIL=3Dy=0A=
# CONFIG_SCSI_SATA_SIS is not set=0A=
# CONFIG_SCSI_SATA_ULI is not set=0A=
# CONFIG_SCSI_SATA_VIA is not set=0A=
# CONFIG_SCSI_SATA_VITESSE is not set=0A=
# CONFIG_SCSI_BUSLOGIC is not set=0A=
# CONFIG_SCSI_DMX3191D is not set=0A=
# CONFIG_SCSI_EATA is not set=0A=
# CONFIG_SCSI_FUTURE_DOMAIN is not set=0A=
# CONFIG_SCSI_GDTH is not set=0A=
# CONFIG_SCSI_IPS is not set=0A=
# CONFIG_SCSI_INITIO is not set=0A=
# CONFIG_SCSI_INIA100 is not set=0A=
# CONFIG_SCSI_SYM53C8XX_2 is not set=0A=
# CONFIG_SCSI_IPR is not set=0A=
# CONFIG_SCSI_QLOGIC_FC is not set=0A=
# CONFIG_SCSI_QLOGIC_1280 is not set=0A=
CONFIG_SCSI_QLA2XXX=3Dy=0A=
# CONFIG_SCSI_QLA21XX is not set=0A=
# CONFIG_SCSI_QLA22XX is not set=0A=
# CONFIG_SCSI_QLA2300 is not set=0A=
# CONFIG_SCSI_QLA2322 is not set=0A=
# CONFIG_SCSI_QLA6312 is not set=0A=
# CONFIG_SCSI_LPFC is not set=0A=
# CONFIG_SCSI_DC395x is not set=0A=
# CONFIG_SCSI_DC390T is not set=0A=
# CONFIG_SCSI_NSP32 is not set=0A=
# CONFIG_SCSI_DEBUG is not set=0A=
=0A=
#=0A=
# Multi-device support (RAID and LVM)=0A=
#=0A=
# CONFIG_MD is not set=0A=
=0A=
#=0A=
# Fusion MPT device support=0A=
#=0A=
# CONFIG_FUSION is not set=0A=
=0A=
#=0A=
# IEEE 1394 (FireWire) support=0A=
#=0A=
# CONFIG_IEEE1394 is not set=0A=
=0A=
#=0A=
# I2O device support=0A=
#=0A=
# CONFIG_I2O is not set=0A=
=0A=
#=0A=
# Macintosh device drivers=0A=
#=0A=
=0A=
#=0A=
# Networking support=0A=
#=0A=
CONFIG_NET=3Dy=0A=
=0A=
#=0A=
# Networking options=0A=
#=0A=
CONFIG_PACKET=3Dy=0A=
# CONFIG_PACKET_MMAP is not set=0A=
CONFIG_UNIX=3Dy=0A=
# CONFIG_NET_KEY is not set=0A=
CONFIG_INET=3Dy=0A=
CONFIG_IP_MULTICAST=3Dy=0A=
CONFIG_IP_ADVANCED_ROUTER=3Dy=0A=
# CONFIG_IP_MULTIPLE_TABLES is not set=0A=
# CONFIG_IP_ROUTE_MULTIPATH is not set=0A=
# CONFIG_IP_ROUTE_VERBOSE is not set=0A=
# CONFIG_IP_PNP is not set=0A=
# CONFIG_NET_IPIP is not set=0A=
# CONFIG_NET_IPGRE is not set=0A=
# CONFIG_IP_MROUTE is not set=0A=
# CONFIG_ARPD is not set=0A=
# CONFIG_SYN_COOKIES is not set=0A=
# CONFIG_INET_AH is not set=0A=
# CONFIG_INET_ESP is not set=0A=
# CONFIG_INET_IPCOMP is not set=0A=
# CONFIG_INET_TUNNEL is not set=0A=
CONFIG_IP_TCPDIAG=3Dy=0A=
# CONFIG_IP_TCPDIAG_IPV6 is not set=0A=
# CONFIG_IPV6 is not set=0A=
# CONFIG_NETFILTER is not set=0A=
=0A=
#=0A=
# SCTP Configuration (EXPERIMENTAL)=0A=
#=0A=
# CONFIG_IP_SCTP is not set=0A=
# CONFIG_ATM is not set=0A=
CONFIG_BRIDGE=3Dy=0A=
# CONFIG_VLAN_8021Q is not set=0A=
# CONFIG_DECNET is not set=0A=
CONFIG_LLC=3Dy=0A=
# CONFIG_LLC2 is not set=0A=
CONFIG_IPX=3Dy=0A=
# CONFIG_IPX_INTERN is not set=0A=
CONFIG_ATALK=3Dy=0A=
CONFIG_DEV_APPLETALK=3Dy=0A=
# CONFIG_IPDDP is not set=0A=
# CONFIG_X25 is not set=0A=
# CONFIG_LAPB is not set=0A=
# CONFIG_NET_DIVERT is not set=0A=
# CONFIG_ECONET is not set=0A=
# CONFIG_WAN_ROUTER is not set=0A=
=0A=
#=0A=
# QoS and/or fair queueing=0A=
#=0A=
# CONFIG_NET_SCHED is not set=0A=
# CONFIG_NET_CLS_ROUTE is not set=0A=
=0A=
#=0A=
# Network testing=0A=
#=0A=
# CONFIG_NET_PKTGEN is not set=0A=
# CONFIG_NETPOLL is not set=0A=
# CONFIG_NET_POLL_CONTROLLER is not set=0A=
# CONFIG_HAMRADIO is not set=0A=
# CONFIG_IRDA is not set=0A=
# CONFIG_BT is not set=0A=
CONFIG_NETDEVICES=3Dy=0A=
CONFIG_DUMMY=3Dy=0A=
CONFIG_BONDING=3Dm=0A=
# CONFIG_EQUALIZER is not set=0A=
# CONFIG_TUN is not set=0A=
=0A=
#=0A=
# ARCnet devices=0A=
#=0A=
# CONFIG_ARCNET is not set=0A=
=0A=
#=0A=
# Ethernet (10 or 100Mbit)=0A=
#=0A=
# CONFIG_NET_ETHERNET is not set=0A=
=0A=
#=0A=
# Ethernet (1000 Mbit)=0A=
#=0A=
# CONFIG_ACENIC is not set=0A=
# CONFIG_DL2K is not set=0A=
CONFIG_E1000=3Dy=0A=
# CONFIG_E1000_NAPI is not set=0A=
# CONFIG_NS83820 is not set=0A=
# CONFIG_HAMACHI is not set=0A=
# CONFIG_YELLOWFIN is not set=0A=
# CONFIG_R8169 is not set=0A=
# CONFIG_SK98LIN is not set=0A=
# CONFIG_TIGON3 is not set=0A=
# CONFIG_BNX2 is not set=0A=
=0A=
#=0A=
# Ethernet (10000 Mbit)=0A=
#=0A=
# CONFIG_IXGB is not set=0A=
# CONFIG_S2IO is not set=0A=
=0A=
#=0A=
# Token Ring devices=0A=
#=0A=
# CONFIG_TR is not set=0A=
=0A=
#=0A=
# Wireless LAN (non-hamradio)=0A=
#=0A=
# CONFIG_NET_RADIO is not set=0A=
=0A=
#=0A=
# Wan interfaces=0A=
#=0A=
# CONFIG_WAN is not set=0A=
# CONFIG_FDDI is not set=0A=
# CONFIG_HIPPI is not set=0A=
# CONFIG_PPP is not set=0A=
# CONFIG_SLIP is not set=0A=
# CONFIG_NET_FC is not set=0A=
# CONFIG_SHAPER is not set=0A=
# CONFIG_NETCONSOLE is not set=0A=
=0A=
#=0A=
# ISDN subsystem=0A=
#=0A=
# CONFIG_ISDN is not set=0A=
=0A=
#=0A=
# Telephony Support=0A=
#=0A=
# CONFIG_PHONE is not set=0A=
=0A=
#=0A=
# Input device support=0A=
#=0A=
CONFIG_INPUT=3Dy=0A=
=0A=
#=0A=
# Userland interfaces=0A=
#=0A=
CONFIG_INPUT_MOUSEDEV=3Dy=0A=
CONFIG_INPUT_MOUSEDEV_PSAUX=3Dy=0A=
CONFIG_INPUT_MOUSEDEV_SCREEN_X=3D1024=0A=
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=3D768=0A=
# CONFIG_INPUT_JOYDEV is not set=0A=
# CONFIG_INPUT_TSDEV is not set=0A=
# CONFIG_INPUT_EVDEV is not set=0A=
# CONFIG_INPUT_EVBUG is not set=0A=
=0A=
#=0A=
# Input Device Drivers=0A=
#=0A=
CONFIG_INPUT_KEYBOARD=3Dy=0A=
CONFIG_KEYBOARD_ATKBD=3Dy=0A=
# CONFIG_KEYBOARD_SUNKBD is not set=0A=
# CONFIG_KEYBOARD_LKKBD is not set=0A=
# CONFIG_KEYBOARD_XTKBD is not set=0A=
# CONFIG_KEYBOARD_NEWTON is not set=0A=
CONFIG_INPUT_MOUSE=3Dy=0A=
CONFIG_MOUSE_PS2=3Dy=0A=
CONFIG_MOUSE_SERIAL=3Dy=0A=
CONFIG_MOUSE_VSXXXAA=3Dy=0A=
# CONFIG_INPUT_JOYSTICK is not set=0A=
# CONFIG_INPUT_TOUCHSCREEN is not set=0A=
# CONFIG_INPUT_MISC is not set=0A=
=0A=
#=0A=
# Hardware I/O ports=0A=
#=0A=
CONFIG_SERIO=3Dy=0A=
CONFIG_SERIO_I8042=3Dy=0A=
CONFIG_SERIO_SERPORT=3Dy=0A=
# CONFIG_SERIO_PCIPS2 is not set=0A=
CONFIG_SERIO_LIBPS2=3Dy=0A=
# CONFIG_SERIO_RAW is not set=0A=
# CONFIG_GAMEPORT is not set=0A=
=0A=
#=0A=
# Character devices=0A=
#=0A=
CONFIG_VT=3Dy=0A=
CONFIG_VT_CONSOLE=3Dy=0A=
CONFIG_HW_CONSOLE=3Dy=0A=
# CONFIG_SERIAL_NONSTANDARD is not set=0A=
=0A=
#=0A=
# Serial drivers=0A=
#=0A=
CONFIG_SERIAL_8250=3Dy=0A=
CONFIG_SERIAL_8250_CONSOLE=3Dy=0A=
CONFIG_SERIAL_8250_NR_UARTS=3D2=0A=
CONFIG_SERIAL_8250_EXTENDED=3Dy=0A=
CONFIG_SERIAL_8250_MANY_PORTS=3Dy=0A=
CONFIG_SERIAL_8250_SHARE_IRQ=3Dy=0A=
CONFIG_SERIAL_8250_DETECT_IRQ=3Dy=0A=
CONFIG_SERIAL_8250_MULTIPORT=3Dy=0A=
CONFIG_SERIAL_8250_RSA=3Dy=0A=
=0A=
#=0A=
# Non-8250 serial port support=0A=
#=0A=
CONFIG_SERIAL_CORE=3Dy=0A=
CONFIG_SERIAL_CORE_CONSOLE=3Dy=0A=
# CONFIG_SERIAL_JSM is not set=0A=
CONFIG_UNIX98_PTYS=3Dy=0A=
# CONFIG_LEGACY_PTYS is not set=0A=
=0A=
#=0A=
# IPMI=0A=
#=0A=
# CONFIG_IPMI_HANDLER is not set=0A=
=0A=
#=0A=
# Watchdog Cards=0A=
#=0A=
# CONFIG_WATCHDOG is not set=0A=
# CONFIG_NVRAM is not set=0A=
CONFIG_GEN_RTC=3Dy=0A=
# CONFIG_GEN_RTC_X is not set=0A=
# CONFIG_DTLK is not set=0A=
# CONFIG_R3964 is not set=0A=
# CONFIG_APPLICOM is not set=0A=
=0A=
#=0A=
# Ftape, the floppy tape device driver=0A=
#=0A=
# CONFIG_AGP is not set=0A=
# CONFIG_DRM is not set=0A=
# CONFIG_RAW_DRIVER is not set=0A=
=0A=
#=0A=
# TPM devices=0A=
#=0A=
# CONFIG_TCG_TPM is not set=0A=
=0A=
#=0A=
# I2C support=0A=
#=0A=
# CONFIG_I2C is not set=0A=
=0A=
#=0A=
# Dallas's 1-wire bus=0A=
#=0A=
# CONFIG_W1 is not set=0A=
=0A=
#=0A=
# Misc devices=0A=
#=0A=
=0A=
#=0A=
# Multimedia devices=0A=
#=0A=
# CONFIG_VIDEO_DEV is not set=0A=
=0A=
#=0A=
# Digital Video Broadcasting Devices=0A=
#=0A=
# CONFIG_DVB is not set=0A=
=0A=
#=0A=
# Graphics support=0A=
#=0A=
# CONFIG_FB is not set=0A=
=0A=
#=0A=
# Console display driver support=0A=
#=0A=
CONFIG_VGA_CONSOLE=3Dy=0A=
CONFIG_DUMMY_CONSOLE=3Dy=0A=
=0A=
#=0A=
# Sound=0A=
#=0A=
# CONFIG_SOUND is not set=0A=
=0A=
#=0A=
# USB support=0A=
#=0A=
CONFIG_USB_ARCH_HAS_HCD=3Dy=0A=
CONFIG_USB_ARCH_HAS_OHCI=3Dy=0A=
CONFIG_USB=3Dy=0A=
CONFIG_USB_DEBUG=3Dy=0A=
=0A=
#=0A=
# Miscellaneous USB options=0A=
#=0A=
CONFIG_USB_DEVICEFS=3Dy=0A=
CONFIG_USB_BANDWIDTH=3Dy=0A=
CONFIG_USB_DYNAMIC_MINORS=3Dy=0A=
# CONFIG_USB_OTG is not set=0A=
=0A=
#=0A=
# USB Host Controller Drivers=0A=
#=0A=
# CONFIG_USB_EHCI_HCD is not set=0A=
CONFIG_USB_OHCI_HCD=3Dy=0A=
# CONFIG_USB_OHCI_BIG_ENDIAN is not set=0A=
CONFIG_USB_OHCI_LITTLE_ENDIAN=3Dy=0A=
# CONFIG_USB_UHCI_HCD is not set=0A=
# CONFIG_USB_SL811_HCD is not set=0A=
=0A=
#=0A=
# USB Device Class drivers=0A=
#=0A=
# CONFIG_USB_BLUETOOTH_TTY is not set=0A=
# CONFIG_USB_ACM is not set=0A=
# CONFIG_USB_PRINTER is not set=0A=
=0A=
#=0A=
# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support' may also be =
needed; see USB_STORAGE Help for more information=0A=
#=0A=
# CONFIG_USB_STORAGE is not set=0A=
=0A=
#=0A=
# USB Input Devices=0A=
#=0A=
CONFIG_USB_HID=3Dy=0A=
CONFIG_USB_HIDINPUT=3Dy=0A=
# CONFIG_HID_FF is not set=0A=
# CONFIG_USB_HIDDEV is not set=0A=
# CONFIG_USB_AIPTEK is not set=0A=
# CONFIG_USB_WACOM is not set=0A=
# CONFIG_USB_KBTAB is not set=0A=
# CONFIG_USB_POWERMATE is not set=0A=
# CONFIG_USB_MTOUCH is not set=0A=
# CONFIG_USB_EGALAX is not set=0A=
# CONFIG_USB_XPAD is not set=0A=
# CONFIG_USB_ATI_REMOTE is not set=0A=
=0A=
#=0A=
# USB Imaging devices=0A=
#=0A=
# CONFIG_USB_MDC800 is not set=0A=
# CONFIG_USB_MICROTEK is not set=0A=
=0A=
#=0A=
# USB Multimedia devices=0A=
#=0A=
# CONFIG_USB_DABUSB is not set=0A=
=0A=
#=0A=
# Video4Linux support is needed for USB Multimedia device support=0A=
#=0A=
=0A=
#=0A=
# USB Network Adapters=0A=
#=0A=
# CONFIG_USB_CATC is not set=0A=
# CONFIG_USB_KAWETH is not set=0A=
# CONFIG_USB_PEGASUS is not set=0A=
# CONFIG_USB_RTL8150 is not set=0A=
# CONFIG_USB_USBNET is not set=0A=
# CONFIG_USB_MON is not set=0A=
=0A=
#=0A=
# USB port drivers=0A=
#=0A=
=0A=
#=0A=
# USB Serial Converter support=0A=
#=0A=
CONFIG_USB_SERIAL=3Dm=0A=
# CONFIG_USB_SERIAL_GENERIC is not set=0A=
# CONFIG_USB_SERIAL_AIRPRIME is not set=0A=
# CONFIG_USB_SERIAL_BELKIN is not set=0A=
# CONFIG_USB_SERIAL_WHITEHEAT is not set=0A=
# CONFIG_USB_SERIAL_DIGI_ACCELEPORT is not set=0A=
# CONFIG_USB_SERIAL_CP2101 is not set=0A=
# CONFIG_USB_SERIAL_CYPRESS_M8 is not set=0A=
# CONFIG_USB_SERIAL_EMPEG is not set=0A=
# CONFIG_USB_SERIAL_FTDI_SIO is not set=0A=
CONFIG_USB_SERIAL_VISOR=3Dm=0A=
# CONFIG_USB_SERIAL_IPAQ is not set=0A=
# CONFIG_USB_SERIAL_IR is not set=0A=
# CONFIG_USB_SERIAL_EDGEPORT is not set=0A=
# CONFIG_USB_SERIAL_EDGEPORT_TI is not set=0A=
# CONFIG_USB_SERIAL_GARMIN is not set=0A=
# CONFIG_USB_SERIAL_IPW is not set=0A=
# CONFIG_USB_SERIAL_KEYSPAN_PDA is not set=0A=
# CONFIG_USB_SERIAL_KEYSPAN is not set=0A=
# CONFIG_USB_SERIAL_KLSI is not set=0A=
# CONFIG_USB_SERIAL_KOBIL_SCT is not set=0A=
# CONFIG_USB_SERIAL_MCT_U232 is not set=0A=
# CONFIG_USB_SERIAL_PL2303 is not set=0A=
# CONFIG_USB_SERIAL_HP4X is not set=0A=
# CONFIG_USB_SERIAL_SAFE is not set=0A=
# CONFIG_USB_SERIAL_TI is not set=0A=
# CONFIG_USB_SERIAL_CYBERJACK is not set=0A=
# CONFIG_USB_SERIAL_XIRCOM is not set=0A=
# CONFIG_USB_SERIAL_OMNINET is not set=0A=
=0A=
#=0A=
# USB Miscellaneous drivers=0A=
#=0A=
# CONFIG_USB_EMI62 is not set=0A=
# CONFIG_USB_EMI26 is not set=0A=
# CONFIG_USB_AUERSWALD is not set=0A=
# CONFIG_USB_RIO500 is not set=0A=
# CONFIG_USB_LEGOTOWER is not set=0A=
# CONFIG_USB_LCD is not set=0A=
# CONFIG_USB_LED is not set=0A=
# CONFIG_USB_CYTHERM is not set=0A=
# CONFIG_USB_PHIDGETKIT is not set=0A=
# CONFIG_USB_PHIDGETSERVO is not set=0A=
CONFIG_USB_IDMOUSE=3Dy=0A=
# CONFIG_USB_TEST is not set=0A=
=0A=
#=0A=
# USB ATM/DSL drivers=0A=
#=0A=
=0A=
#=0A=
# USB Gadget Support=0A=
#=0A=
# CONFIG_USB_GADGET is not set=0A=
# CONFIG_USB_GADGET_NET2280 is not set=0A=
# CONFIG_USB_GADGET_PXA2XX is not set=0A=
# CONFIG_USB_GADGET_GOKU is not set=0A=
# CONFIG_USB_GADGET_LH7A40X is not set=0A=
# CONFIG_USB_GADGET_OMAP is not set=0A=
# CONFIG_USB_GADGET_DUMMY_HCD is not set=0A=
# CONFIG_USB_ZERO is not set=0A=
# CONFIG_USB_ETH is not set=0A=
# CONFIG_USB_GADGETFS is not set=0A=
# CONFIG_USB_FILE_STORAGE is not set=0A=
# CONFIG_USB_G_SERIAL is not set=0A=
=0A=
#=0A=
# MMC/SD Card support=0A=
#=0A=
# CONFIG_MMC is not set=0A=
=0A=
#=0A=
# InfiniBand support=0A=
#=0A=
# CONFIG_INFINIBAND is not set=0A=
=0A=
#=0A=
# File systems=0A=
#=0A=
CONFIG_EXT2_FS=3Dy=0A=
CONFIG_EXT2_FS_XATTR=3Dy=0A=
CONFIG_EXT2_FS_POSIX_ACL=3Dy=0A=
# CONFIG_EXT2_FS_SECURITY is not set=0A=
CONFIG_EXT3_FS=3Dy=0A=
CONFIG_EXT3_FS_XATTR=3Dy=0A=
CONFIG_EXT3_FS_POSIX_ACL=3Dy=0A=
# CONFIG_EXT3_FS_SECURITY is not set=0A=
CONFIG_JBD=3Dy=0A=
# CONFIG_JBD_DEBUG is not set=0A=
CONFIG_FS_MBCACHE=3Dy=0A=
# CONFIG_REISERFS_FS is not set=0A=
# CONFIG_JFS_FS is not set=0A=
CONFIG_FS_POSIX_ACL=3Dy=0A=
=0A=
#=0A=
# XFS support=0A=
#=0A=
# CONFIG_XFS_FS is not set=0A=
# CONFIG_MINIX_FS is not set=0A=
CONFIG_ROMFS_FS=3Dy=0A=
CONFIG_QUOTA=3Dy=0A=
# CONFIG_QFMT_V1 is not set=0A=
# CONFIG_QFMT_V2 is not set=0A=
CONFIG_QUOTACTL=3Dy=0A=
CONFIG_DNOTIFY=3Dy=0A=
# CONFIG_AUTOFS_FS is not set=0A=
# CONFIG_AUTOFS4_FS is not set=0A=
=0A=
#=0A=
# CD-ROM/DVD Filesystems=0A=
#=0A=
CONFIG_ISO9660_FS=3Dy=0A=
CONFIG_JOLIET=3Dy=0A=
# CONFIG_ZISOFS is not set=0A=
CONFIG_UDF_FS=3Dm=0A=
CONFIG_UDF_NLS=3Dy=0A=
=0A=
#=0A=
# DOS/FAT/NT Filesystems=0A=
#=0A=
# CONFIG_MSDOS_FS is not set=0A=
# CONFIG_VFAT_FS is not set=0A=
# CONFIG_NTFS_FS is not set=0A=
=0A=
#=0A=
# Pseudo filesystems=0A=
#=0A=
CONFIG_PROC_FS=3Dy=0A=
CONFIG_PROC_KCORE=3Dy=0A=
CONFIG_SYSFS=3Dy=0A=
# CONFIG_DEVFS_FS is not set=0A=
# CONFIG_DEVPTS_FS_XATTR is not set=0A=
CONFIG_TMPFS=3Dy=0A=
# CONFIG_TMPFS_XATTR is not set=0A=
# CONFIG_HUGETLB_PAGE is not set=0A=
CONFIG_RAMFS=3Dy=0A=
=0A=
#=0A=
# Miscellaneous filesystems=0A=
#=0A=
# CONFIG_ADFS_FS is not set=0A=
# CONFIG_AFFS_FS is not set=0A=
# CONFIG_HFS_FS is not set=0A=
# CONFIG_HFSPLUS_FS is not set=0A=
# CONFIG_BEFS_FS is not set=0A=
# CONFIG_BFS_FS is not set=0A=
# CONFIG_EFS_FS is not set=0A=
# CONFIG_JFFS_FS is not set=0A=
# CONFIG_JFFS2_FS is not set=0A=
# CONFIG_CRAMFS is not set=0A=
# CONFIG_VXFS_FS is not set=0A=
# CONFIG_HPFS_FS is not set=0A=
# CONFIG_QNX4FS_FS is not set=0A=
# CONFIG_SYSV_FS is not set=0A=
# CONFIG_UFS_FS is not set=0A=
=0A=
#=0A=
# Network File Systems=0A=
#=0A=
CONFIG_NFS_FS=3Dy=0A=
CONFIG_NFS_V3=3Dy=0A=
# CONFIG_NFS_V4 is not set=0A=
# CONFIG_NFS_DIRECTIO is not set=0A=
CONFIG_NFSD=3Dy=0A=
CONFIG_NFSD_V3=3Dy=0A=
# CONFIG_NFSD_V4 is not set=0A=
CONFIG_NFSD_TCP=3Dy=0A=
CONFIG_LOCKD=3Dy=0A=
CONFIG_LOCKD_V4=3Dy=0A=
CONFIG_EXPORTFS=3Dy=0A=
CONFIG_SUNRPC=3Dy=0A=
# CONFIG_RPCSEC_GSS_KRB5 is not set=0A=
# CONFIG_RPCSEC_GSS_SPKM3 is not set=0A=
CONFIG_SMB_FS=3Dy=0A=
# CONFIG_SMB_NLS_DEFAULT is not set=0A=
CONFIG_CIFS=3Dy=0A=
CONFIG_CIFS_STATS=3Dy=0A=
# CONFIG_CIFS_XATTR is not set=0A=
# CONFIG_CIFS_EXPERIMENTAL is not set=0A=
# CONFIG_NCP_FS is not set=0A=
# CONFIG_CODA_FS is not set=0A=
# CONFIG_AFS_FS is not set=0A=
=0A=
#=0A=
# Partition Types=0A=
#=0A=
# CONFIG_PARTITION_ADVANCED is not set=0A=
CONFIG_MSDOS_PARTITION=3Dy=0A=
=0A=
#=0A=
# Native Language Support=0A=
#=0A=
CONFIG_NLS=3Dy=0A=
CONFIG_NLS_DEFAULT=3D"iso8859-1"=0A=
CONFIG_NLS_CODEPAGE_437=3Dy=0A=
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
CONFIG_NLS_CODEPAGE_936=3Dy=0A=
CONFIG_NLS_CODEPAGE_950=3Dy=0A=
CONFIG_NLS_CODEPAGE_932=3Dy=0A=
CONFIG_NLS_CODEPAGE_949=3Dy=0A=
# CONFIG_NLS_CODEPAGE_874 is not set=0A=
# CONFIG_NLS_ISO8859_8 is not set=0A=
# CONFIG_NLS_CODEPAGE_1250 is not set=0A=
# CONFIG_NLS_CODEPAGE_1251 is not set=0A=
# CONFIG_NLS_ASCII is not set=0A=
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
# Library routines=0A=
#=0A=
CONFIG_CRC_CCITT=3Dm=0A=
CONFIG_CRC32=3Dy=0A=
# CONFIG_LIBCRC32C is not set=0A=
=0A=
#=0A=
# Profiling support=0A=
#=0A=
# CONFIG_PROFILING is not set=0A=
=0A=
#=0A=
# Kernel hacking=0A=
#=0A=
# CONFIG_PRINTK_TIME is not set=0A=
# CONFIG_DEBUG_KERNEL is not set=0A=
CONFIG_LOG_BUF_SHIFT=3D14=0A=
# CONFIG_SERIAL_TEXT_DEBUG is not set=0A=
CONFIG_PPC_OCP=3Dy=0A=
=0A=
#=0A=
# Security options=0A=
#=0A=
# CONFIG_KEYS is not set=0A=
# CONFIG_SECURITY is not set=0A=
=0A=
#=0A=
# Cryptographic options=0A=
#=0A=
# CONFIG_CRYPTO is not set=0A=
=0A=
#=0A=
# Hardware crypto devices=0A=
#=0A=

------=_NextPart_000_0063_01C5A80A.150DEA60
Content-Type: application/octet-stream;
	name="Kernel_Oops"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="Kernel_Oops"

Linux version 2.6.12.3 (johnsoncheng@RISC-Srv.qnap.com.tw) (gcc version =
3.4.3) #24 Tue Aug 23 17:23:11 CST 2005=0A=
=0DMotorola SPS Sandpoint Test Platform=0A=
=0DPort by MontaVista Software, Inc. (source@mvista.com)=0A=
=0DBuilt 1 zonelists=0A=
=0DKernel command line: console=3DttyS0,115200n8 root=3D/dev/ram=0A=
=0DOpenPIC Version 1.2 (1 CPUs and 9 IRQ sources) at fdf40000=0A=
=0DPID hash table entries: 512 (order: 9, 8192 bytes)=0A=
=0DTODC real-time-clock was stopped. Now starting...=0A=
=0Dtime_init: decrementer frequency =3D 33.000000 MHz=0A=
=0DWarning: real time clock seems stuck!=0A=
=0DConsole: colour dummy device 80x25=0A=
=0DDentry cache hash table entries: 16384 (order: 4, 65536 bytes)=0A=
=0DInode-cache hash table entries: 8192 (order: 3, 32768 bytes)=0A=
=0DMemory: 59392k available (2328k kernel code, 1324k data, 108k init, =
0k highmem)=0A=
=0DMount-cache hash table entries: 512=0A=
=0Dchecking if image is initramfs...it isn't (no cpio magic); looks like =
an initrd=0A=
=0DFreeing initrd memory: 1621k freed=0A=
=0DNET: Registered protocol family 16=0A=
=0DPCI: Probing PCI hardware=0A=
=0DPCI: Cannot allocate resource region 1 of device 0000:00:00.0=0A=
=0DSCSI subsystem initialized=0A=
=0Dusbcore: registered new driver usbfs=0A=
=0Dusbcore: registered new driver hub=0A=
=0DVFS: Disk quotas dquot_6.5.1=0A=
=0DDquot-cache hash table entries: 1024 (order 0, 4096 bytes)=0A=
=0DInstalling knfsd (copyright (C) 1996 okir@monad.swb.de).=0A=
=0DGeneric RTC Driver v1.07=0A=
=0Di8042.c: No controller found.=0A=
=0DSerial: 8250/16550 driver $Revision: 1.1.1.1 $ 4 ports, IRQ sharing =
enabled=0A=
=0D=FFttyS0 at MMIO 0x0 (irq =3D 0) is a 16550A=0A=
=0DttyS1 at MMIO 0x0 (irq =3D 0) is a 16550A=0A=
=0Dio scheduler noop registered=0A=
=0Dio scheduler anticipatory registered=0A=
=0Dio scheduler deadline registered=0A=
=0Dio scheduler cfq registered=0A=
=0DRAMDISK driver initialized: 16 RAM disks of 40960K size 1024 blocksize=0A=
=0Dloop: loaded (max 8 devices)=0A=
=0DIntel(R) PRO/1000 Network Driver - version 6.0.54-k2=0A=
=0DCopyright (c) 1999-2004 Intel Corporation.=0A=
=0De1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection=0A=
=0Dsata_sil(0000:00:0d.0): cache line size not set.  Driver may not =
function=0A=
=0Data1: SATA max UDMA/100 cmd 0xC5022E80 ctl 0xC5022E8A bmdma =
0xC5022E00 irq 16=0A=
=0Data2: SATA max UDMA/100 cmd 0xC5022EC0 ctl 0xC5022ECA bmdma =
0xC5022E08 irq 16=0A=
=0Data1: dev 0 ATA, max UDMA/133, 312581808 sectors: lba48=0A=
=0Data1: dev 0 configured for UDMA/100=0A=
=0Dscsi0 : sata_sil=0A=
=0Data2: no device found (phy stat 00000000)=0A=
=0Dscsi1 : sata_sil=0A=
=0D  Vendor: ATA       Model: ST3160827AS       Rev: 3.42=0A=
=0D  Type:   Direct-Access                      ANSI SCSI revision: 05=0A=
=0DSCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)=0A=
=0DSCSI device sda: drive cache: write back=0A=
=0DSCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)=0A=
=0DSCSI device sda: drive cache: write back=0A=
=0D sda: unknown partition table=0A=
=0DAttached scsi disk sda at scsi0, channel 0, id 0, lun 0=0A=
=0DAttached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0=0A=
=0Dregister_mtd_user =0A=
=0Dphysmap flash device: 1000000 at ff000000=0A=
=0Dphys_mapped_flash: Found 2 x8 devices at 0x0 in 16-bit bank=0A=
=0D Amd/Fujitsu Extended Query Table at 0x0040=0A=
=0DUsing buffer write method=0A=
=0Dphys_mapped_flash: CFI does not contain boot bank location. Assuming =
top.=0A=
=0Dnumber of CFI chips: 1=0A=
=0Dcfi_cmdset_0002: Disabling erase-suspend-program due to code =
brokenness.=0A=
=0Dcmdlinepart partition parsing not available=0A=
=0DRedBoot partition parsing not available=0A=
=0Dmtd_parts_nd =3D 0=0A=
=0Dnum_physmap_partitions =3D 0=0A=
=0Dnum_physmap_partitions =3D 5=0A=
=0DUsing physmap partition definition=0A=
=0DCreating 5 MTD partitions on "phys_mapped_flash":=0A=
=0D0x00f00000-0x00f40000 : "U-Boot"=0A=
=0Dslave offset: 0xf00000, master size: 0x2000000=0A=
=0Dadd_mtd_device: (MAX_MTD_DEVICES: 16)=0A=
=0Dmtd: Giving out device 0 to U-Boot=0A=
=0D0x00000000-0x00200000 : "kernel"=0A=
=0Dslave offset: 0x0, master size: 0x2000000=0A=
=0Dadd_mtd_device: (MAX_MTD_DEVICES: 16)=0A=
=0Dmtd: Giving out device 1 to kernel=0A=
=0D0x00200000-0x00a00000 : "initrd"=0A=
=0Dslave offset: 0x200000, master size: 0x2000000=0A=
=0Dadd_mtd_device: (MAX_MTD_DEVICES: 16)=0A=
=0Dmtd: Giving out device 2 to initrd=0A=
=0D0x00a00000-0x00b00000 : "Config"=0A=
=0Dslave offset: 0xa00000, master size: 0x2000000=0A=
=0Dadd_mtd_device: (MAX_MTD_DEVICES: 16)=0A=
=0Dmtd: Giving out device 3 to Config=0A=
=0D0xc02745c0-0x804e8be0 : "cfi_probe"=0A=
=0Dslave offset: 0xc02745c0, master size: 0x2000000=0A=
=0Dmtd: partition "cfi_probe" is out of reach -- disabled=0A=
=0Dohci_hcd 0000:00:0e.0: NEC Corporation USB=0A=
=0Dohci_hcd 0000:00:0e.0: new USB bus registered, assigned bus number 1=0A=
=0Dohci_hcd 0000:00:0e.0: request interrupt 17 failed=0A=
=0Dohci_hcd 0000:00:0e.0: USB bus 1 deregistered=0A=
=0Dohci_hcd 0000:00:0e.0: init 0000:00:0e.0 fail, -16=0A=
=0Dohci_hcd: probe of 0000:00:0e.0 failed with error -16=0A=
=0Dohci_hcd 0000:00:0e.1: NEC Corporation USB (#2)=0A=
=0Dohci_hcd 0000:00:0e.1: new USB bus registered, assigned bus number 1=0A=
=0Dohci_hcd 0000:00:0e.1: irq 18, io mem 0xbfffd000=0A=
=0Dusb usb1: Product: NEC Corporation USB (#2)=0A=
=0Dusb usb1: Manufacturer: Linux 2.6.12.3 ohci_hcd=0A=
=0Dusb usb1: SerialNumber: 0000:00:0e.1=0A=
=0Dhub 1-0:1.0: USB hub found=0A=
=0Dhub 1-0:1.0: 2 ports detected=0A=
=0Dusbcore: registered new driver usbhid=0A=
=0Ddrivers/usb/input/hid-core.c: v2.01:USB HID core driver=0A=
=0Ddrivers/usb/misc/idmouse.c: Siemens ID Mouse FingerTIP Sensor Driver =
0.5=0A=
=0Dusbcore: registered new driver idmouse=0A=
=0Dmice: PS/2 mouse device common for all mice=0A=
=0DNET: Registered protocol family 2=0A=
=0DIP: routing cache hash table of 512 buckets, 4Kbytes=0A=
=0DTCP established hash table entries: 4096 (order: 3, 32768 bytes)=0A=
=0DTCP bind hash table entries: 4096 (order: 2, 16384 bytes)=0A=
=0DTCP: Hash tables configured (established 4096 bind 4096)=0A=
=0DNET: Registered protocol family 1=0A=
=0DNET: Registered protocol family 17=0A=
=0DNET: Registered protocol family 4=0A=
=0DNET: Registered protocol family 5=0A=
=0DRAMDISK: Compressed image found at block 0=0A=
=0DVFS: Mounted root (ext2 filesystem) readonly.=0A=
=0DFreeing unused kernel memory: 108k init=0A=
=0DEXT2-fs warning: checktime reached, running e2fsck is recommended=0A=
=0DInitializing random number generator... done.
Starting network...
run-parts: failed to open directory /etc/network/if-pre-up.d: No such =
file or directory
udhcpc e1000: eth0: e1000_watchdog_task: NIC Link is Up 100 Mbps Full =
Duplex=0A=
=0D(v0.9.9-pre) started
Jan 12 08:58:13 udhcpc[233]: udhcpc (v0.9.9-pre) started=0D
Sending discover...
Jan 12 08:58:13 udhcpc[233]: Sending discover...=0D
Sending select for 10.8.12.17...
Jan 12 08:58:13 udhcpc[233]: Sending select for 10.8.12.17...=0D
Lease of 10.8.12.17 obtained, lease time 691200
Jan 12 08:58:13 udhcpc[233]: Lease of 10.8.12.17 obtained, lease time =
691200=0D
deleting routers
route: SIOC[ADD|DEL]RT: No such pro
=0A=

=0DWelcome to the Erik's uClibc development environment.=0A=

=0D(none) login: root


BusyBox v1.00 (2005.06.16-05:15+0000) Built-in shell (ash)
Enter 'help' for a list of built-in commands.

# usb 1-2: new low speed USB device using ohci_hcd and address 2=0A=
=0Dillegal vector 255 received!=0A=
=0Dkernel BUG in ack_bad_irq at include/asm/hardirq.h:27!=0A=
=0DOops: Exception in kernel mode, sig: 5 [#1]=0A=
=0DNIP: C0034F50 LR: C0034F50 SP: C0379E90 REGS: c0379de0 TRAP: 0700    =
Not tainted=0A=
=0DMSR: 00021032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11=0A=
=0DTASK =3D c0299ac0[0] 'swapper' THREAD: c0378000=0A=
=0DLast syscall: 120 =0A=
=0DGPR00: C0034F50 C0379E90 C0299AC0 00000023 C0398714 00000000 C03926A0 =
00354E88 =0A=
=0DGPR08: C0398718 C03745D8 C3F71EFC C03745D8 00007936 10003000 03FE4000 =
007FFF24 =0A=
=0DGPR16: 00000000 00000001 007FFF00 FFFFFFFF 03FDFCA8 00000000 00000003 =
03F1FE40 =0A=
=0DGPR24: 00000000 007FFEC0 40000000 C0379EF0 C0375000 000000FF 00000000 =
C0376FE0 =0A=
=0DNIP [c0034f50] ack_none+0x1c/0x30=0A=
=0DLR [c0034f50] ack_none+0x1c/0x30=0A=
=0DCall trace:=0A=
=0D [c00350f8] __do_IRQ+0xb0/0x160=0A=
=0D [c0005a9c] do_IRQ+0x38/0x98=0A=
=0D [c0004a74] ret_from_except+0x0/0x14=0A=
=0D [c0003568] ppc6xx_idle+0xe4/0xf0=0A=
=0D [c0005b80] cpu_idle+0x28/0x44=0A=
=0D [c0003884] rest_init+0x24/0x34=0A=
=0D [c037a63c] start_kernel+0x174/0x1ac=0A=
=0D [000032c4] 0x32c4=0A=
=0Dillegal vector 255 received!=0A=
=0Dkernel BUG in ack_bad_irq at include/asm/hardirq.h:27!=0A=
=0DOops: Exception in kernel mode, sig: 5 [#2]=0A=
=0DNIP: C0034F50 LR: C0034F50 SP: C0379C10 REGS: c0379b60 TRAP: 0700    =
Not tainted=0A=
=0DMSR: 00021032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11=0A=
=0DTASK =3D c0299ac0[0] 'swapper' THREAD: c0378000=0A=
=0DLast syscall: 120 =0A=
=0DGPR00: C0034F50 C0379C10 C0299AC0 00000023 0000252B FFFFFFFF C0390000 =
C029B484 =0A=
=0DGPR08: C02A0000 C0370000 00000000 C0390000 00000000 10003000 03FE4000 =
007FFF24 =0A=
=0DGPR16: 00000000 00000001 007FFF00 FFFFFFFF 03FDFCA8 00000000 00000003 =
03F1FE40 =0A=
=0DGPR24: 00000000 007FFEC0 40000000 C0379C70 C0375000 000000FF 00000000 =
C0376FE0 =0A=
=0DNIP [c0034f50] ack_none+0x1c/0x30=0A=
=0DLR [c0034f50] ack_none+0x1c/0x30=0A=
=0DCall trace:=0A=
=0D [c00350f8] __do_IRQ+0xb0/0x160=0A=
=0D [c0005a9c] do_IRQ+0x38/0x98=0A=
=0D [c0004a74] ret_from_except+0x0/0x14=0A=
=0D [c0004d34] die+0x7c/0x80=0A=
=0D [c0004da8] _exception+0x70/0xa8=0A=
=0D [c0004a28] ret_from_except_full+0x0/0x4c=0A=
=0D [c0034f50] ack_none+0x1c/0x30=0A=
=0D [c00350f8] __do_IRQ+0xb0/0x160=0A=
=0D [c0005a9c] do_IRQ+0x38/0x98=0A=
=0D [c0004a74] ret_from_except+0x0/0x14=0A=
=0D [c0003568] ppc6xx_idle+0xe4/0xf0=0A=
=0D [c0005b80] cpu_idle+0x28/0x44=0A=
=0D [c0003884] rest_init+0x24/0x34=0A=
=0D [c037a63c] start_kernel+0x174/0x1ac=0A=
=0D [000032c4] 0x32c4=0A=
=0Dillegal vector 255 received!=0A=
=0Dkernel BUG in ack_bad_irq at include/asm/hardirq.h:27!=0A=
=0DOops: Exception in kernel mode, sig: 5 [#3]=0A=
=0DNIP: C0034F50 LR: C0034F50 SP: C0379990 REGS: c03798e0 TRAP: 0700    =
Not tainted=0A=
=0DMSR: 00021032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11=0A=
=0DTASK =3D c0299ac0[0] 'swapper' THREAD: c0378000=0A=
=0DLast syscall: 120 =0A=
=0DGPR00: C0034F50 C0379990 C0299AC0 00000023 00002A34 FFFFFFFF C0390000 =
C029B484 =0A=
=0DGPR08: C02A0000 C0370000 00000000 C0390000 00000000 10003000 03FE4000 =
007FFF24 =0A=
=0DGPR16: 00000000 00000001 007FFF00 FFFFFFFF 03FDFCA8 00000000 00000003 =
03F1FE40 =0A=
=0DGPR24: 00000000 007FFEC0 40000000 C03799F0 C0375000 000000FF 00000000 =
C0376FE0 =0A=
=0DNIP [c0034f50] ack_none+0x1c/0x30=0A=
=0DLR [c0034f50] ack_none+0x1c/0x30=0A=
=0DCall trace:=0A=
=0D [c00350f8] __do_IRQ+0xb0/0x160=0A=
=0D [c0005a9c] do_IRQ+0x38/0x98=0A=
=0D [c0004a74] ret_from_except+0x0/0x14=0A=
=0D [c0004d34] die+0x7c/0x80=0A=
=0D [c0004da8] _exception+0x70/0xa8=0A=
=0D [c0004a28] ret_from_except_full+0x0/0x4c=0A=
=0D [c0034f50] ack_none+0x1c/0x30=0A=
=0D [c00350f8] __do_IRQ+0xb0/0x160=0A=
=0D [c0005a9c] do_IRQ+0x38/0x98=0A=
=0D [c0004a74] ret_from_except+0x0/0x14=0A=
=0D [c0004d34] die+0x7c/0x80=0A=
=0D [c0004da8] _exception+0x70/0xa8=0A=
=0D [c0004a28] ret_from_except_full+0x0/0x4c=0A=
=0D [c0034f50] ack_none+0x1c/0x30=0A=
=0D [c00350f8] __do_IRQ+0xb0/0x160=0A=
=0Dillegal vector 255 received!=0A=
=0Dkernel BUG in ack_bad_irq at include/asm/hardirq.h:27!=0A=
=0DOops: Exception in kernel mode, sig: 5 [#4]=0A=
=0DNIP: C0034F50 LR: C0034F50 SP: C0379710 REGS: c0379660 TRAP: 0700    =
Not tainted=0A=
=0DMSR: 00021032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11=0A=
=0DTASK =3D c0299ac0[0] 'swapper' THREAD: c0378000=0A=
=0DLast syscall: 120 =0A=
=0DGPR00: C0034F50 C0379710 C0299AC0 00000023 00002F48 FFFFFFFF C0390000 =
C029B484 =0A=
=0DGPR08: C02A0000 C0370000 00000000 C0390000 00000000 10003000 03FE4000 =
007FFF24 =0A=
=0DGPR16: 00000000 00000001 007FFF00 FFFFFFFF 03FDFCA8 00000000 00000003 =
03F1FE40 =0A=
=0DGPR24: 00000000 007FFEC0 40000000 C0379770 C0375000 000000FF 00000000 =
C0376FE0 =0A=
=0DNIP [c0034f50] ack_none+0x1c/0x30=0A=
=0DLR [c0034f50] ack_none+0x1c/0x30=0A=
=0DCall trace:=0A=
=0D [c00350f8] __do_IRQ+0xb0/0x160=0A=
=0D [c0005a9c] do_IRQ+0x38/0x98=0A=
=0D [c0004a74] ret_from_except+0x0/0x14=0A=
=0D [c0004d34] die+0x7c/0x80=0A=
=0D [c0004da8] _exception+0x70/0xa8=0A=
=0D [c0004a28] ret_from_except_full+0x0/0x4c=0A=
=0D [c0034f50] ack_none+0x1c/0x30=0A=
=0D [c00350f8] __do_IRQ+0xb0/0x160=0A=
=0D [c0005a9c] do_IRQ+0x38/0x98=0A=
=0D [c0004a74] ret_from_except+0x0/0x14=0A=
=0D [c0004d34] die+0x7c/0x80=0A=
=0D [c0004da8] _exception+0x70/0xa8=0A=
=0D [c0004a28] ret_from_except_full+0x0/0x4c=0A=
=0D [c0034f50] ack_none+0x1c/0x30=0A=
=0D [c00350f8] __do_IRQ+0xb0/0x160=0A=
=0Dillegal vector 255 received!=0A=
=0Dkernel BUG in ack_bad_irq at include/asm/hardirq.h:27!=0A=
=0DOops: Exception in kernel mode, sig: 5 [#5]=0A=
=0DNIP: C0034F50 LR: C0034F50 SP: C0379490 REGS: c03793e0 TRAP: 0700    =
Not tainted=0A=
=0DMSR: 00021032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11=0A=
=0DTASK =3D c0299ac0[0] 'swapper' THREAD: c0378000=0A=
=0DLast syscall: 120 =0A=
=0DGPR00: C0034F50 C0379490 C0299AC0 00000023 0000345C FFFFFFFF C0390000 =
C029B484 =0A=
=0DGPR08: C02A0000 C0370000 00000000 C0390000 00000000 10003000 03FE4000 =
007FFF24 =0A=
=0DGPR16: 00000000 00000001 007FFF00 FFFFFFFF 03FDFCA8 00000000 00000003 =
03F1FE40 =0A=
=0DGPR24: 00000000 007FFEC0 40000000 C03794F0 C0375000 000000FF 00000000 =
C0376FE0 =0A=
=0DNIP [c0034f50] ack_none+0x1c/0x30=0A=
=0DLR [c0034f50] ack_none+0x1c/0x30=0A=
=0DCall trace:=0A=
=0D [c00350f8] __do_IRQ+0xb0/0x160=0A=
=0D [c0005a9c] do_IRQ+0x38/0x98=0A=
=0D [c0004a74] ret_from_except+0x0/0x14=0A=
=0D [c0004d34] die+0x7c/0x80=0A=
=0D [c0004da8] _exception+0x70/0xa8=0A=
=0D [c0004a28] ret_from_except_full+0x0/0x4c=0A=
=0D [c0034f50] ack_none+0x1c/0x30=0A=
=0D [c00350f8] __do_IRQ+0xb0/0x160=0A=
=0D [c0005a9c] do_IRQ+0x38/0x98=0A=
=0D [c0004a74] ret_from_except+0x0/0x14=0A=
=0D [c0004d34] die+0x7c/0x80=0A=
=0D [c0004da8] _exception+0x70/0xa8=0A=
=0D [c0004a28] ret_from_except_full+0x0/0x4c=0A=
=0D [c0034f50] ack_none+0x1c/0x30=0A=
=0D [c00350f8] __do_IRQ+0xb0/0x160=0A=
=0Dillegal vector 255 received!=0A=
=0Dkernel BUG in ack_bad_irq at include/asm/hardirq.h:27!=0A=
=0DOops: Exception in kernel mode, sig: 5 [#6]=0A=
=0DNIP: C0034F50 LR: C0034F50 SP: C0379210 REGS: c0379160 TRAP: 0700    =
Not tainted=0A=
=0DMSR: 00021032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11=0A=
=0DTASK =3D c0299ac0[0] 'swapper' THREAD: c0378000=0A=
=0DLast syscall: 120 =0A=
=0DGPR00: C0034F50 C0379210 C0299AC0 00000023 00003970 FFFFFFFF C0390000 =
C029B484 =0A=
=0DGPR08: C02A0000 C0370000 00000000 C0390000 00000000 10003000 03FE4000 =
007FFF24 =0A=
=0DGPR16: 00000000 00000001 007FFF00 FFFFFFFF 03FDFCA8 00000000 00000003 =
03F1FE40 =0A=
=0DGPR24: 00000000 007FFEC0 40000000 C0379270 C0375000 000000FF 00000000 =
C0376FE0 =0A=
=0DNIP [c0034f50] ack_none+0x1c/0x30=0A=
=0DLR [c0034f50] ack_none+0x1c/0x30=0A=
=0DCall trace:=0A=
=0D [c00350f8] __do_IRQ+0xb0/0x160=0A=
=0D [c0005a9c] do_IRQ+0x38/0x98=0A=
=0D [c0004a74] ret_from_except+0x0/0x14=0A=
=0D [c0004d34] die+0x7c/0x80=0A=
=0D [c0004da8] _exception+0x70/0xa8=0A=
=0D [c0004a28] ret_from_except_full+0x0/0x4c=0A=
=0D [c0034f50] ack_none+0x1c/0x30=0A=
=0D [c00350f8] __do_IRQ+0xb0/0x160=0A=
=0D [c0005a9c] do_IRQ+0x38/0x98=0A=
=0D [c0004a74] ret_from_except+0x0/0x14=0A=
=0D [c0004d34] die+0x7c/0x80=0A=
=0D [c0004da8] _exception+0x70/0xa8=0A=
=0D [c0004a28] ret_from_except_full+0x0/0x4c=0A=
=0D [c0034f50] ack_none+0x1c/0x30=0A=
=0D [c00350f8] __do_IRQ+0xb0/0x160=0A=
=0Dillegal vector 255 received!=0A=
=0Dkernel BUG in ack_bad_irq at include/asm/hardirq.h:27!=0A=
=0DOops: Exception in kernel mode, sig: 5 [#7]=0A=
=0DNIP: C0034F50 LR: C0034F50 SP: C0378F90 REGS: c0378ee0 TRAP: 0700    =
Not tainted=0A=
=0DMSR: 00021032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11=0A=
=0DTASK =3D c0299ac0[0] 'swapper' THREAD: c0378000=0A=
=0DLast syscall: 120 =0A=
=0DGPR00: C0034F50 C0378F90 C0299AC0 00000023 00003E84 FFFFFFFF C0390000 =
C029B484 =0A=
=0DGPR08: C02A0000 C0370000 00000000 C0390000 00000000 10003000 03FE4000 =
007FFF24 =0A=
=0DGPR16: 00000000 00000001 007FFF00 FFFFFFFF 03FDFCA8 00000000 00000003 =
03F1FE40 =0A=
=0DGPR24: 00000000 007FFEC0 40000000 C0378FF0 C0375000 000000FF 00000000 =
C0376FE0 =0A=
=0DNIP [c0034f50] ack_none+0x1c/0x30=0A=
=0DLR [c0034f50] ack_none+0x1c/0x30=0A=
=0DCall trace:=0A=
=0D [c00350f8] __do_IRQ+0xb0/0x160=0A=
=0D [c0005a9c] do_IRQ+0x38/0x98=0A=
=0D [c0004a74] ret_from_except+0x0/0x14=0A=
=0D [c0004d34] die+0x7c/0x80=0A=
=0D [c0004da8] _exception+0x70/0xa8=0A=
=0D [c0004a28] ret_from_except_full+0x0/0x4c=0A=
=0D [c0034f50] ack_none+0x1c/0x30=0A=
=0D [c00350f8] __do_IRQ+0xb0/0x160=0A=
=0D [c0005a9c] do_IRQ+0x38/0x98=0A=
=0D [c0004a74] ret_from_except+0x0/0x14=0A=
=0D [c0004d34] die+0x7c/0x80=0A=
=0D [c0004da8] _exception+0x70/0xa8=0A=
=0D [c0004a28] ret_from_except_full+0x0/0x4c=0A=
=0D [c0034f50] ack_none+0x1c/0x30=0A=
=0D [c00350f8] __do_IRQ+0xb0/0x160=0A=
=0Dillegal vector 255 received!=0A=
=0Dkernel BUG in ack_bad_irq at include/asm/hardirq.h:27!=0A=
=0DOops: Exception in kernel mode, sig: 5 [#8]=0A=
=0DNIP: C0034F50 LR: C0034F50 SP: C0378D10 REGS: c0378c60 TRAP: 0700    =
Not tainted=0A=
=0DMSR: 00021032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11=0A=
=0DTASK =3D c0299ac0[0] 'swapper' THREAD: c0378000=0A=
=0DLast syscall: 120 =0A=
=0DGPR00: C0034F50 C0378D10 C0299AC0 00000023 00004398 FFFFFFFF C0390000 =
C029B484 =0A=
=0DGPR08: C02A0000 C0370000 00000000 C0390000 00000000 10003000 03FE4000 =
007FFF24 =0A=
=0DGPR16: 00000000 00000001 007FFF00 FFFFFFFF 03FDFCA8 00000000 00000003 =
03F1FE40 =0A=
=0DGPR24: 00000000 007FFEC0 40000000 C0378D70 C0375000 000000FF 00000000 =
C0376FE0 =0A=
=0DNIP [c0034f50] ack_none+0x1c/0x30=0A=
=0DLR [c0034f50] ack_none+0x1c/0x30=0A=
=0DCall trace:=0A=
=0D [c00350f8] __do_IRQ+0xb0/0x160=0A=
=0D [c0005a9c] do_IRQ+0x38/0x98=0A=
=0D [c0004a74] ret_from_except+0x0/0x14=0A=
=0D [c0004d34] die+0x7c/0x80=0A=
=0D [c0004da8] _exception+0x70/0xa8=0A=
=0D [c0004a28] ret_from_except_full+0x0/0x4c=0A=
=0D [c0034f50] ack_none+0x1c/0x30=0A=
=0D [c00350f8] __do_IRQ+0xb0/0x160=0A=
=0D [c0005a9c] do_IRQ+0x38/0x98=0A=
=0D [c0004a74] ret_from_except+0x0/0x14=0A=
=0D [c0004d34] die+0x7c/0x80=0A=
=0D [c0004da8] _exception+0x70/0xa8=0A=
=0D [c0004a28] ret_from_except_full+0x0/0x4c=0A=
=0D [c0034f50] ack_none+0x1c/0x30=0A=
=0D [c00350f8] __do_IRQ+0xb0/0x160=0A=
=0Dillegal vector 255 received!=0A=
=0Dkernel BUG in ack_bad_irq at include/asm/hardirq.h:27!=0A=
=0DOops: Exception in kernel mode, sig: 5 [#9]=0A=
=0DNIP: C0034F50 LR: C0034F50 SP: C0378A90 REGS: c03789e0 TRAP: 0700    =
Not tainted=0A=
=0DMSR: 00021032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11=0A=
=0DTASK =3D c0299ac0[0] 'swapper' THREAD: c0378000=0A=
=0DLast syscall: 120 =0A=
=0DGPR00: C0034F50 C0378A90 C0299AC0 00000023 000048AC FFFFFFFF C0390000 =
C029B484 =0A=
=0DGPR08: C02A0000 C0370000 00000000 C0390000 00000000 10003000 03FE4000 =
007FFF24 =0A=
=0DGPR16: 00000000 00000001 007FFF00 FFFFFFFF 03FDFCA8 00000000 00000003 =
03F1FE40 =0A=
=0DGPR24: 00000000 007FFEC0 40000000 C0378AF0 C0375000 000000FF 00000000 =
C0376FE0 =0A=
=0DNIP [c0034f50] ack_none+0x1c/0x30=0A=
=0DLR [c0034f50] ack_none+0x1c/0x30=0A=
=0DCall trace:=0A=
=0D [c00350f8] __do_IRQ+0xb0/0x160=0A=
=0D [c0005a9c] do_IRQ+0x38/0x98=0A=
=0D [c0004a74] ret_from_except+0x0/0x14=0A=
=0D [c0004d34] die+0x7c/0x80=0A=
=0D [c0004da8] _exception+0x70/0xa8=0A=
=0D [c0004a28] ret_from_except_full+0x0/0x4c=0A=
=0D [c0034f50] ack_none+0x1c/0x30=0A=
=0D [c00350f8] __do_IRQ+0xb0/0x160=0A=
=0D [c0005a9c] do_IRQ+0x38/0x98=0A=
=0D [c0004a74] ret_from_except+0x0/0x14=0A=
=0D [c0004d34] die+0x7c/0x80=0A=
=0D [c0004da8] _exception+0x70/0xa8=0A=
=0D [c0004a28] ret_from_except_full+0x0/0x4c=0A=
=0D [c0034f50] ack_none+0x1c/0x30=0A=
=0D [c00350f8] __do_IRQ+0xb0/0x160=0A=
=0Dillegal vector 255 received!=0A=
=0Dkernel BUG in ack_bad_irq at include/asm/hardirq.h:27!=0A=
=0DOops: Exception in kernel mode, sig: 5 [#10]=0A=
=0DNIP: C0034F50 LR: C0034F50 SP: C0378810 REGS: c0378760 TRAP: 0700    =
Not tainted=0A=
=0DMSR: 00021032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11=0A=
=0DTASK =3D c0299ac0[0] 'swapper' THREAD: c0378000=0A=
=0DLast syscall: 120 =0A=
=0DGPR00: C0034F50 C0378810 C0299AC0 00000023 00004DC0 FFFFFFFF C0390000 =
C029B484 =0A=
=0DGPR08: C02A0000 C0370000 00000000 C0390000 00000000 10003000 03FE4000 =
007FFF24 =0A=
=0DGPR16: 00000000 00000001 007FFF00 FFFFFFFF 03FDFCA8 00000000 00000003 =
03F1FE40 =0A=
=0DGPR24: 00000000 007FFEC0 40000000 C0378870 C0375000 000000FF 00000000 =
C0376FE0 =0A=
=0DNIP [c0034f50] ack_none+0x1c/0x30=0A=
=0DLR [c0034f50] ack_none+0x1c/0x30=0A=
=0DCall trace:=0A=
=0D [c00350f8] __do_IRQ+0xb0/0x160=0A=
=0D [c0005a9c] do_IRQ+0x38/0x98=0A=
=0D [c0004a74] ret_from_except+0x0/0x14=0A=
=0D [c0004d34] die+0x7c/0x80=0A=
=0D [c0004da8] _exception+0x70/0xa8=0A=
=0D [c0004a28] ret_from_except_full+0x0/0x4c=0A=
=0D [c0034f50] ack_none+0x1c/0x30=0A=
=0D [c00350f8] __do_IRQ+0xb0/0x160=0A=
=0D [c0005a9c] do_IRQ+0x38/0x98=0A=
=0D [c0004a74] ret_from_except+0x0/0x14=0A=
=0D [c0004d34] die+0x7c/0x80=0A=
=0D [c0004da8] _exception+0x70/0xa8=0A=
=0D [c0004a28] ret_from_except_full+0x0/0x4c=0A=
=0D [c0034f50] ack_none+0x1c/0x30=0A=
=0D [c00350f8] __do_IRQ+0xb0/0x160=0A=
=0Dillegal vector 255 received!=0A=
=0Dkernel BUG in ack_bad_irq at include/asm/hardirq.h:27!=0A=
=0DOops: Exception in kernel mode, sig: 5 [#11]=0A=
=0DNIP: C0034F50 LR: C0034F50 SP: C0378590 REGS: c03784e0 TRAP: 0700    =
Not tainted=0A=
=0DMSR: 00021032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11=0A=
=0DTASK =3D c0299ac0[0] 'swapper' THREAD: c0378000=0A=
=0DLast syscall: 120 =0A=
=0DGPR00: C0034F50 C0378590 C0299AC0 00000023 000052D5 FFFFFFFF C0390000 =
C029B484 =0A=
=0DGPR08: C02A0000 C0370000 00000000 C0390000 00000000 10003000 03FE4000 =
007FFF24 =0A=
=0DGPR16: 00000000 00000001 007FFF00 FFFFFFFF 03FDFCA8 00000000 00000003 =
03F1FE40 =0A=
=0DGPR24: 00000000 007FFEC0 40000000 C03785F0 C0375000 000000FF 00000000 =
C0376FE0 =0A=
=0DNIP [c0034f50] ack_none+0x1c/0x30=0A=
=0DLR [c0034f50] ack_none+0x1c/0x30=0A=
=0DCall trace:=0A=
=0D [c00350f8] __do_IRQ+0xb0/0x160=0A=
=0D [c0005a9c] do_IRQ+0x38/0x98=0A=
=0D [c0004a74] ret_from_except+0x0/0x14=0A=
=0D [c0004d34] die+0x7c/0x80=0A=
=0D [c0004da8] _exception+0x70/0xa8=0A=
=0D [c0004a28] ret_from_except_full+0x0/0x4c=0A=
=0D [c0034f50] ack_none+0x1c/0x30=0A=
=0D [c00350f8] __do_IRQ+0xb0/0x160=0A=
=0D [c0005a9c] do_IRQ+0x38/0x98=0A=
=0D [c0004a74] ret_from_except+0x0/0x14=0A=
=0D [c0004d34] die+0x7c/0x80=0A=
=0D [c0004da8] _exception+0x70/0xa8=0A=
=0D [c0004a28] ret_from_except_full+0x0/0x4c=0A=
=0D [c0034f50] ack_none+0x1c/0x30=0A=
=0D [c00350f8] __do_IRQ+0xb0/0x160=0A=
=0Dillegal vector 255 received!=0A=
=0Dkernel BUG in ack_bad_irq at include/asm/hardirq.h:27!=0A=
=0DOops: Exception in kernel mode, sig: 5 [#12]=0A=
=0DNIP: C0034F50 LR: C0034F50 SP: C0378310 REGS: c0378260 TRAP: 0700    =
Not tainted=0A=
=0DMSR: 00021032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11=0A=
=0DTASK =3D c0299ac0[0] 'swapper' THREAD: c0378000=0A=
=0DLast syscall: 120 =0A=
=0DGPR00: C0034F50 C0378310 C0299AC0 00000023 000057EA FFFFFFFF C0390000 =
C029B484 =0A=
=0DGPR08: C02A0000 C0370000 00000000 C0390000 00000000 10003000 03FE4000 =
007FFF24 =0A=
=0DGPR16: 00000000 00000001 007FFF00 FFFFFFFF 03FDFCA8 00000000 00000003 =
03F1FE40 =0A=
=0DGPR24: 00000000 007FFEC0 40000000 C0378370 C0375000 000000FF 00000000 =
C0376FE0 =0A=
=0DNIP [c0034f50] ack_none+0x1c/0x30=0A=
=0DLR [c0034f50] ack_none+0x1c/0x30=0A=
=0DCall trace:=0A=
=0D [c00350f8] __do_IRQ+0xb0/0x160=0A=
=0D [c0005a9c] do_IRQ+0x38/0x98=0A=
=0D [c0004a74] ret_from_except+0x0/0x14=0A=
=0D [c0004d34] die+0x7c/0x80=0A=
=0D [c0004da8] _exception+0x70/0xa8=0A=
=0D [c0004a28] ret_from_except_full+0x0/0x4c=0A=
=0D [c0034f50] ack_none+0x1c/0x30=0A=
=0D [c00350f8] __do_IRQ+0xb0/0x160=0A=
=0D [c0005a9c] do_IRQ+0x38/0x98=0A=
=0D [c0004a74] ret_from_except+0x0/0x14=0A=
=0D [c0004d34] die+0x7c/0x80=0A=
=0D [c0004da8] _exception+0x70/0xa8=0A=
=0D [c0004a28] ret_from_except_full+0x0/0x4c=0A=
=0D [c0034f50] ack_none+0x1c/0x30=0A=
=0D [c00350f8] __do_IRQ+0xb0/0x160=0A=
=0Dillegal vector 255 received!=0A=
=0Dkernel BUG in ack_bad_irq at include/asm/hardirq.h:27!=0A=
=0DOops: Exception in kernel mode, sig: 5 [#13]=0A=
=0DNIP: C0034F50 LR: C0034F50 SP: C0378090 REGS: c0377fe0 TRAP: 0700    =
Not tainted=0A=
=0DMSR: 00021032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11=0A=
=0DTASK =3D c0299ac0[0] 'swapper' THREAD: c0378000=0A=
=0DLast syscall: 120 =0A=
=0DGPR00: C0034F50 C0378090 C0299AC0 00000023 00005CFF FFFFFFFF C0390000 =
C029B484 =0A=
=0DGPR08: C02A0000 C0370000 00000000 C0390000 00000000 10003000 03FE4000 =
007FFF24 =0A=
=0DGPR16: 00000000 00000001 007FFF00 FFFFFFFF 03FDFCA8 00000000 00000003 =
03F1FE40 =0A=
=0DGPR24: 00000000 007FFEC0 40000000 C03780F0 C0375000 000000FF 00000000 =
C0376FE0 =0A=
=0DNIP [c0034f50] ack_none+0x1c/0x30=0A=
=0DLR [c0034f50] ack_none+0x1c/0x30=0A=
=0DCall trace:=0A=
=0D [c00350f8] __do_IRQ+0xb0/0x160=0A=
=0D [c0005a9c] do_IRQ+0x38/0x98=0A=
=0D [c0004a74] ret_from_except+0x0/0x14=0A=
=0D [c0004d34] die+0x7c/0x80=0A=
=0D [c0004da8] _exception+0x70/0xa8=0A=
=0D [c0004a28] ret_from_except_full+0x0/0x4c=0A=
=0D [c0034f50] ack_none+0x1c/0x30=0A=
=0D [c00350f8] __do_IRQ+0xb0/0x160=0A=
=0D [c0005a9c] do_IRQ+0x38/0x98=0A=
=0D [c0004a74] ret_from_except+0x0/0x14=0A=
=0D [c0004d34] die+0x7c/0x80=0A=
=0D [c0004da8] _exception+0x70/0xa8=0A=
=0D [c0004a28] ret_from_except_full+0x0/0x4c=0A=
=0D [c0034f50] ack_none+0x1c/0x30=0A=
=0D [c00350f8] __do_IRQ+0xb0/0x160=0A=
=0Dillegal vector 255 received!=0A=
=0Dkernel BUG in ack_bad_irq at include/asm/hardirq.h:27!=0A=
=0DOops: Exception in kernel mode, sig: 5 [#14]=0A=
=0DNIP: C0034F50 LR: C0034F50 SP: C0377E10 REGS: c0377d60 TRAP: 0700    =
Not tainted=0A=
=0DMSR: 00021032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11=0A=
=0DTASK =3D c0299ac0[0] 'swapper' THREAD: c0378000=0A=
=0DLast syscall: 120 =0A=
=0DGPR00: C0034F50 C0377E10 C0299AC0 00000023 00006214 FFFFFFFF C0390000 =
C029B484 =0A=
=0DGPR08: C02A0000 C0370000 00000000 C0390000 00000000 10003000 03FE4000 =
007FFF24 =0A=
=0DGPR16: 00000000 00000001 007FFF00 FFFFFFFF 03FDFCA8 00000000 00000003 =
03F1FE40 =0A=
=0DGPR24: 00000000 007FFEC0 40000000 C0377E70 C0375000 000000FF 00000000 =
C0376FE0 =0A=
=0DNIP [c0034f50] ack_none+0x1c/0x30=0A=
=0DLR [c0034f50] ack_none+0x1c/0x30=0A=
=0Dillegal vector 255 received!=0A=
=0Dkernel BUG in ack_bad_irq at include/asm/hardirq.h:27!=0A=
=0DOops: Exception in kernel mode, sig: 5 [#15]=0A=
=0DNIP: C0034F50 LR: C0034F50 SP: C0377B90 REGS: c0377ae0 TRAP: 0700    =
Not tainted=0A=
=0DMSR: 00021032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11=0A=
=0DTASK =3D c0299ac0[0] 'swapper' THREAD: c0378000=0A=
=0DLast syscall: 120 =0A=
=0DGPR00: C0034F50 C0377B90 C0299AC0 00000023 00006501 FFFFFFFF C0390000 =
C029B484 =0A=
=0DGPR08: C02A0000 C0370000 00000000 C0390000 00000000 10003000 03FE4000 =
007FFF24 =0A=
=0DGPR16: 00000000 00000001 007FFF00 FFFFFFFF 03FDFCA8 00000000 00000003 =
03F1FE40 =0A=
=0DGPR24: 00000000 007FFEC0 40000000 C0377BF0 C0375000 000000FF 00000000 =
C0376FE0 =0A=
=0DNIP [c0034f50] ack_none+0x1c/0x30=0A=
=0DLR [c0034f50] ack_none+0x1c/0x30=0A=
=0Dillegal vector 255 received!=0A=
=0Dkernel BUG in ack_bad_irq at include/asm/hardirq.h:27!=0A=
=0DOops: Exception in kernel mode, sig: 5 [#16]=0A=
=0DNIP: C0034F50 LR: C0034F50 SP: C0377910 REGS: c0377860 TRAP: 0700    =
Not tainted=0A=
=0DMSR: 00021032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11=0A=
=0DTASK =3D c0299ac0[0] 'swapper' THREAD: c0378000=0A=
=0DLast syscall: 120 =0A=
=0DGPR00: C0034F50 C0377910 C0299AC0 00000023 000067EE FFFFFFFF C0390000 =
C029B484 =0A=
=0DGPR08: C02A0000 C0370000 00000000 C0390000 00000000 10003000 03FE4000 =
007FFF24 =0A=
=0DGPR16: 00000000 00000001 007FFF00 FFFFFFFF 03FDFCA8 00000000 00000003 =
03F1FE40 =0A=
=0DGPR24: 00000000 007FFEC0 40000000 C0377970 C0375000 000000FF 00000000 =
C0376FE0 =0A=
=0DNIP [c0034f50] ack_none+0x1c/0x30=0A=
=0DLR [c0034f50] ack_none+0x1c/0x30=0A=
=0Dillegal vector 255 received!=0A=
=0Dkernel BUG in ack_bad_irq at include/asm/hardirq.h:27!=0A=
=0DOops: Exception in kernel mode, sig: 5 [#17]=0A=
=0DNIP: C0034F50 LR: C0034F50 SP: C0377690 REGS: c03775e0 TRAP: 0700    =
Not tainted=0A=
=0DMSR: 00021032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11=0A=
=0DTASK =3D c0299ac0[0] 'swapper' THREAD: c0378000=0A=
=0DLast syscall: 120 =0A=
=0DGPR00: C0034F50 C0377690 C0299AC0 00000023 00006ADB FFFFFFFF C0390000 =
C029B484 =0A=
=0DGPR08: C02A0000 C0370000 00000000 C0390000 00000000 10003000 03FE4000 =
007FFF24 =0A=
=0DGPR16: 00000000 00000001 007FFF00 FFFFFFFF 03FDFCA8 00000000 00000003 =
03F1FE40 =0A=
=0DGPR24: 00000000 007FFEC0 40000000 C03776F0 C0375000 000000FF 00000000 =
C0376FE0 =0A=
=0DNIP [c0034f50] ack_none+0x1c/0x30=0A=
=0DLR [c0034f50] ack_none+0x1c/0x30=0A=
=0Dillegal vector 255 received!=0A=
=0Dkernel BUG in ack_bad_irq at include/asm/hardirq.h:27!=0A=
=0DOops: Exception in kernel mode, sig: 5 [#18]=0A=
=0DNIP: C0034F50 LR: C0034F50 SP: C0377410 REGS: c0377360 TRAP: 0700    =
Not tainted=0A=
=0DMSR: 00021032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11=0A=
=0DTASK =3D c0299ac0[0] 'swapper' THREAD: c0378000=0A=
=0DLast syscall: 120 =0A=
=0DGPR00: C0034F50 C0377410 C0299AC0 00000023 00006DC8 FFFFFFFF C0390000 =
C029B484 =0A=
=0DGPR08: C02A0000 C0370000 00000000 C0390000 00000000 10003000 03FE4000 =
007FFF24 =0A=
=0DGPR16: 00000000 00000001 007FFF00 FFFFFFFF 03FDFCA8 00000000 00000003 =
03F1FE40 =0A=
=0DGPR24: 00000000 007FFEC0 40000000 C0377470 C0375000 000000FF 00000000 =
C0376FE0 =0A=
=0DNIP [c0034f50] ack_none+0x1c/0x30=0A=
=0DLR [c0034f50] ack_none+0x1c/0x30=0A=
=0DOops: kernel access of bad area, sig: 11 [#19]=0A=
=0DNIP: 00000030 LR: C00350F8 SP: C03771A0 REGS: c03770f0 TRAP: 0400    =
Not tainted=0A=
=0DMSR: 20001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11=0A=
=0DTASK =3D c0299ac0[0] 'swapper' THREAD: c0378000=0A=
=0DLast syscall: 120 =0A=
=0DGPR00: 00000002 C03771A0 C0299AC0 000000FF C03771F0 FFFFFFFF C0390000 =
C029B484 =0A=
=0DGPR08: C0390000 00000030 C0390000 C039869C 00299C80 10003000 03FE4000 =
007FFF24 =0A=
=0DGPR16: 00000000 00000001 007FFF00 FFFFFFFF 03FDFCA8 00000000 00000003 =
03F1FE40 =0A=
=0DGPR24: 00000000 007FFEC0 40000000 C03771F0 C0375000 000000FF 00000000 =
C0376FE0 =0A=
=0DNIP [00000030] 0x30=0A=
=0DLR [c00350f8] __do_IRQ+0xb0/0x160=0A=
=0DOops: kernel access of bad area, sig: 11 [#20]=0A=
=0DNIP: 00000000 LR: C00350F8 SP: C0376FB0 REGS: c0376f00 TRAP: 0400    =
Not tainted=0A=
=0DMSR: 20001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11=0A=
=0DTASK =3D c0299ac0[0] 'swapper' THREAD: c0378000=0A=
=0DLast syscall: 120 =0A=
=0DGPR00: 0000000B C0376FB0 C0299AC0 000000FF C0377000 FFFFFFFF C0390000 =
C029B484 =0A=
=0DGPR08: C0390000 00000000 C0390000 C039869C 00299C80 10003000 03FE4000 =
007FFF24 =0A=
=0DGPR16: 00000000 00000001 007FFF00 FFFFFFFF 03FDFCA8 00000000 00000003 =
03F1FE40 =0A=
=0DGPR24: 00000000 007FFEC0 40000000 C0377000 C0375000 000000FF 00000000 =
C0376FE0 =0A=
=0DNIP [00000000] 0x0=0A=
=0DLR [c00350f8] __do_IRQ+0xb0/0x160=0A=
=0DOops: kernel access of bad area, sig: 11 [#21]=0A=
=0DNIP: 00000000 LR: C00350F8 SP: C0376DC0 REGS: c0376d10 TRAP: 0400    =
Not tainted=0A=
=0DMSR: 20001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11=0A=
=0DTASK =3D c0299ac0[0] 'swapper' THREAD: c0378000=0A=
=0DLast syscall: 120 =0A=
=0DGPR00: 0000000B C0376DC0 C0299AC0 000000FF C0376E10 FFFFFFFF C0390000 =
C029B484 =0A=
=0DGPR08: C0390000 00000000 C0390000 C039869C 00299C80 10003000 03FE4000 =
007FFF24 =0A=
=0DGPR16: 00000000 00000001 007FFF00 FFFFFFFF 03FDFCA8 00000000 00000003 =
03F1FE40 =0A=
=0DGPR24: 00000000 007FFEC0 40000000 C0376E10 C0375000 000000FF 00000000 =
C0376FE0 =0A=
=0DNIP [00000000] 0x0=0A=
=0DLR [c00350f8] __do_IRQ+0xb0/0x160=0A=
=0DOops: kernel access of bad area, sig: 11 [#22]=0A=
=0DNIP: 00000000 LR: C00350F8 SP: C0376BD0 REGS: c0376b20 TRAP: 0400    =
Not tainted=0A=
=0DMSR: 20001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11=0A=
=0DTASK =3D c0299ac0[0] 'swapper' THREAD: c0378000=0A=
=0DLast syscall: 120 =0A=
=0DGPR00: 0000000B C0376BD0 C0299AC0 000000FF C0376C20 FFFFFFFF C0390000 =
C029B484 =0A=
=0DGPR08: C0390000 00000000 C0390000 C039869C 00299C80 10003000 03FE4000 =
007FFF24 =0A=
=0DGPR16: 00000000 00000001 007FFF00 FFFFFFFF 03FDFCA8 00000000 00000003 =
03F1FE40 =0A=
=0DGPR24: 00000000 007FFEC0 40000000 C0376C20 C0375000 000000FF 00000000 =
C0376FE0 =0A=
=0DNIP [00000000] 0x0=0A=
=0DLR [c00350f8] __do_IRQ+0xb0/0x160=0A=
=0DOops: kernel access of bad area, sig: 11 [#23]=0A=
=0DNIP: 00000000 LR: C00350F8 SP: C03769E0 REGS: c0376930 TRAP: 0400    =
Not tainted=0A=
=0DMSR: 20001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11=0A=
=0DTASK =3D c0299ac0[0] 'swapper' THREAD: c0378000=0A=
=0DLast syscall: 120 =0A=
=0DGPR00: 0000000B C03769E0 C0299AC0 000000FF C0376A30 FFFFFFFF C0390000 =
C029B484 =0A=
=0DGPR08: C0390000 00000000 C0390000 C039869C 00299C80 10003000 03FE4000 =
007FFF24 =0A=
=0DGPR16: 00000000 00000001 007FFF00 FFFFFFFF 03FDFCA8 00000000 00000003 =
03F1FE40 =0A=
=0DGPR24: 00000000 007FFEC0 40000000 C0376A30 C0375000 000000FF 00000000 =
C0376FE0 =0A=
=0DNIP [00000000] 0x0=0A=
=0DLR [c00350f8] __do_IRQ+0xb0/0x160=0A=
=0DOops: kernel access of bad area, sig: 11 [#24]=0A=
=0DNIP: 00000000 LR: C00350F8 SP: C03767F0 REGS: c0376740 TRAP: 0400    =
Not tainted=0A=
=0DMSR: 20001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11=0A=
=0DTASK =3D c0299ac0[0] 'swapper' THREAD: c0378000=0A=
=0DLast syscall: 120 =0A=
=0DGPR00: 0000000B C03767F0 C0299AC0 000000FF C0376840 FFFFFFFF C0390000 =
C029B484 =0A=
=0DGPR08: C0390000 00000000 C0390000 C039869C 00299C80 10003000 03FE4000 =
007FFF24 =0A=
=0DGPR16: 00000000 00000001 007FFF00 FFFFFFFF 03FDFCA8 00000000 00000003 =
03F1FE40 =0A=
=0DGPR24: 00000000 007FFEC0 40000000 C0376840 C0375000 000000FF 00000000 =
C0376FE0 =0A=
=0DNIP [00000000] 0x0=0A=
=0DLR [c00350f8] __do_IRQ+0xb0/0x160=0A=
=0DOops: kernel access of bad area, sig: 11 [#25]=0A=
=0DNIP: 00000000 LR: C00350F8 SP: C0376600 REGS: c0376550 TRAP: 0400    =
Not tainted=0A=
=0DMSR: 20001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11=0A=
=0DTASK =3D c0299ac0[0] 'swapper' THREAD: c0378000=0A=
=0DLast syscall: 120 =0A=
=0DGPR00: 0000000B C0376600 C0299AC0 000000FF C0376650 FFFFFFFF C0390000 =
C029B484 =0A=
=0DGPR08: C0390000 00000000 C0390000 C039869C 00299C80 10003000 03FE4000 =
007FFF24 =0A=
=0DGPR16: 00000000 00000001 007FFF00 FFFFFFFF 03FDFCA8 00000000 00000003 =
03F1FE40 =0A=
=0DGPR24: 00000000 007FFEC0 40000000 C0376650 C0375000 000000FF 00000000 =
C0376FE0 =0A=
=0DNIP [00000000] 0x0=0A=
=0DLR [c00350f8] __do_IRQ+0xb0/0x160=0A=
=0DOops: kernel access of bad area, sig: 11 [#26]=0A=
=0DNIP: 00000000 LR: C00350F8 SP: C0376410 REGS: c0376360 TRAP: 0400    =
Not tainted=0A=
=0DMSR: 20001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11=0A=
=0DTASK =3D c0299ac0[0] 'swapper' THREAD: c0378000=0A=
=0DLast syscall: 120 =0A=
=0DGPR00: 0000000B C0376410 C0299AC0 000000FF C0376460 FFFFFFFF C0390000 =
C029B484 =0A=
=0DGPR08: C0390000 00000000 C0390000 C039869C 00299C80 10003000 03FE4000 =
007FFF24 =0A=
=0DGPR16: 00000000 00000001 007FFF00 FFFFFFFF 03FDFCA8 00000000 00000003 =
03F1FE40 =0A=
=0DGPR24: 00000000 007FFEC0 40000000 C0376460 C0375000 000000FF 00000000 =
C0376FE0 =0A=
=0DNIP [00000000] 0x0=0A=
=0DLR [c00350f8] __do_IRQ+0xb0/0x160=0A=
=0DOops: kernel access of bad area, sig: 11 [#27]=0A=
=0DNIP: 00000000 LR: C00350F8 SP: C0376220 REGS: c0376170 TRAP: 0400    =
Not tainted=0A=
=0DMSR: 20001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11=0A=
=0DTASK =3D c0299ac0[0] 'swapper' THREAD: c0378000=0A=
=0DLast syscall: 120 =0A=
=0DGPR00: 0000000B C0376220 C0299AC0 000000FF C0376270 FFFFFFFF C0390000 =
C029B484 =0A=
=0DGPR08: C0390000 00000000 C0390000 C039869C 00299C80 10003000 03FE4000 =
007FFF24 =0A=
=0DGPR16: 00000000 00000001 007FFF00 FFFFFFFF 03FDFCA8 00000000 00000003 =
03F1FE40 =0A=
=0DGPR24: 00000000 007FFEC0 40000000 C0376270 C0375000 000000FF 00000000 =
C0376FE0 =0A=
=0DNIP [00000000] 0x0=0A=
=0DLR [c00350f8] __do_IRQ+0xb0/0x160=0A=
=0DOops: kernel access of bad area, sig: 11 [#28]=0A=
=0DNIP: 00000000 LR: C00350F8 SP: C0376030 REGS: c0375f80 TRAP: 0400    =
Not tainted=0A=
=0DMSR: 20001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11=0A=
=0DTASK =3D c0299ac0[0] 'swapper' THREAD: c0378000=0A=
=0DLast syscall: 120 =0A=
=0DGPR00: 0000000B C0376030 C0299AC0 000000FF C0376080 FFFFFFFF C0390000 =
C029B484 =0A=
=0DGPR08: C0390000 00000000 C0390000 C039869C 00299C80 10003000 03FE4000 =
007FFF24 =0A=
=0DGPR16: 00000000 00000001 007FFF00 FFFFFFFF 03FDFCA8 00000000 00000003 =
03F1FE40 =0A=
=0DGPR24: 00000000 007FFEC0 40000000 C0376080 C0375000 000000FF 00000000 =
C0376FE0 =0A=
=0DNIP [00000000] 0x0=0A=
=0DLR [c00350f8] __do_IRQ+0xb0/0x160=0A=
=0DOops: kernel access of bad area, sig: 11 [#29]=0A=
=0DNIP: 00000000 LR: C00350F8 SP: C0375E40 REGS: c0375d90 TRAP: 0400    =
Not tainted=0A=
=0DMSR: 20001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11=0A=
=0DTASK =3D c0299ac0[0] 'swapper' THREAD: c0378000=0A=
=0DLast syscall: 120 =0A=
=0DGPR00: 0000000B C0375E40 C0299AC0 000000FF C0375E90 FFFFFFFF C0390000 =
C029B484 =0A=
=0DGPR08: C0390000 00000000 C0390000 C039869C 00299C80 10003000 03FE4000 =
007FFF24 =0A=
=0DGPR16: 00000000 00000001 007FFF00 FFFFFFFF 03FDFCA8 00000000 00000003 =
03F1FE40 =0A=
=0DGPR24: 00000000 007FFEC0 40000000 C0375E90 C0375000 000000FF 00000000 =
C0376FE0 =0A=
=0DNIP [00000000] 0x0=0A=
=0DLR [c00350f8] __do_IRQ+0xb0/0x160=0A=
=0DOops: kernel access of bad area, sig: 11 [#30]=0A=
=0DNIP: 00000000 LR: C00350F8 SP: C0375C50 REGS: c0375ba0 TRAP: 0400    =
Not tainted=0A=
=0DMSR: 20001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11=0A=
=0DTASK =3D c0299ac0[0] 'swapper' THREAD: c0378000=0A=
=0DLast syscall: 120 =0A=
=0DGPR00: 0000000B C0375C50 C0299AC0 000000FF C0375CA0 FFFFFFFF C0390000 =
C029B484 =0A=
=0DGPR08: C0390000 00000000 C0390000 C039869C 00299C80 10003000 03FE4000 =
007FFF24 =0A=
=0DGPR16: 00000000 00000001 007FFF00 FFFFFFFF 03FDFCA8 00000000 00000003 =
03F1FE40 =0A=
=0DGPR24: 00000000 007FFEC0 40000000 C0375CA0 C0375000 000000FF 00000000 =
C0376FE0 =0A=
=0DNIP [00000000] 0x0=0A=
=0DLR [c00350f8] __do_IRQ+0xb0/0x160=0A=
=0DOops: kernel access of bad area, sig: 11 [#31]=0A=
=0DNIP: 00000000 LR: C00350F8 SP: C0375A60 REGS: c03759b0 TRAP: 0400    =
Not tainted=0A=
=0DMSR: 20001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11=0A=
=0DTASK =3D c0299ac0[0] 'swapper' THREAD: c0378000=0A=
=0DLast syscall: 120 =0A=
=0DGPR00: 0000000B C0375A60 C0299AC0 000000FF C0375AB0 FFFFFFFF C0390000 =
C029B484 =0A=
=0DGPR08: C0390000 00000000 C0390000 C039869C 00299C80 10003000 03FE4000 =
007FFF24 =0A=
=0DGPR16: 00000000 00000001 007FFF00 FFFFFFFF 03FDFCA8 00000000 00000003 =
03F1FE40 =0A=
=0DGPR24: 00000000 007FFEC0 40000000 C0375AB0 C0375000 000000FF 00000000 =
C0376FE0 =0A=
=0DNIP [00000000] 0x0=0A=
=0DLR [c00350f8] __do_IRQ+0xb0/0x160=0A=
=0DOops: kernel access of bad area, sig: 11 [#32]=0A=
=0DNIP: 00000000 LR: C00350F8 SP: C0375870 REGS: c03757c0 TRAP: 0400    =
Not tainted=0A=
=0DMSR: 20001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11=0A=
=0DTASK =3D c0299ac0[0] 'swapper' THREAD: c0378000=0A=
=0DLast syscall: 120 =0A=
=0DGPR00: 0000000B C0375870 C0299AC0 000000FF C03758C0 FFFFFFFF C0390000 =
C029B484 =0A=
=0DGPR08: C0390000 00000000 C0390000 C039869C 00299C80 10003000 03FE4000 =
007FFF24 =0A=
=0DGPR16: 00000000 00000001 007FFF00 FFFFFFFF 03FDFCA8 00000000 00000003 =
03F1FE40 =0A=
=0DGPR24: 00000000 007FFEC0 40000000 C03758C0 C0375000 000000FF 00000000 =
C0376FE0 =0A=
=0DNIP [00000000] 0x0=0A=
=0DLR [c00350f8] __do_IRQ+0xb0/0x160=0A=
=0DOops: kernel access of bad area, sig: 11 [#33]=0A=
=0DNIP: 00000000 LR: C00350F8 SP: C0375680 REGS: c03755d0 TRAP: 0400    =
Not tainted=0A=
=0DMSR: 20001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11=0A=
=0DTASK =3D c0299ac0[0] 'swapper' THREAD: c0378000=0A=
=0DLast syscall: 120 =0A=
=0DGPR00: 0000000B C0375680 C0299AC0 000000FF C03756D0 FFFFFFFF C0390000 =
C029B484 =0A=
=0DGPR08: C0390000 00000000 C0390000 C039869C 00299C80 10003000 03FE4000 =
007FFF24 =0A=
=0DGPR16: 00000000 00000001 007FFF00 FFFFFFFF 03FDFCA8 00000000 00000003 =
03F1FE40 =0A=
=0DGPR24: 00000000 007FFEC0 40000000 C03756D0 C0375000 000000FF 00000000 =
C0376FE0 =0A=
=0DNIP [00000000] 0x0=0A=
=0DLR [c00350f8] __do_IRQ+0xb0/0x160=0A=
=0DOops: kernel access of bad area, sig: 11 [#34]=0A=
=0DNIP: 00000000 LR: C00350F8 SP: C0375490 REGS: c03753e0 TRAP: 0400    =
Not tainted=0A=
=0DMSR: 20001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11=0A=
=0DTASK =3D c0299ac0[0] 'swapper' THREAD: c0378000=0A=
=0DLast syscall: 120 =0A=
=0DGPR00: 0000000B C0375490 C0299AC0 000000FF C03754E0 FFFFFFFF C0390000 =
C029B484 =0A=
=0DGPR08: C0390000 00000000 C0390000 C039869C 00299C80 10003000 03FE4000 =
007FFF24 =0A=
=0DGPR16: 00000000 00000001 007FFF00 FFFFFFFF 03FDFCA8 00000000 00000003 =
03F1FE40 =0A=
=0DGPR24: 00000000 007FFEC0 40000000 C03754E0 C0375000 000000FF 00000000 =
C0376FE0 =0A=
=0DNIP [00000000] 0x0=0A=
=0DLR [c00350f8] __do_IRQ+0xb0/0x160=0A=
=0DOops: kernel access of bad area, sig: 11 [#35]=0A=
=0DNIP: 00000000 LR: C00350F8 SP: C03752A0 REGS: c03751f0 TRAP: 0400    =
Not tainted=0A=
=0DMSR: 20001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11=0A=
=0DTASK =3D c0299ac0[0] 'swapper' THREAD: c0378000=0A=
=0DLast syscall: 120 =0A=
=0DGPR00: 0000000B C03752A0 C0299AC0 000000FF C03752F0 FFFFFFFF C0390000 =
C029B484 =0A=
=0DGPR08: C0390000 00000000 C0390000 C039869C 00299C80 10003000 03FE4000 =
007FFF24 =0A=
=0DGPR16: 00000000 00000001 007FFF00 FFFFFFFF 03FDFCA8 00000000 00000003 =
03F1FE40 =0A=
=0DGPR24: 00000000 007FFEC0 40000000 C03752F0 C0375000 000000FF 00000000 =
C0376FE0 =0A=
=0DNIP [00000000] 0x0=0A=
=0DLR [c00350f8] __do_IRQ+0xb0/0x160=0A=
=0DOops: kernel access of bad area, sig: 11 [#36]=0A=
=0DNIP: 5F495250 LR: C00350F8 SP: C03750B0 REGS: c0375000 TRAP: 0400    =
Not tainted=0A=
=0DMSR: 20001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11=0A=
=0DTASK =3D c0299ac0[0] 'swapper' THREAD: c0378000=0A=
=0DLast syscall: 120 =0A=
=0DGPR00: 0000000B C03750B0 C0299AC0 000000FF C0375100 FFFFFFFF C0390000 =
C029B484 =0A=
=0DGPR08: C0390000 5F495251 C0390000 C039869C 00299C80 10003000 03FE4000 =
007FFF24 =0A=
=0DGPR16: 00000000 00000001 007FFF00 FFFFFFFF 03FDFCA8 00000000 00000003 =
03F1FE40 =0A=
=0DGPR24: 00000000 007FFEC0 40000000 C0375100 C0375000 000000FF 00000000 =
C0376FE0 =0A=
=0DNIP [5f495250] 0x5f495250=0A=
=0DLR [c00350f8] __do_IRQ+0xb0/0x160=0A=
=0DOops: kernel access of bad area, sig: 11 [#37]=0A=
=0DNIP: FFFFFFFC LR: C00350F8 SP: C0374EC0 REGS: c0374e10 TRAP: 0400    =
Not tainted=0A=
=0DMSR: 20001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11=0A=
=0DTASK =3D c0299ac0[0] 'swapper' THREAD: c0378000=0A=
=0DLast syscall: 120 =0A=
=0DGPR00: 0000000B C0374EC0 C0299AC0 000000FF C0374F10 FFFFFFFF C0390000 =
C029B484 =0A=
=0DGPR08: C0390000 FFFFFFFF C0390000 C039869C 00299C80 10003000 03FE4000 =
007FFF24 =0A=
=0DGPR16: 00000000 00000001 007FFF00 FFFFFFFF 03FDFCA8 00000000 00000003 =
03F1FE40 =0A=
=0DGPR24: 00000000 007FFEC0 40000000 C0374F10 C0375000 000000FF 00000000 =
C0376FE0 =0A=
=0DNIP [fffffffc] 0xfffffffc=0A=
=0DLR [c00350f8] __do_IRQ+0xb0/0x160=0A=
=0DOops: kernel access of bad area, sig: 11 [#38]=0A=
=0DNIP: FFFFFFFC LR: C00350F8 SP: C0374CD0 REGS: c0374c20 TRAP: 0400    =
Not tainted=0A=
=0DMSR: 20001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11=0A=
=0DTASK =3D c0299ac0[0] 'swapper' THREAD: c0378000=0A=
=0DLast syscall: 120 =0A=
=0DGPR00: 0000000B C0374CD0 C0299AC0 000000FF C0374D20 FFFFFFFF C0390000 =
C029B484 =0A=
=0DGPR08: C0390000 FFFFFFFF C0390000 C039869C 00299C80 10003000 03FE4000 =
007FFF24 =0A=
=0DGPR16: 00000000 00000001 007FFF00 FFFFFFFF 03FDFCA8 00000000 00000003 =
03F1FE40 =0A=
=0DGPR24: 00000000 007FFEC0 40000000 C0374D20 C0375000 000000FF 00000000 =
C0376FE0 =0A=
=0DNIP [fffffffc] 0xfffffffc=0A=
=0DLR [c00350f8] __do_IRQ+0xb0/0x160=0A=
=0DOops: kernel access of bad area, sig: 11 [#39]=0A=
=0DNIP: FFFFFFFC LR: C00350F8 SP: C0374AE0 REGS: c0374a30 TRAP: 0400    =
Not tainted=0A=
=0DMSR: 20001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11=0A=
=0DTASK =3D c0299ac0[0] 'swapper' THREAD: c0378000=0A=
=0DLast syscall: 120 =0A=
=0DGPR00: 0000000B C0374AE0 C0299AC0 000000FF C0374B30 FFFFFFFF C0390000 =
C029B484 =0A=
=0DGPR08: C0390000 FFFFFFFF C0390000 C039869C 00299C80 10003000 03FE4000 =
007FFF24 =0A=
=0DGPR16: 00000000 00000001 007FFF00 FFFFFFFF 03FDFCA8 00000000 00000003 =
03F1FE40 =0A=
=0DGPR24: 00000000 007FFEC0 40000000 C0374B30 C0375000 000000FF 00000000 =
C0376FE0 =0A=
=0DNIP [fffffffc] 0xfffffffc=0A=
=0DLR [c00350f8] __do_IRQ+0xb0/0x160=0A=
=0DOops: kernel access of bad area, sig: 11 [#40]=0A=
=0DNIP: FFFFFFFC LR: C00350F8 SP: C03748F0 REGS: c0374840 TRAP: 0400    =
Not tainted=0A=
=0DMSR: 20001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11=0A=
=0DTASK =3D c0299ac0[0] 'swapper' THREAD: c0378000=0A=
=0DLast syscall: 120 =0A=
=0DGPR00: 0000000B C03748F0 C0299AC0 000000FF C0374940 FFFFFFFF C0390000 =
C029B484 =0A=
=0DGPR08: C0390000 FFFFFFFF C0390000 C039869C 00299C80 10003000 03FE4000 =
007FFF24 =0A=
=0DGPR16: 00000000 00000001 007FFF00 FFFFFFFF 03FDFCA8 00000000 00000003 =
03F1FE40 =0A=
=0DGPR24: 00000000 007FFEC0 40000000 C0374940 C0375000 000000FF 00000000 =
C0376FE0 =0A=
=0DNIP [fffffffc] 0xfffffffc=0A=
=0DLR [c00350f8] do_`=01=18KK=FF=FD=A49`=01=1CK=FF=FD=9C9`=01 =
K=FF=FD=949`=01$K=FF=FD=8C9`=01(K=FF=FD=849`=01,K=FF=FD|9`=010K=FF=FDt=FF=
=FF=FF=FF_IRQ+0xb0/0x160=0A=
=0DOops: kernel access of bad area, sig: 11 [#41]=0A=
=0DNIP: FFFFFFFC LR: C00350F8 SP: C0374700 REGS: c0374650 TRAP: 0400    =
Not tainted=0A=
=0DMSR: 20001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11=0A=
=0DTASK =3D c0299ac0[0] 'swapper' THREAD: c0378000=0A=
=0DLast syscall: 120 =0A=
=0DGPR00: 0000000B C0374700 C0299AC0 000000FF C0374750 FFFFFFFF C0390000 =
C029B484 =0A=
=0DGPR08: C0390000 FFFFFFFF C0390000 C039869C 00299C80 10003000 03FE4000 =
007FFF24 =0A=
=0DGPR16: 00000000 00000001 007FFF00 FFFFFFFF 03FDFCA8 00000000 00000003 =
03F1FE40 =0A=
=0DGPR24: 00000000 007FFEC0 40000000 C0374750 C0375000 000000FF 00000000 =
C0376FE0 =0A=
=0DNIP [fffffffc] 0xfffffffc=0A=
=0DLR [c00350f8] *=01=18KK=FF=FD=A49`=01=1CK=FF=FD=9C9`=01 =
K=FF=FD=949`=01$K=FF=FD=8C9`=01(K=FF=FD=849`=01,K=FF=FD|9`=010K=FF=FDt=FF=
=FF=FF=FF=C07=87`=C0+0xb0/0x160=0A=
=0DOops: kernel access of bad area, sig: 11 [#42]=0A=
=0DOops: kernel access of bad area, sig: 11 [#43]=0A=
=0DOops: kernel access of bad area, sig: 11 [#44]=0A=
=0DOops: kernel access of bad area, sig: 11 [#45]=0A=
=0DOops: kernel access of bad area, sig: 11 [#46]=0A=
=0DOops: kernel access of bad area, sig: 11 [#47]=0A=
=0DOops: kernel access of bad area, sig: 11 [#48]=0A=
=0DOops: kernel access of bad area, sig: 11 [#49]=0A=
=0DOops: kernel access of bad area, sig: 11 [#50]=0A=
=0DOops: kernel access of bad area, sig: 11 [#51]=0A=
=0DOops: kernel access of bad area, sig: 11 [#52]=0A=
=0DOops: kernel access of bad area, sig: 11 [#53]=0A=
=0DOops: kernel access of bad area, sig: 11 [#54]=0A=
=0DOops: kernel access of bad area, sig: 11 [#55]=0A=
=0DOops: kernel access of bad area, sig: 11 [#56]=0A=
=0DOops: kernel access of bad area, sig: 11 [#57]=0A=
=0DOops: kernel access of bad area, sig: 11 [#58]=0A=
=0DOops: kernel access of bad area, sig: 11 [#59]=0A=
=0DOops: kernel access of bad area, sig: 11 [#60]=0A=
=0DOops: kernel access of bad area, sig: 11 [#61]=0A=
=0DOops: kernel access of bad area, sig: 11 [#62]=0A=
=0DOops: kernel access of bad area, sig: 11 [#63]=0A=
=0DOops: kernel access of bad area, sig: 11 [#64]=0A=
=0DOops: kernel access of bad area, sig: 11 [#65]=0A=
=0DOops: kernel access of bad area, sig: 11 [#66]=0A=
=0DOops: kernel access of bad area, sig: 11 [#67]=0A=
=0DOops: kernel access of bad area, sig: 11 [#68]=0A=
=0DOops: kernel access of bad area, sig: 11 [#69]=0A=
=0DOops: kernel access of bad area, sig: 11 [#70]=0A=
=0DOops: kernel access of bad area, sig: 11 [#71]=0A=
=0DOops: kernel access of bad area, sig: 11 [#72]=0A=
=0DOops: kernel access of bad area, sig: 11 [#73]=0A=
=0DOops: kernel access of bad area, sig: 11 [#74]=0A=
=0DOops: kernel access of bad area, sig: 11 [#75]=0A=
=0DOops: kernel access of bad area, sig: 11 [#76]=0A=
=0DOops: kernel access of bad area, sig: 11 [#77]=0A=
=0DOops: kernel access of bad area, sig: 11 [#78]=0A=
=0DOops: kernel access of bad area, sig: 11 [#79]=0A=
=0DOops: kernel access of bad area, sig: 11 [#80]=0A=
=0DOops: kernel access of bad area, sig: 11 [#81]=0A=
=0DOops: kernel access of bad area, sig: 11 [#82]=0A=
=0DOops: kernel access of bad area, sig: 11 [#83]=0A=
=0DOops: kernel access of bad area, sig: 11 [#84]=0A=
=0DOops: kernel access of bad area, sig: 11 [#85]=0A=
=0DOops: kernel access of bad area, sig: 11 [#86]=0A=
=0DOops: kernel access of bad area, sig: 11 [#87]=0A=
=0DOops: kernel access of bad area, sig: 11 [#88]=0A=
=0DOops: kernel access of bad area, sig: 11 [#89]=0A=
=0DOops: kernel access of bad area, sig: 11 [#90]=0A=
=0DOops: kernel access of bad area, sig: 11 [#91]=0A=
=0DOops: kernel access of bad area, sig: 11 [#92]=0A=
=0DOops: kernel access of bad area, sig: 11 [#93]=0A=
=0DOops: kernel access of bad area, sig: 11 [#94]=0A=
=0DOops: kernel access of bad area, sig: 11 [#95]=0A=
=0DOops: kernel access of bad area, sig: 11 [#96]=0A=
=0DOops: kernel access of bad area, sig: 11 [#97]=0A=
=0DOops: kernel access of bad area, sig: 11 [#98]=0A=
=0DOops: kernel access of bad area, sig: 11 [#99]=0A=
=0DOops: kernel access of bad area, sig: 11 [#100]=0A=
=0DOops: kernel access of bad area, sig: 11 [#101]=0A=
=0DOops: kernel access of bad area, sig: 11 [#102]=0A=
=0DOops: kernel access of bad area, sig: 11 [#103]=0A=
=0DOops: kernel access of bad area, sig: 11 [#104]=0A=
=0DOops: kernel access of bad area, sig: 11 [#105]=0A=
=0DOops: kernel access of bad area, sig: 11 [#106]=0A=
=0DOops: kernel access of bad area, sig: 11 [#107]=0A=
=0DOops: kernel access of bad area, sig: 11 [#108]=0A=
=0DOops: kernel access of bad area, sig: 11 [#109]=0A=
=0DOops: kernel access of bad area, sig: 11 [#110]=0A=
=0DOops: kernel access of bad area, sig: 11 [#111]=0A=
=0DOops: kernel access of bad area, sig: 11 [#112]=0A=
=0DOops: kernel access of bad area, sig: 11 [#113]=0A=
=0DOops: kernel access of bad area, sig: 11 [#114]=0A=
=0DOops: kernel access of bad area, sig: 11 [#115]=0A=
=0DOops: kernel access of bad area, sig: 11 [#116]=0A=
=0DOops: kernel access of bad area, sig: 11 [#117]=0A=
=0DOops: kernel access of bad area, sig: 11 [#118]=0A=
=0DOops: kernel access of bad area, sig: 11 [#119]=0A=
=0DOops: kernel access of bad area, sig: 11 [#120]=0A=
=0DOops: kernel access of bad area, sig: 11 [#121]=0A=
=0DOops: kernel access of bad area, sig: 11 [#122]=0A=
=0DOops: kernel access of bad area, sig: 11 [#123]=0A=
=0DOops: kernel access of bad area, sig: 11 [#124]=0A=
=0DOops: kernel access of bad area, sig: 11 [#125]=0A=
=0DOops: kernel access of bad area, sig: 11 [#126]=0A=
=0DOops: kernel access of bad area, sig: 11 [#127]=0A=
=0DOops: kernel access of bad area, sig: 11 [#128]=0A=
=0DOops: kernel access of bad area, sig: 11 [#129]=0A=
=0DOops: kernel access of bad area, sig: 11 [#130]=0A=
=0DOops: kernel access of bad area, sig: 11 [#131]=0A=
=0DOops: kernel access of bad area, sig: 11 [#132]=0A=
=0DOops: kernel access of bad area, sig: 11 [#133]=0A=
=0DOops: kernel access of bad area, sig: 11 [#134]=0A=
=0DOops: kernel access of bad area, sig: 11 [#135]=0A=
=0DOops: kernel access of bad area, sig: 11 [#136]=0A=
=0DOops: kernel access of bad area, sig: 11 [#137]=0A=
=0DOops: kernel access of bad area, sig: 11 [#138]=0A=
=0DOops: kernel access of bad area, sig: 11 [#139]=0A=
=0DOops: kernel access of bad area, sig: 11 [#140]=0A=
=0DOops: kernel access of bad area, sig: 11 [#141]=0A=
=0DOops: kernel access of bad area, sig: 11 [#142]=0A=
=0DOops: kernel access of bad area, sig: 11 [#143]=0A=
=0DOops: kernel access of bad area, sig: 11 [#144]=0A=
=0DOops: kernel access of bad area, sig: 11 [#145]=0A=
=0DOops: kernel access of bad area, sig: 11 [#146]=0A=
=0DOops: kernel access of bad area, sig: 11 [#147]=0A=
=0DOops: kernel access of bad area, sig: 11 [#148]=0A=
=0DOops: kernel access of bad area, sig: 11 [#149]=0A=
=0DOops: kernel access of bad area, sig: 11 [#150]=0A=
=0DOops: kernel access of bad area, sig: 11 [#151]=0A=
=0DOops: kernel access of bad area, sig: 11 [#152]=0A=
=0DOops: kernel access of bad area, sig: 11 [#153]=0A=
=0DOops: kernel access of bad area, sig: 11 [#154]=0A=
=0DOops: kernel access of bad area, sig: 11 [#155]=0A=
=0DOops: kernel access of bad area, sig: 11 [#156]=0A=
=0DOops: kernel access of bad area, sig: 11 [#157]=0A=
=0DOops: kernel access of bad area, sig: 11 [#158]=0A=
=0DOops: kernel access of bad area, sig: 11 [#159]=0A=
=0DOops: kernel access of bad area, sig: 11 [#160]=0A=
=0DOops: kernel access of bad area, sig: 11 [#161]=0A=
=0DOops: kernel access of bad area, sig: 11 [#162]=0A=
=0DOops: kernel access of bad area, sig: 11 [#163]=0A=
=0DOops: kernel access of bad area, sig: 11 [#164]=0A=
=0DOops: kernel access of bad area, sig: 11 [#165]=0A=
=0DOops: kernel access of bad area, sig: 11 [#166]=0A=
=0DOops: kernel access of bad area, sig: 11 [#167]=0A=
=0DOops: kernel access of bad area, sig: 11 [#168]=0A=
=0DOops: kernel access of bad area, sig: 11 [#169]=0A=
=0DOops: kernel access of bad area, sig: 11 [#170]=0A=
=0DOops: kernel access of bad area, sig: 11 [#171]=0A=
=0DOops: kernel access of bad area, sig: 11 [#172]=0A=
=0DOops: kernel access of bad area, sig: 11 [#173]=0A=
=0DOops: kernel access of bad area, sig: 11 [#174]=0A=
=0DOops: kernel access of bad area, sig: 11 [#175]=0A=
=0DOops: kernel access of bad area, sig: 11 [#176]=0A=
=0DOops: kernel access of bad area, sig: 11 [#177]=0A=
=0DOops: kernel access of bad area, sig: 11 [#178]=0A=
=0DOops: kernel access of bad area, sig: 11 [#179]=0A=
=0DOops: kernel access of bad area, sig: 11 [#180]=0A=
=0DOops: kernel access of bad area, sig: 11 [#181]=0A=
=0DOops: kernel access of bad area, sig: 11 [#182]=0A=
=0DOops: kernel access of bad area, sig: 11 [#183]=0A=
=0DOops: kernel access of bad area, sig: 11 [#184]=0A=
=0DOops: kernel access of bad area, sig: 11 [#185]=0A=
=0DOops: kernel access of bad area, sig: 11 [#186]=0A=
=0DOops: kernel access of bad area, sig: 11 [#187]=0A=
=0DOops: kernel access of bad area, sig: 11 [#188]=0A=
=0DOops: kernel access of bad area, sig: 11 [#189]=0A=
=0DOops: kernel access of bad area, sig: 11 [#190]=0A=
=0DOops: kernel access of bad area, sig: 11 [#191]=0A=
=0DOops: kernel access of bad area, sig: 11 [#192]=0A=
=0DOops: kernel access of bad area, sig: 11 [#193]=0A=
=0DOops: kernel access of bad area, sig: 11 [#194]=0A=
=0DOops: kernel access of bad area, sig: 11 [#195]=0A=
=0DOops: kernel access of bad area, sig: 11 [#196]=0A=
=0DOops: kernel access of bad area, sig: 11 [#197]=0A=
=0DOops: kernel access of bad area, sig: 11 [#198]=0A=
=0DOops: kernel access of bad area, sig: 11 [#199]=0A=
=0DOops: kernel access of bad area, sig: 11 [#200]=0A=
=0DOops: kernel access of bad area, sig: 11 [#201]=0A=
=0DOops: kernel access of bad area, sig: 11 [#202]=0A=
=0DOops: kernel access of bad area, sig: 11 [#203]=0A=
=0DOops: kernel access of bad area, sig: 11 [#204]=0A=
=0DOops: kernel access of bad area, sig: 11 [#205]=0A=
=0DOops: kernel access of bad area, sig: 11 [#206]=0A=
=0DOops: kernel access of bad area, sig: 11 [#207]=0A=
=0DOops: kernel access of bad area, sig: 11 [#208]=0A=
=0DOops: kernel access of bad area, sig: 11 [#209]=0A=
=0DOops: kernel access of bad area, sig: 11 [#210]=0A=
=0DOops: kernel access of bad area, sig: 11 [#211]=0A=
=0DOops: kernel access of bad area, sig: 11 [#212]=0A=
=0DOops: kernel access of bad area, sig: 11 [#213]=0A=
=0DOops: kernel access of bad area, sig: 11 [#214]=0A=
=0DOops: kernel access of bad area, sig: 11 [#215]=0A=
=0DOops: kernel access of bad area, sig: 11 [#216]=0A=
=0DOops: kernel access of bad area, sig: 11 [#217]=0A=
=0DOops: kernel access of bad area, sig: 11 [#218]=0A=
=0DOops: kernel access of bad area, sig: 11 [#219]=0A=
=0DOops: kernel access of bad area, sig: 11 [#220]=0A=
=0DOops: kernel access of bad area, sig: 11 [#221]=0A=
=0DOops: kernel access of bad area, sig: 11 [#222]=0A=
=0DOops: kernel access of bad area, sig: 11 [#223]=0A=
=0DOops: kernel access of bad area, sig: 11 [#224]=0A=
=0DOops: kernel access of bad area, sig: 11 [#225]=0A=
=0DOops: kernel access of bad area, sig: 11 [#226]=0A=
=0DOops: kernel access of bad area, sig: 11 [#227]=0A=
=0DOops: kernel access of bad area, sig: 11 [#228]=0A=
=0DOops: kernel access of bad area, sig: 11 [#229]=0A=
=0DOops: kernel access of bad area, sig: 11 [#230]=0A=
=0DOops: kernel access of bad area, sig: 11 [#231]=0A=
=0DOops: kernel access of bad area, sig: 11 [#232]=0A=
=0DOops: kernel access of bad area, sig: 11 [#233]=0A=
=0DOops: kernel access of bad area, sig: 11 [#234]=0A=
=0DOops: kernel access of bad area, sig: 11 [#235]=0A=
=0DOops: kernel access of bad area, sig: 11 [#236]=0A=
=0DOops: kernel access of bad area, sig: 11 [#237]=0A=
=0DOops: kernel access of bad area, sig: 11 [#238]=0A=
=0DOops: kernel access of bad area, sig: 11 [#239]=0A=
=0DOops: kernel access of bad area, sig: 11 [#240]=0A=
=0DOops: kernel access of bad area, sig: 11 [#241]=0A=
=0DOops: kernel access of bad area, sig: 11 [#242]=0A=
=0DOops: kernel access of bad area, sig: 11 [#243]=0A=
=0DOops: kernel access of bad area, sig: 11 [#244]=0A=
=0DOops: kernel access of bad area, sig: 11 [#245]=0A=
=0DOops: kernel access of bad area, sig: 11 [#246]=0A=
=0DOops: kernel access of bad area, sig: 11 [#247]=0A=
=0DOops: kernel access of bad area, sig: 11 [#248]=0A=
=0DOops: kernel access of bad area, sig: 11 [#249]=0A=
=0DOops: kernel access of bad area, sig: 11 [#250]=0A=
=0DOops: kernel access of bad area, sig: 11 [#251]=0A=
=0DOops: kernel access of bad area, sig: 11 [#252]=0A=
=0DOops: kernel access of bad area, sig: 11 [#253]=0A=
=0DOops: kernel access of bad area, sig: 11 [#254]=0A=
=0DOops: kernel access of bad area, sig: 11 [#255]=0A=
=0DOops: kernel access of bad area, sig: 11 [#256]=0A=
=0DOops: kernel access of bad area, sig: 11 [#257]=0A=
=0DOops: kernel access of bad area, sig: 11 [#258]=0A=
=0DOops: kernel access of bad area, sig: 11 [#259]=0A=
=0DOops: kernel access of bad area, sig: 11 [#260]=0A=
=0DOops: kernel access of bad area, sig: 11 [#261]=0A=
=0DOops: kernel access of bad area, sig: 11 [#262]=0A=
=0DOops: kernel access of bad area, sig: 11 [#263]=0A=
=0DOops: kernel access of bad area, sig: 11 [#264]=0A=
=0DOops: kernel access of bad area, sig: 11 [#265]=0A=
=0DOops: kernel access of bad area, sig: 11 [#266]=0A=
=0DOops: kernel access of bad area, sig: 11 [#267]=0A=
=0DOops: kernel access of bad area, sig: 11 [#268]=0A=
=0DOops: kernel access of bad area, sig: 11 [#269]=0A=
=0DOops: kernel access of bad area, sig: 11 [#270]=0A=
=0DOops: kernel access of bad area, sig: 11 [#271]=0A=
=0DOops: kernel access of bad area, sig: 11 [#272]=0A=
=0DOops: kernel access of bad area, sig: 11 [#273]=0A=
=0DOops: kernel access of bad area, sig: 11 [#274]=0A=
=0DOops: kernel access of bad area, sig: 11 [#275]=0A=
=0DOops: kernel access of bad area, sig: 11 [#276]=0A=
=0DOops: kernel access of bad area, sig: 11 [#277]=0A=
=0DOops: kernel access of bad area, sig: 11 [#278]=0A=
=0DOops: kernel access of bad area, sig: 11 [#279]=0A=
=0DOops: kernel access of bad area, sig: 11 [#280]=0A=
=0DOops: kernel access of bad area, sig: 11 [#281]=0A=
=0DOops: kernel access of bad area, sig: 11 [#282]=0A=
=0DOops: kernel access of bad area, sig: 11 [#283]=0A=
=0DOops: kernel access of bad area, sig: 11 [#284]=0A=
=0DOops: kernel access of bad area, sig: 11 [#285]=0A=
=0DOops: kernel access of bad area, sig: 11 [#286]=0A=
=0DOops: kernel access of bad area, sig: 11 [#287]=0A=
=0DOops: kernel access of bad area, sig: 11 [#288]=0A=
=0DOops: kernel access of bad area, sig: 11 [#289]=0A=
=0DOops: kernel access of bad area, sig: 11 [#290]=0A=
=0DOops: kernel access of bad area, sig: 11 [#291]=0A=
=0DOops: kernel access of bad area, sig: 11 [#292]=0A=
=0DOops: kernel access of bad area, sig: 11 [#293]=0A=
=0DOops: kernel access of bad area, sig: 11 [#294]=0A=
=0DOops: kernel access of bad area, sig: 11 [#295]=0A=
=0DOops: kernel access of bad area, sig: 11 [#296]=0A=
=0DOops: kernel access of bad area, sig: 11 [#297]=0A=
=0DOops: kernel access of bad area, sig: 11 [#298]=0A=
=0DOops: kernel access of bad area, sig: 11 [#299]=0A=
=0DOops: kernel access of bad area, sig: 11 [#300]=0A=
=0DOops: kernel access of bad area, sig: 11 [#301]=0A=
=0DOops: kernel access of bad area, sig: 11 [#302]=0A=
=0DOops: kernel access of bad area, sig: 11 [#303]=0A=
=0DOops: kernel access of bad area, sig: 11 [#304]=0A=
=0DOops: kernel access of bad area, sig: 11 [#305]=0A=
=0DOops: kernel access of bad area, sig: 11 [#306]=0A=
=0DOops: kernel access of bad area, sig: 11 [#307]=0A=
=0DOops: kernel access of bad area, sig: 11 [#308]=0A=
=0D
------=_NextPart_000_0063_01C5A80A.150DEA60--
