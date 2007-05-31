Return-Path: <mgreer@mvista.com>
Date: Thu, 31 May 2007 12:56:15 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: linuxppc-dev <Linuxppc-dev@ozlabs.org>
Subject: [PATCH 3/3] powerpc: Update holly to use new dts wrapping feature
Message-ID: <20070531195615.GC3818@mag.az.mvista.com>
References: <20070531195136.GA3699@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070531195136.GA3699@mag.az.mvista.com>
Cc: David Gibson <dgibson@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


The holly support currently has separate rules to wrap its device tree
with its zImage.  This can now be done automatically without the extra
rules so update holly support to use the automatic feature.

Signed-off-by: Mark A. Greer <mgreer@mista.com>

---

Josh, please take a look at this patch and if you approve, give me an
Acked-by: line (thanks).  Note that 'zImage.holly-elf' was changed to
'zImage.holly'.

 arch/powerpc/boot/Makefile                 |    8 -
 arch/powerpc/configs/holly_defconfig       |  104 +++++++------------
 arch/powerpc/platforms/embedded6xx/Kconfig |    1 
 3 files changed, 43 insertions(+), 70 deletions(-)

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 06f0a5d..b8011e9 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -134,7 +134,7 @@ image-$(CONFIG_PPC_CELLEB)		+= zImage.pseries
 image-$(CONFIG_PPC_CHRP)		+= zImage.chrp
 image-$(CONFIG_PPC_EFIKA)		+= zImage.chrp
 image-$(CONFIG_PPC_PMAC)		+= zImage.pmac
-image-$(CONFIG_PPC_HOLLY)		+= zImage.holly-elf
+image-$(CONFIG_PPC_HOLLY)		+= zImage.holly
 image-$(CONFIG_PPC_PRPMC2800)		+= zImage.prpmc2800
 image-$(CONFIG_DEFAULT_UIMAGE)		+= uImage
 
@@ -183,12 +183,6 @@ $(obj)/zImage.ps3: vmlinux
 $(obj)/zImage.initrd.ps3: vmlinux
 	@echo "  WARNING zImage.initrd.ps3 not supported (yet)"
 
-$(obj)/zImage.holly-elf: vmlinux $(wrapperbits)
-	$(call if_changed,wrap,holly,$(obj)/dts/holly.dts,,)
-
-$(obj)/zImage.initrd.holly-elf: vmlinux $(wrapperbits) $(obj)/ramdisk.image.gz
-	$(call if_changed,wrap,holly,$(obj)/dts/holly.dts,,$(obj)/ramdisk.image.gz)
-
 $(obj)/uImage: vmlinux $(wrapperbits)
 	$(call if_changed,wrap,uboot)
 
diff --git a/arch/powerpc/configs/holly_defconfig b/arch/powerpc/configs/holly_defconfig
index be633b9..423bdd2 100644
--- a/arch/powerpc/configs/holly_defconfig
+++ b/arch/powerpc/configs/holly_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.21
-# Sat May  5 11:02:35 2007
+# Linux kernel version: 2.6.22-rc2
+# Thu May 31 11:25:44 2007
 #
 # CONFIG_PPC64 is not set
 CONFIG_PPC32=y
@@ -45,6 +45,7 @@ CONFIG_PPC_FPU=y
 # CONFIG_ALTIVEC is not set
 CONFIG_PPC_STD_MMU=y
 CONFIG_PPC_STD_MMU_32=y
+# CONFIG_PPC_MM_SLICES is not set
 # CONFIG_SMP is not set
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
 
@@ -70,6 +71,7 @@ CONFIG_SYSVIPC_SYSCTL=y
 # CONFIG_UTS_NS is not set
 # CONFIG_AUDIT is not set
 # CONFIG_IKCONFIG is not set
+CONFIG_LOG_BUF_SHIFT=14
 CONFIG_SYSFS_DEPRECATED=y
 # CONFIG_RELAY is not set
 CONFIG_BLK_DEV_INITRD=y
