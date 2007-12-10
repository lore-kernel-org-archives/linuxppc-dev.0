Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6F6ECDDE35
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Dec 2007 04:10:38 +1100 (EST)
Date: Mon, 10 Dec 2007 11:10:45 -0600
From: Scott Wood <scottwood@freescale.com>
To: galak@kernel.crashing.org
Subject: [PATCH] mpc8272ads, pq2fads: Update defconfig with
	CONFIG_FS_ENET_MDIO_FCC
Message-ID: <20071210171045.GA17318@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This was recently made configurable, and needs to be set for these boards.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
Please apply for 2.6.24.

 arch/powerpc/configs/mpc8272_ads_defconfig |  110 +++++++++++---------
 arch/powerpc/configs/pq2fads_defconfig     |  152 +++++++++++++++++-----------
 2 files changed, 153 insertions(+), 109 deletions(-)

diff --git a/arch/powerpc/configs/mpc8272_ads_defconfig b/arch/powerpc/configs/mpc8272_ads_defconfig
index 865a942..e982a29 100644
--- a/arch/powerpc/configs/mpc8272_ads_defconfig
+++ b/arch/powerpc/configs/mpc8272_ads_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.23-rc4
-# Wed Sep  5 12:43:23 2007
+# Linux kernel version: 2.6.24-rc3
+# Mon Dec 10 11:02:24 2007
 #
 # CONFIG_PPC64 is not set
 
@@ -20,8 +20,13 @@ CONFIG_PPC_STD_MMU_32=y
 # CONFIG_PPC_MM_SLICES is not set
 # CONFIG_SMP is not set
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
@@ -63,6 +68,10 @@ CONFIG_SYSVIPC_SYSCTL=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=14
+# CONFIG_CGROUPS is not set
+CONFIG_FAIR_GROUP_SCHED=y
+CONFIG_FAIR_USER_SCHED=y
+# CONFIG_FAIR_CGROUP_SCHED is not set
 CONFIG_SYSFS_DEPRECATED=y
 # CONFIG_RELAY is not set
 # CONFIG_BLK_DEV_INITRD is not set
@@ -81,7 +90,6 @@ CONFIG_FUTEX=y
 CONFIG_ANON_INODES=y
 CONFIG_EPOLL=y
 CONFIG_SIGNALFD=y
-CONFIG_TIMERFD=y
 CONFIG_EVENTFD=y
 CONFIG_SHMEM=y
 CONFIG_VM_EVENT_COUNTERS=y
@@ -115,7 +123,6 @@ CONFIG_DEFAULT_IOSCHED="anticipatory"
 # Platform support
 #
 # CONFIG_PPC_MULTIPLATFORM is not set
-# CONFIG_EMBEDDED6xx is not set
 CONFIG_PPC_82xx=y
 # CONFIG_PPC_83xx is not set
 # CONFIG_PPC_86xx is not set
@@ -124,6 +131,7 @@ CONFIG_PPC_82xx=y
 # CONFIG_PPC_CELL is not set
 # CONFIG_PPC_CELL_NATIVE is not set
 CONFIG_MPC8272_ADS=y
+# CONFIG_PQ2FADS is not set
 CONFIG_PQ2ADS=y
 CONFIG_8260=y
 CONFIG_8272=y
@@ -147,6 +155,10 @@ CONFIG_CPM=y
 # Kernel options
 #
 # CONFIG_HIGHMEM is not set
+# CONFIG_TICK_ONESHOT is not set
+# CONFIG_NO_HZ is not set
+# CONFIG_HIGH_RES_TIMERS is not set
+CONFIG_GENERIC_CLOCKEVENTS_BUILD=y
 # CONFIG_HZ_100 is not set
 CONFIG_HZ_250=y
 # CONFIG_HZ_300 is not set
@@ -163,6 +175,7 @@ CONFIG_ARCH_POPULATES_NODE_MAP=y
 CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
+# CONFIG_SPARSEMEM_VMEMMAP_ENABLE is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
 # CONFIG_RESOURCES_64BIT is not set
 CONFIG_ZONE_DMA_FLAG=1
@@ -171,9 +184,10 @@ CONFIG_VIRT_TO_BUS=y
 CONFIG_PROC_DEVICETREE=y
 # CONFIG_CMDLINE_BOOL is not set
 # CONFIG_PM is not set
