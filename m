Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <5776905a997a4d7e95af1011349dd52383fd3402.1226552026.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH] Add helpers for finding a device node which as a certain
	property
Date: Thu, 13 Nov 2008 15:54:42 +1100 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This commit adds a routine for finding a device node which has a certain
property, the contents of the property are not taken into account,
merely the presence or absence of the property.

Based on that routine, we add a for_each_ macro for iterating over all
nodes that have a certain property.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

Pass the brown paper bag ... actually take a reference when we find the
matching node.


 drivers/of/base.c  |   35 +++++++++++++++++++++++++++++++++++
 include/linux/of.h |    6 ++++++
 2 files changed, 41 insertions(+), 0 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 7c79e94..4f884a3 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -329,6 +329,41 @@ struct device_node *of_find_compatible_node(struct device_node *from,
 EXPORT_SYMBOL(of_find_compatible_node);
 
 /**
+ *	of_find_node_with_property - Find a node which has a property with
+ *                                   the given name.
+ *	@from:		The node to start searching from or NULL, the node
+ *			you pass will not be searched, only the next one
+ *			will; typically, you pass what the previous call
+ *			returned. of_node_put() will be called on it
+ *	@prop_name:	The name of the property to look for.
+ *
+ *	Returns a node pointer with refcount incremented, use
+ *	of_node_put() on it when done.
+ */
+struct device_node *of_find_node_with_property(struct device_node *from,
+	const char *prop_name)
+{
+	struct device_node *np;
+	struct property *pp;
+
+	read_lock(&devtree_lock);
+	np = from ? from->allnext : allnodes;
+	for (; np; np = np->allnext) {
+		for (pp = np->properties; pp != 0; pp = pp->next) {
+			if (of_prop_cmp(pp->name, prop_name) == 0) {
+				of_node_get(np);
+				goto out;
+			}
+		}
+	}
+out:
+	of_node_put(from);
+	read_unlock(&devtree_lock);
+	return np;
+}
+EXPORT_SYMBOL(of_find_node_with_property);
+
+/**
  * of_match_node - Tell if an device_node has a matching of_match structure
  *	@matches:	array of of device match structures to search in
  *	@node:		the of device structure to match against
diff --git a/include/linux/of.h b/include/linux/of.h
index e2488f5..6a7efa2 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -57,6 +57,12 @@ extern struct device_node *of_get_next_child(const struct device_node *node,
 	for (child = of_get_next_child(parent, NULL); child != NULL; \
 	     child = of_get_next_child(parent, child))
 
+extern struct device_node *of_find_node_with_property(
+	struct device_node *from, const char *prop_name);
+#define for_each_node_with_property(dn, prop_name) \
+	for (dn = of_find_node_with_property(NULL, prop_name); dn; \
+	     dn = of_find_node_with_property(dn, prop_name))
+
 extern struct property *of_find_property(const struct device_node *np,
 					 const char *name,
 					 int *lenp);
-- 
1.5.5
