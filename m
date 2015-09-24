Return-Path: <Dongsheng.Wang@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0117.outbound.protection.outlook.com [157.56.111.117])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5B8321A0026
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2015 18:35:27 +1000 (AEST)
From: Dongsheng Wang <dongsheng.wang@freescale.com>
To: <scottwood@freescale.com>
CC: <robh+dt@kernel.org>, <shawnguo@kernel.org>, <jason.jin@freescale.com>,
 <alison.wang@freescale.com>, <devicetree@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-arm-kernel@lists.infradead.org>, Wang
 Dongsheng <dongsheng.wang@freescale.com>, Chenhui Zhao
 <chenhui.zhao@freescale.com>, Tang Yuantian <Yuantian.Tang@freescale.com>
Subject: [PATCH v3 1/2] fsl: Add binding for RCPM
Date: Thu, 24 Sep 2015 16:29:13 +0800
Message-ID: <1443083354-37369-1-git-send-email-dongsheng.wang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Wang Dongsheng <dongsheng.wang@freescale.com>

RCPM is the Run Control and Power Management module performs all
device-level tasks associated with device run control and power
management.

Add this for freescale powerpc platform and layerscape platform.

Signed-off-by: Chenhui Zhao <chenhui.zhao@freescale.com>
Signed-off-by: Tang Yuantian <Yuantian.Tang@freescale.com>
Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
---
*v3*
- Add "fsl,#rcpm-wakeup-cells" for rcpm node. The number of cells
  correspond rcpm-wakeup property.
- Modify rcpm-wakeup property description.

*v2*
- Remove P4080 example.
- Modify rcpm-wakeup property description.

diff --git a/Documentation/devicetree/bindings/soc/fsl/rcpm.txt b/Documentation/devicetree/bindings/soc/fsl/rcpm.txt
new file mode 100644
index 0000000..52110ec
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/fsl/rcpm.txt
@@ -0,0 +1,63 @@
+* Run Control and Power Management
+-------------------------------------------
+The RCPM performs all device-level tasks associated with device run control
+and power management.
+
+Required properites:
+  - reg : Offset and length of the register set of RCPM block.
+  - fsl,#rcpm-wakeup-cells : The number of cells in rcpm-wakeup property.
+  - compatible : Sould contain a chip-specific RCPM block compatible string
+	and (if applicable) may contain a chassis-version RCPM compatible
+	string. Chip-specific strings are of the form "fsl,<chip>-rcpm",
+	such as:
+	* "fsl,p2041-rcpm"
+	* "fsl,p3041-rcpm"
+	* "fsl,p4080-rcpm"
+	* "fsl,p5020-rcpm"
+	* "fsl,p5040-rcpm"
+	* "fsl,t4240-rcpm"
+	* "fsl,b4420-rcpm"
+	* "fsl,b4860-rcpm"
+
+	Chassis-version strings are of the form "fsl,qoriq-rcpm-<version>",
+	such as:
+	* "fsl,qoriq-rcpm-1.0": for chassis 1.0 rcpm
+	* "fsl,qoriq-rcpm-2.0": for chassis 2.0 rcpm
+	* "fsl,qoriq-rcpm-2.1": for chassis 2.1 rcpm
+
+All references to "1.0" and "2.0" refer to the QorIQ chassis version to
+which the chip complies.
+Chassis Version		Example Chips
+---------------		-------------------------------
+1.0				p4080, p5020, p5040, p2041, p3041
+2.0				t4240, b4860, b4420
+2.1				t1040, ls1021
+
+Example:
+The RCPM node for T4240:
+	rcpm: global-utilities@e2000 {
+		compatible = "fsl,t4240-rcpm", "fsl,qoriq-rcpm-2.0";
+		reg = <0xe2000 0x1000>;
+		fsl,#rcpm-wakeup-cells = <2>;
+	};
+
+* Freescale RCPM Wakeup Source Device Tree Bindings
+-------------------------------------------
+Required rcpm-wakeup property should be added to a device node if the device
+can be used as a wakeup source.
+
+  - rcpm-wakeup: The value of the property consists of cells, the number of
+	cells defined in "fsl,#rcpm-wakeup-cells". The first cell is a pointer
+	to the rcpm node, the second cell is the bit mask that should be set
+	in IPPDEXPCR0, and the third cell is for IPPDEXPCR1, and so on.
+
+Example:
+	lpuart0: serial@2950000 {
+		compatible = "fsl,ls1021a-lpuart";
+		reg = <0x0 0x2950000 0x0 0x1000>;
+		interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&sysclk>;
+		clock-names = "ipg";
+		rcpm-wakeup = <&rcpm 0x0 0x40000000>;
+		status = "disabled";
+	};
-- 
2.1.0.27.g96db324
