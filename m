Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id EB182DE8B8
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Jan 2007 07:13:11 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l0TKDAOQ005778
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jan 2007 13:13:10 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.82.65.62])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l0TKD9hP023213
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jan 2007 14:13:09 -0600 (CST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32 [10.82.19.112])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	l0TJtIi1014956
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jan 2007 13:55:19 -0600 (CST)
Received: from ld0162-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0162-tx32.am.freescale.net (Postfix) with ESMTP id EE03F4B92B
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jan 2007 14:13:07 -0600 (CST)
Received: (from b07421@localhost)
	by ld0162-tx32.am.freescale.net (8.12.11/8.12.11/Submit) id
	l0TKD7S2013571
	for linuxppc-dev@ozlabs.org; Mon, 29 Jan 2007 14:13:07 -0600
Date: Mon, 29 Jan 2007 14:13:07 -0600
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 16/18] bootwrapper: Add dt_ops methods.
Message-ID: <20070129201307.GP13485@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ca1ac163-f732-45ce-9629-e6f4a8c3a880@ld0162-tx32.am.freescale.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add finddevice_rel, get_parent, create_node, and find_prop to dt_ops.
Currently only implemented by flatdevtree_misc.

Also, add a _str convenience wrapper for setprop.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/boot/flatdevtree_misc.c |   25 +++++++++++++++++
 arch/powerpc/boot/ops.h              |   49 ++++++++++++++++++++++++++++++++++
 2 files changed, 74 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/flatdevtree_misc.c b/arch/powerpc/boot/flatdevtree_misc.c
index 39fa010..2ec12eb 100644
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
@@ -51,12 +56,32 @@ unsigned long ft_finalize(void)
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
+void *fdtm_find_prop(const void *prev, const char *propname,
+                     const char *propval, int proplen)
+{
+	return ft_find_prop(&cxt, prev, propname, propval, proplen);
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
+	dt_ops.find_prop = fdtm_find_prop;
 
 	return ft_open(&cxt, dt_blob, max_size, max_find_device,
 			platform_ops.realloc);
diff --git a/arch/powerpc/boot/ops.h b/arch/powerpc/boot/ops.h
index 0bc4a68..522b7c8 100644
--- a/arch/powerpc/boot/ops.h
+++ b/arch/powerpc/boot/ops.h
@@ -13,6 +13,7 @@
 
 #include <stddef.h>
 #include "types.h"
+#include "string.h"
 
 #define	COMMAND_LINE_SIZE	512
 #define	MAX_PATH_LEN		256
@@ -32,10 +33,16 @@ extern struct platform_ops platform_ops;
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
+	void *(*find_prop)(const void *prev, const char *propname,
+	                   const char *propval, int proplen);
 	unsigned long (*finalize)(void);
 };
 extern struct dt_ops dt_ops;
@@ -75,6 +82,14 @@ static inline void *finddevice(const cha
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
@@ -85,6 +100,40 @@ static inline int setprop(void *devp, co
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
+static inline void *find_prop(const void *prev, const char *propname,
+	                      const char *propval, int proplen)
+{
+	if (dt_ops.find_prop)
+		return dt_ops.find_prop(prev, propname, propval, proplen);
+
+	return NULL;
+}
+
+static inline void *find_prop_str(const void *prev, const char *propname,
+	                          const char *propval)
+{
+	return find_prop(prev, propname, propval, strlen(propval) + 1);
+}
+
 static inline void *malloc(u32 size)
 {
 	return (platform_ops.malloc) ? platform_ops.malloc(size) : NULL;
-- 
1.4.4
