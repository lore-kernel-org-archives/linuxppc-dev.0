Return-Path: <B16395@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 76E8E2C0142
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Mar 2013 07:02:18 +1100 (EST)
From: Varun Sethi <Varun.Sethi@freescale.com>
To: <joro@8bytes.org>, <stuart.yoder@freescale.com>,
 <scottwood@freescale.com>, <iommu@lists.linux-foundation.org>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
 <galak@kernel.crashing.org>, <benh@kernel.crashing.org>
Subject: [PATCH 1/5 v11] iommu/fsl: Make iova dma_addr_t in the
 iommu_iova_to_phys API.
Date: Fri, 29 Mar 2013 01:23:58 +0530
Message-ID: <1364500442-20927-2-git-send-email-Varun.Sethi@freescale.com>
In-Reply-To: <1364500442-20927-1-git-send-email-Varun.Sethi@freescale.com>
References: <1364500442-20927-1-git-send-email-Varun.Sethi@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Varun Sethi <Varun.Sethi@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is required in case of PAMU, as it can support a window size of up
to 64G (even on 32bit). 

Signed-off-by: Varun Sethi <Varun.Sethi@freescale.com>
---
changes in v11:
- Made iova dma_addr_t instead of u64.
- no change in v10.
 drivers/iommu/amd_iommu.c      |    2 +-
 drivers/iommu/exynos-iommu.c   |    2 +-
 drivers/iommu/intel-iommu.c    |    2 +-
 drivers/iommu/iommu.c          |    3 +--
 drivers/iommu/msm_iommu.c      |    2 +-
 drivers/iommu/omap-iommu.c     |    2 +-
 drivers/iommu/shmobile-iommu.c |    2 +-
 drivers/iommu/tegra-gart.c     |    2 +-
 drivers/iommu/tegra-smmu.c     |    2 +-
 include/linux/iommu.h          |    9 +++------
 10 files changed, 12 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 98f555d..ee5431d 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -3412,7 +3412,7 @@ static size_t amd_iommu_unmap(struct iommu_domain *dom, unsigned long iova,
 }
 
 static phys_addr_t amd_iommu_iova_to_phys(struct iommu_domain *dom,
-					  unsigned long iova)
+					  dma_addr_t iova)
 {
 	struct protection_domain *domain = dom->priv;
 	unsigned long offset_mask;
diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 238a3ca..3f32d64 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -1027,7 +1027,7 @@ done:
 }
 
 static phys_addr_t exynos_iommu_iova_to_phys(struct iommu_domain *domain,
-					  unsigned long iova)
+					  dma_addr_t iova)
 {
 	struct exynos_iommu_domain *priv = domain->priv;
 	unsigned long *entry;
diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 0099667..6e0b9ff 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -4111,7 +4111,7 @@ static size_t intel_iommu_unmap(struct iommu_domain *domain,
 }
 
 static phys_addr_t intel_iommu_iova_to_phys(struct iommu_domain *domain,
-					    unsigned long iova)
+					    dma_addr_t iova)
 {
 	struct dmar_domain *dmar_domain = domain->priv;
 	struct dma_pte *pte;
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index b972d43..f730ed9 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -706,8 +706,7 @@ void iommu_detach_group(struct iommu_domain *domain, struct iommu_group *group)
 }
 EXPORT_SYMBOL_GPL(iommu_detach_group);
 
