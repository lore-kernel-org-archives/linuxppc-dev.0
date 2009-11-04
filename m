Return-Path: <nfont@austin.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e38.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6AE7EB7BA2
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Nov 2009 09:20:54 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e38.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id nA4MGPED001098
	for <linuxppc-dev@ozlabs.org>; Wed, 4 Nov 2009 15:16:25 -0700
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	nA4MKmav226032
	for <linuxppc-dev@ozlabs.org>; Wed, 4 Nov 2009 15:20:49 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id nA4MHUlD030109
	for <linuxppc-dev@ozlabs.org>; Wed, 4 Nov 2009 15:17:31 -0700
Message-ID: <4AF1FE3D.3080601@austin.ibm.com>
Date: Wed, 04 Nov 2009 16:20:45 -0600
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: devicetree-discuss@lists.ozlabs.org, linuxppc-dev@ozlabs.org,
	microblaze-uclinux@itee.uq.edu.au
Subject: [RFC PATCH 5/5] powerpc/iseries updates for new OF dynamic code
References: <4AF1FB29.50905@austin.ibm.com>
In-Reply-To: <4AF1FB29.50905@austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Update the powerpc/iseries vio code to use the new generic OF dynamic code.

NOTE: I have no means of testing iseries kernels, this does at least pass the
compile test for me.

Signed-off-by: Nathan Fontenot <nfont@austin.ibm.com>
---

Index: linux-next/arch/powerpc/platforms/iseries/vio.c
===================================================================
--- linux-next.orig/arch/powerpc/platforms/iseries/vio.c	2009-11-02 13:39:40.000000000 -0600
+++ linux-next/arch/powerpc/platforms/iseries/vio.c	2009-11-03 12:34:19.000000000 -0600
@@ -80,8 +80,7 @@
 	kfree(np);
 }
 
-static struct device_node *new_node(const char *path,
-		struct device_node *parent)
+static struct device_node *new_node(const char *path)
 {
 	struct device_node *np = kzalloc(sizeof(*np), GFP_KERNEL);
 
@@ -93,9 +92,6 @@
 		return NULL;
 	}
 	strcpy(np->full_name, path);
-	of_node_set_flag(np, OF_DYNAMIC);
-	kref_init(&np->kref);
-	np->parent = of_node_get(parent);
 	return np;
 }
 
@@ -122,7 +118,7 @@
 
 	if (!nprop)
 		return 0;
-	prom_add_property(np, nprop);
+	of_property_attach(np, nprop);
 	return 1;
 }
 
@@ -133,19 +129,19 @@
 
 	if (!nprop)
 		return 0;
-	prom_add_property(np, nprop);
+	of_property_attach(np, nprop);
 	return 1;
 }
 
