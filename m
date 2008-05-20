Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6C5DEDEEB4
	for <linuxppc-dev@ozlabs.org>; Wed, 21 May 2008 06:14:33 +1000 (EST)
From: Timur Tabi <timur@freescale.com>
To: galak@kernel.crashing.org, linuxppc-dev@ozlabs.org
Subject: [PATCH v4][POWERPC] Update defconfig for MPC8610 HPCD
Date: Tue, 20 May 2008 15:14:18 -0500
Message-Id: <1211314458-25003-1-git-send-email-timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Update the defconfig for the Freescale MPC8610 HPCD board.  Enable module
support.  Disable support for all NICs except for the on-board ULI526x.
Enable support for the Freescale DIU driver.  Increase the maximum zone order
to 12, so that the DIU driver can allocate physically-contiguous 5MB buffers.
Enable SYSV IPC and OSS plugin support, which are needed for some OSS apps.

Signed-off-by: Timur Tabi <timur@freescale.com>
---

v4: turn on CONFIG_SND_PCM_OSS_PLUGINS, which apparently works now

Support for the Freescale generic DMA driver will have to wait until 2.6.27
because the current audio driver for the 8610 is incompatible with it.

 arch/powerpc/configs/mpc8610_hpcd_defconfig |  316 +++++++++++++++------------
 1 files changed, 180 insertions(+), 136 deletions(-)

diff --git a/arch/powerpc/configs/mpc8610_hpcd_defconfig b/arch/powerpc/configs/mpc8610_hpcd_defconfig
index 7e5b9ce..389ff8d 100644
--- a/arch/powerpc/configs/mpc8610_hpcd_defconfig
+++ b/arch/powerpc/configs/mpc8610_hpcd_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.25-rc6
-# Mon Mar 24 08:48:33 2008
+# Linux kernel version: 2.6.26-rc2
+# Tue May 20 15:12:10 2008
 #
 # CONFIG_PPC64 is not set
 
@@ -31,6 +31,8 @@ CONFIG_GENERIC_CLOCKEVENTS=y
 CONFIG_GENERIC_HARDIRQS=y
 # CONFIG_HAVE_SETUP_PER_CPU_AREA is not set
 CONFIG_IRQ_PER_CPU=y
+CONFIG_STACKTRACE_SUPPORT=y
+CONFIG_LOCKDEP_SUPPORT=y
 CONFIG_RWSEM_XCHGADD_ALGORITHM=y
 CONFIG_ARCH_HAS_ILOG2_U32=y
 CONFIG_GENERIC_HWEIGHT=y
@@ -60,9 +62,10 @@ CONFIG_EXPERIMENTAL=y
 CONFIG_BROKEN_ON_SMP=y
 CONFIG_INIT_ENV_ARG_LIMIT=32
 CONFIG_LOCALVERSION=""
-# CONFIG_LOCALVERSION_AUTO is not set
+CONFIG_LOCALVERSION_AUTO=y
 # CONFIG_SWAP is not set
-# CONFIG_SYSVIPC is not set
+CONFIG_SYSVIPC=y
+CONFIG_SYSVIPC_SYSCTL=y
 # CONFIG_POSIX_MQUEUE is not set
 # CONFIG_BSD_PROCESS_ACCT is not set
 # CONFIG_TASKSTATS is not set
@@ -86,6 +89,7 @@ CONFIG_INITRAMFS_SOURCE=""
 CONFIG_SYSCTL=y
 CONFIG_EMBEDDED=y
 CONFIG_SYSCTL_SYSCALL=y
+CONFIG_SYSCTL_SYSCALL_CHECK=y
 CONFIG_KALLSYMS=y
 # CONFIG_KALLSYMS_ALL is not set
 CONFIG_KALLSYMS_EXTRA_PASS=y
@@ -110,14 +114,22 @@ CONFIG_SLUB=y
 # CONFIG_PROFILING is not set
 # CONFIG_MARKERS is not set
 CONFIG_HAVE_OPROFILE=y
+# CONFIG_KPROBES is not set
 CONFIG_HAVE_KPROBES=y
 CONFIG_HAVE_KRETPROBES=y
