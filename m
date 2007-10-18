Return-Path: <grant.likely@secretlab.ca>
Received: from pd2mo2so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id EC8DADDEC9
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 03:23:27 +1000 (EST)
Received: from pd2mr1so.prod.shaw.ca
	(pd2mr1so-qfe3.prod.shaw.ca [10.0.141.110]) by l-daemon
	(Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
	with ESMTP id <0JQ400G64AY55850@l-daemon> for linuxppc-dev@ozlabs.org;
	Thu, 18 Oct 2007 11:22:53 -0600 (MDT)
Received: from pn2ml8so.prod.shaw.ca ([10.0.121.152])
	by pd2mr1so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JQ400DIRAY2MC90@pd2mr1so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Thu, 18 Oct 2007 11:22:53 -0600 (MDT)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JQ400LURAY195G1@l-daemon> for linuxppc-dev@ozlabs.org;
	Thu, 18 Oct 2007 11:22:50 -0600 (MDT)
Date: Thu, 18 Oct 2007 11:22:59 -0600
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH v3] Device tree bindings for Xilinx devices
To: linuxppc-dev@ozlabs.org,
	Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>,
	Wolfgang Reissnegger <wre@xilinx.com>, Leonid <Leonid@a-k-a.net>,
	microblaze-uclinux@itee.uq.edu.au,
	Josh Boyer <jwboyer@linux.vnet.ibm.com>, Arnd Bergmann <arnd@arndb.de>
Message-id: <20071018172259.14948.74736.stgit@trillian.cg.shawcable.net>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 Documentation/powerpc/booting-without-of.txt |  264 ++++++++++++++++++++++++++
 1 files changed, 264 insertions(+), 0 deletions(-)

diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
index a96e853..d4dedf4 100644
--- a/Documentation/powerpc/booting-without-of.txt
+++ b/Documentation/powerpc/booting-without-of.txt
@@ -52,6 +52,7 @@ Table of Contents
       i) Freescale QUICC Engine module (QE)
       j) CFI or JEDEC memory-mapped NOR flash
       k) Global Utilities Block
+      l) Xilinx IP cores
 
   VII - Specifying interrupt information for devices
     1) interrupts property
@@ -2242,6 +2243,269 @@ platforms are moved over to use the flattened-device-tree model.
 			   available.
 			   For Axon: 0x0000012a
 
+   l) Xilinx IP cores
+
+   The Xilinx EDK toolchain ships with a set of IP cores (devices) for use
+   in Xilinx Spartan and Virtex FPGAs.  The devices cover the whole range
+   of standard device types (network, serial, etc.) and miscellanious
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
+	(name)@(base-address) {
+		compatible = "xilinx,(ip-core-name)-(HW_VER)"
+			     [, (list of compatible devices), ...];
+		reg = <(baseaddr) (size)>;
+		interrupt-parent = <&interrupt-controller-phandle>;
+		interrupts = < ... >;
+		xilinx,(parameter1) = "(string-value)";
+		xilinx,(parameter2) = <(int-value)>;
+	};
+
+	(ip-core-name):	the name of the ip block (given after the BEGIN
+			directive in system.mhs).  Should be in lowercase
+			and all underscores '_' converted to dashes '-'.
+	(name):		is derived from the "PARAMETER INSTANCE" value.
+	(parameter#):	C_* parameters from system.mhs.  The C_ prefix is
+			dropped from the parameter name, the name is converted
+			to lowercase and all underscore '_' characters are
+			converted to dashes '-'.
+	(baseaddr):	the C_BASEADDR parameter.
+	(HW_VER):	from the HW_VER parameter.
+	(size):		equals C_HIGHADDR - C_BASEADDR + 1
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
+	opb-uartlite-0@ec100000 {
+		device_type = "serial";
+		compatible = "xilinx,opb-uartlite-1.00.b";
+		reg = <ec100000 10000>;
+		interrupt-parent = <&opb-intc>;
+		interrupts = <1 0>; // got this from the opb_intc parameters
+		current-speed = <d#115200>;	// standard serial device prop
+		clock-frequency = <d#50000000>;	// standard serial device prop
+		xilinx,data-bits = <8>;
+		xilinx,odd-parity = <0>;
+		xilinx,use-parity = <0>;
+	};
+
+   Some IP cores actually implement 2 or more logical devices.  In this case,
+   the device should still describe the whole IP core with a single node
+   and add a child node for each logical device.  The ranges property can
+   be used to translate from parent IP-core to the registers of each device.
+   (Note: this makes the assumption that both logical devices have the same
+   bus binding.  If this is not true, then separate nodes should be used for
+   each logical device).  The 'cell-index' property can be used to enumerate
+   logical devices within an IP core.  For example, the following is the
+   system.mhs entry for the dual ps2 controller found on the ml403 reference
+   design.
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
+	opb_ps2_dual_ref_0@a9000000 {
+		ranges = <0 a9000000 2000>;
+		// If this device had extra parameters, then they would
+		// go here.
+		ps2@0 {
+			compatible = "xilinx,opb-ps2-dual-ref-1.00.a";
+			reg = <0 40>;
+			interrupt-parent = <&opb-intc>;
+			interrupts = <3 0>;
+			cell-index = <0>;
+		};
+		ps2@1000 {
+			compatible = "xilinx,opb-ps2-dual-ref-1.00.a";
+			reg = <1000 40>;
+			interrupt-parent = <&opb-intc>;
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
+	plb-v34-0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		device_type = "ibm,plb";
+		ranges; // 1:1 translation
+
+		plb-bram-if-cntrl-0@ffff0000 {
+			reg = <ffff0000 10000>;
+		}
+
+		opb-v20-0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <20000000 20000000 20000000
+				  60000000 60000000 20000000
+				  80000000 80000000 40000000
+				  c0000000 c0000000 20000000>;
+
+			opb-uart16550-0@a0000000 {
+				reg = <a00000000 2000>;
+			};
+
+			opb-intc-0@d1000fc0 {
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
+       - resolution : <xres yres> pixel resolution of framebuffer.  Some
+                      implementations use a different resolution.  Default
+                      is <d#640 d#480>
+       - virt-resolution : <xvirt yvirt> Size of framebuffer in memory.
+                           Default is <d#1024 d#480>.
+       - rotate-display (empty) : rotate display 180 degrees.
+
+      ii) Xilinx SystemACE
+
+      The Xilinx SystemACE device is used to program FPGAs from an FPGA
+      bitstream stored on a CF card.  It can also be used as a generic CF
+      interface device.
+
+      Required properties:
+       - compatible : Should include "xilinx,sysace" in the list
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
+      Requred properties:
+       - current-speed : Baud rate of uartlite
+
    More devices will be defined as this spec matures.
 
 VII - Specifying interrupt information for devices
