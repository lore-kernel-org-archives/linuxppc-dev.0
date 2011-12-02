Return-Path: <Kyle.D.Moffett@boeing.com>
Received: from border.exmeritus.com (border.exmeritus.com
 [IPv6:2002:46a7:f11a:ffff::])
 by ozlabs.org (Postfix) with ESMTP id 7DDEF1008EE
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Dec 2011 03:29:14 +1100 (EST)
From: Kyle Moffett <Kyle.D.Moffett@boeing.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH v3 05/10] powerpc/mpic: Search for open-pic device-tree node
 if NULL
Date: Fri,  2 Dec 2011 11:28:02 -0500
Message-Id: <1322843287-2745-6-git-send-email-Kyle.D.Moffett@boeing.com>
In-Reply-To: <1322795058.3729.48.camel@pasglop>
References: <1322795058.3729.48.camel@pasglop>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <michaele@au1.ibm.com>,
 Kyle Moffett <Kyle.D.Moffett@boeing.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Almost all PowerPC platforms use a standard "open-pic" device node so
the mpic_alloc() function now accepts NULL for the device-node.  This
will cause it to perform a default search with of_find_matching_node().

Signed-off-by: Kyle Moffett <Kyle.D.Moffett@boeing.com>
---
 arch/powerpc/platforms/85xx/corenet_ds.c          |   10 +-----
 arch/powerpc/platforms/85xx/ksi8560.c             |   14 +--------
 arch/powerpc/platforms/85xx/mpc8536_ds.c          |   13 +-------
 arch/powerpc/platforms/85xx/mpc85xx_ads.c         |   13 +-------
 arch/powerpc/platforms/85xx/mpc85xx_cds.c         |   15 +--------
 arch/powerpc/platforms/85xx/mpc85xx_ds.c          |   14 ++-------
 arch/powerpc/platforms/85xx/mpc85xx_mds.c         |   10 +-----
 arch/powerpc/platforms/85xx/mpc85xx_rdb.c         |   14 +-------
 arch/powerpc/platforms/85xx/p1010rdb.c            |   12 +------
 arch/powerpc/platforms/85xx/p1022_ds.c            |   14 +--------
 arch/powerpc/platforms/85xx/p1023_rds.c           |   11 +------
 arch/powerpc/platforms/85xx/sbc8548.c             |   16 +---------
 arch/powerpc/platforms/85xx/sbc8560.c             |   13 +-------
 arch/powerpc/platforms/85xx/socrates.c            |   11 +------
 arch/powerpc/platforms/85xx/stx_gp3.c             |   13 +-------
 arch/powerpc/platforms/85xx/tqm85xx.c             |   13 +-------
 arch/powerpc/platforms/85xx/xes_mpc85xx.c         |   13 +-------
 arch/powerpc/platforms/86xx/pic.c                 |   11 +-----
 arch/powerpc/platforms/embedded6xx/holly.c        |   10 +-----
 arch/powerpc/platforms/embedded6xx/linkstation.c  |    8 +----
 arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c |   10 +-----
 arch/powerpc/platforms/embedded6xx/storcenter.c   |   10 +-----
 arch/powerpc/sysdev/mpic.c                        |   34 ++++++++++++++++++--
 23 files changed, 58 insertions(+), 244 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/corenet_ds.c b/arch/powerpc/platforms/85xx/corenet_ds.c
