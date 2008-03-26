Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 8A165DF203
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Mar 2008 07:25:31 +1100 (EST)
Received: from localhost (unknown [10.150.0.9])
	by buildserver.ru.mvista.com (Postfix) with ESMTP id 6EB858817
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Mar 2008 01:25:50 +0400 (SAMT)
Date: Wed, 26 Mar 2008 23:25:29 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 5/5] [POWERPC] mpc837xrdb: add support for MCU
Message-ID: <20080326202529.GE1772@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

MCU is and external Freescale MC9S08QG8 microcontroller, mainly used to
provide soft power-off function, but also exports two GPIOs (wired to
the mcu1 and mcu2 LEDs and external (J28 and J43) headers.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/boot/dts/mpc8377_rdb.dts     |   26 +++++++++++++++++++++++++-
 arch/powerpc/boot/dts/mpc8378_rdb.dts     |   26 +++++++++++++++++++++++++-
 arch/powerpc/boot/dts/mpc8379_rdb.dts     |   26 +++++++++++++++++++++++++-
 arch/powerpc/platforms/83xx/Kconfig       |    2 ++
 arch/powerpc/platforms/83xx/mpc837x_rdb.c |    1 +
 arch/powerpc/sysdev/fsl_soc.c             |    1 +
 6 files changed, 79 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8377_rdb.dts b/arch/powerpc/boot/dts/mpc8377_rdb.dts
index 440aa4d..0897bba 100644
--- a/arch/powerpc/boot/dts/mpc8377_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc8377_rdb.dts
@@ -111,7 +111,7 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			cell-index = <0>;
-			compatible = "fsl-i2c";
+			compatible = "fsl-i2c", "simple-bus";
 			reg = <0x3000 0x100>;
 			interrupts = <14 0x8>;
 			interrupt-parent = <&ipic>;
@@ -121,6 +121,30 @@
 				compatible = "dallas,ds1339";
 				reg = <0x68>;
 			};
+			mcu_pio: mcu@0a {
+				#gpio-cells = <1>;
+				compatible = "fsl,mc9s08qg8-mpc837xrdb",
+					     "fsl,mcu-mpc837xrdb",
+					     "simple-bus";
+				reg = <0x0a>;
+				gpio-controller;
+
+				led@0 {
+					compatible = "fsl,mcu-mpc837xrdb-led2",
+						     "gpio-led";
+					linux,name = "mcu2";
+					linux,active-low;
+					gpios = <&mcu_pio 0>;
+				};
+
+				led@1 {
+					compatible = "fsl,mcu-mpc837xrdb-led1",
+						     "gpio-led";
+					linux,name = "mcu1";
+					linux,active-low;
+					gpios = <&mcu_pio 1>;
+				};
+			};
 		};
 
 		i2c@3100 {
diff --git a/arch/powerpc/boot/dts/mpc8378_rdb.dts b/arch/powerpc/boot/dts/mpc8378_rdb.dts
index 9271153..e21cbb1 100644
--- a/arch/powerpc/boot/dts/mpc8378_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc8378_rdb.dts
@@ -111,7 +111,7 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			cell-index = <0>;
-			compatible = "fsl-i2c";
+			compatible = "fsl-i2c", "simple-bus";
 			reg = <0x3000 0x100>;
 			interrupts = <14 0x8>;
 			interrupt-parent = <&ipic>;
@@ -121,6 +121,30 @@
 				compatible = "dallas,ds1339";
 				reg = <0x68>;
 			};
