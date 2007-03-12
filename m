Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 0C6ACDE11D
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Mar 2007 07:42:06 +1100 (EST)
Date: Mon, 12 Mar 2007 14:42:01 -0600
From: Scott Wood <scottwood@freescale.com>
To: paulus@samba.org
Subject: [PATCH 15/19] bootwrapper: Add dt_ops methods.
Message-ID: <20070312204201.GO28545@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
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
 arch/powerpc/boot/flatdevtree_misc.c |   48 ++++++++++++++++++++++++------
 arch/powerpc/boot/ops.h              |   54 ++++++++++++++++++++++++++++++++++
 2 files changed, 92 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/boot/flatdevtree_misc.c b/arch/powerpc/boot/flatdevtree_misc.c
index 04da38f..4c2cbcc 100644
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
@@ -41,10 +65,14 @@ static unsigned long ft_finalize(void)
 
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
index 2b569ad..6b4fd9b 100644
--- a/arch/powerpc/boot/ops.h
+++ b/arch/powerpc/boot/ops.h
@@ -13,6 +13,7 @@
 
 #include <stddef.h>
 #include "types.h"
+#include "string.h"
 
 #define	COMMAND_LINE_SIZE	512
 #define	MAX_PATH_LEN		256
@@ -33,10 +34,17 @@ extern struct platform_ops platform_ops;
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
@@ -79,6 +87,14 @@ static inline void *finddevice(const char *name)
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
@@ -89,6 +105,44 @@ static inline int setprop(void *devp, const char *name, void *buf, int buflen)
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
1.5.0.3
