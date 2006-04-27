Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 3A93A67B48
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Apr 2006 17:24:25 +1000 (EST)
Received: from localhost (bh02i525f01.au.ibm.com [202.81.18.30])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by smtps.tip.net.au (Postfix) with ESMTP id 039FC3682CD
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Apr 2006 17:24:24 +1000 (EST)
Date: Thu, 27 Apr 2006 17:18:21 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/4] powerpc: use the device tree for the iSeries vio bus probe
Message-Id: <20060427171821.6ebdf3fb.sfr@canb.auug.org.au>
In-Reply-To: <20060427170902.51a5a098.sfr@canb.auug.org.au>
References: <20060427170902.51a5a098.sfr@canb.auug.org.au>
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

 arch/powerpc/kernel/vio.c              |  171 +++++++++++++++++++++++++++-----
 arch/powerpc/platforms/iseries/setup.c |    4 +
 arch/powerpc/platforms/iseries/vio.c   |   70 ++-----------
 arch/powerpc/platforms/pseries/vio.c   |  147 ++--------------------------
 include/asm-powerpc/vio.h              |    9 +-
 5 files changed, 169 insertions(+), 232 deletions(-)

Booted on an iSeries 270 and built for pSeries.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

457201dcad29a4a3fdb7230a6260dcee2c223ddb
diff --git a/arch/powerpc/kernel/vio.c b/arch/powerpc/kernel/vio.c
index 971020c..9b46eed 100644
--- a/arch/powerpc/kernel/vio.c
+++ b/arch/powerpc/kernel/vio.c
@@ -22,9 +22,7 @@ #include <asm/iommu.h>
 #include <asm/dma.h>
 #include <asm/vio.h>
 #include <asm/prom.h>
