Return-Path: <grant.likely@secretlab.ca>
Received: from pd2mo1so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id DAB9FDDFB6
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2007 06:08:49 +1000 (EST)
Received: from pd4mr2so.prod.shaw.ca
	(pd4mr2so-qfe3.prod.shaw.ca [10.0.141.213]) by l-daemon
	(Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
	with ESMTP id <0JPY00H7MYKR2E10@l-daemon> for linuxppc-dev@ozlabs.org;
	Mon, 15 Oct 2007 14:07:39 -0600 (MDT)
Received: from pn2ml10so.prod.shaw.ca ([10.0.121.80])
	by pd4mr2so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JPY00DOXYK4PMJ0@pd4mr2so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Mon, 15 Oct 2007 14:07:37 -0600 (MDT)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JPY00G5WONONPV0@l-daemon> for linuxppc-dev@ozlabs.org;
	Mon, 15 Oct 2007 10:33:24 -0600 (MDT)
Date: Mon, 15 Oct 2007 10:33:24 -0600
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH] mpc8349emitx(gp): add UHCI support and other misc defconfig
	changes
To: Timur Tabi <timur@freescale.com>, galak@kernel.crashing.org,
	linuxppc-dev@ozlabs.org
Message-id: <20071015163324.8520.3528.stgit@trillian.cg.shawcable.net>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

USB support for the 8349itx got added a while back; but the defconfig
never got updated.  This patch updates defconfig and adds the appropriate
USB config options.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
CC: Scott Wood <scottwood@freescale.com>
CC: Kumar Gala <galak@kernel.crashing.org>
CC: Timur Tabi <timur@freescale.com>
---

 arch/powerpc/configs/mpc834x_itx_defconfig   |   87 ++++++++----
 arch/powerpc/configs/mpc834x_itxgp_defconfig |  190 ++++++++++++++++++++++----
 2 files changed, 224 insertions(+), 53 deletions(-)

diff --git a/arch/powerpc/configs/mpc834x_itx_defconfig b/arch/powerpc/configs/mpc834x_itx_defconfig
index ddafa6b..8f3d1f2 100644
--- a/arch/powerpc/configs/mpc834x_itx_defconfig
+++ b/arch/powerpc/configs/mpc834x_itx_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.23-rc4
-# Tue Aug 28 21:24:41 2007
+# Linux kernel version: 2.6.23-rc9
+# Mon Oct 15 10:28:18 2007
 #
 # CONFIG_PPC64 is not set
 
@@ -21,8 +21,13 @@ CONFIG_PPC_STD_MMU_32=y
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
@@ -83,12 +88,12 @@ CONFIG_FUTEX=y
 CONFIG_ANON_INODES=y
 # CONFIG_EPOLL is not set
 CONFIG_SIGNALFD=y
-CONFIG_TIMERFD=y
 CONFIG_EVENTFD=y
 CONFIG_SHMEM=y
 CONFIG_VM_EVENT_COUNTERS=y
-CONFIG_SLAB=y
-# CONFIG_SLUB is not set
+# CONFIG_SLUB_DEBUG is not set
+# CONFIG_SLAB is not set
+CONFIG_SLUB=y
 # CONFIG_SLOB is not set
 CONFIG_RT_MUTEXES=y
 # CONFIG_TINY_SHMEM is not set
@@ -122,7 +127,6 @@ CONFIG_DEFAULT_IOSCHED="anticipatory"
 # Platform support
 #
 # CONFIG_PPC_MULTIPLATFORM is not set
-# CONFIG_EMBEDDED6xx is not set
 # CONFIG_PPC_82xx is not set
 CONFIG_PPC_83xx=y
 # CONFIG_PPC_86xx is not set
@@ -155,6 +159,9 @@ CONFIG_MPC834x=y
 # Kernel options
 #
 # CONFIG_HIGHMEM is not set
+# CONFIG_TICK_ONESHOT is not set
+# CONFIG_NO_HZ is not set
+# CONFIG_HIGH_RES_TIMERS is not set
 # CONFIG_HZ_100 is not set
 CONFIG_HZ_250=y
 # CONFIG_HZ_300 is not set
@@ -183,9 +190,11 @@ CONFIG_VIRT_TO_BUS=y
 CONFIG_PROC_DEVICETREE=y
 # CONFIG_CMDLINE_BOOL is not set
 # CONFIG_PM is not set
