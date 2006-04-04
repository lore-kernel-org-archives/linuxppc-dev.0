Return-Path: <wfarnsworth@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id CB548679E0
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  5 Apr 2006 09:54:19 +1000 (EST)
Received: from rhino.az.mvista.com (rhino.az.mvista.com [10.50.1.88])
	by hermes.mvista.com (Postfix) with ESMTP id 4312E1B1A6
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  4 Apr 2006 16:54:16 -0700 (PDT)
Subject: [PATCH] ppc32: Support for Freescale PQ2FADS
From: Wade Farnsworth <wfarnsworth@mvista.com>
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Content-Type: text/plain
Message-Id: <1144194855.32471.64.camel@rhino.az.mvista.com>
Mime-Version: 1.0
Date: 04 Apr 2006 16:54:16 -0700
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

 arch/ppc/Kconfig                   |    2
 arch/ppc/configs/pq2fads_defconfig |  712 +++++++++++++++++++++++++++
 arch/ppc/platforms/Makefile        |    1
 arch/ppc/platforms/pq2ads.h        |   10
 arch/ppc/platforms/pq2ads_pd.h     |   11
 arch/ppc/platforms/pq2fads_setup.c |  235 ++++++++
 arch/ppc/syslib/m82xx_pci.c        |    5
 7 files changed, 975 insertions(+), 1 deletion(-)

diff --git a/arch/ppc/Kconfig b/arch/ppc/Kconfig
--- a/arch/ppc/Kconfig
+++ b/arch/ppc/Kconfig
@@ -731,7 +731,7 @@ endchoice
 
 config PQ2ADS
 	bool
-	depends on ADS8272
+	depends on ADS8272 || PQ2FADS
 	default y
 
 config TQM8xxL
