Return-Path: <aik@ozlabs.ru>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AA7F31A088A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2015 01:09:17 +1100 (AEDT)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Tue, 10 Mar 2015 00:09:16 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 06AFC3578054
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2015 01:09:13 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t29E94hV44433432
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2015 01:09:13 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t29E8dlh022726
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2015 01:08:39 +1100
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v5 28/29] vfio: powerpc/spapr: Support multiple groups in one
 container if possible
Date: Tue, 10 Mar 2015 01:07:24 +1100
Message-Id: <1425910045-26167-29-git-send-email-aik@ozlabs.ru>
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

At the moment only one group per container is supported.
POWER8 CPUs have more flexible design and allows naving 2 TCE tables per
IOMMU group so we can relax this limitation and support multiple groups
per container.

This adds TCE table descriptors to a container and uses iommu_table_group_ops
to create/set DMA windows on IOMMU groups so the same TCE tables will be
shared between several IOMMU groups.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 drivers/vfio/vfio_iommu_spapr_tce.c | 252 ++++++++++++++++++++++++------------
 1 file changed, 170 insertions(+), 82 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
index 3bc0645..3a0b5fe 100644
--- a/drivers/vfio/vfio_iommu_spapr_tce.c
+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
@@ -91,10 +91,16 @@ static void decrement_locked_vm(long npages)
  */
 struct tce_container {
 	struct mutex lock;
-	struct iommu_group *grp;
 	bool enabled;
 	unsigned long locked_pages;
 	struct list_head mem_list;
+	struct iommu_table tables[IOMMU_TABLE_GROUP_MAX_TABLES];
+	struct list_head group_list;
+};
+
+struct tce_iommu_group {
+	struct list_head next;
+	struct iommu_group *grp;
 };
 
 struct tce_memory {
@@ -300,20 +306,20 @@ static bool tce_page_is_contained(struct page *page, unsigned page_shift)
 	return false;
 }
 