@@ -87,14 +89,19 @@ CONFIG_BUG=y
 CONFIG_ELF_CORE=y
 CONFIG_BASE_FULL=y
 CONFIG_FUTEX=y
+CONFIG_ANON_INODES=y
 CONFIG_EPOLL=y
+CONFIG_SIGNALFD=y
+CONFIG_TIMERFD=y
+CONFIG_EVENTFD=y
 CONFIG_SHMEM=y
-CONFIG_SLAB=y
 CONFIG_VM_EVENT_COUNTERS=y
+CONFIG_SLAB=y
+# CONFIG_SLUB is not set
+# CONFIG_SLOB is not set
 CONFIG_RT_MUTEXES=y
 # CONFIG_TINY_SHMEM is not set
 CONFIG_BASE_SMALL=0
-# CONFIG_SLOB is not set
 
 #
 # Loadable module support
@@ -140,6 +147,7 @@ CONFIG_EMBEDDED6xx=y
 # CONFIG_LINKSTATION is not set
 # CONFIG_MPC7448HPC2 is not set
 CONFIG_PPC_HOLLY=y
+# CONFIG_PPC_PRPMC2800 is not set
 CONFIG_TSI108_BRIDGE=y
 CONFIG_MPIC=y
 CONFIG_MPIC_WEIRD=y
@@ -185,7 +193,8 @@ CONFIG_PROC_DEVICETREE=y
 # CONFIG_CMDLINE_BOOL is not set
 # CONFIG_PM is not set
 # CONFIG_SECCOMP is not set
-# CONFIG_WANT_DEVICE_TREE is not set
+CONFIG_WANT_DEVICE_TREE=y
+CONFIG_DEVICE_TREE="holly.dts"
 CONFIG_ISA_DMA_API=y
 
 #
@@ -197,16 +206,14 @@ CONFIG_GENERIC_ISA_DMA=y
 CONFIG_PCI=y
 CONFIG_PCI_DOMAINS=y
 # CONFIG_PCIEPORTBUS is not set
+CONFIG_ARCH_SUPPORTS_MSI=y
+# CONFIG_PCI_MSI is not set
 # CONFIG_PCI_DEBUG is not set
 
 #
 # PCCARD (PCMCIA/CardBus) support
 #
 # CONFIG_PCCARD is not set
-
-#
-# PCI Hotplug Support
-#
 # CONFIG_HOTPLUG_PCI is not set
 
 #
@@ -317,7 +324,9 @@ CONFIG_DEFAULT_TCP_CONG="cubic"
 #
 # CONFIG_CFG80211 is not set
 # CONFIG_WIRELESS_EXT is not set
+# CONFIG_MAC80211 is not set
 # CONFIG_IEEE80211 is not set
+# CONFIG_RFKILL is not set
 
 #
 # Device Drivers
@@ -372,12 +381,10 @@ CONFIG_BLK_DEV_RAM_BLOCKSIZE=1024
 #
 # Misc devices
 #
+# CONFIG_PHANTOM is not set
 # CONFIG_SGI_IOC4 is not set
 # CONFIG_TIFM_CORE is not set
-
-#
-# ATA/ATAPI/MFM/RLL support
-#
+# CONFIG_BLINK is not set
 # CONFIG_IDE is not set
 
 #
@@ -406,6 +413,7 @@ CONFIG_BLK_DEV_SD=y
 # CONFIG_SCSI_CONSTANTS is not set
 # CONFIG_SCSI_LOGGING is not set
 # CONFIG_SCSI_SCAN_ASYNC is not set
+CONFIG_SCSI_WAIT_SCAN=m
 
 #
 # SCSI Transports
@@ -455,10 +463,6 @@ CONFIG_BLK_DEV_SD=y
 # CONFIG_SCSI_DEBUG is not set
 # CONFIG_SCSI_ESP_CORE is not set
 # CONFIG_SCSI_SRP is not set
