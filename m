Return-Path: <robin.murphy@arm.com>
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 3xjdxX2BkYzDqVg
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Aug 2017 20:33:03 +1000 (AEST)
From: Robin Murphy <robin.murphy@arm.com>
To: hch@lst.de,
	robh+dt@kernel.org
Cc: frowand.list@gmail.com, m.szyprowski@samsung.com,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2] of: Restrict DMA configuration
Date: Thu, 31 Aug 2017 11:32:54 +0100
Message-Id: <5fc6930c9645c934de2586179ca3f80a055689cb.1504175330.git.robin.murphy@arm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Moving DMA configuration to happen later at driver probe time had the
unnoticed side-effect that we now perform DMA configuration for *every*
device represented in DT, rather than only those explicitly created by
the of_platform and PCI code.

As Christoph points out, this is not really the best thing to do. Whilst
there may well be other DMA-capable buses that can benefit from having
their children automatically configured after the bridge has probed,
there are also plenty of others like USB, MDIO, etc. that definitely do
not support DMA and should not be indiscriminately processed.

The good news is that in most cases the DT "dma-ranges" property serves
as an appropriate indicator - per a strict interpretation of the spec,
anything lacking a "dma-ranges" property should be considered not to
have a mapping of DMA address space from its children to its parent,
thus anything for which of_dma_get_range() does not succeed does not
need DMA configuration. Certain bus types have a general expectation of
DMA capability and carry a well-established precedent that an absent
"dma-ranges" implies the same as the empty property, so we automatically
opt those in to DMA configuration regardless, to avoid regressing most
existing platforms.

Fixes: 09515ef5ddad ("of/acpi: Configure dma operations at probe time for platform/amba/pci bus devices")
Reported-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v2: Updated commit message to be more reasonable

 drivers/of/device.c | 48 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 32 insertions(+), 16 deletions(-)

diff --git a/drivers/of/device.c b/drivers/of/device.c
index e0a28ea341fe..04c4c952dc57 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -9,6 +9,9 @@
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/slab.h>
+#include <linux/pci.h>
+#include <linux/platform_device.h>
+#include <linux/amba/bus.h>
 
 #include <asm/errno.h>
 #include "of_private.h"
@@ -84,31 +87,28 @@ int of_device_add(struct platform_device *ofdev)
  */
 int of_dma_configure(struct device *dev, struct device_node *np)
 {
-	u64 dma_addr, paddr, size;
+	u64 dma_addr, paddr, size = 0;
 	int ret;
 	bool coherent;
 	unsigned long offset;
 	const struct iommu_ops *iommu;
 	u64 mask;
 
-	/*
-	 * Set default coherent_dma_mask to 32 bit.  Drivers are expected to
-	 * setup the correct supported mask.
-	 */
-	if (!dev->coherent_dma_mask)
-		dev->coherent_dma_mask = DMA_BIT_MASK(32);
-
-	/*
-	 * Set it to coherent_dma_mask by default if the architecture
-	 * code has not set it.
-	 */
-	if (!dev->dma_mask)
-		dev->dma_mask = &dev->coherent_dma_mask;
-
 	ret = of_dma_get_range(np, &dma_addr, &paddr, &size);
 	if (ret < 0) {
+		/*
+		 * For legacy reasons, we have to assume some devices need
+		 * DMA configuration regardless of whether "dma-ranges" is
+		 * correctly specified or not.
+		 */
+		if (!dev_is_pci(dev) &&
+#ifdef CONFIG_ARM_AMBA
+		    dev->bus != &amba_bustype &&
+#endif
+		    dev->bus != &platform_bus_type)
+			return ret == -ENODEV ? 0 : ret;
+
 		dma_addr = offset = 0;
-		size = max(dev->coherent_dma_mask, dev->coherent_dma_mask + 1);
 	} else {
 		offset = PFN_DOWN(paddr - dma_addr);
 
@@ -129,6 +129,22 @@ int of_dma_configure(struct device *dev, struct device_node *np)
 		dev_dbg(dev, "dma_pfn_offset(%#08lx)\n", offset);
 	}
 
+	/*
+	 * Set default coherent_dma_mask to 32 bit.  Drivers are expected to
+	 * setup the correct supported mask.
+	 */
+	if (!dev->coherent_dma_mask)
+		dev->coherent_dma_mask = DMA_BIT_MASK(32);
+	/*
+	 * Set it to coherent_dma_mask by default if the architecture
+	 * code has not set it.
+	 */
+	if (!dev->dma_mask)
+		dev->dma_mask = &dev->coherent_dma_mask;
+
+	if (!size)
+		size = max(dev->coherent_dma_mask, dev->coherent_dma_mask + 1);
+
 	dev->dma_pfn_offset = offset;
 
 	/*
-- 
2.13.4.dirty
