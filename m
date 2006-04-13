Return-Path: <wfarnsworth@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id 4B91E67A01
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 14 Apr 2006 02:16:45 +1000 (EST)
Subject: [PATCH] ppc32: Support for Freescale PQ2FADS
From: Wade Farnsworth <wfarnsworth@mvista.com>
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
In-Reply-To: <1144194855.32471.64.camel@rhino.az.mvista.com>
References: <1144194855.32471.64.camel@rhino.az.mvista.com>
Content-Type: text/plain
Message-Id: <1144945002.3225.10.camel@rhino.az.mvista.com>
Mime-Version: 1.0
Date: 13 Apr 2006 09:16:42 -0700
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

From: Wade Farnsworth <wfarnsworth@mvista.com>

Adds support for the Freescale PQ2FADS board.

Signed-off-by: Wade Farnsworth <wfarnsworth@mvista.com>

---

This patch makes use of PHYLIB, and as such requires the following
patches from Vitaly Bordug <vbordug@ru.mvista.com>:

ppc32: Fix string comparing in platform_notify_map
PAL: Support of the fixed PHY
FS_ENET: use PAL for mii management

This supercedes the previous patch posted on April 4.

 arch/ppc/Kconfig                   |    2
 arch/ppc/configs/pq2fads_defconfig |  783 +++++++++++++++++++++++++++
 arch/ppc/platforms/Makefile        |    1
 arch/ppc/platforms/pq2ads.h        |   17
 arch/ppc/platforms/pq2ads_pd.h     |   15
 arch/ppc/platforms/pq2fads_setup.c |  248 ++++++++
 arch/ppc/syslib/m82xx_pci.c        |    5
 arch/ppc/syslib/pq2_sys.c          |   10
 8 files changed, 1075 insertions(+), 6 deletions(-)

diff -uprN linux-2.6-orig/arch/ppc/Kconfig linux-2.6-new/arch/ppc/Kconfig
--- linux-2.6-orig/arch/ppc/Kconfig	2006-04-11 11:00:08.000000000 -0700
+++ linux-2.6-new/arch/ppc/Kconfig	2006-04-11 11:14:52.000000000 -0700
@@ -731,7 +731,7 @@ endchoice
 
 config PQ2ADS
 	bool
-	depends on ADS8272
+	depends on ADS8272 || PQ2FADS
 	default y
 
 config TQM8xxL