+static inline bool tce_groups_attached(struct tce_container *container)
+{
+	return !list_empty(&container->group_list);
+}
+
 static struct iommu_table *spapr_tce_find_table(
 		struct tce_container *container,
 		phys_addr_t ioba)
 {
 	long i;
 	struct iommu_table *ret = NULL;
-	struct iommu_table_group *table_group;
-
-	table_group = iommu_group_get_iommudata(container->grp);
-	if (!table_group)
-		return NULL;
 
 	for (i = 0; i < IOMMU_TABLE_GROUP_MAX_TABLES; ++i) {
-		struct iommu_table *tbl = &table_group->tables[i];
+		struct iommu_table *tbl = &container->tables[i];
 		unsigned long entry = ioba >> tbl->it_page_shift;
 		unsigned long start = tbl->it_offset;
 		unsigned long end = start + tbl->it_size;
@@ -331,11 +337,8 @@ static int tce_iommu_enable(struct tce_container *container)
 {
 	int ret = 0;
 	unsigned long locked;
-	struct iommu_table *tbl;
 	struct iommu_table_group *table_group;
-
-	if (!container->grp)
-		return -ENXIO;
+	struct tce_iommu_group *tcegrp;
 
 	if (!current->mm)
 		return -ESRCH; /* process exited */
@@ -369,12 +372,24 @@ static int tce_iommu_enable(struct tce_container *container)
 	 * KVM agnostic.
 	 */
 	if (!tce_preregistered(container)) {
-		table_group = iommu_group_get_iommudata(container->grp);
+		if (!tce_groups_attached(container))
+			return -ENODEV;
+
+		tcegrp = list_first_entry(&container->group_list,
+				struct tce_iommu_group, next);
+		table_group = iommu_group_get_iommudata(tcegrp->grp);
 		if (!table_group)
 			return -ENODEV;
 
-		tbl = &table_group->tables[0];
-		locked = (tbl->it_size << tbl->it_page_shift) >> PAGE_SHIFT;
+		/*
+		 * We do not allow enabling a group if no DMA-able memory was
+		 * registered as there is no way to know how much we should
+		 * increment the locked_vm counter.
+		 */
+		if (!table_group->tce32_size)
+			return -EPERM;
+
+		locked = table_group->tce32_size >> PAGE_SHIFT;
 		ret = try_increment_locked_vm(locked);
 		if (ret)
 			return ret;
@@ -415,6 +430,7 @@ static void *tce_iommu_open(unsigned long arg)
 
 	mutex_init(&container->lock);
 	INIT_LIST_HEAD_RCU(&container->mem_list);
+	INIT_LIST_HEAD_RCU(&container->group_list);
 
 	return container;
 }
@@ -426,11 +442,30 @@ static int tce_iommu_clear(struct tce_container *container,
 static void tce_iommu_release(void *iommu_data)
 {
 	struct tce_container *container = iommu_data;
+	struct iommu_table_group *table_group;
+	int i;
+	struct tce_iommu_group *tcegrp;
 
-	WARN_ON(container->grp);
+	while (tce_groups_attached(container)) {
+		tcegrp = list_first_entry(&container->group_list,
+				struct tce_iommu_group, next);
+		table_group = iommu_group_get_iommudata(tcegrp->grp);
+		tce_iommu_detach_group(iommu_data, tcegrp->grp);
+	}
 
-	if (container->grp)
-		tce_iommu_detach_group(iommu_data, container->grp);
+	/* Free tables */
+	for (i = 0; i < IOMMU_TABLE_GROUP_MAX_TABLES; ++i) {
+		struct iommu_table *tbl = &container->tables[i];
+
+		if (!tbl->it_size)
+			continue;
+
+		tce_iommu_clear(container, tbl,
+				tbl->it_offset, tbl->it_size);
+
+		if (tbl->it_ops && tbl->it_ops->free)
+			tbl->it_ops->free(tbl);
+	}
 
 	tce_mem_unregister_all(container);
 	tce_iommu_disable(container);
@@ -593,16 +628,17 @@ static long tce_iommu_ioctl(void *iommu_data,
 
 	case VFIO_IOMMU_SPAPR_TCE_GET_INFO: {
 		struct vfio_iommu_spapr_tce_info info;
-		struct iommu_table *tbl;
+		struct tce_iommu_group *tcegrp;
 		struct iommu_table_group *table_group;
 
-		if (WARN_ON(!container->grp))
+		if (!tce_groups_attached(container))
 			return -ENXIO;
 
-		table_group = iommu_group_get_iommudata(container->grp);
+		tcegrp = list_first_entry(&container->group_list,
+				struct tce_iommu_group, next);
+		table_group = iommu_group_get_iommudata(tcegrp->grp);
 
-		tbl = &table_group->tables[0];
-		if (WARN_ON_ONCE(!tbl))
+		if (!table_group)
 			return -ENXIO;
 
 		minsz = offsetofend(struct vfio_iommu_spapr_tce_info,
@@ -614,9 +650,8 @@ static long tce_iommu_ioctl(void *iommu_data,
 		if (info.argsz < minsz)
 			return -EINVAL;
 
-		info.dma32_window_start = tbl->it_offset << tbl->it_page_shift;
-		info.dma32_window_size = tbl->it_size << tbl->it_page_shift;
-		info.flags = 0;
+		info.dma32_window_start = table_group->tce32_start;
+		info.dma32_window_size = table_group->tce32_size;
 
 		if (copy_to_user((void __user *)arg, &info, minsz))
 			return -EFAULT;
@@ -774,12 +809,20 @@ static long tce_iommu_ioctl(void *iommu_data,
 		tce_iommu_disable(container);
 		mutex_unlock(&container->lock);
 		return 0;
-	case VFIO_EEH_PE_OP:
-		if (!container->grp)
-			return -ENODEV;
 
-		return vfio_spapr_iommu_eeh_ioctl(container->grp,
-						  cmd, arg);
+	case VFIO_EEH_PE_OP: {
+		struct tce_iommu_group *tcegrp;
+
+		ret = 0;
+		list_for_each_entry(tcegrp, &container->group_list, next) {
+			ret = vfio_spapr_iommu_eeh_ioctl(tcegrp->grp,
+					cmd, arg);
+			if (ret)
+				return ret;
+		}
+		return ret;
+	}
+
 	}
 
 	return -ENOTTY;
@@ -788,63 +831,111 @@ static long tce_iommu_ioctl(void *iommu_data,
 static int tce_iommu_attach_group(void *iommu_data,
 		struct iommu_group *iommu_group)
 {
-	int ret;
+	int ret, i;
 	struct tce_container *container = iommu_data;
 	struct iommu_table_group *table_group;
+	struct tce_iommu_group *tcegrp = NULL;
+	bool first_group = !tce_groups_attached(container);
 
 	mutex_lock(&container->lock);
 
 	/* pr_debug("tce_vfio: Attaching group #%u to iommu %p\n",
 			iommu_group_id(iommu_group), iommu_group); */
-	if (container->grp) {
-		pr_warn("tce_vfio: Only one group per IOMMU container is allowed, existing id=%d, attaching id=%d\n",
-				iommu_group_id(container->grp),
-				iommu_group_id(iommu_group));
-		ret = -EBUSY;
-		goto unlock_exit;
-	}
-
-	if (container->enabled) {
-		pr_err("tce_vfio: attaching group #%u to enabled container\n",
-				iommu_group_id(iommu_group));
-		ret = -EBUSY;
-		goto unlock_exit;
-	}
-
 	table_group = iommu_group_get_iommudata(iommu_group);
-	if (!table_group) {
-		ret = -ENXIO;
+
+	if (!first_group && (!table_group->ops ||
+			!table_group->ops->set_ownership)) {
+		ret = -EBUSY;
+		goto unlock_exit;
+	}
+
+	/* Check if new group has the same iommu_ops (i.e. compatible) */
+	list_for_each_entry(tcegrp, &container->group_list, next) {
+		struct iommu_table_group *table_group_tmp;
+
+		if (tcegrp->grp == iommu_group) {
+			pr_warn("tce_vfio: Group %d is already attached\n",
+					iommu_group_id(iommu_group));
+			ret = -EBUSY;
+			goto unlock_exit;
+		}
+		table_group_tmp = iommu_group_get_iommudata(tcegrp->grp);
+		if (table_group_tmp->ops != table_group->ops) {
+			pr_warn("tce_vfio: Group %d is incompatible with group %d\n",
+					iommu_group_id(iommu_group),
+					iommu_group_id(tcegrp->grp));
+			ret = -EPERM;
+			goto unlock_exit;
+		}
+	}
+
+	tcegrp = kzalloc(sizeof(*tcegrp), GFP_KERNEL);
+	if (!tcegrp) {
+		ret = -ENOMEM;
 		goto unlock_exit;
 	}
 
 	if (!table_group->ops || !table_group->ops->set_ownership) {
 		ret = iommu_take_ownership(table_group);
+		if (!ret)
+			container->tables[0] = table_group->tables[0];
 	} else if (!table_group->ops->create_table ||
 			!table_group->ops->set_window) {
 		WARN_ON_ONCE(1);
 		ret = -EFAULT;
 	} else {
-		/*
-		 * Disable iommu bypass, otherwise the user can DMA to all of
-		 * our physical memory via the bypass window instead of just
-		 * the pages that has been explicitly mapped into the iommu
-		 */
-		struct iommu_table tbltmp = { 0 }, *tbl = &tbltmp;
-
 		table_group->ops->set_ownership(table_group, true);
-		ret = table_group->ops->create_table(table_group, 0,
-				IOMMU_PAGE_SHIFT_4K,
-				table_group->tce32_size, 1, tbl);
-		if (!ret)
-			ret = table_group->ops->set_window(table_group, 0, tbl);
+		/*
+		 * If it the first group attached, check if there is any window
+		 * created and create one if none.
+		 */
+		if (first_group) {
+			bool found = false;
+
+			for (i = 0; i < IOMMU_TABLE_GROUP_MAX_TABLES; ++i) {
+				if (!container->tables[i].it_size)
+					continue;
+
+				found = true;
+				break;
+			}
+			if (!found) {
+				struct iommu_table *tbl = &container->tables[0];
+
+				ret = table_group->ops->create_table(
+						table_group, 0,
+						IOMMU_PAGE_SHIFT_4K,
+						table_group->tce32_size, 1,
+						tbl);
+				if (ret)
+					goto unlock_exit;
+			}
+		}
+
+		/* Set all windows to the new group */
+		for (i = 0; i < IOMMU_TABLE_GROUP_MAX_TABLES; ++i) {
+			struct iommu_table *tbl = &container->tables[i];
+
+			if (!tbl->it_size)
+				continue;
+
+			/* Set the default window to a new group */
+			ret = table_group->ops->set_window(table_group, i, tbl);
+			if (ret)
+				break;
+		}
 	}
 
 	if (ret)
 		goto unlock_exit;
 
-	container->grp = iommu_group;
+	tcegrp->grp = iommu_group;
+	list_add(&tcegrp->next, &container->group_list);
 
 unlock_exit:
+	if (ret && tcegrp)
+		kfree(tcegrp);
+
 	mutex_unlock(&container->lock);
 
 	return ret;
@@ -855,25 +946,27 @@ static void tce_iommu_detach_group(void *iommu_data,
 {
 	struct tce_container *container = iommu_data;
 	struct iommu_table_group *table_group;
+	struct tce_iommu_group *tcegrp, *tcetmp;
 	long i;
+	bool found = false;
 
 	mutex_lock(&container->lock);
-	if (iommu_group != container->grp) {
-		pr_warn("tce_vfio: detaching group #%u, expected group is #%u\n",
-				iommu_group_id(iommu_group),
-				iommu_group_id(container->grp));
+
+	list_for_each_entry_safe(tcegrp, tcetmp, &container->group_list, next) {
+		if (tcegrp->grp != iommu_group)
+			continue;
+		found = true;
+		break;
+	}
+
+	if (!found) {
+		pr_warn("tce_vfio: detaching unattached group #%u\n",
+				iommu_group_id(iommu_group));
 		goto unlock_exit;
 	}
 
-	if (container->enabled) {
-		pr_warn("tce_vfio: detaching group #%u from enabled container, forcing disable\n",
-				iommu_group_id(container->grp));
-		tce_iommu_disable(container);
-	}
-
-	/* pr_debug("tce_vfio: detaching group #%u from iommu %p\n",
-	   iommu_group_id(iommu_group), iommu_group); */
-	container->grp = NULL;
+	list_del(&tcegrp->next);
+	kfree(tcegrp);
 
 	table_group = iommu_group_get_iommudata(iommu_group);
 	BUG_ON(!table_group);
@@ -881,7 +974,7 @@ static void tce_iommu_detach_group(void *iommu_data,
 	/* Kernel owns the device now, we can restore bypass */
 	if (!table_group->ops || !table_group->ops->set_ownership) {
 		for (i = 0; i < IOMMU_TABLE_GROUP_MAX_TABLES; ++i) {
-			struct iommu_table *tbl = &table_group->tables[i];
+			struct iommu_table *tbl = &container->tables[i];
 
 			if (!tbl->it_size)
 				continue;
@@ -890,20 +983,15 @@ static void tce_iommu_detach_group(void *iommu_data,
 				goto unlock_exit;
 			tce_iommu_clear(container, tbl,
 					tbl->it_offset, tbl->it_size);
+
+			memset(tbl, 0, sizeof(*tbl));
 		}
 		iommu_release_ownership(table_group);
 	} else if (!table_group->ops->unset_window) {
 		WARN_ON_ONCE(1);
 	} else {
 		for (i = 0; i < IOMMU_TABLE_GROUP_MAX_TABLES; ++i) {
-			struct iommu_table *tbl = &table_group->tables[i];
-
 			table_group->ops->unset_window(table_group, i);
-			tce_iommu_clear(container, tbl,
-					tbl->it_offset, tbl->it_size);
-
-			if (tbl->it_ops->free)
-				tbl->it_ops->free(tbl);
 		}
 
 		table_group->ops->set_ownership(table_group, false);
-- 
2.0.0
