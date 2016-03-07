Return-Path: <codrin.ciubotariu@nxp.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com (unknown
 [65.55.169.84])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B78651A01E7
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Mar 2016 02:49:39 +1100 (AEDT)
From: Codrin Ciubotariu <codrin.ciubotariu@nxp.com>
To: <iommu@lists.linux-foundation.org>
CC: <scottwood@freescale.com>, <Varun.Sethi@freescale.com>,
 <linuxppc-dev@lists.ozlabs.org>, Codrin Ciubotariu
 <codrin.ciubotariu@nxp.com>
Subject: [PATCH 1/7] iommu/fsl: Fix most checkpatch warnings and typos
Date: Mon, 7 Mar 2016 17:34:17 +0200
Message-ID: <1457364863-18004-2-git-send-email-codrin.ciubotariu@nxp.com>
In-Reply-To: <1457364863-18004-1-git-send-email-codrin.ciubotariu@nxp.com>
References: <1457364863-18004-1-git-send-email-codrin.ciubotariu@nxp.com>
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

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@nxp.com>
---
 drivers/iommu/fsl_pamu.c        | 92 +++++++++++++++++++++++++++++------------
 drivers/iommu/fsl_pamu.h        | 29 +++++++------
 drivers/iommu/fsl_pamu_domain.c | 41 +++++++++++-------
 drivers/iommu/fsl_pamu_domain.h |  2 +-
 4 files changed, 109 insertions(+), 55 deletions(-)

diff --git a/drivers/iommu/fsl_pamu.c b/drivers/iommu/fsl_pamu.c
index a34355f..c64cdef 100644
--- a/drivers/iommu/fsl_pamu.c
+++ b/drivers/iommu/fsl_pamu.c
@@ -128,6 +128,10 @@ int pamu_enable_liodn(int liodn)
 	mb();
 
 	set_bf(ppaace->addr_bitfields, PAACE_AF_V, PAACE_V_VALID);
+	/*
+	 * Ensure that I/O devices use the new PAACE entry
+	 * right after this function returns
+	 */
 	mb();
 
 	return 0;
@@ -150,6 +154,10 @@ int pamu_disable_liodn(int liodn)
 	}
 
 	set_bf(ppaace->addr_bitfields, PAACE_AF_V, PAACE_V_INVALID);
+	/*
+	 * Ensure that I/O devices no longer use this PAACE entry
+	 * right after this function returns
+	 */
 	mb();
 
 	return 0;
@@ -226,16 +234,17 @@ static struct paace *pamu_get_spaace(struct paace *paace, u32 wnum)
  * function returns the index of the first SPAACE entry. The remaining
  * SPAACE entries are reserved contiguously from that index.
  *
- * Returns a valid fspi index in the range of 0 - SPAACE_NUMBER_ENTRIES on success.
- * If no SPAACE entry is available or the allocator can not reserve the required
- * number of contiguous entries function returns ULONG_MAX indicating a failure.
- *
+ * Returns a valid fspi index in the range of 0 - SPAACE_NUMBER_ENTRIES on
+ * success. If no SPAACE entry is available or the allocator can not reserve
+ * the required number of contiguous entries function returns ULONG_MAX
+ * indicating a failure.
  */
 static unsigned long pamu_get_fspi_and_allocate(u32 subwin_cnt)
 {
 	unsigned long spaace_addr;
 
-	spaace_addr = gen_pool_alloc(spaace_pool, subwin_cnt * sizeof(struct paace));
+	spaace_addr = gen_pool_alloc(spaace_pool, subwin_cnt *
+						  sizeof(struct paace));
 	if (!spaace_addr)
 		return ULONG_MAX;
 
@@ -257,16 +266,17 @@ void pamu_free_subwins(int liodn)
 	if (get_bf(ppaace->addr_bitfields, PPAACE_AF_MW)) {
 		subwin_cnt = 1UL << (get_bf(ppaace->impl_attr, PAACE_IA_WCE) + 1);
 		size = (subwin_cnt - 1) * sizeof(struct paace);
-		gen_pool_free(spaace_pool, (unsigned long)&spaact[ppaace->fspi], size);
+		gen_pool_free(spaace_pool,
+			      (unsigned long)&spaact[ppaace->fspi], size);
 		set_bf(ppaace->addr_bitfields, PPAACE_AF_MW, 0);
 	}
 }
 
 /*
- * Function used for updating stash destination for the coressponding
+ * Function used for updating stash destination for the corresponding
  * LIODN.
  */