+# CONFIG_HAVE_DMA_ATTRS is not set
 CONFIG_PROC_PAGE_MONITOR=y
 CONFIG_SLABINFO=y
 CONFIG_RT_MUTEXES=y
 # CONFIG_TINY_SHMEM is not set
 CONFIG_BASE_SMALL=0
-# CONFIG_MODULES is not set
+CONFIG_MODULES=y
+# CONFIG_MODULE_FORCE_LOAD is not set
+CONFIG_MODULE_UNLOAD=y
+# CONFIG_MODULE_FORCE_UNLOAD is not set
+# CONFIG_MODVERSIONS is not set
+# CONFIG_MODULE_SRCVERSION_ALL is not set
+CONFIG_KMOD=y
 CONFIG_BLOCK=y
 # CONFIG_LBD is not set
 # CONFIG_BLK_DEV_IO_TRACE is not set
@@ -151,6 +163,7 @@ CONFIG_PPC_86xx=y
 # CONFIG_PPC_CELL_NATIVE is not set
 # CONFIG_PQ2ADS is not set
 # CONFIG_MPC8641_HPCN is not set
+# CONFIG_SBC8641D is not set
 CONFIG_MPC8610_HPCD=y
 CONFIG_MPC8610=y
 # CONFIG_IPIC is not set
@@ -199,11 +212,13 @@ CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
 # CONFIG_SPARSEMEM_VMEMMAP_ENABLE is not set
+CONFIG_PAGEFLAGS_EXTENDED=y
 CONFIG_SPLIT_PTLOCK_CPUS=4
 # CONFIG_RESOURCES_64BIT is not set
 CONFIG_ZONE_DMA_FLAG=1
 CONFIG_BOUNCE=y
 CONFIG_VIRT_TO_BUS=y
+CONFIG_FORCE_MAX_ZONEORDER=12
 CONFIG_PROC_DEVICETREE=y
 # CONFIG_CMDLINE_BOOL is not set
 # CONFIG_PM is not set
@@ -223,12 +238,14 @@ CONFIG_PCI_DOMAINS=y
 CONFIG_PCI_SYSCALL=y
 CONFIG_PCIEPORTBUS=y
 CONFIG_PCIEAER=y
+# CONFIG_PCIEASPM is not set
 CONFIG_ARCH_SUPPORTS_MSI=y
 # CONFIG_PCI_MSI is not set
 CONFIG_PCI_LEGACY=y
 CONFIG_PCI_DEBUG=y
 # CONFIG_PCCARD is not set
 # CONFIG_HOTPLUG_PCI is not set
+# CONFIG_HAS_RAPIDIO is not set
 
 #
 # Advanced setup
@@ -238,11 +255,11 @@ CONFIG_PCI_DEBUG=y
 #
 # Default settings for advanced configuration options are used
 #
-CONFIG_HIGHMEM_START=0xfe000000
 CONFIG_LOWMEM_SIZE=0x30000000
+CONFIG_PAGE_OFFSET=0xc0000000
 CONFIG_KERNEL_START=0xc0000000
+CONFIG_PHYSICAL_START=0x00000000
 CONFIG_TASK_SIZE=0xc0000000
-CONFIG_BOOT_LOAD=0x00800000
 
 #
 # Networking
@@ -303,8 +320,10 @@ CONFIG_INET6_XFRM_MODE_TUNNEL=y
 CONFIG_INET6_XFRM_MODE_BEET=y
 # CONFIG_INET6_XFRM_MODE_ROUTEOPTIMIZATION is not set
 CONFIG_IPV6_SIT=y
+CONFIG_IPV6_NDISC_NODETYPE=y
 # CONFIG_IPV6_TUNNEL is not set
 # CONFIG_IPV6_MULTIPLE_TABLES is not set
+# CONFIG_IPV6_MROUTE is not set
 # CONFIG_NETWORK_SECMARK is not set
 # CONFIG_NETFILTER is not set
 # CONFIG_IP_DCCP is not set
@@ -446,6 +465,7 @@ CONFIG_MTD_NAND_FSL_ELBC=y
 #
 # CONFIG_MTD_UBI is not set
 CONFIG_OF_DEVICE=y
