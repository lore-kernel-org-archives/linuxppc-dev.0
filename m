Return-Path: <grant.likely@secretlab.ca>
Sender: Grant Likely <glikely@secretlab.ca>
Subject: [PATCH] of/device: Don't register disabled devices
To: devicetree-discuss@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 03 Jan 2011 16:01:22 -0700
Message-ID: <20110103230122.25772.72990.stgit@localhost6.localdomain6>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Scott Wood <scottwood@freescale.com>,
	Deepak Saxena <deepak_saxena@mentor.com>,
	Hollis Blanchard <hollis_blanchard@mentor.com>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Device nodes with the property status="disabled" are not usable and so
don't register them when parsing the device tree for devices.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
Cc: Hollis Blanchard <hollis_blanchard@mentor.com>
Cc: Deepak Saxena <deepak_saxena@mentor.com>
Cc: Scott Wood <scottwood@freescale.com>,
Cc: David Gibson <david@gibson.dropbear.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 drivers/of/platform.c |   22 ++++++++++++++--------
 1 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 5b4a07f..c01cd1a 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -633,6 +633,9 @@ EXPORT_SYMBOL(of_device_alloc);
  * @np: pointer to node to create device for
  * @bus_id: name to assign device
  * @parent: Linux device model parent device.
+ *
+ * Returns pointer to created platform device, or NULL if a device was not
+ * registered.  Unavailable devices will not get registered.
  */
 struct platform_device *of_platform_device_create(struct device_node *np,
 					    const char *bus_id,
@@ -640,6 +643,9 @@ struct platform_device *of_platform_device_create(struct device_node *np,
 {
 	struct platform_device *dev;
 
+	if (!of_device_is_available(np))
+		return NULL;
+
 	dev = of_device_alloc(np, bus_id, parent);
 	if (!dev)
 		return NULL;
@@ -683,8 +689,9 @@ static int of_platform_bus_create(const struct device_node *bus,
 		pr_debug("   create child: %s\n", child->full_name);
 		dev = of_platform_device_create(child, NULL, parent);
 		if (dev == NULL)
-			rc = -ENOMEM;
-		else if (!of_match_node(matches, child))
+			continue;
+
+		if (!of_match_node(matches, child))
 			continue;
 		if (rc == 0) {
 			pr_debug("   and sub busses\n");
@@ -733,10 +740,9 @@ int of_platform_bus_probe(struct device_node *root,
 	if (of_match_node(matches, root)) {
 		pr_debug(" root match, create all sub devices\n");
 		dev = of_platform_device_create(root, NULL, parent);
-		if (dev == NULL) {
-			rc = -ENOMEM;
+		if (dev == NULL)
 			goto bail;
-		}
+
 		pr_debug(" create all sub busses\n");
 		rc = of_platform_bus_create(root, matches, &dev->dev);
 		goto bail;
@@ -748,9 +754,9 @@ int of_platform_bus_probe(struct device_node *root,
 		pr_debug("  match: %s\n", child->full_name);
 		dev = of_platform_device_create(child, NULL, parent);
 		if (dev == NULL)
-			rc = -ENOMEM;
-		else
-			rc = of_platform_bus_create(child, matches, &dev->dev);
+			continue;
+
+		rc = of_platform_bus_create(child, matches, &dev->dev);
 		if (rc) {
 			of_node_put(child);
 			break;
