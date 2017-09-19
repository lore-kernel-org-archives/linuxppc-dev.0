Return-Path: <Zhiqiang.Hou@nxp.com>
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-cys01nam02on0066.outbound.protection.outlook.com [104.47.37.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xxHz31pXjzDqYN
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Sep 2017 19:44:47 +1000 (AEST)
From: Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linuxppc-dev@lists.ozlabs.org>, <marc.zyngier@arm.com>,
 <robh+dt@kernel.org>, <mark.rutland@arm.com>, <bhelgaas@google.com>,
 <shawnguo@kernel.org>, <Mingkai.Hu@nxp.com>, <Minghuan.Lian@nxp.com>,
 <roy.zang@nxp.com>
CC: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCH 4/5] arm64: dts: ls1012a: Add PCIe controller DT node
Date: Tue, 19 Sep 2017 17:26:57 +0800
Message-ID: <20170919092658.22482-5-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20170919092658.22482-1-Zhiqiang.Hou@nxp.com>
References: <20170919092658.22482-1-Zhiqiang.Hou@nxp.com>
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

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Add PCIe controller node for ls1012a platform.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
index a7698ac7264b..140570d45ff3 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
@@ -478,5 +478,29 @@
 			msi-controller;
 			interrupts = <0 126 IRQ_TYPE_LEVEL_HIGH>;
 		};
+
+		pcie@3400000 {
+			compatible = "fsl,ls1012a-pcie", "snps,dw-pcie";
+			reg = <0x00 0x03400000 0x0 0x00100000   /* controller registers */
+			       0x40 0x00000000 0x0 0x00002000>; /* configuration space */
+			reg-names = "regs", "config";
+			interrupts = <0 118 0x4>, /* controller interrupt */
+				     <0 117 0x4>; /* PME interrupt */
+			interrupt-names = "aer", "pme";
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			num-lanes = <4>;
+			bus-range = <0x0 0xff>;
+			ranges = <0x81000000 0x0 0x00000000 0x40 0x00010000 0x0 0x00010000   /* downstream I/O */
+				  0x82000000 0x0 0x40000000 0x40 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
+			msi-parent = <&msi>;
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 7>;
+			interrupt-map = <0000 0 0 1 &gic 0 110 IRQ_TYPE_LEVEL_HIGH>,
+					<0000 0 0 2 &gic 0 111 IRQ_TYPE_LEVEL_HIGH>,
+					<0000 0 0 3 &gic 0 112 IRQ_TYPE_LEVEL_HIGH>,
+					<0000 0 0 4 &gic 0 113 IRQ_TYPE_LEVEL_HIGH>;
+		};
 	};
 };
-- 
2.14.1
