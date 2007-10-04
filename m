Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 29692DDE07
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Oct 2007 15:32:05 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.13.8/8.13.8) with ESMTP id l945W18i025506
	for <linuxppc-dev@ozlabs.org>; Thu, 4 Oct 2007 00:32:02 -0500
Date: Thu, 4 Oct 2007 00:31:35 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [POWERPC] Use for_each_ matching routinues for pci PHBs
Message-ID: <Pine.LNX.4.64.0710040030010.11519@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On the Freescale embedded (83xx, 85xx, 86xx) and a few of the discrete
bridges (mpc10x, tsi108) use the new for_each_compatible_node() or
for_each_node_by_type() to provide more exact matching when looking for
PHBs in the device tree.

With the previous code it was possible to match on pci bridges since
we were only matching on device_type.

---
 arch/powerpc/platforms/83xx/mpc8313_rdb.c         |    2 +-
 arch/powerpc/platforms/83xx/mpc832x_mds.c         |    2 +-
 arch/powerpc/platforms/83xx/mpc832x_rdb.c         |    2 +-
 arch/powerpc/platforms/83xx/mpc834x_itx.c         |    2 +-
 arch/powerpc/platforms/83xx/mpc834x_mds.c         |    2 +-
 arch/powerpc/platforms/83xx/mpc836x_mds.c         |    2 +-
 arch/powerpc/platforms/85xx/mpc85xx_ads.c         |    3 ++-
 arch/powerpc/platforms/85xx/mpc85xx_cds.c         |   18 +++++++++++-------
 arch/powerpc/platforms/85xx/mpc85xx_ds.c          |   18 +++++++++++-------
 arch/powerpc/platforms/85xx/mpc85xx_mds.c         |   14 +++++++++++---
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c        |    3 ++-
 arch/powerpc/platforms/embedded6xx/linkstation.c  |    2 +-
 arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c |    2 +-
 13 files changed, 45 insertions(+), 27 deletions(-)

In my git tree.

diff --git a/arch/powerpc/platforms/83xx/mpc8313_rdb.c b/arch/powerpc/platforms/83xx/mpc8313_rdb.c
index 140b46f..33766b8 100644
--- a/arch/powerpc/platforms/83xx/mpc8313_rdb.c
+++ b/arch/powerpc/platforms/83xx/mpc8313_rdb.c
@@ -43,7 +43,7 @@ static void __init mpc8313_rdb_setup_arch(void)
 		ppc_md.progress("mpc8313_rdb_setup_arch()", 0);

 #ifdef CONFIG_PCI
-	for (np = NULL; (np = of_find_node_by_type(np, "pci")) != NULL;)
+	for_each_compatible_node(np, "pci", "fsl,mpc8349-pci")
 		mpc83xx_add_bridge(np);
 #endif
 	mpc831x_usb_cfg();
diff --git a/arch/powerpc/platforms/83xx/mpc832x_mds.c b/arch/powerpc/platforms/83xx/mpc832x_mds.c
index d494bc4..b8d8c91 100644
--- a/arch/powerpc/platforms/83xx/mpc832x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc832x_mds.c
@@ -73,7 +73,7 @@ static void __init mpc832x_sys_setup_arch(void)
 	}

 #ifdef CONFIG_PCI
-	for (np = NULL; (np = of_find_node_by_type(np, "pci")) != NULL;)
+	for_each_compatible_node(np, "pci", "fsl,mpc8349-pci")
 		mpc83xx_add_bridge(np);
 #endif

diff --git a/arch/powerpc/platforms/83xx/mpc832x_rdb.c b/arch/powerpc/platforms/83xx/mpc832x_rdb.c
index 24a790c..4da0698 100644
--- a/arch/powerpc/platforms/83xx/mpc832x_rdb.c
+++ b/arch/powerpc/platforms/83xx/mpc832x_rdb.c
@@ -93,7 +93,7 @@ static void __init mpc832x_rdb_setup_arch(void)
 		ppc_md.progress("mpc832x_rdb_setup_arch()", 0);

 #ifdef CONFIG_PCI
-	for (np = NULL; (np = of_find_node_by_type(np, "pci")) != NULL;)
+	for_each_compatible_node(np, "pci", "fsl,mpc8349-pci")
 		mpc83xx_add_bridge(np);
 #endif

