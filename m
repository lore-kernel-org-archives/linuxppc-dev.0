Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id BF562DDFBE
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Jul 2008 02:53:30 +1000 (EST)
Date: Fri, 4 Jul 2008 20:53:28 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH v2] powerpc: add FHCI USB, FSL MCU, FSL UPM and GPIO LEDs
	bindings
Message-ID: <20080704165328.GA9962@polina.dev.rtsoft.ru>
References: <20080703174844.GA27966@polina.dev.rtsoft.ru>
	<EC062FA3-9CF8-4A94-95C7-2AAF22754A9C@kernel.crashing.org>
	<20080703182440.GA2576@polina.dev.rtsoft.ru>
	<8A8D87F8-A1DD-467D-8D83-CDC651B99F45@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <8A8D87F8-A1DD-467D-8D83-CDC651B99F45@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds few bindings for the new drivers to be submitted through
the appropriate maintainers.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---

Updated to decrypt MCU, and to split the bindings into appropriate files.

 .../powerpc/device-tree/fsl/mcu-mpc8349emitx.txt   |   17 +++++++++
 Documentation/powerpc/device-tree/fsl/qe/usb.txt   |   37 ++++++++++++++++++++
 Documentation/powerpc/device-tree/fsl/upm-nand.txt |   28 +++++++++++++++
 Documentation/powerpc/device-tree/gpio/led.txt     |   15 ++++++++
 4 files changed, 97 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/powerpc/device-tree/fsl/mcu-mpc8349emitx.txt
 create mode 100644 Documentation/powerpc/device-tree/fsl/qe/usb.txt
 create mode 100644 Documentation/powerpc/device-tree/fsl/upm-nand.txt
 create mode 100644 Documentation/powerpc/device-tree/gpio/led.txt

diff --git a/Documentation/powerpc/device-tree/fsl/mcu-mpc8349emitx.txt b/Documentation/powerpc/device-tree/fsl/mcu-mpc8349emitx.txt
new file mode 100644
index 0000000..0f76633
--- /dev/null
+++ b/Documentation/powerpc/device-tree/fsl/mcu-mpc8349emitx.txt
@@ -0,0 +1,17 @@
+Freescale MPC8349E-mITX-compatible Power Management Micro Controller Unit (MCU)
+
+Required properties:
+- compatible : "fsl,<mcu-chip>-<board>", "fsl,mcu-mpc8349emitx".
+- reg : should specify I2C address (0x0a).
+- #gpio-cells : should be 2.
+- gpio-controller : should be present.
+
+Example:
+
+mcu@0a {
+	#gpio-cells = <2>;
+	compatible = "fsl,mc9s08qg8-mpc8349emitx",
+		     "fsl,mcu-mpc8349emitx";
+	reg = <0x0a>;
+	gpio-controller;
+};
diff --git a/Documentation/powerpc/device-tree/fsl/qe/usb.txt b/Documentation/powerpc/device-tree/fsl/qe/usb.txt
new file mode 100644
index 0000000..9ccd5f3
--- /dev/null
+++ b/Documentation/powerpc/device-tree/fsl/qe/usb.txt
@@ -0,0 +1,37 @@
+Freescale QUICC Engine USB Controller
+
+Required properties:
+- compatible : should be "fsl,<chip>-qe-usb", "fsl,mpc8323-qe-usb".
+- reg : the first two cells should contain usb registers location and
+  length, the next two two cells should contain PRAM location and
+  length.
+- interrupts : should contain USB interrupt.
+- interrupt-parent : interrupt source phandle.
+- fsl,fullspeed-clock : specifies the full speed USB clock source:
+  "none": clock source is disabled
+  "brg1" through "brg16": clock source is BRG1-BRG16, respectively
+  "clk1" through "clk24": clock source is CLK1-CLK24, respectively
+- fsl,lowspeed-clock : specifies the low speed USB clock source:
+  "none": clock source is disabled
+  "brg1" through "brg16": clock source is BRG1-BRG16, respectively
+  "clk1" through "clk24": clock source is CLK1-CLK24, respectively
+- hub-power-budget : USB power budget for the root hub, in mA.
+- gpios : should specify GPIOs in this order: USBOE, USBTP, USBTN, USBRP,
+  USBRN, SPEED (optional), and POWER (optional).
+
+Example:
+
+usb@6c0 {
+	compatible = "fsl,mpc8360-qe-usb", "fsl,mpc8323-qe-usb";
+	reg = <0x6c0 0x40 0x8b00 0x100>;
+	interrupts = <11>;
+	interrupt-parent = <&qeic>;
+	fsl,fullspeed-clock = "clk21";
+	gpios = <&qe_pio_b  2 0 /* USBOE */
+		 &qe_pio_b  3 0 /* USBTP */
+		 &qe_pio_b  8 0 /* USBTN */
+		 &qe_pio_b  9 0 /* USBRP */
+		 &qe_pio_b 11 0 /* USBRN */
+		 &qe_pio_e 20 0 /* SPEED */
+		 &qe_pio_e 21 0 /* POWER */>;
+};
diff --git a/Documentation/powerpc/device-tree/fsl/upm-nand.txt b/Documentation/powerpc/device-tree/fsl/upm-nand.txt
new file mode 100644
index 0000000..84a04d5
--- /dev/null
+++ b/Documentation/powerpc/device-tree/fsl/upm-nand.txt
@@ -0,0 +1,28 @@
+Freescale Localbus UPM programmed to work with NAND flash
+
+Required properties:
+- compatible : "fsl,upm-nand".
+- reg : should specify localbus chip select and size used for the chip.
+- fsl,upm-addr-offset : UPM pattern offset for the address latch.
+- fsl,upm-cmd-offset : UPM pattern offset for the command latch.
+- gpios : may specify optional GPIO connected to the Ready-Not-Busy pin.
+
+Example:
+
+upm@1,0 {
+	compatible = "fsl,upm-nand";
+	reg = <1 0 1>;
+	fsl,upm-addr-offset = <16>;
+	fsl,upm-cmd-offset = <8>;
+	gpios = <&qe_pio_e 18 0>;
+
+	flash {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "...";
+
+		partition@0 {
+			...
+		};
+	};
+};
diff --git a/Documentation/powerpc/device-tree/gpio/led.txt b/Documentation/powerpc/device-tree/gpio/led.txt
new file mode 100644
index 0000000..ff51f4c
--- /dev/null
+++ b/Documentation/powerpc/device-tree/gpio/led.txt
@@ -0,0 +1,15 @@
+LED connected to GPIO
+
+Required properties:
+- compatible : should be "gpio-led".
+- label : (optional) the label for this LED. If omitted, the label is
+  taken from the node name (excluding the unit address).
+- gpios : should specify LED GPIO.
+
+Example:
+
+led@0 {
+	compatible = "gpio-led";
+	label = "hdd";
+	gpios = <&mcu_pio 0 1>;
+};
-- 
1.5.5.4
