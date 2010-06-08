Return-Path: <grant.likely@secretlab.ca>
Sender: Grant Likely <glikely@secretlab.ca>
Subject: [PATCH 4/6] of/device: Merge of_platform_bus_probe()
To: ben@kernel.crashing.org, sfr@canb.auug.org.au, monstr@monstr.eu,
	microblaze-uclinux@itee.uq.edu.au,
	devicetree-discuss@lists.ozlabs.org, jeremy.kerr@canonical.com,
	linuxppc-dev@lists.ozlabs.org
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 08 Jun 2010 08:26:33 -0600
Message-ID: <20100608142633.26088.90672.stgit@angua>
In-Reply-To: <20100608142152.26088.1108.stgit@angua>
References: <20100608142152.26088.1108.stgit@angua>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Merge common code between PowerPC and microblaze.  This patch merges
the code that scans the tree and registers devices.  The functions
merged are of_platform_bus_probe(), of_platform_bus_create(), and
of_platform_device_create().

This patch also move the of_default_bus_ids[] table out of a Microblaze
header file and makes it non-static.  The device ids table isn't merged
because powerpc and microblaze use different default data.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
CC: Michal Simek <monstr@monstr.eu>
CC: Grant Likely <grant.likely@secretlab.ca>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Stephen Rothwell <sfr@canb.auug.org.au>
CC: microblaze-uclinux@itee.uq.edu.au
CC: linuxppc-dev@ozlabs.org
---
 arch/microblaze/include/asm/of_platform.h |   33 -------
 arch/microblaze/kernel/of_platform.c      |  141 ++++-------------------------
 arch/powerpc/include/asm/of_platform.h    |   11 --
 arch/powerpc/kernel/of_platform.c         |  131 ---------------------------
 drivers/of/platform.c                     |  143 +++++++++++++++++++++++++++++
 include/linux/of_platform.h               |   17 +++
 6 files changed, 179 insertions(+), 297 deletions(-)

diff --git a/arch/microblaze/include/asm/of_platform.h b/arch/microblaze/include/asm/of_platform.h
index 3749127..625003f 100644
--- a/arch/microblaze/include/asm/of_platform.h
+++ b/arch/microblaze/include/asm/of_platform.h
@@ -14,39 +14,6 @@
 /* This is just here during the transition */
 #include <linux/of_platform.h>
 
-/*
- * The list of OF IDs below is used for matching bus types in the
- * system whose devices are to be exposed as of_platform_devices.
- *
- * This is the default list valid for most platforms. This file provides
- * functions who can take an explicit list if necessary though
- *
- * The search is always performed recursively looking for children of
- * the provided device_node and recursively if such a children matches
- * a bus type in the list
- */
-
-static const struct of_device_id of_default_bus_ids[] = {
-	{ .type = "soc", },
-	{ .compatible = "soc", },
-	{ .type = "plb5", },
-	{ .type = "plb4", },
-	{ .type = "opb", },
-	{ .type = "simple", },
-	{},
-};
-
-/* Platform devices and busses creation */
-extern struct of_device *of_platform_device_create(struct device_node *np,
-						const char *bus_id,
-						struct device *parent);
-/* pseudo "matches" value to not do deep probe */
-#define OF_NO_DEEP_PROBE ((struct of_device_id *)-1)
-
-extern int of_platform_bus_probe(struct device_node *root,
-				const struct of_device_id *matches,
-				struct device *parent);
-
 extern struct of_device *of_find_device_by_phandle(phandle ph);
 
 extern void of_instantiate_rtc(void);
diff --git a/arch/microblaze/kernel/of_platform.c b/arch/microblaze/kernel/of_platform.c
index ccf6f42..a07abdd 100644
--- a/arch/microblaze/kernel/of_platform.c
+++ b/arch/microblaze/kernel/of_platform.c
@@ -37,132 +37,27 @@ static int __init of_bus_driver_init(void)
 }
 postcore_initcall(of_bus_driver_init);
 
