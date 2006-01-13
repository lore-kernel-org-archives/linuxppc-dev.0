Return-Path: <jdl@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 5C2B0689AC
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Jan 2006 10:29:05 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	k0DNhkDt002937
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jan 2006 16:43:46 -0700 (MST)
Received: from [10.82.19.2] (cashmere.am.freescale.net [10.82.19.2])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id k0DNbfRg012350
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jan 2006 17:37:42 -0600 (CST)
Subject: [PATCH] Initial MPC8540 ADS port with OF Flat Dev
From: Jon Loeliger <jdl@freescale.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Message-Id: <1137194938.29751.3950.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Date: Fri, 13 Jan 2006 17:28:59 -0600
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Initial support for MPC8540 ADS with Flat Device tree.
Does not yet include PCI or I2C.

Signed-off-by: Jon Loeliger <jdl@freescale.com>
Signed-off-by: Becky Bruce <becky.bruce@freescale.com>

--

 arch/powerpc/Kconfig                       |   23 +
 arch/powerpc/configs/mpc8540_ads_defconfig |  723 ++++++++++++++++++++++++++++
 arch/powerpc/kernel/head_booke.h           |  363 ++++++++++++++
 arch/powerpc/platforms/85xx/Kconfig        |   74 ---
 arch/powerpc/platforms/85xx/Makefile       |    5 
 arch/powerpc/platforms/85xx/mpc8540_ads.h  |   67 +++
 arch/powerpc/platforms/85xx/mpc85xx.c      |  257 ++++++++++
 arch/powerpc/platforms/Makefile            |    2 
 8 files changed, 1441 insertions(+), 73 deletions(-)



diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index a8d2f2d..898047d 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -138,6 +138,12 @@ config PPC_83xx
 	select 83xx
 	select PPC_FPU
 
+config PPC_85xx
+	bool "Freescale 85xx"
+	select E500
+	select FSL_SOC
+	select 85xx
+
 config 40x
 	bool "AMCC 40x"
 
@@ -150,8 +156,6 @@ config 8xx
 config E200
 	bool "Freescale e200"
 
-config E500
-	bool "Freescale e500"
 endchoice
 
 config POWER4_ONLY
@@ -179,6 +183,12 @@ config 6xx
 config 83xx
 	bool
 
+config 85xx
+	bool
+
+config E500
+	bool
+
 config PPC_FPU
 	bool
 	default y if PPC64
@@ -228,6 +238,7 @@ config ALTIVEC
 config SPE
 	bool "SPE Support"
 	depends on E200 || E500
+	default y
 	---help---
 	  This option enables kernel support for the Signal Processing
 	  Extensions (SPE) to the PowerPC processor. The kernel currently
@@ -735,13 +746,13 @@ config GENERIC_ISA_DMA
 
 config PPC_I8259
 	bool
-	default y if 85xx
+	default y if PPC_85xx
 	default n
 
 config PPC_INDIRECT_PCI
 	bool
 	depends on PCI
-	default y if 40x || 44x || 85xx
+	default y if 40x || 44x || PPC_85xx
 	default n
 
 config EISA
@@ -758,8 +769,8 @@ config MCA
 	bool
 
 config PCI
-	bool "PCI support" if 40x || CPM2 || PPC_83xx || 85xx || PPC_MPC52xx || (EMBEDDED && PPC_ISERIES)
-	default y if !40x && !CPM2 && !8xx && !APUS && !PPC_83xx && !85xx
+	bool "PCI support" if 40x || CPM2 || PPC_83xx || PPC_85xx || PPC_MPC52xx || (EMBEDDED && PPC_ISERIES)
+	default y if !40x && !CPM2 && !8xx && !APUS && !PPC_83xx && !PPC_85xx
 	default PCI_PERMEDIA if !4xx && !CPM2 && !8xx && APUS
 	default PCI_QSPAN if !4xx && !CPM2 && 8xx
 	help
