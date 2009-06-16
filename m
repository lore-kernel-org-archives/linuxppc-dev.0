Return-Path: <smaclennan@pikatech.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 4799DB7147
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 17 Jun 2009 01:24:45 +1000 (EST)
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 27D0FDDD1B
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jun 2009 01:24:39 +1000 (EST)
Date: Tue, 16 Jun 2009 11:24:35 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>, Josh Boyer
	<jwboyer@linux.vnet.ibm.com>
Subject: [PATCH] powerpc: Update Warp defconfig
Message-ID: <20090616112435.20f7b3d9@lappy.seanm.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I forgot to include the defconfig in the last set of patches. So you
don't get to use the shiny new LEDS driver on the warp unless you turn
it on.

Enabling hotplug is also very important since we have moved to udev on
the warp.

Like most defconfig patches, most of the changes are just the normal
kernel changes, not warp specific.

If it is too early, and we want to hold off until say rc4 with
defconfigs I have no problem with that. I have tried to outline all the
changes we specifically made. If anybody sees any bad choices with
options, let me know!

Cheers,
   Sean

* Enable GPIO LEDS
* Enable LED triggers
* Move to slub
* Enable hotplug
* Enable timestamps on printks
* Enable UBIFS

Signed-off-by: Sean MacLennan <smaclennan@pikatech.com>
---
diff --git a/arch/powerpc/configs/44x/warp_defconfig b/arch/powerpc/configs/44x/warp_defconfig
index 3b77f09..787635f 100644
--- a/arch/powerpc/configs/44x/warp_defconfig
+++ b/arch/powerpc/configs/44x/warp_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.29-rc2
-# Fri Jan 23 07:57:16 2009
+# Linux kernel version: 2.6.30
+# Tue Jun  9 23:35:36 2009
 #
 # CONFIG_PPC64 is not set
 
@@ -41,6 +41,7 @@ CONFIG_ARCH_HAS_ILOG2_U32=y
 CONFIG_GENERIC_HWEIGHT=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
 CONFIG_GENERIC_FIND_NEXT_BIT=y
+CONFIG_GENERIC_GPIO=y
 # CONFIG_ARCH_NO_VIRT_TO_BUS is not set
 CONFIG_PPC=y
 CONFIG_EARLY_PRINTK=y
@@ -53,10 +54,12 @@ CONFIG_PPC_UDBG_16550=y
 # CONFIG_GENERIC_TBSYNC is not set
 CONFIG_AUDIT_ARCH=y
 CONFIG_GENERIC_BUG=y
+CONFIG_DTC=y
 # CONFIG_DEFAULT_UIMAGE is not set
 CONFIG_PPC_DCR_NATIVE=y
 # CONFIG_PPC_DCR_MMIO is not set
 CONFIG_PPC_DCR=y
+CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
 
 #
@@ -74,7 +77,17 @@ CONFIG_SYSVIPC_SYSCTL=y
 # CONFIG_BSD_PROCESS_ACCT is not set
 # CONFIG_TASKSTATS is not set
 # CONFIG_AUDIT is not set
-# CONFIG_IKCONFIG is not set
+
+#
+# RCU Subsystem
+#
+CONFIG_CLASSIC_RCU=y
+# CONFIG_TREE_RCU is not set
+# CONFIG_PREEMPT_RCU is not set
+# CONFIG_TREE_RCU_TRACE is not set
+# CONFIG_PREEMPT_RCU_TRACE is not set
+CONFIG_IKCONFIG=y
+CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_GROUP_SCHED=y
 CONFIG_FAIR_GROUP_SCHED=y
@@ -82,27 +95,29 @@ CONFIG_FAIR_GROUP_SCHED=y
 CONFIG_USER_SCHED=y
 # CONFIG_CGROUP_SCHED is not set
 # CONFIG_CGROUPS is not set
-CONFIG_SYSFS_DEPRECATED=y
-CONFIG_SYSFS_DEPRECATED_V2=y
+# CONFIG_SYSFS_DEPRECATED_V2 is not set
 # CONFIG_RELAY is not set
 # CONFIG_NAMESPACES is not set
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_INITRAMFS_SOURCE=""
+CONFIG_RD_GZIP=y
+# CONFIG_RD_BZIP2 is not set
+# CONFIG_RD_LZMA is not set
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_SYSCTL=y
+CONFIG_ANON_INODES=y
 CONFIG_EMBEDDED=y
 CONFIG_SYSCTL_SYSCALL=y
 CONFIG_KALLSYMS=y
 # CONFIG_KALLSYMS_ALL is not set
 # CONFIG_KALLSYMS_EXTRA_PASS is not set
