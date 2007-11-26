Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <e68326d47ae49fee03c635514d5a86a566b13ff9.1196064155.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH] Add for_each_child_of_node() helper for iterating over child
	nodes
Date: Mon, 26 Nov 2007 19:03:45 +1100 (EST)
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	"David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add for_each_child_of_node() to encapsulate the common idiom of
iterating over the children of a device_node.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

After conducting a straw pole of powerpc hackers, this seems to be the
preferred name for such a beast.


 include/linux/of.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/include/linux/of.h b/include/linux/of.h
index 5c39b92..c65af7b 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -46,6 +46,10 @@ extern struct device_node *of_find_node_by_phandle(phandle handle);
 extern struct device_node *of_get_parent(const struct device_node *node);
 extern struct device_node *of_get_next_child(const struct device_node *node,
 					     struct device_node *prev);
+#define for_each_child_of_node(parent, child) \
+	for (child = of_get_next_child(parent, NULL); child != NULL; \
+	     child = of_get_next_child(parent, child))
+
 extern struct property *of_find_property(const struct device_node *np,
 					 const char *name,
 					 int *lenp);
-- 
1.5.2.rc1.1884.g59b20