diff -uprN linux-2.6-orig/arch/ppc/configs/pq2fads_defconfig linux-2.6-new/arch/ppc/configs/pq2fads_defconfig
--- linux-2.6-orig/arch/ppc/configs/pq2fads_defconfig	1969-12-31 17:00:00.000000000 -0700
+++ linux-2.6-new/arch/ppc/configs/pq2fads_defconfig	2006-04-11 11:34:30.000000000 -0700
@@ -0,0 +1,783 @@
+#
+# Automatically generated make config: don't edit
+# Linux kernel version: 2.6.17-rc1
+# Tue Apr 11 11:34:23 2006
+#
+CONFIG_MMU=y
+CONFIG_GENERIC_HARDIRQS=y
+CONFIG_RWSEM_XCHGADD_ALGORITHM=y
+CONFIG_GENERIC_HWEIGHT=y
+CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_PPC=y
+CONFIG_PPC32=y
+CONFIG_GENERIC_NVRAM=y
+CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
+CONFIG_ARCH_MAY_HAVE_PC_FDC=y
+
+#
+# Code maturity level options
+#
+CONFIG_EXPERIMENTAL=y
+CONFIG_BROKEN_ON_SMP=y
+CONFIG_INIT_ENV_ARG_LIMIT=32
+
+#
+# General setup
+#
+CONFIG_LOCALVERSION=""
+CONFIG_LOCALVERSION_AUTO=y
+CONFIG_SWAP=y
+CONFIG_SYSVIPC=y
+# CONFIG_POSIX_MQUEUE is not set
+# CONFIG_BSD_PROCESS_ACCT is not set
+CONFIG_SYSCTL=y
+# CONFIG_AUDIT is not set
+# CONFIG_IKCONFIG is not set
+# CONFIG_RELAY is not set
+CONFIG_INITRAMFS_SOURCE=""
+# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
+CONFIG_EMBEDDED=y
+# CONFIG_KALLSYMS is not set
+# CONFIG_HOTPLUG is not set
+CONFIG_PRINTK=y
+CONFIG_BUG=y
+CONFIG_ELF_CORE=y
+CONFIG_BASE_FULL=y
+CONFIG_FUTEX=y
+# CONFIG_EPOLL is not set
+CONFIG_SHMEM=y
+CONFIG_SLAB=y
+CONFIG_DOUBLEFAULT=y
+# CONFIG_TINY_SHMEM is not set
+CONFIG_BASE_SMALL=0
+# CONFIG_SLOB is not set
+
+#
+# Loadable module support
+#
+# CONFIG_MODULES is not set
+
+#
+# Block layer
+#
+# CONFIG_LBD is not set
+# CONFIG_BLK_DEV_IO_TRACE is not set
+# CONFIG_LSF is not set
+
+#
+# IO Schedulers
+#
+CONFIG_IOSCHED_NOOP=y
+CONFIG_IOSCHED_AS=y
+CONFIG_IOSCHED_DEADLINE=y
+CONFIG_IOSCHED_CFQ=y
+CONFIG_DEFAULT_AS=y
+# CONFIG_DEFAULT_DEADLINE is not set
+# CONFIG_DEFAULT_CFQ is not set
+# CONFIG_DEFAULT_NOOP is not set
+CONFIG_DEFAULT_IOSCHED="anticipatory"
+
+#
+# Processor
+#
+CONFIG_6xx=y
+# CONFIG_40x is not set
+# CONFIG_44x is not set
+# CONFIG_8xx is not set
+# CONFIG_E200 is not set
+# CONFIG_E500 is not set
+CONFIG_PPC_FPU=y
+# CONFIG_KEXEC is not set
+# CONFIG_CPU_FREQ is not set
+# CONFIG_WANT_EARLY_SERIAL is not set
+CONFIG_EMBEDDEDBOOT=y
+CONFIG_PPC_STD_MMU=y
+
+#
+# Platform options
+#
+
+#
+# Freescale Ethernet driver platform-specific options
+#
+# CONFIG_PPC_PREP is not set
+# CONFIG_APUS is not set
+# CONFIG_KATANA is not set
+# CONFIG_WILLOW is not set
+# CONFIG_CPCI690 is not set
+# CONFIG_POWERPMC250 is not set
+# CONFIG_CHESTNUT is not set
+# CONFIG_SPRUCE is not set
+# CONFIG_HDPU is not set
+# CONFIG_EV64260 is not set
+# CONFIG_LOPEC is not set
+# CONFIG_MVME5100 is not set
+# CONFIG_PPLUS is not set
+# CONFIG_PRPMC750 is not set
+# CONFIG_PRPMC800 is not set
+# CONFIG_SANDPOINT is not set
+# CONFIG_RADSTONE_PPC7D is not set
+# CONFIG_PAL4 is not set
+# CONFIG_GEMINI is not set
+# CONFIG_EST8260 is not set
+# CONFIG_SBC82xx is not set
+# CONFIG_SBS8260 is not set
+# CONFIG_RPX8260 is not set
+# CONFIG_TQM8260 is not set
+# CONFIG_ADS8272 is not set
+CONFIG_PQ2FADS=y
+# CONFIG_LITE5200 is not set
+# CONFIG_MPC834x_SYS is not set
+# CONFIG_EV64360 is not set
+CONFIG_PQ2ADS=y
+CONFIG_8260=y
+CONFIG_CPM2=y
+# CONFIG_PC_KEYBOARD is not set
+# CONFIG_SMP is not set
+# CONFIG_HIGHMEM is not set
+# CONFIG_HZ_100 is not set
+CONFIG_HZ_250=y
+# CONFIG_HZ_1000 is not set
+CONFIG_HZ=250
+CONFIG_PREEMPT_NONE=y
+# CONFIG_PREEMPT_VOLUNTARY is not set
+# CONFIG_PREEMPT is not set
+CONFIG_SELECT_MEMORY_MODEL=y
+CONFIG_FLATMEM_MANUAL=y
+# CONFIG_DISCONTIGMEM_MANUAL is not set
+# CONFIG_SPARSEMEM_MANUAL is not set
+CONFIG_FLATMEM=y
+CONFIG_FLAT_NODE_MEM_MAP=y
+# CONFIG_SPARSEMEM_STATIC is not set
+CONFIG_SPLIT_PTLOCK_CPUS=4
+CONFIG_BINFMT_ELF=y
+# CONFIG_BINFMT_MISC is not set
+# CONFIG_CMDLINE_BOOL is not set
+# CONFIG_PM is not set
+# CONFIG_SOFTWARE_SUSPEND is not set
+CONFIG_SECCOMP=y
+CONFIG_ISA_DMA_API=y
+
+#
+# Bus options
+#
+# CONFIG_PPC_I8259 is not set
+CONFIG_PPC_INDIRECT_PCI=y
+CONFIG_PCI=y
+CONFIG_PCI_DOMAINS=y
+CONFIG_PCI_8260=y
+CONFIG_8260_PCI9=y
+CONFIG_8260_PCI9_IDMA1=y
+# CONFIG_8260_PCI9_IDMA2 is not set
+# CONFIG_8260_PCI9_IDMA3 is not set
+# CONFIG_8260_PCI9_IDMA4 is not set
+
+#
+# PCCARD (PCMCIA/CardBus) support
+#
+# CONFIG_PCCARD is not set
+
+#
+# Advanced setup
+#
+# CONFIG_ADVANCED_OPTIONS is not set
+
+#
+# Default settings for advanced configuration options are used
+#
+CONFIG_HIGHMEM_START=0xfe000000
+CONFIG_LOWMEM_SIZE=0x30000000
+CONFIG_KERNEL_START=0xc0000000
+CONFIG_TASK_SIZE=0x80000000
+CONFIG_BOOT_LOAD=0x00400000
+
+#
+# Networking
+#
+CONFIG_NET=y
+
+#
+# Networking options
+#
+# CONFIG_NETDEBUG is not set
+CONFIG_PACKET=y
+# CONFIG_PACKET_MMAP is not set
+CONFIG_UNIX=y
+# CONFIG_NET_KEY is not set
+CONFIG_INET=y
+CONFIG_IP_MULTICAST=y
+# CONFIG_IP_ADVANCED_ROUTER is not set
+CONFIG_IP_FIB_HASH=y
+CONFIG_IP_PNP=y
+CONFIG_IP_PNP_DHCP=y
+CONFIG_IP_PNP_BOOTP=y
+# CONFIG_IP_PNP_RARP is not set
+# CONFIG_NET_IPIP is not set
+# CONFIG_NET_IPGRE is not set
+# CONFIG_IP_MROUTE is not set
+# CONFIG_ARPD is not set
+CONFIG_SYN_COOKIES=y
+# CONFIG_INET_AH is not set
+# CONFIG_INET_ESP is not set
+# CONFIG_INET_IPCOMP is not set
+# CONFIG_INET_XFRM_TUNNEL is not set
+# CONFIG_INET_TUNNEL is not set
+CONFIG_INET_DIAG=y
+CONFIG_INET_TCP_DIAG=y
+# CONFIG_TCP_CONG_ADVANCED is not set
+CONFIG_TCP_CONG_BIC=y
+# CONFIG_IPV6 is not set
+# CONFIG_INET6_XFRM_TUNNEL is not set
+# CONFIG_INET6_TUNNEL is not set
+# CONFIG_NETFILTER is not set
+
+#
+# DCCP Configuration (EXPERIMENTAL)
+#
+# CONFIG_IP_DCCP is not set
+
+#
+# SCTP Configuration (EXPERIMENTAL)
+#
+# CONFIG_IP_SCTP is not set
+
+#
+# TIPC Configuration (EXPERIMENTAL)
+#
+# CONFIG_TIPC is not set
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
+
+#
+# Network testing
+#
+# CONFIG_NET_PKTGEN is not set
+# CONFIG_HAMRADIO is not set
+# CONFIG_IRDA is not set
+# CONFIG_BT is not set
+# CONFIG_IEEE80211 is not set
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
+# CONFIG_FW_LOADER is not set
+
+#
+# Connector - unified userspace <-> kernelspace linker
+#
+# CONFIG_CONNECTOR is not set
+
+#
+# Memory Technology Devices (MTD)
+#
+# CONFIG_MTD is not set
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
+CONFIG_BLK_DEV_RAM_SIZE=32768
+CONFIG_BLK_DEV_INITRD=y
+# CONFIG_CDROM_PKTCDVD is not set
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
+# CONFIG_RAID_ATTRS is not set
+# CONFIG_SCSI is not set
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
+# CONFIG_WINDFARM is not set
+
+#
+# Network device support
+#
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
+# PHY device support
+#
+CONFIG_PHYLIB=y
+
+#
+# MII PHY device drivers
+#
+# CONFIG_MARVELL_PHY is not set
+CONFIG_DAVICOM_PHY=y
+# CONFIG_QSEMI_PHY is not set
+# CONFIG_LXT_PHY is not set
+# CONFIG_CICADA_PHY is not set
+# CONFIG_FIXED_PHY is not set
+
+#
+# Ethernet (10 or 100Mbit)
+#
+CONFIG_NET_ETHERNET=y
+CONFIG_MII=y
+# CONFIG_HAPPYMEAL is not set
+# CONFIG_SUNGEM is not set
+# CONFIG_CASSINI is not set
+# CONFIG_NET_VENDOR_3COM is not set
+
+#
+# Tulip family network device support
+#
+# CONFIG_NET_TULIP is not set
+# CONFIG_HP100 is not set
+# CONFIG_NET_PCI is not set
+CONFIG_FS_ENET=y
+# CONFIG_FS_ENET_HAS_SCC is not set
+CONFIG_FS_ENET_HAS_FCC=y
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
+# CONFIG_SIS190 is not set
+# CONFIG_SKGE is not set
+# CONFIG_SKY2 is not set
+# CONFIG_SK98LIN is not set
+# CONFIG_TIGON3 is not set
+# CONFIG_BNX2 is not set
+
+#
+# Ethernet (10000 Mbit)
+#
+# CONFIG_CHELSIO_T1 is not set
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
+# CONFIG_SHAPER is not set
+# CONFIG_NETCONSOLE is not set
+# CONFIG_NETPOLL is not set
+# CONFIG_NET_POLL_CONTROLLER is not set
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
+# CONFIG_INPUT is not set
+
+#
+# Hardware I/O ports
+#
+# CONFIG_SERIO is not set
+# CONFIG_GAMEPORT is not set
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
+CONFIG_SERIAL_CORE=y
+CONFIG_SERIAL_CORE_CONSOLE=y
+CONFIG_SERIAL_CPM=y
+CONFIG_SERIAL_CPM_CONSOLE=y
+CONFIG_SERIAL_CPM_SCC1=y
+CONFIG_SERIAL_CPM_SCC2=y
+# CONFIG_SERIAL_CPM_SCC3 is not set
+# CONFIG_SERIAL_CPM_SCC4 is not set
+# CONFIG_SERIAL_CPM_SMC1 is not set
+# CONFIG_SERIAL_CPM_SMC2 is not set
+# CONFIG_SERIAL_JSM is not set
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
+# CONFIG_TELCLOCK is not set
+
+#
+# I2C support
+#
+# CONFIG_I2C is not set
+
+#
+# SPI support
+#
+# CONFIG_SPI is not set
+# CONFIG_SPI_MASTER is not set
+
+#
+# Dallas's 1-wire bus
+#
+# CONFIG_W1 is not set
+
+#
+# Hardware Monitoring support
+#
+CONFIG_HWMON=y
+# CONFIG_HWMON_VID is not set
+# CONFIG_SENSORS_F71805F is not set
+# CONFIG_HWMON_DEBUG_CHIP is not set
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
+CONFIG_USB_ARCH_HAS_EHCI=y
+# CONFIG_USB is not set
+
+#
+# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
+#
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
+# LED devices
+#
+# CONFIG_NEW_LEDS is not set
+
+#
+# LED drivers
+#
+
+#
+# LED Triggers
+#
+
+#
+# InfiniBand support
+#
+# CONFIG_INFINIBAND is not set
+
+#
+# EDAC - error detection and reporting (RAS) (EXPERIMENTAL)
+#
+
+#
+# Real Time Clock
+#
+# CONFIG_RTC_CLASS is not set
+
+#
+# File systems
+#
+CONFIG_EXT2_FS=y
+# CONFIG_EXT2_FS_XATTR is not set
+# CONFIG_EXT2_FS_XIP is not set
+CONFIG_EXT3_FS=y
+CONFIG_EXT3_FS_XATTR=y
+# CONFIG_EXT3_FS_POSIX_ACL is not set
+# CONFIG_EXT3_FS_SECURITY is not set
+CONFIG_JBD=y
+# CONFIG_JBD_DEBUG is not set
+CONFIG_FS_MBCACHE=y
+# CONFIG_REISERFS_FS is not set
+# CONFIG_JFS_FS is not set
+# CONFIG_FS_POSIX_ACL is not set
+# CONFIG_XFS_FS is not set
+# CONFIG_OCFS2_FS is not set
+# CONFIG_MINIX_FS is not set
+# CONFIG_ROMFS_FS is not set
+CONFIG_INOTIFY=y
+# CONFIG_QUOTA is not set
+CONFIG_DNOTIFY=y
+# CONFIG_AUTOFS_FS is not set
+# CONFIG_AUTOFS4_FS is not set
+# CONFIG_FUSE_FS is not set
+
+#
+# CD-ROM/DVD Filesystems
+#
+# CONFIG_ISO9660_FS is not set
+# CONFIG_UDF_FS is not set
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
+CONFIG_TMPFS=y
+# CONFIG_HUGETLB_PAGE is not set
+CONFIG_RAMFS=y
+# CONFIG_CONFIGFS_FS is not set
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
+# CONFIG_NFS_V3 is not set
+# CONFIG_NFS_V4 is not set
+# CONFIG_NFS_DIRECTIO is not set
+# CONFIG_NFSD is not set
+CONFIG_ROOT_NFS=y
+CONFIG_LOCKD=y
+CONFIG_NFS_COMMON=y
+CONFIG_SUNRPC=y
+# CONFIG_RPCSEC_GSS_KRB5 is not set
+# CONFIG_RPCSEC_GSS_SPKM3 is not set
+# CONFIG_SMB_FS is not set
+# CONFIG_CIFS is not set
+# CONFIG_NCP_FS is not set
+# CONFIG_CODA_FS is not set
+# CONFIG_AFS_FS is not set
+# CONFIG_9P_FS is not set
+
+#
+# Partition Types
+#
+CONFIG_PARTITION_ADVANCED=y
+# CONFIG_ACORN_PARTITION is not set
+# CONFIG_OSF_PARTITION is not set
+# CONFIG_AMIGA_PARTITION is not set
+# CONFIG_ATARI_PARTITION is not set
+# CONFIG_MAC_PARTITION is not set
+# CONFIG_MSDOS_PARTITION is not set
+# CONFIG_LDM_PARTITION is not set
+# CONFIG_SGI_PARTITION is not set
+# CONFIG_ULTRIX_PARTITION is not set
+# CONFIG_SUN_PARTITION is not set
+# CONFIG_KARMA_PARTITION is not set
+# CONFIG_EFI_PARTITION is not set
+
+#
+# Native Language Support
+#
+# CONFIG_NLS is not set
+# CONFIG_SCC_ENET is not set
+# CONFIG_FEC_ENET is not set
+
+#
+# CPM2 Options
+#
+
+#
+# Library routines
+#
+# CONFIG_CRC_CCITT is not set
+# CONFIG_CRC16 is not set
+# CONFIG_CRC32 is not set
+# CONFIG_LIBCRC32C is not set
+# CONFIG_PROFILING is not set
+
+#
+# Kernel hacking
+#
+# CONFIG_PRINTK_TIME is not set
+# CONFIG_MAGIC_SYSRQ is not set
+# CONFIG_DEBUG_KERNEL is not set
+CONFIG_LOG_BUF_SHIFT=14
+# CONFIG_DEBUG_FS is not set
+# CONFIG_UNWIND_INFO is not set
+# CONFIG_KGDB_CONSOLE is not set
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
+# CONFIG_CRYPTO is not set
+
+#
+# Hardware crypto devices
+#
diff -uprN linux-2.6-orig/arch/ppc/platforms/Makefile linux-2.6-new/arch/ppc/platforms/Makefile
--- linux-2.6-orig/arch/ppc/platforms/Makefile	2006-04-11 11:00:08.000000000 -0700
+++ linux-2.6-new/arch/ppc/platforms/Makefile	2006-04-11 11:14:52.000000000 -0700
@@ -21,6 +21,7 @@ obj-$(CONFIG_MVME5100)		+= mvme5100.o
 obj-$(CONFIG_PAL4)		+= pal4_setup.o pal4_pci.o
 obj-$(CONFIG_POWERPMC250)	+= powerpmc250.o
 obj-$(CONFIG_PPLUS)		+= pplus.o