+CONFIG_SUSPEND_UP_POSSIBLE=y
+CONFIG_HIBERNATION_UP_POSSIBLE=y
 CONFIG_SECCOMP=y
 CONFIG_WANT_DEVICE_TREE=y
-# CONFIG_BUILD_RAW_IMAGE is not set
 CONFIG_DEVICE_TREE="mpc8272ads.dts"
 CONFIG_ISA_DMA_API=y
 
@@ -190,11 +204,8 @@ CONFIG_PCI_8260=y
 # CONFIG_PCIEPORTBUS is not set
 CONFIG_ARCH_SUPPORTS_MSI=y
 # CONFIG_PCI_MSI is not set
+CONFIG_PCI_LEGACY=y
 # CONFIG_PCI_DEBUG is not set
-
-#
-# PCCARD (PCMCIA/CardBus) support
-#
 # CONFIG_PCCARD is not set
 
 #
@@ -208,7 +219,7 @@ CONFIG_ARCH_SUPPORTS_MSI=y
 CONFIG_HIGHMEM_START=0xfe000000
 CONFIG_LOWMEM_SIZE=0x30000000
 CONFIG_KERNEL_START=0xc0000000
-CONFIG_TASK_SIZE=0x80000000
+CONFIG_TASK_SIZE=0xc0000000
 CONFIG_BOOT_LOAD=0x00400000
 
 #
@@ -245,6 +256,7 @@ CONFIG_INET_TUNNEL=y
 CONFIG_INET_XFRM_MODE_TRANSPORT=y
 CONFIG_INET_XFRM_MODE_TUNNEL=y
 CONFIG_INET_XFRM_MODE_BEET=y
+# CONFIG_INET_LRO is not set
 CONFIG_INET_DIAG=y
 CONFIG_INET_TCP_DIAG=y
 # CONFIG_TCP_CONG_ADVANCED is not set
@@ -288,10 +300,6 @@ CONFIG_NETFILTER=y
 # CONFIG_LLC2 is not set
 # CONFIG_IPX is not set
 # CONFIG_ATALK is not set
-
-#
-# QoS and/or fair queueing
-#
 # CONFIG_NET_SCHED is not set
 
 #
@@ -317,6 +325,7 @@ CONFIG_NETFILTER=y
 #
 # Generic Driver Options
 #
+CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_STANDALONE=y
 CONFIG_PREVENT_FIRMWARE_BUILD=y
 # CONFIG_FW_LOADER is not set
@@ -340,6 +349,7 @@ CONFIG_MTD_BLOCK=y
 # CONFIG_INFTL is not set
 # CONFIG_RFD_FTL is not set
 # CONFIG_SSFDC is not set
+# CONFIG_MTD_OOPS is not set
 
 #
 # RAM/ROM/Flash chip drivers
@@ -378,6 +388,7 @@ CONFIG_MTD_CFI_UTIL=y
 # CONFIG_MTD_PHYSMAP is not set
 CONFIG_MTD_PHYSMAP_OF=y
 # CONFIG_MTD_SBC8240 is not set
+# CONFIG_MTD_INTEL_VR_NOR is not set
 # CONFIG_MTD_PLATRAM is not set
 
 #
@@ -429,10 +440,6 @@ CONFIG_BLK_DEV_LOOP=y
 # CONFIG_SCSI_NETLINK is not set
 # CONFIG_ATA is not set
 # CONFIG_MD is not set
-
-#
-# Fusion MPT device support
-#
 # CONFIG_FUSION is not set
 
 #
@@ -451,6 +458,7 @@ CONFIG_NETDEVICES=y
 # CONFIG_BONDING is not set
 # CONFIG_EQUALIZER is not set
 CONFIG_TUN=y
+# CONFIG_VETH is not set
 # CONFIG_ARCNET is not set
 CONFIG_PHYLIB=y
 
@@ -476,20 +484,28 @@ CONFIG_MII=y
 # CONFIG_NET_VENDOR_3COM is not set
 # CONFIG_NET_TULIP is not set
 # CONFIG_HP100 is not set
