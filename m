Return-Path: <nipun.gupta@nxp.com>
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-eopbgr50041.outbound.protection.outlook.com [40.107.5.41])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40QLzL0ZcPzF20r
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Apr 2018 20:27:25 +1000 (AEST)
From: Nipun Gupta <nipun.gupta@nxp.com>
To: robin.murphy@arm.com, will.deacon@arm.com, mark.rutland@arm.com,
 catalin.marinas@arm.com
Cc: hch@lst.de, gregkh@linuxfoundation.org, joro@8bytes.org,
 robh+dt@kernel.org, m.szyprowski@samsung.com, shawnguo@kernel.org,
 frowand.list@gmail.com, bhelgaas@google.com,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 bharat.bhushan@nxp.com, stuyoder@gmail.com, laurentiu.tudor@nxp.com,
 leoyang.li@nxp.com, Nipun Gupta <nipun.gupta@nxp.com>
Subject: [PATCH 6/6 v2] arm64: dts: ls208xa: comply with the iommu map binding
 for fsl_mc
Date: Tue, 17 Apr 2018 15:51:54 +0530
Message-Id: <1523960514-25457-7-git-send-email-nipun.gupta@nxp.com>
In-Reply-To: <1523960514-25457-1-git-send-email-nipun.gupta@nxp.com>
References: <1520260166-29387-1-git-send-email-nipun.gupta@nxp.com>
 <1523960514-25457-1-git-send-email-nipun.gupta@nxp.com>
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

Fsl-mc bus now support the iommu-map property. Comply to this binding for
fsl_mc bus. This patch also updates the dts w.r.t. the DMA configuration.

Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
index f3a40af..1b1c5eb 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
@@ -135,6 +135,7 @@
 		#address-cells = <2>;
 		#size-cells = <2>;
 		ranges;
+		dma-ranges = <0x0 0x0 0x0 0x0 0x10000 0x00000000>;
 
 		clockgen: clocking@1300000 {
 			compatible = "fsl,ls2080a-clockgen";
@@ -357,6 +358,8 @@
 			reg = <0x00000008 0x0c000000 0 0x40>,	 /* MC portal base */
 			      <0x00000000 0x08340000 0 0x40000>; /* MC control reg */
 			msi-parent = <&its>;
+			iommu-map = <0 &smmu 0 0>;	/* This is fixed-up by u-boot */
+			dma-coherent;
 			#address-cells = <3>;
 			#size-cells = <1>;
 
@@ -460,6 +463,8 @@
 			compatible = "arm,mmu-500";
 			reg = <0 0x5000000 0 0x800000>;
 			#global-interrupts = <12>;
+			#iommu-cells = <1>;
+			stream-match-mask = <0x7C00>;
 			interrupts = <0 13 4>, /* global secure fault */
 				     <0 14 4>, /* combined secure interrupt */
 				     <0 15 4>, /* global non-secure fault */
@@ -502,7 +507,6 @@
 				     <0 204 4>, <0 205 4>,
 				     <0 206 4>, <0 207 4>,
 				     <0 208 4>, <0 209 4>;
-			mmu-masters = <&fsl_mc 0x300 0>;
 		};
 
 		dspi: dspi@2100000 {
-- 
1.9.1