-struct of_device *of_platform_device_create(struct device_node *np,
-					    const char *bus_id,
-					    struct device *parent)
-{
-	struct of_device *dev;
-
-	dev = of_device_alloc(np, bus_id, parent);
-	if (!dev)
-		return NULL;
-
-	dev->archdata.dma_mask = 0xffffffffUL;
-	dev->dev.bus = &of_platform_bus_type;
-
-	/* We do not fill the DMA ops for platform devices by default.
-	 * This is currently the responsibility of the platform code
-	 * to do such, possibly using a device notifier
-	 */
-
-	if (of_device_register(dev) != 0) {
-		of_device_free(dev);
-		return NULL;
-	}
-
-	return dev;
-}
-EXPORT_SYMBOL(of_platform_device_create);
-
-/**
- * of_platform_bus_create - Create an OF device for a bus node and all its
- * children. Optionally recursively instanciate matching busses.
- * @bus: device node of the bus to instanciate
- * @matches: match table, NULL to use the default, OF_NO_DEEP_PROBE to
- * disallow recursive creation of child busses
- */
-static int of_platform_bus_create(const struct device_node *bus,
-				  const struct of_device_id *matches,
-				  struct device *parent)
-{
-	struct device_node *child;
-	struct of_device *dev;
-	int rc = 0;
-
-	for_each_child_of_node(bus, child) {
-		pr_debug("   create child: %s\n", child->full_name);
-		dev = of_platform_device_create(child, NULL, parent);
-		if (dev == NULL)
-			rc = -ENOMEM;
-		else if (!of_match_node(matches, child))
-			continue;
-		if (rc == 0) {
-			pr_debug("   and sub busses\n");
-			rc = of_platform_bus_create(child, matches, &dev->dev);
-		}
-		if (rc) {
-			of_node_put(child);
-			break;
-		}
-	}
-	return rc;
-}
-
-
-/**
- * of_platform_bus_probe - Probe the device-tree for platform busses
- * @root: parent of the first level to probe or NULL for the root of the tree
- * @matches: match table, NULL to use the default
- * @parent: parent to hook devices from, NULL for toplevel
+/*
+ * The list of OF IDs below is used for matching bus types in the
+ * system whose devices are to be exposed as of_platform_devices.
  *
- * Note that children of the provided root are not instanciated as devices
- * unless the specified root itself matches the bus list and is not NULL.
+ * This is the default list valid for most platforms. This file provides
+ * functions who can take an explicit list if necessary though
+ *
+ * The search is always performed recursively looking for children of
+ * the provided device_node and recursively if such a children matches
+ * a bus type in the list
  */
 