-
-#
-# Serial ATA (prod) and Parallel ATA (experimental) drivers
-#
 CONFIG_ATA=y
 # CONFIG_ATA_NONSTANDARD is not set
 # CONFIG_SATA_AHCI is not set
@@ -531,6 +535,7 @@ CONFIG_ATA=y
 #
 # IEEE 1394 (FireWire) support
 #
+# CONFIG_FIREWIRE is not set
 # CONFIG_IEEE1394 is not set
 
 #
@@ -552,10 +557,6 @@ CONFIG_NETDEVICES=y
 # ARCnet devices
 #
 # CONFIG_ARCNET is not set
-
-#
-# PHY device support
-#
 CONFIG_PHYLIB=y
 
 #
@@ -589,10 +590,7 @@ CONFIG_VORTEX=y
 # CONFIG_NET_TULIP is not set
 # CONFIG_HP100 is not set
 # CONFIG_NET_PCI is not set
-
-#
-# Ethernet (1000 Mbit)
-#
+CONFIG_NETDEV_1000=y
 # CONFIG_ACENIC is not set
 # CONFIG_DL2K is not set
 # CONFIG_E1000 is not set
@@ -609,16 +607,14 @@ CONFIG_VORTEX=y
 CONFIG_TSI108_ETH=y
 # CONFIG_QLA3XXX is not set
 # CONFIG_ATL1 is not set
-
-#
-# Ethernet (10000 Mbit)
-#
+CONFIG_NETDEV_10000=y
 # CONFIG_CHELSIO_T1 is not set
 # CONFIG_CHELSIO_T3 is not set
 # CONFIG_IXGB is not set
 # CONFIG_S2IO is not set
 # CONFIG_MYRI10GE is not set
 # CONFIG_NETXEN_NIC is not set
+# CONFIG_MLX4_CORE is not set
 
 #
 # Token Ring devices
@@ -630,10 +626,6 @@ CONFIG_TSI108_ETH=y
 #
 # CONFIG_WLAN_PRE80211 is not set
 # CONFIG_WLAN_80211 is not set
-
-#
-# Wan interfaces
-#
 # CONFIG_WAN is not set
 # CONFIG_FDDI is not set
 # CONFIG_HIPPI is not set
@@ -676,6 +668,7 @@ CONFIG_INPUT=y
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_INPUT_JOYSTICK is not set
+# CONFIG_INPUT_TABLET is not set
 # CONFIG_INPUT_TOUCHSCREEN is not set
 # CONFIG_INPUT_MISC is not set
 
@@ -721,16 +714,11 @@ CONFIG_LEGACY_PTY_COUNT=256
 # IPMI
 #
 # CONFIG_IPMI_HANDLER is not set
-
-#
-# Watchdog Cards
-#
 # CONFIG_WATCHDOG is not set
 # CONFIG_HW_RANDOM is not set
 # CONFIG_NVRAM is not set
 CONFIG_GEN_RTC=y
 # CONFIG_GEN_RTC_X is not set
-# CONFIG_DTLK is not set
 # CONFIG_R3964 is not set
 # CONFIG_APPLICOM is not set
 # CONFIG_AGP is not set
@@ -741,10 +729,7 @@ CONFIG_GEN_RTC=y
 # TPM devices
 #
 # CONFIG_TCG_TPM is not set
-
-#
-# I2C support
-#
+CONFIG_DEVPORT=y
 # CONFIG_I2C is not set
 
 #
@@ -757,16 +742,15 @@ CONFIG_GEN_RTC=y
 # Dallas's 1-wire bus
 #
 # CONFIG_W1 is not set
-
-#
-# Hardware Monitoring support
-#
 CONFIG_HWMON=y
 # CONFIG_HWMON_VID is not set
 # CONFIG_SENSORS_ABITUGURU is not set
 # CONFIG_SENSORS_F71805F is not set
 # CONFIG_SENSORS_PC87427 is not set
+# CONFIG_SENSORS_SMSC47M1 is not set
+# CONFIG_SENSORS_SMSC47B397 is not set
 # CONFIG_SENSORS_VT1211 is not set
