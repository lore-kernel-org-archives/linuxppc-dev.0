Return-Path: <waite@skycomputers.com>
Received: from sky.skycomputers.com (sky.skycomputers.com [198.4.246.2])
	by ozlabs.org (Postfix) with ESMTP id EA60C67A70
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 18 Mar 2005 02:35:42 +1100 (EST)
From: Brian Waite <waite@skycomputers.com>
To: linuxppc-embedded@ozlabs.org, "Mark A. Greer" <mgreer@mvista.com>
Date: Thu, 17 Mar 2005 09:53:01 -0500
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200503170953.02626.waite@skycomputers.com>
Cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] ppc32: 0/2 add support for Sky Computers HDPU Compute blade
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Add support for Sky Computers HDPU Compute blade

Signed-off-by: Brian Waite <waite@skycomputers.com>

The Sky Computers HDPU compute blade is an embedded compute platform for the 
Sky Computers SMARTpac 600/1200 series. A blade consists of 
ppc7445/ppc7447A, Marvell Discovery II,  100 BaseT ethernet, a single 
PCI/PCI-X slot, and a PCI-X on-board Infiniband device.

This patch contains the base platform support required for booting Linux.

diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper 
--exclude=ChangeSet linux-2.5/arch/ppc/Kconfig 
linux-2.5-hdpu/arch/ppc/Kconfig
--- linux-2.5/arch/ppc/Kconfig	2005-03-16 14:40:35 -05:00
+++ linux-2.5-hdpu/arch/ppc/Kconfig	2005-03-16 14:01:21 -05:00
@@ -538,6 +538,11 @@
 config SPRUCE
 	bool "IBM-Spruce"
 
+config HDPU
+	bool "Sky-HDPU"
+	help
+	  Select HDPU if configuring a Sky Computers Compute Blade.
+
 config EV64260
 	bool "Marvell-EV64260BP"
 	help
@@ -748,7 +759,7 @@
 
 config MV64360
 	bool
