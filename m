Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C723CDDF5D
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jul 2008 23:21:01 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id m68DKuY9024067
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Jul 2008 08:20:57 -0500
Date: Tue, 8 Jul 2008 08:20:56 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [RFC][WIP][PATCH] powerpc: Refactor device bindings
Message-ID: <Pine.LNX.4.64.0807080818440.5899@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Moved Freescale SoC related bindings out of booting-without-of.txt and into
their own files.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---

I'm posting this to get any initial feedback on the splitting up of the
device bindings for Freescale SoCs.  I still need to finish off the cpm/qe
bits.  I also removed the crypto/SEC node as Kim has a new binding in the
works.

I also DO NOT plan on trying to tackle 5xxx as part of the initial effort.

- k

 Documentation/powerpc/booting-without-of.txt       | 1218 +-------------------
 Documentation/powerpc/dts-bindings/fsl/board.txt   |   29 +
 .../powerpc/dts-bindings/fsl/cpm_qe/cpm.txt        |  196 ++++
 .../powerpc/dts-bindings/fsl/cpm_qe/cpm/i2c.txt    |   41 +
 .../powerpc/dts-bindings/fsl/cpm_qe/qe.txt         |  171 +++
 .../powerpc/dts-bindings/fsl/cpm_qe/qe/par_io.txt  |   51 +
 .../powerpc/dts-bindings/fsl/cpm_qe/qe/ucc.txt     |   70 ++
 .../powerpc/dts-bindings/fsl/cpm_qe/qe/usb.txt     |   22 +
 Documentation/powerpc/dts-bindings/fsl/diu.txt     |   18 +
 Documentation/powerpc/dts-bindings/fsl/dma.txt     |  127 ++
 Documentation/powerpc/dts-bindings/fsl/gtm.txt     |   31 +
 Documentation/powerpc/dts-bindings/fsl/guts.txt    |   25 +
 Documentation/powerpc/dts-bindings/fsl/i2c.txt     |   32 +
 Documentation/powerpc/dts-bindings/fsl/lbc.txt     |   35 +
 Documentation/powerpc/dts-bindings/fsl/msi-pic.txt |   36 +
 Documentation/powerpc/dts-bindings/fsl/sata.txt    |   29 +
 Documentation/powerpc/dts-bindings/fsl/ssi.txt     |   38 +
 Documentation/powerpc/dts-bindings/fsl/tsec.txt    |   69 ++
 Documentation/powerpc/dts-bindings/fsl/usb.txt     |   59 +
 19 files changed, 1091 insertions(+), 1206 deletions(-)
 create mode 100644 Documentation/powerpc/dts-bindings/fsl/board.txt
 create mode 100644 Documentation/powerpc/dts-bindings/fsl/cpm_qe/cpm.txt
 create mode 100644 Documentation/powerpc/dts-bindings/fsl/cpm_qe/cpm/i2c.txt
 create mode 100644 Documentation/powerpc/dts-bindings/fsl/cpm_qe/qe.txt
 create mode 100644 Documentation/powerpc/dts-bindings/fsl/cpm_qe/qe/par_io.txt
 create mode 100644 Documentation/powerpc/dts-bindings/fsl/cpm_qe/qe/ucc.txt
 create mode 100644 Documentation/powerpc/dts-bindings/fsl/cpm_qe/qe/usb.txt
 create mode 100644 Documentation/powerpc/dts-bindings/fsl/diu.txt
 create mode 100644 Documentation/powerpc/dts-bindings/fsl/dma.txt
 create mode 100644 Documentation/powerpc/dts-bindings/fsl/gtm.txt
 create mode 100644 Documentation/powerpc/dts-bindings/fsl/guts.txt
 create mode 100644 Documentation/powerpc/dts-bindings/fsl/i2c.txt
 create mode 100644 Documentation/powerpc/dts-bindings/fsl/lbc.txt
 create mode 100644 Documentation/powerpc/dts-bindings/fsl/msi-pic.txt
 create mode 100644 Documentation/powerpc/dts-bindings/fsl/sata.txt
 create mode 100644 Documentation/powerpc/dts-bindings/fsl/ssi.txt
 create mode 100644 Documentation/powerpc/dts-bindings/fsl/tsec.txt
 create mode 100644 Documentation/powerpc/dts-bindings/fsl/usb.txt

diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
index f6394b5..de2e5c0 100644
--- a/Documentation/powerpc/booting-without-of.txt
+++ b/Documentation/powerpc/booting-without-of.txt
@@ -41,27 +41,12 @@ Table of Contents
   VI - System-on-a-chip devices and nodes
     1) Defining child nodes of an SOC
     2) Representing devices without a current OF specification
-      a) MDIO IO device
-      b) Gianfar-compatible ethernet nodes
-      c) PHY nodes
-      d) Interrupt controllers
-      e) I2C
-      f) Freescale SOC USB controllers
-      g) Freescale SOC SEC Security Engines
-      h) Board Control and Status (BCSR)
-      i) Freescale QUICC Engine module (QE)
-      j) CFI or JEDEC memory-mapped NOR flash
-      k) Global Utilities Block
-      l) Freescale Communications Processor Module
-      m) Chipselect/Local Bus
-      n) 4xx/Axon EMAC ethernet nodes
-      o) Xilinx IP cores
-      p) Freescale Synchronous Serial Interface
-      q) USB EHCI controllers
-      r) Freescale Display Interface Unit
-      s) Freescale on board FPGA
-      t) Freescael MSI interrupt controller
-      u) Freescale General-purpose Timers Module
+      a) PHY nodes
+      b) Interrupt controllers
+      c) CFI or JEDEC memory-mapped NOR flash
+      d) 4xx/Axon EMAC ethernet nodes
+      e) Xilinx IP cores
+      f) USB EHCI controllers

   VII - Marvell Discovery mv64[345]6x System Controller chips
     1) The /system-controller node
@@ -1250,80 +1235,7 @@ descriptions for the SOC devices for which new nodes have been
 defined; this list will expand as more and more SOC-containing
 platforms are moved over to use the flattened-device-tree model.

-  a) MDIO IO device
-
-  The MDIO is a bus to which the PHY devices are connected.  For each
-  device that exists on this bus, a child node should be created.  See
-  the definition of the PHY node below for an example of how to define
-  a PHY.
-
-  Required properties:
-    - reg : Offset and length of the register set for the device
-    - compatible : Should define the compatible device type for the
-      mdio.  Currently, this is most likely to be "fsl,gianfar-mdio"
-
-  Example:
-
-	mdio@24520 {
-		reg = <24520 20>;
-		compatible = "fsl,gianfar-mdio";
-
-		ethernet-phy@0 {
-			......
-		};
-	};
-
-
-  b) Gianfar-compatible ethernet nodes
-
-  Required properties:
-
-    - device_type : Should be "network"
-    - model : Model of the device.  Can be "TSEC", "eTSEC", or "FEC"
-    - compatible : Should be "gianfar"
-    - reg : Offset and length of the register set for the device
-    - mac-address : List of bytes representing the ethernet address of
-      this controller
-    - interrupts : <a b> where a is the interrupt number and b is a
-      field that represents an encoding of the sense and level
-      information for the interrupt.  This should be encoded based on
-      the information in section 2) depending on the type of interrupt
-      controller you have.
-    - interrupt-parent : the phandle for the interrupt controller that
-      services interrupts for this device.
-    - phy-handle : The phandle for the PHY connected to this ethernet
-      controller.
-    - fixed-link : <a b c d e> where a is emulated phy id - choose any,
-      but unique to the all specified fixed-links, b is duplex - 0 half,
-      1 full, c is link speed - d#10/d#100/d#1000, d is pause - 0 no
-      pause, 1 pause, e is asym_pause - 0 no asym_pause, 1 asym_pause.
-
-  Recommended properties:
-
-    - phy-connection-type : a string naming the controller/PHY interface type,
-      i.e., "mii" (default), "rmii", "gmii", "rgmii", "rgmii-id", "sgmii",
-      "tbi", or "rtbi".  This property is only really needed if the connection
-      is of type "rgmii-id", as all other connection types are detected by
-      hardware.
-
-
-  Example:
-
-	ethernet@24000 {
-		#size-cells = <0>;
-		device_type = "network";
-		model = "TSEC";
-		compatible = "gianfar";
-		reg = <24000 1000>;
-		mac-address = [ 00 E0 0C 00 73 00 ];
-		interrupts = <d 3 e 3 12 3>;
-		interrupt-parent = <40000>;
-		phy-handle = <2452000>
-	};
-
-
-
-   c) PHY nodes
+   a) PHY nodes

    Required properties:

@@ -1351,7 +1263,7 @@ platforms are moved over to use the flattened-device-tree model.
 	};


-   d) Interrupt controllers
+   b) Interrupt controllers

    Some SOC devices contain interrupt controllers that are different
    from the standard Open PIC specification.  The SOC device nodes for
@@ -1371,508 +1283,7 @@ platforms are moved over to use the flattened-device-tree model.
 		device_type = "open-pic";
 	};

