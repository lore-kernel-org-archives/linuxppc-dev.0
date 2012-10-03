Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e1.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4FF412C00A5
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Oct 2012 12:58:53 +1000 (EST)
Received: from /spool/local
 by e1.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Tue, 2 Oct 2012 22:58:50 -0400
Message-ID: <506BA9E6.9050309@linux.vnet.ibm.com>
Date: Tue, 02 Oct 2012 21:58:46 -0500
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: devicetree-discuss@lists.ozlabs.org, cbe-oss-dev@lists.ozlabs.org,
 LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 4/5] Rename the drivers/of prom_*	functions to of_*
References: <506B2E63.5090900@linux.vnet.ibm.com>
In-Reply-To: <506B2E63.5090900@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Rename the prom_*_property routines of the generic OF code to of_*_property.
This brings them in line with the naming used by the rest of the OF code.

Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/machine_kexec.c       |   12 ++++++------
 arch/powerpc/kernel/machine_kexec_64.c    |    8 ++++----
 arch/powerpc/kernel/pci_32.c              |    2 +-
 arch/powerpc/platforms/ps3/os-area.c      |    6 +++---
 arch/powerpc/platforms/pseries/iommu.c    |    4 ++--
 arch/powerpc/platforms/pseries/mobility.c |    6 +++---
 arch/powerpc/platforms/pseries/reconfig.c |    8 ++++----
 drivers/macintosh/smu.c                   |    2 +-
 drivers/of/base.c                         |   15 +++++++--------
 include/linux/of.h                        |    9 ++++-----
 10 files changed, 35 insertions(+), 37 deletions(-)

Index: dt-next/include/linux/of.h
===================================================================
--- dt-next.orig/include/linux/of.h	2012-10-02 08:50:22.000000000 -0500
+++ dt-next/include/linux/of.h	2012-10-02 09:07:23.000000000 -0500
@@ -263,11 +263,10 @@
 
 extern int of_machine_is_compatible(const char *compat);
 
-extern int prom_add_property(struct device_node* np, struct property* prop);
-extern int prom_remove_property(struct device_node *np, struct property *prop);
-extern int prom_update_property(struct device_node *np,
-				struct property *newprop,
-				struct property *oldprop);
+extern int of_add_property(struct device_node *np, struct property *prop);
+extern int of_remove_property(struct device_node *np, struct property *prop);
+extern int of_update_property(struct device_node *np, struct property *newprop,
+			      struct property *oldprop);
 
 #if defined(CONFIG_OF_DYNAMIC)
 /* For updating the device tree at runtime */
Index: dt-next/arch/powerpc/kernel/pci_32.c
===================================================================
--- dt-next.orig/arch/powerpc/kernel/pci_32.c	2012-10-02 08:30:22.000000000 -0500
+++ dt-next/arch/powerpc/kernel/pci_32.c	2012-10-02 09:01:10.000000000 -0500
@@ -208,7 +208,7 @@
 		of_prop->name = "pci-OF-bus-map";
 		of_prop->length = 256;
 		of_prop->value = &of_prop[1];
-		prom_add_property(dn, of_prop);
+		of_add_property(dn, of_prop);
 		of_node_put(dn);
 	}
 }
Index: dt-next/arch/powerpc/kernel/machine_kexec.c
===================================================================
--- dt-next.orig/arch/powerpc/kernel/machine_kexec.c	2012-10-02 08:30:22.000000000 -0500
+++ dt-next/arch/powerpc/kernel/machine_kexec.c	2012-10-02 09:01:10.000000000 -0500
@@ -212,16 +212,16 @@
 	 * be sure what's in them, so remove them. */
 	prop = of_find_property(node, "linux,crashkernel-base", NULL);
 	if (prop)
-		prom_remove_property(node, prop);
+		of_remove_property(node, prop);
 
 	prop = of_find_property(node, "linux,crashkernel-size", NULL);
 	if (prop)
-		prom_remove_property(node, prop);
+		of_remove_property(node, prop);
 
 	if (crashk_res.start != 0) {
-		prom_add_property(node, &crashk_base_prop);
+		of_add_property(node, &crashk_base_prop);
 		crashk_size = resource_size(&crashk_res);
-		prom_add_property(node, &crashk_size_prop);
+		of_add_property(node, &crashk_size_prop);
 	}
 }
 
