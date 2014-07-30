Return-Path: <aik@ozlabs.ru>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 146BD1A03E5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Jul 2014 19:31:48 +1000 (EST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Wed, 30 Jul 2014 19:31:28 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 439083578023
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Jul 2014 19:31:42 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6U98fLA59703350
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Jul 2014 19:08:41 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6U9Vf33031325
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Jul 2014 19:31:42 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4 06/16] powerpc/powernv: Make invalidate() a callback
Date: Wed, 30 Jul 2014 19:31:25 +1000
Message-Id: <1406712695-9491-7-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1406712695-9491-1-git-send-email-aik@ozlabs.ru>
References: <1406712695-9491-1-git-send-email-aik@ozlabs.ru>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Michael Ellerman <michael@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

At the moment pnv_pci_ioda_tce_invalidate() gets the PE pointer via
container_of(tbl). Since we are going to have to add Dynamic DMA windows
and that means having 2 IOMMU tables per PE, this is not going to work.

This implements pnv_pci_ioda(1|2)_tce_invalidate as a pnv_ioda_pe callback.

This adds a pnv_iommu_table wrapper around iommu_table and stores a pointer
to PE there. PNV's ppc_md.tce_build() call uses this to find PE and
do the invalidation. This will be used later for Dynamic DMA windows too.

This registers invalidate() callbacks for IODA1 and IODA2:
- pnv_pci_ioda1_tce_invalidate;
- pnv_pci_ioda2_tce_invalidate.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
Changes:
v4:
* changed commit log to explain why this change is needed
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 33 +++++++++++--------------------
 arch/powerpc/platforms/powernv/pci.c      | 31 +++++++++++++++++++++--------
 arch/powerpc/platforms/powernv/pci.h      | 13 +++++++++++-
 3 files changed, 47 insertions(+), 30 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 9f28e18..007497f 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -462,7 +462,7 @@ static void pnv_pci_ioda_dma_dev_setup(struct pnv_phb *phb, struct pci_dev *pdev
 
 	pe = &phb->ioda.pe_array[pdn->pe_number];
 	WARN_ON(get_dma_ops(&pdev->dev) != &dma_iommu_ops);
-	set_iommu_table_base(&pdev->dev, &pe->tce32_table);
+	set_iommu_table_base(&pdev->dev, &pe->tce32.table);
 }
 
 static int pnv_pci_ioda_dma_set_mask(struct pnv_phb *phb,
@@ -489,7 +489,7 @@ static int pnv_pci_ioda_dma_set_mask(struct pnv_phb *phb,
 	} else {
 		dev_info(&pdev->dev, "Using 32-bit DMA via iommu\n");
 		set_dma_ops(&pdev->dev, &dma_iommu_ops);
-		set_iommu_table_base(&pdev->dev, &pe->tce32_table);
+		set_iommu_table_base(&pdev->dev, &pe->tce32.table);
 	}
 	return 0;
 }
@@ -499,7 +499,7 @@ static void pnv_ioda_setup_bus_dma(struct pnv_ioda_pe *pe, struct pci_bus *bus)
 	struct pci_dev *dev;
 
 	list_for_each_entry(dev, &bus->devices, bus_list) {
-		set_iommu_table_base_and_group(&dev->dev, &pe->tce32_table);
+		set_iommu_table_base_and_group(&dev->dev, &pe->tce32.table);
 		if (dev->subordinate)
 			pnv_ioda_setup_bus_dma(pe, dev->subordinate);
 	}
@@ -584,19 +584,6 @@ static void pnv_pci_ioda2_tce_invalidate(struct pnv_ioda_pe *pe,
 	}
 }
 
-void pnv_pci_ioda_tce_invalidate(struct iommu_table *tbl,
-				 __be64 *startp, __be64 *endp, bool rm)
-{
-	struct pnv_ioda_pe *pe = container_of(tbl, struct pnv_ioda_pe,
-					      tce32_table);
-	struct pnv_phb *phb = pe->phb;
-
-	if (phb->type == PNV_PHB_IODA1)
-		pnv_pci_ioda1_tce_invalidate(pe, tbl, startp, endp, rm);
-	else
-		pnv_pci_ioda2_tce_invalidate(pe, tbl, startp, endp, rm);
-}
-
 static void pnv_pci_ioda_setup_dma_pe(struct pnv_phb *phb,
 				      struct pnv_ioda_pe *pe, unsigned int base,
 				      unsigned int segs)
@@ -654,9 +641,11 @@ static void pnv_pci_ioda_setup_dma_pe(struct pnv_phb *phb,
 	}
 
 	/* Setup linux iommu table */
-	tbl = &pe->tce32_table;
+	tbl = &pe->tce32.table;
 	pnv_pci_setup_iommu_table(tbl, addr, TCE32_TABLE_SIZE * segs,
 				  base << 28, IOMMU_PAGE_SHIFT_4K);
+	pe->tce32.pe = pe;
+	pe->tce_invalidate = pnv_pci_ioda1_tce_invalidate;
 
 	/* OPAL variant of P7IOC SW invalidated TCEs */
 	swinvp = of_get_property(phb->hose->dn, "ibm,opal-tce-kill", NULL);