-
-   e) I2C
-
-   Required properties :
-
-    - device_type : Should be "i2c"
-    - reg : Offset and length of the register set for the device
-
-   Recommended properties :
-
-    - compatible : Should be "fsl-i2c" for parts compatible with
-      Freescale I2C specifications.
-    - interrupts : <a b> where a is the interrupt number and b is a
-      field that represents an encoding of the sense and level
-      information for the interrupt.  This should be encoded based on
-      the information in section 2) depending on the type of interrupt
-      controller you have.
-    - interrupt-parent : the phandle for the interrupt controller that
-      services interrupts for this device.
-    - dfsrr : boolean; if defined, indicates that this I2C device has
-      a digital filter sampling rate register
-    - fsl5200-clocking : boolean; if defined, indicated that this device
-      uses the FSL 5200 clocking mechanism.
-
-   Example :
-
-	i2c@3000 {
-		interrupt-parent = <40000>;
-		interrupts = <1b 3>;
-		reg = <3000 18>;
-		device_type = "i2c";
-		compatible  = "fsl-i2c";
-		dfsrr;
-	};
-
-
-   f) Freescale SOC USB controllers
-
-   The device node for a USB controller that is part of a Freescale
-   SOC is as described in the document "Open Firmware Recommended
-   Practice : Universal Serial Bus" with the following modifications
-   and additions :
-
-   Required properties :
-    - compatible : Should be "fsl-usb2-mph" for multi port host USB
-      controllers, or "fsl-usb2-dr" for dual role USB controllers
-    - phy_type : For multi port host USB controllers, should be one of
-      "ulpi", or "serial". For dual role USB controllers, should be
-      one of "ulpi", "utmi", "utmi_wide", or "serial".
-    - reg : Offset and length of the register set for the device
-    - port0 : boolean; if defined, indicates port0 is connected for
-      fsl-usb2-mph compatible controllers.  Either this property or
-      "port1" (or both) must be defined for "fsl-usb2-mph" compatible
-      controllers.
-    - port1 : boolean; if defined, indicates port1 is connected for
-      fsl-usb2-mph compatible controllers.  Either this property or
-      "port0" (or both) must be defined for "fsl-usb2-mph" compatible
-      controllers.
-    - dr_mode : indicates the working mode for "fsl-usb2-dr" compatible
-      controllers.  Can be "host", "peripheral", or "otg".  Default to
-      "host" if not defined for backward compatibility.
-
-   Recommended properties :
-    - interrupts : <a b> where a is the interrupt number and b is a
-      field that represents an encoding of the sense and level
-      information for the interrupt.  This should be encoded based on
-      the information in section 2) depending on the type of interrupt
-      controller you have.
-    - interrupt-parent : the phandle for the interrupt controller that
-      services interrupts for this device.
-
-   Example multi port host USB controller device node :
-	usb@22000 {
-		compatible = "fsl-usb2-mph";
-		reg = <22000 1000>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		interrupt-parent = <700>;
-		interrupts = <27 1>;
-		phy_type = "ulpi";
-		port0;
-		port1;
-	};
-
-   Example dual role USB controller device node :
-	usb@23000 {
-		compatible = "fsl-usb2-dr";
-		reg = <23000 1000>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		interrupt-parent = <700>;
-		interrupts = <26 1>;
-		dr_mode = "otg";
-		phy = "ulpi";
-	};
-
-
-   g) Freescale SOC SEC Security Engines
-
-   Required properties:
-
-    - device_type : Should be "crypto"
-    - model : Model of the device.  Should be "SEC1" or "SEC2"
-    - compatible : Should be "talitos"
-    - reg : Offset and length of the register set for the device
-    - interrupts : <a b> where a is the interrupt number and b is a
-      field that represents an encoding of the sense and level
-      information for the interrupt.  This should be encoded based on
-      the information in section 2) depending on the type of interrupt
-      controller you have.
-    - interrupt-parent : the phandle for the interrupt controller that
-      services interrupts for this device.
-    - num-channels : An integer representing the number of channels
-      available.
-    - channel-fifo-len : An integer representing the number of
-      descriptor pointers each channel fetch fifo can hold.
-    - exec-units-mask : The bitmask representing what execution units
-      (EUs) are available. It's a single 32-bit cell. EU information
-      should be encoded following the SEC's Descriptor Header Dword
-      EU_SEL0 field documentation, i.e. as follows:
-
-        bit 0 = reserved - should be 0
-        bit 1 = set if SEC has the ARC4 EU (AFEU)
-        bit 2 = set if SEC has the DES/3DES EU (DEU)
-        bit 3 = set if SEC has the message digest EU (MDEU)
-        bit 4 = set if SEC has the random number generator EU (RNG)
-        bit 5 = set if SEC has the public key EU (PKEU)
-        bit 6 = set if SEC has the AES EU (AESU)
-        bit 7 = set if SEC has the Kasumi EU (KEU)
-
-      bits 8 through 31 are reserved for future SEC EUs.
-
-    - descriptor-types-mask : The bitmask representing what descriptors
-      are available. It's a single 32-bit cell. Descriptor type
-      information should be encoded following the SEC's Descriptor
-      Header Dword DESC_TYPE field documentation, i.e. as follows:
-
-        bit 0  = set if SEC supports the aesu_ctr_nonsnoop desc. type
-        bit 1  = set if SEC supports the ipsec_esp descriptor type
-        bit 2  = set if SEC supports the common_nonsnoop desc. type
-        bit 3  = set if SEC supports the 802.11i AES ccmp desc. type
-        bit 4  = set if SEC supports the hmac_snoop_no_afeu desc. type
-        bit 5  = set if SEC supports the srtp descriptor type
-        bit 6  = set if SEC supports the non_hmac_snoop_no_afeu desc.type
-        bit 7  = set if SEC supports the pkeu_assemble descriptor type
-        bit 8  = set if SEC supports the aesu_key_expand_output desc.type
-        bit 9  = set if SEC supports the pkeu_ptmul descriptor type
-        bit 10 = set if SEC supports the common_nonsnoop_afeu desc. type
-        bit 11 = set if SEC supports the pkeu_ptadd_dbl descriptor type
-
-      ..and so on and so forth.
-
-   Example:
-
-       /* MPC8548E */
-       crypto@30000 {
-               device_type = "crypto";
-               model = "SEC2";
-               compatible = "talitos";
-               reg = <30000 10000>;
-               interrupts = <1d 3>;
-               interrupt-parent = <40000>;
-               num-channels = <4>;
-               channel-fifo-len = <18>;
-               exec-units-mask = <000000fe>;
-               descriptor-types-mask = <012b0ebf>;
-       };
-
-   h) Board Control and Status (BCSR)
-
-   Required properties:
-
-    - device_type : Should be "board-control"
-    - reg : Offset and length of the register set for the device
-
-    Example:
-
-	bcsr@f8000000 {
-		device_type = "board-control";
-		reg = <f8000000 8000>;
-	};
-
-   i) Freescale QUICC Engine module (QE)
-   This represents qe module that is installed on PowerQUICC II Pro.
-
-   NOTE:  This is an interim binding; it should be updated to fit
-   in with the CPM binding later in this document.
-
-   Basically, it is a bus of devices, that could act more or less
-   as a complete entity (UCC, USB etc ). All of them should be siblings on
-   the "root" qe node, using the common properties from there.
-   The description below applies to the qe of MPC8360 and
-   more nodes and properties would be extended in the future.
-
-   i) Root QE device
-
-   Required properties:
-   - compatible : should be "fsl,qe";
-   - model : precise model of the QE, Can be "QE", "CPM", or "CPM2"
-   - reg : offset and length of the device registers.
-   - bus-frequency : the clock frequency for QUICC Engine.
-
-   Recommended properties
-   - brg-frequency : the internal clock source frequency for baud-rate
-     generators in Hz.
-
-   Example:
-	qe@e0100000 {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		#interrupt-cells = <2>;
-		compatible = "fsl,qe";
-		ranges = <0 e0100000 00100000>;
-		reg = <e0100000 480>;
-		brg-frequency = <0>;
-		bus-frequency = <179A7B00>;
-	}
-
-
-   ii) SPI (Serial Peripheral Interface)
-
-   Required properties:
-   - cell-index : SPI controller index.
-   - compatible : should be "fsl,spi".
-   - mode : the SPI operation mode, it can be "cpu" or "cpu-qe".
-   - reg : Offset and length of the register set for the device
-   - interrupts : <a b> where a is the interrupt number and b is a
-     field that represents an encoding of the sense and level
-     information for the interrupt.  This should be encoded based on
-     the information in section 2) depending on the type of interrupt
-     controller you have.
-   - interrupt-parent : the phandle for the interrupt controller that
-     services interrupts for this device.
-
-   Example:
-	spi@4c0 {
-		cell-index = <0>;
-		compatible = "fsl,spi";
-		reg = <4c0 40>;
-		interrupts = <82 0>;
-		interrupt-parent = <700>;
-		mode = "cpu";
-	};
-
-
-   iii) USB (Universal Serial Bus Controller)
-
-   Required properties:
-   - compatible : could be "qe_udc" or "fhci-hcd".
-   - mode : the could be "host" or "slave".
-   - reg : Offset and length of the register set for the device
-   - interrupts : <a b> where a is the interrupt number and b is a
-     field that represents an encoding of the sense and level
-     information for the interrupt.  This should be encoded based on
-     the information in section 2) depending on the type of interrupt
-     controller you have.
-   - interrupt-parent : the phandle for the interrupt controller that
-     services interrupts for this device.
-
-   Example(slave):
-	usb@6c0 {
-		compatible = "qe_udc";
-		reg = <6c0 40>;
-		interrupts = <8b 0>;
-		interrupt-parent = <700>;
-		mode = "slave";
-	};
-
-
-   iv) UCC (Unified Communications Controllers)
-
-   Required properties:
-   - device_type : should be "network", "hldc", "uart", "transparent"
-     "bisync", "atm", or "serial".
-   - compatible : could be "ucc_geth" or "fsl_atm" and so on.
-   - cell-index : the ucc number(1-8), corresponding to UCCx in UM.
-   - reg : Offset and length of the register set for the device
-   - interrupts : <a b> where a is the interrupt number and b is a
-     field that represents an encoding of the sense and level
-     information for the interrupt.  This should be encoded based on
-     the information in section 2) depending on the type of interrupt
-     controller you have.
-   - interrupt-parent : the phandle for the interrupt controller that
-     services interrupts for this device.
-   - pio-handle : The phandle for the Parallel I/O port configuration.
-   - port-number : for UART drivers, the port number to use, between 0 and 3.
-     This usually corresponds to the /dev/ttyQE device, e.g. <0> = /dev/ttyQE0.
-     The port number is added to the minor number of the device.  Unlike the
-     CPM UART driver, the port-number is required for the QE UART driver.
-   - soft-uart : for UART drivers, if specified this means the QE UART device
-     driver should use "Soft-UART" mode, which is needed on some SOCs that have
-     broken UART hardware.  Soft-UART is provided via a microcode upload.
-   - rx-clock-name: the UCC receive clock source
-     "none": clock source is disabled
-     "brg1" through "brg16": clock source is BRG1-BRG16, respectively
-     "clk1" through "clk24": clock source is CLK1-CLK24, respectively
-   - tx-clock-name: the UCC transmit clock source
-     "none": clock source is disabled
-     "brg1" through "brg16": clock source is BRG1-BRG16, respectively
-     "clk1" through "clk24": clock source is CLK1-CLK24, respectively
-   The following two properties are deprecated.  rx-clock has been replaced
-   with rx-clock-name, and tx-clock has been replaced with tx-clock-name.
-   Drivers that currently use the deprecated properties should continue to
-   do so, in order to support older device trees, but they should be updated
-   to check for the new properties first.
-   - rx-clock : represents the UCC receive clock source.
-     0x00 : clock source is disabled;
-     0x1~0x10 : clock source is BRG1~BRG16 respectively;
-     0x11~0x28: clock source is QE_CLK1~QE_CLK24 respectively.
-   - tx-clock: represents the UCC transmit clock source;
-     0x00 : clock source is disabled;
-     0x1~0x10 : clock source is BRG1~BRG16 respectively;
-     0x11~0x28: clock source is QE_CLK1~QE_CLK24 respectively.
-
-   Required properties for network device_type:
-   - mac-address : list of bytes representing the ethernet address.
-   - phy-handle : The phandle for the PHY connected to this controller.
-
-   Recommended properties:
-   - phy-connection-type : a string naming the controller/PHY interface type,
-     i.e., "mii" (default), "rmii", "gmii", "rgmii", "rgmii-id" (Internal
-     Delay), "rgmii-txid" (delay on TX only), "rgmii-rxid" (delay on RX only),
-     "tbi", or "rtbi".
-
-   Example:
-	ucc@2000 {
-		device_type = "network";
-		compatible = "ucc_geth";
-		cell-index = <1>;
-		reg = <2000 200>;
-		interrupts = <a0 0>;
-		interrupt-parent = <700>;
-		mac-address = [ 00 04 9f 00 23 23 ];
-		rx-clock = "none";
-		tx-clock = "clk9";
-		phy-handle = <212000>;
-		phy-connection-type = "gmii";
-		pio-handle = <140001>;
-	};
-
-
-   v) Parallel I/O Ports
-
-   This node configures Parallel I/O ports for CPUs with QE support.
-   The node should reside in the "soc" node of the tree.  For each
-   device that using parallel I/O ports, a child node should be created.
-   See the definition of the Pin configuration nodes below for more
-   information.
-
-   Required properties:
-   - device_type : should be "par_io".
-   - reg : offset to the register set and its length.
-   - num-ports : number of Parallel I/O ports
-
-   Example:
-	par_io@1400 {
-		reg = <1400 100>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		device_type = "par_io";
-		num-ports = <7>;
-		ucc_pin@01 {
-			......
-		};
-
-   Note that "par_io" nodes are obsolete, and should not be used for
-   the new device trees. Instead, each Par I/O bank should be represented
-   via its own gpio-controller node:
-
-   Required properties:
-   - #gpio-cells : should be "2".
-   - compatible : should be "fsl,<chip>-qe-pario-bank",
-     "fsl,mpc8323-qe-pario-bank".
-   - reg : offset to the register set and its length.
-   - gpio-controller : node to identify gpio controllers.
-
-   Example:
-	qe_pio_a: gpio-controller@1400 {
-		#gpio-cells = <2>;
-		compatible = "fsl,mpc8360-qe-pario-bank",
-			     "fsl,mpc8323-qe-pario-bank";
-		reg = <0x1400 0x18>;
-		gpio-controller;
-	};
-
-	qe_pio_e: gpio-controller@1460 {
-		#gpio-cells = <2>;
-		compatible = "fsl,mpc8360-qe-pario-bank",
-			     "fsl,mpc8323-qe-pario-bank";
-		reg = <0x1460 0x18>;
-		gpio-controller;
-	};
-
-   vi) Pin configuration nodes
-
-   Required properties:
-   - linux,phandle : phandle of this node; likely referenced by a QE
-     device.
-   - pio-map : array of pin configurations.  Each pin is defined by 6
-     integers.  The six numbers are respectively: port, pin, dir,
-     open_drain, assignment, has_irq.
-     - port : port number of the pin; 0-6 represent port A-G in UM.
-     - pin : pin number in the port.
-     - dir : direction of the pin, should encode as follows:
-
-	0 = The pin is disabled
-	1 = The pin is an output
-	2 = The pin is an input
-	3 = The pin is I/O
-
-     - open_drain : indicates the pin is normal or wired-OR:
-
-	0 = The pin is actively driven as an output
-	1 = The pin is an open-drain driver. As an output, the pin is
-	    driven active-low, otherwise it is three-stated.
-
-     - assignment : function number of the pin according to the Pin Assignment
-       tables in User Manual.  Each pin can have up to 4 possible functions in
-       QE and two options for CPM.
-     - has_irq : indicates if the pin is used as source of external
-       interrupts.
-
-   Example:
-	ucc_pin@01 {
-		linux,phandle = <140001>;
-		pio-map = <
-		/* port  pin  dir  open_drain  assignment  has_irq */
-			0  3  1  0  1  0 	/* TxD0 */
-			0  4  1  0  1  0 	/* TxD1 */
-			0  5  1  0  1  0 	/* TxD2 */
-			0  6  1  0  1  0 	/* TxD3 */
-			1  6  1  0  3  0 	/* TxD4 */
-			1  7  1  0  1  0 	/* TxD5 */
-			1  9  1  0  2  0 	/* TxD6 */
-			1  a  1  0  2  0 	/* TxD7 */
-			0  9  2  0  1  0 	/* RxD0 */
-			0  a  2  0  1  0 	/* RxD1 */
-			0  b  2  0  1  0 	/* RxD2 */
-			0  c  2  0  1  0 	/* RxD3 */
-			0  d  2  0  1  0 	/* RxD4 */
-			1  1  2  0  2  0 	/* RxD5 */
-			1  0  2  0  2  0 	/* RxD6 */
-			1  4  2  0  2  0 	/* RxD7 */
-			0  7  1  0  1  0 	/* TX_EN */
-			0  8  1  0  1  0 	/* TX_ER */
-			0  f  2  0  1  0 	/* RX_DV */
-			0  10 2  0  1  0 	/* RX_ER */
-			0  0  2  0  1  0 	/* RX_CLK */
-			2  9  1  0  3  0 	/* GTX_CLK - CLK10 */
-			2  8  2  0  1  0>;	/* GTX125 - CLK9 */
-	};
-
-   vii) Multi-User RAM (MURAM)
-
-   Required properties:
-   - compatible : should be "fsl,qe-muram", "fsl,cpm-muram".
-   - mode : the could be "host" or "slave".
-   - ranges : Should be defined as specified in 1) to describe the
-      translation of MURAM addresses.
-   - data-only : sub-node which defines the address area under MURAM
-      bus that can be allocated as data/parameter
-
-   Example:
-
-	muram@10000 {
-		compatible = "fsl,qe-muram", "fsl,cpm-muram";
-		ranges = <0 00010000 0000c000>;
-
-		data-only@0{
-			compatible = "fsl,qe-muram-data",
-				     "fsl,cpm-muram-data";
-			reg = <0 c000>;
-		};
-	};
-
-   viii) Uploaded QE firmware
-
-	 If a new firwmare has been uploaded to the QE (usually by the
-	 boot loader), then a 'firmware' child node should be added to the QE
-	 node.  This node provides information on the uploaded firmware that
-	 device drivers may need.
-
-	 Required properties:
-	 - id: The string name of the firmware.  This is taken from the 'id'
-	       member of the qe_firmware structure of the uploaded firmware.
-	       Device drivers can search this string to determine if the
-	       firmware they want is already present.
-	 - extended-modes: The Extended Modes bitfield, taken from the
-			   firmware binary.  It is a 64-bit number represented
-			   as an array of two 32-bit numbers.
-	 - virtual-traps: The virtual traps, taken from the firmware binary.
-			  It is an array of 8 32-bit numbers.
-
-	 Example:
-
-		firmware {
-			id = "Soft-UART";
-			extended-modes = <0 0>;
-			virtual-traps = <0 0 0 0 0 0 0 0>;
-		}
-
-   j) CFI or JEDEC memory-mapped NOR flash
+   c) CFI or JEDEC memory-mapped NOR flash

     Flash chips (Memory Technology Devices) are often used for solid state
     file systems on embedded devices.
