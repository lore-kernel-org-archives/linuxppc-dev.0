Return-Path: <nipun.gupta@nxp.com>
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr00051.outbound.protection.outlook.com [40.107.0.51])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zw2Q74fs5zDrYc
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Mar 2018 01:30:55 +1100 (AEDT)
From: Nipun Gupta <nipun.gupta@nxp.com>
To: will.deacon@arm.com, robin.murphy@arm.com, mark.rutland@arm.com,
 catalin.marinas@arm.com
Cc: iommu@lists.linux-foundation.org, robh+dt@kernel.org, hch@lst.de,
 m.szyprowski@samsung.com, gregkh@linuxfoundation.org, joro@8bytes.org,
 leoyang.li@nxp.com, shawnguo@kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, bharat.bhushan@nxp.com, stuyoder@gmail.com,
 laurentiu.tudor@nxp.com, Nipun Gupta <nipun.gupta@nxp.com>
Subject: [PATCH 5/6] dma-mapping: support fsl-mc bus
Date: Mon,  5 Mar 2018 19:59:25 +0530
Message-Id: <1520260166-29387-6-git-send-email-nipun.gupta@nxp.com>
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

Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>
---
 drivers/base/dma-mapping.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/base/dma-mapping.c b/drivers/base/dma-mapping.c
index 3b11835..2279c4d 100644
--- a/drivers/base/dma-mapping.c
+++ b/drivers/base/dma-mapping.c
@@ -334,6 +334,7 @@ void dma_common_free_remap(void *cpu_addr, size_t size, unsigned long vm_flags)
  * Common configuration to enable DMA API use for a device
  */
 #include <linux/pci.h>
+#include <linux/fsl/mc.h>
 
 int dma_configure(struct device *dev)
 {
@@ -349,6 +350,12 @@ int dma_configure(struct device *dev)
 			dma_dev = dma_dev->parent;
 	}
 
+	if (dev_is_fsl_mc(dev)) {
+		dma_dev = dev;
+		while (dev_is_fsl_mc(dma_dev))
+			dma_dev = dma_dev->parent;
+	}
+
 	if (dma_dev->of_node) {
 		ret = of_dma_configure(dev, dma_dev->of_node);
 	} else if (has_acpi_companion(dma_dev)) {
-- 
1.9.1
