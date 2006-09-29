Return-Path: <LeoLi@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id C87B567C24
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Sep 2006 20:35:08 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	k8TAZ45S017012
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Sep 2006 03:35:04 -0700 (MST)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k8TAYjhw011994
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Sep 2006 05:35:02 -0500 (CDT)
Message-ID: <451CF6F9.40904@freescale.com>
Date: Fri, 29 Sep 2006 18:35:37 +0800
From: Li Yang <leoli@freescale.com>
MIME-Version: 1.0
To: paulus@samba.org
Subject: [PATCH 9/9] Add QE device tree node definition
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Here is OF device tree node spec used in QE/8360 support patches.

Signed-off-by: Li Yang <leoli@freescale.com>
Signed-off-by: Jiang Bo <Tanya.jiang@freescale.com>
Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com> 

---
 Documentation/powerpc/booting-without-of.txt |  253 ++++++++++++++++++++++++++
 1 files changed, 253 insertions(+), 0 deletions(-)

diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
index 5c0ba23..5d6fcd0 100644
--- a/Documentation/powerpc/booting-without-of.txt
+++ b/Documentation/powerpc/booting-without-of.txt
@@ -1441,6 +1441,258 @@ platforms are moved over to use the flat
                descriptor-types-mask = <012b0ebf>;
        };
 
