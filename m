Return-Path: <avorontsov@dev.rtsoft.ru>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id 1292CDDDE9
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Apr 2008 05:41:38 +1000 (EST)
Date: Tue, 22 Apr 2008 23:41:35 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [RFC POWERPC] booting-without-of: bindings for FHCI USB, GPIO
	LEDs, MCU, and NAND on UPM
Message-ID: <20080422194135.GA27822@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi all,

Here is purposed bindings draft for the new drivers that I would like to
send for this or next merge window, depending on results of this RFC. ;-)
(The new bindings needs to be in-tree or at least Acked before I could
send the drivers.)

Comments and suggestions are highly appreciated.

Thanks.

diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
index c350623..38fe3e9 100644
--- a/Documentation/powerpc/booting-without-of.txt
+++ b/Documentation/powerpc/booting-without-of.txt
@@ -59,6 +59,11 @@ Table of Contents
       p) Freescale Synchronous Serial Interface
       q) USB EHCI controllers
       r) Freescale General-purpose Timers Module
+      s) Freescale USB Parameter RAM:
+      t) Freescale QUICC Engine USB Controller
+      u) LEDs on GPIOs
+      v) Freescale MCU with MPC8349E-mITX compatible firmware
+      w) NAND on UPM-driven Freescale Localbus
 
   VII - Marvell Discovery mv64[345]6x System Controller chips
     1) The /system-controller node
@@ -2866,6 +2871,139 @@ platforms are moved over to use the flattened-device-tree model.
     	clock-frequency = <0>;
     };
 
+    s) Freescale USB Parameter RAM:
+
+    Required properties:
+      - compatible : should be "fsl,<chip>-qe-muram-usb-pram",
+        "fsl,qe-muram-usb-pram", "fsl,cpm-muram-usb-pram".
+      - reg : should contain USB PRAM location and length.
+
+    Example:
+
+	usb-pram@8b00 {
+		compatible = "fsl,mpc8360-qe-muram-usb-pram",
+			     "fsl,qe-muram-usb-pram",
+			     "fsl,cpm-muram-usb-pram";
+		reg = <0x8b00 0x100>;
+	};
+
+    t) Freescale QUICC Engine USB Controller
+
+    Required properties:
+      - compatible : should be "fsl,<chip>-qe-usb", "fsl,qe-usb",
+        "fsl,usb-fhci"
+      - reg : should contain gtm registers location and length.
+      - interrupts : should contain USB interrupt.
+      - interrupt-parent : interrupt source phandle.
+      - fsl,fullspeed-clock : specifies the full speed USB clock source.
+      - fsl,lowspeed-clock : specifies the low speed USB clock source.
+      - fsl,usb-mode : should be "host".
+      - linux,hub-power-budget : optional, USB power budget for the root hub
+        in mA.
+      - gpios : should specify GPIOs in this order: USBOE, USBTP, USBTN, USBRP,
+        USBRN, SPEED (optional), and SUSPEND (optional).
+
+    Example:
+
+	usb@6c0 {
+		compatible = "fsl,mpc8360-qe-usb", "fsl,qe-usb",
+			     "fsl,usb-fhci";
+		reg = <0x6c0 0x40>;
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
+			 &qe_pio_e 21 0 /* SUSPN */>;
+	};
+
+    u) LEDs on GPIOs
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
+    v) Freescale MCU with MPC8349E-mITX compatible firmware
+
+    Required properties:
+      - compatible : "fsl,<mcu-chip>-<board>", "fsl,mcu-mpc8349emitx",
+        "simple-bus";
+      - reg : should specify I2C address (0x0a).
+      - #address-cells : should be 0.
+      - #size-cells : should be 0.
+      - #gpio-cells : should be 1.
+      - gpio-controller : should be present;
+
+    Example:
+
+	mcu_pio: mcu@0a {
+		#address-cells = <0>;
+		#size-cells = <0>;
+		#gpio-cells = <1>;
+		compatible = "fsl,mc9s08qg8-mpc8349emitx",
+			     "fsl,mcu-mpc8349emitx",
+			     "simple-bus";
+		reg = <0x0a>;
+		gpio-controller;
+	};
+
+    w) NAND on UPM-driven Freescale Localbus
+
+      Required properties:
+      - compatible : "fsl,upm-nand".
+      - reg : should specify localbus chip select and size used for the chip.
+      - width : should specify port size in bytes.
+      - fsl,upm-addr-offset : UPM pattern offset for the address latch.
+      - fsl,upm-cmd-offset : UPM pattern offset for the command latch.
+      - fsl,wait-pattern : should be present if NAND chip requires waiting
+        for Ready-Not-Busy pin after each executed pattern.
+      - fsl,wait-write : should be present if NAND chip needs waiting on
+        Ready-Not-Busy pin after each write cycle.
+      - linux,chip-delay : optional, may contain delay value in milliseconds
+        (in case when Ready-Not-Busy pin was unspecified).
+      - gpios : may specify optional GPIO connected to the Ready-Not-Busy pin.
+
+      Example:
+
+	flash@1,0 {
+		compatible = "stmicro,NAND512W3A2BN6E", "fsl,upm-nand";
+		reg = <1 0 1>;
+		width = <1>;
+		fsl,upm-addr-offset = <16>;
+		fsl,upm-cmd-offset = <8>;
+		fsl,wait-pattern;
+		fsl,wait-write;
+		gpios = <&qe_pio_e 18 0>;
+	};
+
 VII - Marvell Discovery mv64[345]6x System Controller chips
 ===========================================================
 