@@ -1936,310 +1347,7 @@ platforms are moved over to use the flattened-device-tree model.
 		};
 	};

-   k) Global Utilities Block
-
-   The global utilities block controls power management, I/O device
-   enabling, power-on-reset configuration monitoring, general-purpose
-   I/O signal configuration, alternate function selection for multiplexed
-   signals, and clock control.
-
-   Required properties:
-
-    - compatible : Should define the compatible device type for
-      global-utilities.
-    - reg : Offset and length of the register set for the device.
-
-  Recommended properties:
-
-    - fsl,has-rstcr : Indicates that the global utilities register set
-      contains a functioning "reset control register" (i.e. the board
-      is wired to reset upon setting the HRESET_REQ bit in this register).
-
-    Example:
-
-	global-utilities@e0000 {	/* global utilities block */
-		compatible = "fsl,mpc8548-guts";
-		reg = <e0000 1000>;
-		fsl,has-rstcr;
-	};
-
-   l) Freescale Communications Processor Module
-
-   NOTE: This is an interim binding, and will likely change slightly,
-   as more devices are supported.  The QE bindings especially are
-   incomplete.
-
-   i) Root CPM node
-
-   Properties:
-   - compatible : "fsl,cpm1", "fsl,cpm2", or "fsl,qe".
-   - reg : A 48-byte region beginning with CPCR.
-
-   Example:
-	cpm@119c0 {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		#interrupt-cells = <2>;
-		compatible = "fsl,mpc8272-cpm", "fsl,cpm2";
-		reg = <119c0 30>;
-	}
-
-   ii) Properties common to mulitple CPM/QE devices
-
-   - fsl,cpm-command : This value is ORed with the opcode and command flag
-                       to specify the device on which a CPM command operates.
-
-   - fsl,cpm-brg : Indicates which baud rate generator the device
-                   is associated with.  If absent, an unused BRG
-                   should be dynamically allocated.  If zero, the
-                   device uses an external clock rather than a BRG.
-
-   - reg : Unless otherwise specified, the first resource represents the
-           scc/fcc/ucc registers, and the second represents the device's
-           parameter RAM region (if it has one).
-
-   iii) Serial
-
-   Currently defined compatibles:
-   - fsl,cpm1-smc-uart
-   - fsl,cpm2-smc-uart
-   - fsl,cpm1-scc-uart
-   - fsl,cpm2-scc-uart
-   - fsl,qe-uart
-
-   Example:
-
-	serial@11a00 {
-		device_type = "serial";
-		compatible = "fsl,mpc8272-scc-uart",
-		             "fsl,cpm2-scc-uart";
-		reg = <11a00 20 8000 100>;
-		interrupts = <28 8>;
-		interrupt-parent = <&PIC>;
-		fsl,cpm-brg = <1>;
-		fsl,cpm-command = <00800000>;
-	};
-
-   iii) Network
-
-   Currently defined compatibles:
-   - fsl,cpm1-scc-enet
-   - fsl,cpm2-scc-enet
-   - fsl,cpm1-fec-enet
-   - fsl,cpm2-fcc-enet (third resource is GFEMR)
-   - fsl,qe-enet
-
-   Example:
-
-	ethernet@11300 {
-		device_type = "network";
-		compatible = "fsl,mpc8272-fcc-enet",
-		             "fsl,cpm2-fcc-enet";
-		reg = <11300 20 8400 100 11390 1>;
-		local-mac-address = [ 00 00 00 00 00 00 ];
-		interrupts = <20 8>;
-		interrupt-parent = <&PIC>;
-		phy-handle = <&PHY0>;
-		fsl,cpm-command = <12000300>;
-	};
-
-   iv) MDIO
-
-   Currently defined compatibles:
-   fsl,pq1-fec-mdio (reg is same as first resource of FEC device)
-   fsl,cpm2-mdio-bitbang (reg is port C registers)
-
-   Properties for fsl,cpm2-mdio-bitbang:
-   fsl,mdio-pin : pin of port C controlling mdio data
-   fsl,mdc-pin : pin of port C controlling mdio clock
-
-   Example:
-
-	mdio@10d40 {
-		device_type = "mdio";
-		compatible = "fsl,mpc8272ads-mdio-bitbang",
-		             "fsl,mpc8272-mdio-bitbang",
-		             "fsl,cpm2-mdio-bitbang";
-		reg = <10d40 14>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		fsl,mdio-pin = <12>;
-		fsl,mdc-pin = <13>;
-	};
-
-   v) Baud Rate Generators
-
-   Currently defined compatibles:
-   fsl,cpm-brg
-   fsl,cpm1-brg
-   fsl,cpm2-brg
-
-   Properties:
-   - reg : There may be an arbitrary number of reg resources; BRG
-     numbers are assigned to these in order.
-   - clock-frequency : Specifies the base frequency driving
-     the BRG.
-
-   Example:
-
-	brg@119f0 {
-		compatible = "fsl,mpc8272-brg",
-		             "fsl,cpm2-brg",
-		             "fsl,cpm-brg";
-		reg = <119f0 10 115f0 10>;
-		clock-frequency = <d#25000000>;
-	};
-
-   vi) Interrupt Controllers
-
-   Currently defined compatibles:
-   - fsl,cpm1-pic
-     - only one interrupt cell
-   - fsl,pq1-pic
-   - fsl,cpm2-pic
-     - second interrupt cell is level/sense:
-       - 2 is falling edge
-       - 8 is active low
-
-   Example:
-
-	interrupt-controller@10c00 {
-		#interrupt-cells = <2>;
-		interrupt-controller;
-		reg = <10c00 80>;
-		compatible = "mpc8272-pic", "fsl,cpm2-pic";
-	};
-
-   vii) USB (Universal Serial Bus Controller)
-
-   Properties:
-   - compatible : "fsl,cpm1-usb", "fsl,cpm2-usb", "fsl,qe-usb"
-
-   Example:
-	usb@11bc0 {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		compatible = "fsl,cpm2-usb";
-		reg = <11b60 18 8b00 100>;
-		interrupts = <b 8>;
-		interrupt-parent = <&PIC>;
-		fsl,cpm-command = <2e600000>;
-	};
-
-   viii) Multi-User RAM (MURAM)
-
-   The multi-user/dual-ported RAM is expressed as a bus under the CPM node.
-
-   Ranges must be set up subject to the following restrictions:
-
-   - Children's reg nodes must be offsets from the start of all muram, even
-     if the user-data area does not begin at zero.
-   - If multiple range entries are used, the difference between the parent
-     address and the child address must be the same in all, so that a single
-     mapping can cover them all while maintaining the ability to determine
-     CPM-side offsets with pointer subtraction.  It is recommended that
-     multiple range entries not be used.
-   - A child address of zero must be translatable, even if no reg resources
-     contain it.
-
-   A child "data" node must exist, compatible with "fsl,cpm-muram-data", to
-   indicate the portion of muram that is usable by the OS for arbitrary
-   purposes.  The data node may have an arbitrary number of reg resources,
-   all of which contribute to the allocatable muram pool.
-
-   Example, based on mpc8272:
-
-	muram@0 {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges = <0 0 10000>;
-
-		data@0 {
-			compatible = "fsl,cpm-muram-data";
-			reg = <0 2000 9800 800>;
-		};
-	};
-
-   x) I2C
-
-   The I2C controller is expressed as a bus under the CPM node.
-
-   Properties:
-   - compatible : "fsl,cpm1-i2c", "fsl,cpm2-i2c"
-   - reg : On CPM2 devices, the second resource doesn't specify the I2C
-     Parameter RAM itself, but the I2C_BASE field of the CPM2 Parameter RAM
-     (typically 0x8afc 0x2).
-   - #address-cells : Should be one. The cell is the i2c device address with
-     the r/w bit set to zero.
-   - #size-cells : Should be zero.
-   - clock-frequency : Can be used to set the i2c clock frequency. If
-     unspecified, a default frequency of 60kHz is being used.
-   The following two properties are deprecated. They are only used by legacy
-   i2c drivers to find the bus to probe:
-   - linux,i2c-index : Can be used to hard code an i2c bus number. By default,
-     the bus number is dynamically assigned by the i2c core.
-   - linux,i2c-class : Can be used to override the i2c class. The class is used
-     by legacy i2c device drivers to find a bus in a specific context like
-     system management, video or sound. By default, I2C_CLASS_HWMON (1) is
-     being used. The definition of the classes can be found in
-     include/i2c/i2c.h
-
-   Example, based on mpc823:
-
-	i2c@860 {
-		compatible = "fsl,mpc823-i2c",
-			     "fsl,cpm1-i2c";
-		reg = <0x860 0x20 0x3c80 0x30>;
-		interrupts = <16>;
-		interrupt-parent = <&CPM_PIC>;
-		fsl,cpm-command = <0x10>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		rtc@68 {
-			compatible = "dallas,ds1307";
-			reg = <0x68>;
-		};
-	};
-
-   m) Chipselect/Local Bus
-
-   Properties:
-   - name : Should be localbus
-   - #address-cells : Should be either two or three.  The first cell is the
-                      chipselect number, and the remaining cells are the
-                      offset into the chipselect.
-   - #size-cells : Either one or two, depending on how large each chipselect
-                   can be.
-   - ranges : Each range corresponds to a single chipselect, and cover
-              the entire access window as configured.
-
-   Example:
-	localbus@f0010100 {
-		compatible = "fsl,mpc8272-localbus",
-		             "fsl,pq2-localbus";
-		#address-cells = <2>;
-		#size-cells = <1>;
-		reg = <f0010100 40>;
-
-		ranges = <0 0 fe000000 02000000
-		          1 0 f4500000 00008000>;
-
-		flash@0,0 {
-			compatible = "jedec-flash";
-			reg = <0 0 2000000>;
-			bank-width = <4>;
-			device-width = <1>;
-		};
-
-		board-control@1,0 {
-			reg = <1 0 20>;
-			compatible = "fsl,mpc8272ads-bcsr";
-		};
-	};
-
-
-    n) 4xx/Axon EMAC ethernet nodes
+    d) 4xx/Axon EMAC ethernet nodes

     The EMAC ethernet controller in IBM and AMCC 4xx chips, and also
     the Axon bridge.  To operate this needs to interact with a ths
