Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id C539EDDFBF
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Mar 2008 04:10:46 +1100 (EST)
Date: Thu, 27 Mar 2008 20:10:43 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Anton Vorontsov <cbouatmailru@gmail.com>
Subject: Re: [PATCH 4/5] i2c: MPC837xRDB Power Management and GPIO expander
	driver
Message-ID: <20080327171043.GA31049@localhost.localdomain>
References: <20080326202511.GD1772@localhost.localdomain>
	<47EAB885.7000006@freescale.com> <20080326225611.GA2799@zarina>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20080326225611.GA2799@zarina>
Cc: linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>,
	i2c@lm-sensors.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Mar 27, 2008 at 01:56:11AM +0300, Anton Vorontsov wrote:
> On Wed, Mar 26, 2008 at 03:56:37PM -0500, Timur Tabi wrote:
> > Anton Vorontsov wrote:
> > 
> > > +config MCU_MPC837XRDB
> > > +	tristate "MPC837XRDB MCU driver"
> > > +	depends on I2C && MPC837x_RDB && OF_GPIO
> > 
> > The MPC8349E-mITX also has this chip.  Can you include support for that board as
> > well?
> 
> Well, only if it has the same (or compatible) firmware.. then yes.

Ok, they're the same and everything works fine. Except one mitx-specific
thing though... on the power-off call I can see that MCU is driving its
PTA1 pin low as expected, but the board doesn't turn off. PTA1 pin is
wired to the J19 jumper pin1, pin2 is PORESET# and pin3 is RESET#.
It doesn't work in both [1-2] and [2-3] positions...

This is surely not a software issue though. And just in case, on the
board I have the PWR button isn't functional, so this is hw issues (or
just need to find another jumper somewhere ;-).

Updated patch follows.

- - - -
From: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: [POWERPC] mpc8349emitx/mpc837xrdb: add support for MCU

MCU is an external Freescale MC9S08QG8 microcontroller, mainly used to
provide soft power-off function, but also exports two GPIOs (wired to
the LEDs, but also available from the external headers).

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/boot/dts/mpc8349emitx.dts    |   39 ++++++++++++++++++++++++++++-
 arch/powerpc/boot/dts/mpc8377_rdb.dts     |   29 ++++++++++++++++++++-
 arch/powerpc/boot/dts/mpc8378_rdb.dts     |   29 ++++++++++++++++++++-
 arch/powerpc/boot/dts/mpc8379_rdb.dts     |   29 ++++++++++++++++++++-
 arch/powerpc/platforms/83xx/mpc834x_itx.c |    1 +
 arch/powerpc/platforms/83xx/mpc837x_rdb.c |    1 +
 arch/powerpc/sysdev/fsl_soc.c             |    1 +
 7 files changed, 125 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8349emitx.dts b/arch/powerpc/boot/dts/mpc8349emitx.dts
index 9426676..0ad85af 100644
--- a/arch/powerpc/boot/dts/mpc8349emitx.dts
+++ b/arch/powerpc/boot/dts/mpc8349emitx.dts
@@ -51,6 +51,8 @@
 	soc8349@e0000000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
+		compatible = "fsl,immr-mpc8349e", "fsl,immr", "fsl,soc",
+			     "simple-bus";
 		device_type = "soc";
 		ranges = <0x0 0xe0000000 0x00100000>;
 		reg = <0xe0000000 0x00000200>;
@@ -66,11 +68,46 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			cell-index = <0>;
-			compatible = "fsl-i2c";
+			compatible = "fsl-i2c", "simple-bus";
 			reg = <0x3000 0x100>;
 			interrupts = <14 0x8>;
 			interrupt-parent = <&ipic>;
 			dfsrr;
