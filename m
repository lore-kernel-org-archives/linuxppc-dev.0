Return-Path: <Kyle.D.Moffett@boeing.com>
Received: from border.exmeritus.com (border.exmeritus.com
 [IPv6:2002:46a7:f11a:ffff::])
 by ozlabs.org (Postfix) with ESMTP id A4532100AF7
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Dec 2011 03:29:11 +1100 (EST)
From: Kyle Moffett <Kyle.D.Moffett@boeing.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH v3 02/10] powerpc: Consolidate mpic_alloc() OF address
 translation
Date: Fri,  2 Dec 2011 11:27:59 -0500
Message-Id: <1322843287-2745-3-git-send-email-Kyle.D.Moffett@boeing.com>
In-Reply-To: <1322795058.3729.48.camel@pasglop>
References: <1322795058.3729.48.camel@pasglop>
Cc: Michael Ellerman <michaele@au1.ibm.com>, Paul Mackerras <paulus@samba.org>,
 Kyle Moffett <Kyle.D.Moffett@boeing.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Instead of using the open-coded "reg" property lookup and address
translation in mpic_alloc(), directly call of_address_to_resource().
This includes various workarounds for special cases which the naive
of_address_translate() does not.

Afterwards it is possible to remove the copiously copy-pasted calls to
of_address_translate() from the 85xx/86xx/powermac platforms.

Signed-off-by: Kyle Moffett <Kyle.D.Moffett@boeing.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/platforms/85xx/corenet_ds.c  |    9 +----
 arch/powerpc/platforms/85xx/ksi8560.c     |    9 +----
 arch/powerpc/platforms/85xx/mpc8536_ds.c  |    9 +----
 arch/powerpc/platforms/85xx/mpc85xx_ads.c |    9 +----
 arch/powerpc/platforms/85xx/mpc85xx_cds.c |    9 +----
 arch/powerpc/platforms/85xx/mpc85xx_ds.c  |   11 +----
 arch/powerpc/platforms/85xx/mpc85xx_mds.c |    9 +----
 arch/powerpc/platforms/85xx/mpc85xx_rdb.c |   11 +----
 arch/powerpc/platforms/85xx/p1010rdb.c    |    9 +----
 arch/powerpc/platforms/85xx/p1022_ds.c    |    9 +----
 arch/powerpc/platforms/85xx/p1023_rds.c   |    9 +----
 arch/powerpc/platforms/85xx/sbc8548.c     |    9 +----
 arch/powerpc/platforms/85xx/sbc8560.c     |    9 +----
 arch/powerpc/platforms/85xx/socrates.c    |    9 +----
 arch/powerpc/platforms/85xx/stx_gp3.c     |    9 +----
 arch/powerpc/platforms/85xx/tqm85xx.c     |    9 +----
 arch/powerpc/platforms/85xx/xes_mpc85xx.c |    9 +----
 arch/powerpc/platforms/86xx/pic.c         |    4 +-
 arch/powerpc/platforms/powermac/pic.c     |    8 +---
 arch/powerpc/sysdev/mpic.c                |   61 ++++++++++++++++-------------
 20 files changed, 55 insertions(+), 175 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/corenet_ds.c b/arch/powerpc/platforms/85xx/corenet_ds.c
index 3052821..5b1c577 100644
--- a/arch/powerpc/platforms/85xx/corenet_ds.c
+++ b/arch/powerpc/platforms/85xx/corenet_ds.c
@@ -36,7 +36,6 @@
 void __init corenet_ds_pic_init(void)
 {
 	struct mpic *mpic;
-	struct resource r;
 	struct device_node *np = NULL;
 	unsigned int flags = MPIC_PRIMARY | MPIC_BIG_ENDIAN |
 				MPIC_BROKEN_FRR_NIRQS | MPIC_SINGLE_DEST_CPU;
@@ -48,16 +47,10 @@ void __init corenet_ds_pic_init(void)
 		return;
 	}
 
