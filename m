Return-Path: <aik@ozlabs.ru>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 50F6C1A027F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2015 01:40:53 +1000 (AEST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Tue, 12 May 2015 01:40:52 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 51EB3357804F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2015 01:40:49 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4BFefgb38600834
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2015 01:40:49 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4BFeGLN026193
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2015 01:40:17 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel v10 14/34] powerpc/iommu: Move tce_xxx callbacks from
 ppc_md to iommu_table
Date: Tue, 12 May 2015 01:39:03 +1000
Message-Id: <1431358763-24371-15-git-send-email-aik@ozlabs.ru>
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

This adds a iommu_table_ops struct and puts pointer to it into
the iommu_table struct. This moves tce_build/tce_free/tce_get/tce_flush
callbacks from ppc_md to the new struct where they really belong to.

This adds the requirement for @it_ops to be initialized before calling
iommu_init_table() to make sure that we do not leave any IOMMU table
with iommu_table_ops uninitialized. This is not a parameter of
iommu_init_table() though as there will be cases when iommu_init_table()
will not be called on TCE tables, for example - VFIO.

This does s/tce_build/set/, s/tce_free/clear/ and removes "tce_"
redundand prefixes.

This removes tce_xxx_rm handlers from ppc_md but does not add
them to iommu_table_ops as this will be done later if we decide to
support TCE hypercalls in real mode. This removes _vm callbacks as
only virtual mode is supported by now so this also removes @rm parameter.

For pSeries, this always uses tce_buildmulti_pSeriesLP/
tce_buildmulti_pSeriesLP. This changes multi callback to fall back to
tce_build_pSeriesLP/tce_free_pSeriesLP if FW_FEATURE_MULTITCE is not
present. The reason for this is we still have to support "multitce=off"
boot parameter in disable_multitce() and we do not want to walk through
all IOMMU tables in the system and replace "multi" callbacks with single
ones.

For powernv, this defines _ops per PHB type which are P5IOC2/IODA1/IODA2.
This makes the callbacks for them public. Later patches will extend
callbacks for IODA1/2.

No change in behaviour is expected.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
---
Changes:
v9:
* pnv_tce_build/pnv_tce_free/pnv_tce_get have been made public and lost
"rm" parameters to make following patches simpler (realmode is not
supported here anyway)
* got rid of _vm versions of callbacks
---
 arch/powerpc/include/asm/iommu.h            | 17 +++++++++++
 arch/powerpc/include/asm/machdep.h          | 25 ---------------
 arch/powerpc/kernel/iommu.c                 | 46 ++++++++++++++--------------
 arch/powerpc/kernel/vio.c                   |  5 +++
 arch/powerpc/platforms/cell/iommu.c         |  8 +++--
 arch/powerpc/platforms/pasemi/iommu.c       |  7 +++--
 arch/powerpc/platforms/powernv/pci-ioda.c   | 14 +++++++++
 arch/powerpc/platforms/powernv/pci-p5ioc2.c |  7 +++++
 arch/powerpc/platforms/powernv/pci.c        | 47 +++++------------------------
 arch/powerpc/platforms/powernv/pci.h        |  5 +++
 arch/powerpc/platforms/pseries/iommu.c      | 34 ++++++++++++---------
 arch/powerpc/sysdev/dart_iommu.c            | 12 +++++---
 12 files changed, 116 insertions(+), 111 deletions(-)

diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/iommu.h
index d91bd69..e2a45c3 100644
--- a/arch/powerpc/include/asm/iommu.h
+++ b/arch/powerpc/include/asm/iommu.h
@@ -44,6 +44,22 @@
 extern int iommu_is_off;
 extern int iommu_force_on;
 
