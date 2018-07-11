Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (unknown [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 41Qbhk6RCCzF35J
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jul 2018 21:00:53 +1000 (AEST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>, kvm-ppc@vger.kernel.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Paul Mackerras <paulus@ozlabs.org>, Balbir Singh <bsingharora@gmail.com>
Subject: [PATCH kernel v6 1/2] vfio/spapr: Use IOMMU pageshift rather than
 pagesize
Date: Wed, 11 Jul 2018 21:00:43 +1000
Message-Id: <20180711110044.15939-2-aik@ozlabs.ru>
In-Reply-To: <20180711110044.15939-1-aik@ozlabs.ru>
References: <20180711110044.15939-1-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The size is always equal to 1 page so let's use this. Later on this will
be used for other checks which use page shifts to check the granularity
of access.

This should cause no behavioral change.

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Acked-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---

As Alex suggested, this should go via the ppc tree which the next patch
is going to (which is ppc-kvm).
---
 drivers/vfio/vfio_iommu_spapr_tce.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
index 759a5bd..2da5f05 100644
--- a/drivers/vfio/vfio_iommu_spapr_tce.c
+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
@@ -457,13 +457,13 @@ static void tce_iommu_unuse_page(struct tce_container *container,
 }
 
 static int tce_iommu_prereg_ua_to_hpa(struct tce_container *container,
-		unsigned long tce, unsigned long size,
+		unsigned long tce, unsigned long shift,
 		unsigned long *phpa, struct mm_iommu_table_group_mem_t **pmem)
 {
 	long ret = 0;
 	struct mm_iommu_table_group_mem_t *mem;
 
-	mem = mm_iommu_lookup(container->mm, tce, size);
+	mem = mm_iommu_lookup(container->mm, tce, 1ULL << shift);
 	if (!mem)
 		return -EINVAL;
 
@@ -487,7 +487,7 @@ static void tce_iommu_unuse_page_v2(struct tce_container *container,
 	if (!pua)
 		return;
 
-	ret = tce_iommu_prereg_ua_to_hpa(container, *pua, IOMMU_PAGE_SIZE(tbl),
+	ret = tce_iommu_prereg_ua_to_hpa(container, *pua, tbl->it_page_shift,
 			&hpa, &mem);
 	if (ret)
 		pr_debug("%s: tce %lx at #%lx was not cached, ret=%d\n",
@@ -611,7 +611,7 @@ static long tce_iommu_build_v2(struct tce_container *container,
 				entry + i);
 
 		ret = tce_iommu_prereg_ua_to_hpa(container,
-				tce, IOMMU_PAGE_SIZE(tbl), &hpa, &mem);
+				tce, tbl->it_page_shift, &hpa, &mem);
 		if (ret)
 			break;
 
-- 
2.11.0
