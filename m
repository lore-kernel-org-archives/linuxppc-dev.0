Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 1D10B67B4A
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Apr 2006 17:24:47 +1000 (EST)
Received: from localhost (bh02i525f01.au.ibm.com [202.81.18.30])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by smtps.tip.net.au (Postfix) with ESMTP id CE07D3682CD
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Apr 2006 17:24:46 +1000 (EST)
Date: Thu, 27 Apr 2006 17:23:32 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: ppc-dev <linuxppc-dev@ozlabs.org>
Subject: [PATCH 4/4] powerpc: merge the rest of the vio code
Message-Id: <20060427172332.299248d3.sfr@canb.auug.org.au>
In-Reply-To: <20060427172146.4660a953.sfr@canb.auug.org.au>
References: <20060427170902.51a5a098.sfr@canb.auug.org.au>
	<20060427171821.6ebdf3fb.sfr@canb.auug.org.au>
	<20060427172146.4660a953.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---

 arch/powerpc/kernel/vio.c               |  198 ++++++++++++++++++++++++++-----
 arch/powerpc/platforms/iseries/Makefile |    1 
 arch/powerpc/platforms/iseries/iommu.c  |    3 
 arch/powerpc/platforms/iseries/iommu.h  |   35 -----
 arch/powerpc/platforms/iseries/pci.c    |    2 
 arch/powerpc/platforms/iseries/vio.c    |   67 ----------
 arch/powerpc/platforms/pseries/Makefile |    1 
 arch/powerpc/platforms/pseries/vio.c    |  133 ---------------------
 include/asm-powerpc/iseries/iommu.h     |   35 +++++
 include/asm-powerpc/vio.h               |    8 -
 10 files changed, 201 insertions(+), 282 deletions(-)
 delete mode 100644 arch/powerpc/platforms/iseries/iommu.h
 delete mode 100644 arch/powerpc/platforms/iseries/vio.c
 delete mode 100644 arch/powerpc/platforms/pseries/vio.c
 create mode 100644 include/asm-powerpc/iseries/iommu.h

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

d79e3d667af2d5babcc931a71aa536ff150ba541
diff --git a/arch/powerpc/kernel/vio.c b/arch/powerpc/kernel/vio.c
index 1952929..ac5c7bf 100644
--- a/arch/powerpc/kernel/vio.c
+++ b/arch/powerpc/kernel/vio.c
@@ -13,25 +13,102 @@
  *      2 of the License, or (at your option) any later version.
  */
 
+#include <linux/types.h>
+#include <linux/device.h>
 #include <linux/init.h>
 #include <linux/console.h>
 #include <linux/module.h>
 #include <linux/mm.h>
 #include <linux/dma-mapping.h>
+#include <linux/kobject.h>
+
 #include <asm/iommu.h>
 #include <asm/dma.h>
 #include <asm/vio.h>
 #include <asm/prom.h>
 #include <asm/firmware.h>