@@ -2387,7 +1495,7 @@ platforms are moved over to use the flattened-device-tree model.
 			   available.
 			   For Axon: 0x0000012a

-   o) Xilinx IP cores
+   e) Xilinx IP cores

    The Xilinx EDK toolchain ships with a set of IP cores (devices) for use
    in Xilinx Spartan and Virtex FPGAs.  The devices cover the whole range
@@ -2681,206 +1789,7 @@ platforms are moved over to use the flattened-device-tree model.
        - reg-offset : A value of 3 is required
        - reg-shift : A value of 2 is required

-
-    p) Freescale Synchronous Serial Interface
-
-       The SSI is a serial device that communicates with audio codecs.  It can
-       be programmed in AC97, I2S, left-justified, or right-justified modes.
-
-       Required properties:
-       - compatible	  : compatible list, containing "fsl,ssi"
-       - cell-index	  : the SSI, <0> = SSI1, <1> = SSI2, and so on
-       - reg		  : offset and length of the register set for the device
-       - interrupts	  : <a b> where a is the interrupt number and b is a
-                            field that represents an encoding of the sense and
-			    level information for the interrupt.  This should be
-			    encoded based on the information in section 2)
-			    depending on the type of interrupt controller you
-			    have.
-       - interrupt-parent : the phandle for the interrupt controller that
-                            services interrupts for this device.
-       - fsl,mode	  : the operating mode for the SSI interface
-			    "i2s-slave" - I2S mode, SSI is clock slave
-			    "i2s-master" - I2S mode, SSI is clock master
-			    "lj-slave" - left-justified mode, SSI is clock slave
-			    "lj-master" - l.j. mode, SSI is clock master
-			    "rj-slave" - right-justified mode, SSI is clock slave
-			    "rj-master" - r.j., SSI is clock master
-			    "ac97-slave" - AC97 mode, SSI is clock slave
-			    "ac97-master" - AC97 mode, SSI is clock master
-
-       Optional properties:
-       - codec-handle	  : phandle to a 'codec' node that defines an audio
-			    codec connected to this SSI.  This node is typically
-			    a child of an I2C or other control node.
-
-       Child 'codec' node required properties:
-       - compatible	  : compatible list, contains the name of the codec
-
-       Child 'codec' node optional properties:
-       - clock-frequency  : The frequency of the input clock, which typically
-                            comes from an on-board dedicated oscillator.
-
-    * Freescale 83xx DMA Controller
-
-    Freescale PowerPC 83xx have on chip general purpose DMA controllers.
-
-    Required properties:
-
-    - compatible        : compatible list, contains 2 entries, first is
-			 "fsl,CHIP-dma", where CHIP is the processor
-			 (mpc8349, mpc8360, etc.) and the second is
-			 "fsl,elo-dma"
-    - reg               : <registers mapping for DMA general status reg>
-    - ranges 		: Should be defined as specified in 1) to describe the
-			  DMA controller channels.
-    - cell-index        : controller index.  0 for controller @ 0x8100
-    - interrupts        : <interrupt mapping for DMA IRQ>
-    - interrupt-parent  : optional, if needed for interrupt mapping
-
-
-    - DMA channel nodes:
-	    - compatible        : compatible list, contains 2 entries, first is
-				 "fsl,CHIP-dma-channel", where CHIP is the processor
-				 (mpc8349, mpc8350, etc.) and the second is
-				 "fsl,elo-dma-channel"
-	    - reg               : <registers mapping for channel>
-	    - cell-index        : dma channel index starts at 0.
-
-    Optional properties:
-	    - interrupts        : <interrupt mapping for DMA channel IRQ>
-				  (on 83xx this is expected to be identical to
-				   the interrupts property of the parent node)
-	    - interrupt-parent  : optional, if needed for interrupt mapping
-
-  Example:
-	dma@82a8 {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		compatible = "fsl,mpc8349-dma", "fsl,elo-dma";
-		reg = <82a8 4>;
-		ranges = <0 8100 1a4>;
-		interrupt-parent = <&ipic>;
-		interrupts = <47 8>;
-		cell-index = <0>;
-		dma-channel@0 {
-			compatible = "fsl,mpc8349-dma-channel", "fsl,elo-dma-channel";
-			cell-index = <0>;
-			reg = <0 80>;
-		};
-		dma-channel@80 {
-			compatible = "fsl,mpc8349-dma-channel", "fsl,elo-dma-channel";
-			cell-index = <1>;
-			reg = <80 80>;
-		};
-		dma-channel@100 {
-			compatible = "fsl,mpc8349-dma-channel", "fsl,elo-dma-channel";
-			cell-index = <2>;
-			reg = <100 80>;
-		};
-		dma-channel@180 {
-			compatible = "fsl,mpc8349-dma-channel", "fsl,elo-dma-channel";
-			cell-index = <3>;
-			reg = <180 80>;
-		};
-	};
-
-   * Freescale 85xx/86xx DMA Controller
-
-    Freescale PowerPC 85xx/86xx have on chip general purpose DMA controllers.
-
-    Required properties:
-
-    - compatible        : compatible list, contains 2 entries, first is
-			 "fsl,CHIP-dma", where CHIP is the processor
-			 (mpc8540, mpc8540, etc.) and the second is
-			 "fsl,eloplus-dma"
-    - reg               : <registers mapping for DMA general status reg>
-    - cell-index        : controller index.  0 for controller @ 0x21000,
-                                             1 for controller @ 0xc000
-    - ranges 		: Should be defined as specified in 1) to describe the
-			  DMA controller channels.
-
-    - DMA channel nodes:
-	    - compatible        : compatible list, contains 2 entries, first is
-				 "fsl,CHIP-dma-channel", where CHIP is the processor
-				 (mpc8540, mpc8560, etc.) and the second is
-				 "fsl,eloplus-dma-channel"
-	    - cell-index        : dma channel index starts at 0.
-	    - reg               : <registers mapping for channel>
-	    - interrupts        : <interrupt mapping for DMA channel IRQ>
-	    - interrupt-parent  : optional, if needed for interrupt mapping
-
-  Example:
-	dma@21300 {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		compatible = "fsl,mpc8540-dma", "fsl,eloplus-dma";
-		reg = <21300 4>;
-		ranges = <0 21100 200>;
-		cell-index = <0>;
-		dma-channel@0 {
-			compatible = "fsl,mpc8540-dma-channel", "fsl,eloplus-dma-channel";
-			reg = <0 80>;
-			cell-index = <0>;
-			interrupt-parent = <&mpic>;
-			interrupts = <14 2>;
-		};
-		dma-channel@80 {
-			compatible = "fsl,mpc8540-dma-channel", "fsl,eloplus-dma-channel";
-			reg = <80 80>;
-			cell-index = <1>;
-			interrupt-parent = <&mpic>;
-			interrupts = <15 2>;
-		};
-		dma-channel@100 {
-			compatible = "fsl,mpc8540-dma-channel", "fsl,eloplus-dma-channel";
-			reg = <100 80>;
-			cell-index = <2>;
-			interrupt-parent = <&mpic>;
-			interrupts = <16 2>;
-		};
-		dma-channel@180 {
-			compatible = "fsl,mpc8540-dma-channel", "fsl,eloplus-dma-channel";
-			reg = <180 80>;
-			cell-index = <3>;
-			interrupt-parent = <&mpic>;
-			interrupts = <17 2>;
-		};
-	};
-
-    * Freescale 8xxx/3.0 Gb/s SATA nodes
-
-    SATA nodes are defined to describe on-chip Serial ATA controllers.
-    Each SATA port should have its own node.
-
-    Required properties:
-    - compatible        : compatible list, contains 2 entries, first is
-			 "fsl,CHIP-sata", where CHIP is the processor
-			 (mpc8315, mpc8379, etc.) and the second is
-			 "fsl,pq-sata"
-    - interrupts        : <interrupt mapping for SATA IRQ>
-    - cell-index        : controller index.
-                              1 for controller @ 0x18000
-                              2 for controller @ 0x19000
-                              3 for controller @ 0x1a000
-                              4 for controller @ 0x1b000
-
-    Optional properties:
-    - interrupt-parent  : optional, if needed for interrupt mapping
-    - reg               : <registers mapping>
-
-   Example:
-
-	sata@18000 {
-		compatible = "fsl,mpc8379-sata", "fsl,pq-sata";
-		reg = <0x18000 0x1000>;
-		cell-index = <1>;
-		interrupts = <2c 8>;
-		interrupt-parent = < &ipic >;
-        };
-
-    q) USB EHCI controllers
+    f) USB EHCI controllers

     Required properties:
       - compatible : should be "usb-ehci".
@@ -2906,109 +1815,6 @@ platforms are moved over to use the flattened-device-tree model.
 		   big-endian;
 	   };

