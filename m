Return-Path: <aik@ozlabs.ru>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CA1C91A0512
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Feb 2015 21:07:47 +1100 (AEDT)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Mon, 16 Feb 2015 20:07:47 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 064D32CE805A
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Feb 2015 21:07:45 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1GA7avj30998640
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Feb 2015 21:07:44 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1GA7Atu000865
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Feb 2015 21:07:11 +1100
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4 28/28] vfio: powerpc/spapr: Support Dynamic DMA windows
Date: Mon, 16 Feb 2015 21:06:20 +1100
Message-Id: <1424081180-4494-29-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1424081180-4494-1-git-send-email-aik@ozlabs.ru>
References: <1424081180-4494-1-git-send-email-aik@ozlabs.ru>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>,
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
 Documentation/vfio.txt              |   6 ++
 arch/powerpc/include/asm/iommu.h    |   2 +-
 drivers/vfio/vfio_iommu_spapr_tce.c | 156 +++++++++++++++++++++++++++++++++++-
 include/uapi/linux/vfio.h           |  24 +++++-
 4 files changed, 185 insertions(+), 3 deletions(-)

diff --git a/Documentation/vfio.txt b/Documentation/vfio.txt
index 791e85c..11628f1 100644
--- a/Documentation/vfio.txt
+++ b/Documentation/vfio.txt
@@ -446,6 +446,12 @@ the memory block.
 The user space is not expected to call these often and the block descriptors
 are stored in a linked list in the kernel.
 
+6) sPAPR specification allows guests to have an ddditional DMA window(s) on
+a PCI bus with a variable page size. Two ioctls have been added to support
+this: VFIO_IOMMU_SPAPR_TCE_CREATE and VFIO_IOMMU_SPAPR_TCE_REMOVE.
+The platform has to support the functionality or error will be returned to
+the userspace.
+
 -------------------------------------------------------------------------------
 
 [1] VFIO was originally an acronym for "Virtual Function I/O" in its
diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/iommu.h
index 8393822..6f34b82 100644
--- a/arch/powerpc/include/asm/iommu.h
+++ b/arch/powerpc/include/asm/iommu.h
@@ -133,7 +133,7 @@ extern void iommu_free_table(struct iommu_table *tbl, const char *node_name);
 extern struct iommu_table *iommu_init_table(struct iommu_table * tbl,
 					    int nid);
 
-#define POWERPC_IOMMU_MAX_TABLES	1
+#define POWERPC_IOMMU_MAX_TABLES	2
 
 #define POWERPC_IOMMU_DEFAULT_LEVELS	1
 
diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
index ee91d51..d5de7c6 100644
--- a/drivers/vfio/vfio_iommu_spapr_tce.c
+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
@@ -333,6 +333,20 @@ static struct iommu_table *spapr_tce_find_table(
 	return ret;
 }
 
+static int spapr_tce_find_free_table(struct tce_container *container)
+{
+	int i;
+
+	for (i = 0; i < POWERPC_IOMMU_MAX_TABLES; ++i) {
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
@@ -620,11 +634,85 @@ static long tce_iommu_build(struct tce_container *container,
 	return ret;
 }
 
+static long tce_iommu_create_window(struct tce_container *container,
+		__u32 page_shift, __u32 window_shift, __u32 levels,
+		__u64 *start_addr)
+{
+	struct powerpc_iommu *iommu;
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
+	iommu = iommu_group_get_iommudata(tcegrp->grp);
+
+	ret = iommu->ops->create_table(iommu, num,
+			page_shift, window_shift, levels,
+			&container->tables[num]);
+	if (ret)
+		return ret;
+
+	list_for_each_entry(tcegrp, &container->group_list, next) {
+		struct powerpc_iommu *iommutmp =
+			iommu_group_get_iommudata(tcegrp->grp);
+
+		if (WARN_ON_ONCE(iommutmp->ops != iommu->ops))
+			return -EFAULT;
+
+		ret = iommu->ops->set_window(iommutmp, num,
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
+	struct powerpc_iommu *iommu = NULL;
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
+		iommu = iommu_group_get_iommudata(tcegrp->grp);
+		if (container->tables[num].it_size)
+			iommu->ops->unset_window(iommu, num);
+	}
+
+	/* Free table */
+	tcegrp = list_first_entry(&container->group_list,
+			struct tce_iommu_group, next);
+	iommu = iommu_group_get_iommudata(tcegrp->grp);
+
+	tce_iommu_clear(container, tbl,
+			tbl->it_offset, tbl->it_size);
+	iommu->ops->free_table(tbl);
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
@@ -666,6 +754,15 @@ static long tce_iommu_ioctl(void *iommu_data,
 
 		info.dma32_window_start = iommu->tce32_start;
 		info.dma32_window_size = iommu->tce32_size;
+		info.windows_supported = iommu->windows_supported;
+		info.levels = iommu->levels;
+		info.flags = iommu->flags;
+
+		ddwsz = offsetofend(struct vfio_iommu_spapr_tce_info,
+				levels);
+
+		if (info.argsz == ddwsz)
+			minsz = ddwsz;
 
 		if (copy_to_user((void __user *)arg, &info, minsz))
 			return -EFAULT;
@@ -828,6 +925,63 @@ static long tce_iommu_ioctl(void *iommu_data,
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
+				create.window_shift, create.levels,
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
index 0f55c08..0f4b219 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -454,9 +454,11 @@ struct vfio_iommu_type1_dma_unmap {
  */
 struct vfio_iommu_spapr_tce_info {
 	__u32 argsz;
-	__u32 flags;			/* reserved for future use */
+	__u32 flags;
 	__u32 dma32_window_start;	/* 32 bit window start (bytes) */
 	__u32 dma32_window_size;	/* 32 bit window size (bytes) */
+	__u32 windows_supported;
+	__u32 levels;
 };
 
 #define VFIO_IOMMU_SPAPR_TCE_GET_INFO	_IO(VFIO_TYPE, VFIO_BASE + 12)
@@ -517,6 +519,26 @@ struct vfio_iommu_spapr_register_memory {
  */
 #define VFIO_IOMMU_SPAPR_UNREGISTER_MEMORY	_IO(VFIO_TYPE, VFIO_BASE + 18)
 
+struct vfio_iommu_spapr_tce_create {
+	__u32 argsz;
+	__u32 flags;
+	/* in */
+	__u32 page_shift;
+	__u32 window_shift;
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
