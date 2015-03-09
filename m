Return-Path: <aik@ozlabs.ru>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B245A1A0292
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2015 01:08:30 +1100 (AEDT)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Tue, 10 Mar 2015 00:08:28 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id AA9A72BB0055
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2015 01:08:26 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t29E8IH648627952
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2015 01:08:26 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t29E7rlB013483
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2015 01:07:53 +1100
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v5 04/29] vfio: powerpc/spapr: Use it_page_size
Date: Tue, 10 Mar 2015 01:07:00 +1100
Message-Id: <1425910045-26167-5-git-send-email-aik@ozlabs.ru>
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

This makes use of the it_page_size from the iommu_table struct
as page size can differ.

This replaces missing IOMMU_PAGE_SHIFT macro in commented debug code
as recently introduced IOMMU_PAGE_XXX macros do not include
IOMMU_PAGE_SHIFT.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
---
 drivers/vfio/vfio_iommu_spapr_tce.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
index 91e7599..0e37400 100644
--- a/drivers/vfio/vfio_iommu_spapr_tce.c
+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
@@ -99,7 +99,7 @@ static int tce_iommu_enable(struct tce_container *container)
 	 * enforcing the limit based on the max that the guest can map.
 	 */
 	down_write(&current->mm->mmap_sem);
-	npages = (tbl->it_size << IOMMU_PAGE_SHIFT_4K) >> PAGE_SHIFT;
+	npages = (tbl->it_size << tbl->it_page_shift) >> PAGE_SHIFT;
 	locked = current->mm->locked_vm + npages;
 	lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
 	if (locked > lock_limit && !capable(CAP_IPC_LOCK)) {
@@ -128,7 +128,7 @@ static void tce_iommu_disable(struct tce_container *container)
 
 	down_write(&current->mm->mmap_sem);
 	current->mm->locked_vm -= (container->tbl->it_size <<
-			IOMMU_PAGE_SHIFT_4K) >> PAGE_SHIFT;
+			container->tbl->it_page_shift) >> PAGE_SHIFT;
 	up_write(&current->mm->mmap_sem);
 }
 
@@ -230,7 +230,7 @@ static long tce_iommu_build(struct tce_container *container,
 					tce, ret);
 			break;
 		}
-		tce += IOMMU_PAGE_SIZE_4K;
+		tce += IOMMU_PAGE_SIZE(tbl);
 	}
 
 	if (ret)
@@ -275,8 +275,8 @@ static long tce_iommu_ioctl(void *iommu_data,
 		if (info.argsz < minsz)
 			return -EINVAL;
 
-		info.dma32_window_start = tbl->it_offset << IOMMU_PAGE_SHIFT_4K;
-		info.dma32_window_size = tbl->it_size << IOMMU_PAGE_SHIFT_4K;
+		info.dma32_window_start = tbl->it_offset << tbl->it_page_shift;
+		info.dma32_window_size = tbl->it_size << tbl->it_page_shift;
 		info.flags = 0;
 
 		if (copy_to_user((void __user *)arg, &info, minsz))
@@ -306,8 +306,8 @@ static long tce_iommu_ioctl(void *iommu_data,
 				VFIO_DMA_MAP_FLAG_WRITE))
 			return -EINVAL;
 
-		if ((param.size & ~IOMMU_PAGE_MASK_4K) ||
-				(param.vaddr & ~IOMMU_PAGE_MASK_4K))
+		if ((param.size & ~IOMMU_PAGE_MASK(tbl)) ||
+				(param.vaddr & ~IOMMU_PAGE_MASK(tbl)))
 			return -EINVAL;
 
 		/* iova is checked by the IOMMU API */
@@ -322,8 +322,8 @@ static long tce_iommu_ioctl(void *iommu_data,
 			return ret;
 
 		ret = tce_iommu_build(container, tbl,
-				param.iova >> IOMMU_PAGE_SHIFT_4K,
-				tce, param.size >> IOMMU_PAGE_SHIFT_4K);
+				param.iova >> tbl->it_page_shift,
+				tce, param.size >> tbl->it_page_shift);
 
 		iommu_flush_tce(tbl);
 
@@ -349,17 +349,17 @@ static long tce_iommu_ioctl(void *iommu_data,
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
2.0.0
