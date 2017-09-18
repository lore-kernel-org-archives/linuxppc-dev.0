Return-Path: <roy.pledge@nxp.com>
Received: from NAM03-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam03on0604.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe48::604])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xwyYc0fVpzDq78
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Sep 2017 06:40:03 +1000 (AEST)
From: Roy Pledge <roy.pledge@nxp.com>
To: <leoyang.li@nxp.com>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <devicetree@vger.kernel.org>
CC: <oss@buserror.net>, <madalin.bucur@nxp.com>, <catalin.marinas@arm.com>,
 <linux@armlinux.org.uk>, <arnd@arndb.de>, <mark.rutland@arm.com>, Roy Pledge
 <roy.pledge@nxp.com>
Subject: [v5 08/12] soc/fsl/qbman: Rework portal mapping calls for ARM/PPC
Date: Mon, 18 Sep 2017 16:39:43 -0400
Message-ID: <1505767187-4596-9-git-send-email-roy.pledge@nxp.com>
In-Reply-To: <1505767187-4596-1-git-send-email-roy.pledge@nxp.com>
References: <1505767187-4596-1-git-send-email-roy.pledge@nxp.com>
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
flushes on ARM. This also fixes the code so sparse checking is clean.

Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
---
 drivers/soc/fsl/qbman/bman.c        | 18 ++++++++++--------
 drivers/soc/fsl/qbman/bman_portal.c | 23 ++++++++++-------------
 drivers/soc/fsl/qbman/bman_priv.h   |  8 +++-----
 drivers/soc/fsl/qbman/dpaa_sys.h    | 15 +++++++++++----
 drivers/soc/fsl/qbman/qman.c        | 31 +++++++++++++------------------
 drivers/soc/fsl/qbman/qman_portal.c | 23 ++++++++++-------------
 drivers/soc/fsl/qbman/qman_priv.h   |  8 +++-----
 7 files changed, 60 insertions(+), 66 deletions(-)

diff --git a/drivers/soc/fsl/qbman/bman.c b/drivers/soc/fsl/qbman/bman.c
index ff8998f..5dbb5cc 100644
--- a/drivers/soc/fsl/qbman/bman.c
+++ b/drivers/soc/fsl/qbman/bman.c
@@ -154,7 +154,8 @@ struct bm_mc {
 };
 
 struct bm_addr {
-	void __iomem *ce;	/* cache-enabled */
+	void *ce;		/* cache-enabled */
+	__be32 *ce_be;		/* Same as above but for direct access */
 	void __iomem *ci;	/* cache-inhibited */
 };
 
