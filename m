Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id EF17667A3B
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Apr 2006 22:00:18 +1000 (EST)
Received: from localhost (ta-1-1.tip.net.au [203.11.71.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by smtps.tip.net.au (Postfix) with ESMTP id 5DF2E3683D8
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Apr 2006 22:00:17 +1000 (EST)
Date: Tue, 25 Apr 2006 21:59:50 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: ppc-dev <linuxppc-dev@ozlabs.org>
Subject: [RFC 2/2] powerpc: use the device tree for the iSeries vio bus probe
Message-Id: <20060425215950.36c01f2b.sfr@canb.auug.org.au>
In-Reply-To: <20060425215405.648a16e7.sfr@canb.auug.org.au>
References: <20060425215405.648a16e7.sfr@canb.auug.org.au>
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

As an added bonus, since every vio_dev now has a device_node
associated with it, hotplug now works.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---

 arch/powerpc/kernel/vio.c              |  149 ++++++++++++++++++++++++++------
 arch/powerpc/platforms/iseries/setup.c |    5 +
 arch/powerpc/platforms/iseries/vio.c   |   79 ++++-------------
 arch/powerpc/platforms/pseries/vio.c   |  134 ++---------------------------
 drivers/block/viodasd.c                |    5 +
 drivers/cdrom/viocd.c                  |    5 +
 drivers/char/viotape.c                 |    4 -
 drivers/net/iseries_veth.c             |    7 +-
 include/asm-powerpc/iseries/vio.h      |    5 +
 include/asm-powerpc/vio.h              |    5 -
 10 files changed, 173 insertions(+), 225 deletions(-)

This has been booted on an iSeries 270 and compiled for pSeries.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

a8083bf970bafd0f7139b4b9bbbf12e3ed32e2f7
diff --git a/arch/powerpc/kernel/vio.c b/arch/powerpc/kernel/vio.c
index 971020c..784528b 100644
--- a/arch/powerpc/kernel/vio.c
+++ b/arch/powerpc/kernel/vio.c
@@ -23,9 +23,6 @@ #include <asm/dma.h>
 #include <asm/vio.h>
 #include <asm/prom.h>
 
-static const struct vio_device_id *vio_match_device(
-		const struct vio_device_id *, const struct vio_dev *);
-
 struct vio_dev vio_bus_device  = { /* fake "parent" device */
 	.name = vio_bus_device.dev.bus_id,
 	.type = "",
@@ -35,6 +32,27 @@ struct vio_dev vio_bus_device  = { /* fa
 
 static struct vio_bus_ops vio_bus_ops;
 
+/**
+ * vio_match_device: - Tell if a VIO device has a matching
+ *			VIO device id structure.
+ * @ids:	array of VIO device id structures to search in
+ * @dev:	the VIO device structure to match against
+ *
+ * Used by a driver to check whether a VIO device present in the
+ * system is in its list of supported devices. Returns the matching
+ * vio_device_id structure or NULL if there is no match.
+ */
+static const struct vio_device_id *vio_match_device(
+		const struct vio_device_id *ids, const struct vio_dev *dev)
+{
+	while (ids->type[0] != '\0') {
+		if (vio_bus_ops.match(ids, dev))
+			return ids;
+		ids++;
+	}
+	return NULL;
+}
+
 /*
  * Convert from struct device to struct vio_dev and pass to driver.
  * dev->driver has already been set by generic code because vio_bus_match
@@ -107,25 +125,70 @@ void vio_unregister_driver(struct vio_dr
 EXPORT_SYMBOL(vio_unregister_driver);
 
 /**
- * vio_match_device: - Tell if a VIO device has a matching
- *			VIO device id structure.
- * @ids:	array of VIO device id structures to search in
- * @dev:	the VIO device structure to match against
+ * vio_register_device_node: - Register a new vio device.
+ * @of_node:	The OF node for this device.
  *
- * Used by a driver to check whether a VIO device present in the
- * system is in its list of supported devices. Returns the matching
- * vio_device_id structure or NULL if there is no match.
+ * Creates and initializes a vio_dev structure from the data in
+ * of_node (dev.platform_data) and adds it to the list of virtual devices.
+ * Returns a pointer to the created vio_dev or NULL if node has
+ * NULL device_type or compatible fields.
  */
-static const struct vio_device_id *vio_match_device(
-		const struct vio_device_id *ids, const struct vio_dev *dev)
+struct vio_dev * __devinit vio_register_device_node(struct device_node *of_node)
 {
-	while (ids->type[0] != '\0') {
-		if (vio_bus_ops.match(ids, dev))
-			return ids;
-		ids++;
+	struct vio_dev *viodev;
+	unsigned int *unit_address;
+	unsigned int *irq_p;
+
+	/* we need the 'device_type' property, in order to match with drivers */
+	if (of_node->type == NULL) {
+		printk(KERN_WARNING "%s: node %s missing 'device_type'\n",
+				__FUNCTION__,
+				of_node->name ? of_node->name : "<unknown>");
+		return NULL;
 	}
-	return NULL;
+
+	unit_address = (unsigned int *)get_property(of_node, "reg", NULL);
+	if (unit_address == NULL) {
+		printk(KERN_WARNING "%s: node %s missing 'reg'\n",
+				__FUNCTION__,
+				of_node->name ? of_node->name : "<unknown>");
+		return NULL;
+	}
+
+	/* allocate a vio_dev for this node */
+	viodev = kzalloc(sizeof(struct vio_dev), GFP_KERNEL);
+	if (viodev == NULL)
+		return NULL;
+
+	viodev->dev.platform_data = of_node_get(of_node);
+
+	viodev->irq = NO_IRQ;
+	irq_p = (unsigned int *)get_property(of_node, "interrupts", NULL);
+	if (irq_p) {
+		int virq = virt_irq_create_mapping(*irq_p);
+		if (virq == NO_IRQ) {
+			printk(KERN_ERR "Unable to allocate interrupt "
+			       "number for %s\n", of_node->full_name);
+		} else
+			viodev->irq = irq_offset_up(virq);
+	}
+
+	snprintf(viodev->dev.bus_id, BUS_ID_SIZE, "%x", *unit_address);
+	viodev->name = of_node->name;
+	viodev->type = of_node->type;
+	viodev->unit_address = *unit_address;
+	viodev->iommu_table = vio_bus_ops.build_iommu_table(viodev);
+
+	/* register with generic device framework */
+	if (vio_register_device(viodev) == NULL) {
+		/* XXX free TCE table */
+		kfree(viodev);
+		return NULL;
+	}
+
+	return viodev;
 }
+EXPORT_SYMBOL(vio_register_device_node);
 
 /**
  * vio_bus_init: - Initialize the virtual IO bus
@@ -133,6 +196,7 @@ static const struct vio_device_id *vio_m
 int __init vio_bus_init(struct vio_bus_ops *ops)
 {
 	int err;
+	struct device_node *node_vroot;
 
 	vio_bus_ops = *ops;
 
@@ -153,23 +217,54 @@ int __init vio_bus_init(struct vio_bus_o
 		return err;
 	}
 
+	node_vroot = find_devices("vdevice");
+	if (node_vroot) {
+		struct device_node *of_node;
+
+		/*
+		 * Create struct vio_devices for each virtual device in
+		 * the device tree. Drivers will associate with them later.
+		 */
+		for (of_node = node_vroot->child; of_node != NULL;
+				of_node = of_node->sibling) {
+			printk(KERN_DEBUG "%s: processing %p\n",
+					__FUNCTION__, of_node);
+			vio_register_device_node(of_node);
+		}
+	}
+
 	return 0;
 }
 
 /* vio_dev refcount hit 0 */
 static void __devinit vio_dev_release(struct device *dev)
 {
-	if (vio_bus_ops.release_device)
-		vio_bus_ops.release_device(dev);
+	if (dev->platform_data) {
+		/* XXX free TCE table */
+		of_node_put(dev->platform_data);
+	}
 	kfree(to_vio_dev(dev));
 }
 
-static ssize_t viodev_show_name(struct device *dev,
+static ssize_t name_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
 	return sprintf(buf, "%s\n", to_vio_dev(dev)->name);
 }
-DEVICE_ATTR(name, S_IRUSR | S_IRGRP | S_IROTH, viodev_show_name, NULL);
+
+static ssize_t devspec_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct device_node *of_node = dev->platform_data;
+
+	return sprintf(buf, "%s\n", of_node ? of_node->full_name : "none");
+}
+
+static struct device_attribute vio_dev_attrs[] = {
+	__ATTR_RO(name),
+	__ATTR_RO(devspec),
+	__ATTR_NULL
+};
 
 struct vio_dev * __devinit vio_register_device(struct vio_dev *viodev)
 {
@@ -184,16 +279,12 @@ struct vio_dev * __devinit vio_register_
 				__FUNCTION__, viodev->dev.bus_id);
 		return NULL;
 	}
-	device_create_file(&viodev->dev, &dev_attr_name);
 
 	return viodev;
 }
 
 void __devinit vio_unregister_device(struct vio_dev *viodev)
 {
-	if (vio_bus_ops.unregister_device)
-		vio_bus_ops.unregister_device(viodev);
-	device_remove_file(&viodev->dev, &dev_attr_name);
 	device_unregister(&viodev->dev);
 }
 EXPORT_SYMBOL(vio_unregister_device);
