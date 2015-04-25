Return-Path: <aik@ozlabs.ru>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 114B31A0C40
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Apr 2015 22:16:47 +1000 (AEST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Sat, 25 Apr 2015 22:16:46 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 483E62BB0059
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Apr 2015 22:16:44 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3PCGaTe29294752
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Apr 2015 22:16:44 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3PCGAgO027872
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Apr 2015 22:16:11 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel v9 18/32] powerpc/iommu/powernv: Release replaced TCE
Date: Sat, 25 Apr 2015 22:14:42 +1000
Message-Id: <1429964096-11524-19-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1429964096-11524-1-git-send-email-aik@ozlabs.ru>
References: <1429964096-11524-1-git-send-email-aik@ozlabs.ru>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
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
the caller can release the pages afterwards. The exchange() receives
a physical address unlike set() which receives linear mapping address;
and returns a physical address as the clear() does.

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
[aw: for the vfio related changes]
Acked-by: Alex Williamson <alex.williamson@redhat.com>
---
Changes:
v9:
* changed exchange() to work with physical addresses as these addresses
are never accessed by the code and physical addresses are actual values
we put into the IOMMU table
---
 arch/powerpc/include/asm/iommu.h            | 22 +++++++++--
 arch/powerpc/kernel/iommu.c                 | 57 +++++++++-------------------
 arch/powerpc/platforms/powernv/pci-ioda.c   | 34 +++++++++++++++++
 arch/powerpc/platforms/powernv/pci-p5ioc2.c |  3 ++
 arch/powerpc/platforms/powernv/pci.c        | 17 +++++++++
 arch/powerpc/platforms/powernv/pci.h        |  2 +
 drivers/vfio/vfio_iommu_spapr_tce.c         | 58 ++++++++++++++++++-----------
 7 files changed, 128 insertions(+), 65 deletions(-)

diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/iommu.h
index e63419e..7e7ca0a 100644
--- a/arch/powerpc/include/asm/iommu.h
+++ b/arch/powerpc/include/asm/iommu.h
@@ -45,13 +45,29 @@ extern int iommu_is_off;
 extern int iommu_force_on;
 
 struct iommu_table_ops {
+	/*
+	 * When called with direction==DMA_NONE, it is equal to clear().
+	 * uaddr is a linear map address.
+	 */
 	int (*set)(struct iommu_table *tbl,
 			long index, long npages,
 			unsigned long uaddr,
 			enum dma_data_direction direction,
 			struct dma_attrs *attrs);
+#ifdef CONFIG_IOMMU_API
+	/*
+	 * Exchanges existing TCE with new TCE plus direction bits;
+	 * returns old TCE and DMA direction mask.
+	 * @tce is a physical address.
+	 */
+	int (*exchange)(struct iommu_table *tbl,
+			long index,
+			unsigned long *tce,
+			enum dma_data_direction *direction);
+#endif
 	void (*clear)(struct iommu_table *tbl,
 			long index, long npages);
+	/* get() returns a physical address */
 	unsigned long (*get)(struct iommu_table *tbl, long index);
 	void (*flush)(struct iommu_table *tbl);
 };