-	depends on KATANA || RADSTONE_PPC7D
+	depends on KATANA || RADSTONE_PPC7D || HDPU
 	default y
 
 config MV64360
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper 
--exclude=ChangeSet linux-2.5/arch/ppc/configs/hdpu_defconfig 
linux-2.5-hdpu/arch/ppc/configs/hdpu_defconfig
--- linux-2.5/arch/ppc/configs/hdpu_defconfig	1969-12-31 19:00:00 -05:00
+++ linux-2.5-hdpu/arch/ppc/configs/hdpu_defconfig	2005-03-16 14:01:22 -05:00
@@ -0,0 +1,890 @@
+#
+# Automatically generated make config: don't edit
+# Linux kernel version: 2.6.11
+# Wed Mar 16 12:43:19 2005
+#
+CONFIG_MMU=y
+CONFIG_GENERIC_HARDIRQS=y
+CONFIG_RWSEM_XCHGADD_ALGORITHM=y
+CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_HAVE_DEC_LOCK=y
+CONFIG_PPC=y
+CONFIG_PPC32=y
+CONFIG_GENERIC_NVRAM=y
+
+#
+# Code maturity level options
+#
+CONFIG_EXPERIMENTAL=y
+CONFIG_CLEAN_COMPILE=y
+CONFIG_LOCK_KERNEL=y
+
+#
+# General setup
+#
+CONFIG_LOCALVERSION=""
+CONFIG_SWAP=y
+CONFIG_SYSVIPC=y
+# CONFIG_POSIX_MQUEUE is not set
+# CONFIG_BSD_PROCESS_ACCT is not set
+CONFIG_SYSCTL=y
+# CONFIG_AUDIT is not set
+CONFIG_HOTPLUG=y
+CONFIG_KOBJECT_UEVENT=y
+# CONFIG_IKCONFIG is not set
+# CONFIG_CPUSETS is not set
+CONFIG_EMBEDDED=y
+# CONFIG_KALLSYMS is not set
+CONFIG_BASE_FULL=y
+CONFIG_FUTEX=y
+CONFIG_EPOLL=y
+# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
+CONFIG_SHMEM=y
+CONFIG_CC_ALIGN_FUNCTIONS=0
+CONFIG_CC_ALIGN_LABELS=0
+CONFIG_CC_ALIGN_LOOPS=0
+CONFIG_CC_ALIGN_JUMPS=0
+# CONFIG_TINY_SHMEM is not set
+CONFIG_BASE_SMALL=0
+
+#
+# Loadable module support
+#
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+# CONFIG_MODULE_FORCE_UNLOAD is not set
+CONFIG_OBSOLETE_MODPARM=y
+# CONFIG_MODVERSIONS is not set
+# CONFIG_MODULE_SRCVERSION_ALL is not set
+CONFIG_KMOD=y
+CONFIG_STOP_MACHINE=y
+
+#
+# Processor
+#
+CONFIG_6xx=y
+# CONFIG_40x is not set
+# CONFIG_44x is not set
+# CONFIG_POWER3 is not set
+# CONFIG_POWER4 is not set
+# CONFIG_8xx is not set
+# CONFIG_E500 is not set
+CONFIG_ALTIVEC=y
+# CONFIG_TAU is not set
+# CONFIG_CPU_FREQ is not set
+# CONFIG_PM is not set
+CONFIG_PPC_STD_MMU=y
+# CONFIG_NOT_COHERENT_CACHE is not set
+
+#
+# Platform options
+#
+# CONFIG_PPC_MULTIPLATFORM is not set
+# CONFIG_APUS is not set
+# CONFIG_KATANA is not set
+# CONFIG_WILLOW is not set
+# CONFIG_CPCI690 is not set
+# CONFIG_PCORE is not set
+# CONFIG_POWERPMC250 is not set
+# CONFIG_CHESTNUT is not set
+# CONFIG_SPRUCE is not set
+CONFIG_HDPU=y
+# CONFIG_EV64260 is not set
+# CONFIG_LOPEC is not set
+# CONFIG_MCPN765 is not set
+# CONFIG_MVME5100 is not set
+# CONFIG_PPLUS is not set
+# CONFIG_PRPMC750 is not set
+# CONFIG_PRPMC800 is not set
+# CONFIG_SANDPOINT is not set
+# CONFIG_RADSTONE_PPC7D is not set
+# CONFIG_ADIR is not set
+# CONFIG_K2 is not set
+# CONFIG_PAL4 is not set
+# CONFIG_GEMINI is not set
+# CONFIG_EST8260 is not set
+# CONFIG_SBC82xx is not set
+# CONFIG_SBS8260 is not set
+# CONFIG_RPX8260 is not set
+# CONFIG_TQM8260 is not set
+# CONFIG_ADS8272 is not set
+# CONFIG_PQ2FADS is not set
+# CONFIG_LITE5200 is not set
+# CONFIG_MPC834x_SYS is not set
+CONFIG_MV64360=y
+CONFIG_MV64X60=y
+
+#
+# Set bridge options
+#
+CONFIG_MV64X60_BASE=0xf1000000
+CONFIG_MV64X60_NEW_BASE=0xf1000000
+# CONFIG_SMP is not set
+# CONFIG_IRQ_ALL_CPUS is not set
+# CONFIG_NR_CPUS is not set
+CONFIG_PREEMPT=y
+CONFIG_HIGHMEM=y
+CONFIG_BINFMT_ELF=y
+CONFIG_BINFMT_MISC=y
+CONFIG_CMDLINE_BOOL=y
+CONFIG_CMDLINE="root=/dev/nfs ip=auto"
+
+#
+# Bus options
+#
+CONFIG_GENERIC_ISA_DMA=y
+CONFIG_PCI=y
+CONFIG_PCI_DOMAINS=y
+CONFIG_PCI_LEGACY_PROC=y
+CONFIG_PCI_NAMES=y
+
+#
+# PCCARD (PCMCIA/CardBus) support
+#
+# CONFIG_PCCARD is not set
+
+#
+# Advanced setup
+#
+CONFIG_ADVANCED_OPTIONS=y
+# CONFIG_HIGHMEM_START_BOOL is not set
+CONFIG_HIGHMEM_START=0xfe000000
+# CONFIG_LOWMEM_SIZE_BOOL is not set
+CONFIG_LOWMEM_SIZE=0x30000000
+CONFIG_KERNEL_START_BOOL=y
+CONFIG_KERNEL_START=0x80000000
+# CONFIG_TASK_SIZE_BOOL is not set
+CONFIG_TASK_SIZE=0x80000000
+# CONFIG_BOOT_LOAD_BOOL is not set
+CONFIG_BOOT_LOAD=0x00800000
+
+#
+# Device Drivers
+#
+
+#
+# Generic Driver Options
+#
+CONFIG_STANDALONE=y
+CONFIG_PREVENT_FIRMWARE_BUILD=y
+CONFIG_FW_LOADER=y
+
+#
+# Memory Technology Devices (MTD)
+#
+CONFIG_MTD=y
+# CONFIG_MTD_DEBUG is not set
+# CONFIG_MTD_CONCAT is not set
+CONFIG_MTD_PARTITIONS=y
+# CONFIG_MTD_REDBOOT_PARTS is not set
+# CONFIG_MTD_CMDLINE_PARTS is not set
+
+#
+# User Modules And Translation Layers
+#
+CONFIG_MTD_CHAR=y
+# CONFIG_MTD_BLOCK is not set
+# CONFIG_MTD_BLOCK_RO is not set
+# CONFIG_FTL is not set
+# CONFIG_NFTL is not set
+# CONFIG_INFTL is not set
+
+#
+# RAM/ROM/Flash chip drivers
+#
+CONFIG_MTD_CFI=y
+# CONFIG_MTD_JEDECPROBE is not set
+CONFIG_MTD_GEN_PROBE=y
+# CONFIG_MTD_CFI_ADV_OPTIONS is not set
+CONFIG_MTD_MAP_BANK_WIDTH_1=y
+CONFIG_MTD_MAP_BANK_WIDTH_2=y
+CONFIG_MTD_MAP_BANK_WIDTH_4=y
+# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
+# CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
+# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
+CONFIG_MTD_CFI_I1=y
+CONFIG_MTD_CFI_I2=y
+# CONFIG_MTD_CFI_I4 is not set
+# CONFIG_MTD_CFI_I8 is not set
+CONFIG_MTD_CFI_INTELEXT=y
+# CONFIG_MTD_CFI_AMDSTD is not set
+# CONFIG_MTD_CFI_STAA is not set
+CONFIG_MTD_CFI_UTIL=y
+# CONFIG_MTD_RAM is not set
+# CONFIG_MTD_ROM is not set
+# CONFIG_MTD_ABSENT is not set
+
+#
+# Mapping drivers for chip access
+#
+# CONFIG_MTD_COMPLEX_MAPPINGS is not set
+CONFIG_MTD_PHYSMAP=y
+CONFIG_MTD_PHYSMAP_START=0xfc000000
+CONFIG_MTD_PHYSMAP_LEN=0x04000000
+CONFIG_MTD_PHYSMAP_BANKWIDTH=4
+
+#
+# Self-contained MTD device drivers
+#
+# CONFIG_MTD_PMC551 is not set
+# CONFIG_MTD_SLRAM is not set
+# CONFIG_MTD_PHRAM is not set
+# CONFIG_MTD_MTDRAM is not set
+# CONFIG_MTD_BLKMTD is not set
+# CONFIG_MTD_BLOCK2MTD is not set
+
+#
+# Disk-On-Chip Device Drivers
+#
+# CONFIG_MTD_DOC2000 is not set
+# CONFIG_MTD_DOC2001 is not set
+# CONFIG_MTD_DOC2001PLUS is not set
+
+#
+# NAND Flash Device Drivers
+#
+# CONFIG_MTD_NAND is not set
+
+#
+# Parallel port support
+#
+# CONFIG_PARPORT is not set
+
+#
+# Plug and Play support
+#
+
+#
+# Block devices
+#
+# CONFIG_BLK_DEV_FD is not set
+# CONFIG_BLK_CPQ_DA is not set
+# CONFIG_BLK_CPQ_CISS_DA is not set
+# CONFIG_BLK_DEV_DAC960 is not set
+# CONFIG_BLK_DEV_UMEM is not set
+# CONFIG_BLK_DEV_COW_COMMON is not set
+CONFIG_BLK_DEV_LOOP=y
+# CONFIG_BLK_DEV_CRYPTOLOOP is not set
+# CONFIG_BLK_DEV_NBD is not set
+# CONFIG_BLK_DEV_SX8 is not set
+CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_COUNT=16
+CONFIG_BLK_DEV_RAM_SIZE=8192
+CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS_SOURCE=""
+# CONFIG_LBD is not set
+# CONFIG_CDROM_PKTCDVD is not set
+
+#
+# IO Schedulers
+#
+CONFIG_IOSCHED_NOOP=y
+CONFIG_IOSCHED_AS=y
+CONFIG_IOSCHED_DEADLINE=y
+CONFIG_IOSCHED_CFQ=y
+# CONFIG_ATA_OVER_ETH is not set
+
+#
+# ATA/ATAPI/MFM/RLL support
+#
+# CONFIG_IDE is not set
+
+#
+# SCSI device support
+#
+CONFIG_SCSI=y
+CONFIG_SCSI_PROC_FS=y
+
+#
+# SCSI support type (disk, tape, CD-ROM)
+#
+CONFIG_BLK_DEV_SD=y
+CONFIG_CHR_DEV_ST=y
+# CONFIG_CHR_DEV_OSST is not set
+CONFIG_BLK_DEV_SR=y
+# CONFIG_BLK_DEV_SR_VENDOR is not set
+CONFIG_CHR_DEV_SG=y
+
+#
+# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
+#
+# CONFIG_SCSI_MULTI_LUN is not set
+CONFIG_SCSI_CONSTANTS=y
+# CONFIG_SCSI_LOGGING is not set
+
+#
+# SCSI Transport Attributes
+#
+# CONFIG_SCSI_SPI_ATTRS is not set
+# CONFIG_SCSI_FC_ATTRS is not set
+# CONFIG_SCSI_ISCSI_ATTRS is not set
+
+#
+# SCSI low-level drivers
+#
+# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
+# CONFIG_SCSI_3W_9XXX is not set
+# CONFIG_SCSI_ACARD is not set
+# CONFIG_SCSI_AACRAID is not set
+CONFIG_SCSI_AIC7XXX=y
+CONFIG_AIC7XXX_CMDS_PER_DEVICE=32
+CONFIG_AIC7XXX_RESET_DELAY_MS=15000
+# CONFIG_AIC7XXX_DEBUG_ENABLE is not set
+CONFIG_AIC7XXX_DEBUG_MASK=0
+# CONFIG_AIC7XXX_REG_PRETTY_PRINT is not set
+# CONFIG_SCSI_AIC7XXX_OLD is not set
+# CONFIG_SCSI_AIC79XX is not set
+# CONFIG_SCSI_DPT_I2O is not set
+# CONFIG_MEGARAID_NEWGEN is not set
+# CONFIG_MEGARAID_LEGACY is not set
+# CONFIG_SCSI_SATA is not set
+# CONFIG_SCSI_BUSLOGIC is not set
+# CONFIG_SCSI_DMX3191D is not set
+# CONFIG_SCSI_EATA is not set
+# CONFIG_SCSI_EATA_PIO is not set
+# CONFIG_SCSI_FUTURE_DOMAIN is not set
+# CONFIG_SCSI_GDTH is not set
+# CONFIG_SCSI_IPS is not set
+# CONFIG_SCSI_INITIO is not set
+# CONFIG_SCSI_INIA100 is not set
+# CONFIG_SCSI_SYM53C8XX_2 is not set
+# CONFIG_SCSI_IPR is not set
+# CONFIG_SCSI_QLOGIC_ISP is not set
+# CONFIG_SCSI_QLOGIC_FC is not set
+# CONFIG_SCSI_QLOGIC_1280 is not set
+CONFIG_SCSI_QLA2XXX=y
+# CONFIG_SCSI_QLA21XX is not set
+# CONFIG_SCSI_QLA22XX is not set
+# CONFIG_SCSI_QLA2300 is not set
+# CONFIG_SCSI_QLA2322 is not set
+# CONFIG_SCSI_QLA6312 is not set
+# CONFIG_SCSI_DC395x is not set
+# CONFIG_SCSI_DC390T is not set
+# CONFIG_SCSI_NSP32 is not set
+# CONFIG_SCSI_DEBUG is not set
+
+#
+# Multi-device support (RAID and LVM)
+#
+# CONFIG_MD is not set
+
+#
+# Fusion MPT device support
+#
+# CONFIG_FUSION is not set
+
+#
+# IEEE 1394 (FireWire) support
+#
+# CONFIG_IEEE1394 is not set
+
+#
+# I2O device support
+#
+# CONFIG_I2O is not set
+
+#
+# Macintosh device drivers
+#
+
+#
+# Networking support
+#
+CONFIG_NET=y
+
+#
+# Networking options
+#
+CONFIG_PACKET=y
+CONFIG_PACKET_MMAP=y
+# CONFIG_NETLINK_DEV is not set
+CONFIG_UNIX=y
+# CONFIG_NET_KEY is not set
+CONFIG_INET=y
+CONFIG_IP_MULTICAST=y
+# CONFIG_IP_ADVANCED_ROUTER is not set
+CONFIG_IP_PNP=y
+# CONFIG_IP_PNP_DHCP is not set
+CONFIG_IP_PNP_BOOTP=y
+# CONFIG_IP_PNP_RARP is not set
+# CONFIG_NET_IPIP is not set
+# CONFIG_NET_IPGRE is not set
+# CONFIG_IP_MROUTE is not set
+# CONFIG_ARPD is not set
+# CONFIG_SYN_COOKIES is not set
+# CONFIG_INET_AH is not set
+# CONFIG_INET_ESP is not set
+# CONFIG_INET_IPCOMP is not set
+# CONFIG_INET_TUNNEL is not set
+# CONFIG_IP_TCPDIAG is not set
+# CONFIG_IP_TCPDIAG_IPV6 is not set
+# CONFIG_IPV6 is not set
+# CONFIG_NETFILTER is not set
+
+#
+# SCTP Configuration (EXPERIMENTAL)
+#
+# CONFIG_IP_SCTP is not set
+# CONFIG_ATM is not set
+# CONFIG_BRIDGE is not set
+# CONFIG_VLAN_8021Q is not set
+# CONFIG_DECNET is not set
+# CONFIG_LLC2 is not set
+# CONFIG_IPX is not set
+# CONFIG_ATALK is not set
+# CONFIG_X25 is not set
+# CONFIG_LAPB is not set
+# CONFIG_NET_DIVERT is not set
+# CONFIG_ECONET is not set
+# CONFIG_WAN_ROUTER is not set
+
+#
+# QoS and/or fair queueing
+#
+# CONFIG_NET_SCHED is not set
+# CONFIG_NET_CLS_ROUTE is not set
+
+#
+# Network testing
+#
+# CONFIG_NET_PKTGEN is not set
+# CONFIG_NETPOLL is not set
+# CONFIG_NET_POLL_CONTROLLER is not set
+# CONFIG_HAMRADIO is not set
+# CONFIG_IRDA is not set
+# CONFIG_BT is not set
+CONFIG_NETDEVICES=y
+# CONFIG_DUMMY is not set
+# CONFIG_BONDING is not set
+# CONFIG_EQUALIZER is not set
+# CONFIG_TUN is not set
+
+#
+# ARCnet devices
+#
+# CONFIG_ARCNET is not set
+
+#
+# Ethernet (10 or 100Mbit)
+#
+CONFIG_NET_ETHERNET=y
+CONFIG_MII=y
+# CONFIG_HAPPYMEAL is not set
+# CONFIG_SUNGEM is not set
+# CONFIG_NET_VENDOR_3COM is not set
+
+#
+# Tulip family network device support
+#
+# CONFIG_NET_TULIP is not set
+# CONFIG_HP100 is not set
+# CONFIG_NET_PCI is not set
+
+#
+# Ethernet (1000 Mbit)
+#
+# CONFIG_ACENIC is not set
+# CONFIG_DL2K is not set
+# CONFIG_E1000 is not set
+# CONFIG_NS83820 is not set
+# CONFIG_HAMACHI is not set
+# CONFIG_YELLOWFIN is not set
+# CONFIG_R8169 is not set
+# CONFIG_SK98LIN is not set
+# CONFIG_TIGON3 is not set
+CONFIG_MV643XX_ETH=y
+CONFIG_MV643XX_ETH_0=y
+# CONFIG_MV643XX_ETH_1 is not set
+# CONFIG_MV643XX_ETH_2 is not set
+
+#
+# Ethernet (10000 Mbit)
+#
+# CONFIG_IXGB is not set
+# CONFIG_S2IO is not set
+
+#
+# Token Ring devices
+#
+# CONFIG_TR is not set
+
+#
+# Wireless LAN (non-hamradio)
+#
+# CONFIG_NET_RADIO is not set
+
+#
+# Wan interfaces
+#
+# CONFIG_WAN is not set
+# CONFIG_FDDI is not set
+# CONFIG_HIPPI is not set
+# CONFIG_PPP is not set
+# CONFIG_SLIP is not set
+# CONFIG_NET_FC is not set
+# CONFIG_SHAPER is not set
+# CONFIG_NETCONSOLE is not set
+
+#
+# ISDN subsystem
+#
+# CONFIG_ISDN is not set
+
+#
+# Telephony Support
+#
+# CONFIG_PHONE is not set
+
+#
+# Input device support
+#
+CONFIG_INPUT=y
+
+#
+# Userland interfaces
+#
+CONFIG_INPUT_MOUSEDEV=y
+CONFIG_INPUT_MOUSEDEV_PSAUX=y
+CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
+CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
+# CONFIG_INPUT_JOYDEV is not set
+# CONFIG_INPUT_TSDEV is not set
+# CONFIG_INPUT_EVDEV is not set
+# CONFIG_INPUT_EVBUG is not set
+
+#
+# Input Device Drivers
+#
+# CONFIG_INPUT_KEYBOARD is not set
+# CONFIG_INPUT_MOUSE is not set
+# CONFIG_INPUT_JOYSTICK is not set
+# CONFIG_INPUT_TOUCHSCREEN is not set
+# CONFIG_INPUT_MISC is not set
+
+#
+# Hardware I/O ports
+#
+# CONFIG_SERIO is not set
+# CONFIG_GAMEPORT is not set
+CONFIG_SOUND_GAMEPORT=y
+
+#
+# Character devices
+#
+# CONFIG_VT is not set
+# CONFIG_SERIAL_NONSTANDARD is not set
+
+#
+# Serial drivers
+#
+# CONFIG_SERIAL_8250 is not set
+
+#
+# Non-8250 serial port support
+#
+CONFIG_SERIAL_MPSC=y
+CONFIG_SERIAL_MPSC_CONSOLE=y
+CONFIG_SERIAL_CORE=y
+CONFIG_SERIAL_CORE_CONSOLE=y
+CONFIG_UNIX98_PTYS=y
+CONFIG_LEGACY_PTYS=y
+CONFIG_LEGACY_PTY_COUNT=256
+
+#
+# IPMI
+#
+# CONFIG_IPMI_HANDLER is not set
+
+#
+# Watchdog Cards
+#
+# CONFIG_WATCHDOG is not set
+# CONFIG_NVRAM is not set
+CONFIG_GEN_RTC=y
+# CONFIG_GEN_RTC_X is not set
+# CONFIG_DTLK is not set
+# CONFIG_R3964 is not set
+# CONFIG_APPLICOM is not set
+
+#
+# Ftape, the floppy tape device driver
+#
+# CONFIG_AGP is not set
+# CONFIG_DRM is not set
+# CONFIG_RAW_DRIVER is not set
+
+#
+# TPM devices
+#
+# CONFIG_TCG_TPM is not set
+
+#
+# I2C support
+#
+# CONFIG_I2C is not set
+
+#
+# Dallas's 1-wire bus
+#
+# CONFIG_W1 is not set
+
+#
+# Misc devices
+#
+
+#
+# Multimedia devices
+#
+# CONFIG_VIDEO_DEV is not set
+
+#
+# Digital Video Broadcasting Devices
+#
+# CONFIG_DVB is not set
+
+#
+# Graphics support
+#
+# CONFIG_FB is not set
+
+#
+# Sound
+#
+# CONFIG_SOUND is not set
+
+#
+# USB support
+#
+CONFIG_USB_ARCH_HAS_HCD=y
+CONFIG_USB_ARCH_HAS_OHCI=y
+# CONFIG_USB is not set
+
+#
+# USB Gadget Support
+#
+# CONFIG_USB_GADGET is not set
+
+#
+# MMC/SD Card support
+#
+# CONFIG_MMC is not set
+
+#
+# InfiniBand support
+#
+# CONFIG_INFINIBAND is not set
+
+#
+# File systems
+#
+CONFIG_EXT2_FS=y
+# CONFIG_EXT2_FS_XATTR is not set
+CONFIG_EXT3_FS=y
+# CONFIG_EXT3_FS_XATTR is not set
+CONFIG_JBD=y
+# CONFIG_JBD_DEBUG is not set
+# CONFIG_REISERFS_FS is not set
+# CONFIG_JFS_FS is not set
+CONFIG_FS_POSIX_ACL=y
+
+#
+# XFS support
+#
+# CONFIG_XFS_FS is not set
+# CONFIG_MINIX_FS is not set
+# CONFIG_ROMFS_FS is not set
+# CONFIG_QUOTA is not set
+CONFIG_DNOTIFY=y
+# CONFIG_AUTOFS_FS is not set
+# CONFIG_AUTOFS4_FS is not set
+
+#
+# CD-ROM/DVD Filesystems
+#
+CONFIG_ISO9660_FS=y
+CONFIG_JOLIET=y
+# CONFIG_ZISOFS is not set
+CONFIG_UDF_FS=y
+CONFIG_UDF_NLS=y
+
+#
+# DOS/FAT/NT Filesystems
+#
+# CONFIG_MSDOS_FS is not set
+# CONFIG_VFAT_FS is not set
+# CONFIG_NTFS_FS is not set
+
+#
+# Pseudo filesystems
+#
+CONFIG_PROC_FS=y
+CONFIG_PROC_KCORE=y
+CONFIG_SYSFS=y
+# CONFIG_DEVFS_FS is not set
+# CONFIG_DEVPTS_FS_XATTR is not set
+CONFIG_TMPFS=y
+# CONFIG_TMPFS_XATTR is not set
+# CONFIG_HUGETLB_PAGE is not set
+CONFIG_RAMFS=y
+
+#
+# Miscellaneous filesystems
+#
+# CONFIG_ADFS_FS is not set
+# CONFIG_AFFS_FS is not set
+# CONFIG_HFS_FS is not set
+# CONFIG_HFSPLUS_FS is not set
+# CONFIG_BEFS_FS is not set
+# CONFIG_BFS_FS is not set
+# CONFIG_EFS_FS is not set
+# CONFIG_JFFS_FS is not set
+CONFIG_JFFS2_FS=y
+CONFIG_JFFS2_FS_DEBUG=0
+# CONFIG_JFFS2_FS_NAND is not set
+# CONFIG_JFFS2_FS_NOR_ECC is not set
+# CONFIG_JFFS2_COMPRESSION_OPTIONS is not set
+CONFIG_JFFS2_ZLIB=y
+CONFIG_JFFS2_RTIME=y
+# CONFIG_JFFS2_RUBIN is not set
+# CONFIG_CRAMFS is not set
+# CONFIG_VXFS_FS is not set
+# CONFIG_HPFS_FS is not set
+# CONFIG_QNX4FS_FS is not set
+# CONFIG_SYSV_FS is not set
+# CONFIG_UFS_FS is not set
+
+#
+# Network File Systems
+#
+CONFIG_NFS_FS=y
+CONFIG_NFS_V3=y
+CONFIG_NFS_V4=y
+CONFIG_NFS_DIRECTIO=y
+CONFIG_NFSD=y
+CONFIG_NFSD_V3=y
+CONFIG_NFSD_V4=y
+CONFIG_NFSD_TCP=y
+CONFIG_ROOT_NFS=y
+CONFIG_LOCKD=y
+CONFIG_LOCKD_V4=y
+CONFIG_EXPORTFS=y
+CONFIG_SUNRPC=y
+CONFIG_SUNRPC_GSS=y
+CONFIG_RPCSEC_GSS_KRB5=y
+# CONFIG_RPCSEC_GSS_SPKM3 is not set
+# CONFIG_SMB_FS is not set
+# CONFIG_CIFS is not set
+# CONFIG_NCP_FS is not set
+# CONFIG_CODA_FS is not set
+# CONFIG_AFS_FS is not set
+
+#
+# Partition Types
+#
+# CONFIG_PARTITION_ADVANCED is not set
+CONFIG_MSDOS_PARTITION=y
+
+#
+# Native Language Support
+#
+CONFIG_NLS=y
+CONFIG_NLS_DEFAULT="iso8859-1"
+# CONFIG_NLS_CODEPAGE_437 is not set
+# CONFIG_NLS_CODEPAGE_737 is not set
+# CONFIG_NLS_CODEPAGE_775 is not set
+# CONFIG_NLS_CODEPAGE_850 is not set
+# CONFIG_NLS_CODEPAGE_852 is not set
+# CONFIG_NLS_CODEPAGE_855 is not set
+# CONFIG_NLS_CODEPAGE_857 is not set
+# CONFIG_NLS_CODEPAGE_860 is not set
+# CONFIG_NLS_CODEPAGE_861 is not set
+# CONFIG_NLS_CODEPAGE_862 is not set
+# CONFIG_NLS_CODEPAGE_863 is not set
+# CONFIG_NLS_CODEPAGE_864 is not set
+# CONFIG_NLS_CODEPAGE_865 is not set
+# CONFIG_NLS_CODEPAGE_866 is not set
+# CONFIG_NLS_CODEPAGE_869 is not set
+# CONFIG_NLS_CODEPAGE_936 is not set
+# CONFIG_NLS_CODEPAGE_950 is not set
+# CONFIG_NLS_CODEPAGE_932 is not set
+# CONFIG_NLS_CODEPAGE_949 is not set
+# CONFIG_NLS_CODEPAGE_874 is not set
+# CONFIG_NLS_ISO8859_8 is not set
+# CONFIG_NLS_CODEPAGE_1250 is not set
+# CONFIG_NLS_CODEPAGE_1251 is not set
+# CONFIG_NLS_ASCII is not set
+# CONFIG_NLS_ISO8859_1 is not set
+# CONFIG_NLS_ISO8859_2 is not set
+# CONFIG_NLS_ISO8859_3 is not set
+# CONFIG_NLS_ISO8859_4 is not set
+# CONFIG_NLS_ISO8859_5 is not set
+# CONFIG_NLS_ISO8859_6 is not set
+# CONFIG_NLS_ISO8859_7 is not set
+# CONFIG_NLS_ISO8859_9 is not set
+# CONFIG_NLS_ISO8859_13 is not set
+# CONFIG_NLS_ISO8859_14 is not set
+# CONFIG_NLS_ISO8859_15 is not set
+# CONFIG_NLS_KOI8_R is not set
+# CONFIG_NLS_KOI8_U is not set
+# CONFIG_NLS_UTF8 is not set
+
+#
+# Library routines
+#
+# CONFIG_CRC_CCITT is not set
+CONFIG_CRC32=y
+# CONFIG_LIBCRC32C is not set
+CONFIG_ZLIB_INFLATE=y
+CONFIG_ZLIB_DEFLATE=y
+
+#
+# Profiling support
+#
+# CONFIG_PROFILING is not set
+
+#
+# Kernel hacking
+#
+# CONFIG_PRINTK_TIME is not set
+# CONFIG_DEBUG_KERNEL is not set
+CONFIG_LOG_BUF_SHIFT=15
+# CONFIG_SERIAL_TEXT_DEBUG is not set
+
+#
+# Security options
+#
+# CONFIG_KEYS is not set
+# CONFIG_SECURITY is not set
+
+#
+# Cryptographic options
+#
+CONFIG_CRYPTO=y
+# CONFIG_CRYPTO_HMAC is not set
+# CONFIG_CRYPTO_NULL is not set
+# CONFIG_CRYPTO_MD4 is not set
+CONFIG_CRYPTO_MD5=y
+# CONFIG_CRYPTO_SHA1 is not set
+# CONFIG_CRYPTO_SHA256 is not set
+# CONFIG_CRYPTO_SHA512 is not set
+# CONFIG_CRYPTO_WP512 is not set
+# CONFIG_CRYPTO_TGR192 is not set
+CONFIG_CRYPTO_DES=y
+# CONFIG_CRYPTO_BLOWFISH is not set
+# CONFIG_CRYPTO_TWOFISH is not set
+# CONFIG_CRYPTO_SERPENT is not set
+# CONFIG_CRYPTO_AES is not set
+# CONFIG_CRYPTO_CAST5 is not set
+# CONFIG_CRYPTO_CAST6 is not set
+# CONFIG_CRYPTO_TEA is not set
+# CONFIG_CRYPTO_ARC4 is not set
+# CONFIG_CRYPTO_KHAZAD is not set
+# CONFIG_CRYPTO_ANUBIS is not set
+# CONFIG_CRYPTO_DEFLATE is not set
+# CONFIG_CRYPTO_MICHAEL_MIC is not set
+# CONFIG_CRYPTO_CRC32C is not set
+# CONFIG_CRYPTO_TEST is not set
+
+#
+# Hardware crypto devices
+#
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper 
--exclude=ChangeSet linux-2.5/arch/ppc/platforms/Makefile 
linux-2.5-hdpu/arch/ppc/platforms/Makefile
--- linux-2.5/arch/ppc/platforms/Makefile	2005-03-16 14:14:48 -05:00
+++ linux-2.5-hdpu/arch/ppc/platforms/Makefile	2005-03-10 14:34:49 -05:00
@@ -30,6 +30,7 @@
 obj-$(CONFIG_K2)		+= k2.o
 obj-$(CONFIG_LOPEC)		+= lopec.o
 obj-$(CONFIG_KATANA)		+= katana.o