-# CONFIG_HOTPLUG is not set
+# CONFIG_STRIP_ASM_SYMS is not set
+CONFIG_HOTPLUG=y
 CONFIG_PRINTK=y
 CONFIG_BUG=y
 CONFIG_ELF_CORE=y
-CONFIG_COMPAT_BRK=y
 CONFIG_BASE_FULL=y
 CONFIG_FUTEX=y
-CONFIG_ANON_INODES=y
 CONFIG_EPOLL=y
 CONFIG_SIGNALFD=y
 CONFIG_TIMERFD=y
@@ -110,10 +125,13 @@ CONFIG_EVENTFD=y
 CONFIG_SHMEM=y
 CONFIG_AIO=y
 CONFIG_VM_EVENT_COUNTERS=y
-CONFIG_SLAB=y
-# CONFIG_SLUB is not set
+CONFIG_SLUB_DEBUG=y
+CONFIG_COMPAT_BRK=y
+# CONFIG_SLAB is not set
+CONFIG_SLUB=y
 # CONFIG_SLOB is not set
 # CONFIG_PROFILING is not set
+# CONFIG_MARKERS is not set
 CONFIG_HAVE_OPROFILE=y
 # CONFIG_KPROBES is not set
 CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
@@ -121,6 +139,7 @@ CONFIG_HAVE_IOREMAP_PROT=y
 CONFIG_HAVE_KPROBES=y
 CONFIG_HAVE_KRETPROBES=y
 CONFIG_HAVE_ARCH_TRACEHOOK=y
+# CONFIG_SLOW_WORK is not set
 # CONFIG_HAVE_GENERIC_DMA_COHERENT is not set
 CONFIG_SLABINFO=y
 CONFIG_RT_MUTEXES=y
@@ -133,7 +152,6 @@ CONFIG_MODULE_UNLOAD=y
 # CONFIG_MODULE_SRCVERSION_ALL is not set
 CONFIG_BLOCK=y
 # CONFIG_LBD is not set
-# CONFIG_BLK_DEV_IO_TRACE is not set
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_BLK_DEV_INTEGRITY is not set
 
@@ -149,11 +167,6 @@ CONFIG_DEFAULT_AS=y
 # CONFIG_DEFAULT_CFQ is not set
 # CONFIG_DEFAULT_NOOP is not set
 CONFIG_DEFAULT_IOSCHED="anticipatory"
-CONFIG_CLASSIC_RCU=y
-# CONFIG_TREE_RCU is not set
-# CONFIG_PREEMPT_RCU is not set
-# CONFIG_TREE_RCU_TRACE is not set
-# CONFIG_PREEMPT_RCU_TRACE is not set
 # CONFIG_FREEZER is not set
 
 #
@@ -173,10 +186,11 @@ CONFIG_WARP=y
 # CONFIG_ARCHES is not set
 # CONFIG_CANYONLANDS is not set
 # CONFIG_GLACIER is not set
+# CONFIG_REDWOOD is not set
 # CONFIG_YOSEMITE is not set
 # CONFIG_XILINX_VIRTEX440_GENERIC_BOARD is not set
 # CONFIG_PPC44x_SIMPLE is not set
-# CONFIG_PPC4xx_GPIO is not set
+CONFIG_PPC4xx_GPIO=y
 CONFIG_440EP=y
 CONFIG_IBM440EP_ERR42=y
 # CONFIG_IPIC is not set
@@ -235,9 +249,13 @@ CONFIG_ZONE_DMA_FLAG=1
 CONFIG_BOUNCE=y
 CONFIG_VIRT_TO_BUS=y
 CONFIG_UNEVICTABLE_LRU=y
+CONFIG_HAVE_MLOCK=y
+CONFIG_HAVE_MLOCKED_PAGE_BIT=y
+CONFIG_STDBINUTILS=y
 CONFIG_PPC_4K_PAGES=y
 # CONFIG_PPC_16K_PAGES is not set
 # CONFIG_PPC_64K_PAGES is not set
+# CONFIG_PPC_256K_PAGES is not set
 CONFIG_FORCE_MAX_ZONEORDER=11
 CONFIG_PROC_DEVICETREE=y
 CONFIG_CMDLINE_BOOL=y
