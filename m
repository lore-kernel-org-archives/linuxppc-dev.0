Return-Path: <grant.likely@secretlab.ca>
Received: from sandbox.secretlab.ca (S01060016b61d1226.cg.shawcable.net
	[68.147.191.145]) by ozlabs.org (Postfix) with ESMTP id 2B209DDE45
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Feb 2007 18:30:42 +1100 (EST)
From: Grant Likely <grant.likely@secretlab.ca>
To: linuxppc-dev@ozlabs.org,
	Sylvain Munaut <tnt@246tnt.com>
Subject: [RFC] mpc5200 device tree bindings refinement
Date: Fri,  9 Feb 2007 00:30:09 -0700
Message-Id: <11710062092006-git-send-email-grant.likely@secretlab.ca>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Much needed refinement of mpc5200 device tree binding specifications.

Short list:
- drop mpc52xx designator; only two supported chips exist, 5200 and 5200b.
  It's premature to refer to them as '52xx'.
- Specify optional 'model' and 'revision' properties in the soc5200 node
- Specify reqiured 'cell-index' property to identify between multiple SOC
  devices of the same type.  (Useful for arbitrating shared register access)
- Specify optional 'port-number' property for adjusting the logical serial
  port assignments.
- Specify optional 'has-wdt' property for gpt0 node.
- Add system-frequency property to soc5200 node

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

It's been a bit in coming; but here are the changes to the 5200 device tree
bindings which were discussed to death on the list about a month ago.

 .../powerpc/mpc52xx-device-tree-bindings.txt       |  179 +++++++++++++-------
 arch/powerpc/boot/dts/lite5200.dts                 |  135 +++++++++------
 arch/powerpc/boot/dts/lite5200b.dts                |  131 +++++++++------
 3 files changed, 273 insertions(+), 172 deletions(-)

diff --git a/Documentation/powerpc/mpc52xx-device-tree-bindings.txt b/Documentation/powerpc/mpc52xx-device-tree-bindings.txt
index 69f016f..b7b682a 100644
--- a/Documentation/powerpc/mpc52xx-device-tree-bindings.txt
+++ b/Documentation/powerpc/mpc52xx-device-tree-bindings.txt
@@ -1,7 +1,7 @@
-MPC52xx Device Tree Bindings
+MPC5200 Device Tree Bindings
 ----------------------------
 
-(c) 2006 Secret Lab Technologies Ltd
+(c) 2006-2007 Secret Lab Technologies Ltd
 Grant Likely <grant.likely at secretlab.ca>
 
 ********** DRAFT ***********
@@ -20,11 +20,11 @@ described in Documentation/powerpc/booti
 by Open Firmare (IEEE 1275) compatible firmware using an OF compatible
 client interface API.
 
-This document specifies the requirements on the device-tree for mpc52xx
+This document specifies the requirements on the device-tree for mpc5200
 based boards.  These requirements are above and beyond the details
 specified in either the OpenFirmware spec or booting-without-of.txt
 
-All new mpc52xx-based boards are expected to match this document.  In
+All new mpc5200-based boards are expected to match this document.  In
 cases where this document is not sufficient to support a new board port,
 this document should be updated as part of adding the new board support.
 
@@ -32,26 +32,26 @@ II - Philosophy
 ===============
 The core of this document is naming convention.  The whole point of
 defining this convention is to reduce or eliminate the number of
-special cases required to support a 52xx board.  If all 52xx boards
-follow the same convention, then generic 52xx support code will work
+special cases required to support a 5200 board.  If all 5200 boards
+follow the same convention, then generic 5200 support code will work
 rather than coding special cases for each new board.
 
 This section tries to capture the thought process behind why the naming
 convention is what it is.
 
-1. Node names
--------------
+1.  names
+---------
 There is strong convention/requirements already established for children
 of the root node.  'cpus' describes the processor cores, 'memory'
 describes memory, and 'chosen' provides boot configuration.  Other nodes
 are added to describe devices attached to the processor local bus.
+
 Following convention already established with other system-on-chip
-processors, MPC52xx boards must have an 'soc5200' node as a child of the
-root node.
+processors, 5200 device trees should use the name 'soc5200' for the
+parent node of on chip devices, and the root node should be its parent.
 
-The soc5200 node holds child nodes for all on chip devices.  Child nodes
-are typically named after the configured function.  ie. the FEC node is
-named 'ethernet', and a PSC in uart mode is named 'serial'.
+Child nodes are typically named after the configured function.  ie.
+the FEC node is named 'ethernet', and a PSC in uart mode is named 'serial'.
 
 2. device_type property
 -----------------------
@@ -66,28 +66,47 @@ exactly.
 Since device_type isn't enough to match devices to drivers, there also
 needs to be a naming convention for the compatible property.  Compatible
 is an list of device descriptions sorted from specific to generic.  For