+CONFIG_OF_I2C=y
 # CONFIG_PARPORT is not set
 CONFIG_BLK_DEV=y
 # CONFIG_BLK_DEV_FD is not set
@@ -504,6 +524,7 @@ CONFIG_CHR_DEV_SG=y
 # CONFIG_SCSI_CONSTANTS is not set
 # CONFIG_SCSI_LOGGING is not set
 # CONFIG_SCSI_SCAN_ASYNC is not set
+CONFIG_SCSI_WAIT_SCAN=m
 
 #
 # SCSI Transports
@@ -553,7 +574,11 @@ CONFIG_SCSI_LOWLEVEL=y
 # CONFIG_SCSI_SRP is not set
 CONFIG_ATA=y
 # CONFIG_ATA_NONSTANDARD is not set
+CONFIG_SATA_PMP=y
 CONFIG_SATA_AHCI=y
+# CONFIG_SATA_SIL24 is not set
+# CONFIG_SATA_FSL is not set
+CONFIG_ATA_SFF=y
 # CONFIG_SATA_SVW is not set
 # CONFIG_ATA_PIIX is not set
 # CONFIG_SATA_MV is not set
@@ -563,13 +588,11 @@ CONFIG_SATA_AHCI=y
 # CONFIG_SATA_PROMISE is not set
 # CONFIG_SATA_SX4 is not set
 # CONFIG_SATA_SIL is not set
-# CONFIG_SATA_SIL24 is not set
 # CONFIG_SATA_SIS is not set
 # CONFIG_SATA_ULI is not set
 # CONFIG_SATA_VIA is not set
 # CONFIG_SATA_VITESSE is not set
 # CONFIG_SATA_INIC162X is not set
-# CONFIG_SATA_FSL is not set
 CONFIG_PATA_ALI=y
 # CONFIG_PATA_AMD is not set
 # CONFIG_PATA_ARTOP is not set
@@ -609,6 +632,7 @@ CONFIG_PATA_ALI=y
 # CONFIG_PATA_VIA is not set
 # CONFIG_PATA_WINBOND is not set
 # CONFIG_PATA_PLATFORM is not set
+# CONFIG_PATA_SCH is not set
 # CONFIG_MD is not set
 # CONFIG_FUSION is not set
 
@@ -628,25 +652,9 @@ CONFIG_DUMMY=y
 # CONFIG_TUN is not set
 # CONFIG_VETH is not set
 # CONFIG_ARCNET is not set
-CONFIG_PHYLIB=y
-
-#
-# MII PHY device drivers
-#
-# CONFIG_MARVELL_PHY is not set
-# CONFIG_DAVICOM_PHY is not set
-# CONFIG_QSEMI_PHY is not set
-# CONFIG_LXT_PHY is not set
-# CONFIG_CICADA_PHY is not set
-# CONFIG_VITESSE_PHY is not set
-# CONFIG_SMSC_PHY is not set
-# CONFIG_BROADCOM_PHY is not set
-# CONFIG_ICPLUS_PHY is not set
-# CONFIG_REALTEK_PHY is not set
-# CONFIG_FIXED_PHY is not set
-# CONFIG_MDIO_BITBANG is not set
+# CONFIG_PHYLIB is not set
 CONFIG_NET_ETHERNET=y
-CONFIG_MII=y
+# CONFIG_MII is not set
 # CONFIG_HAPPYMEAL is not set
 # CONFIG_SUNGEM is not set
 # CONFIG_CASSINI is not set
@@ -663,64 +671,10 @@ CONFIG_ULI526X=y
 # CONFIG_IBM_NEW_EMAC_RGMII is not set
 # CONFIG_IBM_NEW_EMAC_TAH is not set
 # CONFIG_IBM_NEW_EMAC_EMAC4 is not set
-CONFIG_NET_PCI=y
-# CONFIG_PCNET32 is not set
-# CONFIG_AMD8111_ETH is not set
-# CONFIG_ADAPTEC_STARFIRE is not set
+# CONFIG_NET_PCI is not set
 # CONFIG_B44 is not set
