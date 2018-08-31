Return-Path: <ran.wang_1@nxp.com>
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 421m043yNSzF37t
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Aug 2018 14:02:12 +1000 (AEST)
From: Ran Wang <ran.wang_1@nxp.com>
To: Leo Li <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ran Wang <ran.wang_1@nxp.com>
Subject: [PATCH 2/3] Documentation: dt: binding: fsl: update property
 description for RCPM
Date: Fri, 31 Aug 2018 11:52:18 +0800
Message-Id: <20180831035219.31619-2-ran.wang_1@nxp.com>
In-Reply-To: <20180831035219.31619-1-ran.wang_1@nxp.com>
References: <20180831035219.31619-1-ran.wang_1@nxp.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add property 'big-endian' and supportted IP's configuration info.
Remove property 'fsl,#rcpm-wakeup-cell'.

Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
---
 Documentation/devicetree/bindings/soc/fsl/rcpm.txt |   42 ++++++-------------
 1 files changed, 13 insertions(+), 29 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/fsl/rcpm.txt b/Documentation/devicetree/bindings/soc/fsl/rcpm.txt
index e284e4e..7fc630a 100644
--- a/Documentation/devicetree/bindings/soc/fsl/rcpm.txt
+++ b/Documentation/devicetree/bindings/soc/fsl/rcpm.txt
@@ -5,8 +5,6 @@ and power management.
 
 Required properites:
   - reg : Offset and length of the register set of the RCPM block.
-  - fsl,#rcpm-wakeup-cells : The number of IPPDEXPCR register cells in the
-	fsl,rcpm-wakeup property.
   - compatible : Must contain a chip-specific RCPM block compatible string
 	and (if applicable) may contain a chassis-version RCPM compatible
 	string. Chip-specific strings are of the form "fsl,<chip>-rcpm",
@@ -27,37 +25,23 @@ Chassis Version		Example Chips
 ---------------		-------------------------------
 1.0				p4080, p5020, p5040, p2041, p3041
 2.0				t4240, b4860, b4420
-2.1				t1040, ls1021
+2.1				t1040, ls1021, ls1012
+
+Optional properties:
+ - big-endian : Indicate RCPM registers is big-endian. A RCPM node
+   that doesn't have this property will be regarded as little-endian.
+ - <property 'compatible' string of consumer device> : This string
+   is referred by RCPM driver to judge if the consumer (such as flex timer)
+   is able to be regards as wakeup source or not, such as 'fsl,ls1012a-ftm'.
+   Further, this property will carry the bit mask info to control
+   coresponding wake up source.
 
 Example:
 The RCPM node for T4240:
 	rcpm: global-utilities@e2000 {
 		compatible = "fsl,t4240-rcpm", "fsl,qoriq-rcpm-2.0";
 		reg = <0xe2000 0x1000>;
-		fsl,#rcpm-wakeup-cells = <2>;
-	};
-
-* Freescale RCPM Wakeup Source Device Tree Bindings
--------------------------------------------
-Required fsl,rcpm-wakeup property should be added to a device node if the device
-can be used as a wakeup source.
-
-  - fsl,rcpm-wakeup: Consists of a phandle to the rcpm node and the IPPDEXPCR
-	register cells. The number of IPPDEXPCR register cells is defined in
-	"fsl,#rcpm-wakeup-cells" in the rcpm node. The first register cell is
-	the bit mask that should be set in IPPDEXPCR0, and the second register
-	cell is for IPPDEXPCR1, and so on.
-
-	Note: IPPDEXPCR(IP Powerdown Exception Control Register) provides a
-	mechanism for keeping certain blocks awake during STANDBY and MEM, in
-	order to use them as wake-up sources.
-
-Example:
-	lpuart0: serial@2950000 {
-		compatible = "fsl,ls1021a-lpuart";
-		reg = <0x0 0x2950000 0x0 0x1000>;
-		interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&sysclk>;
-		clock-names = "ipg";
-		fsl,rcpm-wakeup = <&rcpm 0x0 0x40000000>;
+		big-endian;
+		fsl,ls1012a-ftm = <0x20000>;
+		fsl,pfe = <0xf0000020>;
 	};
-- 
1.7.1
