Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (ozlabs.ru [83.169.36.222])
 by lists.ozlabs.org (Postfix) with ESMTP id 3vHZBv1jNhzDqBN
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Feb 2017 17:27:35 +1100 (AEDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>,
 Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org
Subject: [PATCH kernel] vfio/spapr_tce: Set window when adding additional
 groups to container
Date: Tue,  7 Feb 2017 17:26:57 +1100
Message-Id: <20170207062657.21606-1-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If a container already has a group attached, attaching a new group
should just program already created IOMMU tables to the hardware via
the iommu_table_group_ops::set_window() callback.

However 6f01cc692 "vfio/spapr: Add a helper to create default DMA window"
did not just simplify the code but also removed the set_window() calls
in the case of attaching groups to a container which already has tables
so it broke VFIO PCI hotplug.

This reverts set_window() bits in tce_iommu_take_ownership_ddw().

Fixes: 6f01cc692
Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 drivers/vfio/vfio_iommu_spapr_tce.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
index 7690e5bf3cf1..14c62a8495a2 100644
--- a/drivers/vfio/vfio_iommu_spapr_tce.c
+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
@@ -1245,6 +1245,8 @@ static void tce_iommu_release_ownership_ddw(struct tce_container *container,
 static long tce_iommu_take_ownership_ddw(struct tce_container *container,
 		struct iommu_table_group *table_group)
 {
+	long i, ret = 0;
+
 	if (!table_group->ops->create_table || !table_group->ops->set_window ||
 			!table_group->ops->release_ownership) {
 		WARN_ON_ONCE(1);
@@ -1253,7 +1255,26 @@ static long tce_iommu_take_ownership_ddw(struct tce_container *container,
 
 	table_group->ops->take_ownership(table_group);
 
+	/* Set all windows to the new group */
+	for (i = 0; i < IOMMU_TABLE_GROUP_MAX_TABLES; ++i) {
+		struct iommu_table *tbl = container->tables[i];
+		if (!tbl)
+			continue;
+
+		ret = table_group->ops->set_window(table_group, i, tbl);
+		if (ret)
+			goto release_exit;
+	}
+
 	return 0;
+
+release_exit:
+	for (i = 0; i < IOMMU_TABLE_GROUP_MAX_TABLES; ++i)
+		table_group->ops->unset_window(table_group, i);
+
+	table_group->ops->release_ownership(table_group);
+
+	return ret;
 }
 
 static int tce_iommu_attach_group(void *iommu_data,
-- 
2.11.0
