Return-Path: <aik@ozlabs.ru>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7D1791A09AB
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 16:32:44 +1000 (AEST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Fri, 10 Apr 2015 16:32:44 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id CD080357804F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 16:32:41 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3A6WXVu13566040
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 16:32:41 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3A6W8MZ027866
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 16:32:08 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel v8 17/31] powerpc/iommu/powernv: Release replaced TCE
Date: Fri, 10 Apr 2015 16:30:59 +1000
Message-Id: <1428647473-11738-18-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1428647473-11738-1-git-send-email-aik@ozlabs.ru>
References: <1428647473-11738-1-git-send-email-aik@ozlabs.ru>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

At the moment writing new TCE value to the IOMMU table fails with EBUSY
if there is a valid entry already. However PAPR specification allows
the guest to write new TCE value without clearing it first.

Another problem this patch is addressing is the use of pool locks for
external IOMMU users such as VFIO. The pool locks are to protect
DMA page allocator rather than entries and since the host kernel does
not control what pages are in use, there is no point in pool locks and
exchange()+put_page(oldtce) is sufficient to avoid possible races.

This adds an exchange() callback to iommu_table_ops which does the same
thing as set() plus it returns replaced TCE and DMA direction so
the caller can release the pages afterwards.

The returned old TCE value is a virtual address as the new TCE value.
This is different from tce_clear() which returns a physical address.

This implements exchange() for P5IOC2/IODA/IODA2. This adds a requirement
for a platform to have exchange() implemented in order to support VFIO.

This replaces iommu_tce_build() and iommu_clear_tce() with
a single iommu_tce_xchg().

This makes sure that TCE permission bits are not set in TCE passed to
IOMMU API as those are to be calculated by platform code from DMA direction.

This moves SetPageDirty() to the IOMMU code to make it work for both
VFIO ioctl interface in in-kernel TCE acceleration (when it becomes
available later).

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/include/asm/iommu.h            | 17 ++++++--
 arch/powerpc/kernel/iommu.c                 | 53 +++++++++---------------
 arch/powerpc/platforms/powernv/pci-ioda.c   | 38 ++++++++++++++++++
 arch/powerpc/platforms/powernv/pci-p5ioc2.c |  3 ++
 arch/powerpc/platforms/powernv/pci.c        | 17 ++++++++
 arch/powerpc/platforms/powernv/pci.h        |  2 +
 drivers/vfio/vfio_iommu_spapr_tce.c         | 62 ++++++++++++++++++-----------
 7 files changed, 130 insertions(+), 62 deletions(-)

diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/iommu.h
index d1f8c6c..bde7ee7 100644
--- a/arch/powerpc/include/asm/iommu.h
+++ b/arch/powerpc/include/asm/iommu.h
@@ -44,11 +44,22 @@ extern int iommu_is_off;
 extern int iommu_force_on;
 
 struct iommu_table_ops {
+	/* When called with direction==DMA_NONE, it is equal to clear() */
 	int (*set)(struct iommu_table *tbl,
 			long index, long npages,
 			unsigned long uaddr,
 			enum dma_data_direction direction,
 			struct dma_attrs *attrs);
+#ifdef CONFIG_IOMMU_API
+	/*
+	 * Exchanges existing TCE with new TCE plus direction bits;
+	 * returns old TCE and DMA direction mask
+	 */
+	int (*exchange)(struct iommu_table *tbl,
+			long index,
+			unsigned long *tce,
+			enum dma_data_direction *direction);
+#endif
 	void (*clear)(struct iommu_table *tbl,
 			long index, long npages);
 	unsigned long (*get)(struct iommu_table *tbl, long index);
@@ -152,6 +163,8 @@ extern void iommu_register_group(struct iommu_table_group *table_group,
 extern int iommu_add_device(struct device *dev);
 extern void iommu_del_device(struct device *dev);
 extern int __init tce_iommu_bus_notifier_init(void);
+extern long iommu_tce_xchg(struct iommu_table *tbl, unsigned long entry,
+		unsigned long *tce, enum dma_data_direction *direction);
 #else
 static inline void iommu_register_group(struct iommu_table_group *table_group,
 					int pci_domain_number,
@@ -231,10 +244,6 @@ extern int iommu_tce_clear_param_check(struct iommu_table *tbl,
 		unsigned long npages);
 extern int iommu_tce_put_param_check(struct iommu_table *tbl,
 		unsigned long ioba, unsigned long tce);
-extern int iommu_tce_build(struct iommu_table *tbl, unsigned long entry,
-		unsigned long hwaddr, enum dma_data_direction direction);
-extern unsigned long iommu_clear_tce(struct iommu_table *tbl,
-		unsigned long entry);
 
 extern void iommu_flush_tce(struct iommu_table *tbl);
 extern int iommu_take_ownership(struct iommu_table_group *table_group);
diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index 068fe4ff..501e8ee 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -982,9 +982,6 @@ EXPORT_SYMBOL_GPL(iommu_tce_clear_param_check);
 int iommu_tce_put_param_check(struct iommu_table *tbl,
 		unsigned long ioba, unsigned long tce)
 {
-	if (!(tce & (TCE_PCI_WRITE | TCE_PCI_READ)))
-		return -EINVAL;
-
 	if (tce & ~(IOMMU_PAGE_MASK(tbl) | TCE_PCI_WRITE | TCE_PCI_READ))
 		return -EINVAL;
 
@@ -1002,44 +999,20 @@ int iommu_tce_put_param_check(struct iommu_table *tbl,
 }
 EXPORT_SYMBOL_GPL(iommu_tce_put_param_check);
 
-unsigned long iommu_clear_tce(struct iommu_table *tbl, unsigned long entry)
-{
-	unsigned long oldtce;
-	struct iommu_pool *pool = get_pool(tbl, entry);
-
-	spin_lock(&(pool->lock));
-
-	oldtce = tbl->it_ops->get(tbl, entry);
-	if (oldtce & (TCE_PCI_WRITE | TCE_PCI_READ))
-		tbl->it_ops->clear(tbl, entry, 1);
-	else
-		oldtce = 0;
-
-	spin_unlock(&(pool->lock));
-
-	return oldtce;
-}
-EXPORT_SYMBOL_GPL(iommu_clear_tce);
-
 /*
  * hwaddr is a kernel virtual address here (0xc... bazillion),
  * tce_build converts it to a physical address.
  */
-int iommu_tce_build(struct iommu_table *tbl, unsigned long entry,
-		unsigned long hwaddr, enum dma_data_direction direction)
+long iommu_tce_xchg(struct iommu_table *tbl, unsigned long entry,
+		unsigned long *tce, enum dma_data_direction *direction)
 {
-	int ret = -EBUSY;
-	unsigned long oldtce;
-	struct iommu_pool *pool = get_pool(tbl, entry);
+	long ret;
 
-	spin_lock(&(pool->lock));
+	ret = tbl->it_ops->exchange(tbl, entry, tce, direction);
 
-	oldtce = tbl->it_ops->get(tbl, entry);
-	/* Add new entry if it is not busy */
-	if (!(oldtce & (TCE_PCI_WRITE | TCE_PCI_READ)))
-		ret = tbl->it_ops->set(tbl, entry, 1, hwaddr, direction, NULL);
-
-	spin_unlock(&(pool->lock));
+	if (!ret && ((*direction == DMA_FROM_DEVICE) ||
+			(*direction == DMA_BIDIRECTIONAL)))
+		SetPageDirty(pfn_to_page(__pa(*tce) >> PAGE_SHIFT));
 
 	/* if (unlikely(ret))
 		pr_err("iommu_tce: %s failed on hwaddr=%lx ioba=%lx kva=%lx ret=%d\n",
@@ -1048,13 +1021,23 @@ int iommu_tce_build(struct iommu_table *tbl, unsigned long entry,
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(iommu_tce_build);
+EXPORT_SYMBOL_GPL(iommu_tce_xchg);
 
 static int iommu_table_take_ownership(struct iommu_table *tbl)
 {
 	unsigned long flags, i, sz = (tbl->it_size + 7) >> 3;
 	int ret = 0;
 
+	/*
+	 * VFIO does not control TCE entries allocation and the guest
+	 * can write new TCEs on top of existing ones so iommu_tce_build()
+	 * must be able to release old pages. This functionality
+	 * requires exchange() callback defined so if it is not
+	 * implemented, we disallow taking ownership over the table.
+	 */
+	if (!tbl->it_ops->exchange)
+		return -EINVAL;
+
 	spin_lock_irqsave(&tbl->large_pool.lock, flags);
 	for (i = 0; i < tbl->nr_pools; i++)
 		spin_lock(&tbl->pools[i].lock);
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index fd993bc..4d80502 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1128,6 +1128,20 @@ static int pnv_ioda1_tce_build_vm(struct iommu_table *tbl, long index,
 	return ret;
 }
 
+#ifdef CONFIG_IOMMU_API
+static int pnv_ioda1_tce_xchg_vm(struct iommu_table *tbl, long index,
+		unsigned long *tce, enum dma_data_direction *direction)
+{
+	long ret = pnv_tce_xchg(tbl, index, tce, direction);
+
+	if (!ret && (tbl->it_type &
+			(TCE_PCI_SWINV_CREATE | TCE_PCI_SWINV_FREE)))
+		pnv_pci_ioda1_tce_invalidate(tbl, index, 1, false);
+
+	return ret;
+}
+#endif
+
 static void pnv_ioda1_tce_free_vm(struct iommu_table *tbl, long index,
 		long npages)
 {
@@ -1139,6 +1153,9 @@ static void pnv_ioda1_tce_free_vm(struct iommu_table *tbl, long index,
 
 struct iommu_table_ops pnv_ioda1_iommu_ops = {
 	.set = pnv_ioda1_tce_build_vm,
+#ifdef CONFIG_IOMMU_API
+	.exchange = pnv_ioda1_tce_xchg_vm,
+#endif
 	.clear = pnv_ioda1_tce_free_vm,
 	.get = pnv_tce_get,
 };
@@ -1190,6 +1207,20 @@ static int pnv_ioda2_tce_build_vm(struct iommu_table *tbl, long index,
 	return ret;
 }
 
+#ifdef CONFIG_IOMMU_API
+static int pnv_ioda2_tce_xchg_vm(struct iommu_table *tbl, long index,
+		unsigned long *tce, enum dma_data_direction *direction)
+{
+	long ret = pnv_tce_xchg(tbl, index, tce, direction);
+
+	if (!ret && (tbl->it_type &
+			(TCE_PCI_SWINV_CREATE | TCE_PCI_SWINV_FREE)))
+		pnv_pci_ioda2_tce_invalidate(tbl, index, 1, false);
+
+	return ret;
+}
+#endif
+
 static void pnv_ioda2_tce_free_vm(struct iommu_table *tbl, long index,
 		long npages)
 {
@@ -1201,6 +1232,9 @@ static void pnv_ioda2_tce_free_vm(struct iommu_table *tbl, long index,
 
 static struct iommu_table_ops pnv_ioda2_iommu_ops = {
 	.set = pnv_ioda2_tce_build_vm,
+#ifdef CONFIG_IOMMU_API
+	.exchange = pnv_ioda2_tce_xchg_vm,
+#endif
 	.clear = pnv_ioda2_tce_free_vm,
 	.get = pnv_tce_get,
 };
@@ -1353,6 +1387,7 @@ static void pnv_pci_ioda2_setup_bypass_pe(struct pnv_phb *phb,
 	pnv_pci_ioda2_set_bypass(pe, true);
 }
 
+#ifdef CONFIG_IOMMU_API
 static void pnv_ioda2_set_ownership(struct iommu_table_group *table_group,
 				     bool enable)
 {
@@ -1369,6 +1404,7 @@ static void pnv_ioda2_set_ownership(struct iommu_table_group *table_group,
 static struct iommu_table_group_ops pnv_pci_ioda2_ops = {
 	.set_ownership = pnv_ioda2_set_ownership,
 };
+#endif
 
 static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
 				       struct pnv_ioda_pe *pe)
@@ -1437,7 +1473,9 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
 	}
 	tbl->it_ops = &pnv_ioda2_iommu_ops;
 	iommu_init_table(tbl, phb->hose->node);
+#ifdef CONFIG_IOMMU_API
 	pe->table_group.ops = &pnv_pci_ioda2_ops;
+#endif
 	iommu_register_group(&pe->table_group, phb->hose->global_number,
 			pe->pe_number);
 
diff --git a/arch/powerpc/platforms/powernv/pci-p5ioc2.c b/arch/powerpc/platforms/powernv/pci-p5ioc2.c
index 6906a9c..d2d9092 100644
--- a/arch/powerpc/platforms/powernv/pci-p5ioc2.c
+++ b/arch/powerpc/platforms/powernv/pci-p5ioc2.c
@@ -85,6 +85,9 @@ static void pnv_pci_init_p5ioc2_msis(struct pnv_phb *phb) { }
 
 static struct iommu_table_ops pnv_p5ioc2_iommu_ops = {
 	.set = pnv_tce_build,
+#ifdef CONFIG_IOMMU_API
+	.exchange = pnv_tce_xchg,
+#endif
 	.clear = pnv_tce_free,
 	.get = pnv_tce_get,
 };
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index a8c05de..a9797dd 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -615,6 +615,23 @@ int pnv_tce_build(struct iommu_table *tbl, long index, long npages,
 	return 0;
 }
 
+#ifdef CONFIG_IOMMU_API
+int pnv_tce_xchg(struct iommu_table *tbl, long index,
+		unsigned long *tce, enum dma_data_direction *direction)
+{
+	u64 proto_tce = iommu_direction_to_tce_perm(*direction);
+	unsigned long newtce =  __pa(*tce) | proto_tce;
+	unsigned long idx = index - tbl->it_offset;
+
+	*tce = xchg(pnv_tce(tbl, idx), cpu_to_be64(newtce));
+	*tce = (unsigned long) __va(be64_to_cpu(*tce));
+	*direction = iommu_tce_direction(*tce);
+	*tce &= ~(TCE_PCI_READ | TCE_PCI_WRITE);
+
+	return 0;
+}
+#endif
+
 void pnv_tce_free(struct iommu_table *tbl, long index, long npages)
 {
 	long i;
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index 0d4df32..4d1a78c 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -220,6 +220,8 @@ extern int pnv_tce_build(struct iommu_table *tbl, long index, long npages,
 		unsigned long uaddr, enum dma_data_direction direction,
 		struct dma_attrs *attrs);
 extern void pnv_tce_free(struct iommu_table *tbl, long index, long npages);
+extern int pnv_tce_xchg(struct iommu_table *tbl, long index,
+		unsigned long *tce, enum dma_data_direction *direction);
 extern unsigned long pnv_tce_get(struct iommu_table *tbl, long index);
 extern struct iommu_table_ops pnv_ioda1_iommu_ops;
 
diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
index d5d8c50..7c3c215 100644
--- a/drivers/vfio/vfio_iommu_spapr_tce.c
+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
@@ -251,9 +251,6 @@ static void tce_iommu_unuse_page(struct tce_container *container,
 {
 	struct page *page;
 
-	if (!(oldtce & (TCE_PCI_READ | TCE_PCI_WRITE)))
-		return;
-
 	/*
 	 * VFIO cannot map/unmap when a container is not enabled so
 	 * we would not need this check but KVM could map/unmap and if
@@ -264,10 +261,6 @@ static void tce_iommu_unuse_page(struct tce_container *container,
 		return;
 
 	page = pfn_to_page(__pa(oldtce) >> PAGE_SHIFT);
-
-	if (oldtce & TCE_PCI_WRITE)
-		SetPageDirty(page);
-
 	put_page(page);
 }
 
@@ -275,14 +268,21 @@ static int tce_iommu_clear(struct tce_container *container,
 		struct iommu_table *tbl,
 		unsigned long entry, unsigned long pages)
 {
-	unsigned long oldtce;
+	long ret;
+	enum dma_data_direction direction;
+	unsigned long tce;
 
 	for ( ; pages; --pages, ++entry) {
-		oldtce = iommu_clear_tce(tbl, entry);
-		if (!oldtce)
+		direction = DMA_NONE;
+		tce = (unsigned long) __va(0);
+		ret = iommu_tce_xchg(tbl, entry, &tce, &direction);
+		if (ret)
 			continue;
 
-		tce_iommu_unuse_page(container, (unsigned long) __va(oldtce));
+		if (direction == DMA_NONE)
+			continue;
+
+		tce_iommu_unuse_page(container, tce);
 	}
 
 	return 0;
@@ -304,12 +304,13 @@ static int tce_get_hva(unsigned long tce, unsigned long *hva)
 
 static long tce_iommu_build(struct tce_container *container,
 		struct iommu_table *tbl,
-		unsigned long entry, unsigned long tce, unsigned long pages)
+		unsigned long entry, unsigned long tce, unsigned long pages,
+		enum dma_data_direction direction)
 {
 	long i, ret = 0;
 	struct page *page;
 	unsigned long hva;
-	enum dma_data_direction direction = iommu_tce_direction(tce);
+	enum dma_data_direction dirtmp;
 
 	for (i = 0; i < pages; ++i) {
 		ret = tce_get_hva(tce, &hva);
@@ -324,15 +325,21 @@ static long tce_iommu_build(struct tce_container *container,
 
 		/* Preserve offset within IOMMU page */
 		hva |= tce & IOMMU_PAGE_MASK(tbl) & ~PAGE_MASK;
+		dirtmp = direction;
 
-		ret = iommu_tce_build(tbl, entry + i, hva, direction);
+		ret = iommu_tce_xchg(tbl, entry + i, &hva, &dirtmp);
 		if (ret) {
+			/* dirtmp cannot be DMA_NONE here */
 			tce_iommu_unuse_page(container, hva);
 			pr_err("iommu_tce: %s failed ioba=%lx, tce=%lx, ret=%ld\n",
 					__func__, entry << tbl->it_page_shift,
 					tce, ret);
 			break;
 		}
+
+		if (dirtmp != DMA_NONE)
+			tce_iommu_unuse_page(container, hva);
+
 		tce += IOMMU_PAGE_SIZE(tbl);
 	}
 
@@ -397,7 +404,7 @@ static long tce_iommu_ioctl(void *iommu_data,
 	case VFIO_IOMMU_MAP_DMA: {
 		struct vfio_iommu_type1_dma_map param;
 		struct iommu_table *tbl;
-		unsigned long tce;
+		enum dma_data_direction direction;
 
 		if (!container->enabled)
 			return -EPERM;
@@ -418,24 +425,33 @@ static long tce_iommu_ioctl(void *iommu_data,
 		if (!tbl)
 			return -ENXIO;
 
-		if ((param.size & ~IOMMU_PAGE_MASK(tbl)) ||
-				(param.vaddr & ~IOMMU_PAGE_MASK(tbl)))
+		if (param.size & ~IOMMU_PAGE_MASK(tbl))
+			return -EINVAL;
+
+		if (param.vaddr & (TCE_PCI_READ | TCE_PCI_WRITE))
 			return -EINVAL;
 
 		/* iova is checked by the IOMMU API */
-		tce = param.vaddr;
 		if (param.flags & VFIO_DMA_MAP_FLAG_READ)
-			tce |= TCE_PCI_READ;
-		if (param.flags & VFIO_DMA_MAP_FLAG_WRITE)
-			tce |= TCE_PCI_WRITE;
+			if (param.flags & VFIO_DMA_MAP_FLAG_WRITE)
+				direction = DMA_BIDIRECTIONAL;
+			else
+				direction = DMA_TO_DEVICE;
+		else
+			if (param.flags & VFIO_DMA_MAP_FLAG_WRITE)
+				direction = DMA_FROM_DEVICE;
+			else
+				return -EINVAL;
 
-		ret = iommu_tce_put_param_check(tbl, param.iova, tce);
+		ret = iommu_tce_put_param_check(tbl, param.iova, param.vaddr);
 		if (ret)
 			return ret;
 
 		ret = tce_iommu_build(container, tbl,
 				param.iova >> tbl->it_page_shift,
-				tce, param.size >> tbl->it_page_shift);
+				param.vaddr,
+				param.size >> tbl->it_page_shift,
+				direction);
 
 		iommu_flush_tce(tbl);
 
-- 
2.0.0
