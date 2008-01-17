Return-Path: <m8@semihalf.com>
Received: from mail.semihalf.com (mail.semihalf.com [83.15.139.206])
	by ozlabs.org (Postfix) with ESMTP id DAE58DDF00
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jan 2008 01:30:39 +1100 (EST)
Received: from localhost (unknown [127.0.0.1])
	by mail.semihalf.com (Postfix) with ESMTP id 05E48143CD
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jan 2008 15:37:19 +0100 (CET)
Received: from mail.semihalf.com ([127.0.0.1])
	by localhost (mail.semihalf.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 18943-10 for <linuxppc-dev@ozlabs.org>;
	Thu, 17 Jan 2008 15:37:13 +0100 (CET)
Received: from hekate.izotz.org (frozen.izotz.org [83.175.187.135])
	by mail.semihalf.com (Postfix) with ESMTP id 36421143CB
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jan 2008 15:37:12 +0100 (CET)
From: Marian Balakowicz <m8@semihalf.com>
Subject: [PATCH] [POWERPC] Update TQM5200,
	CM5200 and Motion-PRO _defconfig and .dts files
To: linuxppc-dev@ozlabs.org
Date: Thu, 17 Jan 2008 15:31:30 +0100
Message-ID: <20080117143024.15372.95923.stgit@hekate.izotz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Updates include:
- set soc node compatible property to "fsl,mpc5200-immr"
- update i2c device tree nodes
- add mdio node
- add lpb bus node and flash device (without partitions defined)
- add second mscan node for Motio-PRO
- add rtc i2c nodes and enable RTC in _defconfigs
- use SLUB insteand of SLAB
- enable printk timestamp

Signed-off-by: Marian Balakowicz <m8@semihalf.com>
---

This patch was applied and tested against:
git://git.secretlab.ca/git/linux-2.6-mpc52xx.git#for-2.6.25

 arch/powerpc/boot/dts/cm5200.dts         |   40 +++++++
 arch/powerpc/boot/dts/motionpro.dts      |   49 ++++++++-
 arch/powerpc/boot/dts/tqm5200.dts        |   45 ++++++++
 arch/powerpc/configs/cm5200_defconfig    |   53 ++++------
 arch/powerpc/configs/motionpro_defconfig |  161 ++++++++++++++----------------
 arch/powerpc/configs/tqm5200_defconfig   |   91 ++++++++---------
 6 files changed, 263 insertions(+), 176 deletions(-)


diff --git a/arch/powerpc/boot/dts/cm5200.dts b/arch/powerpc/boot/dts/cm5200.dts
index 9295083..ff01478 100644
--- a/arch/powerpc/boot/dts/cm5200.dts
+++ b/arch/powerpc/boot/dts/cm5200.dts
@@ -46,7 +46,7 @@
 
 	soc5200@f0000000 {
 		model = "fsl,mpc5200b";
-		compatible = "fsl,mpc5200b";
+		compatible = "fsl,mpc5200-immr";
 		revision = "";			// from bootloader
 		device_type = "soc";
 		ranges = <0 f0000000 0000c000>;
@@ -214,13 +214,31 @@
 		ethernet@3000 {
 			device_type = "network";
 			compatible = "mpc5200b-fec","mpc5200-fec";
-			reg = <3000 800>;
+			reg = <3000 400>;
 			local-mac-address = [ 00 00 00 00 00 00 ]; /* Filled in by U-Boot */
 			interrupts = <2 5 0>;
 			interrupt-parent = <&mpc5200_pic>;
+			phy-handle = <&phy0>;
+		};
+
+		mdio@3000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			device_type = "mdio";
+			compatible = "mpc5200b-fec-phy";
+			reg = <3000 400>;	// fec range, since we need to setup fec interrupts
+			interrupts = <2 5 0>;	// these are for "mii command finished", not link changes & co.
+			interrupt-parent = <&mpc5200_pic>;
+
+			phy0:ethernet-phy@0 {
+				device_type = "ethernet-phy";
+				reg = <0>;
+			};
 		};
 
 		i2c@3d40 {
+			#address-cells = <1>;
+			#size-cells = <0>;
 			compatible = "mpc5200b-i2c","mpc5200-i2c","fsl-i2c";
 			reg = <3d40 40>;
 			interrupts = <2 10 0>;
@@ -233,4 +251,22 @@
 			reg = <8000 4000>;
 		};
 	};
+
+	lpb {
+		model = "fsl,lpb";
+		compatible = "fsl,lpb";
+		#address-cells = <2>;
+		#size-cells = <1>;
+		ranges = <0 0 fc000000 2000000>;
+
+		// 16-bit flash device at LocalPlus Bus CS0
+		flash@0,0 {
+			compatible = "cfi-flash";
+			reg = <0 0 2000000>;
+			bank-width = <2>;
+			device-width = <2>;
+			#size-cells = <1>;
+			#address-cells = <1>;
+		};
+	};
 };
diff --git a/arch/powerpc/boot/dts/motionpro.dts b/arch/powerpc/boot/dts/motionpro.dts
index d8c316a..1a046aa 100644
--- a/arch/powerpc/boot/dts/motionpro.dts
+++ b/arch/powerpc/boot/dts/motionpro.dts
@@ -46,7 +46,7 @@
 
 	soc5200@f0000000 {
 		model = "fsl,mpc5200b";
-		compatible = "fsl,mpc5200b";
+		compatible = "fsl,mpc5200-immr";
 		revision = "";			// from bootloader
 		device_type = "soc";
 		ranges = <0 f0000000 0000c000>;
@@ -134,6 +134,13 @@
 			interrupt-parent = <&mpc5200_pic>;
 		};
 
+		mscan@900 {
+			compatible = "mpc5200b-mscan\0mpc5200-mscan";
+			interrupts = <2 11 0>;
+			interrupt-parent = <&mpc5200_pic>;
+			reg = <900 80>;
+		};
+
 		mscan@980 {
 			compatible = "mpc5200b-mscan","mpc5200-mscan";
 			interrupts = <2 12 0>;
@@ -155,7 +162,6 @@
 			interrupt-parent = <&mpc5200_pic>;
 		};
 