+obj-$(CONFIG_PQ2FADS)		+= pq2fads_setup.o
 obj-$(CONFIG_PRPMC750)		+= prpmc750.o
 obj-$(CONFIG_PRPMC800)		+= prpmc800.o
 obj-$(CONFIG_RADSTONE_PPC7D)	+= radstone_ppc7d.o
diff -uprN linux-2.6-orig/arch/ppc/platforms/pq2ads.h linux-2.6-new/arch/ppc/platforms/pq2ads.h
--- linux-2.6-orig/arch/ppc/platforms/pq2ads.h	2006-04-11 11:00:08.000000000 -0700
+++ linux-2.6-new/arch/ppc/platforms/pq2ads.h	2006-04-11 11:16:47.000000000 -0700
@@ -15,6 +15,8 @@
 
 #if defined(CONFIG_ADS8272)
 #define BOARD_CHIP_NAME "8272"
+#elif defined(CONFIG_PQ2FADS)
+#define BOARD_CHIP_NAME "8280"
 #endif
 
 /* Memory map is configured by the PROM startup.
@@ -25,7 +27,11 @@
 #define BCSR_ADDR		((uint)0xf4500000)
 #define BCSR_SIZE		((uint)(32 * 1024))
 
+#ifdef CONFIG_PQ2FADS
+#define BOOTROM_RESTART_ADDR	((uint)0xfff40004)
+#else
 #define BOOTROM_RESTART_ADDR	((uint)0xff000104)
+#endif
 
 /* For our show_cpuinfo hooks. */
 #define CPUINFO_VENDOR		"Motorola"
