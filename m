Return-Path: <mditto@consentry.com>
Received: from tidalnetworks.net (mail.consentry.com [75.35.230.10])
	by ozlabs.org (Postfix) with ESMTP id 6C5E2DDD0C
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Oct 2008 08:32:32 +1100 (EST)
Message-ID: <48FE4A6D.5@consentry.com>
Date: Tue, 21 Oct 2008 14:32:29 -0700
From: Mike Ditto <mditto@consentry.com>
MIME-Version: 1.0
To: Mike Ditto <mditto@consentry.com>, linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Add del_node function to allow early boot code to
	prune inapplicable devices.
References: <48F7E1E6.4040701@consentry.com>
	<20081017012604.GA22213@yookeroo.seuss>
In-Reply-To: <20081017012604.GA22213@yookeroo.seuss>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Reposting in proper format...

Some platforms have variants that can share most of a flat device tree but need
a few devices selectively pruned at boot time.  This adds del_node() to ops.h
to allow access to the existing fdt_del_node().

Signed-off-by: Mike Ditto <mditto@consentry.com>
---

Index: arch/powerpc/boot/ops.h
===================================================================
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 ops.h
--- arch/powerpc/boot/ops.h	11 Oct 2008 02:51:35 -0000	1.1.1.1
+++ arch/powerpc/boot/ops.h	18 Oct 2008 02:06:45 -0000
@@ -40,6 +40,7 @@
 			const int buflen);
 	int	(*setprop)(const void *phandle, const char *name,
 			const void *buf, const int buflen);
+	int (*del_node)(const void *phandle);
 	void *(*get_parent)(const void *phandle);
 	/* The node must not already exist. */
 	void *(*create_node)(const void *parent, const char *name);
@@ -124,6 +125,11 @@
 		return dt_ops.setprop(devp, name, buf, strlen(buf) + 1);

 	return -1;
+}
+
+static inline int del_node(const void *devp)
+{
+	return dt_ops.del_node ? dt_ops.del_node(devp) : -1;
 }

 static inline void *get_parent(const char *devp)
Index: arch/powerpc/boot/libfdt-wrapper.c
===================================================================
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 libfdt-wrapper.c
--- arch/powerpc/boot/libfdt-wrapper.c	11 Oct 2008 02:51:35 -0000	1.1.1.1
+++ arch/powerpc/boot/libfdt-wrapper.c	17 Oct 2008 22:08:44 -0000
@@ -105,6 +105,11 @@
 	return check_err(rc);
 }

+static int fdt_wrapper_del_node(const void *devp)
+{
+	return fdt_del_node(fdt, devp_offset(devp));
+}
+
 static void *fdt_wrapper_get_parent(const void *devp)
 {
 	return offset_devp(fdt_parent_offset(fdt, devp_offset(devp)));
@@ -173,6 +178,7 @@
 	dt_ops.create_node = fdt_wrapper_create_node;
 	dt_ops.find_node_by_prop_value = fdt_wrapper_find_node_by_prop_value;
 	dt_ops.find_node_by_compatible = fdt_wrapper_find_node_by_compatible;
+	dt_ops.del_node = fdt_wrapper_del_node;
 	dt_ops.get_path = fdt_wrapper_get_path;
 	dt_ops.finalize = fdt_wrapper_finalize;