-
-static const struct vio_device_id *vio_match_device(
-		const struct vio_device_id *, const struct vio_dev *);
+#include <asm/firmware.h>
 
 struct vio_dev vio_bus_device  = { /* fake "parent" device */
 	.name = vio_bus_device.dev.bus_id,
@@ -35,6 +33,27 @@ struct vio_dev vio_bus_device  = { /* fa
 
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
@@ -107,25 +126,76 @@ void vio_unregister_driver(struct vio_dr
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
+	if (firmware_has_feature(FW_FEATURE_ISERIES)) {
+		unit_address = (unsigned int *)get_property(of_node,
+				"linux,unit_address", NULL);
+		if (unit_address != NULL)
+			viodev->unit_address = *unit_address;
+	}
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
@@ -133,6 +203,7 @@ static const struct vio_device_id *vio_m
 int __init vio_bus_init(struct vio_bus_ops *ops)
 {
 	int err;
+	struct device_node *node_vroot;
 
 	vio_bus_ops = *ops;
 
@@ -153,23 +224,54 @@ int __init vio_bus_init(struct vio_bus_o
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
@@ -184,16 +286,12 @@ struct vio_dev * __devinit vio_register_
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
@@ -267,22 +365,23 @@ static int vio_hotplug(struct device *de
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
@@ -290,9 +389,25 @@ static int vio_hotplug(struct device *de
 
 struct bus_type vio_bus_type = {
 	.name = "vio",
+	.dev_attrs = vio_dev_attrs,
 	.uevent = vio_hotplug,
 	.match = vio_bus_match,
 	.probe = vio_bus_probe,
 	.remove = vio_bus_remove,
 	.shutdown = vio_bus_shutdown,
 };
+
+/**
+ * vio_get_attribute: - get attribute for virtual device
+ * @vdev:	The vio device to get property.
+ * @which:	The property/attribute to be extracted.
+ * @length:	Pointer to length of returned data size (unused if NULL).
+ *
+ * Calls prom.c's get_property() to return the value of the
+ * attribute specified by @which
+*/
+const void *vio_get_attribute(struct vio_dev *vdev, char *which, int *length)
+{
+	return get_property(vdev->dev.platform_data, which, length);
+}
+EXPORT_SYMBOL(vio_get_attribute);
diff --git a/arch/powerpc/platforms/iseries/setup.c b/arch/powerpc/platforms/iseries/setup.c
index 4862b8e..901acbc 100644
--- a/arch/powerpc/platforms/iseries/setup.c
+++ b/arch/powerpc/platforms/iseries/setup.c
@@ -951,6 +951,7 @@ void dt_vdevices(struct iseries_flat_dt 
 		dt_prop_str(dt, "device_type", "vlan");
 		dt_prop_empty(dt, "compatible");
 		dt_prop_u32(dt, "reg", reg + i);
+		dt_prop_u32(dt, "linux,unit_address", i);
 
 		mac_addr[0] = 0x02;
 		mac_addr[1] = 0x01;
@@ -971,6 +972,7 @@ void dt_vdevices(struct iseries_flat_dt 
 		dt_prop_str(dt, "device_type", "viodasd");
 		dt_prop_empty(dt, "compatible");
 		dt_prop_u32(dt, "reg", reg + i);
+		dt_prop_u32(dt, "linux,unit_address", i);
 		dt_end_node(dt);
 	}
 	reg += HVMAXARCHITECTEDVIRTUALDISKS;
@@ -980,6 +982,7 @@ void dt_vdevices(struct iseries_flat_dt 
 		dt_prop_str(dt, "device_type", "viocd");
 		dt_prop_empty(dt, "compatible");
 		dt_prop_u32(dt, "reg", reg + i);
+		dt_prop_u32(dt, "linux,unit_address", i);
 		dt_end_node(dt);
 	}
 	reg += HVMAXARCHITECTEDVIRTUALCDROMS;
@@ -989,6 +992,7 @@ void dt_vdevices(struct iseries_flat_dt 
 		dt_prop_str(dt, "device_type", "viotape");
 		dt_prop_empty(dt, "compatible");
 		dt_prop_u32(dt, "reg", reg + i);
+		dt_prop_u32(dt, "linux,unit_address", i);
 		dt_end_node(dt);
 	}
 
diff --git a/arch/powerpc/platforms/iseries/vio.c b/arch/powerpc/platforms/iseries/vio.c
index 22045a2..a689da6 100644
--- a/arch/powerpc/platforms/iseries/vio.c
+++ b/arch/powerpc/platforms/iseries/vio.c
@@ -43,58 +43,11 @@ static void __init iommu_vio_init(void)
 		printk("Virtual Bus VIO TCE table failed.\n");
 }
 
-/**
- * vio_register_device_iseries: - Register a new iSeries vio device.
- * @voidev:	The device to register.
- */
-static struct vio_dev *__init vio_register_device_iseries(char *type,
-		uint32_t unit_num)
+static struct iommu_table *vio_build_iommu_table(struct vio_dev *dev)
 {
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
-{
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
@@ -109,6 +62,7 @@ static int vio_match_device_iseries(cons
 
 static struct vio_bus_ops vio_bus_ops_iseries = {
 	.match = vio_match_device_iseries,
+	.build_iommu_table = vio_build_iommu_table,
 };
 
 /**
@@ -116,16 +70,10 @@ static struct vio_bus_ops vio_bus_ops_is
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
index 8e53e04..b3925ae 100644
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
@@ -136,88 +75,20 @@ static struct iommu_table *vio_build_iom
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
 
-/**
- * vio_get_attribute: - get attribute for virtual device
- * @vdev:	The vio device to get property.
- * @which:	The property/attribute to be extracted.
- * @length:	Pointer to length of returned data size (unused if NULL).
- *
- * Calls prom.c's get_property() to return the value of the
- * attribute specified by the preprocessor constant @which
-*/
-const void * vio_get_attribute(struct vio_dev *vdev, void* which, int* length)
-{
-	return get_property(vdev->dev.platform_data, (char*)which, length);
-}
-EXPORT_SYMBOL(vio_get_attribute);
+__initcall(vio_bus_init_pseries);
 
 /* vio_find_name() - internal because only vio.c knows how we formatted the
  * kobject name
diff --git a/include/asm-powerpc/vio.h b/include/asm-powerpc/vio.h
index 0544ece..0055d8e 100644
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
@@ -82,14 +81,14 @@ extern void __devinit vio_unregister_dev
 
 extern int vio_bus_init(struct vio_bus_ops *);
 
-#ifdef CONFIG_PPC_PSERIES
 struct device_node;
 
 extern struct vio_dev * __devinit vio_register_device_node(
 		struct device_node *node_vdev);
-extern struct vio_dev *vio_find_node(struct device_node *vnode);
-extern const void *vio_get_attribute(struct vio_dev *vdev, void *which,
+extern const void *vio_get_attribute(struct vio_dev *vdev, char *which,
 		int *length);
+#ifdef CONFIG_PPC_PSERIES
+extern struct vio_dev *vio_find_node(struct device_node *vnode);
 extern int vio_enable_interrupts(struct vio_dev *dev);
 extern int vio_disable_interrupts(struct vio_dev *dev);
 #endif
-- 
1.3.1