+CONFIG_SUSPEND_UP_POSSIBLE=y
+CONFIG_HIBERNATION_UP_POSSIBLE=y
 CONFIG_SECCOMP=y
 CONFIG_WANT_DEVICE_TREE=y
-CONFIG_DEVICE_TREE=""
+CONFIG_DEVICE_TREE="mpc8349emitx.dts"
 CONFIG_ISA_DMA_API=y
 
 #
@@ -219,7 +228,7 @@ CONFIG_ARCH_SUPPORTS_MSI=y
 CONFIG_HIGHMEM_START=0xfe000000
 CONFIG_LOWMEM_SIZE=0x30000000
 CONFIG_KERNEL_START=0xc0000000
-CONFIG_TASK_SIZE=0x80000000
+CONFIG_TASK_SIZE=0xc0000000
 CONFIG_BOOT_LOAD=0x00800000
 
 #
@@ -419,11 +428,7 @@ CONFIG_BLK_DEV_RAM_SIZE=32768
 CONFIG_BLK_DEV_RAM_BLOCKSIZE=1024
 # CONFIG_CDROM_PKTCDVD is not set
 # CONFIG_ATA_OVER_ETH is not set
-CONFIG_MISC_DEVICES=y
-# CONFIG_PHANTOM is not set
-# CONFIG_EEPROM_93CX6 is not set
-# CONFIG_SGI_IOC4 is not set
-# CONFIG_TIFM_CORE is not set
+# CONFIG_MISC_DEVICES is not set
 CONFIG_IDE=y
 CONFIG_IDE_MAX_HWIFS=4
 # CONFIG_BLK_DEV_IDE is not set
@@ -618,6 +623,7 @@ CONFIG_NETDEV_1000=y
 # CONFIG_SIS190 is not set
 # CONFIG_SKGE is not set
 # CONFIG_SKY2 is not set
+# CONFIG_SK98LIN is not set
 # CONFIG_VIA_VELOCITY is not set
 # CONFIG_TIGON3 is not set
 # CONFIG_BNX2 is not set
@@ -625,14 +631,7 @@ CONFIG_GIANFAR=y
 CONFIG_GFAR_NAPI=y
 # CONFIG_QLA3XXX is not set
 # CONFIG_ATL1 is not set
-CONFIG_NETDEV_10000=y
-# CONFIG_CHELSIO_T1 is not set
-# CONFIG_CHELSIO_T3 is not set
-# CONFIG_IXGB is not set
-# CONFIG_S2IO is not set
-# CONFIG_MYRI10GE is not set
-# CONFIG_NETXEN_NIC is not set
-# CONFIG_MLX4_CORE is not set
+# CONFIG_NETDEV_10000 is not set
 # CONFIG_TR is not set
 
 #
@@ -666,7 +665,28 @@ CONFIG_NETDEV_10000=y
 #
 # Input device support
 #
-# CONFIG_INPUT is not set
+CONFIG_INPUT=y
+# CONFIG_INPUT_FF_MEMLESS is not set
+# CONFIG_INPUT_POLLDEV is not set
+
+#
+# Userland interfaces
+#
+# CONFIG_INPUT_MOUSEDEV is not set
+# CONFIG_INPUT_JOYDEV is not set
+# CONFIG_INPUT_TSDEV is not set
+CONFIG_INPUT_EVDEV=y
+# CONFIG_INPUT_EVBUG is not set
+
+#
+# Input Device Drivers
+#
+# CONFIG_INPUT_KEYBOARD is not set
+# CONFIG_INPUT_MOUSE is not set
+# CONFIG_INPUT_JOYSTICK is not set
+# CONFIG_INPUT_TABLET is not set
+# CONFIG_INPUT_TOUCHSCREEN is not set
+# CONFIG_INPUT_MISC is not set
 
 #
 # Hardware I/O ports
@@ -841,6 +861,17 @@ CONFIG_VIDEO_OUTPUT_CONTROL=m
 # Sound
 #
 # CONFIG_SOUND is not set
+CONFIG_HID_SUPPORT=y
+CONFIG_HID=y
+# CONFIG_HID_DEBUG is not set
+
+#
+# USB Input Devices
+#
+CONFIG_USB_HID=y
+# CONFIG_USB_HIDINPUT_POWERBOOK is not set
+# CONFIG_HID_FF is not set
+CONFIG_USB_HIDDEV=y
 CONFIG_USB_SUPPORT=y
 CONFIG_USB_ARCH_HAS_HCD=y
 CONFIG_USB_ARCH_HAS_OHCI=y
