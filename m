Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (ozlabs.ru [83.169.36.222])
 by lists.ozlabs.org (Postfix) with ESMTP id 3tTB1N0FjZzDvsT
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Nov 2016 17:52:23 +1100 (AEDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alex Williamson <alex.williamson@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Paul Mackerras <paulus@samba.org>, kvm@vger.kernel.org
Subject: [PATCH kernel v7 4/7] vfio/spapr: Add a helper to create default DMA
 window
Date: Wed, 30 Nov 2016 17:52:02 +1100
Message-Id: <1480488725-12783-5-git-send-email-aik@ozlabs.ru>
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

There is already a helper to create a DMA window which does allocate
a table and programs it to the IOMMU group. However
tce_iommu_take_ownership_ddw() did not use it and did these 2 calls
itself to simplify error path.

Since we are going to delay the default window creation till
the default window is accessed/removed or new window is added,
we need a helper to create a default window from all these cases.

This adds tce_iommu_create_default_window(). Since it relies on
a VFIO container to have at least one IOMMU group (for future use),
this changes tce_iommu_attach_group() to add a group to the container
first and then call the new helper.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
---
Changes:
v6:
* new to the patchset
---
 drivers/vfio/vfio_iommu_spapr_tce.c | 87 ++++++++++++++++++-------------------
 1 file changed, 42 insertions(+), 45 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
index 4efd2b2..a67bbfd 100644
--- a/drivers/vfio/vfio_iommu_spapr_tce.c
+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
@@ -710,6 +710,29 @@ static long tce_iommu_remove_window(struct tce_container *container,
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
@@ -1100,9 +1123,6 @@ static void tce_iommu_release_ownership_ddw(struct tce_container *container,
 static long tce_iommu_take_ownership_ddw(struct tce_container *container,
 		struct iommu_table_group *table_group)
 {
-	long i, ret = 0;
-	struct iommu_table *tbl = NULL;
-
 	if (!table_group->ops->create_table || !table_group->ops->set_window ||
 			!table_group->ops->release_ownership) {
 		WARN_ON_ONCE(1);
@@ -1111,47 +1131,7 @@ static long tce_iommu_take_ownership_ddw(struct tce_container *container,
 
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
-
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
@@ -1161,6 +1141,7 @@ static int tce_iommu_attach_group(void *iommu_data,
 	struct tce_container *container = iommu_data;
 	struct iommu_table_group *table_group;
 	struct tce_iommu_group *tcegrp = NULL;
+	bool create_default_window = false;
 
 	mutex_lock(&container->lock);
 
@@ -1203,14 +1184,30 @@ static int tce_iommu_attach_group(void *iommu_data,
 	}
 
 	if (!table_group->ops || !table_group->ops->take_ownership ||
-			!table_group->ops->release_ownership)
+			!table_group->ops->release_ownership) {
 		ret = tce_iommu_take_ownership(container, table_group);
-	else
+	} else {
 		ret = tce_iommu_take_ownership_ddw(container, table_group);
+		if (!tce_groups_attached(container) && !container->tables[0])
+			create_default_window = true;
+	}
 
 	if (!ret) {
 		tcegrp->grp = iommu_group;
 		list_add(&tcegrp->next, &container->group_list);
+		/*
+		 * If it the first group attached, check if there is
+		 * a default DMA window and create one if none as
+		 * the userspace expects it to exist.
+		 */
+		if (create_default_window) {
+			ret = tce_iommu_create_default_window(container);
+			if (ret) {
+				list_del(&tcegrp->next);
+				tce_iommu_release_ownership_ddw(container,
+						table_group);
+			}
+		}
 	}
 
 unlock_exit:
-- 
2.5.0.rc3
