Return-Path: <martyn.welch@gefanuc.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 53D92B750A
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  3 Jul 2009 00:18:48 +1000 (EST)
Received: from exprod5og103.obsmtp.com (exprod5og103.obsmtp.com [64.18.0.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1A909DDD0C
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Jul 2009 00:18:45 +1000 (EST)
From: Martyn Welch <martyn.welch@gefanuc.com>
Subject: [PATCH] powerpc/86xx: Update GE Fanuc sbc310 default configuration
To: galak@kernel.crashing.org
Date: Thu, 02 Jul 2009 15:18:44 +0100
Message-ID: <20090702141844.22370.87052.stgit@ES-J7S4D2J.amer.consind.ge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

General update of defconfig including the following notable changes:
 - Enable Highmem support.
 - Support for PCMCIA based daughter card.

Signed-off-by: Martyn Welch <martyn.welch@gefanuc.com>
---

 arch/powerpc/configs/86xx/gef_sbc310_defconfig |  213 +++++++++++++++++-------
 1 files changed, 154 insertions(+), 59 deletions(-)

diff --git a/arch/powerpc/configs/86xx/gef_sbc310_defconfig b/arch/powerpc/configs/86xx/gef_sbc310_defconfig
index a66910e..f2362e5 100644
--- a/arch/powerpc/configs/86xx/gef_sbc310_defconfig
+++ b/arch/powerpc/configs/86xx/gef_sbc310_defconfig
@@ -1,26 +1,28 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.30-rc3
-# Wed May 13 17:22:29 2009
+# Linux kernel version: 2.6.30
+# Thu Jul  2 14:10:12 2009
 #
 # CONFIG_PPC64 is not set
 
 #
 # Processor support
 #
-CONFIG_6xx=y
+CONFIG_PPC_BOOK3S_32=y
 # CONFIG_PPC_85xx is not set
 # CONFIG_PPC_8xx is not set
 # CONFIG_40x is not set
 # CONFIG_44x is not set
 # CONFIG_E200 is not set
 CONFIG_PPC_BOOK3S=y
+CONFIG_6xx=y
 CONFIG_PPC_FPU=y
 # CONFIG_PHYS_64BIT is not set
 CONFIG_ALTIVEC=y
 CONFIG_PPC_STD_MMU=y
 CONFIG_PPC_STD_MMU_32=y
 # CONFIG_PPC_MM_SLICES is not set
+CONFIG_PPC_HAVE_PMU_SUPPORT=y
 CONFIG_SMP=y
 CONFIG_NR_CPUS=2
 CONFIG_PPC32=y
@@ -32,6 +34,7 @@ CONFIG_GENERIC_TIME=y
 CONFIG_GENERIC_TIME_VSYSCALL=y
 CONFIG_GENERIC_CLOCKEVENTS=y
 CONFIG_GENERIC_HARDIRQS=y
+CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ=y
 # CONFIG_HAVE_SETUP_PER_CPU_AREA is not set
 CONFIG_IRQ_PER_CPU=y
 CONFIG_STACKTRACE_SUPPORT=y
@@ -41,7 +44,6 @@ CONFIG_RWSEM_XCHGADD_ALGORITHM=y
 CONFIG_GENERIC_LOCKBREAK=y
 CONFIG_ARCH_HAS_ILOG2_U32=y
 CONFIG_GENERIC_HWEIGHT=y
-CONFIG_GENERIC_CALIBRATE_DELAY=y
 CONFIG_GENERIC_FIND_NEXT_BIT=y
 CONFIG_GENERIC_GPIO=y
 # CONFIG_ARCH_NO_VIRT_TO_BUS is not set
@@ -56,11 +58,13 @@ CONFIG_PPC_UDBG_16550=y
 CONFIG_GENERIC_TBSYNC=y
 CONFIG_AUDIT_ARCH=y
 CONFIG_GENERIC_BUG=y
+CONFIG_DTC=y
 CONFIG_DEFAULT_UIMAGE=y
 # CONFIG_PPC_DCR_NATIVE is not set
 # CONFIG_PPC_DCR_MMIO is not set
 CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
+CONFIG_CONSTRUCTORS=y
 
 #
 # General setup
@@ -91,7 +95,11 @@ CONFIG_CLASSIC_RCU=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=14
-# CONFIG_GROUP_SCHED is not set
+CONFIG_GROUP_SCHED=y
+CONFIG_FAIR_GROUP_SCHED=y
+# CONFIG_RT_GROUP_SCHED is not set
+CONFIG_USER_SCHED=y
+# CONFIG_CGROUP_SCHED is not set
 # CONFIG_CGROUPS is not set
 CONFIG_SYSFS_DEPRECATED=y
 CONFIG_SYSFS_DEPRECATED_V2=y
@@ -109,7 +117,6 @@ CONFIG_EMBEDDED=y
 CONFIG_SYSCTL_SYSCALL=y
 CONFIG_KALLSYMS=y
 # CONFIG_KALLSYMS_EXTRA_PASS is not set
-# CONFIG_STRIP_ASM_SYMS is not set
 CONFIG_HOTPLUG=y
 CONFIG_PRINTK=y
 CONFIG_BUG=y
@@ -122,8 +129,15 @@ CONFIG_TIMERFD=y
 CONFIG_EVENTFD=y
 CONFIG_SHMEM=y
 CONFIG_AIO=y
+CONFIG_HAVE_PERF_COUNTERS=y
+
+#
+# Performance Counters
+#
+# CONFIG_PERF_COUNTERS is not set
 CONFIG_VM_EVENT_COUNTERS=y
 CONFIG_PCI_QUIRKS=y
+# CONFIG_STRIP_ASM_SYMS is not set
 CONFIG_COMPAT_BRK=y
 CONFIG_SLAB=y
 # CONFIG_SLUB is not set
@@ -138,6 +152,10 @@ CONFIG_HAVE_KPROBES=y
 CONFIG_HAVE_KRETPROBES=y
 CONFIG_HAVE_ARCH_TRACEHOOK=y
 CONFIG_USE_GENERIC_SMP_HELPERS=y
+
+#
+# GCOV-based kernel profiling
+#
 # CONFIG_SLOW_WORK is not set
 # CONFIG_HAVE_GENERIC_DMA_COHERENT is not set
 CONFIG_SLABINFO=y
@@ -151,7 +169,7 @@ CONFIG_MODULE_UNLOAD=y
 # CONFIG_MODULE_SRCVERSION_ALL is not set
 CONFIG_STOP_MACHINE=y
 CONFIG_BLOCK=y
-# CONFIG_LBD is not set
+CONFIG_LBDAF=y
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_BLK_DEV_INTEGRITY is not set
 
@@ -168,7 +186,6 @@ CONFIG_DEFAULT_CFQ=y
 # CONFIG_DEFAULT_NOOP is not set
 CONFIG_DEFAULT_IOSCHED="cfq"
 # CONFIG_FREEZER is not set
-CONFIG_PPC_MSI_BITMAP=y
 
 #
 # Platform support
@@ -212,7 +229,7 @@ CONFIG_MPIC=y
 #
 # Kernel options
 #
-# CONFIG_HIGHMEM is not set
+CONFIG_HIGHMEM=y
 CONFIG_TICK_ONESHOT=y
 # CONFIG_NO_HZ is not set
 CONFIG_HIGH_RES_TIMERS=y
@@ -231,6 +248,7 @@ CONFIG_BINFMT_ELF=y
 # CONFIG_HAVE_AOUT is not set
 CONFIG_BINFMT_MISC=y
 # CONFIG_IOMMU_HELPER is not set
+# CONFIG_SWIOTLB is not set
 CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
 CONFIG_ARCH_HAS_WALK_MEMORY=y
 CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
@@ -252,9 +270,9 @@ CONFIG_MIGRATION=y
 CONFIG_ZONE_DMA_FLAG=1
 CONFIG_BOUNCE=y
 CONFIG_VIRT_TO_BUS=y
-CONFIG_UNEVICTABLE_LRU=y
 CONFIG_HAVE_MLOCK=y
 CONFIG_HAVE_MLOCKED_PAGE_BIT=y
+CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
 CONFIG_PPC_4K_PAGES=y
 # CONFIG_PPC_16K_PAGES is not set
 # CONFIG_PPC_64K_PAGES is not set
@@ -281,13 +299,32 @@ CONFIG_PCI_DOMAINS=y
 CONFIG_PCI_SYSCALL=y
 CONFIG_PCIEPORTBUS=y
 CONFIG_PCIEAER=y
+# CONFIG_PCIE_ECRC is not set
+# CONFIG_PCIEAER_INJECT is not set
 # CONFIG_PCIEASPM is not set
 CONFIG_ARCH_SUPPORTS_MSI=y
-CONFIG_PCI_MSI=y
+# CONFIG_PCI_MSI is not set
 # CONFIG_PCI_LEGACY is not set
 # CONFIG_PCI_STUB is not set
 # CONFIG_PCI_IOV is not set
-# CONFIG_PCCARD is not set
+CONFIG_PCCARD=y
+# CONFIG_PCMCIA_DEBUG is not set
+CONFIG_PCMCIA=y
+# CONFIG_PCMCIA_LOAD_CIS is not set
+# CONFIG_PCMCIA_IOCTL is not set
+# CONFIG_CARDBUS is not set
+
+#
+# PC-card bridges
+#
+CONFIG_YENTA=y
+# CONFIG_YENTA_O2 is not set
+# CONFIG_YENTA_RICOH is not set
+CONFIG_YENTA_TI=y
+# CONFIG_YENTA_TOSHIBA is not set
+# CONFIG_PD6729 is not set
+# CONFIG_I82092 is not set
+CONFIG_PCCARD_NONSTATIC=y
 # CONFIG_HOTPLUG_PCI is not set
 # CONFIG_HAS_RAPIDIO is not set
 
@@ -393,6 +430,7 @@ CONFIG_IPV6_TUNNEL=m
 # CONFIG_ECONET is not set
 # CONFIG_WAN_ROUTER is not set
 # CONFIG_PHONET is not set
+# CONFIG_IEEE802154 is not set
 # CONFIG_NET_SCHED is not set
 # CONFIG_DCB is not set
 
@@ -421,7 +459,9 @@ CONFIG_FIB_RULES=y
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_STANDALONE=y
 CONFIG_PREVENT_FIRMWARE_BUILD=y
-# CONFIG_FW_LOADER is not set
+CONFIG_FW_LOADER=y
+CONFIG_FIRMWARE_IN_KERNEL=y
+CONFIG_EXTRA_FIRMWARE=""
 # CONFIG_SYS_HYPERVISOR is not set
 # CONFIG_CONNECTOR is not set
 CONFIG_MTD=y
@@ -511,6 +551,7 @@ CONFIG_MTD_PHYSMAP_OF=y
 CONFIG_OF_DEVICE=y
 CONFIG_OF_GPIO=y
 CONFIG_OF_I2C=y
+CONFIG_OF_MDIO=y
 # CONFIG_PARPORT is not set
 CONFIG_BLK_DEV=y
 # CONFIG_BLK_DEV_FD is not set
@@ -546,9 +587,60 @@ CONFIG_MISC_DEVICES=y
 #
 # CONFIG_EEPROM_AT24 is not set
 # CONFIG_EEPROM_LEGACY is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_EEPROM_93CX6 is not set
+# CONFIG_CB710_CORE is not set
 CONFIG_HAVE_IDE=y
-# CONFIG_IDE is not set
+CONFIG_IDE=y
+
+#
+# Please see Documentation/ide/ide.txt for help/info on IDE drives
+#
+# CONFIG_BLK_DEV_IDE_SATA is not set
+CONFIG_IDE_GD=y
+CONFIG_IDE_GD_ATA=y
+# CONFIG_IDE_GD_ATAPI is not set
+CONFIG_BLK_DEV_IDECS=y
+# CONFIG_BLK_DEV_IDECD is not set
+# CONFIG_BLK_DEV_IDETAPE is not set
+# CONFIG_IDE_TASK_IOCTL is not set
+CONFIG_IDE_PROC_FS=y
+
+#
+# IDE chipset support/bugfixes
+#
+# CONFIG_BLK_DEV_PLATFORM is not set
+
+#
+# PCI IDE chipsets support
+#
+# CONFIG_BLK_DEV_GENERIC is not set
+# CONFIG_BLK_DEV_OPTI621 is not set
+# CONFIG_BLK_DEV_AEC62XX is not set
+# CONFIG_BLK_DEV_ALI15X3 is not set
+# CONFIG_BLK_DEV_AMD74XX is not set
+# CONFIG_BLK_DEV_CMD64X is not set
+# CONFIG_BLK_DEV_TRIFLEX is not set
+# CONFIG_BLK_DEV_CS5520 is not set
+# CONFIG_BLK_DEV_CS5530 is not set
+# CONFIG_BLK_DEV_HPT366 is not set
+# CONFIG_BLK_DEV_JMICRON is not set
+# CONFIG_BLK_DEV_SC1200 is not set
+# CONFIG_BLK_DEV_PIIX is not set
+# CONFIG_BLK_DEV_IT8172 is not set
+# CONFIG_BLK_DEV_IT8213 is not set
+# CONFIG_BLK_DEV_IT821X is not set
+# CONFIG_BLK_DEV_NS87415 is not set
+# CONFIG_BLK_DEV_PDC202XX_OLD is not set
+# CONFIG_BLK_DEV_PDC202XX_NEW is not set
+# CONFIG_BLK_DEV_SVWKS is not set
+# CONFIG_BLK_DEV_SIIMAGE is not set
+# CONFIG_BLK_DEV_SL82C105 is not set
+# CONFIG_BLK_DEV_SLC90E66 is not set
+# CONFIG_BLK_DEV_TRM290 is not set
+# CONFIG_BLK_DEV_VIA82CXXX is not set
+# CONFIG_BLK_DEV_TC86C001 is not set
+# CONFIG_BLK_DEV_IDEDMA is not set
 
 #
 # SCSI device support
@@ -570,10 +662,6 @@ CONFIG_BLK_DEV_SR=y
 # CONFIG_BLK_DEV_SR_VENDOR is not set
 # CONFIG_CHR_DEV_SG is not set
 # CONFIG_CHR_DEV_SCH is not set
-
-#
-# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
-#
 # CONFIG_SCSI_MULTI_LUN is not set
 # CONFIG_SCSI_CONSTANTS is not set
 # CONFIG_SCSI_LOGGING is not set
@@ -590,6 +678,7 @@ CONFIG_SCSI_WAIT_SCAN=m
 # CONFIG_SCSI_SRP_ATTRS is not set
 CONFIG_SCSI_LOWLEVEL=y
 # CONFIG_ISCSI_TCP is not set
+# CONFIG_SCSI_BNX2_ISCSI is not set
 # CONFIG_BLK_DEV_3W_XXXX_RAID is not set
 # CONFIG_SCSI_3W_9XXX is not set
 # CONFIG_SCSI_ACARD is not set
@@ -598,6 +687,7 @@ CONFIG_SCSI_LOWLEVEL=y
 # CONFIG_SCSI_AIC7XXX_OLD is not set
 # CONFIG_SCSI_AIC79XX is not set
 # CONFIG_SCSI_AIC94XX is not set
+# CONFIG_SCSI_MVSAS is not set
 # CONFIG_SCSI_DPT_I2O is not set
 # CONFIG_SCSI_ADVANSYS is not set
 # CONFIG_SCSI_ARCMSR is not set
@@ -617,7 +707,6 @@ CONFIG_SCSI_LOWLEVEL=y
 # CONFIG_SCSI_IPS is not set
 # CONFIG_SCSI_INITIO is not set
 # CONFIG_SCSI_INIA100 is not set
-# CONFIG_SCSI_MVSAS is not set
 # CONFIG_SCSI_STEX is not set
 # CONFIG_SCSI_SYM53C8XX_2 is not set
 # CONFIG_SCSI_IPR is not set
@@ -630,6 +719,7 @@ CONFIG_SCSI_LOWLEVEL=y
 # CONFIG_SCSI_NSP32 is not set
 # CONFIG_SCSI_DEBUG is not set
 # CONFIG_SCSI_SRP is not set
+# CONFIG_SCSI_LOWLEVEL_PCMCIA is not set
 # CONFIG_SCSI_DH is not set
 # CONFIG_SCSI_OSD_INITIATOR is not set
 CONFIG_ATA=y
@@ -647,14 +737,17 @@ CONFIG_SATA_SIL24=y
 #
 
 #
-# Enable only one of the two stacks, unless you know what you are doing
+# You can enable one or both FireWire driver stacks.
+#
+
+#
+# See the help texts for more information.
 #
 # CONFIG_FIREWIRE is not set
 # CONFIG_IEEE1394 is not set
 # CONFIG_I2O is not set
 # CONFIG_MACINTOSH_DRIVERS is not set
 CONFIG_NETDEVICES=y
-CONFIG_COMPAT_NET_DEV_OPS=y
 CONFIG_DUMMY=m
 CONFIG_BONDING=m
 # CONFIG_MACVLAN is not set
@@ -701,6 +794,7 @@ CONFIG_MII=y
 # CONFIG_IBM_NEW_EMAC_MAL_COMMON_ERR is not set
 # CONFIG_NET_PCI is not set
 # CONFIG_B44 is not set
+# CONFIG_KS8842 is not set
 # CONFIG_ATL2 is not set
 CONFIG_NETDEV_1000=y
 # CONFIG_ACENIC is not set
@@ -720,8 +814,10 @@ CONFIG_NETDEV_1000=y
 # CONFIG_VIA_VELOCITY is not set
 # CONFIG_TIGON3 is not set
 # CONFIG_BNX2 is not set
+# CONFIG_CNIC is not set
 CONFIG_FSL_PQ_MDIO=y
 CONFIG_GIANFAR=y
+# CONFIG_MV643XX_ETH is not set
 # CONFIG_QLA3XXX is not set
 # CONFIG_ATL1 is not set
 # CONFIG_ATL1E is not set
@@ -748,6 +844,7 @@ CONFIG_GIANFAR=y
 # CONFIG_USB_PEGASUS is not set
 # CONFIG_USB_RTL8150 is not set
 # CONFIG_USB_USBNET is not set
+# CONFIG_NET_PCMCIA is not set
 # CONFIG_WAN is not set
 # CONFIG_FDDI is not set
 # CONFIG_HIPPI is not set
@@ -827,6 +924,7 @@ CONFIG_DEVKMEM=y
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 # CONFIG_SERIAL_8250_PCI is not set
+# CONFIG_SERIAL_8250_CS is not set
 CONFIG_SERIAL_8250_NR_UARTS=2
 CONFIG_SERIAL_8250_RUNTIME_UARTS=2
 # CONFIG_SERIAL_8250_EXTENDED is not set
@@ -849,6 +947,14 @@ CONFIG_HW_RANDOM=y
 CONFIG_NVRAM=y
 # CONFIG_R3964 is not set
 # CONFIG_APPLICOM is not set
+
+#
+# PCMCIA character devices
+#
+# CONFIG_SYNCLINK_CS is not set
+# CONFIG_CARDMAN_4000 is not set
+# CONFIG_CARDMAN_4040 is not set
+# CONFIG_IPWIRELESS is not set
 # CONFIG_RAW_DRIVER is not set
 # CONFIG_TCG_TPM is not set
 CONFIG_DEVPORT=y
@@ -912,13 +1018,17 @@ CONFIG_DS1682=y
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
-# CONFIG_SENSORS_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
 # CONFIG_I2C_DEBUG_BUS is not set
 # CONFIG_I2C_DEBUG_CHIP is not set
 # CONFIG_SPI is not set
+
+#
+# PPS support
+#
+# CONFIG_PPS is not set
 CONFIG_ARCH_WANT_OPTIONAL_GPIOLIB=y
 CONFIG_ARCH_REQUIRE_GPIOLIB=y
 CONFIG_GPIOLIB=y
@@ -997,6 +1107,7 @@ CONFIG_SENSORS_LM92=y
 # CONFIG_SENSORS_SMSC47B397 is not set
 # CONFIG_SENSORS_ADS7828 is not set
 # CONFIG_SENSORS_THMC50 is not set
+# CONFIG_SENSORS_TMP401 is not set
 # CONFIG_SENSORS_VIA686A is not set
 # CONFIG_SENSORS_VT1211 is not set
 # CONFIG_SENSORS_VT8231 is not set
@@ -1052,24 +1163,9 @@ CONFIG_SSB_POSSIBLE=y
 # CONFIG_MFD_WM8400 is not set
 # CONFIG_MFD_WM8350_I2C is not set
 # CONFIG_MFD_PCF50633 is not set
+# CONFIG_AB3100_CORE is not set
 # CONFIG_REGULATOR is not set
-
-#
-# Multimedia devices
-#
-
-#
-# Multimedia core support
-#
-# CONFIG_VIDEO_DEV is not set
-# CONFIG_DVB_CORE is not set
-# CONFIG_VIDEO_MEDIA is not set
-
-#
-# Multimedia drivers
-#
-CONFIG_DAB=y
-# CONFIG_USB_DABUSB is not set
+# CONFIG_MEDIA_SUPPORT is not set
 
 #
 # Graphics support
@@ -1114,7 +1210,7 @@ CONFIG_HID_BELKIN=y
 CONFIG_HID_CHERRY=y
 CONFIG_HID_CHICONY=y
 CONFIG_HID_CYPRESS=y
-# CONFIG_DRAGONRISE_FF is not set
+# CONFIG_HID_DRAGONRISE is not set
 CONFIG_HID_EZKEY=y
 # CONFIG_HID_KYE is not set
 CONFIG_HID_GYRATION=y
@@ -1131,10 +1227,11 @@ CONFIG_HID_PETALYNX=y
 CONFIG_HID_SAMSUNG=y
 CONFIG_HID_SONY=y
 CONFIG_HID_SUNPLUS=y
-# CONFIG_GREENASIA_FF is not set
+# CONFIG_HID_GREENASIA is not set
+# CONFIG_HID_SMARTJOYPLUS is not set
 # CONFIG_HID_TOPSEED is not set
-# CONFIG_THRUSTMASTER_FF is not set
-# CONFIG_ZEROPLUS_FF is not set
+# CONFIG_HID_THRUSTMASTER is not set
+# CONFIG_HID_ZEROPLUS is not set
 CONFIG_USB_SUPPORT=y
 CONFIG_USB_ARCH_HAS_HCD=y
 CONFIG_USB_ARCH_HAS_OHCI=y
@@ -1160,6 +1257,7 @@ CONFIG_USB=y
 # USB Host Controller Drivers
 #
 # CONFIG_USB_C67X00_HCD is not set
+# CONFIG_USB_XHCI_HCD is not set
 CONFIG_USB_EHCI_HCD=y
 # CONFIG_USB_EHCI_ROOT_HUB_TT is not set
 # CONFIG_USB_EHCI_TT_NEWSCHED is not set
@@ -1288,6 +1386,7 @@ CONFIG_RTC_INTF_DEV=y
 # CONFIG_RTC_DRV_S35390A is not set
 # CONFIG_RTC_DRV_FM3130 is not set
 CONFIG_RTC_DRV_RX8581=y
+# CONFIG_RTC_DRV_RX8025 is not set
 
 #
 # SPI RTC drivers
@@ -1315,6 +1414,10 @@ CONFIG_RTC_DRV_RX8581=y
 # CONFIG_DMADEVICES is not set
 # CONFIG_AUXDISPLAY is not set
 # CONFIG_UIO is not set
+
+#
+# TI VLYNQ
+#
 # CONFIG_STAGING is not set
 
 #
@@ -1336,10 +1439,12 @@ CONFIG_FS_MBCACHE=y
 # CONFIG_REISERFS_FS is not set
 # CONFIG_JFS_FS is not set
 CONFIG_FS_POSIX_ACL=y
-CONFIG_FILE_LOCKING=y
 # CONFIG_XFS_FS is not set
+# CONFIG_GFS2_FS is not set
 # CONFIG_OCFS2_FS is not set
 # CONFIG_BTRFS_FS is not set
+CONFIG_FILE_LOCKING=y
+CONFIG_FSNOTIFY=y
 CONFIG_DNOTIFY=y
 CONFIG_INOTIFY=y
 CONFIG_INOTIFY_USER=y
@@ -1419,6 +1524,7 @@ CONFIG_NFS_FS=y
 CONFIG_NFS_V3=y
 # CONFIG_NFS_V3_ACL is not set
 CONFIG_NFS_V4=y
+# CONFIG_NFS_V4_1 is not set
 CONFIG_ROOT_NFS=y
 # CONFIG_NFSD is not set
 CONFIG_LOCKD=y
@@ -1508,6 +1614,7 @@ CONFIG_HAS_IOPORT=y
 CONFIG_HAS_DMA=y
 CONFIG_HAVE_LMB=y
 CONFIG_NLATTR=y
+CONFIG_GENERIC_ATOMIC64=y
 
 #
 # Kernel hacking
@@ -1531,23 +1638,11 @@ CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
 CONFIG_HAVE_DYNAMIC_FTRACE=y
 CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
 CONFIG_TRACING_SUPPORT=y
-
-#
-# Tracers
-#
-# CONFIG_FUNCTION_TRACER is not set
-# CONFIG_PREEMPT_TRACER is not set
-# CONFIG_SCHED_TRACER is not set
-# CONFIG_CONTEXT_SWITCH_TRACER is not set
-# CONFIG_EVENT_TRACER is not set
-# CONFIG_BOOT_TRACER is not set
-# CONFIG_TRACE_BRANCH_PROFILING is not set
-# CONFIG_STACK_TRACER is not set
-# CONFIG_KMEMTRACE is not set
-# CONFIG_WORKQUEUE_TRACER is not set
-# CONFIG_BLK_DEV_IO_TRACE is not set
+# CONFIG_FTRACE is not set
 # CONFIG_SAMPLES is not set
 CONFIG_HAVE_ARCH_KGDB=y
+# CONFIG_PPC_DISABLE_WERROR is not set
+CONFIG_PPC_WERROR=y
 CONFIG_PRINT_STACK_DEPTH=64
 # CONFIG_IRQSTACKS is not set
 # CONFIG_BOOTX_TEXT is not set
