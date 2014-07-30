Return-Path: <aik@ozlabs.ru>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D5C231A0223
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Jul 2014 19:31:52 +1000 (EST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Wed, 30 Jul 2014 19:31:40 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id B51832BB0057
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Jul 2014 19:31:48 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6U98mQe1245464
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Jul 2014 19:08:48 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6U9Vlgw024048
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Jul 2014 19:31:48 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4 16/16] vfio: powerpc/spapr: Enable Dynamic DMA windows
Date: Wed, 30 Jul 2014 19:31:35 +1000
Message-Id: <1406712695-9491-17-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1406712695-9491-1-git-send-email-aik@ozlabs.ru>
References: <1406712695-9491-1-git-send-email-aik@ozlabs.ru>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Michael Ellerman <michael@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This defines and implements VFIO IOMMU API required to support
Dynamic DMA windows defined in the SPAPR specification. The ioctl handlers
implement host-size part of corresponding RTAS calls:
- VFIO_IOMMU_SPAPR_TCE_QUERY - ibm,query-pe-dma-window;
- VFIO_IOMMU_SPAPR_TCE_CREATE - ibm,create-pe-dma-window;
- VFIO_IOMMU_SPAPR_TCE_REMOVE - ibm,remove-pe-dma-window;
- VFIO_IOMMU_SPAPR_TCE_RESET - ibm,reset-pe-dma-window.

The VFIO IOMMU driver does basic sanity checks and calls corresponding
SPAPR TCE functions. At the moment only IODA2 (POWER8 PCI host bridge)
implements them.

This advertises VFIO_IOMMU_SPAPR_TCE_FLAG_DDW capability via
VFIO_IOMMU_SPAPR_TCE_GET_INFO.

This calls reset() when IOMMU is being disabled (happens when VFIO stops
using it).

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/platforms/powernv/pci-ioda.c |   1 +
 drivers/vfio/vfio_iommu_spapr_tce.c       | 173 +++++++++++++++++++++++++++++-
 include/uapi/linux/vfio.h                 |  37 ++++++-
 3 files changed, 209 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 6a847b2..f51afe2 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -859,6 +859,7 @@ static long pnv_pci_ioda2_ddw_create(struct spapr_tce_iommu_group *data,
 
 	/* Copy "invalidate" register address */
 	tbl64->it_index = pe->tce32.table.it_index;
+	tbl64->it_group = pe->tce32.table.it_group;
 	tbl64->it_type = TCE_PCI_SWINV_CREATE | TCE_PCI_SWINV_FREE |
 			TCE_PCI_SWINV_PAIR;
 	tbl64->it_map = (void *) 0xDEADBEEF; /* poison */
diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
index 48b256c..32e2804 100644
--- a/drivers/vfio/vfio_iommu_spapr_tce.c
+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
@@ -45,6 +45,7 @@ struct tce_container {
 	struct mutex lock;
 	struct iommu_group *grp;
 	bool enabled;
+	unsigned long start64;
 };
 
 
@@ -123,19 +124,36 @@ static void tce_iommu_disable(struct tce_container *container)
 
 	container->enabled = false;
 
-	if (!container->grp || !current->mm)
+	if (!container->grp)
 		return;
 
 	data = iommu_group_get_iommudata(container->grp);
 	if (!data || !data->iommu_owner || !data->ops->get_table)
 		return;
 
+	/* Try resetting, there might have been a 64bit window */
+	if (data->ops->reset)
+		data->ops->reset(data);
+
+	if (!current->mm)
+		return;
+
 	tbl = data->ops->get_table(data, TCE_DEFAULT_WINDOW);
 	if (!tbl)
 		return;
 
 	decrement_locked_vm((tbl->it_size << tbl->it_page_shift) >>
 			PAGE_SHIFT);
+
+	if (!container->start64)
+		return;
+
+	tbl = data->ops->get_table(data, container->start64);
+	if (!tbl)
+		return;
+
+	decrement_locked_vm((tbl->it_size << tbl->it_page_shift) >>
+			PAGE_SHIFT);
 }
 
 static void *tce_iommu_open(unsigned long arg)
