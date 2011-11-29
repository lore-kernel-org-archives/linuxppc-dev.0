Return-Path: <Kyle.D.Moffett@boeing.com>
Received: from border.exmeritus.com (border.exmeritus.com
 [IPv6:2002:46a7:f11a:ffff::])
 by ozlabs.org (Postfix) with ESMTP id E99B81007E2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Nov 2011 05:59:33 +1100 (EST)
From: Kyle Moffett <Kyle.D.Moffett@boeing.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 02/10] powerpc: Consolidate mpic_alloc() OF address translation
Date: Tue, 29 Nov 2011 13:58:29 -0500
Message-Id: <1322593117-29938-3-git-send-email-Kyle.D.Moffett@boeing.com>
In-Reply-To: <1322593117-29938-1-git-send-email-Kyle.D.Moffett@boeing.com>
References: <1322593117-29938-1-git-send-email-Kyle.D.Moffett@boeing.com>
Cc: Paul Mackerras <paulus@samba.org>, Kyle Moffett <Kyle.D.Moffett@boeing.com>,
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
 arch/powerpc/platforms/powermac/pic.c     |    7 +---
 arch/powerpc/sysdev/mpic.c                |   61 ++++++++++++++++-------------
 20 files changed, 55 insertions(+), 174 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/corenet_ds.c b/arch/powerpc/platforms/85xx/corenet_ds.c
