Return-Path: <B37400@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe004.messaging.microsoft.com [207.46.163.27])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E4CDF2C007B
 for <linuxppc-dev@ozlabs.org>; Thu,  3 Jan 2013 00:25:31 +1100 (EST)
From: Sandeep Singh <Sandeep@freescale.com>
To: <devicetree-discuss@lists.ozlabs.org>, <linuxppc-dev@ozlabs.org>
Subject: [PATCH] Added device tree binding for TDM and TDM phy
Date: Wed, 2 Jan 2013 18:55:20 +0530
Message-ID: <1357133120-2271-1-git-send-email-Sandeep@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Sandeep Singh <Sandeep@freescale.com>,
 Poonam Aggrwal <poonam.aggrwal@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This controller is available on many Freescale SOCs like MPC8315, P1020, P1010
and P1022

Signed-off-by: Sandeep Singh <Sandeep@freescale.com>
Signed-off-by: Poonam Aggrwal <poonam.aggrwal@freescale.com>
---
 .../devicetree/bindings/powerpc/fsl/fsl-tdm.txt    |   63 ++++++++++++++++++++
 .../devicetree/bindings/powerpc/fsl/tdm-phy.txt    |   38 ++++++++++++
 2 files changed, 101 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/powerpc/fsl/fsl-tdm.txt
 create mode 100644 Documentation/devicetree/bindings/powerpc/fsl/tdm-phy.txt

diff --git a/Documentation/devicetree/bindings/powerpc/fsl/fsl-tdm.txt b/Documentation/devicetree/bindings/powerpc/fsl/fsl-tdm.txt
new file mode 100644
index 0000000..ceb2ef1
--- /dev/null
+++ b/Documentation/devicetree/bindings/powerpc/fsl/fsl-tdm.txt
@@ -0,0 +1,63 @@
+TDM Device Tree Binding
+
+NOTE: The bindings described in this document are preliminary
+and subject to change.
+
+TDM (Time Division Multiplexing)
+
+Description:
+
+The TDM is full duplex serial port designed to allow various devices including
+digital signal processors (DSPs) to communicate with a variety of serial devices
+including industry standard framers, codecs, other DSPs and microprocessors.
+
+The below properties describe the device tree bindings for Freescale TDM
+controller. This TDM controller is available on various Freescale Processors
+like MPC8315, P1020, P1022 and P1010.
+
+Required properties:
+
+- compatible
+    Value type: <string>
+    Definition: Should contain "fsl,tdm1.0".
+
+- reg
+    Definition: A standard property. The first reg specifier describes the TDM
+    registers, and the second describes the TDM DMAC registers.
+
+- tdm_tx_clk
+    Value type: <u32 or u64>
+    Definition: This specifies the value of transmit clock. It should not
+    exceed 50Mhz.
+
+- tdm_rx_clk
+    Value type: <u32 or u64>
+    Definition: This specifies the value of receive clock. Its value could be
+    zero, in which case tdm will operate in shared mode. Its value should not
+    exceed 50Mhz.
+
+- interrupts
+    Definition: Two interrupt specifiers. The first is TDM error, and the
+    second is TDM DMAC.
+
+- phy-handle
+    Value type: <phandle>
+    Definition: Phandle of the line controller node or framer node eg. SLIC,
+    E1/T1 etc. (Refer Documentation/devicetree/bindings/powerpc/fsl/tdm-phy.txt)
+
+- fsl,max-time-slots
+    Value type: <u32>
+    Definition: Maximum number of 8-bit time slots in one TDM frame. This is
+    the maximum number which TDM hardware supports.
+
+Example:
+
+	tdm@16000 {
+		compatible = "fsl,tdm1.0";
+		reg = <0x16000 0x200 0x2c000 0x2000>;
+		tdm_tx_clk = <2048000>;
+		tdm_rx_clk = <0>;
+		interrupts = <16 8 62 8>;
+		phy-handle = <&tdm-phy>;
+		fsl,max-time-slots = <128>;
+	};
diff --git a/Documentation/devicetree/bindings/powerpc/fsl/tdm-phy.txt b/Documentation/devicetree/bindings/powerpc/fsl/tdm-phy.txt
new file mode 100644
index 0000000..2563934
--- /dev/null
+++ b/Documentation/devicetree/bindings/powerpc/fsl/tdm-phy.txt
@@ -0,0 +1,38 @@
+TDM PHY Device Tree Binding
+
+NOTE: The bindings described in this document are preliminary
+and subject to change.
+
+Description:
+TDM PHY is the terminal interface of TDM subsystem. It is typically a line
+control device like E1/T1 framer or SLIC. A TDM device can have multiple TDM
+PHYs.
+
+Required properties:
+
+- compatible
+    Value type: <string>
+    Definition: Should contain generic compatibility like "tdm-phy-slic" or
+    "tdm-phy-e1" or "tdm-phy-t1".
+
+- max-num-ports
+    Value type: <u32>
+    Definition: Defines the maximum number of ports supported by the SLIC
+    device. Only required if the device is SLIC. For E1/T1 devices the number
+    of ports are predefined i.e. (24 in case of T1 and 32 in case of E1).
+
+Apart from the above, there may be other properties required because of the
+bus/interface this device is connected on. It could be SPI/local bus, etc.
+
+Example:
+
+	tdm-phy@0 {
+		compatible = "zarlink,le88266","tdm-phy-slic";
+		reg = <0>;
+		max-num-ports = <4>;
+		spi-max-frequency = <8000000>;
+	};
+
+In the above example properties "reg" and "spi-max-frequency" are SPI specific
+as the SLIC device is connected on SPI interface. These properties might vary
+depending on the specific interface the device is using.
-- 
1.7.6.GIT