-# CONFIG_FORCEDETH is not set
-# CONFIG_EEPRO100 is not set
-# CONFIG_E100 is not set
-# CONFIG_FEALNX is not set
-# CONFIG_NATSEMI is not set
-# CONFIG_NE2K_PCI is not set
-# CONFIG_8139CP is not set
-CONFIG_8139TOO=y
-CONFIG_8139TOO_PIO=y
-# CONFIG_8139TOO_TUNE_TWISTER is not set
-# CONFIG_8139TOO_8129 is not set
-# CONFIG_8139_OLD_RX_RESET is not set
-# CONFIG_R6040 is not set
-# CONFIG_SIS900 is not set
-# CONFIG_EPIC100 is not set
-# CONFIG_SUNDANCE is not set
-# CONFIG_TLAN is not set
-# CONFIG_VIA_RHINE is not set
-# CONFIG_SC92031 is not set
-CONFIG_NETDEV_1000=y
-# CONFIG_ACENIC is not set
-# CONFIG_DL2K is not set
-# CONFIG_E1000 is not set
-# CONFIG_E1000E is not set
-# CONFIG_E1000E_ENABLED is not set
-# CONFIG_IP1000 is not set
-# CONFIG_IGB is not set
-# CONFIG_NS83820 is not set
-# CONFIG_HAMACHI is not set
-# CONFIG_YELLOWFIN is not set
-# CONFIG_R8169 is not set
-# CONFIG_SIS190 is not set
-# CONFIG_SKGE is not set
-# CONFIG_SKY2 is not set
-# CONFIG_SK98LIN is not set
-# CONFIG_VIA_VELOCITY is not set
-# CONFIG_TIGON3 is not set
-# CONFIG_BNX2 is not set
-# CONFIG_GIANFAR is not set
-# CONFIG_QLA3XXX is not set
-# CONFIG_ATL1 is not set
-CONFIG_NETDEV_10000=y
-# CONFIG_CHELSIO_T1 is not set
-# CONFIG_CHELSIO_T3 is not set
-# CONFIG_IXGBE is not set
-# CONFIG_IXGB is not set
-# CONFIG_S2IO is not set
-# CONFIG_MYRI10GE is not set
-# CONFIG_NETXEN_NIC is not set
-# CONFIG_NIU is not set
-# CONFIG_MLX4_CORE is not set
-# CONFIG_TEHUTI is not set
-# CONFIG_BNX2X is not set
+# CONFIG_NETDEV_1000 is not set
+# CONFIG_NETDEV_10000 is not set
 # CONFIG_TR is not set
 
 #
@@ -728,6 +682,7 @@ CONFIG_NETDEV_10000=y
 #
 # CONFIG_WLAN_PRE80211 is not set
 # CONFIG_WLAN_80211 is not set
+# CONFIG_IWLWIFI_LEDS is not set
 # CONFIG_WAN is not set
 # CONFIG_FDDI is not set
 # CONFIG_HIPPI is not set
@@ -783,6 +738,7 @@ CONFIG_VT=y
 CONFIG_VT_CONSOLE=y
 CONFIG_HW_CONSOLE=y
 # CONFIG_VT_HW_CONSOLE_BINDING is not set
+CONFIG_DEVKMEM=y
 # CONFIG_SERIAL_NONSTANDARD is not set
 # CONFIG_NOZOMI is not set
 
@@ -824,13 +780,6 @@ CONFIG_I2C_BOARDINFO=y
 # CONFIG_I2C_CHARDEV is not set
 
 #
-# I2C Algorithms
-#
-# CONFIG_I2C_ALGOBIT is not set
-# CONFIG_I2C_ALGOPCF is not set
-# CONFIG_I2C_ALGOPCA is not set
-
-#
 # I2C Hardware Bus support
 #
 # CONFIG_I2C_ALI1535 is not set
@@ -852,9 +801,11 @@ CONFIG_I2C_MPC=y
 # CONFIG_I2C_SIS630 is not set
 # CONFIG_I2C_SIS96X is not set
 # CONFIG_I2C_TAOS_EVM is not set
+# CONFIG_I2C_STUB is not set
 # CONFIG_I2C_VIA is not set
 # CONFIG_I2C_VIAPRO is not set
 # CONFIG_I2C_VOODOO3 is not set
