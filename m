Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 06 Nov 2006 18:05:47 +1100
Subject: [PATCH 12/27] powerpc: Souped-up of_platform_device support
In-Reply-To: <1162796738.274582.277491064706.qpush@grosgo>
Message-Id: <20061106070703.27AAF67D49@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch first splits of_device.c and of_platform.c, the later containing
the bits relative to of_platform_device's. On the "breaks" side of things,
drivers uisng of_platform_device(s) need to include asm/of_platform.h now
and of_(un)register_driver is now of_(un)register_platform_driver.

In addition to a few utility functions to locate of_platform_device(s),
the main new addition is of_platform_bus_probe() which allows the platform
code to trigger an automatic creation of of_platform_devices for a whole
tree of devices.

The function acts based on the type of the various "parent" devices encountered
from a provided root, using either a default known list of bus types that can be
"probed" or a passed-in list. It will only register devices on busses matching
that list, which mean that typically, it will not register PCI devices, as
expected (since they will be picked up by the PCI layer).

This will be used by Cell platforms using 4xx-type IOs in the Axon bridge
and can be used by any embedded-type device as well.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

 arch/powerpc/kernel/Makefile            |    2 
 arch/powerpc/kernel/of_device.c         |  172 ++------------
 arch/powerpc/kernel/of_platform.c       |  372 ++++++++++++++++++++++++++++++++
 arch/powerpc/platforms/powermac/setup.c |    1 
 drivers/macintosh/smu.c                 |    3 
 drivers/macintosh/therm_adt746x.c       |    2 
 drivers/macintosh/therm_pm72.c          |    5 
 drivers/macintosh/therm_windtunnel.c    |    7 
 drivers/video/platinumfb.c              |    5 
 include/asm-powerpc/of_device.h         |   34 --
 include/asm-powerpc/of_platform.h       |   60 +++++
 11 files changed, 476 insertions(+), 187 deletions(-)

Index: linux-cell/arch/powerpc/kernel/of_device.c
===================================================================
--- linux-cell.orig/arch/powerpc/kernel/of_device.c	2006-10-06 13:47:54.000000000 +1000
+++ linux-cell/arch/powerpc/kernel/of_device.c	2006-11-06 15:16:35.000000000 +1100
@@ -9,30 +9,26 @@
 #include <asm/of_device.h>
 
 /**
- * of_match_device - Tell if an of_device structure has a matching
- * of_match structure
+ * of_match_node - Tell if an device_node has a matching of_match structure
  * @ids: array of of device match structures to search in
- * @dev: the of device structure to match against
+ * @node: the of device structure to match against
  *
- * Used by a driver to check whether an of_device present in the
- * system is in its list of supported devices.
+ * Low level utility function used by device matching.
  */
-const struct of_device_id *of_match_device(const struct of_device_id *matches,
-					const struct of_device *dev)
+const struct of_device_id *of_match_node(const struct of_device_id *matches,
+					 const struct device_node *node)
 {
-	if (!dev->node)
-		return NULL;
 	while (matches->name[0] || matches->type[0] || matches->compatible[0]) {
 		int match = 1;
 		if (matches->name[0])
-			match &= dev->node->name
-				&& !strcmp(matches->name, dev->node->name);
+			match &= node->name
+				&& !strcmp(matches->name, node->name);
 		if (matches->type[0])
-			match &= dev->node->type
-				&& !strcmp(matches->type, dev->node->type);
+			match &= node->type
+				&& !strcmp(matches->type, node->type);
 		if (matches->compatible[0])
-			match &= device_is_compatible(dev->node,
-				matches->compatible);
+			match &= device_is_compatible(node,
+						      matches->compatible);
 		if (match)
 			return matches;
 		matches++;
@@ -40,16 +36,21 @@ const struct of_device_id *of_match_devi
 	return NULL;
 }
 
-static int of_platform_bus_match(struct device *dev, struct device_driver *drv)
+/**
+ * of_match_device - Tell if an of_device structure has a matching
+ * of_match structure
+ * @ids: array of of device match structures to search in
+ * @dev: the of device structure to match against
+ *
+ * Used by a driver to check whether an of_device present in the
+ * system is in its list of supported devices.
+ */
+const struct of_device_id *of_match_device(const struct of_device_id *matches,
+					const struct of_device *dev)
 {
-	struct of_device * of_dev = to_of_device(dev);
-	struct of_platform_driver * of_drv = to_of_platform_driver(drv);
-	const struct of_device_id * matches = of_drv->match_table;
-
-	if (!matches)
-		return 0;
-
-	return of_match_device(matches, of_dev) != NULL;
+	if (!dev->node)
+		return NULL;
+	return of_match_node(matches, dev->node);
 }
 
 struct of_device *of_dev_get(struct of_device *dev)
@@ -71,96 +72,8 @@ void of_dev_put(struct of_device *dev)
 		put_device(&dev->dev);
 }
 
