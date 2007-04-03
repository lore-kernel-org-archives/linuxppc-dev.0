Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 3D68DDE082
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Apr 2007 10:58:41 +1000 (EST)
Date: Tue, 3 Apr 2007 10:55:39 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH 3/6] [POWERPC] Rename device_is_compatible to
	of_device_is_compatible
Message-Id: <20070403105539.7222cf2a.sfr@canb.auug.org.au>
In-Reply-To: <20070403105401.1fcdee27.sfr@canb.auug.org.au>
References: <20070403105217.7b9fea08.sfr@canb.auug.org.au>
	<20070403105401.1fcdee27.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is more consistent and gets us closer to the Sparc code.

We add a device_is_compatible define for compatibility during the
change over.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/prom.c |   11 ++++++-----
 include/asm-powerpc/prom.h |    3 ++-
 2 files changed, 8 insertions(+), 6 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 6224728..d2840b6 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -1131,7 +1131,8 @@ EXPORT_SYMBOL(find_all_nodes);
 /** Checks if the given "compat" string matches one of the strings in
  * the device's "compatible" property
  */
-int device_is_compatible(const struct device_node *device, const char *compat)
+int of_device_is_compatible(const struct device_node *device,
+		const char *compat)
 {
 	const char* cp;
 	int cplen, l;
@@ -1149,7 +1150,7 @@ int device_is_compatible(const struct device_node *device, const char *compat)
 
 	return 0;
 }
-EXPORT_SYMBOL(device_is_compatible);
+EXPORT_SYMBOL(of_device_is_compatible);
 
 
 /**
@@ -1163,7 +1164,7 @@ int machine_is_compatible(const char *compat)
 
 	root = of_find_node_by_path("/");
 	if (root) {
-		rc = device_is_compatible(root, compat);
+		rc = of_device_is_compatible(root, compat);
 		of_node_put(root);
 	}
 	return rc;
@@ -1184,7 +1185,7 @@ struct device_node *find_compatible_devices(const char *type,
 		if (type != NULL
 		    && !(np->type != 0 && strcasecmp(np->type, type) == 0))
 			continue;
-		if (device_is_compatible(np, compat)) {
+		if (of_device_is_compatible(np, compat)) {
 			*prevp = np;
 			prevp = &np->next;
 		}
@@ -1300,7 +1301,7 @@ struct device_node *of_find_compatible_node(struct device_node *from,
 		if (type != NULL
 		    && !(np->type != 0 && strcasecmp(np->type, type) == 0))
 			continue;
-		if (device_is_compatible(np, compatible) && of_node_get(np))
+		if (of_device_is_compatible(np, compatible) && of_node_get(np))
 			break;
 	}
 	of_node_put(from);
diff --git a/include/asm-powerpc/prom.h b/include/asm-powerpc/prom.h
index 448c5ce..fcacc88 100644
--- a/include/asm-powerpc/prom.h
+++ b/include/asm-powerpc/prom.h
@@ -162,8 +162,9 @@ extern void of_detach_node(const struct device_node *);
 extern void finish_device_tree(void);
 extern void unflatten_device_tree(void);
 extern void early_init_devtree(void *);
-extern int device_is_compatible(const struct device_node *device,
+extern int of_device_is_compatible(const struct device_node *device,
 				const char *);
+#define device_is_compatible(d, c)	of_device_is_compatible((d), (c))
 extern int machine_is_compatible(const char *compat);
 extern const void *of_get_property(const struct device_node *node,
 				const char *name,
-- 
1.5.0.3
