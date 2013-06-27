Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-f50.google.com (mail-pa0-f50.google.com
 [209.85.220.50])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B41EE2C0096
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jun 2013 14:53:28 +1000 (EST)
Received: by mail-pa0-f50.google.com with SMTP id fb1so516757pad.37
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2013 21:53:26 -0700 (PDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3] powerpc: Rework iommu_table locks
Date: Thu, 27 Jun 2013 14:53:16 +1000
Message-Id: <1372308796-27796-1-git-send-email-aik@ozlabs.ru>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The locks in arch/powerpc/kernel/iommu.c were initally added to protect
iommu_table::it_map so the patch just makes things consistent.

Specifically, it does:

1. add missing locks for it_map access during iommu_take_ownership/
iommu_release_ownership execution where the entire it_map is marked
busy/free in order to avoid allocation from it by some broken
driver on the host.

2. remove locks from functions being called by VFIO. The whole table
is given to the user space so it is responsible now for races.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---

This is actually v3 of [PATCH v2] powerpc/vfio: Add missing locks for take/release TCE table ownership

---
 arch/powerpc/kernel/iommu.c |   40 ++++++++++++++++++++++++++--------------
 1 file changed, 26 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index b20ff17..1391ddd 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -975,9 +975,6 @@ EXPORT_SYMBOL_GPL(iommu_tce_put_param_check);
 unsigned long iommu_clear_tce(struct iommu_table *tbl, unsigned long entry)
 {
 	unsigned long oldtce;
-	struct iommu_pool *pool = get_pool(tbl, entry);
-
-	spin_lock(&(pool->lock));
 
 	oldtce = ppc_md.tce_get(tbl, entry);
 	if (oldtce & (TCE_PCI_WRITE | TCE_PCI_READ))
@@ -985,8 +982,6 @@ unsigned long iommu_clear_tce(struct iommu_table *tbl, unsigned long entry)
 	else
 		oldtce = 0;
 
-	spin_unlock(&(pool->lock));
-
 	return oldtce;
 }
 EXPORT_SYMBOL_GPL(iommu_clear_tce);
@@ -1024,17 +1019,12 @@ int iommu_tce_build(struct iommu_table *tbl, unsigned long entry,
 {
 	int ret = -EBUSY;
 	unsigned long oldtce;
-	struct iommu_pool *pool = get_pool(tbl, entry);
-
-	spin_lock(&(pool->lock));
 
 	oldtce = ppc_md.tce_get(tbl, entry);
 	/* Add new entry if it is not busy */
 	if (!(oldtce & (TCE_PCI_WRITE | TCE_PCI_READ)))
 		ret = ppc_md.tce_build(tbl, entry, 1, hwaddr, direction, NULL);
 
-	spin_unlock(&(pool->lock));
-
 	/* if (unlikely(ret))
 		pr_err("iommu_tce: %s failed on hwaddr=%lx ioba=%lx kva=%lx ret=%d\n",
 				__func__, hwaddr, entry << IOMMU_PAGE_SHIFT,
@@ -1076,32 +1066,54 @@ EXPORT_SYMBOL_GPL(iommu_put_tce_user_mode);
 int iommu_take_ownership(struct iommu_table *tbl)
 {
 	unsigned long sz = (tbl->it_size + 7) >> 3;
+	unsigned long i, flags;
+	int ret = 0;
+
+	spin_lock_irqsave(&tbl->large_pool.lock, flags);
+	for (i = 0; i < tbl->nr_pools; i++)
+		spin_lock(&tbl->pools[i].lock);
 
 	if (tbl->it_offset == 0)
 		clear_bit(0, tbl->it_map);
 
 	if (!bitmap_empty(tbl->it_map, tbl->it_size)) {
 		pr_err("iommu_tce: it_map is not empty");
-		return -EBUSY;
+		ret = -EBUSY;
+	} else {
+		memset(tbl->it_map, 0xff, sz);
 	}
 
-	memset(tbl->it_map, 0xff, sz);
-	iommu_clear_tces_and_put_pages(tbl, tbl->it_offset, tbl->it_size);
+	for (i = 0; i < tbl->nr_pools; i++)
+		spin_unlock(&tbl->pools[i].lock);
+	spin_unlock_irqrestore(&tbl->large_pool.lock, flags);
 
-	return 0;
+	if (!ret)
+		iommu_clear_tces_and_put_pages(tbl, tbl->it_offset, tbl->it_size);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(iommu_take_ownership);
 
 void iommu_release_ownership(struct iommu_table *tbl)
 {
 	unsigned long sz = (tbl->it_size + 7) >> 3;
+	unsigned long i, flags;
 
 	iommu_clear_tces_and_put_pages(tbl, tbl->it_offset, tbl->it_size);
+
+	spin_lock_irqsave(&tbl->large_pool.lock, flags);
+	for (i = 0; i < tbl->nr_pools; i++)
+		spin_lock(&tbl->pools[i].lock);
+
 	memset(tbl->it_map, 0, sz);
 
 	/* Restore bit#0 set by iommu_init_table() */
 	if (tbl->it_offset == 0)
 		set_bit(0, tbl->it_map);
+
+	for (i = 0; i < tbl->nr_pools; i++)
+		spin_unlock(&tbl->pools[i].lock);
+	spin_unlock_irqrestore(&tbl->large_pool.lock, flags);
 }
 EXPORT_SYMBOL_GPL(iommu_release_ownership);
 
-- 
1.7.10.4