+# CONFIG_I2C_PCA_PLATFORM is not set
 
 #
 # Miscellaneous I2C Chip support
@@ -864,19 +815,13 @@ CONFIG_I2C_MPC=y
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCF8591 is not set
-# CONFIG_TPS65010 is not set
 # CONFIG_SENSORS_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
 # CONFIG_I2C_DEBUG_BUS is not set
 # CONFIG_I2C_DEBUG_CHIP is not set
-
-#
-# SPI support
-#
 # CONFIG_SPI is not set
-# CONFIG_SPI_MASTER is not set
 # CONFIG_W1 is not set
 # CONFIG_POWER_SUPPLY is not set
 # CONFIG_HWMON is not set
@@ -893,12 +838,21 @@ CONFIG_SSB_POSSIBLE=y
 # Multifunction device drivers
 #
 # CONFIG_MFD_SM501 is not set
+# CONFIG_HTC_PASIC3 is not set
 
 #
 # Multimedia devices
 #
+
+#
+# Multimedia core support
+#
 # CONFIG_VIDEO_DEV is not set
 # CONFIG_DVB_CORE is not set
+
+#
+# Multimedia drivers
+#
 CONFIG_DAB=y
 
 #
@@ -908,7 +862,57 @@ CONFIG_DAB=y
 # CONFIG_DRM is not set
 # CONFIG_VGASTATE is not set
 CONFIG_VIDEO_OUTPUT_CONTROL=y
-# CONFIG_FB is not set
+CONFIG_FB=y
+# CONFIG_FIRMWARE_EDID is not set
+# CONFIG_FB_DDC is not set
+CONFIG_FB_CFB_FILLRECT=y
+CONFIG_FB_CFB_COPYAREA=y
+CONFIG_FB_CFB_IMAGEBLIT=y
+# CONFIG_FB_CFB_REV_PIXELS_IN_BYTE is not set
+# CONFIG_FB_SYS_FILLRECT is not set
+# CONFIG_FB_SYS_COPYAREA is not set
+# CONFIG_FB_SYS_IMAGEBLIT is not set
+# CONFIG_FB_FOREIGN_ENDIAN is not set
+# CONFIG_FB_SYS_FOPS is not set
+CONFIG_FB_DEFERRED_IO=y
+# CONFIG_FB_SVGALIB is not set
+# CONFIG_FB_MACMODES is not set
+# CONFIG_FB_BACKLIGHT is not set
+# CONFIG_FB_MODE_HELPERS is not set
+# CONFIG_FB_TILEBLITTING is not set
+
+#
+# Frame buffer hardware drivers
+#
+# CONFIG_FB_CIRRUS is not set
+# CONFIG_FB_PM2 is not set
+# CONFIG_FB_CYBER2000 is not set
+# CONFIG_FB_OF is not set
+# CONFIG_FB_CT65550 is not set
+# CONFIG_FB_ASILIANT is not set
+# CONFIG_FB_IMSTT is not set
+# CONFIG_FB_VGA16 is not set
+# CONFIG_FB_S1D13XXX is not set
+# CONFIG_FB_NVIDIA is not set
+# CONFIG_FB_RIVA is not set
+# CONFIG_FB_MATROX is not set
+# CONFIG_FB_RADEON is not set
+# CONFIG_FB_ATY128 is not set
+# CONFIG_FB_ATY is not set
+# CONFIG_FB_S3 is not set
+# CONFIG_FB_SAVAGE is not set
+# CONFIG_FB_SIS is not set
+# CONFIG_FB_NEOMAGIC is not set
+# CONFIG_FB_KYRO is not set
+# CONFIG_FB_3DFX is not set
+# CONFIG_FB_VOODOO1 is not set
+# CONFIG_FB_VT8623 is not set
+# CONFIG_FB_TRIDENT is not set
+# CONFIG_FB_ARK is not set
+# CONFIG_FB_PM3 is not set
+CONFIG_FB_FSL_DIU=y
+# CONFIG_FB_IBM_GXT4500 is not set
+# CONFIG_FB_VIRTUAL is not set
 # CONFIG_BACKLIGHT_LCD_SUPPORT is not set
 
 #
