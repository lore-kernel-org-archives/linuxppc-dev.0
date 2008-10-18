Return-Path: <mditto@consentry.com>
Received: from tidalnetworks.net (mail.consentry.com [75.35.230.10])
	by ozlabs.org (Postfix) with ESMTP id E9369DDDFF
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Oct 2008 13:14:10 +1100 (EST)
Message-ID: <48F9466D.8060603@consentry.com>
Date: Fri, 17 Oct 2008 19:14:05 -0700
From: Mike Ditto <mditto@consentry.com>
MIME-Version: 1.0
To: Mike Ditto <mditto@consentry.com>, linuxppc-dev@ozlabs.org
Subject: Re: device tree variations
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

David Gibson wrote:
> Deleting the irrelevant parts or picking a device tree to pass to
> fdt_init() are both reasonable solutions.  libfdt which is included in
> the bootwrapper has functions for removing unwanted nodes: either
> fdt_nop_node() or fdt_del_node() will suffice.  There isn't currently
> a dt_ops hook to call though to those functions though.  You could
> either add one, or (knowing that your platform always has a flat dt)
> bypass the dt_ops hooks and call libfdt directly.

Thanks.  The fdt_del_node approach works pretty nicely.  I added a
dt_ops hook since fdt is static in libfdt-wrapper.c.

At first I tried fdt_nop_node, fearing that find_node_by_prop_value()
and fdt_del_node() would interact badly when deleting in mid-traversal,
but it turns out that fdt_nop_node() upsets find_node_by_prop_value()
anyway.  Plus, the kernel prints harmless but strange messages when
there are NOPs in the tree.  So I use fdt_del_node() and rescan from
the top each time I delete a node and it works fine.

	/* Find all product-dependent nodes and delete inapplicable ones. */
	dev = NULL;
	while ((dev = find_node_by_prop_value(dev,
					      "product-dependent",
					      "", 0)) != NULL) {
		u32 mask;
		int len;

		len = getprop(dev, "productmask", &mask, sizeof mask);
		if (len == sizeof mask) {
			if ((mask & (1 << product_id)) == 0) {
				del_node(dev);
				/* Have to restart from the beginning. */
				dev = NULL;
			}
		}
	}

I had to fix the memcmp bug I mentioned in an earlier posting to allow
searching for a boolean (empty) property.

If anyone cares, below is a trivial patch to expose the del_node()
operation via dt_ops.

Thanks again,
					-=] Mike [=-


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
