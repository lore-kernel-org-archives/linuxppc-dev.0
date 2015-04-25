Return-Path: <aik@ozlabs.ru>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2FC521A0AE1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Apr 2015 22:16:24 +1000 (AEST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Sat, 25 Apr 2015 22:16:23 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 863BB357805E
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Apr 2015 22:16:20 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3PCGCg23211732
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Apr 2015 22:16:20 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3PCFkCV028406
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Apr 2015 22:15:47 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel v9 31/32] vfio: powerpc/spapr: Support multiple groups
 in one container if possible
Date: Sat, 25 Apr 2015 22:14:55 +1000
Message-Id: <1429964096-11524-32-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1429964096-11524-1-git-send-email-aik@ozlabs.ru>
References: <1429964096-11524-1-git-send-email-aik@ozlabs.ru>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, David Gibson <david@gibson.dropbear.id.au>
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
[aw: for the vfio related changes]
Acked-by: Alex Williamson <alex.williamson@redhat.com>
---
Changes:
v7:
* updated doc
---
 Documentation/vfio.txt              |   8 +-
 drivers/vfio/vfio_iommu_spapr_tce.c | 268 ++++++++++++++++++++++++++----------
 2 files changed, 199 insertions(+), 77 deletions(-)

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
index a7d6729..970e3a2 100644
--- a/drivers/vfio/vfio_iommu_spapr_tce.c
+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
@@ -82,6 +82,11 @@ static void decrement_locked_vm(long npages)
  * into DMA'ble space using the IOMMU
  */
 
+struct tce_iommu_group {
+	struct list_head next;
+	struct iommu_group *grp;
+};
+
 /*
  * The container descriptor supports only a single group per container.
  * Required by the API as the container is not supplied with the IOMMU group
@@ -89,10 +94,11 @@ static void decrement_locked_vm(long npages)
  */
 struct tce_container {
 	struct mutex lock;
-	struct iommu_group *grp;
 	bool enabled;
 	unsigned long locked_pages;
 	bool v2;
+	struct iommu_table tables[IOMMU_TABLE_GROUP_MAX_TABLES];
+	struct list_head group_list;
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
@@ -186,9 +192,7 @@ static int tce_iommu_enable(struct tce_container *container)
 	int ret = 0;
 	unsigned long locked;
 	struct iommu_table_group *table_group;
-
-	if (!container->grp)
-		return -ENXIO;
+	struct tce_iommu_group *tcegrp;
 
 	if (!current->mm)
 		return -ESRCH; /* process exited */
@@ -225,7 +229,12 @@ static int tce_iommu_enable(struct tce_container *container)
 	 * as there is no way to know how much we should increment
 	 * the locked_vm counter.
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
 
@@ -257,6 +266,48 @@ static void tce_iommu_disable(struct tce_container *container)
 	decrement_locked_vm(container->locked_pages);
 }
 
+static long tce_iommu_create_table(struct iommu_table_group *table_group,
+			int num,
+			__u32 page_shift,
+			__u64 window_size,
+			__u32 levels,
+			struct iommu_table *tbl)
+{
+	long ret, table_size;
+
+	table_size = table_group->ops->get_table_size(page_shift, window_size,
+			levels);
+	if (!table_size)
+		return -EINVAL;
+
+	ret = try_increment_locked_vm(table_size >> PAGE_SHIFT);
+	if (ret)
+		return ret;
+
+	ret = table_group->ops->create_table(table_group, num,
+			page_shift, window_size, levels, tbl);
+
+	WARN_ON(!ret && !tbl->it_ops->free);
+	WARN_ON(!ret && (tbl->it_allocated_size != table_size));
+
+	if (ret)
+		decrement_locked_vm(table_size >> PAGE_SHIFT);
+
+	return ret;
+}
+
+static void tce_iommu_free_table(struct iommu_table *tbl)
+{
+	unsigned long pages = tbl->it_allocated_size >> PAGE_SHIFT;
+
+	if (!tbl->it_size)
+		return;
+
+	tbl->it_ops->free(tbl);
+	decrement_locked_vm(pages);
+	memset(tbl, 0, sizeof(*tbl));
+}
+
 static void *tce_iommu_open(unsigned long arg)
 {
 	struct tce_container *container;
@@ -271,19 +322,41 @@ static void *tce_iommu_open(unsigned long arg)
 		return ERR_PTR(-ENOMEM);
 
 	mutex_init(&container->lock);
+	INIT_LIST_HEAD_RCU(&container->group_list);
+
 	container->v2 = arg == VFIO_SPAPR_TCE_v2_IOMMU;
 
 	return container;
 }
 
