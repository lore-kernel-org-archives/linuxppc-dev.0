Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id E16E0DDEFE
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Mar 2008 14:27:44 +1100 (EST)
Date: Thu, 27 Mar 2008 14:27:43 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Olof Johansson <olof@lixom.net>
Subject: [PATCH] [POWERPC] Remove CONFIG_PCI_LEGACY from pasemi_defconfig
Message-Id: <20080327142743.82c4f0fb.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This should eliminate several build warnings and only removes the
possibility of building some ISDN drivers that we don't build anyway.

It was done by copying pasemi_defconfig to .config, removing
CONFIG_PCI_LEGACY, running make oldconfig and taking the defaults for
everything except CONFIG_PCI_LEGACY.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/configs/pasemi_defconfig |  139 ++++++++++++++++++++++-----------
 1 files changed, 93 insertions(+), 46 deletions(-)

Olof,  you should review this carefully to see if anything got turned off
that you need (e.g. CONFIG_MTD_NAND_PASEMI) or turned on that you don't
want (e.g. "Conflicting RTC option has been selected, check GEN_RTC and
RTC").  I have built this config.  This patch is on top of the powerpc
master tree.

diff --git a/arch/powerpc/configs/pasemi_defconfig b/arch/powerpc/configs/pasemi_defconfig
index 797f0df..419ca4e 100644
--- a/arch/powerpc/configs/pasemi_defconfig
+++ b/arch/powerpc/configs/pasemi_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.24-rc6
-# Tue Jan 15 10:26:10 2008
+# Linux kernel version: 2.6.25-rc6
+# Thu Mar 27 13:56:20 2008
 #
 CONFIG_PPC64=y
 
@@ -27,6 +27,7 @@ CONFIG_GENERIC_TIME=y
 CONFIG_GENERIC_TIME_VSYSCALL=y
 CONFIG_GENERIC_CLOCKEVENTS=y
 CONFIG_GENERIC_HARDIRQS=y
+CONFIG_HAVE_SETUP_PER_CPU_AREA=y
 CONFIG_IRQ_PER_CPU=y
 CONFIG_RWSEM_XCHGADD_ALGORITHM=y
 CONFIG_ARCH_HAS_ILOG2_U32=y
@@ -67,17 +68,23 @@ CONFIG_SYSVIPC_SYSCTL=y
 # CONFIG_POSIX_MQUEUE is not set
 # CONFIG_BSD_PROCESS_ACCT is not set
 # CONFIG_TASKSTATS is not set
-# CONFIG_USER_NS is not set
-# CONFIG_PID_NS is not set
 # CONFIG_AUDIT is not set
 # CONFIG_IKCONFIG is not set
 CONFIG_LOG_BUF_SHIFT=17
 # CONFIG_CGROUPS is not set
+CONFIG_GROUP_SCHED=y
 CONFIG_FAIR_GROUP_SCHED=y
-CONFIG_FAIR_USER_SCHED=y
-# CONFIG_FAIR_CGROUP_SCHED is not set
+# CONFIG_RT_GROUP_SCHED is not set
+CONFIG_USER_SCHED=y
+# CONFIG_CGROUP_SCHED is not set
 CONFIG_SYSFS_DEPRECATED=y
+CONFIG_SYSFS_DEPRECATED_V2=y
 # CONFIG_RELAY is not set
+CONFIG_NAMESPACES=y
+# CONFIG_UTS_NS is not set
+# CONFIG_IPC_NS is not set
+# CONFIG_USER_NS is not set
+# CONFIG_PID_NS is not set
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_INITRAMFS_SOURCE=""
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
@@ -91,11 +98,13 @@ CONFIG_HOTPLUG=y
 CONFIG_PRINTK=y
 CONFIG_BUG=y
 CONFIG_ELF_CORE=y
+CONFIG_COMPAT_BRK=y
 CONFIG_BASE_FULL=y
 CONFIG_FUTEX=y
 CONFIG_ANON_INODES=y
 CONFIG_EPOLL=y
 CONFIG_SIGNALFD=y
+CONFIG_TIMERFD=y
 CONFIG_EVENTFD=y
 CONFIG_SHMEM=y
 CONFIG_VM_EVENT_COUNTERS=y
@@ -103,6 +112,15 @@ CONFIG_SLUB_DEBUG=y
 # CONFIG_SLAB is not set
 CONFIG_SLUB=y
 # CONFIG_SLOB is not set
+CONFIG_PROFILING=y
+# CONFIG_MARKERS is not set
+CONFIG_OPROFILE=y
+CONFIG_HAVE_OPROFILE=y
+# CONFIG_KPROBES is not set
+CONFIG_HAVE_KPROBES=y
+CONFIG_HAVE_KRETPROBES=y
+CONFIG_PROC_PAGE_MONITOR=y
+CONFIG_SLABINFO=y
 CONFIG_RT_MUTEXES=y
 # CONFIG_TINY_SHMEM is not set
 CONFIG_BASE_SMALL=0
@@ -130,6 +148,7 @@ CONFIG_DEFAULT_AS=y
 # CONFIG_DEFAULT_CFQ is not set
 # CONFIG_DEFAULT_NOOP is not set
 CONFIG_DEFAULT_IOSCHED="anticipatory"
+CONFIG_CLASSIC_RCU=y
 
 #
 # Platform support
@@ -140,8 +159,8 @@ CONFIG_PPC_MULTIPLATFORM=y
 # CONFIG_PPC_86xx is not set
 # CONFIG_PPC_PSERIES is not set
 # CONFIG_PPC_ISERIES is not set
-# CONFIG_PPC_MPC52xx is not set
-# CONFIG_PPC_MPC5200 is not set
+# CONFIG_PPC_MPC512x is not set
+# CONFIG_PPC_MPC5121 is not set
 # CONFIG_PPC_PMAC is not set
 # CONFIG_PPC_MAPLE is not set
 CONFIG_PPC_PASEMI=y
@@ -159,6 +178,7 @@ CONFIG_PPC_PASEMI_MDIO=y
 # CONFIG_PPC_IBM_CELL_BLADE is not set
 # CONFIG_PQ2ADS is not set
 CONFIG_PPC_NATIVE=y
+# CONFIG_IPIC is not set
 CONFIG_MPIC=y
 # CONFIG_MPIC_WEIRD is not set
 # CONFIG_PPC_I8259 is not set
@@ -189,7 +209,6 @@ CONFIG_CPU_FREQ_GOV_ONDEMAND=y
 # CPU Frequency drivers
 #
 CONFIG_PPC_PASEMI_CPUFREQ=y
-# CONFIG_CPM2 is not set
 # CONFIG_FSL_ULI1575 is not set
 
 #
@@ -204,16 +223,20 @@ CONFIG_GENERIC_CLOCKEVENTS_BUILD=y
 # CONFIG_HZ_300 is not set
 CONFIG_HZ_1000=y
 CONFIG_HZ=1000
+# CONFIG_SCHED_HRTICK is not set
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
-# CONFIG_PREEMPT_BKL is not set
 CONFIG_BINFMT_ELF=y
+CONFIG_COMPAT_BINFMT_ELF=y
 # CONFIG_BINFMT_MISC is not set
 CONFIG_FORCE_MAX_ZONEORDER=9
 CONFIG_HUGETLB_PAGE_SIZE_VARIABLE=y
 CONFIG_IOMMU_VMERGE=y
+CONFIG_IOMMU_HELPER=y
 CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
+CONFIG_ARCH_HAS_WALK_MEMORY=y
+CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
 # CONFIG_KEXEC is not set
 # CONFIG_CRASH_DUMP is not set
 # CONFIG_IRQ_ALL_CPUS is not set
@@ -236,12 +259,12 @@ CONFIG_ZONE_DMA_FLAG=1
 CONFIG_BOUNCE=y
 CONFIG_PPC_HAS_HASH_64K=y
 CONFIG_PPC_64K_PAGES=y
+# CONFIG_PPC_SUBPAGE_PROT is not set
 # CONFIG_SCHED_SMT is not set
 CONFIG_PROC_DEVICETREE=y
 # CONFIG_CMDLINE_BOOL is not set
 # CONFIG_PM is not set
 # CONFIG_SECCOMP is not set
-# CONFIG_WANT_DEVICE_TREE is not set
 CONFIG_ISA_DMA_API=y
 
 #
@@ -256,7 +279,7 @@ CONFIG_PCI_SYSCALL=y
 # CONFIG_PCIEPORTBUS is not set
 CONFIG_ARCH_SUPPORTS_MSI=y
 CONFIG_PCI_MSI=y
-CONFIG_PCI_LEGACY=y
+# CONFIG_PCI_LEGACY is not set
 # CONFIG_PCI_DEBUG is not set
 CONFIG_PCCARD=y
 CONFIG_PCMCIA_DEBUG=y
@@ -290,6 +313,7 @@ CONFIG_XFRM=y
 CONFIG_XFRM_USER=y
 # CONFIG_XFRM_SUB_POLICY is not set
 # CONFIG_XFRM_MIGRATE is not set
+# CONFIG_XFRM_STATISTICS is not set
 CONFIG_NET_KEY=y
 # CONFIG_NET_KEY_MIGRATE is not set
 CONFIG_INET=y
@@ -346,6 +370,7 @@ CONFIG_DEFAULT_TCP_CONG="cubic"
 #
 # CONFIG_NET_PKTGEN is not set
 # CONFIG_HAMRADIO is not set
+# CONFIG_CAN is not set
 # CONFIG_IRDA is not set
 # CONFIG_BT is not set
 # CONFIG_AF_RXRPC is not set
@@ -441,8 +466,10 @@ CONFIG_MTD_NAND=y
 CONFIG_MTD_NAND_IDS=y
 # CONFIG_MTD_NAND_DISKONCHIP is not set
 # CONFIG_MTD_NAND_CAFE is not set
+# CONFIG_MTD_NAND_PASEMI is not set
 # CONFIG_MTD_NAND_PLATFORM is not set
 # CONFIG_MTD_ALAUDA is not set
+# CONFIG_MTD_NAND_FSL_ELBC is not set
 # CONFIG_MTD_ONENAND is not set
 
 #
@@ -465,7 +492,7 @@ CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_COUNT=16
 CONFIG_BLK_DEV_RAM_SIZE=16384
-CONFIG_BLK_DEV_RAM_BLOCKSIZE=1024
+# CONFIG_BLK_DEV_XIP is not set
 # CONFIG_CDROM_PKTCDVD is not set
 # CONFIG_ATA_OVER_ETH is not set
 CONFIG_MISC_DEVICES=y
@@ -473,11 +500,13 @@ CONFIG_MISC_DEVICES=y
 # CONFIG_EEPROM_93CX6 is not set
 # CONFIG_SGI_IOC4 is not set
 # CONFIG_TIFM_CORE is not set
+# CONFIG_ENCLOSURE_SERVICES is not set
+CONFIG_HAVE_IDE=y
 CONFIG_IDE=y
 CONFIG_BLK_DEV_IDE=y
 
 #
-# Please see Documentation/ide.txt for help/info on IDE drives
+# Please see Documentation/ide/ide.txt for help/info on IDE drives
 #
 # CONFIG_BLK_DEV_IDE_SATA is not set
 CONFIG_BLK_DEV_IDEDISK=y
@@ -485,6 +514,7 @@ CONFIG_IDEDISK_MULTI_MODE=y
 # CONFIG_BLK_DEV_IDECS is not set
 # CONFIG_BLK_DEV_DELKIN is not set
 CONFIG_BLK_DEV_IDECD=y
+CONFIG_BLK_DEV_IDECD_VERBOSE_ERRORS=y
 # CONFIG_BLK_DEV_IDETAPE is not set
 # CONFIG_BLK_DEV_IDEFLOPPY is not set
 CONFIG_BLK_DEV_IDESCSI=y
@@ -500,7 +530,6 @@ CONFIG_IDE_PROC_FS=y
 #
 # PCI IDE chipsets support
 #
-# CONFIG_IDEPCI_PCIBUS_ORDER is not set
 # CONFIG_BLK_DEV_GENERIC is not set
 # CONFIG_BLK_DEV_OPTI621 is not set
 # CONFIG_BLK_DEV_AEC62XX is not set
@@ -528,7 +557,6 @@ CONFIG_IDE_PROC_FS=y
 # CONFIG_BLK_DEV_TRM290 is not set
 # CONFIG_BLK_DEV_VIA82CXXX is not set
 # CONFIG_BLK_DEV_TC86C001 is not set
-# CONFIG_IDE_ARM is not set
 # CONFIG_BLK_DEV_IDEDMA is not set
 CONFIG_IDE_ARCH_OBSOLETE_INIT=y
 # CONFIG_BLK_DEV_HD is not set
@@ -593,6 +621,7 @@ CONFIG_SCSI_LOWLEVEL=y
 # CONFIG_SCSI_IPS is not set
 # CONFIG_SCSI_INITIO is not set
 # CONFIG_SCSI_INIA100 is not set
+# CONFIG_SCSI_MVSAS is not set
 # CONFIG_SCSI_STEX is not set
 # CONFIG_SCSI_SYM53C8XX_2 is not set
 # CONFIG_SCSI_IPR is not set
@@ -646,6 +675,7 @@ CONFIG_ATA_GENERIC=y
 # CONFIG_PATA_MPIIX is not set
 # CONFIG_PATA_OLDPIIX is not set
 # CONFIG_PATA_NETCELL is not set
+# CONFIG_PATA_NINJA32 is not set
 # CONFIG_PATA_NS87410 is not set
 # CONFIG_PATA_NS87415 is not set
 # CONFIG_PATA_OPTI is not set
@@ -699,7 +729,6 @@ CONFIG_DUMMY=y
 # CONFIG_EQUALIZER is not set
 # CONFIG_TUN is not set
 # CONFIG_VETH is not set
-# CONFIG_IP1000 is not set
 # CONFIG_ARCNET is not set
 CONFIG_PHYLIB=y
 
@@ -715,6 +744,7 @@ CONFIG_MARVELL_PHY=y
 # CONFIG_SMSC_PHY is not set
 # CONFIG_BROADCOM_PHY is not set
 # CONFIG_ICPLUS_PHY is not set
+# CONFIG_REALTEK_PHY is not set
 # CONFIG_FIXED_PHY is not set
 # CONFIG_MDIO_BITBANG is not set
 CONFIG_NET_ETHERNET=y
@@ -742,6 +772,7 @@ CONFIG_NET_PCI=y
 # CONFIG_NE2K_PCI is not set
 # CONFIG_8139CP is not set
 # CONFIG_8139TOO is not set
+# CONFIG_R6040 is not set
 # CONFIG_SIS900 is not set
 # CONFIG_EPIC100 is not set
 # CONFIG_SUNDANCE is not set
@@ -754,6 +785,9 @@ CONFIG_E1000=y
 CONFIG_E1000_NAPI=y
 # CONFIG_E1000_DISABLE_PACKET_SPLIT is not set
 # CONFIG_E1000E is not set
+# CONFIG_E1000E_ENABLED is not set
+# CONFIG_IP1000 is not set
+# CONFIG_IGB is not set
 # CONFIG_NS83820 is not set
 # CONFIG_HAMACHI is not set
 # CONFIG_YELLOWFIN is not set
@@ -779,6 +813,7 @@ CONFIG_NETDEV_10000=y
 CONFIG_PASEMI_MAC=y
 # CONFIG_MLX4_CORE is not set
 # CONFIG_TEHUTI is not set
+# CONFIG_BNX2X is not set
 # CONFIG_TR is not set
 
 #
@@ -802,7 +837,6 @@ CONFIG_PASEMI_MAC=y
 # CONFIG_PPP is not set
 # CONFIG_SLIP is not set
 # CONFIG_NET_FC is not set
-# CONFIG_SHAPER is not set
 # CONFIG_NETCONSOLE is not set
 # CONFIG_NETPOLL is not set
 # CONFIG_NET_POLL_CONTROLLER is not set
@@ -861,6 +895,7 @@ CONFIG_VT_CONSOLE=y
 CONFIG_HW_CONSOLE=y
 # CONFIG_VT_HW_CONSOLE_BINDING is not set
 # CONFIG_SERIAL_NONSTANDARD is not set
+# CONFIG_NOZOMI is not set
 
 #
 # Serial drivers
@@ -897,6 +932,7 @@ CONFIG_GEN_RTC_X=y
 # CONFIG_SYNCLINK_CS is not set
 # CONFIG_CARDMAN_4000 is not set
 # CONFIG_CARDMAN_4040 is not set
+# CONFIG_IPWIRELESS is not set
 CONFIG_RAW_DRIVER=y
 CONFIG_MAX_RAW_DEVS=256
 # CONFIG_HANGCHECK_TIMER is not set
@@ -944,13 +980,12 @@ CONFIG_I2C_PASEMI=y
 #
 # Miscellaneous I2C Chip support
 #
-# CONFIG_SENSORS_DS1337 is not set
-# CONFIG_SENSORS_DS1374 is not set
 # CONFIG_DS1682 is not set
 CONFIG_SENSORS_EEPROM=y
 # CONFIG_SENSORS_PCF8574 is not set
-# CONFIG_SENSORS_PCA9539 is not set
+# CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCF8591 is not set
+# CONFIG_TPS65010 is not set
 # CONFIG_SENSORS_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
@@ -975,6 +1010,7 @@ CONFIG_HWMON_VID=y
 # CONFIG_SENSORS_ADM1031 is not set
 # CONFIG_SENSORS_ADM9240 is not set
 # CONFIG_SENSORS_ADT7470 is not set
+# CONFIG_SENSORS_ADT7473 is not set
 # CONFIG_SENSORS_ATXP1 is not set
 # CONFIG_SENSORS_DS1621 is not set
 # CONFIG_SENSORS_I5K_AMB is not set
@@ -1004,6 +1040,7 @@ CONFIG_SENSORS_LM90=y
 # CONFIG_SENSORS_SMSC47M1 is not set
 # CONFIG_SENSORS_SMSC47M192 is not set
 # CONFIG_SENSORS_SMSC47B397 is not set
+# CONFIG_SENSORS_ADS7828 is not set
 # CONFIG_SENSORS_THMC50 is not set
 # CONFIG_SENSORS_VIA686A is not set
 # CONFIG_SENSORS_VT1211 is not set
@@ -1013,9 +1050,11 @@ CONFIG_SENSORS_LM90=y
 # CONFIG_SENSORS_W83792D is not set
 # CONFIG_SENSORS_W83793 is not set
 # CONFIG_SENSORS_W83L785TS is not set
+# CONFIG_SENSORS_W83L786NG is not set
 # CONFIG_SENSORS_W83627HF is not set
 # CONFIG_SENSORS_W83627EHF is not set
 # CONFIG_HWMON_DEBUG_CHIP is not set
+# CONFIG_THERMAL is not set
 # CONFIG_WATCHDOG is not set
 
 #
@@ -1183,6 +1222,7 @@ CONFIG_SND_VERBOSE_PROCFS=y
 # CONFIG_SND_BT87X is not set
 # CONFIG_SND_CA0106 is not set
 # CONFIG_SND_CMIPCI is not set
+# CONFIG_SND_OXYGEN is not set
 # CONFIG_SND_CS4281 is not set
 # CONFIG_SND_CS46XX is not set
 # CONFIG_SND_CS5530 is not set
@@ -1208,6 +1248,7 @@ CONFIG_SND_VERBOSE_PROCFS=y
 # CONFIG_SND_HDA_INTEL is not set
 # CONFIG_SND_HDSP is not set
 # CONFIG_SND_HDSPM is not set
+# CONFIG_SND_HIFIER is not set
 # CONFIG_SND_ICE1712 is not set
 # CONFIG_SND_ICE1724 is not set
 # CONFIG_SND_INTEL8X0 is not set
@@ -1225,6 +1266,7 @@ CONFIG_SND_VERBOSE_PROCFS=y
 # CONFIG_SND_TRIDENT is not set
 # CONFIG_SND_VIA82XX is not set
 # CONFIG_SND_VIA82XX_MODEM is not set
+# CONFIG_SND_VIRTUOSO is not set
 # CONFIG_SND_VX222 is not set
 # CONFIG_SND_YMFPCI is not set
 
@@ -1259,6 +1301,10 @@ CONFIG_SND_USB_USX2Y=y
 #
 
 #
+# ALSA SoC audio for Freescale SOCs
+#
+
+#
 # Open Sound System
 #
 # CONFIG_SOUND_PRIME is not set
@@ -1280,6 +1326,7 @@ CONFIG_USB_ARCH_HAS_OHCI=y
 CONFIG_USB_ARCH_HAS_EHCI=y
 CONFIG_USB=y
 # CONFIG_USB_DEBUG is not set
+# CONFIG_USB_ANNOUNCE_NEW_DEVICES is not set
 
 #
 # Miscellaneous USB options
@@ -1293,9 +1340,9 @@ CONFIG_USB_DEVICEFS=y
 # USB Host Controller Drivers
 #
 CONFIG_USB_EHCI_HCD=y
-# CONFIG_USB_EHCI_SPLIT_ISO is not set
 # CONFIG_USB_EHCI_ROOT_HUB_TT is not set
 # CONFIG_USB_EHCI_TT_NEWSCHED is not set
+CONFIG_USB_EHCI_HCD_PPC_OF=y
 # CONFIG_USB_ISP116X_HCD is not set
 CONFIG_USB_OHCI_HCD=y
 CONFIG_USB_OHCI_HCD_PPC_OF=y
@@ -1348,10 +1395,6 @@ CONFIG_USB_LIBUSUAL=y
 #
 # USB port drivers
 #
-
-#
-# USB Serial Converter support
-#
 # CONFIG_USB_SERIAL is not set
 
 #
@@ -1377,16 +1420,9 @@ CONFIG_USB_LIBUSUAL=y
 # CONFIG_USB_TRANCEVIBRATOR is not set
 # CONFIG_USB_IOWARRIOR is not set
 # CONFIG_USB_TEST is not set
-
-#
-# USB DSL modem support
-#
-
-#
-# USB Gadget Support
-#
 # CONFIG_USB_GADGET is not set
 # CONFIG_MMC is not set
+# CONFIG_MEMSTICK is not set
 # CONFIG_NEW_LEDS is not set
 # CONFIG_INFINIBAND is not set
 CONFIG_EDAC=y
@@ -1399,6 +1435,10 @@ CONFIG_EDAC_MM_EDAC=y
 CONFIG_EDAC_PASEMI=y
 CONFIG_RTC_LIB=y
 CONFIG_RTC_CLASS=y
+
+#
+# Conflicting RTC option has been selected, check GEN_RTC and RTC
+#
 CONFIG_RTC_HCTOSYS=y
 CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
 # CONFIG_RTC_DEBUG is not set
@@ -1425,6 +1465,7 @@ CONFIG_RTC_DRV_DS1307=y
 # CONFIG_RTC_DRV_PCF8563 is not set
 # CONFIG_RTC_DRV_PCF8583 is not set
 # CONFIG_RTC_DRV_M41T80 is not set
+# CONFIG_RTC_DRV_S35390A is not set
 
 #
 # SPI RTC drivers
@@ -1434,9 +1475,10 @@ CONFIG_RTC_DRV_DS1307=y
 # Platform RTC drivers
 #
 # CONFIG_RTC_DRV_CMOS is not set
+# CONFIG_RTC_DRV_DS1511 is not set
 # CONFIG_RTC_DRV_DS1553 is not set
-# CONFIG_RTC_DRV_STK17TA8 is not set
 # CONFIG_RTC_DRV_DS1742 is not set
+# CONFIG_RTC_DRV_STK17TA8 is not set
 # CONFIG_RTC_DRV_M48T86 is not set
 # CONFIG_RTC_DRV_M48T59 is not set
 # CONFIG_RTC_DRV_V3020 is not set
@@ -1444,6 +1486,7 @@ CONFIG_RTC_DRV_DS1307=y
 #
 # on-CPU RTC drivers
 #
+# CONFIG_DMADEVICES is not set
 
 #
 # Userspace I/O
@@ -1471,12 +1514,10 @@ CONFIG_FS_POSIX_ACL=y
 # CONFIG_XFS_FS is not set
 # CONFIG_GFS2_FS is not set
 # CONFIG_OCFS2_FS is not set
-# CONFIG_MINIX_FS is not set
-# CONFIG_ROMFS_FS is not set
+CONFIG_DNOTIFY=y
 CONFIG_INOTIFY=y
 CONFIG_INOTIFY_USER=y
 # CONFIG_QUOTA is not set
-CONFIG_DNOTIFY=y
 CONFIG_AUTOFS_FS=y
 CONFIG_AUTOFS4_FS=y
 # CONFIG_FUSE_FS is not set
@@ -1536,8 +1577,10 @@ CONFIG_JFFS2_RTIME=y
 # CONFIG_JFFS2_RUBIN is not set
 # CONFIG_CRAMFS is not set
 # CONFIG_VXFS_FS is not set
+# CONFIG_MINIX_FS is not set
 # CONFIG_HPFS_FS is not set
 # CONFIG_QNX4FS_FS is not set
+# CONFIG_ROMFS_FS is not set
 # CONFIG_SYSV_FS is not set
 # CONFIG_UFS_FS is not set
 CONFIG_NETWORK_FILESYSTEMS=y
@@ -1629,7 +1672,6 @@ CONFIG_NLS_ISO8859_1=y
 # CONFIG_NLS_KOI8_U is not set
 # CONFIG_NLS_UTF8 is not set
 # CONFIG_DLM is not set
-# CONFIG_UCC_SLOW is not set
 
 #
 # Library routines
@@ -1647,11 +1689,7 @@ CONFIG_PLIST=y
 CONFIG_HAS_IOMEM=y
 CONFIG_HAS_IOPORT=y
 CONFIG_HAS_DMA=y
-CONFIG_INSTRUMENTATION=y
-CONFIG_PROFILING=y
-CONFIG_OPROFILE=y
-# CONFIG_KPROBES is not set
-# CONFIG_MARKERS is not set
+CONFIG_HAVE_LMB=y
 
 #
 # Kernel hacking
@@ -1670,6 +1708,7 @@ CONFIG_DETECT_SOFTLOCKUP=y
 # CONFIG_SCHEDSTATS is not set
 # CONFIG_TIMER_STATS is not set
 # CONFIG_SLUB_DEBUG_ON is not set
+# CONFIG_SLUB_STATS is not set
 # CONFIG_DEBUG_RT_MUTEXES is not set
 # CONFIG_RT_MUTEX_TESTER is not set
 # CONFIG_DEBUG_SPINLOCK is not set
@@ -1682,9 +1721,9 @@ CONFIG_DEBUG_BUGVERBOSE=y
 # CONFIG_DEBUG_VM is not set
 # CONFIG_DEBUG_LIST is not set
 # CONFIG_DEBUG_SG is not set
-# CONFIG_FORCED_INLINING is not set
 # CONFIG_BOOT_PRINTK_DELAY is not set
 # CONFIG_RCU_TORTURE_TEST is not set
+# CONFIG_BACKTRACE_SELF_TEST is not set
 # CONFIG_FAULT_INJECTION is not set
 # CONFIG_SAMPLES is not set
 # CONFIG_DEBUG_STACKOVERFLOW is not set
@@ -1710,7 +1749,9 @@ CONFIG_ASYNC_MEMCPY=y
 CONFIG_ASYNC_XOR=y
 CONFIG_CRYPTO=y
 CONFIG_CRYPTO_ALGAPI=y
+CONFIG_CRYPTO_AEAD=y
 CONFIG_CRYPTO_BLKCIPHER=y
+# CONFIG_CRYPTO_SEQIV is not set
 CONFIG_CRYPTO_HASH=y
 CONFIG_CRYPTO_MANAGER=y
 CONFIG_CRYPTO_HMAC=y
@@ -1729,6 +1770,9 @@ CONFIG_CRYPTO_CBC=y
 # CONFIG_CRYPTO_PCBC is not set
 # CONFIG_CRYPTO_LRW is not set
 # CONFIG_CRYPTO_XTS is not set
+# CONFIG_CRYPTO_CTR is not set
+# CONFIG_CRYPTO_GCM is not set
+# CONFIG_CRYPTO_CCM is not set
 # CONFIG_CRYPTO_CRYPTD is not set
 CONFIG_CRYPTO_DES=y
 # CONFIG_CRYPTO_FCRYPT is not set
@@ -1743,11 +1787,14 @@ CONFIG_CRYPTO_AES=y
 # CONFIG_CRYPTO_KHAZAD is not set
 # CONFIG_CRYPTO_ANUBIS is not set
 # CONFIG_CRYPTO_SEED is not set
+# CONFIG_CRYPTO_SALSA20 is not set
 # CONFIG_CRYPTO_DEFLATE is not set
 # CONFIG_CRYPTO_MICHAEL_MIC is not set
 # CONFIG_CRYPTO_CRC32C is not set
 # CONFIG_CRYPTO_CAMELLIA is not set
 # CONFIG_CRYPTO_TEST is not set
-# CONFIG_CRYPTO_AUTHENC is not set
+CONFIG_CRYPTO_AUTHENC=y
+# CONFIG_CRYPTO_LZO is not set
 CONFIG_CRYPTO_HW=y
+# CONFIG_CRYPTO_DEV_HIFN_795X is not set
 # CONFIG_PPC_CLOCK is not set
-- 
1.5.4.4

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
