Return-Path: <aik@ozlabs.ru>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5B5831A0CCD
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2015 18:46:26 +1000 (AEST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Fri, 29 May 2015 18:46:24 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id C52202BB005C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2015 18:46:21 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4T8kDBr65929308
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2015 18:46:21 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4T8jmmi022950
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2015 18:45:49 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alex Williamson <alex.williamson@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH kernel v11 20/34] powerpc/powernv/ioda2: Move TCE kill
 register address to PE
Date: Fri, 29 May 2015 18:44:44 +1000
Message-Id: <1432889098-22924-21-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1432889098-22924-1-git-send-email-aik@ozlabs.ru>
References: <1432889098-22924-1-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

At the moment the DMA setup code looks for the "ibm,opal-tce-kill"
property which contains the TCE kill register address. Writing to
this register invalidates TCE cache on IODA/IODA2 hub.

This moves the register address from iommu_table to pnv_pnb as this
register belongs to PHB and invalidates TCE cache for all tables of
all attached PEs.

This moves the property reading/remapping code to a helper which is
called when DMA is being configured for PE and which does DMA setup
for both IODA1 and IODA2.

This adds a new pnv_pci_ioda2_tce_invalidate_entire() helper which
invalidates cache for the entire table. It should be called after
every call to opal_pci_map_pe_dma_window(). It was not required before
because there was just a single TCE table and 64bit DMA was handled via
bypass window (which has no table so no cache was used) but this is going
to change with Dynamic DMA windows (DDW).

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
Changes:
v11:
* s/pnv_pci_ioda2_tvt_invalidate/pnv_pci_ioda2_tce_invalidate_entire/g
(cannot think of better-and-shorter name)
* moved tce_inval_reg_phys/tce_inval_reg to pnv_phb

v10:
* fixed error from checkpatch.pl
* removed comment at "ibm,opal-tce-kill" parsing as irrelevant
* s/addr/val/ in pnv_pci_ioda2_tvt_invalidate() as it was not a kernel address