-
-static int of_device_probe(struct device *dev)
-{
-	int error = -ENODEV;
-	struct of_platform_driver *drv;
-	struct of_device *of_dev;
-	const struct of_device_id *match;
-
-	drv = to_of_platform_driver(dev->driver);
-	of_dev = to_of_device(dev);
-
-	if (!drv->probe)
-		return error;
-
-	of_dev_get(of_dev);
-
-	match = of_match_device(drv->match_table, of_dev);
-	if (match)
-		error = drv->probe(of_dev, match);
-	if (error)
-		of_dev_put(of_dev);
-
-	return error;
-}
-
-static int of_device_remove(struct device *dev)
-{
-	struct of_device * of_dev = to_of_device(dev);
-	struct of_platform_driver * drv = to_of_platform_driver(dev->driver);
-
-	if (dev->driver && drv->remove)
-		drv->remove(of_dev);
-	return 0;
-}
-
-static int of_device_suspend(struct device *dev, pm_message_t state)
-{
-	struct of_device * of_dev = to_of_device(dev);
-	struct of_platform_driver * drv = to_of_platform_driver(dev->driver);
-	int error = 0;
-
-	if (dev->driver && drv->suspend)
-		error = drv->suspend(of_dev, state);
-	return error;
-}
-
-static int of_device_resume(struct device * dev)
-{
-	struct of_device * of_dev = to_of_device(dev);
-	struct of_platform_driver * drv = to_of_platform_driver(dev->driver);
-	int error = 0;
-
-	if (dev->driver && drv->resume)
-		error = drv->resume(of_dev);
-	return error;
-}
-
-struct bus_type of_platform_bus_type = {
-       .name	= "of_platform",
-       .match	= of_platform_bus_match,
-       .probe	= of_device_probe,
-       .remove	= of_device_remove,
-       .suspend	= of_device_suspend,
-       .resume	= of_device_resume,
-};
-
-static int __init of_bus_driver_init(void)
-{
-	return bus_register(&of_platform_bus_type);
-}
-
-postcore_initcall(of_bus_driver_init);
-
-int of_register_driver(struct of_platform_driver *drv)
-{
-	/* initialize common driver fields */
-	drv->driver.name = drv->name;
-	drv->driver.bus = &of_platform_bus_type;
-
-	/* register with core */
-	return driver_register(&drv->driver);
-}
-
-void of_unregister_driver(struct of_platform_driver *drv)
-{
-	driver_unregister(&drv->driver);
-}
-
-
-static ssize_t dev_show_devspec(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t dev_show_devspec(struct device *dev,
+				struct device_attribute *attr, char *buf)
 {
 	struct of_device *ofdev;
 
@@ -208,41 +121,10 @@ void of_device_unregister(struct of_devi
 	device_unregister(&ofdev->dev);
 }
 
-struct of_device* of_platform_device_create(struct device_node *np,
-					    const char *bus_id,
-					    struct device *parent)
-{
-	struct of_device *dev;
-
-	dev = kmalloc(sizeof(*dev), GFP_KERNEL);
-	if (!dev)
-		return NULL;
-	memset(dev, 0, sizeof(*dev));
-
-	dev->node = of_node_get(np);
-	dev->dma_mask = 0xffffffffUL;
-	dev->dev.dma_mask = &dev->dma_mask;
-	dev->dev.parent = parent;
-	dev->dev.bus = &of_platform_bus_type;
-	dev->dev.release = of_release_dev;
-
-	strlcpy(dev->dev.bus_id, bus_id, BUS_ID_SIZE);
-
-	if (of_device_register(dev) != 0) {
-		kfree(dev);
-		return NULL;
-	}
-
-	return dev;
-}
 
 EXPORT_SYMBOL(of_match_device);
-EXPORT_SYMBOL(of_platform_bus_type);
-EXPORT_SYMBOL(of_register_driver);
-EXPORT_SYMBOL(of_unregister_driver);
 EXPORT_SYMBOL(of_device_register);
 EXPORT_SYMBOL(of_device_unregister);
 EXPORT_SYMBOL(of_dev_get);
 EXPORT_SYMBOL(of_dev_put);
-EXPORT_SYMBOL(of_platform_device_create);
 EXPORT_SYMBOL(of_release_dev);
Index: linux-cell/include/asm-powerpc/of_device.h
===================================================================
--- linux-cell.orig/include/asm-powerpc/of_device.h	2006-10-06 13:48:23.000000000 +1000
+++ linux-cell/include/asm-powerpc/of_device.h	2006-11-06 15:45:18.000000000 +1100
@@ -6,12 +6,6 @@
 #include <linux/mod_devicetable.h>
 #include <asm/prom.h>
 
-/*
- * The of_platform_bus_type is a bus type used by drivers that do not
- * attach to a macio or similar bus but still use OF probing
- * mechanism
- */
-extern struct bus_type of_platform_bus_type;
 
 /*
  * The of_device is a kind of "base class" that is a superset of
@@ -26,40 +20,16 @@ struct of_device
 };
 #define	to_of_device(d) container_of(d, struct of_device, dev)
 
+extern const struct of_device_id *of_match_node(
+	const struct of_device_id *matches, const struct device_node *node);
 extern const struct of_device_id *of_match_device(
 	const struct of_device_id *matches, const struct of_device *dev);
 
 extern struct of_device *of_dev_get(struct of_device *dev);
 extern void of_dev_put(struct of_device *dev);
 
-/*
- * An of_platform_driver driver is attached to a basic of_device on
- * the "platform bus" (of_platform_bus_type)
- */
-struct of_platform_driver
-{
-	char			*name;
-	struct of_device_id	*match_table;
-	struct module		*owner;
-
-	int	(*probe)(struct of_device* dev, const struct of_device_id *match);
-	int	(*remove)(struct of_device* dev);
-
-	int	(*suspend)(struct of_device* dev, pm_message_t state);
-	int	(*resume)(struct of_device* dev);
-	int	(*shutdown)(struct of_device* dev);
-
-	struct device_driver	driver;
-};
-#define	to_of_platform_driver(drv) container_of(drv,struct of_platform_driver, driver)
-
-extern int of_register_driver(struct of_platform_driver *drv);
-extern void of_unregister_driver(struct of_platform_driver *drv);
 extern int of_device_register(struct of_device *ofdev);
 extern void of_device_unregister(struct of_device *ofdev);
-extern struct of_device *of_platform_device_create(struct device_node *np,
-						   const char *bus_id,
-						   struct device *parent);
 extern void of_release_dev(struct device *dev);
 
 #endif /* __KERNEL__ */
Index: linux-cell/arch/powerpc/kernel/of_platform.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-cell/arch/powerpc/kernel/of_platform.c	2006-11-06 15:45:18.000000000 +1100
@@ -0,0 +1,372 @@
+/*
+ *    Copyright (C) 2006 Benjamin Herrenschmidt, IBM Corp.
+ *			 <benh@kernel.crashing.org>
+ *
+ *  This program is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU General Public License
+ *  as published by the Free Software Foundation; either version
+ *  2 of the License, or (at your option) any later version.
+ *
+ */
+
+#undef DEBUG
+
+#include <linux/string.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/slab.h>
+
+#include <asm/errno.h>
+#include <asm/dcr.h>
+#include <asm/of_device.h>
+#include <asm/of_platform.h>
+
+
+/*
+ * The list of OF IDs below is used for matching bus types in the
+ * system whose devices are to be exposed as of_platform_devices.
+ *
+ * This is the default list valid for most platforms. This file provides
+ * functions who can take an explicit list if necessary though
+ *
+ * The search is always performed recursively looking for children of
+ * the provided device_node and recursively if such a children matches
+ * a bus type in the list
+ */
+
+static struct of_device_id of_default_bus_ids[] = {
+	{ .type = "soc", },
+	{ .compatible = "soc", },
+	{ .type = "spider", },
+	{ .type = "axon", },
+	{ .type = "plb5", },
+	{ .type = "plb4", },
+	{ .type = "opb", },
+	{},
+};
+
+/*
+ *
+ * OF platform device type definition & base infrastructure
+ *
+ */
+
+static int of_platform_bus_match(struct device *dev, struct device_driver *drv)
+{
+	struct of_device * of_dev = to_of_device(dev);
+	struct of_platform_driver * of_drv = to_of_platform_driver(drv);
+	const struct of_device_id * matches = of_drv->match_table;
+
+	if (!matches)
+		return 0;
+
+	return of_match_device(matches, of_dev) != NULL;
+}
+
+static int of_platform_device_probe(struct device *dev)
+{
+	int error = -ENODEV;
+	struct of_platform_driver *drv;
+	struct of_device *of_dev;
+	const struct of_device_id *match;
+
+	drv = to_of_platform_driver(dev->driver);
+	of_dev = to_of_device(dev);
+
+	if (!drv->probe)
+		return error;
+
+	of_dev_get(of_dev);
+
+	match = of_match_device(drv->match_table, of_dev);
+	if (match)
+		error = drv->probe(of_dev, match);
+	if (error)
+		of_dev_put(of_dev);
+
+	return error;
+}
+
+static int of_platform_device_remove(struct device *dev)
+{
+	struct of_device * of_dev = to_of_device(dev);
+	struct of_platform_driver * drv = to_of_platform_driver(dev->driver);
+
+	if (dev->driver && drv->remove)
+		drv->remove(of_dev);
+	return 0;
+}
+
+static int of_platform_device_suspend(struct device *dev, pm_message_t state)
+{
+	struct of_device * of_dev = to_of_device(dev);
+	struct of_platform_driver * drv = to_of_platform_driver(dev->driver);
+	int error = 0;
+
+	if (dev->driver && drv->suspend)
+		error = drv->suspend(of_dev, state);
+	return error;
+}
+
+static int of_platform_device_resume(struct device * dev)
+{
+	struct of_device * of_dev = to_of_device(dev);
+	struct of_platform_driver * drv = to_of_platform_driver(dev->driver);
+	int error = 0;
+
+	if (dev->driver && drv->resume)
+		error = drv->resume(of_dev);
+	return error;
+}
+
+struct bus_type of_platform_bus_type = {
+       .name	= "of_platform",
+       .match	= of_platform_bus_match,
+       .probe	= of_platform_device_probe,
+       .remove	= of_platform_device_remove,
+       .suspend	= of_platform_device_suspend,
+       .resume	= of_platform_device_resume,
+};
+EXPORT_SYMBOL(of_platform_bus_type);
+
+static int __init of_bus_driver_init(void)
+{
+	return bus_register(&of_platform_bus_type);
+}
+
+postcore_initcall(of_bus_driver_init);
+
+int of_register_platform_driver(struct of_platform_driver *drv)
+{
+	/* initialize common driver fields */
+	drv->driver.name = drv->name;
+	drv->driver.bus = &of_platform_bus_type;
+
+	/* register with core */
+	return driver_register(&drv->driver);
+}
+EXPORT_SYMBOL(of_register_platform_driver);
+
+void of_unregister_platform_driver(struct of_platform_driver *drv)
+{
+	driver_unregister(&drv->driver);
+}
+EXPORT_SYMBOL(of_unregister_platform_driver);
+
+static void of_platform_make_bus_id(struct of_device *dev)
+{
+	struct device_node *node = dev->node;
+	char *name = dev->dev.bus_id;
+	const u32 *reg;
+	u64 addr;
+
+	/*
+	 * If it's a DCR based device, use 'd' for native DCRs
+	 * and 'D' for MMIO DCRs.
+	 */
+#ifdef CONFIG_PPC_DCR
+	reg = get_property(node, "dcr-reg", NULL);
+	if (reg) {
+#ifdef CONFIG_PPC_DCR_NATIVE
+		snprintf(name, BUS_ID_SIZE, "d%x.%s",
+			 *reg, node->name);
+#else /* CONFIG_PPC_DCR_NATIVE */
+		addr = of_translate_dcr_address(node, *reg, NULL);
+		if (addr != OF_BAD_ADDR) {
+			snprintf(name, BUS_ID_SIZE,
+				 "D%llx.%s", (unsigned long long)addr,
+				 node->name);
+			return;
+		}
+#endif /* !CONFIG_PPC_DCR_NATIVE */
+	}
+#endif /* CONFIG_PPC_DCR */
+
+	/*
+	 * For MMIO, get the physical address
+	 */
+	reg = get_property(node, "reg", NULL);
+	if (reg) {
+		addr = of_translate_address(node, reg);
+		if (addr != OF_BAD_ADDR) {
+			snprintf(name, BUS_ID_SIZE,
+				 "%llx.%s", (unsigned long long)addr,
+				 node->name);
+			return;
+		}
+	}
+
+	/*
+	 * No BusID, use the node name and pray
+	 */
+	snprintf(name, BUS_ID_SIZE, "%s", node->name);
+}
+
+struct of_device* of_platform_device_create(struct device_node *np,
+					    const char *bus_id,
+					    struct device *parent)
+{
+	struct of_device *dev;
+
+	dev = kmalloc(sizeof(*dev), GFP_KERNEL);
+	if (!dev)
+		return NULL;
+	memset(dev, 0, sizeof(*dev));
+
+	dev->node = of_node_get(np);
+	dev->dma_mask = 0xffffffffUL;
+	dev->dev.dma_mask = &dev->dma_mask;
+	dev->dev.parent = parent;
+	dev->dev.bus = &of_platform_bus_type;
+	dev->dev.release = of_release_dev;
+
+	if (bus_id)
+		strlcpy(dev->dev.bus_id, bus_id, BUS_ID_SIZE);
+	else
+		of_platform_make_bus_id(dev);
+
+	if (of_device_register(dev) != 0) {
+		kfree(dev);
+		return NULL;
+	}
+
+	return dev;
+}
+EXPORT_SYMBOL(of_platform_device_create);
+
+
+
+/**
+ * of_platform_bus_create - Create an OF device for a bus node and all its
+ * children. Optionally recursively instanciate matching busses.
+ * @bus: device node of the bus to instanciate
+ * @matches: match table, NULL to use the default, OF_NO_DEEP_PROBE to
+ * disallow recursive creation of child busses
+ */
+static int of_platform_bus_create(struct device_node *bus,
+				  struct of_device_id *matches,
+				  struct device *parent)
+{
+	struct device_node *child;
+	struct of_device *dev;
+	int rc = 0;
+
+	for (child = NULL; (child = of_get_next_child(bus, child)); ) {
+		pr_debug("   create child: %s\n", child->full_name);
+		dev = of_platform_device_create(child, NULL, parent);
+		if (dev == NULL)
+			rc = -ENOMEM;
+		else if (!of_match_node(matches, child))
+			continue;
+		if (rc == 0) {
+			pr_debug("   and sub busses\n");
+			rc = of_platform_bus_create(child, matches, &dev->dev);
+		} if (rc) {
+			of_node_put(child);
+			break;
+		}
+	}
+	return rc;
+}
+
+/**
+ * of_platform_bus_probe - Probe the device-tree for platform busses
+ * @root: parent of the first level to probe or NULL for the root of the tree
+ * @matches: match table, NULL to use the default
+ * @parent: parent to hook devices from, NULL for toplevel
+ *
+ * Note that children of the provided root are not instanciated as devices
+ * unless the specified root itself matches the bus list and is not NULL.
+ */
+
+int of_platform_bus_probe(struct device_node *root,
+			  struct of_device_id *matches,
+			  struct device *parent)
+{
+	struct device_node *child;
+	struct of_device *dev;
+	int rc = 0;
+
+	if (matches == NULL)
+		matches = of_default_bus_ids;
+	if (matches == OF_NO_DEEP_PROBE)
+		return -EINVAL;
+	if (root == NULL)
+		root = of_find_node_by_path("/");
+	else
+		of_node_get(root);
+
+	pr_debug("of_platform_bus_probe()\n");
+	pr_debug(" starting at: %s\n", root->full_name);
+
+	/* Do a self check of bus type, if there's a match, create
+	 * children
+	 */
+	if (of_match_node(matches, root)) {
+		pr_debug(" root match, create all sub devices\n");
+		dev = of_platform_device_create(root, NULL, parent);
+		if (dev == NULL) {
+			rc = -ENOMEM;
+			goto bail;
+		}
+		pr_debug(" create all sub busses\n");
+		rc = of_platform_bus_create(root, matches, &dev->dev);
+		goto bail;
+	}
+	for (child = NULL; (child = of_get_next_child(root, child)); ) {
+		if (!of_match_node(matches, child))
+			continue;
+
+		pr_debug("  match: %s\n", child->full_name);
+		dev = of_platform_device_create(child, NULL, parent);
+		if (dev == NULL)
+			rc = -ENOMEM;
+		else
+			rc = of_platform_bus_create(child, matches, &dev->dev);
+		if (rc) {
+			of_node_put(child);
+			break;
+		}
+	}
+ bail:
+	of_node_put(root);
+	return rc;
+}
+EXPORT_SYMBOL(of_platform_bus_probe);
+
+static int of_dev_node_match(struct device *dev, void *data)
+{
+	return to_of_device(dev)->node == data;
+}
+
+struct of_device *of_find_device_by_node(struct device_node *np)
+{
+	struct device *dev;
+
+	dev = bus_find_device(&of_platform_bus_type,
+			      NULL, np, of_dev_node_match);
+	if (dev)
+		return to_of_device(dev);
+	return NULL;
+}
+EXPORT_SYMBOL(of_find_device_by_node);
+
+static int of_dev_phandle_match(struct device *dev, void *data)
+{
+	phandle *ph = data;
+	return to_of_device(dev)->node->linux_phandle == *ph;
+}
+
+struct of_device *of_find_device_by_phandle(phandle ph)
+{
+	struct device *dev;
+
+	dev = bus_find_device(&of_platform_bus_type,
+			      NULL, &ph, of_dev_phandle_match);
+	if (dev)
+		return to_of_device(dev);
+	return NULL;
+}
+EXPORT_SYMBOL(of_find_device_by_phandle);
Index: linux-cell/arch/powerpc/kernel/Makefile
===================================================================
--- linux-cell.orig/arch/powerpc/kernel/Makefile	2006-11-06 15:05:40.000000000 +1100
+++ linux-cell/arch/powerpc/kernel/Makefile	2006-11-06 15:45:18.000000000 +1100
@@ -21,7 +21,7 @@ obj-$(CONFIG_PPC64)		+= setup_64.o binfm
 obj-$(CONFIG_PPC64)		+= vdso64/
 obj-$(CONFIG_ALTIVEC)		+= vecemu.o vector.o
 obj-$(CONFIG_PPC_970_NAP)	+= idle_power4.o
-obj-$(CONFIG_PPC_OF)		+= of_device.o prom_parse.o
+obj-$(CONFIG_PPC_OF)		+= of_device.o of_platform.o prom_parse.o
 procfs-$(CONFIG_PPC64)		:= proc_ppc64.o
 obj-$(CONFIG_PROC_FS)		+= $(procfs-y)
 rtaspci-$(CONFIG_PPC64)		:= rtas_pci.o
Index: linux-cell/drivers/macintosh/therm_pm72.c
===================================================================
--- linux-cell.orig/drivers/macintosh/therm_pm72.c	2006-10-06 13:48:04.000000000 +1000
+++ linux-cell/drivers/macintosh/therm_pm72.c	2006-11-06 15:16:35.000000000 +1100
@@ -129,6 +129,7 @@
 #include <asm/sections.h>
 #include <asm/of_device.h>
 #include <asm/macio.h>
+#include <asm/of_platform.h>
 
 #include "therm_pm72.h"
 
@@ -2236,14 +2237,14 @@ static int __init therm_pm72_init(void)
 		return -ENODEV;
 	}
 
-	of_register_driver(&fcu_of_platform_driver);
+	of_register_platform_driver(&fcu_of_platform_driver);
 	
 	return 0;
 }
 
 static void __exit therm_pm72_exit(void)
 {
-	of_unregister_driver(&fcu_of_platform_driver);
+	of_unregister_platform_driver(&fcu_of_platform_driver);
 
 	if (of_dev)
 		of_device_unregister(of_dev);
Index: linux-cell/include/asm-powerpc/of_platform.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-cell/include/asm-powerpc/of_platform.h	2006-11-06 15:16:35.000000000 +1100
@@ -0,0 +1,60 @@
+/*
+ *    Copyright (C) 2006 Benjamin Herrenschmidt, IBM Corp.
+ *			 <benh@kernel.crashing.org>
+ *
+ *  This program is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU General Public License
+ *  as published by the Free Software Foundation; either version
+ *  2 of the License, or (at your option) any later version.
+ *
+ */
+
+#include <asm/of_device.h>
+
+/*
+ * The of_platform_bus_type is a bus type used by drivers that do not
+ * attach to a macio or similar bus but still use OF probing
+ * mechanism
+ */
+extern struct bus_type of_platform_bus_type;
+
+/*
+ * An of_platform_driver driver is attached to a basic of_device on
+ * the "platform bus" (of_platform_bus_type)
+ */
+struct of_platform_driver
+{
+	char			*name;
+	struct of_device_id	*match_table;
+	struct module		*owner;
+
+	int	(*probe)(struct of_device* dev,
+			 const struct of_device_id *match);
+	int	(*remove)(struct of_device* dev);
+
+	int	(*suspend)(struct of_device* dev, pm_message_t state);
+	int	(*resume)(struct of_device* dev);
+	int	(*shutdown)(struct of_device* dev);
+
+	struct device_driver	driver;
+};
+#define	to_of_platform_driver(drv) \
+	container_of(drv,struct of_platform_driver, driver)
+
+/* Platform drivers register/unregister */
+extern int of_register_platform_driver(struct of_platform_driver *drv);
+extern void of_unregister_platform_driver(struct of_platform_driver *drv);
+
+/* Platform devices and busses creation */
+extern struct of_device *of_platform_device_create(struct device_node *np,
+						   const char *bus_id,
+						   struct device *parent);
+/* pseudo "matches" value to not do deep probe */
+#define OF_NO_DEEP_PROBE ((struct of_device_id *)-1)
+
+extern int of_platform_bus_probe(struct device_node *root,
+				 struct of_device_id *matches,
+				 struct device *parent);
+
+extern struct of_device *of_find_device_by_node(struct device_node *np);
+extern struct of_device *of_find_device_by_phandle(phandle ph);
Index: linux-cell/arch/powerpc/platforms/powermac/setup.c
===================================================================
--- linux-cell.orig/arch/powerpc/platforms/powermac/setup.c	2006-11-06 15:02:21.000000000 +1100
+++ linux-cell/arch/powerpc/platforms/powermac/setup.c	2006-11-06 15:18:34.000000000 +1100
@@ -70,6 +70,7 @@
 #include <asm/pmac_feature.h>
 #include <asm/time.h>
 #include <asm/of_device.h>
+#include <asm/of_platform.h>
 #include <asm/mmu_context.h>
 #include <asm/iommu.h>
 #include <asm/smu.h>
Index: linux-cell/drivers/macintosh/smu.c
===================================================================
--- linux-cell.orig/drivers/macintosh/smu.c	2006-10-09 12:03:33.000000000 +1000
+++ linux-cell/drivers/macintosh/smu.c	2006-11-06 15:16:35.000000000 +1100
@@ -46,6 +46,7 @@
 #include <asm/abs_addr.h>
 #include <asm/uaccess.h>
 #include <asm/of_device.h>
+#include <asm/of_platform.h>
 
 #define VERSION "0.7"
 #define AUTHOR  "(c) 2005 Benjamin Herrenschmidt, IBM Corp."
@@ -653,7 +654,7 @@ static int __init smu_init_sysfs(void)
 	 * I'm a bit too far from figuring out how that works with those
 	 * new chipsets, but that will come back and bite us
 	 */
-	of_register_driver(&smu_of_platform_driver);
+	of_register_platform_driver(&smu_of_platform_driver);
 	return 0;
 }
 
