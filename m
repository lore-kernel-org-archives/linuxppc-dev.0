Return-Path: <aik@ozlabs.ru>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 752351A092F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jul 2014 13:06:48 +1000 (EST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Wed, 23 Jul 2014 13:06:48 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id B85D22CE805B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jul 2014 13:06:14 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6N35w9d9109864
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jul 2014 13:05:58 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6N36E1P031217
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jul 2014 13:06:14 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 11/18] powerpc/iommu: Fix IOMMU ownership control functions
Date: Wed, 23 Jul 2014 13:05:57 +1000
Message-Id: <1406084764-24685-12-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1406084764-24685-1-git-send-email-aik@ozlabs.ru>
References: <1406084764-24685-1-git-send-email-aik@ozlabs.ru>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Paul Mackerras <paulus@samba.org>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This adds missing locks in iommu_take_ownership()/
iommu_release_ownership().

This marks all pages busy in iommu_table::it_map in order to catch
errors if there is an attempt to use this table while ownership over it
is taken.

This only clears TCE content if there is no page marked busy in it_map.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/kernel/iommu.c | 37 ++++++++++++++++++++++++++++++-------
 1 file changed, 30 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index d9494b2..da04561 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -1100,33 +1100,56 @@ EXPORT_SYMBOL_GPL(iommu_put_tce_user_mode);
 
 int iommu_take_ownership(struct iommu_table *tbl)
 {
-	unsigned long sz = (tbl->it_size + 7) >> 3;
+	unsigned long flags, i, sz = (tbl->it_size + 7) >> 3;
+	int ret = 0, bit0 = 0;
+
+	spin_lock_irqsave(&tbl->large_pool.lock, flags);
+	for (i = 0; i < tbl->nr_pools; i++)
+		spin_lock(&tbl->pools[i].lock);
 
 	if (tbl->it_offset == 0)
-		clear_bit(0, tbl->it_map);
+		bit0 = test_and_clear_bit(0, tbl->it_map);
 
 	if (!bitmap_empty(tbl->it_map, tbl->it_size)) {
 		pr_err("iommu_tce: it_map is not empty");
-		return -EBUSY;
+		ret = -EBUSY;
+		if (bit0)
+			set_bit(0, tbl->it_map);
+	} else {
+		memset(tbl->it_map, 0xff, sz);
 	}
 
-	memset(tbl->it_map, 0xff, sz);
-	iommu_clear_tces_and_put_pages(tbl, tbl->it_offset, tbl->it_size);
+	if (!ret)
+		iommu_clear_tces_and_put_pages(tbl, tbl->it_offset,
+				tbl->it_size);
 
-	return 0;
+	for (i = 0; i < tbl->nr_pools; i++)
+		spin_unlock(&tbl->pools[i].lock);
+	spin_unlock_irqrestore(&tbl->large_pool.lock, flags);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(iommu_take_ownership);
 
 void iommu_release_ownership(struct iommu_table *tbl)
 {
-	unsigned long sz = (tbl->it_size + 7) >> 3;
+	unsigned long flags, i, sz = (tbl->it_size + 7) >> 3;
 
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
2.0.0
