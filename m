Return-Path: <avorontsov@dev.rtsoft.ru>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id E20B8DE25C
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Apr 2008 05:00:58 +1000 (EST)
Date: Tue, 29 Apr 2008 23:00:57 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 6/6] [POWERPC] booting-without-of: add FHCI USB, FSL MCU,
	FSL UPM and GPIO LEDs bindings
Message-ID: <20080429190057.GF21203@polina.dev.rtsoft.ru>
References: <20080429185920.GA19735@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20080429185920.GA19735@polina.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org
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
 Documentation/powerpc/booting-without-of.txt |  125 ++++++++++++++++++++++++++
 1 files changed, 125 insertions(+), 0 deletions(-)

diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
index 4fefc44..6564e0a 100644
--- a/Documentation/powerpc/booting-without-of.txt
+++ b/Documentation/powerpc/booting-without-of.txt
@@ -61,6 +61,10 @@ Table of Contents
       r) Freescale Display Interface Unit
       s) Freescale on board FPGA
       t) Freescale General-purpose Timers Module
+      u) Freescale QUICC Engine USB Controller
+      v) LEDs on GPIOs
+      w) Freescale MCU with MPC8349E-mITX compatible firmware
+      x) Freescale Localbus UPM programmed to work with NAND flash
 
   VII - Marvell Discovery mv64[345]6x System Controller chips
     1) The /system-controller node
@@ -2916,6 +2920,127 @@ platforms are moved over to use the flattened-device-tree model.
     	clock-frequency = <0>;
     };
 
+    u) Freescale QUICC Engine USB Controller
+
+    Required properties:
+      - compatible : should be "fsl,<chip>-qe-usb", "fsl,mpc8323-qe-usb";
+      - reg : the first two cells should contain gtm registers location and
+        length, the next two two cells should contain PRAM location and
+        length.
+      - interrupts : should contain USB interrupt.
+      - interrupt-parent : interrupt source phandle.
+      - fsl,fullspeed-clock : specifies the full speed USB clock source in
+        "clk<num>" or "brg<num>" format.
+      - fsl,lowspeed-clock : specifies the low speed USB clock source in
+        "clk<num>" or "brg<num>" format.
+      - fsl,usb-mode : should be "host".
+      - linux,hub-power-budget : optional, USB power budget for the root hub
+        in mA.
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
+		fsl,usb-mode = "host";
+		gpios = <&qe_pio_b  2 0 /* USBOE */
+			 &qe_pio_b  3 0 /* USBTP */
+			 &qe_pio_b  8 0 /* USBTN */
+			 &qe_pio_b  9 0 /* USBRP */
+			 &qe_pio_b 11 0 /* USBRN */
+			 &qe_pio_e 20 0 /* SPEED */
+			 &qe_pio_e 21 0 /* POWER */>;
+	};
+
+    v) LEDs on GPIOs
+
+    Required properties:
+      - compatible : should be "linux,gpio-led".
+      - linux,name : LED name.
+      - linux,active-low : property should be present if LED wired as
+        active-low.
+      - linux,default-trigger : Linux default trigger for this LED.
+      - linux,brightness : default brightness.
+      - gpios : should specify LED GPIO.
+
+    Example:
+
+	led@0 {
+		compatible = "linux,gpio-led";
+		linux,name = "pwr";
+		linux,brightness = <1>;
+		linux,active-low;
+		gpios = <&mcu_pio 0>;
+	};
+
+	led@1 {
+	        compatible = "linux,gpio-led";
+	        linux,name = "hdd";
+	        linux,default-trigger = "ide-disk";
+		linux,active-low;
+		gpios = <&mcu_pio 1>;
+	};
+
+    w) Freescale MCU with MPC8349E-mITX compatible firmware
+
+    Required properties:
+      - compatible : "fsl,<mcu-chip>-<board>", "fsl,mcu-mpc8349emitx";
+      - reg : should specify I2C address (0x0a).
+      - #address-cells : should be 0.
+      - #size-cells : should be 0.
+      - #gpio-cells : should be 2.
+      - gpio-controller : should be present;
+
+    Example:
+
+	mcu_pio: mcu@0a {
+		#address-cells = <0>;
+		#size-cells = <0>;
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
+      - #address-cells : should be 0;
+      - #size-cells : should be 0;
+      - compatible : "fsl,upm-nand".
+      - reg : should specify localbus chip select and size used for the chip.
+      - fsl,upm-addr-offset : UPM pattern offset for the address latch.
+      - fsl,upm-cmd-offset : UPM pattern offset for the command latch.
+      - gpios : may specify optional GPIO connected to the Ready-Not-Busy pin.
+
+      Example:
+
+	upm@1,0 {
+		#address-cells = <0>;
+		#size-cells = <0>;
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
 VII - Marvell Discovery mv64[345]6x System Controller chips
 ===========================================================
 
-- 
1.5.5.1
