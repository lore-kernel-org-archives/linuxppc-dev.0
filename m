Return-Path: <aik@ozlabs.ru>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A03DD1A0D91
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2015 18:46:26 +1000 (AEST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Fri, 29 May 2015 18:46:25 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id DDB78357807A
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2015 18:46:22 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4T8kEg739190552
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2015 18:46:22 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4T8jmtM004831
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2015 18:45:50 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alex Williamson <alex.williamson@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH kernel v11 08/34] vfio: powerpc/spapr: Use it_page_size
Date: Fri, 29 May 2015 18:44:32 +1000
Message-Id: <1432889098-22924-9-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1432889098-22924-1-git-send-email-aik@ozlabs.ru>
References: <1432889098-22924-1-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This makes use of the it_page_size from the iommu_table struct
as page size can differ.

This replaces missing IOMMU_PAGE_SHIFT macro in commented debug code
as recently introduced IOMMU_PAGE_XXX macros do not include
IOMMU_PAGE_SHIFT.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
[aw: for the vfio related changes]
Acked-by: Alex Williamson <alex.williamson@redhat.com>
Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 drivers/vfio/vfio_iommu_spapr_tce.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
index 735b308..64300cc 100644
--- a/drivers/vfio/vfio_iommu_spapr_tce.c
+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
@@ -91,7 +91,7 @@ static int tce_iommu_enable(struct tce_container *container)
 	 * enforcing the limit based on the max that the guest can map.
 	 */
 	down_write(&current->mm->mmap_sem);
-	npages = (tbl->it_size << IOMMU_PAGE_SHIFT_4K) >> PAGE_SHIFT;
+	npages = (tbl->it_size << tbl->it_page_shift) >> PAGE_SHIFT;
 	locked = current->mm->locked_vm + npages;
 	lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
 	if (locked > lock_limit && !capable(CAP_IPC_LOCK)) {
@@ -120,7 +120,7 @@ static void tce_iommu_disable(struct tce_container *container)
 
 	down_write(&current->mm->mmap_sem);
 	current->mm->locked_vm -= (container->tbl->it_size <<
-			IOMMU_PAGE_SHIFT_4K) >> PAGE_SHIFT;
+			container->tbl->it_page_shift) >> PAGE_SHIFT;
 	up_write(&current->mm->mmap_sem);
 }
 
@@ -215,7 +215,7 @@ static long tce_iommu_build(struct tce_container *container,
 					tce, ret);
 			break;
 		}
-		tce += IOMMU_PAGE_SIZE_4K;
+		tce += IOMMU_PAGE_SIZE(tbl);
 	}
 
 	if (ret)
@@ -260,8 +260,8 @@ static long tce_iommu_ioctl(void *iommu_data,
 		if (info.argsz < minsz)
 			return -EINVAL;
 
-		info.dma32_window_start = tbl->it_offset << IOMMU_PAGE_SHIFT_4K;
-		info.dma32_window_size = tbl->it_size << IOMMU_PAGE_SHIFT_4K;
+		info.dma32_window_start = tbl->it_offset << tbl->it_page_shift;
+		info.dma32_window_size = tbl->it_size << tbl->it_page_shift;
 		info.flags = 0;
 
 		if (copy_to_user((void __user *)arg, &info, minsz))
@@ -291,8 +291,8 @@ static long tce_iommu_ioctl(void *iommu_data,
 				VFIO_DMA_MAP_FLAG_WRITE))
 			return -EINVAL;
 
-		if ((param.size & ~IOMMU_PAGE_MASK_4K) ||
-				(param.vaddr & ~IOMMU_PAGE_MASK_4K))
+		if ((param.size & ~IOMMU_PAGE_MASK(tbl)) ||
+				(param.vaddr & ~IOMMU_PAGE_MASK(tbl)))
 			return -EINVAL;
 
 		/* iova is checked by the IOMMU API */
@@ -307,8 +307,8 @@ static long tce_iommu_ioctl(void *iommu_data,
 			return ret;
 
 		ret = tce_iommu_build(container, tbl,
-				param.iova >> IOMMU_PAGE_SHIFT_4K,
-				tce, param.size >> IOMMU_PAGE_SHIFT_4K);
+				param.iova >> tbl->it_page_shift,
+				tce, param.size >> tbl->it_page_shift);
 
 		iommu_flush_tce(tbl);
 
@@ -334,17 +334,17 @@ static long tce_iommu_ioctl(void *iommu_data,
 		if (param.flags)
 			return -EINVAL;
 
-		if (param.size & ~IOMMU_PAGE_MASK_4K)
+		if (param.size & ~IOMMU_PAGE_MASK(tbl))
 			return -EINVAL;
 
 		ret = iommu_tce_clear_param_check(tbl, param.iova, 0,
-				param.size >> IOMMU_PAGE_SHIFT_4K);
+				param.size >> tbl->it_page_shift);
 		if (ret)
 			return ret;
 
 		ret = tce_iommu_clear(container, tbl,
-				param.iova >> IOMMU_PAGE_SHIFT_4K,
-				param.size >> IOMMU_PAGE_SHIFT_4K);
+				param.iova >> tbl->it_page_shift,
+				param.size >> tbl->it_page_shift);
 		iommu_flush_tce(tbl);
 
 		return ret;
-- 
2.4.0.rc3.8.gfb3e7d5
