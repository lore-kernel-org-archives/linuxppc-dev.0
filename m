Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 360FDB726B
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 20 Jun 2009 01:36:33 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Refactor device tree binding
Date: Fri, 19 Jun 2009 10:36:25 -0500
Message-Id: <1245425785-9950-1-git-send-email-galak@kernel.crashing.org>
Cc: devicetree-discuss@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Split device tree binding out of booting-without-of.txt and put them
into their own files per binding.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 Documentation/powerpc/booting-without-of.txt     | 1168 +---------------------
 Documentation/powerpc/dts-bindings/4xx/emac.txt  |  148 +++
 Documentation/powerpc/dts-bindings/gpio/gpio.txt |   50 +
 Documentation/powerpc/dts-bindings/gpio/mdio.txt |   19 +
 Documentation/powerpc/dts-bindings/marvell.txt   |  521 ++++++++++
 Documentation/powerpc/dts-bindings/phy.txt       |   25 +
 Documentation/powerpc/dts-bindings/spi-bus.txt   |   57 ++
 Documentation/powerpc/dts-bindings/usb-ehci.txt  |   25 +
 Documentation/powerpc/dts-bindings/xilinx.txt    |  295 ++++++
 9 files changed, 1142 insertions(+), 1166 deletions(-)
 create mode 100644 Documentation/powerpc/dts-bindings/4xx/emac.txt
 create mode 100644 Documentation/powerpc/dts-bindings/gpio/gpio.txt
 create mode 100644 Documentation/powerpc/dts-bindings/gpio/mdio.txt
 create mode 100644 Documentation/powerpc/dts-bindings/marvell.txt
 create mode 100644 Documentation/powerpc/dts-bindings/phy.txt
 create mode 100644 Documentation/powerpc/dts-bindings/spi-bus.txt
 create mode 100644 Documentation/powerpc/dts-bindings/usb-ehci.txt
 create mode 100644 Documentation/powerpc/dts-bindings/xilinx.txt

diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
index 8d999d8..79f533f 100644
--- a/Documentation/powerpc/booting-without-of.txt
+++ b/Documentation/powerpc/booting-without-of.txt
@@ -1238,1122 +1238,7 @@ descriptions for the SOC devices for which new nodes have been
 defined; this list will expand as more and more SOC-containing
 platforms are moved over to use the flattened-device-tree model.
 
