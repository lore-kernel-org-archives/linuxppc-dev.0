Return-Path: <Dongsheng.Wang@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0116.outbound.protection.outlook.com [157.56.110.116])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A0A601A046D
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Oct 2015 17:50:58 +1100 (AEDT)
From: Dongsheng Wang <dongsheng.wang@freescale.com>
To: <scottwood@freescale.com>
CC: <stuart.yoder@freescale.com>, <shawnguo@kernel.org>, <robh+dt@kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, <devicetree@vger.kernel.org>,
 <jason.jin@freescale.com>, Wang Dongsheng <dongsheng.wang@freescale.com>,
 Chenhui Zhao <chenhui.zhao@freescale.com>, Tang Yuantian
 <Yuantian.Tang@freescale.com>
Subject: [PATCH v4] Documentation: dt: binding: fsl: add devicetree binding
 for describing RCPM
Date: Mon, 26 Oct 2015 14:44:12 +0800
Message-ID: <1445841852-6830-1-git-send-email-dongsheng.wang@freescale.com>
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
*v4*
- Change patch subject.
- A few grammatical mistakes.
- Change "rcpm-wakeup" property to "fsl,rcpm-wakeup" property.
- Remove a few "fsl,<chip>-rcpm" examples.
- Now the value of "fsl,#rcpm-wakeup-cells" is not contain rcpm node.
- Add a NOTE to describe IPPDEXPCR register.

*v3*
- Add "fsl,#rcpm-wakeup-cells" for rcpm node. The number of cells
  correspond rcpm-wakeup property.
- Modify rcpm-wakeup property description.

*v2*
- Remove P4080 example.
- Modify rcpm-wakeup property description.

diff --git a/Documentation/devicetree/bindings/soc/fsl/rcpm.txt b/Documentation/devicetree/bindings/soc/fsl/rcpm.txt
new file mode 100644
index 0000000..757e0eb
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/fsl/rcpm.txt
@@ -0,0 +1,64 @@
+* Run Control and Power Management
+-------------------------------------------
+The RCPM performs all device-level tasks associated with device run control
+and power management.
+
+Required properites:
+  - reg : Offset and length of the register set of the RCPM block.
+  - fsl,#rcpm-wakeup-cells : The number of IPPDEXPCR register cells in the
+	fsl,rcpm-wakeup property.
+  - compatible : Must contain a chip-specific RCPM block compatible string
+	and (if applicable) may contain a chassis-version RCPM compatible
+	string. Chip-specific strings are of the form "fsl,<chip>-rcpm",
+	such as:
+	* "fsl,p2041-rcpm"
+	* "fsl,p5020-rcpm"
+	* "fsl,t4240-rcpm"
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
+Required fsl,rcpm-wakeup property should be added to a device node if the device
+can be used as a wakeup source.
+
+  - fsl,rcpm-wakeup: Consists of a pointer to the rcpm node and the IPPDEXPCR
+	register cells. The number of IPPDEXPCR register cells is defined in
+	"fsl,#rcpm-wakeup-cells" in the rcpm node. The first register cell is
+	the bit mask that should be set in IPPDEXPCR0, and the second register
+	cell is for IPPDEXPCR1, and so on.
+
+	Note: IPPDEXPCR(IP Powerdown Exception Control Register) provides a
+	mechanism for keeping certain blocks awake during STANDBY and MEM, in
+	order to use them as wake-up sources.
+
+Example:
+	lpuart0: serial@2950000 {
+		compatible = "fsl,ls1021a-lpuart";
+		reg = <0x0 0x2950000 0x0 0x1000>;
+		interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&sysclk>;
+		clock-names = "ipg";
+		fsl,rcpm-wakeup = <&rcpm 0x0 0x40000000>;
+		status = "disabled";
+	};
-- 
2.1.0.27.g96db324
