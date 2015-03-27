Return-Path: <aik@ozlabs.ru>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 409B61A08D7
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Mar 2015 01:57:19 +1100 (AEDT)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Sat, 28 Mar 2015 00:57:19 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 4820C2BB0061
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Mar 2015 01:57:17 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2REv9GZ44433460
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Mar 2015 01:57:17 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2REuhkG031476
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Mar 2015 01:56:44 +1100
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel v7 30/31] vfio: powerpc/spapr: Support multiple groups
 in one container if possible
Date: Sat, 28 Mar 2015 01:55:14 +1100
Message-Id: <1427468115-2224-31-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1427468115-2224-1-git-send-email-aik@ozlabs.ru>
References: <1427468115-2224-1-git-send-email-aik@ozlabs.ru>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
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
Changes:
v7:
* updated doc
---
 Documentation/vfio.txt              |   8 +-
 drivers/vfio/vfio_iommu_spapr_tce.c | 289 ++++++++++++++++++++++++++----------
 2 files changed, 214 insertions(+), 83 deletions(-)

diff --git a/Documentation/vfio.txt b/Documentation/vfio.txt
index 94328c8..7dcf2b5 100644
--- a/Documentation/vfio.txt
+++ b/Documentation/vfio.txt
@@ -289,10 +289,12 @@ PPC64 sPAPR implementation note
 
 This implementation has some specifics:
 
-1) Only one IOMMU group per container is supported as an IOMMU group
-represents the minimal entity which isolation can be guaranteed for and
-groups are allocated statically, one per a Partitionable Endpoint (PE)
+1) On older systems (POWER7 with P5IOC2/IODA1) only one IOMMU group per
+container is supported as an IOMMU table is allocated at the boot time,
+one table per a IOMMU group which is a Partitionable Endpoint (PE)
 (PE is often a PCI domain but not always).
+Newer systems (POWER8 with IODA2) have improved hardware design which allows
+to remove this limitation and have multiple IOMMU groups per a VFIO container.
 
 2) The hardware supports so called DMA windows - the PCI address range
 within which DMA transfer is allowed, any attempt to access address space
diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
index 5049b4f..8cbd239 100644
--- a/drivers/vfio/vfio_iommu_spapr_tce.c
+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
@@ -89,10 +89,16 @@ static void decrement_locked_vm(long npages)
  */
 struct tce_container {
 	struct mutex lock;
-	struct iommu_group *grp;
 	bool enabled;
 	unsigned long locked_pages;
 	bool v2;
+	struct iommu_table tables[IOMMU_TABLE_GROUP_MAX_TABLES];
+	struct list_head group_list;
+};
+
+struct tce_iommu_group {
+	struct list_head next;
+	struct iommu_group *grp;
 };
 
 static long tce_unregister_pages(struct tce_container *container,
@@ -154,20 +160,20 @@ static bool tce_page_is_contained(struct page *page, unsigned page_shift)
 	return (PAGE_SHIFT + compound_order(compound_head(page))) >= page_shift;
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
@@ -185,11 +191,8 @@ static int tce_iommu_enable(struct tce_container *container)
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
@@ -222,12 +225,24 @@ static int tce_iommu_enable(struct tce_container *container)
 	 * as this information is only available from KVM and VFIO is
 	 * KVM agnostic.
 	 */
-	table_group = iommu_group_get_iommudata(container->grp);
+	if (!tce_groups_attached(container))
+		return -ENODEV;
+
+	tcegrp = list_first_entry(&container->group_list,
+			struct tce_iommu_group, next);
+	table_group = iommu_group_get_iommudata(tcegrp->grp);
 	if (!table_group)
 		return -ENODEV;
 
-	tbl = &table_group->tables[0];
-	locked = (tbl->it_size << tbl->it_page_shift) >> PAGE_SHIFT;
+	/*
+	 * We do not allow enabling a group if no DMA-able memory was
+	 * registered as there is no way to know how much we should
+	 * increment the locked_vm counter.
+	 */
+	if (!table_group->tce32_size)
+		return -EPERM;
+
+	locked = table_group->tce32_size >> PAGE_SHIFT;
 	ret = try_increment_locked_vm(locked);
 	if (ret)
 		return ret;
@@ -266,6 +281,8 @@ static void *tce_iommu_open(unsigned long arg)
 		return ERR_PTR(-ENOMEM);
 
 	mutex_init(&container->lock);
+	INIT_LIST_HEAD_RCU(&container->group_list);
+
 	container->v2 = arg == VFIO_SPAPR_TCE_v2_IOMMU;
 
 	return container;
@@ -274,15 +291,35 @@ static void *tce_iommu_open(unsigned long arg)
 static int tce_iommu_clear(struct tce_container *container,
 		struct iommu_table *tbl,
 		unsigned long entry, unsigned long pages);
+static void tce_iommu_free_table(struct iommu_table *tbl);
 
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
+			tce_iommu_free_table(tbl);
+	}
 
 	tce_iommu_disable(container);
 
