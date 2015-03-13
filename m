Return-Path: <aik@ozlabs.ru>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 998021A0A0A
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2015 19:09:05 +1100 (AEDT)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Fri, 13 Mar 2015 18:09:05 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 1DD442BB0067
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2015 19:09:01 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2D88rcB29950038
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2015 19:09:01 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2D88RUr016599
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2015 19:08:27 +1100
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel v6 29/29] vfio: powerpc/spapr: Support Dynamic DMA
 windows
Date: Fri, 13 Mar 2015 19:07:37 +1100
Message-Id: <1426234057-16165-30-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1426234057-16165-1-git-send-email-aik@ozlabs.ru>
References: <1426234057-16165-1-git-send-email-aik@ozlabs.ru>
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

This adds create/remove window ioctls to create and remove DMA windows.
sPAPR defines a Dynamic DMA windows capability which allows
para-virtualized guests to create additional DMA windows on a PCI bus.
The existing linux kernels use this new window to map the entire guest
memory and switch to the direct DMA operations saving time on map/unmap
requests which would normally happen in a big amounts.

This adds 2 ioctl handlers - VFIO_IOMMU_SPAPR_TCE_CREATE and
VFIO_IOMMU_SPAPR_TCE_REMOVE - to create and remove windows.
Up to 2 windows are supported now by the hardware and by this driver.

This changes VFIO_IOMMU_SPAPR_TCE_GET_INFO handler to return additional
information such as a number of supported windows and maximum number
levels of TCE tables.

DDW is added as a capability, not as a SPAPR TCE IOMMU v2 unique feature
as we still want to support v2 on platforms which cannot do DDW for
the sake of TCE acceleration in KVM (coming soon).

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
Changes:
v6:
* added explicit VFIO_IOMMU_INFO_DDW flag to vfio_iommu_spapr_tce_info,
it used to be page mask flags from platform code
* added explicit pgsizes field
* added cleanup if tce_iommu_create_window() failed in a middle
* added checks for callbacks in tce_iommu_create_window and remove those
from tce_iommu_remove_window when it is too late to test anyway
* spapr_tce_find_free_table returns sensible error code now
* updated description of VFIO_IOMMU_SPAPR_TCE_CREATE/
VFIO_IOMMU_SPAPR_TCE_REMOVE

v4:
* moved code to tce_iommu_create_window()/tce_iommu_remove_window()
helpers
* added docs
---
 Documentation/vfio.txt              |  19 ++++
 arch/powerpc/include/asm/iommu.h    |   2 +-
 drivers/vfio/vfio_iommu_spapr_tce.c | 206 +++++++++++++++++++++++++++++++++++-
 include/uapi/linux/vfio.h           |  41 ++++++-
 4 files changed, 265 insertions(+), 3 deletions(-)

diff --git a/Documentation/vfio.txt b/Documentation/vfio.txt
index 791e85c..61ce393 100644
--- a/Documentation/vfio.txt
+++ b/Documentation/vfio.txt
@@ -446,6 +446,25 @@ the memory block.
 The user space is not expected to call these often and the block descriptors
 are stored in a linked list in the kernel.
 
+6) sPAPR specification allows guests to have an ddditional DMA window(s) on
+a PCI bus with a variable page size. Two ioctls have been added to support
+this: VFIO_IOMMU_SPAPR_TCE_CREATE and VFIO_IOMMU_SPAPR_TCE_REMOVE.
+The platform has to support the functionality or error will be returned to
+the userspace. The existing hardware supports up to 2 DMA windows, one is
+2GB long, uses 4K pages and called "default 32bit window"; the other can
+be as big as entire RAM, use different page size, it is optional - guests
+create those in run-time if the guest driver supports 64bit DMA.
+
+VFIO_IOMMU_SPAPR_TCE_CREATE receives a page shift, a DMA window size and
+a number of TCE table levels (if a TCE table is going to be big enough and
+the kernel may not be able to allocate enough of physicall contiguous memory).
+It creates a new window in the available slot and returns the bus address where
+the new window starts. Due to hardware limitation, the user space cannot choose
+the location of DMA windows.
+
+VFIO_IOMMU_SPAPR_TCE_REMOVE receives the bus start address of the window
+and removes it.
+
 -------------------------------------------------------------------------------
 
 [1] VFIO was originally an acronym for "Virtual Function I/O" in its
diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/iommu.h
index 13145a2..bac02bf 100644
--- a/arch/powerpc/include/asm/iommu.h
+++ b/arch/powerpc/include/asm/iommu.h
@@ -138,7 +138,7 @@ extern void iommu_free_table(struct iommu_table *tbl, const char *node_name);
 extern struct iommu_table *iommu_init_table(struct iommu_table * tbl,
 					    int nid);
 
-#define IOMMU_TABLE_GROUP_MAX_TABLES	1
+#define IOMMU_TABLE_GROUP_MAX_TABLES	2
 
 struct iommu_table_group;
 
diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
index d94116b..0129a4f 100644
--- a/drivers/vfio/vfio_iommu_spapr_tce.c
+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
@@ -600,11 +600,137 @@ static long tce_iommu_build(struct tce_container *container,
 	return ret;
 }
 