diff --git a/arch/ppc/configs/pq2fads_defconfig b/arch/ppc/configs/pq2fads_defconfig
new file mode 100644
--- /dev/null
+++ b/arch/ppc/configs/pq2fads_defconfig
@@ -0,0 +1,712 @@
+#
+# Automatically generated make config: don't edit
+# Linux kernel version: 2.6.10_mvl401
+# Thu Mar 23 14:28:38 2006
+#
+CONFIG_MMU=y
+CONFIG_GENERIC_HARDIRQS=y
+CONFIG_RWSEM_GENERIC_SPINLOCK=y
+CONFIG_ASM_SEMAPHORES=y
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
+CONFIG_BROKEN_ON_SMP=y
+
+#
+# General setup
+#
+CONFIG_LOCALVERSION=""
+CONFIG_SWAP=y
+CONFIG_SYSVIPC=y
+CONFIG_SYSVIPC_SEMMNI=128
+CONFIG_SYSVIPC_SEMMSL=250
+# CONFIG_POSIX_MQUEUE is not set
+# CONFIG_BSD_PROCESS_ACCT is not set
+CONFIG_SYSCTL=y
+# CONFIG_AUDIT is not set
+CONFIG_LOG_BUF_SHIFT=14
+# CONFIG_HOTPLUG is not set
+CONFIG_KOBJECT_UEVENT=y
+# CONFIG_IKCONFIG is not set
+CONFIG_EMBEDDED=y
+# CONFIG_KALLSYMS is not set
+CONFIG_FUTEX=y
+# CONFIG_EPOLL is not set
+# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
+CONFIG_SHMEM=y
+CONFIG_CC_ALIGN_FUNCTIONS=0
+CONFIG_CC_ALIGN_LABELS=0
+CONFIG_CC_ALIGN_LOOPS=0
+CONFIG_CC_ALIGN_JUMPS=0
+# CONFIG_BOOT_FLIGHT_RECORDER is not set
+CONFIG_LOCKLESS=y
+CONFIG_BOOT_FLIGHT_BUFFERS=4
+CONFIG_BOOT_FLIGHT_SIZE=524288
+CONFIG_FLIGHT_PROC_BUFFERS=8
+CONFIG_FLIGHT_PROC_SIZE=8192
+CONFIG_NEWEV=y
+CONFIG_CSTM=y
+# CONFIG_TINY_SHMEM is not set
+
+#
+# Loadable module support
+#
+# CONFIG_MODULES is not set
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
+# CONFIG_E200 is not set
+# CONFIG_E500 is not set
+CONFIG_PPC_FPU=y
+# CONFIG_CPU_FREQ is not set
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
+# CONFIG_PPC_MULTIPLATFORM is not set
+# CONFIG_APUS is not set
+# CONFIG_KATANA is not set
+# CONFIG_WILLOW is not set
+# CONFIG_CPCI690 is not set
+# CONFIG_PCORE is not set
+# CONFIG_POWERPMC250 is not set
+# CONFIG_CHESTNUT is not set
+# CONFIG_SPRUCE is not set
+# CONFIG_EV64260 is not set
+# CONFIG_LOPEC is not set
+# CONFIG_MCPN765 is not set
+# CONFIG_MVME5100 is not set
+# CONFIG_PPLUS is not set
+# CONFIG_PRPMC750 is not set
+# CONFIG_PRPMC800 is not set
+# CONFIG_SANDPOINT is not set
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
+CONFIG_PQ2FADS=y
+# CONFIG_LITE5200 is not set
+# CONFIG_MPC834x_SYS is not set
+CONFIG_PQ2ADS=y
+CONFIG_8260=y
+CONFIG_CPM2=y
+# CONFIG_PC_KEYBOARD is not set
+# CONFIG_SMP is not set
+CONFIG_PREEMPT_NONE=y
+# CONFIG_PREEMPT_VOLUNTARY is not set
+# CONFIG_PREEMPT_DESKTOP is not set
+# CONFIG_PREEMPT_RT is not set
+# CONFIG_PREEMPT_SOFTIRQS is not set
+# CONFIG_PREEMPT_HARDIRQS is not set
+# CONFIG_PREEMPT_BKL is not set
+# CONFIG_HIGHMEM is not set
+# CONFIG_HIGH_RES_TIMERS is not set
+CONFIG_BINFMT_ELF=y
+# CONFIG_BINFMT_MISC is not set
+# CONFIG_CMDLINE_BOOL is not set
+
+#
+# Bus options
+#
+CONFIG_PCI=y
+CONFIG_PCI_DOMAINS=y
+CONFIG_PCI_8260=y
+# CONFIG_8260_PCI9 is not set
+# CONFIG_PCI_LEGACY_PROC is not set
+# CONFIG_PCI_NAMES is not set
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
+# Device Drivers
+#
+
+#
+# Generic Driver Options
+#
+CONFIG_STANDALONE=y
+CONFIG_PREVENT_FIRMWARE_BUILD=y
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
+CONFIG_BLK_DEV_LOOP=y
+# CONFIG_BLK_DEV_CRYPTOLOOP is not set
+# CONFIG_BLK_DEV_NBD is not set
+# CONFIG_BLK_DEV_SX8 is not set
+CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_COUNT=16
+CONFIG_BLK_DEV_RAM_SIZE=32768
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
+
+#
+# ATA/ATAPI/MFM/RLL support
+#
+# CONFIG_IDE is not set
+
+#
+# SCSI device support
+#
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
+# CONFIG_PACKET_MMAP is not set
+# CONFIG_NETLINK_DEV is not set
+CONFIG_UNIX=y
+# CONFIG_NET_KEY is not set
+CONFIG_USE_POLICY_FWD=y
+CONFIG_INET=y
+CONFIG_IP_MULTICAST=y
+# CONFIG_IP_ADVANCED_ROUTER is not set
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
+CONFIG_IP_TCPDIAG=y
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
+# CONFIG_IEEE80211 is not set
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
+# CONFIG_PHYLIB is not set
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
+
+#
+# Broadcom network devices
+#
+# CONFIG_HND is not set
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
+# CONFIG_SK98LIN is not set
+# CONFIG_TIGON3 is not set
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
+# CONFIG_INPUT_MOUSEDEV is not set
+# CONFIG_INPUT_JOYDEV is not set
+# CONFIG_INPUT_TSDEV is not set
+# CONFIG_INPUT_TSLIBDEV is not set
+# CONFIG_INPUT_EVDEV is not set
+# CONFIG_INPUT_EVBUG is not set
+
+#
+# Input I/O drivers
+#
+# CONFIG_GAMEPORT is not set
+CONFIG_SOUND_GAMEPORT=y
+# CONFIG_SERIO is not set
+# CONFIG_SERIO_I8042 is not set
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
+# CONFIG_BLOCKER is not set
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
+# CONFIG_USB is not set
+CONFIG_USB_ARCH_HAS_HCD=y
+CONFIG_USB_ARCH_HAS_OHCI=y
+
+#
+# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support' may also be needed; see USB_STORAGE Help for more information
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
+# Synchronous Serial Interfaces (SSI)
+#
+
+#
+# File systems
+#
+CONFIG_EXT2_FS=y
+# CONFIG_EXT2_FS_XATTR is not set
+CONFIG_EXT3_FS=y
+CONFIG_EXT3_FS_XATTR=y
+# CONFIG_EXT3_FS_POSIX_ACL is not set
+# CONFIG_EXT3_FS_SECURITY is not set
+CONFIG_JBD=y
+# CONFIG_JBD_DEBUG is not set
+CONFIG_FS_MBCACHE=y
+# CONFIG_REISERFS_FS is not set
+# CONFIG_JFS_FS is not set
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
+# CONFIG_DEVFS_FS is not set
+# CONFIG_DEVPTS_FS_XATTR is not set
+CONFIG_TMPFS=y
+# CONFIG_TMPFS_XATTR is not set
+# CONFIG_HUGETLB_PAGE is not set
+CONFIG_RAMFS=y
+# CONFIG_RELAYFS_FS is not set
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
+# CONFIG_JFFS2_COMPRESSION_OPTIONS is not set
+# CONFIG_CRAMFS is not set
+# CONFIG_VXFS_FS is not set
+# CONFIG_HPFS_FS is not set
+# CONFIG_QNX4FS_FS is not set
+# CONFIG_SYSV_FS is not set
+# CONFIG_UFS_FS is not set
+# CONFIG_YAFFS_FS is not set
+# CONFIG_YAFFS1_FS is not set
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
+# CONFIG_EXPORTFS is not set
+CONFIG_SUNRPC=y
+# CONFIG_RPCSEC_GSS_KRB5 is not set
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
+# CONFIG_CRC32 is not set
+# CONFIG_LIBCRC32C is not set
+
+#
+# Fast Real-Time Domain
+#
+# CONFIG_FRD is not set
+
+#
+# Fast Real-Time Domain Advanced Options
+#
+
+#
+# Profiling support
+#
+# CONFIG_PROFILING is not set
+
+#
+# MontaVista System tools
+#
+# CONFIG_ILATENCY is not set
+
+#
+# Kernel hacking
+#
+# CONFIG_DEBUG_KERNEL is not set
+# CONFIG_WAKEUP_TIMING is not set
+# CONFIG_CRITICAL_IRQSOFF_TIMING is not set
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
diff --git a/arch/ppc/platforms/Makefile b/arch/ppc/platforms/Makefile
--- a/arch/ppc/platforms/Makefile
+++ b/arch/ppc/platforms/Makefile
@@ -21,6 +21,7 @@ obj-$(CONFIG_MVME5100)		+= mvme5100.o
 obj-$(CONFIG_PAL4)		+= pal4_setup.o pal4_pci.o
 obj-$(CONFIG_POWERPMC250)	+= powerpmc250.o
 obj-$(CONFIG_PPLUS)		+= pplus.o