v9:
* new in the series
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 66 ++++++++++++++++++-------------
 arch/powerpc/platforms/powernv/pci.h      |  7 +++-
 2 files changed, 44 insertions(+), 29 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 1d0bb5b..3fd8b18 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1679,8 +1679,8 @@ static void pnv_pci_ioda1_tce_invalidate(struct iommu_table *tbl,
 	struct pnv_ioda_pe *pe = container_of(tgl->table_group,
 			struct pnv_ioda_pe, table_group);
 	__be64 __iomem *invalidate = rm ?
-		(__be64 __iomem *)pe->tce_inval_reg_phys :
-		(__be64 __iomem *)tbl->it_index;
+		(__be64 __iomem *)pe->phb->ioda.tce_inval_reg_phys :
+		pe->phb->ioda.tce_inval_reg;
 	unsigned long start, end, inc;
 	const unsigned shift = tbl->it_page_shift;
 
@@ -1751,6 +1751,19 @@ static struct iommu_table_ops pnv_ioda1_iommu_ops = {
 	.get = pnv_tce_get,
 };
 
+static inline void pnv_pci_ioda2_tce_invalidate_entire(struct pnv_ioda_pe *pe)
+{
+	/* 01xb - invalidate TCEs that match the specified PE# */
+	unsigned long val = (0x4ull << 60) | (pe->pe_number & 0xFF);
+	struct pnv_phb *phb = pe->phb;
+
+	if (!phb->ioda.tce_inval_reg)
+		return;
+
+	mb(); /* Ensure above stores are visible */
+	__raw_writeq(cpu_to_be64(val), phb->ioda.tce_inval_reg);
+}
+
 static void pnv_pci_ioda2_tce_invalidate(struct iommu_table *tbl,
 		unsigned long index, unsigned long npages, bool rm)
 {
@@ -1761,8 +1774,8 @@ static void pnv_pci_ioda2_tce_invalidate(struct iommu_table *tbl,
 			struct pnv_ioda_pe, table_group);
 	unsigned long start, end, inc;
 	__be64 __iomem *invalidate = rm ?
-		(__be64 __iomem *)pe->tce_inval_reg_phys :
-		(__be64 __iomem *)tbl->it_index;
+		(__be64 __iomem *)pe->phb->ioda.tce_inval_reg_phys :
+		pe->phb->ioda.tce_inval_reg;
 	const unsigned shift = tbl->it_page_shift;
 
 	/* We'll invalidate DMA address in PE scope */
@@ -1820,7 +1833,6 @@ static void pnv_pci_ioda_setup_dma_pe(struct pnv_phb *phb,
 {
 
 	struct page *tce_mem = NULL;
-	const __be64 *swinvp;
 	struct iommu_table *tbl;
 	unsigned int i;
 	int64_t rc;
@@ -1877,20 +1889,11 @@ static void pnv_pci_ioda_setup_dma_pe(struct pnv_phb *phb,
 				  base << 28, IOMMU_PAGE_SHIFT_4K);
 
 	/* OPAL variant of P7IOC SW invalidated TCEs */
-	swinvp = of_get_property(phb->hose->dn, "ibm,opal-tce-kill", NULL);
-	if (swinvp) {
-		/* We need a couple more fields -- an address and a data
-		 * to or.  Since the bus is only printed out on table free
-		 * errors, and on the first pass the data will be a relative
-		 * bus number, print that out instead.
-		 */
-		pe->tce_inval_reg_phys = be64_to_cpup(swinvp);
-		tbl->it_index = (unsigned long)ioremap(pe->tce_inval_reg_phys,
-				8);
+	if (phb->ioda.tce_inval_reg)
 		tbl->it_type |= (TCE_PCI_SWINV_CREATE |
 				 TCE_PCI_SWINV_FREE   |
 				 TCE_PCI_SWINV_PAIR);
-	}
+
 	tbl->it_ops = &pnv_ioda1_iommu_ops;
 	iommu_init_table(tbl, phb->hose->node);
 
@@ -1971,12 +1974,24 @@ static struct iommu_table_group_ops pnv_pci_ioda2_ops = {
 };
 #endif
 
+static void pnv_pci_ioda_setup_opal_tce_kill(struct pnv_phb *phb)
+{
+	const __be64 *swinvp;
+
+	/* OPAL variant of PHB3 invalidated TCEs */
+	swinvp = of_get_property(phb->hose->dn, "ibm,opal-tce-kill", NULL);
+	if (!swinvp)
+		return;
+
+	phb->ioda.tce_inval_reg_phys = be64_to_cpup(swinvp);
+	phb->ioda.tce_inval_reg = ioremap(phb->ioda.tce_inval_reg_phys, 8);
+}
+
 static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
 				       struct pnv_ioda_pe *pe)
 {
 	struct page *tce_mem = NULL;
 	void *addr;
-	const __be64 *swinvp;
 	struct iommu_table *tbl;
 	unsigned int tce_table_size, end;
 	int64_t rc;
@@ -2023,23 +2038,16 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
 		goto fail;
 	}
 
+	pnv_pci_ioda2_tce_invalidate_entire(pe);
+
 	/* Setup linux iommu table */
 	pnv_pci_setup_iommu_table(tbl, addr, tce_table_size, 0,
 			IOMMU_PAGE_SHIFT_4K);
 
 	/* OPAL variant of PHB3 invalidated TCEs */
-	swinvp = of_get_property(phb->hose->dn, "ibm,opal-tce-kill", NULL);
-	if (swinvp) {
-		/* We need a couple more fields -- an address and a data
-		 * to or.  Since the bus is only printed out on table free
-		 * errors, and on the first pass the data will be a relative
-		 * bus number, print that out instead.
-		 */
-		pe->tce_inval_reg_phys = be64_to_cpup(swinvp);
-		tbl->it_index = (unsigned long)ioremap(pe->tce_inval_reg_phys,
-				8);
+	if (phb->ioda.tce_inval_reg)
 		tbl->it_type |= (TCE_PCI_SWINV_CREATE | TCE_PCI_SWINV_FREE);
-	}
+
 	tbl->it_ops = &pnv_ioda2_iommu_ops;
 	iommu_init_table(tbl, phb->hose->node);
 #ifdef CONFIG_IOMMU_API
@@ -2095,6 +2103,8 @@ static void pnv_ioda_setup_dma(struct pnv_phb *phb)
 	pr_info("PCI: %d PE# for a total weight of %d\n",
 		phb->ioda.dma_pe_count, phb->ioda.dma_weight);
 
+	pnv_pci_ioda_setup_opal_tce_kill(phb);
+
 	/* Walk our PE list and configure their DMA segments, hand them
 	 * out one base segment plus any residual segments based on
 	 * weight
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index 87bdd4f..d1e6978 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -58,7 +58,6 @@ struct pnv_ioda_pe {
 	int			tce32_seg;
 	int			tce32_segcount;
 	struct iommu_table_group table_group;
-	phys_addr_t		tce_inval_reg_phys;
 
 	/* 64-bit TCE bypass region */
 	bool			tce_bypass_enabled;
@@ -187,6 +186,12 @@ struct pnv_phb {
 			 * boot for resource allocation purposes
 			 */
 			struct list_head	pe_dma_list;
+
+			/* TCE cache invalidate registers (physical and
+			 * remapped)
+			 */
+			phys_addr_t		tce_inval_reg_phys;
+			__be64 __iomem		*tce_inval_reg;
 		} ioda;
 	};
 
-- 
2.4.0.rc3.8.gfb3e7d5
