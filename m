Return-Path: <kim.phillips@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5F6FEDDE3E
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Nov 2007 06:41:04 +1100 (EST)
Date: Thu, 8 Nov 2007 13:37:06 -0600
From: Kim Phillips <kim.phillips@freescale.com>
To: linuxppc-dev@ozlabs.org, Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH] powerpc: mpc8xxx MDS board RTC fixes
Message-Id: <20071108133706.961af8d2.kim.phillips@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Now the rtc class ds1374 driver has been added,
remove the old rtc driver hookup code, add rtc node
to device trees, and turn on the new driver in the defconfigs.

Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
---
 arch/powerpc/boot/dts/mpc832x_mds.dts      |    7 ++++
 arch/powerpc/boot/dts/mpc834x_mds.dts      |    9 +++++
 arch/powerpc/boot/dts/mpc836x_mds.dts      |    9 +++++
 arch/powerpc/configs/mpc832x_mds_defconfig |   48 +++++++++++++++++++++++++++-
 arch/powerpc/configs/mpc834x_mds_defconfig |   48 +++++++++++++++++++++++++++-
 arch/powerpc/configs/mpc836x_mds_defconfig |   48 +++++++++++++++++++++++++++-
 arch/powerpc/configs/mpc8568mds_defconfig  |   48 +++++++++++++++++++++++++++-
 arch/powerpc/platforms/83xx/mpc832x_mds.c  |   24 --------------
 arch/powerpc/platforms/83xx/mpc834x_mds.c  |   24 --------------
 arch/powerpc/platforms/83xx/mpc836x_mds.c  |   24 --------------
 10 files changed, 213 insertions(+), 76 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc832x_mds.dts b/arch/powerpc/boot/dts/mpc832x_mds.dts
index fcd333c..650a50c 100644
--- a/arch/powerpc/boot/dts/mpc832x_mds.dts
+++ b/arch/powerpc/boot/dts/mpc832x_mds.dts
@@ -57,12 +57,19 @@
 		};
 
 		i2c@3000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
 			device_type = "i2c";
 			compatible = "fsl-i2c";
 			reg = <3000 100>;
 			interrupts = <e 8>;
 			interrupt-parent = < &ipic >;
 			dfsrr;
+
+			rtc@68 {
+				compatible = "dallas,ds1374";
+				reg = <68>;
+			};
 		};
 
 		serial@4500 {
diff --git a/arch/powerpc/boot/dts/mpc834x_mds.dts b/arch/powerpc/boot/dts/mpc834x_mds.dts
index e5a84ef..49363f8 100644
--- a/arch/powerpc/boot/dts/mpc834x_mds.dts
+++ b/arch/powerpc/boot/dts/mpc834x_mds.dts
@@ -57,15 +57,24 @@
 		};
 
 		i2c@3000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
 			device_type = "i2c";
 			compatible = "fsl-i2c";
 			reg = <3000 100>;
 			interrupts = <e 8>;
 			interrupt-parent = < &ipic >;
 			dfsrr;
+
+			rtc@68 {
+				compatible = "dallas,ds1374";
+				reg = <68>;
+			};
 		};
 
 		i2c@3100 {
+			#address-cells = <1>;
+			#size-cells = <0>;
 			device_type = "i2c";
 			compatible = "fsl-i2c";
 			reg = <3100 100>;
diff --git a/arch/powerpc/boot/dts/mpc836x_mds.dts b/arch/powerpc/boot/dts/mpc836x_mds.dts
index fbd1573..0b2d2b5 100644
--- a/arch/powerpc/boot/dts/mpc836x_mds.dts
+++ b/arch/powerpc/boot/dts/mpc836x_mds.dts
@@ -62,15 +62,24 @@
 		};
 
 		i2c@3000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
 			device_type = "i2c";
 			compatible = "fsl-i2c";
 			reg = <3000 100>;
 			interrupts = <e 8>;
 			interrupt-parent = < &ipic >;
 			dfsrr;
