Return-Path: <grant.likely@secretlab.ca>
Sender: Grant Likely <glikely@secretlab.ca>
Subject: [RFC] dt: add of_platform_bus_snoop() which attaches nodes to devices
To: linaro-dev@lists.linaro.org, devicetree-discuss@lists.ozlabs.org,
	linuxppc-dev@lists.ozlabs.org
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 31 Jan 2011 15:01:01 -0700
Message-ID: <20110131215935.26336.32719.stgit@localhost6.localdomain6>
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

This patch implements an alternate method for using device tree data
for populating machine device registration.  Traditionally, board
support has directly generated and registered devices based on nodes
in the device tree.  The board support code starts at the root of the
tree and begins allocating devices for each device node it finds.
Similarly, bus drivers (i2c, spi, etc.) use their child nodes to
register child devices.  This model can be seen in almost all the powerpc
board ports (arch/powerpc/platforms/*).

However, for many of the ARM SoCs, there already exists complete board
support for many SoCs that have their own code for registering the
basic set of platform devices with non-trivial dependencies on clock
structure and machine specific platform code.  While starting at the
base of the tree and working up is certainly possible, it requires
modifying a lot of machine support code to get it working.

Instead, this patch provides an alternate approach.  Instead of
starting at the root of the tree and working up, this patch allows the
SoC support code to register its standard set of platform devices in
the normal way.  However, it also registers a platform_bus notifier
function which compares platform_device registrations with data in the
device tree.  Whenever it finds a matching node, it increments the
node reference count and assigns it to the device's of_node pointer so
that it is available for the device driver to use and bind against.
For example, an spi master driver would have access to the spi node
which contains information about all the spi slaves on the bus.

An example usage of this facility is to allow a single 'devicetree'
board support file to support multiple machines all using the same
SoC.  The common code would register SoC devices unconditionally, and
the board support code would depend entirely on device tree data.

Note: Board ports using this facility are still required to provide a
fully populated device tree blob.  It is not a shortcut to providing
an accurate device tree model of the machine to the point that it
would be reasonably possible to switch to a direct registration model
for all devices without change the device tree.  ie. The SoC still
needs to be correctly identified and there should be nodes for all the
discrete devices.

I'm not convinced that this is the model to pursue over the long term,
but it greatly simplifies the task of getting device tree support up
and running, and it provides a migration path to full dt device
registration (if it makes sense to do so).

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

This patch can be found in my devicetree/test branch (frequently rebased)

  git://git.secretlab.ca/git/linux-2.6 devicetree/test

I'll move it to devicetree/arm (never rebased) once it is stable.

g.

 arch/arm/mach-versatile/core.c |    3 +
 drivers/of/address.c           |   14 ++
 drivers/of/base.c              |    3 +
 drivers/of/platform.c          |  230 ++++++++++++++++++++++++++++++++++++++++
 include/linux/of_address.h     |    1 
 include/linux/of_platform.h    |    2 
 6 files changed, 253 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-versatile/core.c b/arch/arm/mach-versatile/core.c
index 136c32e..86ad01d 100644
--- a/arch/arm/mach-versatile/core.c
+++ b/arch/arm/mach-versatile/core.c
@@ -21,6 +21,7 @@
 #include <linux/init.h>
 #include <linux/device.h>
 #include <linux/dma-mapping.h>
+#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/sysdev.h>
 #include <linux/interrupt.h>
@@ -873,6 +874,8 @@ void __init versatile_init(void)
 
 	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
 
+	of_platform_bus_snoop(NULL, NULL);
+
 	platform_device_register(&versatile_flash_device);
 	platform_device_register(&versatile_i2c_device);
 	platform_device_register(&smc91x_device);
diff --git a/drivers/of/address.c b/drivers/of/address.c
index b4559c5..b43ff66 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -556,6 +556,20 @@ static int __of_address_to_resource(struct device_node *dev,
 }
 
 /**
+ * of_address_count - Return the number of entries in the reg property
+ */
+int of_address_count(struct device_node *np)
+{
+	struct resource temp_res;
+	int num_reg = 0;
+
+	while (of_address_to_resource(np, num_reg, &temp_res) == 0)
+		num_reg++;
+	return num_reg;
+}
+EXPORT_SYMBOL_GPL(of_address_count);
+
+/**
  * of_address_to_resource - Translate device tree address and return as resource
  *
  * Note that if your address is a PIO address, the conversion will fail if
diff --git a/drivers/of/base.c b/drivers/of/base.c
index 710b53b..632ebae 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -496,6 +496,9 @@ EXPORT_SYMBOL(of_find_node_with_property);
 const struct of_device_id *of_match_node(const struct of_device_id *matches,
 					 const struct device_node *node)
 {
+	if (!matches)
+		return NULL;
+
 	while (matches->name[0] || matches->type[0] || matches->compatible[0]) {
 		int match = 1;
 		if (matches->name[0])
diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index c01cd1a..559bfe3 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -11,11 +11,15 @@
  *  2 of the License, or (at your option) any later version.
  *
  */
+
+#define DEBUG
+
 #include <linux/errno.h>
 #include <linux/module.h>
 #include <linux/device.h>
 #include <linux/dma-mapping.h>
 #include <linux/slab.h>
+#include <linux/notifier.h>
 #include <linux/of_address.h>
 #include <linux/of_device.h>
 #include <linux/of_irq.h>
@@ -767,4 +771,230 @@ int of_platform_bus_probe(struct device_node *root,
 	return rc;
 }
 EXPORT_SYMBOL(of_platform_bus_probe);
+
+
+struct of_platform_bus_snoop_node_data {
+	struct list_head list;
+	struct device_node *node;
+	struct device *dev;		/* assigned device */
+
+	int num_resources;
+	struct resource resource[0];
+};
+
+struct of_platform_bus_snoop_data {
+	struct list_head nodes;
+	struct notifier_block nb;
+};
+
+static bool of_pdev_match_resources(struct platform_device *pdev,
+			struct of_platform_bus_snoop_node_data *node_data)
+{
+	struct resource *node_res = node_data->resource;
+	struct resource *pdev_res = pdev->resource;
+	int i, j;
+
+	/* Compare both resource tables and make sure every node resource
+	 * is represented by the platform device.  Here we check that each
+	 * resource has corresponding entry with the same type and start
+	 * values, and the end value falls inside the range specified
+	 * in the device tree node. */
+	for (i = 0; i < node_data->num_resources; i++, node_res++) {
+		for (j = 0; j < pdev->num_resources; j++, pdev_res++) {
+			if ((pdev_res->start == node_res->start) &&
+			    (pdev_res->end >= node_res->start) &&
+			    (pdev_res->end <= node_res->end) &&
+			    (pdev_res->flags == node_res->flags))
+				break;
+		}
+		if (j >= pdev->num_resources)
+			return false;
+	}
+	return true;
+}
+
+static int of_platform_bus_snoop_notifier_call(struct notifier_block *nb,
+					unsigned long event, void *_dev)
+{
+	struct platform_device *pdev = to_platform_device(_dev);
+	struct of_platform_bus_snoop_data *data;
+	struct of_platform_bus_snoop_node_data *node_data;
+
+#ifdef DEBUG
+	struct resource *res = pdev->resource;
+	int i;
+	pr_debug("snooping: '%s':\n", dev_name(&pdev->dev));
+	for (i = 0; i < pdev->num_resources; i++, res++)
+		pr_debug("snooping:    %2i:%.8x..%.8x[%lx]\n", i,
+			res->start, res->end, res->flags);
+#endif
+
+	if (pdev->dev.of_node)
+		return NOTIFY_DONE;
+
+	data = container_of(nb, struct of_platform_bus_snoop_data, nb);
+
+	switch (event) {
+	case BUS_NOTIFY_ADD_DEVICE:
+		list_for_each_entry(node_data, &data->nodes, list) {
+			if (node_data->dev)
+				continue;
+
+			if (!of_pdev_match_resources(pdev, node_data))
+				continue;
+
+			pr_debug("%s: add reference to node %s\n",
+				dev_name(&pdev->dev),
+				node_data->node->full_name);
+			node_data->dev = get_device(&pdev->dev);
+			pdev->dev.of_node = of_node_get(node_data->node);
+			return NOTIFY_OK;
+		}
+		break;
+
+	case BUS_NOTIFY_DEL_DEVICE:
+		list_for_each_entry(node_data, &data->nodes, list) {
+			if (node_data->dev == &pdev->dev) {
+				pr_debug("%s: removing reference to %s\n",
+					dev_name(&pdev->dev),
+					node_data->node->full_name);
+				of_node_put(pdev->dev.of_node);
+				put_device(node_data->dev);
+				pdev->dev.of_node = NULL;
+				node_data->dev = NULL;
+				return NOTIFY_OK;
+			}
+		}
+		break;
+	}
+
+	return NOTIFY_DONE;
+}
+
+int of_platform_bus_snoop_children(struct of_platform_bus_snoop_data *data,
+				   struct device_node *parent,
+				   const struct of_device_id *bus_match)
+{
+	struct device_node *child;
+
+	/* Loop over children and record the details */
+	for_each_child_of_node(parent, child) {
+		struct of_platform_bus_snoop_node_data *node_data;
+		struct resource *res;
+		int num_irq, num_reg, i, rc;
+
+		/* Make sure it has a compatible property */
+		if (!of_get_property(child, "compatible", NULL))
+			continue;
+
+		num_irq = of_irq_count(child);
+		num_reg = of_address_count(child);
+		node_data = kzalloc(sizeof(*node_data) +
+				(sizeof(struct resource) * (num_irq + num_reg)),
+				GFP_KERNEL);
+		if (!node_data)
+			return -ENOMEM;
+		INIT_LIST_HEAD(&node_data->list);
+
+		res = &node_data->resource[0];
+		for (i = 0; i < num_reg; i++, res++)
+			WARN_ON(of_address_to_resource(child, i, res));
+		WARN_ON(of_irq_to_resource_table(child, res, num_irq) != num_irq);
+		node_data->num_resources = num_reg + num_irq;
+		node_data->node = of_node_get(child);
+
+		list_add_tail(&node_data->list, &data->nodes);
+
+		/* If this is a bus node, recursively inspect the children */
+		if (of_match_node(bus_match, child)) {
+			rc = of_platform_bus_snoop_children(data, child, bus_match);
+			if (rc)
+				return rc;
+		}
+	}
+
+	return 0;
+}
+
+/**
+ * of_platform_bus_snoop - Attach device nodes to platform bus registrations.
+ * @root: parent of the first level to probe or NULL for the root of the tree
+ * @bus_match: match table for child bus nodes, or NULL
+ *
+ * This function sets up 'snooping' of device tree registrations and
+ * when a device registration is found that matches a node in the
+ * device tree, it populates the platform_device with a pointer to the
+ * matching node.
+ *
+ * A bus notifier is used to implement this behaviour.  When this
+ * function is called, it will parse all the child nodes of @root and
+ * create a lookup table of eligible device nodes.  A device node is
+ * considered eligible if it:
+ *    a) has a compatible property,
+ *    b) has memory mapped registers, and
+ *    c) has a mappable interrupt.
+ *
+ * It will also recursively parse child buses providing
+ *    a) the child bus node has a ranges property (children have
+ *       memory-mapped registers), and
+ *    b) it is compatible with the @matches list.
+ *
+ * The lookup table will be used as data for a platform bus notifier
+ * that will compare each new device registration with the table
+ * before a device driver is bound to it.  If there is a match, then
+ * the of_node pointer will be added to the device.  Therefore it is
+ * important to call this function *before* any platform devices get
+ * registered.
+ */
+int __init of_platform_bus_snoop(struct device_node *root,
+				 const struct of_device_id *bus_match)
+{
+	struct of_platform_bus_snoop_data *data;
+	struct of_platform_bus_snoop_node_data *node_data, *tmp;
+	int rc;
+
+	if (!root)
+		root = of_find_node_by_path("/");
+	else
+		of_node_get(root);
+	if (root == NULL)
+		return -EINVAL;
+
+	pr_debug("of_platform_bus_snoop()\n");
+	pr_debug(" starting at: %s\n", root->full_name);
+
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+	INIT_LIST_HEAD(&data->nodes);
+
+	rc = of_platform_bus_snoop_children(data, root, bus_match);
+	if (rc)
+		goto bail;
+
+#ifdef DEBUG
+	list_for_each_entry(node_data, &data->nodes, list) {
+		struct resource *res = node_data->resource;
+		int i;
+		pr_info("snoop: '%s':\n", node_data->node->full_name);
+		for (i = 0; i < node_data->num_resources; i++, res++)
+			pr_info("snoop:    %2i:%.8x..%.8x[%lx]\n", i,
+				res->start, res->end, res->flags);
+	}
+#endif
+
+	data->nb.notifier_call = of_platform_bus_snoop_notifier_call;
+	bus_register_notifier(&platform_bus_type, &data->nb);
+
+	return 0;
+
+ bail:
+	list_for_each_entry_safe(node_data, tmp, &data->nodes, list) {
+		list_del(&node_data->list);
+		of_node_put(node_data->node);
+		kfree(node_data);
+	}
+	kfree(data);
+	return rc;
+}
 #endif /* !CONFIG_SPARC */
diff --git a/include/linux/of_address.h b/include/linux/of_address.h
index 2feda6e..6711d5f 100644
--- a/include/linux/of_address.h
+++ b/include/linux/of_address.h
@@ -3,6 +3,7 @@
 #include <linux/ioport.h>
 #include <linux/of.h>
 
+extern int of_address_count(struct device_node *np);
 extern u64 of_translate_address(struct device_node *np, const __be32 *addr);
 extern int of_address_to_resource(struct device_node *dev, int index,
 				  struct resource *r);
diff --git a/include/linux/of_platform.h b/include/linux/of_platform.h
index a68716a..bf40328 100644
--- a/include/linux/of_platform.h
+++ b/include/linux/of_platform.h
@@ -74,6 +74,8 @@ extern struct platform_device *of_platform_device_create(struct device_node *np,
 extern int of_platform_bus_probe(struct device_node *root,
 				 const struct of_device_id *matches,
 				 struct device *parent);
+extern int of_platform_bus_snoop(struct device_node *root,
+				 const struct of_device_id *bus_match);
 #endif /* !CONFIG_SPARC */
 
 #endif /* CONFIG_OF_DEVICE */
