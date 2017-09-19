Return-Path: <Zhiqiang.Hou@nxp.com>
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-cys01nam02on0073.outbound.protection.outlook.com [104.47.37.73])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xxHz82kQtzDqXj
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Sep 2017 19:44:52 +1000 (AEST)
From: Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linuxppc-dev@lists.ozlabs.org>, <marc.zyngier@arm.com>,
 <robh+dt@kernel.org>, <mark.rutland@arm.com>, <bhelgaas@google.com>,
 <shawnguo@kernel.org>, <Mingkai.Hu@nxp.com>, <Minghuan.Lian@nxp.com>,
 <roy.zang@nxp.com>
CC: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCH 5/5] arm64: dts: ls1046a: add PCIe controller DT nodes
Date: Tue, 19 Sep 2017 17:26:58 +0800
Message-ID: <20170919092658.22482-6-Zhiqiang.Hou@nxp.com>
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

LS1046a implements 3 PCIe 3.0 controllers.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 75 ++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index c8ff0baddf1d..eac8c32f64b0 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -661,6 +661,81 @@
 				     <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+		pcie@3400000 {
+			compatible = "fsl,ls1046a-pcie", "snps,dw-pcie";
+			reg = <0x00 0x03400000 0x0 0x00100000   /* controller registers */
+			       0x40 0x00000000 0x0 0x00002000>; /* configuration space */
+			reg-names = "regs", "config";
+			interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>, /* controller interrupt */
+				     <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>; /* PME interrupt */
+			interrupt-names = "aer", "pme";
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			dma-coherent;
+			num-lanes = <4>;
+			bus-range = <0x0 0xff>;
+			ranges = <0x81000000 0x0 0x00000000 0x40 0x00010000 0x0 0x00010000   /* downstream I/O */
+				  0x82000000 0x0 0x40000000 0x40 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
+			msi-parent = <&msi1>, <&msi2>, <&msi3>;
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 7>;
+			interrupt-map = <0000 0 0 1 &gic GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
+					<0000 0 0 2 &gic GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
+					<0000 0 0 3 &gic GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
+					<0000 0 0 4 &gic GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		pcie@3500000 {
+			compatible = "fsl,ls1046a-pcie", "snps,dw-pcie";
+			reg = <0x00 0x03500000 0x0 0x00100000   /* controller registers */
+			       0x48 0x00000000 0x0 0x00002000>; /* configuration space */
+			reg-names = "regs", "config";
+			interrupts = <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>, /* controller interrupt */
+				     <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>; /* PME interrupt */
+			interrupt-names = "aer", "pme";
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			dma-coherent;
+			num-lanes = <2>;
+			bus-range = <0x0 0xff>;
+			ranges = <0x81000000 0x0 0x00000000 0x48 0x00010000 0x0 0x00010000   /* downstream I/O */
+				  0x82000000 0x0 0x40000000 0x48 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
+			msi-parent = <&msi2>, <&msi3>, <&msi1>;
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 7>;
+			interrupt-map = <0000 0 0 1 &gic GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>,
+					<0000 0 0 2 &gic GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>,
+					<0000 0 0 3 &gic GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>,
+					<0000 0 0 4 &gic GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		pcie@3600000 {
+			compatible = "fsl,ls1046a-pcie", "snps,dw-pcie";
+			reg = <0x00 0x03600000 0x0 0x00100000   /* controller registers */
+			       0x50 0x00000000 0x0 0x00002000>; /* configuration space */
+			reg-names = "regs", "config";
+			interrupts = <GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH>, /* controller interrupt */
+				     <GIC_SPI 161 IRQ_TYPE_LEVEL_HIGH>; /* PME interrupt */
+			interrupt-names = "aer", "pme";
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			dma-coherent;
+			num-lanes = <2>;
+			bus-range = <0x0 0xff>;
+			ranges = <0x81000000 0x0 0x00000000 0x50 0x00010000 0x0 0x00010000   /* downstream I/O */
+				  0x82000000 0x0 0x40000000 0x50 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
+			msi-parent = <&msi3>, <&msi1>, <&msi2>;
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 7>;
+			interrupt-map = <0000 0 0 1 &gic GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>,
+					<0000 0 0 2 &gic GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>,
+					<0000 0 0 3 &gic GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>,
+					<0000 0 0 4 &gic GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
 	};
 
 	reserved-memory {
-- 
2.14.1
