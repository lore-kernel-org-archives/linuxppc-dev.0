Return-Path: <dale@farnsworth.org>
Received: from farnsworth.org (xyzzy.farnsworth.org [65.39.95.219])
	by ozlabs.org (Postfix) with SMTP id B53E5DDF02
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Oct 2007 23:21:39 +1000 (EST)
From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Tue, 23 Oct 2007 06:21:33 -0700
To: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
Subject: [PATCH] [POWERPC] Update prpmc2800_defconfig
Message-ID: <20071023132132.GA7900@xyzzy.farnsworth.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Dale Farnsworth <dale@farnsworth.org>
---

This gets the prpmc2800 booting again.

 arch/powerpc/configs/prpmc2800_defconfig |  147 ++++++++++++++++--------------
 1 files changed, 78 insertions(+), 69 deletions(-)

diff --git a/arch/powerpc/configs/prpmc2800_defconfig b/arch/powerpc/configs/prpmc2800_defconfig
index 3e87faf..92bca4f 100644
--- a/arch/powerpc/configs/prpmc2800_defconfig
+++ b/arch/powerpc/configs/prpmc2800_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.23-rc4
-# Tue Aug 28 21:24:45 2007
+# Linux kernel version: 2.6.23
+# Tue Oct 23 04:56:05 2007
 #
 # CONFIG_PPC64 is not set
 
@@ -15,6 +15,7 @@ CONFIG_6xx=y
 # CONFIG_44x is not set
 # CONFIG_E200 is not set
 CONFIG_PPC_FPU=y
+CONFIG_ALTIVEC=y
 CONFIG_PPC_STD_MMU=y
 CONFIG_PPC_STD_MMU_32=y
 # CONFIG_PPC_MM_SLICES is not set
@@ -22,8 +23,13 @@ CONFIG_PPC_STD_MMU_32=y
 CONFIG_NOT_COHERENT_CACHE=y
 CONFIG_CHECK_CACHE_COHERENCY=y
 CONFIG_PPC32=y
+CONFIG_WORD_SIZE=32
 CONFIG_PPC_MERGE=y
 CONFIG_MMU=y
+CONFIG_GENERIC_CMOS_UPDATE=y
+CONFIG_GENERIC_TIME=y
+CONFIG_GENERIC_TIME_VSYSCALL=y
+CONFIG_GENERIC_CLOCKEVENTS=y
 CONFIG_GENERIC_HARDIRQS=y
 CONFIG_IRQ_PER_CPU=y
 CONFIG_RWSEM_XCHGADD_ALGORITHM=y
@@ -66,6 +72,10 @@ CONFIG_POSIX_MQUEUE=y
 # CONFIG_AUDIT is not set
 # CONFIG_IKCONFIG is not set
 CONFIG_LOG_BUF_SHIFT=14
+# CONFIG_CGROUPS is not set
+CONFIG_FAIR_GROUP_SCHED=y
+CONFIG_FAIR_USER_SCHED=y
+# CONFIG_FAIR_CGROUP_SCHED is not set
 # CONFIG_SYSFS_DEPRECATED is not set
 # CONFIG_RELAY is not set
 CONFIG_BLK_DEV_INITRD=y
@@ -85,7 +95,6 @@ CONFIG_FUTEX=y
 CONFIG_ANON_INODES=y
 CONFIG_EPOLL=y
 CONFIG_SIGNALFD=y
-CONFIG_TIMERFD=y
 CONFIG_EVENTFD=y
 CONFIG_SHMEM=y
 CONFIG_VM_EVENT_COUNTERS=y
@@ -119,16 +128,21 @@ CONFIG_DEFAULT_IOSCHED="anticipatory"
 #
 # Platform support
 #
-# CONFIG_PPC_MULTIPLATFORM is not set
-CONFIG_EMBEDDED6xx=y
+CONFIG_PPC_MULTIPLATFORM=y
 # CONFIG_PPC_82xx is not set
 # CONFIG_PPC_83xx is not set
 # CONFIG_PPC_86xx is not set
