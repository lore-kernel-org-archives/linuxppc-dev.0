Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id A85B9DDEC9
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Jun 2007 09:36:25 +1000 (EST)
Message-Id: <20070611233354.006513064@arndb.de>
References: <20070611232824.489103547@arndb.de>
Date: Tue, 12 Jun 2007 01:28:28 +0200
From: arnd@arndb.de
To: paulus@samba.org
Subject: [patch 04/10] powerpc: rename add_bridge to avoid namespace clashes
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Many platforms currently define their own add_bridge function, some
of them globally. This breaks some multiplatform configurations.
Prefixing each of these functions with the platform name avoids
this problem.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Index: linux-2.6/arch/powerpc/platforms/82xx/mpc82xx_ads.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/82xx/mpc82xx_ads.c
+++ linux-2.6/arch/powerpc/platforms/82xx/mpc82xx_ads.c
@@ -49,7 +49,7 @@
 #include <linux/fs_enet_pd.h>
 
 #include <sysdev/fsl_soc.h>
-#include <../sysdev/cpm2_pic.h>
+#include <../../sysdev/cpm2_pic.h>
 
 #include "pq2ads.h"
 
@@ -515,7 +515,7 @@ static int m82xx_pci_exclude_device(u_ch
 		return PCIBIOS_SUCCESSFUL;
 }
 
