Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <4509235daf44688f6e30675d2d480e7f786c8c60.1182233192.git.michael@ellerman.id.au>
In-Reply-To: <9ac0032bf8356ff6e41b0860b6f67dddf9bda2f5.1182233192.git.michael@ellerman.id.au>
References: <9ac0032bf8356ff6e41b0860b6f67dddf9bda2f5.1182233192.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 2/3] Generalise device_node flag interface
Date: Tue, 19 Jun 2007 16:07:58 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The struct device_node currently has a _flags variable, although
it's only used for one flag - OF_DYNAMIC. Generalise the flag
accessors so we can use them with other flags in future.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/kernel/prom.c                |    2 +-
 arch/powerpc/platforms/pseries/reconfig.c |    2 +-
 include/asm-powerpc/prom.h                |   14 +++++++++++---
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 6ea94cf..4f70764 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -1375,7 +1375,7 @@ static void of_node_release(struct kref *kref)
 	struct device_node *node = kref_to_device_node(kref);
 	struct property *prop = node->properties;
 
-	if (!OF_IS_DYNAMIC(node))
+	if (!of_node_check_flag(node, OF_DYNAMIC))
 		return;
 	while (prop) {
 		struct property *next = prop->next;
diff --git a/arch/powerpc/platforms/pseries/reconfig.c b/arch/powerpc/platforms/pseries/reconfig.c
index 5aa97af..c02f874 100644
--- a/arch/powerpc/platforms/pseries/reconfig.c
+++ b/arch/powerpc/platforms/pseries/reconfig.c
@@ -123,7 +123,7 @@ static int pSeries_reconfig_add_node(const char *path, struct property *proplist
 	strcpy(np->full_name, path);
 
 	np->properties = proplist;
-	OF_MARK_DYNAMIC(np);
+	of_node_set_flag(np, OF_DYNAMIC);
 	kref_init(&np->kref);
 
 	np->parent = derive_parent(path);
diff --git a/include/asm-powerpc/prom.h b/include/asm-powerpc/prom.h
index 6845af9..6eb98aa 100644
--- a/include/asm-powerpc/prom.h
+++ b/include/asm-powerpc/prom.h
@@ -98,10 +98,18 @@ struct device_node {
 extern struct device_node *of_chosen;
 
 /* flag descriptions */
-#define OF_DYNAMIC 1 /* node and properties were allocated via kmalloc */
+#define OF_DYNAMIC	1 /* node and properties were allocated via kmalloc */
+
+static inline int of_node_check_flag(struct device_node *n, unsigned long flag)
+{
+	return test_bit(flag, &n->_flags);
+}
+
+static inline void of_node_set_flag(struct device_node *n, unsigned long flag)
+{
+	set_bit(flag, &n->_flags);
+}
 
-#define OF_IS_DYNAMIC(x) test_bit(OF_DYNAMIC, &x->_flags)
-#define OF_MARK_DYNAMIC(x) set_bit(OF_DYNAMIC, &x->_flags)
 
 #define HAVE_ARCH_DEVTREE_FIXUPS
 
-- 
1.5.1.3.g7a33b