-    r) Freescale Display Interface Unit
-
-    The Freescale DIU is a LCD controller, with proper hardware, it can also
-    drive DVI monitors.
-
-    Required properties:
-    - compatible : should be "fsl-diu".
-    - reg : should contain at least address and length of the DIU register
-      set.
-    - Interrupts : one DIU interrupt should be describe here.
-
-    Example (MPC8610HPCD)
-	display@2c000 {
-		compatible = "fsl,diu";
-		reg = <0x2c000 100>;
-		interrupts = <72 2>;
-		interrupt-parent = <&mpic>;
-	};
-
-    s) Freescale on board FPGA
-
-    This is the memory-mapped registers for on board FPGA.
-
-    Required properities:
-    - compatible : should be "fsl,fpga-pixis".
-    - reg : should contain the address and the lenght of the FPPGA register
-      set.
-
-    Example (MPC8610HPCD)
-	board-control@e8000000 {
-		compatible = "fsl,fpga-pixis";
-		reg = <0xe8000000 32>;
-	};
-
-    t) Freescale MSI interrupt controller
-
-    Reguired properities:
-    - compatible : compatible list, contains 2 entries,
-      first is "fsl,CHIP-msi", where CHIP is the processor(mpc8610, mpc8572,
-      etc.) and the second is "fsl,mpic-msi" or "fsl,ipic-msi" depending on
-      the parent type.
-    - reg : should contain the address and the length of the shared message
-      interrupt register set.
-    - msi-available-ranges: use <start count> style section to define which
-      msi interrupt can be used in the 256 msi interrupts. This property is
-      optional, without this, all the 256 MSI interrupts can be used.
-    - interrupts : each one of the interrupts here is one entry per 32 MSIs,
-      and routed to the host interrupt controller. the interrupts should
-      be set as edge sensitive.
-    - interrupt-parent: the phandle for the interrupt controller
-      that services interrupts for this device. for 83xx cpu, the interrupts
-      are routed to IPIC, and for 85xx/86xx cpu the interrupts are routed
-      to MPIC.
-
-    Example
-	msi@41600 {
-		compatible = "fsl,mpc8610-msi", "fsl,mpic-msi";
-		reg = <0x41600 0x80>;
-		msi-available-ranges = <0 0x100>;
-		interrupts = <
-			0xe0 0
-			0xe1 0
-			0xe2 0
-			0xe3 0
-			0xe4 0
-			0xe5 0
-			0xe6 0
-			0xe7 0>;
-		interrupt-parent = <&mpic>;
-	};
-
-    u) Freescale General-purpose Timers Module
-
-    Required properties:
-      - compatible : should be
-        "fsl,<chip>-gtm", "fsl,gtm" for SOC GTMs
-        "fsl,<chip>-qe-gtm", "fsl,qe-gtm", "fsl,gtm" for QE GTMs
-        "fsl,<chip>-cpm2-gtm", "fsl,cpm2-gtm", "fsl,gtm" for CPM2 GTMs
-      - reg : should contain gtm registers location and length (0x40).
-      - interrupts : should contain four interrupts.
-      - interrupt-parent : interrupt source phandle.
-      - clock-frequency : specifies the frequency driving the timer.
-
-    Example:
-
-    timer@500 {
-	compatible = "fsl,mpc8360-gtm", "fsl,gtm";
-	reg = <0x500 0x40>;
-	interrupts = <90 8 78 8 84 8 72 8>;
-	interrupt-parent = <&ipic>;
-	/* filled by u-boot */
-	clock-frequency = <0>;
-    };
-
-    timer@440 {
-	compatible = "fsl,mpc8360-qe-gtm", "fsl,qe-gtm", "fsl,gtm";
-	reg = <0x440 0x40>;
-	interrupts = <12 13 14 15>;
-	interrupt-parent = <&qeic>;
-	/* filled by u-boot */
-	clock-frequency = <0>;
-    };
-
 VII - Marvell Discovery mv64[345]6x System Controller chips
 ===========================================================

