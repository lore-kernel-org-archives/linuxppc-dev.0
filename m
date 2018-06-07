Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (unknown [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 411fHc3JryzF32f
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jun 2018 18:45:00 +1000 (AEST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>, kvm-ppc@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Ram Pai <linuxram@us.ibm.com>, kvm@vger.kernel.org,
 Alistair Popple <alistair@popple.id.au>
Subject: [RFC PATCH kernel 1/5] vfio/spapr_tce: Simplify page contained test
Date: Thu,  7 Jun 2018 18:44:16 +1000
Message-Id: <20180607084420.29513-2-aik@ozlabs.ru>
In-Reply-To: <20180607084420.29513-1-aik@ozlabs.ru>
References: <20180607084420.29513-1-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The test function takes a page struct pointer which is not used by
either of two callers in any other way, make it simple and just pass
a physical address there.

This should cause no behavioral change now but later we may start
supporting host addresses for memory devices which are not backed
with page structs.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 drivers/vfio/vfio_iommu_spapr_tce.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
index 759a5bd..2c4a048 100644
--- a/drivers/vfio/vfio_iommu_spapr_tce.c
+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
@@ -249,8 +249,9 @@ static void tce_iommu_userspace_view_free(struct iommu_table *tbl,
 	decrement_locked_vm(mm, cb >> PAGE_SHIFT);
 }
 
-static bool tce_page_is_contained(struct page *page, unsigned page_shift)
+static bool tce_page_is_contained(unsigned long hpa, unsigned page_shift)
 {
+	struct page *page = pfn_to_page(hpa >> PAGE_SHIFT);
 	/*
 	 * Check that the TCE table granularity is not bigger than the size of
 	 * a page we just found. Otherwise the hardware can get access to
@@ -549,7 +550,6 @@ static long tce_iommu_build(struct tce_container *container,
 		enum dma_data_direction direction)
 {
 	long i, ret = 0;
-	struct page *page;
 	unsigned long hpa;
 	enum dma_data_direction dirtmp;
 
@@ -560,8 +560,7 @@ static long tce_iommu_build(struct tce_container *container,
 		if (ret)
 			break;
 
-		page = pfn_to_page(hpa >> PAGE_SHIFT);
-		if (!tce_page_is_contained(page, tbl->it_page_shift)) {
+		if (!tce_page_is_contained(hpa, tbl->it_page_shift)) {
 			ret = -EPERM;
 			break;
 		}
@@ -595,7 +594,6 @@ static long tce_iommu_build_v2(struct tce_container *container,
 		enum dma_data_direction direction)
 {
 	long i, ret = 0;
-	struct page *page;
 	unsigned long hpa;
 	enum dma_data_direction dirtmp;
 
@@ -615,8 +613,7 @@ static long tce_iommu_build_v2(struct tce_container *container,
 		if (ret)
 			break;
 
-		page = pfn_to_page(hpa >> PAGE_SHIFT);
-		if (!tce_page_is_contained(page, tbl->it_page_shift)) {
+		if (!tce_page_is_contained(hpa, tbl->it_page_shift)) {
 			ret = -EPERM;
 			break;
 		}
-- 
2.11.0