@@ -862,11 +893,11 @@ CONFIG_USB_DEVICE_CLASS=y
 CONFIG_USB_EHCI_HCD=y
 # CONFIG_USB_EHCI_SPLIT_ISO is not set
 CONFIG_USB_EHCI_ROOT_HUB_TT=y
-# CONFIG_USB_EHCI_TT_NEWSCHED is not set
+CONFIG_USB_EHCI_TT_NEWSCHED=y
 CONFIG_USB_EHCI_FSL=y
 # CONFIG_USB_ISP116X_HCD is not set
 # CONFIG_USB_OHCI_HCD is not set
-# CONFIG_USB_UHCI_HCD is not set
+CONFIG_USB_UHCI_HCD=y
 # CONFIG_USB_SL811_HCD is not set
 # CONFIG_USB_R8A66597_HCD is not set
 
@@ -893,6 +924,7 @@ CONFIG_USB_STORAGE=y
 # CONFIG_USB_STORAGE_SDDR55 is not set
 # CONFIG_USB_STORAGE_JUMPSHOT is not set
 # CONFIG_USB_STORAGE_ALAUDA is not set
+# CONFIG_USB_STORAGE_ONETOUCH is not set
 # CONFIG_USB_STORAGE_KARMA is not set
 # CONFIG_USB_LIBUSUAL is not set
 
@@ -1010,7 +1042,7 @@ CONFIG_NET_DMA=y
 #
 # DMA Devices
 #
-CONFIG_INTEL_IOATDMA=y
+# CONFIG_INTEL_IOATDMA is not set
 
 #
 # Userspace I/O
@@ -1169,7 +1201,7 @@ CONFIG_NLS_DEFAULT="iso8859-1"
 # CONFIG_NLS_CODEPAGE_1250 is not set
 # CONFIG_NLS_CODEPAGE_1251 is not set
 # CONFIG_NLS_ASCII is not set
-# CONFIG_NLS_ISO8859_1 is not set
+CONFIG_NLS_ISO8859_1=y
 # CONFIG_NLS_ISO8859_2 is not set
 # CONFIG_NLS_ISO8859_3 is not set
 # CONFIG_NLS_ISO8859_4 is not set
@@ -1213,7 +1245,7 @@ CONFIG_HAS_DMA=y
 #
 # Kernel hacking
 #
-# CONFIG_PRINTK_TIME is not set
+CONFIG_PRINTK_TIME=y
 CONFIG_ENABLE_MUST_CHECK=y
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_UNUSED_SYMBOLS is not set
@@ -1266,3 +1298,4 @@ CONFIG_CRYPTO_DES=y
 # CONFIG_CRYPTO_CAMELLIA is not set
 # CONFIG_CRYPTO_TEST is not set
 CONFIG_CRYPTO_HW=y
+# CONFIG_PPC_CLOCK is not set
diff --git a/arch/powerpc/configs/mpc834x_itxgp_defconfig b/arch/powerpc/configs/mpc834x_itxgp_defconfig
index 8241c69..303e4e5 100644
--- a/arch/powerpc/configs/mpc834x_itxgp_defconfig
+++ b/arch/powerpc/configs/mpc834x_itxgp_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.23-rc4
-# Tue Aug 28 21:24:41 2007
+# Linux kernel version: 2.6.23-rc9
+# Mon Oct 15 10:28:05 2007
 #
 # CONFIG_PPC64 is not set
 
@@ -21,8 +21,13 @@ CONFIG_PPC_STD_MMU_32=y
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
@@ -83,12 +88,12 @@ CONFIG_FUTEX=y
 CONFIG_ANON_INODES=y
 # CONFIG_EPOLL is not set
 CONFIG_SIGNALFD=y
-CONFIG_TIMERFD=y
 CONFIG_EVENTFD=y
 CONFIG_SHMEM=y
 CONFIG_VM_EVENT_COUNTERS=y
-CONFIG_SLAB=y
-# CONFIG_SLUB is not set
+# CONFIG_SLUB_DEBUG is not set
+# CONFIG_SLAB is not set
+CONFIG_SLUB=y
 # CONFIG_SLOB is not set
 CONFIG_RT_MUTEXES=y
 # CONFIG_TINY_SHMEM is not set