-int  pamu_update_paace_stash(int liodn, u32 subwin, u32 value)
+int pamu_update_paace_stash(int liodn, u32 subwin, u32 value)
 {
 	struct paace *paace;
 
@@ -282,6 +292,10 @@ int  pamu_update_paace_stash(int liodn, u32 subwin, u32 value)
 	}
 	set_bf(paace->impl_attr, PAACE_IA_CID, value);
 
+	/*
+	 * Ensure that I/O devices see the new stash id
+	 * just after this function returns
+	 */
 	mb();
 
 	return 0;
@@ -307,6 +321,10 @@ int pamu_disable_spaace(int liodn, u32 subwin)
 		       PAACE_AP_PERMS_DENIED);
 	}
 
+	/*
+	 * Ensure that I/O devices no longer use this PAACE entry
+	 * right after this function returns
+	 */
 	mb();
 
 	return 0;
@@ -399,6 +417,10 @@ int pamu_config_ppaace(int liodn, phys_addr_t win_addr, phys_addr_t win_size,
 		set_bf(ppaace->impl_attr, PAACE_IA_WCE, 0);
 		set_bf(ppaace->addr_bitfields, PPAACE_AF_MW, 0);
 	}
+	/*
+	 * Ensure that I/O devices see the updated PPAACE entry
+	 * right after this function returns
+	 */
 	mb();
 
 	return 0;
