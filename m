Return-Path: <grant.likely@secretlab.ca>
Received: from pd2mo1so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id 211DFDDEC7
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Feb 2008 03:17:46 +1100 (EST)
Received: from pd3mr4so.prod.shaw.ca
	(pd3mr4so-qfe3.prod.shaw.ca [10.0.141.180]) by l-daemon
	(Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
	with ESMTP id <0JVQ002DO2K4C8C0@l-daemon> for linuxppc-dev@ozlabs.org;
	Mon, 04 Feb 2008 09:16:52 -0700 (MST)
Received: from pn2ml4so.prod.shaw.ca ([10.0.121.148])
	by pd3mr4so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JVQ00I832K3S9D0@pd3mr4so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Mon, 04 Feb 2008 09:16:52 -0700 (MST)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JVQ00DCD2K2OZ30@l-daemon> for linuxppc-dev@ozlabs.org;
	Mon, 04 Feb 2008 09:16:51 -0700 (MST)
Date: Mon, 04 Feb 2008 09:16:08 -0700
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH] [POWERPC] of: add alias helper functions.
To: linuxppc-dev@ozlabs.org, sfr@canb.auug.org.au, david@gibson.dropbear.id.au,
	davem@davemloft.net
Message-id: <20080204161604.10674.9289.stgit@trillian.secretlab.ca>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

Add helper functions for translating back and forth between alias
properties and device tree nodes.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 drivers/of/base.c  |   80 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/of.h |    2 +
 2 files changed, 82 insertions(+), 0 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index b306fef..54a7f2e 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -331,3 +331,83 @@ struct device_node *of_find_matching_node(struct device_node *from,
 	return np;
 }
 EXPORT_SYMBOL(of_find_matching_node);
+
+/**
+ *	of_find_node_by_alias - Find a node from an alias name
+ *	@alias:		Alias to decode
+ *
+ *	Returns a node pointer with refcount incremented.  Use of_node_put
+ *	on it when done.
+ */
+struct device_node *of_find_node_by_alias(const char *alias)
+{
+	struct device_node *np, *alias_np;
+	const char *path;
+
+	np = NULL;
+
+	/* First decode the alias into a path */
+	alias_np = of_find_node_by_path("/aliases");
+	if (!alias_np)
+		return NULL;
+
+	path = of_get_property(alias_np, alias, NULL);
+	if (!path)
+		goto exit;
+
+	/* Next find the node pointed to by the alias */
+	np = of_find_node_by_path(path);
+
+ exit:
+	of_node_put(alias_np);
+	return np;
+}
+
+/**
+ * of_node_alias - Return the alias for a node
+ * @np		Pointer to device node
+ * @prefix	Prefix string; if provided then this function will only
+ * 		match on properties which have the given prefix.
+ *
+ * returns the alias property name for the given node without the prefix
+ */
+const char *of_node_alias(struct device_node *np, const char *prefix)
+{
+	struct device_node *alias_np, *test_np;
+	struct property *pp;
+	int prefix_len;
+	const char *alias;
+
+	prefix_len = 0;
+	if (prefix)
+		prefix_len = strlen(prefix);
+
+	/* First decode the alias into a path */
+	alias_np = of_find_node_by_path("/aliases");
+	if (!alias_np)
+		return NULL;
+
+	/* Loop over the aliases looking for a match */
+	alias = NULL;
+	for (pp = alias_np->properties; pp != 0; pp = pp->next) {
+		/* Skip properties which don't begin with the prefix */
+		if (prefix && (strncmp(pp->name, prefix, prefix_len) != 0))
+			continue;
+
+		/* Skip properties which aren't a NULL terminated string */
+		if (memchr(pp->value, 0, pp->length) == NULL)
+			continue;
+
+		/* Find out what node the property points to and see if it
+		 * matches.  If so then we've found our alias */
+		test_np = of_find_node_by_path(pp->value);
+		if (test_np == np)
+			alias = pp->name + prefix_len;
+		of_node_put(test_np);
+		if (alias)
+			break;
+	}
+
+	of_node_put(alias_np);
+	return alias;
+}
diff --git a/include/linux/of.h b/include/linux/of.h
index b5f33ef..aae1570 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -68,5 +68,7 @@ extern int of_n_addr_cells(struct device_node *np);
 extern int of_n_size_cells(struct device_node *np);
 extern const struct of_device_id *of_match_node(
 	const struct of_device_id *matches, const struct device_node *node);
+extern struct device_node *of_find_node_by_alias(const char *alias);
+extern const char *of_node_alias(struct device_node *np, const char *prefix);
 
 #endif /* _LINUX_OF_H */
