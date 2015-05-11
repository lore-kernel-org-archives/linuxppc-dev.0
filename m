Return-Path: <aik@ozlabs.ru>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 312AB1A03E1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2015 01:41:13 +1000 (AEST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Tue, 12 May 2015 01:41:13 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id AE97F2BB0057
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2015 01:41:10 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4BFf2kk26017854
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2015 01:41:10 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4BFecri029513
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2015 01:40:38 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel v10 20/34] powerpc/powernv/ioda2: Move TCE kill
 register address to PE
Date: Tue, 12 May 2015 01:39:09 +1000
Message-Id: <1431358763-24371-21-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1431358763-24371-1-git-send-email-aik@ozlabs.ru>
References: <1431358763-24371-1-git-send-email-aik@ozlabs.ru>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

At the moment the DMA setup code looks for the "ibm,opal-tce-kill" property
which contains the TCE kill register address. Writes to this register
invalidates TCE cache on IODA/IODA2 hub.

This moves the register address from iommu_table to pnv_ioda_pe as:
1) When we get 2 tables per PE, this register will be used for both tables;
2) When we get TCE tables sharing, we will need to invalidate every
IOMMU group (i.e. PE) which is using this table and each PE has
its own invalidate register.

This moves the property reading/remapping code to a helper to reduce
code duplication. Although this change is not required for IODA1, this
changes it as well to reduce code duplication.

This adds a new pnv_pci_ioda2_tvt_invalidate() helper which invalidates
the entire table. It should be called after every call to
opal_pci_map_pe_dma_window(). It was not required before because
there is just a single TCE table and 64bit DMA is handled via bypass
window (which has no table so no chache is used) but this is going
to change with Dynamic DMA windows (DDW).

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
Changes:
v10:
* fixed error from checkpatch.pl
* removed comment at "ibm,opal-tce-kill" parsing as irrelevant
* s/addr/val/ in pnv_pci_ioda2_tvt_invalidate() as it was not a kernel address

v9:
* new in the series
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 64 ++++++++++++++++++-------------
 arch/powerpc/platforms/powernv/pci.h      |  1 +
 2 files changed, 39 insertions(+), 26 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 35ab19c8..f972e40 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1680,7 +1680,7 @@ static void pnv_pci_ioda1_tce_invalidate(struct iommu_table *tbl,
 			struct pnv_ioda_pe, table_group);
 	__be64 __iomem *invalidate = rm ?
 		(__be64 __iomem *)pe->tce_inval_reg_phys :
-		(__be64 __iomem *)tbl->it_index;
+		pe->tce_inval_reg;
 	unsigned long start, end, inc;
 	const unsigned shift = tbl->it_page_shift;
 
@@ -1751,6 +1751,18 @@ static struct iommu_table_ops pnv_ioda1_iommu_ops = {
 	.get = pnv_tce_get,
 };
 
