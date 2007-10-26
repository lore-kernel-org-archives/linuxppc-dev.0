Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <80449d4682309dbf8cf80816be4f381fe875f3d1.1193381582.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 01/16] Add of_get_next_parent()
Date: Fri, 26 Oct 2007 16:54:31 +1000 (EST)
Cc: davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Iterating through a device node's parents is simple enough, but dealing
with the refcounts properly is a little ugly, and replicating that logic
is asking for someone to get it wrong or forget it all together, eg:

while (dn != NULL) {
	/* loop body */
	tmp = of_get_parent(dn);
	of_node_put(dn);
	dn = tmp;
}

So add of_get_next_parent(), inspired by of_get_next_child(). The contract
is that it returns the parent and drops the reference on the current node,
this makes the loop look like:

while (dn != NULL) {
	/* loop body */
	dn = of_get_next_parent(dn);
}

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 drivers/of/base.c  |   25 +++++++++++++++++++++++++
 include/linux/of.h |    1 +
 2 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 9377f3b..e0db2b5 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -138,6 +138,31 @@ struct device_node *of_get_parent(const struct device_node *node)
 EXPORT_SYMBOL(of_get_parent);
 
 /**
+ *	of_get_next_parent - Iterate to a node's parent
+ *	@node:	Node to get parent of
+ *
+ * 	This is like of_get_parent() except that it drops the
+ * 	refcount on the passed node, making it suitable for iterating
+ * 	through a node's parents.
+ *
+ *	Returns a node pointer with refcount incremented, use
+ *	of_node_put() on it when done.
+ */
+struct device_node *of_get_next_parent(struct device_node *node)
+{
+	struct device_node *parent;
+
+	if (!node)
+		return NULL;
+
+	read_lock(&devtree_lock);
+	parent = of_node_get(node->parent);
+	of_node_put(node);
+	read_unlock(&devtree_lock);
+	return parent;
+}
+
+/**
  *	of_get_next_child - Iterate a node childs
  *	@node:	parent node
  *	@prev:	previous child of the parent node, or NULL to get first
diff --git a/include/linux/of.h b/include/linux/of.h
index 5c39b92..3557d1e 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -44,6 +44,7 @@ extern struct device_node *of_find_compatible_node(struct device_node *from,
 extern struct device_node *of_find_node_by_path(const char *path);
 extern struct device_node *of_find_node_by_phandle(phandle handle);
 extern struct device_node *of_get_parent(const struct device_node *node);
+extern struct device_node *of_get_next_parent(struct device_node *node);
 extern struct device_node *of_get_next_child(const struct device_node *node,
 					     struct device_node *prev);
 extern struct property *of_find_property(const struct device_node *np,
-- 
1.5.2.rc1.1884.g59b20
