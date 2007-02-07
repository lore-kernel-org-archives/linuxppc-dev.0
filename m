Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 7B6A6DDF3A
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Feb 2007 10:28:44 +1100 (EST)
Date: Wed, 7 Feb 2007 17:01:44 -0600
From: Scott Wood <scottwood@freescale.com>
To: paulus@samba.org
Subject: [PATCH 17/19] bootwrapper: Add dt_ops methods.
Message-ID: <20070207230144.GQ3849@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070207230017.GA3758@ld0162-tx32.am.freescale.net>
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
 arch/powerpc/boot/flatdevtree_misc.c |   26 ++++++++++++++++
 arch/powerpc/boot/ops.h              |   54 ++++++++++++++++++++++++++++++++++
 2 files changed, 80 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/flatdevtree_misc.c b/arch/powerpc/boot/flatdevtree_misc.c
index 39fa010..10e5f27 100644
--- a/arch/powerpc/boot/flatdevtree_misc.c
+++ b/arch/powerpc/boot/flatdevtree_misc.c
@@ -21,6 +21,11 @@ static void *ft_finddevice(const char *n
 	return ft_find_device(&cxt, name);
 }
 
+static void *ft_finddevice_rel(const void *phandle, const char *name)
+{
+	return ft_find_device_rel(&cxt, phandle, name);
+}
+
 static int ft_getprop(const void *phandle, const char *propname, void *buf,
 		const int buflen)
 {
@@ -51,12 +56,33 @@ unsigned long ft_finalize(void)
 	return (unsigned long)cxt.bph;
 }
 
+void *fdtm_get_parent(const void *phandle)
+{
+	return ft_get_parent(&cxt, phandle);
+}
+
+void *fdtm_create_node(const void *phandle, const char *name)
+{
+	return ft_create_node(&cxt, phandle, name);
+}
+
+void *fdtm_find_node_by_prop_value(const void *prev, const char *propname,
+                                   const char *propval, int proplen)
+{
+	return ft_find_node_by_prop_value(&cxt, prev, propname,
+	                                  propval, proplen);
+}
+
 int ft_init(void *dt_blob, unsigned int max_size, unsigned int max_find_device)
 {
 	dt_ops.finddevice = ft_finddevice;
+	dt_ops.finddevice_rel = ft_finddevice_rel;
 	dt_ops.getprop = ft_getprop;
 	dt_ops.setprop = ft_setprop;
 	dt_ops.finalize = ft_finalize;
+	dt_ops.get_parent = fdtm_get_parent;
+	dt_ops.create_node = fdtm_create_node;
+	dt_ops.find_node_by_prop_value = fdtm_find_node_by_prop_value;
 
 	return ft_open(&cxt, dt_blob, max_size, max_find_device,
 			platform_ops.realloc);
diff --git a/arch/powerpc/boot/ops.h b/arch/powerpc/boot/ops.h
index 0bc4a68..381627e 100644
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