@@ -122,7 +127,6 @@ CONFIG_DEFAULT_IOSCHED="anticipatory"
 # Platform support
 #
 # CONFIG_PPC_MULTIPLATFORM is not set
-# CONFIG_EMBEDDED6xx is not set
 # CONFIG_PPC_82xx is not set
 CONFIG_PPC_83xx=y
 # CONFIG_PPC_86xx is not set
@@ -155,6 +159,9 @@ CONFIG_MPC834x=y
 # Kernel options
 #
 # CONFIG_HIGHMEM is not set
+# CONFIG_TICK_ONESHOT is not set
+# CONFIG_NO_HZ is not set
+# CONFIG_HIGH_RES_TIMERS is not set
 # CONFIG_HZ_100 is not set
 CONFIG_HZ_250=y
 # CONFIG_HZ_300 is not set
@@ -183,9 +190,11 @@ CONFIG_VIRT_TO_BUS=y
 CONFIG_PROC_DEVICETREE=y
 # CONFIG_CMDLINE_BOOL is not set
 # CONFIG_PM is not set
+CONFIG_SUSPEND_UP_POSSIBLE=y
+CONFIG_HIBERNATION_UP_POSSIBLE=y
 CONFIG_SECCOMP=y
 CONFIG_WANT_DEVICE_TREE=y
-CONFIG_DEVICE_TREE=""
+CONFIG_DEVICE_TREE="mpc8349emitxgp.dts"
 CONFIG_ISA_DMA_API=y
 
 #
@@ -219,7 +228,7 @@ CONFIG_ARCH_SUPPORTS_MSI=y
 CONFIG_HIGHMEM_START=0xfe000000
 CONFIG_LOWMEM_SIZE=0x30000000
 CONFIG_KERNEL_START=0xc0000000
-CONFIG_TASK_SIZE=0x80000000
+CONFIG_TASK_SIZE=0xc0000000
 CONFIG_BOOT_LOAD=0x00800000
 
 #
@@ -412,17 +421,14 @@ CONFIG_BLK_DEV_LOOP=y
 # CONFIG_BLK_DEV_CRYPTOLOOP is not set
 # CONFIG_BLK_DEV_NBD is not set
 # CONFIG_BLK_DEV_SX8 is not set
+# CONFIG_BLK_DEV_UB is not set
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_COUNT=16
 CONFIG_BLK_DEV_RAM_SIZE=32768
 CONFIG_BLK_DEV_RAM_BLOCKSIZE=1024
 # CONFIG_CDROM_PKTCDVD is not set
 # CONFIG_ATA_OVER_ETH is not set
-CONFIG_MISC_DEVICES=y
-# CONFIG_PHANTOM is not set
-# CONFIG_EEPROM_93CX6 is not set
-# CONFIG_SGI_IOC4 is not set
-# CONFIG_TIFM_CORE is not set
+# CONFIG_MISC_DEVICES is not set
 # CONFIG_IDE is not set
 
 #
@@ -549,6 +555,7 @@ CONFIG_NETDEV_1000=y
 # CONFIG_SIS190 is not set
 # CONFIG_SKGE is not set
 # CONFIG_SKY2 is not set
+# CONFIG_SK98LIN is not set
 # CONFIG_VIA_VELOCITY is not set
 # CONFIG_TIGON3 is not set
 # CONFIG_BNX2 is not set
@@ -556,14 +563,7 @@ CONFIG_GIANFAR=y
 CONFIG_GFAR_NAPI=y
 # CONFIG_QLA3XXX is not set
 # CONFIG_ATL1 is not set
-CONFIG_NETDEV_10000=y
-# CONFIG_CHELSIO_T1 is not set
-# CONFIG_CHELSIO_T3 is not set
-# CONFIG_IXGB is not set
-# CONFIG_S2IO is not set
-# CONFIG_MYRI10GE is not set
-# CONFIG_NETXEN_NIC is not set
-# CONFIG_MLX4_CORE is not set
+# CONFIG_NETDEV_10000 is not set
 # CONFIG_TR is not set
 
 #
@@ -571,6 +571,16 @@ CONFIG_NETDEV_10000=y
 #
 # CONFIG_WLAN_PRE80211 is not set
 # CONFIG_WLAN_80211 is not set