-	if (of_address_to_resource(np, 0, &r)) {
-		printk(KERN_ERR "Failed to map mpic register space\n");
-		of_node_put(np);
-		return;
-	}
-
 	if (ppc_md.get_irq == mpic_get_coreint_irq)
 		flags |= MPIC_ENABLE_COREINT;
 
-	mpic = mpic_alloc(np, r.start, flags, 0, 256, " OpenPIC  ");
+	mpic = mpic_alloc(np, 0, flags, 0, 256, " OpenPIC  ");
 	BUG_ON(mpic == NULL);
 
 	mpic_init(mpic);
diff --git a/arch/powerpc/platforms/85xx/ksi8560.c b/arch/powerpc/platforms/85xx/ksi8560.c
index 0f3e688..3403b0e 100644
--- a/arch/powerpc/platforms/85xx/ksi8560.c
+++ b/arch/powerpc/platforms/85xx/ksi8560.c
@@ -58,7 +58,6 @@ static void machine_restart(char *cmd)
 static void __init ksi8560_pic_init(void)
 {
 	struct mpic *mpic;
-	struct resource r;
 	struct device_node *np;
 
 	np = of_find_node_by_type(NULL, "open-pic");
@@ -68,13 +67,7 @@ static void __init ksi8560_pic_init(void)
 		return;
 	}
 