@@ -167,12 +168,12 @@ struct bm_portal {
 /* Cache-inhibited register access. */
 static inline u32 bm_in(struct bm_portal *p, u32 offset)
 {
-	return be32_to_cpu(__raw_readl(p->addr.ci + offset));
+	return ioread32be(p->addr.ci + offset);
 }
 
 static inline void bm_out(struct bm_portal *p, u32 offset, u32 val)
 {
-	__raw_writel(cpu_to_be32(val), p->addr.ci + offset);
+	iowrite32be(val, p->addr.ci + offset);
 }
 
 /* Cache Enabled Portal Access */
@@ -188,7 +189,7 @@ static inline void bm_cl_touch_ro(struct bm_portal *p, u32 offset)
 
 static inline u32 bm_ce_in(struct bm_portal *p, u32 offset)
 {
-	return be32_to_cpu(__raw_readl(p->addr.ce + offset));
+	return be32_to_cpu(*(p->addr.ce_be + (offset/4)));
 }
 
 struct bman_portal {
@@ -408,7 +409,7 @@ static int bm_mc_init(struct bm_portal *portal)
 
 	mc->cr = portal->addr.ce + BM_CL_CR;
 	mc->rr = portal->addr.ce + BM_CL_RR0;
-	mc->rridx = (__raw_readb(&mc->cr->_ncw_verb) & BM_MCC_VERB_VBIT) ?
+	mc->rridx = (mc->cr->_ncw_verb & BM_MCC_VERB_VBIT) ?
 		    0 : 1;
 	mc->vbit = mc->rridx ? BM_MCC_VERB_VBIT : 0;
 #ifdef CONFIG_FSL_DPAA_CHECKING
@@ -466,7 +467,7 @@ static inline union bm_mc_result *bm_mc_result(struct bm_portal *portal)
 	 * its command is submitted and completed. This includes the valid-bit,
 	 * in case you were wondering...
 	 */
-	if (!__raw_readb(&rr->verb)) {
+	if (!rr->verb) {
 		dpaa_invalidate_touch_ro(rr);
 		return NULL;
 	}
@@ -512,8 +513,9 @@ static int bman_create_portal(struct bman_portal *portal,
 	 * config, everything that follows depends on it and "config" is more
 	 * for (de)reference...
 	 */
-	p->addr.ce = c->addr_virt[DPAA_PORTAL_CE];
-	p->addr.ci = c->addr_virt[DPAA_PORTAL_CI];
+	p->addr.ce = c->addr_virt_ce;
+	p->addr.ce_be = c->addr_virt_ce;
+	p->addr.ci = c->addr_virt_ci;
 	if (bm_rcr_init(p, bm_rcr_pvb, bm_rcr_cce)) {
 		dev_err(c->dev, "RCR initialisation failed\n");
 		goto fail_rcr;
diff --git a/drivers/soc/fsl/qbman/bman_portal.c b/drivers/soc/fsl/qbman/bman_portal.c
index 39b39c8..2f71f7d 100644
--- a/drivers/soc/fsl/qbman/bman_portal.c
+++ b/drivers/soc/fsl/qbman/bman_portal.c
@@ -91,7 +91,6 @@ static int bman_portal_probe(struct platform_device *pdev)
 	struct device_node *node = dev->of_node;
 	struct bm_portal_config *pcfg;
 	struct resource *addr_phys[2];
-	void __iomem *va;
 	int irq, cpu;
 
 	pcfg = devm_kmalloc(dev, sizeof(*pcfg), GFP_KERNEL);
@@ -123,23 +122,21 @@ static int bman_portal_probe(struct platform_device *pdev)
 	}
 	pcfg->irq = irq;
 
-	va = ioremap_prot(addr_phys[0]->start, resource_size(addr_phys[0]), 0);
-	if (!va) {
-		dev_err(dev, "ioremap::CE failed\n");
+	pcfg->addr_virt_ce = memremap(addr_phys[0]->start,
+					resource_size(addr_phys[0]),
+					QBMAN_MEMREMAP_ATTR);
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
@@ -164,9 +161,9 @@ static int bman_portal_probe(struct platform_device *pdev)
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
index f6896a2..751ce90 100644
--- a/drivers/soc/fsl/qbman/bman_priv.h
+++ b/drivers/soc/fsl/qbman/bman_priv.h
@@ -46,11 +46,9 @@ extern u16 bman_ip_rev;	/* 0 if uninitialised, otherwise BMAN_REVx */
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
index 61cfdb3..5a2c0af 100644
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
 
@@ -102,4 +102,11 @@ static inline u8 dpaa_cyc_diff(u8 ringsize, u8 first, u8 last)
 int qbman_init_private_mem(struct device *dev, int idx, dma_addr_t *addr,
 				size_t *size);
 
+/* memremap() attributes for different platforms */
+#ifdef CONFIG_PPC
+#define QBMAN_MEMREMAP_ATTR	MEMREMAP_WB
+#else
+#define QBMAN_MEMREMAP_ATTR	MEMREMAP_WC
+#endif
+
 #endif	/* __DPAA_SYS_H */
diff --git a/drivers/soc/fsl/qbman/qman.c b/drivers/soc/fsl/qbman/qman.c
index 25419e1..8934c27 100644
--- a/drivers/soc/fsl/qbman/qman.c
+++ b/drivers/soc/fsl/qbman/qman.c
@@ -300,7 +300,8 @@ struct qm_mc {
 };
 
 struct qm_addr {
-	void __iomem *ce;	/* cache-enabled */
+	void *ce;		/* cache-enabled */
+	__be32 *ce_be;		/* same value as above but for direct access */
 	void __iomem *ci;	/* cache-inhibited */
 };
 
@@ -321,12 +322,12 @@ struct qm_portal {
 /* Cache-inhibited register access. */
 static inline u32 qm_in(struct qm_portal *p, u32 offset)
 {
-	return be32_to_cpu(__raw_readl(p->addr.ci + offset));
+	return ioread32be(p->addr.ci + offset);
 }
 
 static inline void qm_out(struct qm_portal *p, u32 offset, u32 val)
 {
-	__raw_writel(cpu_to_be32(val), p->addr.ci + offset);
+	iowrite32be(val, p->addr.ci + offset);
 }
 
 /* Cache Enabled Portal Access */
@@ -342,7 +343,7 @@ static inline void qm_cl_touch_ro(struct qm_portal *p, u32 offset)
 
 static inline u32 qm_ce_in(struct qm_portal *p, u32 offset)
 {
-	return be32_to_cpu(__raw_readl(p->addr.ce + offset));
+	return be32_to_cpu(*(p->addr.ce_be + (offset/4)));
 }
 
 /* --- EQCR API --- */
@@ -646,11 +647,7 @@ static inline void qm_dqrr_pvb_update(struct qm_portal *portal)
 	 */
 	dpaa_invalidate_touch_ro(res);
 #endif
-	/*
-	 *  when accessing 'verb', use __raw_readb() to ensure that compiler
-	 * inlining doesn't try to optimise out "excess reads".
-	 */
-	if ((__raw_readb(&res->verb) & QM_DQRR_VERB_VBIT) == dqrr->vbit) {
+	if ((res->verb & QM_DQRR_VERB_VBIT) == dqrr->vbit) {
 		dqrr->pi = (dqrr->pi + 1) & (QM_DQRR_SIZE - 1);
 		if (!dqrr->pi)
 			dqrr->vbit ^= QM_DQRR_VERB_VBIT;
@@ -777,11 +774,8 @@ static inline void qm_mr_pvb_update(struct qm_portal *portal)
 	union qm_mr_entry *res = qm_cl(mr->ring, mr->pi);
 
 	DPAA_ASSERT(mr->pmode == qm_mr_pvb);
-	/*
-	 *  when accessing 'verb', use __raw_readb() to ensure that compiler
-	 * inlining doesn't try to optimise out "excess reads".
-	 */
-	if ((__raw_readb(&res->verb) & QM_MR_VERB_VBIT) == mr->vbit) {
+
+	if ((res->verb & QM_MR_VERB_VBIT) == mr->vbit) {
 		mr->pi = (mr->pi + 1) & (QM_MR_SIZE - 1);
 		if (!mr->pi)
 			mr->vbit ^= QM_MR_VERB_VBIT;
@@ -822,7 +816,7 @@ static inline int qm_mc_init(struct qm_portal *portal)
 
 	mc->cr = portal->addr.ce + QM_CL_CR;
 	mc->rr = portal->addr.ce + QM_CL_RR0;
-	mc->rridx = (__raw_readb(&mc->cr->_ncw_verb) & QM_MCC_VERB_VBIT)
+	mc->rridx = (mc->cr->_ncw_verb & QM_MCC_VERB_VBIT)
 		    ? 0 : 1;
 	mc->vbit = mc->rridx ? QM_MCC_VERB_VBIT : 0;
 #ifdef CONFIG_FSL_DPAA_CHECKING
@@ -880,7 +874,7 @@ static inline union qm_mc_result *qm_mc_result(struct qm_portal *portal)
 	 * its command is submitted and completed. This includes the valid-bit,
 	 * in case you were wondering...
 	 */
-	if (!__raw_readb(&rr->verb)) {
+	if (!rr->verb) {
 		dpaa_invalidate_touch_ro(rr);
 		return NULL;
 	}
@@ -1123,8 +1117,9 @@ static int qman_create_portal(struct qman_portal *portal,
 	 * config, everything that follows depends on it and "config" is more
 	 * for (de)reference
 	 */
-	p->addr.ce = c->addr_virt[DPAA_PORTAL_CE];
-	p->addr.ci = c->addr_virt[DPAA_PORTAL_CI];
+	p->addr.ce = c->addr_virt_ce;
+	p->addr.ce_be = c->addr_virt_ce;
+	p->addr.ci = c->addr_virt_ci;
 	/*
 	 * If CI-stashing is used, the current defaults use a threshold of 3,
 	 * and stash with high-than-DQRR priority.
diff --git a/drivers/soc/fsl/qbman/qman_portal.c b/drivers/soc/fsl/qbman/qman_portal.c
index cbacdf4..a120002 100644
--- a/drivers/soc/fsl/qbman/qman_portal.c
+++ b/drivers/soc/fsl/qbman/qman_portal.c
@@ -224,7 +224,6 @@ static int qman_portal_probe(struct platform_device *pdev)
 	struct device_node *node = dev->of_node;
 	struct qm_portal_config *pcfg;
 	struct resource *addr_phys[2];
-	void __iomem *va;
 	int irq, cpu, err;
 	u32 val;
 
@@ -262,23 +261,21 @@ static int qman_portal_probe(struct platform_device *pdev)
 	}
 	pcfg->irq = irq;
 
-	va = ioremap_prot(addr_phys[0]->start, resource_size(addr_phys[0]), 0);
-	if (!va) {
-		dev_err(dev, "ioremap::CE failed\n");
+	pcfg->addr_virt_ce = memremap(addr_phys[0]->start,
+					resource_size(addr_phys[0]),
+					QBMAN_MEMREMAP_ATTR);
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
@@ -310,9 +307,9 @@ static int qman_portal_probe(struct platform_device *pdev)
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
index b1e2cbf..9407d2e 100644
--- a/drivers/soc/fsl/qbman/qman_priv.h
+++ b/drivers/soc/fsl/qbman/qman_priv.h
@@ -153,11 +153,9 @@ static inline void qman_cgrs_xor(struct qman_cgrs *dest,
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