-phys_addr_t iommu_iova_to_phys(struct iommu_domain *domain,
-			       unsigned long iova)
+phys_addr_t iommu_iova_to_phys(struct iommu_domain *domain, dma_addr_t iova)
 {
 	if (unlikely(domain->ops->iova_to_phys == NULL))
 		return 0;
diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index 6a8870a..8ab4f41 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -554,7 +554,7 @@ fail:
 }
 
 static phys_addr_t msm_iommu_iova_to_phys(struct iommu_domain *domain,
-					  unsigned long va)
+					  dma_addr_t va)
 {
 	struct msm_priv *priv;
 	struct msm_iommu_drvdata *iommu_drvdata;
diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index 6ac02fa..e02e5d7 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -1219,7 +1219,7 @@ static void omap_iommu_domain_destroy(struct iommu_domain *domain)
 }
 
 static phys_addr_t omap_iommu_iova_to_phys(struct iommu_domain *domain,
-					  unsigned long da)
+					  dma_addr_t da)
 {
 	struct omap_iommu_domain *omap_domain = domain->priv;
 	struct omap_iommu *oiommu = omap_domain->iommu_dev;
diff --git a/drivers/iommu/shmobile-iommu.c b/drivers/iommu/shmobile-iommu.c
index b6e8b57..d572863 100644
--- a/drivers/iommu/shmobile-iommu.c
+++ b/drivers/iommu/shmobile-iommu.c
@@ -296,7 +296,7 @@ done:
 }
 
 static phys_addr_t shmobile_iommu_iova_to_phys(struct iommu_domain *domain,
-					       unsigned long iova)
+					       dma_addr_t iova)
 {
 	struct shmobile_iommu_domain *sh_domain = domain->priv;
 	uint32_t l1entry = 0, l2entry = 0;
diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index 8643757..4aec8be 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -279,7 +279,7 @@ static size_t gart_iommu_unmap(struct iommu_domain *domain, unsigned long iova,
 }
 
 static phys_addr_t gart_iommu_iova_to_phys(struct iommu_domain *domain,
-					   unsigned long iova)
+					   dma_addr_t iova)
 {
 	struct gart_device *gart = domain->priv;
 	unsigned long pte;
diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index b34e5fd..bc9b599 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -757,7 +757,7 @@ static size_t smmu_iommu_unmap(struct iommu_domain *domain, unsigned long iova,
 }
 
 static phys_addr_t smmu_iommu_iova_to_phys(struct iommu_domain *domain,
-					   unsigned long iova)
+					   dma_addr_t iova)
 {
 	struct smmu_as *as = domain->priv;
 	unsigned long *pte;
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index ba3b8a9..bb0a0fc 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -91,8 +91,7 @@ struct iommu_ops {
 		   phys_addr_t paddr, size_t size, int prot);
 	size_t (*unmap)(struct iommu_domain *domain, unsigned long iova,
 		     size_t size);
-	phys_addr_t (*iova_to_phys)(struct iommu_domain *domain,
-				    unsigned long iova);
+	phys_addr_t (*iova_to_phys)(struct iommu_domain *domain, dma_addr_t iova);
 	int (*domain_has_cap)(struct iommu_domain *domain,
 			      unsigned long cap);
 	int (*add_device)(struct device *dev);
@@ -134,8 +133,7 @@ extern int iommu_map(struct iommu_domain *domain, unsigned long iova,
 		     phys_addr_t paddr, size_t size, int prot);
 extern size_t iommu_unmap(struct iommu_domain *domain, unsigned long iova,
 		       size_t size);
-extern phys_addr_t iommu_iova_to_phys(struct iommu_domain *domain,
-				      unsigned long iova);
+extern phys_addr_t iommu_iova_to_phys(struct iommu_domain *domain, dma_addr_t iova);
 extern int iommu_domain_has_cap(struct iommu_domain *domain,
 				unsigned long cap);
 extern void iommu_set_fault_handler(struct iommu_domain *domain,
@@ -267,8 +265,7 @@ static inline void iommu_domain_window_disable(struct iommu_domain *domain,
 {
 }
 
-static inline phys_addr_t iommu_iova_to_phys(struct iommu_domain *domain,
-					     unsigned long iova)
+static inline phys_addr_t iommu_iova_to_phys(struct iommu_domain *domain, dma_addr_t iova)
 {
 	return 0;
 }
-- 
1.7.4.1