+obj-$(CONFIG_PQ2FADS)		+= pq2fads_setup.o
 obj-$(CONFIG_PRPMC750)		+= prpmc750.o
 obj-$(CONFIG_PRPMC800)		+= prpmc800.o
 obj-$(CONFIG_RADSTONE_PPC7D)	+= radstone_ppc7d.o
diff --git a/arch/ppc/platforms/pq2ads.h b/arch/ppc/platforms/pq2ads.h
--- a/arch/ppc/platforms/pq2ads.h
+++ b/arch/ppc/platforms/pq2ads.h
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
@@ -45,7 +51,11 @@
 #define BCSR1_RS232_EN1		((uint)0x02000000)	/* 0 == enable */
 #define BCSR1_RS232_EN2		((uint)0x01000000)	/* 0 == enable */
 #define BCSR3_FETHIEN2		((uint)0x10000000)	/* 0 == enable */
+#ifdef CONFIG_PQ2FADS
+#define BCSR3_FETH2_RST 	((uint)0x08000000)	/* 0 == reset */
+#else
 #define BCSR3_FETH2_RST 	((uint)0x80000000)	/* 0 == reset */
+#endif
 
 #define PHY_INTERRUPT	SIU_INT_IRQ7
 
diff --git a/arch/ppc/platforms/pq2ads_pd.h b/arch/ppc/platforms/pq2ads_pd.h
--- a/arch/ppc/platforms/pq2ads_pd.h
+++ b/arch/ppc/platforms/pq2ads_pd.h
@@ -21,13 +21,23 @@
 
 /* FCC2 Clock Source Configuration.  These can be redefined in the board specific file.
    Can only choose from CLK13-16 */
