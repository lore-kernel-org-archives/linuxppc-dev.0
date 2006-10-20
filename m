Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AE96267C08
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Oct 2006 11:50:05 +1000 (EST)
Subject: [PATCH] powerpc: Fix device_is_compatible() const warning
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Fri, 20 Oct 2006 11:49:54 +1000
Message-Id: <1161308994.10524.114.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Fix a const'ification related warning with device_is_compatible()
and friends related to get_property() not properly having const
on it's input device node argument.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-cell/arch/powerpc/kernel/prom.c
===================================================================
--- linux-cell.orig/arch/powerpc/kernel/prom.c	2006-10-09 12:03:33.000000000 +1000
+++ linux-cell/arch/powerpc/kernel/prom.c	2006-10-17 11:12:51.000000000 +1000
@@ -1014,7 +1014,7 @@ EXPORT_SYMBOL(find_all_nodes);
 /** Checks if the given "compat" string matches one of the strings in
  * the device's "compatible" property
  */
-int device_is_compatible(struct device_node *device, const char *compat)
+int device_is_compatible(const struct device_node *device, const char *compat)
 {
 	const char* cp;
 	int cplen, l;
@@ -1491,7 +1491,8 @@ static int __init prom_reconfig_setup(vo
 __initcall(prom_reconfig_setup);
 #endif
 
-struct property *of_find_property(struct device_node *np, const char *name,
+struct property *of_find_property(const struct device_node *np,
+				  const char *name,
 				  int *lenp)
 {
 	struct property *pp;
@@ -1512,7 +1513,8 @@ struct property *of_find_property(struct
  * Find a property with a given name for a given node
  * and return the value.
  */
-const void *get_property(struct device_node *np, const char *name, int *lenp)
+const void *get_property(const struct device_node *np, const char *name,
+			 int *lenp)
 {
 	struct property *pp = of_find_property(np,name,lenp);
 	return pp ? pp->value : NULL;
Index: linux-cell/include/asm-powerpc/prom.h
===================================================================
--- linux-cell.orig/include/asm-powerpc/prom.h	2006-10-06 13:48:24.000000000 +1000
+++ linux-cell/include/asm-powerpc/prom.h	2006-10-17 11:12:12.000000000 +1000
@@ -134,7 +134,7 @@ extern struct device_node *of_find_all_n
 extern struct device_node *of_get_parent(const struct device_node *node);
 extern struct device_node *of_get_next_child(const struct device_node *node,
 					     struct device_node *prev);
-extern struct property *of_find_property(struct device_node *np,
+extern struct property *of_find_property(const struct device_node *np,
 					 const char *name,
 					 int *lenp);
 extern struct device_node *of_node_get(struct device_node *node);
@@ -158,10 +158,12 @@ extern void of_detach_node(const struct 
 extern void finish_device_tree(void);
 extern void unflatten_device_tree(void);
 extern void early_init_devtree(void *);
-extern int device_is_compatible(struct device_node *device, const char *);
+extern int device_is_compatible(const struct device_node *device,
+				const char *);
 extern int machine_is_compatible(const char *compat);
-extern const void *get_property(struct device_node *node, const char *name,
-		int *lenp);
+extern const void *get_property(const struct device_node *node,
+				const char *name,
+				int *lenp);
 extern void print_properties(struct device_node *node);
 extern int prom_n_addr_cells(struct device_node* np);
 extern int prom_n_size_cells(struct device_node* np);