+# CONFIG_IBM_NEW_EMAC_ZMII is not set
+# CONFIG_IBM_NEW_EMAC_RGMII is not set
+# CONFIG_IBM_NEW_EMAC_TAH is not set
+# CONFIG_IBM_NEW_EMAC_EMAC4 is not set
 # CONFIG_NET_PCI is not set
+# CONFIG_B44 is not set
 CONFIG_FS_ENET=y
 # CONFIG_FS_ENET_HAS_SCC is not set
 CONFIG_FS_ENET_HAS_FCC=y
+CONFIG_FS_ENET_MDIO_FCC=y
 CONFIG_NETDEV_1000=y
 # CONFIG_ACENIC is not set
 # CONFIG_DL2K is not set
 # CONFIG_E1000 is not set
+# CONFIG_E1000E is not set
 # CONFIG_NS83820 is not set
 # CONFIG_HAMACHI is not set
 # CONFIG_R8169 is not set
 # CONFIG_SIS190 is not set
 # CONFIG_SKGE is not set
 # CONFIG_SKY2 is not set
+# CONFIG_SK98LIN is not set
 # CONFIG_VIA_VELOCITY is not set
 # CONFIG_TIGON3 is not set
 # CONFIG_BNX2 is not set
@@ -497,11 +513,14 @@ CONFIG_NETDEV_1000=y
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
@@ -539,7 +558,6 @@ CONFIG_INPUT_MOUSEDEV_PSAUX=y
 CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
 CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
 # CONFIG_INPUT_JOYDEV is not set
-# CONFIG_INPUT_TSDEV is not set
 CONFIG_INPUT_EVDEV=y
 # CONFIG_INPUT_EVBUG is not set
 
@@ -609,14 +627,11 @@ CONFIG_UNIX98_PTYS=y
 CONFIG_LEGACY_PTYS=y
 CONFIG_LEGACY_PTY_COUNT=256
 # CONFIG_IPMI_HANDLER is not set
-# CONFIG_WATCHDOG is not set
 CONFIG_HW_RANDOM=y
 # CONFIG_NVRAM is not set
 # CONFIG_GEN_RTC is not set
 # CONFIG_R3964 is not set
 # CONFIG_APPLICOM is not set
-# CONFIG_AGP is not set
-# CONFIG_DRM is not set
 # CONFIG_RAW_DRIVER is not set
 CONFIG_DEVPORT=y
 # CONFIG_I2C is not set
@@ -629,6 +644,13 @@ CONFIG_DEVPORT=y
 # CONFIG_W1 is not set
 # CONFIG_POWER_SUPPLY is not set
 # CONFIG_HWMON is not set
+# CONFIG_WATCHDOG is not set
+
+#
+# Sonics Silicon Backplane
+#
+CONFIG_SSB_POSSIBLE=y
+# CONFIG_SSB is not set
 
 #
 # Multifunction device drivers
@@ -645,16 +667,17 @@ CONFIG_DAB=y
 #
 # Graphics support
 #
+# CONFIG_AGP is not set
+# CONFIG_DRM is not set
+# CONFIG_VGASTATE is not set
+# CONFIG_VIDEO_OUTPUT_CONTROL is not set
+# CONFIG_FB is not set
 # CONFIG_BACKLIGHT_LCD_SUPPORT is not set
 
 #
 # Display device support
 #
 # CONFIG_DISPLAY_SUPPORT is not set
-# CONFIG_VGASTATE is not set
-# CONFIG_VIDEO_OUTPUT_CONTROL is not set
-# CONFIG_FB is not set
-# CONFIG_FB_IBM_GXT4500 is not set
 
 #
 # Sound
@@ -668,19 +691,6 @@ CONFIG_DAB=y
 # CONFIG_RTC_CLASS is not set
 
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
@@ -696,7 +706,6 @@ CONFIG_EXT3_FS_XATTR=y
 # CONFIG_EXT3_FS_POSIX_ACL is not set
 # CONFIG_EXT3_FS_SECURITY is not set
 CONFIG_JBD=y
-# CONFIG_JBD_DEBUG is not set
 CONFIG_FS_MBCACHE=y
 # CONFIG_REISERFS_FS is not set
 # CONFIG_JFS_FS is not set