Index: linux-cell/drivers/video/platinumfb.c
===================================================================
--- linux-cell.orig/drivers/video/platinumfb.c	2006-10-23 14:41:38.000000000 +1000
+++ linux-cell/drivers/video/platinumfb.c	2006-11-06 15:16:35.000000000 +1100
@@ -34,6 +34,7 @@
 #include <asm/prom.h>
 #include <asm/pgtable.h>
 #include <asm/of_device.h>
+#include <asm/of_platform.h>
 
 #include "macmodes.h"
 #include "platinumfb.h"
@@ -682,14 +683,14 @@ static int __init platinumfb_init(void)
 		return -ENODEV;
 	platinumfb_setup(option);
 #endif
-	of_register_driver(&platinum_driver);
+	of_register_platform_driver(&platinum_driver);
 
 	return 0;
 }
 
 static void __exit platinumfb_exit(void)
 {
-	of_unregister_driver(&platinum_driver);	
+	of_unregister_platform_driver(&platinum_driver);
 }
 
 MODULE_LICENSE("GPL");
Index: linux-cell/drivers/macintosh/therm_adt746x.c
===================================================================
--- linux-cell.orig/drivers/macintosh/therm_adt746x.c	2006-10-06 13:48:04.000000000 +1000
+++ linux-cell/drivers/macintosh/therm_adt746x.c	2006-11-06 15:45:42.000000000 +1100
@@ -30,7 +30,7 @@
 #include <asm/io.h>
 #include <asm/system.h>
 #include <asm/sections.h>