@@ -256,6 +274,7 @@ CONFIG_PPC_PCI_CHOICE=y
 # CONFIG_PCI_DOMAINS is not set
 # CONFIG_PCI_SYSCALL is not set
 # CONFIG_ARCH_SUPPORTS_MSI is not set
+# CONFIG_PCCARD is not set
 # CONFIG_HAS_RAPIDIO is not set
 
 #
@@ -271,14 +290,12 @@ CONFIG_PAGE_OFFSET=0xc0000000
 CONFIG_KERNEL_START=0xc0000000
 CONFIG_PHYSICAL_START=0x00000000
 CONFIG_TASK_SIZE=0xc0000000
-CONFIG_CONSISTENT_START=0xff100000
 CONFIG_CONSISTENT_SIZE=0x00200000
 CONFIG_NET=y
 
 #
 # Networking options
 #
-CONFIG_COMPAT_NET_DEV_OPS=y
 CONFIG_PACKET=y
 # CONFIG_PACKET_MMAP is not set
 CONFIG_UNIX=y
@@ -353,6 +370,7 @@ CONFIG_VLAN_8021Q=y
 # CONFIG_LAPB is not set
 # CONFIG_ECONET is not set
 # CONFIG_WAN_ROUTER is not set
+# CONFIG_PHONET is not set
 # CONFIG_NET_SCHED is not set
 # CONFIG_DCB is not set
 
@@ -365,7 +383,6 @@ CONFIG_VLAN_8021Q=y
 # CONFIG_IRDA is not set
 # CONFIG_BT is not set
 # CONFIG_AF_RXRPC is not set
-# CONFIG_PHONET is not set
 # CONFIG_WIRELESS is not set
 # CONFIG_WIMAX is not set
 # CONFIG_RFKILL is not set
@@ -378,8 +395,12 @@ CONFIG_VLAN_8021Q=y
 #
 # Generic Driver Options
 #
+CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 # CONFIG_STANDALONE is not set
 CONFIG_PREVENT_FIRMWARE_BUILD=y
+CONFIG_FW_LOADER=y
+# CONFIG_FIRMWARE_IN_KERNEL is not set
+CONFIG_EXTRA_FIRMWARE=""
 # CONFIG_DEBUG_DRIVER is not set
 # CONFIG_DEBUG_DEVRES is not set
 # CONFIG_SYS_HYPERVISOR is not set
@@ -471,13 +492,21 @@ CONFIG_MTD_NAND_NDFC=y
 # LPDDR flash memory drivers
 #
 # CONFIG_MTD_LPDDR is not set
-# CONFIG_MTD_QINFO_PROBE is not set
 
 #
 # UBI - Unsorted block images
 #
-# CONFIG_MTD_UBI is not set
+CONFIG_MTD_UBI=y
+CONFIG_MTD_UBI_WL_THRESHOLD=4096
+CONFIG_MTD_UBI_BEB_RESERVE=1
+# CONFIG_MTD_UBI_GLUEBI is not set
+
+#
+# UBI debugging options
+#
+# CONFIG_MTD_UBI_DEBUG is not set
 CONFIG_OF_DEVICE=y
+CONFIG_OF_GPIO=y
 CONFIG_OF_I2C=y
 # CONFIG_PARPORT is not set
 CONFIG_BLK_DEV=y
@@ -495,10 +524,17 @@ CONFIG_BLK_DEV_RAM_SIZE=4096
 # CONFIG_XILINX_SYSACE is not set
 # CONFIG_BLK_DEV_HD is not set
 CONFIG_MISC_DEVICES=y
-# CONFIG_EEPROM_93CX6 is not set
 # CONFIG_ICS932S401 is not set
 # CONFIG_ENCLOSURE_SERVICES is not set
+# CONFIG_ISL29003 is not set
 # CONFIG_C2PORT is not set
+
+#
+# EEPROM support
+#
+CONFIG_EEPROM_AT24=y
+# CONFIG_EEPROM_LEGACY is not set
+# CONFIG_EEPROM_93CX6 is not set
 CONFIG_HAVE_IDE=y
 # CONFIG_IDE is not set
 
@@ -529,7 +565,7 @@ CONFIG_BLK_DEV_SD=y
 # CONFIG_SCSI_CONSTANTS is not set
 # CONFIG_SCSI_LOGGING is not set
 # CONFIG_SCSI_SCAN_ASYNC is not set