+#ifdef CONFIG_PQ2FADS
+#define F2_RXCLK	13
+#define F2_TXCLK	14
+#else
 #define F2_RXCLK	15
 #define F2_TXCLK	16
+#endif
 
 /* FCC3 Clock Source Configuration.  These can be redefined in the board specific file.
    Can only choose from CLK13-16 */
+#ifdef CONFIG_PQ2FADS
+#define F3_RXCLK	15
+#define F3_TXCLK	16
+#else
 #define F3_RXCLK	13
 #define F3_TXCLK	14
+#endif
 
 /* Automatically generates register configurations */
 #define PC_CLK(x)	((uint)(1<<(x-1)))	/* FCC CLK I/O ports */
@@ -110,5 +120,6 @@
 #define FCC_MEM_OFFSET(x) (CPM_FCC_SPECIAL_BASE + (x*128))
 #define FCC1_MEM_OFFSET FCC_MEM_OFFSET(0)
 #define FCC2_MEM_OFFSET FCC_MEM_OFFSET(1)
+#define FCC3_MEM_OFFSET FCC_MEM_OFFSET(2)
 
 #endif
diff --git a/arch/ppc/platforms/pq2fads_setup.c b/arch/ppc/platforms/pq2fads_setup.c
new file mode 100644
--- /dev/null
+++ b/arch/ppc/platforms/pq2fads_setup.c
@@ -0,0 +1,235 @@
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
+void ppc_sys_device_enable(enum ppc_sys_devices);
+static void init_fcc2_ioports(void);
+static void init_fcc3_ioports(void);
+
+static struct fs_mii_bus_info mii_bus_info = {
+	.method                 = fsmii_bitbang,
+	.id                     = 0,
+	.i.bitbang = {
+		.mdio_port	= fsiop_portc,
+		.mdc_port	= fsiop_portc,
+		.mdio_bit	= 9,
+		.mdc_bit	= 10,
+		.delay		= 1,
+	},
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
+	.bus_info	= &mii_bus_info,
+	.rx_ring	= 32,
+	.tx_ring	= 32,
+	.rx_copybreak	= 240,
+	.use_napi	= 0,
+	.napi_weight	= 17,
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
+	.bus_info	= &mii_bus_info,
+	.rx_ring	= 32,
+	.tx_ring	= 32,
+	.rx_copybreak	= 240,
+	.use_napi	= 0,
+	.napi_weight	= 17,
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
+					      int idx)
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
+static int pq2fads_platform_notify(struct device *dev)
+{
+	static const struct platform_notify_dev_map dev_map[] = {
+		{
+			.bus_id = "fsl-cpm-fcc",
+			.rtn = pq2fads_fixup_enet_pdata
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
+
+	return 0;
+}
+
+arch_initcall(pq2fads_init);
diff --git a/arch/ppc/syslib/m82xx_pci.c b/arch/ppc/syslib/m82xx_pci.c
--- a/arch/ppc/syslib/m82xx_pci.c
+++ b/arch/ppc/syslib/m82xx_pci.c
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
 
