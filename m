Return-Path: <jk@ozlabs.org>
To: linuxppc-dev@ozlabs.org
From: Jeremy Kerr <jk@ozlabs.org>
Subject: [PATCH 20/20] [powerpc] Make get_property() return a const void *
Message-ID: 1151993427.2210.21@pokey
Date: Tue,  4 Jul 2006 16:46:44 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Previous changes have treated the return values of get_property as
const, so now we can make the actual change to get_property(). There
shouldn't be a need to cast the return values anymore.

We will now get compiler warnings when property values are assigned to
a non-const variable.

If properties need to be updated, there's still the of_find_property
function.

Built for cell_defconfig, chrp32_defconfig, g5_defconfig,
iseries_defconfig, maple_defconfig, pmac32_defconfig, ppc64_defconfig
and pseries_defconfig.

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
---

 arch/powerpc/kernel/prom.c |    2 +-
 include/asm-powerpc/prom.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6/arch/powerpc/kernel/prom.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/prom.c
+++ linux-2.6/arch/powerpc/kernel/prom.c
@@ -1527,7 +1527,7 @@ struct property *of_find_property(struct
  * Find a property with a given name for a given node
  * and return the value.
  */
-void *get_property(struct device_node *np, const char *name, int *lenp)
+const void *get_property(struct device_node *np, const char *name, int *lenp)
 {
 	struct property *pp = of_find_property(np,name,lenp);
 	return pp ? pp->value : NULL;
Index: linux-2.6/include/asm-powerpc/prom.h
===================================================================
--- linux-2.6.orig/include/asm-powerpc/prom.h
+++ linux-2.6/include/asm-powerpc/prom.h
@@ -160,7 +160,7 @@ extern void unflatten_device_tree(void);
 extern void early_init_devtree(void *);
 extern int device_is_compatible(struct device_node *device, const char *);
 extern int machine_is_compatible(const char *compat);
-extern void *get_property(struct device_node *node, const char *name,
+extern const void *get_property(struct device_node *node, const char *name,
 		int *lenp);
 extern void print_properties(struct device_node *node);
 extern int prom_n_addr_cells(struct device_node* np);