-void __init add_bridge(struct device_node *np)
+static void __init mpc82xx_add_bridge(struct device_node *np)
 {
 	int len;
 	struct pci_controller *hose;
@@ -584,7 +584,7 @@ static void __init mpc82xx_ads_setup_arc
 #ifdef CONFIG_PCI
 	ppc_md.pci_exclude_device = m82xx_pci_exclude_device;
 	for (np = NULL; (np = of_find_node_by_type(np, "pci")) != NULL;)
-		add_bridge(np);
+		mpc82xx_add_bridge(np);
 
 	of_node_put(np);
 #endif
Index: linux-2.6/arch/powerpc/platforms/83xx/mpc836x_mds.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/83xx/mpc836x_mds.c
+++ linux-2.6/arch/powerpc/platforms/83xx/mpc836x_mds.c
@@ -86,7 +86,7 @@ static void __init mpc836x_mds_setup_arc
 
 #ifdef CONFIG_PCI
 	for (np = NULL; (np = of_find_node_by_type(np, "pci")) != NULL;)
-		add_bridge(np);
+		mpc83xx_add_bridge(np);
 	ppc_md.pci_exclude_device = mpc83xx_exclude_device;
 #endif
 
Index: linux-2.6/arch/powerpc/platforms/83xx/mpc83xx.h
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/83xx/mpc83xx.h
+++ linux-2.6/arch/powerpc/platforms/83xx/mpc83xx.h
@@ -27,7 +27,7 @@
  * mpc83xx_* files. Mostly for use by mpc83xx_setup
  */
 
-extern int add_bridge(struct device_node *dev);
+extern int mpc83xx_add_bridge(struct device_node *dev);
 extern int mpc83xx_exclude_device(u_char bus, u_char devfn);
 extern void mpc83xx_restart(char *cmd);
 extern long mpc83xx_time_init(void);
Index: linux-2.6/arch/powerpc/platforms/83xx/mpc8313_rdb.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/83xx/mpc8313_rdb.c
+++ linux-2.6/arch/powerpc/platforms/83xx/mpc8313_rdb.c
@@ -49,7 +49,7 @@ static void __init mpc8313_rdb_setup_arc
 
 #ifdef CONFIG_PCI
 	for (np = NULL; (np = of_find_node_by_type(np, "pci")) != NULL;)
-		add_bridge(np);
+		mpc83xx_add_bridge(np);
 
 	ppc_md.pci_exclude_device = mpc83xx_exclude_device;
 #endif
Index: linux-2.6/arch/powerpc/platforms/83xx/mpc832x_mds.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/83xx/mpc832x_mds.c
+++ linux-2.6/arch/powerpc/platforms/83xx/mpc832x_mds.c
@@ -80,7 +80,7 @@ static void __init mpc832x_sys_setup_arc
 
 #ifdef CONFIG_PCI
 	for (np = NULL; (np = of_find_node_by_type(np, "pci")) != NULL;)
-		add_bridge(np);
+		mpc83xx_add_bridge(np);
 	ppc_md.pci_exclude_device = mpc83xx_exclude_device;
 #endif
 
Index: linux-2.6/arch/powerpc/platforms/83xx/mpc832x_rdb.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/83xx/mpc832x_rdb.c
+++ linux-2.6/arch/powerpc/platforms/83xx/mpc832x_rdb.c
@@ -53,7 +53,7 @@ static void __init mpc832x_rdb_setup_arc
 
 #ifdef CONFIG_PCI
 	for (np = NULL; (np = of_find_node_by_type(np, "pci")) != NULL;)
-		add_bridge(np);
+		mpc83xx_add_bridge(np);
 
 	ppc_md.pci_exclude_device = mpc83xx_exclude_device;
 #endif
Index: linux-2.6/arch/powerpc/platforms/83xx/mpc834x_itx.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/83xx/mpc834x_itx.c
+++ linux-2.6/arch/powerpc/platforms/83xx/mpc834x_itx.c
@@ -59,7 +59,7 @@ static void __init mpc834x_itx_setup_arc
 
 #ifdef CONFIG_PCI
 	for (np = NULL; (np = of_find_node_by_type(np, "pci")) != NULL;)
-		add_bridge(np);
+		mpc83xx_add_bridge(np);
 
 	ppc_md.pci_exclude_device = mpc83xx_exclude_device;
 #endif
Index: linux-2.6/arch/powerpc/platforms/83xx/mpc834x_mds.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/83xx/mpc834x_mds.c
+++ linux-2.6/arch/powerpc/platforms/83xx/mpc834x_mds.c
@@ -129,7 +129,7 @@ static void __init mpc834x_mds_setup_arc
 
 #ifdef CONFIG_PCI
 	for (np = NULL; (np = of_find_node_by_type(np, "pci")) != NULL;)
-		add_bridge(np);
+		mpc83xx_add_bridge(np);
 
 	ppc_md.pci_exclude_device = mpc83xx_exclude_device;
 #endif
Index: linux-2.6/arch/powerpc/platforms/83xx/pci.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/83xx/pci.c
+++ linux-2.6/arch/powerpc/platforms/83xx/pci.c
@@ -45,7 +45,7 @@ int mpc83xx_exclude_device(u_char bus, u
 	return PCIBIOS_SUCCESSFUL;
 }
 
-int __init add_bridge(struct device_node *dev)
+int __init mpc83xx_add_bridge(struct device_node *dev)
 {
 	int len;
 	struct pci_controller *hose;
Index: linux-2.6/arch/powerpc/platforms/85xx/mpc85xx.h
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/85xx/mpc85xx.h
+++ linux-2.6/arch/powerpc/platforms/85xx/mpc85xx.h
@@ -15,4 +15,4 @@
  */
 
 extern void mpc85xx_restart(char *);
-extern int add_bridge(struct device_node *dev);
+extern int mpc85xx_add_bridge(struct device_node *dev);
Index: linux-2.6/arch/powerpc/platforms/85xx/mpc85xx_ads.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/85xx/mpc85xx_ads.c
+++ linux-2.6/arch/powerpc/platforms/85xx/mpc85xx_ads.c
@@ -241,7 +241,7 @@ static void __init mpc85xx_ads_setup_arc
 
 #ifdef CONFIG_PCI
 	for (np = NULL; (np = of_find_node_by_type(np, "pci")) != NULL;)
-		add_bridge(np);
+		mpc85xx_add_bridge(np);
 	ppc_md.pci_exclude_device = mpc85xx_exclude_device;
 #endif
 }
Index: linux-2.6/arch/powerpc/platforms/85xx/mpc85xx_cds.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/85xx/mpc85xx_cds.c
+++ linux-2.6/arch/powerpc/platforms/85xx/mpc85xx_cds.c
@@ -257,7 +257,7 @@ static void __init mpc85xx_cds_setup_arc
 
 #ifdef CONFIG_PCI
 	for (np = NULL; (np = of_find_node_by_type(np, "pci")) != NULL;)
-		add_bridge(np);
+		mpc85xx_add_bridge(np);
 
 	ppc_md.pcibios_fixup = mpc85xx_cds_pcibios_fixup;
 	ppc_md.pci_exclude_device = mpc85xx_exclude_device;
Index: linux-2.6/arch/powerpc/platforms/85xx/mpc85xx_mds.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/85xx/mpc85xx_mds.c
+++ linux-2.6/arch/powerpc/platforms/85xx/mpc85xx_mds.c
@@ -100,7 +100,7 @@ static void __init mpc85xx_mds_setup_arc
 
 #ifdef CONFIG_PCI
 	for (np = NULL; (np = of_find_node_by_type(np, "pci")) != NULL;) {
-		add_bridge(np);
+		mpc85xx_add_bridge(np);
 	}
 	of_node_put(np);
 #endif
Index: linux-2.6/arch/powerpc/platforms/85xx/pci.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/85xx/pci.c
+++ linux-2.6/arch/powerpc/platforms/85xx/pci.c
@@ -36,7 +36,7 @@
 int mpc85xx_pci2_busno = 0;
 
 #ifdef CONFIG_PCI
-int __init add_bridge(struct device_node *dev)
+int __init mpc85xx_add_bridge(struct device_node *dev)
 {
 	int len;
 	struct pci_controller *hose;
Index: linux-2.6/arch/powerpc/platforms/86xx/mpc86xx.h
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/86xx/mpc86xx.h
+++ linux-2.6/arch/powerpc/platforms/86xx/mpc86xx.h
@@ -15,7 +15,7 @@
  * mpc86xx_* files. Mostly for use by mpc86xx_setup().
  */
 
-extern int add_bridge(struct device_node *dev);
+extern int mpc86xx_add_bridge(struct device_node *dev);
 
 extern int mpc86xx_exclude_device(u_char bus, u_char devfn);
 
Index: linux-2.6/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
+++ linux-2.6/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
@@ -364,7 +364,7 @@ mpc86xx_hpcn_setup_arch(void)
 
 #ifdef CONFIG_PCI
 	for (np = NULL; (np = of_find_node_by_type(np, "pci")) != NULL;)
-		add_bridge(np);
+		mpc86xx_add_bridge(np);
 
 	ppc_md.pci_exclude_device = mpc86xx_exclude_device;
 #endif
Index: linux-2.6/arch/powerpc/platforms/86xx/pci.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/86xx/pci.c
+++ linux-2.6/arch/powerpc/platforms/86xx/pci.c
@@ -148,7 +148,7 @@ int mpc86xx_exclude_device(u_char bus, u
 	return PCIBIOS_SUCCESSFUL;
 }
 
-int __init add_bridge(struct device_node *dev)
+int __init mpc86xx_add_bridge(struct device_node *dev)
 {
 	int len;
 	struct pci_controller *hose;
Index: linux-2.6/arch/powerpc/platforms/embedded6xx/linkstation.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/embedded6xx/linkstation.c
+++ linux-2.6/arch/powerpc/platforms/embedded6xx/linkstation.c
@@ -54,7 +54,7 @@ static struct mtd_partition linkstation_
 	},
 };
 
-static int __init add_bridge(struct device_node *dev)
+static int __init linkstation_add_bridge(struct device_node *dev)
 {
 	int len;
 	struct pci_controller *hose;
@@ -92,7 +92,7 @@ static void __init linkstation_setup_arc
 
 	/* Lookup PCI host bridges */
 	for (np = NULL; (np = of_find_node_by_type(np, "pci")) != NULL;)
-		add_bridge(np);
+		linkstation_add_bridge(np);
 
 	printk(KERN_INFO "BUFFALO Network Attached Storage Series\n");
 	printk(KERN_INFO "(C) 2002-2005 BUFFALO INC.\n");
Index: linux-2.6/arch/powerpc/platforms/maple/pci.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/maple/pci.c
+++ linux-2.6/arch/powerpc/platforms/maple/pci.c
@@ -444,7 +444,7 @@ static void __init setup_u3_ht(struct pc
 	u3_ht = hose;
 }
 
-static int __init add_bridge(struct device_node *dev)
+static int __init maple_add_bridge(struct device_node *dev)
 {
 	int len;
 	struct pci_controller *hose;
@@ -558,7 +558,7 @@ void __init maple_pci_init(void)
 			continue;
 		if ((of_device_is_compatible(np, "u4-pcie") ||
 		     of_device_is_compatible(np, "u3-agp")) &&
-		    add_bridge(np) == 0)
+		    maple_add_bridge(np) == 0)
 			of_node_get(np);
 
 		if (of_device_is_compatible(np, "u3-ht")) {
@@ -570,7 +570,7 @@ void __init maple_pci_init(void)
 
 	/* Now setup the HyperTransport host if we found any
 	 */
-	if (ht && add_bridge(ht) != 0)
+	if (ht && maple_add_bridge(ht) != 0)
 		of_node_put(ht);
 
         /*
Index: linux-2.6/arch/powerpc/platforms/pasemi/pci.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/pasemi/pci.c
+++ linux-2.6/arch/powerpc/platforms/pasemi/pci.c
@@ -132,7 +132,7 @@ static void __init setup_pa_pxp(struct p
 	hose->cfg_data = ioremap(0xe0000000, 0x10000000);
 }
 
-static int __init add_bridge(struct device_node *dev)
+static int __init pas_add_bridge(struct device_node *dev)
 {
 	struct pci_controller *hose;
 
@@ -185,7 +185,7 @@ void __init pas_pci_init(void)
 	}
 
 	for (np = NULL; (np = of_get_next_child(root, np)) != NULL;)
-		if (np->name && !strcmp(np->name, "pxp") && !add_bridge(np))
+		if (np->name && !strcmp(np->name, "pxp") && !pas_add_bridge(np))
 			of_node_get(np);
 
 	of_node_put(root);
Index: linux-2.6/arch/powerpc/platforms/powermac/pci.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/powermac/pci.c
+++ linux-2.6/arch/powerpc/platforms/powermac/pci.c
@@ -35,8 +35,6 @@
 #define DBG(x...)
 #endif
 
-static int add_bridge(struct device_node *dev);
-
 /* XXX Could be per-controller, but I don't think we risk anything by
  * assuming we won't have both UniNorth and Bandit */
 static int has_uninorth;
@@ -897,7 +895,7 @@ static void __init setup_u3_ht(struct pc
  * "pci" (a MPC106) and no bandit or chaos bridges, and contrariwise,
  * if we have one or more bandit or chaos bridges, we don't have a MPC106.
  */
-static int __init add_bridge(struct device_node *dev)
+static int __init pmac_add_bridge(struct device_node *dev)
 {
 	int len;
 	struct pci_controller *hose;
@@ -1036,7 +1034,7 @@ void __init pmac_pci_init(void)
 		if (strcmp(np->name, "bandit") == 0
 		    || strcmp(np->name, "chaos") == 0
 		    || strcmp(np->name, "pci") == 0) {
-			if (add_bridge(np) == 0)
+			if (pmac_add_bridge(np) == 0)
 				of_node_get(np);
 		}
 		if (strcmp(np->name, "ht") == 0) {
@@ -1050,7 +1048,7 @@ void __init pmac_pci_init(void)
 	/* Probe HT last as it relies on the agp resources to be already
 	 * setup
 	 */
-	if (ht && add_bridge(ht) != 0)
+	if (ht && pmac_add_bridge(ht) != 0)
 		of_node_put(ht);
 
 	/*

--