@@ -498,6 +535,44 @@ static long tce_iommu_build_v2(struct tce_container *container,
 	return ret;
 }
 
+static long tce_iommu_create_table(struct iommu_table_group *table_group,
+			int num,
+			__u32 page_shift,
+			__u64 window_size,
+			__u32 levels,
+			struct iommu_table *tbl)
+{
+	long ret;
+	unsigned long table_size;
+
+	table_size = table_group->ops->get_table_size(page_shift, window_size,
+			levels) >> PAGE_SHIFT;
+
+	ret = try_increment_locked_vm(table_size);
+	if (ret)
+		return ret;
+
+	ret = table_group->ops->create_table(table_group, num,
+			page_shift, window_size, levels, tbl);
+
+	if (ret)
+		decrement_locked_vm(table_size);
+
+	return ret;
+}
+
+static void tce_iommu_free_table(struct iommu_table *tbl)
+{
+	unsigned long pages = tbl->it_allocated_size >> PAGE_SHIFT;
+
+	if (!tbl->it_allocated_size)
+		return;
+
+	tbl->it_ops->free(tbl);
+	decrement_locked_vm(pages);
+	memset(tbl, 0, sizeof(*tbl));
+}
+
 static long tce_iommu_ioctl(void *iommu_data,
 				 unsigned int cmd, unsigned long arg)
 {
@@ -521,16 +596,17 @@ static long tce_iommu_ioctl(void *iommu_data,
 
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
@@ -542,9 +618,9 @@ static long tce_iommu_ioctl(void *iommu_data,
 		if (info.argsz < minsz)
 			return -EINVAL;
 
-		info.dma32_window_start = tbl->it_offset << tbl->it_page_shift;
-		info.dma32_window_size = tbl->it_size << tbl->it_page_shift;
 		info.flags = 0;
+		info.dma32_window_start = table_group->tce32_start;
+		info.dma32_window_size = table_group->tce32_size;
 
 		if (copy_to_user((void __user *)arg, &info, minsz))
 			return -EFAULT;
@@ -721,12 +797,20 @@ static long tce_iommu_ioctl(void *iommu_data,
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
@@ -735,63 +819,111 @@ static long tce_iommu_ioctl(void *iommu_data,
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
+		table_group->ops->set_ownership(table_group, true);
 		/*
-		 * Disable iommu bypass, otherwise the user can DMA to all of
-		 * our physical memory via the bypass window instead of just
-		 * the pages that has been explicitly mapped into the iommu
+		 * If it the first group attached, check if there is any window
+		 * created and create one if none.
 		 */
-		struct iommu_table tbltmp = { 0 }, *tbl = &tbltmp;
-
-		table_group->ops->set_ownership(table_group, true);
-		ret = table_group->ops->create_table(table_group, 0,
-				IOMMU_PAGE_SHIFT_4K,
-				table_group->tce32_size, 1, tbl);
-		if (!ret)
-			ret = table_group->ops->set_window(table_group, 0, tbl);
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
+				ret = tce_iommu_create_table(
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
@@ -802,25 +934,27 @@ static void tce_iommu_detach_group(void *iommu_data,
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
@@ -828,7 +962,7 @@ static void tce_iommu_detach_group(void *iommu_data,
 	/* Kernel owns the device now, we can restore bypass */
 	if (!table_group->ops || !table_group->ops->set_ownership) {
 		for (i = 0; i < IOMMU_TABLE_GROUP_MAX_TABLES; ++i) {
-			struct iommu_table *tbl = &table_group->tables[i];
+			struct iommu_table *tbl = &container->tables[i];
 
 			if (!tbl->it_size)
 				continue;
@@ -837,20 +971,15 @@ static void tce_iommu_detach_group(void *iommu_data,
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