@@ -922,6 +926,8 @@ CONFIG_VIDEO_OUTPUT_CONTROL=y
 CONFIG_VGA_CONSOLE=y
 # CONFIG_VGACON_SOFT_SCROLLBACK is not set
 CONFIG_DUMMY_CONSOLE=y
+# CONFIG_FRAMEBUFFER_CONSOLE is not set
+# CONFIG_LOGO is not set
 
 #
 # Sound
@@ -938,7 +944,7 @@ CONFIG_SND_PCM=y
 CONFIG_SND_OSSEMUL=y
 CONFIG_SND_MIXER_OSS=y
 CONFIG_SND_PCM_OSS=y
-# CONFIG_SND_PCM_OSS_PLUGINS is not set
+CONFIG_SND_PCM_OSS_PLUGINS=y
 # CONFIG_SND_DYNAMIC_MINORS is not set
 # CONFIG_SND_SUPPORT_OLD_API is not set
 CONFIG_SND_VERBOSE_PROCFS=y
@@ -965,6 +971,7 @@ CONFIG_SND_VERBOSE_PROCFS=y
 # CONFIG_SND_AU8810 is not set
 # CONFIG_SND_AU8820 is not set
 # CONFIG_SND_AU8830 is not set
+# CONFIG_SND_AW2 is not set
 # CONFIG_SND_AZT3328 is not set
 # CONFIG_SND_BT87X is not set
 # CONFIG_SND_CA0106 is not set
@@ -1031,14 +1038,14 @@ CONFIG_SND_VERBOSE_PROCFS=y
 CONFIG_SND_SOC=y
 
 #
-# SoC Audio support for SuperH
-#
-
-#
 # ALSA SoC audio for Freescale SOCs
 #
 CONFIG_SND_SOC_MPC8610=y
 CONFIG_SND_SOC_MPC8610_HPCD=y
+
+#
+# SoC Audio for the Texas Instruments OMAP
+#
 CONFIG_SND_SOC_CS4270=y
 CONFIG_SND_SOC_CS4270_VD33_ERRATA=y
 
@@ -1055,6 +1062,8 @@ CONFIG_USB_ARCH_HAS_HCD=y
 CONFIG_USB_ARCH_HAS_OHCI=y
 CONFIG_USB_ARCH_HAS_EHCI=y
 # CONFIG_USB is not set
+# CONFIG_USB_OTG_WHITELIST is not set
+# CONFIG_USB_OTG_BLACKLIST_HUB is not set
 
 #
 # NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
@@ -1063,14 +1072,11 @@ CONFIG_USB_ARCH_HAS_EHCI=y
 # CONFIG_MMC is not set
 # CONFIG_MEMSTICK is not set
 # CONFIG_NEW_LEDS is not set
+# CONFIG_ACCESSIBILITY is not set
 # CONFIG_INFINIBAND is not set
 # CONFIG_EDAC is not set
 # CONFIG_RTC_CLASS is not set
 # CONFIG_DMADEVICES is not set
-
-#
-# Userspace I/O
-#
 # CONFIG_UIO is not set
 
 #
@@ -1090,7 +1096,6 @@ CONFIG_FS_MBCACHE=y
 # CONFIG_JFS_FS is not set
 # CONFIG_FS_POSIX_ACL is not set
 # CONFIG_XFS_FS is not set
-# CONFIG_GFS2_FS is not set
 # CONFIG_OCFS2_FS is not set
 # CONFIG_DNOTIFY is not set
 # CONFIG_INOTIFY is not set
@@ -1134,6 +1139,7 @@ CONFIG_TMPFS=y
 # CONFIG_BEFS_FS is not set
 # CONFIG_BFS_FS is not set
 # CONFIG_EFS_FS is not set
+# CONFIG_JFFS2_FS is not set
 # CONFIG_CRAMFS is not set
 # CONFIG_VXFS_FS is not set
 # CONFIG_MINIX_FS is not set