@@ -736,7 +745,6 @@ CONFIG_SYSFS=y
 CONFIG_TMPFS=y
 # CONFIG_TMPFS_POSIX_ACL is not set
 # CONFIG_HUGETLB_PAGE is not set
-CONFIG_RAMFS=y
 
 #
 # Miscellaneous filesystems
@@ -749,10 +757,7 @@ CONFIG_CRAMFS=y
 # CONFIG_QNX4FS_FS is not set
 # CONFIG_SYSV_FS is not set
 # CONFIG_UFS_FS is not set
-
-#
-# Network File Systems
-#
+CONFIG_NETWORK_FILESYSTEMS=y
 CONFIG_NFS_FS=y
 CONFIG_NFS_V3=y
 CONFIG_NFS_V3_ACL=y
@@ -790,10 +795,6 @@ CONFIG_MSDOS_PARTITION=y
 # CONFIG_KARMA_PARTITION is not set
 # CONFIG_EFI_PARTITION is not set
 # CONFIG_SYSV68_PARTITION is not set
-
-#
-# Native Language Support
-#
 CONFIG_NLS=y
 CONFIG_NLS_DEFAULT="iso8859-1"
 CONFIG_NLS_CODEPAGE_437=y
@@ -852,11 +853,15 @@ CONFIG_PLIST=y
 CONFIG_HAS_IOMEM=y
 CONFIG_HAS_IOPORT=y
 CONFIG_HAS_DMA=y
+CONFIG_INSTRUMENTATION=y
+# CONFIG_PROFILING is not set
+# CONFIG_MARKERS is not set
 
 #
 # Kernel hacking
 #
 # CONFIG_PRINTK_TIME is not set
+CONFIG_ENABLE_WARN_DEPRECATED=y
 CONFIG_ENABLE_MUST_CHECK=y
 CONFIG_MAGIC_SYSRQ=y
 # CONFIG_UNUSED_SYMBOLS is not set
@@ -880,8 +885,11 @@ CONFIG_DEBUG_BUGVERBOSE=y
 CONFIG_DEBUG_INFO=y
 # CONFIG_DEBUG_VM is not set
 # CONFIG_DEBUG_LIST is not set
+# CONFIG_DEBUG_SG is not set
 CONFIG_FORCED_INLINING=y
+# CONFIG_BOOT_PRINTK_DELAY is not set
 # CONFIG_FAULT_INJECTION is not set
+# CONFIG_SAMPLES is not set
 # CONFIG_DEBUG_STACKOVERFLOW is not set
 # CONFIG_DEBUG_STACK_USAGE is not set
 # CONFIG_DEBUG_PAGEALLOC is not set
@@ -924,8 +932,12 @@ CONFIG_CRYPTO_DES=y
 # CONFIG_CRYPTO_ARC4 is not set
 # CONFIG_CRYPTO_KHAZAD is not set
 # CONFIG_CRYPTO_ANUBIS is not set
+# CONFIG_CRYPTO_SEED is not set
 # CONFIG_CRYPTO_DEFLATE is not set
 # CONFIG_CRYPTO_MICHAEL_MIC is not set
 # CONFIG_CRYPTO_CRC32C is not set
 # CONFIG_CRYPTO_CAMELLIA is not set
+# CONFIG_CRYPTO_AUTHENC is not set
 # CONFIG_CRYPTO_HW is not set
+# CONFIG_PPC_CLOCK is not set
+CONFIG_PPC_LIB_RHEAP=y
diff --git a/arch/powerpc/configs/pq2fads_defconfig b/arch/powerpc/configs/pq2fads_defconfig
index 9191f55..6b17562 100644
--- a/arch/powerpc/configs/pq2fads_defconfig
+++ b/arch/powerpc/configs/pq2fads_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.23-rc4
-# Thu Aug 30 11:58:17 2007
+# Linux kernel version: 2.6.24-rc3
+# Mon Dec 10 11:01:07 2007
 #
 # CONFIG_PPC64 is not set
 