-static struct device_node *do_device_node(struct device_node *parent,
-		const char *name, u32 reg, u32 unit, const char *type,
-		const char *compat, struct vio_resource *res)
+static struct device_node *do_device_node(const char *name, u32 reg,
+		u32 unit, const char *type, const char *compat,
+		struct vio_resource *res)
 {
 	struct device_node *np;
 	char path[32];
 
 	snprintf(path, sizeof(path), "/vdevice/%s@%08x", name, reg);
-	np = new_node(path, parent);
+	np = new_node(path);
 	if (!np)
 		return NULL;
 	if (!add_string_property(np, "name", name) ||
@@ -168,15 +164,6 @@
 	np->name = of_get_property(np, "name", NULL);
 	np->type = of_get_property(np, "device_type", NULL);
 	of_attach_node(np);
-#ifdef CONFIG_PROC_DEVICETREE
-	if (parent->pde) {
-		struct proc_dir_entry *ent;
-
-		ent = proc_mkdir(strrchr(np->full_name, '/') + 1, parent->pde);
-		if (ent)
-			proc_device_tree_add_node(np, ent);
-	}
-#endif
 	return np;
 
  node_free:
@@ -190,16 +177,11 @@
  */
 struct vio_dev *vio_create_viodasd(u32 unit)
 {
-	struct device_node *vio_root;
 	struct device_node *np;
 	struct vio_dev *vdev = NULL;
 
-	vio_root = of_find_node_by_path("/vdevice");
-	if (!vio_root)
-		return NULL;
-	np = do_device_node(vio_root, "viodasd", FIRST_VIODASD + unit, unit,
+	np = do_device_node("viodasd", FIRST_VIODASD + unit, unit,
 			"block", "IBM,iSeries-viodasd", NULL);
-	of_node_put(vio_root);
 	if (np) {
 		vdev = vio_register_device_node(np);
 		if (!vdev)
@@ -254,7 +236,7 @@
 	}
 }
 
-static void __init probe_disk(struct device_node *vio_root, u32 unit)
+static void __init probe_disk(u32 unit)
 {
 	HvLpEvent_Rc hvrc;
 	struct vio_waitevent we;
@@ -305,11 +287,11 @@
 		return;
 	}
 
-	do_device_node(vio_root, "viodasd", FIRST_VIODASD + unit, unit,
+	do_device_node("viodasd", FIRST_VIODASD + unit, unit,
 			"block", "IBM,iSeries-viodasd", NULL);
 }
 
-static void __init get_viodasd_info(struct device_node *vio_root)
+static void __init get_viodasd_info(void)
 {
 	int rc;
 	u32 unit;
@@ -326,7 +308,7 @@
 	vio_setHandler(viomajorsubtype_blockio, handle_block_event);
 
 	for (unit = 0; unit < HVMAXARCHITECTEDVIRTUALDISKS; unit++)
-		probe_disk(vio_root, unit);
+		probe_disk(unit);
 
 	vio_clearHandler(viomajorsubtype_blockio);
 	viopath_close(viopath_hostLp, viomajorsubtype_blockio, 2);
@@ -372,7 +354,7 @@
 	}
 }
 
-static void __init get_viocd_info(struct device_node *vio_root)
+static void __init get_viocd_info(void)
 {
 	HvLpEvent_Rc hvrc;
 	u32 unit;
@@ -430,7 +412,7 @@
 
 	for (unit = 0; (unit < HVMAXARCHITECTEDVIRTUALCDROMS) &&
 			unitinfo[unit].rsrcname[0]; unit++) {
-		if (!do_device_node(vio_root, "viocd", FIRST_VIOCD + unit, unit,
+		if (!do_device_node("viocd", FIRST_VIOCD + unit, unit,
 				"block", "IBM,iSeries-viocd", &unitinfo[unit]))
 			break;
 	}
@@ -464,7 +446,7 @@
 	}
 }
 
-static void __init get_viotape_info(struct device_node *vio_root)
+static void __init get_viotape_info(void)
 {
 	HvLpEvent_Rc hvrc;
 	u32 unit;
@@ -507,7 +489,7 @@
 
 	for (unit = 0; (unit < HVMAXARCHITECTEDVIRTUALTAPES) &&
 			unitinfo[unit].rsrcname[0]; unit++) {
-		if (!do_device_node(vio_root, "viotape", FIRST_VIOTAPE + unit,
+		if (!do_device_node("viotape", FIRST_VIOTAPE + unit,
 				unit, "byte", "IBM,iSeries-viotape",
 				&unitinfo[unit]))
 			break;
@@ -522,7 +504,6 @@
 
 static int __init iseries_vio_init(void)
 {
-	struct device_node *vio_root;
 	int ret = -ENODEV;
 
 	if (!firmware_has_feature(FW_FEATURE_ISERIES))
@@ -530,25 +511,19 @@
 
 	iommu_vio_init();
 
-	vio_root = of_find_node_by_path("/vdevice");
-	if (!vio_root)
-		goto out;
-
 	if (viopath_hostLp == HvLpIndexInvalid) {
 		vio_set_hostlp();
 		/* If we don't have a host, bail out */
 		if (viopath_hostLp == HvLpIndexInvalid)
-			goto put_node;
+			goto out;
 	}
 
-	get_viodasd_info(vio_root);
-	get_viocd_info(vio_root);
-	get_viotape_info(vio_root);
+	get_viodasd_info();
+	get_viocd_info();
+	get_viotape_info();
 
 	ret = 0;
 
- put_node:
-	of_node_put(vio_root);
  out:
 	return ret;
 }