-the mpc52xx, the required format for each compatible value is
-<chip>-<device>[-<mode>].  At the minimum, the list shall contain two
-items; the first specifying the exact chip, and the second specifying
-mpc52xx for the chip.
-
-ie. ethernet on mpc5200b: compatible = "mpc5200b-ethernet\0mpc52xx-ethernet"
-
-The idea here is that most drivers will match to the most generic field
-in the compatible list (mpc52xx-*), but can also test the more specific
-field for enabling bug fixes or extra features.
+the mpc5200, the required format for each compatible value is
+<chip>-<device>[-<mode>].  The OS should be able to match a device driver
+to the device based solely on the compatible value.  If two drivers
+match on the compatible list; the 'most compatible' driver should be
+selected.
+
+The split between the MPC5200 and the MPC5200B leaves a bit of a
+connundrum.  How should the compatible property be set up to provide
+maximum compatability information; but still acurately describe the
+chip?  For the MPC5200; the answer is easy.  Most of the SoC devices
+originally appeared on the MPC5200.  Since they didn't exist anywhere
+else; the 5200 compatible properties will contain only one item;
+"mpc5200-<device>".
+
+The 5200B is almost the same as the 5200, but not quite.  It fixes
+silicon bugs and it adds a small number of enhancements.  Most of the
+devices either provide exactly the same interface as on the 5200.  A few
+devices have extra functions but still have a backwards compatible mode.
+To express this infomation as completely as possible, 5200B device trees
+should have two items in the compatible list;
+"mpc5200b-<device>\0mpc5200-<device>".  It is *strongly* recommended
+that 5200B device trees follow this convention (instead of only listing
+the base mpc5200 item).
+
+If another chip appear on the market with one of the mpc5200 SoC
+devices, then the compatible list should include mpc5200-<device>.
+
+ie. ethernet on mpc5200: compatible = "mpc5200-ethernet"
+    ethernet on mpc5200b: compatible = "mpc5200b-ethernet\0mpc5200-ethernet"
 
 Modal devices, like PSCs, also append the configured function to the
 end of the compatible field.  ie. A PSC in i2s mode would specify
-"mpc52xx-psc-i2s", not "mpc52xx-i2s".  This convention is chosen to
+"mpc5200-psc-i2s", not "mpc5200-i2s".  This convention is chosen to
 avoid naming conflicts with non-psc devices providing the same
-function.  For example, "mpc52xx-spi" and "mpc52xx-psc-spi" describe
+function.  For example, "mpc5200-spi" and "mpc5200-psc-spi" describe
 the mpc5200 simple spi device and a PSC spi mode respectively.
 
 If the soc device is more generic and present on other SOCs, the
 compatible property can specify the more generic device type also.
 
-ie. mscan: compatible = "mpc5200-mscan\0mpc52xx-mscan\0fsl,mscan";
+ie. mscan: compatible = "mpc5200-mscan\0fsl,mscan";
 
 At the time of writing, exact chip may be either 'mpc5200' or
 'mpc5200b'.
@@ -96,7 +115,7 @@ Device drivers should always try to matc
 
 III - Structure
 ===============
-The device tree for an mpc52xx board follows the structure defined in
+The device tree for an mpc5200 board follows the structure defined in
 booting-without-of.txt with the following additional notes:
 
 0) the root node
@@ -115,7 +134,7 @@ Typical memory description node; see boo
 
 3) The soc5200 node
 -------------------
-This node describes the on chip SOC peripherals.  Every mpc52xx based
+This node describes the on chip SOC peripherals.  Every mpc5200 based
 board will have this node, and as such there is a common naming
 convention for SOC devices.
 
@@ -125,71 +144,107 @@ name			type		description
 device_type		string		must be "soc"
 ranges			int		should be <0 baseaddr baseaddr+10000>
 reg			int		must be <baseaddr 10000>
+compatible		string		mpc5200: "mpc5200-soc"
+					mpc5200b: "mpc5200b-soc\0mpc5200-soc"
+system-frequency	int		Fsystem frequency; source of all
+					other clocks.
+bus-frequency		int		IPB bus frequency in HZ.  Clock rate
+					used by most of the soc devices.
+#interrupt-cells	int		must be <3>.
 
 Recommended properties:
 name			type		description
 ----			----		-----------
-compatible		string		should be "<chip>-soc\0mpc52xx-soc"
-					ie. "mpc5200b-soc\0mpc52xx-soc"
-#interrupt-cells	int		must be <3>.  If it is not defined
-					here then it must be defined in every
-					soc device node.
-bus-frequency		int		IPB bus frequency in HZ.  Clock rate
-					used by most of the soc devices.
-					Defining it here avoids needing it
-					added to every device node.
+model			string		Exact model of the chip;
+					ie: model="fsl,mpc5200"
+revision		string		Silicon revision of chip
+					ie: revision="M08A"
+
+The 'model' and 'revision' properties are *strongly* recommended.  Having
+them presence acts as a bit of a safety net for working around as yet
+undiscovered bugs on one version of silicon.  For example, device drivers
+can use the model and revision properties to decide if a bug fix should
+be turned on.
 
 4) soc5200 child nodes
 ----------------------
 Any on chip SOC devices available to Linux must appear as soc5200 child nodes.
 
-Note: in the tables below, '*' matches all <chip> values.  ie.
-*-pic would translate to "mpc5200-pic\0mpc52xx-pic"
+Note: The tables below show the value for the mpc5200.  A mpc5200b device
+tree should use the "mpc5200b-<device>\0mpc5200-<device> form.
 
 Required soc5200 child nodes:
 name		device_type		compatible	Description
 ----		-----------		----------	-----------
-cdm@<addr>	cdm			*-cmd		Clock Distribution
-pic@<addr>	interrupt-controller	*-pic		need an interrupt
+cdm@<addr>	cdm			mpc5200-cmd	Clock Distribution
+pic@<addr>	interrupt-controller	mpc5200-pic	need an interrupt
 							controller to boot