diff --git a/arch/powerpc/configs/mpc8540_ads_defconfig b/arch/powerpc/configs/mpc8540_ads_defconfig
new file mode 100644
index 0000000..b7489f8
--- /dev/null
+++ b/arch/powerpc/configs/mpc8540_ads_defconfig
@@ -0,0 +1,723 @@
+#
+# Automatically generated make config: don't edit
+# Linux kernel version: 2.6.15-g2554f1e1-dirty
+# Thu Jan 12 16:29:46 2006
+#
+# CONFIG_PPC64 is not set
+CONFIG_PPC32=y
+CONFIG_PPC_MERGE=y
+CONFIG_MMU=y
+CONFIG_GENERIC_HARDIRQS=y
+CONFIG_RWSEM_XCHGADD_ALGORITHM=y
+CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_PPC=y
+CONFIG_EARLY_PRINTK=y
+CONFIG_GENERIC_NVRAM=y
+CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
+CONFIG_ARCH_MAY_HAVE_PC_FDC=y
+CONFIG_PPC_OF=y
+CONFIG_PPC_UDBG_16550=y
+# CONFIG_GENERIC_TBSYNC is not set
+CONFIG_DEFAULT_UIMAGE=y
+
+#
+# Processor support
+#
+# CONFIG_CLASSIC32 is not set
+# CONFIG_PPC_52xx is not set
+# CONFIG_PPC_82xx is not set
+# CONFIG_PPC_83xx is not set
+CONFIG_PPC_85xx=y
+# CONFIG_40x is not set
+# CONFIG_44x is not set
+# CONFIG_8xx is not set
+# CONFIG_E200 is not set
+CONFIG_85xx=y
+CONFIG_E500=y
+CONFIG_BOOKE=y
+CONFIG_FSL_BOOKE=y
+# CONFIG_PHYS_64BIT is not set
+CONFIG_SPE=y
+
+#
+# Code maturity level options
+#
+CONFIG_EXPERIMENTAL=y
+CONFIG_CLEAN_COMPILE=y
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
+CONFIG_BSD_PROCESS_ACCT=y
+# CONFIG_BSD_PROCESS_ACCT_V3 is not set
+CONFIG_SYSCTL=y
+# CONFIG_AUDIT is not set
+# CONFIG_IKCONFIG is not set
+CONFIG_INITRAMFS_SOURCE=""
+CONFIG_CC_OPTIMIZE_FOR_SIZE=y
+CONFIG_EMBEDDED=y
+CONFIG_KALLSYMS=y
+# CONFIG_KALLSYMS_ALL is not set
+# CONFIG_KALLSYMS_EXTRA_PASS is not set
+CONFIG_HOTPLUG=y
+CONFIG_PRINTK=y
+CONFIG_BUG=y
+CONFIG_ELF_CORE=y
+CONFIG_BASE_FULL=y
+CONFIG_FUTEX=y
+CONFIG_EPOLL=y
+CONFIG_SHMEM=y
+CONFIG_CC_ALIGN_FUNCTIONS=0
+CONFIG_CC_ALIGN_LABELS=0
+CONFIG_CC_ALIGN_LOOPS=0
+CONFIG_CC_ALIGN_JUMPS=0
+CONFIG_SLAB=y
+# CONFIG_TINY_SHMEM is not set
+CONFIG_BASE_SMALL=0
+# CONFIG_SLOB is not set
+
+#
+# Loadable module support
+#
+CONFIG_MODULES=y
+# CONFIG_MODULE_UNLOAD is not set
+CONFIG_OBSOLETE_MODPARM=y
+CONFIG_MODVERSIONS=y
+# CONFIG_MODULE_SRCVERSION_ALL is not set
+CONFIG_KMOD=y
+
+#
+# Block layer
+#
+# CONFIG_LBD is not set
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
+CONFIG_MPIC=y
+# CONFIG_WANT_EARLY_SERIAL is not set
+
+#
+# Platform support
+#
+CONFIG_MPC8540_ADS=y
+CONFIG_MPC8540=y
+CONFIG_PPC_INDIRECT_PCI_BE=y
+
+#
+# Kernel options
+#
+# CONFIG_HIGHMEM is not set
+# CONFIG_HZ_100 is not set
+CONFIG_HZ_250=y
+# CONFIG_HZ_1000 is not set
+CONFIG_HZ=250
+CONFIG_PREEMPT_NONE=y
+# CONFIG_PREEMPT_VOLUNTARY is not set
+# CONFIG_PREEMPT is not set
+CONFIG_BINFMT_ELF=y
+CONFIG_BINFMT_MISC=m
+CONFIG_MATH_EMULATION=y
+CONFIG_ARCH_FLATMEM_ENABLE=y
+CONFIG_SELECT_MEMORY_MODEL=y
+CONFIG_FLATMEM_MANUAL=y
+# CONFIG_DISCONTIGMEM_MANUAL is not set
+# CONFIG_SPARSEMEM_MANUAL is not set
+CONFIG_FLATMEM=y
+CONFIG_FLAT_NODE_MEM_MAP=y
+# CONFIG_SPARSEMEM_STATIC is not set
+CONFIG_SPLIT_PTLOCK_CPUS=4
+CONFIG_PROC_DEVICETREE=y
+# CONFIG_CMDLINE_BOOL is not set
+# CONFIG_PM is not set
+# CONFIG_SOFTWARE_SUSPEND is not set
+# CONFIG_SECCOMP is not set
+CONFIG_ISA_DMA_API=y
+
+#
+# Bus options
+#
+CONFIG_PPC_I8259=y
+CONFIG_PPC_INDIRECT_PCI=y
+CONFIG_FSL_SOC=y
+# CONFIG_PCI is not set
+# CONFIG_PCI_DOMAINS is not set
+
+#
+# PCCARD (PCMCIA/CardBus) support
+#
+# CONFIG_PCCARD is not set
+
+#
+# PCI Hotplug Support
+#
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
+CONFIG_BOOT_LOAD=0x00800000
+
+#
+# Networking
+#
+CONFIG_NET=y
+
+#
+# Networking options
+#
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
+# CONFIG_INET_TUNNEL is not set
+CONFIG_INET_DIAG=y
+CONFIG_INET_TCP_DIAG=y
+# CONFIG_TCP_CONG_ADVANCED is not set
+CONFIG_TCP_CONG_BIC=y
+# CONFIG_IPV6 is not set
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
+# CONFIG_DEBUG_DRIVER is not set
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
+# CONFIG_BLK_DEV_COW_COMMON is not set
+CONFIG_BLK_DEV_LOOP=y
+# CONFIG_BLK_DEV_CRYPTOLOOP is not set
+# CONFIG_BLK_DEV_NBD is not set
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
+
+#
+# I2O device support
+#
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
+# PHY device support
+#
+CONFIG_PHYLIB=y
+
+#
+# MII PHY device drivers
+#
+# CONFIG_MARVELL_PHY is not set
+# CONFIG_DAVICOM_PHY is not set
+# CONFIG_QSEMI_PHY is not set
+# CONFIG_LXT_PHY is not set
+# CONFIG_CICADA_PHY is not set
+
+#
+# Ethernet (10 or 100Mbit)
+#
+CONFIG_NET_ETHERNET=y
+CONFIG_MII=y
+
+#
+# Ethernet (1000 Mbit)
+#
+CONFIG_GIANFAR=y
+CONFIG_GFAR_NAPI=y
+
+#
+# Ethernet (10000 Mbit)
+#
+
+#
+# Token Ring devices
+#
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
+CONFIG_INPUT=y
+
+#
+# Userland interfaces
+#
+# CONFIG_INPUT_MOUSEDEV is not set
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
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_8250_NR_UARTS=4
+CONFIG_SERIAL_8250_RUNTIME_UARTS=4
+# CONFIG_SERIAL_8250_EXTENDED is not set
+
+#
+# Non-8250 serial port support
+#
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
+
+#
+# Ftape, the floppy tape device driver
+#
+# CONFIG_AGP is not set
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
+# Dallas's 1-wire bus
+#
+# CONFIG_W1 is not set
+
+#
+# Hardware Monitoring support
+#
+CONFIG_HWMON=y
+# CONFIG_HWMON_VID is not set
+# CONFIG_HWMON_DEBUG_CHIP is not set
+
+#
+# Misc devices
+#
+
+#
+# Multimedia Capabilities Port drivers
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
+# CONFIG_USB_ARCH_HAS_HCD is not set
+# CONFIG_USB_ARCH_HAS_OHCI is not set
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
+# InfiniBand support
+#
+
+#
+# SN Devices
+#
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
+# CONFIG_RELAYFS_FS is not set
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
+# CONFIG_EFI_PARTITION is not set
+
+#
+# Native Language Support
+#
+# CONFIG_NLS is not set
+
+#
+# Library routines
+#
+# CONFIG_CRC_CCITT is not set
+# CONFIG_CRC16 is not set
+CONFIG_CRC32=y
+# CONFIG_LIBCRC32C is not set
+
+#
+# Instrumentation Support
+#
+# CONFIG_PROFILING is not set
+
+#
+# Kernel hacking
+#
+# CONFIG_PRINTK_TIME is not set
+# CONFIG_MAGIC_SYSRQ is not set
+CONFIG_DEBUG_KERNEL=y
+CONFIG_LOG_BUF_SHIFT=14
+CONFIG_DETECT_SOFTLOCKUP=y
+# CONFIG_SCHEDSTATS is not set
+# CONFIG_DEBUG_SLAB is not set
+CONFIG_DEBUG_MUTEXES=y
+# CONFIG_DEBUG_SPINLOCK is not set
+# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
+# CONFIG_DEBUG_KOBJECT is not set
+CONFIG_DEBUG_INFO=y
+# CONFIG_DEBUG_FS is not set
+# CONFIG_DEBUG_VM is not set
+# CONFIG_RCU_TORTURE_TEST is not set
+# CONFIG_DEBUGGER is not set
+# CONFIG_BDI_SWITCH is not set
+# CONFIG_BOOTX_TEXT is not set
+# CONFIG_PPC_EARLY_DEBUG_LPAR is not set
+# CONFIG_PPC_EARLY_DEBUG_G5 is not set
+# CONFIG_PPC_EARLY_DEBUG_RTAS is not set
+# CONFIG_PPC_EARLY_DEBUG_MAPLE is not set
+# CONFIG_PPC_EARLY_DEBUG_ISERIES is not set
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
diff --git a/arch/powerpc/kernel/head_booke.h b/arch/powerpc/kernel/head_booke.h
new file mode 100644
index 0000000..5827c27
--- /dev/null
+++ b/arch/powerpc/kernel/head_booke.h
@@ -0,0 +1,363 @@
+#ifndef __HEAD_BOOKE_H__
+#define __HEAD_BOOKE_H__
+
+/*
+ * Macros used for common Book-e exception handling
+ */
+
+#define SET_IVOR(vector_number, vector_label)		\
+		li	r26,vector_label@l; 		\
+		mtspr	SPRN_IVOR##vector_number,r26;	\
+		sync
+
+#define NORMAL_EXCEPTION_PROLOG						     \
+	mtspr	SPRN_SPRG0,r10;		/* save two registers to work with */\
+	mtspr	SPRN_SPRG1,r11;						     \
+	mtspr	SPRN_SPRG4W,r1;						     \
+	mfcr	r10;			/* save CR in r10 for now	   */\
+	mfspr	r11,SPRN_SRR1;		/* check whether user or kernel    */\
+	andi.	r11,r11,MSR_PR;						     \
+	beq	1f;							     \
+	mfspr	r1,SPRN_SPRG3;		/* if from user, start at top of   */\
+	lwz	r1,THREAD_INFO-THREAD(r1); /* this thread's kernel stack   */\
+	addi	r1,r1,THREAD_SIZE;					     \
+1:	subi	r1,r1,INT_FRAME_SIZE;	/* Allocate an exception frame     */\
+	mr	r11,r1;							     \
+	stw	r10,_CCR(r11);          /* save various registers	   */\
+	stw	r12,GPR12(r11);						     \
+	stw	r9,GPR9(r11);						     \
+	mfspr	r10,SPRN_SPRG0;						     \
+	stw	r10,GPR10(r11);						     \
+	mfspr	r12,SPRN_SPRG1;						     \
+	stw	r12,GPR11(r11);						     \
+	mflr	r10;							     \
+	stw	r10,_LINK(r11);						     \
+	mfspr	r10,SPRN_SPRG4R;					     \
+	mfspr	r12,SPRN_SRR0;						     \
+	stw	r10,GPR1(r11);						     \
+	mfspr	r9,SPRN_SRR1;						     \
+	stw	r10,0(r11);						     \
+	rlwinm	r9,r9,0,14,12;		/* clear MSR_WE (necessary?)	   */\
+	stw	r0,GPR0(r11);						     \
+	SAVE_4GPRS(3, r11);						     \
+	SAVE_2GPRS(7, r11)
+
+/* To handle the additional exception priority levels on 40x and Book-E
+ * processors we allocate a 4k stack per additional priority level. The various
+ * head_xxx.S files allocate space (exception_stack_top) for each priority's
+ * stack times the number of CPUs
+ *
+ * On 40x critical is the only additional level
+ * On 44x/e500 we have critical and machine check
+ * On e200 we have critical and debug (machine check occurs via critical)
+ *
+ * Additionally we reserve a SPRG for each priority level so we can free up a
+ * GPR to use as the base for indirect access to the exception stacks.  This
+ * is necessary since the MMU is always on, for Book-E parts, and the stacks
+ * are offset from KERNELBASE.
+ *
+ */
+#define BOOKE_EXCEPTION_STACK_SIZE	(8192)
+
+/* CRIT_SPRG only used in critical exception handling */
+#define CRIT_SPRG	SPRN_SPRG2
+/* MCHECK_SPRG only used in machine check exception handling */
+#define MCHECK_SPRG	SPRN_SPRG6W
+
+#define MCHECK_STACK_TOP	(exception_stack_top - 4096)
+#define CRIT_STACK_TOP		(exception_stack_top)
+
+/* only on e200 for now */
+#define DEBUG_STACK_TOP		(exception_stack_top - 4096)
+#define DEBUG_SPRG		SPRN_SPRG6W
+
+#ifdef CONFIG_SMP
+#define BOOKE_LOAD_EXC_LEVEL_STACK(level)		\
+	mfspr	r8,SPRN_PIR;				\
+	mulli	r8,r8,BOOKE_EXCEPTION_STACK_SIZE;	\
+	neg	r8,r8;					\
+	addis	r8,r8,level##_STACK_TOP@ha;		\
+	addi	r8,r8,level##_STACK_TOP@l
+#else
+#define BOOKE_LOAD_EXC_LEVEL_STACK(level)		\
+	lis	r8,level##_STACK_TOP@h;			\
+	ori	r8,r8,level##_STACK_TOP@l
+#endif
+
+/*
+ * Exception prolog for critical/machine check exceptions.  This is a
+ * little different from the normal exception prolog above since a
+ * critical/machine check exception can potentially occur at any point
+ * during normal exception processing. Thus we cannot use the same SPRG
+ * registers as the normal prolog above. Instead we use a portion of the
+ * critical/machine check exception stack at low physical addresses.
+ */
+#define EXC_LEVEL_EXCEPTION_PROLOG(exc_level, exc_level_srr0, exc_level_srr1) \
+	mtspr	exc_level##_SPRG,r8;					     \
+	BOOKE_LOAD_EXC_LEVEL_STACK(exc_level);/* r8 points to the exc_level stack*/ \
+	stw	r10,GPR10-INT_FRAME_SIZE(r8);				     \
+	stw	r11,GPR11-INT_FRAME_SIZE(r8);				     \
+	mfcr	r10;			/* save CR in r10 for now	   */\
+	mfspr	r11,exc_level_srr1;	/* check whether user or kernel    */\
+	andi.	r11,r11,MSR_PR;						     \
+	mr	r11,r8;							     \
+	mfspr	r8,exc_level##_SPRG;					     \
+	beq	1f;							     \
+	/* COMING FROM USER MODE */					     \
+	mfspr	r11,SPRN_SPRG3;		/* if from user, start at top of   */\
+	lwz	r11,THREAD_INFO-THREAD(r11); /* this thread's kernel stack */\
+	addi	r11,r11,THREAD_SIZE;					     \
+1:	subi	r11,r11,INT_FRAME_SIZE;	/* Allocate an exception frame     */\
+	stw	r10,_CCR(r11);          /* save various registers	   */\
+	stw	r12,GPR12(r11);						     \
+	stw	r9,GPR9(r11);						     \
+	mflr	r10;							     \
+	stw	r10,_LINK(r11);						     \
+	mfspr	r12,SPRN_DEAR;		/* save DEAR and ESR in the frame  */\
+	stw	r12,_DEAR(r11);		/* since they may have had stuff   */\
+	mfspr	r9,SPRN_ESR;		/* in them at the point where the  */\
+	stw	r9,_ESR(r11);		/* exception was taken		   */\
+	mfspr	r12,exc_level_srr0;					     \
+	stw	r1,GPR1(r11);						     \
+	mfspr	r9,exc_level_srr1;					     \
+	stw	r1,0(r11);						     \
+	mr	r1,r11;							     \
+	rlwinm	r9,r9,0,14,12;		/* clear MSR_WE (necessary?)	   */\
+	stw	r0,GPR0(r11);						     \
+	SAVE_4GPRS(3, r11);						     \
+	SAVE_2GPRS(7, r11)
+
+#define CRITICAL_EXCEPTION_PROLOG \
+		EXC_LEVEL_EXCEPTION_PROLOG(CRIT, SPRN_CSRR0, SPRN_CSRR1)
+#define DEBUG_EXCEPTION_PROLOG \
+		EXC_LEVEL_EXCEPTION_PROLOG(DEBUG, SPRN_DSRR0, SPRN_DSRR1)
+#define MCHECK_EXCEPTION_PROLOG \
+		EXC_LEVEL_EXCEPTION_PROLOG(MCHECK, SPRN_MCSRR0, SPRN_MCSRR1)
+
+/*
+ * Exception vectors.
+ */
+#define	START_EXCEPTION(label)						     \
+        .align 5;              						     \
+label:
+
+#define FINISH_EXCEPTION(func)					\
+	bl	transfer_to_handler_full;			\
+	.long	func;						\
+	.long	ret_from_except_full
+
+#define EXCEPTION(n, label, hdlr, xfer)				\
+	START_EXCEPTION(label);					\
+	NORMAL_EXCEPTION_PROLOG;				\
+	addi	r3,r1,STACK_FRAME_OVERHEAD;			\
+	xfer(n, hdlr)
+
+#define CRITICAL_EXCEPTION(n, label, hdlr)			\
+	START_EXCEPTION(label);					\
+	CRITICAL_EXCEPTION_PROLOG;				\
+	addi	r3,r1,STACK_FRAME_OVERHEAD;			\
+	EXC_XFER_TEMPLATE(hdlr, n+2, (MSR_KERNEL & ~(MSR_ME|MSR_DE|MSR_CE)), \
+			  NOCOPY, crit_transfer_to_handler, \
+			  ret_from_crit_exc)
+
+#define MCHECK_EXCEPTION(n, label, hdlr)			\
+	START_EXCEPTION(label);					\
+	MCHECK_EXCEPTION_PROLOG;				\
+	mfspr	r5,SPRN_ESR;					\
+	stw	r5,_ESR(r11);					\
+	addi	r3,r1,STACK_FRAME_OVERHEAD;			\
+	EXC_XFER_TEMPLATE(hdlr, n+2, (MSR_KERNEL & ~(MSR_ME|MSR_DE|MSR_CE)), \
+			  NOCOPY, mcheck_transfer_to_handler,   \
+			  ret_from_mcheck_exc)
+
+#define EXC_XFER_TEMPLATE(hdlr, trap, msr, copyee, tfer, ret)	\
+	li	r10,trap;					\
+	stw	r10,_TRAP(r11);					\
+	lis	r10,msr@h;					\
+	ori	r10,r10,msr@l;					\
+	copyee(r10, r9);					\
+	bl	tfer;		 				\
+	.long	hdlr;						\
+	.long	ret
+
+#define COPY_EE(d, s)		rlwimi d,s,0,16,16
+#define NOCOPY(d, s)
+
+#define EXC_XFER_STD(n, hdlr)		\
+	EXC_XFER_TEMPLATE(hdlr, n, MSR_KERNEL, NOCOPY, transfer_to_handler_full, \
+			  ret_from_except_full)
+
+#define EXC_XFER_LITE(n, hdlr)		\
+	EXC_XFER_TEMPLATE(hdlr, n+1, MSR_KERNEL, NOCOPY, transfer_to_handler, \
+			  ret_from_except)
+
+#define EXC_XFER_EE(n, hdlr)		\
+	EXC_XFER_TEMPLATE(hdlr, n, MSR_KERNEL, COPY_EE, transfer_to_handler_full, \
+			  ret_from_except_full)
+
+#define EXC_XFER_EE_LITE(n, hdlr)	\
+	EXC_XFER_TEMPLATE(hdlr, n+1, MSR_KERNEL, COPY_EE, transfer_to_handler, \
+			  ret_from_except)
+
+/* Check for a single step debug exception while in an exception
+ * handler before state has been saved.  This is to catch the case
+ * where an instruction that we are trying to single step causes
+ * an exception (eg ITLB/DTLB miss) and thus the first instruction of
+ * the exception handler generates a single step debug exception.
+ *
+ * If we get a debug trap on the first instruction of an exception handler,
+ * we reset the MSR_DE in the _exception handler's_ MSR (the debug trap is
+ * a critical exception, so we are using SPRN_CSRR1 to manipulate the MSR).
+ * The exception handler was handling a non-critical interrupt, so it will
+ * save (and later restore) the MSR via SPRN_CSRR1, which will still have
+ * the MSR_DE bit set.
+ */
+#ifdef CONFIG_E200
+#define DEBUG_EXCEPTION							      \
+	START_EXCEPTION(Debug);						      \
+	DEBUG_EXCEPTION_PROLOG;						      \
+									      \
+	/*								      \
+	 * If there is a single step or branch-taken exception in an	      \
+	 * exception entry sequence, it was probably meant to apply to	      \
+	 * the code where the exception occurred (since exception entry	      \
+	 * doesn't turn off DE automatically).  We simulate the effect	      \
+	 * of turning off DE on entry to an exception handler by turning      \
+	 * off DE in the CSRR1 value and clearing the debug status.	      \
+	 */								      \
+	mfspr	r10,SPRN_DBSR;		/* check single-step/branch taken */  \
+	andis.	r10,r10,DBSR_IC@h;					      \
+	beq+	2f;							      \
+									      \
+	lis	r10,KERNELBASE@h;	/* check if exception in vectors */   \
+	ori	r10,r10,KERNELBASE@l;					      \
+	cmplw	r12,r10;						      \
+	blt+	2f;			/* addr below exception vectors */    \
+									      \
+	lis	r10,Debug@h;						      \
+	ori	r10,r10,Debug@l;					      \
+	cmplw	r12,r10;						      \
+	bgt+	2f;			/* addr above exception vectors */    \
+									      \
+	/* here it looks like we got an inappropriate debug exception. */     \
+1:	rlwinm	r9,r9,0,~MSR_DE;	/* clear DE in the CDRR1 value */     \
+	lis	r10,DBSR_IC@h;		/* clear the IC event */	      \
+	mtspr	SPRN_DBSR,r10;						      \
+	/* restore state and get out */					      \
+	lwz	r10,_CCR(r11);						      \
+	lwz	r0,GPR0(r11);						      \
+	lwz	r1,GPR1(r11);						      \
+	mtcrf	0x80,r10;						      \
+	mtspr	SPRN_DSRR0,r12;						      \
+	mtspr	SPRN_DSRR1,r9;						      \
+	lwz	r9,GPR9(r11);						      \
+	lwz	r12,GPR12(r11);						      \
+	mtspr	DEBUG_SPRG,r8;						      \
+	BOOKE_LOAD_EXC_LEVEL_STACK(DEBUG); /* r8 points to the debug stack */ \
+	lwz	r10,GPR10-INT_FRAME_SIZE(r8);				      \
+	lwz	r11,GPR11-INT_FRAME_SIZE(r8);				      \
+	mfspr	r8,DEBUG_SPRG;						      \
+									      \
+	RFDI;								      \
+	b	.;							      \
+									      \
+	/* continue normal handling for a critical exception... */	      \
+2:	mfspr	r4,SPRN_DBSR;						      \
+	addi	r3,r1,STACK_FRAME_OVERHEAD;				      \
+	EXC_XFER_TEMPLATE(DebugException, 0x2002, (MSR_KERNEL & ~(MSR_ME|MSR_DE|MSR_CE)), NOCOPY, debug_transfer_to_handler, ret_from_debug_exc)
+#else
+#define DEBUG_EXCEPTION							      \
+	START_EXCEPTION(Debug);						      \
+	CRITICAL_EXCEPTION_PROLOG;					      \
+									      \
+	/*								      \
+	 * If there is a single step or branch-taken exception in an	      \
+	 * exception entry sequence, it was probably meant to apply to	      \
+	 * the code where the exception occurred (since exception entry	      \
+	 * doesn't turn off DE automatically).  We simulate the effect	      \
+	 * of turning off DE on entry to an exception handler by turning      \
+	 * off DE in the CSRR1 value and clearing the debug status.	      \
+	 */								      \
+	mfspr	r10,SPRN_DBSR;		/* check single-step/branch taken */  \
+	andis.	r10,r10,DBSR_IC@h;					      \
+	beq+	2f;							      \
+									      \
+	lis	r10,KERNELBASE@h;	/* check if exception in vectors */   \
+	ori	r10,r10,KERNELBASE@l;					      \
+	cmplw	r12,r10;						      \
+	blt+	2f;			/* addr below exception vectors */    \
+									      \
+	lis	r10,Debug@h;						      \
+	ori	r10,r10,Debug@l;					      \
+	cmplw	r12,r10;						      \
+	bgt+	2f;			/* addr above exception vectors */    \
+									      \
+	/* here it looks like we got an inappropriate debug exception. */     \
+1:	rlwinm	r9,r9,0,~MSR_DE;	/* clear DE in the CSRR1 value */     \
+	lis	r10,DBSR_IC@h;		/* clear the IC event */	      \
+	mtspr	SPRN_DBSR,r10;						      \
+	/* restore state and get out */					      \
+	lwz	r10,_CCR(r11);						      \
+	lwz	r0,GPR0(r11);						      \
+	lwz	r1,GPR1(r11);						      \
+	mtcrf	0x80,r10;						      \
+	mtspr	SPRN_CSRR0,r12;						      \
+	mtspr	SPRN_CSRR1,r9;						      \
+	lwz	r9,GPR9(r11);						      \
+	lwz	r12,GPR12(r11);						      \
+	mtspr	CRIT_SPRG,r8;						      \
+	BOOKE_LOAD_EXC_LEVEL_STACK(CRIT); /* r8 points to the debug stack */  \
+	lwz	r10,GPR10-INT_FRAME_SIZE(r8);				      \
+	lwz	r11,GPR11-INT_FRAME_SIZE(r8);				      \
+	mfspr	r8,CRIT_SPRG;						      \
+									      \
+	rfci;								      \
+	b	.;							      \
+									      \
+	/* continue normal handling for a critical exception... */	      \
+2:	mfspr	r4,SPRN_DBSR;						      \
+	addi	r3,r1,STACK_FRAME_OVERHEAD;				      \
+	EXC_XFER_TEMPLATE(DebugException, 0x2002, (MSR_KERNEL & ~(MSR_ME|MSR_DE|MSR_CE)), NOCOPY, crit_transfer_to_handler, ret_from_crit_exc)
+#endif
+
+#define INSTRUCTION_STORAGE_EXCEPTION					      \
+	START_EXCEPTION(InstructionStorage)				      \
+	NORMAL_EXCEPTION_PROLOG;					      \
+	mfspr	r5,SPRN_ESR;		/* Grab the ESR and save it */	      \
+	stw	r5,_ESR(r11);						      \
+	mr      r4,r12;                 /* Pass SRR0 as arg2 */		      \
+	li      r5,0;                   /* Pass zero as arg3 */		      \
+	EXC_XFER_EE_LITE(0x0400, handle_page_fault)
+
+#define ALIGNMENT_EXCEPTION						      \
+	START_EXCEPTION(Alignment)					      \
+	NORMAL_EXCEPTION_PROLOG;					      \
+	mfspr   r4,SPRN_DEAR;           /* Grab the DEAR and save it */	      \
+	stw     r4,_DEAR(r11);						      \
+	addi    r3,r1,STACK_FRAME_OVERHEAD;				      \
+	EXC_XFER_EE(0x0600, alignment_exception)
+
+#define PROGRAM_EXCEPTION						      \
+	START_EXCEPTION(Program)					      \
+	NORMAL_EXCEPTION_PROLOG;					      \
+	mfspr	r4,SPRN_ESR;		/* Grab the ESR and save it */	      \
+	stw	r4,_ESR(r11);						      \
+	addi	r3,r1,STACK_FRAME_OVERHEAD;				      \
+	EXC_XFER_STD(0x0700, program_check_exception)
+
+#define DECREMENTER_EXCEPTION						      \
+	START_EXCEPTION(Decrementer)					      \
+	NORMAL_EXCEPTION_PROLOG;					      \
+	lis     r0,TSR_DIS@h;           /* Setup the DEC interrupt mask */    \
+	mtspr   SPRN_TSR,r0;		/* Clear the DEC interrupt */	      \
+	addi    r3,r1,STACK_FRAME_OVERHEAD;				      \
+	EXC_XFER_LITE(0x0900, timer_interrupt)
+
+#define FP_UNAVAILABLE_EXCEPTION					      \
+	START_EXCEPTION(FloatingPointUnavailable)			      \
+	NORMAL_EXCEPTION_PROLOG;					      \
+	bne	load_up_fpu;		/* if from user, just load it up */   \
+	addi	r3,r1,STACK_FRAME_OVERHEAD;				      \
+	EXC_XFER_EE_LITE(0x800, KernelFP)
+
+#endif /* __HEAD_BOOKE_H__ */
diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index c5bc282..d3d0ff7 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -1,86 +1,30 @@
-config 85xx
-	bool
-	depends on E500
-	default y
-
-config PPC_INDIRECT_PCI_BE
-	bool
-	depends on 85xx
-	default y
-
-menu "Freescale 85xx options"
-	depends on E500
+menu "Platform support"
+	depends on PPC_85xx
 
 choice
 	prompt "Machine Type"
