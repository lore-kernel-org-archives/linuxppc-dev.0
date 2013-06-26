Return-Path: <aik@ozlabs.ru>
Received: from mail-ie0-x22a.google.com (mail-ie0-x22a.google.com
 [IPv6:2607:f8b0:4001:c03::22a])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5CF6F2C0805
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2013 15:39:38 +1000 (EST)
Received: by mail-ie0-f170.google.com with SMTP id e11so30306962iej.15
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 22:39:35 -0700 (PDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/vfio: Add missing locks for take/release TCE table
 ownership
Date: Wed, 26 Jun 2013 15:39:19 +1000
Message-Id: <1372225159-30187-1-git-send-email-aik@ozlabs.ru>
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

VFIO IOMMU driver for sPAPR TCE locks the whole DMA window by setting
ones to iommu_table.it_map. However this was not protected by the locks
which other clients of iommu_table use.

The patch fixes this.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/kernel/iommu.c |   25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index b20ff17..9f34742 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -1076,25 +1076,41 @@ EXPORT_SYMBOL_GPL(iommu_put_tce_user_mode);
 int iommu_take_ownership(struct iommu_table *tbl)
 {
 	unsigned long sz = (tbl->it_size + 7) >> 3;
+	int i, ret = 0;
+
+	for (i = 0; i < tbl->nr_pools; i++)
+		spin_lock(&tbl->pools[i].lock);
+	spin_lock(&tbl->large_pool.lock);
 
 	if (tbl->it_offset == 0)
 		clear_bit(0, tbl->it_map);
 
 	if (!bitmap_empty(tbl->it_map, tbl->it_size)) {
 		pr_err("iommu_tce: it_map is not empty");
-		return -EBUSY;
+		ret = -EBUSY;
+		goto unlock_exit;
 	}
 
 	memset(tbl->it_map, 0xff, sz);
 	iommu_clear_tces_and_put_pages(tbl, tbl->it_offset, tbl->it_size);
 
-	return 0;
+unlock_exit:
+	spin_unlock(&tbl->large_pool.lock);
+	for (i = 0; i < tbl->nr_pools; i++)
+		spin_unlock(&tbl->pools[i].lock);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(iommu_take_ownership);
 
 void iommu_release_ownership(struct iommu_table *tbl)
 {
 	unsigned long sz = (tbl->it_size + 7) >> 3;
+	int i;
+
+	for (i = 0; i < tbl->nr_pools; i++)
+		spin_lock(&tbl->pools[i].lock);
+	spin_lock(&tbl->large_pool.lock);
 
 	iommu_clear_tces_and_put_pages(tbl, tbl->it_offset, tbl->it_size);
 	memset(tbl->it_map, 0, sz);
@@ -1102,6 +1118,11 @@ void iommu_release_ownership(struct iommu_table *tbl)
 	/* Restore bit#0 set by iommu_init_table() */
 	if (tbl->it_offset == 0)
 		set_bit(0, tbl->it_map);
+
+	spin_unlock(&tbl->large_pool.lock);
+	for (i = 0; i < tbl->nr_pools; i++)
+		spin_unlock(&tbl->pools[i].lock);
+
 }
 EXPORT_SYMBOL_GPL(iommu_release_ownership);
 
-- 
1.7.10.4