index 5b1c577..cfa4bad 100644
--- a/arch/powerpc/platforms/85xx/corenet_ds.c
+++ b/arch/powerpc/platforms/85xx/corenet_ds.c
@@ -36,21 +36,13 @@
 void __init corenet_ds_pic_init(void)
 {
 	struct mpic *mpic;
-	struct device_node *np = NULL;
 	unsigned int flags = MPIC_PRIMARY | MPIC_BIG_ENDIAN |
 				MPIC_BROKEN_FRR_NIRQS | MPIC_SINGLE_DEST_CPU;
 
-	np = of_find_node_by_type(np, "open-pic");
-
-	if (np == NULL) {
-		printk(KERN_ERR "Could not find open-pic node\n");
-		return;
-	}
-
 	if (ppc_md.get_irq == mpic_get_coreint_irq)
 		flags |= MPIC_ENABLE_COREINT;
 
-	mpic = mpic_alloc(np, 0, flags, 0, 256, " OpenPIC  ");
+	mpic = mpic_alloc(NULL, 0, flags, 0, 256, " OpenPIC  ");
 	BUG_ON(mpic == NULL);
 
 	mpic_init(mpic);
diff --git a/arch/powerpc/platforms/85xx/ksi8560.c b/arch/powerpc/platforms/85xx/ksi8560.c
index 3403b0e..1620fa8 100644
--- a/arch/powerpc/platforms/85xx/ksi8560.c
+++ b/arch/powerpc/platforms/85xx/ksi8560.c
@@ -57,22 +57,10 @@ static void machine_restart(char *cmd)
 
 static void __init ksi8560_pic_init(void)
 {
-	struct mpic *mpic;
-	struct device_node *np;
-
-	np = of_find_node_by_type(NULL, "open-pic");
-
-	if (np == NULL) {
-		printk(KERN_ERR "Could not find open-pic node\n");
-		return;
-	}
-
-	mpic = mpic_alloc(np, 0,
+	struct mpic *mpic = mpic_alloc(NULL, 0,
 			MPIC_PRIMARY | MPIC_WANTS_RESET | MPIC_BIG_ENDIAN,
 			0, 256, " OpenPIC  ");
 	BUG_ON(mpic == NULL);
-	of_node_put(np);
-
 	mpic_init(mpic);
 
 	mpc85xx_cpm2_pic_init();
diff --git a/arch/powerpc/platforms/85xx/mpc8536_ds.c b/arch/powerpc/platforms/85xx/mpc8536_ds.c
index 5c20b28..07916d6 100644
--- a/arch/powerpc/platforms/85xx/mpc8536_ds.c
+++ b/arch/powerpc/platforms/85xx/mpc8536_ds.c
@@ -36,22 +36,11 @@
 
 void __init mpc8536_ds_pic_init(void)
 {
-	struct mpic *mpic;
-	struct device_node *np;
-
-	np = of_find_node_by_type(NULL, "open-pic");
-	if (np == NULL) {
-		printk(KERN_ERR "Could not find open-pic node\n");
-		return;
-	}
-
-	mpic = mpic_alloc(np, 0,
+	struct mpic *mpic = mpic_alloc(NULL, 0,
 			  MPIC_PRIMARY | MPIC_WANTS_RESET |
 			  MPIC_BIG_ENDIAN | MPIC_BROKEN_FRR_NIRQS,
 			0, 256, " OpenPIC  ");
 	BUG_ON(mpic == NULL);
-	of_node_put(np);
-
 	mpic_init(mpic);
 }
 
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ads.c b/arch/powerpc/platforms/85xx/mpc85xx_ads.c
index 4c1e9b6..17c6f06 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ads.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ads.c
@@ -50,21 +50,10 @@ static int mpc85xx_exclude_device(struct pci_controller *hose,
 
 static void __init mpc85xx_ads_pic_init(void)
 {
-	struct mpic *mpic;
-	struct device_node *np = NULL;
-
-	np = of_find_node_by_type(np, "open-pic");
-	if (!np) {
-		printk(KERN_ERR "Could not find open-pic node\n");
-		return;
-	}
-
-	mpic = mpic_alloc(np, 0,
+	struct mpic *mpic = mpic_alloc(NULL, 0,
 			MPIC_PRIMARY | MPIC_WANTS_RESET | MPIC_BIG_ENDIAN,
 			0, 256, " OpenPIC  ");
 	BUG_ON(mpic == NULL);
-	of_node_put(np);
-
 	mpic_init(mpic);
 
 	mpc85xx_cpm2_pic_init();
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_cds.c b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
index 62b90c3..cf209b3 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_cds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
@@ -188,23 +188,10 @@ static struct irqaction mpc85xxcds_8259_irqaction = {
 static void __init mpc85xx_cds_pic_init(void)
 {
 	struct mpic *mpic;
-	struct device_node *np = NULL;
-
-	np = of_find_node_by_type(np, "open-pic");
-
-	if (np == NULL) {
-		printk(KERN_ERR "Could not find open-pic node\n");
-		return;
-	}
-
-	mpic = mpic_alloc(np, 0,
+	mpic = mpic_alloc(NULL, 0,
 			MPIC_PRIMARY | MPIC_WANTS_RESET | MPIC_BIG_ENDIAN,
 			0, 256, " OpenPIC  ");
 	BUG_ON(mpic == NULL);
-
-	/* Return the mpic node */
-	of_node_put(np);
-
 	mpic_init(mpic);
 }
 
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ds.c b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
index 4fc6b80..104a09b 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
@@ -63,27 +63,21 @@ static void mpc85xx_8259_cascade(unsigned int irq, struct irq_desc *desc)
 void __init mpc85xx_ds_pic_init(void)
 {
 	struct mpic *mpic;
-	struct device_node *np;
 #ifdef CONFIG_PPC_I8259
+	struct device_node *np;
 	struct device_node *cascade_node = NULL;
 	int cascade_irq;
 #endif
 	unsigned long root = of_get_flat_dt_root();
 
-	np = of_find_node_by_type(NULL, "open-pic");
-	if (np == NULL) {
-		printk(KERN_ERR "Could not find open-pic node\n");
-		return;
-	}
-
 	if (of_flat_dt_is_compatible(root, "fsl,MPC8572DS-CAMP")) {
-		mpic = mpic_alloc(np, 0,
+		mpic = mpic_alloc(NULL, 0,
 			MPIC_PRIMARY |
 			MPIC_BIG_ENDIAN | MPIC_BROKEN_FRR_NIRQS |
 			MPIC_SINGLE_DEST_CPU,
 			0, 256, " OpenPIC  ");
 	} else {
-		mpic = mpic_alloc(np, 0,
+		mpic = mpic_alloc(NULL, 0,
 			  MPIC_PRIMARY | MPIC_WANTS_RESET |
 			  MPIC_BIG_ENDIAN | MPIC_BROKEN_FRR_NIRQS |
 			  MPIC_SINGLE_DEST_CPU,
@@ -91,8 +85,6 @@ void __init mpc85xx_ds_pic_init(void)
 	}
 
 	BUG_ON(mpic == NULL);
-	of_node_put(np);
-
 	mpic_init(mpic);
 
 #ifdef CONFIG_PPC_I8259
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_mds.c b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
index 74b6da2..4e5431a 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_mds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
@@ -434,19 +434,11 @@ machine_arch_initcall(p1021_mds, swiotlb_setup_bus_notifier);
 
 static void __init mpc85xx_mds_pic_init(void)
 {
-	struct mpic *mpic;
-	struct device_node *np = NULL;
-
-	np = of_find_node_by_type(NULL, "open-pic");
-	if (!np)
-		return;
-
-	mpic = mpic_alloc(np, 0,
+	struct mpic *mpic = mpic_alloc(NULL, 0,
 			MPIC_PRIMARY | MPIC_WANTS_RESET | MPIC_BIG_ENDIAN |
 			MPIC_BROKEN_FRR_NIRQS | MPIC_SINGLE_DEST_CPU,
 			0, 256, " OpenPIC  ");
 	BUG_ON(mpic == NULL);
-	of_node_put(np);
 
 	mpic_init(mpic);
 	mpc85xx_mds_qeic_init();
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
index 2b299eb..a68d922 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
@@ -45,23 +45,16 @@
 void __init mpc85xx_rdb_pic_init(void)
 {
 	struct mpic *mpic;
-	struct device_node *np;
 	unsigned long root = of_get_flat_dt_root();
 
-	np = of_find_node_by_type(NULL, "open-pic");
-	if (np == NULL) {
-		printk(KERN_ERR "Could not find open-pic node\n");
-		return;
-	}
-
 	if (of_flat_dt_is_compatible(root, "fsl,MPC85XXRDB-CAMP")) {
-		mpic = mpic_alloc(np, 0,
+		mpic = mpic_alloc(NULL, 0,
 			MPIC_PRIMARY |
 			MPIC_BIG_ENDIAN | MPIC_BROKEN_FRR_NIRQS |
 			MPIC_SINGLE_DEST_CPU,
 			0, 256, " OpenPIC  ");
 	} else {
-		mpic = mpic_alloc(np, 0,
+		mpic = mpic_alloc(NULL, 0,
 		  MPIC_PRIMARY | MPIC_WANTS_RESET |
 		  MPIC_BIG_ENDIAN | MPIC_BROKEN_FRR_NIRQS |
 		  MPIC_SINGLE_DEST_CPU,
@@ -69,10 +62,7 @@ void __init mpc85xx_rdb_pic_init(void)
 	}
 
 	BUG_ON(mpic == NULL);
-	of_node_put(np);
-
 	mpic_init(mpic);
-
 }
 
 /*
diff --git a/arch/powerpc/platforms/85xx/p1010rdb.c b/arch/powerpc/platforms/85xx/p1010rdb.c
index dff49e8..25f7375 100644
--- a/arch/powerpc/platforms/85xx/p1010rdb.c
+++ b/arch/powerpc/platforms/85xx/p1010rdb.c
@@ -32,16 +32,8 @@
 
 void __init p1010_rdb_pic_init(void)
 {
-	struct mpic *mpic;
-	struct device_node *np;
-
-	np = of_find_node_by_type(NULL, "open-pic");
-	if (np == NULL) {
-		printk(KERN_ERR "Could not find open-pic node\n");
-		return;
-	}
-
-	mpic = mpic_alloc(np, 0, MPIC_PRIMARY | MPIC_WANTS_RESET |
+	struct mpic *mpic = mpic_alloc(NULL, 0,
+	  MPIC_PRIMARY | MPIC_WANTS_RESET |
 	  MPIC_BIG_ENDIAN | MPIC_BROKEN_FRR_NIRQS | MPIC_SINGLE_DEST_CPU,
 	  0, 256, " OpenPIC  ");
 
diff --git a/arch/powerpc/platforms/85xx/p1022_ds.c b/arch/powerpc/platforms/85xx/p1022_ds.c
index 6d684c2..6af5502 100644
--- a/arch/powerpc/platforms/85xx/p1022_ds.c
+++ b/arch/powerpc/platforms/85xx/p1022_ds.c
@@ -241,24 +241,12 @@ p1022ds_valid_monitor_port(enum fsl_diu_monitor_port port)
 
 void __init p1022_ds_pic_init(void)
 {
-	struct mpic *mpic;
-	struct device_node *np;
-
-	np = of_find_node_by_type(NULL, "open-pic");
-	if (!np) {
-		pr_err("Could not find open-pic node\n");
-		return;
-	}
-
-	mpic = mpic_alloc(np, 0,
+	struct mpic *mpic = mpic_alloc(NULL, 0,
 		MPIC_PRIMARY | MPIC_WANTS_RESET |
 		MPIC_BIG_ENDIAN | MPIC_BROKEN_FRR_NIRQS |
 		MPIC_SINGLE_DEST_CPU,
 		0, 256, " OpenPIC  ");
-
 	BUG_ON(mpic == NULL);
-	of_node_put(np);
-
 	mpic_init(mpic);
 }
 
diff --git a/arch/powerpc/platforms/85xx/p1023_rds.c b/arch/powerpc/platforms/85xx/p1023_rds.c
index df7ccf6..b3c78fe 100644
--- a/arch/powerpc/platforms/85xx/p1023_rds.c
+++ b/arch/powerpc/platforms/85xx/p1023_rds.c
@@ -93,16 +93,7 @@ machine_device_initcall(p1023_rds, mpc85xx_common_publish_devices);
 
 static void __init mpc85xx_rds_pic_init(void)
 {
-	struct mpic *mpic;
-	struct device_node *np = NULL;
-
-	np = of_find_node_by_type(NULL, "open-pic");
-	if (!np) {
-		printk(KERN_ERR "Could not find open-pic node\n");
-		return;
-	}
-
-	mpic = mpic_alloc(np, 0,
+	struct mpic *mpic = mpic_alloc(NULL, 0,
 		MPIC_PRIMARY | MPIC_WANTS_RESET | MPIC_BIG_ENDIAN |
 		MPIC_BROKEN_FRR_NIRQS | MPIC_SINGLE_DEST_CPU,
 		0, 256, " OpenPIC  ");
diff --git a/arch/powerpc/platforms/85xx/sbc8548.c b/arch/powerpc/platforms/85xx/sbc8548.c
index 5e16025..38d6945 100644
--- a/arch/powerpc/platforms/85xx/sbc8548.c
+++ b/arch/powerpc/platforms/85xx/sbc8548.c
@@ -54,24 +54,10 @@ static int sbc_rev;
 
 static void __init sbc8548_pic_init(void)
 {
-	struct mpic *mpic;
-	struct device_node *np = NULL;
-
-	np = of_find_node_by_type(np, "open-pic");
-
-	if (np == NULL) {
-		printk(KERN_ERR "Could not find open-pic node\n");
-		return;
-	}
-
-	mpic = mpic_alloc(np, 0,
+	struct mpic *mpic = mpic_alloc(NULL, 0,
 			MPIC_PRIMARY | MPIC_WANTS_RESET | MPIC_BIG_ENDIAN,
 			0, 256, " OpenPIC  ");
 	BUG_ON(mpic == NULL);
-
-	/* Return the mpic node */
-	of_node_put(np);
-
 	mpic_init(mpic);
 }
 
diff --git a/arch/powerpc/platforms/85xx/sbc8560.c b/arch/powerpc/platforms/85xx/sbc8560.c
index 97f00de..7e6d7e5 100644
--- a/arch/powerpc/platforms/85xx/sbc8560.c
+++ b/arch/powerpc/platforms/85xx/sbc8560.c
@@ -41,21 +41,10 @@
 
 static void __init sbc8560_pic_init(void)
 {
-	struct mpic *mpic;
-	struct device_node *np = NULL;
-
-	np = of_find_node_by_type(np, "open-pic");
-	if (!np) {
-		printk(KERN_ERR "Could not find open-pic node\n");
-		return;
-	}
-
-	mpic = mpic_alloc(np, 0,
+	struct mpic *mpic = mpic_alloc(NULL, 0,
 			MPIC_PRIMARY | MPIC_WANTS_RESET | MPIC_BIG_ENDIAN,
 			0, 256, " OpenPIC  ");
 	BUG_ON(mpic == NULL);
-	of_node_put(np);
-
 	mpic_init(mpic);
 
 	mpc85xx_cpm2_pic_init();
diff --git a/arch/powerpc/platforms/85xx/socrates.c b/arch/powerpc/platforms/85xx/socrates.c
index e87e75c..8175f0a 100644
--- a/arch/powerpc/platforms/85xx/socrates.c
+++ b/arch/powerpc/platforms/85xx/socrates.c
@@ -46,21 +46,12 @@
 
 static void __init socrates_pic_init(void)
 {
-	struct mpic *mpic;
 	struct device_node *np;
 
-	np = of_find_node_by_type(NULL, "open-pic");
-	if (!np) {
-		printk(KERN_ERR "Could not find open-pic node\n");
-		return;
-	}
-
-	mpic = mpic_alloc(np, 0,
+	struct mpic *mpic = mpic_alloc(NULL, 0,
 			MPIC_PRIMARY | MPIC_WANTS_RESET | MPIC_BIG_ENDIAN,
 			0, 256, " OpenPIC  ");
 	BUG_ON(mpic == NULL);
-	of_node_put(np);
-
 	mpic_init(mpic);
 
 	np = of_find_compatible_node(NULL, NULL, "abb,socrates-fpga-pic");
diff --git a/arch/powerpc/platforms/85xx/stx_gp3.c b/arch/powerpc/platforms/85xx/stx_gp3.c
index 060d514..8ca1e61 100644
--- a/arch/powerpc/platforms/85xx/stx_gp3.c
+++ b/arch/powerpc/platforms/85xx/stx_gp3.c
@@ -48,21 +48,10 @@
 
 static void __init stx_gp3_pic_init(void)
 {
-	struct mpic *mpic;
-	struct device_node *np;
-
-	np = of_find_node_by_type(NULL, "open-pic");
-	if (!np) {
-		printk(KERN_ERR "Could not find open-pic node\n");
-		return;
-	}
-
-	mpic = mpic_alloc(np, 0,
+	struct mpic *mpic = mpic_alloc(NULL, 0,
 			MPIC_PRIMARY | MPIC_WANTS_RESET | MPIC_BIG_ENDIAN,
 			0, 256, " OpenPIC  ");
 	BUG_ON(mpic == NULL);
-	of_node_put(np);
-
 	mpic_init(mpic);
 
 	mpc85xx_cpm2_pic_init();
diff --git a/arch/powerpc/platforms/85xx/tqm85xx.c b/arch/powerpc/platforms/85xx/tqm85xx.c
index a46b9fc..6e7a835 100644
--- a/arch/powerpc/platforms/85xx/tqm85xx.c
+++ b/arch/powerpc/platforms/85xx/tqm85xx.c
@@ -46,21 +46,10 @@
 
 static void __init tqm85xx_pic_init(void)
 {
-	struct mpic *mpic;
-	struct device_node *np;
-
-	np = of_find_node_by_type(NULL, "open-pic");
-	if (!np) {
-		printk(KERN_ERR "Could not find open-pic node\n");
-		return;
-	}
-
-	mpic = mpic_alloc(np, 0,
+	struct mpic *mpic = mpic_alloc(NULL, 0,
 			MPIC_PRIMARY | MPIC_WANTS_RESET | MPIC_BIG_ENDIAN,
 			0, 256, " OpenPIC  ");
 	BUG_ON(mpic == NULL);
-	of_node_put(np);
-
 	mpic_init(mpic);
 
 	mpc85xx_cpm2_pic_init();
diff --git a/arch/powerpc/platforms/85xx/xes_mpc85xx.c b/arch/powerpc/platforms/85xx/xes_mpc85xx.c
index 2be5e4d..f94c608 100644
--- a/arch/powerpc/platforms/85xx/xes_mpc85xx.c
+++ b/arch/powerpc/platforms/85xx/xes_mpc85xx.c
@@ -43,22 +43,11 @@
 
 void __init xes_mpc85xx_pic_init(void)
 {
-	struct mpic *mpic;
-	struct device_node *np;
-
-	np = of_find_node_by_type(NULL, "open-pic");
-	if (np == NULL) {
-		printk(KERN_ERR "Could not find open-pic node\n");
-		return;
-	}
-
-	mpic = mpic_alloc(np, 0,
+	struct mpic *mpic = mpic_alloc(NULL, 0,
 			  MPIC_PRIMARY | MPIC_WANTS_RESET |
 			  MPIC_BIG_ENDIAN | MPIC_BROKEN_FRR_NIRQS,
 			0, 256, " OpenPIC  ");
 	BUG_ON(mpic == NULL);
-	of_node_put(np);
-
 	mpic_init(mpic);
 }
 
diff --git a/arch/powerpc/platforms/86xx/pic.c b/arch/powerpc/platforms/86xx/pic.c
index f85c8f0..ed85b3c 100644
--- a/arch/powerpc/platforms/86xx/pic.c
+++ b/arch/powerpc/platforms/86xx/pic.c
@@ -31,24 +31,17 @@ static void mpc86xx_8259_cascade(unsigned int irq, struct irq_desc *desc)
 
 void __init mpc86xx_init_irq(void)
 {
-	struct mpic *mpic;
-	struct device_node *np;
 #ifdef CONFIG_PPC_I8259
+	struct device_node *np;
 	struct device_node *cascade_node = NULL;
 	int cascade_irq;
 #endif
 
-	/* Determine PIC address. */
-	np = of_find_node_by_type(NULL, "open-pic");
-	if (np == NULL)
-		return;
-
-	mpic = mpic_alloc(np, 0,
+	struct mpic *mpic = mpic_alloc(NULL, 0,
 			MPIC_PRIMARY | MPIC_WANTS_RESET |
 			MPIC_BIG_ENDIAN | MPIC_BROKEN_FRR_NIRQS |
 			MPIC_SINGLE_DEST_CPU,
 			0, 256, " MPIC     ");
-	of_node_put(np);
 	BUG_ON(mpic == NULL);
 
 	mpic_init(mpic);
diff --git a/arch/powerpc/platforms/embedded6xx/holly.c b/arch/powerpc/platforms/embedded6xx/holly.c
index d4fb41e..5ed00a7 100644
--- a/arch/powerpc/platforms/embedded6xx/holly.c
+++ b/arch/powerpc/platforms/embedded6xx/holly.c
@@ -148,20 +148,13 @@ static void __init holly_setup_arch(void)
 static void __init holly_init_IRQ(void)
 {
 	struct mpic *mpic;
-	struct device_node *tsi_pic;
 #ifdef CONFIG_PCI
 	unsigned int cascade_pci_irq;
 	struct device_node *tsi_pci;
 	struct device_node *cascade_node = NULL;
 #endif
 
-	tsi_pic = of_find_node_by_type(NULL, "open-pic");
-	if (!tsi_pic) {
-		printk(KERN_ERR "%s: No tsi108 PIC found !\n", __func__);
-		return;
-	}
-
-	mpic = mpic_alloc(tsi_pic, 0,
+	mpic = mpic_alloc(NULL, 0,
 			MPIC_PRIMARY | MPIC_BIG_ENDIAN | MPIC_WANTS_RESET |
 			MPIC_SPV_EOI | MPIC_NO_PTHROU_DIS | MPIC_REGSET_TSI108,
 			24,
@@ -195,7 +188,6 @@ static void __init holly_init_IRQ(void)
 #endif
 	/* Configure MPIC outputs to CPU0 */
 	tsi108_write_reg(TSI108_MPIC_OFFSET + 0x30c, 0);
-	of_node_put(tsi_pic);
 }
 
 void holly_show_cpuinfo(struct seq_file *m)
diff --git a/arch/powerpc/platforms/embedded6xx/linkstation.c b/arch/powerpc/platforms/embedded6xx/linkstation.c
index 72b3685..502ff60 100644
--- a/arch/powerpc/platforms/embedded6xx/linkstation.c
+++ b/arch/powerpc/platforms/embedded6xx/linkstation.c
@@ -81,13 +81,9 @@ static void __init linkstation_setup_arch(void)
 static void __init linkstation_init_IRQ(void)
 {
 	struct mpic *mpic;
-	struct device_node *dnp;
 
-	dnp = of_find_node_by_type(NULL, "open-pic");
-	if (dnp == NULL)
-		return;
-
-	mpic = mpic_alloc(dnp, 0, MPIC_PRIMARY | MPIC_WANTS_RESET, 4, 32, " EPIC     ");
+	mpic = mpic_alloc(NULL, 0, MPIC_PRIMARY | MPIC_WANTS_RESET,
+			4, 32, " EPIC     ");
 	BUG_ON(mpic == NULL);
 
 	/* PCI IRQs */
diff --git a/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c b/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c
index c8ce204..e0f1127 100644
--- a/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c
+++ b/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c
@@ -102,20 +102,13 @@ static void __init mpc7448_hpc2_setup_arch(void)
 static void __init mpc7448_hpc2_init_IRQ(void)
 {
 	struct mpic *mpic;
-	struct device_node *tsi_pic;
 #ifdef CONFIG_PCI
 	unsigned int cascade_pci_irq;
 	struct device_node *tsi_pci;
 	struct device_node *cascade_node = NULL;
 #endif
 
-	tsi_pic = of_find_node_by_type(NULL, "open-pic");
-	if (!tsi_pic) {
-		printk("%s: No tsi108 PIC found !\n", __func__);
-		return;
-	}
-
-	mpic = mpic_alloc(tsi_pic, 0,
+	mpic = mpic_alloc(NULL, 0,
 			MPIC_PRIMARY | MPIC_BIG_ENDIAN | MPIC_WANTS_RESET |
 			MPIC_SPV_EOI | MPIC_NO_PTHROU_DIS | MPIC_REGSET_TSI108,
 			24,
@@ -149,7 +142,6 @@ static void __init mpc7448_hpc2_init_IRQ(void)
 #endif
 	/* Configure MPIC outputs to CPU0 */
 	tsi108_write_reg(TSI108_MPIC_OFFSET + 0x30c, 0);
-	of_node_put(tsi_pic);
 }
 
 void mpc7448_hpc2_show_cpuinfo(struct seq_file *m)
diff --git a/arch/powerpc/platforms/embedded6xx/storcenter.c b/arch/powerpc/platforms/embedded6xx/storcenter.c
index 084f0fc..9bd15df 100644
--- a/arch/powerpc/platforms/embedded6xx/storcenter.c
+++ b/arch/powerpc/platforms/embedded6xx/storcenter.c
@@ -83,17 +83,9 @@ static void __init storcenter_setup_arch(void)
 static void __init storcenter_init_IRQ(void)
 {
 	struct mpic *mpic;
-	struct device_node *dnp;
 
-	dnp = of_find_node_by_type(NULL, "open-pic");
-	if (dnp == NULL)
-		return;
-
-	mpic = mpic_alloc(dnp, 0, MPIC_PRIMARY | MPIC_WANTS_RESET,
+	mpic = mpic_alloc(NULL, 0, MPIC_PRIMARY | MPIC_WANTS_RESET,
 			16, 32, " OpenPIC  ");
-
-	of_node_put(dnp);
-
 	BUG_ON(mpic == NULL);
 
 	/*
diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index ef721c3..bb72a62 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -1143,8 +1143,24 @@ struct mpic * __init mpic_alloc(struct device_node *node,
 	const char *vers;
 	const u32 *psrc;
 
-	/* This code assumes that a non-NULL device node is passed in */
-	BUG_ON(!node);
+	/* Default MPIC search parameters */
+	static const struct of_device_id __initconst mpic_device_id[] = {
+		{ .type	      = "open-pic", },
+		{ .compatible = "open-pic", },
+		{},
+	};
+
+	/*
+	 * If we were not passed a device-tree node, then perform the default
+	 * search for standardized a standardized OpenPIC.
+	 */
+	if (node) {
+		node = of_node_get(node);
+	} else {
+		node = of_find_matching_node(NULL, mpic_device_id);
+		if (!node)
+			return NULL;
+	}
 
 	/* Pick the physical address from the device tree if unspecified */
 	if (!phys_addr) {
@@ -1154,14 +1170,14 @@ struct mpic * __init mpic_alloc(struct device_node *node,
 		} else {
 			struct resource r;
 			if (of_address_to_resource(node, 0, &r))
-				return NULL;
+				goto err_of_node_put;
 			phys_addr = r.start;
 		}
 	}
 
 	mpic = kzalloc(sizeof(struct mpic), GFP_KERNEL);
 	if (mpic == NULL)
-		return NULL;
+		goto err_of_node_put;
 
 	mpic->name = name;
 	mpic->paddr = phys_addr;
@@ -1325,6 +1341,11 @@ struct mpic * __init mpic_alloc(struct device_node *node,
 				       isu_size ? isu_size : mpic->num_sources,
 				       &mpic_host_ops,
 				       flags & MPIC_LARGE_VECTORS ? 2048 : 256);
+
+	/*
+	 * FIXME: The code leaks the MPIC object and mappings here; this
+	 * is very unlikely to fail but it ought to be fixed anyways.
+	 */
 	if (mpic->irqhost == NULL)
 		return NULL;
 
@@ -1359,7 +1380,12 @@ struct mpic * __init mpic_alloc(struct device_node *node,
 		irq_set_default_host(mpic->irqhost);
 	}
 
+	of_node_put(node);
 	return mpic;
+
+err_of_node_put:
+	of_node_put(node);
+	return NULL;
 }
 
 void __init mpic_assign_isu(struct mpic *mpic, unsigned int isu_num,
-- 
1.7.2.5
