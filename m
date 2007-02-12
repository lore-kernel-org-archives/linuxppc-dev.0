Return-Path: <b07421@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 71C4DDDE3F
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Feb 2007 07:54:06 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l1CKs2xN000961
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Feb 2007 13:54:03 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.82.65.62])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l1CKs2Qh024936
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Feb 2007 14:54:02 -0600 (CST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32 [10.82.19.112])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	l1CKZdMO008197
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Feb 2007 14:35:39 -0600 (CST)
Received: from ld0162-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0162-tx32.am.freescale.net (Postfix) with ESMTP id 281ED4B926
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Feb 2007 14:54:00 -0600 (CST)
Received: (from b07421@localhost)
	by ld0162-tx32.am.freescale.net (8.12.11/8.12.11/Submit) id
	l1CKs01E017309
	for linuxppc-dev@ozlabs.org; Mon, 12 Feb 2007 14:54:00 -0600
Date: Mon, 12 Feb 2007 14:54:00 -0600
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 17/19] bootwrapper: Add dt_ops methods.
Message-ID: <20070212205400.GA17285@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add finddevice_rel, get_parent, create_node, and find_node_by_prop_value
to dt_ops.  Currently only implemented by flatdevtree_misc.

Also, add a _str convenience wrapper for setprop.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
This version of the patch makes the fdtm functions static and renames
existing ft_ functions to fdtm_, as pointed out by Mark.  A new patch
19 referencing fdtm_finalize rather than ft_finalize will be coming;
all other patches are the same as in the previous patchset.

 arch/powerpc/boot/flatdevtree_misc.c |   48 +++++++++++++++++++++++------
 arch/powerpc/boot/ops.h              |   56 +++++++++++++++++++++++++++++++++-
 2 files changed, 93 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/boot/flatdevtree_misc.c b/arch/powerpc/boot/flatdevtree_misc.c
index 39fa010..c169063 100644
--- a/arch/powerpc/boot/flatdevtree_misc.c
+++ b/arch/powerpc/boot/flatdevtree_misc.c
@@ -16,24 +16,48 @@
 
 static struct ft_cxt cxt;
 
-static void *ft_finddevice(const char *name)
+static void *fdtm_finddevice(const char *name)
 {
 	return ft_find_device(&cxt, name);
 }
 
-static int ft_getprop(const void *phandle, const char *propname, void *buf,
-		const int buflen)
+static void *fdtm_finddevice_rel(const void *phandle, const char *name)
+{
+	return ft_find_device_rel(&cxt, phandle, name);
+}
+
+static int fdtm_getprop(const void *phandle, const char *propname,
+                        void *buf, const int buflen)
 {
 	return ft_get_prop(&cxt, phandle, propname, buf, buflen);
 }
 
-static int ft_setprop(const void *phandle, const char *propname,
-		const void *buf, const int buflen)
+static int fdtm_setprop(const void *phandle, const char *propname,
+                        const void *buf, const int buflen)
 {
 	return ft_set_prop(&cxt, phandle, propname, buf, buflen);
 }
 