+obj-$(CONFIG_HDPU)		+= hdpu.o
 obj-$(CONFIG_MCPN765)		+= mcpn765.o
 obj-$(CONFIG_MENF1)		+= menf1_setup.o menf1_pci.o
 obj-$(CONFIG_MVME5100)		+= mvme5100.o
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper 
--exclude=ChangeSet linux-2.5/arch/ppc/platforms/hdpu.c 
linux-2.5-hdpu/arch/ppc/platforms/hdpu.c
--- linux-2.5/arch/ppc/platforms/hdpu.c	1969-12-31 19:00:00 -05:00
+++ linux-2.5-hdpu/arch/ppc/platforms/hdpu.c	2005-03-16 14:01:24 -05:00
@@ -0,0 +1,994 @@
+
+/*
+ * arch/ppc/platforms/hdpu_setup.c
+ *
+ * Board setup routines for the Sky Computers HDPU Compute Blade.
+ *
+ * Written by Brian Waite <waite@skycomputers.com>
+ * 
+ * Based on code done by - Mark A. Greer <mgreer@mvista.com>
+ *                         Rabeeh Khoury - rabeeh@galileo.co.il
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/config.h>
+
+#include <linux/pci.h>
+#include <linux/delay.h>
+#include <linux/irq.h>
+#include <linux/ide.h>
+#include <linux/seq_file.h>
+
+#include <linux/initrd.h>
+#include <linux/root_dev.h>
+#include <linux/smp.h>
+
+#include <asm/time.h>
+#include <asm/machdep.h>
+#include <asm/todc.h>
+#include <asm/mv64x60.h>
+#include <asm/ppcboot.h>
+#include <platforms/hdpu.h>
+#include <linux/mv643xx.h>
+#include <linux/device.h>
+#include <linux/mtd/physmap.h>
+
+#define BOARD_VENDOR	"Sky Computers"
+#define BOARD_MACHINE	"HDPU-CB-A"
+
+bd_t ppcboot_bd;
+int ppcboot_bd_valid = 0;
+
+static mv64x60_handle_t bh;
+
+extern char cmd_line[];
+
+unsigned long hdpu_find_end_of_memory(void);
+void hdpu_mpsc_progress(char *s, unsigned short hex);
+void hdpu_heartbeat(void);
+
+static void parse_bootinfo(unsigned long r3,
+			   unsigned long r4, unsigned long r5,
+			   unsigned long r6, unsigned long r7);
+static void hdpu_set_l1pe(void);
+static void hdpu_cpustate_set(unsigned char new_state);
+#ifdef CONFIG_SMP
+static spinlock_t timebase_lock = SPIN_LOCK_UNLOCKED;
+static unsigned int timebase_upper = 0, timebase_lower = 0;
+extern int smp_tb_synchronized;
+
+void __devinit hdpu_tben_give(void);
+void __devinit hdpu_tben_take(void);
+#endif
+
+static int __init
+hdpu_map_irq(struct pci_dev *dev, unsigned char idsel, unsigned char pin)
+{
+	struct pci_controller *hose = pci_bus_to_hose(dev->bus->number);
+
+	if (hose->index == 0) {
+		static char pci_irq_table[][4] = {
+			{HDPU_PCI_0_IRQ, 0, 0, 0},
+			{HDPU_PCI_0_IRQ, 0, 0, 0},
+		};
+
+		const long min_idsel = 1, max_idsel = 2, irqs_per_slot = 4;
+		return PCI_IRQ_TABLE_LOOKUP;
+	} else {
+		static char pci_irq_table[][4] = {
+			{HDPU_PCI_1_IRQ, 0, 0, 0},
+		};
+
+		const long min_idsel = 1, max_idsel = 1, irqs_per_slot = 4;
+		return PCI_IRQ_TABLE_LOOKUP;
+	}
+}
+
+static void __init hdpu_intr_setup(void)
+{
+	mv64x60_write(&bh, MV64x60_GPP_IO_CNTL,
+		      (1 | (1 << 2) | (1 << 3) | (1 << 4) | (1 << 5) |
+		       (1 << 6) | (1 << 7) | (1 << 12) | (1 << 16) |
+		       (1 << 18) | (1 << 19) | (1 << 20) | (1 << 21) |
+		       (1 << 22) | (1 << 23) | (1 << 24) | (1 << 25) |
+		       (1 << 26) | (1 << 27) | (1 << 28) | (1 << 29)));
+
+	/* XXXX Erranum FEr PCI-#8 */
+	mv64x60_clr_bits(&bh, MV64x60_PCI0_CMD, (1 << 5) | (1 << 9));
+	mv64x60_clr_bits(&bh, MV64x60_PCI1_CMD, (1 << 5) | (1 << 9));
+
+	/*
+	 * Dismiss and then enable interrupt on GPP interrupt cause
+	 * for CPU #0
+	 */
+	mv64x60_write(&bh, MV64x60_GPP_INTR_CAUSE, ~((1 << 8) | (1 << 13)));
+	mv64x60_set_bits(&bh, MV64x60_GPP_INTR_MASK, (1 << 8) | (1 << 13));
+
+	/*
+	 * Dismiss and then enable interrupt on CPU #0 high cause reg
+	 * BIT25 summarizes GPP interrupts 8-15
+	 */
+	mv64x60_set_bits(&bh, MV64360_IC_CPU0_INTR_MASK_HI, (1 << 25));
+}
+
+static void __init hdpu_setup_peripherals(void)
+{
+	unsigned int val;
+
+	mv64x60_set_32bit_window(&bh, MV64x60_CPU2BOOT_WIN,
+				 HDPU_EMB_FLASH_BASE, HDPU_EMB_FLASH_SIZE, 0);
+	bh.ci->enable_window_32bit(&bh, MV64x60_CPU2BOOT_WIN);
+
+	mv64x60_set_32bit_window(&bh, MV64x60_CPU2DEV_0_WIN,
+				 HDPU_TBEN_BASE, HDPU_TBEN_SIZE, 0);
+	bh.ci->enable_window_32bit(&bh, MV64x60_CPU2DEV_0_WIN);
+
+	mv64x60_set_32bit_window(&bh, MV64x60_CPU2DEV_1_WIN,
+				 HDPU_NEXUS_ID_BASE, HDPU_NEXUS_ID_SIZE, 0);
+	bh.ci->enable_window_32bit(&bh, MV64x60_CPU2DEV_1_WIN);
+
+	mv64x60_set_32bit_window(&bh, MV64x60_CPU2SRAM_WIN,
+				 HDPU_INTERNAL_SRAM_BASE,
+				 HDPU_INTERNAL_SRAM_SIZE, 0);
+	bh.ci->enable_window_32bit(&bh, MV64x60_CPU2SRAM_WIN);
+
+	bh.ci->disable_window_32bit(&bh, MV64x60_ENET2MEM_4_WIN);
+	mv64x60_set_32bit_window(&bh, MV64x60_ENET2MEM_4_WIN, 0, 0, 0);
+
+	mv64x60_clr_bits(&bh, MV64x60_PCI0_PCI_DECODE_CNTL, (1 << 3));
+	mv64x60_clr_bits(&bh, MV64x60_PCI1_PCI_DECODE_CNTL, (1 << 3));
+	mv64x60_clr_bits(&bh, MV64x60_TIMR_CNTR_0_3_CNTL,
+			 ((1 << 0) | (1 << 8) | (1 << 16) | (1 << 24)));
+
+	/* Enable pipelining */
+	mv64x60_set_bits(&bh, MV64x60_CPU_CONFIG, (1 << 13));
+	/* Enable Snoop Pipelineing */
+	mv64x60_set_bits(&bh, MV64360_D_UNIT_CONTROL_HIGH, (1 << 24));
+
+	/*
+	 * Change DRAM read buffer assignment.
+	 * Assign read buffer 0 dedicated only for CPU, 
+	 * and the rest read buffer 1.
+	 */
+	val = mv64x60_read(&bh, MV64360_SDRAM_CONFIG);
+	val = val & 0x03ffffff;
+	val = val | 0xf8000000;
+	mv64x60_write(&bh, MV64360_SDRAM_CONFIG, val);
+
+	/* 
+	 * Configure internal SRAM - 
+	 * Cache coherent write back, if CONFIG_MV64360_SRAM_CACHE_COHERENT set
+	 * Parity enabled.
+	 * Parity error propagation
+	 * Arbitration not parked for CPU only
+	 * Other bits are reserved.
+	 */
+#ifdef CONFIG_MV64360_SRAM_CACHE_COHERENT
+	mv64x60_write(&bh, MV64360_SRAM_CONFIG, 0x001600b2);
+#else
+	mv64x60_write(&bh, MV64360_SRAM_CONFIG, 0x001600b0);
+#endif
+
+	hdpu_intr_setup();
+}
+
+static void __init hdpu_setup_bridge(void)
+{
+	struct mv64x60_setup_info si;
+	int i;
+
+	memset(&si, 0, sizeof(si));
+
+	si.phys_reg_base = HDPU_BRIDGE_REG_BASE;
+	si.pci_0.enable_bus = 1;
+	si.pci_0.pci_io.cpu_base = HDPU_PCI0_IO_START_PROC_ADDR;
+	si.pci_0.pci_io.pci_base_hi = 0;
+	si.pci_0.pci_io.pci_base_lo = HDPU_PCI0_IO_START_PCI_ADDR;
+	si.pci_0.pci_io.size = HDPU_PCI0_IO_SIZE;
+	si.pci_0.pci_io.swap = MV64x60_CPU2PCI_SWAP_NONE;
+	si.pci_0.pci_mem[0].cpu_base = HDPU_PCI0_MEM_START_PROC_ADDR;
+	si.pci_0.pci_mem[0].pci_base_hi = HDPU_PCI0_MEM_START_PCI_HI_ADDR;
+	si.pci_0.pci_mem[0].pci_base_lo = HDPU_PCI0_MEM_START_PCI_LO_ADDR;
+	si.pci_0.pci_mem[0].size = HDPU_PCI0_MEM_SIZE;
+	si.pci_0.pci_mem[0].swap = MV64x60_CPU2PCI_SWAP_NONE;
+	si.pci_0.pci_cmd_bits = 0;
+	si.pci_0.latency_timer = 0x80;
+
+	si.pci_1.enable_bus = 1;
+	si.pci_1.pci_io.cpu_base = HDPU_PCI1_IO_START_PROC_ADDR;
+	si.pci_1.pci_io.pci_base_hi = 0;
+	si.pci_1.pci_io.pci_base_lo = HDPU_PCI1_IO_START_PCI_ADDR;
+	si.pci_1.pci_io.size = HDPU_PCI1_IO_SIZE;
+	si.pci_1.pci_io.swap = MV64x60_CPU2PCI_SWAP_NONE;
+	si.pci_1.pci_mem[0].cpu_base = HDPU_PCI1_MEM_START_PROC_ADDR;
+	si.pci_1.pci_mem[0].pci_base_hi = HDPU_PCI1_MEM_START_PCI_HI_ADDR;
+	si.pci_1.pci_mem[0].pci_base_lo = HDPU_PCI1_MEM_START_PCI_LO_ADDR;
+	si.pci_1.pci_mem[0].size = HDPU_PCI1_MEM_SIZE;
+	si.pci_1.pci_mem[0].swap = MV64x60_CPU2PCI_SWAP_NONE;
+	si.pci_1.pci_cmd_bits = 0;
+	si.pci_1.latency_timer = 0x80;
+
+	for (i = 0; i < MV64x60_CPU2MEM_WINDOWS; i++) {
+#if defined(CONFIG_NOT_COHERENT_CACHE)
+		si.cpu_prot_options[i] = 0;
+		si.enet_options[i] = MV64360_ENET2MEM_SNOOP_NONE;
+		si.mpsc_options[i] = MV64360_MPSC2MEM_SNOOP_NONE;
+		si.idma_options[i] = MV64360_IDMA2MEM_SNOOP_NONE;
+
+		si.pci_1.acc_cntl_options[i] =
+		    MV64360_PCI_ACC_CNTL_SNOOP_NONE |
+		    MV64360_PCI_ACC_CNTL_SWAP_NONE |
+		    MV64360_PCI_ACC_CNTL_MBURST_128_BYTES |
+		    MV64360_PCI_ACC_CNTL_RDSIZE_256_BYTES;
+
+		si.pci_0.acc_cntl_options[i] =
+		    MV64360_PCI_ACC_CNTL_SNOOP_NONE |
+		    MV64360_PCI_ACC_CNTL_SWAP_NONE |
+		    MV64360_PCI_ACC_CNTL_MBURST_128_BYTES |
+		    MV64360_PCI_ACC_CNTL_RDSIZE_256_BYTES;
+
+#else
+		si.cpu_prot_options[i] = 0;
+		si.enet_options[i] = MV64360_ENET2MEM_SNOOP_WB;	/* errata */
+		si.mpsc_options[i] = MV64360_MPSC2MEM_SNOOP_WB;	/* errata */
+		si.idma_options[i] = MV64360_IDMA2MEM_SNOOP_WB;	/* errata */
+
+		si.pci_0.acc_cntl_options[i] =
+		    MV64360_PCI_ACC_CNTL_SNOOP_WB |
+		    MV64360_PCI_ACC_CNTL_SWAP_NONE |
+		    MV64360_PCI_ACC_CNTL_MBURST_32_BYTES |
+		    MV64360_PCI_ACC_CNTL_RDSIZE_256_BYTES;
+
+		si.pci_1.acc_cntl_options[i] =
+		    MV64360_PCI_ACC_CNTL_SNOOP_WB |
+		    MV64360_PCI_ACC_CNTL_SWAP_NONE |
+		    MV64360_PCI_ACC_CNTL_MBURST_32_BYTES |
+		    MV64360_PCI_ACC_CNTL_RDSIZE_256_BYTES;
+#endif
+	}
+
+	hdpu_cpustate_set(CPUSTATE_KERNEL_MAJOR | CPUSTATE_KERNEL_INIT_PCI);
+
+	/* Lookup PCI host bridges */
+	mv64x60_init(&bh, &si);
+	pci_dram_offset = 0;	/* System mem at same addr on PCI & cpu bus */
+	ppc_md.pci_swizzle = common_swizzle;
+	ppc_md.pci_map_irq = hdpu_map_irq;
+
+	ppc_md.pci_exclude_device = mv64x60_pci_exclude_device;
+
+	hdpu_cpustate_set(CPUSTATE_KERNEL_MAJOR | CPUSTATE_KERNEL_INIT_REG);
+	/*
+	 * Enabling of PCI internal-vs-external arbitration
+	 * is a platform- and errata-dependent decision.
+	 */
+	return;
+}
+
+#if defined(CONFIG_SERIAL_MPSC_CONSOLE)
+static void __init hdpu_early_serial_map(void)
+{
+#ifdef	CONFIG_KGDB
+	static char first_time = 1;
+
+#if defined(CONFIG_KGDB_TTYS0)
+#define KGDB_PORT 0
+#elif defined(CONFIG_KGDB_TTYS1)
+#define KGDB_PORT 1
+#else
+#error "Invalid kgdb_tty port"
+#endif
+
+	if (first_time) {
+		gt_early_mpsc_init(KGDB_PORT,
+				   B9600 | CS8 | CREAD | HUPCL | CLOCAL);
+		first_time = 0;
+	}
+
+	return;
+#endif
+}
+#endif
+
+static void hdpu_init2(void)
+{
+	return;
+}
+
+#if defined(CONFIG_MV643XX_ETH)
+static void __init hdpu_fixup_eth_pdata(struct platform_device *pd)
+{
+
+	struct mv643xx_eth_platform_data *eth_pd;
+	eth_pd = pd->dev.platform_data;
+
+	eth_pd->port_serial_control =
+	    mv64x60_read(&bh, MV643XX_ETH_PORT_SERIAL_CONTROL_REG(pd->id) & ~1);
+
+	eth_pd->force_phy_addr = 1;
+	eth_pd->phy_addr = pd->id;
+	eth_pd->tx_queue_size = 400;
+	eth_pd->rx_queue_size = 800;
+}
+#endif
+
+static void __init hdpu_fixup_mpsc_pdata(struct platform_device *pd)
+{
+
+	struct mpsc_pdata *pdata;
+
+	pdata = (struct mpsc_pdata *)pd->dev.platform_data;
+
+	pdata->max_idle = 40;
+	if (ppcboot_bd_valid)
+		pdata->default_baud = ppcboot_bd.bi_baudrate;
+	else
+		pdata->default_baud = HDPU_DEFAULT_BAUD;
+	pdata->brg_clk_src = HDPU_MPSC_CLK_SRC;
+	pdata->brg_clk_freq = HDPU_MPSC_CLK_FREQ;
+}
+
+static int __init hdpu_platform_notify(struct device *dev)
+{
+	static struct {
+		char *bus_id;
+		void ((*rtn) (struct platform_device * pdev));
+	} dev_map[] = {
+		{
+		MPSC_CTLR_NAME ".0", hdpu_fixup_mpsc_pdata},
+#if defined(CONFIG_MV643XX_ETH)
+		{
+		MV643XX_ETH_NAME ".0", hdpu_fixup_eth_pdata},
+#endif
+	};
+	struct platform_device *pdev;
+	int i;
+
+	if (dev && dev->bus_id)
+		for (i = 0; i < ARRAY_SIZE(dev_map); i++)
+			if (!strncmp(dev->bus_id, dev_map[i].bus_id,
+				     BUS_ID_SIZE)) {
+
+				pdev = container_of(dev,
+						    struct platform_device,
+						    dev);
+				dev_map[i].rtn(pdev);
+			}
+
+	return 0;
+}
+
+static void __init hdpu_setup_arch(void)
+{
+	if (ppc_md.progress)
+		ppc_md.progress("hdpu_setup_arch: enter", 0);
+#ifdef CONFIG_BLK_DEV_INITRD
+	if (initrd_start)
+		ROOT_DEV = Root_RAM0;
+	else
+#endif
+#ifdef	CONFIG_ROOT_NFS
+		ROOT_DEV = Root_NFS;
+#else
+		ROOT_DEV = Root_SDA2;
+#endif
+
+	ppc_md.heartbeat = hdpu_heartbeat;
+
+	ppc_md.heartbeat_reset = HZ;
+	ppc_md.heartbeat_count = 1;
+
+	if (ppc_md.progress)
+		ppc_md.progress("hdpu_setup_arch: Enabling L2 cache", 0);
+
+	/* Enable L1 Parity Bits */
+	hdpu_set_l1pe();
+
+	/* Enable L2 and L3 caches (if 745x) */
+	_set_L2CR(0x80080000);
+
+	if (ppc_md.progress)
+		ppc_md.progress("hdpu_setup_arch: enter", 0);
+
+	hdpu_setup_bridge();
+
+	hdpu_setup_peripherals();
+
+#ifdef CONFIG_SERIAL_MPSC_CONSOLE
+	hdpu_early_serial_map();
+#endif
+
+	printk("SKY HDPU Compute Blade \n");
+
+	if (ppc_md.progress)
+		ppc_md.progress("hdpu_setup_arch: exit", 0);
+
+	hdpu_cpustate_set(CPUSTATE_KERNEL_MAJOR | CPUSTATE_KERNEL_OK);
+	return;
+}
+static void __init hdpu_init_irq(void)
+{
+	mv64360_init_irq();
+}
+
+static void __init hdpu_set_l1pe()
+{
+	unsigned long ictrl;
+	asm volatile ("mfspr %0, 1011":"=r" (ictrl):);
+	ictrl |= ICTRL_EICE | ICTRL_EDC | ICTRL_EICP;
+	asm volatile ("mtspr 1011, %0"::"r" (ictrl));
+}
+
+/*
+ * Set BAT 1 to map 0xf1000000 to end of physical memory space.
+ */
+static __inline__ void hdpu_set_bat(void)
+{
+	mb();
+	mtspr(SPRN_DBAT1U, 0xf10001fe);
+	mtspr(SPRN_DBAT1L, 0xf100002a);
+	mb();
+
+	return;
+}
+
+unsigned long __init hdpu_find_end_of_memory(void)
+{
+	return mv64x60_get_mem_size(CONFIG_MV64X60_NEW_BASE,
+				    MV64x60_TYPE_MV64360);
+}
+
+static void hdpu_reset_board(void)
+{
+	volatile int infinite = 1;
+
+	hdpu_cpustate_set(CPUSTATE_KERNEL_MAJOR | CPUSTATE_KERNEL_RESET);
+
+	local_irq_disable();
+
+	/* Clear all the LEDs */
+	mv64x60_write(&bh, MV64x60_GPP_VALUE_CLR, ((1 << 4) |
+						   (1 << 5) | (1 << 6)));
+
+	/* disable and invalidate the L2 cache */
+	_set_L2CR(0);
+	_set_L2CR(0x200000);
+
+	/* flush and disable L1 I/D cache */
+	__asm__ __volatile__
+	    ("\n"
+	     "mfspr   3,1008\n"
+	     "ori	5,5,0xcc00\n"
+	     "ori	4,3,0xc00\n"
+	     "andc	5,3,5\n"
+	     "sync\n"
+	     "mtspr	1008,4\n"
+	     "isync\n" "sync\n" "mtspr	1008,5\n" "isync\n" "sync\n");
+
+	/* Hit the reset bit */
+	mv64x60_write(&bh, MV64x60_GPP_VALUE_CLR, (1 << 3));
+
+	while (infinite)
+		infinite = infinite;
+
+	return;
+}
+
+static void hdpu_restart(char *cmd)
+{
+	volatile ulong i = 10000000;
+
+	hdpu_reset_board();
+
+	while (i-- > 0) ;
+	panic("restart failed\n");
+}
+
+static void hdpu_halt(void)
+{
+	local_irq_disable();
+
+	hdpu_cpustate_set(CPUSTATE_KERNEL_MAJOR | CPUSTATE_KERNEL_HALT);
+
+	/* Clear all the LEDs */
+	mv64x60_write(&bh, MV64x60_GPP_VALUE_CLR, ((1 << 4) | (1 << 5) |
+						   (1 << 6)));
+	while (1) ;
+	/* NOTREACHED */
+}
+
+static void hdpu_power_off(void)
+{
+	hdpu_halt();
+	/* NOTREACHED */
+}
+
+static int hdpu_show_cpuinfo(struct seq_file *m)
+{
+	uint pvid;
+
+	pvid = mfspr(SPRN_PVR);
+	seq_printf(m, "vendor\t\t: Sky Computers\n");
+	seq_printf(m, "machine\t\t: HDPU Compute Blade\n");
+	seq_printf(m, "PVID\t\t: 0x%x, vendor: %s\n",
+		   pvid, (pvid & (1 << 15) ? "IBM" : "Motorola"));
+
+	return 0;
+}
+
+static void __init hdpu_calibrate_decr(void)
+{
+	ulong freq;
+
+	if (ppcboot_bd_valid)
+		freq = ppcboot_bd.bi_busfreq / 4;
+	else
+		freq = 133000000;
+
+	printk("time_init: decrementer frequency = %lu.%.6lu MHz\n",
+	       freq / 1000000, freq % 1000000);
+
+	tb_ticks_per_jiffy = freq / HZ;
+	tb_to_us = mulhwu_scale_factor(freq, 1000000);
+
+	return;
+}
+
+static void parse_bootinfo(unsigned long r3,
+			   unsigned long r4, unsigned long r5,
+			   unsigned long r6, unsigned long r7)
+{
+	bd_t *bd = NULL;
+	char *cmdline_start = NULL;
+	int cmdline_len = 0;
+
+	if (r3) {
+		if ((r3 & 0xf0000000) == 0)
+			r3 += KERNELBASE;
+		if ((r3 & 0xf0000000) == KERNELBASE) {
+			bd = (void *)r3;
+
+			memcpy(&ppcboot_bd, bd, sizeof(ppcboot_bd));
+			ppcboot_bd_valid = 1;
+		}
+	}
+#ifdef CONFIG_BLK_DEV_INITRD
+	if (r4 && r5 && r5 > r4) {
+		if ((r4 & 0xf0000000) == 0)
+			r4 += KERNELBASE;
+		if ((r5 & 0xf0000000) == 0)
+			r5 += KERNELBASE;
+		if ((r4 & 0xf0000000) == KERNELBASE) {
+			initrd_start = r4;
+			initrd_end = r5;
+			initrd_below_start_ok = 1;
+		}
+	}
+#endif				/* CONFIG_BLK_DEV_INITRD */
+
+	if (r6 && r7 && r7 > r6) {
+		if ((r6 & 0xf0000000) == 0)
+			r6 += KERNELBASE;
+		if ((r7 & 0xf0000000) == 0)
+			r7 += KERNELBASE;
+		if ((r6 & 0xf0000000) == KERNELBASE) {
+			cmdline_start = (void *)r6;
+			cmdline_len = (r7 - r6);
+			strncpy(cmd_line, cmdline_start, cmdline_len);
+		}
+	}
+}
+
+#if defined(CONFIG_BLK_DEV_IDE) || defined(CONFIG_BLK_DEV_IDE_MODULE)
+static int hdpu_ide_check_region(ide_ioreg_t from, unsigned int extent)
+{
+	return check_region(from, extent);
+}
+
+static void
+hdpu_ide_request_region(ide_ioreg_t from, unsigned int extent, const char 
*name)
+{
+	request_region(from, extent, name);
+	return;
+}
+
+static void hdpu_ide_release_region(ide_ioreg_t from, unsigned int extent)
+{
+	release_region(from, extent);
+	return;
+}
+
+static void __init
+hdpu_ide_pci_init_hwif_ports(hw_regs_t * hw, ide_ioreg_t data_port,
+			     ide_ioreg_t ctrl_port, int *irq)
+{
+	struct pci_dev *dev;
+
+	pci_for_each_dev(dev) {
+		if (((dev->class >> 8) == PCI_CLASS_STORAGE_IDE) ||
+		    ((dev->class >> 8) == PCI_CLASS_STORAGE_RAID)) {
+			hw->irq = dev->irq;
+
+			if (irq != NULL) {
+				*irq = dev->irq;
+			}
+		}
+	}
+
+	return;
+}
+#endif
+
+void hdpu_heartbeat(void)
+{
+	if (mv64x60_read(&bh, MV64x60_GPP_VALUE) & (1 << 5))
+		mv64x60_write(&bh, MV64x60_GPP_VALUE_CLR, (1 << 5));
+	else
+		mv64x60_write(&bh, MV64x60_GPP_VALUE_SET, (1 << 5));
+
+	ppc_md.heartbeat_count = ppc_md.heartbeat_reset;
+
+}
+
+static void __init hdpu_map_io(void)
+{
+	io_block_mapping(0xf1000000, 0xf1000000, 0x20000, _PAGE_IO);
+}
+
+#ifdef CONFIG_SMP
+char hdpu_smp0[] = "SMP Cpu #0";
+char hdpu_smp1[] = "SMP Cpu #1";
+
+static irqreturn_t hdpu_smp_cpu0_int_handler(int irq, void *dev_id,
+					     struct pt_regs *regs)
+{
+	volatile unsigned int doorbell;
+
+	doorbell = mv64x60_read(&bh, MV64360_CPU0_DOORBELL);
+
+	/* Ack the doorbell interrupts */
+	mv64x60_write(&bh, MV64360_CPU0_DOORBELL_CLR, doorbell);
+
+	if (doorbell & 1) {
+		smp_message_recv(0, regs);
+	}
+	if (doorbell & 2) {
+		smp_message_recv(1, regs);
+	}
+	if (doorbell & 4) {
+		smp_message_recv(2, regs);
+	}
+	if (doorbell & 8) {
+		smp_message_recv(3, regs);
+	}
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t hdpu_smp_cpu1_int_handler(int irq, void *dev_id,
+					     struct pt_regs *regs)
+{
+	volatile unsigned int doorbell;
+
+	doorbell = mv64x60_read(&bh, MV64360_CPU1_DOORBELL);
+
+	/* Ack the doorbell interrupts */
+	mv64x60_write(&bh, MV64360_CPU1_DOORBELL_CLR, doorbell);
+
+	if (doorbell & 1) {
+		smp_message_recv(0, regs);
+	}
+	if (doorbell & 2) {
+		smp_message_recv(1, regs);
+	}
+	if (doorbell & 4) {
+		smp_message_recv(2, regs);
+	}
+	if (doorbell & 8) {
+		smp_message_recv(3, regs);
+	}
+	return IRQ_HANDLED;
+}
+
+static void smp_hdpu_CPU_two(void)
+{
+	__asm__ __volatile__
+	    ("\n"
+	     "lis     3,0x0000\n"
+	     "ori     3,3,0x00c0\n"
+	     "mtspr   26, 3\n" "li      4,0\n" "mtspr   27,4\n" "rfi");
+
+}
+
+static int smp_hdpu_probe(void)
+{
+	int *cpu_count_reg;
+	int num_cpus = 0;
+
+	cpu_count_reg = ioremap(HDPU_NEXUS_ID_BASE, HDPU_NEXUS_ID_SIZE);
+	if (cpu_count_reg) {
+		num_cpus = (*cpu_count_reg >> 20) & 0x3;
+		iounmap(cpu_count_reg);
+	}
+
+	/* Validate the bits in the CPLD. If we could not map the reg, return 2. 
+	 * If the register reported 0 or 3, return 2.
+	 * Older CPLD revisions set these bits to all ones (val = 3).
+	 */
+	if ((num_cpus < 1) || (num_cpus > 2)) {
+		printk
+		    ("Unable to determine the number of processors %d . deafulting to 2.
\n",
+		     num_cpus);
+		num_cpus = 2;
+	}
+	return num_cpus;
+}
+
+static void
+smp_hdpu_message_pass(int target, int msg, unsigned long data, int wait)
+{
+	if (msg > 0x3) {
+		printk("SMP %d: smp_message_pass: unknown msg %d\n",
+		       smp_processor_id(), msg);
+		return;
+	}
+	switch (target) {
+	case MSG_ALL:
+		mv64x60_write(&bh, MV64360_CPU0_DOORBELL, 1 << msg);
+		mv64x60_write(&bh, MV64360_CPU1_DOORBELL, 1 << msg);
+		break;
+	case MSG_ALL_BUT_SELF:
+		if (smp_processor_id())
+			mv64x60_write(&bh, MV64360_CPU0_DOORBELL, 1 << msg);
+		else
+			mv64x60_write(&bh, MV64360_CPU1_DOORBELL, 1 << msg);
+		break;
+	default:
+		if (target == 0)
+			mv64x60_write(&bh, MV64360_CPU0_DOORBELL, 1 << msg);
+		else
+			mv64x60_write(&bh, MV64360_CPU1_DOORBELL, 1 << msg);
+		break;
+	}
+}
+
+static void smp_hdpu_kick_cpu(int nr)
+{
+	volatile unsigned int *bootaddr;
+
+	if (ppc_md.progress)
+		ppc_md.progress("smp_hdpu_kick_cpu", 0);
+
+	hdpu_cpustate_set(CPUSTATE_KERNEL_MAJOR | CPUSTATE_KERNEL_CPU1_KICK);
+
+       /* Disable BootCS. Must also reduce the windows size to zero. */
+	bh.ci->disable_window_32bit(&bh, MV64x60_CPU2BOOT_WIN);
+	mv64x60_set_32bit_window(&bh, MV64x60_CPU2BOOT_WIN, 0, 0, 0);
+
+	bootaddr = ioremap(HDPU_INTERNAL_SRAM_BASE, HDPU_INTERNAL_SRAM_SIZE);
+	if (!bootaddr) {
+		if (ppc_md.progress)
+			ppc_md.progress("smp_hdpu_kick_cpu: ioremap failed", 0);
+		return;
+	}
+
+	memcpy((void *)(bootaddr + 0x40), (void *)&smp_hdpu_CPU_two, 0x20);
+
+	/* map SRAM to 0xfff00000 */
+	bh.ci->disable_window_32bit(&bh, MV64x60_CPU2SRAM_WIN);
+
+	mv64x60_set_32bit_window(&bh, MV64x60_CPU2SRAM_WIN,
+				 0xfff00000, HDPU_INTERNAL_SRAM_SIZE, 0);
+	bh.ci->enable_window_32bit(&bh, MV64x60_CPU2SRAM_WIN);
+
+	/* Enable CPU1 arbitration */
+	mv64x60_clr_bits(&bh, MV64x60_CPU_MASTER_CNTL, (1 << 9));
+
+	/*
+	 * Wait 100mSecond until other CPU has reached __secondary_start.
+	 * When it reaches, it is permittable to rever the SRAM mapping etc...
+	 */
+	mdelay(100);
+	*(unsigned long *)KERNELBASE = nr;
+	asm volatile ("dcbf 0,%0"::"r" (KERNELBASE):"memory");
+
+	iounmap(bootaddr);
+
+	/* Set up window for internal sram (256KByte insize) */
+	bh.ci->disable_window_32bit(&bh, MV64x60_CPU2SRAM_WIN);
+	mv64x60_set_32bit_window(&bh, MV64x60_CPU2SRAM_WIN,
+				 HDPU_INTERNAL_SRAM_BASE,
+				 HDPU_INTERNAL_SRAM_SIZE, 0);
+	bh.ci->enable_window_32bit(&bh, MV64x60_CPU2SRAM_WIN);
+	/*
+	 * Set up windows for embedded FLASH (using boot CS window).
+	 */
+
+	bh.ci->disable_window_32bit(&bh, MV64x60_CPU2BOOT_WIN);
+	mv64x60_set_32bit_window(&bh, MV64x60_CPU2BOOT_WIN,
+				 HDPU_EMB_FLASH_BASE, HDPU_EMB_FLASH_SIZE, 0);
+	bh.ci->enable_window_32bit(&bh, MV64x60_CPU2BOOT_WIN);
+}
+
+static void smp_hdpu_setup_cpu(int cpu_nr)
+{
+	if (cpu_nr == 0) {
+		if (ppc_md.progress)
+			ppc_md.progress("smp_hdpu_setup_cpu 0", 0);
+		mv64x60_write(&bh, MV64360_CPU0_DOORBELL_CLR, 0xff);
+		mv64x60_write(&bh, MV64360_CPU0_DOORBELL_MASK, 0xff);
+		request_irq(60, hdpu_smp_cpu0_int_handler,
+			    SA_INTERRUPT, hdpu_smp0, 0);
+	}
+
+	if (cpu_nr == 1) {
+		if (ppc_md.progress)
+			ppc_md.progress("smp_hdpu_setup_cpu 1", 0);
+
+		hdpu_cpustate_set(CPUSTATE_KERNEL_MAJOR |
+				  CPUSTATE_KERNEL_CPU1_OK);
+
+		/* Enable L1 Parity Bits */
+		hdpu_set_l1pe();
+
+		/* Enable L2 cache */
+		_set_L2CR(0);
+		_set_L2CR(0x80080000);
+
+		mv64x60_write(&bh, MV64360_CPU1_DOORBELL_CLR, 0x0);
+		mv64x60_write(&bh, MV64360_CPU1_DOORBELL_MASK, 0xff);
+		request_irq(28, hdpu_smp_cpu1_int_handler,
+			    SA_INTERRUPT, hdpu_smp1, 0);
+	}
+
+}
+
+void __devinit hdpu_tben_give()
+{
+	volatile unsigned long *val = 0;
+
+	/* By writing 0 to the TBEN_BASE, the timebases is frozen */
+	val = ioremap(HDPU_TBEN_BASE, 4);
+	*val = 0;
+	mb();
+
+	spin_lock(&timebase_lock);
+	timebase_upper = get_tbu();
+	timebase_lower = get_tbl();
+	spin_unlock(&timebase_lock);
+
+	while (timebase_upper || timebase_lower)
+		barrier();
+
+	/* By writing 1 to the TBEN_BASE, the timebases is thawed */
+	*val = 1;
+	mb();
+
+	iounmap(val);
+
+}
+
+void __devinit hdpu_tben_take()
+{
+	while (!(timebase_upper || timebase_lower))
+		barrier();
+
+	spin_lock(&timebase_lock);
+	set_tb(timebase_upper, timebase_lower);
+	timebase_upper = 0;
+	timebase_lower = 0;
+	spin_unlock(&timebase_lock);
+}
+
+static struct smp_ops_t hdpu_smp_ops = {
+	.message_pass = smp_hdpu_message_pass,
+	.probe = smp_hdpu_probe,
+	.kick_cpu = smp_hdpu_kick_cpu,
+	.setup_cpu = smp_hdpu_setup_cpu,
+	.give_timebase = hdpu_tben_give,
+	.take_timebase = hdpu_tben_take,
+};
+#endif				/* CONFIG_SMP */
+
+void __init
+platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
+	      unsigned long r6, unsigned long r7)
+{
+	parse_bootinfo(r3, r4, r5, r6, r7);
+
+	isa_mem_base = 0;
+
+	ppc_md.setup_arch = hdpu_setup_arch;
+	ppc_md.init = hdpu_init2;
+	ppc_md.show_cpuinfo = hdpu_show_cpuinfo;
+	ppc_md.init_IRQ = hdpu_init_irq;
+	ppc_md.get_irq = mv64360_get_irq;
+	ppc_md.restart = hdpu_restart;
+	ppc_md.power_off = hdpu_power_off;
+	ppc_md.halt = hdpu_halt;
+	ppc_md.find_end_of_memory = hdpu_find_end_of_memory;
+	ppc_md.calibrate_decr = hdpu_calibrate_decr;
+	ppc_md.setup_io_mappings = hdpu_map_io;
+
+	bh.p_base = CONFIG_MV64X60_NEW_BASE;
+	bh.v_base = (unsigned long *)bh.p_base;
+
+	hdpu_set_bat();
+
+#if defined(CONFIG_SERIAL_TEXT_DEBUG)
+	ppc_md.progress = hdpu_mpsc_progress;	/* embedded UART */
+	mv64x60_progress_init(bh.p_base);
+#endif				/* CONFIG_SERIAL_TEXT_DEBUG */
+
+#ifdef CONFIG_SMP
+	ppc_md.smp_ops = &hdpu_smp_ops;
+#endif				/* CONFIG_SMP */
+
+#if defined(CONFIG_SERIAL_MPSC) || defined(CONFIG_MV643XX_ETH)
+	platform_notify = hdpu_platform_notify;
+#endif
+	return;
+}
+
+#if defined(CONFIG_SERIAL_TEXT_DEBUG) && defined(CONFIG_SERIAL_MPSC_CONSOLE)
+/* SMP safe version of the serial text debug routine. Uses Semaphore 0 */
+void hdpu_mpsc_progress(char *s, unsigned short hex)
+{
+	while (mv64x60_read(&bh, MV64360_WHO_AM_I) !=
+	       mv64x60_read(&bh, MV64360_SEMAPHORE_0)) {
+	}
+	mv64x60_mpsc_progress(s, hex);
+	mv64x60_write(&bh, MV64360_SEMAPHORE_0, 0xff);
+}
+#endif
+
+static void hdpu_cpustate_set(unsigned char new_state)
+{
+	unsigned int state = (new_state << 21);
+	mv64x60_write(&bh, MV64x60_GPP_VALUE_CLR, (0xff << 21));
+	mv64x60_write(&bh, MV64x60_GPP_VALUE_CLR, state);
+}
+
+#ifdef CONFIG_MTD_PHYSMAP
+static struct mtd_partition hdpu_partitions[] = {
+	{
+	 .name = "Root FS",
+	 .size = 0x03400000,
+	 .offset = 0,
+	 .mask_flags = 0,
+	 },{
+	 .name = "User FS",
+	 .size = 0x00800000,
+	 .offset = 0x03400000,
+	 .mask_flags = 0,
+	 },{
+	 .name = "Kernel Image",
+	 .size = 0x002C0000,
+	 .offset = 0x03C00000,
+	 .mask_flags = 0,
+	 },{
+	 .name = "bootEnv",
+	 .size = 0x00040000,
+	 .offset = 0x03EC0000,
+	 .mask_flags = 0,
+	 },{
+	 .name = "bootROM",
+	 .size = 0x00100000,
+	 .offset = 0x03F00000,
+	 .mask_flags = 0,
+	 }
+};
+
+static int __init hdpu_setup_mtd(void)
+{
+
+	physmap_set_partitions(hdpu_partitions, 5);
+	return 0;
+}
+
+arch_initcall(hdpu_setup_mtd);
+#endif
+
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper 
--exclude=ChangeSet linux-2.5/arch/ppc/platforms/hdpu.h 
linux-2.5-hdpu/arch/ppc/platforms/hdpu.h
--- linux-2.5/arch/ppc/platforms/hdpu.h	1969-12-31 19:00:00 -05:00
+++ linux-2.5-hdpu/arch/ppc/platforms/hdpu.h	2005-03-16 14:01:24 -05:00
@@ -0,0 +1,82 @@
+/*
+ * arch/ppc/platforms/hdpu.h
+ * 
+ * Definitions for Sky Computers HDPU board.
+ *
+ * Brian Waite <waite@skycomputers.com>
+ *
+ * Based on code done by Rabeeh Khoury - rabeeh@galileo.co.il
+ * Based on code done by Mark A. Greer <mgreer@mvista.com>
+ * Based on code done by  Tim Montgomery <timm@artesyncp.com>
+ *
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+/*
+ * The MV64360 has 2 PCI buses each with 1 window from the CPU bus to
+ * PCI I/O space and 4 windows from the CPU bus to PCI MEM space.
+ * We'll only use one PCI MEM window on each PCI bus.
+ *
+ * This is the CPU physical memory map (windows must be at least 64K and 
start
+ * on a boundary that is a multiple of the window size):
+ *
+ *    0x80000000-0x8fffffff	 - PCI 0 MEM
+ *    0xa0000000-0xafffffff	 - PCI 1 MEM
+ *    0xc0000000-0xc0ffffff	 - PCI 0 I/O
+ *    0xc1000000-0xc1ffffff	 - PCI 1 I/O
+
+ *    0xf1000000-0xf100ffff      - MV64360 Registers
+ *    0xf1010000-0xfb9fffff      - HOLE
+ *    0xfbfa0000-0xfbfaffff      - TBEN
+ *    0xfbf00000-0xfbfbffff      - NEXUS
+ *    0xfbfc0000-0xfbffffff      - Internal SRAM
+ *    0xfc000000-0xffffffff      - Boot window
+ */
+
+#ifndef __PPC_PLATFORMS_HDPU_H
+#define __PPC_PLATFORMS_HDPU_H
+
+/* CPU Physical Memory Map setup. */
+#define	HDPU_BRIDGE_REG_BASE		     0xf1000000
+
+#define HDPU_TBEN_BASE                        0xfbfa0000
+#define HDPU_TBEN_SIZE                        0x00010000
+#define HDPU_NEXUS_ID_BASE                    0xfbfb0000
+#define HDPU_NEXUS_ID_SIZE                    0x00010000
+#define HDPU_INTERNAL_SRAM_BASE               0xfbfc0000
+#define HDPU_INTERNAL_SRAM_SIZE               0x00040000
+#define	HDPU_EMB_FLASH_BASE		      0xfc000000
+#define	HDPU_EMB_FLASH_SIZE      	      0x04000000
+
+/* PCI Mappings */
+
+#define HDPU_PCI0_MEM_START_PROC_ADDR         0x80000000
+#define HDPU_PCI0_MEM_START_PCI_HI_ADDR       0x00000000
+#define HDPU_PCI0_MEM_START_PCI_LO_ADDR       HDPU_PCI0_MEM_START_PROC_ADDR
+#define HDPU_PCI0_MEM_SIZE                    0x10000000
+
+#define HDPU_PCI1_MEM_START_PROC_ADDR         0xc0000000
+#define HDPU_PCI1_MEM_START_PCI_HI_ADDR       0x00000000
+#define HDPU_PCI1_MEM_START_PCI_LO_ADDR       HDPU_PCI1_MEM_START_PROC_ADDR
+#define HDPU_PCI1_MEM_SIZE                    0x20000000
+
+#define HDPU_PCI0_IO_START_PROC_ADDR          0xc0000000
+#define HDPU_PCI0_IO_START_PCI_ADDR           0x00000000
+#define HDPU_PCI0_IO_SIZE                     0x01000000
+
+#define HDPU_PCI1_IO_START_PROC_ADDR          0xc1000000
+#define HDPU_PCI1_IO_START_PCI_ADDR           0x01000000
+#define HDPU_PCI1_IO_SIZE                     0x01000000
+
+#define HDPU_DEFAULT_BAUD 115200
+#define HDPU_MPSC_CLK_SRC 8	/* TCLK */
+#define HDPU_MPSC_CLK_FREQ 133000000	/* 133 Mhz */
+
+#define	HDPU_PCI_0_IRQ		(8+64)
+#define	HDPU_PCI_1_IRQ		(13+64)
+
+#endif				/* __PPC_PLATFORMS_HDPU_H */
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper 
--exclude=ChangeSet linux-2.5/arch/ppc/syslib/Makefile 
linux-2.5-hdpu/arch/ppc/syslib/Makefile
--- linux-2.5/arch/ppc/syslib/Makefile	2005-03-16 14:14:50 -05:00
+++ linux-2.5-hdpu/arch/ppc/syslib/Makefile	2005-03-16 14:01:25 -05:00
@@ -53,6 +53,7 @@
 obj-$(CONFIG_K2)		+= i8259.o indirect_pci.o todc_time.o \
 					pci_auto.o
 obj-$(CONFIG_LOPEC)		+= i8259.o pci_auto.o todc_time.o
+obj-$(CONFIG_HDPU)		+= pci_auto.o
 obj-$(CONFIG_LUAN)		+= indirect_pci.o pci_auto.o todc_time.o
 obj-$(CONFIG_KATANA)		+= pci_auto.o
 obj-$(CONFIG_MCPN765)		+= todc_time.o indirect_pci.o pci_auto.o \
