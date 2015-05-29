Return-Path: <aik@ozlabs.ru>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EF9C51A08D8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2015 18:46:50 +1000 (AEST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Fri, 29 May 2015 18:46:50 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 2D2E8357805E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2015 18:46:46 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4T8kcSF64291030
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2015 18:46:46 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4T8kDAK028635
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2015 18:46:13 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alex Williamson <alex.williamson@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH kernel v11 34/34] vfio: powerpc/spapr: Support Dynamic DMA
 windows
Date: Fri, 29 May 2015 18:44:58 +1000
Message-Id: <1432889098-22924-35-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1432889098-22924-1-git-send-email-aik@ozlabs.ru>
References: <1432889098-22924-1-git-send-email-aik@ozlabs.ru>
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
[aw: for the vfio related changes]
Acked-by: Alex Williamson <alex.williamson@redhat.com>
---
Changes:
v7:
* s/VFIO_IOMMU_INFO_DDW/VFIO_IOMMU_SPAPR_INFO_DDW/
* fixed typos in and updated vfio.txt
* fixed VFIO_IOMMU_SPAPR_TCE_GET_INFO handler
* moved ddw properties to vfio_iommu_spapr_tce_ddw_info

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
 drivers/vfio/vfio_iommu_spapr_tce.c | 196 +++++++++++++++++++++++++++++++++++-
 include/uapi/linux/vfio.h           |  61 ++++++++++-
 4 files changed, 273 insertions(+), 5 deletions(-)

diff --git a/Documentation/vfio.txt b/Documentation/vfio.txt
index 7dcf2b5..8b1ec51 100644
--- a/Documentation/vfio.txt
+++ b/Documentation/vfio.txt
@@ -452,6 +452,25 @@ address is from pre-registered range.
 
 This separation helps in optimizing DMA for guests.
 
+6) sPAPR specification allows guests to have an additional DMA window(s) on
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
+the kernel may not be able to allocate enough of physically contiguous memory).
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
index f9957eb..ca18cff 100644
--- a/arch/powerpc/include/asm/iommu.h
+++ b/arch/powerpc/include/asm/iommu.h
@@ -149,7 +149,7 @@ extern void iommu_free_table(struct iommu_table *tbl, const char *node_name);
  */
 extern struct iommu_table *iommu_init_table(struct iommu_table * tbl,
 					    int nid);
-#define IOMMU_TABLE_GROUP_MAX_TABLES	1
+#define IOMMU_TABLE_GROUP_MAX_TABLES	2
 
 struct iommu_table_group;
 
diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
index cadd9f8..199d5db 100644
--- a/drivers/vfio/vfio_iommu_spapr_tce.c
+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
@@ -211,6 +211,18 @@ static long tce_iommu_find_table(struct tce_container *container,
 	return -1;
 }
 
+static int tce_iommu_find_free_table(struct tce_container *container)
+{
+	int i;
+
+	for (i = 0; i < IOMMU_TABLE_GROUP_MAX_TABLES; ++i) {
+		if (!container->tables[i])
+			return i;
+	}
+
+	return -ENOSPC;
+}
+
 static int tce_iommu_enable(struct tce_container *container)
 {
 	int ret = 0;
@@ -593,11 +605,115 @@ static void tce_iommu_free_table(struct iommu_table *tbl)
 	decrement_locked_vm(pages);
 }
 