diff --git a/Documentation/powerpc/dts-bindings/fsl/board.txt b/Documentation/powerpc/dts-bindings/fsl/board.txt
new file mode 100644
index 0000000..74ae6f1
--- /dev/null
+++ b/Documentation/powerpc/dts-bindings/fsl/board.txt
@@ -0,0 +1,29 @@
+* Board Control and Status (BCSR)
+
+Required properties:
+
+ - device_type : Should be "board-control"
+ - reg : Offset and length of the register set for the device
+
+Example:
+
+	bcsr@f8000000 {
+		device_type = "board-control";
+		reg = <f8000000 8000>;
+	};
+
+* Freescale on board FPGA
+
+This is the memory-mapped registers for on board FPGA.
+
+Required properities:
+- compatible : should be "fsl,fpga-pixis".
+- reg : should contain the address and the lenght of the FPPGA register
+  set.
+
+Example (MPC8610HPCD):
+
+	board-control@e8000000 {
+		compatible = "fsl,fpga-pixis";
+		reg = <0xe8000000 32>;
+	};
diff --git a/Documentation/powerpc/dts-bindings/fsl/cpm_qe/cpm.txt b/Documentation/powerpc/dts-bindings/fsl/cpm_qe/cpm.txt
new file mode 100644
index 0000000..70aa11e
--- /dev/null
+++ b/Documentation/powerpc/dts-bindings/fsl/cpm_qe/cpm.txt
@@ -0,0 +1,196 @@
+   l) Freescale Communications Processor Module
+
+   NOTE: This is an interim binding, and will likely change slightly,
+   as more devices are supported.  The QE bindings especially are
+   incomplete.
+
+   i) Root CPM node
+
+   Properties:
+   - compatible : "fsl,cpm1", "fsl,cpm2", or "fsl,qe".
+   - reg : A 48-byte region beginning with CPCR.
+
+   Example:
+	cpm@119c0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		#interrupt-cells = <2>;
+		compatible = "fsl,mpc8272-cpm", "fsl,cpm2";
+		reg = <119c0 30>;
+	}
+
+   ii) Properties common to mulitple CPM/QE devices
+
+   - fsl,cpm-command : This value is ORed with the opcode and command flag
+                       to specify the device on which a CPM command operates.
+
+   - fsl,cpm-brg : Indicates which baud rate generator the device
+                   is associated with.  If absent, an unused BRG
+                   should be dynamically allocated.  If zero, the
+                   device uses an external clock rather than a BRG.
+
+   - reg : Unless otherwise specified, the first resource represents the
+           scc/fcc/ucc registers, and the second represents the device's
+           parameter RAM region (if it has one).
+
+   iii) Serial
+
+   Currently defined compatibles:
+   - fsl,cpm1-smc-uart
+   - fsl,cpm2-smc-uart
+   - fsl,cpm1-scc-uart
+   - fsl,cpm2-scc-uart
+   - fsl,qe-uart
+
+   Example:
+
+	serial@11a00 {
+		device_type = "serial";
+		compatible = "fsl,mpc8272-scc-uart",
+		             "fsl,cpm2-scc-uart";
+		reg = <11a00 20 8000 100>;
+		interrupts = <28 8>;
+		interrupt-parent = <&PIC>;
+		fsl,cpm-brg = <1>;
+		fsl,cpm-command = <00800000>;
+	};
+
+   iii) Network
+
+   Currently defined compatibles:
+   - fsl,cpm1-scc-enet
+   - fsl,cpm2-scc-enet
+   - fsl,cpm1-fec-enet
+   - fsl,cpm2-fcc-enet (third resource is GFEMR)
+   - fsl,qe-enet
+
+   Example:
+
+	ethernet@11300 {
+		device_type = "network";
+		compatible = "fsl,mpc8272-fcc-enet",
+		             "fsl,cpm2-fcc-enet";
+		reg = <11300 20 8400 100 11390 1>;
+		local-mac-address = [ 00 00 00 00 00 00 ];
+		interrupts = <20 8>;
+		interrupt-parent = <&PIC>;
+		phy-handle = <&PHY0>;
+		fsl,cpm-command = <12000300>;
+	};
+
+   iv) MDIO
+
+   Currently defined compatibles:
+   fsl,pq1-fec-mdio (reg is same as first resource of FEC device)
+   fsl,cpm2-mdio-bitbang (reg is port C registers)
+
+   Properties for fsl,cpm2-mdio-bitbang:
+   fsl,mdio-pin : pin of port C controlling mdio data
+   fsl,mdc-pin : pin of port C controlling mdio clock
+
+   Example:
+
+	mdio@10d40 {
+		device_type = "mdio";
+		compatible = "fsl,mpc8272ads-mdio-bitbang",
+		             "fsl,mpc8272-mdio-bitbang",
+		             "fsl,cpm2-mdio-bitbang";
+		reg = <10d40 14>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		fsl,mdio-pin = <12>;
+		fsl,mdc-pin = <13>;
+	};
+
+   v) Baud Rate Generators
+
+   Currently defined compatibles:
+   fsl,cpm-brg
+   fsl,cpm1-brg
+   fsl,cpm2-brg
+
+   Properties:
+   - reg : There may be an arbitrary number of reg resources; BRG
+     numbers are assigned to these in order.
+   - clock-frequency : Specifies the base frequency driving
+     the BRG.
+
+   Example:
+
+	brg@119f0 {
+		compatible = "fsl,mpc8272-brg",
+		             "fsl,cpm2-brg",
+		             "fsl,cpm-brg";
+		reg = <119f0 10 115f0 10>;
+		clock-frequency = <d#25000000>;
+	};
+
+   vi) Interrupt Controllers
+
+   Currently defined compatibles:
+   - fsl,cpm1-pic
+     - only one interrupt cell
+   - fsl,pq1-pic
+   - fsl,cpm2-pic
+     - second interrupt cell is level/sense:
+       - 2 is falling edge
+       - 8 is active low
+
+   Example:
+
+	interrupt-controller@10c00 {
+		#interrupt-cells = <2>;
+		interrupt-controller;
+		reg = <10c00 80>;
+		compatible = "mpc8272-pic", "fsl,cpm2-pic";
+	};
+
+   vii) USB (Universal Serial Bus Controller)
+
+   Properties:
+   - compatible : "fsl,cpm1-usb", "fsl,cpm2-usb", "fsl,qe-usb"
+
+   Example:
+	usb@11bc0 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "fsl,cpm2-usb";
+		reg = <11b60 18 8b00 100>;
+		interrupts = <b 8>;
+		interrupt-parent = <&PIC>;
+		fsl,cpm-command = <2e600000>;
+	};
+
+   viii) Multi-User RAM (MURAM)
+
+   The multi-user/dual-ported RAM is expressed as a bus under the CPM node.
+
+   Ranges must be set up subject to the following restrictions:
+
+   - Children's reg nodes must be offsets from the start of all muram, even
+     if the user-data area does not begin at zero.
+   - If multiple range entries are used, the difference between the parent
+     address and the child address must be the same in all, so that a single
+     mapping can cover them all while maintaining the ability to determine
+     CPM-side offsets with pointer subtraction.  It is recommended that
+     multiple range entries not be used.
+   - A child address of zero must be translatable, even if no reg resources
+     contain it.
+
+   A child "data" node must exist, compatible with "fsl,cpm-muram-data", to
+   indicate the portion of muram that is usable by the OS for arbitrary
+   purposes.  The data node may have an arbitrary number of reg resources,
+   all of which contribute to the allocatable muram pool.
+
+   Example, based on mpc8272:
+
+	muram@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0 10000>;
+
+		data@0 {
+			compatible = "fsl,cpm-muram-data";
+			reg = <0 2000 9800 800>;
+		};
+	};
diff --git a/Documentation/powerpc/dts-bindings/fsl/cpm_qe/cpm/i2c.txt b/Documentation/powerpc/dts-bindings/fsl/cpm_qe/cpm/i2c.txt
new file mode 100644
index 0000000..87bc604
--- /dev/null
+++ b/Documentation/powerpc/dts-bindings/fsl/cpm_qe/cpm/i2c.txt
@@ -0,0 +1,41 @@
+* I2C
+
+The I2C controller is expressed as a bus under the CPM node.
+
+Properties:
+- compatible : "fsl,cpm1-i2c", "fsl,cpm2-i2c"
+- reg : On CPM2 devices, the second resource doesn't specify the I2C
+  Parameter RAM itself, but the I2C_BASE field of the CPM2 Parameter RAM
+  (typically 0x8afc 0x2).
+- #address-cells : Should be one. The cell is the i2c device address with
+  the r/w bit set to zero.
+- #size-cells : Should be zero.
+- clock-frequency : Can be used to set the i2c clock frequency. If
+  unspecified, a default frequency of 60kHz is being used.
+The following two properties are deprecated. They are only used by legacy
+i2c drivers to find the bus to probe:
+- linux,i2c-index : Can be used to hard code an i2c bus number. By default,
+  the bus number is dynamically assigned by the i2c core.
+- linux,i2c-class : Can be used to override the i2c class. The class is used
+  by legacy i2c device drivers to find a bus in a specific context like
+  system management, video or sound. By default, I2C_CLASS_HWMON (1) is
+  being used. The definition of the classes can be found in
+  include/i2c/i2c.h
+
+Example, based on mpc823:
+
+	i2c@860 {
+		compatible = "fsl,mpc823-i2c",
+			     "fsl,cpm1-i2c";
+		reg = <0x860 0x20 0x3c80 0x30>;
+		interrupts = <16>;
+		interrupt-parent = <&CPM_PIC>;
+		fsl,cpm-command = <0x10>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		rtc@68 {
+			compatible = "dallas,ds1307";
+			reg = <0x68>;
+		};
+	};
diff --git a/Documentation/powerpc/dts-bindings/fsl/cpm_qe/qe.txt b/Documentation/powerpc/dts-bindings/fsl/cpm_qe/qe.txt
new file mode 100644
index 0000000..9a47b87
--- /dev/null
+++ b/Documentation/powerpc/dts-bindings/fsl/cpm_qe/qe.txt
@@ -0,0 +1,171 @@
+i) Freescale QUICC Engine module (QE)
+This represents qe module that is installed on PowerQUICC II Pro.
+
+NOTE:  This is an interim binding; it should be updated to fit
+in with the CPM binding later in this document.
+
+Basically, it is a bus of devices, that could act more or less
+as a complete entity (UCC, USB etc ). All of them should be siblings on
+the "root" qe node, using the common properties from there.
+The description below applies to the qe of MPC8360 and
+more nodes and properties would be extended in the future.
+
+i) Root QE device
+
+Required properties:
+- compatible : should be "fsl,qe";
+- model : precise model of the QE, Can be "QE", "CPM", or "CPM2"
+- reg : offset and length of the device registers.
+- bus-frequency : the clock frequency for QUICC Engine.
+
+Recommended properties
+- brg-frequency : the internal clock source frequency for baud-rate
+  generators in Hz.
+
+Example:
+     qe@e0100000 {
+     	#address-cells = <1>;
+     	#size-cells = <1>;
+     	#interrupt-cells = <2>;
+     	compatible = "fsl,qe";
+     	ranges = <0 e0100000 00100000>;
+     	reg = <e0100000 480>;
+     	brg-frequency = <0>;
+     	bus-frequency = <179A7B00>;
+     }
+
+
+ii) SPI (Serial Peripheral Interface)
+
+Required properties:
+- cell-index : SPI controller index.
+- compatible : should be "fsl,spi".
+- mode : the SPI operation mode, it can be "cpu" or "cpu-qe".
+- reg : Offset and length of the register set for the device
+- interrupts : <a b> where a is the interrupt number and b is a
+  field that represents an encoding of the sense and level
+  information for the interrupt.  This should be encoded based on
+  the information in section 2) depending on the type of interrupt
+  controller you have.
+- interrupt-parent : the phandle for the interrupt controller that
+  services interrupts for this device.
+
+Example:
+     spi@4c0 {
+     	cell-index = <0>;
+     	compatible = "fsl,spi";
+     	reg = <4c0 40>;
+     	interrupts = <82 0>;
+     	interrupt-parent = <700>;
+     	mode = "cpu";
+     };
+
+
+
+vi) Pin configuration nodes
+
+Required properties:
+- linux,phandle : phandle of this node; likely referenced by a QE
+  device.
+- pio-map : array of pin configurations.  Each pin is defined by 6
+  integers.  The six numbers are respectively: port, pin, dir,
+  open_drain, assignment, has_irq.
+  - port : port number of the pin; 0-6 represent port A-G in UM.
+  - pin : pin number in the port.
+  - dir : direction of the pin, should encode as follows:
+
+     0 = The pin is disabled
+     1 = The pin is an output
+     2 = The pin is an input
+     3 = The pin is I/O
+
+  - open_drain : indicates the pin is normal or wired-OR:
+
+     0 = The pin is actively driven as an output
+     1 = The pin is an open-drain driver. As an output, the pin is
+         driven active-low, otherwise it is three-stated.
+
+  - assignment : function number of the pin according to the Pin Assignment
+    tables in User Manual.  Each pin can have up to 4 possible functions in
+    QE and two options for CPM.
+  - has_irq : indicates if the pin is used as source of external
+    interrupts.
+
+Example:
+     ucc_pin@01 {
+     	linux,phandle = <140001>;
+     	pio-map = <
+     	/* port  pin  dir  open_drain  assignment  has_irq */
+     		0  3  1  0  1  0 	/* TxD0 */
+     		0  4  1  0  1  0 	/* TxD1 */
+     		0  5  1  0  1  0 	/* TxD2 */
+     		0  6  1  0  1  0 	/* TxD3 */
+     		1  6  1  0  3  0 	/* TxD4 */
+     		1  7  1  0  1  0 	/* TxD5 */
+     		1  9  1  0  2  0 	/* TxD6 */
+     		1  a  1  0  2  0 	/* TxD7 */
+     		0  9  2  0  1  0 	/* RxD0 */
+     		0  a  2  0  1  0 	/* RxD1 */
+     		0  b  2  0  1  0 	/* RxD2 */
+     		0  c  2  0  1  0 	/* RxD3 */
+     		0  d  2  0  1  0 	/* RxD4 */
+     		1  1  2  0  2  0 	/* RxD5 */
+     		1  0  2  0  2  0 	/* RxD6 */
+     		1  4  2  0  2  0 	/* RxD7 */
+     		0  7  1  0  1  0 	/* TX_EN */
+     		0  8  1  0  1  0 	/* TX_ER */
+     		0  f  2  0  1  0 	/* RX_DV */
+     		0  10 2  0  1  0 	/* RX_ER */
+     		0  0  2  0  1  0 	/* RX_CLK */
+     		2  9  1  0  3  0 	/* GTX_CLK - CLK10 */
+     		2  8  2  0  1  0>;	/* GTX125 - CLK9 */
+     };
+
+vii) Multi-User RAM (MURAM)
+
+Required properties:
+- compatible : should be "fsl,qe-muram", "fsl,cpm-muram".
+- mode : the could be "host" or "slave".
+- ranges : Should be defined as specified in 1) to describe the
+   translation of MURAM addresses.
+- data-only : sub-node which defines the address area under MURAM
+   bus that can be allocated as data/parameter
+
+Example:
+
+     muram@10000 {
+     	compatible = "fsl,qe-muram", "fsl,cpm-muram";
+     	ranges = <0 00010000 0000c000>;
+
+     	data-only@0{
+     		compatible = "fsl,qe-muram-data",
+     			     "fsl,cpm-muram-data";
+     		reg = <0 c000>;
+     	};
+     };
+
+viii) Uploaded QE firmware
+
+      If a new firwmare has been uploaded to the QE (usually by the
+      boot loader), then a 'firmware' child node should be added to the QE
+      node.  This node provides information on the uploaded firmware that
+      device drivers may need.
+
+      Required properties:
+      - id: The string name of the firmware.  This is taken from the 'id'
+            member of the qe_firmware structure of the uploaded firmware.
+            Device drivers can search this string to determine if the
+            firmware they want is already present.
+      - extended-modes: The Extended Modes bitfield, taken from the
+     		   firmware binary.  It is a 64-bit number represented
+     		   as an array of two 32-bit numbers.
+      - virtual-traps: The virtual traps, taken from the firmware binary.
+     		  It is an array of 8 32-bit numbers.
+
+      Example:
+
+     	firmware {
+     		id = "Soft-UART";
+     		extended-modes = <0 0>;
+     		virtual-traps = <0 0 0 0 0 0 0 0>;
+     	}
diff --git a/Documentation/powerpc/dts-bindings/fsl/cpm_qe/qe/par_io.txt b/Documentation/powerpc/dts-bindings/fsl/cpm_qe/qe/par_io.txt
new file mode 100644
index 0000000..6098426
--- /dev/null
+++ b/Documentation/powerpc/dts-bindings/fsl/cpm_qe/qe/par_io.txt
@@ -0,0 +1,51 @@
+* Parallel I/O Ports
+
+This node configures Parallel I/O ports for CPUs with QE support.
+The node should reside in the "soc" node of the tree.  For each
+device that using parallel I/O ports, a child node should be created.
+See the definition of the Pin configuration nodes below for more
+information.
+
+Required properties:
+- device_type : should be "par_io".
+- reg : offset to the register set and its length.
+- num-ports : number of Parallel I/O ports
+
+Example:
+par_io@1400 {
+	reg = <1400 100>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+	device_type = "par_io";
+	num-ports = <7>;
+	ucc_pin@01 {
+		......
+	};
+
+Note that "par_io" nodes are obsolete, and should not be used for
+the new device trees. Instead, each Par I/O bank should be represented
+via its own gpio-controller node:
+
+Required properties:
+- #gpio-cells : should be "2".
+- compatible : should be "fsl,<chip>-qe-pario-bank",
+  "fsl,mpc8323-qe-pario-bank".
+- reg : offset to the register set and its length.
+- gpio-controller : node to identify gpio controllers.
+
+Example:
+	qe_pio_a: gpio-controller@1400 {
+		#gpio-cells = <2>;
+		compatible = "fsl,mpc8360-qe-pario-bank",
+		"fsl,mpc8323-qe-pario-bank";
+		reg = <0x1400 0x18>;
+		gpio-controller;
+	  };
+
+	qe_pio_e: gpio-controller@1460 {
+		#gpio-cells = <2>;
+		compatible = "fsl,mpc8360-qe-pario-bank",
+			     "fsl,mpc8323-qe-pario-bank";
+		reg = <0x1460 0x18>;
+		gpio-controller;
+	  };
diff --git a/Documentation/powerpc/dts-bindings/fsl/cpm_qe/qe/ucc.txt b/Documentation/powerpc/dts-bindings/fsl/cpm_qe/qe/ucc.txt
new file mode 100644
index 0000000..e47734b
--- /dev/null
+++ b/Documentation/powerpc/dts-bindings/fsl/cpm_qe/qe/ucc.txt
@@ -0,0 +1,70 @@
+* UCC (Unified Communications Controllers)
+
+Required properties:
+- device_type : should be "network", "hldc", "uart", "transparent"
+  "bisync", "atm", or "serial".
+- compatible : could be "ucc_geth" or "fsl_atm" and so on.
+- cell-index : the ucc number(1-8), corresponding to UCCx in UM.
+- reg : Offset and length of the register set for the device
+- interrupts : <a b> where a is the interrupt number and b is a
+  field that represents an encoding of the sense and level
+  information for the interrupt.  This should be encoded based on
+  the information in section 2) depending on the type of interrupt
+  controller you have.
+- interrupt-parent : the phandle for the interrupt controller that
+  services interrupts for this device.
+- pio-handle : The phandle for the Parallel I/O port configuration.
+- port-number : for UART drivers, the port number to use, between 0 and 3.
+  This usually corresponds to the /dev/ttyQE device, e.g. <0> = /dev/ttyQE0.
+  The port number is added to the minor number of the device.  Unlike the
+  CPM UART driver, the port-number is required for the QE UART driver.
+- soft-uart : for UART drivers, if specified this means the QE UART device
+  driver should use "Soft-UART" mode, which is needed on some SOCs that have
+  broken UART hardware.  Soft-UART is provided via a microcode upload.
+- rx-clock-name: the UCC receive clock source
+  "none": clock source is disabled
+  "brg1" through "brg16": clock source is BRG1-BRG16, respectively
+  "clk1" through "clk24": clock source is CLK1-CLK24, respectively
+- tx-clock-name: the UCC transmit clock source
+  "none": clock source is disabled
+  "brg1" through "brg16": clock source is BRG1-BRG16, respectively
+  "clk1" through "clk24": clock source is CLK1-CLK24, respectively
+The following two properties are deprecated.  rx-clock has been replaced
+with rx-clock-name, and tx-clock has been replaced with tx-clock-name.
+Drivers that currently use the deprecated properties should continue to
+do so, in order to support older device trees, but they should be updated
+to check for the new properties first.
+- rx-clock : represents the UCC receive clock source.
+  0x00 : clock source is disabled;
+  0x1~0x10 : clock source is BRG1~BRG16 respectively;
+  0x11~0x28: clock source is QE_CLK1~QE_CLK24 respectively.
+- tx-clock: represents the UCC transmit clock source;
+  0x00 : clock source is disabled;
+  0x1~0x10 : clock source is BRG1~BRG16 respectively;
+  0x11~0x28: clock source is QE_CLK1~QE_CLK24 respectively.
+
+Required properties for network device_type:
+- mac-address : list of bytes representing the ethernet address.
+- phy-handle : The phandle for the PHY connected to this controller.
+
+Recommended properties:
+- phy-connection-type : a string naming the controller/PHY interface type,
+  i.e., "mii" (default), "rmii", "gmii", "rgmii", "rgmii-id" (Internal
+  Delay), "rgmii-txid" (delay on TX only), "rgmii-rxid" (delay on RX only),
+  "tbi", or "rtbi".
+
+Example:
+	ucc@2000 {
+		device_type = "network";
+		compatible = "ucc_geth";
+		cell-index = <1>;
+		reg = <2000 200>;
+		interrupts = <a0 0>;
+		interrupt-parent = <700>;
+		mac-address = [ 00 04 9f 00 23 23 ];
+		rx-clock = "none";
+		tx-clock = "clk9";
+		phy-handle = <212000>;
+		phy-connection-type = "gmii";
+		pio-handle = <140001>;
+	};
diff --git a/Documentation/powerpc/dts-bindings/fsl/cpm_qe/qe/usb.txt b/Documentation/powerpc/dts-bindings/fsl/cpm_qe/qe/usb.txt
new file mode 100644
index 0000000..c8f44d6
--- /dev/null
+++ b/Documentation/powerpc/dts-bindings/fsl/cpm_qe/qe/usb.txt
@@ -0,0 +1,22 @@
+* USB (Universal Serial Bus Controller)
+
+Required properties:
+- compatible : could be "qe_udc" or "fhci-hcd".
+- mode : the could be "host" or "slave".
+- reg : Offset and length of the register set for the device
+- interrupts : <a b> where a is the interrupt number and b is a
+  field that represents an encoding of the sense and level
+  information for the interrupt.  This should be encoded based on
+  the information in section 2) depending on the type of interrupt
+  controller you have.
+- interrupt-parent : the phandle for the interrupt controller that
+  services interrupts for this device.
+
+Example(slave):
+	usb@6c0 {
+		compatible = "qe_udc";
+		reg = <6c0 40>;
+		interrupts = <8b 0>;
+		interrupt-parent = <700>;
+		mode = "slave";
+	};
diff --git a/Documentation/powerpc/dts-bindings/fsl/diu.txt b/Documentation/powerpc/dts-bindings/fsl/diu.txt
new file mode 100644
index 0000000..deb35de
--- /dev/null
+++ b/Documentation/powerpc/dts-bindings/fsl/diu.txt
@@ -0,0 +1,18 @@
+* Freescale Display Interface Unit
+
+The Freescale DIU is a LCD controller, with proper hardware, it can also
+drive DVI monitors.
+
+Required properties:
+- compatible : should be "fsl-diu".
+- reg : should contain at least address and length of the DIU register
+  set.
+- Interrupts : one DIU interrupt should be describe here.
+
+Example (MPC8610HPCD):
+	display@2c000 {
+		compatible = "fsl,diu";
+		reg = <0x2c000 100>;
+		interrupts = <72 2>;
+		interrupt-parent = <&mpic>;
+	};
diff --git a/Documentation/powerpc/dts-bindings/fsl/dma.txt b/Documentation/powerpc/dts-bindings/fsl/dma.txt
new file mode 100644
index 0000000..86826df
--- /dev/null
+++ b/Documentation/powerpc/dts-bindings/fsl/dma.txt
@@ -0,0 +1,127 @@
+* Freescale 83xx DMA Controller
+
+Freescale PowerPC 83xx have on chip general purpose DMA controllers.
+
+Required properties:
+
+- compatible        : compatible list, contains 2 entries, first is
+		 "fsl,CHIP-dma", where CHIP is the processor
+		 (mpc8349, mpc8360, etc.) and the second is
+		 "fsl,elo-dma"
+- reg               : <registers mapping for DMA general status reg>
+- ranges		: Should be defined as specified in 1) to describe the
+		  DMA controller channels.
+- cell-index        : controller index.  0 for controller @ 0x8100
+- interrupts        : <interrupt mapping for DMA IRQ>
+- interrupt-parent  : optional, if needed for interrupt mapping
+
+
+- DMA channel nodes:
+        - compatible        : compatible list, contains 2 entries, first is
+			 "fsl,CHIP-dma-channel", where CHIP is the processor
+			 (mpc8349, mpc8350, etc.) and the second is
+			 "fsl,elo-dma-channel"
+        - reg               : <registers mapping for channel>
+        - cell-index        : dma channel index starts at 0.
+
+Optional properties:
+        - interrupts        : <interrupt mapping for DMA channel IRQ>
+			  (on 83xx this is expected to be identical to
+			   the interrupts property of the parent node)
+        - interrupt-parent  : optional, if needed for interrupt mapping
+
+Example:
+	dma@82a8 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "fsl,mpc8349-dma", "fsl,elo-dma";
+		reg = <82a8 4>;
+		ranges = <0 8100 1a4>;
+		interrupt-parent = <&ipic>;
+		interrupts = <47 8>;
+		cell-index = <0>;
+		dma-channel@0 {
+			compatible = "fsl,mpc8349-dma-channel", "fsl,elo-dma-channel";
+			cell-index = <0>;
+			reg = <0 80>;
+		};
+		dma-channel@80 {
+			compatible = "fsl,mpc8349-dma-channel", "fsl,elo-dma-channel";
+			cell-index = <1>;
+			reg = <80 80>;
+		};
+		dma-channel@100 {
+			compatible = "fsl,mpc8349-dma-channel", "fsl,elo-dma-channel";
+			cell-index = <2>;
+			reg = <100 80>;
+		};
+		dma-channel@180 {
+			compatible = "fsl,mpc8349-dma-channel", "fsl,elo-dma-channel";
+			cell-index = <3>;
+			reg = <180 80>;
+		};
+	};
+
+* Freescale 85xx/86xx DMA Controller
+
+Freescale PowerPC 85xx/86xx have on chip general purpose DMA controllers.
+
+Required properties:
+
+- compatible        : compatible list, contains 2 entries, first is
+		 "fsl,CHIP-dma", where CHIP is the processor
+		 (mpc8540, mpc8540, etc.) and the second is
+		 "fsl,eloplus-dma"
+- reg               : <registers mapping for DMA general status reg>
+- cell-index        : controller index.  0 for controller @ 0x21000,
+                                         1 for controller @ 0xc000
+- ranges		: Should be defined as specified in 1) to describe the
+		  DMA controller channels.
+
+- DMA channel nodes:
+        - compatible        : compatible list, contains 2 entries, first is
+			 "fsl,CHIP-dma-channel", where CHIP is the processor
+			 (mpc8540, mpc8560, etc.) and the second is
+			 "fsl,eloplus-dma-channel"
+        - cell-index        : dma channel index starts at 0.
+        - reg               : <registers mapping for channel>
+        - interrupts        : <interrupt mapping for DMA channel IRQ>
+        - interrupt-parent  : optional, if needed for interrupt mapping
+
+Example:
+	dma@21300 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "fsl,mpc8540-dma", "fsl,eloplus-dma";
+		reg = <21300 4>;
+		ranges = <0 21100 200>;
+		cell-index = <0>;
+		dma-channel@0 {
+			compatible = "fsl,mpc8540-dma-channel", "fsl,eloplus-dma-channel";
+			reg = <0 80>;
+			cell-index = <0>;
+			interrupt-parent = <&mpic>;
+			interrupts = <14 2>;
+		};
+		dma-channel@80 {
+			compatible = "fsl,mpc8540-dma-channel", "fsl,eloplus-dma-channel";
+			reg = <80 80>;
+			cell-index = <1>;
+			interrupt-parent = <&mpic>;
+			interrupts = <15 2>;
+		};
+		dma-channel@100 {
+			compatible = "fsl,mpc8540-dma-channel", "fsl,eloplus-dma-channel";
+			reg = <100 80>;
+			cell-index = <2>;
+			interrupt-parent = <&mpic>;
+			interrupts = <16 2>;
+		};
+		dma-channel@180 {
+			compatible = "fsl,mpc8540-dma-channel", "fsl,eloplus-dma-channel";
+			reg = <180 80>;
+			cell-index = <3>;
+			interrupt-parent = <&mpic>;
+			interrupts = <17 2>;
+		};
+	};
diff --git a/Documentation/powerpc/dts-bindings/fsl/gtm.txt b/Documentation/powerpc/dts-bindings/fsl/gtm.txt
new file mode 100644
index 0000000..9a33efd
--- /dev/null
+++ b/Documentation/powerpc/dts-bindings/fsl/gtm.txt
@@ -0,0 +1,31 @@
+* Freescale General-purpose Timers Module
+
+Required properties:
+  - compatible : should be
+    "fsl,<chip>-gtm", "fsl,gtm" for SOC GTMs
+    "fsl,<chip>-qe-gtm", "fsl,qe-gtm", "fsl,gtm" for QE GTMs
+    "fsl,<chip>-cpm2-gtm", "fsl,cpm2-gtm", "fsl,gtm" for CPM2 GTMs
+  - reg : should contain gtm registers location and length (0x40).
+  - interrupts : should contain four interrupts.
+  - interrupt-parent : interrupt source phandle.
+  - clock-frequency : specifies the frequency driving the timer.
+
+Example:
+
+timer@500 {
+	compatible = "fsl,mpc8360-gtm", "fsl,gtm";
+	reg = <0x500 0x40>;
+	interrupts = <90 8 78 8 84 8 72 8>;
+	interrupt-parent = <&ipic>;
+	/* filled by u-boot */
+	clock-frequency = <0>;
+};
+
+timer@440 {
+	compatible = "fsl,mpc8360-qe-gtm", "fsl,qe-gtm", "fsl,gtm";
+	reg = <0x440 0x40>;
+	interrupts = <12 13 14 15>;
+	interrupt-parent = <&qeic>;
+	/* filled by u-boot */
+	clock-frequency = <0>;
+};
diff --git a/Documentation/powerpc/dts-bindings/fsl/guts.txt b/Documentation/powerpc/dts-bindings/fsl/guts.txt
new file mode 100644
index 0000000..9e7a241
--- /dev/null
+++ b/Documentation/powerpc/dts-bindings/fsl/guts.txt
@@ -0,0 +1,25 @@
+* Global Utilities Block
+
+The global utilities block controls power management, I/O device
+enabling, power-on-reset configuration monitoring, general-purpose
+I/O signal configuration, alternate function selection for multiplexed
+signals, and clock control.
+
+Required properties:
+
+ - compatible : Should define the compatible device type for
+   global-utilities.
+ - reg : Offset and length of the register set for the device.
+
+Recommended properties:
+
+ - fsl,has-rstcr : Indicates that the global utilities register set
+   contains a functioning "reset control register" (i.e. the board
+   is wired to reset upon setting the HRESET_REQ bit in this register).
+
+Example:
+	global-utilities@e0000 {	/* global utilities block */
+		compatible = "fsl,mpc8548-guts";
+		reg = <e0000 1000>;
+		fsl,has-rstcr;
+	};
diff --git a/Documentation/powerpc/dts-bindings/fsl/i2c.txt b/Documentation/powerpc/dts-bindings/fsl/i2c.txt
new file mode 100644
index 0000000..d0ab33e
--- /dev/null
+++ b/Documentation/powerpc/dts-bindings/fsl/i2c.txt
@@ -0,0 +1,32 @@
+* I2C
+
+Required properties :
+
+ - device_type : Should be "i2c"
+ - reg : Offset and length of the register set for the device
+
+Recommended properties :
+
+ - compatible : Should be "fsl-i2c" for parts compatible with
+   Freescale I2C specifications.
+ - interrupts : <a b> where a is the interrupt number and b is a
+   field that represents an encoding of the sense and level
+   information for the interrupt.  This should be encoded based on
+   the information in section 2) depending on the type of interrupt
+   controller you have.
+ - interrupt-parent : the phandle for the interrupt controller that
+   services interrupts for this device.
+ - dfsrr : boolean; if defined, indicates that this I2C device has
+   a digital filter sampling rate register
+ - fsl5200-clocking : boolean; if defined, indicated that this device
+   uses the FSL 5200 clocking mechanism.
+
+Example :
+	i2c@3000 {
+		interrupt-parent = <40000>;
+		interrupts = <1b 3>;
+		reg = <3000 18>;
+		device_type = "i2c";
+		compatible  = "fsl-i2c";
+		dfsrr;
+	};
diff --git a/Documentation/powerpc/dts-bindings/fsl/lbc.txt b/Documentation/powerpc/dts-bindings/fsl/lbc.txt
new file mode 100644
index 0000000..3300fec
--- /dev/null
+++ b/Documentation/powerpc/dts-bindings/fsl/lbc.txt
@@ -0,0 +1,35 @@
+* Chipselect/Local Bus
+
+Properties:
+- name : Should be localbus
+- #address-cells : Should be either two or three.  The first cell is the
+                   chipselect number, and the remaining cells are the
+                   offset into the chipselect.
+- #size-cells : Either one or two, depending on how large each chipselect
+                can be.
+- ranges : Each range corresponds to a single chipselect, and cover
+           the entire access window as configured.
+
+Example:
+	localbus@f0010100 {
+		compatible = "fsl,mpc8272-localbus",
+			   "fsl,pq2-localbus";
+		#address-cells = <2>;
+		#size-cells = <1>;
+		reg = <f0010100 40>;
+
+		ranges = <0 0 fe000000 02000000
+			  1 0 f4500000 00008000>;
+
+		flash@0,0 {
+			compatible = "jedec-flash";
+			reg = <0 0 2000000>;
+			bank-width = <4>;
+			device-width = <1>;
+		};
+
+		board-control@1,0 {
+			reg = <1 0 20>;
+			compatible = "fsl,mpc8272ads-bcsr";
+		};
+	};
diff --git a/Documentation/powerpc/dts-bindings/fsl/msi-pic.txt b/Documentation/powerpc/dts-bindings/fsl/msi-pic.txt
new file mode 100644
index 0000000..b26b919
--- /dev/null
+++ b/Documentation/powerpc/dts-bindings/fsl/msi-pic.txt
@@ -0,0 +1,36 @@
+* Freescale MSI interrupt controller
+
+Reguired properities:
+- compatible : compatible list, contains 2 entries,
+  first is "fsl,CHIP-msi", where CHIP is the processor(mpc8610, mpc8572,
+  etc.) and the second is "fsl,mpic-msi" or "fsl,ipic-msi" depending on
+  the parent type.
+- reg : should contain the address and the length of the shared message
+  interrupt register set.
+- msi-available-ranges: use <start count> style section to define which
+  msi interrupt can be used in the 256 msi interrupts. This property is
+  optional, without this, all the 256 MSI interrupts can be used.
+- interrupts : each one of the interrupts here is one entry per 32 MSIs,
+  and routed to the host interrupt controller. the interrupts should
+  be set as edge sensitive.
+- interrupt-parent: the phandle for the interrupt controller
+  that services interrupts for this device. for 83xx cpu, the interrupts
+  are routed to IPIC, and for 85xx/86xx cpu the interrupts are routed
+  to MPIC.
+
+Example:
+	msi@41600 {
+		compatible = "fsl,mpc8610-msi", "fsl,mpic-msi";
+		reg = <0x41600 0x80>;
+		msi-available-ranges = <0 0x100>;
+		interrupts = <
+			0xe0 0
+			0xe1 0
+			0xe2 0
+			0xe3 0
+			0xe4 0
+			0xe5 0
+			0xe6 0
+			0xe7 0>;
+		interrupt-parent = <&mpic>;
+	};
diff --git a/Documentation/powerpc/dts-bindings/fsl/sata.txt b/Documentation/powerpc/dts-bindings/fsl/sata.txt
new file mode 100644
index 0000000..b46bcf4
--- /dev/null
+++ b/Documentation/powerpc/dts-bindings/fsl/sata.txt
@@ -0,0 +1,29 @@
+* Freescale 8xxx/3.0 Gb/s SATA nodes
+
+SATA nodes are defined to describe on-chip Serial ATA controllers.
+Each SATA port should have its own node.
+
+Required properties:
+- compatible        : compatible list, contains 2 entries, first is
+		 "fsl,CHIP-sata", where CHIP is the processor
+		 (mpc8315, mpc8379, etc.) and the second is
+		 "fsl,pq-sata"
+- interrupts        : <interrupt mapping for SATA IRQ>
+- cell-index        : controller index.
+                          1 for controller @ 0x18000
+                          2 for controller @ 0x19000
+                          3 for controller @ 0x1a000
+                          4 for controller @ 0x1b000
+
+Optional properties:
+- interrupt-parent  : optional, if needed for interrupt mapping
+- reg               : <registers mapping>
+
+Example:
+	sata@18000 {
+		compatible = "fsl,mpc8379-sata", "fsl,pq-sata";
+		reg = <0x18000 0x1000>;
+		cell-index = <1>;
+		interrupts = <2c 8>;
+		interrupt-parent = < &ipic >;
+	};
diff --git a/Documentation/powerpc/dts-bindings/fsl/ssi.txt b/Documentation/powerpc/dts-bindings/fsl/ssi.txt
new file mode 100644
index 0000000..d100555
--- /dev/null
+++ b/Documentation/powerpc/dts-bindings/fsl/ssi.txt
@@ -0,0 +1,38 @@
+Freescale Synchronous Serial Interface
+
+The SSI is a serial device that communicates with audio codecs.  It can
+be programmed in AC97, I2S, left-justified, or right-justified modes.
+
+Required properties:
+- compatible	  : compatible list, containing "fsl,ssi"
+- cell-index	  : the SSI, <0> = SSI1, <1> = SSI2, and so on
+- reg		  : offset and length of the register set for the device
+- interrupts	  : <a b> where a is the interrupt number and b is a
+                     field that represents an encoding of the sense and
+		    level information for the interrupt.  This should be
+		    encoded based on the information in section 2)
+		    depending on the type of interrupt controller you
+		    have.
+- interrupt-parent : the phandle for the interrupt controller that
+                     services interrupts for this device.
+- fsl,mode	  : the operating mode for the SSI interface
+		    "i2s-slave" - I2S mode, SSI is clock slave
+		    "i2s-master" - I2S mode, SSI is clock master
+		    "lj-slave" - left-justified mode, SSI is clock slave
+		    "lj-master" - l.j. mode, SSI is clock master
+		    "rj-slave" - right-justified mode, SSI is clock slave
+		    "rj-master" - r.j., SSI is clock master
+		    "ac97-slave" - AC97 mode, SSI is clock slave
+		    "ac97-master" - AC97 mode, SSI is clock master
+
+Optional properties:
+- codec-handle	  : phandle to a 'codec' node that defines an audio
+		    codec connected to this SSI.  This node is typically
+		    a child of an I2C or other control node.
+
+Child 'codec' node required properties:
+- compatible	  : compatible list, contains the name of the codec
+
+Child 'codec' node optional properties:
+- clock-frequency  : The frequency of the input clock, which typically
+                     comes from an on-board dedicated oscillator.
diff --git a/Documentation/powerpc/dts-bindings/fsl/tsec.txt b/Documentation/powerpc/dts-bindings/fsl/tsec.txt
new file mode 100644
index 0000000..583ef6b
--- /dev/null
+++ b/Documentation/powerpc/dts-bindings/fsl/tsec.txt
@@ -0,0 +1,69 @@
+* MDIO IO device
+
+The MDIO is a bus to which the PHY devices are connected.  For each
+device that exists on this bus, a child node should be created.  See
+the definition of the PHY node below for an example of how to define
+a PHY.
+
+Required properties:
+  - reg : Offset and length of the register set for the device
+  - compatible : Should define the compatible device type for the
+    mdio.  Currently, this is most likely to be "fsl,gianfar-mdio"
+
+Example:
+
+	mdio@24520 {
+		reg = <24520 20>;
+		compatible = "fsl,gianfar-mdio";
+
+		ethernet-phy@0 {
+			......
+		};
+	};
+
+
+* Gianfar-compatible ethernet nodes
+
+Required properties:
+
+  - device_type : Should be "network"
+  - model : Model of the device.  Can be "TSEC", "eTSEC", or "FEC"
+  - compatible : Should be "gianfar"
+  - reg : Offset and length of the register set for the device
+  - mac-address : List of bytes representing the ethernet address of
+    this controller
+  - interrupts : <a b> where a is the interrupt number and b is a
+    field that represents an encoding of the sense and level
+    information for the interrupt.  This should be encoded based on
+    the information in section 2) depending on the type of interrupt
+    controller you have.
+  - interrupt-parent : the phandle for the interrupt controller that
+    services interrupts for this device.
+  - phy-handle : The phandle for the PHY connected to this ethernet
+    controller.
+  - fixed-link : <a b c d e> where a is emulated phy id - choose any,
+    but unique to the all specified fixed-links, b is duplex - 0 half,
+    1 full, c is link speed - d#10/d#100/d#1000, d is pause - 0 no
+    pause, 1 pause, e is asym_pause - 0 no asym_pause, 1 asym_pause.
+
+Recommended properties:
+
+  - phy-connection-type : a string naming the controller/PHY interface type,
+    i.e., "mii" (default), "rmii", "gmii", "rgmii", "rgmii-id", "sgmii",
+    "tbi", or "rtbi".  This property is only really needed if the connection
+    is of type "rgmii-id", as all other connection types are detected by
+    hardware.
+
+
+Example:
+	ethernet@24000 {
+		#size-cells = <0>;
+		device_type = "network";
+		model = "TSEC";
+		compatible = "gianfar";
+		reg = <24000 1000>;
+		mac-address = [ 00 E0 0C 00 73 00 ];
+		interrupts = <d 3 e 3 12 3>;
+		interrupt-parent = <40000>;
+		phy-handle = <2452000>
+	};
diff --git a/Documentation/powerpc/dts-bindings/fsl/usb.txt b/Documentation/powerpc/dts-bindings/fsl/usb.txt
new file mode 100644
index 0000000..b001524
--- /dev/null
+++ b/Documentation/powerpc/dts-bindings/fsl/usb.txt
@@ -0,0 +1,59 @@
+Freescale SOC USB controllers
+
+The device node for a USB controller that is part of a Freescale
+SOC is as described in the document "Open Firmware Recommended
+Practice : Universal Serial Bus" with the following modifications
+and additions :
+
+Required properties :
+ - compatible : Should be "fsl-usb2-mph" for multi port host USB
+   controllers, or "fsl-usb2-dr" for dual role USB controllers
+ - phy_type : For multi port host USB controllers, should be one of
+   "ulpi", or "serial". For dual role USB controllers, should be
+   one of "ulpi", "utmi", "utmi_wide", or "serial".
+ - reg : Offset and length of the register set for the device
+ - port0 : boolean; if defined, indicates port0 is connected for
+   fsl-usb2-mph compatible controllers.  Either this property or
+   "port1" (or both) must be defined for "fsl-usb2-mph" compatible
+   controllers.
+ - port1 : boolean; if defined, indicates port1 is connected for
+   fsl-usb2-mph compatible controllers.  Either this property or
+   "port0" (or both) must be defined for "fsl-usb2-mph" compatible
+   controllers.
+ - dr_mode : indicates the working mode for "fsl-usb2-dr" compatible
+   controllers.  Can be "host", "peripheral", or "otg".  Default to
+   "host" if not defined for backward compatibility.
+
+Recommended properties :
+ - interrupts : <a b> where a is the interrupt number and b is a
+   field that represents an encoding of the sense and level
+   information for the interrupt.  This should be encoded based on
+   the information in section 2) depending on the type of interrupt
+   controller you have.
+ - interrupt-parent : the phandle for the interrupt controller that
+   services interrupts for this device.
+
+Example multi port host USB controller device node :
+	usb@22000 {
+		compatible = "fsl-usb2-mph";
+		reg = <22000 1000>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		interrupt-parent = <700>;
+		interrupts = <27 1>;
+		phy_type = "ulpi";
+		port0;
+		port1;
+	};
+
+Example dual role USB controller device node :
+	usb@23000 {
+		compatible = "fsl-usb2-dr";
+		reg = <23000 1000>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		interrupt-parent = <700>;
+		interrupts = <26 1>;
+		dr_mode = "otg";
+		phy = "ulpi";
+	};
-- 
1.5.5.1