-	depends on 85xx
 	default MPC8540_ADS
 
 config MPC8540_ADS
 	bool "Freescale MPC8540 ADS"
 	help
-	  This option enables support for the MPC 8540 ADS evaluation board.
-
-config MPC8548_CDS
-	bool "Freescale MPC8548 CDS"
-	help
-	  This option enablese support for the MPC8548 CDS evaluation board.
-
-config MPC8555_CDS
-	bool "Freescale MPC8555 CDS"
-	help
-	  This option enablese support for the MPC8555 CDS evaluation board.
-
-config MPC8560_ADS
-	bool "Freescale MPC8560 ADS"
-	help
-	  This option enables support for the MPC 8560 ADS evaluation board.
-
-config SBC8560
-	bool "WindRiver PowerQUICC III SBC8560"
-	help
-	  This option enables support for the WindRiver PowerQUICC III 
-	  SBC8560 board.
-
-config STX_GP3
-	bool "Silicon Turnkey Express GP3"
-	help
-	  This option enables support for the Silicon Turnkey Express GP3
-	  board.
+	  This option enables support for the MPC 8540 ADS board
 
 endchoice
 
-# It's often necessary to know the specific 85xx processor type.
-# Fortunately, it is implied (so far) from the board type, so we
-# don't need to ask more redundant questions.
 config MPC8540
 	bool