-CONFIG_SCSI_WAIT_SCAN=m
+# CONFIG_SCSI_WAIT_SCAN is not set
 
 #
 # SCSI Transports
@@ -541,10 +577,12 @@ CONFIG_SCSI_SPI_ATTRS=y
 # CONFIG_SCSI_SRP_ATTRS is not set
 # CONFIG_SCSI_LOWLEVEL is not set
 # CONFIG_SCSI_DH is not set
+# CONFIG_SCSI_OSD_INITIATOR is not set
 # CONFIG_ATA is not set
 # CONFIG_MD is not set
 # CONFIG_MACINTOSH_DRIVERS is not set
 CONFIG_NETDEVICES=y
+CONFIG_COMPAT_NET_DEV_OPS=y
 # CONFIG_DUMMY is not set
 # CONFIG_BONDING is not set
 # CONFIG_MACVLAN is not set
@@ -554,6 +592,8 @@ CONFIG_NETDEVICES=y
 # CONFIG_PHYLIB is not set
 CONFIG_NET_ETHERNET=y
 CONFIG_MII=y
+# CONFIG_ETHOC is not set
+# CONFIG_DNET is not set
 CONFIG_IBM_NEW_EMAC=y
 CONFIG_IBM_NEW_EMAC_RXB=128
 CONFIG_IBM_NEW_EMAC_TXB=64
@@ -577,7 +617,6 @@ CONFIG_IBM_NEW_EMAC_ZMII=y
 #
 # CONFIG_WLAN_PRE80211 is not set
 # CONFIG_WLAN_80211 is not set
-# CONFIG_IWLWIFI_LEDS is not set
 
 #
 # Enable WiMAX (Networking options) to see the WiMAX drivers
@@ -646,6 +685,7 @@ CONFIG_LEGACY_PTY_COUNT=256
 # CONFIG_HVC_UDBG is not set
 # CONFIG_IPMI_HANDLER is not set
 CONFIG_HW_RANDOM=y
+# CONFIG_HW_RANDOM_TIMERIOMEM is not set
 # CONFIG_NVRAM is not set
 # CONFIG_GEN_RTC is not set
 # CONFIG_R3964 is not set
@@ -663,6 +703,7 @@ CONFIG_I2C_HELPER_AUTO=y
 #
 # I2C system bus drivers (mostly embedded / system-on-chip)
 #
+# CONFIG_I2C_GPIO is not set
 CONFIG_I2C_IBM_IIC=y
 # CONFIG_I2C_MPC is not set
 # CONFIG_I2C_OCORES is not set
@@ -685,12 +726,9 @@ CONFIG_I2C_IBM_IIC=y
 # Miscellaneous I2C Chip support
 #
 # CONFIG_DS1682 is not set
-CONFIG_EEPROM_AT24=y
-CONFIG_EEPROM_LEGACY=y
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
-# CONFIG_SENSORS_PCF8591 is not set
 # CONFIG_SENSORS_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
@@ -699,7 +737,30 @@ CONFIG_EEPROM_LEGACY=y
 # CONFIG_I2C_DEBUG_CHIP is not set
 # CONFIG_SPI is not set
 CONFIG_ARCH_WANT_OPTIONAL_GPIOLIB=y
-# CONFIG_GPIOLIB is not set
+CONFIG_ARCH_REQUIRE_GPIOLIB=y
+CONFIG_GPIOLIB=y
+# CONFIG_DEBUG_GPIO is not set
+CONFIG_GPIO_SYSFS=y
+
+#
+# Memory mapped GPIO expanders:
+#
+# CONFIG_GPIO_XILINX is not set
+
+#
+# I2C GPIO expanders:
+#
+# CONFIG_GPIO_MAX732X is not set
+# CONFIG_GPIO_PCA953X is not set
+# CONFIG_GPIO_PCF857X is not set
+
+#
+# PCI GPIO expanders:
+#
+
+#
+# SPI GPIO expanders:
+#
 # CONFIG_W1 is not set
 # CONFIG_POWER_SUPPLY is not set
 CONFIG_HWMON=y
@@ -721,6 +782,7 @@ CONFIG_SENSORS_AD7414=y
 # CONFIG_SENSORS_F71805F is not set
 # CONFIG_SENSORS_F71882FG is not set
 # CONFIG_SENSORS_F75375S is not set
