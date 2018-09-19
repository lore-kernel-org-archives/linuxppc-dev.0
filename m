Return-Path: <robin.murphy@arm.com>
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 42FbKQ5FDjzF3JH
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Sep 2018 20:13:10 +1000 (AEST)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org
Cc: iommu@lists.linux-foundation.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/2] iommu: Remove .domain_{get,set}_windows
Date: Wed, 19 Sep 2018 11:12:58 +0100
Message-Id: <cb7b5bfe3eaf78560c792213df472be58d5531b4.1537351779.git.robin.murphy@arm.com>
In-Reply-To: <96e8371cc3143a58c7a142d9ff1134ba7331dd0a.1537351779.git.robin.murphy@arm.com>
References: <96e8371cc3143a58c7a142d9ff1134ba7331dd0a.1537351779.git.robin.murphy@arm.com>
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Since these are trivially handled by the .domain_{get,set}_attr
callbacks when relevant, we can streamline struct iommu_ops for
everyone.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/fsl_pamu_domain.c | 125 +++++++++++++-------------------
 include/linux/iommu.h           |   6 --
 2 files changed, 51 insertions(+), 80 deletions(-)

diff --git a/drivers/iommu/fsl_pamu_domain.c b/drivers/iommu/fsl_pamu_domain.c
index f83965ee3095..a906ce8cf83b 100644
--- a/drivers/iommu/fsl_pamu_domain.c
+++ b/drivers/iommu/fsl_pamu_domain.c
@@ -814,11 +814,59 @@ static int configure_domain_dma_state(struct fsl_dma_domain *dma_domain, bool en
 	return 0;
 }
 
