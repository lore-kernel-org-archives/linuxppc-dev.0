Return-Path: <aik@ozlabs.ru>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0DAE01A04A2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2015 01:08:52 +1100 (AEDT)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Tue, 10 Mar 2015 00:08:51 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 30D93357805D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2015 01:08:49 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t29E8fC637421162
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2015 01:08:49 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t29E8F7I005897
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2015 01:08:15 +1100
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v5 29/29] vfio: powerpc/spapr: Support Dynamic DMA windows
Date: Tue, 10 Mar 2015 01:07:25 +1100
Message-Id: <1425910045-26167-30-git-send-email-aik@ozlabs.ru>
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

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
Changes:
v4:
* moved code to tce_iommu_create_window()/tce_iommu_remove_window()
helpers
* added docs
---
 Documentation/vfio.txt              |  19 +++++
 arch/powerpc/include/asm/iommu.h    |   2 +-
 drivers/vfio/vfio_iommu_spapr_tce.c | 165 +++++++++++++++++++++++++++++++++++-
 include/uapi/linux/vfio.h           |  24 +++++-
 4 files changed, 207 insertions(+), 3 deletions(-)

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
index 04f72ac..de82b61 100644
--- a/arch/powerpc/include/asm/iommu.h
+++ b/arch/powerpc/include/asm/iommu.h
@@ -138,7 +138,7 @@ extern void iommu_free_table(struct iommu_table *tbl, const char *node_name);
 extern struct iommu_table *iommu_init_table(struct iommu_table * tbl,
 					    int nid);
 
-#define IOMMU_TABLE_GROUP_MAX_TABLES	1
+#define IOMMU_TABLE_GROUP_MAX_TABLES	2
 
 struct iommu_table_group;
 
diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
index 3a0b5fe..7aa4141b 100644
--- a/drivers/vfio/vfio_iommu_spapr_tce.c
+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
@@ -96,6 +96,7 @@ struct tce_container {
 	struct list_head mem_list;
 	struct iommu_table tables[IOMMU_TABLE_GROUP_MAX_TABLES];
 	struct list_head group_list;
+	bool v2;
 };
 
 struct tce_iommu_group {
@@ -333,6 +334,20 @@ static struct iommu_table *spapr_tce_find_table(
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
+	return -1;
+}
+
 static int tce_iommu_enable(struct tce_container *container)
 {
 	int ret = 0;
@@ -432,6 +447,8 @@ static void *tce_iommu_open(unsigned long arg)
 	INIT_LIST_HEAD_RCU(&container->mem_list);
 	INIT_LIST_HEAD_RCU(&container->group_list);
 
+	container->v2 = arg == VFIO_SPAPR_TCE_v2_IOMMU;
+
 	return container;
 }
 
@@ -605,11 +622,90 @@ static long tce_iommu_build(struct tce_container *container,
 	return ret;
 }
 
+static long tce_iommu_create_window(struct tce_container *container,
+		__u32 page_shift, __u64 window_size, __u32 levels,
+		__u64 *start_addr)
+{
+	struct iommu_table_group *table_group;
+	struct tce_iommu_group *tcegrp;
+	int num;
+	long ret;
+
+	num = spapr_tce_find_free_table(container);
+	if (num < 0)
+		return -ENOSYS;
+
+	tcegrp = list_first_entry(&container->group_list,
+			struct tce_iommu_group, next);
+	table_group = iommu_group_get_iommudata(tcegrp->grp);
+
+	ret = table_group->ops->create_table(table_group, num,
+			page_shift, window_size, levels,
+			&container->tables[num]);
+	if (ret)
+		return ret;
+
+	list_for_each_entry(tcegrp, &container->group_list, next) {
+		struct iommu_table_group *table_group_tmp =
+			iommu_group_get_iommudata(tcegrp->grp);
+
+		if (WARN_ON_ONCE(table_group_tmp->ops != table_group->ops))
+			return -EFAULT;
+
+		ret = table_group->ops->set_window(table_group_tmp, num,
+				&container->tables[num]);
+		if (ret)
+			return ret;
+	}
+
+	*start_addr = container->tables[num].it_offset <<
+		container->tables[num].it_page_shift;
+
+	return 0;
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
+		if (!table_group->ops || !table_group->ops->unset_window)
+			return -EFAULT;
+		if (container->tables[num].it_size)
+			table_group->ops->unset_window(table_group, num);
+	}
+
+	/* Free table */
+	tcegrp = list_first_entry(&container->group_list,
+			struct tce_iommu_group, next);
+	table_group = iommu_group_get_iommudata(tcegrp->grp);
+
+	tce_iommu_clear(container, tbl,
+			tbl->it_offset, tbl->it_size);
+	if (tbl->it_ops->free)
+		tbl->it_ops->free(tbl);
+
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
@@ -652,6 +748,16 @@ static long tce_iommu_ioctl(void *iommu_data,
 
 		info.dma32_window_start = table_group->tce32_start;
 		info.dma32_window_size = table_group->tce32_size;
+		info.max_dynamic_windows_supported =
+				table_group->max_dynamic_windows_supported;
+		info.levels = table_group->max_levels;
+		info.flags = table_group->flags;
+
+		ddwsz = offsetofend(struct vfio_iommu_spapr_tce_info,
+				levels);
+
+		if (info.argsz == ddwsz)
+			minsz = ddwsz;
 
 		if (copy_to_user((void __user *)arg, &info, minsz))
 			return -EFAULT;
@@ -823,6 +929,63 @@ static long tce_iommu_ioctl(void *iommu_data,
 		return ret;
 	}
 
+	case VFIO_IOMMU_SPAPR_TCE_CREATE: {
+		struct vfio_iommu_spapr_tce_create create;
+
+		if (!tce_preregistered(container))
+			return -EPERM;
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
+			return -EFAULT;
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
index fbc5286..150f418 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -457,9 +457,11 @@ struct vfio_iommu_type1_dma_unmap {
  */
 struct vfio_iommu_spapr_tce_info {
 	__u32 argsz;
-	__u32 flags;			/* reserved for future use */
+	__u32 flags;
 	__u32 dma32_window_start;	/* 32 bit window start (bytes) */
 	__u32 dma32_window_size;	/* 32 bit window size (bytes) */
+	__u32 max_dynamic_windows_supported;
+	__u32 levels;
 };
 
 #define VFIO_IOMMU_SPAPR_TCE_GET_INFO	_IO(VFIO_TYPE, VFIO_BASE + 12)
@@ -520,6 +522,26 @@ struct vfio_iommu_spapr_register_memory {
  */
 #define VFIO_IOMMU_SPAPR_UNREGISTER_MEMORY	_IO(VFIO_TYPE, VFIO_BASE + 18)
 
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