@@ -20,8 +20,13 @@ CONFIG_PPC_STD_MMU_32=y
 # CONFIG_PPC_MM_SLICES is not set
 # CONFIG_SMP is not set
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
@@ -63,6 +68,10 @@ CONFIG_SYSVIPC_SYSCTL=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=14
+# CONFIG_CGROUPS is not set
+CONFIG_FAIR_GROUP_SCHED=y
+CONFIG_FAIR_USER_SCHED=y
+# CONFIG_FAIR_CGROUP_SCHED is not set
 # CONFIG_SYSFS_DEPRECATED is not set
 # CONFIG_RELAY is not set
 CONFIG_BLK_DEV_INITRD=y
@@ -82,7 +91,6 @@ CONFIG_FUTEX=y
 CONFIG_ANON_INODES=y
 CONFIG_EPOLL=y
 CONFIG_SIGNALFD=y
-CONFIG_TIMERFD=y
 CONFIG_EVENTFD=y
 CONFIG_SHMEM=y
 CONFIG_VM_EVENT_COUNTERS=y
@@ -116,7 +124,6 @@ CONFIG_DEFAULT_IOSCHED="anticipatory"
 # Platform support
 #
 # CONFIG_PPC_MULTIPLATFORM is not set
-# CONFIG_EMBEDDED6xx is not set
 CONFIG_PPC_82xx=y
 # CONFIG_PPC_83xx is not set
 # CONFIG_PPC_86xx is not set
@@ -126,7 +133,6 @@ CONFIG_PPC_82xx=y
 # CONFIG_PPC_CELL_NATIVE is not set
 # CONFIG_MPC8272_ADS is not set
 CONFIG_PQ2FADS=y
-# CONFIG_EP8248E is not set
 CONFIG_PQ2ADS=y
 CONFIG_8260=y
 CONFIG_PQ2_ADS_PCI_PIC=y
@@ -149,6 +155,10 @@ CONFIG_CPM=y
 # Kernel options
 #
 # CONFIG_HIGHMEM is not set
+# CONFIG_TICK_ONESHOT is not set
+# CONFIG_NO_HZ is not set
+# CONFIG_HIGH_RES_TIMERS is not set
+CONFIG_GENERIC_CLOCKEVENTS_BUILD=y
 # CONFIG_HZ_100 is not set
 CONFIG_HZ_250=y
 # CONFIG_HZ_300 is not set
@@ -165,6 +175,7 @@ CONFIG_ARCH_POPULATES_NODE_MAP=y
 CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
+# CONFIG_SPARSEMEM_VMEMMAP_ENABLE is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
 # CONFIG_RESOURCES_64BIT is not set
 CONFIG_ZONE_DMA_FLAG=1
@@ -173,6 +184,8 @@ CONFIG_VIRT_TO_BUS=y
 CONFIG_PROC_DEVICETREE=y
 # CONFIG_CMDLINE_BOOL is not set
 # CONFIG_PM is not set
+CONFIG_SUSPEND_UP_POSSIBLE=y
+CONFIG_HIBERNATION_UP_POSSIBLE=y
 CONFIG_SECCOMP=y
 CONFIG_WANT_DEVICE_TREE=y
 CONFIG_DEVICE_TREE="pq2fads.dts"
@@ -192,11 +205,8 @@ CONFIG_PCI_8260=y
 # CONFIG_PCIEPORTBUS is not set
 CONFIG_ARCH_SUPPORTS_MSI=y
 # CONFIG_PCI_MSI is not set
+CONFIG_PCI_LEGACY=y
 # CONFIG_PCI_DEBUG is not set
-
-#
-# PCCARD (PCMCIA/CardBus) support
-#
 # CONFIG_PCCARD is not set
 
 #
@@ -210,7 +220,7 @@ CONFIG_ARCH_SUPPORTS_MSI=y
 CONFIG_HIGHMEM_START=0xfe000000
 CONFIG_LOWMEM_SIZE=0x30000000
 CONFIG_KERNEL_START=0xc0000000
-CONFIG_TASK_SIZE=0x80000000
+CONFIG_TASK_SIZE=0xc0000000
 CONFIG_BOOT_LOAD=0x00400000
 
 #
@@ -247,6 +257,7 @@ CONFIG_INET_TUNNEL=y
 CONFIG_INET_XFRM_MODE_TRANSPORT=y
 CONFIG_INET_XFRM_MODE_TUNNEL=y
 CONFIG_INET_XFRM_MODE_BEET=y
