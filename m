Return-Path: <nipun.gupta@nxp.com>
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr00051.outbound.protection.outlook.com [40.107.0.51])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zw2Pq01XRzF0jr
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Mar 2018 01:30:38 +1100 (AEDT)
From: Nipun Gupta <nipun.gupta@nxp.com>
To: will.deacon@arm.com, robin.murphy@arm.com, mark.rutland@arm.com,
 catalin.marinas@arm.com
Cc: iommu@lists.linux-foundation.org, robh+dt@kernel.org, hch@lst.de,
 m.szyprowski@samsung.com, gregkh@linuxfoundation.org, joro@8bytes.org,
 leoyang.li@nxp.com, shawnguo@kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, bharat.bhushan@nxp.com, stuyoder@gmail.com,
 laurentiu.tudor@nxp.com, Nipun Gupta <nipun.gupta@nxp.com>
Subject: [PATCH 3/6] iommu: arm-smmu: Add support for the fsl-mc bus
Date: Mon,  5 Mar 2018 19:59:23 +0530
Message-Id: <1520260166-29387-4-git-send-email-nipun.gupta@nxp.com>
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

Implement bus specific support for the fsl-mc bus including
registering arm_smmu_ops and bus specific device add operations.

Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>
---
 drivers/iommu/arm-smmu.c |  7 +++++++
 drivers/iommu/iommu.c    | 21 +++++++++++++++++++++
 include/linux/fsl/mc.h   |  8 ++++++++
 include/linux/iommu.h    |  2 ++
 4 files changed, 38 insertions(+)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 69e7c60..e1d5090 100644
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
index 69fef99..fbeebb2 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -32,6 +32,7 @@
 #include <linux/pci.h>
 #include <linux/bitops.h>
 #include <linux/property.h>
+#include <linux/fsl/mc.h>
 #include <trace/events/iommu.h>
 
 static struct kset *iommu_group_kset;
@@ -987,6 +988,26 @@ struct iommu_group *pci_device_group(struct device *dev)
 	return iommu_group_alloc();
 }
 
+/* Get the IOMMU group for device on fsl-mc bus */
+struct iommu_group *fsl_mc_device_group(struct device *dev)
+{
+	struct device *cont_dev = fsl_mc_cont_dev(dev);
+	struct iommu_group *group;
+
+	/* Container device is responsible for creating the iommu group */
+	if (fsl_mc_is_cont_dev(dev)) {
+		group = iommu_group_alloc();
+		if (IS_ERR(group))
+			return NULL;
+	} else {
+		get_device(cont_dev);
+		group = iommu_group_get(cont_dev);
+		put_device(cont_dev);
+	}
+
+	return group;
+}
+
 /**
  * iommu_group_get_for_dev - Find or create the IOMMU group for a device
  * @dev: target device
diff --git a/include/linux/fsl/mc.h b/include/linux/fsl/mc.h
index 765ba41..ae9382b 100644
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
index 41b8c57..00a460b 100644
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
