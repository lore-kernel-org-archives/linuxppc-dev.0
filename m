Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (ozlabs.ru [83.169.36.222])
 by lists.ozlabs.org (Postfix) with ESMTP id 3tTB1K2R5dzDt0R
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Nov 2016 17:52:21 +1100 (AEDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alex Williamson <alex.williamson@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Paul Mackerras <paulus@samba.org>, kvm@vger.kernel.org
Subject: [PATCH kernel v7 3/7] vfio/spapr: Postpone allocation of userspace
 version of TCE table
Date: Wed, 30 Nov 2016 17:52:01 +1100
Message-Id: <1480488725-12783-4-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1480488725-12783-1-git-send-email-aik@ozlabs.ru>
References: <1480488725-12783-1-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The iommu_table struct manages a hardware TCE table and a vmalloc'd
table with corresponding userspace addresses. Both are allocated when
the default DMA window is created and this happens when the very first
group is attached to a container.

As we are going to allow the userspace to configure container in one
memory context and pas container fd to another, we have to postpones
such allocations till a container fd is passed to the destination
user process so we would account locked memory limit against the actual
container user constrainsts.

This postpones the it_userspace array allocation till it is used first
time for mapping. The unmapping patch already checks if the array is
allocated.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
---
Changes:
v6:
* moved missing hunk from the next patch: tce_iommu_create_table()
would decrement locked_vm while new caller - tce_iommu_build_v2() -
will not; this adds a new return code to the DMA mapping path but
this seems to be a minor change.
---
 drivers/vfio/vfio_iommu_spapr_tce.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
index d0c38b2..4efd2b2 100644
--- a/drivers/vfio/vfio_iommu_spapr_tce.c
+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
@@ -515,6 +515,12 @@ static long tce_iommu_build_v2(struct tce_container *container,
 	unsigned long hpa;
 	enum dma_data_direction dirtmp;
 
+	if (!tbl->it_userspace) {
+		ret = tce_iommu_userspace_view_alloc(tbl);
+		if (ret)
+			return ret;
+	}
+
 	for (i = 0; i < pages; ++i) {
 		struct mm_iommu_table_group_mem_t *mem = NULL;
 		unsigned long *pua = IOMMU_TABLE_USERSPACE_ENTRY(tbl,
@@ -588,15 +594,6 @@ static long tce_iommu_create_table(struct tce_container *container,
 	WARN_ON(!ret && !(*ptbl)->it_ops->free);
 	WARN_ON(!ret && ((*ptbl)->it_allocated_size != table_size));
 
-	if (!ret && container->v2) {
-		ret = tce_iommu_userspace_view_alloc(*ptbl);
-		if (ret)
-			(*ptbl)->it_ops->free(*ptbl);
-	}
-
-	if (ret)
-		decrement_locked_vm(table_size >> PAGE_SHIFT);
-
 	return ret;
 }
 
@@ -1068,10 +1065,7 @@ static int tce_iommu_take_ownership(struct tce_container *container,
 		if (!tbl || !tbl->it_map)
 			continue;
 
-		rc = tce_iommu_userspace_view_alloc(tbl);
-		if (!rc)
-			rc = iommu_take_ownership(tbl);
-
+		rc = iommu_take_ownership(tbl);
 		if (rc) {
 			for (j = 0; j < i; ++j)
 				iommu_release_ownership(
-- 
2.5.0.rc3
