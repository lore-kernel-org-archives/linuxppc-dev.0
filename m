Return-Path: <cbouatmailru@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.171])
	by ozlabs.org (Postfix) with ESMTP id 3FB92DDF27
	for <linuxppc-dev@ozlabs.org>; Sat, 24 May 2008 10:30:14 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id j3so949096ugf.0
	for <linuxppc-dev@ozlabs.org>; Fri, 23 May 2008 17:30:12 -0700 (PDT)
Date: Sat, 24 May 2008 04:30:08 +0400
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: [PATCH 6/7] [POWERPC] booting-without-of: add FHCI USB, FSL MCU,
	FSL UPM and GPIO LEDs bindings
Message-ID: <20080524003008.GA20493@zarina>
References: <20080523163811.GA12181@polina.dev.rtsoft.ru>
	<20080523163903.GF16137@polina.dev.rtsoft.ru>
	<25787c450a6a7e79435877a358ab819a@kernel.crashing.org>
	<20080524002825.GA636@zarina>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20080524002825.GA636@zarina>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Timur Tabi <timur@freescale.com>
Reply-To: cbouatmailru@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds few bindings for the new drivers to be submitted through
appropriate maintainers.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 Documentation/powerpc/booting-without-of.txt |  114 ++++++++++++++++++++++++++
 1 files changed, 114 insertions(+), 0 deletions(-)

diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
index 7c01730..8e3f743 100644
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
@@ -2943,6 +2947,116 @@ platforms are moved over to use the flattened-device-tree model.
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
+      - fsl,usb-mode : (optional) so far acceptable value is "host" only
+        (this is default mode if property is absent).
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
+      - default-brightness : (optional) default brightness: 1 on, 0 off.
+        Assumed off if property doesn't present.
+      - linux,default-trigger : (optional) Linux default trigger for this LED.
+      - gpios : should specify LED GPIO.
+
+    Example:
+
+	pwr-led@0 {
+		compatible = "gpio-led";
+		default-brightness = <1>;
+		gpios = <&mcu_pio 0 1>;
+	};
+
+	hdd-led@1 {
+	        compatible = "gpio-led";
+	        linux,default-trigger = "ide-disk";
+		gpios = <&mcu_pio 1 0>;
+	};
+
 VII - Marvell Discovery mv64[345]6x System Controller chips
 ===========================================================
 
-- 
1.5.5.1
