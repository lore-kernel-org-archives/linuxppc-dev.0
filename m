Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 87FBDDDF82
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Apr 2007 22:43:43 +1000 (EST)
Date: Tue, 24 Apr 2007 22:42:29 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "David S. Miller" <davem@davemloft.net>, paulus@samba.org
Subject: [PATCH 5/6] Consolidate of_get_next_child
Message-Id: <20070424224229.1e02b466.sfr@canb.auug.org.au>
In-Reply-To: <20070424223245.78f4fdfb.sfr@canb.auug.org.au>
References: <20070403105217.7b9fea08.sfr@canb.auug.org.au>
	<20070403223000.5d44b2f1.sfr@canb.auug.org.au>
	<20070403223136.6ecdabbd.sfr@canb.auug.org.au>
	<20070403223257.cb8c4d15.sfr@canb.auug.org.au>
	<20070403223535.dd6731d6.sfr@canb.auug.org.au>
	<20070403223738.03386a13.sfr@canb.auug.org.au>
	<20070403223914.35bf04e1.sfr@canb.auug.org.au>
	<20070403224039.913af749.sfr@canb.auug.org.au>
	<20070403224205.807cffe0.sfr@canb.auug.org.au>
	<20070403224340.5533abc9.sfr@canb.auug.org.au>
	<20070403224505.5d5a1495.sfr@canb.auug.org.au>
	<20070403224610.b61c7377.sfr@canb.auug.org.au>
	<20070403224937.f6a07e56.sfr@canb.auug.org.au>
	<20070403225059.e735b5e4.sfr@canb.auug.org.au>
	<20070403225222.88e92221.sfr@canb.auug.org.au>
	<20070403230505.f96ea210.sfr@canb.auug.org.au>
	<20070403232406.ab9a3c86.sfr@canb.auug.org.au>
	<20070412141905.6f30efd3.sfr@canb.auug.org.au>
	<20070412153424.bf3957f4.sfr@canb.auug.org.au>
	<20070424223245.78f4fdfb.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This adds a readlock around the child/next accesses on Sparc.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/prom.c |   24 ------------------------
 arch/sparc/kernel/prom.c   |   14 --------------
 arch/sparc64/kernel/prom.c |   14 --------------
 drivers/openfw/base.c      |   24 ++++++++++++++++++++++++
 4 files changed, 24 insertions(+), 52 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 55e67ca..90901e4 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -1225,30 +1225,6 @@ struct device_node *of_find_all_nodes(struct device_node *prev)
 EXPORT_SYMBOL(of_find_all_nodes);
 
 /**
- *	of_get_next_child - Iterate a node childs
- *	@node:	parent node
- *	@prev:	previous child of the parent node, or NULL to get first
- *
- *	Returns a node pointer with refcount incremented, use
- *	of_node_put() on it when done.
- */
-struct device_node *of_get_next_child(const struct device_node *node,
-	struct device_node *prev)
-{
-	struct device_node *next;
-
-	read_lock(&devtree_lock);
-	next = prev ? prev->sibling : node->child;
-	for (; next != 0; next = next->sibling)
-		if (of_node_get(next))
-			break;
-	of_node_put(prev);
-	read_unlock(&devtree_lock);
-	return next;
-}
-EXPORT_SYMBOL(of_get_next_child);
-
-/**
  *	of_node_get - Increment refcount of a node
  *	@node:	Node to inc refcount, NULL is supported to
  *		simplify writing of callers
diff --git a/arch/sparc/kernel/prom.c b/arch/sparc/kernel/prom.c
index b378715..3f8ccfa 100644
--- a/arch/sparc/kernel/prom.c
+++ b/arch/sparc/kernel/prom.c
@@ -29,20 +29,6 @@ static struct device_node *allnodes;
 
 extern rwlock_t devtree_lock;	/* temporary while merging */
 
-struct device_node *of_get_next_child(const struct device_node *node,
-	struct device_node *prev)
-{
-	struct device_node *next;
-
-	next = prev ? prev->sibling : node->child;
-	for (; next != 0; next = next->sibling) {
-		break;
-	}
-
-	return next;
-}
-EXPORT_SYMBOL(of_get_next_child);
-
 struct device_node *of_find_node_by_path(const char *path)
 {
 	struct device_node *np = allnodes;
diff --git a/arch/sparc64/kernel/prom.c b/arch/sparc64/kernel/prom.c
index f876079..be3b958 100644
--- a/arch/sparc64/kernel/prom.c
+++ b/arch/sparc64/kernel/prom.c
@@ -33,20 +33,6 @@ static struct device_node *allnodes;
 
 extern rwlock_t devtree_lock;	/* temporary while merging */
 
-struct device_node *of_get_next_child(const struct device_node *node,
-	struct device_node *prev)
-{
-	struct device_node *next;
-
-	next = prev ? prev->sibling : node->child;
-	for (; next != 0; next = next->sibling) {
-		break;
-	}
-
-	return next;
-}
-EXPORT_SYMBOL(of_get_next_child);
-
 struct device_node *of_find_node_by_path(const char *path)
 {
 	struct device_node *np = allnodes;
diff --git a/drivers/openfw/base.c b/drivers/openfw/base.c
index 3fc02de..60f7bd4 100644
--- a/drivers/openfw/base.c
+++ b/drivers/openfw/base.c
@@ -134,3 +134,27 @@ struct device_node *of_get_parent(const struct device_node *node)
 	return np;
 }
 EXPORT_SYMBOL(of_get_parent);
+
+/**
+ *	of_get_next_child - Iterate a node childs
+ *	@node:	parent node
+ *	@prev:	previous child of the parent node, or NULL to get first
+ *
+ *	Returns a node pointer with refcount incremented, use
+ *	of_node_put() on it when done.
+ */
+struct device_node *of_get_next_child(const struct device_node *node,
+	struct device_node *prev)
+{
+	struct device_node *next;
+
+	read_lock(&devtree_lock);
+	next = prev ? prev->sibling : node->child;
+	for (; next; next = next->sibling)
+		if (of_node_get(next))
+			break;
+	of_node_put(prev);
+	read_unlock(&devtree_lock);
+	return next;
+}
+EXPORT_SYMBOL(of_get_next_child);
-- 
1.5.1.2