+CONFIG_CLASSIC32=y
+# CONFIG_PPC_CHRP is not set
 # CONFIG_PPC_MPC52xx is not set
 # CONFIG_PPC_MPC5200 is not set
+# CONFIG_PPC_EFIKA is not set
+# CONFIG_PPC_LITE5200 is not set
+# CONFIG_PPC_PMAC is not set
 # CONFIG_PPC_CELL is not set
 # CONFIG_PPC_CELL_NATIVE is not set
 # CONFIG_PQ2ADS is not set
+CONFIG_EMBEDDED6xx=y
 # CONFIG_LINKSTATION is not set
 # CONFIG_MPC7448HPC2 is not set
 # CONFIG_PPC_HOLLY is not set
@@ -144,6 +158,7 @@ CONFIG_MV64X60=y
 # CONFIG_PPC_INDIRECT_IO is not set
 # CONFIG_GENERIC_IOMAP is not set
 # CONFIG_CPU_FREQ is not set
+# CONFIG_TAU is not set
 # CONFIG_CPM2 is not set
 # CONFIG_FSL_ULI1575 is not set
 
@@ -151,6 +166,10 @@ CONFIG_MV64X60=y
 # Kernel options
 #
 CONFIG_HIGHMEM=y
+# CONFIG_TICK_ONESHOT is not set
+# CONFIG_NO_HZ is not set
+# CONFIG_HIGH_RES_TIMERS is not set
+CONFIG_GENERIC_CLOCKEVENTS_BUILD=y
 # CONFIG_HZ_100 is not set
 CONFIG_HZ_250=y
 # CONFIG_HZ_300 is not set
@@ -172,6 +191,7 @@ CONFIG_FLATMEM_MANUAL=y
 CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
+# CONFIG_SPARSEMEM_VMEMMAP_ENABLE is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
 # CONFIG_RESOURCES_64BIT is not set
 CONFIG_ZONE_DMA_FLAG=1
@@ -180,6 +200,8 @@ CONFIG_VIRT_TO_BUS=y
 CONFIG_PROC_DEVICETREE=y
 # CONFIG_CMDLINE_BOOL is not set
 # CONFIG_PM is not set
+CONFIG_SUSPEND_UP_POSSIBLE=y
+CONFIG_HIBERNATION_UP_POSSIBLE=y
 # CONFIG_SECCOMP is not set
 CONFIG_WANT_DEVICE_TREE=y
 CONFIG_DEVICE_TREE="prpmc2800.dts"
@@ -197,10 +219,6 @@ CONFIG_PCI_SYSCALL=y
 # CONFIG_PCIEPORTBUS is not set
 CONFIG_ARCH_SUPPORTS_MSI=y
 # CONFIG_PCI_MSI is not set
-
-#
-# PCCARD (PCMCIA/CardBus) support
-#
 # CONFIG_PCCARD is not set
 # CONFIG_HOTPLUG_PCI is not set
 
@@ -215,7 +233,7 @@ CONFIG_ARCH_SUPPORTS_MSI=y
 CONFIG_HIGHMEM_START=0xfe000000
 CONFIG_LOWMEM_SIZE=0x30000000
 CONFIG_KERNEL_START=0xc0000000
-CONFIG_TASK_SIZE=0x80000000
+CONFIG_TASK_SIZE=0xc0000000
 CONFIG_CONSISTENT_START=0xff100000
 CONFIG_CONSISTENT_SIZE=0x00200000
 CONFIG_BOOT_LOAD=0x00800000
@@ -257,6 +275,7 @@ CONFIG_SYN_COOKIES=y
 CONFIG_INET_XFRM_MODE_TRANSPORT=y
 CONFIG_INET_XFRM_MODE_TUNNEL=y
 CONFIG_INET_XFRM_MODE_BEET=y
+# CONFIG_INET_LRO is not set
 CONFIG_INET_DIAG=y
 CONFIG_INET_TCP_DIAG=y
 # CONFIG_TCP_CONG_ADVANCED is not set
@@ -282,10 +301,6 @@ CONFIG_DEFAULT_TCP_CONG="cubic"
 # CONFIG_LAPB is not set
 # CONFIG_ECONET is not set
 # CONFIG_WAN_ROUTER is not set
