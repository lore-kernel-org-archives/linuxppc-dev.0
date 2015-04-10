Return-Path: <aik@ozlabs.ru>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F25861A057D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 16:32:46 +1000 (AEST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Fri, 10 Apr 2015 16:32:46 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 68BE42BB005C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 16:32:43 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3A6WZN345023344
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 16:32:43 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3A6WA4g010091
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 16:32:10 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel v8 09/31] powerpc/powernv: Do not set "read" flag if
 direction==DMA_NONE
Date: Fri, 10 Apr 2015 16:30:51 +1000
Message-Id: <1428647473-11738-10-git-send-email-aik@ozlabs.ru>
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

Normally a bitmap from the iommu_table is used to track what TCE entry
is in use. Since we are going to use iommu_table without its locks and
do xchg() instead, it becomes essential not to put bits which are not
implied in the direction flag.

This adds iommu_direction_to_tce_perm() (its counterpart is there already)
and uses it for powernv's pnv_tce_build().

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/include/asm/iommu.h     |  1 +
 arch/powerpc/kernel/iommu.c          | 15 +++++++++++++++
 arch/powerpc/platforms/powernv/pci.c |  7 +------
 3 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/iommu.h
index ed69b7d..2af2d70 100644
--- a/arch/powerpc/include/asm/iommu.h
+++ b/arch/powerpc/include/asm/iommu.h
@@ -203,6 +203,7 @@ extern int iommu_take_ownership(struct iommu_table *tbl);
 extern void iommu_release_ownership(struct iommu_table *tbl);
 
 extern enum dma_data_direction iommu_tce_direction(unsigned long tce);
+extern unsigned long iommu_direction_to_tce_perm(enum dma_data_direction dir);
 
 #endif /* __KERNEL__ */
 #endif /* _ASM_IOMMU_H */
diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index 1b4a178..029b1ea 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -871,6 +871,21 @@ void iommu_free_coherent(struct iommu_table *tbl, size_t size,
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
index 54323d6..609f5b1 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -593,15 +593,10 @@ static int pnv_tce_build(struct iommu_table *tbl, long index, long npages,
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
2.0.0