-#include <asm/of_device.h>
+#include <asm/of_platform.h>
 
 #undef DEBUG
 
Index: linux-cell/drivers/macintosh/therm_windtunnel.c
===================================================================
--- linux-cell.orig/drivers/macintosh/therm_windtunnel.c	2006-10-06 13:48:04.000000000 +1000
+++ linux-cell/drivers/macintosh/therm_windtunnel.c	2006-11-06 15:46:39.000000000 +1100
@@ -36,12 +36,13 @@
 #include <linux/i2c.h>
 #include <linux/slab.h>
 #include <linux/init.h>
+
 #include <asm/prom.h>
 #include <asm/machdep.h>
 #include <asm/io.h>
 #include <asm/system.h>
 #include <asm/sections.h>
-#include <asm/of_device.h>
+#include <asm/of_platform.h>
 #include <asm/macio.h>
 
 #define LOG_TEMP		0			/* continously log temperature */
@@ -511,14 +512,14 @@ g4fan_init( void )
 		return -ENODEV;
 	}
 
-	of_register_driver( &therm_of_driver );
+	of_register_platform_driver( &therm_of_driver );
 	return 0;
 }
 
 static void __exit
 g4fan_exit( void )
 {
-	of_unregister_driver( &therm_of_driver );
+	of_unregister_platform_driver( &therm_of_driver );
 
 	if( x.of_dev )
 		of_device_unregister( x.of_dev );