@@ -693,7 +682,7 @@ static void pnv_pci_ioda_setup_dma_pe(struct pnv_phb *phb,
 static void pnv_pci_ioda2_set_bypass(struct iommu_table *tbl, bool enable)
 {
 	struct pnv_ioda_pe *pe = container_of(tbl, struct pnv_ioda_pe,
-					      tce32_table);
+					      tce32.table);
 	uint16_t window_id = (pe->pe_number << 1 ) + 1;
 	int64_t rc;
 
@@ -734,10 +723,10 @@ static void pnv_pci_ioda2_setup_bypass_pe(struct pnv_phb *phb,
 	pe->tce_bypass_base = 1ull << 59;
 
 	/* Install set_bypass callback for VFIO */
-	pe->tce32_table.set_bypass = pnv_pci_ioda2_set_bypass;
+	pe->tce32.table.set_bypass = pnv_pci_ioda2_set_bypass;
 
 	/* Enable bypass by default */
-	pnv_pci_ioda2_set_bypass(&pe->tce32_table, true);
+	pnv_pci_ioda2_set_bypass(&pe->tce32.table, true);
 }
 
 static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
@@ -785,9 +774,11 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
 	}
 
 	/* Setup linux iommu table */
-	tbl = &pe->tce32_table;
+	tbl = &pe->tce32.table;
 	pnv_pci_setup_iommu_table(tbl, addr, tce_table_size, 0,
 			IOMMU_PAGE_SHIFT_4K);
+	pe->tce32.pe = pe;
+	pe->tce_invalidate = pnv_pci_ioda2_tce_invalidate;
 
 	/* OPAL variant of PHB3 invalidated TCEs */
 	swinvp = of_get_property(phb->hose->dn, "ibm,opal-tce-kill", NULL);
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index 4dff552..74a2626 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -550,6 +550,27 @@ struct pci_ops pnv_pci_ops = {
 	.write = pnv_pci_write_config,
 };
 
+static void pnv_tce_invalidate(struct iommu_table *tbl, __be64 *startp,
+	__be64 *endp, bool rm)
+{
+	struct pnv_iommu_table *ptbl = container_of(tbl,
+			struct pnv_iommu_table, table);
+	struct pnv_ioda_pe *pe = ptbl->pe;
+
+	/*
+	 * Some implementations won't cache invalid TCEs and thus may not
+	 * need that flush. We'll probably turn it_type into a bit mask
+	 * of flags if that becomes the case
+	 */
+	if (!(tbl->it_type & TCE_PCI_SWINV_FREE))
+		return;
+
+	if (!pe || !pe->tce_invalidate)
+		return;
+
+	pe->tce_invalidate(pe, tbl, startp, endp, rm);
+}
+
 static int pnv_tce_build(struct iommu_table *tbl, long index, long npages,
 			 unsigned long uaddr, enum dma_data_direction direction,
 			 struct dma_attrs *attrs, bool rm)
@@ -570,12 +591,7 @@ static int pnv_tce_build(struct iommu_table *tbl, long index, long npages,
 		*(tcep++) = cpu_to_be64(proto_tce |
 				(rpn++ << tbl->it_page_shift));
 
-	/* Some implementations won't cache invalid TCEs and thus may not
-	 * need that flush. We'll probably turn it_type into a bit mask
-	 * of flags if that becomes the case
-	 */
-	if (tbl->it_type & TCE_PCI_SWINV_CREATE)
-		pnv_pci_ioda_tce_invalidate(tbl, tces, tcep - 1, rm);
+	pnv_tce_invalidate(tbl, tces, tcep - 1, rm);
 
 	return 0;
 }
@@ -599,8 +615,7 @@ static void pnv_tce_free(struct iommu_table *tbl, long index, long npages,
 	while (npages--)
 		*(tcep++) = cpu_to_be64(0);
 
-	if (tbl->it_type & TCE_PCI_SWINV_FREE)
-		pnv_pci_ioda_tce_invalidate(tbl, tces, tcep - 1, rm);
+	pnv_tce_invalidate(tbl, tces, tcep - 1, rm);
 }
 
 static void pnv_tce_free_vm(struct iommu_table *tbl, long index, long npages)
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index 6f5ff69..32847a5 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -22,6 +22,16 @@ enum pnv_phb_model {
 #define PNV_IODA_PE_BUS		(1 << 1)	/* PE has primary PCI bus	*/
 #define PNV_IODA_PE_BUS_ALL	(1 << 2)	/* PE has subordinate buses	*/
 
+struct pnv_ioda_pe;
+typedef void (*pnv_invalidate_fn)(struct pnv_ioda_pe *pe,
+		struct iommu_table *tbl,
+		__be64 *startp, __be64 *endp, bool rm);
+
+struct pnv_iommu_table {
+	struct iommu_table	table;
+	struct pnv_ioda_pe	*pe;
+};
+
 /* Data associated with a PE, including IOMMU tracking etc.. */
 struct pnv_phb;
 struct pnv_ioda_pe {
@@ -49,9 +59,10 @@ struct pnv_ioda_pe {
 	unsigned int		dma_weight;
 
 	/* "Base" iommu table, ie, 4K TCEs, 32-bit DMA */
+	pnv_invalidate_fn	tce_invalidate;
 	int			tce32_seg;
 	int			tce32_segcount;
-	struct iommu_table	tce32_table;
+	struct pnv_iommu_table	tce32;
 	phys_addr_t		tce_inval_reg_phys;
 
 	/* 64-bit TCE bypass region */
-- 
2.0.0
