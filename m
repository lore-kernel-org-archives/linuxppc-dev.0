Return-Path: <robin.murphy@arm.com>
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 42FbKQ5FnnzF3JJ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Sep 2018 20:13:10 +1000 (AEST)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org
Cc: iommu@lists.linux-foundation.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/2] iommu: Tidy up window attributes
Date: Wed, 19 Sep 2018 11:12:57 +0100
Message-Id: <96e8371cc3143a58c7a142d9ff1134ba7331dd0a.1537351779.git.robin.murphy@arm.com>
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The external interface to get/set window attributes is already
abstracted behind iommu_domain_{get,set}_attr(), so there's no real
reason for the internal interface to be different. Since we only have
one window-based driver anyway, clean up the core code by just moving
the DOMAIN_ATTR_WINDOWS handling directly into the PAMU driver.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

Just a cleanup opportunity I spotted whilst poking around in the area.

 drivers/iommu/fsl_pamu_domain.c | 20 ++++++++++++++++++++
 drivers/iommu/iommu.c           | 20 --------------------
 2 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/iommu/fsl_pamu_domain.c b/drivers/iommu/fsl_pamu_domain.c
index f089136e9c3f..f83965ee3095 100644
--- a/drivers/iommu/fsl_pamu_domain.c
+++ b/drivers/iommu/fsl_pamu_domain.c
@@ -818,6 +818,7 @@ static int fsl_pamu_set_domain_attr(struct iommu_domain *domain,
 				    enum iommu_attr attr_type, void *data)
 {
 	struct fsl_dma_domain *dma_domain = to_fsl_dma_domain(domain);
+	u32 *count;
 	int ret = 0;
 
 	switch (attr_type) {
@@ -829,6 +830,15 @@ static int fsl_pamu_set_domain_attr(struct iommu_domain *domain,
 		break;
 	case DOMAIN_ATTR_FSL_PAMU_ENABLE:
 		ret = configure_domain_dma_state(dma_domain, *(int *)data);
+		break;
+	case DOMAIN_ATTR_WINDOWS:
+		count = data;
+
+		if (domain->ops->domain_set_windows != NULL)
+			ret = domain->ops->domain_set_windows(domain, *count);
+		else
+			ret = -ENODEV;
+
 		break;
 	default:
 		pr_debug("Unsupported attribute type\n");
@@ -843,6 +853,7 @@ static int fsl_pamu_get_domain_attr(struct iommu_domain *domain,
 				    enum iommu_attr attr_type, void *data)
 {
 	struct fsl_dma_domain *dma_domain = to_fsl_dma_domain(domain);
+	u32 *count;
 	int ret = 0;
 
 	switch (attr_type) {
@@ -855,6 +866,15 @@ static int fsl_pamu_get_domain_attr(struct iommu_domain *domain,
 		break;
 	case DOMAIN_ATTR_FSL_PAMUV1:
 		*(int *)data = DOMAIN_ATTR_FSL_PAMUV1;
+		break;
+	case DOMAIN_ATTR_WINDOWS:
+		count = data;
+
+		if (domain->ops->domain_get_windows != NULL)
+			*count = domain->ops->domain_get_windows(domain);
+		else
+			ret = -ENODEV;
+
 		break;
 	default:
 		pr_debug("Unsupported attribute type\n");
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 8c15c5980299..2faec6aa73c4 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1796,7 +1796,6 @@ int iommu_domain_get_attr(struct iommu_domain *domain,
 	struct iommu_domain_geometry *geometry;
 	bool *paging;
 	int ret = 0;
-	u32 *count;
 
 	switch (attr) {
 	case DOMAIN_ATTR_GEOMETRY:
@@ -1807,15 +1806,6 @@ int iommu_domain_get_attr(struct iommu_domain *domain,
 	case DOMAIN_ATTR_PAGING:
 		paging  = data;
 		*paging = (domain->pgsize_bitmap != 0UL);
-		break;
-	case DOMAIN_ATTR_WINDOWS:
-		count = data;
-
-		if (domain->ops->domain_get_windows != NULL)
-			*count = domain->ops->domain_get_windows(domain);
-		else
-			ret = -ENODEV;
-
 		break;
 	default:
 		if (!domain->ops->domain_get_attr)
@@ -1832,18 +1822,8 @@ int iommu_domain_set_attr(struct iommu_domain *domain,
 			  enum iommu_attr attr, void *data)
 {
 	int ret = 0;
-	u32 *count;
 
 	switch (attr) {
-	case DOMAIN_ATTR_WINDOWS:
-		count = data;
-
-		if (domain->ops->domain_set_windows != NULL)
-			ret = domain->ops->domain_set_windows(domain, *count);
-		else
-			ret = -ENODEV;
-
-		break;
 	default:
 		if (domain->ops->domain_set_attr == NULL)
 			return -EINVAL;
-- 
2.19.0.dirty