index 435074d..7893ad3 100644
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
index c46f935..b20c07d 100644
--- a/arch/powerpc/platforms/85xx/ksi8560.c
+++ b/arch/powerpc/platforms/85xx/ksi8560.c
@@ -68,7 +68,6 @@ static void cpm2_cascade(unsigned int irq, struct irq_desc *desc)
 static void __init ksi8560_pic_init(void)
 {
 	struct mpic *mpic;
-	struct resource r;
 	struct device_node *np;
 #ifdef CONFIG_CPM2
 	int irq;
@@ -81,13 +80,7 @@ static void __init ksi8560_pic_init(void)
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
index f79f2f1..03173ba 100644
--- a/arch/powerpc/platforms/85xx/mpc8536_ds.c
+++ b/arch/powerpc/platforms/85xx/mpc8536_ds.c
@@ -35,7 +35,6 @@
 void __init mpc8536_ds_pic_init(void)
 {
 	struct mpic *mpic;
-	struct resource r;
 	struct device_node *np;
 
 	np = of_find_node_by_type(NULL, "open-pic");
@@ -44,13 +43,7 @@ void __init mpc8536_ds_pic_init(void)
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
index 3b2c9bb..5cb797b 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ads.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ads.c
@@ -64,7 +64,6 @@ static void cpm2_cascade(unsigned int irq, struct irq_desc *desc)
 static void __init mpc85xx_ads_pic_init(void)
 {
 	struct mpic *mpic;
-	struct resource r;
 	struct device_node *np = NULL;
 #ifdef CONFIG_CPM2
 	int irq;
@@ -76,13 +75,7 @@ static void __init mpc85xx_ads_pic_init(void)
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
index 66cb8d6..3e65336 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_cds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
@@ -186,7 +186,6 @@ static struct irqaction mpc85xxcds_8259_irqaction = {
 static void __init mpc85xx_cds_pic_init(void)
 {
 	struct mpic *mpic;
-	struct resource r;
 	struct device_node *np = NULL;
 
 	np = of_find_node_by_type(np, "open-pic");
@@ -196,13 +195,7 @@ static void __init mpc85xx_cds_pic_init(void)
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
index 52d2a3e..b608da7 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
@@ -61,7 +61,6 @@ static void mpc85xx_8259_cascade(unsigned int irq, struct irq_desc *desc)
 void __init mpc85xx_ds_pic_init(void)
 {
 	struct mpic *mpic;
-	struct resource r;
 	struct device_node *np;
 #ifdef CONFIG_PPC_I8259
 	struct device_node *cascade_node = NULL;
@@ -75,20 +74,14 @@ void __init mpc85xx_ds_pic_init(void)
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
index e4d470e..f2f7527 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_mds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
@@ -474,20 +474,13 @@ machine_arch_initcall(p1021_mds, swiotlb_setup_bus_notifier);
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
index cd49898..67bd1d4 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
@@ -43,7 +43,6 @@
 void __init mpc85xx_rdb_pic_init(void)
 {
 	struct mpic *mpic;
-	struct resource r;
 	struct device_node *np;
 	unsigned long root = of_get_flat_dt_root();
 
@@ -53,20 +52,14 @@ void __init mpc85xx_rdb_pic_init(void)
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
index d7387fa..2efcdcd 100644
--- a/arch/powerpc/platforms/85xx/p1010rdb.c
+++ b/arch/powerpc/platforms/85xx/p1010rdb.c
@@ -31,7 +31,6 @@
 void __init p1010_rdb_pic_init(void)
 {
 	struct mpic *mpic;
-	struct resource r;
 	struct device_node *np;
 
 	np = of_find_node_by_type(NULL, "open-pic");
@@ -40,13 +39,7 @@ void __init p1010_rdb_pic_init(void)
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
index 089b959..e840cc9 100644
--- a/arch/powerpc/platforms/85xx/p1022_ds.c
+++ b/arch/powerpc/platforms/85xx/p1022_ds.c
@@ -240,7 +240,6 @@ p1022ds_valid_monitor_port(enum fsl_diu_monitor_port port)
 void __init p1022_ds_pic_init(void)
 {
 	struct mpic *mpic;
-	struct resource r;
 	struct device_node *np;
 
 	np = of_find_node_by_type(NULL, "open-pic");
@@ -249,13 +248,7 @@ void __init p1022_ds_pic_init(void)
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
index da546ea..6988fab 100644
--- a/arch/powerpc/platforms/85xx/p1023_rds.c
+++ b/arch/powerpc/platforms/85xx/p1023_rds.c
@@ -107,7 +107,6 @@ machine_device_initcall(p1023_rds, p1023_publish_devices);
 static void __init mpc85xx_rds_pic_init(void)
 {
 	struct mpic *mpic;
-	struct resource r;
 	struct device_node *np = NULL;
 
 	np = of_find_node_by_type(NULL, "open-pic");
@@ -116,13 +115,7 @@ static void __init mpc85xx_rds_pic_init(void)
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
index 14632a9..218761a 100644
--- a/arch/powerpc/platforms/85xx/sbc8548.c
+++ b/arch/powerpc/platforms/85xx/sbc8548.c
@@ -53,7 +53,6 @@ static int sbc_rev;
 static void __init sbc8548_pic_init(void)
 {
 	struct mpic *mpic;
-	struct resource r;
 	struct device_node *np = NULL;
 
 	np = of_find_node_by_type(np, "open-pic");
@@ -63,13 +62,7 @@ static void __init sbc8548_pic_init(void)
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
index cebd786..6e3066a 100644
--- a/arch/powerpc/platforms/85xx/sbc8560.c
+++ b/arch/powerpc/platforms/85xx/sbc8560.c
@@ -55,7 +55,6 @@ static void cpm2_cascade(unsigned int irq, struct irq_desc *desc)
 static void __init sbc8560_pic_init(void)
 {
 	struct mpic *mpic;
-	struct resource r;
 	struct device_node *np = NULL;
 #ifdef CONFIG_CPM2
 	int irq;
@@ -67,13 +66,7 @@ static void __init sbc8560_pic_init(void)
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
index 747d8fb..fb4bfd6 100644
--- a/arch/powerpc/platforms/85xx/socrates.c
+++ b/arch/powerpc/platforms/85xx/socrates.c
@@ -46,7 +46,6 @@
 static void __init socrates_pic_init(void)
 {
 	struct mpic *mpic;
-	struct resource r;
 	struct device_node *np;
 
 	np = of_find_node_by_type(NULL, "open-pic");
@@ -55,13 +54,7 @@ static void __init socrates_pic_init(void)
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
index 5387e9f..78aef45 100644
--- a/arch/powerpc/platforms/85xx/stx_gp3.c
+++ b/arch/powerpc/platforms/85xx/stx_gp3.c
@@ -59,7 +59,6 @@ static void cpm2_cascade(unsigned int irq, struct irq_desc *desc)
 static void __init stx_gp3_pic_init(void)
 {
 	struct mpic *mpic;
-	struct resource r;
 	struct device_node *np;
 #ifdef CONFIG_CPM2
 	int irq;
@@ -71,13 +70,7 @@ static void __init stx_gp3_pic_init(void)
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
index 325de77..5775f4c 100644
--- a/arch/powerpc/platforms/85xx/tqm85xx.c
+++ b/arch/powerpc/platforms/85xx/tqm85xx.c
@@ -57,7 +57,6 @@ static void cpm2_cascade(unsigned int irq, struct irq_desc *desc)
 static void __init tqm85xx_pic_init(void)
 {
 	struct mpic *mpic;
-	struct resource r;
 	struct device_node *np;
 #ifdef CONFIG_CPM2
 	int irq;
@@ -69,13 +68,7 @@ static void __init tqm85xx_pic_init(void)
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
index ce3f660..fccf9aa 100644
--- a/arch/powerpc/platforms/85xx/xes_mpc85xx.c
+++ b/arch/powerpc/platforms/85xx/xes_mpc85xx.c
@@ -42,7 +42,6 @@
 void __init xes_mpc85xx_pic_init(void)
 {
 	struct mpic *mpic;
-	struct resource r;
 	struct device_node *np;
 
 	np = of_find_node_by_type(NULL, "open-pic");
@@ -51,13 +50,7 @@ void __init xes_mpc85xx_pic_init(void)
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
index 901bfbd..44f9774 100644
--- a/arch/powerpc/platforms/powermac/pic.c
+++ b/arch/powerpc/platforms/powermac/pic.c
@@ -498,15 +498,10 @@ static struct mpic * __init pmac_setup_one_mpic(struct device_node *np,
 						int master)
 {
 	const char *name = master ? " MPIC 1   " : " MPIC 2   ";
-	struct resource r;
 	struct mpic *mpic;
 	unsigned int flags = master ? MPIC_PRIMARY : 0;
 	int rc;
 
-	rc = of_address_to_resource(np, 0, &r);
-	if (rc)
-		return NULL;
-
 	pmac_call_feature(PMAC_FTR_ENABLE_MPIC, np, 0, 0);
 
 	flags |= MPIC_WANTS_RESET;
@@ -519,7 +514,7 @@ static struct mpic * __init pmac_setup_one_mpic(struct device_node *np,
 	if (master && (flags & MPIC_BIG_ENDIAN))
 		flags |= MPIC_U3_HT_IRQS;
 
-	mpic = mpic_alloc(np, r.start, flags, 0, 0, name);
+	mpic = mpic_alloc(np, 0, flags, 0, 0, name);
 	if (mpic == NULL)
 		return NULL;
 
diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index 8c7e852..d68c9ca 100644
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
