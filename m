Return-Path: <aik@ozlabs.ru>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 641AC1A09A6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2015 01:09:16 +1100 (AEDT)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Tue, 10 Mar 2015 00:09:15 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id AAD1A2BB004D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2015 01:09:12 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t29E94JE41550008
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2015 01:09:12 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t29E8dDR006538
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2015 01:08:39 +1100
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v5 18/29] powerpc/iommu/powernv: Release replaced TCE
Date: Tue, 10 Mar 2015 01:07:14 +1100
Message-Id: <1425910045-26167-19-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1425910045-26167-1-git-send-email-aik@ozlabs.ru>
References: <1425910045-26167-1-git-send-email-aik@ozlabs.ru>
Cc: kvm@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
 linux-kernel@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>
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
 arch/powerpc/include/asm/iommu.h            | 15 +++++--
 arch/powerpc/kernel/iommu.c                 | 53 +++++++++++-------------
 arch/powerpc/platforms/powernv/pci-ioda.c   | 26 ++++++++++++
 arch/powerpc/platforms/powernv/pci-p5ioc2.c |  1 +
 arch/powerpc/platforms/powernv/pci.c        | 15 +++++++
 arch/powerpc/platforms/powernv/pci.h        |  2 +
 drivers/vfio/vfio_iommu_spapr_tce.c         | 62 ++++++++++++++++++-----------
 7 files changed, 116 insertions(+), 58 deletions(-)

diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/iommu.h
index d1f8c6c..6af22a4 100644
--- a/arch/powerpc/include/asm/iommu.h
+++ b/arch/powerpc/include/asm/iommu.h
@@ -44,11 +44,20 @@ extern int iommu_is_off;
 extern int iommu_force_on;
 
 struct iommu_table_ops {
+	/* When called with direction==DMA_NONE, it is equal to clear() */
 	int (*set)(struct iommu_table *tbl,
 			long index, long npages,
 			unsigned long uaddr,
 			enum dma_data_direction direction,
 			struct dma_attrs *attrs);
+	/*
+	 * Exchanges existing TCE with new TCE plus direction bits;
+	 * returns old TCE and DMA direction mask
+	 */
+	int (*exchange)(struct iommu_table *tbl,
+			long index,
+			unsigned long *tce,
+			enum dma_data_direction *direction);
 	void (*clear)(struct iommu_table *tbl,
 			long index, long npages);
 	unsigned long (*get)(struct iommu_table *tbl, long index);
@@ -231,10 +240,8 @@ extern int iommu_tce_clear_param_check(struct iommu_table *tbl,
 		unsigned long npages);
 extern int iommu_tce_put_param_check(struct iommu_table *tbl,
 		unsigned long ioba, unsigned long tce);
-extern int iommu_tce_build(struct iommu_table *tbl, unsigned long entry,
-		unsigned long hwaddr, enum dma_data_direction direction);
-extern unsigned long iommu_clear_tce(struct iommu_table *tbl,
-		unsigned long entry);
+extern long iommu_tce_xchg(struct iommu_table *tbl, unsigned long entry,
+		unsigned long *tce, enum dma_data_direction *direction);
 
 extern void iommu_flush_tce(struct iommu_table *tbl);
 extern int iommu_take_ownership(struct iommu_table_group *table_group);
diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index df888a7..f0f60ec 100644
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
 
@@ -1002,44 +999,30 @@ int iommu_tce_put_param_check(struct iommu_table *tbl,
 }
 EXPORT_SYMBOL_GPL(iommu_tce_put_param_check);
 
-unsigned long iommu_clear_tce(struct iommu_table *tbl, unsigned long entry)
+static void iommu_tce_mk_dirty(unsigned long tce)
 {
-	unsigned long oldtce;
-	struct iommu_pool *pool = get_pool(tbl, entry);
+	struct page *pg = pfn_to_page(__pa(tce) >> PAGE_SHIFT);
 
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
+	SetPageDirty(pg);
 }
-EXPORT_SYMBOL_GPL(iommu_clear_tce);
 
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
+	if (*tce & ~IOMMU_PAGE_MASK(tbl))
+		return -EINVAL;
 
-	oldtce = tbl->it_ops->get(tbl, entry);
-	/* Add new entry if it is not busy */
-	if (!(oldtce & (TCE_PCI_WRITE | TCE_PCI_READ)))
-		ret = tbl->it_ops->set(tbl, entry, 1, hwaddr, direction, NULL);
+	ret = tbl->it_ops->exchange(tbl, entry, tce, direction);
 
-	spin_unlock(&(pool->lock));
+	if (!ret && ((*direction == DMA_FROM_DEVICE) ||
+			(*direction == DMA_BIDIRECTIONAL)))
+		iommu_tce_mk_dirty(*tce);
 
 	/* if (unlikely(ret))
 		pr_err("iommu_tce: %s failed on hwaddr=%lx ioba=%lx kva=%lx ret=%d\n",
@@ -1048,13 +1031,23 @@ int iommu_tce_build(struct iommu_table *tbl, unsigned long entry,
 
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
index 43a7cce..3703098 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1130,6 +1130,18 @@ static int pnv_ioda1_tce_build_vm(struct iommu_table *tbl, long index,
 	return ret;
 }
 
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
+
 static void pnv_ioda1_tce_free_vm(struct iommu_table *tbl, long index,
 		long npages)
 {
@@ -1141,6 +1153,7 @@ static void pnv_ioda1_tce_free_vm(struct iommu_table *tbl, long index,
 
 struct iommu_table_ops pnv_ioda1_iommu_ops = {
 	.set = pnv_ioda1_tce_build_vm,
+	.exchange = pnv_ioda1_tce_xchg_vm,
 	.clear = pnv_ioda1_tce_free_vm,
 	.get = pnv_tce_get,
 };
@@ -1192,6 +1205,18 @@ static int pnv_ioda2_tce_build_vm(struct iommu_table *tbl, long index,
 	return ret;
 }
 
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
+
 static void pnv_ioda2_tce_free_vm(struct iommu_table *tbl, long index,
 		long npages)
 {
@@ -1203,6 +1228,7 @@ static void pnv_ioda2_tce_free_vm(struct iommu_table *tbl, long index,
 
 static struct iommu_table_ops pnv_ioda2_iommu_ops = {
 	.set = pnv_ioda2_tce_build_vm,
+	.exchange = pnv_ioda2_tce_xchg_vm,
 	.clear = pnv_ioda2_tce_free_vm,
 	.get = pnv_tce_get,
 };
diff --git a/arch/powerpc/platforms/powernv/pci-p5ioc2.c b/arch/powerpc/platforms/powernv/pci-p5ioc2.c
index 6906a9c..5888b2c 100644
--- a/arch/powerpc/platforms/powernv/pci-p5ioc2.c
+++ b/arch/powerpc/platforms/powernv/pci-p5ioc2.c
@@ -85,6 +85,7 @@ static void pnv_pci_init_p5ioc2_msis(struct pnv_phb *phb) { }
 
 static struct iommu_table_ops pnv_p5ioc2_iommu_ops = {
 	.set = pnv_tce_build,
+	.exchange = pnv_tce_xchg,
 	.clear = pnv_tce_free,
 	.get = pnv_tce_get,
 };
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index a8c05de..c5e1f05 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -615,6 +615,21 @@ int pnv_tce_build(struct iommu_table *tbl, long index, long npages,
 	return 0;
 }
 
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
index 10e9e76..e572c28 100644
--- a/drivers/vfio/vfio_iommu_spapr_tce.c
+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
@@ -452,9 +452,6 @@ static void tce_iommu_unuse_page(struct tce_container *container,
 {
 	struct page *page;
 
-	if (!(oldtce & (TCE_PCI_READ | TCE_PCI_WRITE)))
-		return;
-
 	/*
 	 * VFIO cannot map/unmap when a container is not enabled so
 	 * we would not need this check but KVM could map/unmap and if
@@ -464,14 +461,10 @@ static void tce_iommu_unuse_page(struct tce_container *container,
 	if (!container->enabled)
 		return;
 
-	page = pfn_to_page(__pa(oldtce) >> PAGE_SHIFT);
-
-	if (oldtce & TCE_PCI_WRITE)
-		SetPageDirty(page);
-
 	if (tce_preregistered(container))
 		return;
 
+	page = pfn_to_page(__pa(oldtce) >> PAGE_SHIFT);
 	put_page(page);
 }
 
@@ -479,14 +472,19 @@ static int tce_iommu_clear(struct tce_container *container,
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
+		if (direction != DMA_NONE)
+			tce_iommu_unuse_page(container, tce);
 	}
 
 	return 0;
@@ -528,12 +526,13 @@ static unsigned long tce_get_hva_cached(struct tce_container *container,
 
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
 		if (tce_preregistered(container))
@@ -554,15 +553,21 @@ static long tce_iommu_build(struct tce_container *container,
 
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
 
@@ -627,7 +632,7 @@ static long tce_iommu_ioctl(void *iommu_data,
 	case VFIO_IOMMU_MAP_DMA: {
 		struct vfio_iommu_type1_dma_map param;
 		struct iommu_table *tbl;
-		unsigned long tce;
+		enum dma_data_direction direction;
 
 		if (!container->enabled)
 			return -EPERM;
@@ -648,24 +653,33 @@ static long tce_iommu_ioctl(void *iommu_data,
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