-   a) PHY nodes
-
-   Required properties:
-
-    - device_type : Should be "ethernet-phy"
-    - interrupts : <a b> where a is the interrupt number and b is a
-      field that represents an encoding of the sense and level
-      information for the interrupt.  This should be encoded based on
-      the information in section 2) depending on the type of interrupt
-      controller you have.
-    - interrupt-parent : the phandle for the interrupt controller that
-      services interrupts for this device.
-    - reg : The ID number for the phy, usually a small integer
-    - linux,phandle :  phandle for this node; likely referenced by an
-      ethernet controller node.
-
-
-   Example:
-
-	ethernet-phy@0 {
-		linux,phandle = <2452000>
-		interrupt-parent = <40000>;
-		interrupts = <35 1>;
-		reg = <0>;
-		device_type = "ethernet-phy";
-	};
-
-
-   b) Interrupt controllers
-
-   Some SOC devices contain interrupt controllers that are different
-   from the standard Open PIC specification.  The SOC device nodes for
-   these types of controllers should be specified just like a standard
-   OpenPIC controller.  Sense and level information should be encoded
-   as specified in section 2) of this chapter for each device that
-   specifies an interrupt.
-
-   Example :
-
-	pic@40000 {
-		linux,phandle = <40000>;
-		interrupt-controller;
-		#address-cells = <0>;
-		reg = <40000 40000>;
-		compatible = "chrp,open-pic";
-		device_type = "open-pic";
-	};
-
-    c) 4xx/Axon EMAC ethernet nodes
-
-    The EMAC ethernet controller in IBM and AMCC 4xx chips, and also
-    the Axon bridge.  To operate this needs to interact with a ths
-    special McMAL DMA controller, and sometimes an RGMII or ZMII
-    interface.  In addition to the nodes and properties described
-    below, the node for the OPB bus on which the EMAC sits must have a
-    correct clock-frequency property.
-
-      i) The EMAC node itself
-
-    Required properties:
-    - device_type       : "network"
-
-    - compatible        : compatible list, contains 2 entries, first is
-			  "ibm,emac-CHIP" where CHIP is the host ASIC (440gx,
-			  405gp, Axon) and second is either "ibm,emac" or
-			  "ibm,emac4".  For Axon, thus, we have: "ibm,emac-axon",
-			  "ibm,emac4"
-    - interrupts        : <interrupt mapping for EMAC IRQ and WOL IRQ>
-    - interrupt-parent  : optional, if needed for interrupt mapping
-    - reg               : <registers mapping>
-    - local-mac-address : 6 bytes, MAC address
-    - mal-device        : phandle of the associated McMAL node
-    - mal-tx-channel    : 1 cell, index of the tx channel on McMAL associated
-			  with this EMAC
-    - mal-rx-channel    : 1 cell, index of the rx channel on McMAL associated
-			  with this EMAC
-    - cell-index        : 1 cell, hardware index of the EMAC cell on a given
-			  ASIC (typically 0x0 and 0x1 for EMAC0 and EMAC1 on
-			  each Axon chip)
-    - max-frame-size    : 1 cell, maximum frame size supported in bytes
-    - rx-fifo-size      : 1 cell, Rx fifo size in bytes for 10 and 100 Mb/sec
-			  operations.
-			  For Axon, 2048
-    - tx-fifo-size      : 1 cell, Tx fifo size in bytes for 10 and 100 Mb/sec
-			  operations.
-			  For Axon, 2048.
-    - fifo-entry-size   : 1 cell, size of a fifo entry (used to calculate
-			  thresholds).
-			  For Axon, 0x00000010
-    - mal-burst-size    : 1 cell, MAL burst size (used to calculate thresholds)
-			  in bytes.
-			  For Axon, 0x00000100 (I think ...)
-    - phy-mode          : string, mode of operations of the PHY interface.
-			  Supported values are: "mii", "rmii", "smii", "rgmii",
-			  "tbi", "gmii", rtbi", "sgmii".
-			  For Axon on CAB, it is "rgmii"
-    - mdio-device       : 1 cell, required iff using shared MDIO registers
-			  (440EP).  phandle of the EMAC to use to drive the
-			  MDIO lines for the PHY used by this EMAC.
-    - zmii-device       : 1 cell, required iff connected to a ZMII.  phandle of
-			  the ZMII device node
-    - zmii-channel      : 1 cell, required iff connected to a ZMII.  Which ZMII
-			  channel or 0xffffffff if ZMII is only used for MDIO.
-    - rgmii-device      : 1 cell, required iff connected to an RGMII. phandle
-			  of the RGMII device node.
-			  For Axon: phandle of plb5/plb4/opb/rgmii
-    - rgmii-channel     : 1 cell, required iff connected to an RGMII.  Which
-			  RGMII channel is used by this EMAC.
-			  Fox Axon: present, whatever value is appropriate for each
-			  EMAC, that is the content of the current (bogus) "phy-port"
-			  property.
-
-    Optional properties:
-    - phy-address       : 1 cell, optional, MDIO address of the PHY. If absent,
-			  a search is performed.
-    - phy-map           : 1 cell, optional, bitmap of addresses to probe the PHY
-			  for, used if phy-address is absent. bit 0x00000001 is
-			  MDIO address 0.
-			  For Axon it can be absent, though my current driver
-			  doesn't handle phy-address yet so for now, keep
-			  0x00ffffff in it.
-    - rx-fifo-size-gige : 1 cell, Rx fifo size in bytes for 1000 Mb/sec
-			  operations (if absent the value is the same as
-			  rx-fifo-size).  For Axon, either absent or 2048.
-    - tx-fifo-size-gige : 1 cell, Tx fifo size in bytes for 1000 Mb/sec
-			  operations (if absent the value is the same as
-			  tx-fifo-size). For Axon, either absent or 2048.
-    - tah-device        : 1 cell, optional. If connected to a TAH engine for
-			  offload, phandle of the TAH device node.
-    - tah-channel       : 1 cell, optional. If appropriate, channel used on the
-			  TAH engine.
-
-    Example:
-
-	EMAC0: ethernet@40000800 {
-		device_type = "network";
-		compatible = "ibm,emac-440gp", "ibm,emac";
-		interrupt-parent = <&UIC1>;
-		interrupts = <1c 4 1d 4>;
-		reg = <40000800 70>;
-		local-mac-address = [00 04 AC E3 1B 1E];
-		mal-device = <&MAL0>;
-		mal-tx-channel = <0 1>;
-		mal-rx-channel = <0>;
-		cell-index = <0>;
-		max-frame-size = <5dc>;
-		rx-fifo-size = <1000>;
-		tx-fifo-size = <800>;
-		phy-mode = "rmii";
-		phy-map = <00000001>;
-		zmii-device = <&ZMII0>;
-		zmii-channel = <0>;
-	};
-
-      ii) McMAL node
-
-    Required properties:
-    - device_type        : "dma-controller"
-    - compatible         : compatible list, containing 2 entries, first is
-			   "ibm,mcmal-CHIP" where CHIP is the host ASIC (like
-			   emac) and the second is either "ibm,mcmal" or
-			   "ibm,mcmal2".
-			   For Axon, "ibm,mcmal-axon","ibm,mcmal2"
-    - interrupts         : <interrupt mapping for the MAL interrupts sources:
-                           5 sources: tx_eob, rx_eob, serr, txde, rxde>.
-                           For Axon: This is _different_ from the current
-			   firmware.  We use the "delayed" interrupts for txeob
-			   and rxeob. Thus we end up with mapping those 5 MPIC
-			   interrupts, all level positive sensitive: 10, 11, 32,
-			   33, 34 (in decimal)
-    - dcr-reg            : < DCR registers range >
-    - dcr-parent         : if needed for dcr-reg
-    - num-tx-chans       : 1 cell, number of Tx channels
-    - num-rx-chans       : 1 cell, number of Rx channels
-
-      iii) ZMII node
-
-    Required properties:
-    - compatible         : compatible list, containing 2 entries, first is
-			   "ibm,zmii-CHIP" where CHIP is the host ASIC (like
-			   EMAC) and the second is "ibm,zmii".
-			   For Axon, there is no ZMII node.
-    - reg                : <registers mapping>
-
-      iv) RGMII node
-
-    Required properties:
-    - compatible         : compatible list, containing 2 entries, first is
-			   "ibm,rgmii-CHIP" where CHIP is the host ASIC (like
-			   EMAC) and the second is "ibm,rgmii".
-                           For Axon, "ibm,rgmii-axon","ibm,rgmii"
-    - reg                : <registers mapping>
-    - revision           : as provided by the RGMII new version register if
-			   available.
-			   For Axon: 0x0000012a
-
-   d) Xilinx IP cores
-
-   The Xilinx EDK toolchain ships with a set of IP cores (devices) for use
-   in Xilinx Spartan and Virtex FPGAs.  The devices cover the whole range
-   of standard device types (network, serial, etc.) and miscellaneous
-   devices (gpio, LCD, spi, etc).  Also, since these devices are
-   implemented within the fpga fabric every instance of the device can be
-   synthesised with different options that change the behaviour.
-
-   Each IP-core has a set of parameters which the FPGA designer can use to
-   control how the core is synthesized.  Historically, the EDK tool would
-   extract the device parameters relevant to device drivers and copy them
-   into an 'xparameters.h' in the form of #define symbols.  This tells the
-   device drivers how the IP cores are configured, but it requres the kernel
-   to be recompiled every time the FPGA bitstream is resynthesized.
-
-   The new approach is to export the parameters into the device tree and
-   generate a new device tree each time the FPGA bitstream changes.  The
-   parameters which used to be exported as #defines will now become
-   properties of the device node.  In general, device nodes for IP-cores
-   will take the following form:
-
-	(name): (generic-name)@(base-address) {
-		compatible = "xlnx,(ip-core-name)-(HW_VER)"
-			     [, (list of compatible devices), ...];
-		reg = <(baseaddr) (size)>;
-		interrupt-parent = <&interrupt-controller-phandle>;
-		interrupts = < ... >;
-		xlnx,(parameter1) = "(string-value)";
-		xlnx,(parameter2) = <(int-value)>;
-	};
-
-	(generic-name):   an open firmware-style name that describes the
-			generic class of device.  Preferably, this is one word, such
-			as 'serial' or 'ethernet'.
-	(ip-core-name):	the name of the ip block (given after the BEGIN
-			directive in system.mhs).  Should be in lowercase
-			and all underscores '_' converted to dashes '-'.
-	(name):		is derived from the "PARAMETER INSTANCE" value.
-	(parameter#):	C_* parameters from system.mhs.  The C_ prefix is
-			dropped from the parameter name, the name is converted
-			to lowercase and all underscore '_' characters are
-			converted to dashes '-'.
-	(baseaddr):	the baseaddr parameter value (often named C_BASEADDR).
-	(HW_VER):	from the HW_VER parameter.
-	(size):		the address range size (often C_HIGHADDR - C_BASEADDR + 1).
-
-   Typically, the compatible list will include the exact IP core version
-   followed by an older IP core version which implements the same
-   interface or any other device with the same interface.
-
-   'reg', 'interrupt-parent' and 'interrupts' are all optional properties.
-
-   For example, the following block from system.mhs:
-
-	BEGIN opb_uartlite
-		PARAMETER INSTANCE = opb_uartlite_0
-		PARAMETER HW_VER = 1.00.b
-		PARAMETER C_BAUDRATE = 115200
-		PARAMETER C_DATA_BITS = 8
-		PARAMETER C_ODD_PARITY = 0
-		PARAMETER C_USE_PARITY = 0
-		PARAMETER C_CLK_FREQ = 50000000
-		PARAMETER C_BASEADDR = 0xEC100000
-		PARAMETER C_HIGHADDR = 0xEC10FFFF
-		BUS_INTERFACE SOPB = opb_7
-		PORT OPB_Clk = CLK_50MHz
-		PORT Interrupt = opb_uartlite_0_Interrupt
-		PORT RX = opb_uartlite_0_RX
-		PORT TX = opb_uartlite_0_TX
-		PORT OPB_Rst = sys_bus_reset_0
-	END
-
-   becomes the following device tree node:
-
-	opb_uartlite_0: serial@ec100000 {
-		device_type = "serial";
-		compatible = "xlnx,opb-uartlite-1.00.b";
-		reg = <ec100000 10000>;
-		interrupt-parent = <&opb_intc_0>;
-		interrupts = <1 0>; // got this from the opb_intc parameters
-		current-speed = <d#115200>;	// standard serial device prop
-		clock-frequency = <d#50000000>;	// standard serial device prop
-		xlnx,data-bits = <8>;
-		xlnx,odd-parity = <0>;
-		xlnx,use-parity = <0>;
-	};
-
-   Some IP cores actually implement 2 or more logical devices.  In
-   this case, the device should still describe the whole IP core with
-   a single node and add a child node for each logical device.  The
-   ranges property can be used to translate from parent IP-core to the
-   registers of each device.  In addition, the parent node should be
-   compatible with the bus type 'xlnx,compound', and should contain
-   #address-cells and #size-cells, as with any other bus.  (Note: this
-   makes the assumption that both logical devices have the same bus
-   binding.  If this is not true, then separate nodes should be used
-   for each logical device).  The 'cell-index' property can be used to
-   enumerate logical devices within an IP core.  For example, the
-   following is the system.mhs entry for the dual ps2 controller found
-   on the ml403 reference design.
-
-	BEGIN opb_ps2_dual_ref
-		PARAMETER INSTANCE = opb_ps2_dual_ref_0
-		PARAMETER HW_VER = 1.00.a
-		PARAMETER C_BASEADDR = 0xA9000000
-		PARAMETER C_HIGHADDR = 0xA9001FFF
-		BUS_INTERFACE SOPB = opb_v20_0
-		PORT Sys_Intr1 = ps2_1_intr
-		PORT Sys_Intr2 = ps2_2_intr
-		PORT Clkin1 = ps2_clk_rx_1
-		PORT Clkin2 = ps2_clk_rx_2
-		PORT Clkpd1 = ps2_clk_tx_1
-		PORT Clkpd2 = ps2_clk_tx_2
-		PORT Rx1 = ps2_d_rx_1
-		PORT Rx2 = ps2_d_rx_2
-		PORT Txpd1 = ps2_d_tx_1
-		PORT Txpd2 = ps2_d_tx_2
-	END
-
-   It would result in the following device tree nodes:
-
-	opb_ps2_dual_ref_0: opb-ps2-dual-ref@a9000000 {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		compatible = "xlnx,compound";
-		ranges = <0 a9000000 2000>;
-		// If this device had extra parameters, then they would
-		// go here.
-		ps2@0 {
-			compatible = "xlnx,opb-ps2-dual-ref-1.00.a";
-			reg = <0 40>;
-			interrupt-parent = <&opb_intc_0>;
-			interrupts = <3 0>;
-			cell-index = <0>;
-		};
-		ps2@1000 {
-			compatible = "xlnx,opb-ps2-dual-ref-1.00.a";
-			reg = <1000 40>;
-			interrupt-parent = <&opb_intc_0>;
-			interrupts = <3 0>;
-			cell-index = <0>;
-		};
-	};
-
-   Also, the system.mhs file defines bus attachments from the processor
-   to the devices.  The device tree structure should reflect the bus
-   attachments.  Again an example; this system.mhs fragment:
-
-	BEGIN ppc405_virtex4
-		PARAMETER INSTANCE = ppc405_0
-		PARAMETER HW_VER = 1.01.a
-		BUS_INTERFACE DPLB = plb_v34_0
-		BUS_INTERFACE IPLB = plb_v34_0
-	END
-
-	BEGIN opb_intc
-		PARAMETER INSTANCE = opb_intc_0
-		PARAMETER HW_VER = 1.00.c
-		PARAMETER C_BASEADDR = 0xD1000FC0
-		PARAMETER C_HIGHADDR = 0xD1000FDF
-		BUS_INTERFACE SOPB = opb_v20_0
-	END
-
-	BEGIN opb_uart16550
-		PARAMETER INSTANCE = opb_uart16550_0
-		PARAMETER HW_VER = 1.00.d
-		PARAMETER C_BASEADDR = 0xa0000000
-		PARAMETER C_HIGHADDR = 0xa0001FFF
-		BUS_INTERFACE SOPB = opb_v20_0
-	END
-
-	BEGIN plb_v34
-		PARAMETER INSTANCE = plb_v34_0
-		PARAMETER HW_VER = 1.02.a
-	END
-
-	BEGIN plb_bram_if_cntlr
-		PARAMETER INSTANCE = plb_bram_if_cntlr_0
-		PARAMETER HW_VER = 1.00.b
-		PARAMETER C_BASEADDR = 0xFFFF0000
-		PARAMETER C_HIGHADDR = 0xFFFFFFFF
-		BUS_INTERFACE SPLB = plb_v34_0
-	END
-
-	BEGIN plb2opb_bridge
-		PARAMETER INSTANCE = plb2opb_bridge_0
-		PARAMETER HW_VER = 1.01.a
-		PARAMETER C_RNG0_BASEADDR = 0x20000000
-		PARAMETER C_RNG0_HIGHADDR = 0x3FFFFFFF
-		PARAMETER C_RNG1_BASEADDR = 0x60000000
-		PARAMETER C_RNG1_HIGHADDR = 0x7FFFFFFF
-		PARAMETER C_RNG2_BASEADDR = 0x80000000
-		PARAMETER C_RNG2_HIGHADDR = 0xBFFFFFFF
-		PARAMETER C_RNG3_BASEADDR = 0xC0000000
-		PARAMETER C_RNG3_HIGHADDR = 0xDFFFFFFF
-		BUS_INTERFACE SPLB = plb_v34_0
-		BUS_INTERFACE MOPB = opb_v20_0
-	END
-
-   Gives this device tree (some properties removed for clarity):
-
-	plb@0 {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		compatible = "xlnx,plb-v34-1.02.a";
-		device_type = "ibm,plb";
-		ranges; // 1:1 translation
-
-		plb_bram_if_cntrl_0: bram@ffff0000 {
-			reg = <ffff0000 10000>;
-		}
-
-		opb@20000000 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			ranges = <20000000 20000000 20000000
-				  60000000 60000000 20000000
-				  80000000 80000000 40000000
-				  c0000000 c0000000 20000000>;
-
-			opb_uart16550_0: serial@a0000000 {
-				reg = <a00000000 2000>;
-			};
-
-			opb_intc_0: interrupt-controller@d1000fc0 {
-				reg = <d1000fc0 20>;
-			};
-		};
-	};
-
-   That covers the general approach to binding xilinx IP cores into the
-   device tree.  The following are bindings for specific devices:
-
-      i) Xilinx ML300 Framebuffer
-
-      Simple framebuffer device from the ML300 reference design (also on the
-      ML403 reference design as well as others).
-
-      Optional properties:
-       - resolution = <xres yres> : pixel resolution of framebuffer.  Some
-                                    implementations use a different resolution.
-                                    Default is <d#640 d#480>
-       - virt-resolution = <xvirt yvirt> : Size of framebuffer in memory.
-                                           Default is <d#1024 d#480>.
-       - rotate-display (empty) : rotate display 180 degrees.
-
-      ii) Xilinx SystemACE
-
-      The Xilinx SystemACE device is used to program FPGAs from an FPGA
-      bitstream stored on a CF card.  It can also be used as a generic CF
-      interface device.
-
-      Optional properties:
-       - 8-bit (empty) : Set this property for SystemACE in 8 bit mode
-
-      iii) Xilinx EMAC and Xilinx TEMAC
-
-      Xilinx Ethernet devices.  In addition to general xilinx properties
-      listed above, nodes for these devices should include a phy-handle
-      property, and may include other common network device properties
-      like local-mac-address.
-
-      iv) Xilinx Uartlite
-
-      Xilinx uartlite devices are simple fixed speed serial ports.
-
-      Required properties:
-       - current-speed : Baud rate of uartlite
-
-      v) Xilinx hwicap
-
-		Xilinx hwicap devices provide access to the configuration logic
-		of the FPGA through the Internal Configuration Access Port
-		(ICAP).  The ICAP enables partial reconfiguration of the FPGA,
-		readback of the configuration information, and some control over
-		'warm boots' of the FPGA fabric.
-
-		Required properties:
-		- xlnx,family : The family of the FPGA, necessary since the
-                      capabilities of the underlying ICAP hardware
-                      differ between different families.  May be
-                      'virtex2p', 'virtex4', or 'virtex5'.
-
-      vi) Xilinx Uart 16550
-
-      Xilinx UART 16550 devices are very similar to the NS16550 but with
-      different register spacing and an offset from the base address.
-
-      Required properties:
-       - clock-frequency : Frequency of the clock input
-       - reg-offset : A value of 3 is required
-       - reg-shift : A value of 2 is required
-
-    e) USB EHCI controllers
-
-    Required properties:
-      - compatible : should be "usb-ehci".
-      - reg : should contain at least address and length of the standard EHCI
-        register set for the device. Optional platform-dependent registers
-        (debug-port or other) can be also specified here, but only after
-        definition of standard EHCI registers.
-      - interrupts : one EHCI interrupt should be described here.
-    If device registers are implemented in big endian mode, the device
-    node should have "big-endian-regs" property.
-    If controller implementation operates with big endian descriptors,
-    "big-endian-desc" property should be specified.
-    If both big endian registers and descriptors are used by the controller
-    implementation, "big-endian" property can be specified instead of having
-    both "big-endian-regs" and "big-endian-desc".
-
-     Example (Sequoia 440EPx):
-	    ehci@e0000300 {
-		   compatible = "ibm,usb-ehci-440epx", "usb-ehci";
-		   interrupt-parent = <&UIC0>;
-		   interrupts = <1a 4>;
-		   reg = <0 e0000300 90 0 e0000390 70>;
-		   big-endian;
-	   };
-
-   f) MDIO on GPIOs
-
-   Currently defined compatibles:
-   - virtual,gpio-mdio
-
-   MDC and MDIO lines connected to GPIO controllers are listed in the
-   gpios property as described in section VIII.1 in the following order:
-
-   MDC, MDIO.
-
-   Example:
-
-	mdio {
-		compatible = "virtual,mdio-gpio";
-		#address-cells = <1>;
-		#size-cells = <0>;
-		gpios = <&qe_pio_a 11
-			 &qe_pio_c 6>;
-	};
-
-    g) SPI (Serial Peripheral Interface) busses
-
-    SPI busses can be described with a node for the SPI master device
-    and a set of child nodes for each SPI slave on the bus.  For this
-    discussion, it is assumed that the system's SPI controller is in
-    SPI master mode.  This binding does not describe SPI controllers
-    in slave mode.
-
-    The SPI master node requires the following properties:
-    - #address-cells  - number of cells required to define a chip select
-			address on the SPI bus.
-    - #size-cells     - should be zero.
-    - compatible      - name of SPI bus controller following generic names
-			recommended practice.
-    No other properties are required in the SPI bus node.  It is assumed
-    that a driver for an SPI bus device will understand that it is an SPI bus.
-    However, the binding does not attempt to define the specific method for
-    assigning chip select numbers.  Since SPI chip select configuration is
-    flexible and non-standardized, it is left out of this binding with the
-    assumption that board specific platform code will be used to manage
-    chip selects.  Individual drivers can define additional properties to
-    support describing the chip select layout.
-
-    SPI slave nodes must be children of the SPI master node and can
-    contain the following properties.
-    - reg             - (required) chip select address of device.
-    - compatible      - (required) name of SPI device following generic names
-			recommended practice
-    - spi-max-frequency - (required) Maximum SPI clocking speed of device in Hz
-    - spi-cpol        - (optional) Empty property indicating device requires
-			inverse clock polarity (CPOL) mode
-    - spi-cpha        - (optional) Empty property indicating device requires
-			shifted clock phase (CPHA) mode
-    - spi-cs-high     - (optional) Empty property indicating device requires
-			chip select active high
-
-    SPI example for an MPC5200 SPI bus:
-		spi@f00 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl,mpc5200b-spi","fsl,mpc5200-spi";
-			reg = <0xf00 0x20>;
-			interrupts = <2 13 0 2 14 0>;
-			interrupt-parent = <&mpc5200_pic>;
-
-			ethernet-switch@0 {
-				compatible = "micrel,ks8995m";
-				spi-max-frequency = <1000000>;
-				reg = <0>;
-			};
-
-			codec@1 {
-				compatible = "ti,tlv320aic26";
-				spi-max-frequency = <100000>;
-				reg = <1>;
-			};
-		};
-
-VII - Marvell Discovery mv64[345]6x System Controller chips
-===========================================================
-
-The Marvell mv64[345]60 series of system controller chips contain
-many of the peripherals needed to implement a complete computer
-system.  In this section, we define device tree nodes to describe
-the system controller chip itself and each of the peripherals
-which it contains.  Compatible string values for each node are
-prefixed with the string "marvell,", for Marvell Technology Group Ltd.
-
-1) The /system-controller node
-
-  This node is used to represent the system-controller and must be
-  present when the system uses a system controller chip. The top-level
-  system-controller node contains information that is global to all
-  devices within the system controller chip. The node name begins
-  with "system-controller" followed by the unit address, which is
-  the base address of the memory-mapped register set for the system
-  controller chip.
-
-  Required properties:
-
-    - ranges : Describes the translation of system controller addresses
-      for memory mapped registers.
-    - clock-frequency: Contains the main clock frequency for the system
-      controller chip.
-    - reg : This property defines the address and size of the
-      memory-mapped registers contained within the system controller
-      chip.  The address specified in the "reg" property should match
-      the unit address of the system-controller node.
-    - #address-cells : Address representation for system controller
-      devices.  This field represents the number of cells needed to
-      represent the address of the memory-mapped registers of devices
-      within the system controller chip.
-    - #size-cells : Size representation for for the memory-mapped
-      registers within the system controller chip.
-    - #interrupt-cells : Defines the width of cells used to represent
-      interrupts.
-
-  Optional properties:
-
-    - model : The specific model of the system controller chip.  Such
-      as, "mv64360", "mv64460", or "mv64560".
-    - compatible : A string identifying the compatibility identifiers
-      of the system controller chip.
-
-  The system-controller node contains child nodes for each system
-  controller device that the platform uses.  Nodes should not be created
-  for devices which exist on the system controller chip but are not used
-
-  Example Marvell Discovery mv64360 system-controller node:
-
-    system-controller@f1000000 { /* Marvell Discovery mv64360 */
-	    #address-cells = <1>;
-	    #size-cells = <1>;
-	    model = "mv64360";                      /* Default */
-	    compatible = "marvell,mv64360";
-	    clock-frequency = <133333333>;
-	    reg = <0xf1000000 0x10000>;
-	    virtual-reg = <0xf1000000>;
-	    ranges = <0x88000000 0x88000000 0x1000000 /* PCI 0 I/O Space */
-		    0x80000000 0x80000000 0x8000000 /* PCI 0 MEM Space */
-		    0xa0000000 0xa0000000 0x4000000 /* User FLASH */
-		    0x00000000 0xf1000000 0x0010000 /* Bridge's regs */
-		    0xf2000000 0xf2000000 0x0040000>;/* Integrated SRAM */
-
-	    [ child node definitions... ]
-    }
-
-2) Child nodes of /system-controller
-
-   a) Marvell Discovery MDIO bus
-
-   The MDIO is a bus to which the PHY devices are connected.  For each
-   device that exists on this bus, a child node should be created.  See
-   the definition of the PHY node below for an example of how to define
-   a PHY.
-
-   Required properties:
-     - #address-cells : Should be <1>
-     - #size-cells : Should be <0>
-     - device_type : Should be "mdio"
-     - compatible : Should be "marvell,mv64360-mdio"
-
-   Example:
-
-     mdio {
-	     #address-cells = <1>;
-	     #size-cells = <0>;
-	     device_type = "mdio";
-	     compatible = "marvell,mv64360-mdio";
-
-	     ethernet-phy@0 {
-		     ......
-	     };
-     };
-
-
-   b) Marvell Discovery ethernet controller
-
-   The Discover ethernet controller is described with two levels
-   of nodes.  The first level describes an ethernet silicon block
-   and the second level describes up to 3 ethernet nodes within
-   that block.  The reason for the multiple levels is that the
-   registers for the node are interleaved within a single set
-   of registers.  The "ethernet-block" level describes the
-   shared register set, and the "ethernet" nodes describe ethernet
-   port-specific properties.
-
-   Ethernet block node
-
-   Required properties:
-     - #address-cells : <1>
-     - #size-cells : <0>
-     - compatible : "marvell,mv64360-eth-block"
-     - reg : Offset and length of the register set for this block
-
-   Example Discovery Ethernet block node:
-     ethernet-block@2000 {
-	     #address-cells = <1>;
-	     #size-cells = <0>;
-	     compatible = "marvell,mv64360-eth-block";
-	     reg = <0x2000 0x2000>;
-	     ethernet@0 {
-		     .......
-	     };
-     };
-
-   Ethernet port node
-
-   Required properties:
-     - device_type : Should be "network".
-     - compatible : Should be "marvell,mv64360-eth".
-     - reg : Should be <0>, <1>, or <2>, according to which registers
-       within the silicon block the device uses.
-     - interrupts : <a> where a is the interrupt number for the port.
-     - interrupt-parent : the phandle for the interrupt controller
-       that services interrupts for this device.
-     - phy : the phandle for the PHY connected to this ethernet
-       controller.
-     - local-mac-address : 6 bytes, MAC address
-
-   Example Discovery Ethernet port node:
-     ethernet@0 {
-	     device_type = "network";
-	     compatible = "marvell,mv64360-eth";
-	     reg = <0>;
-	     interrupts = <32>;
-	     interrupt-parent = <&PIC>;
-	     phy = <&PHY0>;
-	     local-mac-address = [ 00 00 00 00 00 00 ];
-     };
-
-
-
-   c) Marvell Discovery PHY nodes
-
-   Required properties:
-     - device_type : Should be "ethernet-phy"
-     - interrupts : <a> where a is the interrupt number for this phy.
-     - interrupt-parent : the phandle for the interrupt controller that
-       services interrupts for this device.
-     - reg : The ID number for the phy, usually a small integer
-
-   Example Discovery PHY node:
-     ethernet-phy@1 {
-	     device_type = "ethernet-phy";
-	     compatible = "broadcom,bcm5421";
-	     interrupts = <76>;      /* GPP 12 */
-	     interrupt-parent = <&PIC>;
-	     reg = <1>;
-     };
-
-
-   d) Marvell Discovery SDMA nodes
-
-   Represent DMA hardware associated with the MPSC (multiprotocol
-   serial controllers).
-
-   Required properties:
-     - compatible : "marvell,mv64360-sdma"
-     - reg : Offset and length of the register set for this device
-     - interrupts : <a> where a is the interrupt number for the DMA
-       device.
-     - interrupt-parent : the phandle for the interrupt controller
-       that services interrupts for this device.
-
-   Example Discovery SDMA node:
-     sdma@4000 {
-	     compatible = "marvell,mv64360-sdma";
-	     reg = <0x4000 0xc18>;
-	     virtual-reg = <0xf1004000>;
-	     interrupts = <36>;
-	     interrupt-parent = <&PIC>;
-     };
-
-
-   e) Marvell Discovery BRG nodes
-
-   Represent baud rate generator hardware associated with the MPSC
-   (multiprotocol serial controllers).
-
-   Required properties:
-     - compatible : "marvell,mv64360-brg"
-     - reg : Offset and length of the register set for this device
-     - clock-src : A value from 0 to 15 which selects the clock
-       source for the baud rate generator.  This value corresponds
-       to the CLKS value in the BRGx configuration register.  See
-       the mv64x60 User's Manual.
-     - clock-frequence : The frequency (in Hz) of the baud rate
-       generator's input clock.
-     - current-speed : The current speed setting (presumably by
-       firmware) of the baud rate generator.
-
-   Example Discovery BRG node:
-     brg@b200 {
-	     compatible = "marvell,mv64360-brg";
-	     reg = <0xb200 0x8>;
-	     clock-src = <8>;
-	     clock-frequency = <133333333>;
-	     current-speed = <9600>;
-     };
-
-
-   f) Marvell Discovery CUNIT nodes
-
-   Represent the Serial Communications Unit device hardware.
-
-   Required properties:
-     - reg : Offset and length of the register set for this device
-
-   Example Discovery CUNIT node:
-     cunit@f200 {
-	     reg = <0xf200 0x200>;
-     };
-
-
-   g) Marvell Discovery MPSCROUTING nodes
-
-   Represent the Discovery's MPSC routing hardware
-
-   Required properties:
-     - reg : Offset and length of the register set for this device
-
-   Example Discovery CUNIT node:
-     mpscrouting@b500 {
-	     reg = <0xb400 0xc>;
-     };
-
-
-   h) Marvell Discovery MPSCINTR nodes
-
-   Represent the Discovery's MPSC DMA interrupt hardware registers
-   (SDMA cause and mask registers).
-
-   Required properties:
-     - reg : Offset and length of the register set for this device
-
-   Example Discovery MPSCINTR node:
-     mpsintr@b800 {
-	     reg = <0xb800 0x100>;
-     };
-
-
-   i) Marvell Discovery MPSC nodes
-
-   Represent the Discovery's MPSC (Multiprotocol Serial Controller)
-   serial port.
-
-   Required properties:
-     - device_type : "serial"
-     - compatible : "marvell,mv64360-mpsc"
-     - reg : Offset and length of the register set for this device
-     - sdma : the phandle for the SDMA node used by this port
-     - brg : the phandle for the BRG node used by this port
-     - cunit : the phandle for the CUNIT node used by this port
-     - mpscrouting : the phandle for the MPSCROUTING node used by this port
-     - mpscintr : the phandle for the MPSCINTR node used by this port
-     - cell-index : the hardware index of this cell in the MPSC core
-     - max_idle : value needed for MPSC CHR3 (Maximum Frame Length)
-       register
-     - interrupts : <a> where a is the interrupt number for the MPSC.
-     - interrupt-parent : the phandle for the interrupt controller
-       that services interrupts for this device.
-
-   Example Discovery MPSCINTR node:
-     mpsc@8000 {
-	     device_type = "serial";
-	     compatible = "marvell,mv64360-mpsc";
-	     reg = <0x8000 0x38>;
-	     virtual-reg = <0xf1008000>;
-	     sdma = <&SDMA0>;
-	     brg = <&BRG0>;
-	     cunit = <&CUNIT>;
-	     mpscrouting = <&MPSCROUTING>;
-	     mpscintr = <&MPSCINTR>;
-	     cell-index = <0>;
-	     max_idle = <40>;
-	     interrupts = <40>;
-	     interrupt-parent = <&PIC>;
-     };
-
-
-   j) Marvell Discovery Watch Dog Timer nodes
-
-   Represent the Discovery's watchdog timer hardware
-
-   Required properties:
-     - compatible : "marvell,mv64360-wdt"
-     - reg : Offset and length of the register set for this device
-
-   Example Discovery Watch Dog Timer node:
-     wdt@b410 {
-	     compatible = "marvell,mv64360-wdt";
-	     reg = <0xb410 0x8>;
-     };
-
-
-   k) Marvell Discovery I2C nodes
-
-   Represent the Discovery's I2C hardware
-
-   Required properties:
-     - device_type : "i2c"
-     - compatible : "marvell,mv64360-i2c"
-     - reg : Offset and length of the register set for this device
-     - interrupts : <a> where a is the interrupt number for the I2C.
-     - interrupt-parent : the phandle for the interrupt controller
-       that services interrupts for this device.
-
-   Example Discovery I2C node:
-	     compatible = "marvell,mv64360-i2c";
-	     reg = <0xc000 0x20>;
-	     virtual-reg = <0xf100c000>;
-	     interrupts = <37>;
-	     interrupt-parent = <&PIC>;
-     };
-
-
-   l) Marvell Discovery PIC (Programmable Interrupt Controller) nodes
-
-   Represent the Discovery's PIC hardware
-
-   Required properties:
-     - #interrupt-cells : <1>
-     - #address-cells : <0>
-     - compatible : "marvell,mv64360-pic"
-     - reg : Offset and length of the register set for this device
-     - interrupt-controller
-
-   Example Discovery PIC node:
-     pic {
-	     #interrupt-cells = <1>;
-	     #address-cells = <0>;
-	     compatible = "marvell,mv64360-pic";
-	     reg = <0x0 0x88>;
-	     interrupt-controller;
-     };
-
-
-   m) Marvell Discovery MPP (Multipurpose Pins) multiplexing nodes
-
-   Represent the Discovery's MPP hardware
-
-   Required properties:
-     - compatible : "marvell,mv64360-mpp"
-     - reg : Offset and length of the register set for this device
-
-   Example Discovery MPP node:
-     mpp@f000 {
-	     compatible = "marvell,mv64360-mpp";
-	     reg = <0xf000 0x10>;
-     };
-
-
-   n) Marvell Discovery GPP (General Purpose Pins) nodes
-
-   Represent the Discovery's GPP hardware
-
-   Required properties:
-     - compatible : "marvell,mv64360-gpp"
-     - reg : Offset and length of the register set for this device
-
-   Example Discovery GPP node:
-     gpp@f000 {
-	     compatible = "marvell,mv64360-gpp";
-	     reg = <0xf100 0x20>;
-     };
-
-
-   o) Marvell Discovery PCI host bridge node
-
-   Represents the Discovery's PCI host bridge device.  The properties
-   for this node conform to Rev 2.1 of the PCI Bus Binding to IEEE
-   1275-1994.  A typical value for the compatible property is
-   "marvell,mv64360-pci".
-
-   Example Discovery PCI host bridge node
-     pci@80000000 {
-	     #address-cells = <3>;
-	     #size-cells = <2>;
-	     #interrupt-cells = <1>;
-	     device_type = "pci";
-	     compatible = "marvell,mv64360-pci";
-	     reg = <0xcf8 0x8>;
-	     ranges = <0x01000000 0x0        0x0
-			     0x88000000 0x0 0x01000000
-		       0x02000000 0x0 0x80000000
-			     0x80000000 0x0 0x08000000>;
-	     bus-range = <0 255>;
-	     clock-frequency = <66000000>;
-	     interrupt-parent = <&PIC>;
-	     interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
-	     interrupt-map = <
-		     /* IDSEL 0x0a */
-		     0x5000 0 0 1 &PIC 80
-		     0x5000 0 0 2 &PIC 81
-		     0x5000 0 0 3 &PIC 91
-		     0x5000 0 0 4 &PIC 93
-
-		     /* IDSEL 0x0b */
-		     0x5800 0 0 1 &PIC 91
-		     0x5800 0 0 2 &PIC 93
-		     0x5800 0 0 3 &PIC 80
-		     0x5800 0 0 4 &PIC 81
-
-		     /* IDSEL 0x0c */
-		     0x6000 0 0 1 &PIC 91
-		     0x6000 0 0 2 &PIC 93
-		     0x6000 0 0 3 &PIC 80
-		     0x6000 0 0 4 &PIC 81
-
-		     /* IDSEL 0x0d */
-		     0x6800 0 0 1 &PIC 93
-		     0x6800 0 0 2 &PIC 80
-		     0x6800 0 0 3 &PIC 81
-		     0x6800 0 0 4 &PIC 91
-	     >;
-     };
-
-
-   p) Marvell Discovery CPU Error nodes
-
-   Represent the Discovery's CPU error handler device.
-
-   Required properties:
-     - compatible : "marvell,mv64360-cpu-error"
-     - reg : Offset and length of the register set for this device
-     - interrupts : the interrupt number for this device
-     - interrupt-parent : the phandle for the interrupt controller
-       that services interrupts for this device.
-
-   Example Discovery CPU Error node:
-     cpu-error@0070 {
-	     compatible = "marvell,mv64360-cpu-error";
-	     reg = <0x70 0x10 0x128 0x28>;
-	     interrupts = <3>;
-	     interrupt-parent = <&PIC>;
-     };
-
-
-   q) Marvell Discovery SRAM Controller nodes
-
-   Represent the Discovery's SRAM controller device.
-
-   Required properties:
-     - compatible : "marvell,mv64360-sram-ctrl"
-     - reg : Offset and length of the register set for this device
-     - interrupts : the interrupt number for this device
-     - interrupt-parent : the phandle for the interrupt controller
-       that services interrupts for this device.
-
-   Example Discovery SRAM Controller node:
-     sram-ctrl@0380 {
-	     compatible = "marvell,mv64360-sram-ctrl";
-	     reg = <0x380 0x80>;
-	     interrupts = <13>;
-	     interrupt-parent = <&PIC>;
-     };
-
-
-   r) Marvell Discovery PCI Error Handler nodes
-
-   Represent the Discovery's PCI error handler device.
-
-   Required properties:
-     - compatible : "marvell,mv64360-pci-error"
-     - reg : Offset and length of the register set for this device
-     - interrupts : the interrupt number for this device
-     - interrupt-parent : the phandle for the interrupt controller
-       that services interrupts for this device.
-
-   Example Discovery PCI Error Handler node:
-     pci-error@1d40 {
-	     compatible = "marvell,mv64360-pci-error";
-	     reg = <0x1d40 0x40 0xc28 0x4>;
-	     interrupts = <12>;
-	     interrupt-parent = <&PIC>;
-     };
-
-
-   s) Marvell Discovery Memory Controller nodes
-
-   Represent the Discovery's memory controller device.
-
-   Required properties:
-     - compatible : "marvell,mv64360-mem-ctrl"
-     - reg : Offset and length of the register set for this device
-     - interrupts : the interrupt number for this device
-     - interrupt-parent : the phandle for the interrupt controller
-       that services interrupts for this device.
-
-   Example Discovery Memory Controller node:
-     mem-ctrl@1400 {
-	     compatible = "marvell,mv64360-mem-ctrl";
-	     reg = <0x1400 0x60>;
-	     interrupts = <17>;
-	     interrupt-parent = <&PIC>;
-     };
-
-
-VIII - Specifying interrupt information for devices
+VII - Specifying interrupt information for devices
 ===================================================
 
 The device tree represents the busses and devices of a hardware