@@ -237,11 +237,11 @@
 	/* remove any stale properties so ours can be found */
 	prop = of_find_property(node, kernel_end_prop.name, NULL);
 	if (prop)
-		prom_remove_property(node, prop);
+		of_remove_property(node, prop);
 
 	/* information needed by userspace when using default_machine_kexec */
 	kernel_end = __pa(_end);
-	prom_add_property(node, &kernel_end_prop);
+	of_add_property(node, &kernel_end_prop);
 
 	export_crashk_values(node);
 
Index: dt-next/arch/powerpc/kernel/machine_kexec_64.c
===================================================================
--- dt-next.orig/arch/powerpc/kernel/machine_kexec_64.c	2012-10-02 08:30:22.000000000 -0500
+++ dt-next/arch/powerpc/kernel/machine_kexec_64.c	2012-10-02 09:01:10.000000000 -0500
@@ -389,14 +389,14 @@
 	/* remove any stale propertys so ours can be found */
 	prop = of_find_property(node, htab_base_prop.name, NULL);
 	if (prop)
-		prom_remove_property(node, prop);
+		of_remove_property(node, prop);
 	prop = of_find_property(node, htab_size_prop.name, NULL);
 	if (prop)
-		prom_remove_property(node, prop);
+		of_remove_property(node, prop);
 
 	htab_base = __pa(htab_address);
-	prom_add_property(node, &htab_base_prop);
-	prom_add_property(node, &htab_size_prop);
+	of_add_property(node, &htab_base_prop);
+	of_add_property(node, &htab_size_prop);
 
 	of_node_put(node);
 	return 0;
Index: dt-next/arch/powerpc/platforms/pseries/reconfig.c
===================================================================
--- dt-next.orig/arch/powerpc/platforms/pseries/reconfig.c	2012-10-02 08:45:12.000000000 -0500
+++ dt-next/arch/powerpc/platforms/pseries/reconfig.c	2012-10-02 09:14:31.000000000 -0500
@@ -326,7 +326,7 @@
 	if (!prop)
 		return -ENOMEM;
 
-	prom_add_property(np, prop);
+	of_add_property(np, prop);
 
 	return 0;
 }
@@ -350,7 +350,7 @@
 
 	prop = of_find_property(np, buf, NULL);
 
-	return prom_remove_property(np, prop);
+	return of_remove_property(np, prop);
 }
 
 static int do_update_property(char *buf, size_t bufsize)
@@ -380,11 +380,11 @@
 	oldprop = of_find_property(np, name,NULL);
 	if (!oldprop) {
 		if (strlen(name))
-			return prom_add_property(np, newprop);
+			return of_add_property(np, newprop);
 		return -ENODEV;
 	}
 
-	rc = prom_update_property(np, newprop, oldprop);
+	rc = of_update_property(np, newprop, oldprop);
 	return rc;
 }
 
Index: dt-next/arch/powerpc/platforms/pseries/mobility.c
===================================================================
--- dt-next.orig/arch/powerpc/platforms/pseries/mobility.c	2012-10-02 08:30:23.000000000 -0500
+++ dt-next/arch/powerpc/platforms/pseries/mobility.c	2012-10-02 09:03:54.000000000 -0500
@@ -119,9 +119,9 @@
 	if (!more) {
 		old_prop = of_find_property(dn, new_prop->name, NULL);
 		if (old_prop)
-			prom_update_property(dn, new_prop, old_prop);
+			of_update_property(dn, new_prop, old_prop);
 		else
-			prom_add_property(dn, new_prop);
+			of_add_property(dn, new_prop);
 
 		new_prop = NULL;
 	}
@@ -178,7 +178,7 @@
 
 			case 0x80000000:
 				prop = of_find_property(dn, prop_name, NULL);
-				prom_remove_property(dn, prop);
+				of_remove_property(dn, prop);
 				prop = NULL;
 				break;
 
