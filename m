Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 8B793DE032
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Apr 2007 10:58:40 +1000 (EST)
Date: Tue, 3 Apr 2007 10:54:01 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH 2/6] [POWERPC] Rename get_property to of_get_property
Message-Id: <20070403105401.1fcdee27.sfr@canb.auug.org.au>
In-Reply-To: <20070403105217.7b9fea08.sfr@canb.auug.org.au>
References: <20070403105217.7b9fea08.sfr@canb.auug.org.au>
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

We add a get_property define for compatibility during the change over.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/prom.c |   24 ++++++++++++------------
 include/asm-powerpc/prom.h |    3 ++-
 include/asm-ppc/prom.h     |    3 ++-
 3 files changed, 16 insertions(+), 14 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index ef6bfb7..6224728 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -400,8 +400,8 @@ static unsigned long __init unflatten_dt_node(unsigned long mem,
 	}
 	if (allnextpp) {
 		*prev_pp = NULL;
-		np->name = get_property(np, "name", NULL);
-		np->type = get_property(np, "device_type", NULL);
+		np->name = of_get_property(np, "name", NULL);
+		np->type = of_get_property(np, "device_type", NULL);
 
 		if (!np->name)
 			np->name = "<NULL>";
@@ -1048,7 +1048,7 @@ prom_n_addr_cells(struct device_node* np)
 	do {
 		if (np->parent)
 			np = np->parent;
-		ip = get_property(np, "#address-cells", NULL);
+		ip = of_get_property(np, "#address-cells", NULL);
 		if (ip != NULL)
 			return *ip;
 	} while (np->parent);
@@ -1064,7 +1064,7 @@ prom_n_size_cells(struct device_node* np)
 	do {
 		if (np->parent)
 			np = np->parent;
-		ip = get_property(np, "#size-cells", NULL);
+		ip = of_get_property(np, "#size-cells", NULL);
 		if (ip != NULL)
 			return *ip;
 	} while (np->parent);
@@ -1136,7 +1136,7 @@ int device_is_compatible(const struct device_node *device, const char *compat)
 	const char* cp;
 	int cplen, l;
 
-	cp = get_property(device, "compatible", &cplen);
+	cp = of_get_property(device, "compatible", &cplen);
 	if (cp == NULL)
 		return 0;
 	while (cplen > 0) {
@@ -1547,8 +1547,8 @@ static int of_finish_dynamic_node(struct device_node *node)
 	int err = 0;
 	const phandle *ibm_phandle;
 
-	node->name = get_property(node, "name", NULL);
-	node->type = get_property(node, "device_type", NULL);
+	node->name = of_get_property(node, "name", NULL);
+	node->type = of_get_property(node, "device_type", NULL);
 
 	if (!parent) {
 		err = -ENODEV;
@@ -1562,7 +1562,7 @@ static int of_finish_dynamic_node(struct device_node *node)
 		return -ENODEV;
 
 	/* fix up new node's linux_phandle field */
-	if ((ibm_phandle = get_property(node, "ibm,phandle", NULL)))
+	if ((ibm_phandle = of_get_property(node, "ibm,phandle", NULL)))
 		node->linux_phandle = *ibm_phandle;
 
 out:
@@ -1625,13 +1625,13 @@ EXPORT_SYMBOL(of_find_property);
  * Find a property with a given name for a given node
  * and return the value.
  */
-const void *get_property(const struct device_node *np, const char *name,
+const void *of_get_property(const struct device_node *np, const char *name,
 			 int *lenp)
 {
 	struct property *pp = of_find_property(np,name,lenp);
 	return pp ? pp->value : NULL;
 }
-EXPORT_SYMBOL(get_property);
+EXPORT_SYMBOL(of_get_property);
 
 /*
  * Add a property to a node
@@ -1762,10 +1762,10 @@ struct device_node *of_get_cpu_node(int cpu, unsigned int *thread)
 		/* Check for ibm,ppc-interrupt-server#s. If it doesn't exist
 		 * fallback to "reg" property and assume no threads
 		 */
-		intserv = get_property(np, "ibm,ppc-interrupt-server#s",
+		intserv = of_get_property(np, "ibm,ppc-interrupt-server#s",
 				&plen);
 		if (intserv == NULL) {
-			const u32 *reg = get_property(np, "reg", NULL);
+			const u32 *reg = of_get_property(np, "reg", NULL);
 			if (reg == NULL)
 				continue;
 			if (*reg == hardid) {
diff --git a/include/asm-powerpc/prom.h b/include/asm-powerpc/prom.h
index 994de8e..448c5ce 100644
--- a/include/asm-powerpc/prom.h
+++ b/include/asm-powerpc/prom.h
@@ -165,9 +165,10 @@ extern void early_init_devtree(void *);
 extern int device_is_compatible(const struct device_node *device,
 				const char *);
 extern int machine_is_compatible(const char *compat);
-extern const void *get_property(const struct device_node *node,
+extern const void *of_get_property(const struct device_node *node,
 				const char *name,
 				int *lenp);
+#define get_property(a, b, c)	of_get_property((a), (b), (c))
 extern void print_properties(struct device_node *node);
 extern int prom_n_addr_cells(struct device_node* np);
 extern int prom_n_size_cells(struct device_node* np);
diff --git a/include/asm-ppc/prom.h b/include/asm-ppc/prom.h
index adc5ae7..901f7fa 100644
--- a/include/asm-ppc/prom.h
+++ b/include/asm-ppc/prom.h
@@ -34,7 +34,8 @@ extern unsigned long sub_reloc_offset(unsigned long);
  */
 #define machine_is_compatible(x)		0
 #define of_find_compatible_node(f, t, c)	NULL
-#define get_property(p, n, l)			NULL
+#define of_get_property(p, n, l)		NULL
+#define get_property(a, b, c)			of_get_property((a), (b), (c))
 
 #endif /* _PPC_PROM_H */
 #endif /* __KERNEL__ */
-- 
1.5.0.3