+# CONFIG_INET_LRO is not set
 CONFIG_INET_DIAG=y
 CONFIG_INET_TCP_DIAG=y
 # CONFIG_TCP_CONG_ADVANCED is not set
@@ -290,10 +301,6 @@ CONFIG_NETFILTER=y
 # CONFIG_LLC2 is not set
 # CONFIG_IPX is not set
 # CONFIG_ATALK is not set
-
-#
-# QoS and/or fair queueing
-#
 # CONFIG_NET_SCHED is not set
 
 #
@@ -319,6 +326,7 @@ CONFIG_NETFILTER=y
 #
 # Generic Driver Options
 #
+CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_STANDALONE=y
 CONFIG_PREVENT_FIRMWARE_BUILD=y
 # CONFIG_FW_LOADER is not set
@@ -342,6 +350,7 @@ CONFIG_MTD_BLOCK=y
 # CONFIG_INFTL is not set
 # CONFIG_RFD_FTL is not set
 # CONFIG_SSFDC is not set
+# CONFIG_MTD_OOPS is not set
 
 #
 # RAM/ROM/Flash chip drivers
@@ -380,6 +389,7 @@ CONFIG_MTD_CFI_UTIL=y
 # CONFIG_MTD_PHYSMAP is not set
 CONFIG_MTD_PHYSMAP_OF=y
 # CONFIG_MTD_SBC8240 is not set
+# CONFIG_MTD_INTEL_VR_NOR is not set
 # CONFIG_MTD_PLATRAM is not set
 
 #
@@ -442,10 +452,40 @@ CONFIG_IDE_PROC_FS=y
 # IDE chipset support/bugfixes
 #
 # CONFIG_IDE_GENERIC is not set
-# CONFIG_BLK_DEV_IDEPCI is not set
+# CONFIG_BLK_DEV_PLATFORM is not set
+
+#
+# PCI IDE chipsets support
+#
 # CONFIG_IDEPCI_PCIBUS_ORDER is not set
+# CONFIG_BLK_DEV_GENERIC is not set
+# CONFIG_BLK_DEV_AEC62XX is not set
+# CONFIG_BLK_DEV_ALI15X3 is not set
+# CONFIG_BLK_DEV_AMD74XX is not set
+# CONFIG_BLK_DEV_CMD64X is not set
+# CONFIG_BLK_DEV_TRIFLEX is not set
+# CONFIG_BLK_DEV_CY82C693 is not set
+# CONFIG_BLK_DEV_CS5530 is not set
+# CONFIG_BLK_DEV_HPT34X is not set
+# CONFIG_BLK_DEV_HPT366 is not set
+# CONFIG_BLK_DEV_JMICRON is not set
+# CONFIG_BLK_DEV_SC1200 is not set
+# CONFIG_BLK_DEV_PIIX is not set
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
 # CONFIG_IDE_ARM is not set
 # CONFIG_BLK_DEV_IDEDMA is not set
+CONFIG_IDE_ARCH_OBSOLETE_INIT=y
 # CONFIG_BLK_DEV_HD is not set
 
 #
@@ -457,10 +497,6 @@ CONFIG_IDE_PROC_FS=y
 # CONFIG_SCSI_NETLINK is not set
 # CONFIG_ATA is not set
 # CONFIG_MD is not set
-
-#
-# Fusion MPT device support
-#
 # CONFIG_FUSION is not set
 
 #
@@ -479,6 +515,7 @@ CONFIG_NETDEVICES=y
 # CONFIG_BONDING is not set
 # CONFIG_EQUALIZER is not set
 CONFIG_TUN=y
+# CONFIG_VETH is not set
 # CONFIG_ARCNET is not set
 CONFIG_PHYLIB=y
 
@@ -504,20 +541,28 @@ CONFIG_MII=y
 # CONFIG_NET_VENDOR_3COM is not set
 # CONFIG_NET_TULIP is not set
 # CONFIG_HP100 is not set
+# CONFIG_IBM_NEW_EMAC_ZMII is not set
+# CONFIG_IBM_NEW_EMAC_RGMII is not set
+# CONFIG_IBM_NEW_EMAC_TAH is not set
+# CONFIG_IBM_NEW_EMAC_EMAC4 is not set
 # CONFIG_NET_PCI is not set
