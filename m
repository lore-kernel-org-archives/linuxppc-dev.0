Return-Path: <timur@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6AE8CDDFA4
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jun 2008 06:05:48 +1000 (EST)
From: Timur Tabi <timur@freescale.com>
To: galak@kernel.crashing.org, linuxppc-dev@ozlabs.org, sr@denx.de
Subject: [PATCH] powerpc: add of_find_next_property and of_get_aliased_index
Date: Wed, 25 Jun 2008 15:05:32 -0500
Message-Id: <1214424332-18496-1-git-send-email-timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add two functions: of_find_next_property() returns the next in a list of
properties for a given node.  It's handy when you want a list of properties
for a given node, but you don't know what the properties are called.
of_get_aliased_node() looks up the aliases in the "/aliases" node and returns
the index of the property that points to a given node.  That is, if you have
an alias "serial2" that points to a serial port node, of_get_aliased_index()
returns "2".

Signed-off-by: Timur Tabi <timur@freescale.com>
---

This patch is for 2.6.27.  It applies on top of Kumar's powerpc-next branch.

 arch/powerpc/kernel/prom_parse.c |   40 ++++++++++++++++++++++++++++++++++++++
 drivers/of/base.c                |   26 ++++++++++++++++++++++++
 include/asm-powerpc/prom.h       |   17 ++++++++++++++++
 include/linux/of.h               |    3 ++
 4 files changed, 86 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/prom_parse.c b/arch/powerpc/kernel/prom_parse.c
index 90eb3a3..a09635e 100644
--- a/arch/powerpc/kernel/prom_parse.c
+++ b/arch/powerpc/kernel/prom_parse.c
@@ -6,6 +6,7 @@
 #include <linux/module.h>
 #include <linux/ioport.h>
 #include <linux/etherdevice.h>
+#include <linux/ctype.h>
 #include <asm/prom.h>
 #include <asm/pci-bridge.h>
 
@@ -1079,3 +1080,42 @@ void __iomem *of_iomap(struct device_node *np, int index)
 	return ioremap(res.start, 1 + res.end - res.start);
 }
 EXPORT_SYMBOL(of_iomap);
+
+int of_get_aliased_index(struct device_node *np)
+{
+	struct device_node *aliases = of_find_node_by_path("/aliases");
+	struct property *pp = NULL;
+	int index = -ENODEV;
+
+	if (!np || !aliases)
+		return -ENODEV;
+
+	while ((pp = of_find_next_property(aliases, pp)) != NULL) {
+		if (of_find_node_by_path(pp->value) == np) {
+			const char *p = pp->name;
+			unsigned long result;
+
+			while (isalpha(*p))
+				p++;
+
+			if (!*p) {
+				index = 0;
+				break;
+			}
+
+			if (strict_strtoul(p, 10, &result)) {
+				index = -EINVAL;
+				break;
+			}
+
+			index = (int) result;
+			break;
+		}
+	}
+
+	of_node_put(aliases);
+
+	return index;
+}
+EXPORT_SYMBOL(of_get_aliased_index);
+
diff --git a/drivers/of/base.c b/drivers/of/base.c
index 23ffb7c..5a644d9 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -385,3 +385,29 @@ struct device_node *of_find_matching_node(struct device_node *from,
 	return np;
 }
 EXPORT_SYMBOL(of_find_matching_node);
+
+/**
+ * Return the first or next property within a node.
+ * @np: the node
+ * @prev: if NULL, return 1st prop, otherwise return the prop after 'prev'
+ *
+ * This function is used to get a list of properties within a node.  It's
+ * also useful for when you don't know the name of the propety you want to
+ * find.
+ */
+struct property *of_find_next_property(const struct device_node *np,
+	struct property *prev)
+{
+	struct property *next;
+
+	if (!np)
+		return NULL;
+
+	read_lock(&devtree_lock);
+	next = prev ? prev->next : np->properties;
+	read_unlock(&devtree_lock);
+
+	return next;
+}
+EXPORT_SYMBOL(of_find_next_property);
+
diff --git a/include/asm-powerpc/prom.h b/include/asm-powerpc/prom.h
index 78b7b0d..dddf814 100644
--- a/include/asm-powerpc/prom.h
+++ b/include/asm-powerpc/prom.h
@@ -330,6 +330,23 @@ extern int of_irq_to_resource(struct device_node *dev, int index,
  */
 extern void __iomem *of_iomap(struct device_node *device, int index);
 
+/**
+ * Return the index of the alias for the given node
+ * @np: the device node for which an index is sought
+ *
+ * This function scans that /aliases node for an alias that points to the
+ * given node.  It then parses the property to obtain the index (the number
+ * at the end of the property name).
+ *
+ * This allows device drivers to use the /aliases node to enumerate their
+ * devices, without needing a new property like "cell-index" or "device-id".
+ *
+ * We assume the alias property is of the format "xxxn", where "xxx" is a
+ * string of only alpha characters, and "n" is a number greater than or
+ * equal to 0. If "n" doesn't exist, we assume that the index is zero.
+ */
+int of_get_aliased_index(struct device_node *np);
+
 /*
  * NB:  This is here while we transition from using asm/prom.h
  * to linux/of.h
diff --git a/include/linux/of.h b/include/linux/of.h
index 59a61bd..98e90d4 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -71,4 +71,7 @@ extern int of_n_size_cells(struct device_node *np);
 extern const struct of_device_id *of_match_node(
 	const struct of_device_id *matches, const struct device_node *node);
 
+struct property *of_find_next_property(const struct device_node *np,
+	struct property *prev);
+
 #endif /* _LINUX_OF_H */
-- 
1.5.5