-
-#
-# QoS and/or fair queueing
-#
 # CONFIG_NET_SCHED is not set
 
 #
@@ -314,6 +329,7 @@ CONFIG_DEFAULT_TCP_CONG="cubic"
 #
 # Generic Driver Options
 #
+CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_STANDALONE=y
 CONFIG_PREVENT_FIRMWARE_BUILD=y
 # CONFIG_FW_LOADER is not set
@@ -337,6 +353,7 @@ CONFIG_MTD_BLOCK=y
 # CONFIG_INFTL is not set
 # CONFIG_RFD_FTL is not set
 # CONFIG_SSFDC is not set
+# CONFIG_MTD_OOPS is not set
 
 #
 # RAM/ROM/Flash chip drivers
@@ -369,6 +386,7 @@ CONFIG_MTD_CFI_UTIL=y
 # CONFIG_MTD_COMPLEX_MAPPINGS is not set
 # CONFIG_MTD_PHYSMAP is not set
 CONFIG_MTD_PHYSMAP_OF=y
+# CONFIG_MTD_INTEL_VR_NOR is not set
 # CONFIG_MTD_PLATRAM is not set
 
 #
@@ -438,6 +456,11 @@ CONFIG_IDE_PROC_FS=y
 # IDE chipset support/bugfixes
 #
 CONFIG_IDE_GENERIC=y
+# CONFIG_BLK_DEV_PLATFORM is not set
+
+#
+# PCI IDE chipsets support
+#
 CONFIG_BLK_DEV_IDEPCI=y
 # CONFIG_IDEPCI_SHARE_IRQ is not set
 CONFIG_IDEPCI_PCIBUS_ORDER=y
@@ -445,8 +468,6 @@ CONFIG_IDEPCI_PCIBUS_ORDER=y
 CONFIG_BLK_DEV_GENERIC=y
 # CONFIG_BLK_DEV_OPTI621 is not set
 CONFIG_BLK_DEV_IDEDMA_PCI=y
-# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
-# CONFIG_IDEDMA_ONLYDISK is not set
 # CONFIG_BLK_DEV_AEC62XX is not set
 # CONFIG_BLK_DEV_ALI15X3 is not set
 # CONFIG_BLK_DEV_AMD74XX is not set
@@ -474,7 +495,7 @@ CONFIG_BLK_DEV_PDC202XX_NEW=y
 # CONFIG_BLK_DEV_TC86C001 is not set
 # CONFIG_IDE_ARM is not set
 CONFIG_BLK_DEV_IDEDMA=y
-# CONFIG_IDEDMA_IVB is not set
+CONFIG_IDE_ARCH_OBSOLETE_INIT=y
 # CONFIG_BLK_DEV_HD is not set
 
 #
@@ -512,6 +533,7 @@ CONFIG_BLK_DEV_SD=y
 # CONFIG_SCSI_FC_ATTRS is not set
 # CONFIG_SCSI_ISCSI_ATTRS is not set
 # CONFIG_SCSI_SAS_LIBSAS is not set
+# CONFIG_SCSI_SRP_ATTRS is not set
 CONFIG_SCSI_LOWLEVEL=y
 # CONFIG_ISCSI_TCP is not set
 # CONFIG_BLK_DEV_3W_XXXX_RAID is not set
@@ -523,6 +545,7 @@ CONFIG_SCSI_LOWLEVEL=y
 # CONFIG_SCSI_AIC79XX is not set
 # CONFIG_SCSI_AIC94XX is not set
 # CONFIG_SCSI_DPT_I2O is not set
+# CONFIG_SCSI_ADVANSYS is not set
 # CONFIG_SCSI_ARCMSR is not set
 # CONFIG_MEGARAID_NEWGEN is not set
 # CONFIG_MEGARAID_LEGACY is not set
@@ -590,6 +613,7 @@ CONFIG_SATA_MV=y
 # CONFIG_PATA_OLDPIIX is not set
 # CONFIG_PATA_NETCELL is not set
 # CONFIG_PATA_NS87410 is not set
