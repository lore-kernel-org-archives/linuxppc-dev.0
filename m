Return-Path: <srinivas.kandagatla@st.com>
Received: from eu1sys200aog115.obsmtp.com (eu1sys200aog115.obsmtp.com
 [207.126.144.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id D7B952C0086
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Sep 2012 18:50:36 +1000 (EST)
From: Srinivas KANDAGATLA <srinivas.kandagatla@st.com>
To: davem@davemloft.net, robherring2@gmail.com, bergner@us.ibm.com,
 devicetree-discuss@lists.ozlabs.org
Subject: [PATCH v2 1/7] dt: introduce of_get_child_by_name to get child node
 by name.
Date: Fri, 14 Sep 2012 09:17:42 +0100
Message-Id: <1347610662-20105-1-git-send-email-srinivas.kandagatla@st.com>
Cc: jassi.brar@samsung.com, srinivas.kandagatla@st.com, afleming@freescale.com,
 netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Srinivas Kandagatla <srinivas.kandagatla@st.com>

This patch introduces of_get_child_by_name function to get a child node
by its name in a given parent node.

Without this patch each driver code has to iterate the parent and do
a string compare, However having of_get_child_by_name libary function would
avoid code duplication, errors and is more convenient.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@st.com>
---
 drivers/of/base.c  |   25 +++++++++++++++++++++++++
 include/linux/of.h |    2 ++
 2 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index d4a1c9a..7391f8a 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -391,6 +391,31 @@ struct device_node *of_get_next_available_child(const struct device_node *node,
 EXPORT_SYMBOL(of_get_next_available_child);
 
 /**
+ *	of_get_child_by_name - Find the child node by name for a given parent
+ *	@node:	parent node
+ *	@name:	child name to look for.
+ *
+ *      This function looks for child node for given matching name
+ *
+ *	Returns a node pointer if found, with refcount incremented, use
+ *	of_node_put() on it when done.
+ *	Returns NULL if node is not found.
+ */
+
+struct device_node *of_get_child_by_name(const struct device_node *node,
+				const char *name)
+{
+	struct device_node *child;
+
+	for_each_child_of_node(node, child)
+		if (child->name && (of_node_cmp(child->name, name) == 0)
+			&& of_node_get(child))
+			break;
+	return child;
+}
+EXPORT_SYMBOL(of_get_child_by_name);
+
+/**
  *	of_find_node_by_path - Find a node matching a full OF path
  *	@path:	The full path to match
  *
diff --git a/include/linux/of.h b/include/linux/of.h
index 1b11632..7b8e3cd 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -192,6 +192,8 @@ extern struct device_node *of_get_next_child(const struct device_node *node,
 					     struct device_node *prev);
 extern struct device_node *of_get_next_available_child(
 	const struct device_node *node, struct device_node *prev);
+extern struct device_node *of_get_child_by_name(const struct device_node *node,
+					const char *name);
 
 #define for_each_child_of_node(parent, child) \
 	for (child = of_get_next_child(parent, NULL); child != NULL; \
-- 
1.7.0.4
