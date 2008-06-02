Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id EBFAEDE19D
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Jun 2008 04:24:23 +1000 (EST)
Date: Mon, 2 Jun 2008 22:24:22 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [RFC PATCH] booting-without-of: add FHCI USB, FSL MCU, FSL UPM and
	GPIO LEDs bindings
Message-ID: <20080602182422.GA8620@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Arnd Bergmann <arnd@arndb.de>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi all,

Here are the notorious bindings. I believe I addressed Segher's comments.

Major changes are in the LEDs bindings, I removed all the cruft and now
using "aliases" mechanism to determine LEDs' trigger.

Comments, suggestions?

Thanks,

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 Documentation/powerpc/booting-without-of.txt |  117 ++++++++++++++++++++++++++
 1 files changed, 117 insertions(+), 0 deletions(-)

diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
index 1ad903a..2a452c3 100644
--- a/Documentation/powerpc/booting-without-of.txt
+++ b/Documentation/powerpc/booting-without-of.txt
@@ -62,6 +62,10 @@ Table of Contents
       s) Freescale on board FPGA
       t) Freescael MSI interrupt controller
       u) Freescale General-purpose Timers Module
+      v) Freescale QUICC Engine USB Controller
+      w) Freescale MCU with MPC8349E-mITX compatible firmware
+      x) Freescale Localbus UPM programmed to work with NAND flash
+      y) LEDs on GPIOs
 
   VII - Marvell Discovery mv64[345]6x System Controller chips
     1) The /system-controller node
@@ -2970,6 +2974,119 @@ platforms are moved over to use the flattened-device-tree model.
     	clock-frequency = <0>;
     };
 
+    v) Freescale QUICC Engine USB Controller
+
+    Required properties:
+      - compatible : should be "fsl,<chip>-qe-usb", "fsl,mpc8323-qe-usb";
+      - reg : the first two cells should contain usb registers location and
+        length, the next two two cells should contain PRAM location and
+        length.
+      - interrupts : should contain USB interrupt.
+      - interrupt-parent : interrupt source phandle.
+      - fsl,fullspeed-clock : specifies the full speed USB clock source:
+        "none": clock source is disabled
+        "brg1" through "brg16": clock source is BRG1-BRG16, respectively
+        "clk1" through "clk24": clock source is CLK1-CLK24, respectively
+      - fsl,lowspeed-clock : specifies the low speed USB clock source:
+        "none": clock source is disabled
+        "brg1" through "brg16": clock source is BRG1-BRG16, respectively
+        "clk1" through "clk24": clock source is CLK1-CLK24, respectively
+      - hub-power-budget : optional, USB power budget for the root hub, in mA.
+      - gpios : should specify GPIOs in this order: USBOE, USBTP, USBTN, USBRP,
+        USBRN, SPEED (optional), and POWER (optional).
+
+    Example:
+
+	usb@6c0 {
+		compatible = "fsl,mpc8360-qe-usb", "fsl,mpc8323-qe-usb";
+		reg = <0x6c0 0x40 0x8b00 0x100>;
+		interrupts = <11>;
+		interrupt-parent = <&qeic>;
+		fsl,fullspeed-clock = "clk21";
+		gpios = <&qe_pio_b  2 0 /* USBOE */
+			 &qe_pio_b  3 0 /* USBTP */
+			 &qe_pio_b  8 0 /* USBTN */
+			 &qe_pio_b  9 0 /* USBRP */
+			 &qe_pio_b 11 0 /* USBRN */
+			 &qe_pio_e 20 0 /* SPEED */
+			 &qe_pio_e 21 0 /* POWER */>;
+	};
+
+    w) Freescale MCU with MPC8349E-mITX compatible firmware
+
+    Required properties:
+      - compatible : "fsl,<mcu-chip>-<board>", "fsl,mcu-mpc8349emitx";
+      - reg : should specify I2C address (0x0a).
+      - #gpio-cells : should be 2.
+      - gpio-controller : should be present;
+
+    Example:
+
+	mcu_pio: mcu@0a {
+		#gpio-cells = <2>;
+		compatible = "fsl,mc9s08qg8-mpc8349emitx",
+			     "fsl,mcu-mpc8349emitx";
+		reg = <0x0a>;
+		gpio-controller;
+	};
+
+    x) Freescale Localbus UPM programmed to work with NAND flash
+
+      Required properties:
+      - compatible : "fsl,upm-nand".
+      - reg : should specify localbus chip select and size used for the chip.
+      - fsl,upm-addr-offset : UPM pattern offset for the address latch.
+      - fsl,upm-cmd-offset : UPM pattern offset for the command latch.
+      - gpios : may specify optional GPIO connected to the Ready-Not-Busy pin.
+
+      Example:
+
+	upm@1,0 {
+		compatible = "fsl,upm-nand";
+		reg = <1 0 1>;
+		fsl,upm-addr-offset = <16>;
+		fsl,upm-cmd-offset = <8>;
+		gpios = <&qe_pio_e 18 0>;
+
+		flash {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "stmicro,NAND512W3A2BN6E";
+
+			partition@0 {
+				...
+			};
+		};
+	};
+
+    y) LEDs on GPIOs
+
+    Required properties:
+      - compatible : should be "gpio-led".
+      - gpios : should specify LED GPIO.
+
+    Example:
+
+	pwr_led: led@0 {
+		compatible = "gpio-led";
+		gpios = <&mcu_pio 0 1>;
+	};
+
+	hdd_led: led@1 {
+		compatible = "gpio-led";
+		gpios = <&mcu_pio 1 0>;
+	};
+
+    To specify "purpose" of the LED, "aliases" mechanism is used. Defined
+    aliases are: "led-power", "led-ide-disk" and "led-nand-disk".
+
+    Example:
+
+	aliases {
+		led-power = &pwr_led;
+		led-ide-disk = &hdd_led;
+	};
+
 VII - Marvell Discovery mv64[345]6x System Controller chips
 ===========================================================
 
-- 
1.5.5.1