+   h) Board Control and Status (BCSR)
+   
+   Required properties:
+
+    - device_type : Should be "board-control"
+    - reg : Offset and length of the register set for the device
+
+    Example:
+
+	bcsr@f8000000 {
+		device_type = "board-control";
+		reg = <f8000000 8000>;
+	};
+
+   i) Freescale QUICC Engine module (QE)
+   This represents qe module that is installed on PowerQUICC II Pro.
+   Hopefully it will merge backward compatibility with CPM/CPM2.
+   Basically, it is a bus of devices, that could act more or less
+   as a complete entity (UCC, USB etc ). All of them should be siblings on
+   the "root" qe node, using the common properties from there.
+   The description below applies to the the qe of MPC8360 and
+   more nodes and properties would be extended in the future.
+
+   i) Root QE device
+
+   Required properties:
+   - device_type : should be "qe";
+   - model : precise model of the QE, Can be "QE", "CPM", or "CPM2"
+   - reg : offset and length of the device registers.
+   - bus-frequency : the clock frequency for QUICC Engine.
+  
+   Recommended properties
+   - brg-frequency : the internal clock source frequency for baud-rate
+     generators in Hz.
+
+   Example:
+	qe@e0100000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		#interrupt-cells = <2>;
+		device_type = "qe";
+		model = "QE";
+		ranges = <0 e0100000 00100000>;
+		reg = <e0100000 480>;
+		brg-frequency = <0>;
+		bus-frequency = <179A7B00>;
+	}
+
+
+   ii) SPI (Serial Peripheral Interface)
+
+   Required properties:
+   - device_type : should be "spi".
+   - compatible : should be "fsl_spi".
+   - mode : the spi operation mode, it can be "cpu" or "qe".
+   - reg : Offset and length of the register set for the device
+   - interrupts : <a b> where a is the interrupt number and b is a
+     field that represents an encoding of the sense and level
+     information for the interrupt.  This should be encoded based on
+     the information in section 2) depending on the type of interrupt
+     controller you have.
+   - interrupt-parent : the phandle for the interrupt controller that
+     services interrupts for this device.
+
+   Example:
+	spi@4c0 {
+		device_type = "spi";
+		compatible = "fsl_spi";
+		reg = <4c0 40>;
+		interrupts = <82 0>;
+		interrupt-parent = <700>;
+		mode = "cpu";
+	};
+
+
+   iii) USB (Universal Serial Bus Controller)
+
+   Required properties:
+   - device_type : should be "usb".
+   - compatible : could be "qe_udc" or "fhci-hcd".
+   - mode : the could be "host" or "slave".
+   - reg : Offset and length of the register set for the device
+   - interrupts : <a b> where a is the interrupt number and b is a
+     field that represents an encoding of the sense and level
+     information for the interrupt.  This should be encoded based on
+     the information in section 2) depending on the type of interrupt
+     controller you have.
+   - interrupt-parent : the phandle for the interrupt controller that
+     services interrupts for this device.
+
+   Example(slave):
+	usb@6c0 {
+		device_type = "usb";
+		compatible = "qe_udc";
+		reg = <6c0 40>;
+		interrupts = <8b 0>;
+		interrupt-parent = <700>;
+		mode = "slave";
+	};
+
+
+   iv) UCC (Unified Communications Controllers)
+
+   Required properties:
+   - device_type : should be "network", "hldc", "uart", "transparent"
+    "bisync" or "atm".
+   - compatible : could be "ucc_geth" or "fsl_atm" and so on.
+   - model : should be "UCC".
+   - device-id : the ucc number(1-8), corresponding to UCCx in UM.
+   - reg : Offset and length of the register set for the device
+   - interrupts : <a b> where a is the interrupt number and b is a
+     field that represents an encoding of the sense and level
+     information for the interrupt.  This should be encoded based on
+     the information in section 2) depending on the type of interrupt
+     controller you have.
+   - interrupt-parent : the phandle for the interrupt controller that
+     services interrupts for this device.
+   - pio-handle : The phandle for the Parallel I/O port configuration.
+   - rx-clock : represents the UCC receive clock source.
+     0x00 : clock source is disabled;
+     0x1~0x10 : clock source is BRG1~BRG16 respectively;
+     0x11~0x28: clock source is QE_CLK1~QE_CLK24 respectively.
+   - tx-clock: represents the UCC transmit clock source;
+     0x00 : clock source is disabled;
+     0x1~0x10 : clock source is BRG1~BRG16 respectively;
+     0x11~0x28: clock source is QE_CLK1~QE_CLK24 respectively.
+
+   Required properties for network device_type:
+   - mac-address : list of bytes representing the ethernet address.
+   - phy-handle : The phandle for the PHY connected to this controller.
+
+   Example:
+	ucc@2000 {
+		device_type = "network";
+		compatible = "ucc_geth";
+		model = "UCC";
+		device-id = <1>;
+		reg = <2000 200>;
+		interrupts = <a0 0>;
+		interrupt-parent = <700>;
+		mac-address = [ 00 04 9f 00 23 23 ];
+		rx-clock = "none";
+		tx-clock = "clk9";
+		phy-handle = <212000>;
+		pio-handle = <140001>;
+	};
+
+
+   v) Parallel I/O Ports
+
+   This node configures Parallel I/O ports for CPUs with QE support.
+   The node should reside in the "soc" node of the tree.  For each
+   device that using parallel I/O ports, a child node should be created.
+   See the definition of the Pin configuration nodes below for more
+   information.
+
+   Required properties:
+   - device_type : should be "par_io".
+   - reg : offset to the register set and its length.
+   - num-ports : number of Parallel I/O ports
+
+   Example:
+	par_io@1400 {
+		reg = <1400 100>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		device_type = "par_io";
+		num-ports = <7>;
+		ucc_pin@01 {
+			......
+		};
+
+
+   vi) Pin configuration nodes
+
+   Required properties:
+   - linux,phandle : phandle of this node; likely referenced by a QE
+     device.
+   - pio-map : array of pin configurations.  Each pin is defined by 6
+     integers.  The six numbers are respectively: port, pin, dir,
+     open_drain, assignment, has_irq.
+     - port : port number of the pin; 0-6 represent port A-G in UM.
+     - pin : pin number in the port.
+     - dir : direction of the pin, should encode as follows:
+
+	0 = The pin is disabled
+	1 = The pin is an output
+	2 = The pin is an input
+	3 = The pin is I/O
+
+     - open_drain : indicates the pin is normal or wired-OR:
+
+	0 = The pin is actively driven as an output
+	1 = The pin is an open-drain driver. As an output, the pin is
+	    driven active-low, otherwise it is three-stated.
+
+     - assignment : function number of the pin according to the Pin Assignment
+       tables in User Manual.  Each pin can have up to 4 possible functions in
+       QE and two options for CPM.
+     - has_irq : indicates if the pin is used as source of exteral
+       interrupts.
+
+   Example:
+	ucc_pin@01 {
+		linux,phandle = <140001>;
+		pio-map = <
+		/* port  pin  dir  open_drain  assignment  has_irq */
+			0  3  1  0  1  0 	/* TxD0 */
+			0  4  1  0  1  0 	/* TxD1 */
+			0  5  1  0  1  0 	/* TxD2 */
+			0  6  1  0  1  0 	/* TxD3 */
+			1  6  1  0  3  0 	/* TxD4 */
+			1  7  1  0  1  0 	/* TxD5 */
+			1  9  1  0  2  0 	/* TxD6 */
+			1  a  1  0  2  0 	/* TxD7 */
+			0  9  2  0  1  0 	/* RxD0 */
+			0  a  2  0  1  0 	/* RxD1 */
+			0  b  2  0  1  0 	/* RxD2 */
+			0  c  2  0  1  0 	/* RxD3 */
+			0  d  2  0  1  0 	/* RxD4 */
+			1  1  2  0  2  0 	/* RxD5 */
+			1  0  2  0  2  0 	/* RxD6 */
+			1  4  2  0  2  0 	/* RxD7 */
+			0  7  1  0  1  0 	/* TX_EN */
+			0  8  1  0  1  0 	/* TX_ER */
+			0  f  2  0  1  0 	/* RX_DV */
+			0  10 2  0  1  0 	/* RX_ER */
+			0  0  2  0  1  0 	/* RX_CLK */
+			2  9  1  0  3  0 	/* GTX_CLK - CLK10 */
+			2  8  2  0  1  0>;	/* GTX125 - CLK9 */
+	};
+
+   vii) Multi-User RAM (MURAM)
+
+   Required properties:
+   - device_type : should be "muram".
+   - mode : the could be "host" or "slave".
+   - ranges : Should be defined as specified in 1) to describe the
+      translation of MURAM addresses.
+   - data-only : sub-node which defines the address area under MURAM
+      bus that can be allocated as data/parameter
+
+   Example:
+
+	muram@10000 {
+		device_type = "muram";
+		ranges = <0 00010000 0000c000>;
+
+		data-only@0{
+			reg = <0 c000>;
+		};
+	};
 
    More devices will be defined as this spec matures.