+# CONFIG_B44 is not set
 CONFIG_FS_ENET=y
 # CONFIG_FS_ENET_HAS_SCC is not set
 CONFIG_FS_ENET_HAS_FCC=y
+CONFIG_FS_ENET_MDIO_FCC=y
 CONFIG_NETDEV_1000=y
 # CONFIG_ACENIC is not set
 # CONFIG_DL2K is not set
 # CONFIG_E1000 is not set
+# CONFIG_E1000E is not set
 # CONFIG_NS83820 is not set
 # CONFIG_HAMACHI is not set
 # CONFIG_R8169 is not set
 # CONFIG_SIS190 is not set
 # CONFIG_SKGE is not set
 # CONFIG_SKY2 is not set
+# CONFIG_SK98LIN is not set
 # CONFIG_VIA_VELOCITY is not set
 # CONFIG_TIGON3 is not set
 # CONFIG_BNX2 is not set
@@ -525,11 +570,14 @@ CONFIG_NETDEV_1000=y
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
@@ -567,7 +615,6 @@ CONFIG_INPUT_MOUSEDEV_PSAUX=y
 CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
 CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
 # CONFIG_INPUT_JOYDEV is not set
-# CONFIG_INPUT_TSDEV is not set
 CONFIG_INPUT_EVDEV=y
 # CONFIG_INPUT_EVBUG is not set
 
@@ -638,14 +685,11 @@ CONFIG_UNIX98_PTYS=y
 CONFIG_LEGACY_PTYS=y
 CONFIG_LEGACY_PTY_COUNT=256
 # CONFIG_IPMI_HANDLER is not set
-# CONFIG_WATCHDOG is not set
 CONFIG_HW_RANDOM=y
 # CONFIG_NVRAM is not set
 # CONFIG_GEN_RTC is not set
 # CONFIG_R3964 is not set
 # CONFIG_APPLICOM is not set
-# CONFIG_AGP is not set
-# CONFIG_DRM is not set
 # CONFIG_RAW_DRIVER is not set
 CONFIG_DEVPORT=y
 # CONFIG_I2C is not set
@@ -658,6 +702,13 @@ CONFIG_DEVPORT=y
 # CONFIG_W1 is not set
 # CONFIG_POWER_SUPPLY is not set
 # CONFIG_HWMON is not set
+# CONFIG_WATCHDOG is not set
+
+#
+# Sonics Silicon Backplane
+#
+CONFIG_SSB_POSSIBLE=y
+# CONFIG_SSB is not set
 
 #
 # Multifunction device drivers
@@ -674,16 +725,17 @@ CONFIG_DAB=y
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
 # Sound
@@ -707,6 +759,7 @@ CONFIG_USB_GADGET=y
 # CONFIG_USB_GADGET_DEBUG_FILES is not set
 CONFIG_USB_GADGET_SELECTED=y
 # CONFIG_USB_GADGET_AMD5536UDC is not set
+# CONFIG_USB_GADGET_ATMEL_USBA is not set
 # CONFIG_USB_GADGET_FSL_USB2 is not set
 # CONFIG_USB_GADGET_NET2280 is not set
 # CONFIG_USB_GADGET_PXA2XX is not set
@@ -731,19 +784,6 @@ CONFIG_USB_ETH=y
 # CONFIG_RTC_CLASS is not set
 
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
@@ -759,7 +799,6 @@ CONFIG_EXT3_FS_XATTR=y
 # CONFIG_EXT3_FS_POSIX_ACL is not set
 # CONFIG_EXT3_FS_SECURITY is not set
 CONFIG_JBD=y
-# CONFIG_JBD_DEBUG is not set
 CONFIG_FS_MBCACHE=y
 # CONFIG_REISERFS_FS is not set
 # CONFIG_JFS_FS is not set
@@ -799,7 +838,6 @@ CONFIG_SYSFS=y
 CONFIG_TMPFS=y
 # CONFIG_TMPFS_POSIX_ACL is not set
 # CONFIG_HUGETLB_PAGE is not set
-CONFIG_RAMFS=y
 
 #
 # Miscellaneous filesystems