+			mcu_pio: mcu@0a {
+				#gpio-cells = <1>;
+				compatible = "fsl,mc9s08qg8-mpc837xrdb",
+					     "fsl,mcu-mpc837xrdb",
+					     "simple-bus";
+				reg = <0x0a>;
+				gpio-controller;
+
+				led@0 {
+					compatible = "fsl,mcu-mpc837xrdb-led2",
+						     "gpio-led";
+					linux,name = "mcu2";
+					linux,active-low;
+					gpios = <&mcu_pio 0>;
+				};
+
+				led@1 {
+					compatible = "fsl,mcu-mpc837xrdb-led1",
+						     "gpio-led";
+					linux,name = "mcu1";
+					linux,active-low;
+					gpios = <&mcu_pio 1>;
+				};
+			};
 		};
 
 		i2c@3100 {
diff --git a/arch/powerpc/boot/dts/mpc8379_rdb.dts b/arch/powerpc/boot/dts/mpc8379_rdb.dts
index 0dda2fc..45c164b 100644
--- a/arch/powerpc/boot/dts/mpc8379_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc8379_rdb.dts
@@ -111,7 +111,7 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			cell-index = <0>;
-			compatible = "fsl-i2c";
+			compatible = "fsl-i2c", "simple-bus";
 			reg = <0x3000 0x100>;
 			interrupts = <14 0x8>;
 			interrupt-parent = <&ipic>;
@@ -121,6 +121,30 @@
 				compatible = "dallas,ds1339";
 				reg = <0x68>;
 			};
+			mcu_pio: mcu@0a {
+				#gpio-cells = <1>;
+				compatible = "fsl,mc9s08qg8-mpc837xrdb",
+					     "fsl,mcu-mpc837xrdb",
+					     "simple-bus";
+				reg = <0x0a>;
+				gpio-controller;
+
+				led@0 {
+					compatible = "fsl,mcu-mpc837xrdb-led2",
+						     "gpio-led";
+					linux,name = "mcu2";
+					linux,active-low;
+					gpios = <&mcu_pio 0>;
+				};
+
+				led@1 {
+					compatible = "fsl,mcu-mpc837xrdb-led1",
+						     "gpio-led";
+					linux,name = "mcu1";
+					linux,active-low;
+					gpios = <&mcu_pio 1>;
+				};
+			};
 		};
 
 		i2c@3100 {
diff --git a/arch/powerpc/platforms/83xx/Kconfig b/arch/powerpc/platforms/83xx/Kconfig
index a5f72bb..3dd4213 100644
--- a/arch/powerpc/platforms/83xx/Kconfig
+++ b/arch/powerpc/platforms/83xx/Kconfig
@@ -77,6 +77,8 @@ config MPC837x_RDB
 	bool "Freescale MPC837x RDB"
 	select DEFAULT_UIMAGE
 	select PPC_MPC837x
+	select GENERIC_GPIO
+	select HAVE_GPIO_LIB
 	help
 	  This option enables support for the MPC837x RDB Board.
 
diff --git a/arch/powerpc/platforms/83xx/mpc837x_rdb.c b/arch/powerpc/platforms/83xx/mpc837x_rdb.c
index 2293ae5..c00356b 100644
--- a/arch/powerpc/platforms/83xx/mpc837x_rdb.c
+++ b/arch/powerpc/platforms/83xx/mpc837x_rdb.c
@@ -46,6 +46,7 @@ static void __init mpc837x_rdb_setup_arch(void)
 static struct of_device_id mpc837x_ids[] = {
 	{ .type = "soc", },
 	{ .compatible = "soc", },
+	{ .compatible = "simple-bus", },
 	{},
 };
 
diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index 7ad9bce..97a209a 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -410,6 +410,7 @@ static struct i2c_driver_device i2c_devices[] __initdata = {
 	{"dallas,ds1340",  "rtc-ds1307",  "ds1340",},
 	{"stm,m41t00",     "rtc-ds1307",  "m41t00"},
 	{"dallas,ds1374",  "rtc-ds1374",  "rtc-ds1374",},
+	{"fsl,mcu-mpc837xrdb", "mcu-mpc837xrdb", "mcu-mpc837xrdb"},
 };
 
 static int __init of_find_i2c_driver(struct device_node *node,
-- 
1.5.2.2
