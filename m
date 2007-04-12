Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 8C322DDEC8
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Apr 2007 14:18:56 +1000 (EST)
Date: Thu, 12 Apr 2007 14:19:05 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "David S. Miller" <davem@davemloft.net>, paulus@samba.org
Subject: [PATCH,RFC] Split out common parts of prom.h
Message-Id: <20070412141905.6f30efd3.sfr@canb.auug.org.au>
In-Reply-To: <20070403232406.ab9a3c86.sfr@canb.auug.org.au>
References: <20070403105217.7b9fea08.sfr@canb.auug.org.au>
	<20070403222406.cf39c459.sfr@canb.auug.org.au>
	<20070403222641.e93cb73b.sfr@canb.auug.org.au>
	<20070403222841.a2c6af1c.sfr@canb.auug.org.au>
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

This creates linux/openfw.h and includes asm/prom.h from it.

We also include linux/openfw.h from asm/prom.h while we transition.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 include/asm-powerpc/prom.h |   39 +++-------------------------
 include/asm-sparc/prom.h   |   48 ++++-------------------------------
 include/asm-sparc64/prom.h |   48 ++++-------------------------------
 include/linux/openfw.h     |   59 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 76 insertions(+), 118 deletions(-)
 create mode 100644 include/linux/openfw.h