@@ -1147,10 +1153,9 @@ CONFIG_NFS_FS=y
 CONFIG_NFS_V3=y
 # CONFIG_NFS_V3_ACL is not set
 # CONFIG_NFS_V4 is not set
-# CONFIG_NFS_DIRECTIO is not set
 CONFIG_NFSD=y
 # CONFIG_NFSD_V3 is not set
-CONFIG_NFSD_TCP=y
+# CONFIG_NFSD_V4 is not set
 CONFIG_ROOT_NFS=y
 CONFIG_LOCKD=y
 CONFIG_LOCKD_V4=y
@@ -1234,6 +1239,7 @@ CONFIG_NLS_DEFAULT="iso8859-1"
 # Library routines
 #
 CONFIG_BITREVERSE=y
+# CONFIG_GENERIC_FIND_FIRST_BIT is not set
 # CONFIG_CRC_CCITT is not set
 # CONFIG_CRC16 is not set
 # CONFIG_CRC_ITU_T is not set
@@ -1244,6 +1250,7 @@ CONFIG_PLIST=y
 CONFIG_HAS_IOMEM=y
 CONFIG_HAS_IOPORT=y
 CONFIG_HAS_DMA=y
+CONFIG_HAVE_LMB=y
 
 #
 # Kernel hacking
@@ -1251,6 +1258,7 @@ CONFIG_HAS_DMA=y
 # CONFIG_PRINTK_TIME is not set
 CONFIG_ENABLE_WARN_DEPRECATED=y
 CONFIG_ENABLE_MUST_CHECK=y
+CONFIG_FRAME_WARN=1024
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_UNUSED_SYMBOLS is not set
 # CONFIG_DEBUG_FS is not set
@@ -1261,6 +1269,7 @@ CONFIG_DETECT_SOFTLOCKUP=y
 CONFIG_SCHED_DEBUG=y
 # CONFIG_SCHEDSTATS is not set
 # CONFIG_TIMER_STATS is not set
+# CONFIG_DEBUG_OBJECTS is not set
 # CONFIG_SLUB_DEBUG_ON is not set
 # CONFIG_SLUB_STATS is not set
 # CONFIG_DEBUG_RT_MUTEXES is not set
@@ -1274,9 +1283,11 @@ CONFIG_SCHED_DEBUG=y
 CONFIG_DEBUG_BUGVERBOSE=y
 CONFIG_DEBUG_INFO=y
 # CONFIG_DEBUG_VM is not set
+# CONFIG_DEBUG_WRITECOUNT is not set
 # CONFIG_DEBUG_LIST is not set
 # CONFIG_DEBUG_SG is not set
 # CONFIG_BOOT_PRINTK_DELAY is not set
+# CONFIG_RCU_TORTURE_TEST is not set
 # CONFIG_BACKTRACE_SELF_TEST is not set
 # CONFIG_FAULT_INJECTION is not set
 # CONFIG_SAMPLES is not set
@@ -1284,6 +1295,7 @@ CONFIG_DEBUG_INFO=y
 # CONFIG_DEBUG_STACK_USAGE is not set
 # CONFIG_DEBUG_PAGEALLOC is not set
 # CONFIG_DEBUGGER is not set
+# CONFIG_IRQSTACKS is not set
 # CONFIG_BDI_SWITCH is not set
 # CONFIG_PPC_EARLY_DEBUG is not set
 
@@ -1294,48 +1306,80 @@ CONFIG_DEBUG_INFO=y
 # CONFIG_SECURITY is not set
 # CONFIG_SECURITY_FILE_CAPABILITIES is not set
 CONFIG_CRYPTO=y
-# CONFIG_CRYPTO_SEQIV is not set
+
+#
+# Crypto core or helper
+#
 # CONFIG_CRYPTO_MANAGER is not set