+# CONFIG_SENSORS_G760A is not set
 # CONFIG_SENSORS_GL518SM is not set
 # CONFIG_SENSORS_GL520SM is not set
 # CONFIG_SENSORS_IT87 is not set
@@ -735,11 +797,15 @@ CONFIG_SENSORS_AD7414=y
 # CONFIG_SENSORS_LM90 is not set
 # CONFIG_SENSORS_LM92 is not set
 # CONFIG_SENSORS_LM93 is not set
+# CONFIG_SENSORS_LTC4215 is not set
 # CONFIG_SENSORS_LTC4245 is not set
+# CONFIG_SENSORS_LM95241 is not set
 # CONFIG_SENSORS_MAX1619 is not set
 # CONFIG_SENSORS_MAX6650 is not set
 # CONFIG_SENSORS_PC87360 is not set
 # CONFIG_SENSORS_PC87427 is not set
+# CONFIG_SENSORS_PCF8591 is not set
+# CONFIG_SENSORS_SHT15 is not set
 # CONFIG_SENSORS_DME1737 is not set
 # CONFIG_SENSORS_SMSC47M1 is not set
 # CONFIG_SENSORS_SMSC47M192 is not set
@@ -785,6 +851,7 @@ CONFIG_SSB_POSSIBLE=y
 # CONFIG_MFD_CORE is not set
 # CONFIG_MFD_SM501 is not set
 # CONFIG_HTC_PASIC3 is not set
+# CONFIG_TPS65010 is not set
 # CONFIG_TWL4030_CORE is not set
 # CONFIG_MFD_TMIO is not set
 # CONFIG_PMIC_DA903X is not set
@@ -870,11 +937,11 @@ CONFIG_USB_OHCI_LITTLE_ENDIAN=y
 # CONFIG_USB_TMC is not set
 
 #
-# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may also be needed;
+# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
 #
 
 #
-# see USB_STORAGE Help for more information
+# also be needed; see USB_STORAGE Help for more info
 #
 CONFIG_USB_STORAGE=y
 # CONFIG_USB_STORAGE_DEBUG is not set
@@ -915,7 +982,6 @@ CONFIG_USB_STORAGE=y
 # CONFIG_USB_LED is not set
 # CONFIG_USB_CYPRESS_CY7C63 is not set
 # CONFIG_USB_CYTHERM is not set
-# CONFIG_USB_PHIDGET is not set
 # CONFIG_USB_IDMOUSE is not set
 # CONFIG_USB_FTDI_ELAN is not set
 # CONFIG_USB_APPLEDISPLAY is not set
@@ -929,6 +995,8 @@ CONFIG_USB_STORAGE=y
 #
 # OTG and related infrastructure
 #
+# CONFIG_USB_GPIO_VBUS is not set
+# CONFIG_NOP_USB_XCEIV is not set
 CONFIG_MMC=y
 # CONFIG_MMC_DEBUG is not set
 # CONFIG_MMC_UNSAFE_RESUME is not set
@@ -946,6 +1014,7 @@ CONFIG_MMC_BLOCK_BOUNCE=y
 #
 # CONFIG_MMC_SDHCI is not set
 # CONFIG_MMC_WBSD is not set
+CONFIG_MMC_PIKASD=y
 # CONFIG_MEMSTICK is not set
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
@@ -953,16 +1022,31 @@ CONFIG_LEDS_CLASS=y
 #
 # LED drivers
 #
+CONFIG_LEDS_GPIO=y
+# CONFIG_LEDS_GPIO_PLATFORM is not set
+CONFIG_LEDS_GPIO_OF=y
+# CONFIG_LEDS_LP5521 is not set
 # CONFIG_LEDS_PCA955X is not set
+# CONFIG_LEDS_BD2802 is not set
 
 #
 # LED Triggers
 #
-# CONFIG_LEDS_TRIGGERS is not set
+CONFIG_LEDS_TRIGGERS=y
+# CONFIG_LEDS_TRIGGER_TIMER is not set
+# CONFIG_LEDS_TRIGGER_HEARTBEAT is not set
+# CONFIG_LEDS_TRIGGER_BACKLIGHT is not set
+# CONFIG_LEDS_TRIGGER_GPIO is not set
+CONFIG_LEDS_TRIGGER_DEFAULT_ON=y
+
+#
+# iptables trigger is under Netfilter config (LED target)
+#
 # CONFIG_ACCESSIBILITY is not set
 # CONFIG_EDAC is not set
 # CONFIG_RTC_CLASS is not set
 # CONFIG_DMADEVICES is not set
