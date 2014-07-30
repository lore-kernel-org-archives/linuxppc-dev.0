Return-Path: <aik@ozlabs.ru>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 715261A073C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Jul 2014 19:31:50 +1000 (EST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Wed, 30 Jul 2014 19:31:48 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 773CF3578047
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Jul 2014 19:31:45 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6U9VLXV22937666
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Jul 2014 19:31:21 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6U9Vir7000619
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Jul 2014 19:31:45 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4 11/16] powerpc/powernv: Release replaced TCE
Date: Wed, 30 Jul 2014 19:31:30 +1000
Message-Id: <1406712695-9491-12-git-send-email-aik@ozlabs.ru>
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

At the moment writing new TCE value to the IOMMU table fails with EBUSY
if there is a valid entry already. However PAPR specification allows
the guest to write new TCE value without clearing it first.

This adds a set_and_get() callback to iommu_table_ops which does the same
thing as set() plus it returns replaced TCE(s) so the caller can release
the pages afterwards.

This makes iommu_tce_build() put pages returned by set_and_get().

Since now we depend on permission bits in TCE entries, this preserves
those bits in TCE in iommu_put_tce_user_mode().

This removes use of pool locks as those locks serve for TCE allocations
rathen than IOMMU table access and new set_and_get() callback provides
lockless way of safe pages release.

This disables external IOMMU use (i.e. VFIO) for IOMMUs which do not
implement set_and_get() callback. Therefore the "powernv" platform is
the only supported one.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
Changes:
v4:
* this is merge+rework of
	powerpc/powernv: Return non-zero TCE from pnv_tce_build
	powerpc/iommu: Implement put_page() if TCE had non-zero value
	powerpc/iommu: Extend ppc_md.tce_build(_rm) to return old TCE values
---
 arch/powerpc/include/asm/iommu.h     |  6 ++++++
 arch/powerpc/kernel/iommu.c          | 28 +++++++++++++++-------------
 arch/powerpc/platforms/powernv/pci.c | 29 +++++++++++++++++++++++------
 3 files changed, 44 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/iommu.h
index c725e4a..4b13e4e 100644
--- a/arch/powerpc/include/asm/iommu.h
+++ b/arch/powerpc/include/asm/iommu.h
@@ -49,6 +49,12 @@ struct iommu_table_ops {
 			unsigned long uaddr,
 			enum dma_data_direction direction,
 			struct dma_attrs *attrs);
+	int (*set_and_get)(struct iommu_table *tbl,
+			long index, long npages,
+			unsigned long uaddr,
+			unsigned long *old_tces,
+			enum dma_data_direction direction,
+			struct dma_attrs *attrs);
 	void (*clear)(struct iommu_table *tbl,
 			long index, long npages);
 	unsigned long (*get)(struct iommu_table *tbl, long index);
diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index 6a86788..ad52e00 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -1007,9 +1007,6 @@ EXPORT_SYMBOL_GPL(iommu_tce_put_param_check);
 unsigned long iommu_clear_tce(struct iommu_table *tbl, unsigned long entry)
 {
 	unsigned long oldtce;
-	struct iommu_pool *pool = get_pool(tbl, entry);
-
-	spin_lock(&(pool->lock));
 
 	oldtce = tbl->it_ops->get(tbl, entry);
 	if (oldtce & (TCE_PCI_WRITE | TCE_PCI_READ))
@@ -1017,8 +1014,6 @@ unsigned long iommu_clear_tce(struct iommu_table *tbl, unsigned long entry)
 	else
 		oldtce = 0;
 
-	spin_unlock(&(pool->lock));
-
 	return oldtce;
 }
 EXPORT_SYMBOL_GPL(iommu_clear_tce);