-
 		spi@f00 {
 			compatible = "mpc5200b-spi","mpc5200-spi";
 			reg = <f00 20>;
@@ -216,10 +222,26 @@
 		ethernet@3000 {
 			device_type = "network";
 			compatible = "mpc5200b-fec","mpc5200-fec";
-			reg = <3000 800>;
+			reg = <3000 400>;
 			local-mac-address = [ 00 00 00 00 00 00 ]; /* Filled in by U-Boot */
 			interrupts = <2 5 0>;
 			interrupt-parent = <&mpc5200_pic>;
+			phy-handle = <&phy0>;
+		};
+
+		mdio@3000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			device_type = "mdio";
+			compatible = "mpc5200b-fec-phy";
+			reg = <3000 400>;	// fec range, since we need to setup fec interrupts
+			interrupts = <2 5 0>;	// these are for "mii command finished", not link changes & co.
+			interrupt-parent = <&mpc5200_pic>;
+
+			phy0:ethernet-phy@0 {
+				device_type = "ethernet-phy";
+				reg = <0>;
+			};
 		};
 
 		ata@3a00 {
@@ -230,11 +252,19 @@
 		};
 
 		i2c@3d40 {
+			#address-cells = <1>;
+			#size-cells = <0>;
 			compatible = "mpc5200b-i2c","mpc5200-i2c","fsl-i2c";
 			reg = <3d40 40>;
 			interrupts = <2 10 0>;
 			interrupt-parent = <&mpc5200_pic>;
 			fsl5200-clocking;
+
+			rtc@68 {
+				device_type = "rtc";
+				compatible = "dallas,ds1339";
+				reg = <68>;
+			};
 		};
 
 		sram@8000 {
@@ -248,7 +278,8 @@
 		compatible = "fsl,lpb";
 		#address-cells = <2>;
 		#size-cells = <1>;
-		ranges = <1 0 50000000 00010000
+		ranges = <0 0 ff000000 01000000
+			  1 0 50000000 00010000
 			  2 0 50010000 00010000
 			  3 0 50020000 00010000>;
 
@@ -279,6 +310,16 @@
 			compatible = "promess,pro_module_dio";
 			reg = <3 800 2>;
 		};
+
+		// 16-bit flash device at LocalPlus Bus CS0
+		flash@0,0 {
+			compatible = "cfi-flash";
+			reg = <0 0 01000000>;
+			bank-width = <2>;
+			device-width = <2>;
+			#size-cells = <1>;
+			#address-cells = <1>;
+		};
 	};
 
 	pci@f0000d00 {
diff --git a/arch/powerpc/boot/dts/tqm5200.dts b/arch/powerpc/boot/dts/tqm5200.dts
index 5017cec..54fb2a2 100644
--- a/arch/powerpc/boot/dts/tqm5200.dts
+++ b/arch/powerpc/boot/dts/tqm5200.dts
@@ -46,7 +46,7 @@
 
 	soc5200@f0000000 {
 		model = "fsl,mpc5200";
-		compatible = "fsl,mpc5200";
+		compatible = "fsl,mpc5200-immr";
 		revision = "";			// from bootloader
 		device_type = "soc";
 		ranges = <0 f0000000 0000c000>;
@@ -134,10 +134,26 @@
 		ethernet@3000 {
 			device_type = "network";
 			compatible = "mpc5200-fec";
-			reg = <3000 800>;
+			reg = <3000 400>;
 			local-mac-address = [ 00 00 00 00 00 00 ]; /* Filled in by U-Boot */
 			interrupts = <2 5 0>;
 			interrupt-parent = <&mpc5200_pic>;
+			phy-handle = <&phy0>;
+		};
+
+		mdio@3000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			device_type = "mdio";
+			compatible = "mpc5200b-fec-phy";
+			reg = <3000 400>;	// fec range, since we need to setup fec interrupts
+			interrupts = <2 5 0>;	// these are for "mii command finished", not link changes & co.
+			interrupt-parent = <&mpc5200_pic>;
+
+			phy0:ethernet-phy@0 {
+				device_type = "ethernet-phy";
+				reg = <0>;
+			};
 		};
 
 		ata@3a00 {
@@ -148,11 +164,19 @@
 		};
 
 		i2c@3d40 {
+			#address-cells = <1>;
+			#size-cells = <0>;
 			compatible = "mpc5200-i2c","fsl-i2c";
 			reg = <3d40 40>;
 			interrupts = <2 10 0>;
 			interrupt-parent = <&mpc5200_pic>;
 			fsl5200-clocking;
+
+			rtc@68 {
+				device_type = "rtc";
+				compatible = "dallas,ds1307";
+				reg = <68>;
+			};
 		};
 
 		sram@8000 {
@@ -161,6 +185,23 @@
 		};
 	};
 