+# CONFIG_PATA_NS87415 is not set
 # CONFIG_PATA_OPTI is not set
 # CONFIG_PATA_OPTIDMA is not set
 # CONFIG_PATA_PDC_OLD is not set
@@ -603,14 +627,7 @@ CONFIG_SATA_MV=y
 # CONFIG_PATA_VIA is not set
 # CONFIG_PATA_WINBOND is not set
 # CONFIG_MD is not set
-
-#
-# Fusion MPT device support
-#
 # CONFIG_FUSION is not set
-# CONFIG_FUSION_SPI is not set
-# CONFIG_FUSION_FC is not set
-# CONFIG_FUSION_SAS is not set
 
 #
 # IEEE 1394 (FireWire) support
@@ -628,6 +645,8 @@ CONFIG_NETDEVICES=y
 # CONFIG_MACVLAN is not set
 # CONFIG_EQUALIZER is not set
 # CONFIG_TUN is not set
+# CONFIG_VETH is not set
+# CONFIG_IP1000 is not set
 # CONFIG_ARCNET is not set
 CONFIG_PHYLIB=y
 
@@ -644,6 +663,7 @@ CONFIG_PHYLIB=y
 # CONFIG_BROADCOM_PHY is not set
 # CONFIG_ICPLUS_PHY is not set
 # CONFIG_FIXED_PHY is not set
+# CONFIG_MDIO_BITBANG is not set
 CONFIG_NET_ETHERNET=y
 CONFIG_MII=y
 # CONFIG_HAPPYMEAL is not set
@@ -652,13 +672,16 @@ CONFIG_MII=y
 # CONFIG_NET_VENDOR_3COM is not set
 # CONFIG_NET_TULIP is not set
 # CONFIG_HP100 is not set
+# CONFIG_IBM_NEW_EMAC_ZMII is not set
+# CONFIG_IBM_NEW_EMAC_RGMII is not set
+# CONFIG_IBM_NEW_EMAC_TAH is not set
+# CONFIG_IBM_NEW_EMAC_EMAC4 is not set
 CONFIG_NET_PCI=y
 # CONFIG_PCNET32 is not set
 # CONFIG_AMD8111_ETH is not set
 # CONFIG_ADAPTEC_STARFIRE is not set
 # CONFIG_B44 is not set
 # CONFIG_FORCEDETH is not set
-# CONFIG_DGRS is not set
 # CONFIG_EEPRO100 is not set
 CONFIG_E100=y
 # CONFIG_FEALNX is not set
@@ -682,6 +705,7 @@ CONFIG_NETDEV_1000=y
 CONFIG_E1000=y
 # CONFIG_E1000_NAPI is not set
 # CONFIG_E1000_DISABLE_PACKET_SPLIT is not set
+# CONFIG_E1000E is not set
 # CONFIG_NS83820 is not set
 # CONFIG_HAMACHI is not set
 # CONFIG_YELLOWFIN is not set
@@ -689,6 +713,7 @@ CONFIG_E1000=y
 # CONFIG_SIS190 is not set
 # CONFIG_SKGE is not set
 # CONFIG_SKY2 is not set
+# CONFIG_SK98LIN is not set
 # CONFIG_VIA_VELOCITY is not set
 # CONFIG_TIGON3 is not set
 # CONFIG_BNX2 is not set
@@ -698,11 +723,14 @@ CONFIG_MV643XX_ETH=y
 CONFIG_NETDEV_10000=y
 # CONFIG_CHELSIO_T1 is not set
 # CONFIG_CHELSIO_T3 is not set
+# CONFIG_IXGBE is not set
 # CONFIG_IXGB is not set
 # CONFIG_S2IO is not set
 # CONFIG_MYRI10GE is not set
 # CONFIG_NETXEN_NIC is not set
+# CONFIG_NIU is not set
 # CONFIG_MLX4_CORE is not set
+# CONFIG_TEHUTI is not set
 # CONFIG_TR is not set
 
 #
