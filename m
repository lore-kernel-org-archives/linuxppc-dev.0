Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (ozlabs.ru [83.169.36.222])
 by lists.ozlabs.org (Postfix) with ESMTP id 3tPStW3BNTzDw6g
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Nov 2016 16:48:35 +1100 (AEDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alex Williamson <alex.williamson@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Nicholas Piggin <npiggin@gmail.com>, Paul Mackerras <paulus@samba.org>,
 kvm@vger.kernel.org
Subject: [PATCH kernel v6 5/7] vfio/spapr: Postpone default window creation
Date: Thu, 24 Nov 2016 16:48:08 +1100
Message-Id: <1479966490-8739-6-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1479966490-8739-1-git-send-email-aik@ozlabs.ru>
References: <1479966490-8739-1-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We are going to allow the userspace to configure container in
one memory context and pass container fd to another so
we are postponing memory allocations accounted against
the locked memory limit. One of previous patches took care of
it_userspace.

At the moment we create the default DMA window when the first group is
attached to a container; this is done for the userspace which is not
DDW-aware but familiar with the SPAPR TCE IOMMU v2 in the part of memory
pre-registration - such client expects the default DMA window to exist.

This postpones the default DMA window allocation till one of
the folliwing happens:
1. first map/unmap request arrives;
2. new window is requested;
This adds noop for the case when the userspace requested removal
of the default window which has not been created yet.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
Changes:
v6:
* new helper tce_iommu_create_default_window() moved to a separate patch;
* creates a default window when new window is requested; it used to
reset the def_window_pending flag instead;
* def_window_pending handling (mostly) localized in
tce_iommu_create_default_window() now, the only exception is removal
of not yet created default window.
---
 drivers/vfio/vfio_iommu_spapr_tce.c | 40 +++++++++++++++++++++++--------------
 1 file changed, 25 insertions(+), 15 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
index a67bbfd..88622be 100644
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
@@ -717,6 +718,9 @@ static long tce_iommu_create_default_window(struct tce_container *container)
 	struct tce_iommu_group *tcegrp;
 	struct iommu_table_group *table_group;
 
+	if (!container->def_window_pending)
+		return 0;
+
 	if (!tce_groups_attached(container))
 		return -ENODEV;
 
@@ -730,6 +734,9 @@ static long tce_iommu_create_default_window(struct tce_container *container)
 			table_group->tce32_size, 1, &start_addr);
 	WARN_ON_ONCE(!ret && start_addr);
 
+	if (!ret)
+		container->def_window_pending = false;
+
 	return ret;
 }
 
@@ -823,6 +830,10 @@ static long tce_iommu_ioctl(void *iommu_data,
 				VFIO_DMA_MAP_FLAG_WRITE))
 			return -EINVAL;
 
+		ret = tce_iommu_create_default_window(container);
+		if (ret)
+			return ret;
+
 		num = tce_iommu_find_table(container, param.iova, &tbl);
 		if (num < 0)
 			return -ENXIO;
@@ -886,6 +897,10 @@ static long tce_iommu_ioctl(void *iommu_data,
 		if (param.flags)
 			return -EINVAL;
 
+		ret = tce_iommu_create_default_window(container);
+		if (ret)
+			return ret;
+
 		num = tce_iommu_find_table(container, param.iova, &tbl);
 		if (num < 0)
 			return -ENXIO;
@@ -1012,6 +1027,10 @@ static long tce_iommu_ioctl(void *iommu_data,
 
 		mutex_lock(&container->lock);
 
+		ret = tce_iommu_create_default_window(container);
+		if (ret)
+			return ret;
+
 		ret = tce_iommu_create_window(container, create.page_shift,
 				create.window_size, create.levels,
 				&create.start_addr);
@@ -1044,6 +1063,11 @@ static long tce_iommu_ioctl(void *iommu_data,
 		if (remove.flags)
 			return -EINVAL;
 
+		if (container->def_window_pending && !remove.start_addr) {
+			container->def_window_pending = false;
+			return 0;
+		}
+
 		mutex_lock(&container->lock);
 
 		ret = tce_iommu_remove_window(container, remove.start_addr);
@@ -1141,7 +1165,6 @@ static int tce_iommu_attach_group(void *iommu_data,
 	struct tce_container *container = iommu_data;
 	struct iommu_table_group *table_group;
 	struct tce_iommu_group *tcegrp = NULL;
-	bool create_default_window = false;
 
 	mutex_lock(&container->lock);
 
@@ -1189,25 +1212,12 @@ static int tce_iommu_attach_group(void *iommu_data,
 	} else {
 		ret = tce_iommu_take_ownership_ddw(container, table_group);
 		if (!tce_groups_attached(container) && !container->tables[0])
-			create_default_window = true;
+			container->def_window_pending = true;
 	}
 
 	if (!ret) {
 		tcegrp->grp = iommu_group;
 		list_add(&tcegrp->next, &container->group_list);
-		/*
-		 * If it the first group attached, check if there is
-		 * a default DMA window and create one if none as
-		 * the userspace expects it to exist.
-		 */
-		if (create_default_window) {
-			ret = tce_iommu_create_default_window(container);
-			if (ret) {
-				list_del(&tcegrp->next);
-				tce_iommu_release_ownership_ddw(container,
-						table_group);
-			}
-		}
 	}
 
 unlock_exit:
-- 
2.5.0.rc3