@@ -45,7 +51,18 @@
 #define BCSR1_RS232_EN1		((uint)0x02000000)	/* 0 == enable */
 #define BCSR1_RS232_EN2		((uint)0x01000000)	/* 0 == enable */
 #define BCSR3_FETHIEN2		((uint)0x10000000)	/* 0 == enable */
+#ifdef CONFIG_PQ2FADS
+#define BCSR3_FETH2_RST 	((uint)0x08000000)	/* 0 == reset */
+#else
 #define BCSR3_FETH2_RST 	((uint)0x80000000)	/* 0 == reset */
+#endif
+
+#ifdef CONFIG_PQ2FADS
+#define F2_RXCLK	13
+#define F2_TXCLK	14
+#define F3_RXCLK	15
+#define F3_TXCLK	16
+#endif
 
 #define PHY_INTERRUPT	SIU_INT_IRQ7
 
diff -uprN linux-2.6-orig/arch/ppc/platforms/pq2ads_pd.h linux-2.6-new/arch/ppc/platforms/pq2ads_pd.h
--- linux-2.6-orig/arch/ppc/platforms/pq2ads_pd.h	2006-04-11 11:00:08.000000000 -0700
+++ linux-2.6-new/arch/ppc/platforms/pq2ads_pd.h	2006-04-11 11:14:52.000000000 -0700
@@ -15,19 +15,31 @@
 
 /* FCC1 Clock Source Configuration.  These can be redefined in the board specific file.
    Can only choose from CLK9-12 */
