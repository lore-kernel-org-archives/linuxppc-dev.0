Return-Path: <aik@ozlabs.ru>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D3A441A037E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2015 01:40:50 +1000 (AEST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Tue, 12 May 2015 01:40:50 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 3075E2BB005F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2015 01:40:49 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4BFef3Q45875312
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2015 01:40:49 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4BFeG4V011504
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2015 01:40:16 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel v10 13/34] powerpc/powernv: Do not set "read" flag if
 direction==DMA_NONE
Date: Tue, 12 May 2015 01:39:02 +1000
Message-Id: <1431358763-24371-14-git-send-email-aik@ozlabs.ru>
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

Normally a bitmap from the iommu_table is used to track what TCE entry
is in use. Since we are going to use iommu_table without its locks and
do xchg() instead, it becomes essential not to put bits which are not
implied in the direction flag as the old TCE value (more precisely -
the permission bits) will be used to decide whether to put the page or not.

This adds iommu_direction_to_tce_perm() (its counterpart is there already)
and uses it for powernv's pnv_tce_build().

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
---
Changes:
v9:
* added comment why we must put only valid permission bits
---
 arch/powerpc/include/asm/iommu.h     |  1 +
 arch/powerpc/kernel/iommu.c          | 15 +++++++++++++++
 arch/powerpc/platforms/powernv/pci.c |  7 +------
 3 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/iommu.h
index e94a5e3..d91bd69 100644
--- a/arch/powerpc/include/asm/iommu.h
+++ b/arch/powerpc/include/asm/iommu.h
@@ -200,6 +200,7 @@ extern int iommu_take_ownership(struct iommu_table *tbl);
 extern void iommu_release_ownership(struct iommu_table *tbl);
 
 extern enum dma_data_direction iommu_tce_direction(unsigned long tce);
+extern unsigned long iommu_direction_to_tce_perm(enum dma_data_direction dir);
 
 #endif /* __KERNEL__ */
 #endif /* _ASM_IOMMU_H */
diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index 8673c94..31319f8 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -863,6 +863,21 @@ void iommu_free_coherent(struct iommu_table *tbl, size_t size,
 	}
 }
 
+unsigned long iommu_direction_to_tce_perm(enum dma_data_direction dir)
+{
+	switch (dir) {
+	case DMA_BIDIRECTIONAL:
+		return TCE_PCI_READ | TCE_PCI_WRITE;
+	case DMA_FROM_DEVICE:
+		return TCE_PCI_WRITE;
+	case DMA_TO_DEVICE:
+		return TCE_PCI_READ;
+	default:
+		return 0;
+	}
+}
+EXPORT_SYMBOL_GPL(iommu_direction_to_tce_perm);
+
 #ifdef CONFIG_IOMMU_API
 /*
  * SPAPR TCE API
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index bca2aeb..b7ea245 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -576,15 +576,10 @@ static int pnv_tce_build(struct iommu_table *tbl, long index, long npages,
 			 unsigned long uaddr, enum dma_data_direction direction,
 			 struct dma_attrs *attrs, bool rm)
 {
-	u64 proto_tce;
+	u64 proto_tce = iommu_direction_to_tce_perm(direction);
 	__be64 *tcep, *tces;
 	u64 rpn;
 
-	proto_tce = TCE_PCI_READ; // Read allowed
-
-	if (direction != DMA_TO_DEVICE)
-		proto_tce |= TCE_PCI_WRITE;
-
 	tces = tcep = ((__be64 *)tbl->it_base) + index - tbl->it_offset;
 	rpn = __pa(uaddr) >> tbl->it_page_shift;
 
-- 
2.4.0.rc3.8.gfb3e7d5