diff --git a/arch/powerpc/platforms/83xx/mpc834x_itx.c b/arch/powerpc/platforms/83xx/mpc834x_itx.c
index 870fd20..aa76819 100644
--- a/arch/powerpc/platforms/83xx/mpc834x_itx.c
+++ b/arch/powerpc/platforms/83xx/mpc834x_itx.c
@@ -52,7 +52,7 @@ static void __init mpc834x_itx_setup_arch(void)
 		ppc_md.progress("mpc834x_itx_setup_arch()", 0);

 #ifdef CONFIG_PCI
-	for (np = NULL; (np = of_find_node_by_type(np, "pci")) != NULL;)
+	for_each_compatible_node(np, "pci", "fsl,mpc8349-pci")
 		mpc83xx_add_bridge(np);
 #endif

diff --git a/arch/powerpc/platforms/83xx/mpc834x_mds.c b/arch/powerpc/platforms/83xx/mpc834x_mds.c
index a9140b6..00aed7c 100644
--- a/arch/powerpc/platforms/83xx/mpc834x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc834x_mds.c
@@ -83,7 +83,7 @@ static void __init mpc834x_mds_setup_arch(void)
 		ppc_md.progress("mpc834x_mds_setup_arch()", 0);

 #ifdef CONFIG_PCI
-	for (np = NULL; (np = of_find_node_by_type(np, "pci")) != NULL;)
+	for_each_compatible_node(np, "pci", "fsl,mpc8349-pci")
 		mpc83xx_add_bridge(np);
 #endif

diff --git a/arch/powerpc/platforms/83xx/mpc836x_mds.c b/arch/powerpc/platforms/83xx/mpc836x_mds.c
index db69576..0b18a75 100644
--- a/arch/powerpc/platforms/83xx/mpc836x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc836x_mds.c
@@ -79,7 +79,7 @@ static void __init mpc836x_mds_setup_arch(void)
 	}

 #ifdef CONFIG_PCI
-	for (np = NULL; (np = of_find_node_by_type(np, "pci")) != NULL;)
+	for_each_compatible_node(np, "pci", "fsl,mpc8349-pci")
 		mpc83xx_add_bridge(np);
 #endif

diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ads.c b/arch/powerpc/platforms/85xx/mpc85xx_ads.c
index c22bc1c..acb1ef9 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ads.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ads.c
@@ -204,8 +204,9 @@ static void __init mpc85xx_ads_setup_arch(void)
 #endif

 #ifdef CONFIG_PCI
-	for (np = NULL; (np = of_find_node_by_type(np, "pci")) != NULL;)
+	for_each_compatible_node(np, "pci", "fsl,mpc8540-pci")
 		fsl_add_bridge(np, 1);
+
 	ppc_md.pci_exclude_device = mpc85xx_exclude_device;
 #endif
 }
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_cds.c b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
index 665e8df..abc85b8 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_cds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
@@ -283,14 +283,18 @@ static void __init mpc85xx_cds_setup_arch(void)
 	}

 #ifdef CONFIG_PCI