+
+#
+# USB Network Adapters
+#
+# CONFIG_USB_CATC is not set
+# CONFIG_USB_KAWETH is not set
+# CONFIG_USB_PEGASUS is not set
+# CONFIG_USB_RTL8150 is not set
+# CONFIG_USB_USBNET_MII is not set
+# CONFIG_USB_USBNET is not set
 # CONFIG_WAN is not set
 # CONFIG_FDDI is not set
 # CONFIG_HIPPI is not set
@@ -587,7 +597,28 @@ CONFIG_NETDEV_10000=y
 #
 # Input device support
 #
-# CONFIG_INPUT is not set
+CONFIG_INPUT=y
+# CONFIG_INPUT_FF_MEMLESS is not set
+# CONFIG_INPUT_POLLDEV is not set
+
+#
+# Userland interfaces
+#
+# CONFIG_INPUT_MOUSEDEV is not set
+# CONFIG_INPUT_JOYDEV is not set
+# CONFIG_INPUT_TSDEV is not set
+CONFIG_INPUT_EVDEV=y
+# CONFIG_INPUT_EVBUG is not set
+
+#
+# Input Device Drivers
+#
+# CONFIG_INPUT_KEYBOARD is not set
+# CONFIG_INPUT_MOUSE is not set
+# CONFIG_INPUT_JOYSTICK is not set
+# CONFIG_INPUT_TABLET is not set
+# CONFIG_INPUT_TOUCHSCREEN is not set
+# CONFIG_INPUT_MISC is not set
 
 #
 # Hardware I/O ports
@@ -637,6 +668,11 @@ CONFIG_83xx_WDT=y
 #
 # CONFIG_PCIPCWATCHDOG is not set
 # CONFIG_WDTPCI is not set
+
+#
+# USB-based Watchdog Cards
+#
+# CONFIG_USBPCWATCHDOG is not set
 CONFIG_HW_RANDOM=y
 # CONFIG_NVRAM is not set
 # CONFIG_GEN_RTC is not set
@@ -681,6 +717,7 @@ CONFIG_I2C_MPC=y
 # CONFIG_I2C_SIS96X is not set
 # CONFIG_I2C_TAOS_EVM is not set
 # CONFIG_I2C_STUB is not set
+# CONFIG_I2C_TINY_USB is not set
 # CONFIG_I2C_VIA is not set
 # CONFIG_I2C_VIAPRO is not set
 # CONFIG_I2C_VOODOO3 is not set
@@ -736,6 +773,7 @@ CONFIG_SPI_MPC83xx=y
 # CONFIG_VIDEO_DEV is not set
 # CONFIG_DVB_CORE is not set
 CONFIG_DAB=y
+# CONFIG_USB_DABUSB is not set
 
 #
 # Graphics support
@@ -755,19 +793,118 @@ CONFIG_VIDEO_OUTPUT_CONTROL=m
 # Sound
 #
 # CONFIG_SOUND is not set
+CONFIG_HID_SUPPORT=y
+CONFIG_HID=y
+# CONFIG_HID_DEBUG is not set
+
+#
+# USB Input Devices
+#
+CONFIG_USB_HID=y
+# CONFIG_USB_HIDINPUT_POWERBOOK is not set
+# CONFIG_HID_FF is not set
+CONFIG_USB_HIDDEV=y
 CONFIG_USB_SUPPORT=y
 CONFIG_USB_ARCH_HAS_HCD=y
 CONFIG_USB_ARCH_HAS_OHCI=y
 CONFIG_USB_ARCH_HAS_EHCI=y
-# CONFIG_USB is not set
+CONFIG_USB=y
+# CONFIG_USB_DEBUG is not set
+
+#
+# Miscellaneous USB options
+#
+CONFIG_USB_DEVICEFS=y
+CONFIG_USB_DEVICE_CLASS=y
+# CONFIG_USB_DYNAMIC_MINORS is not set
+# CONFIG_USB_OTG is not set
+
+#
+# USB Host Controller Drivers
+#
+CONFIG_USB_EHCI_HCD=y
+# CONFIG_USB_EHCI_SPLIT_ISO is not set
 CONFIG_USB_EHCI_ROOT_HUB_TT=y
+CONFIG_USB_EHCI_TT_NEWSCHED=y
 CONFIG_USB_EHCI_FSL=y