+static int fsl_pamu_set_windows(struct iommu_domain *domain, u32 w_count)
+{
+	struct fsl_dma_domain *dma_domain = to_fsl_dma_domain(domain);
+	unsigned long flags;
+	int ret;
+
+	spin_lock_irqsave(&dma_domain->domain_lock, flags);
+	/* Ensure domain is inactive i.e. DMA should be disabled for the domain */
+	if (dma_domain->enabled) {
+		pr_debug("Can't set geometry attributes as domain is active\n");
+		spin_unlock_irqrestore(&dma_domain->domain_lock, flags);
+		return  -EBUSY;
+	}
+
+	/* Ensure that the geometry has been set for the domain */
+	if (!dma_domain->geom_size) {
+		pr_debug("Please configure geometry before setting the number of windows\n");
+		spin_unlock_irqrestore(&dma_domain->domain_lock, flags);
+		return -EINVAL;
+	}
+
+	/*
+	 * Ensure we have valid window count i.e. it should be less than
+	 * maximum permissible limit and should be a power of two.
+	 */
+	if (w_count > pamu_get_max_subwin_cnt() || !is_power_of_2(w_count)) {
+		pr_debug("Invalid window count\n");
+		spin_unlock_irqrestore(&dma_domain->domain_lock, flags);
+		return -EINVAL;
+	}
+
+	ret = pamu_set_domain_geometry(dma_domain, &domain->geometry,
+				       w_count > 1 ? w_count : 0);
+	if (!ret) {
+		kfree(dma_domain->win_arr);
+		dma_domain->win_arr = kcalloc(w_count,
+					      sizeof(*dma_domain->win_arr),
+					      GFP_ATOMIC);
+		if (!dma_domain->win_arr) {
+			spin_unlock_irqrestore(&dma_domain->domain_lock, flags);
+			return -ENOMEM;
+		}
+		dma_domain->win_cnt = w_count;
+	}
+	spin_unlock_irqrestore(&dma_domain->domain_lock, flags);
+
+	return ret;
+}
+
 static int fsl_pamu_set_domain_attr(struct iommu_domain *domain,
 				    enum iommu_attr attr_type, void *data)
 {
 	struct fsl_dma_domain *dma_domain = to_fsl_dma_domain(domain);
-	u32 *count;
 	int ret = 0;
 
 	switch (attr_type) {
@@ -832,13 +880,7 @@ static int fsl_pamu_set_domain_attr(struct iommu_domain *domain,
 		ret = configure_domain_dma_state(dma_domain, *(int *)data);
 		break;
 	case DOMAIN_ATTR_WINDOWS:
-		count = data;
-
-		if (domain->ops->domain_set_windows != NULL)
-			ret = domain->ops->domain_set_windows(domain, *count);
-		else
-			ret = -ENODEV;
-
+		ret = fsl_pamu_set_windows(domain, *(u32 *)data);
 		break;
 	default:
 		pr_debug("Unsupported attribute type\n");
@@ -853,7 +895,6 @@ static int fsl_pamu_get_domain_attr(struct iommu_domain *domain,
 				    enum iommu_attr attr_type, void *data)
 {
 	struct fsl_dma_domain *dma_domain = to_fsl_dma_domain(domain);
-	u32 *count;
 	int ret = 0;
 
 	switch (attr_type) {
@@ -868,13 +909,7 @@ static int fsl_pamu_get_domain_attr(struct iommu_domain *domain,
 		*(int *)data = DOMAIN_ATTR_FSL_PAMUV1;
 		break;
 	case DOMAIN_ATTR_WINDOWS:
-		count = data;
-
-		if (domain->ops->domain_get_windows != NULL)
-			*count = domain->ops->domain_get_windows(domain);
-		else
-			ret = -ENODEV;
-
+		*(u32 *)data = dma_domain->win_cnt;
 		break;
 	default:
 		pr_debug("Unsupported attribute type\n");
@@ -1014,62 +1049,6 @@ static void fsl_pamu_remove_device(struct device *dev)
 	iommu_group_remove_device(dev);
 }
 
-static int fsl_pamu_set_windows(struct iommu_domain *domain, u32 w_count)
-{
-	struct fsl_dma_domain *dma_domain = to_fsl_dma_domain(domain);
-	unsigned long flags;
-	int ret;
-
-	spin_lock_irqsave(&dma_domain->domain_lock, flags);
-	/* Ensure domain is inactive i.e. DMA should be disabled for the domain */
-	if (dma_domain->enabled) {
-		pr_debug("Can't set geometry attributes as domain is active\n");
-		spin_unlock_irqrestore(&dma_domain->domain_lock, flags);
-		return  -EBUSY;
-	}
-
-	/* Ensure that the geometry has been set for the domain */
-	if (!dma_domain->geom_size) {
-		pr_debug("Please configure geometry before setting the number of windows\n");
-		spin_unlock_irqrestore(&dma_domain->domain_lock, flags);
-		return -EINVAL;
-	}
-
-	/*
-	 * Ensure we have valid window count i.e. it should be less than
-	 * maximum permissible limit and should be a power of two.
-	 */
-	if (w_count > pamu_get_max_subwin_cnt() || !is_power_of_2(w_count)) {
-		pr_debug("Invalid window count\n");
-		spin_unlock_irqrestore(&dma_domain->domain_lock, flags);
-		return -EINVAL;
-	}
-
-	ret = pamu_set_domain_geometry(dma_domain, &domain->geometry,
-				       w_count > 1 ? w_count : 0);
-	if (!ret) {
-		kfree(dma_domain->win_arr);
-		dma_domain->win_arr = kcalloc(w_count,
-					      sizeof(*dma_domain->win_arr),
-					      GFP_ATOMIC);
-		if (!dma_domain->win_arr) {
-			spin_unlock_irqrestore(&dma_domain->domain_lock, flags);
-			return -ENOMEM;
-		}
-		dma_domain->win_cnt = w_count;
-	}
-	spin_unlock_irqrestore(&dma_domain->domain_lock, flags);
-
-	return ret;
-}
-
-static u32 fsl_pamu_get_windows(struct iommu_domain *domain)
-{
-	struct fsl_dma_domain *dma_domain = to_fsl_dma_domain(domain);
-
-	return dma_domain->win_cnt;
-}
-
 static const struct iommu_ops fsl_pamu_ops = {
 	.capable	= fsl_pamu_capable,
 	.domain_alloc	= fsl_pamu_domain_alloc,
@@ -1078,8 +1057,6 @@ static const struct iommu_ops fsl_pamu_ops = {
 	.detach_dev	= fsl_pamu_detach_device,
 	.domain_window_enable = fsl_pamu_window_enable,
 	.domain_window_disable = fsl_pamu_window_disable,
-	.domain_get_windows = fsl_pamu_get_windows,
-	.domain_set_windows = fsl_pamu_set_windows,
 	.iova_to_phys	= fsl_pamu_iova_to_phys,
 	.domain_set_attr = fsl_pamu_set_domain_attr,
 	.domain_get_attr = fsl_pamu_get_domain_attr,
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 87994c265bf5..fd4ff4ff691d 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -181,8 +181,6 @@ struct iommu_resv_region {
  * @apply_resv_region: Temporary helper call-back for iova reserved ranges
  * @domain_window_enable: Configure and enable a particular window for a domain
  * @domain_window_disable: Disable a particular window for a domain
- * @domain_set_windows: Set the number of windows for a domain
- * @domain_get_windows: Return the number of windows for a domain
  * @of_xlate: add OF master IDs to iommu grouping
  * @pgsize_bitmap: bitmap of all possible supported page sizes
  */
@@ -223,10 +221,6 @@ struct iommu_ops {
 	int (*domain_window_enable)(struct iommu_domain *domain, u32 wnd_nr,
 				    phys_addr_t paddr, u64 size, int prot);
 	void (*domain_window_disable)(struct iommu_domain *domain, u32 wnd_nr);
-	/* Set the number of windows per domain */
-	int (*domain_set_windows)(struct iommu_domain *domain, u32 w_count);
-	/* Get the number of windows per domain */
-	u32 (*domain_get_windows)(struct iommu_domain *domain);
 
 	int (*of_xlate)(struct device *dev, struct of_phandle_args *args);
 	bool (*is_attach_deferred)(struct iommu_domain *domain, struct device *dev);
-- 
2.19.0.dirty
