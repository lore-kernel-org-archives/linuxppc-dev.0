Return-Path: <jk@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Jeremy Kerr <jk@ozlabs.org>
Date: Thu, 29 Jun 2006 20:28:18 +1000
Subject: [PATCH] [powerpc] change get_property to return void *
Message-Id: <1151576898.883498.737885160345.qpush@pokey>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Change the get_property() function to return a void *. This allows us
to later remove the cast done in the majority of callers.

Built for pseries, iseries, pmac32, cell, cbesim, g5, systemsim, maple,
and mpc* defconfigs

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
---

 arch/powerpc/kernel/prom.c |    3 +--
 include/asm-powerpc/prom.h |    4 ++--
 2 files changed, 3 insertions(+), 4 deletions(-)

Index: linux-2.6/arch/powerpc/kernel/prom.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/prom.c
+++ linux-2.6/arch/powerpc/kernel/prom.c
@@ -1975,8 +1975,7 @@ struct property *of_find_property(struct
  * Find a property with a given name for a given node
  * and return the value.
  */
-unsigned char *get_property(struct device_node *np, const char *name,
-			    int *lenp)
+void *get_property(struct device_node *np, const char *name, int *lenp)
 {
 	struct property *pp = of_find_property(np,name,lenp);
 	return pp ? pp->value : NULL;
Index: linux-2.6/include/asm-powerpc/prom.h
===================================================================
--- linux-2.6.orig/include/asm-powerpc/prom.h
+++ linux-2.6/include/asm-powerpc/prom.h
@@ -167,8 +167,8 @@ extern void unflatten_device_tree(void);
 extern void early_init_devtree(void *);
 extern int device_is_compatible(struct device_node *device, const char *);
 extern int machine_is_compatible(const char *compat);
-extern unsigned char *get_property(struct device_node *node, const char *name,
-				   int *lenp);
+extern void *get_property(struct device_node *node, const char *name,
+		int *lenp);
 extern void print_properties(struct device_node *node);
 extern int prom_n_addr_cells(struct device_node* np);
 extern int prom_n_size_cells(struct device_node* np);
