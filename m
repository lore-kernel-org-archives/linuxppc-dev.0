Return-Path: <roy.pledge@nxp.com>
Received: from NAM01-BY2-obe.outbound.protection.outlook.com
 (mail-by2nam01on0083.outbound.protection.outlook.com [104.47.34.83])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xdbhy0cGTzDrKZ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Aug 2017 06:38:10 +1000 (AEST)
From: Roy Pledge <roy.pledge@nxp.com>
To: <leoyang.li@nxp.com>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <oss@buserror.net>, <madalin.bucur@nxp.com>, <catalin.marinas@arm.com>,
 <linux@armlinux.org.uk>, <arnd@arndb.de>, <mark.rutland@arm.com>, Roy Pledge
 <roy.pledge@nxp.com>
Subject: [v4 07/11] soc/fsl/qbman: Rework portal mapping calls for ARM/PPC
Date: Thu, 24 Aug 2017 16:37:51 -0400
Message-ID: <1503607075-28970-8-git-send-email-roy.pledge@nxp.com>
In-Reply-To: <1503607075-28970-1-git-send-email-roy.pledge@nxp.com>
References: <1503607075-28970-1-git-send-email-roy.pledge@nxp.com>
Reply-To: <roy.pledge@nxp.com>
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

Rework portal mapping for PPC and ARM. The PPC devices require a
cacheable coherent mapping while ARM will work with a non-cachable/write
combine mapping. This also eliminates the need for manual cache
flushes on ARM

Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
---
 drivers/soc/fsl/qbman/bman.c        |  6 +++---
 drivers/soc/fsl/qbman/bman_portal.c | 36 +++++++++++++++++++++++-------------
 drivers/soc/fsl/qbman/bman_priv.h   |  8 +++-----
 drivers/soc/fsl/qbman/dpaa_sys.h    |  8 ++++----
 drivers/soc/fsl/qbman/qman.c        |  6 +++---
 drivers/soc/fsl/qbman/qman_portal.c | 36 +++++++++++++++++++++++-------------
 drivers/soc/fsl/qbman/qman_priv.h   |  8 +++-----
 7 files changed, 62 insertions(+), 46 deletions(-)

diff --git a/drivers/soc/fsl/qbman/bman.c b/drivers/soc/fsl/qbman/bman.c
index ff8998f..e31c843 100644
--- a/drivers/soc/fsl/qbman/bman.c
+++ b/drivers/soc/fsl/qbman/bman.c
@@ -154,7 +154,7 @@ struct bm_mc {
 };
 
 struct bm_addr {
-	void __iomem *ce;	/* cache-enabled */
+	void *ce;		/* cache-enabled */
 	void __iomem *ci;	/* cache-inhibited */
 };
 