+# CONFIG_AUXDISPLAY is not set
 # CONFIG_UIO is not set
 # CONFIG_STAGING is not set
 
@@ -973,6 +1057,7 @@ CONFIG_EXT2_FS=y
 # CONFIG_EXT2_FS_XATTR is not set
 # CONFIG_EXT2_FS_XIP is not set
 CONFIG_EXT3_FS=y
+# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
 # CONFIG_EXT3_FS_XATTR is not set
 # CONFIG_EXT4_FS is not set
 CONFIG_JBD=y
@@ -993,6 +1078,11 @@ CONFIG_INOTIFY_USER=y
 # CONFIG_FUSE_FS is not set
 
 #
+# Caches
+#
+# CONFIG_FSCACHE is not set
+
+#
 # CD-ROM/DVD Filesystems
 #
 # CONFIG_ISO9660_FS is not set
@@ -1039,6 +1129,12 @@ CONFIG_JFFS2_ZLIB=y
 # CONFIG_JFFS2_LZO is not set
 CONFIG_JFFS2_RTIME=y
 # CONFIG_JFFS2_RUBIN is not set
+CONFIG_UBIFS_FS=y
+# CONFIG_UBIFS_FS_XATTR is not set
+# CONFIG_UBIFS_FS_ADVANCED_COMPR is not set
+CONFIG_UBIFS_FS_LZO=y
+CONFIG_UBIFS_FS_ZLIB=y
+# CONFIG_UBIFS_FS_DEBUG is not set
 CONFIG_CRAMFS=y
 # CONFIG_SQUASHFS is not set
 # CONFIG_VXFS_FS is not set
@@ -1049,6 +1145,7 @@ CONFIG_CRAMFS=y
 # CONFIG_ROMFS_FS is not set
 # CONFIG_SYSV_FS is not set
 # CONFIG_UFS_FS is not set
+# CONFIG_NILFS2_FS is not set
 CONFIG_NETWORK_FILESYSTEMS=y
 CONFIG_NFS_FS=y
 CONFIG_NFS_V3=y
@@ -1060,7 +1157,6 @@ CONFIG_LOCKD=y
 CONFIG_LOCKD_V4=y
 CONFIG_NFS_COMMON=y
 CONFIG_SUNRPC=y
-# CONFIG_SUNRPC_REGISTER_V4 is not set
 # CONFIG_RPCSEC_GSS_KRB5 is not set
 # CONFIG_RPCSEC_GSS_SPKM3 is not set
 # CONFIG_SMB_FS is not set
@@ -1115,6 +1211,7 @@ CONFIG_NLS_ISO8859_15=y
 # CONFIG_NLS_KOI8_U is not set
 CONFIG_NLS_UTF8=y
 # CONFIG_DLM is not set
+# CONFIG_BINARY_PRINTF is not set
 
 #
 # Library routines
@@ -1122,7 +1219,7 @@ CONFIG_NLS_UTF8=y
 CONFIG_BITREVERSE=y
 CONFIG_GENERIC_FIND_LAST_BIT=y
 CONFIG_CRC_CCITT=y
-# CONFIG_CRC16 is not set
+CONFIG_CRC16=y
 CONFIG_CRC_T10DIF=y
 # CONFIG_CRC_ITU_T is not set
 CONFIG_CRC32=y
@@ -1130,16 +1227,19 @@ CONFIG_CRC32=y
 # CONFIG_LIBCRC32C is not set
 CONFIG_ZLIB_INFLATE=y
 CONFIG_ZLIB_DEFLATE=y
-CONFIG_PLIST=y
+CONFIG_LZO_COMPRESS=y
+CONFIG_LZO_DECOMPRESS=y
+CONFIG_DECOMPRESS_GZIP=y
 CONFIG_HAS_IOMEM=y
 CONFIG_HAS_IOPORT=y
 CONFIG_HAS_DMA=y
 CONFIG_HAVE_LMB=y
+CONFIG_NLATTR=y
 
 #
 # Kernel hacking
 #
-# CONFIG_PRINTK_TIME is not set
+CONFIG_PRINTK_TIME=y
 CONFIG_ENABLE_WARN_DEPRECATED=y
 CONFIG_ENABLE_MUST_CHECK=y
 CONFIG_FRAME_WARN=1024