-
-struct vio_dev vio_bus_device  = { /* fake "parent" device */
+#include <asm/tce.h>
+#include <asm/abs_addr.h>
+#include <asm/page.h>
+#include <asm/hvcall.h>
+#include <asm/iseries/vio.h>
+#include <asm/iseries/hv_types.h>
+#include <asm/iseries/hv_lp_config.h>
+#include <asm/iseries/hv_call_xm.h>
+#include <asm/iseries/iommu.h>
+
+extern struct subsystem devices_subsys; /* needed for vio_find_name() */
+
+static struct vio_dev vio_bus_device  = { /* fake "parent" device */
 	.name = vio_bus_device.dev.bus_id,
 	.type = "",
 	.dev.bus_id = "vio",
 	.dev.bus = &vio_bus_type,
 };
 
-static struct vio_bus_ops vio_bus_ops;
+#ifdef CONFIG_PPC_ISERIES
+struct device *iSeries_vio_dev = &vio_bus_device.dev;
+EXPORT_SYMBOL(iSeries_vio_dev);
+
+static struct iommu_table veth_iommu_table;
+static struct iommu_table vio_iommu_table;
+
+static void __init iommu_vio_init(void)
+{
+	iommu_table_getparms_iSeries(255, 0, 0xff, &veth_iommu_table);
+	veth_iommu_table.it_size /= 2;
+	vio_iommu_table = veth_iommu_table;
+	vio_iommu_table.it_offset += veth_iommu_table.it_size;
+
+	if (!iommu_init_table(&veth_iommu_table))
+		printk("Virtual Bus VETH TCE table failed.\n");
+	if (!iommu_init_table(&vio_iommu_table))
+		printk("Virtual Bus VIO TCE table failed.\n");
+}
+#endif
+
+static struct iommu_table *vio_build_iommu_table(struct vio_dev *dev)
+{
+#ifdef CONFIG_PPC_ISERIES
+	if (firmware_has_feature(FW_FEATURE_ISERIES)) {
+		if (strcmp(dev->type, "vlan") == 0)
+			return &veth_iommu_table;
+		return &vio_iommu_table;
+	} else
+#endif
+	{
+		unsigned int *dma_window;
+		struct iommu_table *newTceTable;
+		unsigned long offset;
+		int dma_window_property_size;
+
+		dma_window = (unsigned int *)get_property(
+				dev->dev.platform_data, "ibm,my-dma-window",
+				&dma_window_property_size);
+		if (!dma_window)
+			return NULL;
+
+		newTceTable = kmalloc(sizeof(struct iommu_table), GFP_KERNEL);
+
+		/*
+		 * There should be some code to extract the phys-encoded
+		 * offset using prom_n_addr_cells(). However, according to
+		 * a comment on earlier versions, it's always zero, so we
+		 * don't bother
+		 */
+		offset = dma_window[1] >>  PAGE_SHIFT;
+
+		/* TCE table size - measured in tce entries */
+		newTceTable->it_size = dma_window[4] >> PAGE_SHIFT;
+		/* offset for VIO should always be 0 */
+		newTceTable->it_offset = offset;
+		newTceTable->it_busno = 0;
+		newTceTable->it_index = (unsigned long)dma_window[0];
+		newTceTable->it_type = TCE_VB;
+
+		return iommu_init_table(newTceTable);
+	}
+}
 
 /**
  * vio_match_device: - Tell if a VIO device has a matching
@@ -126,6 +203,16 @@ void vio_unregister_driver(struct vio_dr
 }
 EXPORT_SYMBOL(vio_unregister_driver);
 
+/* vio_dev refcount hit 0 */
+static void __devinit vio_dev_release(struct device *dev)
+{
+	if (dev->platform_data) {
+		/* XXX free TCE table */
+		of_node_put(dev->platform_data);
+	}
+	kfree(to_vio_dev(dev));
+}
+
 /**
  * vio_register_device_node: - Register a new vio device.
  * @of_node:	The OF node for this device.
@@ -185,10 +272,17 @@ struct vio_dev * __devinit vio_register_
 		if (unit_address != NULL)
 			viodev->unit_address = *unit_address;
 	}
-	viodev->iommu_table = vio_bus_ops.build_iommu_table(viodev);
+	viodev->iommu_table = vio_build_iommu_table(viodev);
+
+	/* init generic 'struct device' fields: */
+	viodev->dev.parent = &vio_bus_device.dev;
+	viodev->dev.bus = &vio_bus_type;
+	viodev->dev.release = vio_dev_release;
 
 	/* register with generic device framework */
-	if (vio_register_device(viodev) == NULL) {
+	if (device_register(&viodev->dev)) {
+		printk(KERN_ERR "%s: failed to register device %s\n",
+				__FUNCTION__, viodev->dev.bus_id);
 		/* XXX free TCE table */
 		kfree(viodev);
 		return NULL;
@@ -201,12 +295,18 @@ EXPORT_SYMBOL(vio_register_device_node);
 /**
  * vio_bus_init: - Initialize the virtual IO bus
  */
-int __init vio_bus_init(struct vio_bus_ops *ops)
+static int __init vio_bus_init(void)
 {
 	int err;
 	struct device_node *node_vroot;
 
-	vio_bus_ops = *ops;
+#ifdef CONFIG_PPC_ISERIES
+	if (firmware_has_feature(FW_FEATURE_ISERIES)) {
+		iommu_vio_init();
+		vio_bus_device.iommu_table = &vio_iommu_table;
+		iSeries_vio_dev = &vio_bus_device.dev;
+	}
+#endif
 
 	err = bus_register(&vio_bus_type);
 	if (err) {
@@ -243,16 +343,7 @@ int __init vio_bus_init(struct vio_bus_o
 
 	return 0;
 }
-
-/* vio_dev refcount hit 0 */
-static void __devinit vio_dev_release(struct device *dev)
-{
-	if (dev->platform_data) {
-		/* XXX free TCE table */
-		of_node_put(dev->platform_data);
-	}
-	kfree(to_vio_dev(dev));
-}
+__initcall(vio_bus_init);
 
 static ssize_t name_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
@@ -274,23 +365,6 @@ static struct device_attribute vio_dev_a
 	__ATTR_NULL
 };
 
-struct vio_dev * __devinit vio_register_device(struct vio_dev *viodev)
-{
-	/* init generic 'struct device' fields: */
-	viodev->dev.parent = &vio_bus_device.dev;
-	viodev->dev.bus = &vio_bus_type;
-	viodev->dev.release = vio_dev_release;
-
-	/* register with generic device framework */
-	if (device_register(&viodev->dev)) {
-		printk(KERN_ERR "%s: failed to register device %s\n",
-				__FUNCTION__, viodev->dev.bus_id);
-		return NULL;
-	}
-
-	return viodev;
-}
-
 void __devinit vio_unregister_device(struct vio_dev *viodev)
 {
 	device_unregister(&viodev->dev);
@@ -412,3 +486,59 @@ const void *vio_get_attribute(struct vio
 	return get_property(vdev->dev.platform_data, which, length);
 }
 EXPORT_SYMBOL(vio_get_attribute);
+
+#ifdef CONFIG_PPC_PSERIES
+/* vio_find_name() - internal because only vio.c knows how we formatted the
+ * kobject name
+ * XXX once vio_bus_type.devices is actually used as a kset in
+ * drivers/base/bus.c, this function should be removed in favor of
+ * "device_find(kobj_name, &vio_bus_type)"
+ */
+static struct vio_dev *vio_find_name(const char *kobj_name)
+{
+	struct kobject *found;
+
+	found = kset_find_obj(&devices_subsys.kset, kobj_name);
+	if (!found)
+		return NULL;
+
+	return to_vio_dev(container_of(found, struct device, kobj));
+}
+
+/**
+ * vio_find_node - find an already-registered vio_dev
+ * @vnode: device_node of the virtual device we're looking for
+ */
+struct vio_dev *vio_find_node(struct device_node *vnode)
+{
+	uint32_t *unit_address;
+	char kobj_name[BUS_ID_SIZE];
+
+	/* construct the kobject name from the device node */
+	unit_address = (uint32_t *)get_property(vnode, "reg", NULL);
+	if (!unit_address)
+		return NULL;
+	snprintf(kobj_name, BUS_ID_SIZE, "%x", *unit_address);
+
+	return vio_find_name(kobj_name);
+}
+EXPORT_SYMBOL(vio_find_node);
+
+int vio_enable_interrupts(struct vio_dev *dev)
+{
+	int rc = h_vio_signal(dev->unit_address, VIO_IRQ_ENABLE);
+	if (rc != H_SUCCESS)
+		printk(KERN_ERR "vio: Error 0x%x enabling interrupts\n", rc);
+	return rc;
+}
+EXPORT_SYMBOL(vio_enable_interrupts);
+
+int vio_disable_interrupts(struct vio_dev *dev)
+{
+	int rc = h_vio_signal(dev->unit_address, VIO_IRQ_DISABLE);
+	if (rc != H_SUCCESS)
+		printk(KERN_ERR "vio: Error 0x%x disabling interrupts\n", rc);
+	return rc;
+}
+EXPORT_SYMBOL(vio_disable_interrupts);
+#endif /* CONFIG_PPC_PSERIES */
diff --git a/arch/powerpc/platforms/iseries/Makefile b/arch/powerpc/platforms/iseries/Makefile
index ce8c0b9..7e67a20 100644
--- a/arch/powerpc/platforms/iseries/Makefile
+++ b/arch/powerpc/platforms/iseries/Makefile
@@ -3,7 +3,6 @@ EXTRA_CFLAGS	+= -mno-minimal-toc
 obj-y += hvlog.o hvlpconfig.o lpardata.o setup.o mf.o lpevents.o \
 	hvcall.o proc.o htab.o iommu.o misc.o irq.o
 obj-$(CONFIG_PCI) += pci.o vpdinfo.o
-obj-$(CONFIG_IBMVIO) += vio.o
 obj-$(CONFIG_SMP) += smp.o
 obj-$(CONFIG_VIOPATH) += viopath.o
 obj-$(CONFIG_MODULES) += ksyms.o
diff --git a/arch/powerpc/platforms/iseries/iommu.c b/arch/powerpc/platforms/iseries/iommu.c
index bea0b70..a8d9631 100644
--- a/arch/powerpc/platforms/iseries/iommu.c
+++ b/arch/powerpc/platforms/iseries/iommu.c
@@ -33,8 +33,7 @@ #include <asm/machdep.h>
 #include <asm/abs_addr.h>
 #include <asm/pci-bridge.h>
 #include <asm/iseries/hv_call_xm.h>
-
-#include "iommu.h"
+#include <asm/iseries/iommu.h>
 
 extern struct list_head iSeries_Global_Device_List;
 
diff --git a/arch/powerpc/platforms/iseries/iommu.h b/arch/powerpc/platforms/iseries/iommu.h
deleted file mode 100644
index cb5658f..0000000
--- a/arch/powerpc/platforms/iseries/iommu.h
+++ /dev/null
@@ -1,35 +0,0 @@
-#ifndef _PLATFORMS_ISERIES_IOMMU_H
-#define _PLATFORMS_ISERIES_IOMMU_H
-
-/*
- * Copyright (C) 2005  Stephen Rothwell, IBM Corporation
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the:
- * Free Software Foundation, Inc.,
- * 59 Temple Place, Suite 330,
- * Boston, MA  02111-1307  USA
- */
-
-struct device_node;
-struct iommu_table;
-
-/* Creates table for an individual device node */
-extern void iommu_devnode_init_iSeries(struct device_node *dn);
-
-/* Get table parameters from HV */
-extern void iommu_table_getparms_iSeries(unsigned long busno,
-		unsigned char slotno, unsigned char virtbus,
-		struct iommu_table *tbl);
-
-#endif /* _PLATFORMS_ISERIES_IOMMU_H */
diff --git a/arch/powerpc/platforms/iseries/pci.c b/arch/powerpc/platforms/iseries/pci.c
index 5a61c6f..428ffb5 100644
--- a/arch/powerpc/platforms/iseries/pci.c
+++ b/arch/powerpc/platforms/iseries/pci.c
@@ -37,13 +37,13 @@ #include <asm/abs_addr.h>
 
 #include <asm/iseries/hv_call_xm.h>
 #include <asm/iseries/mf.h>
+#include <asm/iseries/iommu.h>
 
 #include <asm/ppc-pci.h>
 
 #include "irq.h"
 #include "pci.h"
 #include "call_pci.h"
-#include "iommu.h"
 
 /*
  * Forward declares of prototypes.
diff --git a/arch/powerpc/platforms/iseries/vio.c b/arch/powerpc/platforms/iseries/vio.c
deleted file mode 100644
index bdd2b7d..0000000
--- a/arch/powerpc/platforms/iseries/vio.c
+++ /dev/null
@@ -1,67 +0,0 @@
-/*
- * IBM PowerPC iSeries Virtual I/O Infrastructure Support.
- *
- *    Copyright (c) 2005 Stephen Rothwell, IBM Corp.
- *
- *      This program is free software; you can redistribute it and/or
- *      modify it under the terms of the GNU General Public License
- *      as published by the Free Software Foundation; either version
- *      2 of the License, or (at your option) any later version.
- */
-#include <linux/types.h>
-#include <linux/device.h>
-#include <linux/init.h>
-
-#include <asm/vio.h>
-#include <asm/iommu.h>
-#include <asm/tce.h>
-#include <asm/abs_addr.h>
-#include <asm/page.h>
-#include <asm/iseries/vio.h>
-#include <asm/iseries/hv_types.h>
-#include <asm/iseries/hv_lp_config.h>
-#include <asm/iseries/hv_call_xm.h>
-
-#include "iommu.h"
-
-struct device *iSeries_vio_dev = &vio_bus_device.dev;
-EXPORT_SYMBOL(iSeries_vio_dev);
-
-static struct iommu_table veth_iommu_table;
-static struct iommu_table vio_iommu_table;
-
-static void __init iommu_vio_init(void)
-{
-	iommu_table_getparms_iSeries(255, 0, 0xff, &veth_iommu_table);
-	veth_iommu_table.it_size /= 2;
-	vio_iommu_table = veth_iommu_table;
-	vio_iommu_table.it_offset += veth_iommu_table.it_size;
-
-	if (!iommu_init_table(&veth_iommu_table))
-		printk("Virtual Bus VETH TCE table failed.\n");
-	if (!iommu_init_table(&vio_iommu_table))
-		printk("Virtual Bus VIO TCE table failed.\n");
-}
-
-static struct iommu_table *vio_build_iommu_table(struct vio_dev *dev)
-{
-	if (strcmp(dev->type, "vlan") == 0)
-		return &veth_iommu_table;
-	return &vio_iommu_table;
-}
-
-static struct vio_bus_ops vio_bus_ops_iseries = {
-	.build_iommu_table = vio_build_iommu_table,
-};
-
-/**
- * vio_bus_init_iseries: - Initialize the iSeries virtual IO bus
- */
-static int __init vio_bus_init_iseries(void)
-{
-	iommu_vio_init();
-	vio_bus_device.iommu_table = &vio_iommu_table;
-	iSeries_vio_dev = &vio_bus_device.dev;
-	return vio_bus_init(&vio_bus_ops_iseries);
-}
-__initcall(vio_bus_init_iseries);
diff --git a/arch/powerpc/platforms/pseries/Makefile b/arch/powerpc/platforms/pseries/Makefile
index 9308986..b46ce3b 100644
--- a/arch/powerpc/platforms/pseries/Makefile
+++ b/arch/powerpc/platforms/pseries/Makefile
@@ -2,7 +2,6 @@ obj-y			:= pci.o lpar.o hvCall.o nvram.o
 			   setup.o iommu.o ras.o rtasd.o pci_dlpar.o \
 			   firmware.o
 obj-$(CONFIG_SMP)	+= smp.o
-obj-$(CONFIG_IBMVIO)	+= vio.o
 obj-$(CONFIG_XICS)	+= xics.o
 obj-$(CONFIG_SCANLOG)	+= scanlog.o
 obj-$(CONFIG_EEH)	+= eeh.o eeh_cache.o eeh_driver.o eeh_event.o
diff --git a/arch/powerpc/platforms/pseries/vio.c b/arch/powerpc/platforms/pseries/vio.c
deleted file mode 100644
index d289166..0000000
--- a/arch/powerpc/platforms/pseries/vio.c
+++ /dev/null
@@ -1,133 +0,0 @@
-/*
- * IBM PowerPC pSeries Virtual I/O Infrastructure Support.
- *
- *    Copyright (c) 2003-2005 IBM Corp.
- *     Dave Engebretsen engebret@us.ibm.com
- *     Santiago Leon santil@us.ibm.com
- *     Hollis Blanchard <hollisb@us.ibm.com>
- *     Stephen Rothwell
- *
- *      This program is free software; you can redistribute it and/or
- *      modify it under the terms of the GNU General Public License
- *      as published by the Free Software Foundation; either version
- *      2 of the License, or (at your option) any later version.
- */
-
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/mm.h>
-#include <linux/kobject.h>
-#include <asm/iommu.h>
-#include <asm/dma.h>
-#include <asm/prom.h>
-#include <asm/vio.h>
-#include <asm/hvcall.h>
-#include <asm/tce.h>
-
-extern struct subsystem devices_subsys; /* needed for vio_find_name() */
-
-/**
- * vio_build_iommu_table: - gets the dma information from OF and
- *	builds the TCE tree.
- * @dev: the virtual device.
- *
- * Returns a pointer to the built tce tree, or NULL if it can't
- * find property.
-*/
-static struct iommu_table *vio_build_iommu_table(struct vio_dev *dev)
-{
-	unsigned int *dma_window;
-	struct iommu_table *newTceTable;
-	unsigned long offset;
-	int dma_window_property_size;
-
-	dma_window = (unsigned int *) get_property(dev->dev.platform_data, "ibm,my-dma-window", &dma_window_property_size);
-	if(!dma_window) {
-		return NULL;
-	}
-
-	newTceTable = (struct iommu_table *) kmalloc(sizeof(struct iommu_table), GFP_KERNEL);
-
-	/*  There should be some code to extract the phys-encoded offset
-		using prom_n_addr_cells(). However, according to a comment
-		on earlier versions, it's always zero, so we don't bother */
-	offset = dma_window[1] >>  PAGE_SHIFT;
-
-	/* TCE table size - measured in tce entries */
-	newTceTable->it_size		= dma_window[4] >> PAGE_SHIFT;
-	/* offset for VIO should always be 0 */
-	newTceTable->it_offset		= offset;
-	newTceTable->it_busno		= 0;
-	newTceTable->it_index		= (unsigned long)dma_window[0];
-	newTceTable->it_type		= TCE_VB;
-
-	return iommu_init_table(newTceTable);
-}
-
-static struct vio_bus_ops vio_bus_ops_pseries = {
-	.build_iommu_table = vio_build_iommu_table,
-};
-
-/**
- * vio_bus_init_pseries: - Initialize the pSeries virtual IO bus
- */
-static int __init vio_bus_init_pseries(void)
-{
-	return vio_bus_init(&vio_bus_ops_pseries);
-}
-
-__initcall(vio_bus_init_pseries);
-
-/* vio_find_name() - internal because only vio.c knows how we formatted the
- * kobject name
- * XXX once vio_bus_type.devices is actually used as a kset in
- * drivers/base/bus.c, this function should be removed in favor of
- * "device_find(kobj_name, &vio_bus_type)"
- */
-static struct vio_dev *vio_find_name(const char *kobj_name)
-{
-	struct kobject *found;
-
-	found = kset_find_obj(&devices_subsys.kset, kobj_name);
-	if (!found)
-		return NULL;
-
-	return to_vio_dev(container_of(found, struct device, kobj));
-}
-
-/**
- * vio_find_node - find an already-registered vio_dev
- * @vnode: device_node of the virtual device we're looking for
- */
-struct vio_dev *vio_find_node(struct device_node *vnode)
-{
-	uint32_t *unit_address;
-	char kobj_name[BUS_ID_SIZE];
-
-	/* construct the kobject name from the device node */
-	unit_address = (uint32_t *)get_property(vnode, "reg", NULL);
-	if (!unit_address)
-		return NULL;
-	snprintf(kobj_name, BUS_ID_SIZE, "%x", *unit_address);
-
-	return vio_find_name(kobj_name);
-}
-EXPORT_SYMBOL(vio_find_node);
-
-int vio_enable_interrupts(struct vio_dev *dev)
-{
-	int rc = h_vio_signal(dev->unit_address, VIO_IRQ_ENABLE);
-	if (rc != H_SUCCESS)
-		printk(KERN_ERR "vio: Error 0x%x enabling interrupts\n", rc);
-	return rc;
-}
-EXPORT_SYMBOL(vio_enable_interrupts);
-
-int vio_disable_interrupts(struct vio_dev *dev)
-{
-	int rc = h_vio_signal(dev->unit_address, VIO_IRQ_DISABLE);
-	if (rc != H_SUCCESS)
-		printk(KERN_ERR "vio: Error 0x%x disabling interrupts\n", rc);
-	return rc;
-}
-EXPORT_SYMBOL(vio_disable_interrupts);
diff --git a/include/asm-powerpc/iseries/iommu.h b/include/asm-powerpc/iseries/iommu.h
new file mode 100644
index 0000000..0edbfe1
--- /dev/null
+++ b/include/asm-powerpc/iseries/iommu.h
@@ -0,0 +1,35 @@
+#ifndef _ASM_POWERPC_ISERIES_IOMMU_H
+#define _ASM_POWERPC_ISERIES_IOMMU_H
+
+/*
+ * Copyright (C) 2005  Stephen Rothwell, IBM Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the:
+ * Free Software Foundation, Inc.,
+ * 59 Temple Place, Suite 330,
+ * Boston, MA  02111-1307  USA
+ */
+
+struct device_node;
+struct iommu_table;
+
+/* Creates table for an individual device node */
+extern void iommu_devnode_init_iSeries(struct device_node *dn);
+
+/* Get table parameters from HV */
+extern void iommu_table_getparms_iSeries(unsigned long busno,
+		unsigned char slotno, unsigned char virtbus,
+		struct iommu_table *tbl);
+
+#endif /* _ASM_POWERPC_ISERIES_IOMMU_H */
diff --git a/include/asm-powerpc/vio.h b/include/asm-powerpc/vio.h
index 9c09a8f..10da7f3 100644
--- a/include/asm-powerpc/vio.h
+++ b/include/asm-powerpc/vio.h
@@ -64,22 +64,14 @@ struct vio_driver {
 	struct device_driver driver;
 };
 
-struct vio_bus_ops {
-	struct iommu_table *(*build_iommu_table)(struct vio_dev *dev);
-};
-
 extern struct dma_mapping_ops vio_dma_ops;
 extern struct bus_type vio_bus_type;
-extern struct vio_dev vio_bus_device;
 
 extern int vio_register_driver(struct vio_driver *drv);
 extern void vio_unregister_driver(struct vio_driver *drv);
 
-extern struct vio_dev * __devinit vio_register_device(struct vio_dev *viodev);
 extern void __devinit vio_unregister_device(struct vio_dev *dev);
 
-extern int vio_bus_init(struct vio_bus_ops *);
-
 struct device_node;
 
 extern struct vio_dev * __devinit vio_register_device_node(
-- 
1.3.1
