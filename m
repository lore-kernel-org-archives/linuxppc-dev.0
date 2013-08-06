Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH 23/63] powerpc: Make device tree accesses in VIO subsystem
 endian safe
Date: Wed,  7 Aug 2013 02:01:40 +1000
Message-Id: <1375804940-22050-24-git-send-email-anton@samba.org>
In-Reply-To: <1375804940-22050-1-git-send-email-anton@samba.org>
References: <1375804940-22050-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/kernel/vio.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/kernel/vio.c b/arch/powerpc/kernel/vio.c
index 31875a6..78a3506 100644
--- a/arch/powerpc/kernel/vio.c
+++ b/arch/powerpc/kernel/vio.c
@@ -1312,8 +1312,7 @@ struct vio_dev *vio_register_device_node(struct device_node *of_node)
 {
 	struct vio_dev *viodev;
 	struct device_node *parent_node;
-	const unsigned int *unit_address;
-	const unsigned int *pfo_resid = NULL;
+	const __be32 *prop;
 	enum vio_dev_family family;
 	const char *of_node_name = of_node->name ? of_node->name : "<unknown>";
 
@@ -1360,6 +1359,8 @@ struct vio_dev *vio_register_device_node(struct device_node *of_node)
 	/* we need the 'device_type' property, in order to match with drivers */
 	viodev->family = family;
 	if (viodev->family == VDEVICE) {
+		unsigned int unit_address;
+
 		if (of_node->type != NULL)
 			viodev->type = of_node->type;
 		else {
@@ -1368,24 +1369,24 @@ struct vio_dev *vio_register_device_node(struct device_node *of_node)
 			goto out;
 		}
 
-		unit_address = of_get_property(of_node, "reg", NULL);
-		if (unit_address == NULL) {
+		prop = of_get_property(of_node, "reg", NULL);
+		if (prop == NULL) {
 			pr_warn("%s: node %s missing 'reg'\n",
 					__func__, of_node_name);
 			goto out;
 		}
-		dev_set_name(&viodev->dev, "%x", *unit_address);
+		unit_address = of_read_number(prop, 1);
+		dev_set_name(&viodev->dev, "%x", unit_address);
 		viodev->irq = irq_of_parse_and_map(of_node, 0);
-		viodev->unit_address = *unit_address;
+		viodev->unit_address = unit_address;
 	} else {
 		/* PFO devices need their resource_id for submitting COP_OPs
 		 * This is an optional field for devices, but is required when
 		 * performing synchronous ops */
-		pfo_resid = of_get_property(of_node, "ibm,resource-id", NULL);
-		if (pfo_resid != NULL)
-			viodev->resource_id = *pfo_resid;
+		prop = of_get_property(of_node, "ibm,resource-id", NULL);
+		if (prop != NULL)
+			viodev->resource_id = of_read_number(prop, 1);
 
-		unit_address = NULL;
 		dev_set_name(&viodev->dev, "%s", of_node_name);
 		viodev->type = of_node_name;
 		viodev->irq = 0;
@@ -1622,7 +1623,6 @@ static struct vio_dev *vio_find_name(const char *name)
  */
 struct vio_dev *vio_find_node(struct device_node *vnode)
 {
-	const uint32_t *unit_address;
 	char kobj_name[20];
 	struct device_node *vnode_parent;
 	const char *dev_type;
@@ -1638,10 +1638,13 @@ struct vio_dev *vio_find_node(struct device_node *vnode)
 
 	/* construct the kobject name from the device node */
 	if (!strcmp(dev_type, "vdevice")) {
-		unit_address = of_get_property(vnode, "reg", NULL);
-		if (!unit_address)
+		const __be32 *prop;
+		
+		prop = of_get_property(vnode, "reg", NULL);
+		if (!prop)
 			return NULL;
-		snprintf(kobj_name, sizeof(kobj_name), "%x", *unit_address);
+		snprintf(kobj_name, sizeof(kobj_name), "%x",
+			 (uint32_t)of_read_number(prop, 1));
 	} else if (!strcmp(dev_type, "ibm,platform-facilities"))
 		snprintf(kobj_name, sizeof(kobj_name), "%s", vnode->name);
 	else
-- 
1.8.1.2