@@ -2439,56 +1324,7 @@ encodings listed below:
 	2 =  high to low edge sensitive type enabled
 	3 =  low to high edge sensitive type enabled
 
-IX - Specifying GPIO information for devices
-============================================
-
-1) gpios property
------------------
-
-Nodes that makes use of GPIOs should define them using `gpios' property,
-format of which is: <&gpio-controller1-phandle gpio1-specifier
-		     &gpio-controller2-phandle gpio2-specifier
-		     0 /* holes are permitted, means no GPIO 3 */
-		     &gpio-controller4-phandle gpio4-specifier
-		     ...>;
-
-Note that gpio-specifier length is controller dependent.
-
-gpio-specifier may encode: bank, pin position inside the bank,
-whether pin is open-drain and whether pin is logically inverted.
-
-Example of the node using GPIOs:
-
-	node {
-		gpios = <&qe_pio_e 18 0>;
-	};
-
-In this example gpio-specifier is "18 0" and encodes GPIO pin number,
-and empty GPIO flags as accepted by the "qe_pio_e" gpio-controller.
-
-2) gpio-controller nodes
-------------------------
-
-Every GPIO controller node must have #gpio-cells property defined,
-this information will be used to translate gpio-specifiers.
-
-Example of two SOC GPIO banks defined as gpio-controller nodes:
-
-	qe_pio_a: gpio-controller@1400 {
-		#gpio-cells = <2>;
-		compatible = "fsl,qe-pario-bank-a", "fsl,qe-pario-bank";
-		reg = <0x1400 0x18>;
-		gpio-controller;
-	};
-
-	qe_pio_e: gpio-controller@1460 {
-		#gpio-cells = <2>;
-		compatible = "fsl,qe-pario-bank-e", "fsl,qe-pario-bank";
-		reg = <0x1460 0x18>;
-		gpio-controller;
-	};
-
-X - Specifying Device Power Management Information (sleep property)
+VIII - Specifying Device Power Management Information (sleep property)
 ===================================================================
 
 Devices on SOCs often have mechanisms for placing devices into low-power
diff --git a/Documentation/powerpc/dts-bindings/4xx/emac.txt b/Documentation/powerpc/dts-bindings/4xx/emac.txt
new file mode 100644
index 0000000..2161334
--- /dev/null
+++ b/Documentation/powerpc/dts-bindings/4xx/emac.txt
@@ -0,0 +1,148 @@
+    4xx/Axon EMAC ethernet nodes
+
+    The EMAC ethernet controller in IBM and AMCC 4xx chips, and also
+    the Axon bridge.  To operate this needs to interact with a ths
+    special McMAL DMA controller, and sometimes an RGMII or ZMII
+    interface.  In addition to the nodes and properties described
+    below, the node for the OPB bus on which the EMAC sits must have a
+    correct clock-frequency property.
+
+      i) The EMAC node itself
+
+    Required properties:
+    - device_type       : "network"
+
+    - compatible        : compatible list, contains 2 entries, first is
+			  "ibm,emac-CHIP" where CHIP is the host ASIC (440gx,
+			  405gp, Axon) and second is either "ibm,emac" or
+			  "ibm,emac4".  For Axon, thus, we have: "ibm,emac-axon",
+			  "ibm,emac4"
+    - interrupts        : <interrupt mapping for EMAC IRQ and WOL IRQ>
+    - interrupt-parent  : optional, if needed for interrupt mapping
+    - reg               : <registers mapping>
+    - local-mac-address : 6 bytes, MAC address
+    - mal-device        : phandle of the associated McMAL node
+    - mal-tx-channel    : 1 cell, index of the tx channel on McMAL associated
+			  with this EMAC
+    - mal-rx-channel    : 1 cell, index of the rx channel on McMAL associated
+			  with this EMAC
+    - cell-index        : 1 cell, hardware index of the EMAC cell on a given
+			  ASIC (typically 0x0 and 0x1 for EMAC0 and EMAC1 on
+			  each Axon chip)
+    - max-frame-size    : 1 cell, maximum frame size supported in bytes
+    - rx-fifo-size      : 1 cell, Rx fifo size in bytes for 10 and 100 Mb/sec
+			  operations.
+			  For Axon, 2048
+    - tx-fifo-size      : 1 cell, Tx fifo size in bytes for 10 and 100 Mb/sec
+			  operations.
+			  For Axon, 2048.
+    - fifo-entry-size   : 1 cell, size of a fifo entry (used to calculate
+			  thresholds).
+			  For Axon, 0x00000010
+    - mal-burst-size    : 1 cell, MAL burst size (used to calculate thresholds)
+			  in bytes.
+			  For Axon, 0x00000100 (I think ...)
+    - phy-mode          : string, mode of operations of the PHY interface.
+			  Supported values are: "mii", "rmii", "smii", "rgmii",
+			  "tbi", "gmii", rtbi", "sgmii".
+			  For Axon on CAB, it is "rgmii"
+    - mdio-device       : 1 cell, required iff using shared MDIO registers
+			  (440EP).  phandle of the EMAC to use to drive the
+			  MDIO lines for the PHY used by this EMAC.
+    - zmii-device       : 1 cell, required iff connected to a ZMII.  phandle of
+			  the ZMII device node
+    - zmii-channel      : 1 cell, required iff connected to a ZMII.  Which ZMII
+			  channel or 0xffffffff if ZMII is only used for MDIO.
+    - rgmii-device      : 1 cell, required iff connected to an RGMII. phandle
+			  of the RGMII device node.
+			  For Axon: phandle of plb5/plb4/opb/rgmii
+    - rgmii-channel     : 1 cell, required iff connected to an RGMII.  Which
+			  RGMII channel is used by this EMAC.
+			  Fox Axon: present, whatever value is appropriate for each
+			  EMAC, that is the content of the current (bogus) "phy-port"
+			  property.
+
+    Optional properties:
+    - phy-address       : 1 cell, optional, MDIO address of the PHY. If absent,
+			  a search is performed.
+    - phy-map           : 1 cell, optional, bitmap of addresses to probe the PHY
+			  for, used if phy-address is absent. bit 0x00000001 is
+			  MDIO address 0.
+			  For Axon it can be absent, though my current driver
+			  doesn't handle phy-address yet so for now, keep
+			  0x00ffffff in it.
+    - rx-fifo-size-gige : 1 cell, Rx fifo size in bytes for 1000 Mb/sec
+			  operations (if absent the value is the same as
+			  rx-fifo-size).  For Axon, either absent or 2048.
+    - tx-fifo-size-gige : 1 cell, Tx fifo size in bytes for 1000 Mb/sec
+			  operations (if absent the value is the same as
+			  tx-fifo-size). For Axon, either absent or 2048.
+    - tah-device        : 1 cell, optional. If connected to a TAH engine for
+			  offload, phandle of the TAH device node.
+    - tah-channel       : 1 cell, optional. If appropriate, channel used on the
+			  TAH engine.
+
+    Example:
+
+	EMAC0: ethernet@40000800 {
+		device_type = "network";
+		compatible = "ibm,emac-440gp", "ibm,emac";
+		interrupt-parent = <&UIC1>;
+		interrupts = <1c 4 1d 4>;
+		reg = <40000800 70>;
+		local-mac-address = [00 04 AC E3 1B 1E];
+		mal-device = <&MAL0>;
+		mal-tx-channel = <0 1>;
+		mal-rx-channel = <0>;
+		cell-index = <0>;
+		max-frame-size = <5dc>;
+		rx-fifo-size = <1000>;
+		tx-fifo-size = <800>;
+		phy-mode = "rmii";
+		phy-map = <00000001>;
+		zmii-device = <&ZMII0>;
+		zmii-channel = <0>;
+	};
+
+      ii) McMAL node
+
+    Required properties:
+    - device_type        : "dma-controller"
+    - compatible         : compatible list, containing 2 entries, first is
+			   "ibm,mcmal-CHIP" where CHIP is the host ASIC (like
+			   emac) and the second is either "ibm,mcmal" or
+			   "ibm,mcmal2".
+			   For Axon, "ibm,mcmal-axon","ibm,mcmal2"
+    - interrupts         : <interrupt mapping for the MAL interrupts sources:
+                           5 sources: tx_eob, rx_eob, serr, txde, rxde>.
+                           For Axon: This is _different_ from the current
+			   firmware.  We use the "delayed" interrupts for txeob
+			   and rxeob. Thus we end up with mapping those 5 MPIC
+			   interrupts, all level positive sensitive: 10, 11, 32,
+			   33, 34 (in decimal)
+    - dcr-reg            : < DCR registers range >
+    - dcr-parent         : if needed for dcr-reg
+    - num-tx-chans       : 1 cell, number of Tx channels
+    - num-rx-chans       : 1 cell, number of Rx channels
+
+      iii) ZMII node
+
+    Required properties:
+    - compatible         : compatible list, containing 2 entries, first is
+			   "ibm,zmii-CHIP" where CHIP is the host ASIC (like
+			   EMAC) and the second is "ibm,zmii".
+			   For Axon, there is no ZMII node.
+    - reg                : <registers mapping>
+
+      iv) RGMII node
+
+    Required properties:
+    - compatible         : compatible list, containing 2 entries, first is
+			   "ibm,rgmii-CHIP" where CHIP is the host ASIC (like
+			   EMAC) and the second is "ibm,rgmii".
+                           For Axon, "ibm,rgmii-axon","ibm,rgmii"
+    - reg                : <registers mapping>
+    - revision           : as provided by the RGMII new version register if
+			   available.
+			   For Axon: 0x0000012a
+
diff --git a/Documentation/powerpc/dts-bindings/gpio/gpio.txt b/Documentation/powerpc/dts-bindings/gpio/gpio.txt
new file mode 100644
index 0000000..edaa84d
--- /dev/null
+++ b/Documentation/powerpc/dts-bindings/gpio/gpio.txt
@@ -0,0 +1,50 @@
+Specifying GPIO information for devices
+============================================
+
+1) gpios property
+-----------------
+
+Nodes that makes use of GPIOs should define them using `gpios' property,
+format of which is: <&gpio-controller1-phandle gpio1-specifier
+		     &gpio-controller2-phandle gpio2-specifier
+		     0 /* holes are permitted, means no GPIO 3 */
+		     &gpio-controller4-phandle gpio4-specifier
+		     ...>;
+
+Note that gpio-specifier length is controller dependent.
+
+gpio-specifier may encode: bank, pin position inside the bank,
+whether pin is open-drain and whether pin is logically inverted.
+
+Example of the node using GPIOs:
+
+	node {
+		gpios = <&qe_pio_e 18 0>;
+	};
+
+In this example gpio-specifier is "18 0" and encodes GPIO pin number,
+and empty GPIO flags as accepted by the "qe_pio_e" gpio-controller.
+
+2) gpio-controller nodes
+------------------------
+
+Every GPIO controller node must have #gpio-cells property defined,
+this information will be used to translate gpio-specifiers.
+
+Example of two SOC GPIO banks defined as gpio-controller nodes:
+
+	qe_pio_a: gpio-controller@1400 {
+		#gpio-cells = <2>;
+		compatible = "fsl,qe-pario-bank-a", "fsl,qe-pario-bank";
+		reg = <0x1400 0x18>;
+		gpio-controller;
+	};
+
+	qe_pio_e: gpio-controller@1460 {
+		#gpio-cells = <2>;
+		compatible = "fsl,qe-pario-bank-e", "fsl,qe-pario-bank";
+		reg = <0x1460 0x18>;
+		gpio-controller;
+	};
+
+
diff --git a/Documentation/powerpc/dts-bindings/gpio/mdio.txt b/Documentation/powerpc/dts-bindings/gpio/mdio.txt
new file mode 100644
index 0000000..bc95495
--- /dev/null
+++ b/Documentation/powerpc/dts-bindings/gpio/mdio.txt
@@ -0,0 +1,19 @@
+MDIO on GPIOs
+
+Currently defined compatibles:
+- virtual,gpio-mdio
+
+MDC and MDIO lines connected to GPIO controllers are listed in the
+gpios property as described in section VIII.1 in the following order:
+
+MDC, MDIO.
+
+Example:
+
+mdio {
+	compatible = "virtual,mdio-gpio";
+	#address-cells = <1>;
+	#size-cells = <0>;
+	gpios = <&qe_pio_a 11
+		 &qe_pio_c 6>;
+};
diff --git a/Documentation/powerpc/dts-bindings/marvell.txt b/Documentation/powerpc/dts-bindings/marvell.txt
new file mode 100644
index 0000000..3708a2f
--- /dev/null
+++ b/Documentation/powerpc/dts-bindings/marvell.txt
@@ -0,0 +1,521 @@
+Marvell Discovery mv64[345]6x System Controller chips
+===========================================================
+
+The Marvell mv64[345]60 series of system controller chips contain
+many of the peripherals needed to implement a complete computer
+system.  In this section, we define device tree nodes to describe
+the system controller chip itself and each of the peripherals
+which it contains.  Compatible string values for each node are
+prefixed with the string "marvell,", for Marvell Technology Group Ltd.
+
+1) The /system-controller node
+
+  This node is used to represent the system-controller and must be
+  present when the system uses a system controller chip. The top-level
+  system-controller node contains information that is global to all
+  devices within the system controller chip. The node name begins
+  with "system-controller" followed by the unit address, which is
+  the base address of the memory-mapped register set for the system
+  controller chip.
+
+  Required properties:
+
+    - ranges : Describes the translation of system controller addresses
+      for memory mapped registers.
+    - clock-frequency: Contains the main clock frequency for the system
+      controller chip.
+    - reg : This property defines the address and size of the
+      memory-mapped registers contained within the system controller
+      chip.  The address specified in the "reg" property should match
+      the unit address of the system-controller node.
+    - #address-cells : Address representation for system controller
+      devices.  This field represents the number of cells needed to
+      represent the address of the memory-mapped registers of devices
+      within the system controller chip.
+    - #size-cells : Size representation for for the memory-mapped
+      registers within the system controller chip.
+    - #interrupt-cells : Defines the width of cells used to represent
+      interrupts.
+
+  Optional properties:
+
+    - model : The specific model of the system controller chip.  Such
+      as, "mv64360", "mv64460", or "mv64560".
+    - compatible : A string identifying the compatibility identifiers
+      of the system controller chip.
+
+  The system-controller node contains child nodes for each system
+  controller device that the platform uses.  Nodes should not be created
+  for devices which exist on the system controller chip but are not used
+
+  Example Marvell Discovery mv64360 system-controller node:
+
+    system-controller@f1000000 { /* Marvell Discovery mv64360 */
+	    #address-cells = <1>;
+	    #size-cells = <1>;
+	    model = "mv64360";                      /* Default */
+	    compatible = "marvell,mv64360";
+	    clock-frequency = <133333333>;
+	    reg = <0xf1000000 0x10000>;
+	    virtual-reg = <0xf1000000>;
+	    ranges = <0x88000000 0x88000000 0x1000000 /* PCI 0 I/O Space */
+		    0x80000000 0x80000000 0x8000000 /* PCI 0 MEM Space */
+		    0xa0000000 0xa0000000 0x4000000 /* User FLASH */
+		    0x00000000 0xf1000000 0x0010000 /* Bridge's regs */
+		    0xf2000000 0xf2000000 0x0040000>;/* Integrated SRAM */
+
+	    [ child node definitions... ]
+    }
+
+2) Child nodes of /system-controller
+
+   a) Marvell Discovery MDIO bus
+
+   The MDIO is a bus to which the PHY devices are connected.  For each
+   device that exists on this bus, a child node should be created.  See
+   the definition of the PHY node below for an example of how to define
+   a PHY.
+
+   Required properties:
+     - #address-cells : Should be <1>
+     - #size-cells : Should be <0>
+     - device_type : Should be "mdio"
+     - compatible : Should be "marvell,mv64360-mdio"
+
+   Example:
+
+     mdio {
+	     #address-cells = <1>;
+	     #size-cells = <0>;
+	     device_type = "mdio";
+	     compatible = "marvell,mv64360-mdio";
+
+	     ethernet-phy@0 {
+		     ......
+	     };
+     };
+
+
+   b) Marvell Discovery ethernet controller
+
+   The Discover ethernet controller is described with two levels
+   of nodes.  The first level describes an ethernet silicon block
+   and the second level describes up to 3 ethernet nodes within
+   that block.  The reason for the multiple levels is that the
+   registers for the node are interleaved within a single set
+   of registers.  The "ethernet-block" level describes the
+   shared register set, and the "ethernet" nodes describe ethernet
+   port-specific properties.
+
+   Ethernet block node
+
+   Required properties:
+     - #address-cells : <1>
+     - #size-cells : <0>
+     - compatible : "marvell,mv64360-eth-block"
+     - reg : Offset and length of the register set for this block
+
+   Example Discovery Ethernet block node:
+     ethernet-block@2000 {
+	     #address-cells = <1>;
+	     #size-cells = <0>;
+	     compatible = "marvell,mv64360-eth-block";
+	     reg = <0x2000 0x2000>;
+	     ethernet@0 {
+		     .......
+	     };
+     };
+
+   Ethernet port node
+
+   Required properties:
+     - device_type : Should be "network".
+     - compatible : Should be "marvell,mv64360-eth".
+     - reg : Should be <0>, <1>, or <2>, according to which registers
+       within the silicon block the device uses.
+     - interrupts : <a> where a is the interrupt number for the port.
+     - interrupt-parent : the phandle for the interrupt controller
+       that services interrupts for this device.
+     - phy : the phandle for the PHY connected to this ethernet
+       controller.
+     - local-mac-address : 6 bytes, MAC address
+
+   Example Discovery Ethernet port node:
+     ethernet@0 {
+	     device_type = "network";
+	     compatible = "marvell,mv64360-eth";
+	     reg = <0>;
+	     interrupts = <32>;
+	     interrupt-parent = <&PIC>;
+	     phy = <&PHY0>;
+	     local-mac-address = [ 00 00 00 00 00 00 ];
+     };
+
+
+
+   c) Marvell Discovery PHY nodes
+
+   Required properties:
+     - device_type : Should be "ethernet-phy"
+     - interrupts : <a> where a is the interrupt number for this phy.
+     - interrupt-parent : the phandle for the interrupt controller that
+       services interrupts for this device.
+     - reg : The ID number for the phy, usually a small integer
+
+   Example Discovery PHY node:
+     ethernet-phy@1 {
+	     device_type = "ethernet-phy";
+	     compatible = "broadcom,bcm5421";
+	     interrupts = <76>;      /* GPP 12 */
+	     interrupt-parent = <&PIC>;
+	     reg = <1>;
+     };
+
+
+   d) Marvell Discovery SDMA nodes
+
+   Represent DMA hardware associated with the MPSC (multiprotocol
+   serial controllers).
+
+   Required properties:
+     - compatible : "marvell,mv64360-sdma"
+     - reg : Offset and length of the register set for this device
+     - interrupts : <a> where a is the interrupt number for the DMA
+       device.
+     - interrupt-parent : the phandle for the interrupt controller
+       that services interrupts for this device.
+
+   Example Discovery SDMA node:
+     sdma@4000 {
+	     compatible = "marvell,mv64360-sdma";
+	     reg = <0x4000 0xc18>;
+	     virtual-reg = <0xf1004000>;
+	     interrupts = <36>;
+	     interrupt-parent = <&PIC>;
+     };
+
+
+   e) Marvell Discovery BRG nodes
+
+   Represent baud rate generator hardware associated with the MPSC
+   (multiprotocol serial controllers).
+
+   Required properties:
+     - compatible : "marvell,mv64360-brg"
+     - reg : Offset and length of the register set for this device
+     - clock-src : A value from 0 to 15 which selects the clock
+       source for the baud rate generator.  This value corresponds
+       to the CLKS value in the BRGx configuration register.  See
+       the mv64x60 User's Manual.
+     - clock-frequence : The frequency (in Hz) of the baud rate
+       generator's input clock.
+     - current-speed : The current speed setting (presumably by
+       firmware) of the baud rate generator.
+
+   Example Discovery BRG node:
+     brg@b200 {
+	     compatible = "marvell,mv64360-brg";
+	     reg = <0xb200 0x8>;
+	     clock-src = <8>;
+	     clock-frequency = <133333333>;
+	     current-speed = <9600>;
+     };
+
+
+   f) Marvell Discovery CUNIT nodes
+
+   Represent the Serial Communications Unit device hardware.
+
+   Required properties:
+     - reg : Offset and length of the register set for this device
+
+   Example Discovery CUNIT node:
+     cunit@f200 {
+	     reg = <0xf200 0x200>;
+     };
+
+
+   g) Marvell Discovery MPSCROUTING nodes
+
+   Represent the Discovery's MPSC routing hardware
+
+   Required properties:
+     - reg : Offset and length of the register set for this device
+
+   Example Discovery CUNIT node:
+     mpscrouting@b500 {
+	     reg = <0xb400 0xc>;
+     };
+
+
+   h) Marvell Discovery MPSCINTR nodes
+
+   Represent the Discovery's MPSC DMA interrupt hardware registers
+   (SDMA cause and mask registers).
+
+   Required properties:
+     - reg : Offset and length of the register set for this device
+
+   Example Discovery MPSCINTR node:
+     mpsintr@b800 {
+	     reg = <0xb800 0x100>;
+     };
+
+
+   i) Marvell Discovery MPSC nodes
+
+   Represent the Discovery's MPSC (Multiprotocol Serial Controller)
+   serial port.
+
+   Required properties:
+     - device_type : "serial"
+     - compatible : "marvell,mv64360-mpsc"
+     - reg : Offset and length of the register set for this device
+     - sdma : the phandle for the SDMA node used by this port
+     - brg : the phandle for the BRG node used by this port
+     - cunit : the phandle for the CUNIT node used by this port
+     - mpscrouting : the phandle for the MPSCROUTING node used by this port
+     - mpscintr : the phandle for the MPSCINTR node used by this port
+     - cell-index : the hardware index of this cell in the MPSC core
+     - max_idle : value needed for MPSC CHR3 (Maximum Frame Length)
+       register
+     - interrupts : <a> where a is the interrupt number for the MPSC.
+     - interrupt-parent : the phandle for the interrupt controller
+       that services interrupts for this device.
+
+   Example Discovery MPSCINTR node:
+     mpsc@8000 {
+	     device_type = "serial";
+	     compatible = "marvell,mv64360-mpsc";
+	     reg = <0x8000 0x38>;
+	     virtual-reg = <0xf1008000>;
+	     sdma = <&SDMA0>;
+	     brg = <&BRG0>;
+	     cunit = <&CUNIT>;
+	     mpscrouting = <&MPSCROUTING>;
+	     mpscintr = <&MPSCINTR>;
+	     cell-index = <0>;
+	     max_idle = <40>;
+	     interrupts = <40>;
+	     interrupt-parent = <&PIC>;
+     };
+
+
+   j) Marvell Discovery Watch Dog Timer nodes
+
+   Represent the Discovery's watchdog timer hardware
+
+   Required properties:
+     - compatible : "marvell,mv64360-wdt"
+     - reg : Offset and length of the register set for this device
+
+   Example Discovery Watch Dog Timer node:
+     wdt@b410 {
+	     compatible = "marvell,mv64360-wdt";
+	     reg = <0xb410 0x8>;
+     };
+
+
+   k) Marvell Discovery I2C nodes
+
+   Represent the Discovery's I2C hardware
+
+   Required properties:
+     - device_type : "i2c"
+     - compatible : "marvell,mv64360-i2c"
+     - reg : Offset and length of the register set for this device
+     - interrupts : <a> where a is the interrupt number for the I2C.
+     - interrupt-parent : the phandle for the interrupt controller
+       that services interrupts for this device.
+
+   Example Discovery I2C node:
+	     compatible = "marvell,mv64360-i2c";
+	     reg = <0xc000 0x20>;
+	     virtual-reg = <0xf100c000>;
+	     interrupts = <37>;
+	     interrupt-parent = <&PIC>;
+     };
+
+
+   l) Marvell Discovery PIC (Programmable Interrupt Controller) nodes
+
+   Represent the Discovery's PIC hardware
+
+   Required properties:
+     - #interrupt-cells : <1>
+     - #address-cells : <0>
+     - compatible : "marvell,mv64360-pic"
+     - reg : Offset and length of the register set for this device
+     - interrupt-controller
+
+   Example Discovery PIC node:
+     pic {
+	     #interrupt-cells = <1>;
+	     #address-cells = <0>;
+	     compatible = "marvell,mv64360-pic";
+	     reg = <0x0 0x88>;
+	     interrupt-controller;
+     };
+
+
+   m) Marvell Discovery MPP (Multipurpose Pins) multiplexing nodes
+
+   Represent the Discovery's MPP hardware
+
+   Required properties:
+     - compatible : "marvell,mv64360-mpp"
+     - reg : Offset and length of the register set for this device
+
+   Example Discovery MPP node:
+     mpp@f000 {
+	     compatible = "marvell,mv64360-mpp";
+	     reg = <0xf000 0x10>;
+     };
+
+
+   n) Marvell Discovery GPP (General Purpose Pins) nodes
+
+   Represent the Discovery's GPP hardware
+
+   Required properties:
+     - compatible : "marvell,mv64360-gpp"
+     - reg : Offset and length of the register set for this device
+
+   Example Discovery GPP node:
+     gpp@f000 {
+	     compatible = "marvell,mv64360-gpp";
+	     reg = <0xf100 0x20>;
+     };
+
+
+   o) Marvell Discovery PCI host bridge node
+
+   Represents the Discovery's PCI host bridge device.  The properties
+   for this node conform to Rev 2.1 of the PCI Bus Binding to IEEE
+   1275-1994.  A typical value for the compatible property is
+   "marvell,mv64360-pci".
+
+   Example Discovery PCI host bridge node
+     pci@80000000 {
+	     #address-cells = <3>;
+	     #size-cells = <2>;
+	     #interrupt-cells = <1>;
+	     device_type = "pci";
+	     compatible = "marvell,mv64360-pci";
+	     reg = <0xcf8 0x8>;
+	     ranges = <0x01000000 0x0        0x0
+			     0x88000000 0x0 0x01000000
+		       0x02000000 0x0 0x80000000
+			     0x80000000 0x0 0x08000000>;
+	     bus-range = <0 255>;
+	     clock-frequency = <66000000>;
+	     interrupt-parent = <&PIC>;
+	     interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
+	     interrupt-map = <
+		     /* IDSEL 0x0a */
+		     0x5000 0 0 1 &PIC 80
+		     0x5000 0 0 2 &PIC 81
+		     0x5000 0 0 3 &PIC 91
+		     0x5000 0 0 4 &PIC 93
+
+		     /* IDSEL 0x0b */
+		     0x5800 0 0 1 &PIC 91
+		     0x5800 0 0 2 &PIC 93
+		     0x5800 0 0 3 &PIC 80
+		     0x5800 0 0 4 &PIC 81
+
+		     /* IDSEL 0x0c */
+		     0x6000 0 0 1 &PIC 91
+		     0x6000 0 0 2 &PIC 93
+		     0x6000 0 0 3 &PIC 80
+		     0x6000 0 0 4 &PIC 81
+
+		     /* IDSEL 0x0d */
+		     0x6800 0 0 1 &PIC 93
+		     0x6800 0 0 2 &PIC 80
+		     0x6800 0 0 3 &PIC 81
+		     0x6800 0 0 4 &PIC 91
+	     >;
+     };
+
+
+   p) Marvell Discovery CPU Error nodes
+
+   Represent the Discovery's CPU error handler device.
+
+   Required properties:
+     - compatible : "marvell,mv64360-cpu-error"
+     - reg : Offset and length of the register set for this device
+     - interrupts : the interrupt number for this device
+     - interrupt-parent : the phandle for the interrupt controller
+       that services interrupts for this device.
+
+   Example Discovery CPU Error node:
+     cpu-error@0070 {
+	     compatible = "marvell,mv64360-cpu-error";
+	     reg = <0x70 0x10 0x128 0x28>;
+	     interrupts = <3>;
+	     interrupt-parent = <&PIC>;
+     };
+
+
+   q) Marvell Discovery SRAM Controller nodes
+
+   Represent the Discovery's SRAM controller device.
+
+   Required properties:
+     - compatible : "marvell,mv64360-sram-ctrl"
+     - reg : Offset and length of the register set for this device
+     - interrupts : the interrupt number for this device
+     - interrupt-parent : the phandle for the interrupt controller
+       that services interrupts for this device.
+
+   Example Discovery SRAM Controller node:
+     sram-ctrl@0380 {
+	     compatible = "marvell,mv64360-sram-ctrl";
+	     reg = <0x380 0x80>;
+	     interrupts = <13>;
+	     interrupt-parent = <&PIC>;
+     };
+
+
+   r) Marvell Discovery PCI Error Handler nodes
+
+   Represent the Discovery's PCI error handler device.
+
+   Required properties:
+     - compatible : "marvell,mv64360-pci-error"
+     - reg : Offset and length of the register set for this device
+     - interrupts : the interrupt number for this device
+     - interrupt-parent : the phandle for the interrupt controller
+       that services interrupts for this device.
+
+   Example Discovery PCI Error Handler node:
+     pci-error@1d40 {
+	     compatible = "marvell,mv64360-pci-error";
+	     reg = <0x1d40 0x40 0xc28 0x4>;
+	     interrupts = <12>;
+	     interrupt-parent = <&PIC>;
+     };
+
+
+   s) Marvell Discovery Memory Controller nodes
+
+   Represent the Discovery's memory controller device.
+
+   Required properties:
+     - compatible : "marvell,mv64360-mem-ctrl"
+     - reg : Offset and length of the register set for this device
+     - interrupts : the interrupt number for this device
+     - interrupt-parent : the phandle for the interrupt controller
+       that services interrupts for this device.
+
+   Example Discovery Memory Controller node:
+     mem-ctrl@1400 {
+	     compatible = "marvell,mv64360-mem-ctrl";
+	     reg = <0x1400 0x60>;
+	     interrupts = <17>;
+	     interrupt-parent = <&PIC>;
+     };
+
+
diff --git a/Documentation/powerpc/dts-bindings/phy.txt b/Documentation/powerpc/dts-bindings/phy.txt
new file mode 100644
index 0000000..bb8c742
--- /dev/null
+++ b/Documentation/powerpc/dts-bindings/phy.txt
@@ -0,0 +1,25 @@
+PHY nodes
+
+Required properties:
+
+ - device_type : Should be "ethernet-phy"
+ - interrupts : <a b> where a is the interrupt number and b is a
+   field that represents an encoding of the sense and level
+   information for the interrupt.  This should be encoded based on
+   the information in section 2) depending on the type of interrupt
+   controller you have.
+ - interrupt-parent : the phandle for the interrupt controller that
+   services interrupts for this device.
+ - reg : The ID number for the phy, usually a small integer
+ - linux,phandle :  phandle for this node; likely referenced by an
+   ethernet controller node.
+
+Example:
+
+ethernet-phy@0 {
+	linux,phandle = <2452000>
+	interrupt-parent = <40000>;
+	interrupts = <35 1>;
+	reg = <0>;
+	device_type = "ethernet-phy";
+};
diff --git a/Documentation/powerpc/dts-bindings/spi-bus.txt b/Documentation/powerpc/dts-bindings/spi-bus.txt
new file mode 100644
index 0000000..e782add
--- /dev/null
+++ b/Documentation/powerpc/dts-bindings/spi-bus.txt
@@ -0,0 +1,57 @@
+SPI (Serial Peripheral Interface) busses
+
+SPI busses can be described with a node for the SPI master device
+and a set of child nodes for each SPI slave on the bus.  For this
+discussion, it is assumed that the system's SPI controller is in
+SPI master mode.  This binding does not describe SPI controllers
+in slave mode.
+
+The SPI master node requires the following properties:
+- #address-cells  - number of cells required to define a chip select
+    		address on the SPI bus.
+- #size-cells     - should be zero.
+- compatible      - name of SPI bus controller following generic names
+    		recommended practice.
+No other properties are required in the SPI bus node.  It is assumed
+that a driver for an SPI bus device will understand that it is an SPI bus.
+However, the binding does not attempt to define the specific method for
+assigning chip select numbers.  Since SPI chip select configuration is
+flexible and non-standardized, it is left out of this binding with the
+assumption that board specific platform code will be used to manage
+chip selects.  Individual drivers can define additional properties to
+support describing the chip select layout.
+
+SPI slave nodes must be children of the SPI master node and can
+contain the following properties.
+- reg             - (required) chip select address of device.
+- compatible      - (required) name of SPI device following generic names
+    		recommended practice
+- spi-max-frequency - (required) Maximum SPI clocking speed of device in Hz
+- spi-cpol        - (optional) Empty property indicating device requires
+    		inverse clock polarity (CPOL) mode
+- spi-cpha        - (optional) Empty property indicating device requires
+    		shifted clock phase (CPHA) mode
+- spi-cs-high     - (optional) Empty property indicating device requires
+    		chip select active high
+
+SPI example for an MPC5200 SPI bus:
+	spi@f00 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "fsl,mpc5200b-spi","fsl,mpc5200-spi";
+		reg = <0xf00 0x20>;
+		interrupts = <2 13 0 2 14 0>;
+		interrupt-parent = <&mpc5200_pic>;
+
+		ethernet-switch@0 {
+			compatible = "micrel,ks8995m";
+			spi-max-frequency = <1000000>;
+			reg = <0>;
+		};
+
+		codec@1 {
+			compatible = "ti,tlv320aic26";
+			spi-max-frequency = <100000>;
+			reg = <1>;
+		};
+	};
diff --git a/Documentation/powerpc/dts-bindings/usb-ehci.txt b/Documentation/powerpc/dts-bindings/usb-ehci.txt
new file mode 100644
index 0000000..fa18612
--- /dev/null
+++ b/Documentation/powerpc/dts-bindings/usb-ehci.txt
@@ -0,0 +1,25 @@
+USB EHCI controllers
+
+Required properties:
+  - compatible : should be "usb-ehci".
+  - reg : should contain at least address and length of the standard EHCI
+    register set for the device. Optional platform-dependent registers
+    (debug-port or other) can be also specified here, but only after
+    definition of standard EHCI registers.
+  - interrupts : one EHCI interrupt should be described here.
+If device registers are implemented in big endian mode, the device
+node should have "big-endian-regs" property.
+If controller implementation operates with big endian descriptors,
+"big-endian-desc" property should be specified.
+If both big endian registers and descriptors are used by the controller
+implementation, "big-endian" property can be specified instead of having
+both "big-endian-regs" and "big-endian-desc".
+
+Example (Sequoia 440EPx):
+    ehci@e0000300 {
+	   compatible = "ibm,usb-ehci-440epx", "usb-ehci";
+	   interrupt-parent = <&UIC0>;
+	   interrupts = <1a 4>;
+	   reg = <0 e0000300 90 0 e0000390 70>;
+	   big-endian;
+   };
diff --git a/Documentation/powerpc/dts-bindings/xilinx.txt b/Documentation/powerpc/dts-bindings/xilinx.txt
new file mode 100644
index 0000000..80339fe
--- /dev/null
+++ b/Documentation/powerpc/dts-bindings/xilinx.txt
@@ -0,0 +1,295 @@
+   d) Xilinx IP cores
+
+   The Xilinx EDK toolchain ships with a set of IP cores (devices) for use
+   in Xilinx Spartan and Virtex FPGAs.  The devices cover the whole range
+   of standard device types (network, serial, etc.) and miscellaneous
+   devices (gpio, LCD, spi, etc).  Also, since these devices are
+   implemented within the fpga fabric every instance of the device can be
+   synthesised with different options that change the behaviour.
+
+   Each IP-core has a set of parameters which the FPGA designer can use to
+   control how the core is synthesized.  Historically, the EDK tool would
+   extract the device parameters relevant to device drivers and copy them
+   into an 'xparameters.h' in the form of #define symbols.  This tells the
+   device drivers how the IP cores are configured, but it requres the kernel
+   to be recompiled every time the FPGA bitstream is resynthesized.
+
+   The new approach is to export the parameters into the device tree and
+   generate a new device tree each time the FPGA bitstream changes.  The
+   parameters which used to be exported as #defines will now become
+   properties of the device node.  In general, device nodes for IP-cores
+   will take the following form:
+
+	(name): (generic-name)@(base-address) {
+		compatible = "xlnx,(ip-core-name)-(HW_VER)"
+			     [, (list of compatible devices), ...];
+		reg = <(baseaddr) (size)>;
+		interrupt-parent = <&interrupt-controller-phandle>;
+		interrupts = < ... >;
+		xlnx,(parameter1) = "(string-value)";
+		xlnx,(parameter2) = <(int-value)>;
+	};
+
+	(generic-name):   an open firmware-style name that describes the
+			generic class of device.  Preferably, this is one word, such
+			as 'serial' or 'ethernet'.
+	(ip-core-name):	the name of the ip block (given after the BEGIN
+			directive in system.mhs).  Should be in lowercase
+			and all underscores '_' converted to dashes '-'.
+	(name):		is derived from the "PARAMETER INSTANCE" value.
+	(parameter#):	C_* parameters from system.mhs.  The C_ prefix is
+			dropped from the parameter name, the name is converted
+			to lowercase and all underscore '_' characters are
+			converted to dashes '-'.
+	(baseaddr):	the baseaddr parameter value (often named C_BASEADDR).
+	(HW_VER):	from the HW_VER parameter.
+	(size):		the address range size (often C_HIGHADDR - C_BASEADDR + 1).
+
+   Typically, the compatible list will include the exact IP core version
+   followed by an older IP core version which implements the same
+   interface or any other device with the same interface.
+
+   'reg', 'interrupt-parent' and 'interrupts' are all optional properties.
+
+   For example, the following block from system.mhs:
+
+	BEGIN opb_uartlite
+		PARAMETER INSTANCE = opb_uartlite_0
+		PARAMETER HW_VER = 1.00.b
+		PARAMETER C_BAUDRATE = 115200
+		PARAMETER C_DATA_BITS = 8
+		PARAMETER C_ODD_PARITY = 0
+		PARAMETER C_USE_PARITY = 0
+		PARAMETER C_CLK_FREQ = 50000000
+		PARAMETER C_BASEADDR = 0xEC100000
+		PARAMETER C_HIGHADDR = 0xEC10FFFF
+		BUS_INTERFACE SOPB = opb_7
+		PORT OPB_Clk = CLK_50MHz
+		PORT Interrupt = opb_uartlite_0_Interrupt
+		PORT RX = opb_uartlite_0_RX
+		PORT TX = opb_uartlite_0_TX
+		PORT OPB_Rst = sys_bus_reset_0
+	END
+
+   becomes the following device tree node:
+
+	opb_uartlite_0: serial@ec100000 {
+		device_type = "serial";
+		compatible = "xlnx,opb-uartlite-1.00.b";
+		reg = <ec100000 10000>;
+		interrupt-parent = <&opb_intc_0>;
+		interrupts = <1 0>; // got this from the opb_intc parameters
+		current-speed = <d#115200>;	// standard serial device prop
+		clock-frequency = <d#50000000>;	// standard serial device prop
+		xlnx,data-bits = <8>;
+		xlnx,odd-parity = <0>;
+		xlnx,use-parity = <0>;
+	};
+
+   Some IP cores actually implement 2 or more logical devices.  In
+   this case, the device should still describe the whole IP core with
+   a single node and add a child node for each logical device.  The
+   ranges property can be used to translate from parent IP-core to the
+   registers of each device.  In addition, the parent node should be
+   compatible with the bus type 'xlnx,compound', and should contain
+   #address-cells and #size-cells, as with any other bus.  (Note: this
+   makes the assumption that both logical devices have the same bus
+   binding.  If this is not true, then separate nodes should be used
+   for each logical device).  The 'cell-index' property can be used to
+   enumerate logical devices within an IP core.  For example, the
+   following is the system.mhs entry for the dual ps2 controller found
+   on the ml403 reference design.
+
+	BEGIN opb_ps2_dual_ref
+		PARAMETER INSTANCE = opb_ps2_dual_ref_0
+		PARAMETER HW_VER = 1.00.a
+		PARAMETER C_BASEADDR = 0xA9000000
+		PARAMETER C_HIGHADDR = 0xA9001FFF
+		BUS_INTERFACE SOPB = opb_v20_0
+		PORT Sys_Intr1 = ps2_1_intr
+		PORT Sys_Intr2 = ps2_2_intr
+		PORT Clkin1 = ps2_clk_rx_1
+		PORT Clkin2 = ps2_clk_rx_2
+		PORT Clkpd1 = ps2_clk_tx_1
+		PORT Clkpd2 = ps2_clk_tx_2
+		PORT Rx1 = ps2_d_rx_1
+		PORT Rx2 = ps2_d_rx_2
+		PORT Txpd1 = ps2_d_tx_1
+		PORT Txpd2 = ps2_d_tx_2
+	END
+
+   It would result in the following device tree nodes:
+
+	opb_ps2_dual_ref_0: opb-ps2-dual-ref@a9000000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "xlnx,compound";
+		ranges = <0 a9000000 2000>;
+		// If this device had extra parameters, then they would
+		// go here.
+		ps2@0 {
+			compatible = "xlnx,opb-ps2-dual-ref-1.00.a";
+			reg = <0 40>;
+			interrupt-parent = <&opb_intc_0>;
+			interrupts = <3 0>;
+			cell-index = <0>;
+		};
+		ps2@1000 {
+			compatible = "xlnx,opb-ps2-dual-ref-1.00.a";
+			reg = <1000 40>;
+			interrupt-parent = <&opb_intc_0>;
+			interrupts = <3 0>;
+			cell-index = <0>;
+		};
+	};
+
+   Also, the system.mhs file defines bus attachments from the processor
+   to the devices.  The device tree structure should reflect the bus
+   attachments.  Again an example; this system.mhs fragment:
+
+	BEGIN ppc405_virtex4
+		PARAMETER INSTANCE = ppc405_0
+		PARAMETER HW_VER = 1.01.a
+		BUS_INTERFACE DPLB = plb_v34_0
+		BUS_INTERFACE IPLB = plb_v34_0
+	END
+
+	BEGIN opb_intc
+		PARAMETER INSTANCE = opb_intc_0
+		PARAMETER HW_VER = 1.00.c
+		PARAMETER C_BASEADDR = 0xD1000FC0
+		PARAMETER C_HIGHADDR = 0xD1000FDF
+		BUS_INTERFACE SOPB = opb_v20_0
+	END
+
+	BEGIN opb_uart16550
+		PARAMETER INSTANCE = opb_uart16550_0
+		PARAMETER HW_VER = 1.00.d
+		PARAMETER C_BASEADDR = 0xa0000000
+		PARAMETER C_HIGHADDR = 0xa0001FFF
+		BUS_INTERFACE SOPB = opb_v20_0
+	END
+
+	BEGIN plb_v34
+		PARAMETER INSTANCE = plb_v34_0
+		PARAMETER HW_VER = 1.02.a
+	END
+
+	BEGIN plb_bram_if_cntlr
+		PARAMETER INSTANCE = plb_bram_if_cntlr_0
+		PARAMETER HW_VER = 1.00.b
+		PARAMETER C_BASEADDR = 0xFFFF0000
+		PARAMETER C_HIGHADDR = 0xFFFFFFFF
+		BUS_INTERFACE SPLB = plb_v34_0
+	END
+
+	BEGIN plb2opb_bridge
+		PARAMETER INSTANCE = plb2opb_bridge_0
+		PARAMETER HW_VER = 1.01.a
+		PARAMETER C_RNG0_BASEADDR = 0x20000000
+		PARAMETER C_RNG0_HIGHADDR = 0x3FFFFFFF
+		PARAMETER C_RNG1_BASEADDR = 0x60000000
+		PARAMETER C_RNG1_HIGHADDR = 0x7FFFFFFF
+		PARAMETER C_RNG2_BASEADDR = 0x80000000
+		PARAMETER C_RNG2_HIGHADDR = 0xBFFFFFFF
+		PARAMETER C_RNG3_BASEADDR = 0xC0000000
+		PARAMETER C_RNG3_HIGHADDR = 0xDFFFFFFF
+		BUS_INTERFACE SPLB = plb_v34_0
+		BUS_INTERFACE MOPB = opb_v20_0
+	END
+
+   Gives this device tree (some properties removed for clarity):
+
+	plb@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "xlnx,plb-v34-1.02.a";
+		device_type = "ibm,plb";
+		ranges; // 1:1 translation
+
+		plb_bram_if_cntrl_0: bram@ffff0000 {
+			reg = <ffff0000 10000>;
+		}
+
+		opb@20000000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <20000000 20000000 20000000
+				  60000000 60000000 20000000
+				  80000000 80000000 40000000
+				  c0000000 c0000000 20000000>;
+
+			opb_uart16550_0: serial@a0000000 {
+				reg = <a00000000 2000>;
+			};
+
+			opb_intc_0: interrupt-controller@d1000fc0 {
+				reg = <d1000fc0 20>;
+			};
+		};
+	};
+
+   That covers the general approach to binding xilinx IP cores into the
+   device tree.  The following are bindings for specific devices:
+
+      i) Xilinx ML300 Framebuffer
+
+      Simple framebuffer device from the ML300 reference design (also on the
+      ML403 reference design as well as others).
+
+      Optional properties:
+       - resolution = <xres yres> : pixel resolution of framebuffer.  Some
+                                    implementations use a different resolution.
+                                    Default is <d#640 d#480>
+       - virt-resolution = <xvirt yvirt> : Size of framebuffer in memory.
+                                           Default is <d#1024 d#480>.
+       - rotate-display (empty) : rotate display 180 degrees.
+
+      ii) Xilinx SystemACE
+
+      The Xilinx SystemACE device is used to program FPGAs from an FPGA
+      bitstream stored on a CF card.  It can also be used as a generic CF
+      interface device.
+
+      Optional properties:
+       - 8-bit (empty) : Set this property for SystemACE in 8 bit mode
+
+      iii) Xilinx EMAC and Xilinx TEMAC
+
+      Xilinx Ethernet devices.  In addition to general xilinx properties
+      listed above, nodes for these devices should include a phy-handle
+      property, and may include other common network device properties
+      like local-mac-address.
+
+      iv) Xilinx Uartlite
+
+      Xilinx uartlite devices are simple fixed speed serial ports.
+
+      Required properties:
+       - current-speed : Baud rate of uartlite
+
+      v) Xilinx hwicap
+
+		Xilinx hwicap devices provide access to the configuration logic
+		of the FPGA through the Internal Configuration Access Port
+		(ICAP).  The ICAP enables partial reconfiguration of the FPGA,
+		readback of the configuration information, and some control over
+		'warm boots' of the FPGA fabric.
+
+		Required properties:
+		- xlnx,family : The family of the FPGA, necessary since the
+                      capabilities of the underlying ICAP hardware
+                      differ between different families.  May be
+                      'virtex2p', 'virtex4', or 'virtex5'.
+
+      vi) Xilinx Uart 16550
+
+      Xilinx UART 16550 devices are very similar to the NS16550 but with
+      different register spacing and an offset from the base address.
+
+      Required properties:
+       - clock-frequency : Frequency of the clock input
+       - reg-offset : A value of 3 is required
+       - reg-shift : A value of 2 is required
+
+
-- 
1.6.0.6