+# CONFIG_USB_ISP116X_HCD is not set
+# CONFIG_USB_OHCI_HCD is not set
+CONFIG_USB_UHCI_HCD=y
+# CONFIG_USB_SL811_HCD is not set
+# CONFIG_USB_R8A66597_HCD is not set
+
+#
+# USB Device Class drivers
+#
+# CONFIG_USB_ACM is not set
+# CONFIG_USB_PRINTER is not set
 
 #
 # NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
 #
 
 #
+# may also be needed; see USB_STORAGE Help for more information
+#
+CONFIG_USB_STORAGE=y
+# CONFIG_USB_STORAGE_DEBUG is not set
+# CONFIG_USB_STORAGE_DATAFAB is not set
+# CONFIG_USB_STORAGE_FREECOM is not set
+# CONFIG_USB_STORAGE_DPCM is not set
+# CONFIG_USB_STORAGE_USBAT is not set
+# CONFIG_USB_STORAGE_SDDR09 is not set
+# CONFIG_USB_STORAGE_SDDR55 is not set
+# CONFIG_USB_STORAGE_JUMPSHOT is not set
+# CONFIG_USB_STORAGE_ALAUDA is not set
+# CONFIG_USB_STORAGE_ONETOUCH is not set
+# CONFIG_USB_STORAGE_KARMA is not set
+# CONFIG_USB_LIBUSUAL is not set
+
+#
+# USB Imaging devices
+#
+# CONFIG_USB_MDC800 is not set
+# CONFIG_USB_MICROTEK is not set
+CONFIG_USB_MON=y
+
+#
+# USB port drivers
+#
+
+#
+# USB Serial Converter support
+#
+# CONFIG_USB_SERIAL is not set
+
+#
+# USB Miscellaneous drivers
+#
+# CONFIG_USB_EMI62 is not set
+# CONFIG_USB_EMI26 is not set
+# CONFIG_USB_ADUTUX is not set
+# CONFIG_USB_AUERSWALD is not set
+# CONFIG_USB_RIO500 is not set
+# CONFIG_USB_LEGOTOWER is not set
+# CONFIG_USB_LCD is not set
+# CONFIG_USB_BERRY_CHARGE is not set
+# CONFIG_USB_LED is not set
+# CONFIG_USB_CYPRESS_CY7C63 is not set
+# CONFIG_USB_CYTHERM is not set
+# CONFIG_USB_PHIDGET is not set
+# CONFIG_USB_IDMOUSE is not set
+# CONFIG_USB_FTDI_ELAN is not set
+# CONFIG_USB_APPLEDISPLAY is not set
+# CONFIG_USB_SISUSBVGA is not set
+# CONFIG_USB_LD is not set
+# CONFIG_USB_TRANCEVIBRATOR is not set
+# CONFIG_USB_IOWARRIOR is not set
+# CONFIG_USB_TEST is not set
+
+#
+# USB DSL modem support
+#
+
+#
 # USB Gadget Support
 #
 # CONFIG_USB_GADGET is not set
@@ -837,7 +974,7 @@ CONFIG_NET_DMA=y
 #
 # DMA Devices
 #
-CONFIG_INTEL_IOATDMA=y
+# CONFIG_INTEL_IOATDMA is not set
 
 #
 # Userspace I/O
@@ -996,7 +1133,7 @@ CONFIG_NLS_DEFAULT="iso8859-1"
 # CONFIG_NLS_CODEPAGE_1250 is not set
 # CONFIG_NLS_CODEPAGE_1251 is not set
 # CONFIG_NLS_ASCII is not set
-# CONFIG_NLS_ISO8859_1 is not set
+CONFIG_NLS_ISO8859_1=y
 # CONFIG_NLS_ISO8859_2 is not set
 # CONFIG_NLS_ISO8859_3 is not set
 # CONFIG_NLS_ISO8859_4 is not set
@@ -1040,7 +1177,7 @@ CONFIG_HAS_DMA=y
 #
 # Kernel hacking
 #
-# CONFIG_PRINTK_TIME is not set
+CONFIG_PRINTK_TIME=y
 CONFIG_ENABLE_MUST_CHECK=y
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_UNUSED_SYMBOLS is not set
@@ -1093,3 +1230,4 @@ CONFIG_CRYPTO_DES=y
 # CONFIG_CRYPTO_CAMELLIA is not set
 # CONFIG_CRYPTO_TEST is not set
 CONFIG_CRYPTO_HW=y
+# CONFIG_PPC_CLOCK is not set
