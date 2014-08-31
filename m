Return-Path: <Igal.Liberman@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0205.outbound.protection.outlook.com [207.46.163.205])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DEFA21A001F
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 31 Aug 2014 22:01:38 +1000 (EST)
From: Igal.Liberman <igal.liberman@freescale.com>
To: <devicetree@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <netdev@vger.kernel.org>
Subject: [PATCH] Freescale Frame Manager Device Tree binding document
Date: Sun, 31 Aug 2014 14:49:20 +0300
Message-ID: <1409485760-18844-1-git-send-email-igal.liberman@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: scottwood@freescale.com, Igal Liberman <Igal.Liberman@freescale.com>,
 Emilian.Medve@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Igal Liberman <Igal.Liberman@freescale.com>

The Frame Manager (FMan) combines the Ethernet network interfaces with packet
distribution logic to provide intelligent distribution and queuing decisions
for incoming traffic at line rate.

This binding document describes Freescale's Frame Manager hardware attributes
that are used by the Frame Manager driver for its basic initialization and
configuration.

Signed-off-by: Igal Liberman <Igal.Liberman@freescale.com>
---
 .../devicetree/bindings/powerpc/fsl/fman.txt       |  462 ++++++++++++++++++++
 1 file changed, 462 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/powerpc/fsl/fman.txt