+static int spapr_tce_find_free_table(struct tce_container *container)
+{
+	int i;
+
+	for (i = 0; i < IOMMU_TABLE_GROUP_MAX_TABLES; ++i) {
+		struct iommu_table *tbl = &container->tables[i];
+
+		if (!tbl->it_size)
+			return i;
+	}
+
+	return -ENOSPC;
+}
+
+static long tce_iommu_create_window(struct tce_container *container,
+		__u32 page_shift, __u64 window_size, __u32 levels,
+		__u64 *start_addr)
+{
+	struct tce_iommu_group *tcegrp;
+	struct iommu_table_group *table_group;
+	struct iommu_table *tbl;
+	int num;
+	long ret;
+
+	num = spapr_tce_find_free_table(container);
+	if (num < 0)
+		return num;
+
+	tbl = &container->tables[num];
+
+	/* Get the first group for ops::create_table */
+	tcegrp = list_first_entry(&container->group_list,
+			struct tce_iommu_group, next);
+	table_group = iommu_group_get_iommudata(tcegrp->grp);
+	if (!table_group)
+		return -EFAULT;
+
+	if (!(table_group->pgsizes & (1ULL << page_shift)))
+		return -EINVAL;
+
+	if (!table_group->ops->set_window || !table_group->ops->unset_window ||
+			!table_group->ops->create_table)
+		return -EPERM;
+
+	/* Create TCE table */
+	ret = table_group->ops->create_table(table_group, num,
+			page_shift, window_size, levels, tbl);
+	if (ret)
+		return ret;
+
+	BUG_ON(!tbl->it_ops->free);
+
+	/*
+	 * Program the table to every group.
+	 * Groups have been tested for compatibility at the attach time.
+	 */
+	list_for_each_entry(tcegrp, &container->group_list, next) {
+		table_group = iommu_group_get_iommudata(tcegrp->grp);
+
+		ret = table_group->ops->set_window(table_group, num, tbl);
+		if (ret)
+			goto unset_exit;
+	}
+
+	/* Return start address assigned by platform in create_table() */
+	*start_addr = tbl->it_offset << tbl->it_page_shift;
+
+	return 0;
+
+unset_exit:
+	list_for_each_entry(tcegrp, &container->group_list, next) {
+		table_group = iommu_group_get_iommudata(tcegrp->grp);
+		table_group->ops->unset_window(table_group, num);
+	}
+	tbl->it_ops->free(tbl);
+	memset(tbl, 0, sizeof(*tbl));
+
+	return ret;
+}
+
+static long tce_iommu_remove_window(struct tce_container *container,
+		__u64 start_addr)
+{
+	struct iommu_table_group *table_group = NULL;
+	struct iommu_table *tbl;
+	struct tce_iommu_group *tcegrp;
+	int num;
+
+	tbl = spapr_tce_find_table(container, start_addr);
+	if (!tbl)
+		return -EINVAL;
+
+	/* Detach groups from IOMMUs */
+	num = tbl - container->tables;
+	list_for_each_entry(tcegrp, &container->group_list, next) {
+		table_group = iommu_group_get_iommudata(tcegrp->grp);
+
+		/*
+		 * When a group is attached, a window might be set if DDW
+		 * is supported by the platform. If it is not, VFIO will
+		 * use the existing window created by the platform code
+		 * so spapr_tce_find_table() will find a table but
+		 * since it is owned by the platform code, ops or unset_window()
+		 * will not be defined. If in this situation a broken
+		 * guest calls VFIO_IOMMU_SPAPR_TCE_REMOVE, we crash here
+		 * without the check.
+		 */
+		if (!table_group->ops || !table_group->ops->unset_window)
+			return -EPERM;
+
+		if (container->tables[num].it_size)
+			table_group->ops->unset_window(table_group, num);
+	}
+
+	/* Free table */
+	tcegrp = list_first_entry(&container->group_list,
+			struct tce_iommu_group, next);
+	table_group = iommu_group_get_iommudata(tcegrp->grp);
+
+	tce_iommu_clear(container, tbl, tbl->it_offset, tbl->it_size);
+	tbl->it_ops->free(tbl);
+	memset(tbl, 0, sizeof(*tbl));
+
+	return 0;
+}
+
 static long tce_iommu_ioctl(void *iommu_data,
 				 unsigned int cmd, unsigned long arg)
 {
 	struct tce_container *container = iommu_data;
-	unsigned long minsz;
+	unsigned long minsz, ddwsz;
 	long ret;
 
 	switch (cmd) {
@@ -645,9 +771,24 @@ static long tce_iommu_ioctl(void *iommu_data,
 		if (info.argsz < minsz)
 			return -EINVAL;
 
+		info.flags = 0;
 		info.dma32_window_start = table_group->tce32_start;
 		info.dma32_window_size = table_group->tce32_size;
 
+		if (table_group->max_dynamic_windows_supported) {
+			info.flags = VFIO_IOMMU_INFO_DDW;
+			info.pgsizes = table_group->pgsizes;
+			info.max_dynamic_windows_supported =
+				table_group->max_dynamic_windows_supported;
+			info.levels = table_group->max_levels;
+		}
+
+		ddwsz = offsetofend(struct vfio_iommu_spapr_tce_info,
+				levels);
+
+		if (info.argsz == ddwsz)
+			minsz = ddwsz;
+
 		if (copy_to_user((void __user *)arg, &info, minsz))
 			return -EFAULT;
 
@@ -830,6 +971,69 @@ static long tce_iommu_ioctl(void *iommu_data,
 		return ret;
 	}
 
+	case VFIO_IOMMU_SPAPR_TCE_CREATE: {
+		struct vfio_iommu_spapr_tce_create create;
+
+		if (!tce_preregistered(container))
+			return -EPERM;
+
+		if (!tce_groups_attached(container))
+			return -ENXIO;
+
+		minsz = offsetofend(struct vfio_iommu_spapr_tce_create,
+				start_addr);
+
+		if (copy_from_user(&create, (void __user *)arg, minsz))
+			return -EFAULT;
+
+		if (create.argsz < minsz)
+			return -EINVAL;
+
+		if (create.flags)
+			return -EINVAL;
+
+		mutex_lock(&container->lock);
+
+		ret = tce_iommu_create_window(container, create.page_shift,
+				create.window_size, create.levels,
+				&create.start_addr);
+
+		if (!ret && copy_to_user((void __user *)arg, &create, minsz))
+			ret = -EFAULT;
+
+		mutex_unlock(&container->lock);
+
+		return ret;
+	}
+	case VFIO_IOMMU_SPAPR_TCE_REMOVE: {
+		struct vfio_iommu_spapr_tce_remove remove;
+
+		if (!tce_preregistered(container))
+			return -EPERM;
+
+		if (!tce_groups_attached(container))
+			return -ENXIO;
+
+		minsz = offsetofend(struct vfio_iommu_spapr_tce_remove,
+				start_addr);
+
+		if (copy_from_user(&remove, (void __user *)arg, minsz))
+			return -EFAULT;
+
+		if (remove.argsz < minsz)
+			return -EINVAL;
+
+		if (remove.flags)
+			return -EINVAL;
+
+		mutex_lock(&container->lock);
+
+		ret = tce_iommu_remove_window(container, remove.start_addr);
+
+		mutex_unlock(&container->lock);
+
+		return ret;
+	}
 	}
 
 	return -ENOTTY;
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index fbc5286..7fa02e1 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -457,9 +457,13 @@ struct vfio_iommu_type1_dma_unmap {
  */
 struct vfio_iommu_spapr_tce_info {
 	__u32 argsz;
-	__u32 flags;			/* reserved for future use */
+	__u32 flags;
+#define VFIO_IOMMU_INFO_DDW	(1 << 0)	/* DDW supported */
 	__u32 dma32_window_start;	/* 32 bit window start (bytes) */
 	__u32 dma32_window_size;	/* 32 bit window size (bytes) */
+	__u64 pgsizes;			/* Bitmap of supported page sizes */
+	__u32 max_dynamic_windows_supported;
+	__u32 levels;
 };
 
 #define VFIO_IOMMU_SPAPR_TCE_GET_INFO	_IO(VFIO_TYPE, VFIO_BASE + 12)
@@ -520,6 +524,41 @@ struct vfio_iommu_spapr_register_memory {
  */
 #define VFIO_IOMMU_SPAPR_UNREGISTER_MEMORY	_IO(VFIO_TYPE, VFIO_BASE + 18)
 
+/**
+ * VFIO_IOMMU_SPAPR_TCE_CREATE - _IOWR(VFIO_TYPE, VFIO_BASE + 19, struct vfio_iommu_spapr_tce_create)
+ *
+ * Creates an additional TCE table and programs it (sets a new DMA window)
+ * to every IOMMU group in the container. It receives page shift, window
+ * size and number of levels in the TCE table being created.
+ *
+ * It allocates and returns an offset on a PCI bus of the new DMA window.
+ */
+struct vfio_iommu_spapr_tce_create {
+	__u32 argsz;
+	__u32 flags;
+	/* in */
+	__u32 page_shift;
+	__u64 window_size;
+	__u32 levels;
+	/* out */
+	__u64 start_addr;
+};
+#define VFIO_IOMMU_SPAPR_TCE_CREATE	_IO(VFIO_TYPE, VFIO_BASE + 19)
+
+/**
+ * VFIO_IOMMU_SPAPR_TCE_REMOVE - _IOW(VFIO_TYPE, VFIO_BASE + 20, struct vfio_iommu_spapr_tce_remove)
+ *
+ * Unprograms a TCE table from all groups in the container and destroys it.
+ * It receives a PCI bus offset as a window id.
+ */
+struct vfio_iommu_spapr_tce_remove {
+	__u32 argsz;
+	__u32 flags;
+	/* in */
+	__u64 start_addr;
+};
+#define VFIO_IOMMU_SPAPR_TCE_REMOVE	_IO(VFIO_TYPE, VFIO_BASE + 20)
+
 /* ***************************************************************** */
 
 #endif /* _UAPIVFIO_H */
-- 
2.0.0