+	lpb {
+		model = "fsl,lpb";
+		compatible = "fsl,lpb";
+		#address-cells = <2>;
+		#size-cells = <1>;
+		ranges = <0 0 fc000000 02000000>;
+
+		flash@0,0 {
+			compatible = "cfi-flash";
+			reg = <0 0 02000000>;
+			bank-width = <4>;
+			device-width = <2>;
+			#size-cells = <1>;
+			#address-cells = <1>;
+		};
+	};
+
 	pci@f0000d00 {
 		#interrupt-cells = <1>;
 		#size-cells = <2>;
diff --git a/arch/powerpc/configs/cm5200_defconfig b/arch/powerpc/configs/cm5200_defconfig
index a17d966..4fcedcd 100644
--- a/arch/powerpc/configs/cm5200_defconfig
+++ b/arch/powerpc/configs/cm5200_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.23
-# Mon Oct 29 14:06:34 2007
+# Linux kernel version: 2.6.24-rc6
+# Tue Jan 15 16:03:14 2008
 #
 # CONFIG_PPC64 is not set
 
@@ -67,11 +67,14 @@ CONFIG_SYSVIPC_SYSCTL=y
 # CONFIG_BSD_PROCESS_ACCT is not set
 # CONFIG_TASKSTATS is not set
 # CONFIG_USER_NS is not set
+# CONFIG_PID_NS is not set
 # CONFIG_AUDIT is not set
 # CONFIG_IKCONFIG is not set
 CONFIG_LOG_BUF_SHIFT=14
+# CONFIG_CGROUPS is not set
 CONFIG_FAIR_GROUP_SCHED=y
 CONFIG_FAIR_USER_SCHED=y
+# CONFIG_FAIR_CGROUP_SCHED is not set
 CONFIG_SYSFS_DEPRECATED=y
 # CONFIG_RELAY is not set
 CONFIG_BLK_DEV_INITRD=y
@@ -93,18 +96,14 @@ CONFIG_SIGNALFD=y
 CONFIG_EVENTFD=y
 CONFIG_SHMEM=y
 CONFIG_VM_EVENT_COUNTERS=y
-CONFIG_SLAB=y
-# CONFIG_SLUB is not set
+CONFIG_SLUB_DEBUG=y
+# CONFIG_SLAB is not set
+CONFIG_SLUB=y
 # CONFIG_SLOB is not set
 CONFIG_RT_MUTEXES=y
 # CONFIG_TINY_SHMEM is not set
 CONFIG_BASE_SMALL=0
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-# CONFIG_MODULE_FORCE_UNLOAD is not set
-# CONFIG_MODVERSIONS is not set
-# CONFIG_MODULE_SRCVERSION_ALL is not set
-# CONFIG_KMOD is not set
+# CONFIG_MODULES is not set
 CONFIG_BLOCK=y
 # CONFIG_LBD is not set
 # CONFIG_BLK_DEV_IO_TRACE is not set
@@ -246,7 +245,7 @@ CONFIG_PACKET=y
 # CONFIG_PACKET_MMAP is not set
 CONFIG_UNIX=y
 CONFIG_XFRM=y
-CONFIG_XFRM_USER=m
+CONFIG_XFRM_USER=y
 # CONFIG_XFRM_SUB_POLICY is not set
 # CONFIG_XFRM_MIGRATE is not set
 # CONFIG_NET_KEY is not set
@@ -297,10 +296,6 @@ CONFIG_DEFAULT_TCP_CONG="cubic"
 # CONFIG_LAPB is not set
 # CONFIG_ECONET is not set
 # CONFIG_WAN_ROUTER is not set
-
-#
-# QoS and/or fair queueing
-#
 # CONFIG_NET_SCHED is not set
 
 #
@@ -457,7 +452,6 @@ CONFIG_CHR_DEV_SG=y
 # CONFIG_SCSI_CONSTANTS is not set
 # CONFIG_SCSI_LOGGING is not set
 # CONFIG_SCSI_SCAN_ASYNC is not set
-CONFIG_SCSI_WAIT_SCAN=m
 
 #
 # SCSI Transports
@@ -496,7 +490,6 @@ CONFIG_NETDEVICES=y
 # CONFIG_USB_KAWETH is not set
 # CONFIG_USB_PEGASUS is not set
 # CONFIG_USB_RTL8150 is not set
-# CONFIG_USB_USBNET_MII is not set
 # CONFIG_USB_USBNET is not set
 # CONFIG_WAN is not set
 # CONFIG_PPP is not set
@@ -543,7 +536,6 @@ CONFIG_UNIX98_PTYS=y
 CONFIG_LEGACY_PTYS=y
 CONFIG_LEGACY_PTY_COUNT=256
 # CONFIG_IPMI_HANDLER is not set
-# CONFIG_WATCHDOG is not set
 # CONFIG_HW_RANDOM is not set
 # CONFIG_NVRAM is not set
 # CONFIG_GEN_RTC is not set
@@ -569,7 +561,6 @@ CONFIG_I2C_MPC=y
 # CONFIG_I2C_PARPORT_LIGHT is not set
 # CONFIG_I2C_SIMTEC is not set
 # CONFIG_I2C_TAOS_EVM is not set
-# CONFIG_I2C_STUB is not set
 # CONFIG_I2C_TINY_USB is not set
 
 #
@@ -598,6 +589,7 @@ CONFIG_I2C_MPC=y
 # CONFIG_W1 is not set
 # CONFIG_POWER_SUPPLY is not set
 # CONFIG_HWMON is not set
+# CONFIG_WATCHDOG is not set
 
 #
 # Sonics Silicon Backplane
@@ -621,7 +613,7 @@ CONFIG_SSB_POSSIBLE=y
 # Graphics support
 #
 # CONFIG_VGASTATE is not set
-CONFIG_VIDEO_OUTPUT_CONTROL=m
+CONFIG_VIDEO_OUTPUT_CONTROL=y
 # CONFIG_FB is not set
 # CONFIG_BACKLIGHT_LCD_SUPPORT is not set
 
@@ -683,6 +675,7 @@ CONFIG_USB_STORAGE=y
 # CONFIG_USB_STORAGE_DEBUG is not set
 # CONFIG_USB_STORAGE_DATAFAB is not set
 # CONFIG_USB_STORAGE_FREECOM is not set
+# CONFIG_USB_STORAGE_ISD200 is not set
 # CONFIG_USB_STORAGE_DPCM is not set
 # CONFIG_USB_STORAGE_USBAT is not set
 # CONFIG_USB_STORAGE_SDDR09 is not set
@@ -761,7 +754,6 @@ CONFIG_EXT3_FS_XATTR=y
 # CONFIG_EXT3_FS_SECURITY is not set
 # CONFIG_EXT4DEV_FS is not set
 CONFIG_JBD=y
-# CONFIG_JBD_DEBUG is not set
 CONFIG_FS_MBCACHE=y
 # CONFIG_REISERFS_FS is not set
 # CONFIG_JFS_FS is not set
@@ -936,16 +928,13 @@ CONFIG_PLIST=y
 CONFIG_HAS_IOMEM=y
 CONFIG_HAS_IOPORT=y
 CONFIG_HAS_DMA=y
-
-#
-# Instrumentation Support
-#
-# CONFIG_PROFILING is not set
+# CONFIG_INSTRUMENTATION is not set
 
 #
 # Kernel hacking
 #
-# CONFIG_PRINTK_TIME is not set
+CONFIG_PRINTK_TIME=y
+CONFIG_ENABLE_WARN_DEPRECATED=y
 CONFIG_ENABLE_MUST_CHECK=y
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_UNUSED_SYMBOLS is not set
@@ -957,7 +946,7 @@ CONFIG_DETECT_SOFTLOCKUP=y
 CONFIG_SCHED_DEBUG=y
 # CONFIG_SCHEDSTATS is not set
 # CONFIG_TIMER_STATS is not set
-# CONFIG_DEBUG_SLAB is not set
+# CONFIG_SLUB_DEBUG_ON is not set
 # CONFIG_DEBUG_RT_MUTEXES is not set
 # CONFIG_RT_MUTEX_TESTER is not set
 # CONFIG_DEBUG_SPINLOCK is not set
@@ -969,10 +958,11 @@ CONFIG_SCHED_DEBUG=y
 # CONFIG_DEBUG_INFO is not set
 # CONFIG_DEBUG_VM is not set
 # CONFIG_DEBUG_LIST is not set
+# CONFIG_DEBUG_SG is not set
 CONFIG_FORCED_INLINING=y
 # CONFIG_BOOT_PRINTK_DELAY is not set
-# CONFIG_RCU_TORTURE_TEST is not set
 # CONFIG_FAULT_INJECTION is not set
+# CONFIG_SAMPLES is not set
 # CONFIG_DEBUG_STACKOVERFLOW is not set
 # CONFIG_DEBUG_STACK_USAGE is not set
 # CONFIG_DEBUG_PAGEALLOC is not set
@@ -1002,9 +992,9 @@ CONFIG_CRYPTO_MD5=y
 # CONFIG_CRYPTO_WP512 is not set
 # CONFIG_CRYPTO_TGR192 is not set
 # CONFIG_CRYPTO_GF128MUL is not set
-CONFIG_CRYPTO_ECB=m
+CONFIG_CRYPTO_ECB=y
 CONFIG_CRYPTO_CBC=y
-CONFIG_CRYPTO_PCBC=m
+CONFIG_CRYPTO_PCBC=y
 # CONFIG_CRYPTO_LRW is not set
 # CONFIG_CRYPTO_XTS is not set
 # CONFIG_CRYPTO_CRYPTD is not set
@@ -1025,7 +1015,6 @@ CONFIG_CRYPTO_DES=y
 # CONFIG_CRYPTO_MICHAEL_MIC is not set
 # CONFIG_CRYPTO_CRC32C is not set
 # CONFIG_CRYPTO_CAMELLIA is not set
-# CONFIG_CRYPTO_TEST is not set
 # CONFIG_CRYPTO_AUTHENC is not set
 CONFIG_CRYPTO_HW=y
 CONFIG_PPC_CLOCK=y
diff --git a/arch/powerpc/configs/motionpro_defconfig b/arch/powerpc/configs/motionpro_defconfig
index fd7a327..510ac66 100644
--- a/arch/powerpc/configs/motionpro_defconfig
+++ b/arch/powerpc/configs/motionpro_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.23
-# Mon Oct 29 14:11:27 2007
+# Linux kernel version: 2.6.24-rc6
+# Thu Jan 17 12:40:29 2008
 #
 # CONFIG_PPC64 is not set
 
@@ -67,11 +67,14 @@ CONFIG_SYSVIPC_SYSCTL=y
 # CONFIG_BSD_PROCESS_ACCT is not set
 # CONFIG_TASKSTATS is not set
 # CONFIG_USER_NS is not set
+# CONFIG_PID_NS is not set
 # CONFIG_AUDIT is not set
 # CONFIG_IKCONFIG is not set
 CONFIG_LOG_BUF_SHIFT=14
+# CONFIG_CGROUPS is not set
 CONFIG_FAIR_GROUP_SCHED=y
 CONFIG_FAIR_USER_SCHED=y
+# CONFIG_FAIR_CGROUP_SCHED is not set
 CONFIG_SYSFS_DEPRECATED=y
 # CONFIG_RELAY is not set
 CONFIG_BLK_DEV_INITRD=y
@@ -93,18 +96,14 @@ CONFIG_SIGNALFD=y
 CONFIG_EVENTFD=y
 CONFIG_SHMEM=y
 CONFIG_VM_EVENT_COUNTERS=y
-CONFIG_SLAB=y
-# CONFIG_SLUB is not set
+CONFIG_SLUB_DEBUG=y
+# CONFIG_SLAB is not set
+CONFIG_SLUB=y
 # CONFIG_SLOB is not set
 CONFIG_RT_MUTEXES=y
 # CONFIG_TINY_SHMEM is not set
 CONFIG_BASE_SMALL=0
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-# CONFIG_MODULE_FORCE_UNLOAD is not set
-# CONFIG_MODVERSIONS is not set
-# CONFIG_MODULE_SRCVERSION_ALL is not set
-# CONFIG_KMOD is not set
+# CONFIG_MODULES is not set
 CONFIG_BLOCK=y
 # CONFIG_LBD is not set
 # CONFIG_BLK_DEV_IO_TRACE is not set
@@ -246,7 +245,7 @@ CONFIG_PACKET=y
 # CONFIG_PACKET_MMAP is not set
 CONFIG_UNIX=y
 CONFIG_XFRM=y
-CONFIG_XFRM_USER=m
+CONFIG_XFRM_USER=y
 # CONFIG_XFRM_SUB_POLICY is not set
 # CONFIG_XFRM_MIGRATE is not set
 # CONFIG_NET_KEY is not set
@@ -297,10 +296,6 @@ CONFIG_DEFAULT_TCP_CONG="cubic"
 # CONFIG_LAPB is not set
 # CONFIG_ECONET is not set
 # CONFIG_WAN_ROUTER is not set
-
-#
-# QoS and/or fair queueing
-#
 # CONFIG_NET_SCHED is not set
 
 #
@@ -456,7 +451,6 @@ CONFIG_CHR_DEV_SG=y
 # CONFIG_SCSI_CONSTANTS is not set
 # CONFIG_SCSI_LOGGING is not set
 # CONFIG_SCSI_SCAN_ASYNC is not set
-CONFIG_SCSI_WAIT_SCAN=m
 
 #
 # SCSI Transports
@@ -472,7 +466,7 @@ CONFIG_SCSI_LOWLEVEL=y
 CONFIG_ATA=y
 # CONFIG_ATA_NONSTANDARD is not set
 CONFIG_PATA_MPC52xx=y
-CONFIG_PATA_PLATFORM=y
+# CONFIG_PATA_PLATFORM is not set
 # CONFIG_MD is not set
 # CONFIG_MACINTOSH_DRIVERS is not set
 CONFIG_NETDEVICES=y
@@ -485,15 +479,14 @@ CONFIG_NETDEVICES=y
 # CONFIG_VETH is not set
 # CONFIG_PHYLIB is not set
 CONFIG_NET_ETHERNET=y
-CONFIG_MII=y
+# CONFIG_MII is not set
 # CONFIG_IBM_NEW_EMAC_ZMII is not set
 # CONFIG_IBM_NEW_EMAC_RGMII is not set
 # CONFIG_IBM_NEW_EMAC_TAH is not set
 # CONFIG_IBM_NEW_EMAC_EMAC4 is not set
 # CONFIG_B44 is not set
-CONFIG_NETDEV_1000=y
-# CONFIG_MV643XX_ETH is not set
-CONFIG_NETDEV_10000=y
+# CONFIG_NETDEV_1000 is not set
+# CONFIG_NETDEV_10000 is not set
 
 #
 # Wireless LAN
@@ -545,7 +538,6 @@ CONFIG_UNIX98_PTYS=y
 CONFIG_LEGACY_PTYS=y
 CONFIG_LEGACY_PTY_COUNT=256
 # CONFIG_IPMI_HANDLER is not set
-# CONFIG_WATCHDOG is not set
 # CONFIG_HW_RANDOM is not set
 # CONFIG_NVRAM is not set
 # CONFIG_GEN_RTC is not set
@@ -571,7 +563,6 @@ CONFIG_I2C_MPC=y
 # CONFIG_I2C_PARPORT_LIGHT is not set
 # CONFIG_I2C_SIMTEC is not set
 # CONFIG_I2C_TAOS_EVM is not set
-# CONFIG_I2C_STUB is not set
 
 #
 # Miscellaneous I2C Chip support
@@ -598,53 +589,8 @@ CONFIG_SENSORS_EEPROM=y
 # CONFIG_SPI_MASTER is not set
 # CONFIG_W1 is not set
 # CONFIG_POWER_SUPPLY is not set
-CONFIG_HWMON=y
-# CONFIG_HWMON_VID is not set
-# CONFIG_SENSORS_AD7418 is not set
-# CONFIG_SENSORS_ADM1021 is not set
-# CONFIG_SENSORS_ADM1025 is not set
-# CONFIG_SENSORS_ADM1026 is not set
-# CONFIG_SENSORS_ADM1029 is not set
-# CONFIG_SENSORS_ADM1031 is not set
-# CONFIG_SENSORS_ADM9240 is not set
-# CONFIG_SENSORS_ADT7470 is not set
-# CONFIG_SENSORS_ATXP1 is not set
-# CONFIG_SENSORS_DS1621 is not set
-# CONFIG_SENSORS_F71805F is not set
-# CONFIG_SENSORS_F71882FG is not set
-# CONFIG_SENSORS_F75375S is not set
-# CONFIG_SENSORS_GL518SM is not set
-# CONFIG_SENSORS_GL520SM is not set
-# CONFIG_SENSORS_IT87 is not set
-# CONFIG_SENSORS_LM63 is not set
-# CONFIG_SENSORS_LM75 is not set
-# CONFIG_SENSORS_LM77 is not set
-# CONFIG_SENSORS_LM78 is not set
-# CONFIG_SENSORS_LM80 is not set
-# CONFIG_SENSORS_LM83 is not set
-# CONFIG_SENSORS_LM85 is not set
-# CONFIG_SENSORS_LM87 is not set
-# CONFIG_SENSORS_LM90 is not set
-# CONFIG_SENSORS_LM92 is not set
-# CONFIG_SENSORS_LM93 is not set
-# CONFIG_SENSORS_MAX1619 is not set
-# CONFIG_SENSORS_MAX6650 is not set
-# CONFIG_SENSORS_PC87360 is not set
-# CONFIG_SENSORS_PC87427 is not set
-# CONFIG_SENSORS_DME1737 is not set
-# CONFIG_SENSORS_SMSC47M1 is not set
-# CONFIG_SENSORS_SMSC47M192 is not set
-# CONFIG_SENSORS_SMSC47B397 is not set
-# CONFIG_SENSORS_THMC50 is not set
-# CONFIG_SENSORS_VT1211 is not set
-# CONFIG_SENSORS_W83781D is not set
-# CONFIG_SENSORS_W83791D is not set
-# CONFIG_SENSORS_W83792D is not set
-# CONFIG_SENSORS_W83793 is not set
-# CONFIG_SENSORS_W83L785TS is not set
-# CONFIG_SENSORS_W83627HF is not set
-# CONFIG_SENSORS_W83627EHF is not set
-# CONFIG_HWMON_DEBUG_CHIP is not set
+# CONFIG_HWMON is not set
+# CONFIG_WATCHDOG is not set
 
 #
 # Sonics Silicon Backplane
@@ -668,7 +614,7 @@ CONFIG_DAB=y
 # Graphics support
 #
 # CONFIG_VGASTATE is not set
-CONFIG_VIDEO_OUTPUT_CONTROL=m
+CONFIG_VIDEO_OUTPUT_CONTROL=y
 # CONFIG_FB is not set
 # CONFIG_BACKLIGHT_LCD_SUPPORT is not set
 
@@ -711,7 +657,53 @@ CONFIG_LEDS_TRIGGERS=y
 CONFIG_LEDS_TRIGGER_TIMER=y
 # CONFIG_LEDS_TRIGGER_HEARTBEAT is not set
 # CONFIG_EDAC is not set
-# CONFIG_RTC_CLASS is not set
+CONFIG_RTC_LIB=y
+CONFIG_RTC_CLASS=y
+CONFIG_RTC_HCTOSYS=y
+CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
+# CONFIG_RTC_DEBUG is not set
+
+#
+# RTC interfaces
+#
+CONFIG_RTC_INTF_SYSFS=y
+CONFIG_RTC_INTF_PROC=y
+CONFIG_RTC_INTF_DEV=y
+# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
+# CONFIG_RTC_DRV_TEST is not set
+
+#
+# I2C RTC drivers
+#
+CONFIG_RTC_DRV_DS1307=y
+# CONFIG_RTC_DRV_DS1374 is not set
+# CONFIG_RTC_DRV_DS1672 is not set
+# CONFIG_RTC_DRV_MAX6900 is not set
+# CONFIG_RTC_DRV_RS5C372 is not set
+# CONFIG_RTC_DRV_ISL1208 is not set
+# CONFIG_RTC_DRV_X1205 is not set
+# CONFIG_RTC_DRV_PCF8563 is not set
+# CONFIG_RTC_DRV_PCF8583 is not set
+# CONFIG_RTC_DRV_M41T80 is not set
+
+#
+# SPI RTC drivers
+#
+
+#
+# Platform RTC drivers
+#
+# CONFIG_RTC_DRV_CMOS is not set
+# CONFIG_RTC_DRV_DS1553 is not set
+# CONFIG_RTC_DRV_STK17TA8 is not set
+# CONFIG_RTC_DRV_DS1742 is not set
+# CONFIG_RTC_DRV_M48T86 is not set
+# CONFIG_RTC_DRV_M48T59 is not set
+# CONFIG_RTC_DRV_V3020 is not set
+
+#
+# on-CPU RTC drivers
+#
 
 #
 # Userspace I/O
@@ -730,7 +722,6 @@ CONFIG_EXT3_FS_XATTR=y
 # CONFIG_EXT3_FS_SECURITY is not set
 # CONFIG_EXT4DEV_FS is not set
 CONFIG_JBD=y
-# CONFIG_JBD_DEBUG is not set
 CONFIG_FS_MBCACHE=y
 # CONFIG_REISERFS_FS is not set
 # CONFIG_JFS_FS is not set
@@ -797,7 +788,7 @@ CONFIG_NETWORK_FILESYSTEMS=y
 CONFIG_NFS_FS=y
 CONFIG_NFS_V3=y
 # CONFIG_NFS_V3_ACL is not set
-CONFIG_NFS_V4=y
+# CONFIG_NFS_V4 is not set
 # CONFIG_NFS_DIRECTIO is not set
 # CONFIG_NFSD is not set
 CONFIG_ROOT_NFS=y
@@ -805,9 +796,8 @@ CONFIG_LOCKD=y
 CONFIG_LOCKD_V4=y
 CONFIG_NFS_COMMON=y
 CONFIG_SUNRPC=y
-CONFIG_SUNRPC_GSS=y
 # CONFIG_SUNRPC_BIND34 is not set
-CONFIG_RPCSEC_GSS_KRB5=y
+# CONFIG_RPCSEC_GSS_KRB5 is not set
 # CONFIG_RPCSEC_GSS_SPKM3 is not set
 # CONFIG_SMB_FS is not set
 # CONFIG_CIFS is not set
@@ -894,16 +884,13 @@ CONFIG_PLIST=y
 CONFIG_HAS_IOMEM=y
 CONFIG_HAS_IOPORT=y
 CONFIG_HAS_DMA=y
-
-#
-# Instrumentation Support
-#
-# CONFIG_PROFILING is not set
+# CONFIG_INSTRUMENTATION is not set
 
 #
 # Kernel hacking
 #
-# CONFIG_PRINTK_TIME is not set
+CONFIG_PRINTK_TIME=y
+CONFIG_ENABLE_WARN_DEPRECATED=y
 CONFIG_ENABLE_MUST_CHECK=y
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_UNUSED_SYMBOLS is not set
@@ -915,7 +902,7 @@ CONFIG_DETECT_SOFTLOCKUP=y
 CONFIG_SCHED_DEBUG=y
 # CONFIG_SCHEDSTATS is not set
 # CONFIG_TIMER_STATS is not set
-# CONFIG_DEBUG_SLAB is not set
+# CONFIG_SLUB_DEBUG_ON is not set
 # CONFIG_DEBUG_RT_MUTEXES is not set
 # CONFIG_RT_MUTEX_TESTER is not set
 # CONFIG_DEBUG_SPINLOCK is not set
@@ -927,10 +914,11 @@ CONFIG_SCHED_DEBUG=y
 CONFIG_DEBUG_INFO=y
 # CONFIG_DEBUG_VM is not set
 # CONFIG_DEBUG_LIST is not set
+# CONFIG_DEBUG_SG is not set
 CONFIG_FORCED_INLINING=y
 # CONFIG_BOOT_PRINTK_DELAY is not set
-# CONFIG_RCU_TORTURE_TEST is not set
 # CONFIG_FAULT_INJECTION is not set
+# CONFIG_SAMPLES is not set
 # CONFIG_DEBUG_STACKOVERFLOW is not set
 # CONFIG_DEBUG_STACK_USAGE is not set
 # CONFIG_DEBUG_PAGEALLOC is not set
@@ -960,9 +948,9 @@ CONFIG_CRYPTO_MD5=y
 # CONFIG_CRYPTO_WP512 is not set
 # CONFIG_CRYPTO_TGR192 is not set
 # CONFIG_CRYPTO_GF128MUL is not set
-CONFIG_CRYPTO_ECB=m
+CONFIG_CRYPTO_ECB=y
 CONFIG_CRYPTO_CBC=y
-CONFIG_CRYPTO_PCBC=m
+CONFIG_CRYPTO_PCBC=y
 # CONFIG_CRYPTO_LRW is not set
 # CONFIG_CRYPTO_XTS is not set
 # CONFIG_CRYPTO_CRYPTD is not set
@@ -983,7 +971,6 @@ CONFIG_CRYPTO_DES=y
 # CONFIG_CRYPTO_MICHAEL_MIC is not set
 # CONFIG_CRYPTO_CRC32C is not set
 # CONFIG_CRYPTO_CAMELLIA is not set
-# CONFIG_CRYPTO_TEST is not set
 # CONFIG_CRYPTO_AUTHENC is not set
 CONFIG_CRYPTO_HW=y
 CONFIG_PPC_CLOCK=y
diff --git a/arch/powerpc/configs/tqm5200_defconfig b/arch/powerpc/configs/tqm5200_defconfig
index 53fa968..ed4951b 100644
--- a/arch/powerpc/configs/tqm5200_defconfig
+++ b/arch/powerpc/configs/tqm5200_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.23
-# Mon Oct 29 14:01:58 2007
+# Linux kernel version: 2.6.24-rc6
+# Thu Jan 17 11:12:51 2008
 #
 # CONFIG_PPC64 is not set
 
@@ -67,11 +67,14 @@ CONFIG_SYSVIPC_SYSCTL=y
 # CONFIG_BSD_PROCESS_ACCT is not set
 # CONFIG_TASKSTATS is not set
 # CONFIG_USER_NS is not set
+# CONFIG_PID_NS is not set
 # CONFIG_AUDIT is not set
 # CONFIG_IKCONFIG is not set
 CONFIG_LOG_BUF_SHIFT=14
+# CONFIG_CGROUPS is not set
 CONFIG_FAIR_GROUP_SCHED=y
 CONFIG_FAIR_USER_SCHED=y
+# CONFIG_FAIR_CGROUP_SCHED is not set
 CONFIG_SYSFS_DEPRECATED=y
 # CONFIG_RELAY is not set
 CONFIG_BLK_DEV_INITRD=y
@@ -93,18 +96,14 @@ CONFIG_SIGNALFD=y
 CONFIG_EVENTFD=y
 CONFIG_SHMEM=y
 CONFIG_VM_EVENT_COUNTERS=y
-CONFIG_SLAB=y
-# CONFIG_SLUB is not set
+CONFIG_SLUB_DEBUG=y
+# CONFIG_SLAB is not set
+CONFIG_SLUB=y
 # CONFIG_SLOB is not set
 CONFIG_RT_MUTEXES=y
 # CONFIG_TINY_SHMEM is not set
 CONFIG_BASE_SMALL=0
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-# CONFIG_MODULE_FORCE_UNLOAD is not set
-# CONFIG_MODVERSIONS is not set
-# CONFIG_MODULE_SRCVERSION_ALL is not set
-# CONFIG_KMOD is not set
+# CONFIG_MODULES is not set
 CONFIG_BLOCK=y
 # CONFIG_LBD is not set
 # CONFIG_BLK_DEV_IO_TRACE is not set
@@ -221,6 +220,7 @@ CONFIG_PCI_SYSCALL=y
 # CONFIG_PCIEPORTBUS is not set
 CONFIG_ARCH_SUPPORTS_MSI=y
 # CONFIG_PCI_MSI is not set
+CONFIG_PCI_LEGACY=y
 # CONFIG_PCI_DEBUG is not set
 # CONFIG_PCCARD is not set
 # CONFIG_HOTPLUG_PCI is not set
@@ -251,7 +251,7 @@ CONFIG_PACKET=y
 # CONFIG_PACKET_MMAP is not set
 CONFIG_UNIX=y
 CONFIG_XFRM=y
-CONFIG_XFRM_USER=m
+CONFIG_XFRM_USER=y
 # CONFIG_XFRM_SUB_POLICY is not set
 # CONFIG_XFRM_MIGRATE is not set
 # CONFIG_NET_KEY is not set
@@ -302,10 +302,6 @@ CONFIG_DEFAULT_TCP_CONG="cubic"
 # CONFIG_LAPB is not set
 # CONFIG_ECONET is not set
 # CONFIG_WAN_ROUTER is not set
-
-#
-# QoS and/or fair queueing
-#
 # CONFIG_NET_SCHED is not set
 
 #
@@ -472,7 +468,6 @@ CONFIG_CHR_DEV_SG=y
 # CONFIG_SCSI_CONSTANTS is not set
 # CONFIG_SCSI_LOGGING is not set
 # CONFIG_SCSI_SCAN_ASYNC is not set
-CONFIG_SCSI_WAIT_SCAN=m
 
 #
 # SCSI Transports
@@ -628,7 +623,6 @@ CONFIG_NET_ETHERNET=y
 # CONFIG_USB_KAWETH is not set
 # CONFIG_USB_PEGASUS is not set
 # CONFIG_USB_RTL8150 is not set
-# CONFIG_USB_USBNET_MII is not set
 # CONFIG_USB_USBNET is not set
 # CONFIG_WAN is not set
 # CONFIG_FDDI is not set
@@ -679,25 +673,6 @@ CONFIG_UNIX98_PTYS=y
 CONFIG_LEGACY_PTYS=y
 CONFIG_LEGACY_PTY_COUNT=256
 # CONFIG_IPMI_HANDLER is not set
-CONFIG_WATCHDOG=y
-# CONFIG_WATCHDOG_NOWAYOUT is not set
-
-#
-# Watchdog Device Drivers
-#
-# CONFIG_SOFT_WATCHDOG is not set
-# CONFIG_MPC5200_WDT is not set
-
-#
-# PCI-based Watchdog Cards
-#
-# CONFIG_PCIPCWATCHDOG is not set
-# CONFIG_WDTPCI is not set
-
-#
-# USB-based Watchdog Cards
-#
-# CONFIG_USBPCWATCHDOG is not set
 # CONFIG_HW_RANDOM is not set
 # CONFIG_NVRAM is not set
 CONFIG_GEN_RTC=y
@@ -740,7 +715,6 @@ CONFIG_I2C_MPC=y
 # CONFIG_I2C_SIS630 is not set
 # CONFIG_I2C_SIS96X is not set
 # CONFIG_I2C_TAOS_EVM is not set
-# CONFIG_I2C_STUB is not set
 # CONFIG_I2C_TINY_USB is not set
 # CONFIG_I2C_VIA is not set
 # CONFIG_I2C_VIAPRO is not set
@@ -783,6 +757,7 @@ CONFIG_HWMON=y
 # CONFIG_SENSORS_ADT7470 is not set
 # CONFIG_SENSORS_ATXP1 is not set
 # CONFIG_SENSORS_DS1621 is not set
+# CONFIG_SENSORS_I5K_AMB is not set
 # CONFIG_SENSORS_F71805F is not set
 # CONFIG_SENSORS_F71882FG is not set
 # CONFIG_SENSORS_F75375S is not set
@@ -821,6 +796,25 @@ CONFIG_HWMON=y
 # CONFIG_SENSORS_W83627HF is not set
 # CONFIG_SENSORS_W83627EHF is not set
 # CONFIG_HWMON_DEBUG_CHIP is not set
+CONFIG_WATCHDOG=y
+# CONFIG_WATCHDOG_NOWAYOUT is not set
+
+#
+# Watchdog Device Drivers
+#
+# CONFIG_SOFT_WATCHDOG is not set
+# CONFIG_MPC5200_WDT is not set
+
+#
+# PCI-based Watchdog Cards
+#
+# CONFIG_PCIPCWATCHDOG is not set
+# CONFIG_WDTPCI is not set
+
+#
+# USB-based Watchdog Cards
+#
+# CONFIG_USBPCWATCHDOG is not set
 
 #
 # Sonics Silicon Backplane
@@ -846,7 +840,7 @@ CONFIG_SSB_POSSIBLE=y
 # CONFIG_AGP is not set
 # CONFIG_DRM is not set
 # CONFIG_VGASTATE is not set
-CONFIG_VIDEO_OUTPUT_CONTROL=m
+CONFIG_VIDEO_OUTPUT_CONTROL=y
 # CONFIG_FB is not set
 # CONFIG_BACKLIGHT_LCD_SUPPORT is not set
 
@@ -911,6 +905,7 @@ CONFIG_USB_STORAGE=y
 # CONFIG_USB_STORAGE_DEBUG is not set
 # CONFIG_USB_STORAGE_DATAFAB is not set
 # CONFIG_USB_STORAGE_FREECOM is not set
+# CONFIG_USB_STORAGE_ISD200 is not set
 # CONFIG_USB_STORAGE_DPCM is not set
 # CONFIG_USB_STORAGE_USBAT is not set
 # CONFIG_USB_STORAGE_SDDR09 is not set
@@ -1036,7 +1031,6 @@ CONFIG_EXT3_FS_XATTR=y
 # CONFIG_EXT3_FS_SECURITY is not set
 # CONFIG_EXT4DEV_FS is not set
 CONFIG_JBD=y
-# CONFIG_JBD_DEBUG is not set
 CONFIG_FS_MBCACHE=y
 # CONFIG_REISERFS_FS is not set
 # CONFIG_JFS_FS is not set
@@ -1211,16 +1205,15 @@ CONFIG_PLIST=y
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
 #
-# CONFIG_PRINTK_TIME is not set
+CONFIG_PRINTK_TIME=y
+CONFIG_ENABLE_WARN_DEPRECATED=y
 CONFIG_ENABLE_MUST_CHECK=y
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_UNUSED_SYMBOLS is not set
@@ -1232,7 +1225,7 @@ CONFIG_DETECT_SOFTLOCKUP=y
 CONFIG_SCHED_DEBUG=y
 # CONFIG_SCHEDSTATS is not set
 # CONFIG_TIMER_STATS is not set
-# CONFIG_DEBUG_SLAB is not set
+# CONFIG_SLUB_DEBUG_ON is not set
 # CONFIG_DEBUG_RT_MUTEXES is not set
 # CONFIG_RT_MUTEX_TESTER is not set
 # CONFIG_DEBUG_SPINLOCK is not set
@@ -1244,10 +1237,11 @@ CONFIG_SCHED_DEBUG=y
 CONFIG_DEBUG_INFO=y
 # CONFIG_DEBUG_VM is not set
 # CONFIG_DEBUG_LIST is not set
+# CONFIG_DEBUG_SG is not set
 CONFIG_FORCED_INLINING=y
 # CONFIG_BOOT_PRINTK_DELAY is not set
-# CONFIG_RCU_TORTURE_TEST is not set
 # CONFIG_FAULT_INJECTION is not set
+# CONFIG_SAMPLES is not set
 # CONFIG_DEBUG_STACKOVERFLOW is not set
 # CONFIG_DEBUG_STACK_USAGE is not set
 # CONFIG_DEBUG_PAGEALLOC is not set
@@ -1277,9 +1271,9 @@ CONFIG_CRYPTO_MD5=y
 # CONFIG_CRYPTO_WP512 is not set
 # CONFIG_CRYPTO_TGR192 is not set
 # CONFIG_CRYPTO_GF128MUL is not set
-CONFIG_CRYPTO_ECB=m
+CONFIG_CRYPTO_ECB=y
 CONFIG_CRYPTO_CBC=y
-CONFIG_CRYPTO_PCBC=m
+CONFIG_CRYPTO_PCBC=y
 # CONFIG_CRYPTO_LRW is not set
 # CONFIG_CRYPTO_XTS is not set
 # CONFIG_CRYPTO_CRYPTD is not set
@@ -1300,7 +1294,6 @@ CONFIG_CRYPTO_DES=y
 # CONFIG_CRYPTO_MICHAEL_MIC is not set
 # CONFIG_CRYPTO_CRC32C is not set
 # CONFIG_CRYPTO_CAMELLIA is not set
-# CONFIG_CRYPTO_TEST is not set
 # CONFIG_CRYPTO_AUTHENC is not set
 CONFIG_CRYPTO_HW=y
 CONFIG_PPC_CLOCK=y