@@ -267,22 +358,23 @@ static int vio_hotplug(struct device *de
 			char *buffer, int buffer_size)
 {
 	const struct vio_dev *vio_dev = to_vio_dev(dev);
+	struct device_node *dn = dev->platform_data;
 	char *cp;
 	int length;
 
 	if (!num_envp)
 		return -ENOMEM;
 
-	if (!vio_dev->dev.platform_data)
+	if (!dn)
 		return -ENODEV;
-	cp = (char *)get_property(vio_dev->dev.platform_data, "compatible", &length);
+	cp = (char *)get_property(dn, "compatible", &length);
 	if (!cp)
 		return -ENODEV;
 
 	envp[0] = buffer;
 	length = scnprintf(buffer, buffer_size, "MODALIAS=vio:T%sS%s",
 				vio_dev->type, cp);
-	if (buffer_size - length <= 0)
+	if ((buffer_size - length) <= 0)
 		return -ENOMEM;
 	envp[1] = NULL;
 	return 0;
@@ -290,6 +382,7 @@ static int vio_hotplug(struct device *de
 
 struct bus_type vio_bus_type = {
 	.name = "vio",
+	.dev_attrs = vio_dev_attrs,
 	.uevent = vio_hotplug,
 	.match = vio_bus_match,
 	.probe = vio_bus_probe,
diff --git a/arch/powerpc/platforms/iseries/setup.c b/arch/powerpc/platforms/iseries/setup.c
index 9ce2afc..af5609a 100644
--- a/arch/powerpc/platforms/iseries/setup.c
+++ b/arch/powerpc/platforms/iseries/setup.c
@@ -54,6 +54,7 @@ #include <asm/iseries/mf.h>
 #include <asm/iseries/it_exp_vpd_panel.h>
 #include <asm/iseries/hv_lp_event.h>
 #include <asm/iseries/lpar_map.h>
+#include <asm/iseries/vio.h>
 #include <asm/udbg.h>
 #include <asm/irq.h>
 
@@ -939,6 +940,7 @@ void dt_vdevices(struct iseries_flat_dt 
 	dt_end_node(dt);
 	reg++;
 
+	vio_first_vlan_unit = reg;
 	vlan_map = HvLpConfig_getVirtualLanIndexMap();
 	for (i = 0; i < HVMAXARCHITECTEDVIRTUALLANS; i++) {
 		unsigned char mac_addr[6];
@@ -964,6 +966,7 @@ void dt_vdevices(struct iseries_flat_dt 
 	}
 	reg += HVMAXARCHITECTEDVIRTUALLANS;
 
+	vio_first_viodasd_unit = reg;
 	for (i = 0; i < HVMAXARCHITECTEDVIRTUALDISKS; i++) {
 		snprintf(buf, 32, "viodasd@%08x", reg + i);
 		dt_start_node(dt, buf);
@@ -973,6 +976,7 @@ void dt_vdevices(struct iseries_flat_dt 
 		dt_end_node(dt);
 	}
 	reg += HVMAXARCHITECTEDVIRTUALDISKS;
+	vio_first_viocd_unit = reg;
 	for (i = 0; i < HVMAXARCHITECTEDVIRTUALCDROMS; i++) {
 		snprintf(buf, 32, "viocd@%08x", reg + i);
 		dt_start_node(dt, buf);
@@ -982,6 +986,7 @@ void dt_vdevices(struct iseries_flat_dt 
 		dt_end_node(dt);
 	}
 	reg += HVMAXARCHITECTEDVIRTUALCDROMS;
+	vio_first_viotape_unit = reg;
 	for (i = 0; i < HVMAXARCHITECTEDVIRTUALTAPES; i++) {
 		snprintf(buf, 32, "viotape@%08x", reg + i);
 		dt_start_node(dt, buf);
diff --git a/arch/powerpc/platforms/iseries/vio.c b/arch/powerpc/platforms/iseries/vio.c
index 22045a2..5cd197b 100644
--- a/arch/powerpc/platforms/iseries/vio.c
+++ b/arch/powerpc/platforms/iseries/vio.c
@@ -24,6 +24,15 @@ #include <asm/iseries/hv_call_xm.h>
 
 #include "iommu.h"
 
+int vio_first_vlan_unit;
+EXPORT_SYMBOL(vio_first_vlan_unit);
+int vio_first_viodasd_unit;
+EXPORT_SYMBOL(vio_first_viodasd_unit);
+int vio_first_viocd_unit;
+EXPORT_SYMBOL(vio_first_viocd_unit);
+int vio_first_viotape_unit;
+EXPORT_SYMBOL(vio_first_viotape_unit);
+
 struct device *iSeries_vio_dev = &vio_bus_device.dev;
 EXPORT_SYMBOL(iSeries_vio_dev);
 
@@ -43,58 +52,11 @@ static void __init iommu_vio_init(void)
 		printk("Virtual Bus VIO TCE table failed.\n");
 }
 
-/**
- * vio_register_device_iseries: - Register a new iSeries vio device.
- * @voidev:	The device to register.
- */
-static struct vio_dev *__init vio_register_device_iseries(char *type,
-		uint32_t unit_num)
-{
-	struct vio_dev *viodev;
-
-	/* allocate a vio_dev for this device */
-	viodev = kmalloc(sizeof(struct vio_dev), GFP_KERNEL);
-	if (!viodev)
-		return NULL;
-	memset(viodev, 0, sizeof(struct vio_dev));
-
-	snprintf(viodev->dev.bus_id, BUS_ID_SIZE, "%s%d", type, unit_num);
-
-	viodev->name = viodev->dev.bus_id;
-	viodev->type = type;
-	viodev->unit_address = unit_num;
-	viodev->iommu_table = &vio_iommu_table;
-	if (vio_register_device(viodev) == NULL) {
-		kfree(viodev);
-		return NULL;
-	}
-	return viodev;
-}
-
-static void __init probe_bus_iseries(void)
+static struct iommu_table *vio_build_iommu_table(struct vio_dev *dev)
 {
-	HvLpIndexMap vlan_map;
-	struct vio_dev *viodev;
-	int i;
-
-	/* there is only one of each of these */
-	vio_register_device_iseries("viocons", 0);
-	vio_register_device_iseries("vscsi", 0);
-
-	vlan_map = HvLpConfig_getVirtualLanIndexMap();
-	for (i = 0; i < HVMAXARCHITECTEDVIRTUALLANS; i++) {
-		if ((vlan_map & (0x8000 >> i)) == 0)
-			continue;
-		viodev = vio_register_device_iseries("vlan", i);
-		/* veth is special and has it own iommu_table */
-		viodev->iommu_table = &veth_iommu_table;
-	}
-	for (i = 0; i < HVMAXARCHITECTEDVIRTUALDISKS; i++)
-		vio_register_device_iseries("viodasd", i);
-	for (i = 0; i < HVMAXARCHITECTEDVIRTUALCDROMS; i++)
-		vio_register_device_iseries("viocd", i);
-	for (i = 0; i < HVMAXARCHITECTEDVIRTUALTAPES; i++)
-		vio_register_device_iseries("viotape", i);
+	if (strcmp(dev->type, "vlan") == 0)
+		return &veth_iommu_table;
+	return &vio_iommu_table;
 }
 
 /**
@@ -109,6 +71,7 @@ static int vio_match_device_iseries(cons
 
 static struct vio_bus_ops vio_bus_ops_iseries = {
 	.match = vio_match_device_iseries,
+	.build_iommu_table = vio_build_iommu_table,
 };
 
 /**
@@ -116,16 +79,10 @@ static struct vio_bus_ops vio_bus_ops_is
  */
 static int __init vio_bus_init_iseries(void)
 {
-	int err;
-
-	err = vio_bus_init(&vio_bus_ops_iseries);
-	if (err == 0) {
-		iommu_vio_init();
-		vio_bus_device.iommu_table = &vio_iommu_table;
-		iSeries_vio_dev = &vio_bus_device.dev;
-		probe_bus_iseries();
-	}
-	return err;
+	iommu_vio_init();
+	vio_bus_device.iommu_table = &vio_iommu_table;
+	iSeries_vio_dev = &vio_bus_device.dev;
+	return vio_bus_init(&vio_bus_ops_iseries);
 }
 
 __initcall(vio_bus_init_iseries);
diff --git a/arch/powerpc/platforms/pseries/vio.c b/arch/powerpc/platforms/pseries/vio.c
index 8e53e04..8f9e3a6 100644
--- a/arch/powerpc/platforms/pseries/vio.c
+++ b/arch/powerpc/platforms/pseries/vio.c
@@ -26,26 +26,6 @@ #include <asm/tce.h>
 
 extern struct subsystem devices_subsys; /* needed for vio_find_name() */
 
-static void probe_bus_pseries(void)
-{
-	struct device_node *node_vroot, *of_node;
-
-	node_vroot = find_devices("vdevice");
-	if ((node_vroot == NULL) || (node_vroot->child == NULL))
-		/* this machine doesn't do virtual IO, and that's ok */
-		return;
-
-	/*
-	 * Create struct vio_devices for each virtual device in the device tree.
-	 * Drivers will associate with them later.
-	 */
-	for (of_node = node_vroot->child; of_node != NULL;
-			of_node = of_node->sibling) {
-		printk(KERN_DEBUG "%s: processing %p\n", __FUNCTION__, of_node);
-		vio_register_device_node(of_node);
-	}
-}
-
 /**
  * vio_match_device_pseries: - Tell if a pSeries VIO device matches a
  *	vio_device_id
@@ -57,47 +37,6 @@ static int vio_match_device_pseries(cons
 			device_is_compatible(dev->dev.platform_data, id->compat);
 }
 
-static void vio_release_device_pseries(struct device *dev)
-{
-	/* XXX free TCE table */
-	of_node_put(dev->platform_data);
-}
-
-static ssize_t viodev_show_devspec(struct device *dev,
-		struct device_attribute *attr, char *buf)
-{
-	struct device_node *of_node = dev->platform_data;
-
-	return sprintf(buf, "%s\n", of_node->full_name);
-}
-DEVICE_ATTR(devspec, S_IRUSR | S_IRGRP | S_IROTH, viodev_show_devspec, NULL);
-
-static void vio_unregister_device_pseries(struct vio_dev *viodev)
-{
-	device_remove_file(&viodev->dev, &dev_attr_devspec);
-}
-
-static struct vio_bus_ops vio_bus_ops_pseries = {
-	.match = vio_match_device_pseries,
-	.unregister_device = vio_unregister_device_pseries,
-	.release_device = vio_release_device_pseries,
-};
-
-/**
- * vio_bus_init_pseries: - Initialize the pSeries virtual IO bus
- */
-static int __init vio_bus_init_pseries(void)
-{
-	int err;
-
-	err = vio_bus_init(&vio_bus_ops_pseries);
-	if (err == 0)
-		probe_bus_pseries();
-	return err;
-}
-
-__initcall(vio_bus_init_pseries);
-
 /**
  * vio_build_iommu_table: - gets the dma information from OF and
  *	builds the TCE tree.
@@ -136,73 +75,20 @@ static struct iommu_table *vio_build_iom
 	return iommu_init_table(newTceTable);
 }
 
+static struct vio_bus_ops vio_bus_ops_pseries = {
+	.match = vio_match_device_pseries,
+	.build_iommu_table = vio_build_iommu_table,
+};
+
 /**
- * vio_register_device_node: - Register a new vio device.
- * @of_node:	The OF node for this device.
- *
- * Creates and initializes a vio_dev structure from the data in
- * of_node (dev.platform_data) and adds it to the list of virtual devices.
- * Returns a pointer to the created vio_dev or NULL if node has
- * NULL device_type or compatible fields.
+ * vio_bus_init_pseries: - Initialize the pSeries virtual IO bus
  */
-struct vio_dev * __devinit vio_register_device_node(struct device_node *of_node)
+static int __init vio_bus_init_pseries(void)
 {
-	struct vio_dev *viodev;
-	unsigned int *unit_address;
-	unsigned int *irq_p;
-
-	/* we need the 'device_type' property, in order to match with drivers */
-	if ((NULL == of_node->type)) {
-		printk(KERN_WARNING
-			"%s: node %s missing 'device_type'\n", __FUNCTION__,
-			of_node->name ? of_node->name : "<unknown>");
-		return NULL;
-	}
-
-	unit_address = (unsigned int *)get_property(of_node, "reg", NULL);
-	if (!unit_address) {
-		printk(KERN_WARNING "%s: node %s missing 'reg'\n", __FUNCTION__,
-			of_node->name ? of_node->name : "<unknown>");
-		return NULL;
-	}
-
-	/* allocate a vio_dev for this node */
-	viodev = kmalloc(sizeof(struct vio_dev), GFP_KERNEL);
-	if (!viodev) {
-		return NULL;
-	}
-	memset(viodev, 0, sizeof(struct vio_dev));
-
-	viodev->dev.platform_data = of_node_get(of_node);
-
-	viodev->irq = NO_IRQ;
-	irq_p = (unsigned int *)get_property(of_node, "interrupts", NULL);
-	if (irq_p) {
-		int virq = virt_irq_create_mapping(*irq_p);
-		if (virq == NO_IRQ) {
-			printk(KERN_ERR "Unable to allocate interrupt "
-			       "number for %s\n", of_node->full_name);
-		} else
-			viodev->irq = irq_offset_up(virq);
-	}
-
-	snprintf(viodev->dev.bus_id, BUS_ID_SIZE, "%x", *unit_address);
-	viodev->name = of_node->name;
-	viodev->type = of_node->type;
-	viodev->unit_address = *unit_address;
-	viodev->iommu_table = vio_build_iommu_table(viodev);
-
-	/* register with generic device framework */
-	if (vio_register_device(viodev) == NULL) {
-		/* XXX free TCE table */
-		kfree(viodev);
-		return NULL;
-	}
-	device_create_file(&viodev->dev, &dev_attr_devspec);
-
-	return viodev;
+	return vio_bus_init(&vio_bus_ops_pseries);
 }
-EXPORT_SYMBOL(vio_register_device_node);
+
+__initcall(vio_bus_init_pseries);
 
 /**
  * vio_get_attribute: - get attribute for virtual device
diff --git a/drivers/block/viodasd.c b/drivers/block/viodasd.c
index f63e07b..1dbcc35 100644
--- a/drivers/block/viodasd.c
+++ b/drivers/block/viodasd.c
@@ -718,7 +718,8 @@ static DRIVER_ATTR(probe, S_IWUSR, NULL,
 
 static int viodasd_probe(struct vio_dev *vdev, const struct vio_device_id *id)
 {
-	struct viodasd_device *d = &viodasd_devices[vdev->unit_address];
+	struct viodasd_device *d =
+		&viodasd_devices[vdev->unit_address - vio_first_viodasd_unit];
 
 	d->dev = &vdev->dev;
 	probe_disk(d);
@@ -731,7 +732,7 @@ static int viodasd_remove(struct vio_dev
 {
 	struct viodasd_device *d;
 
-	d = &viodasd_devices[vdev->unit_address];
+	d = &viodasd_devices[vdev->unit_address - vio_first_viodasd_unit];
 	if (d->disk) {
 		del_gendisk(d->disk);
 		blk_cleanup_queue(d->disk->queue);
diff --git a/drivers/cdrom/viocd.c b/drivers/cdrom/viocd.c
index c0f817b..8547b35 100644
--- a/drivers/cdrom/viocd.c
+++ b/drivers/cdrom/viocd.c
@@ -649,7 +649,7 @@ static int viocd_probe(struct vio_dev *v
 	struct cdrom_info *ci;
 	struct request_queue *q;
 
-	deviceno = vdev->unit_address;
+	deviceno = vdev->unit_address - vio_first_viocd_unit;
 	if (deviceno >= viocd_numdev)
 		return -ENODEV;
 
@@ -714,7 +714,8 @@ out:
 
 static int viocd_remove(struct vio_dev *vdev)
 {
-	struct disk_info *d = &viocd_diskinfo[vdev->unit_address];
+	struct disk_info *d =
+		&viocd_diskinfo[vdev->unit_address - vio_first_viocd_unit];
 
 	if (unregister_cdrom(&d->viocd_info) != 0)
 		printk(VIOCD_KERN_WARNING
diff --git a/drivers/char/viotape.c b/drivers/char/viotape.c
index 60aabdb..e2c69f1 100644
--- a/drivers/char/viotape.c
+++ b/drivers/char/viotape.c
@@ -944,7 +944,7 @@ static void vioHandleTapeEvent(struct Hv
 static int viotape_probe(struct vio_dev *vdev, const struct vio_device_id *id)
 {
 	char tapename[32];
-	int i = vdev->unit_address;
+	int i = vdev->unit_address - vio_first_viotape_unit;
 	int j;
 
 	if (i >= viotape_numdev)
@@ -974,7 +974,7 @@ static int viotape_probe(struct vio_dev 
 
 static int viotape_remove(struct vio_dev *vdev)
 {
-	int i = vdev->unit_address;
+	int i = vdev->unit_address - vio_first_viotape_unit;
 
 	devfs_remove("iseries/nvt%d", i);
 	devfs_remove("iseries/vt%d", i);
diff --git a/drivers/net/iseries_veth.c b/drivers/net/iseries_veth.c
index f0f04be..1b98915 100644
--- a/drivers/net/iseries_veth.c
+++ b/drivers/net/iseries_veth.c
@@ -77,6 +77,7 @@ #include <asm/uaccess.h>
 #include <asm/iseries/hv_lp_config.h>
 #include <asm/iseries/hv_types.h>
 #include <asm/iseries/hv_lp_event.h>
+#include <asm/iseries/vio.h>
 #include <asm/iommu.h>
 #include <asm/vio.h>
 
@@ -1577,7 +1578,7 @@ static int veth_remove(struct vio_dev *v
 	struct veth_port *port;
 	int i;
 
-	dev = veth_dev[vdev->unit_address];
+	dev = veth_dev[vdev->unit_address - vio_first_vlan_unit];
 
 	if (! dev)
 		return 0;
@@ -1593,7 +1594,7 @@ static int veth_remove(struct vio_dev *v
 		}
 	}
 
-	veth_dev[vdev->unit_address] = NULL;
+	veth_dev[vdev->unit_address - vio_first_vlan_unit] = NULL;
 	kobject_del(&port->kobject);
 	kobject_put(&port->kobject);
 	unregister_netdev(dev);
@@ -1604,7 +1605,7 @@ static int veth_remove(struct vio_dev *v
 
 static int veth_probe(struct vio_dev *vdev, const struct vio_device_id *id)
 {
-	int i = vdev->unit_address;
+	int i = vdev->unit_address - vio_first_vlan_unit;
 	struct net_device *dev;
 	struct veth_port *port;
 
diff --git a/include/asm-powerpc/iseries/vio.h b/include/asm-powerpc/iseries/vio.h
index 72a97d3..fe073e6 100644
--- a/include/asm-powerpc/iseries/vio.h
+++ b/include/asm-powerpc/iseries/vio.h
@@ -126,4 +126,9 @@ struct device;
 
 extern struct device *iSeries_vio_dev;
 
+extern int vio_first_vlan_unit;
+extern int vio_first_viodasd_unit;
+extern int vio_first_viocd_unit;
+extern int vio_first_viotape_unit;
+
 #endif /* _ASM_POWERPC_ISERIES_VIO_H */
diff --git a/include/asm-powerpc/vio.h b/include/asm-powerpc/vio.h
index 0544ece..dea55c7 100644
--- a/include/asm-powerpc/vio.h
+++ b/include/asm-powerpc/vio.h
@@ -66,8 +66,7 @@ struct vio_driver {
 
 struct vio_bus_ops {
 	int (*match)(const struct vio_device_id *id, const struct vio_dev *dev);
-	void (*unregister_device)(struct vio_dev *);
-	void (*release_device)(struct device *);
+	struct iommu_table *(*build_iommu_table)(struct vio_dev *dev);
 };
 
 extern struct dma_mapping_ops vio_dma_ops;
@@ -82,11 +81,11 @@ extern void __devinit vio_unregister_dev
 
 extern int vio_bus_init(struct vio_bus_ops *);
 
-#ifdef CONFIG_PPC_PSERIES
 struct device_node;
 
 extern struct vio_dev * __devinit vio_register_device_node(
 		struct device_node *node_vdev);
+#ifdef CONFIG_PPC_PSERIES
 extern struct vio_dev *vio_find_node(struct device_node *vnode);
 extern const void *vio_get_attribute(struct vio_dev *vdev, void *which,
 		int *length);
-- 
1.3.1