@@ -812,10 +850,7 @@ CONFIG_CRAMFS=y
 # CONFIG_QNX4FS_FS is not set
 # CONFIG_SYSV_FS is not set
 # CONFIG_UFS_FS is not set
-
-#
-# Network File Systems
-#
+CONFIG_NETWORK_FILESYSTEMS=y
 CONFIG_NFS_FS=y
 CONFIG_NFS_V3=y
 CONFIG_NFS_V3_ACL=y
@@ -853,10 +888,6 @@ CONFIG_MSDOS_PARTITION=y
 # CONFIG_KARMA_PARTITION is not set
 # CONFIG_EFI_PARTITION is not set
 # CONFIG_SYSV68_PARTITION is not set
-
-#
-# Native Language Support
-#
 CONFIG_NLS=y
 CONFIG_NLS_DEFAULT="iso8859-1"
 CONFIG_NLS_CODEPAGE_437=y
@@ -915,11 +946,15 @@ CONFIG_PLIST=y
 CONFIG_HAS_IOMEM=y
 CONFIG_HAS_IOPORT=y
 CONFIG_HAS_DMA=y
+CONFIG_INSTRUMENTATION=y
+# CONFIG_PROFILING is not set
+# CONFIG_MARKERS is not set
 
 #
 # Kernel hacking
 #
 # CONFIG_PRINTK_TIME is not set
+CONFIG_ENABLE_WARN_DEPRECATED=y
 CONFIG_ENABLE_MUST_CHECK=y
 CONFIG_MAGIC_SYSRQ=y
 # CONFIG_UNUSED_SYMBOLS is not set
@@ -943,8 +978,11 @@ CONFIG_DEBUG_BUGVERBOSE=y
 CONFIG_DEBUG_INFO=y
 # CONFIG_DEBUG_VM is not set
 # CONFIG_DEBUG_LIST is not set
+# CONFIG_DEBUG_SG is not set
 CONFIG_FORCED_INLINING=y
+# CONFIG_BOOT_PRINTK_DELAY is not set
 # CONFIG_FAULT_INJECTION is not set
+# CONFIG_SAMPLES is not set
 # CONFIG_DEBUG_STACKOVERFLOW is not set
 # CONFIG_DEBUG_STACK_USAGE is not set
 # CONFIG_DEBUG_PAGEALLOC is not set
@@ -952,16 +990,6 @@ CONFIG_FORCED_INLINING=y
 # CONFIG_KGDB_CONSOLE is not set
 CONFIG_BDI_SWITCH=y
 # CONFIG_PPC_EARLY_DEBUG is not set
-# CONFIG_PPC_EARLY_DEBUG_LPAR is not set
-# CONFIG_PPC_EARLY_DEBUG_G5 is not set
-# CONFIG_PPC_EARLY_DEBUG_RTAS_PANEL is not set
-# CONFIG_PPC_EARLY_DEBUG_RTAS_CONSOLE is not set
-# CONFIG_PPC_EARLY_DEBUG_MAPLE is not set
-# CONFIG_PPC_EARLY_DEBUG_ISERIES is not set
-# CONFIG_PPC_EARLY_DEBUG_PAS_REALMODE is not set
-# CONFIG_PPC_EARLY_DEBUG_BEAT is not set
-# CONFIG_PPC_EARLY_DEBUG_44x is not set
-# CONFIG_PPC_EARLY_DEBUG_CPM is not set
 
 #
 # Security options
@@ -997,8 +1025,12 @@ CONFIG_CRYPTO_DES=y
 # CONFIG_CRYPTO_ARC4 is not set
 # CONFIG_CRYPTO_KHAZAD is not set
 # CONFIG_CRYPTO_ANUBIS is not set
+# CONFIG_CRYPTO_SEED is not set
 # CONFIG_CRYPTO_DEFLATE is not set
 # CONFIG_CRYPTO_MICHAEL_MIC is not set
 # CONFIG_CRYPTO_CRC32C is not set
 # CONFIG_CRYPTO_CAMELLIA is not set
+# CONFIG_CRYPTO_AUTHENC is not set
 CONFIG_CRYPTO_HW=y
+# CONFIG_PPC_CLOCK is not set
+CONFIG_PPC_LIB_RHEAP=y
-- 
1.5.3.4
