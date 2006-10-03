Return-Path: <b07421@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id AAE2A67CA6
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Oct 2006 08:57:04 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	k93Mv2Nr025646
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Oct 2006 15:57:02 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.82.65.62])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id k93Mv17W012437
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Oct 2006 17:57:01 -0500 (CDT)
Date: Tue, 3 Oct 2006 17:56:59 -0500
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Add of_platform_device_scan().
Message-ID: <20061003225659.GA11955@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds of_platform_device_scan(), which adds matching device
nodes to the of_platform bus.  The goal is to let drivers reuse the match
struct to do this, rather than have special code in fsl_soc.c (or
equivalent) that knows which nodes to add.

This will be used by the ucc_geth.c driver; in the current QE patchset,
it registers an of_platform driver for devices that never get registered.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/kernel/of_device.c |   80 ++++++++++++++++++++++++++++++---------
 include/asm-powerpc/of_device.h |    1 
 2 files changed, 63 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/kernel/of_device.c b/arch/powerpc/kernel/of_device.c
index 397c83e..1bd8fe6 100644
--- a/arch/powerpc/kernel/of_device.c
+++ b/arch/powerpc/kernel/of_device.c
@@ -8,36 +8,50 @@ #include <linux/slab.h>
 #include <asm/errno.h>
 #include <asm/of_device.h>
 
+static const struct of_device_id *
+of_match_device_by_node(const struct of_device_id *matches,
+                        struct device_node *node)
+{
+	while (matches->name[0] || matches->type[0] || matches->compatible[0]) {
+		int match = 1;
+
+		if (matches->name[0] && (!node->name ||
+		    strcmp(matches->name, node->name)))
+			match = 0;
+
+		if (matches->type[0] && (!node->type ||
+		    strcmp(matches->type, node->type)))
+			match = 0;
+
+		if (matches->compatible[0] &&
+		    !device_is_compatible(node, matches->compatible))
+			match = 0;
+
+		if (match)
+			return matches;
+
+		matches++;
+	}
+
+	return NULL;
+}
+
 /**
  * of_match_device - Tell if an of_device structure has a matching
  * of_match structure
- * @ids: array of of device match structures to search in
+ * @matches: array of of device match structures to search in
  * @dev: the of device structure to match against
  *
  * Used by a driver to check whether an of_device present in the
  * system is in its list of supported devices.
  */
 const struct of_device_id *of_match_device(const struct of_device_id *matches,
-					const struct of_device *dev)
+                                           const struct of_device *dev)
 {
 	if (!dev->node)
 		return NULL;
-	while (matches->name[0] || matches->type[0] || matches->compatible[0]) {
-		int match = 1;
-		if (matches->name[0])
-			match &= dev->node->name
-				&& !strcmp(matches->name, dev->node->name);
-		if (matches->type[0])
-			match &= dev->node->type
-				&& !strcmp(matches->type, dev->node->type);
-		if (matches->compatible[0])
-			match &= device_is_compatible(dev->node,
-				matches->compatible);
-		if (match)
-			return matches;
-		matches++;
-	}
-	return NULL;
+
+	return of_match_device_by_node(matches, dev->node);
 }
 
 static int of_platform_bus_match(struct device *dev, struct device_driver *drv)
@@ -236,6 +250,35 @@ struct of_device* of_platform_device_cre
 	return dev;
 }
 
+/**
+ * of_platform_device_scan - Find matching device tree nodes and
+ * call of_platform_device_create.
+ * @match: array of of device match structures to search in
+ *
+ * Used by a driver to add device nodes it supports to the platform bus.
+ * @match should be specified so as to exclude any devices that
+ * do not belong on the OF platform bus (e.g. PCI devices,
+ * devices that use the regular platform bus, etc).
+ */
+void of_platform_device_scan(const struct of_device_id *match)
+{
+	char bus_id[BUS_ID_SIZE];
+	struct device_node *np = NULL;
+
+	while ((np = of_find_all_nodes(np))) {
+		struct resource res;
+
+		if (!of_match_device_by_node(match, np))
+			continue;
+
+		if (of_address_to_resource(np, 0, &res))
+			continue;
+
+		snprintf(bus_id, BUS_ID_SIZE, "%x", res.start);
+		of_platform_device_create(np, bus_id, NULL);
+	}
+}
+
 EXPORT_SYMBOL(of_match_device);
 EXPORT_SYMBOL(of_platform_bus_type);
 EXPORT_SYMBOL(of_register_driver);
@@ -246,3 +289,4 @@ EXPORT_SYMBOL(of_dev_get);
 EXPORT_SYMBOL(of_dev_put);
 EXPORT_SYMBOL(of_platform_device_create);
 EXPORT_SYMBOL(of_release_dev);
+EXPORT_SYMBOL(of_platform_device_scan);
diff --git a/include/asm-powerpc/of_device.h b/include/asm-powerpc/of_device.h
index c5c0b0b..9f84c41 100644
--- a/include/asm-powerpc/of_device.h
+++ b/include/asm-powerpc/of_device.h
@@ -61,6 +61,7 @@ extern struct of_device *of_platform_dev
 						   const char *bus_id,
 						   struct device *parent);
 extern void of_release_dev(struct device *dev);
+extern void of_platform_device_scan(const struct of_device_id *match);
 
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_OF_DEVICE_H */
-- 
1.4.2.1