-	for (np = NULL; (np = of_find_node_by_type(np, "pci")) != NULL;) {
-		struct resource rsrc;
-		of_address_to_resource(np, 0, &rsrc);
-		if ((rsrc.start & 0xfffff) == 0x8000)
-			fsl_add_bridge(np, 1);
-		else
-			fsl_add_bridge(np, 0);
+	for_each_node_by_type(np, "pci") {
+		if (of_device_is_compatible(np, "fsl,mpc8540-pci") ||
+		    of_device_is_compatible(np, "fsl,mpc8548-pcie")) {
+			struct resource rsrc;
+			of_address_to_resource(np, 0, &rsrc);
+			if ((rsrc.start & 0xfffff) == 0x8000)
+				fsl_add_bridge(np, 1);
+			else
+				fsl_add_bridge(np, 0);
+		}
 	}
+
 	ppc_md.pci_irq_fixup = mpc85xx_cds_pci_irq_fixup;
 	ppc_md.pci_exclude_device = mpc85xx_exclude_device;
 #endif
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ds.c b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
index 4d44902..d60bb2b 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
@@ -149,14 +149,18 @@ static void __init mpc85xx_ds_setup_arch(void)
 		ppc_md.progress("mpc85xx_ds_setup_arch()", 0);

 #ifdef CONFIG_PCI
-	for (np = NULL; (np = of_find_node_by_type(np, "pci")) != NULL;) {
-		struct resource rsrc;
-		of_address_to_resource(np, 0, &rsrc);
-		if ((rsrc.start & 0xfffff) == primary_phb_addr)
-			fsl_add_bridge(np, 1);
-		else
-			fsl_add_bridge(np, 0);
+	for_each_node_by_type(np, "pci") {
+		if (of_device_is_compatible(np, "fsl,mpc8540-pci") ||
+		    of_device_is_compatible(np, "fsl,mpc8548-pcie")) {
+			struct resource rsrc;
+			of_address_to_resource(np, 0, &rsrc);
+			if ((rsrc.start & 0xfffff) == primary_phb_addr)
+				fsl_add_bridge(np, 1);
+			else
+				fsl_add_bridge(np, 0);
+		}
 	}
+
 	uses_fsl_uli_m1575 = 1;
 	ppc_md.pci_exclude_device = mpc85xx_exclude_device;
 #endif
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_mds.c b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
index c379286..f8b6b08 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_mds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
@@ -83,9 +83,17 @@ static void __init mpc85xx_mds_setup_arch(void)
 	}

 #ifdef CONFIG_PCI
-	for (np = NULL; (np = of_find_node_by_type(np, "pci")) != NULL;)
-		fsl_add_bridge(np, 1);
-	of_node_put(np);
+	for_each_node_by_type(np, "pci") {
+		if (of_device_is_compatible(np, "fsl,mpc8540-pci") ||
+		    of_device_is_compatible(np, "fsl,mpc8548-pcie")) {
+			struct resource rsrc;
+			of_address_to_resource(np, 0, &rsrc);
+			if ((rsrc.start & 0xfffff) == 0x8000)
+				fsl_add_bridge(np, 1);
+			else
+				fsl_add_bridge(np, 0);
+		}
+	}
 #endif

 #ifdef CONFIG_QUICC_ENGINE
diff --git a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
index 3ec9d5a..6879b83 100644
--- a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
+++ b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
@@ -140,7 +140,7 @@ mpc86xx_hpcn_setup_arch(void)
 		ppc_md.progress("mpc86xx_hpcn_setup_arch()", 0);

 #ifdef CONFIG_PCI
-	for (np = NULL; (np = of_find_node_by_type(np, "pci")) != NULL;) {
+	for_each_compatible_node(np, "pci", "fsl,mpc8641-pcie") {
 		struct resource rsrc;
 		of_address_to_resource(np, 0, &rsrc);
 		if ((rsrc.start & 0xfffff) == 0x8000)
@@ -148,6 +148,7 @@ mpc86xx_hpcn_setup_arch(void)
 		else
 			fsl_add_bridge(np, 0);
 	}
+
 	uses_fsl_uli_m1575 = 1;
 	ppc_md.pci_exclude_device = mpc86xx_exclude_device;

diff --git a/arch/powerpc/platforms/embedded6xx/linkstation.c b/arch/powerpc/platforms/embedded6xx/linkstation.c
index f392374..eb5d74e 100644
--- a/arch/powerpc/platforms/embedded6xx/linkstation.c
+++ b/arch/powerpc/platforms/embedded6xx/linkstation.c
@@ -91,7 +91,7 @@ static void __init linkstation_setup_arch(void)
 #endif

 	/* Lookup PCI host bridges */
-	for (np = NULL; (np = of_find_node_by_type(np, "pci")) != NULL;)
+	for_each_compatible_node(np, "pci", "mpc10x-pci")
 		linkstation_add_bridge(np);

 	printk(KERN_INFO "BUFFALO Network Attached Storage Series\n");
diff --git a/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c b/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c
index 96737e5..a2c04b9 100644
--- a/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c
+++ b/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c
@@ -74,7 +74,7 @@ static void __init mpc7448_hpc2_setup_arch(void)

 	/* setup PCI host bridge */
 #ifdef CONFIG_PCI
-	for (np = NULL; (np = of_find_node_by_type(np, "pci")) != NULL;)
+	for_each_compatible_node(np, "pci", "tsi108-pci")
 		tsi108_setup_pci(np, MPC7448HPC2_PCI_CFG_PHYS, 0);

 	ppc_md.pci_exclude_device = mpc7448_hpc2_exclude_device;
-- 
1.5.2.4
