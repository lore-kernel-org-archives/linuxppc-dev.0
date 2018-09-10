Return-Path: <nipun.gupta@nxp.com>
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01on0044.outbound.protection.outlook.com [104.47.2.44])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4288ZD0LdjzF38B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Sep 2018 23:50:27 +1000 (AEST)
From: Nipun Gupta <nipun.gupta@nxp.com>
To: joro@8bytes.org, robin.murphy@arm.com, will.deacon@arm.com,
 robh+dt@kernel.org, robh@kernel.org, mark.rutland@arm.com,
 catalin.marinas@arm.com, gregkh@linuxfoundation.org,
 laurentiu.tudor@nxp.com, bhelgaas@google.com, hch@lst.de
Cc: m.szyprowski@samsung.com, shawnguo@kernel.org, frowand.list@gmail.com,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 bharat.bhushan@nxp.com, stuyoder@gmail.com, leoyang.li@nxp.com,
 Nipun Gupta <nipun.gupta@nxp.com>
Subject: [PATCH 3/7 v7] iommu/of: support iommu configuration for fsl-mc
 devices
Date: Mon, 10 Sep 2018 19:19:17 +0530
Message-Id: <1536587361-11047-4-git-send-email-nipun.gupta@nxp.com>
In-Reply-To: <1536587361-11047-1-git-send-email-nipun.gupta@nxp.com>
References: <1536587361-11047-1-git-send-email-nipun.gupta@nxp.com>
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

With of_pci_map_rid available for all the busses, use the function
for configuration of devices on fsl-mc bus

Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/of_iommu.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 811e160..284474d 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -24,6 +24,7 @@
 #include <linux/of_iommu.h>
 #include <linux/of_pci.h>
 #include <linux/slab.h>
+#include <linux/fsl/mc.h>
 
 #define NO_IOMMU	1
 
@@ -159,6 +160,23 @@ static int of_pci_iommu_init(struct pci_dev *pdev, u16 alias, void *data)
 	return err;
 }
 
+static int of_fsl_mc_iommu_init(struct fsl_mc_device *mc_dev,
+				struct device_node *master_np)
+{
+	struct of_phandle_args iommu_spec = { .args_count = 1 };
+	int err;
+
+	err = of_map_rid(master_np, mc_dev->icid, "iommu-map",
+			 "iommu-map-mask", &iommu_spec.np,
+			 iommu_spec.args);
+	if (err)
+		return err == -ENODEV ? NO_IOMMU : err;
+
+	err = of_iommu_xlate(&mc_dev->dev, &iommu_spec);
+	of_node_put(iommu_spec.np);
+	return err;
+}
+
 const struct iommu_ops *of_iommu_configure(struct device *dev,
 					   struct device_node *master_np)
 {
@@ -190,6 +208,8 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
 
 		err = pci_for_each_dma_alias(to_pci_dev(dev),
 					     of_pci_iommu_init, &info);
+	} else if (dev_is_fsl_mc(dev)) {
+		err = of_fsl_mc_iommu_init(to_fsl_mc_device(dev), master_np);
 	} else {
 		struct of_phandle_args iommu_spec;
 		int idx = 0;
-- 
1.9.1