+# CONFIG_CRYPTO_GF128MUL is not set
+# CONFIG_CRYPTO_NULL is not set
+# CONFIG_CRYPTO_CRYPTD is not set
+# CONFIG_CRYPTO_AUTHENC is not set
+# CONFIG_CRYPTO_TEST is not set
+
+#
+# Authenticated Encryption with Associated Data
+#
+# CONFIG_CRYPTO_CCM is not set
+# CONFIG_CRYPTO_GCM is not set
+# CONFIG_CRYPTO_SEQIV is not set
+
+#
+# Block modes
+#
+# CONFIG_CRYPTO_CBC is not set
+# CONFIG_CRYPTO_CTR is not set
+# CONFIG_CRYPTO_CTS is not set
+# CONFIG_CRYPTO_ECB is not set
+# CONFIG_CRYPTO_LRW is not set
+# CONFIG_CRYPTO_PCBC is not set
+# CONFIG_CRYPTO_XTS is not set
+
+#
+# Hash modes
+#
 # CONFIG_CRYPTO_HMAC is not set
 # CONFIG_CRYPTO_XCBC is not set
-# CONFIG_CRYPTO_NULL is not set
+
+#
+# Digest
+#
+# CONFIG_CRYPTO_CRC32C is not set
 # CONFIG_CRYPTO_MD4 is not set
 # CONFIG_CRYPTO_MD5 is not set
+# CONFIG_CRYPTO_MICHAEL_MIC is not set
 # CONFIG_CRYPTO_SHA1 is not set
 # CONFIG_CRYPTO_SHA256 is not set
 # CONFIG_CRYPTO_SHA512 is not set
-# CONFIG_CRYPTO_WP512 is not set
 # CONFIG_CRYPTO_TGR192 is not set
-# CONFIG_CRYPTO_GF128MUL is not set
-# CONFIG_CRYPTO_ECB is not set
-# CONFIG_CRYPTO_CBC is not set
-# CONFIG_CRYPTO_PCBC is not set
-# CONFIG_CRYPTO_LRW is not set
-# CONFIG_CRYPTO_XTS is not set
-# CONFIG_CRYPTO_CTR is not set
-# CONFIG_CRYPTO_GCM is not set
-# CONFIG_CRYPTO_CCM is not set
-# CONFIG_CRYPTO_CRYPTD is not set
-# CONFIG_CRYPTO_DES is not set
-# CONFIG_CRYPTO_FCRYPT is not set
-# CONFIG_CRYPTO_BLOWFISH is not set
-# CONFIG_CRYPTO_TWOFISH is not set
-# CONFIG_CRYPTO_SERPENT is not set
+# CONFIG_CRYPTO_WP512 is not set
+
+#
+# Ciphers
+#
 # CONFIG_CRYPTO_AES is not set
+# CONFIG_CRYPTO_ANUBIS is not set
+# CONFIG_CRYPTO_ARC4 is not set
+# CONFIG_CRYPTO_BLOWFISH is not set
+# CONFIG_CRYPTO_CAMELLIA is not set
 # CONFIG_CRYPTO_CAST5 is not set
 # CONFIG_CRYPTO_CAST6 is not set
-# CONFIG_CRYPTO_TEA is not set
-# CONFIG_CRYPTO_ARC4 is not set
+# CONFIG_CRYPTO_DES is not set
+# CONFIG_CRYPTO_FCRYPT is not set
 # CONFIG_CRYPTO_KHAZAD is not set
-# CONFIG_CRYPTO_ANUBIS is not set
-# CONFIG_CRYPTO_SEED is not set
 # CONFIG_CRYPTO_SALSA20 is not set
+# CONFIG_CRYPTO_SEED is not set
+# CONFIG_CRYPTO_SERPENT is not set
+# CONFIG_CRYPTO_TEA is not set
+# CONFIG_CRYPTO_TWOFISH is not set
+
+#
+# Compression
+#
 # CONFIG_CRYPTO_DEFLATE is not set
-# CONFIG_CRYPTO_MICHAEL_MIC is not set
-# CONFIG_CRYPTO_CRC32C is not set
-# CONFIG_CRYPTO_CAMELLIA is not set
-# CONFIG_CRYPTO_AUTHENC is not set
 # CONFIG_CRYPTO_LZO is not set
 CONFIG_CRYPTO_HW=y
 # CONFIG_CRYPTO_DEV_HIFN_795X is not set
 # CONFIG_PPC_CLOCK is not set
+CONFIG_PPC_LIB_RHEAP=y
+# CONFIG_VIRTUALIZATION is not set
-- 
1.5.5