+static int tce_iommu_clear(struct tce_container *container,
+		struct iommu_table *tbl,
+		unsigned long entry, unsigned long pages);
+
 static void tce_iommu_release(void *iommu_data)
 {
 	struct tce_container *container = iommu_data;
+	struct iommu_table_group *table_group;
+	struct tce_iommu_group *tcegrp;
+	long i;
 
-	WARN_ON(container->grp);
+	while (tce_groups_attached(container)) {
+		tcegrp = list_first_entry(&container->group_list,
+				struct tce_iommu_group, next);
+		table_group = iommu_group_get_iommudata(tcegrp->grp);
+		tce_iommu_detach_group(iommu_data, tcegrp->grp);
+	}
 
-	if (container->grp)
-		tce_iommu_detach_group(iommu_data, container->grp);
+	/*
+	 * If VFIO created a table, it was not disposed
+	 * by tce_iommu_detach_group() so do it now.
+	 */
+	for (i = 0; i < IOMMU_TABLE_GROUP_MAX_TABLES; ++i) {
+		struct iommu_table *tbl = &container->tables[i];
+
+		tce_iommu_clear(container, tbl, tbl->it_offset, tbl->it_size);
+		tce_iommu_free_table(tbl);
+	}
 
 	tce_iommu_disable(container);
 	mutex_destroy(&container->lock);
@@ -509,12 +582,15 @@ static long tce_iommu_ioctl(void *iommu_data,
 
 	case VFIO_IOMMU_SPAPR_TCE_GET_INFO: {
 		struct vfio_iommu_spapr_tce_info info;
+		struct tce_iommu_group *tcegrp;
 		struct iommu_table_group *table_group;
 
-		if (WARN_ON(!container->grp))
+		if (!tce_groups_attached(container))
 			return -ENXIO;
 
-		table_group = iommu_group_get_iommudata(container->grp);
+		tcegrp = list_first_entry(&container->group_list,
+				struct tce_iommu_group, next);
+		table_group = iommu_group_get_iommudata(tcegrp->grp);
 
 		if (!table_group)
 			return -ENXIO;
@@ -707,12 +783,20 @@ static long tce_iommu_ioctl(void *iommu_data,
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
@@ -724,11 +808,14 @@ static void tce_iommu_release_ownership(struct tce_container *container,
 	int i;
 
 	for (i = 0; i < IOMMU_TABLE_GROUP_MAX_TABLES; ++i) {
-		struct iommu_table *tbl = &table_group->tables[i];
+		struct iommu_table *tbl = &container->tables[i];
 
 		tce_iommu_clear(container, tbl, tbl->it_offset, tbl->it_size);
 		if (tbl->it_map)
 			iommu_release_ownership(tbl);
+
+		/* Reset the container's copy of the table descriptor */
+		memset(tbl, 0, sizeof(*tbl));
 	}
 }
 
@@ -758,38 +845,56 @@ static int tce_iommu_take_ownership(struct iommu_table_group *table_group)
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
+			!table_group->ops->take_ownership ||
+			!table_group->ops->release_ownership)) {
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
 
 	if (!table_group->ops || !table_group->ops->take_ownership ||
 			!table_group->ops->release_ownership) {
 		ret = tce_iommu_take_ownership(table_group);
+		if (!ret)
+			container->tables[0] = table_group->tables[0];
 	} else if (!table_group->ops->create_table ||
 			!table_group->ops->set_window) {
 		WARN_ON_ONCE(1);
@@ -801,23 +906,46 @@ static int tce_iommu_attach_group(void *iommu_data,
 		 * the pages that has been explicitly mapped into the iommu
 		 */
 		table_group->ops->take_ownership(table_group);
-		ret = table_group->ops->create_table(table_group,
-				0, /* window number */
-				IOMMU_PAGE_SHIFT_4K,
-				table_group->tce32_size,
-				1, /* default levels */
-				&table_group->tables[0]);
-		if (!ret)
-			ret = table_group->ops->set_window(table_group, 0,
-					&table_group->tables[0]);
+		/*
+		 * If it the first group attached, check if there is
+		 * a default DMA window and create one if none as
+		 * the userspace expects it to exist.
+		 */
+		if (first_group && !container->tables[0].it_size) {
+			ret = tce_iommu_create_table(table_group,
+					0, /* window number */
+					IOMMU_PAGE_SHIFT_4K,
+					table_group->tce32_size,
+					1, /* default levels */
+					&container->tables[0]);
+			if (ret)
+				goto unlock_exit;
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
@@ -828,25 +956,27 @@ static void tce_iommu_detach_group(void *iommu_data,
 {
 	struct tce_container *container = iommu_data;
 	struct iommu_table_group *table_group;
+	struct tce_iommu_group *tcegrp;
 	long i;
+	bool found = false;
 
 	mutex_lock(&container->lock);
-	if (iommu_group != container->grp) {
-		pr_warn("tce_vfio: detaching group #%u, expected group is #%u\n",
-				iommu_group_id(iommu_group),
-				iommu_group_id(container->grp));
+
+	list_for_each_entry(tcegrp, &container->group_list, next) {
+		if (tcegrp->grp == iommu_group) {
+			found = true;
+			break;
+		}
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
@@ -857,18 +987,8 @@ static void tce_iommu_detach_group(void *iommu_data,
 	else if (!table_group->ops->unset_window)
 		WARN_ON_ONCE(1);
 	else {
-		for (i = 0; i < IOMMU_TABLE_GROUP_MAX_TABLES; ++i) {
-			struct iommu_table tbl = table_group->tables[i];
-
-			if (!tbl.it_size)
-				continue;
-
+		for (i = 0; i < IOMMU_TABLE_GROUP_MAX_TABLES; ++i)
 			table_group->ops->unset_window(table_group, i);
-			tce_iommu_clear(container, &tbl,
-					tbl.it_offset, tbl.it_size);
-			if (tbl.it_ops->free)
-				tbl.it_ops->free(&tbl);
-		}
 
 		table_group->ops->release_ownership(table_group);
 	}
-- 
2.0.0