+
+			rtc@68 {
+				compatible = "dallas,ds1374";
+				reg = <68>;
+			};
 		};
 
 		i2c@3100 {
+			#address-cells = <1>;
+			#size-cells = <0>;
 			device_type = "i2c";
 			compatible = "fsl-i2c";
 			reg = <3100 100>;
diff --git a/arch/powerpc/configs/mpc832x_mds_defconfig b/arch/powerpc/configs/mpc832x_mds_defconfig
index dd68d18..e069018 100644
--- a/arch/powerpc/configs/mpc832x_mds_defconfig
+++ b/arch/powerpc/configs/mpc832x_mds_defconfig
@@ -774,7 +774,53 @@ CONFIG_USB_ARCH_HAS_EHCI=y
 # CONFIG_NEW_LEDS is not set
 # CONFIG_INFINIBAND is not set
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
+# CONFIG_RTC_DRV_DS1307 is not set
+CONFIG_RTC_DRV_DS1374=y
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
 # DMA Engine support
diff --git a/arch/powerpc/configs/mpc834x_mds_defconfig b/arch/powerpc/configs/mpc834x_mds_defconfig
index e59a88e..356f736 100644
--- a/arch/powerpc/configs/mpc834x_mds_defconfig
+++ b/arch/powerpc/configs/mpc834x_mds_defconfig
@@ -721,7 +721,53 @@ CONFIG_USB_EHCI_FSL=y
 # CONFIG_NEW_LEDS is not set
 # CONFIG_INFINIBAND is not set
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
+# CONFIG_RTC_DRV_DS1307 is not set
+CONFIG_RTC_DRV_DS1374=y
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
 # DMA Engine support
diff --git a/arch/powerpc/configs/mpc836x_mds_defconfig b/arch/powerpc/configs/mpc836x_mds_defconfig
index 7565752..1b4d375 100644
--- a/arch/powerpc/configs/mpc836x_mds_defconfig
+++ b/arch/powerpc/configs/mpc836x_mds_defconfig
@@ -773,7 +773,53 @@ CONFIG_USB_ARCH_HAS_EHCI=y
 # CONFIG_NEW_LEDS is not set
 # CONFIG_INFINIBAND is not set
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
+# CONFIG_RTC_DRV_DS1307 is not set
+CONFIG_RTC_DRV_DS1374=y
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
 # DMA Engine support
diff --git a/arch/powerpc/configs/mpc8568mds_defconfig b/arch/powerpc/configs/mpc8568mds_defconfig
index 883d8af..d665e7a 100644
--- a/arch/powerpc/configs/mpc8568mds_defconfig
+++ b/arch/powerpc/configs/mpc8568mds_defconfig
@@ -768,7 +768,53 @@ CONFIG_USB_ARCH_HAS_EHCI=y
 # CONFIG_NEW_LEDS is not set
 # CONFIG_INFINIBAND is not set
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
+# CONFIG_RTC_DRV_DS1307 is not set
+CONFIG_RTC_DRV_DS1374=y
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
 # DMA Engine support
diff --git a/arch/powerpc/platforms/83xx/mpc832x_mds.c b/arch/powerpc/platforms/83xx/mpc832x_mds.c
index 972fa85..66382df 100644
--- a/arch/powerpc/platforms/83xx/mpc832x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc832x_mds.c
@@ -145,30 +145,6 @@ static void __init mpc832x_sys_init_IRQ(void)
 #endif				/* CONFIG_QUICC_ENGINE */
 }
 
-#if defined(CONFIG_I2C_MPC) && defined(CONFIG_SENSORS_DS1374)
-extern ulong ds1374_get_rtc_time(void);
-extern int ds1374_set_rtc_time(ulong);
-
-static int __init mpc832x_rtc_hookup(void)
-{
-	struct timespec tv;
-
-	if (!machine_is(mpc832x_mds))
-		return 0;
-
-	ppc_md.get_rtc_time = ds1374_get_rtc_time;
-	ppc_md.set_rtc_time = ds1374_set_rtc_time;
-
-	tv.tv_nsec = 0;
-	tv.tv_sec = (ppc_md.get_rtc_time) ();
-	do_settimeofday(&tv);
-
-	return 0;
-}
-
-late_initcall(mpc832x_rtc_hookup);
-#endif
-
 /*
  * Called very early, MMU is off, device-tree isn't unflattened
  */
diff --git a/arch/powerpc/platforms/83xx/mpc834x_mds.c b/arch/powerpc/platforms/83xx/mpc834x_mds.c
index 00aed7c..a81bb3c 100644
--- a/arch/powerpc/platforms/83xx/mpc834x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc834x_mds.c
@@ -106,30 +106,6 @@ static void __init mpc834x_mds_init_IRQ(void)
 	ipic_set_default_priority();
 }
 
-#if defined(CONFIG_I2C_MPC) && defined(CONFIG_SENSORS_DS1374)
-extern ulong ds1374_get_rtc_time(void);
-extern int ds1374_set_rtc_time(ulong);
-
-static int __init mpc834x_rtc_hookup(void)
-{
-	struct timespec tv;
-
-	if (!machine_is(mpc834x_mds))
-		return 0;
-
-	ppc_md.get_rtc_time = ds1374_get_rtc_time;
-	ppc_md.set_rtc_time = ds1374_set_rtc_time;
-
-	tv.tv_nsec = 0;
-	tv.tv_sec = (ppc_md.get_rtc_time) ();
-	do_settimeofday(&tv);
-
-	return 0;
-}
-
-late_initcall(mpc834x_rtc_hookup);
-#endif
-
 /*
  * Called very early, MMU is off, device-tree isn't unflattened
  */
diff --git a/arch/powerpc/platforms/83xx/mpc836x_mds.c b/arch/powerpc/platforms/83xx/mpc836x_mds.c
index 0f3855c..8d87b9c 100644
--- a/arch/powerpc/platforms/83xx/mpc836x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc836x_mds.c
@@ -152,30 +152,6 @@ static void __init mpc836x_mds_init_IRQ(void)
 #endif				/* CONFIG_QUICC_ENGINE */
 }
 
-#if defined(CONFIG_I2C_MPC) && defined(CONFIG_SENSORS_DS1374)
-extern ulong ds1374_get_rtc_time(void);
-extern int ds1374_set_rtc_time(ulong);
-
-static int __init mpc8360_rtc_hookup(void)
-{
-	struct timespec tv;
-
-	if (!machine_is(mpc836x_mds))
-		return 0;
-
-	ppc_md.get_rtc_time = ds1374_get_rtc_time;
-	ppc_md.set_rtc_time = ds1374_set_rtc_time;
-
-	tv.tv_nsec = 0;
-	tv.tv_sec = (ppc_md.get_rtc_time) ();
-	do_settimeofday(&tv);
-
-	return 0;
-}
-
-late_initcall(mpc8360_rtc_hookup);
-#endif
-
 /*
  * Called very early, MMU is off, device-tree isn't unflattened
  */
-- 
1.5.2.2