@@ -512,8 +512,8 @@ static int bman_create_portal(struct bman_portal *portal,
 	 * config, everything that follows depends on it and "config" is more
 	 * for (de)reference...
 	 */
-	p->addr.ce = c->addr_virt[DPAA_PORTAL_CE];
-	p->addr.ci = c->addr_virt[DPAA_PORTAL_CI];
+	p->addr.ce = c->addr_virt_ce;
+	p->addr.ci = c->addr_virt_ci;
 	if (bm_rcr_init(p, bm_rcr_pvb, bm_rcr_cce)) {
 		dev_err(c->dev, "RCR initialisation failed\n");
 		goto fail_rcr;
diff --git a/drivers/soc/fsl/qbman/bman_portal.c b/drivers/soc/fsl/qbman/bman_portal.c
index 39b39c8..bb03503 100644
--- a/drivers/soc/fsl/qbman/bman_portal.c
+++ b/drivers/soc/fsl/qbman/bman_portal.c
@@ -91,7 +91,6 @@ static int bman_portal_probe(struct platform_device *pdev)
 	struct device_node *node = dev->of_node;
 	struct bm_portal_config *pcfg;
 	struct resource *addr_phys[2];
-	void __iomem *va;
 	int irq, cpu;
 
 	pcfg = devm_kmalloc(dev, sizeof(*pcfg), GFP_KERNEL);
@@ -123,23 +122,34 @@ static int bman_portal_probe(struct platform_device *pdev)
 	}
 	pcfg->irq = irq;
 
-	va = ioremap_prot(addr_phys[0]->start, resource_size(addr_phys[0]), 0);
-	if (!va) {
-		dev_err(dev, "ioremap::CE failed\n");
+	/*
+	 * TODO: Ultimately we would like to use a cacheable/non-shareable
+	 * (coherent) mapping for the portal on both architectures but that
+	 * isn't currently available in the kernel.  Because of HW differences
+	 * PPC needs to be mapped cacheable while ARM SoCs will work with non
+	 * cacheable mappings
+	 */
+#ifdef CONFIG_PPC
+	/* PPC requires a cacheable/non-coherent mapping of the portal */
+	pcfg->addr_virt_ce = memremap(addr_phys[0]->start,
+				resource_size(addr_phys[0]), MEMREMAP_WB);
+#else
+	/* ARM can use a write combine mapping. */
+	pcfg->addr_virt_ce = memremap(addr_phys[0]->start,
+				resource_size(addr_phys[0]), MEMREMAP_WC);
+#endif
+	if (!pcfg->addr_virt_ce) {
+		dev_err(dev, "memremap::CE failed\n");
 		goto err_ioremap1;
 	}
 
-	pcfg->addr_virt[DPAA_PORTAL_CE] = va;
-
-	va = ioremap_prot(addr_phys[1]->start, resource_size(addr_phys[1]),
-			  _PAGE_GUARDED | _PAGE_NO_CACHE);
-	if (!va) {
+	pcfg->addr_virt_ci = ioremap(addr_phys[1]->start,
+					resource_size(addr_phys[1]));
+	if (!pcfg->addr_virt_ci) {
 		dev_err(dev, "ioremap::CI failed\n");
 		goto err_ioremap2;
 	}
 
-	pcfg->addr_virt[DPAA_PORTAL_CI] = va;
-
 	spin_lock(&bman_lock);
 	cpu = cpumask_next_zero(-1, &portal_cpus);
 	if (cpu >= nr_cpu_ids) {
@@ -164,9 +174,9 @@ static int bman_portal_probe(struct platform_device *pdev)
 	return 0;
 
 err_portal_init:
-	iounmap(pcfg->addr_virt[DPAA_PORTAL_CI]);
+	iounmap(pcfg->addr_virt_ci);
 err_ioremap2:
-	iounmap(pcfg->addr_virt[DPAA_PORTAL_CE]);
+	memunmap(pcfg->addr_virt_ce);
 err_ioremap1:
 	return -ENXIO;
 }
diff --git a/drivers/soc/fsl/qbman/bman_priv.h b/drivers/soc/fsl/qbman/bman_priv.h
index 765a4bf..c48e6eb 100644
--- a/drivers/soc/fsl/qbman/bman_priv.h
+++ b/drivers/soc/fsl/qbman/bman_priv.h
@@ -49,11 +49,9 @@ extern u16 bman_ip_rev;	/* 0 if uninitialised, otherwise BMAN_REVx */
 extern struct gen_pool *bm_bpalloc;
 
 struct bm_portal_config {
-	/*
-	 * Corenet portal addresses;
-	 * [0]==cache-enabled, [1]==cache-inhibited.
-	 */
-	void __iomem *addr_virt[2];
+	/* Portal addresses */
+	void  *addr_virt_ce;
+	void __iomem *addr_virt_ci;
 	/* Allow these to be joined in lists */
 	struct list_head list;
 	struct device *dev;
diff --git a/drivers/soc/fsl/qbman/dpaa_sys.h b/drivers/soc/fsl/qbman/dpaa_sys.h
index 81a9a5e..0a1d573 100644
--- a/drivers/soc/fsl/qbman/dpaa_sys.h
+++ b/drivers/soc/fsl/qbman/dpaa_sys.h
@@ -51,12 +51,12 @@
 
 static inline void dpaa_flush(void *p)
 {
+	/*
+	 * Only PPC needs to flush the cache currently - on ARM the mapping
+	 * is non cacheable
+	 */
 #ifdef CONFIG_PPC
 	flush_dcache_range((unsigned long)p, (unsigned long)p+64);
-#elif defined(CONFIG_ARM)
-	__cpuc_flush_dcache_area(p, 64);
-#elif defined(CONFIG_ARM64)
-	__flush_dcache_area(p, 64);
 #endif
 }
 
diff --git a/drivers/soc/fsl/qbman/qman.c b/drivers/soc/fsl/qbman/qman.c
index 25419e1..668fab1 100644
--- a/drivers/soc/fsl/qbman/qman.c
+++ b/drivers/soc/fsl/qbman/qman.c
@@ -300,7 +300,7 @@ struct qm_mc {
 };
 
 struct qm_addr {
-	void __iomem *ce;	/* cache-enabled */
+	void *ce;		/* cache-enabled */
 	void __iomem *ci;	/* cache-inhibited */
 };
 
@@ -1123,8 +1123,8 @@ static int qman_create_portal(struct qman_portal *portal,
 	 * config, everything that follows depends on it and "config" is more
 	 * for (de)reference
 	 */
-	p->addr.ce = c->addr_virt[DPAA_PORTAL_CE];
-	p->addr.ci = c->addr_virt[DPAA_PORTAL_CI];
+	p->addr.ce = c->addr_virt_ce;
+	p->addr.ci = c->addr_virt_ci;
 	/*
 	 * If CI-stashing is used, the current defaults use a threshold of 3,
 	 * and stash with high-than-DQRR priority.
diff --git a/drivers/soc/fsl/qbman/qman_portal.c b/drivers/soc/fsl/qbman/qman_portal.c
index cbacdf4..41fe33a 100644
--- a/drivers/soc/fsl/qbman/qman_portal.c
+++ b/drivers/soc/fsl/qbman/qman_portal.c
@@ -224,7 +224,6 @@ static int qman_portal_probe(struct platform_device *pdev)
 	struct device_node *node = dev->of_node;
 	struct qm_portal_config *pcfg;
 	struct resource *addr_phys[2];
-	void __iomem *va;
 	int irq, cpu, err;
 	u32 val;
 
@@ -262,23 +261,34 @@ static int qman_portal_probe(struct platform_device *pdev)
 	}
 	pcfg->irq = irq;
 
-	va = ioremap_prot(addr_phys[0]->start, resource_size(addr_phys[0]), 0);
-	if (!va) {
-		dev_err(dev, "ioremap::CE failed\n");
+	/*
+	 * TODO: Ultimately we would like to use a cacheable/non-shareable
+	 * (coherent) mapping for the portal on both architectures but that
+	 * isn't currently available in the kernel.  Because of HW differences
+	 * PPC needs to be mapped cacheable while ARM SoCs will work with non
+	 * cacheable mappings
+	 */
+#ifdef CONFIG_PPC
+	/* PPC requires a cacheable mapping of the portal */
+	pcfg->addr_virt_ce = memremap(addr_phys[0]->start,
+				resource_size(addr_phys[0]), MEMREMAP_WB);
+#else
+	/* ARM can use write combine mapping for the cacheable area */
+	pcfg->addr_virt_ce = memremap(addr_phys[0]->start,
+				resource_size(addr_phys[0]), MEMREMAP_WT);
+#endif
+	if (!pcfg->addr_virt_ce) {
+		dev_err(dev, "memremap::CE failed\n");
 		goto err_ioremap1;
 	}
 
-	pcfg->addr_virt[DPAA_PORTAL_CE] = va;
-
-	va = ioremap_prot(addr_phys[1]->start, resource_size(addr_phys[1]),
-			  _PAGE_GUARDED | _PAGE_NO_CACHE);
-	if (!va) {
+	pcfg->addr_virt_ci = ioremap(addr_phys[1]->start,
+				resource_size(addr_phys[1]));
+	if (!pcfg->addr_virt_ci) {
 		dev_err(dev, "ioremap::CI failed\n");
 		goto err_ioremap2;
 	}
 
-	pcfg->addr_virt[DPAA_PORTAL_CI] = va;
-
 	pcfg->pools = qm_get_pools_sdqcr();
 
 	spin_lock(&qman_lock);
@@ -310,9 +320,9 @@ static int qman_portal_probe(struct platform_device *pdev)
 	return 0;
 
 err_portal_init:
-	iounmap(pcfg->addr_virt[DPAA_PORTAL_CI]);
+	iounmap(pcfg->addr_virt_ci);
 err_ioremap2:
-	iounmap(pcfg->addr_virt[DPAA_PORTAL_CE]);
+	memunmap(pcfg->addr_virt_ce);
 err_ioremap1:
 	return -ENXIO;
 }
diff --git a/drivers/soc/fsl/qbman/qman_priv.h b/drivers/soc/fsl/qbman/qman_priv.h
index 957ef54..bab7f15 100644
--- a/drivers/soc/fsl/qbman/qman_priv.h
+++ b/drivers/soc/fsl/qbman/qman_priv.h
@@ -155,11 +155,9 @@ static inline void qman_cgrs_xor(struct qman_cgrs *dest,
 void qman_init_cgr_all(void);
 
 struct qm_portal_config {
-	/*
-	 * Corenet portal addresses;
-	 * [0]==cache-enabled, [1]==cache-inhibited.
-	 */
-	void __iomem *addr_virt[2];
+	/* Portal addresses */
+	void *addr_virt_ce;
+	void __iomem *addr_virt_ci;
 	struct device *dev;
 	struct iommu_domain *iommu_domain;
 	/* Allow these to be joined in lists */
-- 
2.7.4