-unsigned long ft_finalize(void)
+static void *fdtm_get_parent(const void *phandle)
+{
+	return ft_get_parent(&cxt, phandle);
+}
+
+static void *fdtm_create_node(const void *phandle, const char *name)
+{
+	return ft_create_node(&cxt, phandle, name);
+}
+
+static void *fdtm_find_node_by_prop_value(const void *prev,
+                                          const char *propname,
+                                          const char *propval,
+                                          int proplen)
+{
+	return ft_find_node_by_prop_value(&cxt, prev, propname,
+	                                  propval, proplen);
+}
+
+unsigned long fdtm_finalize(void)
 {
 	unsigned long initrd_end = initrd.addr + initrd.size;
 	void *devp;
@@ -53,10 +77,14 @@ unsigned long ft_finalize(void)
 
 int ft_init(void *dt_blob, unsigned int max_size, unsigned int max_find_device)
 {
-	dt_ops.finddevice = ft_finddevice;
-	dt_ops.getprop = ft_getprop;
-	dt_ops.setprop = ft_setprop;
-	dt_ops.finalize = ft_finalize;
+	dt_ops.finddevice = fdtm_finddevice;
+	dt_ops.finddevice_rel = fdtm_finddevice_rel;
+	dt_ops.getprop = fdtm_getprop;
+	dt_ops.setprop = fdtm_setprop;
+	dt_ops.get_parent = fdtm_get_parent;
+	dt_ops.create_node = fdtm_create_node;
+	dt_ops.find_node_by_prop_value = fdtm_find_node_by_prop_value;
+	dt_ops.finalize = fdtm_finalize;
 
 	return ft_open(&cxt, dt_blob, max_size, max_find_device,
 			platform_ops.realloc);
diff --git a/arch/powerpc/boot/ops.h b/arch/powerpc/boot/ops.h
index 0bc4a68..e8f1177 100644
--- a/arch/powerpc/boot/ops.h
+++ b/arch/powerpc/boot/ops.h
@@ -13,6 +13,7 @@
 
 #include <stddef.h>
 #include "types.h"
+#include "string.h"
 
 #define	COMMAND_LINE_SIZE	512
 #define	MAX_PATH_LEN		256
@@ -32,10 +33,17 @@ extern struct platform_ops platform_ops;
 /* Device Tree operations */
 struct dt_ops {
 	void *	(*finddevice)(const char *name);
+	void *	(*finddevice_rel)(const void *phandle, const char *name);
 	int	(*getprop)(const void *phandle, const char *name, void *buf,
 			const int buflen);
 	int	(*setprop)(const void *phandle, const char *name,
 			const void *buf, const int buflen);
+	void *(*get_parent)(const void *phandle);
+	/* The node must not already exist. */
+	void *(*create_node)(const void *parent, const char *name);
+	void *(*find_node_by_prop_value)(const void *prev,
+	                                 const char *propname,
+	                                 const char *propval, int proplen);
 	unsigned long (*finalize)(void);
 };
 extern struct dt_ops dt_ops;
@@ -63,7 +71,7 @@ int platform_init(unsigned long r3, unsi
                   unsigned long r6, unsigned long r7,
                   char *dt_blob_start, char *dt_blob_end);
 int ft_init(void *dt_blob, unsigned int max_size, unsigned int max_find_device);
-unsigned long ft_finalize(void);
+unsigned long fdtm_finalize(void);
 int serial_console_init(void);
 int ns16550_console_init(void *devp, struct serial_console_data *scdp);
 void *simple_alloc_init(char *base, u32 heap_size, u32 granularity,
@@ -75,6 +83,14 @@ static inline void *finddevice(const cha
 	return (dt_ops.finddevice) ? dt_ops.finddevice(name) : NULL;
 }
 
+static inline void *finddevice_rel(const void *phandle, const char *name)
+{
+	if (dt_ops.finddevice_rel)
+		return dt_ops.finddevice_rel(phandle, name);
+
+	return NULL;
+}
+
 static inline int getprop(void *devp, const char *name, void *buf, int buflen)
 {
 	return (dt_ops.getprop) ? dt_ops.getprop(devp, name, buf, buflen) : -1;
@@ -85,6 +101,44 @@ static inline int setprop(void *devp, co
 	return (dt_ops.setprop) ? dt_ops.setprop(devp, name, buf, buflen) : -1;
 }
 
+static inline int setprop_str(void *devp, const char *name, const char *buf)
+{
+	if (dt_ops.setprop)
+		return dt_ops.setprop(devp, name, buf, strlen(buf));
+
+	return -1;
+}
+
+static inline void *get_parent(const char *devp)
+{
+	return dt_ops.get_parent ? dt_ops.get_parent(devp) : NULL;
+}
+
+static inline void *create_node(const void *parent, const char *name)
+{
+	return dt_ops.create_node ? dt_ops.create_node(parent, name) : NULL;
+}
+
+
+static inline void *find_node_by_prop_value(const void *prev,
+                                            const char *propname,
+                                            const char *propval, int proplen)
+{
+	if (dt_ops.find_node_by_prop_value)
+		return dt_ops.find_node_by_prop_value(prev, propname,
+		                                      propval, proplen);
+
+	return NULL;
+}
+
+static inline void *find_node_by_prop_value_str(const void *prev,
+                                                const char *propname,
+                                                const char *propval)
+{
+	return find_node_by_prop_value(prev, propname, propval,
+	                               strlen(propval) + 1);
+}
+
 static inline void *malloc(u32 size)
 {
 	return (platform_ops.malloc) ? platform_ops.malloc(size) : NULL;
-- 
1.4.4