-bestcomm@<addr>	dma-controller		*-bestcomm	52xx pic also requires
-							the bestcomm device
+bestcomm@<addr>	dma-controller		mpc5200-bestcomm 5200 pic also requires
+							 the bestcomm device
 
 Recommended soc5200 child nodes; populate as needed for your board
-name		device_type	compatible	Description
-----		-----------	----------	-----------
-gpt@<addr>	gpt		*-gpt		General purpose timers
-rtc@<addr>	rtc		*-rtc		Real time clock
-mscan@<addr>	mscan		*-mscan		CAN bus controller
-pci@<addr>	pci		*-pci		PCI bridge
-serial@<addr>	serial		*-psc-uart	PSC in serial mode
-i2s@<addr>	sound		*-psc-i2s	PSC in i2s mode
-ac97@<addr>	sound		*-psc-ac97	PSC in ac97 mode
-spi@<addr>	spi		*-psc-spi	PSC in spi mode
-irda@<addr>	irda		*-psc-irda	PSC in IrDA mode
-spi@<addr>	spi		*-spi		MPC52xx spi device
-ethernet@<addr>	network		*-fec		MPC52xx ethernet device
-ata@<addr>	ata		*-ata		IDE ATA interface
-i2c@<addr>	i2c		*-i2c		I2C controller
-usb@<addr>	usb-ohci-be	*-ohci,ohci-be	USB controller
-xlb@<addr>	xlb		*-xlb		XLB arbritrator
+name		device_type	compatible	  Description
+----		-----------	----------	  -----------
+gpt@<addr>	gpt		mpc5200-gpt	  General purpose timers
+rtc@<addr>	rtc		mpc5200-rtc	  Real time clock
+mscan@<addr>	mscan		mpc5200-mscan	  CAN bus controller
+pci@<addr>	pci		mpc5200-pci	  PCI bridge
+serial@<addr>	serial		mpc5200-psc-uart  PSC in serial mode
+i2s@<addr>	sound		mpc5200-psc-i2s	  PSC in i2s mode
+ac97@<addr>	sound		mpc5200-psc-ac97  PSC in ac97 mode
+spi@<addr>	spi		mpc5200-psc-spi	  PSC in spi mode
+irda@<addr>	irda		mpc5200-psc-irda  PSC in IrDA mode
+spi@<addr>	spi		mpc5200-spi	  MPC5200 spi device
+ethernet@<addr>	network		mpc5200-fec	  MPC5200 ethernet device
+ata@<addr>	ata		mpc5200-ata	  IDE ATA interface
+i2c@<addr>	i2c		mpc5200-i2c	  I2C controller
+usb@<addr>	usb-ohci-be	mpc5200-ohci,ohci-be	USB controller
+xlb@<addr>	xlb		mpc5200-xlb	  XLB arbritrator
+
+Important child node properties
+name		type		description
+----		----		-----------
+cell-index	int		When multiple devices are present, is the
+				index of the device in the hardware (ie. There
+				are 6 PSC on the 5200 numbered PSC1 to PSC6)
+				    PSC1 has 'cell-index = <0>'
+				    PSC4 has 'cell-index = <3>'
+
+5) General Purpose Timer nodes (child of soc5200 node)
+On the mpc5200 and 5200b, GPT0 has a watchdog timer function.  If the board
+design supports the internal wdt, then the device node for GPT0 should
+include the empty property 'has-wdt'.
+
+6) PSC nodes (child of soc5200 node)
+PSC nodes can define the optional 'port-number' property to force assignment
+order of serial ports.  For example, PSC5 might be physically connected to
+the port labeled 'COM1' and PSC1 wired to 'COM1'.  In this case, PSC5 would
+have a "port-number = <0>" property, and PSC1 would have "port-number = <1>".
 
 IV - Extra Notes
 ================
 
 1. Interrupt mapping
 --------------------
-The mpc52xx pic driver splits hardware IRQ numbers into two levels.  The
+The mpc5200 pic driver splits hardware IRQ numbers into two levels.  The
 split reflects the layout of the PIC hardware itself, which groups
 interrupts into one of three groups; CRIT, MAIN or PERP.  Also, the
 Bestcomm dma engine has it's own set of interrupt sources which are
 cascaded off of peripheral interrupt 0, which the driver interprets as a
 fourth group, SDMA.
 
-The interrupts property for device nodes using the mpc52xx pic consists
+The interrupts property for device nodes using the mpc5200 pic consists
 of three cells; <L1 L2 level>
 
     L1 := [CRIT=0, MAIN=1, PERP=2, SDMA=3]
     L2 := interrupt number; directly mapped from the value in the
           "ICTL PerStat, MainStat, CritStat Encoded Register"
     level := [LEVEL_HIGH=0, EDGE_RISING=1, EDGE_FALLING=2, LEVEL_LOW=3]