@@ -1152,11 +1252,15 @@ CONFIG_DEBUG_KERNEL=y
 CONFIG_DETECT_SOFTLOCKUP=y
 # CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
 CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
+CONFIG_DETECT_HUNG_TASK=y
+# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
+CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE=0
 # CONFIG_SCHED_DEBUG is not set
 # CONFIG_SCHEDSTATS is not set
 # CONFIG_TIMER_STATS is not set
 # CONFIG_DEBUG_OBJECTS is not set
-# CONFIG_DEBUG_SLAB is not set
+# CONFIG_SLUB_DEBUG_ON is not set
+# CONFIG_SLUB_STATS is not set
 # CONFIG_DEBUG_RT_MUTEXES is not set
 # CONFIG_RT_MUTEX_TESTER is not set
 # CONFIG_DEBUG_SPINLOCK is not set
@@ -1180,9 +1284,12 @@ CONFIG_DEBUG_INFO=y
 # CONFIG_FAULT_INJECTION is not set
 # CONFIG_LATENCYTOP is not set
 CONFIG_SYSCTL_SYSCALL_CHECK=y
+# CONFIG_DEBUG_PAGEALLOC is not set
 CONFIG_HAVE_FUNCTION_TRACER=y
+CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
 CONFIG_HAVE_DYNAMIC_FTRACE=y
 CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
+CONFIG_TRACING_SUPPORT=y
 
 #
 # Tracers
@@ -1190,24 +1297,27 @@ CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
 # CONFIG_FUNCTION_TRACER is not set
 # CONFIG_SCHED_TRACER is not set
 # CONFIG_CONTEXT_SWITCH_TRACER is not set
+# CONFIG_EVENT_TRACER is not set
 # CONFIG_BOOT_TRACER is not set
 # CONFIG_TRACE_BRANCH_PROFILING is not set
 # CONFIG_STACK_TRACER is not set
-# CONFIG_DYNAMIC_PRINTK_DEBUG is not set
+# CONFIG_KMEMTRACE is not set
+# CONFIG_WORKQUEUE_TRACER is not set
+# CONFIG_BLK_DEV_IO_TRACE is not set
+# CONFIG_DYNAMIC_DEBUG is not set
 # CONFIG_SAMPLES is not set
 CONFIG_HAVE_ARCH_KGDB=y
 # CONFIG_KGDB is not set
 CONFIG_PRINT_STACK_DEPTH=64
 # CONFIG_DEBUG_STACKOVERFLOW is not set
 # CONFIG_DEBUG_STACK_USAGE is not set
-# CONFIG_DEBUG_PAGEALLOC is not set
 # CONFIG_CODE_PATCHING_SELFTEST is not set
 # CONFIG_FTR_FIXUP_SELFTEST is not set
 # CONFIG_MSI_BITMAP_SELFTEST is not set
 # CONFIG_XMON is not set
 CONFIG_IRQSTACKS=y
 # CONFIG_VIRQ_DEBUG is not set
-CONFIG_BDI_SWITCH=y
+# CONFIG_BDI_SWITCH is not set
 # CONFIG_PPC_EARLY_DEBUG is not set
 
 #
@@ -1223,6 +1333,8 @@ CONFIG_CRYPTO=y
 # Crypto core or helper
 #
 # CONFIG_CRYPTO_FIPS is not set
+CONFIG_CRYPTO_ALGAPI=y
+CONFIG_CRYPTO_ALGAPI2=y
 # CONFIG_CRYPTO_MANAGER is not set
 # CONFIG_CRYPTO_MANAGER2 is not set
 # CONFIG_CRYPTO_GF128MUL is not set
@@ -1294,13 +1406,15 @@ CONFIG_CRYPTO=y
 #
 # Compression
 #
-# CONFIG_CRYPTO_DEFLATE is not set
-# CONFIG_CRYPTO_LZO is not set
+CONFIG_CRYPTO_DEFLATE=y
+# CONFIG_CRYPTO_ZLIB is not set
+CONFIG_CRYPTO_LZO=y
 
 #
 # Random Number Generation
 #
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
 CONFIG_CRYPTO_HW=y
+# CONFIG_CRYPTO_DEV_PPC4XX is not set
 # CONFIG_PPC_CLOCK is not set
 # CONFIG_VIRTUALIZATION is not set