+
+			rtc@68 {
+				device_type = "rtc";
+				compatible = "dallas,ds1339";
+				reg = <0x68>;
+			};
+
+			mcu_pio: mcu@0a {
+				#address-cells = <0>;
+				#size-cells = <0>;
+				#gpio-cells = <1>;
+				compatible = "fsl,mc9s08qg8-mpc8349emitx",
+					     "fsl,mcu-mpc8349emitx",
+					     "simple-bus";
+				reg = <0x0a>;
+				gpio-controller;
+
+				led@0 {
+					compatible = "fsl,mcu-mpc8349emitx-led2",
+						     "gpio-led";
+					linux,name = "pwr";
+					linux,brightness = <1>;
+					linux,active-low;
+					gpios = <&mcu_pio 0>;
+				};
+
+				led@1 {
+					compatible = "fsl,mcu-mpc8349emitx-led1",
+						     "gpio-led";
+					linux,name = "hdd";
+					linux,default-trigger = "ide-disk";
+					linux,active-low;
+					gpios = <&mcu_pio 1>;
+				};
+			};
 		};
 
 		i2c@3100 {
diff --git a/arch/powerpc/boot/dts/mpc8377_rdb.dts b/arch/powerpc/boot/dts/mpc8377_rdb.dts
index 440aa4d..20d7e29 100644
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
@@ -121,6 +121,33 @@
 				compatible = "dallas,ds1339";
 				reg = <0x68>;
 			};
+			mcu_pio: mcu@0a {
+				#address-cells = <0>;
+				#size-cells = <0>;
+				#gpio-cells = <1>;
+				compatible = "fsl,mc9s08qg8-mpc837xrdb",
+					     "fsl,mcu-mpc837xrdb",
+					     "fsl,mcu-mpc8349emitx",
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
index 9271153..fdd2e9b 100644
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
@@ -121,6 +121,33 @@
 				compatible = "dallas,ds1339";
 				reg = <0x68>;
 			};
+			mcu_pio: mcu@0a {
+				#address-cells = <0>;
+				#size-cells = <0>;
+				#gpio-cells = <1>;
+				compatible = "fsl,mc9s08qg8-mpc837xrdb",
+					     "fsl,mcu-mpc837xrdb",
+					     "fsl,mcu-mpc8349emitx",
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
index 0dda2fc..c7a0152 100644
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
@@ -121,6 +121,33 @@
 				compatible = "dallas,ds1339";
 				reg = <0x68>;
 			};
+			mcu_pio: mcu@0a {
+				#address-cells = <0>;
+				#size-cells = <0>;
+				#gpio-cells = <1>;
+				compatible = "fsl,mc9s08qg8-mpc837xrdb",
+					     "fsl,mcu-mpc837xrdb",
+					     "fsl,mcu-mpc8349emitx",
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
diff --git a/arch/powerpc/platforms/83xx/mpc834x_itx.c b/arch/powerpc/platforms/83xx/mpc834x_itx.c
index 50e8f63..1b3451c 100644
--- a/arch/powerpc/platforms/83xx/mpc834x_itx.c
+++ b/arch/powerpc/platforms/83xx/mpc834x_itx.c
@@ -40,6 +40,7 @@
 
 static struct of_device_id __initdata mpc834x_itx_ids[] = {
 	{ .compatible = "fsl,pq2pro-localbus", },
+	{ .compatible = "simple-bus", },
 	{},
 };
 
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
index 7ad9bce..e8fe369 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -410,6 +410,7 @@ static struct i2c_driver_device i2c_devices[] __initdata = {
 	{"dallas,ds1340",  "rtc-ds1307",  "ds1340",},
 	{"stm,m41t00",     "rtc-ds1307",  "m41t00"},
 	{"dallas,ds1374",  "rtc-ds1374",  "rtc-ds1374",},
+	{"fsl,mcu-mpc8349emitx", "mcu-mpc8349emitx", "mcu-mpc8349emitx"},
 };
 
 static int __init of_find_i2c_driver(struct device_node *node,
-- 
1.5.2.2