This applies on top of all the previous patches I sent (including a merge
of the sparc64 and powerpc for-2.6.22 trees).  So if people can't get it
to apply, at least I would like some comments on the direction. (I told
Rusty about the circular inclusion below and he didn't throw up, so I
figure it isn't too bad as a temporary measure.)

I have built allmodconfig (modified slightly) for Powerpc, Sparc64 and
Sparc.  (All of which fail during the module post processing but for
reasons not related to these patches as far as I can see.)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/include/asm-powerpc/prom.h b/include/asm-powerpc/prom.h
index 12fa0c4..cc85c7f 100644
--- a/include/asm-powerpc/prom.h
+++ b/include/asm-powerpc/prom.h
@@ -97,12 +97,6 @@ struct device_node {
 
 extern struct device_node *of_chosen;
 
-/* flag descriptions */
-#define OF_DYNAMIC 1 /* node and properties were allocated via kmalloc */
-
-#define OF_IS_DYNAMIC(x) test_bit(OF_DYNAMIC, &x->_flags)
-#define OF_MARK_DYNAMIC(x) set_bit(OF_DYNAMIC, &x->_flags)
-
 #define HAVE_ARCH_DEVTREE_FIXUPS
 
 static inline void set_node_proc_entry(struct device_node *dn, struct proc_dir_entry *de)
@@ -120,27 +114,7 @@ extern struct device_node *find_compatible_devices(const char *type,
 extern struct device_node *find_all_nodes(void);
 
 /* New style node lookup */
-extern struct device_node *of_find_node_by_name(struct device_node *from,
-	const char *name);
-#define for_each_node_by_name(dn, name) \
-	for (dn = of_find_node_by_name(NULL, name); dn; \
-	     dn = of_find_node_by_name(dn, name))
-extern struct device_node *of_find_node_by_type(struct device_node *from,
-	const char *type);
-#define for_each_node_by_type(dn, type) \
-	for (dn = of_find_node_by_type(NULL, type); dn; \
-	     dn = of_find_node_by_type(dn, type))
-extern struct device_node *of_find_compatible_node(struct device_node *from,
-	const char *type, const char *compat);
-extern struct device_node *of_find_node_by_path(const char *path);
-extern struct device_node *of_find_node_by_phandle(phandle handle);
 extern struct device_node *of_find_all_nodes(struct device_node *prev);
-extern struct device_node *of_get_parent(const struct device_node *node);
-extern struct device_node *of_get_next_child(const struct device_node *node,
-					     struct device_node *prev);
-extern struct property *of_find_property(const struct device_node *np,
-					 const char *name,
-					 int *lenp);
 extern struct device_node *of_node_get(struct device_node *node);
 extern void of_node_put(struct device_node *node);
 
@@ -162,16 +136,9 @@ extern void of_detach_node(const struct device_node *);
 extern void finish_device_tree(void);
 extern void unflatten_device_tree(void);
 extern void early_init_devtree(void *);
-extern int of_device_is_compatible(const struct device_node *device,
-				const char *);
 #define device_is_compatible(d, c)	of_device_is_compatible((d), (c))
 extern int machine_is_compatible(const char *compat);
-extern const void *of_get_property(const struct device_node *node,
-				const char *name,
-				int *lenp);
 extern void print_properties(struct device_node *node);
-extern int of_n_addr_cells(struct device_node* np);
-extern int of_n_size_cells(struct device_node* np);
 extern int prom_n_intr_cells(struct device_node* np);
 extern void prom_get_irq_senses(unsigned char *senses, int off, int max);
 extern int prom_add_property(struct device_node* np, struct property* prop);
@@ -225,7 +192,6 @@ static inline unsigned long of_read_ulong(const u32 *cell, int size)
 
 /* Translate an OF address block into a CPU physical address
  */
-#define OF_BAD_ADDR	((u64)-1)
 extern u64 of_translate_address(struct device_node *np, const u32 *addr);
 
 /* Extract an address from a device, returns the region size and
@@ -354,6 +320,11 @@ static inline int of_irq_to_resource(struct device_node *dev, int index, struct
 	return irq;
 }
 
+/*
+ * NB:  This is here while we transition from using asm/prom.h
+ * to linux/openfw.h
+ */
+#include <linux/openfw.h>
 
 #endif /* __KERNEL__ */
 #endif /* _POWERPC_PROM_H */
diff --git a/include/asm-sparc/prom.h b/include/asm-sparc/prom.h
index c239a80..5188852 100644
--- a/include/asm-sparc/prom.h
+++ b/include/asm-sparc/prom.h
@@ -2,7 +2,6 @@
 #define _SPARC_PROM_H
 #ifdef __KERNEL__
 
-
 /*
  * Definitions for talking to the Open Firmware PROM on
  * Power Macintosh computers.
@@ -17,7 +16,6 @@
  * as published by the Free Software Foundation; either version
  * 2 of the License, or (at your option) any later version.
  */
-
 #include <linux/types.h>
 #include <linux/proc_fs.h>
 #include <asm/atomic.h>
@@ -55,52 +53,18 @@ struct device_node {
 	unsigned int unique_id;
 };
 
-/* flag descriptions */
-#define OF_DYNAMIC 1 /* node and properties were allocated via kmalloc */
-
-#define OF_IS_DYNAMIC(x) test_bit(OF_DYNAMIC, &x->_flags)
-#define OF_MARK_DYNAMIC(x) set_bit(OF_DYNAMIC, &x->_flags)
-
-#define OF_BAD_ADDR	((u64)-1)
-
-static inline void set_node_proc_entry(struct device_node *dn, struct proc_dir_entry *de)
-{
-	dn->pde = de;
-}
-
-extern struct device_node *of_find_node_by_name(struct device_node *from,
-	const char *name);
-#define for_each_node_by_name(dn, name) \
-	for (dn = of_find_node_by_name(NULL, name); dn; \
-	     dn = of_find_node_by_name(dn, name))
-extern struct device_node *of_find_node_by_type(struct device_node *from,
-	const char *type);
-#define for_each_node_by_type(dn, type) \
-	for (dn = of_find_node_by_type(NULL, type); dn; \
-	     dn = of_find_node_by_type(dn, type))
-extern struct device_node *of_find_compatible_node(struct device_node *from,
-	const char *type, const char *compat);
-extern struct device_node *of_find_node_by_path(const char *path);
-extern struct device_node *of_find_node_by_phandle(phandle handle);
-extern struct device_node *of_get_parent(const struct device_node *node);
-extern struct device_node *of_get_next_child(const struct device_node *node,
-					     struct device_node *prev);
-extern struct property *of_find_property(const struct device_node *np,
-					 const char *name,
-					 int *lenp);
-extern int of_device_is_compatible(const struct device_node *device,
-				   const char *);
-extern const void *of_get_property(const struct device_node *node,
-				   const char *name,
-				   int *lenp);
 extern int of_set_property(struct device_node *node, const char *name, void *val, int len);
 extern int of_getintprop_default(struct device_node *np,
 				 const char *name,
 				 int def);
-extern int of_n_addr_cells(struct device_node *np);
-extern int of_n_size_cells(struct device_node *np);
 
 extern void prom_build_devicetree(void);
 
+/*
+ * NB:  This is here while we transition from using asm/prom.h
+ * to linux/openfw.h
+ */
+#include <linux/openfw.h>
+
 #endif /* __KERNEL__ */
 #endif /* _SPARC_PROM_H */
diff --git a/include/asm-sparc64/prom.h b/include/asm-sparc64/prom.h
index 88e62cc..b1557c0 100644
--- a/include/asm-sparc64/prom.h
+++ b/include/asm-sparc64/prom.h
@@ -2,7 +2,6 @@
 #define _SPARC64_PROM_H
 #ifdef __KERNEL__
 
-
 /*
  * Definitions for talking to the Open Firmware PROM on
  * Power Macintosh computers.
@@ -17,7 +16,6 @@
  * as published by the Free Software Foundation; either version
  * 2 of the License, or (at your option) any later version.
  */
-
 #include <linux/types.h>
 #include <linux/proc_fs.h>
 #include <asm/atomic.h>
@@ -63,52 +61,18 @@ struct of_irq_controller {
 	void		*data;
 };
 
-/* flag descriptions */
-#define OF_DYNAMIC 1 /* node and properties were allocated via kmalloc */
-
-#define OF_IS_DYNAMIC(x) test_bit(OF_DYNAMIC, &x->_flags)
-#define OF_MARK_DYNAMIC(x) set_bit(OF_DYNAMIC, &x->_flags)
-
-#define OF_BAD_ADDR	((u64)-1)
-
-static inline void set_node_proc_entry(struct device_node *dn, struct proc_dir_entry *de)
-{
-	dn->pde = de;
-}
-
-extern struct device_node *of_find_node_by_name(struct device_node *from,
-	const char *name);
-#define for_each_node_by_name(dn, name) \
-	for (dn = of_find_node_by_name(NULL, name); dn; \
-	     dn = of_find_node_by_name(dn, name))
-extern struct device_node *of_find_node_by_type(struct device_node *from,
-	const char *type);
-#define for_each_node_by_type(dn, type) \
-	for (dn = of_find_node_by_type(NULL, type); dn; \
-	     dn = of_find_node_by_type(dn, type))
-extern struct device_node *of_find_compatible_node(struct device_node *from,
-	const char *type, const char *compat);
-extern struct device_node *of_find_node_by_path(const char *path);
-extern struct device_node *of_find_node_by_phandle(phandle handle);
-extern struct device_node *of_get_parent(const struct device_node *node);
-extern struct device_node *of_get_next_child(const struct device_node *node,
-					     struct device_node *prev);
-extern struct property *of_find_property(const struct device_node *np,
-					 const char *name,
-					 int *lenp);
-extern int of_device_is_compatible(const struct device_node *device,
-				   const char *);
-extern const void *of_get_property(const struct device_node *node,
-			     const char *name,
-			     int *lenp);
 extern int of_set_property(struct device_node *node, const char *name, void *val, int len);
 extern int of_getintprop_default(struct device_node *np,
 				 const char *name,
 				 int def);
-extern int of_n_addr_cells(struct device_node *np);
-extern int of_n_size_cells(struct device_node *np);
 
 extern void prom_build_devicetree(void);
 
+/*
+ * NB:  This is here while we transition from using asm/prom.h
+ * to linux/openfw.h
+ */
+#include <linux/openfw.h>
+
 #endif /* __KERNEL__ */
 #endif /* _SPARC64_PROM_H */
diff --git a/include/linux/openfw.h b/include/linux/openfw.h
new file mode 100644
index 0000000..d4d9a9c
--- /dev/null
+++ b/include/linux/openfw.h
@@ -0,0 +1,59 @@
+#ifndef _LINUX_OPENFW_H
+#define _LINUX_OPENFW_H
+/*
+ * Definitions for talking to the Open Firmware PROM on
+ * Power Macintosh and other computers.
+ *
+ * Copyright (C) 1996-2005 Paul Mackerras.
+ *
+ * Updates for PPC64 by Peter Bergner & David Engebretsen, IBM Corp.
+ * Updates for SPARC64 by David S. Miller
+ * Derived from PowerPC and Sparc prom.h files by Stephen Rothwell, IBM Corp.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+#include <linux/types.h>
+
+#include <asm/bitops.h>
+#include <asm/prom.h>
+
+/* flag descriptions */
+#define OF_DYNAMIC 1 /* node and properties were allocated via kmalloc */
+
+#define OF_IS_DYNAMIC(x) test_bit(OF_DYNAMIC, &x->_flags)
+#define OF_MARK_DYNAMIC(x) set_bit(OF_DYNAMIC, &x->_flags)
+
+#define OF_BAD_ADDR	((u64)-1)
+
+extern struct device_node *of_find_node_by_name(struct device_node *from,
+	const char *name);
+#define for_each_node_by_name(dn, name) \
+	for (dn = of_find_node_by_name(NULL, name); dn; \
+	     dn = of_find_node_by_name(dn, name))
+extern struct device_node *of_find_node_by_type(struct device_node *from,
+	const char *type);
+#define for_each_node_by_type(dn, type) \
+	for (dn = of_find_node_by_type(NULL, type); dn; \
+	     dn = of_find_node_by_type(dn, type))
+extern struct device_node *of_find_compatible_node(struct device_node *from,
+	const char *type, const char *compat);
+extern struct device_node *of_find_node_by_path(const char *path);
+extern struct device_node *of_find_node_by_phandle(phandle handle);
+extern struct device_node *of_get_parent(const struct device_node *node);
+extern struct device_node *of_get_next_child(const struct device_node *node,
+					     struct device_node *prev);
+extern struct property *of_find_property(const struct device_node *np,
+					 const char *name,
+					 int *lenp);
+extern int of_device_is_compatible(const struct device_node *device,
+				   const char *);
+extern const void *of_get_property(const struct device_node *node,
+				const char *name,
+				int *lenp);
+extern int of_n_addr_cells(struct device_node *np);
+extern int of_n_size_cells(struct device_node *np);
+
+#endif /* _LINUX_OPENFW_H */
-- 
1.5.1