Index: dt-next/arch/powerpc/platforms/pseries/iommu.c
===================================================================
--- dt-next.orig/arch/powerpc/platforms/pseries/iommu.c	2012-10-02 08:43:40.000000000 -0500
+++ dt-next/arch/powerpc/platforms/pseries/iommu.c	2012-10-02 09:01:10.000000000 -0500
@@ -747,7 +747,7 @@
 			np->full_name, ret, ddw_avail[2], liobn);
 
 delprop:
-	ret = prom_remove_property(np, win64);
+	ret = of_remove_property(np, win64);
 	if (ret)
 		pr_warning("%s: failed to remove direct window property: %d\n",
 			np->full_name, ret);
@@ -991,7 +991,7 @@
 		goto out_free_window;
 	}
 
-	ret = prom_add_property(pdn, win64);
+	ret = of_add_property(pdn, win64);
 	if (ret) {
 		dev_err(&dev->dev, "unable to add dma window property for %s: %d",
 			 pdn->full_name, ret);
Index: dt-next/arch/powerpc/platforms/ps3/os-area.c
===================================================================
--- dt-next.orig/arch/powerpc/platforms/ps3/os-area.c	2012-10-02 08:30:23.000000000 -0500
+++ dt-next/arch/powerpc/platforms/ps3/os-area.c	2012-10-02 09:01:10.000000000 -0500
@@ -280,13 +280,13 @@
 
 	if (tmp) {
 		pr_debug("%s:%d found %s\n", __func__, __LINE__, prop->name);
-		prom_remove_property(node, tmp);
+		of_remove_property(node, tmp);
 	}
 
-	result = prom_add_property(node, prop);
+	result = of_add_property(node, prop);
 
 	if (result)
-		pr_debug("%s:%d prom_set_property failed\n", __func__,
+		pr_debug("%s:%d of_set_property failed\n", __func__,
 			__LINE__);
 }
 
Index: dt-next/drivers/macintosh/smu.c
===================================================================
--- dt-next.orig/drivers/macintosh/smu.c	2012-10-02 08:30:35.000000000 -0500
+++ dt-next/drivers/macintosh/smu.c	2012-10-02 09:01:10.000000000 -0500
@@ -998,7 +998,7 @@
 		       "%02x !\n", id, hdr->id);
 		goto failure;
 	}
-	if (prom_add_property(smu->of_node, prop)) {
+	if (of_add_property(smu->of_node, prop)) {
 		printk(KERN_DEBUG "SMU: Failed creating sdb-partition-%02x "
 		       "property !\n", id);
 		goto failure;
Index: dt-next/drivers/of/base.c
===================================================================
--- dt-next.orig/drivers/of/base.c	2012-10-02 08:58:55.000000000 -0500
+++ dt-next/drivers/of/base.c	2012-10-02 09:05:37.000000000 -0500
@@ -997,9 +997,9 @@
 #endif
 
 /**
- * prom_add_property - Add a property to a node
+ * of_add_property - Add a property to a node
  */
-int prom_add_property(struct device_node *np, struct property *prop)
+int of_add_property(struct device_node *np, struct property *prop)
 {
 	struct property **next;
 	unsigned long flags;
@@ -1033,14 +1033,14 @@
 }
 
 /**
- * prom_remove_property - Remove a property from a node.
+ * of_remove_property - Remove a property from a node.
  *
  * Note that we don't actually remove it, since we have given out
  * who-knows-how-many pointers to the data using get-property.
  * Instead we just move the property to the "dead properties"
  * list, so it won't be found any more.
  */
-int prom_remove_property(struct device_node *np, struct property *prop)
+int of_remove_property(struct device_node *np, struct property *prop)
 {
 	struct property **next;
 	unsigned long flags;
@@ -1079,16 +1079,15 @@
 }
 
 /*
- * prom_update_property - Update a property in a node.
+ * of_update_property - Update a property in a node.
  *
  * Note that we don't actually remove it, since we have given out
  * who-knows-how-many pointers to the data using get-property.
  * Instead we just move the property to the "dead properties" list,
  * and add the new property to the property list
  */
-int prom_update_property(struct device_node *np,
-			 struct property *newprop,
-			 struct property *oldprop)
+int of_update_property(struct device_node *np, struct property *newprop,
+		       struct property *oldprop)
 {
 	struct property **next;
 	unsigned long flags;