-
+#ifndef F1_RXCLK
 #define F1_RXCLK	11
+#endif
+#ifndef F1_TXCLK
 #define F1_TXCLK	10
+#endif
 
 /* FCC2 Clock Source Configuration.  These can be redefined in the board specific file.
    Can only choose from CLK13-16 */
+#ifndef F2_RXCLK
 #define F2_RXCLK	15
+#endif
+#ifndef F2_TXCLK
 #define F2_TXCLK	16
+#endif
+
 
 /* FCC3 Clock Source Configuration.  These can be redefined in the board specific file.
    Can only choose from CLK13-16 */
+#ifndef F3_RXCLK
 #define F3_RXCLK	13
+#endif
+#ifndef F3_TXCLK
 #define F3_TXCLK	14
+#endif
 
 /* Automatically generates register configurations */
 #define PC_CLK(x)	((uint)(1<<(x-1)))	/* FCC CLK I/O ports */
@@ -110,5 +122,6 @@
 #define FCC_MEM_OFFSET(x) (CPM_FCC_SPECIAL_BASE + (x*128))
 #define FCC1_MEM_OFFSET FCC_MEM_OFFSET(0)
 #define FCC2_MEM_OFFSET FCC_MEM_OFFSET(1)
+#define FCC3_MEM_OFFSET FCC_MEM_OFFSET(2)
 
 #endif
