Return-Path: <bodonoghue@codehermit.ie>
Received: from lugano.hostireland.com (lugano.hostireland.com [212.100.248.6])
	by ozlabs.org (Postfix) with ESMTP id 74BA767BA5
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 21 Aug 2006 06:18:00 +1000 (EST)
Date: Sun, 20 Aug 2006 20:36:49 +0100
From: Bryan O'Donoghue <bodonoghue@codehermit.ie>
To: marcelo@kvack.org, linuxppc-embedded@ozlabs.org
Subject: [PATCH] Add adder87x board support to 2.6.x
Message-ID: <20060820203649.4dbf89a6@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Greetings all.

This set of patches adds support for the Analogue & Micro Adder87x to Linux.

The port is based on mpc885ads in the 2.6.18-rc4 tree.
The patches are very simple really consisting of a stripped down version of
mpc885ads renamed to adder87x*blah, a defconfig and appropriate entries in 
arch/ppc/Kconfig, arch/ppc/platforms/Makefile and include/asm-ppc/mpc8xx.h.

I've spent a bit of time testing this out, and I'm reasonably happy that this
should be useful to others using this development board.


Signed-off-by: Bryan O'Donoghue <bodonoghue@codehermit.ie>

	modified: arch/ppc/Kconfig
	new file: arch/ppc/configs/adder87x_defconfig
	modified: arch/ppc/platforms/Makefile
	new file: arch/ppc/platforms/adder87x.h
	new file: arch/ppc/platforms/adder87x_setup.c
	modified: include/asm-ppc/mpc8xx.h

---

 arch/ppc/Kconfig                    |    5 
 arch/ppc/configs/adder87x_defconfig |  767 +++++++++++++++++++++++++++++++++++
 arch/ppc/platforms/Makefile         |    1 
 arch/ppc/platforms/adder87x.h       |   32 +
 arch/ppc/platforms/adder87x_setup.c |  276 +++++++++++++
 include/asm-ppc/mpc8xx.h            |    4 
 6 files changed, 1085 insertions(+), 0 deletions(-)
 create mode 100644 arch/ppc/configs/adder87x_defconfig
 create mode 100644 arch/ppc/platforms/adder87x.h
 create mode 100644 arch/ppc/platforms/adder87x_setup.c

79f0a05e41edfca35038448810959aa6a1f8c943
diff --git a/arch/ppc/Kconfig b/arch/ppc/Kconfig
--- a/arch/ppc/Kconfig
+++ b/arch/ppc/Kconfig
@@ -478,6 +478,11 @@ config WINCEPT
 	  MPC821 PowerPC, introduced in 1998 and designed to be used in
 	  thin-client machines.  Say Y to support it directly.
 
+config ADDER87X
+	bool "ADDER87X"
+	help
+	  The Analogue and Micro Adder87x, with Das U-Boot as a bootloader.
+
 endchoice
 
 menu "Freescale Ethernet driver platform-specific options"