@@ -1056,16 +1051,12 @@ int iommu_tce_build(struct iommu_table *tbl, unsigned long entry,
 {
 	int ret = -EBUSY;
 	unsigned long oldtce;
-	struct iommu_pool *pool = get_pool(tbl, entry);
 
-	spin_lock(&(pool->lock));
+	ret = tbl->it_ops->set_and_get(tbl, entry, 1, hwaddr, &oldtce,
+			direction, NULL);
 
-	oldtce = tbl->it_ops->get(tbl, entry);
-	/* Add new entry if it is not busy */
-	if (!(oldtce & (TCE_PCI_WRITE | TCE_PCI_READ)))
-		ret = tbl->it_ops->set(tbl, entry, 1, hwaddr, direction, NULL);
-
-	spin_unlock(&(pool->lock));
+	if (oldtce & (TCE_PCI_WRITE | TCE_PCI_READ))
+		put_page(pfn_to_page(__pa(oldtce) >> PAGE_SHIFT));
 
 	/* if (unlikely(ret))
 		pr_err("iommu_tce: %s failed on hwaddr=%lx ioba=%lx kva=%lx ret=%d\n",
@@ -1092,6 +1083,7 @@ int iommu_put_tce_user_mode(struct iommu_table *tbl, unsigned long entry,
 		return -EFAULT;
 	}
 	hwaddr = (unsigned long) page_address(page) + offset;
+	hwaddr |= tce & (TCE_PCI_READ | TCE_PCI_WRITE);
 
 	ret = iommu_tce_build(tbl, entry, hwaddr, direction);
 	if (ret)
@@ -1110,6 +1102,16 @@ int iommu_take_ownership(struct iommu_table *tbl)
 	unsigned long flags, i, sz = (tbl->it_size + 7) >> 3;
 	int ret = 0, bit0 = 0;
 
+	/*
+	 * VFIO does not control TCE entries allocation and the guest
+	 * can write new TCEs on top of existing ones so iommu_tce_build()
+	 * must be able to release old pages. This functionality
+	 * requires set_and_get() callback defined so if it is not
+	 * implemented, we disallow taking ownership over the table.
+	 */
+	if (!tbl->it_ops->set_and_get)
+		return -EINVAL;
+
 	spin_lock_irqsave(&tbl->large_pool.lock, flags);
 	for (i = 0; i < tbl->nr_pools; i++)
 		spin_lock(&tbl->pools[i].lock);
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index 1179c63..629d443 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -572,12 +572,14 @@ static void pnv_tce_invalidate(struct iommu_table *tbl, __be64 *startp,
 }
 
 static int pnv_tce_build(struct iommu_table *tbl, long index, long npages,
-			 unsigned long uaddr, enum dma_data_direction direction,
+			 unsigned long uaddr, unsigned long *old_tces,
+			 enum dma_data_direction direction,
 			 struct dma_attrs *attrs, bool rm)
 {
 	u64 proto_tce;
 	__be64 *tcep, *tces;
 	u64 rpn;
+	long i;
 
 	proto_tce = TCE_PCI_READ; // Read allowed
 
@@ -587,9 +589,13 @@ static int pnv_tce_build(struct iommu_table *tbl, long index, long npages,
 	tces = tcep = ((__be64 *)tbl->it_base) + index - tbl->it_offset;
 	rpn = __pa(uaddr) >> tbl->it_page_shift;
 
-	while (npages--)
-		*(tcep++) = cpu_to_be64(proto_tce |
-				(rpn++ << tbl->it_page_shift));
+	for (i = 0; i < npages; i++) {
+		unsigned long oldtce = xchg(tcep, cpu_to_be64(proto_tce |
+				(rpn++ << tbl->it_page_shift)));
+		if (old_tces)
+			old_tces[i] = (unsigned long) __va(oldtce);
+		tcep++;
+	}
 
 	pnv_tce_invalidate(tbl, tces, tcep - 1, rm);
 
@@ -601,8 +607,18 @@ static int pnv_tce_build_vm(struct iommu_table *tbl, long index, long npages,
 			    enum dma_data_direction direction,
 			    struct dma_attrs *attrs)
 {
-	return pnv_tce_build(tbl, index, npages, uaddr, direction, attrs,
-			false);
+	return pnv_tce_build(tbl, index, npages, uaddr, NULL, direction,
+			attrs, false);
+}
+
+static int pnv_tce_set_and_get_vm(struct iommu_table *tbl, long index,
+				  long npages,
+				  unsigned long uaddr, unsigned long *old_tces,
+				  enum dma_data_direction direction,
+				  struct dma_attrs *attrs)
+{
+	return pnv_tce_build(tbl, index, npages, uaddr, old_tces, direction,
+			attrs, false);
 }
 
 static void pnv_tce_free(struct iommu_table *tbl, long index, long npages,
@@ -630,6 +646,7 @@ static unsigned long pnv_tce_get(struct iommu_table *tbl, long index)
 
 struct iommu_table_ops pnv_iommu_ops = {
 	.set = pnv_tce_build_vm,
+	.set_and_get = pnv_tce_set_and_get_vm,
 	.clear = pnv_tce_free_vm,
 	.get = pnv_tce_get,
 };
-- 
2.0.0