-int of_platform_bus_probe(struct device_node *root,
-			  const struct of_device_id *matches,
-			  struct device *parent)
-{
-	struct device_node *child;
-	struct of_device *dev;
-	int rc = 0;
-
-	if (matches == NULL)
-		matches = of_default_bus_ids;
-	if (matches == OF_NO_DEEP_PROBE)
-		return -EINVAL;
-	if (root == NULL)
-		root = of_find_node_by_path("/");
-	else
-		of_node_get(root);
-
-	pr_debug("of_platform_bus_probe()\n");
-	pr_debug(" starting at: %s\n", root->full_name);
-
-	/* Do a self check of bus type, if there's a match, create
-	 * children
-	 */
-	if (of_match_node(matches, root)) {
-		pr_debug(" root match, create all sub devices\n");
-		dev = of_platform_device_create(root, NULL, parent);
-		if (dev == NULL) {
-			rc = -ENOMEM;
-			goto bail;
-		}
-		pr_debug(" create all sub busses\n");
-		rc = of_platform_bus_create(root, matches, &dev->dev);
-		goto bail;
-	}
-	for_each_child_of_node(root, child) {
-		if (!of_match_node(matches, child))
-			continue;
-
-		pr_debug("  match: %s\n", child->full_name);
-		dev = of_platform_device_create(child, NULL, parent);
-		if (dev == NULL)
-			rc = -ENOMEM;
-		else
-			rc = of_platform_bus_create(child, matches, &dev->dev);
-		if (rc) {
-			of_node_put(child);
-			break;
-		}
-	}
- bail:
-	of_node_put(root);
-	return rc;
-}
-EXPORT_SYMBOL(of_platform_bus_probe);
+const struct of_device_id of_default_bus_ids[] = {
+	{ .type = "soc", },
+	{ .compatible = "soc", },
+	{ .type = "plb5", },
+	{ .type = "plb4", },
+	{ .type = "opb", },
+	{ .type = "simple", },
+	{},
+};
 
 static int of_dev_node_match(struct device *dev, void *data)
 {
diff --git a/arch/powerpc/include/asm/of_platform.h b/arch/powerpc/include/asm/of_platform.h
index d4aaa34..b37d2dc 100644
--- a/arch/powerpc/include/asm/of_platform.h
+++ b/arch/powerpc/include/asm/of_platform.h
@@ -11,17 +11,6 @@
  *
  */
 
-/* Platform devices and busses creation */
-extern struct of_device *of_platform_device_create(struct device_node *np,
-						   const char *bus_id,
-						   struct device *parent);
-/* pseudo "matches" value to not do deep probe */
-#define OF_NO_DEEP_PROBE ((struct of_device_id *)-1)
-
-extern int of_platform_bus_probe(struct device_node *root,
-				 const struct of_device_id *matches,
-				 struct device *parent);
-
 extern struct of_device *of_find_device_by_phandle(phandle ph);
 
 extern void of_instantiate_rtc(void);
diff --git a/arch/powerpc/kernel/of_platform.c b/arch/powerpc/kernel/of_platform.c
index 487a988..0b5cc6d 100644
--- a/arch/powerpc/kernel/of_platform.c
+++ b/arch/powerpc/kernel/of_platform.c
@@ -40,7 +40,7 @@
  * a bus type in the list
  */
 
-static const struct of_device_id of_default_bus_ids[] = {
+const struct of_device_id of_default_bus_ids[] = {
 	{ .type = "soc", },
 	{ .compatible = "soc", },
 	{ .type = "spider", },
@@ -64,135 +64,6 @@ static int __init of_bus_driver_init(void)
 
 postcore_initcall(of_bus_driver_init);
 
-struct of_device* of_platform_device_create(struct device_node *np,
-					    const char *bus_id,
-					    struct device *parent)
-{
-	struct of_device *dev;
-
-	dev = of_device_alloc(np, bus_id, parent);
-	if (!dev)
-		return NULL;
-
-	dev->archdata.dma_mask = 0xffffffffUL;
-	dev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
-
-	dev->dev.bus = &of_platform_bus_type;
-
-	/* We do not fill the DMA ops for platform devices by default.
-	 * This is currently the responsibility of the platform code
-	 * to do such, possibly using a device notifier
-	 */
-
-	if (of_device_register(dev) != 0) {
-		of_device_free(dev);
-		return NULL;
-	}
-
-	return dev;
-}
-EXPORT_SYMBOL(of_platform_device_create);
-
-
-
-/**
- * of_platform_bus_create - Create an OF device for a bus node and all its
- * children. Optionally recursively instanciate matching busses.
- * @bus: device node of the bus to instanciate
- * @matches: match table, NULL to use the default, OF_NO_DEEP_PROBE to
- * disallow recursive creation of child busses
- */
-static int of_platform_bus_create(const struct device_node *bus,
-				  const struct of_device_id *matches,
-				  struct device *parent)
-{
-	struct device_node *child;
-	struct of_device *dev;
-	int rc = 0;
-
-	for_each_child_of_node(bus, child) {
-		pr_debug("   create child: %s\n", child->full_name);
-		dev = of_platform_device_create(child, NULL, parent);
-		if (dev == NULL)
-			rc = -ENOMEM;
-		else if (!of_match_node(matches, child))
-			continue;
-		if (rc == 0) {
-			pr_debug("   and sub busses\n");
-			rc = of_platform_bus_create(child, matches, &dev->dev);
-		} if (rc) {
-			of_node_put(child);
-			break;
-		}
-	}
-	return rc;
-}
-
-/**
- * of_platform_bus_probe - Probe the device-tree for platform busses
- * @root: parent of the first level to probe or NULL for the root of the tree
- * @matches: match table, NULL to use the default
- * @parent: parent to hook devices from, NULL for toplevel
- *
- * Note that children of the provided root are not instanciated as devices
- * unless the specified root itself matches the bus list and is not NULL.
- */
-
-int of_platform_bus_probe(struct device_node *root,
-			  const struct of_device_id *matches,
-			  struct device *parent)
-{
-	struct device_node *child;
-	struct of_device *dev;
-	int rc = 0;
-
-	if (matches == NULL)
-		matches = of_default_bus_ids;
-	if (matches == OF_NO_DEEP_PROBE)
-		return -EINVAL;
-	if (root == NULL)
-		root = of_find_node_by_path("/");
-	else
-		of_node_get(root);
-
-	pr_debug("of_platform_bus_probe()\n");
-	pr_debug(" starting at: %s\n", root->full_name);
-
-	/* Do a self check of bus type, if there's a match, create
-	 * children
-	 */
-	if (of_match_node(matches, root)) {
-		pr_debug(" root match, create all sub devices\n");
-		dev = of_platform_device_create(root, NULL, parent);
-		if (dev == NULL) {
-			rc = -ENOMEM;
-			goto bail;
-		}
-		pr_debug(" create all sub busses\n");
-		rc = of_platform_bus_create(root, matches, &dev->dev);
-		goto bail;
-	}
-	for_each_child_of_node(root, child) {
-		if (!of_match_node(matches, child))
-			continue;
-
-		pr_debug("  match: %s\n", child->full_name);
-		dev = of_platform_device_create(child, NULL, parent);
-		if (dev == NULL)
-			rc = -ENOMEM;
-		else
-			rc = of_platform_bus_create(child, matches, &dev->dev);
-		if (rc) {
-			of_node_put(child);
-			break;
-		}
-	}
- bail:
-	of_node_put(root);
-	return rc;
-}
-EXPORT_SYMBOL(of_platform_bus_probe);
-
 static int of_dev_node_match(struct device *dev, void *data)
 {
 	return to_of_device(dev)->dev.of_node == data;
diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 7dacc1e..d9c81e9 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -14,6 +14,7 @@
 #include <linux/errno.h>
 #include <linux/module.h>
 #include <linux/device.h>
+#include <linux/dma-mapping.h>
 #include <linux/of_device.h>
 #include <linux/of_platform.h>
 
@@ -396,3 +397,145 @@ void of_unregister_driver(struct of_platform_driver *drv)
 	driver_unregister(&drv->driver);
 }
 EXPORT_SYMBOL(of_unregister_driver);
+
+#if !defined(CONFIG_SPARC)
+/*
+ * The following routines scan a subtree and registers a device for
+ * each applicable node.
+ *
+ * Note: sparc doesn't use these routines because it has a different
+ * mechanism for creating devices from device tree nodes.
+ */
+
+/**
+ * of_platform_device_create - Alloc, initialize and register an of_device
+ * @np: pointer to node to create device for
+ * @bus_id: name to assign device
+ * @parent: Linux device model parent device.
+ */
+struct of_device *of_platform_device_create(struct device_node *np,
+					    const char *bus_id,
+					    struct device *parent)
+{
+	struct of_device *dev;
+
+	dev = of_device_alloc(np, bus_id, parent);
+	if (!dev)
+		return NULL;
+
+	dev->archdata.dma_mask = 0xffffffffUL;
+	dev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
+	dev->dev.bus = &of_platform_bus_type;
+
+	/* We do not fill the DMA ops for platform devices by default.
+	 * This is currently the responsibility of the platform code
+	 * to do such, possibly using a device notifier
+	 */
+
+	if (of_device_register(dev) != 0) {
+		of_device_free(dev);
+		return NULL;
+	}
+
+	return dev;
+}
+EXPORT_SYMBOL(of_platform_device_create);
+
+/**
+ * of_platform_bus_create - Create an OF device for a bus node and all its
+ * children. Optionally recursively instantiate matching busses.
+ * @bus: device node of the bus to instantiate
+ * @matches: match table, NULL to use the default, OF_NO_DEEP_PROBE to
+ * disallow recursive creation of child busses
+ */
+static int of_platform_bus_create(const struct device_node *bus,
+				  const struct of_device_id *matches,
+				  struct device *parent)
+{
+	struct device_node *child;
+	struct of_device *dev;
+	int rc = 0;
+
+	for_each_child_of_node(bus, child) {
+		pr_debug("   create child: %s\n", child->full_name);
+		dev = of_platform_device_create(child, NULL, parent);
+		if (dev == NULL)
+			rc = -ENOMEM;
+		else if (!of_match_node(matches, child))
+			continue;
+		if (rc == 0) {
+			pr_debug("   and sub busses\n");
+			rc = of_platform_bus_create(child, matches, &dev->dev);
+		}
+		if (rc) {
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
+ * Note that children of the provided root are not instantiated as devices
+ * unless the specified root itself matches the bus list and is not NULL.
+ */
+int of_platform_bus_probe(struct device_node *root,
+			  const struct of_device_id *matches,
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
+	for_each_child_of_node(root, child) {
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
+#endif /* !CONFIG_SPARC */
diff --git a/include/linux/of_platform.h b/include/linux/of_platform.h
index 1643d37..4bbba41 100644
--- a/include/linux/of_platform.h
+++ b/include/linux/of_platform.h
@@ -25,6 +25,8 @@
  */
 extern struct bus_type of_platform_bus_type;
 
+extern const struct of_device_id of_default_bus_ids[];
+
 /*
  * An of_platform_driver driver is attached to a basic of_device on
  * the "platform bus" (of_platform_bus_type).
@@ -63,6 +65,21 @@ static inline void of_unregister_platform_driver(struct of_platform_driver *drv)
 extern struct of_device *of_find_device_by_node(struct device_node *np);
 
 extern int of_bus_type_init(struct bus_type *bus, const char *name);
+
+#if !defined(CONFIG_SPARC) /* SPARC has its own device registration method */
+/* Platform devices and busses creation */
+extern struct of_device *of_platform_device_create(struct device_node *np,
+						   const char *bus_id,
+						   struct device *parent);
+
+/* pseudo "matches" value to not do deep probe */
+#define OF_NO_DEEP_PROBE ((struct of_device_id *)-1)
+
+extern int of_platform_bus_probe(struct device_node *root,
+				 const struct of_device_id *matches,
+				 struct device *parent);
+#endif /* !CONFIG_SPARC */
+
 #endif /* CONFIG_OF_DEVICE */
 
 #endif	/* _LINUX_OF_PLATFORM_H */