@@ -748,7 +776,6 @@ CONFIG_INPUT_MOUSEDEV_PSAUX=y
 CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
 CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
 # CONFIG_INPUT_JOYDEV is not set
-# CONFIG_INPUT_TSDEV is not set
 # CONFIG_INPUT_EVDEV is not set
 # CONFIG_INPUT_EVBUG is not set
 
@@ -795,15 +822,12 @@ CONFIG_UNIX98_PTYS=y
 CONFIG_LEGACY_PTYS=y
 CONFIG_LEGACY_PTY_COUNT=256
 # CONFIG_IPMI_HANDLER is not set
-# CONFIG_WATCHDOG is not set
 # CONFIG_HW_RANDOM is not set
 # CONFIG_NVRAM is not set
 CONFIG_GEN_RTC=y
 # CONFIG_GEN_RTC_X is not set
 # CONFIG_R3964 is not set
 # CONFIG_APPLICOM is not set
-# CONFIG_AGP is not set
-# CONFIG_DRM is not set
 # CONFIG_RAW_DRIVER is not set
 # CONFIG_TCG_TPM is not set
 CONFIG_DEVPORT=y
@@ -873,8 +897,6 @@ CONFIG_I2C_MV64XXX=y
 # CONFIG_POWER_SUPPLY is not set
 CONFIG_HWMON=y
 # CONFIG_HWMON_VID is not set
-# CONFIG_SENSORS_ABITUGURU is not set
-# CONFIG_SENSORS_ABITUGURU3 is not set
 # CONFIG_SENSORS_AD7418 is not set
 # CONFIG_SENSORS_ADM1021 is not set
 # CONFIG_SENSORS_ADM1025 is not set
@@ -882,12 +904,12 @@ CONFIG_HWMON=y
 # CONFIG_SENSORS_ADM1029 is not set
 # CONFIG_SENSORS_ADM1031 is not set
 # CONFIG_SENSORS_ADM9240 is not set
-# CONFIG_SENSORS_ASB100 is not set
+# CONFIG_SENSORS_ADT7470 is not set
 # CONFIG_SENSORS_ATXP1 is not set
 # CONFIG_SENSORS_DS1621 is not set
 # CONFIG_SENSORS_F71805F is not set
-# CONFIG_SENSORS_FSCHER is not set
-# CONFIG_SENSORS_FSCPOS is not set
+# CONFIG_SENSORS_F71882FG is not set
+# CONFIG_SENSORS_F75375S is not set
 # CONFIG_SENSORS_GL518SM is not set
 # CONFIG_SENSORS_GL520SM is not set
 # CONFIG_SENSORS_IT87 is not set
@@ -923,6 +945,13 @@ CONFIG_HWMON=y
 # CONFIG_SENSORS_W83627HF is not set
 # CONFIG_SENSORS_W83627EHF is not set
 # CONFIG_HWMON_DEBUG_CHIP is not set
+# CONFIG_WATCHDOG is not set
+
+#
+# Sonics Silicon Backplane
+#
+CONFIG_SSB_POSSIBLE=y
+# CONFIG_SSB is not set
 
 #
 # Multifunction device drivers
@@ -939,16 +968,17 @@ CONFIG_HWMON=y
 #
 # Graphics support
 #
+# CONFIG_AGP is not set
+# CONFIG_DRM is not set
+# CONFIG_VGASTATE is not set
+CONFIG_VIDEO_OUTPUT_CONTROL=y
+# CONFIG_FB is not set
 # CONFIG_BACKLIGHT_LCD_SUPPORT is not set
 
 #
 # Display device support
 #
 # CONFIG_DISPLAY_SUPPORT is not set
-# CONFIG_VGASTATE is not set
-CONFIG_VIDEO_OUTPUT_CONTROL=y
-# CONFIG_FB is not set
-# CONFIG_FB_IBM_GXT4500 is not set
 
 #
 # Console display driver support
@@ -964,6 +994,7 @@ CONFIG_DUMMY_CONSOLE=y
 CONFIG_HID_SUPPORT=y
 CONFIG_HID=y
 # CONFIG_HID_DEBUG is not set