@@ -210,6 +228,8 @@ static long tce_iommu_ioctl(void *iommu_data,
 		info.dma32_window_start = tbl->it_offset << tbl->it_page_shift;
 		info.dma32_window_size = tbl->it_size << tbl->it_page_shift;
 		info.flags = 0;
+		if (data->ops->query && data->ops->create && data->ops->remove)
+			info.flags |= VFIO_IOMMU_SPAPR_TCE_FLAG_DDW;
 
 		if (copy_to_user((void __user *)arg, &info, minsz))
 			return -EFAULT;
@@ -335,6 +355,157 @@ static long tce_iommu_ioctl(void *iommu_data,
 		tce_iommu_disable(container);
 		mutex_unlock(&container->lock);
 		return 0;
+
+	case VFIO_IOMMU_SPAPR_TCE_QUERY: {
+		struct vfio_iommu_spapr_tce_query query;
+		struct spapr_tce_iommu_group *data;
+
+		if (WARN_ON(!container->grp))
+			return -ENXIO;
+
+		data = iommu_group_get_iommudata(container->grp);
+
+		minsz = offsetofend(struct vfio_iommu_spapr_tce_query,
+				page_size_mask);
+
+		if (copy_from_user(&query, (void __user *)arg, minsz))
+			return -EFAULT;
+
+		if (query.argsz < minsz)
+			return -EINVAL;
+
+		if (!data->ops->query || !data->iommu_owner)
+			return -ENOSYS;
+
+		ret = data->ops->query(data,
+				&query.windows_available,
+				&query.page_size_mask);
+
+		if (ret)
+			return ret;
+
+		if (copy_to_user((void __user *)arg, &query, minsz))
+			return -EFAULT;
+
+		return 0;
+	}
+	case VFIO_IOMMU_SPAPR_TCE_CREATE: {
+		struct vfio_iommu_spapr_tce_create create;
+		struct spapr_tce_iommu_group *data;
+		struct iommu_table *tbl;
+
+		if (WARN_ON(!container->grp))
+			return -ENXIO;
+
+		data = iommu_group_get_iommudata(container->grp);
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
+		if (!data->ops->create || !data->iommu_owner)
+			return -ENOSYS;
+
+		BUG_ON(!data || !data->ops || !data->ops->remove);
+
+		ret = data->ops->create(data, create.page_shift,
+				create.window_shift, &tbl);
+		if (ret)
+			return ret;
+
+		ret = try_increment_locked_vm((tbl->it_size <<
+					tbl->it_page_shift) >> PAGE_SHIFT);
+		if (ret) {
+			data->ops->remove(data, tbl);
+			return ret;
+		}
+
+		create.start_addr = tbl->it_offset << tbl->it_page_shift;
+
+		if (copy_to_user((void __user *)arg, &create, minsz)) {
+			data->ops->remove(data, tbl);
+			decrement_locked_vm((tbl->it_size <<
+					tbl->it_page_shift) >> PAGE_SHIFT);
+			return -EFAULT;
+		}
+
+		return ret;
+	}
+	case VFIO_IOMMU_SPAPR_TCE_REMOVE: {
+		struct vfio_iommu_spapr_tce_remove remove;
+		struct spapr_tce_iommu_group *data;
+		struct iommu_table *tbl;
+
+		if (WARN_ON(!container->grp))
+			return -ENXIO;
+
+		data = iommu_group_get_iommudata(container->grp);
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
+		if (!data->ops->remove || !data->iommu_owner)
+			return -ENOSYS;
+
+		tbl = data->ops->get_table(data, remove.start_addr);
+		if (!tbl)
+			return -EINVAL;
+
+		ret = data->ops->remove(data, tbl);
+		if (ret)
+			return ret;
+
+		decrement_locked_vm((tbl->it_size << tbl->it_page_shift)
+				>> PAGE_SHIFT);
+		return 0;
+	}
+	case VFIO_IOMMU_SPAPR_TCE_RESET: {
+		struct vfio_iommu_spapr_tce_reset reset;
+		struct spapr_tce_iommu_group *data;
+
+		if (WARN_ON(!container->grp))
+			return -ENXIO;
+
+		data = iommu_group_get_iommudata(container->grp);
+
+		minsz = offsetofend(struct vfio_iommu_spapr_tce_reset, argsz);
+
+		if (copy_from_user(&reset, (void __user *)arg, minsz))
+			return -EFAULT;
+
+		if (reset.argsz < minsz)
+			return -EINVAL;
+
+		if (!data->ops->reset || !data->iommu_owner)
+			return -ENOSYS;
+
+		ret = data->ops->reset(data);
+		if (ret)
+			return ret;
+
+		if (container->start64) {
+			struct iommu_table *tbl;
+
+			tbl = data->ops->get_table(data, container->start64);
+			BUG_ON(!tbl);
+
+			decrement_locked_vm((tbl->it_size << tbl->it_page_shift)
+					>> PAGE_SHIFT);
+		}
+
+		return 0;
+	}
 	}
 
 	return -ENOTTY;
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index cb9023d..8b03381 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -448,13 +448,48 @@ struct vfio_iommu_type1_dma_unmap {
  */
 struct vfio_iommu_spapr_tce_info {
 	__u32 argsz;
-	__u32 flags;			/* reserved for future use */
+	__u32 flags;
+#define VFIO_IOMMU_SPAPR_TCE_FLAG_DDW	1 /* Support dynamic windows */
 	__u32 dma32_window_start;	/* 32 bit window start (bytes) */
 	__u32 dma32_window_size;	/* 32 bit window size (bytes) */
 };
 
 #define VFIO_IOMMU_SPAPR_TCE_GET_INFO	_IO(VFIO_TYPE, VFIO_BASE + 12)
 
+/*
+ * Dynamic DMA windows
+ */
+struct vfio_iommu_spapr_tce_query {
+	__u32 argsz;
+	/* out */
+	__u32 windows_available;
+	__u32 page_size_mask;
+};
+#define VFIO_IOMMU_SPAPR_TCE_QUERY	_IO(VFIO_TYPE, VFIO_BASE + 17)
+
+struct vfio_iommu_spapr_tce_create {
+	__u32 argsz;
+	/* in */
+	__u32 page_shift;
+	__u32 window_shift;
+	/* out */
+	__u64 start_addr;
+
+};
+#define VFIO_IOMMU_SPAPR_TCE_CREATE	_IO(VFIO_TYPE, VFIO_BASE + 18)
+
+struct vfio_iommu_spapr_tce_remove {
+	__u32 argsz;
+	/* in */
+	__u64 start_addr;
+};
+#define VFIO_IOMMU_SPAPR_TCE_REMOVE	_IO(VFIO_TYPE, VFIO_BASE + 19)
+
+struct vfio_iommu_spapr_tce_reset {
+	__u32 argsz;
+};
+#define VFIO_IOMMU_SPAPR_TCE_RESET	_IO(VFIO_TYPE, VFIO_BASE + 20)
+
 /* ***************************************************************** */
 
 #endif /* _UAPIVFIO_H */
-- 
2.0.0
