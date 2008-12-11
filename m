Return-Path: <ntl@pobox.com>
Received: from sasl.smtp.pobox.com (a-sasl-fastnet.sasl.smtp.pobox.com
	[207.106.133.19]) by ozlabs.org (Postfix) with ESMTP id C1FFCDDFFC
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Dec 2008 11:46:10 +1100 (EST)
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id
	5487F85710
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Dec 2008 19:46:07 -0500 (EST)
Received: from thinkcentre (unknown [67.9.156.46]) by
	a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPA id F11CE8570F
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Dec 2008 19:46:06 -0500 (EST)
From: Nathan Lynch <ntl@pobox.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/3] add of_find_next_cache_node()
Date: Wed, 10 Dec 2008 18:46:04 -0600
Message-Id: <1228956366-17593-1-git-send-email-ntl@pobox.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We have more than one piece of code that looks up cache nodes manually
using the "l2-cache" property.  Add a common helper routine which does
this and handles ePAPR's "next-level-cache" property as well as
powermac.

Signed-off-by: Nathan Lynch <ntl@pobox.com>
---
 arch/powerpc/include/asm/prom.h |    3 +++
 arch/powerpc/kernel/prom.c      |   31 +++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/prom.h b/arch/powerpc/include/asm/prom.h
index eb3bd2e..6ff0418 100644
--- a/arch/powerpc/include/asm/prom.h
+++ b/arch/powerpc/include/asm/prom.h
@@ -253,6 +253,9 @@ extern void kdump_move_device_tree(void);
 /* CPU OF node matching */
 struct device_node *of_get_cpu_node(int cpu, unsigned int *thread);
 
+/* cache lookup */
+struct device_node *of_find_next_cache_node(struct device_node *np);
+
 /* Get the MAC address */
 extern const void *of_get_mac_address(struct device_node *np);
 
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 3a2dc7e..d8266dd 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -1271,6 +1271,37 @@ struct device_node *of_find_node_by_phandle(phandle handle)
 EXPORT_SYMBOL(of_find_node_by_phandle);
 
 /**
+ *	of_find_next_cache_node - Find a node's subsidiary cache
+ *	@np:	node of type "cpu" or "cache"
+ *
+ *	Returns a node pointer with refcount incremented, use
+ *	of_node_put() on it when done.  Caller should hold a reference
+ *	to np.
+ */
+struct device_node *of_find_next_cache_node(struct device_node *np)
+{
+	struct device_node *child;
+	const phandle *handle;
+
+	handle = of_get_property(np, "l2-cache", NULL);
+	if (!handle)
+		handle = of_get_property(np, "next-level-cache", NULL);
+
+	if (handle)
+		return of_find_node_by_phandle(*handle);
+
+	/* OF on pmac has nodes instead of properties named "l2-cache"
+	 * beneath CPU nodes.
+	 */
+	if (!strcmp(np->type, "cpu"))
+		for_each_child_of_node(np, child)
+			if (!strcmp(child->type, "cache"))
+				return child;
+
+	return NULL;
+}
+
+/**
  *	of_find_all_nodes - Get next node in global list
  *	@prev:	Previous node or NULL to start iteration
  *		of_node_put() will be called on it
-- 
1.5.5