diff --git a/arch/ppc/configs/adder87x_defconfig b/arch/ppc/configs/adder87x_defconfig
new file mode 100644
--- /dev/null
+++ b/arch/ppc/configs/adder87x_defconfig
@@ -0,0 +1,767 @@
+#
+# Automatically generated make config: don't edit
+# Linux kernel version: 2.6.18-rc4
+# Sun Aug 20 17:03:31 2006
+#
+CONFIG_MMU=y
+CONFIG_GENERIC_HARDIRQS=y
+CONFIG_RWSEM_XCHGADD_ALGORITHM=y
+CONFIG_GENERIC_HWEIGHT=y
+CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_PPC=y
+CONFIG_PPC32=y
+CONFIG_GENERIC_NVRAM=y
+CONFIG_GENERIC_FIND_NEXT_BIT=y
+CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
+CONFIG_ARCH_MAY_HAVE_PC_FDC=y
+CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
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
+# CONFIG_SWAP is not set
+CONFIG_SYSVIPC=y
+# CONFIG_POSIX_MQUEUE is not set
+# CONFIG_BSD_PROCESS_ACCT is not set
+# CONFIG_TASKSTATS is not set
+CONFIG_SYSCTL=y
+# CONFIG_AUDIT is not set
+# CONFIG_IKCONFIG is not set
+# CONFIG_RELAY is not set
+CONFIG_INITRAMFS_SOURCE=""
+# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
+CONFIG_EMBEDDED=y
+# CONFIG_KALLSYMS is not set
+CONFIG_HOTPLUG=y
+CONFIG_PRINTK=y
+CONFIG_BUG=y
+CONFIG_ELF_CORE=y
+CONFIG_BASE_FULL=y
+CONFIG_RT_MUTEXES=y
+CONFIG_FUTEX=y
+# CONFIG_EPOLL is not set
+CONFIG_SHMEM=y
+CONFIG_SLAB=y
+CONFIG_VM_EVENT_COUNTERS=y
+# CONFIG_TINY_SHMEM is not set
+CONFIG_BASE_SMALL=0
+# CONFIG_SLOB is not set
+
+#
+# Loadable module support
+#
+CONFIG_MODULES=y
+# CONFIG_MODULE_UNLOAD is not set
+# CONFIG_MODVERSIONS is not set
+# CONFIG_MODULE_SRCVERSION_ALL is not set
+# CONFIG_KMOD is not set
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
+# CONFIG_IOSCHED_AS is not set
+# CONFIG_IOSCHED_DEADLINE is not set
+# CONFIG_IOSCHED_CFQ is not set
+# CONFIG_DEFAULT_AS is not set
+# CONFIG_DEFAULT_DEADLINE is not set
+# CONFIG_DEFAULT_CFQ is not set
+CONFIG_DEFAULT_NOOP=y
+CONFIG_DEFAULT_IOSCHED="noop"
+
+#
+# Processor
+#
+# CONFIG_6xx is not set
+# CONFIG_40x is not set
+# CONFIG_44x is not set
+CONFIG_8xx=y
+# CONFIG_E200 is not set
+# CONFIG_E500 is not set
+# CONFIG_MATH_EMULATION is not set
+# CONFIG_KEXEC is not set
+# CONFIG_CPU_FREQ is not set
+# CONFIG_WANT_EARLY_SERIAL is not set
+CONFIG_EMBEDDEDBOOT=y
+CONFIG_NOT_COHERENT_CACHE=y
+
+#
+# Platform options
+#
+# CONFIG_RPXLITE is not set
+# CONFIG_RPXCLASSIC is not set
+# CONFIG_BSEIP is not set
+# CONFIG_MPC8XXFADS is not set
+# CONFIG_MPC86XADS is not set
+# CONFIG_MPC885ADS is not set
+# CONFIG_TQM823L is not set
+# CONFIG_TQM850L is not set
+# CONFIG_TQM855L is not set
+# CONFIG_TQM860L is not set
+# CONFIG_FPS850L is not set
+# CONFIG_IVMS8 is not set
+# CONFIG_IVML24 is not set
+# CONFIG_HERMES_PRO is not set
+# CONFIG_IP860 is not set
+# CONFIG_LWMON is not set
+# CONFIG_PCU_E is not set
+# CONFIG_CCM is not set
+# CONFIG_LANTEC is not set
+# CONFIG_MBX is not set
+# CONFIG_WINCEPT is not set
+CONFIG_ADDER87X=y
+
+#
+# Freescale Ethernet driver platform-specific options
+#
+CONFIG_CPM1=y
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
+# CONFIG_RESOURCES_64BIT is not set
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
+# CONFIG_PCI is not set
+# CONFIG_PCI_DOMAINS is not set
+# CONFIG_PCI_QSPAN is not set
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
+CONFIG_HIGHMEM_START=0xfe000000
+# CONFIG_LOWMEM_SIZE_BOOL is not set
+CONFIG_LOWMEM_SIZE=0x30000000
+# CONFIG_KERNEL_START_BOOL is not set
+CONFIG_KERNEL_START=0xc0000000
+# CONFIG_TASK_SIZE_BOOL is not set
+CONFIG_TASK_SIZE=0x80000000
+CONFIG_CONSISTENT_START_BOOL=y
+CONFIG_CONSISTENT_START=0xff400000
+CONFIG_CONSISTENT_SIZE_BOOL=y
+CONFIG_CONSISTENT_SIZE=0x00200000
+# CONFIG_BOOT_LOAD_BOOL is not set
+CONFIG_BOOT_LOAD=0x00400000
+# CONFIG_PIN_TLB is not set
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
+CONFIG_XFRM=y
+# CONFIG_XFRM_USER is not set
+# CONFIG_NET_KEY is not set
+CONFIG_INET=y
+# CONFIG_IP_MULTICAST is not set
+# CONFIG_IP_ADVANCED_ROUTER is not set
+CONFIG_IP_FIB_HASH=y
+CONFIG_IP_PNP=y
+CONFIG_IP_PNP_DHCP=y
+CONFIG_IP_PNP_BOOTP=y
+# CONFIG_IP_PNP_RARP is not set
+# CONFIG_NET_IPIP is not set
+# CONFIG_NET_IPGRE is not set
+# CONFIG_ARPD is not set
+# CONFIG_SYN_COOKIES is not set
+# CONFIG_INET_AH is not set
+# CONFIG_INET_ESP is not set
+# CONFIG_INET_IPCOMP is not set
+# CONFIG_INET_XFRM_TUNNEL is not set
+# CONFIG_INET_TUNNEL is not set
+CONFIG_INET_XFRM_MODE_TRANSPORT=y
+CONFIG_INET_XFRM_MODE_TUNNEL=y
+CONFIG_INET_DIAG=y
+CONFIG_INET_TCP_DIAG=y
+# CONFIG_TCP_CONG_ADVANCED is not set
+CONFIG_TCP_CONG_BIC=y
+# CONFIG_IPV6 is not set
+# CONFIG_INET6_XFRM_TUNNEL is not set
+# CONFIG_INET6_TUNNEL is not set
+# CONFIG_NETWORK_SECMARK is not set
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
+# CONFIG_SYS_HYPERVISOR is not set
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
+# CONFIG_BLK_DEV_LOOP is not set
+# CONFIG_BLK_DEV_NBD is not set
+# CONFIG_BLK_DEV_RAM is not set
+# CONFIG_BLK_DEV_INITRD is not set
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
+# CONFIG_PHYLIB is not set
+
+#
+# Ethernet (10 or 100Mbit)
+#
+CONFIG_NET_ETHERNET=y
+CONFIG_MII=y
+# CONFIG_FEC_8XX is not set
+CONFIG_FS_ENET=y
+# CONFIG_FS_ENET_HAS_SCC is not set
+CONFIG_FS_ENET_HAS_FEC=y
+
+#
+# Ethernet (1000 Mbit)
+#
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
+CONFIG_PPP=y
+# CONFIG_PPP_MULTILINK is not set
+# CONFIG_PPP_FILTER is not set
+CONFIG_PPP_ASYNC=y
+CONFIG_PPP_SYNC_TTY=y
+CONFIG_PPP_DEFLATE=y
+# CONFIG_PPP_BSDCOMP is not set
+# CONFIG_PPP_MPPE is not set
+# CONFIG_PPPOE is not set
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
+# CONFIG_SERIAL_CPM_SCC1 is not set
+# CONFIG_SERIAL_CPM_SCC2 is not set
+# CONFIG_SERIAL_CPM_SCC3 is not set
+# CONFIG_SERIAL_CPM_SCC4 is not set
+CONFIG_SERIAL_CPM_SMC1=y
+CONFIG_SERIAL_CPM_SMC2=y
+CONFIG_UNIX98_PTYS=y
+# CONFIG_LEGACY_PTYS is not set
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
+CONFIG_HW_RANDOM=y
+# CONFIG_NVRAM is not set
+# CONFIG_GEN_RTC is not set
+# CONFIG_DTLK is not set
+# CONFIG_R3964 is not set
+
+#
+# Ftape, the floppy tape device driver
+#
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
+
+#
+# Hardware Monitoring support
+#
+CONFIG_HWMON=y
+# CONFIG_HWMON_VID is not set
+# CONFIG_SENSORS_ABITUGURU is not set
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
+CONFIG_VIDEO_V4L2=y
+
+#
+# Digital Video Broadcasting Devices
+#
+# CONFIG_DVB is not set
+
+#
+# Graphics support
+#
+CONFIG_FIRMWARE_EDID=y
+# CONFIG_FB is not set
+# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
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
+# CONFIG_USB_ARCH_HAS_EHCI is not set
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
+# DMA Engine support
+#
+# CONFIG_DMA_ENGINE is not set
+
+#
+# DMA Clients
+#
+
+#
+# DMA Devices
+#
+
+#
+# File systems
+#
+CONFIG_EXT2_FS=m
+CONFIG_EXT2_FS_XATTR=y
+# CONFIG_EXT2_FS_POSIX_ACL is not set
+# CONFIG_EXT2_FS_SECURITY is not set
+# CONFIG_EXT2_FS_XIP is not set
+CONFIG_EXT3_FS=m
+CONFIG_EXT3_FS_XATTR=y
+# CONFIG_EXT3_FS_POSIX_ACL is not set
+# CONFIG_EXT3_FS_SECURITY is not set
+CONFIG_JBD=m
+# CONFIG_JBD_DEBUG is not set
+CONFIG_FS_MBCACHE=m
+# CONFIG_REISERFS_FS is not set
+# CONFIG_JFS_FS is not set
+# CONFIG_FS_POSIX_ACL is not set
+# CONFIG_XFS_FS is not set
+# CONFIG_OCFS2_FS is not set
+# CONFIG_MINIX_FS is not set
+# CONFIG_ROMFS_FS is not set
+CONFIG_INOTIFY=y
+CONFIG_INOTIFY_USER=y
+# CONFIG_QUOTA is not set
+# CONFIG_DNOTIFY is not set
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
+# CONFIG_PROC_KCORE is not set
+CONFIG_SYSFS=y
+# CONFIG_TMPFS is not set
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
+CONFIG_MSDOS_PARTITION=y
+# CONFIG_BSD_DISKLABEL is not set
+# CONFIG_MINIX_SUBPARTITION is not set
+# CONFIG_SOLARIS_X86_PARTITION is not set
+# CONFIG_UNIXWARE_DISKLABEL is not set
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
+
+#
+# MPC8xx CPM Options
+#
+# CONFIG_SCC_ENET is not set
+# CONFIG_FEC_ENET is not set
+
+#
+# Generic MPC8xx Options
+#
+CONFIG_8xx_COPYBACK=y
+CONFIG_8xx_CPU6=y
+CONFIG_NO_UCODE_PATCH=y
+# CONFIG_USB_SOF_UCODE_PATCH is not set
+# CONFIG_I2C_SPI_UCODE_PATCH is not set
+# CONFIG_I2C_SPI_SMC1_UCODE_PATCH is not set
+
+#
+# Library routines
+#
+CONFIG_CRC_CCITT=y
+# CONFIG_CRC16 is not set
+# CONFIG_CRC32 is not set
+# CONFIG_LIBCRC32C is not set
+CONFIG_ZLIB_INFLATE=y
+CONFIG_ZLIB_DEFLATE=y
+CONFIG_PLIST=y
+# CONFIG_PROFILING is not set
+
+#
+# Kernel hacking
+#
+# CONFIG_PRINTK_TIME is not set
+# CONFIG_MAGIC_SYSRQ is not set
+# CONFIG_UNUSED_SYMBOLS is not set
+# CONFIG_DEBUG_KERNEL is not set
+CONFIG_LOG_BUF_SHIFT=14
+# CONFIG_DEBUG_FS is not set
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
diff --git a/arch/ppc/platforms/Makefile b/arch/ppc/platforms/Makefile
--- a/arch/ppc/platforms/Makefile
+++ b/arch/ppc/platforms/Makefile
@@ -32,3 +32,4 @@ obj-$(CONFIG_EV64360)		+= ev64360.o
 obj-$(CONFIG_MPC86XADS)		+= mpc866ads_setup.o
 obj-$(CONFIG_MPC885ADS)		+= mpc885ads_setup.o
 obj-$(CONFIG_ADS8272)		+= mpc8272ads_setup.o