+
+2. Shared registers
+-------------------
+Some SoC devices share registers between them.  ie. the i2c devices use
+a single clock control register, and almost all device are affected by
+the port_config register.  Devices which need to manipulate shared regs
+should look to the parent SoC node.  The soc node is responsible
+for arbitrating all shared register access.
diff --git a/arch/powerpc/boot/dts/lite5200.dts b/arch/powerpc/boot/dts/lite5200.dts
index 1868707..c03103c 100644
--- a/arch/powerpc/boot/dts/lite5200.dts
+++ b/arch/powerpc/boot/dts/lite5200.dts
@@ -1,7 +1,7 @@
 /*
  * Lite5200 board Device Tree Source
  *
- * Copyright 2006 Secret Lab Technologies Ltd.
+ * Copyright 2006-2007 Secret Lab Technologies Ltd.
  * Grant Likely <grant.likely@secretlab.ca>
  *
  * This program is free software; you can redistribute  it and/or modify it
@@ -17,8 +17,9 @@
  */
 
 / {
-	model = "Lite5200";
-	compatible = "lite5200\0lite52xx\0mpc5200\0mpc52xx";
+	model = "fsl,lite5200";
+	// revision = "1.0";
+	compatible = "fsl,lite5200\0generic-mpc5200";
 	#address-cells = <1>;
 	#size-cells = <1>;
 
@@ -47,14 +48,17 @@
 	};
 
 	soc5200@f0000000 {
+		model = "fsl,mpc5200";
+		revision = ""			// from bootloader
 		#interrupt-cells = <3>;
 		device_type = "soc";
 		ranges = <0 f0000000 f0010000>;
 		reg = <f0000000 00010000>;
 		bus-frequency = <0>;		// from bootloader
+		system-frequency = <0>;		// from bootloader
 
 		cdm@200 {
-			compatible = "mpc5200-cdm\0mpc52xx-cdm";
+			compatible = "mpc5200-cdm";
 			reg = <200 38>;
 		};
 
@@ -64,77 +68,86 @@
 			interrupt-controller;
 			#interrupt-cells = <3>;
 			device_type = "interrupt-controller";
-			compatible = "mpc5200-pic\0mpc52xx-pic";
+			compatible = "mpc5200-pic";
 			reg = <500 80>;
 			built-in;
 		};
 
 		gpt@600 {	// General Purpose Timer
-			compatible = "mpc5200-gpt\0mpc52xx-gpt";
+			compatible = "mpc5200-gpt";
 			device_type = "gpt";
+			cell-index = <0>;
 			reg = <600 10>;
 			interrupts = <1 9 0>;
 			interrupt-parent = <500>;
+			has-wdt;
 		};
 
 		gpt@610 {	// General Purpose Timer
-			compatible = "mpc5200-gpt\0mpc52xx-gpt";
+			compatible = "mpc5200-gpt";
 			device_type = "gpt";
+			cell-index = <1>;
 			reg = <610 10>;
 			interrupts = <1 a 0>;
 			interrupt-parent = <500>;
 		};
 
 		gpt@620 {	// General Purpose Timer
-			compatible = "mpc5200-gpt\0mpc52xx-gpt";
+			compatible = "mpc5200-gpt";
 			device_type = "gpt";
+			cell-index = <2>;
 			reg = <620 10>;
 			interrupts = <1 b 0>;
 			interrupt-parent = <500>;
 		};
 
 		gpt@630 {	// General Purpose Timer
-			compatible = "mpc5200-gpt\0mpc52xx-gpt";
+			compatible = "mpc5200-gpt";
 			device_type = "gpt";
+			cell-index = <3>;
 			reg = <630 10>;
 			interrupts = <1 c 0>;
 			interrupt-parent = <500>;
 		};
 
 		gpt@640 {	// General Purpose Timer
-			compatible = "mpc5200-gpt\0mpc52xx-gpt";
+			compatible = "mpc5200-gpt";
 			device_type = "gpt";
+			cell-index = <4>;
 			reg = <640 10>;
 			interrupts = <1 d 0>;
 			interrupt-parent = <500>;
 		};
 
 		gpt@650 {	// General Purpose Timer
-			compatible = "mpc5200-gpt\0mpc52xx-gpt";
+			compatible = "mpc5200-gpt";
 			device_type = "gpt";
+			cell-index = <5>;
 			reg = <650 10>;
 			interrupts = <1 e 0>;
 			interrupt-parent = <500>;
 		};
 
 		gpt@660 {	// General Purpose Timer
-			compatible = "mpc5200-gpt\0mpc52xx-gpt";
+			compatible = "mpc5200-gpt";
 			device_type = "gpt";
+			cell-index = <6>;
 			reg = <660 10>;
 			interrupts = <1 f 0>;
 			interrupt-parent = <500>;
 		};
 
 		gpt@670 {	// General Purpose Timer
-			compatible = "mpc5200-gpt\0mpc52xx-gpt";
+			compatible = "mpc5200-gpt";
 			device_type = "gpt";
+			cell-index = <7>;
 			reg = <670 10>;
 			interrupts = <1 10 0>;
 			interrupt-parent = <500>;
 		};
 
 		rtc@800 {	// Real time clock
-			compatible = "mpc5200-rtc\0mpc52xx-rtc";
+			compatible = "mpc5200-rtc";
 			device_type = "rtc";
 			reg = <800 100>;
 			interrupts = <1 5 0 1 6 0>;
@@ -143,7 +156,8 @@
 
 		mscan@900 {
 			device_type = "mscan";
-			compatible = "mpc5200-mscan\0mpc52xx-mscan";
+			compatible = "mpc5200-mscan";
+			cell-index = <0>;
 			interrupts = <2 11 0>;
 			interrupt-parent = <500>;
 			reg = <900 80>;
@@ -151,21 +165,22 @@
 
 		mscan@980 {
 			device_type = "mscan";
-			compatible = "mpc5200-mscan\0mpc52xx-mscan";
+			compatible = "mpc5200-mscan";
+			cell-index = <1>;
 			interrupts = <1 12 0>;
 			interrupt-parent = <500>;
 			reg = <980 80>;
 		};
 
 		gpio@b00 {
-			compatible = "mpc5200-gpio\0mpc52xx-gpio";
+			compatible = "mpc5200-gpio";
 			reg = <b00 40>;
 			interrupts = <1 7 0>;
 			interrupt-parent = <500>;
 		};
 
 		gpio-wkup@b00 {
-			compatible = "mpc5200-gpio-wkup\0mpc52xx-gpio-wkup";
+			compatible = "mpc5200-gpio-wkup";
 			reg = <c00 40>;
 			interrupts = <1 8 0 0 3 0>;
 			interrupt-parent = <500>;
@@ -176,7 +191,7 @@
 			#size-cells = <2>;
 			#address-cells = <3>;
 			device_type = "pci";
-			compatible = "mpc5200-pci\0mpc52xx-pci";
+			compatible = "mpc5200-pci";
 			reg = <d00 100>;
 			interrupt-map-mask = <f800 0 0 7>;
 			interrupt-map = <c000 0 0 1 500 0 0 3
@@ -194,7 +209,7 @@
 
 		spi@f00 {
 			device_type = "spi";
-			compatible = "mpc5200-spi\0mpc52xx-spi";
+			compatible = "mpc5200-spi";
 			reg = <f00 20>;
 			interrupts = <2 d 0 2 e 0>;
 			interrupt-parent = <500>;
@@ -202,7 +217,7 @@
 
 		usb@1000 {
 			device_type = "usb-ohci-be";
-			compatible = "mpc5200-ohci\0mpc52xx-ohci\0ohci-be";
+			compatible = "mpc5200-ohci\0ohci-be";
 			reg = <1000 ff>;
 			interrupts = <2 6 0>;
 			interrupt-parent = <500>;
@@ -210,7 +225,7 @@
 
 		bestcomm@1200 {
 			device_type = "dma-controller";
-			compatible = "mpc5200-bestcomm\0mpc52xx-bestcomm";
+			compatible = "mpc5200-bestcomm";
 			reg = <1200 80>;
 			interrupts = <3 0 0  3 1 0  3 2 0  3 3 0
 			              3 4 0  3 5 0  3 6 0  3 7 0
@@ -220,67 +235,73 @@
 		};
 
 		xlb@1f00 {
-			compatible = "mpc5200-xlb\0mpc52xx-xlb";
+			compatible = "mpc5200-xlb";
 			reg = <1f00 100>;
 		};
 
 		serial@2000 {		// PSC1
 			device_type = "serial";
-			compatible = "mpc5200-psc-uart\0mpc52xx-psc-uart";
+			compatible = "mpc5200-psc-uart";
 			port-number = <0>;  // Logical port assignment
+			cell-index = <0>;
 			reg = <2000 100>;
 			interrupts = <2 1 0>;
 			interrupt-parent = <500>;
 		};
 
-		// PSC2 in spi mode example
-		spi@2200 {		// PSC2
-			device_type = "spi";
-			compatible = "mpc5200-psc-spi\0mpc52xx-psc-spi";
-			reg = <2200 100>;
-			interrupts = <2 2 0>;
-			interrupt-parent = <500>;
-		};
+		// PSC2 in ac97 mode example
+		//ac97@2200 {		// PSC2
+		//	device_type = "sound";
+		//	compatible = "mpc5200-psc-ac97";
+		//	cell-index = <1>;
+		//	reg = <2200 100>;
+		//	interrupts = <2 2 0>;
+		//	interrupt-parent = <500>;
+		//};
 
 		// PSC3 in CODEC mode example
-		i2s@2400 {		// PSC3
-			device_type = "sound";
-			compatible = "mpc5200-psc-i2s\0mpc52xx-psc-i2s";
-			reg = <2400 100>;
-			interrupts = <2 3 0>;
-			interrupt-parent = <500>;
-		};
+		//i2s@2400 {		// PSC3
+		//	device_type = "sound";
+		//	compatible = "mpc5200-psc-i2s";
+		//	cell-index = <2>;
+		//	reg = <2400 100>;
+		//	interrupts = <2 3 0>;
+		//	interrupt-parent = <500>;
+		//};
 
-		// PSC4 unconfigured
+		// PSC4 in uart mode example
 		//serial@2600 {		// PSC4
 		//	device_type = "serial";
-		//	compatible = "mpc5200-psc-uart\0mpc52xx-psc-uart";
+		//	compatible = "mpc5200-psc-uart";
+		//	cell-index = <3>;
 		//	reg = <2600 100>;
 		//	interrupts = <2 b 0>;
 		//	interrupt-parent = <500>;
 		//};
 
-		// PSC5 unconfigured
+		// PSC5 in uart mode example
 		//serial@2800 {		// PSC5
 		//	device_type = "serial";
-		//	compatible = "mpc5200-psc-uart\0mpc52xx-psc-uart";
+		//	compatible = "mpc5200-psc-uart";
+		//	cell-index = <4>;
 		//	reg = <2800 100>;
 		//	interrupts = <2 c 0>;
 		//	interrupt-parent = <500>;
 		//};
 
-		// PSC6 in AC97 mode example
-		ac97@2c00 {		// PSC6
-			device_type = "sound";
-			compatible = "mpc5200-psc-ac97\0mpc52xx-psc-ac97";
-			reg = <2c00 100>;
-			interrupts = <2 4 0>;
-			interrupt-parent = <500>;
-		};
+		// PSC6 in spi mode example
+		//spi@2c00 {		// PSC6
+		//	device_type = "spi";
+		//	compatible = "mpc5200-psc-spi";
+		//	cell-index = <5>;
+		//	reg = <2c00 100>;
+		//	interrupts = <2 4 0>;
+		//	interrupt-parent = <500>;
+		//};
 
 		ethernet@3000 {
 			device_type = "network";
-			compatible = "mpc5200-fec\0mpc52xx-fec";
+			compatible = "mpc5200-fec";
 			reg = <3000 800>;
 			mac-address = [ 02 03 04 05 06 07 ]; // Bad!
 			interrupts = <2 5 0>;
@@ -289,7 +310,7 @@
 
 		ata@3a00 {
 			device_type = "ata";
-			compatible = "mpc5200-ata\0mpc52xx-ata";
+			compatible = "mpc5200-ata";
 			reg = <3a00 100>;
 			interrupts = <2 7 0>;
 			interrupt-parent = <500>;
@@ -297,7 +318,8 @@
 
 		i2c@3d00 {
 			device_type = "i2c";
-			compatible = "mpc5200-i2c\0mpc52xx-i2c";
+			compatible = "mpc5200-i2c";
+			cell-index = <0>;
 			reg = <3d00 40>;
 			interrupts = <2 f 0>;
 			interrupt-parent = <500>;
@@ -305,14 +327,15 @@
 
 		i2c@3d40 {
 			device_type = "i2c";
-			compatible = "mpc5200-i2c\0mpc52xx-i2c";
+			compatible = "mpc5200-i2c";
+			cell-index = <1>;
 			reg = <3d40 40>;
 			interrupts = <2 10 0>;
 			interrupt-parent = <500>;
 		};
 		sram@8000 {
 			device_type = "sram";
-			compatible = "mpc5200-sram\0mpc52xx-sram\0sram";
+			compatible = "mpc5200-sram\0sram";
 			reg = <8000 4000>;
 		};
 	};
diff --git a/arch/powerpc/boot/dts/lite5200b.dts b/arch/powerpc/boot/dts/lite5200b.dts
index 5bb2760..bd74dc0 100644
--- a/arch/powerpc/boot/dts/lite5200b.dts
+++ b/arch/powerpc/boot/dts/lite5200b.dts
@@ -1,7 +1,7 @@
 /*
  * Lite5200B board Device Tree Source
  *
- * Copyright 2006 Secret Lab Technologies Ltd.
+ * Copyright 2006-2007 Secret Lab Technologies Ltd.
  * Grant Likely <grant.likely@secretlab.ca>
  *
  * This program is free software; you can redistribute  it and/or modify it
@@ -17,8 +17,9 @@
  */
 
 / {
-	model = "Lite5200b";
-	compatible = "lite5200b\0lite52xx\0mpc5200b\0mpc52xx";
+	model = "fsl,lite5200b";
+	// revision = "1.0";
+	compatible = "fsl,lite5200b\0fsl,lite5200\0generic-mpc5200";
 	#address-cells = <1>;
 	#size-cells = <1>;
 
@@ -47,14 +48,17 @@
 	};
 
 	soc5200@f0000000 {
+		model = "fsl,mpc5200b";
+		revision = "";			// from bootloader
 		#interrupt-cells = <3>;
 		device_type = "soc";
 		ranges = <0 f0000000 f0010000>;
 		reg = <f0000000 00010000>;
 		bus-frequency = <0>;		// from bootloader
+		system-frequency = <0>;		// from bootloader
 
 		cdm@200 {
-			compatible = "mpc5200b-cdm\0mpc52xx-cdm";
+			compatible = "mpc5200b-cdm\0mpc5200-cdm";
 			reg = <200 38>;
 		};
 
@@ -64,70 +68,79 @@
 			interrupt-controller;
 			#interrupt-cells = <3>;
 			device_type = "interrupt-controller";
-			compatible = "mpc5200b-pic\0mpc52xx-pic";
+			compatible = "mpc5200b-pic\0mpc5200-pic";
 			reg = <500 80>;
 			built-in;
 		};
 
 		gpt@600 {	// General Purpose Timer
-			compatible = "mpc5200b-gpt\0mpc52xx-gpt";
+			compatible = "mpc5200b-gpt\0mpc5200-gpt";
 			device_type = "gpt";
+			cell-index = <0>;
 			reg = <600 10>;
 			interrupts = <1 9 0>;
 			interrupt-parent = <500>;
+			has-wdt;
 		};
 
 		gpt@610 {	// General Purpose Timer
-			compatible = "mpc5200b-gpt\0mpc52xx-gpt";
+			compatible = "mpc5200b-gpt\0mpc5200-gpt";
 			device_type = "gpt";
+			cell-index = <1>;
 			reg = <610 10>;
 			interrupts = <1 a 0>;
 			interrupt-parent = <500>;
 		};
 
 		gpt@620 {	// General Purpose Timer
-			compatible = "mpc5200b-gpt\0mpc52xx-gpt";
+			compatible = "mpc5200b-gpt\0mpc5200-gpt";
 			device_type = "gpt";
+			cell-index = <2>;
 			reg = <620 10>;
 			interrupts = <1 b 0>;
 			interrupt-parent = <500>;
 		};
 
 		gpt@630 {	// General Purpose Timer
-			compatible = "mpc5200b-gpt\0mpc52xx-gpt";
+			compatible = "mpc5200b-gpt\0mpc5200-gpt";
 			device_type = "gpt";
+			cell-index = <3>;
 			reg = <630 10>;
 			interrupts = <1 c 0>;
 			interrupt-parent = <500>;
 		};
 
 		gpt@640 {	// General Purpose Timer
-			compatible = "mpc5200b-gpt\0mpc52xx-gpt";
+			compatible = "mpc5200b-gpt\0mpc5200-gpt";
 			device_type = "gpt";
+			cell-index = <4>;
 			reg = <640 10>;
 			interrupts = <1 d 0>;
 			interrupt-parent = <500>;
 		};
 
 		gpt@650 {	// General Purpose Timer
-			compatible = "mpc5200b-gpt\0mpc52xx-gpt";
+			compatible = "mpc5200b-gpt\0mpc5200-gpt";
 			device_type = "gpt";
+			cell-index = <5>;
 			reg = <650 10>;
 			interrupts = <1 e 0>;
 			interrupt-parent = <500>;
 		};
 
 		gpt@660 {	// General Purpose Timer
-			compatible = "mpc5200b-gpt\0mpc52xx-gpt";
+			compatible = "mpc5200b-gpt\0mpc5200-gpt";
 			device_type = "gpt";
+			cell-index = <6>;
 			reg = <660 10>;
 			interrupts = <1 f 0>;
 			interrupt-parent = <500>;
 		};
 
 		gpt@670 {	// General Purpose Timer
-			compatible = "mpc5200b-gpt\0mpc52xx-gpt";
+			compatible = "mpc5200b-gpt\0mpc5200-gpt";
 			device_type = "gpt";
+			cell-index = <7>;
 			reg = <670 10>;
 			interrupts = <1 10 0>;
 			interrupt-parent = <500>;
@@ -143,7 +156,8 @@
 
 		mscan@900 {
 			device_type = "mscan";
-			compatible = "mpc5200b-mscan\0mpc52xx-mscan";
+			compatible = "mpc5200b-mscan\0mpc5200-mscan";
+			cell-index = <0>;
 			interrupts = <2 11 0>;
 			interrupt-parent = <500>;
 			reg = <900 80>;
@@ -151,21 +165,22 @@
 
 		mscan@980 {
 			device_type = "mscan";
-			compatible = "mpc5200b-mscan\0mpc52xx-mscan";
+			compatible = "mpc5200b-mscan\0mpc5200-mscan";
+			cell-index = <1>;
 			interrupts = <1 12 0>;
 			interrupt-parent = <500>;
 			reg = <980 80>;
 		};
 
 		gpio@b00 {
-			compatible = "mpc5200b-gpio\0mpc52xx-gpio";
+			compatible = "mpc5200b-gpio\0mpc5200-gpio";
 			reg = <b00 40>;
 			interrupts = <1 7 0>;
 			interrupt-parent = <500>;
 		};
 
 		gpio-wkup@b00 {
-			compatible = "mpc5200b-gpio-wkup\0mpc52xx-gpio-wkup";
+			compatible = "mpc5200b-gpio-wkup\0mpc5200-gpio-wkup";
 			reg = <c00 40>;
 			interrupts = <1 8 0 0 3 0>;
 			interrupt-parent = <500>;
@@ -176,7 +191,7 @@
 			#size-cells = <2>;
 			#address-cells = <3>;
 			device_type = "pci";
-			compatible = "mpc5200b-pci\0mpc52xx-pci";
+			compatible = "mpc5200b-pci\0mpc5200-pci";
 			reg = <d00 100>;
 			interrupt-map-mask = <f800 0 0 7>;
 			interrupt-map = <c000 0 0 1 500 0 0 3 // 1st slot
@@ -199,7 +214,7 @@
 
 		spi@f00 {
 			device_type = "spi";
-			compatible = "mpc5200b-spi\0mpc52xx-spi";
+			compatible = "mpc5200b-spi\0mpc5200-spi";
 			reg = <f00 20>;
 			interrupts = <2 d 0 2 e 0>;
 			interrupt-parent = <500>;
@@ -207,7 +222,7 @@
 
 		usb@1000 {
 			device_type = "usb-ohci-be";
-			compatible = "mpc5200b-ohci\0mpc52xx-ohci\0ohci-be";
+			compatible = "mpc5200b-ohci\0mpc5200-ohci\0ohci-be";
 			reg = <1000 ff>;
 			interrupts = <2 6 0>;
 			interrupt-parent = <500>;
@@ -215,7 +230,7 @@
 
 		bestcomm@1200 {
 			device_type = "dma-controller";
-			compatible = "mpc5200b-bestcomm\0mpc52xx-bestcomm";
+			compatible = "mpc5200b-bestcomm\0mpc5200-bestcomm";
 			reg = <1200 80>;
 			interrupts = <3 0 0  3 1 0  3 2 0  3 3 0
 			              3 4 0  3 5 0  3 6 0  3 7 0
@@ -225,67 +240,73 @@
 		};
 
 		xlb@1f00 {
-			compatible = "mpc5200b-xlb\0mpc52xx-xlb";
+			compatible = "mpc5200b-xlb\0mpc5200-xlb";
 			reg = <1f00 100>;
 		};
 
 		serial@2000 {		// PSC1
 			device_type = "serial";
-			compatible = "mpc5200b-psc-uart\0mpc52xx-psc-uart";
+			compatible = "mpc5200b-psc-uart\0mpc5200-psc-uart";
 			port-number = <0>;  // Logical port assignment
+			cell-index = <0>;
 			reg = <2000 100>;
 			interrupts = <2 1 0>;
 			interrupt-parent = <500>;
 		};
 
-		// PSC2 in spi mode example
-		spi@2200 {		// PSC2
-			device_type = "spi";
-			compatible = "mpc5200b-psc-spi\0mpc52xx-psc-spi";
-			reg = <2200 100>;
-			interrupts = <2 2 0>;
-			interrupt-parent = <500>;
-		};
+		// PSC2 in ac97 mode example
+		//ac97@2200 {		// PSC2
+		//	device_type = "sound";
+		//	compatible = "mpc5200b-psc-ac97\0mpc5200-psc-ac97";
+		//	cell-index = <1>;
+		//	reg = <2200 100>;
+		//	interrupts = <2 2 0>;
+		//	interrupt-parent = <500>;
+		//};
 
 		// PSC3 in CODEC mode example
-		i2s@2400 {		// PSC3
-			device_type = "sound";
-			compatible = "mpc5200b-psc-i2s\0mpc52xx-psc-i2s";
-			reg = <2400 100>;
-			interrupts = <2 3 0>;
-			interrupt-parent = <500>;
-		};
+		//i2s@2400 {		// PSC3
+		//	device_type = "sound";
+		//	compatible = "mpc5200b-psc-i2s\0mpc5200-psc-i2s";
+		//	cell-index = <2>;
+		//	reg = <2400 100>;
+		//	interrupts = <2 3 0>;
+		//	interrupt-parent = <500>;
+		//};
 
-		// PSC4 unconfigured
+		// PSC4 in uart mode example
 		//serial@2600 {		// PSC4
 		//	device_type = "serial";
-		//	compatible = "mpc5200b-psc-uart\0mpc52xx-psc-uart";
+		//	compatible = "mpc5200b-psc-uart\0mpc5200-psc-uart";
+		//	cell-index = <3>;
 		//	reg = <2600 100>;
 		//	interrupts = <2 b 0>;
 		//	interrupt-parent = <500>;
 		//};
 
-		// PSC5 unconfigured
+		// PSC5 in uart mode example
 		//serial@2800 {		// PSC5
 		//	device_type = "serial";
-		//	compatible = "mpc5200b-psc-uart\0mpc52xx-psc-uart";
+		//	compatible = "mpc5200b-psc-uart\0mpc5200-psc-uart";
+		//	cell-index = <4>;
 		//	reg = <2800 100>;
 		//	interrupts = <2 c 0>;
 		//	interrupt-parent = <500>;
 		//};
 
-		// PSC6 in AC97 mode example
-		ac97@2c00 {		// PSC6
-			device_type = "sound";
-			compatible = "mpc5200b-psc-ac97\0mpc52xx-psc-ac97";
-			reg = <2c00 100>;
-			interrupts = <2 4 0>;
-			interrupt-parent = <500>;
-		};
+		// PSC6 in spi mode example
+		//spi@2c00 {		// PSC6
+		//	device_type = "spi";
+		//	compatible = "mpc5200b-psc-spi\0mpc5200-psc-spi";
+		//	cell-index = <5>;
+		//	reg = <2c00 100>;
+		//	interrupts = <2 4 0>;
+		//	interrupt-parent = <500>;
+		//};
 
 		ethernet@3000 {
 			device_type = "network";
-			compatible = "mpc5200b-fec\0mpc52xx-fec";
+			compatible = "mpc5200b-fec\0mpc5200-fec";
 			reg = <3000 800>;
 			mac-address = [ 02 03 04 05 06 07 ]; // Bad!
 			interrupts = <2 5 0>;
@@ -294,7 +315,7 @@
 
 		ata@3a00 {
 			device_type = "ata";
-			compatible = "mpc5200b-ata\0mpc52xx-ata";
+			compatible = "mpc5200b-ata\0mpc5200-ata";
 			reg = <3a00 100>;
 			interrupts = <2 7 0>;
 			interrupt-parent = <500>;
@@ -302,7 +323,8 @@
 
 		i2c@3d00 {
 			device_type = "i2c";
-			compatible = "mpc5200b-i2c\0mpc52xx-i2c";
+			compatible = "mpc5200b-i2c\0mpc5200-i2c";
+			cell-index = <0>;
 			reg = <3d00 40>;
 			interrupts = <2 f 0>;
 			interrupt-parent = <500>;
@@ -310,7 +332,8 @@
 
 		i2c@3d40 {
 			device_type = "i2c";
-			compatible = "mpc5200b-i2c\0mpc52xx-i2c";
+			compatible = "mpc5200b-i2c\0mpc5200-i2c";
+			cell-index = <1>;
 			reg = <3d40 40>;
 			interrupts = <2 10 0>;
 			interrupt-parent = <500>;
-- 
1.4.3.rc2.g0503