@@ -152,6 +168,8 @@ extern void iommu_register_group(struct iommu_table_group *table_group,
 extern int iommu_add_device(struct device *dev);
 extern void iommu_del_device(struct device *dev);
 extern int __init tce_iommu_bus_notifier_init(void);
+extern long iommu_tce_xchg(struct iommu_table *tbl, unsigned long entry,
+		unsigned long *tce, enum dma_data_direction *direction);
 #else
 static inline void iommu_register_group(struct iommu_table_group *table_group,
 					int pci_domain_number,
@@ -231,10 +249,6 @@ extern int iommu_tce_clear_param_check(struct iommu_table *tbl,
 		unsigned long npages);
 extern int iommu_tce_put_param_check(struct iommu_table *tbl,
 		unsigned long ioba, unsigned long tce);
-extern int iommu_tce_build(struct iommu_table *tbl, unsigned long entry,
-		unsigned long hwaddr, enum dma_data_direction direction);
-extern unsigned long iommu_clear_tce(struct iommu_table *tbl,
-		unsigned long entry);
 
 extern void iommu_flush_tce(struct iommu_table *tbl);
 extern int iommu_take_ownership(struct iommu_table *tbl);
diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index ea2c8ba..2eaba0c 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -975,9 +975,6 @@ EXPORT_SYMBOL_GPL(iommu_tce_clear_param_check);
 int iommu_tce_put_param_check(struct iommu_table *tbl,
 		unsigned long ioba, unsigned long tce)
 {
-	if (!(tce & (TCE_PCI_WRITE | TCE_PCI_READ)))
-		return -EINVAL;
-
 	if (tce & ~(IOMMU_PAGE_MASK(tbl) | TCE_PCI_WRITE | TCE_PCI_READ))
 		return -EINVAL;
 
@@ -995,44 +992,16 @@ int iommu_tce_put_param_check(struct iommu_table *tbl,
 }
 EXPORT_SYMBOL_GPL(iommu_tce_put_param_check);
 
-unsigned long iommu_clear_tce(struct iommu_table *tbl, unsigned long entry)
+long iommu_tce_xchg(struct iommu_table *tbl, unsigned long entry,
+		unsigned long *tce, enum dma_data_direction *direction)
 {
-	unsigned long oldtce;
-	struct iommu_pool *pool = get_pool(tbl, entry);
+	long ret;
 
-	spin_lock(&(pool->lock));
+	ret = tbl->it_ops->exchange(tbl, entry, tce, direction);
 
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
-/*
- * hwaddr is a kernel virtual address here (0xc... bazillion),
- * tce_build converts it to a physical address.
- */
-int iommu_tce_build(struct iommu_table *tbl, unsigned long entry,
-		unsigned long hwaddr, enum dma_data_direction direction)
-{
-	int ret = -EBUSY;
-	unsigned long oldtce;
-	struct iommu_pool *pool = get_pool(tbl, entry);
-
-	spin_lock(&(pool->lock));
-
-	oldtce = tbl->it_ops->get(tbl, entry);
-	/* Add new entry if it is not busy */
-	if (!(oldtce & (TCE_PCI_WRITE | TCE_PCI_READ)))
-		ret = tbl->it_ops->set(tbl, entry, 1, hwaddr, direction, NULL);
-
-	spin_unlock(&(pool->lock));
+	if (!ret && ((*direction == DMA_FROM_DEVICE) ||
+			(*direction == DMA_BIDIRECTIONAL)))
+		SetPageDirty(pfn_to_page(*tce >> PAGE_SHIFT));
 
 	/* if (unlikely(ret))
 		pr_err("iommu_tce: %s failed on hwaddr=%lx ioba=%lx kva=%lx ret=%d\n",
@@ -1041,13 +1010,23 @@ int iommu_tce_build(struct iommu_table *tbl, unsigned long entry,
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(iommu_tce_build);
+EXPORT_SYMBOL_GPL(iommu_tce_xchg);
 
 int iommu_take_ownership(struct iommu_table *tbl)
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
index b22b3ca..fb765af 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1728,6 +1728,20 @@ static int pnv_ioda1_tce_build(struct iommu_table *tbl, long index,
 	return ret;
 }
 
+#ifdef CONFIG_IOMMU_API
+static int pnv_ioda1_tce_xchg(struct iommu_table *tbl, long index,
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
 static void pnv_ioda1_tce_free(struct iommu_table *tbl, long index,
 		long npages)
 {
@@ -1739,6 +1753,9 @@ static void pnv_ioda1_tce_free(struct iommu_table *tbl, long index,
 
 static struct iommu_table_ops pnv_ioda1_iommu_ops = {
 	.set = pnv_ioda1_tce_build,
+#ifdef CONFIG_IOMMU_API
+	.exchange = pnv_ioda1_tce_xchg,
+#endif
 	.clear = pnv_ioda1_tce_free,
 	.get = pnv_tce_get,
 };
@@ -1800,6 +1817,20 @@ static int pnv_ioda2_tce_build(struct iommu_table *tbl, long index,
 	return ret;
 }
 
+#ifdef CONFIG_IOMMU_API
+static int pnv_ioda2_tce_xchg(struct iommu_table *tbl, long index,
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
 static void pnv_ioda2_tce_free(struct iommu_table *tbl, long index,
 		long npages)
 {
@@ -1811,6 +1842,9 @@ static void pnv_ioda2_tce_free(struct iommu_table *tbl, long index,
 
 static struct iommu_table_ops pnv_ioda2_iommu_ops = {
 	.set = pnv_ioda2_tce_build,
+#ifdef CONFIG_IOMMU_API
+	.exchange = pnv_ioda2_tce_xchg,
+#endif
 	.clear = pnv_ioda2_tce_free,
 	.get = pnv_tce_get,
 };
diff --git a/arch/powerpc/platforms/powernv/pci-p5ioc2.c b/arch/powerpc/platforms/powernv/pci-p5ioc2.c
index a073af0..7a6fd92 100644
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
index ba75aa5..e8802ac 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -598,6 +598,23 @@ int pnv_tce_build(struct iommu_table *tbl, long index, long npages,
 	return 0;
 }
 
+#ifdef CONFIG_IOMMU_API
+int pnv_tce_xchg(struct iommu_table *tbl, long index,
+		unsigned long *tce, enum dma_data_direction *direction)
+{
+	u64 proto_tce = iommu_direction_to_tce_perm(*direction);
+	unsigned long newtce = *tce | proto_tce;
+	unsigned long idx = index - tbl->it_offset;
+
+	*tce = xchg(pnv_tce(tbl, idx), cpu_to_be64(newtce));
+	*tce = be64_to_cpu(*tce);
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
index bd83d85..b15cce5 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -205,6 +205,8 @@ extern int pnv_tce_build(struct iommu_table *tbl, long index, long npages,
 		unsigned long uaddr, enum dma_data_direction direction,
 		struct dma_attrs *attrs);
 extern void pnv_tce_free(struct iommu_table *tbl, long index, long npages);
+extern int pnv_tce_xchg(struct iommu_table *tbl, long index,
+		unsigned long *tce, enum dma_data_direction *direction);
 extern unsigned long pnv_tce_get(struct iommu_table *tbl, long index);
 
 void pnv_pci_dump_phb_diag_data(struct pci_controller *hose,
diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
index dacc738..2d51bbf 100644
--- a/drivers/vfio/vfio_iommu_spapr_tce.c
+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
@@ -239,14 +239,7 @@ static void tce_iommu_unuse_page(struct tce_container *container,
 {
 	struct page *page;
 
-	if (!(oldtce & (TCE_PCI_READ | TCE_PCI_WRITE)))
-		return;
-
 	page = pfn_to_page(oldtce >> PAGE_SHIFT);
-
-	if (oldtce & TCE_PCI_WRITE)
-		SetPageDirty(page);
-
 	put_page(page);
 }
 
@@ -255,10 +248,17 @@ static int tce_iommu_clear(struct tce_container *container,
 		unsigned long entry, unsigned long pages)
 {
 	unsigned long oldtce;
+	long ret;
+	enum dma_data_direction direction;
 
 	for ( ; pages; --pages, ++entry) {
-		oldtce = iommu_clear_tce(tbl, entry);
-		if (!oldtce)
+		direction = DMA_NONE;
+		oldtce = 0;
+		ret = iommu_tce_xchg(tbl, entry, &oldtce, &direction);
+		if (ret)
+			continue;
+
+		if (direction == DMA_NONE)
 			continue;
 
 		tce_iommu_unuse_page(container, oldtce);
@@ -283,12 +283,13 @@ static int tce_iommu_use_page(unsigned long tce, unsigned long *hpa)
 
 static long tce_iommu_build(struct tce_container *container,
 		struct iommu_table *tbl,
-		unsigned long entry, unsigned long tce, unsigned long pages)
+		unsigned long entry, unsigned long tce, unsigned long pages,
+		enum dma_data_direction direction)
 {
 	long i, ret = 0;
 	struct page *page;
 	unsigned long hpa;
-	enum dma_data_direction direction = iommu_tce_direction(tce);
+	enum dma_data_direction dirtmp;
 
 	for (i = 0; i < pages; ++i) {
 		unsigned long offset = tce & IOMMU_PAGE_MASK(tbl) & ~PAGE_MASK;
@@ -304,8 +305,8 @@ static long tce_iommu_build(struct tce_container *container,
 		}
 
 		hpa |= offset;
-		ret = iommu_tce_build(tbl, entry + i, (unsigned long) __va(hpa),
-				direction);
+		dirtmp = direction;
+		ret = iommu_tce_xchg(tbl, entry + i, &hpa, &dirtmp);
 		if (ret) {
 			tce_iommu_unuse_page(container, hpa);
 			pr_err("iommu_tce: %s failed ioba=%lx, tce=%lx, ret=%ld\n",
@@ -313,6 +314,10 @@ static long tce_iommu_build(struct tce_container *container,
 					tce, ret);
 			break;
 		}
+
+		if (dirtmp != DMA_NONE)
+			tce_iommu_unuse_page(container, hpa);
+
 		tce += IOMMU_PAGE_SIZE(tbl);
 	}
 
@@ -377,7 +382,7 @@ static long tce_iommu_ioctl(void *iommu_data,
 	case VFIO_IOMMU_MAP_DMA: {
 		struct vfio_iommu_type1_dma_map param;
 		struct iommu_table *tbl;
-		unsigned long tce;
+		enum dma_data_direction direction;
 
 		if (!container->enabled)
 			return -EPERM;
@@ -398,24 +403,33 @@ static long tce_iommu_ioctl(void *iommu_data,
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