diff -uprN linux-2.6-orig/arch/ppc/platforms/pq2fads_setup.c linux-2.6-new/arch/ppc/platforms/pq2fads_setup.c
--- linux-2.6-orig/arch/ppc/platforms/pq2fads_setup.c	1969-12-31 17:00:00.000000000 -0700
+++ linux-2.6-new/arch/ppc/platforms/pq2fads_setup.c	2006-04-11 11:44:38.000000000 -0700
@@ -0,0 +1,248 @@
+/*
+ * arch/ppc/platforms/pq2fads_setup.c
+ *
+ * PQ2FADS Board-specific Platform Device descriptions
+ *
+ * 2006 (c) MontaVista Software, Inc.
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2. This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/ioport.h>
+#include <linux/fs_enet_pd.h>
+#include <linux/platform_device.h>
+
+#include <asm/io.h>
+#include <asm/mpc8260.h>
+#include <asm/cpm2.h>
+#include <asm/immap_cpm2.h>
+#include <asm/irq.h>
+#include <asm/ppc_sys.h>
+#include <asm/ppcboot.h>
+#include <asm/delay.h>
+
+#include "pq2ads_pd.h"
+
+static void init_fcc2_ioports(void);
+static void init_fcc3_ioports(void);
+
+static struct fs_mii_bb_platform_info m82xx_mii_bb_pdata = {
+	.mdio_port	= fsiop_portc,
+	.mdio_bit	= 9,
+	.mdc_port	= fsiop_portc,
+	.mdc_bit	= 10,
+	.delay		= 1,
+};
+
+/* First Ethernet Port - FCC2 */
+static struct fs_platform_info mpc82xx_fcc2_pdata = {
+	.fs_no		= fsid_fcc2,
+	.cp_page	= CPM_CR_FCC2_PAGE,
+	.cp_block 	= CPM_CR_FCC2_SBLOCK,
+	.clk_trx 	= (PC_F2RXCLK | PC_F2TXCLK),
+	.clk_route	= CMX2_CLK_ROUTE,
+	.clk_mask	= CMX2_CLK_MASK,
+	.init_ioports	= init_fcc2_ioports,
+
+	.phy_addr	= 0,
+#ifdef PHY_INTERRUPT
+	.phy_irq	= PHY_INTERRUPT,
+#else
+	.phy_irq	= -1;
+#endif
+	.mem_offset	= FCC2_MEM_OFFSET,
+	.rx_ring	= 32,
+	.tx_ring	= 32,
+	.rx_copybreak	= 240,
+	.use_napi	= 0,
+	.napi_weight	= 17,
+	.bus_id		= "0:00",
+};
+
+/* Second Ethernet Port - FCC3 */
+static struct fs_platform_info mpc82xx_fcc3_pdata = {
+	.fs_no		= fsid_fcc3,
+	.cp_page	= CPM_CR_FCC3_PAGE,
+	.cp_block 	= CPM_CR_FCC3_SBLOCK,
+	.clk_trx 	= (PC_F3RXCLK | PC_F3TXCLK),
+	.clk_route	= CMX3_CLK_ROUTE,
+	.clk_mask	= CMX3_CLK_MASK,
+	.init_ioports 	= init_fcc3_ioports,
+
+	.phy_addr	= 3,
+#ifdef PHY_INTERRUPT
+	.phy_irq	= PHY_INTERRUPT,
+#else
+	.phy_irq	= -1;
+#endif
+	.mem_offset	= FCC3_MEM_OFFSET,
+	.rx_ring	= 32,
+	.tx_ring	= 32,
+	.rx_copybreak	= 240,
+	.use_napi	= 0,
+	.napi_weight	= 17,
+	.bus_id		= "0:03",
+};
+
+static void init_fcc2_ioports(void)
+{
+	struct io_port *io;
+	u32 tempval;
+	cpm2_map_t* immap = ioremap(CPM_MAP_ADDR, sizeof(cpm2_map_t));
+	u32 *bcsr = ioremap(BCSR_ADDR+4, sizeof(u32));
+
+	io = &immap->im_ioport;
+
+	/* Enable the PHY */
+	clrbits32(bcsr, BCSR1_FETHIEN);
+	setbits32(bcsr, BCSR1_FETH_RST);
+
+	/* FCC2 pins are on port B/C. */
+	/* Configure port B and C pins for FCC2 Ethernet. */
+
+	tempval = in_be32(&io->iop_pdirb);
+	tempval &= ~PB2_DIRB0;
+	tempval |= PB2_DIRB1;
+	out_be32(&io->iop_pdirb, tempval);
+
+	tempval = in_be32(&io->iop_psorb);
+	tempval &= ~PB2_PSORB0;
+	tempval |= PB2_PSORB1;
+	out_be32(&io->iop_psorb, tempval);
+
+	setbits32(&io->iop_pparb,PB2_DIRB0 | PB2_DIRB1);
+
+	tempval = PC_F2RXCLK|PC_F2TXCLK;
+
+	/* Alter clocks */
+	clrbits32(&io->iop_psorc,tempval);
+	clrbits32(&io->iop_pdirc,tempval);
+	setbits32(&io->iop_pparc,tempval);
+
+	clrbits32(&immap->im_cpmux.cmx_fcr, CMX2_CLK_MASK);
+	setbits32(&immap->im_cpmux.cmx_fcr, CMX2_CLK_ROUTE);
+
+	iounmap(bcsr);
+	iounmap(immap);
+}
+
+static void init_fcc3_ioports(void)
+{
+	struct io_port *io;
+	u32 tempval;
+	cpm2_map_t* immap = ioremap(CPM_MAP_ADDR, sizeof(cpm2_map_t));
+	u32 *bcsr = ioremap(BCSR_ADDR+12, sizeof(u32));
+
+	io = &immap->im_ioport;
+
+	/* Enable the PHY */
+	clrbits32(bcsr, BCSR3_FETHIEN2);
+	setbits32(bcsr, BCSR3_FETH2_RST);
+
+	/* FCC3 pins are on port B/C. */
+	/* Configure port B and C pins for FCC3 Ethernet. */
+
+	tempval = in_be32(&io->iop_pdirb);
+	tempval &= ~PB3_DIRB0;
+	tempval |= PB3_DIRB1;
+	out_be32(&io->iop_pdirb, tempval);
+
+	tempval = in_be32(&io->iop_psorb);
+	tempval &= ~PB3_PSORB0;
+	tempval |= PB3_PSORB1;
+	out_be32(&io->iop_psorb, tempval);
+
+	setbits32(&io->iop_pparb,PB3_DIRB0 | PB3_DIRB1);
+
+	/* Alter clocks */
+	tempval = PC_F3TXCLK|PC_F3RXCLK;
+
+	clrbits32(&io->iop_psorc, tempval);
+	clrbits32(&io->iop_pdirc, tempval);
+	setbits32(&io->iop_pparc, tempval);
+
+	clrbits32(&immap->im_cpmux.cmx_fcr, CMX3_CLK_MASK);
+	setbits32(&immap->im_cpmux.cmx_fcr, CMX3_CLK_ROUTE);
+
+	iounmap(bcsr);
+	iounmap(immap);
+}
+
+static void __init pq2fads_fixup_enet_pdata(struct platform_device *pdev,
+						int idx)
+{
+	bd_t* bi = (void*)__res;
+	int fs_no = fsid_fcc1+pdev->id-1;
+
+	mpc82xx_fcc3_pdata.dpram_offset = mpc82xx_fcc2_pdata.dpram_offset = (u32)cpm2_immr->im_dprambase;
+	mpc82xx_fcc3_pdata.fcc_regs_c = mpc82xx_fcc2_pdata.fcc_regs_c = (u32)cpm2_immr->im_fcc_c;
+
+	switch(fs_no) {
+		case fsid_fcc2:
+			memcpy(&mpc82xx_fcc2_pdata.macaddr,bi->bi_enetaddr,6);
+			pdev->dev.platform_data = &mpc82xx_fcc2_pdata;
+		break;
+		case fsid_fcc3:
+			memcpy(&mpc82xx_fcc3_pdata.macaddr,bi->bi_enetaddr,6);
+			mpc82xx_fcc3_pdata.macaddr[5] ^= 1;
+			pdev->dev.platform_data = &mpc82xx_fcc3_pdata;
+		break;
+	}
+}
+
+static void __init pq2fads_fixup_mdio_pdata(struct platform_device *pdev,
+						int idx)
+{
+	m82xx_mii_bb_pdata.irq[0] = PHY_INTERRUPT;
+	m82xx_mii_bb_pdata.irq[1] = -1;
+	m82xx_mii_bb_pdata.irq[2] = -1;
+	m82xx_mii_bb_pdata.irq[3] = PHY_INTERRUPT;
+	m82xx_mii_bb_pdata.irq[31] = -1;
+
+	pdev->dev.platform_data = &m82xx_mii_bb_pdata;
+}
+
+static int pq2fads_platform_notify(struct device *dev)
+{
+	static const struct platform_notify_dev_map dev_map[] = {
+		{
+			.bus_id = "fsl-cpm-fcc",
+			.rtn = pq2fads_fixup_enet_pdata
+		},
+		{
+			.bus_id = "fsl-bb-mdio",
+			.rtn = pq2fads_fixup_mdio_pdata
+		},
+		{
+			.bus_id = NULL
+		}
+	};
+	platform_notify_map(dev_map,dev);
+
+	return 0;
+
+}
+
+int __init pq2fads_init(void)
+{
+	printk(KERN_NOTICE "pq2fads: Init\n");
+
+	platform_notify = pq2fads_platform_notify;
+
+	ppc_sys_device_initfunc();
+
+	ppc_sys_device_disable_all();
+	ppc_sys_device_enable(MPC82xx_CPM_FCC2);
+	ppc_sys_device_enable(MPC82xx_CPM_FCC3);
+	ppc_sys_device_enable(MPC82xx_MDIO_BB);
+
+	return 0;
+}
+
+arch_initcall(pq2fads_init);
diff -uprN linux-2.6-orig/arch/ppc/syslib/m82xx_pci.c linux-2.6-new/arch/ppc/syslib/m82xx_pci.c
--- linux-2.6-orig/arch/ppc/syslib/m82xx_pci.c	2006-04-11 11:00:08.000000000 -0700
+++ linux-2.6-new/arch/ppc/syslib/m82xx_pci.c	2006-04-11 11:14:52.000000000 -0700
@@ -279,8 +279,13 @@ pq2ads_setup_pci(struct pci_controller *
 	immap->im_pci.pci_pobar2 = cpu_to_le32((M82xx_PCI_LOWER_MEM - M82xx_PCI_MEM_OFFSET) >> POTA_ADDR_SHIFT);
 
  	/* Inbound transactions from PCI memory space */
+#ifdef CONFIG_PQ2FADS
+	immap->im_pci.pci_picmr0 = cpu_to_le32(PICMR_ENABLE |
+					((~(M82xx_PCI_SLAVE_MEM_SIZE-1U)) >> PITA_ADDR_SHIFT));
+#else
 	immap->im_pci.pci_picmr0 = cpu_to_le32(PICMR_ENABLE | PICMR_PREFETCH_EN |
 					((~(M82xx_PCI_SLAVE_MEM_SIZE-1U)) >> PITA_ADDR_SHIFT));
+#endif
 	immap->im_pci.pci_pibar0 = cpu_to_le32(M82xx_PCI_SLAVE_MEM_BUS  >> PITA_ADDR_SHIFT);
 	immap->im_pci.pci_pitar0 = cpu_to_le32(M82xx_PCI_SLAVE_MEM_LOCAL>> PITA_ADDR_SHIFT);
 
diff -uprN linux-2.6-orig/arch/ppc/syslib/pq2_sys.c linux-2.6-new/arch/ppc/syslib/pq2_sys.c
--- linux-2.6-orig/arch/ppc/syslib/pq2_sys.c	2006-04-11 11:11:55.000000000 -0700
+++ linux-2.6-new/arch/ppc/syslib/pq2_sys.c	2006-04-11 11:25:00.000000000 -0700
@@ -153,40 +153,42 @@ struct ppc_sys_spec ppc_sys_specs[] = {
 		.ppc_sys_name	= "8270",
 		.mask 		= 0x0000ff00,
 		.value 		= 0x00000a00,
-		.num_devices 	= 12,
+		.num_devices 	= 13,
 		.device_list = (enum ppc_sys_devices[])
 		{
 			MPC82xx_CPM_FCC1, MPC82xx_CPM_FCC2, MPC82xx_CPM_FCC3,
 			MPC82xx_CPM_SCC1, MPC82xx_CPM_SCC2, MPC82xx_CPM_SCC3,
 			MPC82xx_CPM_SCC4, MPC82xx_CPM_MCC1, MPC82xx_CPM_SMC1,
 			MPC82xx_CPM_SMC2, MPC82xx_CPM_SPI, MPC82xx_CPM_I2C,
+			MPC82xx_MDIO_BB,
 		},
 	},
 	{
 		.ppc_sys_name	= "8275",
 		.mask 		= 0x0000ff00,
 		.value 		= 0x00000a00,
-		.num_devices 	= 12,
+		.num_devices 	= 13,
 		.device_list = (enum ppc_sys_devices[])
 		{
 			MPC82xx_CPM_FCC1, MPC82xx_CPM_FCC2, MPC82xx_CPM_FCC3,
 			MPC82xx_CPM_SCC1, MPC82xx_CPM_SCC2, MPC82xx_CPM_SCC3,
 			MPC82xx_CPM_SCC4, MPC82xx_CPM_MCC1, MPC82xx_CPM_SMC1,
 			MPC82xx_CPM_SMC2, MPC82xx_CPM_SPI, MPC82xx_CPM_I2C,
+			MPC82xx_MDIO_BB,
 		},
 	},
 	{
 		.ppc_sys_name	= "8280",
 		.mask 		= 0x0000ff00,
 		.value 		= 0x00000a00,
-		.num_devices 	= 13,
+		.num_devices 	= 14,
 		.device_list = (enum ppc_sys_devices[])
 		{
 			MPC82xx_CPM_FCC1, MPC82xx_CPM_FCC2, MPC82xx_CPM_FCC3,
 			MPC82xx_CPM_SCC1, MPC82xx_CPM_SCC2, MPC82xx_CPM_SCC3,
 			MPC82xx_CPM_SCC4, MPC82xx_CPM_MCC1, MPC82xx_CPM_MCC2,
 			MPC82xx_CPM_SMC1, MPC82xx_CPM_SMC2, MPC82xx_CPM_SPI,
-			MPC82xx_CPM_I2C,
+			MPC82xx_CPM_I2C, MPC82xx_MDIO_BB,
 		},
 	},
 	{
