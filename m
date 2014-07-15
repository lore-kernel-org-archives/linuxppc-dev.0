Return-Path: <aik@ozlabs.ru>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 36E491A02C1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:25:21 +1000 (EST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Tue, 15 Jul 2014 19:25:20 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id C8B982BB0023
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:25:19 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6F9P3Zu7143854
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:25:03 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6F9PJvL005857
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:25:19 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v1 3/7] powerpc/iommu: Clean up IOMMU API
Date: Tue, 15 Jul 2014 19:25:07 +1000
Message-Id: <1405416311-12429-4-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1405416311-12429-1-git-send-email-aik@ozlabs.ru>
References: <1405416311-12429-1-git-send-email-aik@ozlabs.ru>
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

The iommu_tce_direction() function is not used from outside iommu.c
so make it static.

The iommu_clear_tce() is not used anymore at all so remove it.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/include/asm/iommu.h |  4 ----
 arch/powerpc/kernel/iommu.c      | 22 +---------------------
 2 files changed, 1 insertion(+), 25 deletions(-)

diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/iommu.h
index 1c9b346..2f420c28 100644
--- a/arch/powerpc/include/asm/iommu.h
+++ b/arch/powerpc/include/asm/iommu.h
@@ -195,8 +195,6 @@ extern int iommu_tce_put_param_check(struct iommu_table *tbl,
 		unsigned long ioba, unsigned long tce);
 extern int iommu_tce_build(struct iommu_table *tbl, unsigned long entry,
 		unsigned long *hpas, unsigned long npages, bool realmode);
-extern unsigned long iommu_clear_tce(struct iommu_table *tbl,
-		unsigned long entry);
 extern int iommu_clear_tces_and_put_pages(struct iommu_table *tbl,
 		unsigned long entry, unsigned long pages,
 		bool realmode);
@@ -207,7 +205,5 @@ extern void iommu_flush_tce(struct iommu_table *tbl);
 extern int iommu_take_ownership(struct iommu_table *tbl);
 extern void iommu_release_ownership(struct iommu_table *tbl);
 
-extern enum dma_data_direction iommu_tce_direction(unsigned long tce);
-
 #endif /* __KERNEL__ */
 #endif /* _ASM_IOMMU_H */
diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index dd68569..259ddb5 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -929,7 +929,7 @@ void iommu_register_group(struct iommu_table *tbl,
 	kfree(name);
 }
 
-enum dma_data_direction iommu_tce_direction(unsigned long tce)
+static enum dma_data_direction iommu_tce_direction(unsigned long tce)
 {
 	if ((tce & TCE_PCI_READ) && (tce & TCE_PCI_WRITE))
 		return DMA_BIDIRECTIONAL;
@@ -940,7 +940,6 @@ enum dma_data_direction iommu_tce_direction(unsigned long tce)
 	else
 		return DMA_NONE;
 }
-EXPORT_SYMBOL_GPL(iommu_tce_direction);
 
 void iommu_flush_tce(struct iommu_table *tbl)
 {
@@ -998,25 +997,6 @@ int iommu_tce_put_param_check(struct iommu_table *tbl,
 }
 EXPORT_SYMBOL_GPL(iommu_tce_put_param_check);
 
-unsigned long iommu_clear_tce(struct iommu_table *tbl, unsigned long entry)
-{
-	unsigned long oldtce;
-	struct iommu_pool *pool = get_pool(tbl, entry);
-
-	spin_lock(&(pool->lock));
-
-	oldtce = ppc_md.tce_get(tbl, entry);
-	if (oldtce & (TCE_PCI_WRITE | TCE_PCI_READ))
-		ppc_md.tce_free(tbl, entry, 1);
-	else
-		oldtce = 0;
-
-	spin_unlock(&(pool->lock));
-
-	return oldtce;
-}
-EXPORT_SYMBOL_GPL(iommu_clear_tce);
-
 int iommu_clear_tces_and_put_pages(struct iommu_table *tbl,
 		unsigned long entry, unsigned long pages,
 		bool realmode)
-- 
2.0.0