+# CONFIG_SENSORS_W83627HF is not set
 # CONFIG_HWMON_DEBUG_CHIP is not set
 
 #
@@ -778,16 +762,19 @@ CONFIG_HWMON=y
 # Multimedia devices
 #
 # CONFIG_VIDEO_DEV is not set
+# CONFIG_DVB_CORE is not set
+CONFIG_DAB=y
 
 #
-# Digital Video Broadcasting Devices
+# Graphics support
 #
-# CONFIG_DVB is not set
+# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
 
 #
-# Graphics support
+# Display device support
 #
-# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
+# CONFIG_DISPLAY_SUPPORT is not set
+# CONFIG_VGASTATE is not set
 # CONFIG_FB is not set
 # CONFIG_FB_IBM_GXT4500 is not set
 
@@ -818,10 +805,6 @@ CONFIG_USB_ARCH_HAS_EHCI=y
 # USB Gadget Support
 #
 # CONFIG_USB_GADGET is not set
-
-#
-# MMC/SD Card support
-#
 # CONFIG_MMC is not set
 
 #
@@ -865,14 +848,6 @@ CONFIG_USB_ARCH_HAS_EHCI=y
 #
 
 #
-# Auxiliary Display support
-#
-
-#
-# Virtualization
-#
-
-#
 # File systems
 #
 CONFIG_EXT2_FS=y
@@ -957,6 +932,7 @@ CONFIG_ROOT_NFS=y
 CONFIG_LOCKD=y
 CONFIG_NFS_COMMON=y
 CONFIG_SUNRPC=y
+# CONFIG_SUNRPC_BIND34 is not set
 # CONFIG_RPCSEC_GSS_KRB5 is not set
 # CONFIG_RPCSEC_GSS_SPKM3 is not set
 # CONFIG_SMB_FS is not set
@@ -986,6 +962,7 @@ CONFIG_MSDOS_PARTITION=y
 # CONFIG_SUN_PARTITION is not set
 # CONFIG_KARMA_PARTITION is not set
 # CONFIG_EFI_PARTITION is not set
+# CONFIG_SYSV68_PARTITION is not set
 
 #
 # Native Language Support
@@ -1005,11 +982,13 @@ CONFIG_MSDOS_PARTITION=y
 CONFIG_BITREVERSE=y
 # CONFIG_CRC_CCITT is not set
 # CONFIG_CRC16 is not set
+# CONFIG_CRC_ITU_T is not set
 CONFIG_CRC32=y
 # CONFIG_LIBCRC32C is not set
 CONFIG_PLIST=y
 CONFIG_HAS_IOMEM=y
 CONFIG_HAS_IOPORT=y
+CONFIG_HAS_DMA=y
 
 #
 # Instrumentation Support
@@ -1028,7 +1007,6 @@ CONFIG_MAGIC_SYSRQ=y
 # CONFIG_HEADERS_CHECK is not set
 CONFIG_DEBUG_KERNEL=y
 # CONFIG_DEBUG_SHIRQ is not set
-CONFIG_LOG_BUF_SHIFT=14
 CONFIG_DETECT_SOFTLOCKUP=y
 # CONFIG_SCHEDSTATS is not set
 # CONFIG_TIMER_STATS is not set
diff --git a/arch/powerpc/platforms/embedded6xx/Kconfig b/arch/powerpc/platforms/embedded6xx/Kconfig
index f2d2626..91a1652 100644
--- a/arch/powerpc/platforms/embedded6xx/Kconfig
+++ b/arch/powerpc/platforms/embedded6xx/Kconfig
@@ -28,6 +28,7 @@ config PPC_HOLLY
 	bool "PPC750GX/CL with TSI10x bridge (Hickory/Holly)"
 	select TSI108_BRIDGE
 	select PPC_UDBG_16550
+	select WANT_DEVICE_TREE
 	help
 	  Select PPC_HOLLY if configuring for an IBM 750GX/CL Eval
 	  Board with TSI108/9 bridge (Hickory/Holly)