-	depends on MPC8540_ADS
-	default y
-
-config MPC8548
-	bool
-	depends on MPC8548_CDS
-	default y
+	select PPC_UDBG_16550
+	select PPC_INDIRECT_PCI
+	default y if MPC8540_ADS
 
-config MPC8555
-	bool
-	depends on MPC8555_CDS
-	default y
-
-config MPC8560
+config PPC_INDIRECT_PCI_BE
 	bool
-	depends on SBC8560 || MPC8560_ADS || STX_GP3
-	default y
-
-config 85xx_PCI2
-	bool "Supprt for 2nd PCI host controller"
-	depends on MPC8555_CDS
+	depends on PPC_85xx
 	default y
 
-config PPC_GEN550
+config MPIC
 	bool
-	depends on MPC8540 || SBC8560 || MPC8555
 	default y
 
 endmenu
diff --git a/arch/powerpc/platforms/85xx/Makefile b/arch/powerpc/platforms/85xx/Makefile
index 6407197..a9f3b36 100644
--- a/arch/powerpc/platforms/85xx/Makefile
+++ b/arch/powerpc/platforms/85xx/Makefile
@@ -1 +1,4 @@
-# empty makefile so make clean works
+#
+# Makefile for the PowerPC 85xx linux kernel.
+#
+obj-$(CONFIG_PPC_85xx)	+= mpc85xx.o
diff --git a/arch/powerpc/platforms/85xx/mpc8540_ads.h b/arch/powerpc/platforms/85xx/mpc8540_ads.h
new file mode 100644
index 0000000..c665efc
--- /dev/null
+++ b/arch/powerpc/platforms/85xx/mpc8540_ads.h
@@ -0,0 +1,67 @@
+/*
+ * arch/ppc/platforms/85xx/mpc8540_ads.h
+ *
+ * MPC8540ADS board definitions
+ *
+ * Maintainer: Kumar Gala <kumar.gala@freescale.com>
+ *
+ * Copyright 2004 Freescale Semiconductor Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ */
+
+#ifndef __MACH_MPC8540ADS_H__
+#define __MACH_MPC8540ADS_H__
+
+#include <linux/config.h>
+#include <linux/initrd.h>
+
+#define BOARD_CCSRBAR		((uint)0xe0000000)
+#define BCSR_ADDR		((uint)0xf8000000)
+#define BCSR_SIZE		((uint)(32 * 1024))
+
+/* PCI interrupt controller */
+#define PIRQA		MPC85xx_IRQ_EXT1
+#define PIRQB		MPC85xx_IRQ_EXT2
+#define PIRQC		MPC85xx_IRQ_EXT3
+#define PIRQD		MPC85xx_IRQ_EXT4
+
+#define MPC85XX_PCI1_LOWER_IO	0x00000000
+#define MPC85XX_PCI1_UPPER_IO	0x00ffffff
+
+#define MPC85XX_PCI1_LOWER_MEM	0x80000000
+#define MPC85XX_PCI1_UPPER_MEM	0x9fffffff
+
+#define MPC85XX_PCI1_IO_BASE	0xe2000000
+#define MPC85XX_PCI1_MEM_OFFSET	0x00000000
+
+#define MPC85XX_PCI1_IO_SIZE	0x01000000
+
+/* PCI config */
+#define PCI1_CFG_ADDR_OFFSET	(0x8000)
+#define PCI1_CFG_DATA_OFFSET	(0x8004)
+
+#define PCI2_CFG_ADDR_OFFSET	(0x9000)
+#define PCI2_CFG_DATA_OFFSET	(0x9004)
+
+/* Additional register for PCI-X configuration */
+#define PCIX_NEXT_CAP	0x60
+#define PCIX_CAP_ID	0x61
+#define PCIX_COMMAND	0x62
+#define PCIX_STATUS	0x64
+
+/* Serial Config */
+#ifdef CONFIG_SERIAL_MANY_PORTS
+#define RS_TABLE_SIZE  64
+#else
+#define RS_TABLE_SIZE  2
+#endif
+
+/* Offset of CPM register space */
+#define CPM_MAP_ADDR	(CCSRBAR + MPC85xx_CPM_OFFSET)
+
+#endif /* __MACH_MPC8540ADS_H__ */
diff --git a/arch/powerpc/platforms/85xx/mpc85xx.c b/arch/powerpc/platforms/85xx/mpc85xx.c
new file mode 100644
index 0000000..417f496
--- /dev/null
+++ b/arch/powerpc/platforms/85xx/mpc85xx.c
@@ -0,0 +1,257 @@
+/*
+ * MPC85xx setup and early boot code plus other random bits.
+ *
+ * Maintained by Kumar Gala (see MAINTAINERS for contact information)
+ *
+ * Copyright 2005 Freescale Semiconductor Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/config.h>
+#include <linux/stddef.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/errno.h>
+#include <linux/reboot.h>
+#include <linux/pci.h>
+#include <linux/kdev_t.h>
+#include <linux/major.h>
+#include <linux/console.h>
+#include <linux/delay.h>
+#include <linux/irq.h>
+#include <linux/seq_file.h>
+#include <linux/root_dev.h>
+#include <linux/serial.h>
+#include <linux/tty.h>	/* for linux/serial_core.h */
+#include <linux/serial_core.h>
+#include <linux/initrd.h>
+#include <linux/module.h>
+#include <linux/fsl_devices.h>
+#include <linux/serial_core.h>
+#include <linux/serial_8250.h>
+
+#include <asm/system.h>
+#include <asm/pgtable.h>
+#include <asm/page.h>
+#include <asm/atomic.h>
+#include <asm/time.h>
+#include <asm/io.h>
+#include <asm/machdep.h>
+#include <asm/bootinfo.h>
+#include <asm/pci-bridge.h>
+#include <asm/mpc85xx.h>
+#include <asm/irq.h>
+#include <asm/immap_85xx.h>
+#include <asm/prom.h>
+#include <asm/mpic.h>
+#include <mm/mmu_decl.h>
+#include <asm/udbg.h>
+
+extern unsigned long total_memory;	/* in mm/init */
+
+extern void abort(void);
+
+extern void gen550_progress(char *, unsigned short);
+extern void gen550_init(int, struct uart_port *);
+extern phys_addr_t get_immrbase(void);
+extern void find_legacy_serial_ports(void);
+
+void mpc85xx_ads_show_cpuinfo(struct seq_file *m);
+void mpc85xx_restart(char *cmd);
+void mpc85xx_halt(void);
+void mpc85xx_power_off(void);
+
+#ifndef CONFIG_PCI
+unsigned long isa_io_base = 0;
+unsigned long isa_mem_base = 0;
+#endif
+
+phys_addr_t immr_base;
+
+
+/*
+ * Internal interrupts are all Level Sensitive, and Positive Polarity
+ *
+ * Note:  Likely, this table and the following function should be
+ *        obtained and derived from the OF Device Tree.
+ */
+static u_char mpc85xx_ads_openpic_initsenses[] __initdata = {
+	MPC85XX_INTERNAL_IRQ_SENSES,
+	0x0,						/* External  0: */
+#if defined(CONFIG_PCI)
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* Ext 1: PCI slot 0 */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* Ext 2: PCI slot 1 */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* Ext 3: PCI slot 2 */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* Ext 4: PCI slot 3 */
+#else
+	0x0,				/* External  1: */
+	0x0,				/* External  2: */
+	0x0,				/* External  3: */
+	0x0,				/* External  4: */
+#endif
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* External 5: PHY */
+	0x0,				/* External  6: */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* External 7: PHY */
+	0x0,				/* External  8: */
+	0x0,				/* External  9: */
+	0x0,				/* External 10: */
+	0x0,				/* External 11: */
+};
+
+
+void __init mpc85xx_pic_init(void)
+{
+	struct mpic *mpic1;
+	/* Determine the Physical Address of the OpenPIC regs */
+	phys_addr_t OpenPIC_PAddr = immr_base + MPC85xx_OPENPIC_OFFSET;
+
+	mpic1 = mpic_alloc(OpenPIC_PAddr,
+			MPIC_PRIMARY | MPIC_WANTS_RESET | MPIC_BIG_ENDIAN,
+			4, MPC85xx_OPENPIC_IRQ_OFFSET, 0, 250,
+			mpc85xx_ads_openpic_initsenses,
+			sizeof(mpc85xx_ads_openpic_initsenses), " OpenPIC  ");
+	BUG_ON(mpic1 == NULL);
+	mpic_assign_isu(mpic1, 0, OpenPIC_PAddr + 0x10200);
+	mpic_assign_isu(mpic1, 1, OpenPIC_PAddr + 0x10280);
+	mpic_assign_isu(mpic1, 2, OpenPIC_PAddr + 0x10300);
+	mpic_assign_isu(mpic1, 3, OpenPIC_PAddr + 0x10380);
+	mpic_assign_isu(mpic1, 4, OpenPIC_PAddr + 0x10400);
+	mpic_assign_isu(mpic1, 5, OpenPIC_PAddr + 0x10480);
+	mpic_assign_isu(mpic1, 6, OpenPIC_PAddr + 0x10500);
+	mpic_assign_isu(mpic1, 7, OpenPIC_PAddr + 0x10580);
+
+	/* dummy mappings to get to 48 */
+	mpic_assign_isu(mpic1, 8, OpenPIC_PAddr + 0x10600);
+	mpic_assign_isu(mpic1, 9, OpenPIC_PAddr + 0x10680);
+	mpic_assign_isu(mpic1, 10, OpenPIC_PAddr + 0x10700);
+	mpic_assign_isu(mpic1, 11, OpenPIC_PAddr + 0x10780);
+
+	/* External ints */
+	mpic_assign_isu(mpic1, 12, OpenPIC_PAddr + 0x10000);
+	mpic_assign_isu(mpic1, 13, OpenPIC_PAddr + 0x10080);
+	mpic_assign_isu(mpic1, 14, OpenPIC_PAddr + 0x10100);
+	mpic_init(mpic1);
+}
+
+
+/*
+ * Setup the architecture
+ */
+
+static void __init
+mpc85xx_setup_arch(void)
+{
+	struct device_node *cpu;
+
+	if (ppc_md.progress)
+		ppc_md.progress("mpc85xx_setup_arch()", 0);
+
+	cpu = of_find_node_by_type(NULL, "cpu");
+	if (cpu != 0) {
+		unsigned int *fp;
+
+		fp = (int *)get_property(cpu, "clock-frequency", NULL);
+		if (fp != 0)
+			loops_per_jiffy = *fp / HZ;
+		else
+			loops_per_jiffy = 50000000 / HZ;
+		of_node_put(cpu);
+	}
+
+	immr_base = get_immrbase();
+
+#ifdef CONFIG_SERIAL_TEXT_DEBUG
+	/*
+	 * Invalidate the entry we stole earlier.
+	 * The serial ports should be properly mapped.
+	 */
+	invalidate_tlbcam_entry(num_tlbcam_entries - 1);
+#endif
+
+#ifdef  CONFIG_ROOT_NFS
+	ROOT_DEV = Root_NFS;
+#else
+	ROOT_DEV = Root_HDA1;
+#endif
+}
+
+
+void __init
+platform_init(void)
+{
+	ppc_md.setup_arch = mpc85xx_setup_arch;
+	ppc_md.show_cpuinfo = mpc85xx_ads_show_cpuinfo;
+
+	ppc_md.init_IRQ = mpc85xx_pic_init;
+	ppc_md.get_irq = mpic_get_irq;
+
+	ppc_md.restart = mpc85xx_restart;
+	ppc_md.power_off = mpc85xx_power_off;
+	ppc_md.halt = mpc85xx_halt;
+
+	ppc_md.time_init = NULL;
+	ppc_md.set_rtc_time = NULL;
+	ppc_md.get_rtc_time = NULL;
+	ppc_md.calibrate_decr = generic_calibrate_decr;
+
+	ppc_md.progress = udbg_progress;
+
+	if (ppc_md.progress)
+		ppc_md.progress("mpc85xx platform_init(): exit", 0);
+}
+
+void
+mpc85xx_restart(char *cmd)
+{
+	local_irq_disable();
+	abort();
+}
+
+void
+mpc85xx_power_off(void)
+{
+	local_irq_disable();
+	for(;;);
+}
+
+void
+mpc85xx_halt(void)
+{
+	local_irq_disable();
+	for(;;);
+}
+
+/* For now this is a pass through */
+phys_addr_t fixup_bigphys_addr(phys_addr_t addr, phys_addr_t size)
+{
+	return addr;
+};
+EXPORT_SYMBOL(fixup_bigphys_addr);
+
+
+
+void
+mpc85xx_ads_show_cpuinfo(struct seq_file *m)
+{
+	uint pvid, svid, phid1;
+	uint memsize = total_memory;
+
+	pvid = mfspr(SPRN_PVR);
+	svid = mfspr(SPRN_SVR);
+
+	seq_printf(m, "Vendor\t\t: Freescale Semiconductor\n");
+	seq_printf(m, "Machine\t\t: mpc85xx\n");
+	seq_printf(m, "PVR\t\t: 0x%x\n", pvid);
+	seq_printf(m, "SVR\t\t: 0x%x\n", svid);
+
+	/* Display cpu Pll setting */
+	phid1 = mfspr(SPRN_HID1);
+	seq_printf(m, "PLL setting\t: 0x%x\n", ((phid1 >> 24) & 0x3f));
+
+	/* Display the amount of memory */
+	seq_printf(m, "Memory\t\t: %d MB\n", memsize / (1024 * 1024));
+}
diff --git a/arch/powerpc/platforms/Makefile b/arch/powerpc/platforms/Makefile
index 04073fd..c4f6b0d 100644
--- a/arch/powerpc/platforms/Makefile
+++ b/arch/powerpc/platforms/Makefile
@@ -8,7 +8,7 @@ endif
 obj-$(CONFIG_PPC_CHRP)		+= chrp/
 obj-$(CONFIG_4xx)		+= 4xx/
 obj-$(CONFIG_PPC_83xx)		+= 83xx/
-obj-$(CONFIG_85xx)		+= 85xx/
+obj-$(CONFIG_PPC_85xx)		+= 85xx/
 obj-$(CONFIG_PPC_PSERIES)	+= pseries/
 obj-$(CONFIG_PPC_ISERIES)	+= iseries/
 obj-$(CONFIG_PPC_MAPLE)		+= maple/