+struct iommu_table_ops {
+	int (*set)(struct iommu_table *tbl,
+			long index, long npages,
+			unsigned long uaddr,
+			enum dma_data_direction direction,
+			struct dma_attrs *attrs);
+	void (*clear)(struct iommu_table *tbl,
+			long index, long npages);
+	unsigned long (*get)(struct iommu_table *tbl, long index);
+	void (*flush)(struct iommu_table *tbl);
+};
+
+/* These are used by VIO */
+extern struct iommu_table_ops iommu_table_lpar_multi_ops;
+extern struct iommu_table_ops iommu_table_pseries_ops;
+
 /*
  * IOMAP_MAX_ORDER defines the largest contiguous block
  * of dma space we can get.  IOMAP_MAX_ORDER = 13
@@ -78,6 +94,7 @@ struct iommu_table {
 #ifdef CONFIG_IOMMU_API
 	struct iommu_group *it_group;
 #endif
+	struct iommu_table_ops *it_ops;
 	void (*set_bypass)(struct iommu_table *tbl, bool enable);
 #ifdef CONFIG_PPC_POWERNV
 	void           *data;
diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index ef889943..ab721b4 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -65,31 +65,6 @@ struct machdep_calls {
 	 * destroyed as well */
 	void		(*hpte_clear_all)(void);
 
-	int		(*tce_build)(struct iommu_table *tbl,
-				     long index,
-				     long npages,
-				     unsigned long uaddr,
-				     enum dma_data_direction direction,
-				     struct dma_attrs *attrs);
-	void		(*tce_free)(struct iommu_table *tbl,
-				    long index,
-				    long npages);
-	unsigned long	(*tce_get)(struct iommu_table *tbl,
-				    long index);
-	void		(*tce_flush)(struct iommu_table *tbl);
-
-	/* _rm versions are for real mode use only */
-	int		(*tce_build_rm)(struct iommu_table *tbl,
-				     long index,
-				     long npages,
-				     unsigned long uaddr,
-				     enum dma_data_direction direction,
-				     struct dma_attrs *attrs);
-	void		(*tce_free_rm)(struct iommu_table *tbl,
-				    long index,
-				    long npages);
-	void		(*tce_flush_rm)(struct iommu_table *tbl);
-
 	void __iomem *	(*ioremap)(phys_addr_t addr, unsigned long size,
 				   unsigned long flags, void *caller);
 	void		(*iounmap)(volatile void __iomem *token);
diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index 31319f8..16be6aa 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -322,11 +322,11 @@ static dma_addr_t iommu_alloc(struct device *dev, struct iommu_table *tbl,
 	ret = entry << tbl->it_page_shift;	/* Set the return dma address */
 
 	/* Put the TCEs in the HW table */
-	build_fail = ppc_md.tce_build(tbl, entry, npages,
+	build_fail = tbl->it_ops->set(tbl, entry, npages,
 				      (unsigned long)page &
 				      IOMMU_PAGE_MASK(tbl), direction, attrs);
 
-	/* ppc_md.tce_build() only returns non-zero for transient errors.
+	/* tbl->it_ops->set() only returns non-zero for transient errors.
 	 * Clean up the table bitmap in this case and return
 	 * DMA_ERROR_CODE. For all other errors the functionality is
 	 * not altered.
@@ -337,8 +337,8 @@ static dma_addr_t iommu_alloc(struct device *dev, struct iommu_table *tbl,
 	}
 
 	/* Flush/invalidate TLB caches if necessary */
-	if (ppc_md.tce_flush)
-		ppc_md.tce_flush(tbl);
+	if (tbl->it_ops->flush)
+		tbl->it_ops->flush(tbl);
 
 	/* Make sure updates are seen by hardware */
 	mb();
@@ -408,7 +408,7 @@ static void __iommu_free(struct iommu_table *tbl, dma_addr_t dma_addr,
 	if (!iommu_free_check(tbl, dma_addr, npages))
 		return;
 
-	ppc_md.tce_free(tbl, entry, npages);
+	tbl->it_ops->clear(tbl, entry, npages);
 
 	spin_lock_irqsave(&(pool->lock), flags);
 	bitmap_clear(tbl->it_map, free_entry, npages);
@@ -424,8 +424,8 @@ static void iommu_free(struct iommu_table *tbl, dma_addr_t dma_addr,
 	 * not do an mb() here on purpose, it is not needed on any of
 	 * the current platforms.
 	 */
-	if (ppc_md.tce_flush)
-		ppc_md.tce_flush(tbl);
+	if (tbl->it_ops->flush)
+		tbl->it_ops->flush(tbl);
 }
 
 int ppc_iommu_map_sg(struct device *dev, struct iommu_table *tbl,
@@ -495,7 +495,7 @@ int ppc_iommu_map_sg(struct device *dev, struct iommu_table *tbl,
 			    npages, entry, dma_addr);
 
 		/* Insert into HW table */
-		build_fail = ppc_md.tce_build(tbl, entry, npages,
+		build_fail = tbl->it_ops->set(tbl, entry, npages,
 					      vaddr & IOMMU_PAGE_MASK(tbl),
 					      direction, attrs);
 		if(unlikely(build_fail))
@@ -534,8 +534,8 @@ int ppc_iommu_map_sg(struct device *dev, struct iommu_table *tbl,
 	}
 
 	/* Flush/invalidate TLB caches if necessary */
-	if (ppc_md.tce_flush)
-		ppc_md.tce_flush(tbl);
+	if (tbl->it_ops->flush)
+		tbl->it_ops->flush(tbl);
 
 	DBG("mapped %d elements:\n", outcount);
 
@@ -600,8 +600,8 @@ void ppc_iommu_unmap_sg(struct iommu_table *tbl, struct scatterlist *sglist,
 	 * do not do an mb() here, the affected platforms do not need it
 	 * when freeing.
 	 */
-	if (ppc_md.tce_flush)
-		ppc_md.tce_flush(tbl);
+	if (tbl->it_ops->flush)
+		tbl->it_ops->flush(tbl);
 }
 
 static void iommu_table_clear(struct iommu_table *tbl)
@@ -613,17 +613,17 @@ static void iommu_table_clear(struct iommu_table *tbl)
 	 */
 	if (!is_kdump_kernel() || is_fadump_active()) {
 		/* Clear the table in case firmware left allocations in it */
-		ppc_md.tce_free(tbl, tbl->it_offset, tbl->it_size);
+		tbl->it_ops->clear(tbl, tbl->it_offset, tbl->it_size);
 		return;
 	}
 
 #ifdef CONFIG_CRASH_DUMP
-	if (ppc_md.tce_get) {
+	if (tbl->it_ops->get) {
 		unsigned long index, tceval, tcecount = 0;
 
 		/* Reserve the existing mappings left by the first kernel. */
 		for (index = 0; index < tbl->it_size; index++) {
-			tceval = ppc_md.tce_get(tbl, index + tbl->it_offset);
+			tceval = tbl->it_ops->get(tbl, index + tbl->it_offset);
 			/*
 			 * Freed TCE entry contains 0x7fffffffffffffff on JS20
 			 */
@@ -657,6 +657,8 @@ struct iommu_table *iommu_init_table(struct iommu_table *tbl, int nid)
 	unsigned int i;
 	struct iommu_pool *p;
 
+	BUG_ON(!tbl->it_ops);
+
 	/* number of bytes needed for the bitmap */
 	sz = BITS_TO_LONGS(tbl->it_size) * sizeof(unsigned long);
 
@@ -926,8 +928,8 @@ EXPORT_SYMBOL_GPL(iommu_tce_direction);
 void iommu_flush_tce(struct iommu_table *tbl)
 {
 	/* Flush/invalidate TLB caches if necessary */
-	if (ppc_md.tce_flush)
-		ppc_md.tce_flush(tbl);
+	if (tbl->it_ops->flush)
+		tbl->it_ops->flush(tbl);
 
 	/* Make sure updates are seen by hardware */
 	mb();
@@ -938,7 +940,7 @@ int iommu_tce_clear_param_check(struct iommu_table *tbl,
 		unsigned long ioba, unsigned long tce_value,
 		unsigned long npages)
 {
-	/* ppc_md.tce_free() does not support any value but 0 */
+	/* tbl->it_ops->clear() does not support any value but 0 */
 	if (tce_value)
 		return -EINVAL;
 
@@ -986,9 +988,9 @@ unsigned long iommu_clear_tce(struct iommu_table *tbl, unsigned long entry)
 
 	spin_lock(&(pool->lock));
 
-	oldtce = ppc_md.tce_get(tbl, entry);
+	oldtce = tbl->it_ops->get(tbl, entry);
 	if (oldtce & (TCE_PCI_WRITE | TCE_PCI_READ))
-		ppc_md.tce_free(tbl, entry, 1);
+		tbl->it_ops->clear(tbl, entry, 1);
 	else
 		oldtce = 0;
 
@@ -1011,10 +1013,10 @@ int iommu_tce_build(struct iommu_table *tbl, unsigned long entry,
 
 	spin_lock(&(pool->lock));
 
-	oldtce = ppc_md.tce_get(tbl, entry);
+	oldtce = tbl->it_ops->get(tbl, entry);
 	/* Add new entry if it is not busy */
 	if (!(oldtce & (TCE_PCI_WRITE | TCE_PCI_READ)))
-		ret = ppc_md.tce_build(tbl, entry, 1, hwaddr, direction, NULL);
+		ret = tbl->it_ops->set(tbl, entry, 1, hwaddr, direction, NULL);
 
 	spin_unlock(&(pool->lock));
 
diff --git a/arch/powerpc/kernel/vio.c b/arch/powerpc/kernel/vio.c
index 5bfdab9..b41426c 100644
--- a/arch/powerpc/kernel/vio.c
+++ b/arch/powerpc/kernel/vio.c
@@ -1196,6 +1196,11 @@ static struct iommu_table *vio_build_iommu_table(struct vio_dev *dev)
 	tbl->it_type = TCE_VB;
 	tbl->it_blocksize = 16;
 
+	if (firmware_has_feature(FW_FEATURE_LPAR))
+		tbl->it_ops = &iommu_table_lpar_multi_ops;
+	else
+		tbl->it_ops = &iommu_table_pseries_ops;
+
 	return iommu_init_table(tbl, -1);
 }
 
diff --git a/arch/powerpc/platforms/cell/iommu.c b/arch/powerpc/platforms/cell/iommu.c
index 21b5023..14a582b 100644
--- a/arch/powerpc/platforms/cell/iommu.c
+++ b/arch/powerpc/platforms/cell/iommu.c
@@ -466,6 +466,11 @@ static inline u32 cell_iommu_get_ioid(struct device_node *np)
 	return *ioid;
 }
 
+static struct iommu_table_ops cell_iommu_ops = {
+	.set = tce_build_cell,
+	.clear = tce_free_cell
+};
+
 static struct iommu_window * __init
 cell_iommu_setup_window(struct cbe_iommu *iommu, struct device_node *np,
 			unsigned long offset, unsigned long size,
@@ -492,6 +497,7 @@ cell_iommu_setup_window(struct cbe_iommu *iommu, struct device_node *np,
 	window->table.it_offset =
 		(offset >> window->table.it_page_shift) + pte_offset;
 	window->table.it_size = size >> window->table.it_page_shift;
+	window->table.it_ops = &cell_iommu_ops;
 
 	iommu_init_table(&window->table, iommu->nid);
 
@@ -1201,8 +1207,6 @@ static int __init cell_iommu_init(void)
 	/* Setup various callbacks */
 	cell_pci_controller_ops.dma_dev_setup = cell_pci_dma_dev_setup;
 	ppc_md.dma_get_required_mask = cell_dma_get_required_mask;
-	ppc_md.tce_build = tce_build_cell;
-	ppc_md.tce_free = tce_free_cell;
 
 	if (!iommu_fixed_disabled && cell_iommu_fixed_mapping_init() == 0)
 		goto bail;
diff --git a/arch/powerpc/platforms/pasemi/iommu.c b/arch/powerpc/platforms/pasemi/iommu.c
index b8f567b..c929644 100644
--- a/arch/powerpc/platforms/pasemi/iommu.c
+++ b/arch/powerpc/platforms/pasemi/iommu.c
@@ -134,6 +134,10 @@ static void iobmap_free(struct iommu_table *tbl, long index,
 	}
 }
 
+static struct iommu_table_ops iommu_table_iobmap_ops = {
+	.set = iobmap_build,
+	.clear  = iobmap_free
+};
 
 static void iommu_table_iobmap_setup(void)
 {
@@ -153,6 +157,7 @@ static void iommu_table_iobmap_setup(void)
 	 * Should probably be 8 (64 bytes)
 	 */
 	iommu_table_iobmap.it_blocksize = 4;
+	iommu_table_iobmap.it_ops = &iommu_table_iobmap_ops;
 	iommu_init_table(&iommu_table_iobmap, 0);
 	pr_debug(" <- %s\n", __func__);
 }
@@ -252,8 +257,6 @@ void __init iommu_init_early_pasemi(void)
 
 	pasemi_pci_controller_ops.dma_dev_setup = pci_dma_dev_setup_pasemi;
 	pasemi_pci_controller_ops.dma_bus_setup = pci_dma_bus_setup_pasemi;
-	ppc_md.tce_build = iobmap_build;
-	ppc_md.tce_free  = iobmap_free;
 	set_pci_dma_ops(&dma_iommu_ops);
 }
 
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 8c3c4bf..2924abe 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1725,6 +1725,12 @@ static void pnv_pci_ioda1_tce_invalidate(struct pnv_ioda_pe *pe,
 	 */
 }
 
+static struct iommu_table_ops pnv_ioda1_iommu_ops = {
+	.set = pnv_tce_build,
+	.clear = pnv_tce_free,
+	.get = pnv_tce_get,
+};
+
 static void pnv_pci_ioda2_tce_invalidate(struct pnv_ioda_pe *pe,
 					 struct iommu_table *tbl,
 					 __be64 *startp, __be64 *endp, bool rm)
@@ -1769,6 +1775,12 @@ void pnv_pci_ioda_tce_invalidate(struct iommu_table *tbl,
 		pnv_pci_ioda2_tce_invalidate(pe, tbl, startp, endp, rm);
 }
 
+static struct iommu_table_ops pnv_ioda2_iommu_ops = {
+	.set = pnv_tce_build,
+	.clear = pnv_tce_free,
+	.get = pnv_tce_get,
+};
+
 static void pnv_pci_ioda_setup_dma_pe(struct pnv_phb *phb,
 				      struct pnv_ioda_pe *pe, unsigned int base,
 				      unsigned int segs)
@@ -1844,6 +1856,7 @@ static void pnv_pci_ioda_setup_dma_pe(struct pnv_phb *phb,
 				 TCE_PCI_SWINV_FREE   |
 				 TCE_PCI_SWINV_PAIR);
 	}
+	tbl->it_ops = &pnv_ioda1_iommu_ops;
 	iommu_init_table(tbl, phb->hose->node);
 
 	if (pe->flags & PNV_IODA_PE_DEV) {
@@ -1972,6 +1985,7 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
 				8);
 		tbl->it_type |= (TCE_PCI_SWINV_CREATE | TCE_PCI_SWINV_FREE);
 	}
+	tbl->it_ops = &pnv_ioda2_iommu_ops;
 	iommu_init_table(tbl, phb->hose->node);
 
 	if (pe->flags & PNV_IODA_PE_DEV) {
diff --git a/arch/powerpc/platforms/powernv/pci-p5ioc2.c b/arch/powerpc/platforms/powernv/pci-p5ioc2.c
index b17d93615..2722c1a 100644
--- a/arch/powerpc/platforms/powernv/pci-p5ioc2.c
+++ b/arch/powerpc/platforms/powernv/pci-p5ioc2.c
@@ -83,10 +83,17 @@ static void pnv_pci_init_p5ioc2_msis(struct pnv_phb *phb)
 static void pnv_pci_init_p5ioc2_msis(struct pnv_phb *phb) { }
 #endif /* CONFIG_PCI_MSI */
 
+static struct iommu_table_ops pnv_p5ioc2_iommu_ops = {
+	.set = pnv_tce_build,
+	.clear = pnv_tce_free,
+	.get = pnv_tce_get,
+};
+
 static void pnv_pci_p5ioc2_dma_dev_setup(struct pnv_phb *phb,
 					 struct pci_dev *pdev)
 {
 	if (phb->p5ioc2.iommu_table.it_map == NULL) {
+		phb->p5ioc2.iommu_table.it_ops = &pnv_p5ioc2_iommu_ops;
 		iommu_init_table(&phb->p5ioc2.iommu_table, phb->hose->node);
 		iommu_register_group(&phb->p5ioc2.iommu_table,
 				pci_domain_nr(phb->hose->bus), phb->opal_id);
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index b7ea245..4c3bbb1 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -572,9 +572,9 @@ struct pci_ops pnv_pci_ops = {
 	.write = pnv_pci_write_config,
 };
 
-static int pnv_tce_build(struct iommu_table *tbl, long index, long npages,
-			 unsigned long uaddr, enum dma_data_direction direction,
-			 struct dma_attrs *attrs, bool rm)
+int pnv_tce_build(struct iommu_table *tbl, long index, long npages,
+		unsigned long uaddr, enum dma_data_direction direction,
+		struct dma_attrs *attrs)
 {
 	u64 proto_tce = iommu_direction_to_tce_perm(direction);
 	__be64 *tcep, *tces;
@@ -592,22 +592,12 @@ static int pnv_tce_build(struct iommu_table *tbl, long index, long npages,
 	 * of flags if that becomes the case
 	 */
 	if (tbl->it_type & TCE_PCI_SWINV_CREATE)
-		pnv_pci_ioda_tce_invalidate(tbl, tces, tcep - 1, rm);
+		pnv_pci_ioda_tce_invalidate(tbl, tces, tcep - 1, false);
 
 	return 0;
 }
 
-static int pnv_tce_build_vm(struct iommu_table *tbl, long index, long npages,
-			    unsigned long uaddr,
-			    enum dma_data_direction direction,
-			    struct dma_attrs *attrs)
-{
-	return pnv_tce_build(tbl, index, npages, uaddr, direction, attrs,
-			false);
-}
-
-static void pnv_tce_free(struct iommu_table *tbl, long index, long npages,
-		bool rm)
+void pnv_tce_free(struct iommu_table *tbl, long index, long npages)
 {
 	__be64 *tcep, *tces;
 
@@ -617,32 +607,14 @@ static void pnv_tce_free(struct iommu_table *tbl, long index, long npages,
 		*(tcep++) = cpu_to_be64(0);
 
 	if (tbl->it_type & TCE_PCI_SWINV_FREE)
-		pnv_pci_ioda_tce_invalidate(tbl, tces, tcep - 1, rm);
+		pnv_pci_ioda_tce_invalidate(tbl, tces, tcep - 1, false);
 }
 
-static void pnv_tce_free_vm(struct iommu_table *tbl, long index, long npages)
-{
-	pnv_tce_free(tbl, index, npages, false);
-}
-
-static unsigned long pnv_tce_get(struct iommu_table *tbl, long index)
+unsigned long pnv_tce_get(struct iommu_table *tbl, long index)
 {
 	return ((u64 *)tbl->it_base)[index - tbl->it_offset];
 }
 
-static int pnv_tce_build_rm(struct iommu_table *tbl, long index, long npages,
-			    unsigned long uaddr,
-			    enum dma_data_direction direction,
-			    struct dma_attrs *attrs)
-{
-	return pnv_tce_build(tbl, index, npages, uaddr, direction, attrs, true);
-}
-
-static void pnv_tce_free_rm(struct iommu_table *tbl, long index, long npages)
-{
-	pnv_tce_free(tbl, index, npages, true);
-}
-
 void pnv_pci_setup_iommu_table(struct iommu_table *tbl,
 			       void *tce_mem, u64 tce_size,
 			       u64 dma_offset, unsigned page_shift)
@@ -757,11 +729,6 @@ void __init pnv_pci_init(void)
 	pci_devs_phb_init();
 
 	/* Configure IOMMU DMA hooks */
-	ppc_md.tce_build = pnv_tce_build_vm;
-	ppc_md.tce_free = pnv_tce_free_vm;
-	ppc_md.tce_build_rm = pnv_tce_build_rm;
-	ppc_md.tce_free_rm = pnv_tce_free_rm;
-	ppc_md.tce_get = pnv_tce_get;
 	set_pci_dma_ops(&dma_iommu_ops);
 
 	/* Configure MSIs */
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index 070ee88..ec26afd 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -200,6 +200,11 @@ struct pnv_phb {
 };
 
 extern struct pci_ops pnv_pci_ops;
+extern int pnv_tce_build(struct iommu_table *tbl, long index, long npages,
+		unsigned long uaddr, enum dma_data_direction direction,
+		struct dma_attrs *attrs);
+extern void pnv_tce_free(struct iommu_table *tbl, long index, long npages);
+extern unsigned long pnv_tce_get(struct iommu_table *tbl, long index);
 
 void pnv_pci_dump_phb_diag_data(struct pci_controller *hose,
 				unsigned char *log_buff);
diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 89f557b..4f2ab90 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -204,7 +204,7 @@ static int tce_buildmulti_pSeriesLP(struct iommu_table *tbl, long tcenum,
 	int ret = 0;
 	unsigned long flags;
 
-	if (npages == 1) {
+	if ((npages == 1) || !firmware_has_feature(FW_FEATURE_MULTITCE)) {
 		return tce_build_pSeriesLP(tbl, tcenum, npages, uaddr,
 		                           direction, attrs);
 	}
@@ -296,6 +296,9 @@ static void tce_freemulti_pSeriesLP(struct iommu_table *tbl, long tcenum, long n
 {
 	u64 rc;
 
+	if (!firmware_has_feature(FW_FEATURE_MULTITCE))
+		return tce_free_pSeriesLP(tbl, tcenum, npages);
+
 	rc = plpar_tce_stuff((u64)tbl->it_index, (u64)tcenum << 12, 0, npages);
 
 	if (rc && printk_ratelimit()) {
@@ -471,7 +474,6 @@ static int tce_setrange_multi_pSeriesLP_walk(unsigned long start_pfn,
 	return tce_setrange_multi_pSeriesLP(start_pfn, num_pfn, arg);
 }
 
-
 #ifdef CONFIG_PCI
 static void iommu_table_setparms(struct pci_controller *phb,
 				 struct device_node *dn,
@@ -557,6 +559,12 @@ static void iommu_table_setparms_lpar(struct pci_controller *phb,
 	tbl->it_size = size >> tbl->it_page_shift;
 }
 
+struct iommu_table_ops iommu_table_pseries_ops = {
+	.set = tce_build_pSeries,
+	.clear = tce_free_pSeries,
+	.get = tce_get_pseries
+};
+
 static void pci_dma_bus_setup_pSeries(struct pci_bus *bus)
 {
 	struct device_node *dn;
@@ -625,6 +633,7 @@ static void pci_dma_bus_setup_pSeries(struct pci_bus *bus)
 			   pci->phb->node);
 
 	iommu_table_setparms(pci->phb, dn, tbl);
+	tbl->it_ops = &iommu_table_pseries_ops;
 	pci->iommu_table = iommu_init_table(tbl, pci->phb->node);
 	iommu_register_group(tbl, pci_domain_nr(bus), 0);
 
@@ -636,6 +645,11 @@ static void pci_dma_bus_setup_pSeries(struct pci_bus *bus)
 	pr_debug("ISA/IDE, window size is 0x%llx\n", pci->phb->dma_window_size);
 }
 
+struct iommu_table_ops iommu_table_lpar_multi_ops = {
+	.set = tce_buildmulti_pSeriesLP,
+	.clear = tce_freemulti_pSeriesLP,
+	.get = tce_get_pSeriesLP
+};
 
 static void pci_dma_bus_setup_pSeriesLP(struct pci_bus *bus)
 {
@@ -670,6 +684,7 @@ static void pci_dma_bus_setup_pSeriesLP(struct pci_bus *bus)
 		tbl = kzalloc_node(sizeof(struct iommu_table), GFP_KERNEL,
 				   ppci->phb->node);
 		iommu_table_setparms_lpar(ppci->phb, pdn, tbl, dma_window);
+		tbl->it_ops = &iommu_table_lpar_multi_ops;
 		ppci->iommu_table = iommu_init_table(tbl, ppci->phb->node);
 		iommu_register_group(tbl, pci_domain_nr(bus), 0);
 		pr_debug("  created table: %p\n", ppci->iommu_table);
@@ -697,6 +712,7 @@ static void pci_dma_dev_setup_pSeries(struct pci_dev *dev)
 		tbl = kzalloc_node(sizeof(struct iommu_table), GFP_KERNEL,
 				   phb->node);
 		iommu_table_setparms(phb, dn, tbl);
+		tbl->it_ops = &iommu_table_pseries_ops;
 		PCI_DN(dn)->iommu_table = iommu_init_table(tbl, phb->node);
 		iommu_register_group(tbl, pci_domain_nr(phb->bus), 0);
 		set_iommu_table_base(&dev->dev, tbl);
@@ -1119,6 +1135,7 @@ static void pci_dma_dev_setup_pSeriesLP(struct pci_dev *dev)
 		tbl = kzalloc_node(sizeof(struct iommu_table), GFP_KERNEL,
 				   pci->phb->node);
 		iommu_table_setparms_lpar(pci->phb, pdn, tbl, dma_window);
+		tbl->it_ops = &iommu_table_lpar_multi_ops;
 		pci->iommu_table = iommu_init_table(tbl, pci->phb->node);
 		iommu_register_group(tbl, pci_domain_nr(pci->phb->bus), 0);
 		pr_debug("  created table: %p\n", pci->iommu_table);
@@ -1313,22 +1330,11 @@ void iommu_init_early_pSeries(void)
 		return;
 
 	if (firmware_has_feature(FW_FEATURE_LPAR)) {
-		if (firmware_has_feature(FW_FEATURE_MULTITCE)) {
-			ppc_md.tce_build = tce_buildmulti_pSeriesLP;
-			ppc_md.tce_free	 = tce_freemulti_pSeriesLP;
-		} else {
-			ppc_md.tce_build = tce_build_pSeriesLP;
-			ppc_md.tce_free	 = tce_free_pSeriesLP;
-		}
-		ppc_md.tce_get   = tce_get_pSeriesLP;
 		pseries_pci_controller_ops.dma_bus_setup = pci_dma_bus_setup_pSeriesLP;
 		pseries_pci_controller_ops.dma_dev_setup = pci_dma_dev_setup_pSeriesLP;
 		ppc_md.dma_set_mask = dma_set_mask_pSeriesLP;
 		ppc_md.dma_get_required_mask = dma_get_required_mask_pSeriesLP;
 	} else {
-		ppc_md.tce_build = tce_build_pSeries;
-		ppc_md.tce_free  = tce_free_pSeries;
-		ppc_md.tce_get   = tce_get_pseries;
 		pseries_pci_controller_ops.dma_bus_setup = pci_dma_bus_setup_pSeries;
 		pseries_pci_controller_ops.dma_dev_setup = pci_dma_dev_setup_pSeries;
 	}
@@ -1346,8 +1352,6 @@ static int __init disable_multitce(char *str)
 	    firmware_has_feature(FW_FEATURE_LPAR) &&
 	    firmware_has_feature(FW_FEATURE_MULTITCE)) {
 		printk(KERN_INFO "Disabling MULTITCE firmware feature\n");
-		ppc_md.tce_build = tce_build_pSeriesLP;
-		ppc_md.tce_free	 = tce_free_pSeriesLP;
 		powerpc_firmware_features &= ~FW_FEATURE_MULTITCE;
 	}
 	return 1;
diff --git a/arch/powerpc/sysdev/dart_iommu.c b/arch/powerpc/sysdev/dart_iommu.c
index d00a566..90bcdfe 100644
--- a/arch/powerpc/sysdev/dart_iommu.c
+++ b/arch/powerpc/sysdev/dart_iommu.c
@@ -286,6 +286,12 @@ static int __init dart_init(struct device_node *dart_node)
 	return 0;
 }
 
+static struct iommu_table_ops iommu_dart_ops = {
+	.set = dart_build,
+	.clear = dart_free,
+	.flush = dart_flush,
+};
+
 static void iommu_table_dart_setup(void)
 {
 	iommu_table_dart.it_busno = 0;
@@ -298,6 +304,7 @@ static void iommu_table_dart_setup(void)
 	iommu_table_dart.it_base = (unsigned long)dart_vbase;
 	iommu_table_dart.it_index = 0;
 	iommu_table_dart.it_blocksize = 1;
+	iommu_table_dart.it_ops = &iommu_dart_ops;
 	iommu_init_table(&iommu_table_dart, -1);
 
 	/* Reserve the last page of the DART to avoid possible prefetch
@@ -386,11 +393,6 @@ void __init iommu_init_early_dart(struct pci_controller_ops *controller_ops)
 	if (dart_init(dn) != 0)
 		goto bail;
 
-	/* Setup low level TCE operations for the core IOMMU code */
-	ppc_md.tce_build = dart_build;
-	ppc_md.tce_free  = dart_free;
-	ppc_md.tce_flush = dart_flush;
-
 	/* Setup bypass if supported */
 	if (dart_is_u4)
 		ppc_md.dma_set_mask = dart_dma_set_mask;
-- 
2.4.0.rc3.8.gfb3e7d5
