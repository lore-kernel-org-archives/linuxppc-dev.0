Return-Path: <SRS0=rnOA=M4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24BB4C04EBD
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 05:51:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89967208B3
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 05:51:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89967208B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Z4Dw3T3czF3W9
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 16:51:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=ozlabs.ru
 (client-ip=107.173.13.209; helo=ozlabs.ru; envelope-from=aik@ozlabs.ru;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.ru
Received: from ozlabs.ru (unknown [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 42Z4Bp0mR2zDqnK
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Oct 2018 16:49:38 +1100 (AEDT)
Received: from vpl1.ozlabs.ibm.com (localhost [IPv6:::1])
 by ozlabs.ru (Postfix) with ESMTP id CAB73AE80026;
 Tue, 16 Oct 2018 01:49:04 -0400 (EDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel] powerpc/powernv/tce: Implement pnv_phb::tce_invalidate
Date: Tue, 16 Oct 2018 16:49:01 +1100
Message-Id: <20181016054901.22050-1-aik@ozlabs.ru>
X-Mailer: git-send-email 2.11.0
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alistair Popple <alistair@popple.id.au>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

At the moment there are 5 types of TCE invalidation:
- IODA1/POWER7 - uses raw PHB registers;
- IODA2 "direct" - uses raw PHB3 registers;
- IODA2 "opal" - calls OPAL for invalidation;
- NPU - always invalidates the entire cache;
- NPU2 - calls OPAL for invalidation but uses wrong OPAL_PCI_TCE_KILL
(which is an OPAL token and @kill_type should be one of
OPAL_PCI_TCE_KILL_xxx).

We also have separate helpers for invalidating entire PE or some pages,
with ambiguous names such as pnv_pci_phb3_tce_invalidate_pe() and
pnv_pci_ioda2_tce_invalidate_pe() which difference is not clear at all.

This defines a new powernv-phb hook: tce_invalidate(). This adds a new
helper - pnv_pci_tce_invalidate() - which walks through all attached
PEs and calls tce_invalidate(). Depending on parameters, new hook
invalidates TCE for specific pages or for the entire PE.

This defines a pnv_pci_ioda_tce_invalidate_pe() helper to invalidate a PE,
and uses it instead of pnv_pci_ioda2_tce_invalidate_entire() (NPU) and
pnv_pci_ioda2_tce_invalidate_pe() (IODA2). This does not cause a change
as for NPU2 skiboot falls through to OPAL_PCI_TCE_KILL_ALL since the NPU2
introduction anyway.

While we at it, this changes IODA1's iommu_table_ops to use the same
get/clear/exchange handlers which now get more generic name (i.e.
s/ioda2/ioda/).

As a result, the redesigned code uses now the correct kill_type
for NPU2 PHBs.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/platforms/powernv/pci.h          |  10 +-
 arch/powerpc/platforms/powernv/npu-dma.c      |   8 +-
 arch/powerpc/platforms/powernv/pci-ioda-tce.c |  16 ++
 arch/powerpc/platforms/powernv/pci-ioda.c     | 310 ++++++++++----------------
 4 files changed, 147 insertions(+), 197 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index 2131373..a4b4863 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -119,6 +119,9 @@ struct pnv_phb {
 	int (*get_pe_state)(struct pnv_phb *phb, int pe_no);
 	void (*freeze_pe)(struct pnv_phb *phb, int pe_no);
 	int (*unfreeze_pe)(struct pnv_phb *phb, int pe_no, int opt);
+	void (*tce_invalidate)(struct pnv_phb *phb, struct pnv_ioda_pe *pe,
+			struct iommu_table *tbl, unsigned long index,
+			unsigned long npages, bool realmode);
 
 	struct {
 		/* Global bridge info */
@@ -229,7 +232,6 @@ extern void pe_level_printk(const struct pnv_ioda_pe *pe, const char *level,
 
 /* Nvlink functions */
 extern void pnv_npu_try_dma_set_bypass(struct pci_dev *gpdev, bool bypass);
-extern void pnv_pci_ioda2_tce_invalidate_entire(struct pnv_phb *phb, bool rm);
 extern struct pnv_ioda_pe *pnv_pci_npu_setup_iommu(struct pnv_ioda_pe *npe);
 extern long pnv_npu_set_window(struct pnv_ioda_pe *npe, int num,
 		struct iommu_table *tbl);
@@ -266,5 +268,11 @@ extern void pnv_pci_unlink_table_and_group(struct iommu_table *tbl,
 extern void pnv_pci_setup_iommu_table(struct iommu_table *tbl,
 		void *tce_mem, u64 tce_size,
 		u64 dma_offset, unsigned int page_shift);
+extern void pnv_pci_tce_invalidate(struct iommu_table *tbl,
+		unsigned long index, unsigned long npages, bool realmode);
+static inline void pnv_pci_ioda_tce_invalidate_pe(struct pnv_ioda_pe *pe)
+{
+	pe->phb->tce_invalidate(pe->phb, pe, NULL, 0, 0, false);
+}
 
 #endif /* __POWERNV_PCI_H */
diff --git a/arch/powerpc/platforms/powernv/npu-dma.c b/arch/powerpc/platforms/powernv/npu-dma.c
index 8006c54..7931d42 100644
--- a/arch/powerpc/platforms/powernv/npu-dma.c
+++ b/arch/powerpc/platforms/powernv/npu-dma.c
@@ -223,7 +223,7 @@ long pnv_npu_set_window(struct pnv_ioda_pe *npe, int num,
 		pe_err(npe, "Failed to configure TCE table, err %lld\n", rc);
 		return rc;
 	}
-	pnv_pci_ioda2_tce_invalidate_entire(phb, false);
+	pnv_pci_ioda_tce_invalidate_pe(npe);
 
 	/* Add the table to the list so its TCE cache will get invalidated */
 	pnv_pci_link_table_and_group(phb->hose->node, num,
@@ -247,7 +247,7 @@ long pnv_npu_unset_window(struct pnv_ioda_pe *npe, int num)
 		pe_err(npe, "Unmapping failed, ret = %lld\n", rc);
 		return rc;
 	}
-	pnv_pci_ioda2_tce_invalidate_entire(phb, false);
+	pnv_pci_ioda_tce_invalidate_pe(npe);
 
 	pnv_pci_unlink_table_and_group(npe->table_group.tables[num],
 			&npe->table_group);
@@ -313,7 +313,7 @@ static int pnv_npu_dma_set_bypass(struct pnv_ioda_pe *npe)
 			0 /* bypass base */, top);
 
 	if (rc == OPAL_SUCCESS)
-		pnv_pci_ioda2_tce_invalidate_entire(phb, false);
+		pnv_pci_ioda_tce_invalidate_pe(npe);
 
 	return rc;
 }
@@ -377,7 +377,7 @@ void pnv_npu_take_ownership(struct pnv_ioda_pe *npe)
 		pe_err(npe, "Failed to disable bypass, err %lld\n", rc);
 		return;
 	}
-	pnv_pci_ioda2_tce_invalidate_entire(npe->phb, false);
+	pnv_pci_ioda_tce_invalidate_pe(npe);
 }
 
 struct pnv_ioda_pe *pnv_pci_npu_setup_iommu(struct pnv_ioda_pe *npe)
diff --git a/arch/powerpc/platforms/powernv/pci-ioda-tce.c b/arch/powerpc/platforms/powernv/pci-ioda-tce.c
index fe96910..1942c40 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda-tce.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda-tce.c
@@ -84,6 +84,22 @@ static __be64 *pnv_tce(struct iommu_table *tbl, bool user, long idx, bool alloc)
 	return tmp + idx;
 }
 
+void pnv_pci_tce_invalidate(struct iommu_table *tbl,
+		unsigned long index, unsigned long npages, bool rm)
+{
+	struct iommu_table_group_link *tgl;
+
+	list_for_each_entry_lockless(tgl, &tbl->it_group_list, next) {
+		struct pnv_ioda_pe *pe = container_of(tgl->table_group,
+			struct pnv_ioda_pe, table_group);
+
+		if (!pe->phb->tce_invalidate)
+			continue;
+
+		pe->phb->tce_invalidate(pe->phb, pe, tbl, index, npages, rm);
+	}
+}
+
 int pnv_tce_build(struct iommu_table *tbl, long index, long npages,
 		unsigned long uaddr, enum dma_data_direction direction,
 		unsigned long attrs)
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 15a4556..c76c395 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1947,15 +1947,11 @@ static inline __be64 __iomem *pnv_ioda_get_inval_reg(struct pnv_phb *phb,
 		(phb->regs + 0x210);
 }
 
-static void pnv_pci_p7ioc_tce_invalidate(struct iommu_table *tbl,
+static void pnv_ioda1_tce_invalidate(struct pnv_phb *phb,
+		struct pnv_ioda_pe *pe, struct iommu_table *tbl,
 		unsigned long index, unsigned long npages, bool rm)
 {
-	struct iommu_table_group_link *tgl = list_first_entry_or_null(
-			&tbl->it_group_list, struct iommu_table_group_link,
-			next);
-	struct pnv_ioda_pe *pe = container_of(tgl->table_group,
-			struct pnv_ioda_pe, table_group);
-	__be64 __iomem *invalidate = pnv_ioda_get_inval_reg(pe->phb, rm);
+	__be64 __iomem *invalidate = pnv_ioda_get_inval_reg(phb, rm);
 	unsigned long start, end, inc;
 
 	start = __pa(((__be64 *)tbl->it_base) + index - tbl->it_offset);
@@ -1984,7 +1980,7 @@ static void pnv_pci_p7ioc_tce_invalidate(struct iommu_table *tbl,
 	 */
 }
 
-static int pnv_ioda1_tce_build(struct iommu_table *tbl, long index,
+static int pnv_ioda_tce_build(struct iommu_table *tbl, long index,
 		long npages, unsigned long uaddr,
 		enum dma_data_direction direction,
 		unsigned long attrs)
@@ -1993,220 +1989,66 @@ static int pnv_ioda1_tce_build(struct iommu_table *tbl, long index,
 			attrs);
 
 	if (!ret)
-		pnv_pci_p7ioc_tce_invalidate(tbl, index, npages, false);
+		pnv_pci_tce_invalidate(tbl, index, npages, false);
 
 	return ret;
 }
 
 #ifdef CONFIG_IOMMU_API
-static int pnv_ioda1_tce_xchg(struct iommu_table *tbl, long index,
+static int pnv_ioda_tce_xchg(struct iommu_table *tbl, long index,
 		unsigned long *hpa, enum dma_data_direction *direction)
 {
 	long ret = pnv_tce_xchg(tbl, index, hpa, direction, true);
 
 	if (!ret)
-		pnv_pci_p7ioc_tce_invalidate(tbl, index, 1, false);
+		pnv_pci_tce_invalidate(tbl, index, 1, false);
 
 	return ret;
 }
 
-static int pnv_ioda1_tce_xchg_rm(struct iommu_table *tbl, long index,
+static int pnv_ioda_tce_xchg_rm(struct iommu_table *tbl, long index,
 		unsigned long *hpa, enum dma_data_direction *direction)
 {
 	long ret = pnv_tce_xchg(tbl, index, hpa, direction, false);
 
 	if (!ret)
-		pnv_pci_p7ioc_tce_invalidate(tbl, index, 1, true);
+		pnv_pci_tce_invalidate(tbl, index, 1, true);
 
 	return ret;
 }
 #endif
 
-static void pnv_ioda1_tce_free(struct iommu_table *tbl, long index,
+static void pnv_ioda_tce_free(struct iommu_table *tbl, long index,
 		long npages)
 {
 	pnv_tce_free(tbl, index, npages);
 
-	pnv_pci_p7ioc_tce_invalidate(tbl, index, npages, false);
-}
-
-static struct iommu_table_ops pnv_ioda1_iommu_ops = {
-	.set = pnv_ioda1_tce_build,
-#ifdef CONFIG_IOMMU_API
-	.exchange = pnv_ioda1_tce_xchg,
-	.exchange_rm = pnv_ioda1_tce_xchg_rm,
-	.useraddrptr = pnv_tce_useraddrptr,
-#endif
-	.clear = pnv_ioda1_tce_free,
-	.get = pnv_tce_get,
-};
-
-#define PHB3_TCE_KILL_INVAL_ALL		PPC_BIT(0)
-#define PHB3_TCE_KILL_INVAL_PE		PPC_BIT(1)
-#define PHB3_TCE_KILL_INVAL_ONE		PPC_BIT(2)
-
-static void pnv_pci_phb3_tce_invalidate_entire(struct pnv_phb *phb, bool rm)
-{
-	__be64 __iomem *invalidate = pnv_ioda_get_inval_reg(phb, rm);
-	const unsigned long val = PHB3_TCE_KILL_INVAL_ALL;
-
-	mb(); /* Ensure previous TCE table stores are visible */
-	if (rm)
-		__raw_rm_writeq_be(val, invalidate);
-	else
-		__raw_writeq_be(val, invalidate);
-}
-
-static inline void pnv_pci_phb3_tce_invalidate_pe(struct pnv_ioda_pe *pe)
-{
-	/* 01xb - invalidate TCEs that match the specified PE# */
-	__be64 __iomem *invalidate = pnv_ioda_get_inval_reg(pe->phb, false);
-	unsigned long val = PHB3_TCE_KILL_INVAL_PE | (pe->pe_number & 0xFF);
-
-	mb(); /* Ensure above stores are visible */
-	__raw_writeq_be(val, invalidate);
-}
-
-static void pnv_pci_phb3_tce_invalidate(struct pnv_ioda_pe *pe, bool rm,
-					unsigned shift, unsigned long index,
-					unsigned long npages)
-{
-	__be64 __iomem *invalidate = pnv_ioda_get_inval_reg(pe->phb, rm);
-	unsigned long start, end, inc;
-
-	/* We'll invalidate DMA address in PE scope */
-	start = PHB3_TCE_KILL_INVAL_ONE;
-	start |= (pe->pe_number & 0xFF);
-	end = start;
-
-	/* Figure out the start, end and step */
-	start |= (index << shift);
-	end |= ((index + npages - 1) << shift);
-	inc = (0x1ull << shift);
-	mb();
-
-	while (start <= end) {
-		if (rm)
-			__raw_rm_writeq_be(start, invalidate);
-		else
-			__raw_writeq_be(start, invalidate);
-		start += inc;
-	}
-}
-
-static inline void pnv_pci_ioda2_tce_invalidate_pe(struct pnv_ioda_pe *pe)
-{
-	struct pnv_phb *phb = pe->phb;
-
-	if (phb->model == PNV_PHB_MODEL_PHB3 && phb->regs)
-		pnv_pci_phb3_tce_invalidate_pe(pe);
-	else
-		opal_pci_tce_kill(phb->opal_id, OPAL_PCI_TCE_KILL_PE,
-				  pe->pe_number, 0, 0, 0);
-}
-
-static void pnv_pci_ioda2_tce_invalidate(struct iommu_table *tbl,
-		unsigned long index, unsigned long npages, bool rm)
-{
-	struct iommu_table_group_link *tgl;
-
-	list_for_each_entry_lockless(tgl, &tbl->it_group_list, next) {
-		struct pnv_ioda_pe *pe = container_of(tgl->table_group,
-				struct pnv_ioda_pe, table_group);
-		struct pnv_phb *phb = pe->phb;
-		unsigned int shift = tbl->it_page_shift;
-
-		/*
-		 * NVLink1 can use the TCE kill register directly as
-		 * it's the same as PHB3. NVLink2 is different and
-		 * should go via the OPAL call.
-		 */
-		if (phb->model == PNV_PHB_MODEL_NPU) {
-			/*
-			 * The NVLink hardware does not support TCE kill
-			 * per TCE entry so we have to invalidate
-			 * the entire cache for it.
-			 */
-			pnv_pci_phb3_tce_invalidate_entire(phb, rm);
-			continue;
-		}
-		if (phb->model == PNV_PHB_MODEL_PHB3 && phb->regs)
-			pnv_pci_phb3_tce_invalidate(pe, rm, shift,
-						    index, npages);
-		else
-			opal_pci_tce_kill(phb->opal_id,
-					  OPAL_PCI_TCE_KILL_PAGES,
-					  pe->pe_number, 1u << shift,
-					  index << shift, npages);
-	}
-}
-
-void pnv_pci_ioda2_tce_invalidate_entire(struct pnv_phb *phb, bool rm)
-{
-	if (phb->model == PNV_PHB_MODEL_NPU || phb->model == PNV_PHB_MODEL_PHB3)
-		pnv_pci_phb3_tce_invalidate_entire(phb, rm);
-	else
-		opal_pci_tce_kill(phb->opal_id, OPAL_PCI_TCE_KILL, 0, 0, 0, 0);
-}
-
-static int pnv_ioda2_tce_build(struct iommu_table *tbl, long index,
-		long npages, unsigned long uaddr,
-		enum dma_data_direction direction,
-		unsigned long attrs)
-{
-	int ret = pnv_tce_build(tbl, index, npages, uaddr, direction,
-			attrs);
-
-	if (!ret)
-		pnv_pci_ioda2_tce_invalidate(tbl, index, npages, false);
-
-	return ret;
-}
-
-#ifdef CONFIG_IOMMU_API
-static int pnv_ioda2_tce_xchg(struct iommu_table *tbl, long index,
-		unsigned long *hpa, enum dma_data_direction *direction)
-{
-	long ret = pnv_tce_xchg(tbl, index, hpa, direction, true);
-
-	if (!ret)
-		pnv_pci_ioda2_tce_invalidate(tbl, index, 1, false);
-
-	return ret;
-}
-
-static int pnv_ioda2_tce_xchg_rm(struct iommu_table *tbl, long index,
-		unsigned long *hpa, enum dma_data_direction *direction)
-{
-	long ret = pnv_tce_xchg(tbl, index, hpa, direction, false);
-
-	if (!ret)
-		pnv_pci_ioda2_tce_invalidate(tbl, index, 1, true);
-
-	return ret;
-}
-#endif
-
-static void pnv_ioda2_tce_free(struct iommu_table *tbl, long index,
-		long npages)
-{
-	pnv_tce_free(tbl, index, npages);
-
-	pnv_pci_ioda2_tce_invalidate(tbl, index, npages, false);
+	pnv_pci_tce_invalidate(tbl, index, npages, false);
 }
 
 static struct iommu_table_ops pnv_ioda2_iommu_ops = {
-	.set = pnv_ioda2_tce_build,
+	.set = pnv_ioda_tce_build,
 #ifdef CONFIG_IOMMU_API
-	.exchange = pnv_ioda2_tce_xchg,
-	.exchange_rm = pnv_ioda2_tce_xchg_rm,
+	.exchange = pnv_ioda_tce_xchg,
+	.exchange_rm = pnv_ioda_tce_xchg_rm,
 	.useraddrptr = pnv_tce_useraddrptr,
 #endif
-	.clear = pnv_ioda2_tce_free,
+	.clear = pnv_ioda_tce_free,
 	.get = pnv_tce_get,
 	.free = pnv_pci_ioda2_table_free_pages,
 };
 
+static struct iommu_table_ops pnv_ioda1_iommu_ops = {
+	.set = pnv_ioda_tce_build,
+#ifdef CONFIG_IOMMU_API
+	.exchange = pnv_ioda_tce_xchg,
+	.exchange_rm = pnv_ioda_tce_xchg_rm,
+	.useraddrptr = pnv_tce_useraddrptr,
+#endif
+	.clear = pnv_ioda_tce_free,
+	.get = pnv_tce_get,
+};
+
 static int pnv_pci_ioda_dev_dma_weight(struct pci_dev *dev, void *data)
 {
 	unsigned int *weight = (unsigned int *)data;
@@ -2413,7 +2255,7 @@ static long pnv_pci_ioda2_set_window(struct iommu_table_group *table_group,
 
 	pnv_pci_link_table_and_group(phb->hose->node, num,
 			tbl, &pe->table_group);
-	pnv_pci_ioda2_tce_invalidate_pe(pe);
+	pnv_pci_ioda_tce_invalidate_pe(pe);
 
 	return 0;
 }
@@ -2547,7 +2389,7 @@ static long pnv_pci_ioda2_unset_window(struct iommu_table_group *table_group,
 	if (ret)
 		pe_warn(pe, "Unmapping failed, ret = %ld\n", ret);
 	else
-		pnv_pci_ioda2_tce_invalidate_pe(pe);
+		pnv_pci_ioda_tce_invalidate_pe(pe);
 
 	pnv_pci_unlink_table_and_group(table_group->tables[num], table_group);
 
@@ -3525,7 +3367,7 @@ static void pnv_pci_ioda1_release_pe_dma(struct pnv_ioda_pe *pe)
 	if (rc != OPAL_SUCCESS)
 		return;
 
-	pnv_pci_p7ioc_tce_invalidate(tbl, tbl->it_offset, tbl->it_size, false);
+	pnv_pci_tce_invalidate(tbl, tbl->it_offset, tbl->it_size, false);
 	if (pe->table_group.group) {
 		iommu_group_put(pe->table_group.group);
 		WARN_ON(pe->table_group.group);
@@ -3730,6 +3572,82 @@ static const struct pci_controller_ops pnv_npu_ocapi_ioda_controller_ops = {
 	.shutdown		= pnv_pci_ioda_shutdown,
 };
 
+#define PHB3_TCE_KILL_INVAL_ALL		PPC_BIT(0)
+#define PHB3_TCE_KILL_INVAL_PE		PPC_BIT(1)
+#define PHB3_TCE_KILL_INVAL_ONE		PPC_BIT(2)
+
+static void pnv_ioda2_direct_tce_invalidate(struct pnv_phb *phb,
+		struct pnv_ioda_pe *pe, struct iommu_table *tbl,
+		unsigned long index, unsigned long npages, bool rm)
+{
+	__be64 __iomem *invalidate = pnv_ioda_get_inval_reg(phb, rm);
+	unsigned int shift = tbl->it_page_shift;
+	unsigned long start, end, inc;
+
+	if (!tbl || tbl->it_size == npages) {
+		/* 01xb - invalidate TCEs that match the specified PE# */
+		unsigned long val = PHB3_TCE_KILL_INVAL_PE |
+				(pe->pe_number & 0xFF);
+
+		mb(); /* Ensure above stores are visible */
+		__raw_writeq_be(val, invalidate);
+		return;
+	}
+
+	/* We'll invalidate DMA address in PE scope */
+	start = PHB3_TCE_KILL_INVAL_ONE;
+	start |= (pe->pe_number & 0xFF);
+	end = start;
+
+	/* Figure out the start, end and step */
+	start |= (index << shift);
+	end |= ((index + npages - 1) << shift);
+	inc = (0x1ull << shift);
+	mb(); /* Ensure above stores are visible */
+
+	while (start <= end) {
+		if (rm)
+			__raw_rm_writeq_be(start, invalidate);
+		else
+			__raw_writeq_be(start, invalidate);
+		start += inc;
+	}
+}
+
+static void pnv_ioda2_opal_tce_invalidate(struct pnv_phb *phb,
+		struct pnv_ioda_pe *pe, struct iommu_table *tbl,
+		unsigned long index, unsigned long npages, bool realmode)
+{
+	if (!tbl || tbl->it_size == npages) {
+		opal_pci_tce_kill(phb->opal_id, OPAL_PCI_TCE_KILL_PE,
+				pe->pe_number, 0, 0, 0);
+		return;
+	}
+
+	opal_pci_tce_kill(phb->opal_id, OPAL_PCI_TCE_KILL_PAGES, pe->pe_number,
+			1u << tbl->it_page_shift, index << tbl->it_page_shift,
+			npages);
+}
+
+static void pnv_ioda2_npu_tce_invalidate(struct pnv_phb *phb,
+		struct pnv_ioda_pe *npe, struct iommu_table *tbl,
+		unsigned long index, unsigned long npages, bool rm)
+{
+	/*
+	 * The NVLink hardware does not support TCE kill
+	 * per TCE entry so we have to invalidate
+	 * the entire cache for it.
+	 */
+	__be64 __iomem *invalidate = pnv_ioda_get_inval_reg(phb, rm);
+	const unsigned long val = PHB3_TCE_KILL_INVAL_ALL;
+
+	mb(); /* Ensure previous TCE table stores are visible */
+	if (rm)
+		__raw_rm_writeq_be(val, invalidate);
+	else
+		__raw_writeq_be(val, invalidate);
+}
+
 static void __init pnv_pci_init_ioda_phb(struct device_node *np,
 					 u64 hub_id, int ioda_type)
 {
@@ -3787,16 +3705,22 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
 	mutex_init(&phb->ioda.pe_alloc_mutex);
 
 	/* Detect specific models for error handling */
-	if (of_device_is_compatible(np, "ibm,p7ioc-pciex"))
+	if (of_device_is_compatible(np, "ibm,p7ioc-pciex")) {
 		phb->model = PNV_PHB_MODEL_P7IOC;
-	else if (of_device_is_compatible(np, "ibm,power8-pciex"))
+		phb->tce_invalidate = pnv_ioda1_tce_invalidate;
+	} else if (of_device_is_compatible(np, "ibm,power8-pciex")) {
 		phb->model = PNV_PHB_MODEL_PHB3;
-	else if (of_device_is_compatible(np, "ibm,power8-npu-pciex"))
+		phb->tce_invalidate = pnv_ioda2_opal_tce_invalidate;
+	} else if (of_device_is_compatible(np, "ibm,power8-npu-pciex")) {
 		phb->model = PNV_PHB_MODEL_NPU;
-	else if (of_device_is_compatible(np, "ibm,power9-npu-pciex"))
+		phb->tce_invalidate = pnv_ioda2_npu_tce_invalidate;
+	} else if (of_device_is_compatible(np, "ibm,power9-npu-pciex")) {
 		phb->model = PNV_PHB_MODEL_NPU2;
-	else
+		phb->tce_invalidate = pnv_ioda2_opal_tce_invalidate;
+	} else {
 		phb->model = PNV_PHB_MODEL_UNKNOWN;
+		phb->tce_invalidate = pnv_ioda2_opal_tce_invalidate;
+	}
 
 	/* Initialize diagnostic data buffer */
 	prop32 = of_get_property(np, "ibm,phb-diag-data-size", NULL);
@@ -3816,6 +3740,8 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
 		phb->regs = ioremap(r.start, resource_size(&r));
 		if (phb->regs == NULL)
 			pr_err("  Failed to map registers !\n");
+		else if (phb->model == PNV_PHB_MODEL_PHB3)
+			phb->tce_invalidate = pnv_ioda2_direct_tce_invalidate;
 	}
 
 	/* Initialize more IODA stuff */
-- 
2.11.0

