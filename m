Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rm4YT3NjQzDrKJ
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jul 2016 16:37:49 +1000 (AEST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rm4YS3kRWz9s5Q
 for <linuxppc-dev@ozlabs.org>; Fri,  8 Jul 2016 16:37:48 +1000 (AEST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 10/14] powerpc/powernv/pci: Rework accessing the TCE
 invalidate register
Date: Fri,  8 Jul 2016 16:37:14 +1000
Message-Id: <1467959838-6900-10-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1467959838-6900-1-git-send-email-benh@kernel.crashing.org>
References: <1467959838-6900-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

It's architected, always in a known place, so there is no need
to keep a separate pointer to it, we use the existing "regs",
and we complement it with a real mode variant.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

# Conflicts:
#	arch/powerpc/platforms/powernv/pci-ioda.c
#	arch/powerpc/platforms/powernv/pci.h
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 69 ++++++++++++-------------------
 arch/powerpc/platforms/powernv/pci.h      |  7 +---
 2 files changed, 28 insertions(+), 48 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index dc13c14..ac4a432 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1727,6 +1727,13 @@ static void pnv_ioda_setup_bus_dma(struct pnv_ioda_pe *pe,
 	}
 }
 
+static inline __be64 __iomem *pnv_ioda_get_inval_reg(struct pnv_phb *phb,
+						     bool real_mode)
+{
+	return real_mode ? (__be64 __iomem *)(phb->regs_phys + 0x210) :
+		(phb->regs + 0x210);
+}
+
 static void pnv_pci_p7ioc_tce_invalidate(struct iommu_table *tbl,
 		unsigned long index, unsigned long npages, bool rm)
 {
@@ -1735,9 +1742,7 @@ static void pnv_pci_p7ioc_tce_invalidate(struct iommu_table *tbl,
 			next);
 	struct pnv_ioda_pe *pe = container_of(tgl->table_group,
 			struct pnv_ioda_pe, table_group);
-	__be64 __iomem *invalidate = rm ?
-		(__be64 __iomem *)pe->phb->ioda.tce_inval_reg_phys :
-		pe->phb->ioda.tce_inval_reg;
+	__be64 __iomem *invalidate = pnv_ioda_get_inval_reg(pe->phb, rm);
 	unsigned long start, end, inc;
 
 	start = __pa(((__be64 *)tbl->it_base) + index - tbl->it_offset);
@@ -1815,39 +1820,36 @@ static struct iommu_table_ops pnv_ioda1_iommu_ops = {
 
 void pnv_pci_phb3_tce_invalidate_entire(struct pnv_phb *phb, bool rm)
 {
+	__be64 __iomem *invalidate = pnv_ioda_get_inval_reg(phb, rm);
 	const unsigned long val = PHB3_TCE_KILL_INVAL_ALL;
 
 	mb(); /* Ensure previous TCE table stores are visible */
 	if (rm)
-		__raw_rm_writeq(cpu_to_be64(val),
-				(__be64 __iomem *)
-				phb->ioda.tce_inval_reg_phys);
+		__raw_rm_writeq(cpu_to_be64(val), invalidate);
 	else
-		__raw_writeq(cpu_to_be64(val), phb->ioda.tce_inval_reg);
+		__raw_writeq(cpu_to_be64(val), invalidate);
 }
 
 static inline void pnv_pci_phb3_tce_invalidate_pe(struct pnv_ioda_pe *pe)
 {
 	/* 01xb - invalidate TCEs that match the specified PE# */
+	__be64 __iomem *invalidate = pnv_ioda_get_inval_reg(pe->phb, false);
 	unsigned long val = PHB3_TCE_KILL_INVAL_PE | (pe->pe_number & 0xFF);
-	struct pnv_phb *phb = pe->phb;
-
-	if (!phb->ioda.tce_inval_reg)
-		return;
 
 	mb(); /* Ensure above stores are visible */
-	__raw_writeq(cpu_to_be64(val), phb->ioda.tce_inval_reg);
+	__raw_writeq(cpu_to_be64(val), invalidate);
 }
 
-static void pnv_pci_phb3_tce_invalidate(unsigned pe_number, bool rm,
-		__be64 __iomem *invalidate, unsigned shift,
-		unsigned long index, unsigned long npages)
+static void pnv_pci_phb3_tce_invalidate(struct pnv_ioda_pe *pe, bool rm,
+					unsigned shift, unsigned long index,
+					unsigned long npages)
 {
+	__be64 __iomem *invalidate = pnv_ioda_get_inval_reg(pe->phb, false);
 	unsigned long start, end, inc;
 
 	/* We'll invalidate DMA address in PE scope */
 	start = PHB3_TCE_KILL_INVAL_ONE;
-	start |= (pe_number & 0xFF);
+	start |= (pe->pe_number & 0xFF);
 	end = start;
 
 	/* Figure out the start, end and step */
@@ -1873,10 +1875,6 @@ static void pnv_pci_ioda2_tce_invalidate(struct iommu_table *tbl,
 	list_for_each_entry_rcu(tgl, &tbl->it_group_list, next) {
 		struct pnv_ioda_pe *pe = container_of(tgl->table_group,
 				struct pnv_ioda_pe, table_group);
-		__be64 __iomem *invalidate = rm ?
-			(__be64 __iomem *)pe->phb->ioda.tce_inval_reg_phys :
-			pe->phb->ioda.tce_inval_reg;
-
 		if (pe->phb->type == PNV_PHB_NPU) {
 			/*
 			 * The NVLink hardware does not support TCE kill
@@ -1886,9 +1884,8 @@ static void pnv_pci_ioda2_tce_invalidate(struct iommu_table *tbl,
 			pnv_pci_phb3_tce_invalidate_entire(pe->phb, rm);
 			continue;
 		}
-		pnv_pci_phb3_tce_invalidate(pe->pe_number, rm,
-			invalidate, tbl->it_page_shift,
-			index, npages);
+		pnv_pci_phb3_tce_invalidate(pe, rm, tbl->it_page_shift,
+					    index, npages);
 	}
 }
 
@@ -2473,19 +2470,6 @@ static void pnv_pci_ioda_setup_iommu_api(void)
 static void pnv_pci_ioda_setup_iommu_api(void) { };
 #endif
 
-static void pnv_pci_ioda_setup_opal_tce_kill(struct pnv_phb *phb)
-{
-	const __be64 *swinvp;
-
-	/* OPAL variant of PHB3 invalidated TCEs */
-	swinvp = of_get_property(phb->hose->dn, "ibm,opal-tce-kill", NULL);
-	if (!swinvp)
-		return;
-
-	phb->ioda.tce_inval_reg_phys = be64_to_cpup(swinvp);
-	phb->ioda.tce_inval_reg = ioremap(phb->ioda.tce_inval_reg_phys, 8);
-}
-
 static __be64 *pnv_pci_ioda2_table_do_alloc_pages(int nid, unsigned shift,
 		unsigned levels, unsigned long limit,
 		unsigned long *current_offset, unsigned long *total_allocated)
@@ -3600,6 +3584,7 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
 	struct pnv_phb *phb;
 	unsigned long size, m64map_off, m32map_off, pemap_off;
 	unsigned long iomap_off = 0, dma32map_off = 0;
+	struct resource r;
 	const __be64 *prop64;
 	const __be32 *prop32;
 	int len;
@@ -3660,12 +3645,12 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
 	pci_process_bridge_OF_ranges(hose, np, !hose->global_number);
 
 	/* Get registers */
-	phb->regs = of_iomap(np, 0);
-	if (phb->regs == NULL)
-		pr_err("  Failed to map registers !\n");
-
-	/* Initialize TCE kill register */
-	pnv_pci_ioda_setup_opal_tce_kill(phb);
+	if (!of_address_to_resource(np, 0, &r)) {
+		phb->regs_phys = r.start;
+		phb->regs = ioremap(r.start, resource_size(&r));
+		if (phb->regs == NULL)
+			pr_err("  Failed to map registers !\n");
+	}
 
 	/* Initialize more IODA stuff */
 	phb->ioda.total_pe_num = 1;
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index 8666471..23a86a2 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -81,6 +81,7 @@ struct pnv_phb {
 	u64			opal_id;
 	int			flags;
 	void __iomem		*regs;
+	u64			regs_phys;
 	int			initialized;
 	spinlock_t		lock;
 
@@ -157,12 +158,6 @@ struct pnv_phb {
 
 		/* Reverse map of PEs, indexed by {bus, devfn} */
 		unsigned int		pe_rmap[0x10000];
-
-		/* TCE cache invalidate registers (physical and
-		 * remapped)
-		 */
-		phys_addr_t		tce_inval_reg_phys;
-		__be64 __iomem		*tce_inval_reg;
 	} ioda;
 
 	/* PHB and hub status structure */
-- 
2.7.4
