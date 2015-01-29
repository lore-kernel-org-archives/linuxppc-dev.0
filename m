Return-Path: <aik@ozlabs.ru>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 001191A0B8F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jan 2015 20:22:39 +1100 (AEDT)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Thu, 29 Jan 2015 19:22:29 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 8049B2CE8055
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jan 2015 20:22:26 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t0T9MQwf40763598
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jan 2015 20:22:26 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t0T9MOJR023327
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jan 2015 20:22:24 +1100
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 22/24] powerpc/iommu: Get rid of ownership helpers
Date: Thu, 29 Jan 2015 20:22:03 +1100
Message-Id: <1422523325-1389-23-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1422523325-1389-1-git-send-email-aik@ozlabs.ru>
References: <1422523325-1389-1-git-send-email-aik@ozlabs.ru>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Alexander Gordeev <agordeev@redhat.com>, Paul Mackerras <paulus@samba.org>,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

iommu_take_ownership/iommu_release_ownership used to be used to mark
bits in iommu_table::it_map. Since the IOMMU tables are recreated for
VFIO, it_map is always NULL.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/include/asm/iommu.h |  2 -
 arch/powerpc/kernel/iommu.c      | 96 ----------------------------------------
 2 files changed, 98 deletions(-)

diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/iommu.h
index 8393822..33009f9 100644
--- a/arch/powerpc/include/asm/iommu.h
+++ b/arch/powerpc/include/asm/iommu.h
@@ -272,8 +272,6 @@ extern long iommu_tce_xchg(struct iommu_table *tbl, unsigned long entry,
 		enum dma_data_direction direction);
 
 extern void iommu_flush_tce(struct iommu_table *tbl);
-extern int iommu_take_ownership(struct powerpc_iommu *iommu);
-extern void iommu_release_ownership(struct powerpc_iommu *iommu);
 
 #endif /* __KERNEL__ */
 #endif /* _ASM_IOMMU_H */
diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index 5f87076..6987115 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -1007,102 +1007,6 @@ long iommu_tce_xchg(struct iommu_table *tbl, unsigned long entry,
 }
 EXPORT_SYMBOL_GPL(iommu_tce_xchg);
 
-static int iommu_table_take_ownership(struct iommu_table *tbl)
-{
-	unsigned long flags, i, sz = (tbl->it_size + 7) >> 3;
-	int ret = 0;
-
-	/*
-	 * VFIO does not control TCE entries allocation and the guest
-	 * can write new TCEs on top of existing ones so iommu_tce_build()
-	 * must be able to release old pages. This functionality
-	 * requires exchange() callback defined so if it is not
-	 * implemented, we disallow taking ownership over the table.
-	 */
-	if (!tbl->it_ops->exchange)
-		return -EINVAL;
-
-	spin_lock_irqsave(&tbl->large_pool.lock, flags);
-	for (i = 0; i < tbl->nr_pools; i++)
-		spin_lock(&tbl->pools[i].lock);
-
-	if (tbl->it_offset == 0)
-		clear_bit(0, tbl->it_map);
-
-	if (!bitmap_empty(tbl->it_map, tbl->it_size)) {
-		pr_err("iommu_tce: it_map is not empty");
-		ret = -EBUSY;
-		if (tbl->it_offset == 0)
-			set_bit(0, tbl->it_map);
-	} else {
-		memset(tbl->it_map, 0xff, sz);
-	}
-
-	for (i = 0; i < tbl->nr_pools; i++)
-		spin_unlock(&tbl->pools[i].lock);
-	spin_unlock_irqrestore(&tbl->large_pool.lock, flags);
-
-	return 0;
-}
-
-static void iommu_table_release_ownership(struct iommu_table *tbl);
-
-int iommu_take_ownership(struct powerpc_iommu *iommu)
-{
-	int i, j, rc = 0;
-
-	for (i = 0; i < POWERPC_IOMMU_MAX_TABLES; ++i) {
-		struct iommu_table *tbl = &iommu->tables[i];
-
-		if (!tbl->it_map)
-			continue;
-
-		rc = iommu_table_take_ownership(tbl);
-		if (rc) {
-			for (j = 0; j < i; ++j)
-				iommu_table_release_ownership(
-						&iommu->tables[j]);
-
-			return rc;
-		}
-	}
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(iommu_take_ownership);
-
-static void iommu_table_release_ownership(struct iommu_table *tbl)
-{
-	unsigned long flags, i, sz = (tbl->it_size + 7) >> 3;
-
-	spin_lock_irqsave(&tbl->large_pool.lock, flags);
-	for (i = 0; i < tbl->nr_pools; i++)
-		spin_lock(&tbl->pools[i].lock);
-
-	memset(tbl->it_map, 0, sz);
-
-	/* Restore bit#0 set by iommu_init_table() */
-	if (tbl->it_offset == 0)
-		set_bit(0, tbl->it_map);
-
-	for (i = 0; i < tbl->nr_pools; i++)
-		spin_unlock(&tbl->pools[i].lock);
-	spin_unlock_irqrestore(&tbl->large_pool.lock, flags);
-}
-
-extern void iommu_release_ownership(struct powerpc_iommu *iommu)
-{
-	int i;
-
-	for (i = 0; i < POWERPC_IOMMU_MAX_TABLES; ++i) {
-		struct iommu_table *tbl = &iommu->tables[i];
-
-		if (tbl->it_map)
-			iommu_table_release_ownership(tbl);
-	}
-}
-EXPORT_SYMBOL_GPL(iommu_release_ownership);
-
 int iommu_add_device(struct device *dev)
 {
 	struct iommu_table *tbl;
-- 
2.0.0