+# CONFIG_HIDRAW is not set
 
 #
 # USB Input Devices
@@ -1091,6 +1122,7 @@ CONFIG_RTC_INTF_DEV=y
 # I2C RTC drivers
 #
 # CONFIG_RTC_DRV_DS1307 is not set
+# CONFIG_RTC_DRV_DS1374 is not set
 # CONFIG_RTC_DRV_DS1672 is not set
 CONFIG_RTC_DRV_MAX6900=y
 # CONFIG_RTC_DRV_RS5C372 is not set
@@ -1120,19 +1152,6 @@ CONFIG_RTC_DRV_MAX6900=y
 #
 
 #
-# DMA Engine support
-#
-# CONFIG_DMA_ENGINE is not set
-
-#
-# DMA Clients
-#
-
-#
-# DMA Devices
-#
-
-#
 # Userspace I/O
 #
 # CONFIG_UIO is not set
@@ -1149,7 +1168,6 @@ CONFIG_EXT3_FS_XATTR=y
 # CONFIG_EXT3_FS_SECURITY is not set
 # CONFIG_EXT4DEV_FS is not set
 CONFIG_JBD=y
-# CONFIG_JBD_DEBUG is not set
 CONFIG_FS_MBCACHE=y
 # CONFIG_REISERFS_FS is not set
 # CONFIG_JFS_FS is not set
@@ -1190,7 +1208,6 @@ CONFIG_SYSFS=y
 CONFIG_TMPFS=y
 # CONFIG_TMPFS_POSIX_ACL is not set
 # CONFIG_HUGETLB_PAGE is not set
-CONFIG_RAMFS=y
 # CONFIG_CONFIGFS_FS is not set
 
 #
@@ -1210,10 +1227,7 @@ CONFIG_RAMFS=y
 # CONFIG_QNX4FS_FS is not set
 # CONFIG_SYSV_FS is not set
 # CONFIG_UFS_FS is not set
-
-#
-# Network File Systems
-#
+CONFIG_NETWORK_FILESYSTEMS=y
 CONFIG_NFS_FS=y
 # CONFIG_NFS_V3 is not set
 # CONFIG_NFS_V4 is not set
@@ -1253,15 +1267,7 @@ CONFIG_MSDOS_PARTITION=y
 # CONFIG_KARMA_PARTITION is not set
 # CONFIG_EFI_PARTITION is not set
 # CONFIG_SYSV68_PARTITION is not set
-
-#
-# Native Language Support
-#
 # CONFIG_NLS is not set
-
-#
-# Distributed Lock Manager
-#
 # CONFIG_DLM is not set
 # CONFIG_UCC_SLOW is not set
 
@@ -1279,11 +1285,9 @@ CONFIG_PLIST=y
 CONFIG_HAS_IOMEM=y
 CONFIG_HAS_IOPORT=y
 CONFIG_HAS_DMA=y
-
-#
-# Instrumentation Support
-#
+CONFIG_INSTRUMENTATION=y
 # CONFIG_PROFILING is not set
+# CONFIG_MARKERS is not set
 
 #
 # Kernel hacking
@@ -1295,7 +1299,10 @@ CONFIG_ENABLE_MUST_CHECK=y
 # CONFIG_DEBUG_FS is not set
 # CONFIG_HEADERS_CHECK is not set
 # CONFIG_DEBUG_KERNEL is not set
+# CONFIG_SLUB_DEBUG_ON is not set
 CONFIG_DEBUG_BUGVERBOSE=y
+# CONFIG_SAMPLES is not set
+# CONFIG_BOOTX_TEXT is not set
 # CONFIG_PPC_EARLY_DEBUG is not set
 
 #
@@ -1303,4 +1310,6 @@ CONFIG_DEBUG_BUGVERBOSE=y
 #
 # CONFIG_KEYS is not set
 # CONFIG_SECURITY is not set
+# CONFIG_SECURITY_FILE_CAPABILITIES is not set
 # CONFIG_CRYPTO is not set
+# CONFIG_PPC_CLOCK is not set
-- 
1.5.3.4
