Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id E7422DDE30
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Mar 2007 04:27:59 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l2GHRucA013985
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Mar 2007 10:27:56 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.82.65.62])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l2GHRtwD019214
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Mar 2007 12:27:55 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32 [10.82.19.112])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	l2GH8Dse001307
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Mar 2007 12:08:14 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0162-tx32.am.freescale.net (Postfix) with ESMTP id 88E69AEFC9
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Mar 2007 12:27:54 -0500 (CDT)
Received: (from b07421@localhost)
	by ld0162-tx32.am.freescale.net (8.12.11/8.12.11/Submit) id
	l2GHRslI029798
	for linuxppc-dev@ozlabs.org; Fri, 16 Mar 2007 12:27:54 -0500
Date: Fri, 16 Mar 2007 12:27:54 -0500
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 02/17] bootwrapper: Add dt_ops methods.
Message-ID: <20070316172754.GB29784@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070316172641.GA29709@ld0162-tx32.am.freescale.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add get_parent, create_node, and find_node_by_prop_value to dt_ops.
Currently only implemented by flatdevtree_misc.

Also, add a _str convenience wrapper for setprop.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
This version of the patch fixes the off-by-one bug in setprop_str, and
doesn't include the finddevice_rel hook (cuboot no longer needs it, and
as David pointed out, it'd be better to make that the only finddevice
hook, which means that of.c has to implement it first).

 arch/powerpc/boot/flatdevtree_misc.c |   42 +++++++++++++++++++++------
 arch/powerpc/boot/ops.h              |   51 ++++++++++++++++++++++++++++++++++
 2 files changed, 83 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/boot/flatdevtree_misc.c b/arch/powerpc/boot/flatdevtree_misc.c
index 04da38f..4341e65 100644
--- a/arch/powerpc/boot/flatdevtree_misc.c
+++ b/arch/powerpc/boot/flatdevtree_misc.c
@@ -16,24 +16,43 @@
 
 static struct ft_cxt cxt;
 
-static void *ft_finddevice(const char *name)
+static void *fdtm_finddevice(const char *name)
 {
 	return ft_find_device(&cxt, name);
 }
 
-static int ft_getprop(const void *phandle, const char *propname, void *buf,
-		const int buflen)
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
 
-static unsigned long ft_finalize(void)
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
+static unsigned long fdtm_finalize(void)
 {
 	ft_end_tree(&cxt);
 	return (unsigned long)cxt.bph;
@@ -41,10 +60,13 @@ static unsigned long ft_finalize(void)
 
 int ft_init(void *dt_blob, unsigned int max_size, unsigned int max_find_device)
 {
-	dt_ops.finddevice = ft_finddevice;
-	dt_ops.getprop = ft_getprop;
-	dt_ops.setprop = ft_setprop;
-	dt_ops.finalize = ft_finalize;
+	dt_ops.finddevice = fdtm_finddevice;
+	dt_ops.getprop = fdtm_getprop;
+	dt_ops.setprop = fdtm_setprop;
+	dt_ops.get_parent = fdtm_get_parent;
+	dt_ops.create_node = fdtm_create_node;
+	dt_ops.find_node_by_prop_value = fdtm_find_node_by_prop_value;
+	dt_ops.finalize = fdtm_finalize;
 
 	return ft_open(&cxt, dt_blob, max_size, max_find_device,
 			platform_ops.realloc);
diff --git a/arch/powerpc/boot/ops.h b/arch/powerpc/boot/ops.h
index 2b569ad..dae0e3b 100644
--- a/arch/powerpc/boot/ops.h
+++ b/arch/powerpc/boot/ops.h
@@ -13,6 +13,7 @@
 
 #include <stddef.h>
 #include "types.h"
+#include "string.h"
 
 #define	COMMAND_LINE_SIZE	512
 #define	MAX_PATH_LEN		256
@@ -37,6 +38,12 @@ struct dt_ops {
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
@@ -89,6 +96,50 @@ static inline int setprop(void *devp, const char *name, void *buf, int buflen)
 	return (dt_ops.setprop) ? dt_ops.setprop(devp, name, buf, buflen) : -1;
 }
 
+static inline int setprop_str(void *devp, const char *name, const char *buf)
+{
+	if (dt_ops.setprop)
+		return dt_ops.setprop(devp, name, buf, strlen(buf) + 1);
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
+static inline void *find_node_by_devtype(const void *prev,
+                                         const char *type)
+{
+	return find_node_by_prop_value_str(prev, "device_type", type);
+}
+
 static inline void *malloc(u32 size)
 {
 	return (platform_ops.malloc) ? platform_ops.malloc(size) : NULL;
-- 
1.5.0.3