-	if (of_address_to_resource(np, 0, &r)) {
-		printk(KERN_ERR "Could not map mpic register space\n");
-		of_node_put(np);
-		return;
-	}
-
-	mpic = mpic_alloc(np, r.start,
+	mpic = mpic_alloc(np, 0,
 			MPIC_PRIMARY | MPIC_WANTS_RESET | MPIC_BIG_ENDIAN,
 			0, 256, " OpenPIC  ");
 	BUG_ON(mpic == NULL);
diff --git a/arch/powerpc/platforms/85xx/mpc8536_ds.c b/arch/powerpc/platforms/85xx/mpc8536_ds.c
index 9ee6455..5c20b28 100644
--- a/arch/powerpc/platforms/85xx/mpc8536_ds.c
+++ b/arch/powerpc/platforms/85xx/mpc8536_ds.c
@@ -37,7 +37,6 @@
 void __init mpc8536_ds_pic_init(void)
 {
 	struct mpic *mpic;
-	struct resource r;
 	struct device_node *np;
 
 	np = of_find_node_by_type(NULL, "open-pic");
@@ -46,13 +45,7 @@ void __init mpc8536_ds_pic_init(void)
 		return;
 	}
 
-	if (of_address_to_resource(np, 0, &r)) {
-		printk(KERN_ERR "Failed to map mpic register space\n");
-		of_node_put(np);
-		return;
-	}
-
-	mpic = mpic_alloc(np, r.start,
+	mpic = mpic_alloc(np, 0,
 			  MPIC_PRIMARY | MPIC_WANTS_RESET |
 			  MPIC_BIG_ENDIAN | MPIC_BROKEN_FRR_NIRQS,
 			0, 256, " OpenPIC  ");
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ads.c b/arch/powerpc/platforms/85xx/mpc85xx_ads.c
index 986554b..4c1e9b6 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ads.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ads.c
@@ -51,7 +51,6 @@ static int mpc85xx_exclude_device(struct pci_controller *hose,
 static void __init mpc85xx_ads_pic_init(void)
 {
 	struct mpic *mpic;
-	struct resource r;
 	struct device_node *np = NULL;
 
 	np = of_find_node_by_type(np, "open-pic");
@@ -60,13 +59,7 @@ static void __init mpc85xx_ads_pic_init(void)
 		return;
 	}
 
-	if (of_address_to_resource(np, 0, &r)) {
-		printk(KERN_ERR "Could not map mpic register space\n");
-		of_node_put(np);
-		return;
-	}
-
-	mpic = mpic_alloc(np, r.start,
+	mpic = mpic_alloc(np, 0,
 			MPIC_PRIMARY | MPIC_WANTS_RESET | MPIC_BIG_ENDIAN,
 			0, 256, " OpenPIC  ");
 	BUG_ON(mpic == NULL);
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_cds.c b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
index d993b66..62b90c3 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_cds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
@@ -188,7 +188,6 @@ static struct irqaction mpc85xxcds_8259_irqaction = {
 static void __init mpc85xx_cds_pic_init(void)
 {
 	struct mpic *mpic;
-	struct resource r;
 	struct device_node *np = NULL;
 
 	np = of_find_node_by_type(np, "open-pic");
@@ -198,13 +197,7 @@ static void __init mpc85xx_cds_pic_init(void)
 		return;
 	}
 
-	if (of_address_to_resource(np, 0, &r)) {
-		printk(KERN_ERR "Failed to map mpic register space\n");
-		of_node_put(np);
-		return;
-	}
-
-	mpic = mpic_alloc(np, r.start,
+	mpic = mpic_alloc(np, 0,
 			MPIC_PRIMARY | MPIC_WANTS_RESET | MPIC_BIG_ENDIAN,
 			0, 256, " OpenPIC  ");
 	BUG_ON(mpic == NULL);
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ds.c b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
index 3f66631..4fc6b80 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
@@ -63,7 +63,6 @@ static void mpc85xx_8259_cascade(unsigned int irq, struct irq_desc *desc)
 void __init mpc85xx_ds_pic_init(void)
 {
 	struct mpic *mpic;
-	struct resource r;
 	struct device_node *np;
 #ifdef CONFIG_PPC_I8259
 	struct device_node *cascade_node = NULL;
@@ -77,20 +76,14 @@ void __init mpc85xx_ds_pic_init(void)
 		return;
 	}
 
-	if (of_address_to_resource(np, 0, &r)) {
-		printk(KERN_ERR "Failed to map mpic register space\n");
-		of_node_put(np);
-		return;
-	}
-
 	if (of_flat_dt_is_compatible(root, "fsl,MPC8572DS-CAMP")) {
-		mpic = mpic_alloc(np, r.start,
+		mpic = mpic_alloc(np, 0,
 			MPIC_PRIMARY |
 			MPIC_BIG_ENDIAN | MPIC_BROKEN_FRR_NIRQS |
 			MPIC_SINGLE_DEST_CPU,
 			0, 256, " OpenPIC  ");
 	} else {
-		mpic = mpic_alloc(np, r.start,
+		mpic = mpic_alloc(np, 0,
 			  MPIC_PRIMARY | MPIC_WANTS_RESET |
 			  MPIC_BIG_ENDIAN | MPIC_BROKEN_FRR_NIRQS |
 			  MPIC_SINGLE_DEST_CPU,
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_mds.c b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
index 813b5d3..74b6da2 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_mds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
@@ -435,20 +435,13 @@ machine_arch_initcall(p1021_mds, swiotlb_setup_bus_notifier);
 static void __init mpc85xx_mds_pic_init(void)
 {
 	struct mpic *mpic;
-	struct resource r;
 	struct device_node *np = NULL;
 
 	np = of_find_node_by_type(NULL, "open-pic");
 	if (!np)
 		return;
 
-	if (of_address_to_resource(np, 0, &r)) {
-		printk(KERN_ERR "Failed to map mpic register space\n");
-		of_node_put(np);
-		return;
-	}
-
-	mpic = mpic_alloc(np, r.start,
+	mpic = mpic_alloc(np, 0,
 			MPIC_PRIMARY | MPIC_WANTS_RESET | MPIC_BIG_ENDIAN |
 			MPIC_BROKEN_FRR_NIRQS | MPIC_SINGLE_DEST_CPU,
 			0, 256, " OpenPIC  ");
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
index b1ca429..2b299eb 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
@@ -45,7 +45,6 @@
 void __init mpc85xx_rdb_pic_init(void)
 {
 	struct mpic *mpic;
-	struct resource r;
 	struct device_node *np;
 	unsigned long root = of_get_flat_dt_root();
 
@@ -55,20 +54,14 @@ void __init mpc85xx_rdb_pic_init(void)
 		return;
 	}
 
-	if (of_address_to_resource(np, 0, &r)) {
-		printk(KERN_ERR "Failed to map mpic register space\n");
-		of_node_put(np);
-		return;
-	}
-
 	if (of_flat_dt_is_compatible(root, "fsl,MPC85XXRDB-CAMP")) {
-		mpic = mpic_alloc(np, r.start,
+		mpic = mpic_alloc(np, 0,
 			MPIC_PRIMARY |
 			MPIC_BIG_ENDIAN | MPIC_BROKEN_FRR_NIRQS |
 			MPIC_SINGLE_DEST_CPU,
 			0, 256, " OpenPIC  ");
 	} else {
-		mpic = mpic_alloc(np, r.start,
+		mpic = mpic_alloc(np, 0,
 		  MPIC_PRIMARY | MPIC_WANTS_RESET |
 		  MPIC_BIG_ENDIAN | MPIC_BROKEN_FRR_NIRQS |
 		  MPIC_SINGLE_DEST_CPU,
diff --git a/arch/powerpc/platforms/85xx/p1010rdb.c b/arch/powerpc/platforms/85xx/p1010rdb.c
index 2f479f8..dff49e8 100644
--- a/arch/powerpc/platforms/85xx/p1010rdb.c
+++ b/arch/powerpc/platforms/85xx/p1010rdb.c
@@ -33,7 +33,6 @@
 void __init p1010_rdb_pic_init(void)
 {
 	struct mpic *mpic;
-	struct resource r;
 	struct device_node *np;
 
 	np = of_find_node_by_type(NULL, "open-pic");
@@ -42,13 +41,7 @@ void __init p1010_rdb_pic_init(void)
 		return;
 	}
 
-	if (of_address_to_resource(np, 0, &r)) {
-		printk(KERN_ERR "Failed to map mpic register space\n");
-		of_node_put(np);
-		return;
-	}
-
-	mpic = mpic_alloc(np, r.start, MPIC_PRIMARY | MPIC_WANTS_RESET |
+	mpic = mpic_alloc(np, 0, MPIC_PRIMARY | MPIC_WANTS_RESET |
 	  MPIC_BIG_ENDIAN | MPIC_BROKEN_FRR_NIRQS | MPIC_SINGLE_DEST_CPU,
 	  0, 256, " OpenPIC  ");
 
diff --git a/arch/powerpc/platforms/85xx/p1022_ds.c b/arch/powerpc/platforms/85xx/p1022_ds.c
index 8d5c22b..6d684c2 100644
--- a/arch/powerpc/platforms/85xx/p1022_ds.c
+++ b/arch/powerpc/platforms/85xx/p1022_ds.c
@@ -242,7 +242,6 @@ p1022ds_valid_monitor_port(enum fsl_diu_monitor_port port)
 void __init p1022_ds_pic_init(void)
 {
 	struct mpic *mpic;
-	struct resource r;
 	struct device_node *np;
 
 	np = of_find_node_by_type(NULL, "open-pic");
@@ -251,13 +250,7 @@ void __init p1022_ds_pic_init(void)
 		return;
 	}
 
-	if (of_address_to_resource(np, 0, &r)) {
-		pr_err("Failed to map mpic register space\n");
-		of_node_put(np);
-		return;
-	}
-
-	mpic = mpic_alloc(np, r.start,
+	mpic = mpic_alloc(np, 0,
 		MPIC_PRIMARY | MPIC_WANTS_RESET |
 		MPIC_BIG_ENDIAN | MPIC_BROKEN_FRR_NIRQS |
 		MPIC_SINGLE_DEST_CPU,
diff --git a/arch/powerpc/platforms/85xx/p1023_rds.c b/arch/powerpc/platforms/85xx/p1023_rds.c
index 57c3e0f..df7ccf6 100644
--- a/arch/powerpc/platforms/85xx/p1023_rds.c
+++ b/arch/powerpc/platforms/85xx/p1023_rds.c
@@ -94,7 +94,6 @@ machine_device_initcall(p1023_rds, mpc85xx_common_publish_devices);
 static void __init mpc85xx_rds_pic_init(void)
 {
 	struct mpic *mpic;
-	struct resource r;
 	struct device_node *np = NULL;
 
 	np = of_find_node_by_type(NULL, "open-pic");
@@ -103,13 +102,7 @@ static void __init mpc85xx_rds_pic_init(void)
 		return;
 	}
 
-	if (of_address_to_resource(np, 0, &r)) {
-		printk(KERN_ERR "Failed to map mpic register space\n");
-		of_node_put(np);
-		return;
-	}
-
-	mpic = mpic_alloc(np, r.start,
+	mpic = mpic_alloc(np, 0,
 		MPIC_PRIMARY | MPIC_WANTS_RESET | MPIC_BIG_ENDIAN |
 		MPIC_BROKEN_FRR_NIRQS | MPIC_SINGLE_DEST_CPU,
 		0, 256, " OpenPIC  ");
diff --git a/arch/powerpc/platforms/85xx/sbc8548.c b/arch/powerpc/platforms/85xx/sbc8548.c
index 845ed3b..5e16025 100644
--- a/arch/powerpc/platforms/85xx/sbc8548.c
+++ b/arch/powerpc/platforms/85xx/sbc8548.c
@@ -55,7 +55,6 @@ static int sbc_rev;
 static void __init sbc8548_pic_init(void)
 {
 	struct mpic *mpic;
-	struct resource r;
 	struct device_node *np = NULL;
 
 	np = of_find_node_by_type(np, "open-pic");
@@ -65,13 +64,7 @@ static void __init sbc8548_pic_init(void)
 		return;
 	}
 
-	if (of_address_to_resource(np, 0, &r)) {
-		printk(KERN_ERR "Failed to map mpic register space\n");
-		of_node_put(np);
-		return;
-	}
-
-	mpic = mpic_alloc(np, r.start,
+	mpic = mpic_alloc(np, 0,
 			MPIC_PRIMARY | MPIC_WANTS_RESET | MPIC_BIG_ENDIAN,
 			0, 256, " OpenPIC  ");
 	BUG_ON(mpic == NULL);
diff --git a/arch/powerpc/platforms/85xx/sbc8560.c b/arch/powerpc/platforms/85xx/sbc8560.c
index e9a7ed2..97f00de 100644
--- a/arch/powerpc/platforms/85xx/sbc8560.c
+++ b/arch/powerpc/platforms/85xx/sbc8560.c
@@ -42,7 +42,6 @@
 static void __init sbc8560_pic_init(void)
 {
 	struct mpic *mpic;
-	struct resource r;
 	struct device_node *np = NULL;
 
 	np = of_find_node_by_type(np, "open-pic");
@@ -51,13 +50,7 @@ static void __init sbc8560_pic_init(void)
 		return;
 	}
 
-	if (of_address_to_resource(np, 0, &r)) {
-		printk(KERN_ERR "Could not map mpic register space\n");
-		of_node_put(np);
-		return;
-	}
-
-	mpic = mpic_alloc(np, r.start,
+	mpic = mpic_alloc(np, 0,
 			MPIC_PRIMARY | MPIC_WANTS_RESET | MPIC_BIG_ENDIAN,
 			0, 256, " OpenPIC  ");
 	BUG_ON(mpic == NULL);
diff --git a/arch/powerpc/platforms/85xx/socrates.c b/arch/powerpc/platforms/85xx/socrates.c
index fec496a..e87e75c 100644
--- a/arch/powerpc/platforms/85xx/socrates.c
+++ b/arch/powerpc/platforms/85xx/socrates.c
@@ -47,7 +47,6 @@
 static void __init socrates_pic_init(void)
 {
 	struct mpic *mpic;
-	struct resource r;
 	struct device_node *np;
 
 	np = of_find_node_by_type(NULL, "open-pic");
@@ -56,13 +55,7 @@ static void __init socrates_pic_init(void)
 		return;
 	}
 
-	if (of_address_to_resource(np, 0, &r)) {
-		printk(KERN_ERR "Could not map mpic register space\n");
-		of_node_put(np);
-		return;
-	}
-
-	mpic = mpic_alloc(np, r.start,
+	mpic = mpic_alloc(np, 0,
 			MPIC_PRIMARY | MPIC_WANTS_RESET | MPIC_BIG_ENDIAN,
 			0, 256, " OpenPIC  ");
 	BUG_ON(mpic == NULL);
diff --git a/arch/powerpc/platforms/85xx/stx_gp3.c b/arch/powerpc/platforms/85xx/stx_gp3.c
index b44c936..060d514 100644
--- a/arch/powerpc/platforms/85xx/stx_gp3.c
+++ b/arch/powerpc/platforms/85xx/stx_gp3.c
@@ -49,7 +49,6 @@
 static void __init stx_gp3_pic_init(void)
 {
 	struct mpic *mpic;
-	struct resource r;
 	struct device_node *np;
 
 	np = of_find_node_by_type(NULL, "open-pic");
@@ -58,13 +57,7 @@ static void __init stx_gp3_pic_init(void)
 		return;
 	}
 
-	if (of_address_to_resource(np, 0, &r)) {
-		printk(KERN_ERR "Could not map mpic register space\n");
-		of_node_put(np);
-		return;
-	}
-
-	mpic = mpic_alloc(np, r.start,
+	mpic = mpic_alloc(np, 0,
 			MPIC_PRIMARY | MPIC_WANTS_RESET | MPIC_BIG_ENDIAN,
 			0, 256, " OpenPIC  ");
 	BUG_ON(mpic == NULL);
diff --git a/arch/powerpc/platforms/85xx/tqm85xx.c b/arch/powerpc/platforms/85xx/tqm85xx.c
index 2418bf8..a46b9fc 100644
--- a/arch/powerpc/platforms/85xx/tqm85xx.c
+++ b/arch/powerpc/platforms/85xx/tqm85xx.c
@@ -47,7 +47,6 @@
 static void __init tqm85xx_pic_init(void)
 {
 	struct mpic *mpic;
-	struct resource r;
 	struct device_node *np;
 
 	np = of_find_node_by_type(NULL, "open-pic");
@@ -56,13 +55,7 @@ static void __init tqm85xx_pic_init(void)
 		return;
 	}
 
-	if (of_address_to_resource(np, 0, &r)) {
-		printk(KERN_ERR "Could not map mpic register space\n");
-		of_node_put(np);
-		return;
-	}
-
-	mpic = mpic_alloc(np, r.start,
+	mpic = mpic_alloc(np, 0,
 			MPIC_PRIMARY | MPIC_WANTS_RESET | MPIC_BIG_ENDIAN,
 			0, 256, " OpenPIC  ");
 	BUG_ON(mpic == NULL);
diff --git a/arch/powerpc/platforms/85xx/xes_mpc85xx.c b/arch/powerpc/platforms/85xx/xes_mpc85xx.c
index daf9bef..2be5e4d 100644
--- a/arch/powerpc/platforms/85xx/xes_mpc85xx.c
+++ b/arch/powerpc/platforms/85xx/xes_mpc85xx.c
@@ -44,7 +44,6 @@
 void __init xes_mpc85xx_pic_init(void)
 {
 	struct mpic *mpic;
-	struct resource r;
 	struct device_node *np;
 
 	np = of_find_node_by_type(NULL, "open-pic");
@@ -53,13 +52,7 @@ void __init xes_mpc85xx_pic_init(void)
 		return;
 	}
 
-	if (of_address_to_resource(np, 0, &r)) {
-		printk(KERN_ERR "Failed to map mpic register space\n");
-		of_node_put(np);
-		return;
-	}
-
-	mpic = mpic_alloc(np, r.start,
+	mpic = mpic_alloc(np, 0,
 			  MPIC_PRIMARY | MPIC_WANTS_RESET |
 			  MPIC_BIG_ENDIAN | MPIC_BROKEN_FRR_NIRQS,
 			0, 256, " OpenPIC  ");
diff --git a/arch/powerpc/platforms/86xx/pic.c b/arch/powerpc/platforms/86xx/pic.c
index 8ef8960..f85c8f0 100644
--- a/arch/powerpc/platforms/86xx/pic.c
+++ b/arch/powerpc/platforms/86xx/pic.c
@@ -33,7 +33,6 @@ void __init mpc86xx_init_irq(void)
 {
 	struct mpic *mpic;
 	struct device_node *np;
-	struct resource res;
 #ifdef CONFIG_PPC_I8259
 	struct device_node *cascade_node = NULL;
 	int cascade_irq;
@@ -43,9 +42,8 @@ void __init mpc86xx_init_irq(void)
 	np = of_find_node_by_type(NULL, "open-pic");
 	if (np == NULL)
 		return;
-	of_address_to_resource(np, 0, &res);
 
-	mpic = mpic_alloc(np, res.start,
+	mpic = mpic_alloc(np, 0,
 			MPIC_PRIMARY | MPIC_WANTS_RESET |
 			MPIC_BIG_ENDIAN | MPIC_BROKEN_FRR_NIRQS |
 			MPIC_SINGLE_DEST_CPU,
diff --git a/arch/powerpc/platforms/powermac/pic.c b/arch/powerpc/platforms/powermac/pic.c
index 901bfbd..78456fd 100644
--- a/arch/powerpc/platforms/powermac/pic.c
+++ b/arch/powerpc/platforms/powermac/pic.c
@@ -498,14 +498,8 @@ static struct mpic * __init pmac_setup_one_mpic(struct device_node *np,
 						int master)
 {
 	const char *name = master ? " MPIC 1   " : " MPIC 2   ";
-	struct resource r;
 	struct mpic *mpic;
 	unsigned int flags = master ? MPIC_PRIMARY : 0;
-	int rc;
-
-	rc = of_address_to_resource(np, 0, &r);
-	if (rc)
-		return NULL;
 
 	pmac_call_feature(PMAC_FTR_ENABLE_MPIC, np, 0, 0);
 
@@ -519,7 +513,7 @@ static struct mpic * __init pmac_setup_one_mpic(struct device_node *np,
 	if (master && (flags & MPIC_BIG_ENDIAN))
 		flags |= MPIC_U3_HT_IRQS;
 
-	mpic = mpic_alloc(np, r.start, flags, 0, 0, name);
+	mpic = mpic_alloc(np, 0, flags, 0, 0, name);
 	if (mpic == NULL)
 		return NULL;
 
diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index b3fa3d7..8f24c6e 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -1142,7 +1142,24 @@ struct mpic * __init mpic_alloc(struct device_node *node,
 	const char	*vers;
 	int		i;
 	int		intvec_top;
-	u64		paddr = phys_addr;
+
+	/*
+	 * If no phyiscal address was specified then all of the phyiscal
+	 * addressing parameters must come from the device-tree.
+	 */
+	if (!phys_addr) {
+		BUG_ON(!node);
+
+		/* Check if it is DCR-based */
+		if (of_get_property(node, "dcr-reg", NULL)) {
+			flags |= MPIC_USES_DCR;
+		} else {
+			struct resource r;
+			if (of_address_to_resource(node, 0, &r))
+				return NULL;
+			phys_addr = r.start;
+		}
+	}
 
 	mpic = kzalloc(sizeof(struct mpic), GFP_KERNEL);
 	if (mpic == NULL)
@@ -1224,35 +1241,25 @@ struct mpic * __init mpic_alloc(struct device_node *node,
 #endif
 
 	/* default register type */
-	mpic->reg_type = (flags & MPIC_BIG_ENDIAN) ?
-		mpic_access_mmio_be : mpic_access_mmio_le;
-
-	/* If no physical address is passed in, a device-node is mandatory */
-	BUG_ON(paddr == 0 && node == NULL);
+	if (flags & MPIC_BIG_ENDIAN)
+		mpic->reg_type = mpic_access_mmio_be;
+	else
+		mpic->reg_type = mpic_access_mmio_le;
 
-	/* If no physical address passed in, check if it's dcr based */
-	if (paddr == 0 && of_get_property(node, "dcr-reg", NULL) != NULL) {
+	/*
+	 * An MPIC with a "dcr-reg" property must be accessed that way, but
+	 * only if the kernel includes DCR support.
+	 */
 #ifdef CONFIG_PPC_DCR
-		mpic->flags |= MPIC_USES_DCR;
+	if (flags & MPIC_USES_DCR)
 		mpic->reg_type = mpic_access_dcr;
 #else
-		BUG();
-#endif /* CONFIG_PPC_DCR */
-	}
-
-	/* If the MPIC is not DCR based, and no physical address was passed
-	 * in, try to obtain one
-	 */
-	if (paddr == 0 && !(mpic->flags & MPIC_USES_DCR)) {
-		const u32 *reg = of_get_property(node, "reg", NULL);
-		BUG_ON(reg == NULL);
-		paddr = of_translate_address(node, reg);
-		BUG_ON(paddr == OF_BAD_ADDR);
-	}
+	BUG_ON(flags & MPIC_USES_DCR);
+#endif
 
 	/* Map the global registers */
-	mpic_map(mpic, node, paddr, &mpic->gregs, MPIC_INFO(GREG_BASE), 0x1000);
-	mpic_map(mpic, node, paddr, &mpic->tmregs, MPIC_INFO(TIMER_BASE), 0x1000);
+	mpic_map(mpic, node, phys_addr, &mpic->gregs, MPIC_INFO(GREG_BASE), 0x1000);
+	mpic_map(mpic, node, phys_addr, &mpic->tmregs, MPIC_INFO(TIMER_BASE), 0x1000);
 
 	/* Reset */
 
@@ -1307,7 +1314,7 @@ struct mpic * __init mpic_alloc(struct device_node *node,
 	for_each_possible_cpu(i) {
 		unsigned int cpu = get_hard_smp_processor_id(i);
 
-		mpic_map(mpic, node, paddr, &mpic->cpuregs[cpu],
+		mpic_map(mpic, node, phys_addr, &mpic->cpuregs[cpu],
 			 MPIC_INFO(CPU_BASE) + cpu * MPIC_INFO(CPU_STRIDE),
 			 0x1000);
 	}
@@ -1315,7 +1322,7 @@ struct mpic * __init mpic_alloc(struct device_node *node,
 	/* Initialize main ISU if none provided */
 	if (mpic->isu_size == 0) {
 		mpic->isu_size = mpic->num_sources;
-		mpic_map(mpic, node, paddr, &mpic->isus[0],
+		mpic_map(mpic, node, phys_addr, &mpic->isus[0],
 			 MPIC_INFO(IRQ_BASE), MPIC_INFO(IRQ_STRIDE) * mpic->isu_size);
 	}
 	mpic->isu_shift = 1 + __ilog2(mpic->isu_size - 1);
@@ -1347,7 +1354,7 @@ struct mpic * __init mpic_alloc(struct device_node *node,
 	}
 	printk(KERN_INFO "mpic: Setting up MPIC \"%s\" version %s at %llx,"
 	       " max %d CPUs\n",
-	       name, vers, (unsigned long long)paddr, num_possible_cpus());
+	       name, vers, (unsigned long long)phys_addr, num_possible_cpus());
 	printk(KERN_INFO "mpic: ISU size: %d, shift: %d, mask: %x\n",
 	       mpic->isu_size, mpic->isu_shift, mpic->isu_mask);
 
-- 
1.7.2.5