+static long tce_iommu_create_window(struct tce_container *container,
+		__u32 page_shift, __u64 window_size, __u32 levels,
+		__u64 *start_addr)
+{
+	struct tce_iommu_group *tcegrp;
+	struct iommu_table_group *table_group;
+	struct iommu_table *tbl = NULL;
+	long ret, num;
+
+	num = tce_iommu_find_free_table(container);
+	if (num < 0)
+		return num;
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
+			!table_group->ops->get_table_size ||
+			!table_group->ops->create_table)
+		return -EPERM;
+
+	/* Create TCE table */
+	ret = tce_iommu_create_table(container, table_group, num,
+			page_shift, window_size, levels, &tbl);
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
+	container->tables[num] = tbl;
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
+	tce_iommu_free_table(tbl);
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
+	num = tce_iommu_find_table(container, start_addr, &tbl);
+	if (num < 0)
+		return -EINVAL;
+
+	BUG_ON(!tbl->it_size);
+
+	/* Detach groups from IOMMUs */
+	list_for_each_entry(tcegrp, &container->group_list, next) {
+		table_group = iommu_group_get_iommudata(tcegrp->grp);
+
+		/*
+		 * SPAPR TCE IOMMU exposes the default DMA window to
+		 * the guest via dma32_window_start/size of
+		 * VFIO_IOMMU_SPAPR_TCE_GET_INFO. Some platforms allow
+		 * the userspace to remove this window, some do not so
+		 * here we check for the platform capability.
+		 */
+		if (!table_group->ops || !table_group->ops->unset_window)
+			return -EPERM;
+
+		table_group->ops->unset_window(table_group, num);
+	}
+
+	/* Free table */
+	tce_iommu_clear(container, tbl, tbl->it_offset, tbl->it_size);
+	tce_iommu_free_table(tbl);
+	container->tables[num] = NULL;
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
@@ -641,6 +757,21 @@ static long tce_iommu_ioctl(void *iommu_data,
 		info.dma32_window_start = table_group->tce32_start;
 		info.dma32_window_size = table_group->tce32_size;
 		info.flags = 0;
+		memset(&info.ddw, 0, sizeof(info.ddw));
+
+		if (table_group->max_dynamic_windows_supported &&
+				container->v2) {
+			info.flags |= VFIO_IOMMU_SPAPR_INFO_DDW;
+			info.ddw.pgsizes = table_group->pgsizes;
+			info.ddw.max_dynamic_windows_supported =
+				table_group->max_dynamic_windows_supported;
+			info.ddw.levels = table_group->max_levels;
+		}
+
+		ddwsz = offsetofend(struct vfio_iommu_spapr_tce_info, ddw);
+
+		if (info.argsz >= ddwsz)
+			minsz = ddwsz;
 
 		if (copy_to_user((void __user *)arg, &info, minsz))
 			return -EFAULT;
@@ -833,6 +964,69 @@ static long tce_iommu_ioctl(void *iommu_data,
 		return ret;
 	}
 
+	case VFIO_IOMMU_SPAPR_TCE_CREATE: {
+		struct vfio_iommu_spapr_tce_create create;
+
+		if (!container->v2)
+			break;
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
+		mutex_unlock(&container->lock);
+
+		if (!ret && copy_to_user((void __user *)arg, &create, minsz))
+			ret = -EFAULT;
+
+		return ret;
+	}
+	case VFIO_IOMMU_SPAPR_TCE_REMOVE: {
+		struct vfio_iommu_spapr_tce_remove remove;
+
+		if (!container->v2)
+			break;
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
index 8fdcfb9..dde0fe5 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -445,6 +445,23 @@ struct vfio_iommu_type1_dma_unmap {
 /* -------- Additional API for SPAPR TCE (Server POWERPC) IOMMU -------- */
 
 /*
+ * The SPAPR TCE DDW info struct provides the information about
+ * the details of Dynamic DMA window capability.
+ *
+ * @pgsizes contains a page size bitmask, 4K/64K/16M are supported.
+ * @max_dynamic_windows_supported tells the maximum number of windows
+ * which the platform can create.
+ * @levels tells the maximum number of levels in multi-level IOMMU tables;
+ * this allows splitting a table into smaller chunks which reduces
+ * the amount of physically contiguous memory required for the table.
+ */
+struct vfio_iommu_spapr_tce_ddw_info {
+	__u64 pgsizes;			/* Bitmap of supported page sizes */
+	__u32 max_dynamic_windows_supported;
+	__u32 levels;
+};
+
+/*
  * The SPAPR TCE info struct provides the information about the PCI bus
  * address ranges available for DMA, these values are programmed into
  * the hardware so the guest has to know that information.
@@ -454,14 +471,17 @@ struct vfio_iommu_type1_dma_unmap {
  * addresses too so the window works as a filter rather than an offset
  * for IOVA addresses.
  *
- * A flag will need to be added if other page sizes are supported,
- * so as defined here, it is always 4k.
+ * Flags supported:
+ * - VFIO_IOMMU_SPAPR_INFO_DDW: informs the userspace that dynamic DMA windows
+ *   (DDW) support is present. @ddw is only supported when DDW is present.
  */
 struct vfio_iommu_spapr_tce_info {
 	__u32 argsz;
-	__u32 flags;			/* reserved for future use */
+	__u32 flags;
+#define VFIO_IOMMU_SPAPR_INFO_DDW	(1 << 0)	/* DDW supported */
 	__u32 dma32_window_start;	/* 32 bit window start (bytes) */
 	__u32 dma32_window_size;	/* 32 bit window size (bytes) */
+	struct vfio_iommu_spapr_tce_ddw_info ddw;
 };
 
 #define VFIO_IOMMU_SPAPR_TCE_GET_INFO	_IO(VFIO_TYPE, VFIO_BASE + 12)
@@ -522,6 +542,41 @@ struct vfio_iommu_spapr_register_memory {
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
2.4.0.rc3.8.gfb3e7d5