@@ -483,11 +505,16 @@ int pamu_config_spaace(int liodn, u32 subwin_cnt, u32 subwin,
 	if (~stashid != 0)
 		set_bf(paace->impl_attr, PAACE_IA_CID, stashid);
 
+	/* Ensure that this SPAACE entry updates before we enable it */
 	smp_wmb();
 
 	if (enable)
 		set_bf(paace->addr_bitfields, PAACE_AF_V, PAACE_V_VALID);
 
+	/*
+	 * Ensure that I/O devices use this PAACE entry
+	 * right after this function returns
+	 */
 	mb();
 
 	return 0;
@@ -553,7 +580,8 @@ u32 get_stash_id(u32 stash_dest_hint, u32 vcpu)
 found_cpu_node:
 
 	/* find the hwnode that represents the cache */
-	for (cache_level = PAMU_ATTR_CACHE_L1; (cache_level < PAMU_ATTR_CACHE_L3) && found; cache_level++) {
+	for (cache_level = PAMU_ATTR_CACHE_L1;
+	     (cache_level < PAMU_ATTR_CACHE_L3) && found; cache_level++) {
 		if (stash_dest_hint == cache_level) {
 			prop = of_get_property(node, "cache-stash-id", NULL);
 			if (!prop) {
@@ -598,26 +626,28 @@ found_cpu_node:
  * Memory accesses to QMAN and BMAN private memory need not be coherent, so
  * clear the PAACE entry coherency attribute for them.
  */
-static void setup_qbman_paace(struct paace *ppaace, int  paace_type)
+static void setup_qbman_paace(struct paace *ppaace, int paace_type)
 {
 	switch (paace_type) {
 	case QMAN_PAACE:
 		set_bf(ppaace->impl_attr, PAACE_IA_OTM, PAACE_OTM_INDEXED);
 		ppaace->op_encode.index_ot.omi = OMI_QMAN_PRIV;
 		/* setup QMAN Private data stashing for the L3 cache */
-		set_bf(ppaace->impl_attr, PAACE_IA_CID, get_stash_id(PAMU_ATTR_CACHE_L3, 0));
-		set_bf(ppaace->domain_attr.to_host.coherency_required, PAACE_DA_HOST_CR,
-		       0);
+		set_bf(ppaace->impl_attr, PAACE_IA_CID,
+		       get_stash_id(PAMU_ATTR_CACHE_L3, 0));
+		set_bf(ppaace->domain_attr.to_host.coherency_required,
+		       PAACE_DA_HOST_CR, 0);
 		break;
 	case QMAN_PORTAL_PAACE:
 		set_bf(ppaace->impl_attr, PAACE_IA_OTM, PAACE_OTM_INDEXED);
 		ppaace->op_encode.index_ot.omi = OMI_QMAN;
 		/* Set DQRR and Frame stashing for the L3 cache */
-		set_bf(ppaace->impl_attr, PAACE_IA_CID, get_stash_id(PAMU_ATTR_CACHE_L3, 0));
+		set_bf(ppaace->impl_attr, PAACE_IA_CID,
+		       get_stash_id(PAMU_ATTR_CACHE_L3, 0));
 		break;
 	case BMAN_PAACE:
-		set_bf(ppaace->domain_attr.to_host.coherency_required, PAACE_DA_HOST_CR,
-		       0);
+		set_bf(ppaace->domain_attr.to_host.coherency_required,
+		       PAACE_DA_HOST_CR, 0);
 		break;
 	}
 }
@@ -675,7 +705,8 @@ static void get_pamu_cap_values(unsigned long pamu_reg_base)
 }
 
 /* Setup PAMU registers pointing to PAACT, SPAACT and OMT */
-static int setup_one_pamu(unsigned long pamu_reg_base, unsigned long pamu_reg_size,
+static int setup_one_pamu(unsigned long pamu_reg_base,
+			  unsigned long pamu_reg_size,
 			  phys_addr_t ppaact_phys, phys_addr_t spaact_phys,
 			  phys_addr_t omt_phys)
 {
@@ -752,6 +783,10 @@ static void setup_liodns(void)
 				setup_qbman_paace(ppaace, QMAN_PAACE);
 			if (of_device_is_compatible(node, "fsl,bman"))
 				setup_qbman_paace(ppaace, BMAN_PAACE);
+			/*
+			 * Ensure that the PAACE entry is updated before
+			 * enabling it
+			 */
 			mb();
 			pamu_enable_liodn(liodn);
 		}
@@ -814,7 +849,8 @@ static irqreturn_t pamu_av_isr(int irq, void *arg)
 				pics &= ~PAMU_ACCESS_VIOLATION_ENABLE;
 			} else {
 				/* Disable the LIODN */
-				ret = pamu_disable_liodn(avs1 >> PAMU_AVS1_LIODN_SHIFT);
+				ret = pamu_disable_liodn(avs1 >>
+							 PAMU_AVS1_LIODN_SHIFT);
 				BUG_ON(ret);
 				pr_emerg("Disabling liodn %x\n",
 					 avs1 >> PAMU_AVS1_LIODN_SHIFT);
@@ -957,9 +993,11 @@ static int create_csd(phys_addr_t phys, size_t size, u32 csd_port_id)
 
 	law[i].lawbarh = upper_32_bits(phys);
 	law[i].lawbarl = lower_32_bits(phys);
+	/* Ensure LAW entry is updated before enabling it */
 	wmb();
 	law[i].lawar = LAWAR_EN | law_target | (csd_id << LAWAR_CSDID_SHIFT) |
 		(LAW_SIZE_4K + get_order(size));
+	/* Ensure LAW entry is enabled before moving on */
 	wmb();
 
 error:
@@ -979,10 +1017,10 @@ error:
  * Table of SVRs and the corresponding PORT_ID values. Port ID corresponds to a
  * bit map of snoopers for a given range of memory mapped by a LAW.
  *
- * All future CoreNet-enabled SOCs will have this erratum(A-004510) fixed, so this
- * table should never need to be updated.  SVRs are guaranteed to be unique, so
- * there is no worry that a future SOC will inadvertently have one of these
- * values.
+ * All future CoreNet-enabled SOCs will have this erratum(A-004510) fixed,
+ * so this table should never need to be updated. SVRs are guaranteed to be
+ * unique, so there is no worry that a future SOC will inadvertently have one
+ * of these values.
  */
 static const struct {
 	u32 svr;
@@ -1081,7 +1119,7 @@ static int fsl_pamu_probe(struct platform_device *pdev)
 	get_pamu_cap_values((unsigned long)pamu_regs);
 	/*
 	 * To simplify the allocation of a coherency domain, we allocate the
-	 * PAACT and the OMT in the same memory buffer.  Unfortunately, this
+	 * PAACT and the OMT in the same memory buffer. Unfortunately, this
 	 * wastes more memory compared to allocating the buffers separately.
 	 */
 	/* Determine how much memory we need */
@@ -1215,7 +1253,7 @@ static __init int fsl_pamu_init(void)
 
 	/*
 	 * The normal OF process calls the probe function at some
-	 * indeterminate later time, after most drivers have loaded.  This is
+	 * indeterminate later time, after most drivers have loaded. This is
 	 * too late for us, because PAMU clients (like the Qman driver)
 	 * depend on PAMU being initialized early.
 	 *
@@ -1224,11 +1262,11 @@ static __init int fsl_pamu_init(void)
 	 */
 
 	/*
-	 * We assume that there is only one PAMU node in the device tree.  A
+	 * We assume that there is only one PAMU node in the device tree. A
 	 * single PAMU node represents all of the PAMU devices in the SOC
-	 * already.   Everything else already makes that assumption, and the
+	 * already. Everything else already makes that assumption, and the
 	 * binding for the PAMU nodes doesn't allow for any parent-child
-	 * relationships anyway.  In other words, support for more than one
+	 * relationships anyway. In other words, support for more than one
 	 * PAMU node would require significant changes to a lot of code.
 	 */
 
diff --git a/drivers/iommu/fsl_pamu.h b/drivers/iommu/fsl_pamu.h
index aab723f..bebc2e3 100644
--- a/drivers/iommu/fsl_pamu.h
+++ b/drivers/iommu/fsl_pamu.h
@@ -66,8 +66,9 @@ struct pamu_mmap_regs {
 #define PAMU_AVS1_LAV   0x1c00
 #define PAMU_AVS1_GCV   0x2000
 #define PAMU_AVS1_PDV   0x4000
-#define PAMU_AV_MASK    (PAMU_AVS1_AV | PAMU_AVS1_OTV | PAMU_AVS1_APV | PAMU_AVS1_WAV \
-			 | PAMU_AVS1_LAV | PAMU_AVS1_GCV | PAMU_AVS1_PDV)
+#define PAMU_AV_MASK    (PAMU_AVS1_AV | PAMU_AVS1_OTV | PAMU_AVS1_APV | \
+			 PAMU_AVS1_WAV | PAMU_AVS1_LAV | PAMU_AVS1_GCV | \
+			 PAMU_AVS1_PDV)
 #define PAMU_AVS1_LIODN_SHIFT 16
 #define PAMU_LAV_LIODN_NOT_IN_PPAACT 0x400
 
@@ -270,7 +271,7 @@ struct pamu_mmap_regs {
 /* primary / secondary paact structure */
 struct paace {
 	/* PAACE Offset 0x00 */
-	u32 wbah;				/* only valid for Primary PAACE */
+	u32 wbah;			/* only valid for Primary PAACE */
 	u32 addr_bitfields;		/* See P/S PAACE_AF_* */
 
 	/* PAACE Offset 0x08 */
@@ -294,7 +295,10 @@ struct paace {
 		} to_io;
 	} domain_attr;
 
-	/* Implementation attributes + window count + address & operation translation modes */
+	/*
+	 * Implementation attributes + window count +
+	 * address & operation translation modes
+	 */
 	u32 impl_attr;			/* See PAACE_IA_* */
 
 	/* PAACE Offset 0x10 */
@@ -304,7 +308,7 @@ struct paace {
 
 	/* PAACE Offset 0x18 */
 	/* first secondary paace entry */
-	u32 fspi;				/* only valid for Primary PAACE */
+	u32 fspi;			/* only valid for Primary PAACE */
 	union {
 		struct {
 			u8 ioea;
@@ -324,11 +328,12 @@ struct paace {
 
 /* OME : Operation mapping entry
  * MOE : Mapped Operation Encodings
- * The operation mapping table is table containing operation mapping entries (OME).
- * The index of a particular OME is programmed in the PAACE entry for translation
- * in bound I/O operations corresponding to an LIODN. The OMT is used for translation
- * specifically in case of the indexed translation mode. Each OME contains a 128
- * byte mapped operation encoding (MOE), where each byte represents an MOE.
+ * The operation mapping table is table containing operation mapping entries
+ * (OME). The index of a particular OME is programmed in the PAACE entry for
+ * translation in bound I/O operations corresponding to an LIODN. The OMT is
+ * used for translation specifically in case of the indexed translation mode.
+ * Each OME contains a 128 byte mapped operation encoding (MOE), where each
+ * byte represents an MOE.
  */
 #define NUM_MOE 128
 struct ome {
@@ -396,8 +401,8 @@ int pamu_enable_liodn(int liodn);
 int pamu_disable_liodn(int liodn);
 void pamu_free_subwins(int liodn);
 int pamu_config_ppaace(int liodn, phys_addr_t win_addr, phys_addr_t win_size,
-		       u32 omi, unsigned long rpn, u32 snoopid, uint32_t stashid,
-		       u32 subwin_cnt, int prot);
+		       u32 omi, unsigned long rpn, u32 snoopid,
+		       uint32_t stashid, u32 subwin_cnt, int prot);
 int pamu_config_spaace(int liodn, u32 subwin_cnt, u32 subwin_addr,
 		       phys_addr_t subwin_size, u32 omi, unsigned long rpn,
 		       uint32_t snoopid, u32 stashid, int enable, int prot);
diff --git a/drivers/iommu/fsl_pamu_domain.c b/drivers/iommu/fsl_pamu_domain.c
index da0e1e3..869e55e 100644
--- a/drivers/iommu/fsl_pamu_domain.c
+++ b/drivers/iommu/fsl_pamu_domain.c
@@ -64,7 +64,8 @@ static int __init iommu_init_mempool(void)
 	return 0;
 }
 
-static phys_addr_t get_phys_addr(struct fsl_dma_domain *dma_domain, dma_addr_t iova)
+static phys_addr_t get_phys_addr(struct fsl_dma_domain *dma_domain,
+				 dma_addr_t iova)
 {
 	u32 win_cnt = dma_domain->win_cnt;
 	struct dma_window *win_ptr = &dma_domain->win_arr[0];
@@ -84,7 +85,8 @@ static phys_addr_t get_phys_addr(struct fsl_dma_domain *dma_domain, dma_addr_t i
 
 		subwin_size = dma_domain->geom_size >> ilog2(win_cnt);
 		subwin_iova = iova & ~(subwin_size - 1);
-		wnd = (subwin_iova - geom->aperture_start) >> ilog2(subwin_size);
+		wnd = (subwin_iova - geom->aperture_start) >>
+		      ilog2(subwin_size);
 		win_ptr = &dma_domain->win_arr[wnd];
 	}
 
@@ -155,7 +157,8 @@ static int map_liodn(int liodn, struct fsl_dma_domain *dma_domain)
 }
 
 /* Update window/subwindow mapping for the LIODN */
-static int update_liodn(int liodn, struct fsl_dma_domain *dma_domain, u32 wnd_nr)
+static int update_liodn(int liodn, struct fsl_dma_domain *dma_domain,
+			u32 wnd_nr)
 {
 	int ret;
 	struct dma_window *wnd = &dma_domain->win_arr[wnd_nr];
@@ -183,7 +186,8 @@ static int update_liodn(int liodn, struct fsl_dma_domain *dma_domain, u32 wnd_nr
 					 wnd->size,
 					 ~(u32)0,
 					 wnd->paddr >> PAMU_PAGE_SHIFT,
-					 dma_domain->snoop_id, dma_domain->stash_id,
+					 dma_domain->snoop_id,
+					 dma_domain->stash_id,
 					 0, wnd->prot);
 		if (ret)
 			pr_debug("Window reconfiguration failed for liodn %d\n",
@@ -249,8 +253,8 @@ static int pamu_set_liodn(int liodn, struct device *dev,
 	spin_lock_irqsave(&iommu_lock, flags);
 	ret = pamu_disable_liodn(liodn);
 	if (!ret)
-		ret = pamu_config_ppaace(liodn, window_addr, window_size, omi_index,
-					 0, dma_domain->snoop_id,
+		ret = pamu_config_ppaace(liodn, window_addr, window_size,
+					 omi_index, 0, dma_domain->snoop_id,
 					 dma_domain->stash_id, win_cnt, 0);
 	spin_unlock_irqrestore(&iommu_lock, flags);
 	if (ret) {
@@ -267,7 +271,8 @@ static int pamu_set_liodn(int liodn, struct device *dev,
 			if (!ret)
 				ret = pamu_config_spaace(liodn, win_cnt, i,
 							 subwin_size, omi_index,
-							 0, dma_domain->snoop_id,
+							 0,
+							 dma_domain->snoop_id,
 							 dma_domain->stash_id,
 							 0, 0);
 			spin_unlock_irqrestore(&iommu_lock, flags);
@@ -352,7 +357,8 @@ static void detach_device(struct device *dev, struct fsl_dma_domain *dma_domain)
 	spin_unlock_irqrestore(&dma_domain->domain_lock, flags);
 }
 
-static void attach_device(struct fsl_dma_domain *dma_domain, int liodn, struct device *dev)
+static void attach_device(struct fsl_dma_domain *dma_domain, int liodn,
+				 struct device *dev)
 {
 	struct device_domain_info *info, *old_domain_info;
 	unsigned long flags;
@@ -632,7 +638,8 @@ static int handle_attach_device(struct fsl_dma_domain *dma_domain,
 		 * the LIODN.
 		 */
 		if (dma_domain->win_arr) {
-			u32 win_cnt = dma_domain->win_cnt > 1 ? dma_domain->win_cnt : 0;
+			u32 win_cnt = dma_domain->win_cnt > 1 ?
+				      dma_domain->win_cnt : 0;
 
 			ret = pamu_set_liodn(liodn[i], dev, dma_domain,
 					     &domain->geometry, win_cnt);
@@ -724,7 +731,7 @@ static void fsl_pamu_detach_device(struct iommu_domain *domain,
 			 dev->of_node->full_name);
 }
 
-static  int configure_domain_geometry(struct iommu_domain *domain, void *data)
+static int configure_domain_geometry(struct iommu_domain *domain, void *data)
 {
 	struct iommu_domain_geometry *geom_attr = data;
 	struct fsl_dma_domain *dma_domain = to_fsl_dma_domain(domain);
@@ -746,7 +753,7 @@ static  int configure_domain_geometry(struct iommu_domain *domain, void *data)
 	if (dma_domain->enabled) {
 		pr_debug("Can't set geometry attributes as domain is active\n");
 		spin_unlock_irqrestore(&dma_domain->domain_lock, flags);
-		return  -EBUSY;
+		return -EBUSY;
 	}
 
 	/* Copy the domain geometry information */
@@ -787,7 +794,8 @@ static int configure_domain_stash(struct fsl_dma_domain *dma_domain, void *data)
 }
 
 /* Configure domain dma state i.e. enable/disable DMA */
-static int configure_domain_dma_state(struct fsl_dma_domain *dma_domain, bool enable)
+static int configure_domain_dma_state(struct fsl_dma_domain *dma_domain,
+				      bool enable)
 {
 	struct device_domain_info *info;
 	unsigned long flags;
@@ -934,7 +942,7 @@ static struct iommu_group *get_pci_device_group(struct pci_dev *pdev)
 	} else {
 		/*
 		 * All devices connected to the controller will share the
-		 * PCI controllers device group. If this is the first
+		 * PCI controller's device group. If this is the first
 		 * device to be probed for the pci controller, copy the
 		 * device group information from the PCI controller device
 		 * node and remove the PCI controller iommu group.
@@ -998,11 +1006,14 @@ static int fsl_pamu_set_windows(struct iommu_domain *domain, u32 w_count)
 	int ret;
 
 	spin_lock_irqsave(&dma_domain->domain_lock, flags);
-	/* Ensure domain is inactive i.e. DMA should be disabled for the domain */
+	/*
+	 * Ensure domain is inactive i.e.
+	 * DMA should be disabled for the domain
+	 */
 	if (dma_domain->enabled) {
 		pr_debug("Can't set geometry attributes as domain is active\n");
 		spin_unlock_irqrestore(&dma_domain->domain_lock, flags);
-		return  -EBUSY;
+		return -EBUSY;
 	}
 
 	/* Ensure that the geometry has been set for the domain */
diff --git a/drivers/iommu/fsl_pamu_domain.h b/drivers/iommu/fsl_pamu_domain.h
index f2b0f74..d5afbe4 100644
--- a/drivers/iommu/fsl_pamu_domain.h
+++ b/drivers/iommu/fsl_pamu_domain.h
@@ -36,7 +36,7 @@ struct fsl_dma_domain {
 	 */
 	dma_addr_t			geom_size;
 	/*
-	 * Number of windows assocaited with this domain.
+	 * Number of windows associated with this domain.
 	 * During domain initialization, it is set to the
 	 * the maximum number of subwindows allowed for a LIODN.
 	 * Minimum value for this is 1 indicating a single PAMU
-- 
1.9.3
