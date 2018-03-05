Return-Path: <nipun.gupta@nxp.com>
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr00051.outbound.protection.outlook.com [40.107.0.51])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zw2PZ6mtkzF0jr
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Mar 2018 01:30:20 +1100 (AEDT)
From: Nipun Gupta <nipun.gupta@nxp.com>
To: will.deacon@arm.com, robin.murphy@arm.com, mark.rutland@arm.com,
 catalin.marinas@arm.com
Cc: iommu@lists.linux-foundation.org, robh+dt@kernel.org, hch@lst.de,
 m.szyprowski@samsung.com, gregkh@linuxfoundation.org, joro@8bytes.org,
 leoyang.li@nxp.com, shawnguo@kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, bharat.bhushan@nxp.com, stuyoder@gmail.com,
 laurentiu.tudor@nxp.com, Nipun Gupta <nipun.gupta@nxp.com>
Subject: [PATCH 1/6] Docs: dt: add fsl-mc iommu-parent device-tree binding
Date: Mon,  5 Mar 2018 19:59:21 +0530
Message-Id: <1520260166-29387-2-git-send-email-nipun.gupta@nxp.com>
In-Reply-To: <1520260166-29387-1-git-send-email-nipun.gupta@nxp.com>
References: <1520260166-29387-1-git-send-email-nipun.gupta@nxp.com>
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

The existing IOMMU bindings cannot be used to specify the relationship
between fsl-mc devices and IOMMUs. This patch adds a binding for
mapping fsl-mc devices to IOMMUs, using a new iommu-parent property.

Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>
---
 .../devicetree/bindings/misc/fsl,qoriq-mc.txt      | 31 ++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt b/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
index 6611a7c..011c7d6 100644
--- a/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
+++ b/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
@@ -9,6 +9,24 @@ blocks that can be used to create functional hardware objects/devices
 such as network interfaces, crypto accelerator instances, L2 switches,
 etc.
 
+For an overview of the DPAA2 architecture and fsl-mc bus see:
+drivers/staging/fsl-mc/README.txt
+
+As described in the above overview, all DPAA2 objects in a DPRC share the
+same hardware "isolation context" and a 10-bit value called an ICID
+(isolation context id) is expressed by the hardware to identify
+the requester.
+
+The generic 'iommus' property is cannot be used to describe the relationship
+between fsl-mc and IOMMUs, so an iommu-parent property is used to define
+the same.
+
+For generic IOMMU bindings, see
+Documentation/devicetree/bindings/iommu/iommu.txt.
+
+For arm-smmu binding, see:
+Documentation/devicetree/bindings/iommu/arm,smmu.txt.
+
 Required properties:
 
     - compatible
@@ -88,14 +106,27 @@ Sub-nodes:
               Value type: <phandle>
               Definition: Specifies the phandle to the PHY device node associated
                           with the this dpmac.
+Optional properties:
+
+- iommu-parent: Maps the devices on fsl-mc bus to an IOMMU.
+  The property specifies the IOMMU behind which the devices on
+  fsl-mc bus are residing.
 
 Example:
 
+        smmu: iommu@5000000 {
+               compatible = "arm,mmu-500";
+               #iommu-cells = <1>;
+               stream-match-mask = <0x7C00>;
+               ...
+        };
+
         fsl_mc: fsl-mc@80c000000 {
                 compatible = "fsl,qoriq-mc";
                 reg = <0x00000008 0x0c000000 0 0x40>,    /* MC portal base */
                       <0x00000000 0x08340000 0 0x40000>; /* MC control reg */
                 msi-parent = <&its>;
+                iommu-parent = <&smmu>;
                 #address-cells = <3>;
                 #size-cells = <1>;
 
-- 
1.9.1
