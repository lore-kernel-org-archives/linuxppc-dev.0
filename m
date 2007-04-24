Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id C60A6DDF69
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Apr 2007 22:43:42 +1000 (EST)
Date: Tue, 24 Apr 2007 22:40:40 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "David S. Miller" <davem@davemloft.net>, paulus@samba.org
Subject: [PATCH 4/6] Consolidate of_get_parent
Message-Id: <20070424224040.6f0fe143.sfr@canb.auug.org.au>
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

This requires creating dummy of_node_{get,put} routines for sparc and
sparc64.  It also adds a readlocal around the parent accesses.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/prom.c |   21 ---------------------
 arch/sparc/kernel/prom.c   |   13 -------------
 arch/sparc64/kernel/prom.c |   13 -------------
 drivers/openfw/base.c      |   21 +++++++++++++++++++++
 include/asm-sparc/prom.h   |    9 +++++++++
 include/asm-sparc64/prom.h |    9 +++++++++
 6 files changed, 39 insertions(+), 47 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 939d5e4..55e67ca 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -1225,27 +1225,6 @@ struct device_node *of_find_all_nodes(struct device_node *prev)
 EXPORT_SYMBOL(of_find_all_nodes);
 
 /**
- *	of_get_parent - Get a node's parent if any
- *	@node:	Node to get parent
- *
- *	Returns a node pointer with refcount incremented, use
- *	of_node_put() on it when done.
- */
-struct device_node *of_get_parent(const struct device_node *node)
-{
-	struct device_node *np;
-
-	if (!node)
-		return NULL;
-
-	read_lock(&devtree_lock);
-	np = of_node_get(node->parent);
-	read_unlock(&devtree_lock);
-	return np;
-}
-EXPORT_SYMBOL(of_get_parent);
-
-/**
  *	of_get_next_child - Iterate a node childs
  *	@node:	parent node
  *	@prev:	previous child of the parent node, or NULL to get first
diff --git a/arch/sparc/kernel/prom.c b/arch/sparc/kernel/prom.c
index 0f5aab4..b378715 100644
--- a/arch/sparc/kernel/prom.c
+++ b/arch/sparc/kernel/prom.c
@@ -29,19 +29,6 @@ static struct device_node *allnodes;
 
 extern rwlock_t devtree_lock;	/* temporary while merging */
 
-struct device_node *of_get_parent(const struct device_node *node)
-{
-	struct device_node *np;
-
-	if (!node)
-		return NULL;
-
-	np = node->parent;
-
-	return np;
-}
-EXPORT_SYMBOL(of_get_parent);
-
 struct device_node *of_get_next_child(const struct device_node *node,
 	struct device_node *prev)
 {
diff --git a/arch/sparc64/kernel/prom.c b/arch/sparc64/kernel/prom.c
index c759660..f876079 100644
--- a/arch/sparc64/kernel/prom.c
+++ b/arch/sparc64/kernel/prom.c
@@ -33,19 +33,6 @@ static struct device_node *allnodes;
 
 extern rwlock_t devtree_lock;	/* temporary while merging */
 
-struct device_node *of_get_parent(const struct device_node *node)
-{
-	struct device_node *np;
-
-	if (!node)
-		return NULL;
-
-	np = node->parent;
-
-	return np;
-}
-EXPORT_SYMBOL(of_get_parent);
-
 struct device_node *of_get_next_child(const struct device_node *node,
 	struct device_node *prev)
 {
diff --git a/drivers/openfw/base.c b/drivers/openfw/base.c
index 2597d29..3fc02de 100644
--- a/drivers/openfw/base.c
+++ b/drivers/openfw/base.c
@@ -113,3 +113,24 @@ int of_device_is_compatible(const struct device_node *device,
 	return 0;
 }
 EXPORT_SYMBOL(of_device_is_compatible);
+
+/**
+ *	of_get_parent - Get a node's parent if any
+ *	@node:	Node to get parent
+ *
+ *	Returns a node pointer with refcount incremented, use
+ *	of_node_put() on it when done.
+ */
+struct device_node *of_get_parent(const struct device_node *node)
+{
+	struct device_node *np;
+
+	if (!node)
+		return NULL;
+
+	read_lock(&devtree_lock);
+	np = of_node_get(node->parent);
+	read_unlock(&devtree_lock);
+	return np;
+}
+EXPORT_SYMBOL(of_get_parent);
diff --git a/include/asm-sparc/prom.h b/include/asm-sparc/prom.h
index d3dc05b..4621af6 100644
--- a/include/asm-sparc/prom.h
+++ b/include/asm-sparc/prom.h
@@ -66,6 +66,15 @@ extern int of_getintprop_default(struct device_node *np,
 
 extern void prom_build_devicetree(void);
 
+/* Dummy ref counting routines - to be implemented later */
+static inline struct device_node *of_node_get(struct device_node *node)
+{
+	return node;
+}
+static inline void of_node_put(struct device_node *node)
+{
+}
+
 /*
  * NB:  This is here while we transition from using asm/prom.h
  * to linux/openfw.h
diff --git a/include/asm-sparc64/prom.h b/include/asm-sparc64/prom.h
index a1b64e7..c36b884 100644
--- a/include/asm-sparc64/prom.h
+++ b/include/asm-sparc64/prom.h
@@ -74,6 +74,15 @@ extern int of_getintprop_default(struct device_node *np,
 
 extern void prom_build_devicetree(void);
 
+/* Dummy ref counting routines - to be implemented later */
+static inline struct device_node *of_node_get(struct device_node *node)
+{
+	return node;
+}
+static inline void of_node_put(struct device_node *node)
+{
+}
+
 /*
  * NB:  This is here while we transition from using asm/prom.h
  * to linux/openfw.h
-- 
1.5.1.2