+obj-$(CONFIG_ADDER87X)		+= adder87x_setup.o
diff --git a/arch/ppc/platforms/adder87x.h b/arch/ppc/platforms/adder87x.h
new file mode 100644
--- /dev/null
+++ b/arch/ppc/platforms/adder87x.h
@@ -0,0 +1,32 @@
+/*
+ * Support for Analogue & Micro Adder87x
+ * mostly a cloned config of mpc885ads.h
+ *
+ * Bryan O'Donoghue, CodeHermit Software Engineering
+ * bodonoghue@codehermit.ie
+ *
+ * 2006 (c) CodeHermit Software Engineering.
+ * Released under the GNU General Public License version 2.
+ */
+
+#ifdef __KERNEL__
+#ifndef __ADDER87X_H__
+#define __ADDER87X_H__
+
+#include <asm/ppcboot.h>
+
+#define BOARD_CHIP_NAME		"MPC885"
+#define IMAP_ADDR		((uint)0xff000000)
+#define IMAP_SIZE		((uint)(64 * 1024))
+
+/* Interrupt level assignments */
+#define PHY_INTERRUPT	SIU_IRQ7	/* PHY link change interrupt */
+#define SIU_INT_FEC1	SIU_LEVEL1	/* FEC1 interrupt */
+#define SIU_INT_FEC2	SIU_LEVEL3	/* FEC2 interrupt */
+#define FEC_INTERRUPT	SIU_INT_FEC1	/* FEC interrupt */
+
+/* We don't use the 8259 */
+#define NR_8259_INTS	0
+
+#endif /* __ADDER87X_H__ */
+#endif /* __KERNEL__ */
diff --git a/arch/ppc/platforms/adder87x_setup.c b/arch/ppc/platforms/adder87x_setup.c
new file mode 100644
--- /dev/null
+++ b/arch/ppc/platforms/adder87x_setup.c
@@ -0,0 +1,276 @@
+/*
+ * Support for Analogue & Micro Adder87x
+ *
+ * Bryan O'Donoghue, CodeHermit Software Engineering
+ * bodonoghue@codehermit.ie
+ *
+ * Cloned/stripped down from mpc885ads_setup.c
+ *
+ * 2006 (c) CodeHermit Software Engineering.
+ * Released under the GNU General Public License version 2.
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/param.h>
+#include <linux/string.h>
+#include <linux/ioport.h>
+#include <linux/device.h>
+
+#include <linux/fs_enet_pd.h>
+#include <linux/fs_uart_pd.h>
+#include <linux/mii.h>
+
+#include <asm/delay.h>
+#include <asm/io.h>
+#include <asm/machdep.h>
+#include <asm/page.h>
+#include <asm/processor.h>
+#include <asm/system.h>
+#include <asm/time.h>
+#include <asm/ppcboot.h>
+#include <asm/8xx_immap.h>
+#include <asm/commproc.h>
+#include <asm/ppc_sys.h>
+
+/* TODO: Get LEDs on PB29 & PB30 working with LEDs subsystem */ 
+
+extern unsigned char __res[];
+static void setup_smc1_ioports(void);
+
+static struct fs_uart_platform_info mpc875_uart_pdata[] = {
+	[fsid_smc1_uart] = {
+		.brg		= 1,
+ 		.fs_no 		= fsid_smc1_uart,
+ 		.init_ioports	= setup_smc1_ioports,
+		.tx_num_fifo	= 4,
+		.tx_buf_size	= 32,
+		.rx_num_fifo	= 4,
+		.rx_buf_size	= 32,
+ 	},
+};
+
+static struct fs_mii_bus_info fec_mii_bus_info = {
+	.method = fsmii_fec,
+	.id = 0,
+};
+
+static struct fs_platform_info mpc8xx_fec_pdata[] = {
+	{
+		.rx_ring = 128,
+		.tx_ring = 16,
+		.rx_copybreak = 240,
+
+		.use_napi = 1,
+		.napi_weight = 17,
+
+		.phy_addr = 0,
+		.phy_irq = SIU_IRQ7,
+
+		.bus_info = &fec_mii_bus_info,
+	},
+	{
+		.rx_ring = 128,
+		.tx_ring = 16,
+		.rx_copybreak = 240,
+
+		.use_napi = 1,
+		.napi_weight = 17,
+
+		.phy_addr = 1,
+		.phy_irq = SIU_IRQ7,
+
+		.bus_info = &fec_mii_bus_info,
+	}
+};
+
+void __init board_init(void)
+{
+	volatile cpm8xx_t *cp = cpmp;
+
+#ifdef CONFIG_SERIAL_CPM_SMC1
+	cp->cp_simode &= ~(0xe0000000 >> 17);	/* brg1 */
+        cp->cp_smc[0].smc_smcm |= (SMCM_RX | SMCM_TX);
+        cp->cp_smc[0].smc_smcmr &= ~(SMCMR_REN | SMCMR_TEN);
+#else
+	cp->cp_smc[0].smc_smcmr = 0;
+	cp->cp_smc[0].smc_smce = 0;
+#endif
+
+}
+
+static void setup_fec1_ioports(void)
+{
+	immap_t *immap = (immap_t *) IMAP_ADDR;
+
+	/* configure FEC1 pins  */
+	setbits16(&immap->im_ioport.iop_papar, 0xf830);
+	setbits16(&immap->im_ioport.iop_padir, 0x0830);
+	clrbits16(&immap->im_ioport.iop_padir, 0xf000);
+	setbits32(&immap->im_cpm.cp_pbpar, 0x00001001);
+
+	clrbits32(&immap->im_cpm.cp_pbdir, 0x00001001);
+	setbits16(&immap->im_ioport.iop_pcpar, 0x000c);
+	clrbits16(&immap->im_ioport.iop_pcdir, 0x000c);
+	setbits32(&immap->im_cpm.cp_pepar, 0x00000003);
+
+	setbits32(&immap->im_cpm.cp_pedir, 0x00000003);
+	clrbits32(&immap->im_cpm.cp_peso, 0x00000003);
+	clrbits32(&immap->im_cpm.cp_cptr, 0x00000100);
+}
+
+static void setup_fec2_ioports(void)
+{
+	immap_t *immap = (immap_t *) IMAP_ADDR;
+
+	/* configure FEC2 pins */
+	setbits32(&immap->im_cpm.cp_pepar, 0x0003fffc);
+	setbits32(&immap->im_cpm.cp_pedir, 0x0003fffc);
+	setbits32(&immap->im_cpm.cp_peso, 0x00037800);
+	clrbits32(&immap->im_cpm.cp_peso, 0x000087fc);
+	clrbits32(&immap->im_cpm.cp_cptr, 0x00000080);
+}
+
+static void adder87x_fixup_enet_pdata(struct platform_device *pdev, int fs_no)
+{
+	struct fs_platform_info *fpi = pdev->dev.platform_data;
+
+	volatile cpm8xx_t *cp;
+	bd_t *bd = (bd_t *) __res;
+	char *e;
+	int i;
+
+	/* Get pointer to Communication Processor */
+	cp = cpmp;
+	switch (fs_no) {
+	case fsid_fec1:
+		fpi = &mpc8xx_fec_pdata[0];
+		fpi->init_ioports = &setup_fec1_ioports;
+		break;
+	case fsid_fec2:
+		fpi = &mpc8xx_fec_pdata[1];
+		fpi->init_ioports = &setup_fec2_ioports;
+		break;
+	default:
+    	        printk(KERN_WARNING"Device %s is not supported!\n", pdev->name);
+	        return;
+	}
+
+	pdev->dev.platform_data = fpi;
+	fpi->fs_no = fs_no;
+
+	e = (unsigned char *)&bd->bi_enetaddr;
+	for (i = 0; i < 6; i++)
+		fpi->macaddr[i] = *e++;
+
+	fpi->macaddr[5 - pdev->id]++;
+
+}
+
+static void adder87x_fixup_fec_enet_pdata(struct platform_device *pdev,
+					   int idx)
+{
+	/* This is for FEC devices only */
+	if (!pdev || !pdev->name || (!strstr(pdev->name, "fsl-cpm-fec"))){
+		return;
+	}
+	adder87x_fixup_enet_pdata(pdev, fsid_fec1 + pdev->id - 1);
+}
+
+static void setup_smc1_ioports(void)
+{
+        immap_t *immap = (immap_t *) IMAP_ADDR;
+        unsigned int iobits = 0x000000c0;
+
+        setbits32(&immap->im_cpm.cp_pbpar, iobits);
+        clrbits32(&immap->im_cpm.cp_pbdir, iobits);
+        clrbits16(&immap->im_cpm.cp_pbodr, iobits);
+}
+
+
+static void __init adder87x_fixup_uart_pdata(struct platform_device *pdev,
+                                              int idx)
+{
+	bd_t *bd = (bd_t *) __res;
+	struct fs_uart_platform_info *pinfo;
+	int num = ARRAY_SIZE(mpc875_uart_pdata);
+
+	int id = fs_uart_id_smc2fsid(idx);
+
+	/* no need to alter anything if console */
+	if ((id <= num) && (!pdev->dev.platform_data)) {
+		pinfo = &mpc875_uart_pdata[id];
+		pinfo->uart_clk = bd->bi_intfreq;
+		pdev->dev.platform_data = pinfo;
+	}
+}
+
+static int adder87x_platform_notify(struct device *dev)
+{
+
+	static const struct platform_notify_dev_map dev_map[] = {
+		{
+			.bus_id = "fsl-cpm-fec",
+			.rtn = adder87x_fixup_fec_enet_pdata,
+		},
+		{
+			.bus_id = "fsl-cpm-smc:uart",
+			.rtn = adder87x_fixup_uart_pdata
+		},
+		{
+			.bus_id = NULL
+		}
+	};
+
+	platform_notify_map(dev_map,dev);
+
+	return 0;
+}
+
+int __init adder87x_init(void)
+{
+	printk(KERN_NOTICE "adder87x: Init\n");
+
+	platform_notify = adder87x_platform_notify;
+
+	ppc_sys_device_initfunc();
+	ppc_sys_device_disable_all();
+
+	ppc_sys_device_enable(MPC8xx_CPM_FEC1);
+	ppc_sys_device_enable(MPC8xx_CPM_FEC2);
+
+#ifdef CONFIG_SERIAL_CPM_SMC1
+	ppc_sys_device_enable(MPC8xx_CPM_SMC1);
+	ppc_sys_device_setfunc(MPC8xx_CPM_SMC1, PPC_SYS_FUNC_UART);
+#endif
+
+	return 0;
+}
+
+arch_initcall(adder87x_init);
+
+/*
+   To prevent confusion, console selection is gross:
+   by 0 assumed SMC1 and by 1 assumed SMC2
+ */
+struct platform_device* early_uart_get_pdev(int index)
+{
+	bd_t *bd = (bd_t *) __res;
+	struct fs_uart_platform_info *pinfo;
+
+	struct platform_device* pdev = NULL;
+	if(index) { /*assume SMC2 here*/
+		pdev = &ppc_sys_platform_devices[MPC8xx_CPM_SMC2];
+		pinfo = &mpc875_uart_pdata[1];
+	} else { /*over SMC1*/
+		pdev = &ppc_sys_platform_devices[MPC8xx_CPM_SMC1];
+		pinfo = &mpc875_uart_pdata[0];
+	}
+
+	pinfo->uart_clk = bd->bi_intfreq;
+	pdev->dev.platform_data = pinfo;
+	ppc_sys_fixup_mem_resource(pdev, IMAP_ADDR);
+	return NULL;
+}
+
+
diff --git a/include/asm-ppc/mpc8xx.h b/include/asm-ppc/mpc8xx.h
--- a/include/asm-ppc/mpc8xx.h
+++ b/include/asm-ppc/mpc8xx.h
@@ -67,6 +67,10 @@
 #include <platforms/mpc885ads.h>
 #endif
 
+#if defined(CONFIG_ADDER87X)
+#include <platforms/adder87x.h>
+#endif
+
 /* Currently, all 8xx boards that support a processor to PCI/ISA bridge
  * use the same memory map.
  */
