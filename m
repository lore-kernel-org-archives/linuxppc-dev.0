Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (ozlabs.ru [83.169.36.222])
 by lists.ozlabs.org (Postfix) with ESMTP id 3tFfTH4syVzDvpJ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Nov 2016 23:33:07 +1100 (AEDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alex Williamson <alex.williamson@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Paul Mackerras <paulus@samba.org>, kvm@vger.kernel.org
Subject: [PATCH kernel v5 4/6] vfio/spapr: Postpone default window creation
Date: Fri, 11 Nov 2016 23:32:15 +1100
Message-Id: <1478867537-27893-5-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1478867537-27893-1-git-send-email-aik@ozlabs.ru>
References: <1478867537-27893-1-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

As mentioned in the previous patch, we are going to allow the userspace
to configure container in one memory context and pass container fd to
another so we are postponing memory allocations accounted against
the locked memory limit. The previous patch took care of it_userspace.

At the moment we create the default DMA window when the first group is
attached to a container; this is done for the userspace which is not
DDW-aware but familiar with the SPAPR TCE IOMMU v2 in the part of memory
pre-registration - such client expects the default DMA window to exist.

This postpones the default DMA window allocation till first map/unmap
request happens.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 drivers/vfio/vfio_iommu_spapr_tce.c | 98 ++++++++++++++++++-------------------
 1 file changed, 47 insertions(+), 51 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
index 442baac..1c02498 100644
--- a/drivers/vfio/vfio_iommu_spapr_tce.c
+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
@@ -97,6 +97,7 @@ struct tce_container {
 	struct mutex lock;
 	bool enabled;
 	bool v2;
+	bool def_window_pending;
 	unsigned long locked_pages;
 	struct iommu_table *tables[IOMMU_TABLE_GROUP_MAX_TABLES];
 	struct list_head group_list;
@@ -594,15 +595,6 @@ static long tce_iommu_create_table(struct tce_container *container,
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
 
@@ -719,6 +711,29 @@ static long tce_iommu_remove_window(struct tce_container *container,
 	return 0;
 }
 
+static long tce_iommu_create_default_window(struct tce_container *container)
+{
+	long ret;
+	__u64 start_addr = 0;
+	struct tce_iommu_group *tcegrp;
+	struct iommu_table_group *table_group;
+
+	if (!tce_groups_attached(container))
+		return -ENODEV;
+
+	tcegrp = list_first_entry(&container->group_list,
+			struct tce_iommu_group, next);
+	table_group = iommu_group_get_iommudata(tcegrp->grp);
+	if (!table_group)
+		return -ENODEV;
+
+	ret = tce_iommu_create_window(container, IOMMU_PAGE_SHIFT_4K,
+			table_group->tce32_size, 1, &start_addr);
+	WARN_ON_ONCE(!ret && start_addr);
+
+	return ret;
+}
+
 static long tce_iommu_ioctl(void *iommu_data,
 				 unsigned int cmd, unsigned long arg)
 {
@@ -809,6 +824,13 @@ static long tce_iommu_ioctl(void *iommu_data,
 				VFIO_DMA_MAP_FLAG_WRITE))
 			return -EINVAL;
 
+		if (container->def_window_pending) {
+			ret = tce_iommu_create_default_window(container);
+			if (ret)
+				return ret;
+			container->def_window_pending = false;
+		}
+
 		num = tce_iommu_find_table(container, param.iova, &tbl);
 		if (num < 0)
 			return -ENXIO;
@@ -872,6 +894,13 @@ static long tce_iommu_ioctl(void *iommu_data,
 		if (param.flags)
 			return -EINVAL;
 
+		if (container->def_window_pending) {
+			ret = tce_iommu_create_default_window(container);
+			if (ret)
+				return ret;
+			container->def_window_pending = false;
+		}
+
 		num = tce_iommu_find_table(container, param.iova, &tbl);
 		if (num < 0)
 			return -ENXIO;
@@ -998,6 +1027,8 @@ static long tce_iommu_ioctl(void *iommu_data,
 
 		mutex_lock(&container->lock);
 
+		container->def_window_pending = false;
+
 		ret = tce_iommu_create_window(container, create.page_shift,
 				create.window_size, create.levels,
 				&create.start_addr);
@@ -1030,6 +1061,12 @@ static long tce_iommu_ioctl(void *iommu_data,
 		if (remove.flags)
 			return -EINVAL;
 
+		if (container->def_window_pending && !remove.start_addr) {
+			container->def_window_pending = false;
+			return 0;
+		}
+		container->def_window_pending = false;
+
 		mutex_lock(&container->lock);
 
 		ret = tce_iommu_remove_window(container, remove.start_addr);
@@ -1109,9 +1146,6 @@ static void tce_iommu_release_ownership_ddw(struct tce_container *container,
 static long tce_iommu_take_ownership_ddw(struct tce_container *container,
 		struct iommu_table_group *table_group)
 {
-	long i, ret = 0;
-	struct iommu_table *tbl = NULL;
-
 	if (!table_group->ops->create_table || !table_group->ops->set_window ||
 			!table_group->ops->release_ownership) {
 		WARN_ON_ONCE(1);
@@ -1120,47 +1154,9 @@ static long tce_iommu_take_ownership_ddw(struct tce_container *container,
 
 	table_group->ops->take_ownership(table_group);
 
-	/*
-	 * If it the first group attached, check if there is
-	 * a default DMA window and create one if none as
-	 * the userspace expects it to exist.
-	 */
-	if (!tce_groups_attached(container) && !container->tables[0]) {
-		ret = tce_iommu_create_table(container,
-				table_group,
-				0, /* window number */
-				IOMMU_PAGE_SHIFT_4K,
-				table_group->tce32_size,
-				1, /* default levels */
-				&tbl);
-		if (ret)
-			goto release_exit;
-		else
-			container->tables[0] = tbl;
-	}
-
-	/* Set all windows to the new group */
-	for (i = 0; i < IOMMU_TABLE_GROUP_MAX_TABLES; ++i) {
-		tbl = container->tables[i];
-
-		if (!tbl)
-			continue;
-
-		/* Set the default window to a new group */
-		ret = table_group->ops->set_window(table_group, i, tbl);
-		if (ret)
-			goto release_exit;
-	}
+	container->def_window_pending = true;
 
 	return 0;
-
-release_exit:
-	for (i = 0; i < IOMMU_TABLE_GROUP_MAX_TABLES; ++i)
-		table_group->ops->unset_window(table_group, i);
-
-	table_group->ops->release_ownership(table_group);
-
-	return ret;
 }
 
 static int tce_iommu_attach_group(void *iommu_data,
-- 
2.5.0.rc3
