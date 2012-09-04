Return-Path: <aik@ozlabs.ru>
Received: from mail-ie0-f179.google.com (mail-ie0-f179.google.com
 [209.85.223.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 0D9652C0090
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Sep 2012 17:34:17 +1000 (EST)
Received: by ieje13 with SMTP id e13so4130758iej.38
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Sep 2012 00:34:14 -0700 (PDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH] vfio: enabled and supported on power (v7)
Date: Tue,  4 Sep 2012 17:33:55 +1000
Message-Id: <1346744035-31154-1-git-send-email-aik@ozlabs.ru>
In-Reply-To: <20120821113534.GS29724@truffula.fritz.box>
References: <20120821113534.GS29724@truffula.fritz.box>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Cc: David Gibson <david@gibson.dropbear.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/include/asm/iommu.h    |    3 +
 drivers/iommu/Kconfig               |    8 +
 drivers/vfio/Kconfig                |    6 +
 drivers/vfio/Makefile               |    1 +
 drivers/vfio/vfio_iommu_spapr_tce.c |  440 +++++++++++++++++++++++++++++++++++
 include/linux/vfio.h                |   29 +++
 6 files changed, 487 insertions(+)
 create mode 100644 drivers/vfio/vfio_iommu_spapr_tce.c

diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/iommu.h
index 957a83f..c64bce7 100644
--- a/arch/powerpc/include/asm/iommu.h
+++ b/arch/powerpc/include/asm/iommu.h
@@ -66,6 +66,9 @@ struct iommu_table {
 	unsigned long  it_halfpoint; /* Breaking point for small/large allocs */
 	spinlock_t     it_lock;      /* Protects it_map */
 	unsigned long *it_map;       /* A simple allocation bitmap for now */
+#ifdef CONFIG_IOMMU_API
+	struct iommu_group *it_group;
+#endif
 };
 
 struct scatterlist;
diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 3bd9fff..19cf2d9 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -162,4 +162,12 @@ config TEGRA_IOMMU_SMMU
 	  space through the SMMU (System Memory Management Unit)
 	  hardware included on Tegra SoCs.
 
+config SPAPR_TCE_IOMMU
+	bool "sPAPR TCE IOMMU Support"
+	depends on PPC_PSERIES
+	select IOMMU_API
+	help
+	  Enables bits of IOMMU API required by VFIO. The iommu_ops is
+	  still not implemented.
+
 endif # IOMMU_SUPPORT
diff --git a/drivers/vfio/Kconfig b/drivers/vfio/Kconfig
index 7cd5dec..b464687 100644
--- a/drivers/vfio/Kconfig
+++ b/drivers/vfio/Kconfig
@@ -3,10 +3,16 @@ config VFIO_IOMMU_TYPE1
 	depends on VFIO
 	default n
 
+config VFIO_IOMMU_SPAPR_TCE
+	tristate
+	depends on VFIO && SPAPR_TCE_IOMMU
+	default n
+
 menuconfig VFIO
 	tristate "VFIO Non-Privileged userspace driver framework"
 	depends on IOMMU_API
 	select VFIO_IOMMU_TYPE1 if X86
+	select VFIO_IOMMU_SPAPR_TCE if PPC_POWERNV
 	help
 	  VFIO provides a framework for secure userspace device drivers.
 	  See Documentation/vfio.txt for more details.
diff --git a/drivers/vfio/Makefile b/drivers/vfio/Makefile
index 2398d4a..72bfabc 100644
--- a/drivers/vfio/Makefile
+++ b/drivers/vfio/Makefile
@@ -1,3 +1,4 @@
 obj-$(CONFIG_VFIO) += vfio.o
 obj-$(CONFIG_VFIO_IOMMU_TYPE1) += vfio_iommu_type1.o
+obj-$(CONFIG_VFIO_IOMMU_SPAPR_TCE) += vfio_iommu_spapr_tce.o
 obj-$(CONFIG_VFIO_PCI) += pci/
diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
new file mode 100644
index 0000000..21f1909
--- /dev/null
+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
@@ -0,0 +1,440 @@
+/*
+ * VFIO: IOMMU DMA mapping support for TCE on POWER
+ *
+ * Copyright (C) 2012 IBM Corp.  All rights reserved.
+ *     Author: Alexey Kardashevskiy <aik@ozlabs.ru>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Derived from original vfio_iommu_x86.c:
+ * Copyright (C) 2012 Red Hat, Inc.  All rights reserved.
+ *     Author: Alex Williamson <alex.williamson@redhat.com>
+ */
+
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/slab.h>
+#include <linux/uaccess.h>
+#include <linux/err.h>
+#include <linux/vfio.h>
+#include <linux/spinlock.h>
+#include <asm/iommu.h>
+
+#define DRIVER_VERSION  "0.1"
+#define DRIVER_AUTHOR   "aik@ozlabs.ru"
+#define DRIVER_DESC     "VFIO IOMMU SPAPR TCE"
+
+
+/*
+ * SPAPR TCE API
+ */
+static void tce_free(struct iommu_table *tbl, unsigned long entry,
+		unsigned long tce)
+{
+	struct page *page = pfn_to_page(tce >> PAGE_SHIFT);
+
+	WARN_ON(!page);
+	if (page) {
+		if (tce & VFIO_SPAPR_TCE_WRITE)
+			SetPageDirty(page);
+		put_page(page);
+	}
+	ppc_md.tce_free(tbl, entry, 1);
+}
+
+static long tce_put(struct iommu_table *tbl,
+		unsigned long entry, uint64_t tce, uint32_t flags)
+{
+	int ret;
+	unsigned long oldtce, kva, offset;
+	struct page *page = NULL;
+	enum dma_data_direction direction = DMA_NONE;
+
+	switch (flags & VFIO_SPAPR_TCE_PUT_MASK) {
+	case VFIO_SPAPR_TCE_READ:
+		direction = DMA_TO_DEVICE;
+		break;
+	case VFIO_SPAPR_TCE_WRITE:
+		direction = DMA_FROM_DEVICE;
+		break;
+	case VFIO_SPAPR_TCE_BIDIRECTIONAL:
+		direction = DMA_BIDIRECTIONAL;
+		break;
+	}
+
+	oldtce = ppc_md.tce_get(tbl, entry);
+
+	/* Free page if still allocated */
+	if (oldtce & VFIO_SPAPR_TCE_PUT_MASK)
+		tce_free(tbl, entry, oldtce);
+
+	/* Map new TCE */
+	if (direction != DMA_NONE) {
+		offset = (tce & IOMMU_PAGE_MASK) - (tce & PAGE_MASK);
+		ret = get_user_pages_fast(tce & PAGE_MASK, 1,
+				direction != DMA_TO_DEVICE, &page);
+		BUG_ON(ret > 1);
+		if (ret < 1) {
+			printk(KERN_ERR "tce_vfio: get_user_pages_fast failed "
+					"tce=%llx ioba=%lx ret=%d\n",
+					tce, entry << IOMMU_PAGE_SHIFT, ret);
+			if (!ret)
+				ret = -EFAULT;
+			goto unlock_exit;
+		}
+
+		kva = (unsigned long) page_address(page);
+		kva += offset;
+		BUG_ON(!kva);
+		if (WARN_ON(kva & ~IOMMU_PAGE_MASK))
+			return -EINVAL;
+
+		/* Preserve access bits */
+		kva |= flags & VFIO_SPAPR_TCE_PUT_MASK;
+
+		/* tce_build receives a virtual address */
+		entry += tbl->it_offset;	/* Offset into real TCE table */
+		ret = ppc_md.tce_build(tbl, entry, 1, kva, direction, NULL);
+
+		/* tce_build() only returns non-zero for transient errors */
+		if (unlikely(ret)) {
+			printk(KERN_ERR "tce_vfio: Failed to add TCE\n");
+			ret = -EIO;
+			goto unlock_exit;
+		}
+	}
+	/* Flush/invalidate TLB caches if necessary */
+	if (ppc_md.tce_flush)
+		ppc_md.tce_flush(tbl);
+
+	/* Make sure updates are seen by hardware */
+	mb();
+
+unlock_exit:
+	if (ret && page)
+		put_page(page);
+
+	if (ret)
+		printk(KERN_ERR "tce_vfio: tce_put failed on tce=%llx "
+				"ioba=%lx kva=%lx\n", tce,
+				entry << IOMMU_PAGE_SHIFT, kva);
+	return ret;
+}
+
+/*
+ * VFIO IOMMU fd for SPAPR_TCE IOMMU implementation
+ */
+
+/*
+ * The container descriptor supports only a single group per container.
+ * Required by the API as the container is not supplied with the IOMMU group
+ * at the moment of initialization.
+ */
+struct tce_container {
+	struct iommu_table *tbl;
+};
+
+static void *tce_iommu_open(unsigned long arg)
+{
+	struct tce_container *container;
+
+	if (arg != VFIO_SPAPR_TCE_IOMMU) {
+		printk(KERN_ERR "tce_vfio: Wrong IOMMU type\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	container = kzalloc(sizeof(*container), GFP_KERNEL);
+	if (!container)
+		return ERR_PTR(-ENOMEM);
+
+	return container;
+}
+
+static void tce_iommu_release(void *iommu_data)
+{
+	struct tce_container *container = iommu_data;
+	struct iommu_table *tbl = container->tbl;
+	unsigned long i, tce;
+
+	/* Unmap leftovers */
+	spin_lock_irq(&tbl->it_lock);
+	for (i = tbl->it_offset; i < tbl->it_offset + tbl->it_size; ++i) {
+		tce = ppc_md.tce_get(tbl, i);
+		if (tce & VFIO_SPAPR_TCE_PUT_MASK)
+			tce_free(tbl, i, tce);
+	}
+	/* Flush/invalidate TLB caches if necessary */
+	if (ppc_md.tce_flush)
+		ppc_md.tce_flush(tbl);
+
+	/* Make sure updates are seen by hardware */
+	mb();
+
+	spin_unlock_irq(&tbl->it_lock);
+
+	kfree(container);
+}
+
+static long tce_iommu_ioctl(void *iommu_data,
+				 unsigned int cmd, unsigned long arg)
+{
+	struct tce_container *container = iommu_data;
+	unsigned long minsz;
+	long ret;
+
+	switch (cmd) {
+	case VFIO_CHECK_EXTENSION: {
+		return (arg == VFIO_SPAPR_TCE_IOMMU) ? 1 : 0;
+	}
+	case VFIO_IOMMU_SPAPR_TCE_GET_INFO: {
+		struct vfio_iommu_spapr_tce_info info;
+		struct iommu_table *tbl = container->tbl;
+
+		minsz = offsetofend(struct vfio_iommu_spapr_tce_info,
+				dma64_window_size);
+
+		if (copy_from_user(&info, (void __user *)arg, minsz))
+			return -EFAULT;
+
+		if (info.argsz < minsz)
+			return -EINVAL;
+
+		if (!tbl)
+			return -ENXIO;
+
+		info.dma32_window_start = tbl->it_offset << IOMMU_PAGE_SHIFT;
+		info.dma32_window_size = tbl->it_size << IOMMU_PAGE_SHIFT;
+		info.dma64_window_start = 0;
+		info.dma64_window_size = 0;
+		info.flags = 0;
+
+		return copy_to_user((void __user *)arg, &info, minsz);
+	}
+	case VFIO_IOMMU_SPAPR_TCE_PUT: {
+		struct vfio_iommu_spapr_tce_put par;
+		struct iommu_table *tbl = container->tbl;
+
+		minsz = offsetofend(struct vfio_iommu_spapr_tce_put, tce);
+
+		if (copy_from_user(&par, (void __user *)arg, minsz))
+			return -EFAULT;
+
+		if (par.argsz < minsz)
+			return -EINVAL;
+
+		if (!tbl) {
+			return -ENXIO;
+		}
+
+		spin_lock_irq(&tbl->it_lock);
+		ret = tce_put(tbl, par.ioba >> IOMMU_PAGE_SHIFT,
+				par.tce, par.flags);
+		spin_unlock_irq(&tbl->it_lock);
+
+		return ret;
+	}
+	default:
+		printk(KERN_WARNING "tce_vfio: unexpected cmd %x\n", cmd);
+	}
+
+	return -ENOTTY;
+}
+
+static int tce_iommu_attach_group(void *iommu_data,
+		struct iommu_group *iommu_group)
+{
+	struct tce_container *container = iommu_data;
+	struct iommu_table *tbl = iommu_group_get_iommudata(iommu_group);
+
+	printk(KERN_DEBUG "tce_vfio: Attaching group #%u to iommu %p\n",
+			iommu_group_id(iommu_group), iommu_group);
+	if (container->tbl) {
+		printk(KERN_WARNING "tce_vfio: Only one group per IOMMU "
+				"container is allowed, "
+				"existing id=%d, attaching id=%d\n",
+				iommu_group_id(container->tbl->it_group),
+				iommu_group_id(iommu_group));
+		return -EBUSY;
+	}
+
+	container->tbl = tbl;
+
+	return 0;
+}
+
+static void tce_iommu_detach_group(void *iommu_data,
+		struct iommu_group *iommu_group)
+{
+	struct tce_container *container = iommu_data;
+	struct iommu_table *tbl = iommu_group_get_iommudata(iommu_group);
+
+	BUG_ON(!tbl);
+	if (tbl != container->tbl) {
+		printk(KERN_WARNING "tce_vfio: detaching group #%u, expected "
+				"group is #%u\n", iommu_group_id(iommu_group),
+				iommu_group_id(tbl->it_group));
+		return;
+	}
+	printk(KERN_DEBUG "tce_vfio: detaching group #%u from iommu %p\n",
+			iommu_group_id(iommu_group), iommu_group);
+}
+
+const struct vfio_iommu_driver_ops tce_iommu_driver_ops = {
+	.name		= "iommu-vfio-powerpc",
+	.owner		= THIS_MODULE,
+	.open		= tce_iommu_open,
+	.release	= tce_iommu_release,
+	.ioctl		= tce_iommu_ioctl,
+	.attach_group	= tce_iommu_attach_group,
+	.detach_group	= tce_iommu_detach_group,
+};
+
+/*
+ * Add/delete devices support (hotplug, module_init, module_exit)
+ */
+static int add_device(struct device *dev)
+{
+	struct iommu_table *tbl;
+	int ret = 0;
+
+	if (dev->iommu_group) {
+		printk(KERN_WARNING "tce_vfio: device %s is already in iommu "
+				"group %d, skipping\n", dev->kobj.name,
+				iommu_group_id(dev->iommu_group));
+		return -EBUSY;
+	}
+
+	tbl = get_iommu_table_base(dev);
+	if (!tbl) {
+		printk(KERN_DEBUG "tce_vfio: skipping device %s with no tbl\n",
+				dev->kobj.name);
+		return 0;
+	}
+
+	printk(KERN_DEBUG "tce_vfio: adding %s to iommu group %d\n",
+			dev->kobj.name, iommu_group_id(tbl->it_group));
+
+	ret = iommu_group_add_device(tbl->it_group, dev);
+	if (ret < 0)
+		printk(KERN_ERR "tce_vfio: %s has not been added, ret=%d\n",
+				dev->kobj.name, ret);
+
+	return ret;
+}
+
+static void del_device(struct device *dev)
+{
+	iommu_group_remove_device(dev);
+}
+
+static int iommu_bus_notifier(struct notifier_block *nb,
+			      unsigned long action, void *data)
+{
+	struct device *dev = data;
+
+	switch (action) {
+	case BUS_NOTIFY_ADD_DEVICE:
+		return add_device(dev);
+	case BUS_NOTIFY_DEL_DEVICE:
+		del_device(dev);
+		return 0;
+	default:
+		return 0;
+	}
+}
+
+static struct notifier_block tce_iommu_bus_nb = {
+	.notifier_call = iommu_bus_notifier,
+};
+
+void group_release(void *iommu_data)
+{
+	struct iommu_table *tbl = iommu_data;
+	tbl->it_group = NULL;
+}
+
+static int __init tce_iommu_init(void)
+{
+	struct pci_dev *pdev = NULL;
+	struct iommu_table *tbl;
+	struct iommu_group *grp;
+
+	/* If the current platform does not support tce_get
+	   we are unable to clean TCE table properly and
+	   therefore it is better not to touch it at all */
+	if (!ppc_md.tce_get) {
+		printk(KERN_ERR "tce_vfio: ppc_md.tce_get isn't implemented\n");
+		return -EOPNOTSUPP;
+	}
+
+	bus_register_notifier(&pci_bus_type, &tce_iommu_bus_nb);
+
+	/* Allocate and initialize VFIO groups */
+	for_each_pci_dev(pdev) {
+		tbl = get_iommu_table_base(&pdev->dev);
+		if (!tbl)
+			continue;
+
+		/* Skip already initialized */
+		if (tbl->it_group)
+			continue;
+
+		grp = iommu_group_alloc();
+		if (IS_ERR(grp)) {
+			printk(KERN_INFO "tce_vfio: cannot create "
+					"new IOMMU group, ret=%ld\n",
+					PTR_ERR(grp));
+			return -EFAULT;
+		}
+		tbl->it_group = grp;
+		iommu_group_set_iommudata(grp, tbl, group_release);
+	}
+
+	/* Add PCI devices to VFIO groups */
+	for_each_pci_dev(pdev)
+		add_device(&pdev->dev);
+
+	return vfio_register_iommu_driver(&tce_iommu_driver_ops);
+}
+
+static void __exit tce_iommu_cleanup(void)
+{
+	struct pci_dev *pdev = NULL;
+	struct iommu_table *tbl;
+	struct iommu_group *grp = NULL;
+
+	bus_unregister_notifier(&pci_bus_type, &tce_iommu_bus_nb);
+
+	/* Delete PCI devices from VFIO groups */
+	for_each_pci_dev(pdev)
+		del_device(&pdev->dev);
+
+	/* Release VFIO groups */
+	for_each_pci_dev(pdev) {
+		tbl = get_iommu_table_base(&pdev->dev);
+		if (!tbl)
+			continue;
+		grp = tbl->it_group;
+
+		/* Skip (already) uninitialized */
+		if (!grp)
+			continue;
+
+		/* Do actual release, group_release() is expected to work */
+		iommu_group_put(grp);
+		BUG_ON(tbl->it_group);
+	}
+
+	vfio_unregister_iommu_driver(&tce_iommu_driver_ops);
+}
+
+module_init(tce_iommu_init);
+module_exit(tce_iommu_cleanup);
+
+MODULE_VERSION(DRIVER_VERSION);
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR(DRIVER_AUTHOR);
+MODULE_DESCRIPTION(DRIVER_DESC);
+
diff --git a/include/linux/vfio.h b/include/linux/vfio.h
index 0a4f180..2c0a927 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -99,6 +99,7 @@ extern void vfio_unregister_iommu_driver(
 /* Extensions */
 
 #define VFIO_TYPE1_IOMMU		1
+#define VFIO_SPAPR_TCE_IOMMU		2
 
 /*
  * The IOCTL interface is designed for extensibility by embedding the
@@ -442,4 +443,32 @@ struct vfio_iommu_type1_dma_unmap {
 
 #define VFIO_IOMMU_UNMAP_DMA _IO(VFIO_TYPE, VFIO_BASE + 14)
 
+/* -------- API for SPAPR TCE (Server POWERPC) IOMMU -------- */
+
+struct vfio_iommu_spapr_tce_info {
+	__u32 argsz;
+	__u32 flags;
+	__u32 dma32_window_start;
+	__u32 dma32_window_size;
+	__u64 dma64_window_start;
+	__u64 dma64_window_size;
+};
+
+#define VFIO_IOMMU_SPAPR_TCE_GET_INFO	_IO(VFIO_TYPE, VFIO_BASE + 12)
+
+struct vfio_iommu_spapr_tce_put {
+	__u32 argsz;
+	__u32 flags;
+#define VFIO_SPAPR_TCE_READ		1
+#define VFIO_SPAPR_TCE_WRITE		2
+#define VFIO_SPAPR_TCE_BIDIRECTIONAL	(VFIO_SPAPR_TCE_READ|VFIO_SPAPR_TCE_WRITE)
+#define VFIO_SPAPR_TCE_PUT_MASK		VFIO_SPAPR_TCE_BIDIRECTIONAL
+	__u64 ioba;
+	__u64 tce;
+};
+
+#define VFIO_IOMMU_SPAPR_TCE_PUT	_IO(VFIO_TYPE, VFIO_BASE + 13)
+
+/* ***************************************************************** */
+
 #endif /* VFIO_H */
-- 
1.7.10.4