+static inline void pnv_pci_ioda2_tvt_invalidate(struct pnv_ioda_pe *pe)
+{
+	/* 01xb - invalidate TCEs that match the specified PE# */
+	unsigned long val = (0x4ull << 60) | (pe->pe_number & 0xFF);
+
+	if (!pe->tce_inval_reg)
+		return;
+
+	mb(); /* Ensure above stores are visible */
+	__raw_writeq(cpu_to_be64(val), pe->tce_inval_reg);
+}
+
 static void pnv_pci_ioda2_tce_invalidate(struct iommu_table *tbl,
 		unsigned long index, unsigned long npages, bool rm)
 {
@@ -1762,7 +1774,7 @@ static void pnv_pci_ioda2_tce_invalidate(struct iommu_table *tbl,
 	unsigned long start, end, inc;
 	__be64 __iomem *invalidate = rm ?
 		(__be64 __iomem *)pe->tce_inval_reg_phys :
-		(__be64 __iomem *)tbl->it_index;
+		pe->tce_inval_reg;
 	const unsigned shift = tbl->it_page_shift;
 
 	/* We'll invalidate DMA address in PE scope */
@@ -1814,13 +1826,26 @@ static struct iommu_table_ops pnv_ioda2_iommu_ops = {
 	.get = pnv_tce_get,
 };
 
+static void pnv_pci_ioda_setup_opal_tce_kill(struct pnv_phb *phb,
+		struct pnv_ioda_pe *pe)
+{
+	const __be64 *swinvp;
+
+	/* OPAL variant of PHB3 invalidated TCEs */
+	swinvp = of_get_property(phb->hose->dn, "ibm,opal-tce-kill", NULL);
+	if (!swinvp)
+		return;
+
+	pe->tce_inval_reg_phys = be64_to_cpup(swinvp);
+	pe->tce_inval_reg = ioremap(pe->tce_inval_reg_phys, 8);
+}
+
 static void pnv_pci_ioda_setup_dma_pe(struct pnv_phb *phb,
 				      struct pnv_ioda_pe *pe, unsigned int base,
 				      unsigned int segs)
 {
 
 	struct page *tce_mem = NULL;
-	const __be64 *swinvp;
 	struct iommu_table *tbl;
 	unsigned int i;
 	int64_t rc;
@@ -1839,6 +1864,8 @@ static void pnv_pci_ioda_setup_dma_pe(struct pnv_phb *phb,
 			pe->pe_number);
 	pnv_pci_link_table_and_group(phb->hose->node, 0, tbl, &pe->table_group);
 
+	pnv_pci_ioda_setup_opal_tce_kill(phb, pe);
+
 	/* Grab a 32-bit TCE table */
 	pe->tce32_seg = base;
 	pe_info(pe, " Setting up 32-bit TCE table at %08x..%08x\n",
@@ -1877,20 +1904,11 @@ static void pnv_pci_ioda_setup_dma_pe(struct pnv_phb *phb,
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
+	if (pe->tce_inval_reg)
 		tbl->it_type |= (TCE_PCI_SWINV_CREATE |
 				 TCE_PCI_SWINV_FREE   |
 				 TCE_PCI_SWINV_PAIR);
-	}
+
 	tbl->it_ops = &pnv_ioda1_iommu_ops;
 	iommu_init_table(tbl, phb->hose->node);
 
@@ -1976,7 +1994,6 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
 {
 	struct page *tce_mem = NULL;
 	void *addr;
-	const __be64 *swinvp;
 	struct iommu_table *tbl;
 	unsigned int tce_table_size, end;
 	int64_t rc;
@@ -1993,6 +2010,8 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
 			pe->pe_number);
 	pnv_pci_link_table_and_group(phb->hose->node, 0, tbl, &pe->table_group);
 
+	pnv_pci_ioda_setup_opal_tce_kill(phb, pe);
+
 	/* The PE will reserve all possible 32-bits space */
 	pe->tce32_seg = 0;
 	end = (1 << ilog2(phb->ioda.m32_pci_base));
@@ -2023,23 +2042,16 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
 		goto fail;
 	}
 
+	pnv_pci_ioda2_tvt_invalidate(pe);
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
+	if (pe->tce_inval_reg)
 		tbl->it_type |= (TCE_PCI_SWINV_CREATE | TCE_PCI_SWINV_FREE);
-	}
+
 	tbl->it_ops = &pnv_ioda2_iommu_ops;
 	iommu_init_table(tbl, phb->hose->node);
 #ifdef CONFIG_IOMMU_API
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index 87bdd4f..ea97de5 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -59,6 +59,7 @@ struct pnv_ioda_pe {
 	int			tce32_segcount;
 	struct iommu_table_group table_group;
 	phys_addr_t		tce_inval_reg_phys;
+	__be64 __iomem		*tce_inval_reg;
 
 	/* 64-bit TCE bypass region */
 	bool			tce_bypass_enabled;
-- 
2.4.0.rc3.8.gfb3e7d5
