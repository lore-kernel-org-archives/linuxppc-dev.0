Return-Path: <nipun.gupta@nxp.com>
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01on0044.outbound.protection.outlook.com [104.47.2.44])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4288ZF6rP1zF38B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Sep 2018 23:50:29 +1000 (AEST)
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
Subject: [PATCH 4/7 v7] iommu/arm-smmu: Add support for the fsl-mc bus
Date: Mon, 10 Sep 2018 19:19:18 +0530
Message-Id: <1536587361-11047-5-git-send-email-nipun.gupta@nxp.com>
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

Implement bus specific support for the fsl-mc bus including
registering arm_smmu_ops and bus specific device add operations.

Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/arm-smmu.c |  7 +++++++
 drivers/iommu/iommu.c    | 13 +++++++++++++
 include/linux/fsl/mc.h   |  8 ++++++++
 include/linux/iommu.h    |  2 ++
 4 files changed, 30 insertions(+)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index f7a96bc..a011bb6 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -52,6 +52,7 @@
 #include <linux/spinlock.h>
 
 #include <linux/amba/bus.h>
+#include <linux/fsl/mc.h>
 
 #include "io-pgtable.h"
 #include "arm-smmu-regs.h"
@@ -1459,6 +1460,8 @@ static struct iommu_group *arm_smmu_device_group(struct device *dev)
 
 	if (dev_is_pci(dev))
 		group = pci_device_group(dev);
+	else if (dev_is_fsl_mc(dev))
+		group = fsl_mc_device_group(dev);
 	else
 		group = generic_device_group(dev);
 
@@ -2037,6 +2040,10 @@ static void arm_smmu_bus_init(void)
 		bus_set_iommu(&pci_bus_type, &arm_smmu_ops);
 	}
 #endif
+#ifdef CONFIG_FSL_MC_BUS
+	if (!iommu_present(&fsl_mc_bus_type))
+		bus_set_iommu(&fsl_mc_bus_type, &arm_smmu_ops);
+#endif
 }
 
 static int arm_smmu_device_probe(struct platform_device *pdev)
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index d227b86..df2f49e 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -32,6 +32,7 @@
 #include <linux/pci.h>
 #include <linux/bitops.h>
 #include <linux/property.h>
+#include <linux/fsl/mc.h>
 #include <trace/events/iommu.h>
 
 static struct kset *iommu_group_kset;
@@ -988,6 +989,18 @@ struct iommu_group *pci_device_group(struct device *dev)
 	return iommu_group_alloc();
 }
 
+/* Get the IOMMU group for device on fsl-mc bus */
+struct iommu_group *fsl_mc_device_group(struct device *dev)
+{
+	struct device *cont_dev = fsl_mc_cont_dev(dev);
+	struct iommu_group *group;
+
+	group = iommu_group_get(cont_dev);
+	if (!group)
+		group = iommu_group_alloc();
+	return group;
+}
+
 /**
  * iommu_group_get_for_dev - Find or create the IOMMU group for a device
  * @dev: target device
diff --git a/include/linux/fsl/mc.h b/include/linux/fsl/mc.h
index f27cb14..dddaca1 100644
--- a/include/linux/fsl/mc.h
+++ b/include/linux/fsl/mc.h
@@ -351,6 +351,14 @@ struct fsl_mc_io {
 #define dev_is_fsl_mc(_dev) (0)
 #endif
 
+/* Macro to check if a device is a container device */
+#define fsl_mc_is_cont_dev(_dev) (to_fsl_mc_device(_dev)->flags & \
+	FSL_MC_IS_DPRC)
+
+/* Macro to get the container device of a MC device */
+#define fsl_mc_cont_dev(_dev) (fsl_mc_is_cont_dev(_dev) ? \
+	(_dev) : (_dev)->parent)
+
 /*
  * module_fsl_mc_driver() - Helper macro for drivers that don't do
  * anything special in module init/exit.  This eliminates a lot of
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 7447b0b..209891d 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -389,6 +389,8 @@ static inline size_t iommu_map_sg(struct iommu_domain *domain,
 extern struct iommu_group *pci_device_group(struct device *dev);
 /* Generic device grouping function */
 extern struct iommu_group *generic_device_group(struct device *dev);
+/* FSL-MC device grouping function */
+struct iommu_group *fsl_mc_device_group(struct device *dev);
 
 /**
  * struct iommu_fwspec - per-device IOMMU instance data
-- 
1.9.1