diff --git a/Documentation/devicetree/bindings/powerpc/fsl/fman.txt b/Documentation/devicetree/bindings/powerpc/fsl/fman.txt
new file mode 100644
index 0000000..ce0793f
--- /dev/null
+++ b/Documentation/devicetree/bindings/powerpc/fsl/fman.txt
@@ -0,0 +1,462 @@
+=============================================================================
+Freescale Frame Manager Device Bindings
+
+CONTENTS
+  - FMan Node
+  - FMan Port Node
+  - FMan MURAM Node
+  - FMan dTSEC/XGEC/mEMAC Node
+  - FMan IEEE 1588 Node
+  - Example
+
+=============================================================================
+FMan Node
+
+DESCRIPTION
+
+Due to the fact that the FMan is an aggregation of sub-engines (ports, MACs,
+etc.) the FMan node will have child nodes for each of them.
+
+PROPERTIES
+
+- compatible
+		Usage: required
+		Value type: <stringlist>
+		Definition: Must include "fsl,fman"
+		FMan version can be determined via FM_IP_REV_1 register in the
+		FMan block. The offset is 0xc4 from the beginning of the
+		Frame Processing Manager memory map (0xc3000 from the
+		beginning of the FMan node).
+
+- cell-index
+		Usage: required
+		Value type: <u32>
+		Definition: Specifies the index of the FMan unit.
+
+		The cell-index value may be used, for example, to disable or
+		enable the FMan via "Device disable register 2"
+		(DCFG_DEVDISR2, located at the SoC reference manual under
+		"Device Configuration and Pin Control Memory Map").
+
+- reg
+		Usage: required
+		Value type: <prop-encoded-array>
+		Definition: A standard property. Specifies the offset of the
+		following configuration registers:
+		- BMI configuration registers.
+		- QMI configuration registers.
+		- DMA configuration registers.
+		- FPM configuration registers.
+		- FMan controller configuration registers.
+
+- ranges
+		Usage: required
+		Value type: <prop-encoded-array>
+		Definition: A standard property.
+
+- clocks
+		Usage: required
+		Value type: <prop-encoded-array>
+		Definition: phandle for fman clock.
+
+- clock-names
+		usage: optional
+		Value type: <stringlist>
+		Definition: A standard property
+
+- interrupts
+		Usage: required
+		Value type: <prop-encoded-array>
+		Definition: A pair of IRQs are specified in this property.
+		The first element is associated with the event interrupts and
+		the second element is associated with the error interrupts.
+
+- fsl,qman-channel-range
+		Usage: required
+		Value type: <prop-encoded-array>
+		Definition: Specifies the ranges of the available dedicated
+		channels in the FMan. The first cell specifies the beginning
+		of the range and the second cell specifies the number of
+		channels.
+		Further information available at:
+		"Work Queue (WQ) Channel Assignments in the QMan" section
+		in DPAA Reference Manual.
+
+=============================================================================
+FMan MURAM Node
+
+DESCRIPTION
+
+FMan Internal memory - shared between all the FMan modules.
+It contains data structures that are common and written to or read by
+the modules.
+FMan internal memory is split into the following parts:
+	Packet buffering (Tx/Rx FIFOs)
+	Frames internal context
+
+PROPERTIES
+
+- compatible
+		Usage: required
+		Value type: <stringlist>
+		Definition: Must include "fsl,fman-muram"
+
+- ranges
+		Usage: required
+		Value type: <prop-encoded-array>
+		Definition: A standard property. Specifies the physical
+		address and length of the FMan memory space
+
+EXAMPLE
+
+muram@0 {
+	compatible = "fsl,fman-muram";
+	ranges = <0 0x000000 0x28000>;
+};
+
+=============================================================================
+FMan Port Node
+
+DESCRIPTION
+
+The Frame Manager (FMan) supports several types of hardware ports:
+	Ethernet receiver (RX)
+	Ethernet transmitter (TX)
+	Offline/Host command (O/H)
+
+PROPERTIES
+
+- compatible
+		Usage: required
+		Value type: <stringlist>
+		Definition: A standard property.
+		Must include one of the following:
+			- "fsl,fman-v2-port-oh" for FManV2 OH ports
+			- "fsl,fman-v2-port-rx" for FManV2 RX ports
+			- "fsl,fman-v2-port-tx" for FManV2 TX ports
+			- "fsl,fman-v3-port-oh" for FManV3 OH ports
+			- "fsl,fman-v3-port-rx" for FManV3 RX ports
+			- "fsl,fman-v3-port-tx" for FManV3 TX ports
+
+- cell-index
+		Usage: required
+		Value type: <u32>
+		Definition: Specifies the hardware port id.
+		Each hardware port on the FMan has its own hardware PortID.
+		Super set of all hardware Port IDs available at FMan Reference
+		Manual under "FMan Hardware Ports in Freescale Devices" table.
+
+		Each hardware port is assigned a 4KB, port-specific page in
+		the FMan hardware port memory region (which is part of the
+		FMan memory map). The first 4 KB in the FMan hardware ports
+		memory region is used for what are called common registers.
+		The subsequent 63 4KB pages are allocated to the hardware
+		ports.
+		The page of a specific port is determined by the cell-index.
+
+- reg
+		Usage: required
+		Value type: <prop-encoded-array>
+		Definition: There is one reg region describing the port
+		configuration registers.
+
+EXAMPLE
+
+port@a8000 {
+	cell-index = <0x28>;
+	compatible = "fsl,fman-v2-port-tx";
+	reg = <0xa8000 0x1000>;
+};
+
+port@88000 {
+	cell-index = <0x8>;
+	compatible = "fsl,fman-v2-port-rx";
+	reg = <0x88000 0x1000>;
+};
+
+port@81000 {
+	cell-index = <0x1>;
+	compatible = "fsl,fman-v2-port-oh";
+	reg = <0x81000 0x1000>;
+};
+
+=============================================================================
+FMan dTSEC/XGEC/mEMAC Node
+
+DESCRIPTION
+
+mEMAC/dTSEC/XGEC are the Ethernet network interfaces
+
+PROPERTIES
+
+- compatible
+		Usage: required
+		Value type: <stringlist>
+		Definition: A standard property.
+		Must include one of the following:
+		- "fsl,fman-dtsec" for dTSEC MAC
+		- "fsl,fman-xgec" for XGEC MAC
+		- "fsl,fman-memac for mEMAC MAC
+
+- cell-index
+		Usage: required
+		Value type: <u32>
+		Definition: Specifies the MAC id.
+		This value is used to identify the MAC id in some registers
+		in the FMan memory map, for example:
+		The FMan Error Pending Interrupt Register (FM_EPI) -
+		This register holds a bit for each MAC.
+
+- reg
+		Usage: required
+		Value type: <prop-encoded-array>
+		Definition: A standard property.
+
+- fsl,fman-ports
+		Usage: required
+		Value type: <prop-encoded-array>
+		Definition: An array of two phandles - the first references is
+		the FMan RX port and the second is the TX port used by this
+		MAC.
+
+- ptp-timer
+		Usage required
+		Value type: <phandle>
+		Definition: A phandle for 1EEE1588 timer.
+
+EXAMPLE
+
+fman1_tx28: port@a8000 {
+	cell-index = <0x28>;
+	compatible = "fsl,fman-v2-port-tx";
+	reg = <0xa8000 0x1000>;
+};
+
+fman1_rx8: port@88000 {
+	cell-index = <0x8>;
+	compatible = "fsl,fman-v2-port-rx";
+	reg = <0x88000 0x1000>;
+};
+
+ptp-timer: ptp_timer@fe000 {
+	compatible = "fsl,fman-ptp-timer";
+	reg = <0xfe000 0x1000>;
+};
+
+ethernet@e0000 {
+	compatible = "fsl,fman-dtsec";
+	cell-index = <0>;
+	reg = <0xe0000 0x1000>;
+	fsl,fman-ports = <&fman1_rx8 &fman1_tx28>;
+	ptp-timer = <&ptp-timer>;
+};
+
+============================================================================
+FMan IEEE 1588 Node
+
+DESCRIPTION
+
+The FMan interface to support IEEE 1588
+
+
+PROPERTIES
+
+- compatible
+		Usage: required
+		Value type: <stringlist>
+		Definition: A standard property.
+		Must include "fsl,fman-ptp-timer".
+
+- reg
+		Usage: required
+		Value type: <prop-encoded-array>
+		Definition: A standard property.
+
+EXAMPLE
+
+ptp-timer@fe000 {
+	compatible = "fsl,fman-ptp-timer";
+	reg = <0xfe000 0x1000>;
+};
+
+=============================================================================
+Example
+
+fman@400000 {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	cell-index = <1>;
+	compatible = "fsl,fman"
+	ranges = <0 0x400000 0x100000>;
+	reg = <0x480000 0x00400
+	       0x480400 0x00400
+	       0x4c2000 0x01000
+	       0x4c3000 0x01000
+	       0x4c4000 0x01000
+	       0x4c7000 0x01000>;
+	clocks = <&fman_clk>;
+	clock-names = "fmanclk";
+	interrupts = <
+		96 2 0 0
+		16 2 1 1>;
+	fsl,qman-channel-range = <0x40 0xc>;
+
+	muram@0 {
+		compatible = "fsl,fman-muram";
+		reg = <0x0 0x28000>;
+	};
+
+	port@81000 {
+		cell-index = <1>;
+		compatible = "fsl,fman-v2-port-oh";
+		reg = <0x81000 0x1000>;
+	};
+
+	port@82000 {
+		cell-index = <2>;
+		compatible = "fsl,fman-v2-port-oh";
+		reg = <0x82000 0x1000>;
+	};
+
+	port@83000 {
+		cell-index = <3>;
+		compatible = "fsl,fman-v2-port-oh";
+		reg = <0x83000 0x1000>;
+	};
+
+	port@84000 {
+		cell-index = <4>;
+		compatible = "fsl,fman-v2-port-oh";
+		reg = <0x84000 0x1000>;
+	};
+
+	port@85000 {
+		cell-index = <5>;
+		compatible = "fsl,fman-v2-port-oh";
+		reg = <0x85000 0x1000>;
+	};
+
+	port@86000 {
+		cell-index = <6>;
+		compatible = "fsl,fman-v2-port-oh";
+		reg = <0x86000 0x1000>;
+	};
+
+	fman1_rx_0x8: port@88000 {
+		cell-index = <0x8>;
+		compatible = "fsl,fman-v2-port-rx";
+		reg = <0x88000 0x1000>;
+	};
+
+	fman1_rx_0x9: port@89000 {
+		cell-index = <0x9>;
+		compatible = "fsl,fman-v2-port-rx";
+		reg = <0x89000 0x1000>;
+	};
+
+	fman1_rx_0xa: port@8a000 {
+		cell-index = <0xa>;
+		compatible = "fsl,fman-v2-port-rx";
+		reg = <0x8a000 0x1000>;
+	};
+
+	fman1_rx_0xb: port@8b000 {
+		cell-index = <0xb>;
+		compatible = "fsl,fman-v2-port-rx";
+		reg = <0x8b000 0x1000>;
+	};
+
+	fman1_rx_0xc: port@8c000 {
+		cell-index = <0xc>;
+		compatible = "fsl,fman-v2-port-rx";
+		reg = <0x8c000 0x1000>;
+	};
+
+	fman1_rx_0x10: port@90000 {
+		cell-index = <0x10>;
+		compatible = "fsl,fman-v2-port-rx";
+		reg = <0x90000 0x1000>;
+	};
+
+	fman1_tx_0x28: port@a8000 {
+		cell-index = <0x28>;
+		compatible = "fsl,fman-v2-port-tx";
+		reg = <0xa8000 0x1000>;
+	};
+
+	fman1_tx_0x29: port@a9000 {
+		cell-index = <0x29>;
+		compatible = "fsl,fman-v2-port-tx";
+		reg = <0xa9000 0x1000>;
+	};
+
+	fman1_tx_0x2a: port@aa000 {
+		cell-index = <0x2a>;
+		compatible = "fsl,fman-v2-port-tx";
+		reg = <0xaa000 0x1000>;
+	};
+
+	fman1_tx_0x2b: port@ab000 {
+		cell-index = <0x2b>;
+		compatible = "fsl,fman-v2-port-tx";
+		reg = <0xab000 0x1000>;
+	};
+
+	fman1_tx_0x2c: port@ac0000 {
+		cell-index = <0x2c>;
+		compatible = "fsl,fman-v2-port-tx";
+		reg = <0xac000 0x1000>;
+	};
+
+	fman1_tx_0x30: port@b0000 {
+		cell-index = <0x30>;
+		compatible = "fsl,fman-v2-port-tx";
+		reg = <0xb0000 0x1000>;
+	};
+
+	ethernet@e0000 {
+		compatible = "fsl,fman-dtsec";
+		cell-index = <0>;
+		reg = <0xe0000 0x1000>;
+		fsl,fman-ports = <&fman1_rx_0x8 &fman1_tx_0x28>;
+	};
+
+	ethernet@e2000 {
+		compatible = "fsl,fman-dtsec";
+		cell-index = <1>;
+		reg = <0xe2000 0x1000>;
+		fsl,fman-ports = <&fman1_rx_0x9 &fman1_tx_0x29>;
+	};
+
+	ethernet@e4000 {
+		compatible = "fsl,fman-dtsec";
+		cell-index = <2>;
+		reg = <0xe4000 0x1000>;
+		fsl,fman-ports = <&fman1_rx_0xa &fman1_tx_0x2a>;
+	};
+
+	ethernet@e6000 {
+		compatible = "fsl,fman-dtsec";
+		cell-index = <3>;
+		reg = <0xe6000 0x1000>;
+		fsl,fman-ports = <&fman1_rx_0xb &fman1_tx_0x2b>;
+	};
+
+	ethernet@e8000 {
+		compatible = "fsl,fman-dtsec";
+		cell-index = <4>;
+		reg = <0xf0000 0x1000>;
+		fsl,fman-ports = <&fman1_rx_0xc &fman1_tx_0x2c>;
+
+	ethernet@f0000 {
+		cell-index = <8>;
+		compatible = "fsl,fman-xgec";
+		reg = <0xf0000 0x1000>;
+		fsl,fman-ports = <&fman1_rx_0x10 &fman1_tx_0x30>;
+	};
+
+	ptp-timer@fe000 {
+		compatible = "fsl,fman-ptp-timer";
+		reg = <0xfe000 0x1000>;
+	};
+};
-- 
1.7.9.5
