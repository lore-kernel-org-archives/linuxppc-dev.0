Return-Path: <Kyle.D.Moffett@boeing.com>
Received: from border.exmeritus.com (border.exmeritus.com
 [IPv6:2002:46a7:f11a:ffff::])
 by ozlabs.org (Postfix) with ESMTP id D55A0100BE7
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Dec 2011 03:29:14 +1100 (EST)
From: Kyle Moffett <Kyle.D.Moffett@boeing.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH v3 06/10] powerpc/mpic: Invert the meaning of MPIC_PRIMARY
Date: Fri,  2 Dec 2011 11:28:03 -0500
Message-Id: <1322843287-2745-7-git-send-email-Kyle.D.Moffett@boeing.com>
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

It turns out that there are only 2 in-tree platforms which use MPICs
which are not "primary":  IBM Cell and PowerMac.  To reduce the
complexity of the typical board setup code, invert the MPIC_PRIMARY bit
into MPIC_SECONDARY.

Signed-off-by: Kyle Moffett <Kyle.D.Moffett@boeing.com>
---
 arch/powerpc/include/asm/mpic.h                   |    8 ++++----
 arch/powerpc/platforms/44x/iss4xx.c               |    2 +-
 arch/powerpc/platforms/85xx/corenet_ds.c          |    2 +-
 arch/powerpc/platforms/85xx/ksi8560.c             |    2 +-
 arch/powerpc/platforms/85xx/mpc8536_ds.c          |    2 +-
 arch/powerpc/platforms/85xx/mpc85xx_ads.c         |    2 +-
 arch/powerpc/platforms/85xx/mpc85xx_cds.c         |    2 +-
 arch/powerpc/platforms/85xx/mpc85xx_ds.c          |    3 +--
 arch/powerpc/platforms/85xx/mpc85xx_mds.c         |    2 +-
 arch/powerpc/platforms/85xx/mpc85xx_rdb.c         |    3 +--
 arch/powerpc/platforms/85xx/p1010rdb.c            |    4 ++--
 arch/powerpc/platforms/85xx/p1022_ds.c            |    2 +-
 arch/powerpc/platforms/85xx/p1023_rds.c           |    2 +-
 arch/powerpc/platforms/85xx/sbc8548.c             |    2 +-
 arch/powerpc/platforms/85xx/sbc8560.c             |    2 +-
 arch/powerpc/platforms/85xx/socrates.c            |    2 +-
 arch/powerpc/platforms/85xx/stx_gp3.c             |    2 +-
 arch/powerpc/platforms/85xx/tqm85xx.c             |    2 +-
 arch/powerpc/platforms/85xx/xes_mpc85xx.c         |    2 +-
 arch/powerpc/platforms/86xx/pic.c                 |    5 ++---
 arch/powerpc/platforms/cell/setup.c               |    2 +-
 arch/powerpc/platforms/chrp/setup.c               |    3 +--
 arch/powerpc/platforms/embedded6xx/holly.c        |    2 +-
 arch/powerpc/platforms/embedded6xx/linkstation.c  |    2 +-
 arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c |    2 +-
 arch/powerpc/platforms/embedded6xx/storcenter.c   |    2 +-
 arch/powerpc/platforms/maple/setup.c              |    2 +-
 arch/powerpc/platforms/pasemi/setup.c             |    2 +-
 arch/powerpc/platforms/powermac/pic.c             |    2 +-
 arch/powerpc/platforms/pseries/setup.c            |    3 +--
 arch/powerpc/sysdev/mpic.c                        |   14 +++++++-------
 31 files changed, 42 insertions(+), 47 deletions(-)

diff --git a/arch/powerpc/include/asm/mpic.h b/arch/powerpc/include/asm/mpic.h
index ba0b204..b9d2c0f 100644
--- a/arch/powerpc/include/asm/mpic.h
+++ b/arch/powerpc/include/asm/mpic.h
@@ -334,11 +334,11 @@ struct mpic
  * Note setting any ID (leaving those bits to 0) means standard MPIC
  */
 
-/* This is the primary controller, only that one has IPIs and
- * has afinity control. A non-primary MPIC always uses CPU0
- * registers only
+/*
+ * This is a secondary ("chained") controller; it only uses the CPU0
+ * registers.  Primary controllers have IPIs and affinity control.
  */
-#define MPIC_PRIMARY			0x00000001
+#define MPIC_SECONDARY			0x00000001
 
 /* Set this for a big-endian MPIC */
 #define MPIC_BIG_ENDIAN			0x00000002
diff --git a/arch/powerpc/platforms/44x/iss4xx.c b/arch/powerpc/platforms/44x/iss4xx.c
index 19395f1..5b8cdbb 100644
--- a/arch/powerpc/platforms/44x/iss4xx.c
+++ b/arch/powerpc/platforms/44x/iss4xx.c
@@ -71,7 +71,7 @@ static void __init iss4xx_init_irq(void)
 		/* The MPIC driver will get everything it needs from the
 		 * device-tree, just pass 0 to all arguments
 		 */
-		struct mpic *mpic = mpic_alloc(np, 0, MPIC_PRIMARY, 0, 0,
+		struct mpic *mpic = mpic_alloc(np, 0, 0, 0, 0,
 					       " MPIC     ");
 		BUG_ON(mpic == NULL);
 		mpic_init(mpic);
diff --git a/arch/powerpc/platforms/85xx/corenet_ds.c b/arch/powerpc/platforms/85xx/corenet_ds.c
index cfa4bad..07e3e6c 100644
--- a/arch/powerpc/platforms/85xx/corenet_ds.c
+++ b/arch/powerpc/platforms/85xx/corenet_ds.c
@@ -36,7 +36,7 @@
 void __init corenet_ds_pic_init(void)
 {
 	struct mpic *mpic;
-	unsigned int flags = MPIC_PRIMARY | MPIC_BIG_ENDIAN |
+	unsigned int flags = MPIC_BIG_ENDIAN |
 				MPIC_BROKEN_FRR_NIRQS | MPIC_SINGLE_DEST_CPU;
 
 	if (ppc_md.get_irq == mpic_get_coreint_irq)
diff --git a/arch/powerpc/platforms/85xx/ksi8560.c b/arch/powerpc/platforms/85xx/ksi8560.c
index 1620fa8..20f75d7 100644
--- a/arch/powerpc/platforms/85xx/ksi8560.c
+++ b/arch/powerpc/platforms/85xx/ksi8560.c
@@ -58,7 +58,7 @@ static void machine_restart(char *cmd)
 static void __init ksi8560_pic_init(void)
 {
 	struct mpic *mpic = mpic_alloc(NULL, 0,
-			MPIC_PRIMARY | MPIC_WANTS_RESET | MPIC_BIG_ENDIAN,
+			MPIC_WANTS_RESET | MPIC_BIG_ENDIAN,
 			0, 256, " OpenPIC  ");
 	BUG_ON(mpic == NULL);
 	mpic_init(mpic);
diff --git a/arch/powerpc/platforms/85xx/mpc8536_ds.c b/arch/powerpc/platforms/85xx/mpc8536_ds.c
index 07916d6..cf26682 100644
--- a/arch/powerpc/platforms/85xx/mpc8536_ds.c
+++ b/arch/powerpc/platforms/85xx/mpc8536_ds.c
@@ -37,7 +37,7 @@
 void __init mpc8536_ds_pic_init(void)
 {
 	struct mpic *mpic = mpic_alloc(NULL, 0,
-			  MPIC_PRIMARY | MPIC_WANTS_RESET |
+			  MPIC_WANTS_RESET |
 			  MPIC_BIG_ENDIAN | MPIC_BROKEN_FRR_NIRQS,
 			0, 256, " OpenPIC  ");
 	BUG_ON(mpic == NULL);
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ads.c b/arch/powerpc/platforms/85xx/mpc85xx_ads.c
index 17c6f06..3bebb51 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ads.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ads.c
@@ -51,7 +51,7 @@ static int mpc85xx_exclude_device(struct pci_controller *hose,
 static void __init mpc85xx_ads_pic_init(void)
 {
 	struct mpic *mpic = mpic_alloc(NULL, 0,
-			MPIC_PRIMARY | MPIC_WANTS_RESET | MPIC_BIG_ENDIAN,
+			MPIC_WANTS_RESET | MPIC_BIG_ENDIAN,
 			0, 256, " OpenPIC  ");
 	BUG_ON(mpic == NULL);
 	mpic_init(mpic);
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_cds.c b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
index cf209b3..40f03da 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_cds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
@@ -189,7 +189,7 @@ static void __init mpc85xx_cds_pic_init(void)
 {
 	struct mpic *mpic;
 	mpic = mpic_alloc(NULL, 0,
-			MPIC_PRIMARY | MPIC_WANTS_RESET | MPIC_BIG_ENDIAN,
+			MPIC_WANTS_RESET | MPIC_BIG_ENDIAN,
 			0, 256, " OpenPIC  ");
 	BUG_ON(mpic == NULL);
 	mpic_init(mpic);
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ds.c b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
index 104a09b..eefbb91 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
@@ -72,13 +72,12 @@ void __init mpc85xx_ds_pic_init(void)
 
 	if (of_flat_dt_is_compatible(root, "fsl,MPC8572DS-CAMP")) {
 		mpic = mpic_alloc(NULL, 0,
-			MPIC_PRIMARY |
 			MPIC_BIG_ENDIAN | MPIC_BROKEN_FRR_NIRQS |
 			MPIC_SINGLE_DEST_CPU,
 			0, 256, " OpenPIC  ");
 	} else {
 		mpic = mpic_alloc(NULL, 0,
-			  MPIC_PRIMARY | MPIC_WANTS_RESET |
+			  MPIC_WANTS_RESET |
 			  MPIC_BIG_ENDIAN | MPIC_BROKEN_FRR_NIRQS |
 			  MPIC_SINGLE_DEST_CPU,
 			0, 256, " OpenPIC  ");
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_mds.c b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
index 4e5431a..1d15a0c 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_mds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
@@ -435,7 +435,7 @@ machine_arch_initcall(p1021_mds, swiotlb_setup_bus_notifier);
 static void __init mpc85xx_mds_pic_init(void)
 {
 	struct mpic *mpic = mpic_alloc(NULL, 0,
-			MPIC_PRIMARY | MPIC_WANTS_RESET | MPIC_BIG_ENDIAN |
+			MPIC_WANTS_RESET | MPIC_BIG_ENDIAN |
 			MPIC_BROKEN_FRR_NIRQS | MPIC_SINGLE_DEST_CPU,
 			0, 256, " OpenPIC  ");
 	BUG_ON(mpic == NULL);
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
index a68d922..ccf520e 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
@@ -49,13 +49,12 @@ void __init mpc85xx_rdb_pic_init(void)
 
 	if (of_flat_dt_is_compatible(root, "fsl,MPC85XXRDB-CAMP")) {
 		mpic = mpic_alloc(NULL, 0,
-			MPIC_PRIMARY |
 			MPIC_BIG_ENDIAN | MPIC_BROKEN_FRR_NIRQS |
 			MPIC_SINGLE_DEST_CPU,
 			0, 256, " OpenPIC  ");
 	} else {
 		mpic = mpic_alloc(NULL, 0,
-		  MPIC_PRIMARY | MPIC_WANTS_RESET |
+		  MPIC_WANTS_RESET |
 		  MPIC_BIG_ENDIAN | MPIC_BROKEN_FRR_NIRQS |
 		  MPIC_SINGLE_DEST_CPU,
 		  0, 256, " OpenPIC  ");
diff --git a/arch/powerpc/platforms/85xx/p1010rdb.c b/arch/powerpc/platforms/85xx/p1010rdb.c
index 25f7375..894f1e8 100644
--- a/arch/powerpc/platforms/85xx/p1010rdb.c
+++ b/arch/powerpc/platforms/85xx/p1010rdb.c
@@ -33,8 +33,8 @@
 void __init p1010_rdb_pic_init(void)
 {
 	struct mpic *mpic = mpic_alloc(NULL, 0,
-	  MPIC_PRIMARY | MPIC_WANTS_RESET |
-	  MPIC_BIG_ENDIAN | MPIC_BROKEN_FRR_NIRQS | MPIC_SINGLE_DEST_CPU,
+	  MPIC_WANTS_RESET | MPIC_BIG_ENDIAN |
+	  MPIC_BROKEN_FRR_NIRQS | MPIC_SINGLE_DEST_CPU,
 	  0, 256, " OpenPIC  ");
 
 	BUG_ON(mpic == NULL);
diff --git a/arch/powerpc/platforms/85xx/p1022_ds.c b/arch/powerpc/platforms/85xx/p1022_ds.c
index 6af5502..bb3d84f 100644
--- a/arch/powerpc/platforms/85xx/p1022_ds.c
+++ b/arch/powerpc/platforms/85xx/p1022_ds.c
@@ -242,7 +242,7 @@ p1022ds_valid_monitor_port(enum fsl_diu_monitor_port port)
 void __init p1022_ds_pic_init(void)
 {
 	struct mpic *mpic = mpic_alloc(NULL, 0,
-		MPIC_PRIMARY | MPIC_WANTS_RESET |
+		MPIC_WANTS_RESET |
 		MPIC_BIG_ENDIAN | MPIC_BROKEN_FRR_NIRQS |
 		MPIC_SINGLE_DEST_CPU,
 		0, 256, " OpenPIC  ");
diff --git a/arch/powerpc/platforms/85xx/p1023_rds.c b/arch/powerpc/platforms/85xx/p1023_rds.c
index b3c78fe..e92a714 100644
--- a/arch/powerpc/platforms/85xx/p1023_rds.c
+++ b/arch/powerpc/platforms/85xx/p1023_rds.c
@@ -94,7 +94,7 @@ machine_device_initcall(p1023_rds, mpc85xx_common_publish_devices);
 static void __init mpc85xx_rds_pic_init(void)
 {
 	struct mpic *mpic = mpic_alloc(NULL, 0,
-		MPIC_PRIMARY | MPIC_WANTS_RESET | MPIC_BIG_ENDIAN |
+		MPIC_WANTS_RESET | MPIC_BIG_ENDIAN |
 		MPIC_BROKEN_FRR_NIRQS | MPIC_SINGLE_DEST_CPU,
 		0, 256, " OpenPIC  ");
 
diff --git a/arch/powerpc/platforms/85xx/sbc8548.c b/arch/powerpc/platforms/85xx/sbc8548.c
index 38d6945..184a507 100644
--- a/arch/powerpc/platforms/85xx/sbc8548.c
+++ b/arch/powerpc/platforms/85xx/sbc8548.c
@@ -55,7 +55,7 @@ static int sbc_rev;
 static void __init sbc8548_pic_init(void)
 {
 	struct mpic *mpic = mpic_alloc(NULL, 0,
-			MPIC_PRIMARY | MPIC_WANTS_RESET | MPIC_BIG_ENDIAN,
+			MPIC_WANTS_RESET | MPIC_BIG_ENDIAN,
 			0, 256, " OpenPIC  ");
 	BUG_ON(mpic == NULL);
 	mpic_init(mpic);
diff --git a/arch/powerpc/platforms/85xx/sbc8560.c b/arch/powerpc/platforms/85xx/sbc8560.c
index 7e6d7e5..940752e 100644
--- a/arch/powerpc/platforms/85xx/sbc8560.c
+++ b/arch/powerpc/platforms/85xx/sbc8560.c
@@ -42,7 +42,7 @@
 static void __init sbc8560_pic_init(void)
 {
 	struct mpic *mpic = mpic_alloc(NULL, 0,
-			MPIC_PRIMARY | MPIC_WANTS_RESET | MPIC_BIG_ENDIAN,
+			MPIC_WANTS_RESET | MPIC_BIG_ENDIAN,
 			0, 256, " OpenPIC  ");
 	BUG_ON(mpic == NULL);
 	mpic_init(mpic);
diff --git a/arch/powerpc/platforms/85xx/socrates.c b/arch/powerpc/platforms/85xx/socrates.c
index 8175f0a..18f6359 100644
--- a/arch/powerpc/platforms/85xx/socrates.c
+++ b/arch/powerpc/platforms/85xx/socrates.c
@@ -49,7 +49,7 @@ static void __init socrates_pic_init(void)
 	struct device_node *np;
 
 	struct mpic *mpic = mpic_alloc(NULL, 0,
-			MPIC_PRIMARY | MPIC_WANTS_RESET | MPIC_BIG_ENDIAN,
+			MPIC_WANTS_RESET | MPIC_BIG_ENDIAN,
 			0, 256, " OpenPIC  ");
 	BUG_ON(mpic == NULL);
 	mpic_init(mpic);
diff --git a/arch/powerpc/platforms/85xx/stx_gp3.c b/arch/powerpc/platforms/85xx/stx_gp3.c
index 8ca1e61..e9e5234 100644
--- a/arch/powerpc/platforms/85xx/stx_gp3.c
+++ b/arch/powerpc/platforms/85xx/stx_gp3.c
@@ -49,7 +49,7 @@
 static void __init stx_gp3_pic_init(void)
 {
 	struct mpic *mpic = mpic_alloc(NULL, 0,
-			MPIC_PRIMARY | MPIC_WANTS_RESET | MPIC_BIG_ENDIAN,
+			MPIC_WANTS_RESET | MPIC_BIG_ENDIAN,
 			0, 256, " OpenPIC  ");
 	BUG_ON(mpic == NULL);
 	mpic_init(mpic);
diff --git a/arch/powerpc/platforms/85xx/tqm85xx.c b/arch/powerpc/platforms/85xx/tqm85xx.c
index 6e7a835..bf7c89f 100644
--- a/arch/powerpc/platforms/85xx/tqm85xx.c
+++ b/arch/powerpc/platforms/85xx/tqm85xx.c
@@ -47,7 +47,7 @@
 static void __init tqm85xx_pic_init(void)
 {
 	struct mpic *mpic = mpic_alloc(NULL, 0,
-			MPIC_PRIMARY | MPIC_WANTS_RESET | MPIC_BIG_ENDIAN,
+			MPIC_WANTS_RESET | MPIC_BIG_ENDIAN,
 			0, 256, " OpenPIC  ");
 	BUG_ON(mpic == NULL);
 	mpic_init(mpic);
diff --git a/arch/powerpc/platforms/85xx/xes_mpc85xx.c b/arch/powerpc/platforms/85xx/xes_mpc85xx.c
index f94c608..3a69f8b 100644
--- a/arch/powerpc/platforms/85xx/xes_mpc85xx.c
+++ b/arch/powerpc/platforms/85xx/xes_mpc85xx.c
@@ -44,7 +44,7 @@
 void __init xes_mpc85xx_pic_init(void)
 {
 	struct mpic *mpic = mpic_alloc(NULL, 0,
-			  MPIC_PRIMARY | MPIC_WANTS_RESET |
+			  MPIC_WANTS_RESET |
 			  MPIC_BIG_ENDIAN | MPIC_BROKEN_FRR_NIRQS,
 			0, 256, " OpenPIC  ");
 	BUG_ON(mpic == NULL);
diff --git a/arch/powerpc/platforms/86xx/pic.c b/arch/powerpc/platforms/86xx/pic.c
index ed85b3c..52bbfa0 100644
--- a/arch/powerpc/platforms/86xx/pic.c
+++ b/arch/powerpc/platforms/86xx/pic.c
@@ -38,9 +38,8 @@ void __init mpc86xx_init_irq(void)
 #endif
 
 	struct mpic *mpic = mpic_alloc(NULL, 0,
-			MPIC_PRIMARY | MPIC_WANTS_RESET |
-			MPIC_BIG_ENDIAN | MPIC_BROKEN_FRR_NIRQS |
-			MPIC_SINGLE_DEST_CPU,
+			MPIC_WANTS_RESET | MPIC_BIG_ENDIAN |
+			MPIC_BROKEN_FRR_NIRQS | MPIC_SINGLE_DEST_CPU,
 			0, 256, " MPIC     ");
 	BUG_ON(mpic == NULL);
 
diff --git a/arch/powerpc/platforms/cell/setup.c b/arch/powerpc/platforms/cell/setup.c
index 0fc9b72..cd00ca8 100644
--- a/arch/powerpc/platforms/cell/setup.c
+++ b/arch/powerpc/platforms/cell/setup.c
@@ -211,7 +211,7 @@ static void __init mpic_init_IRQ(void)
 		/* The MPIC driver will get everything it needs from the
 		 * device-tree, just pass 0 to all arguments
 		 */
-		mpic = mpic_alloc(dn, 0, 0, 0, 0, " MPIC     ");
+		mpic = mpic_alloc(dn, 0, MPIC_SECONDARY, 0, 0, " MPIC     ");
 		if (mpic == NULL)
 			continue;
 		mpic_init(mpic);
diff --git a/arch/powerpc/platforms/chrp/setup.c b/arch/powerpc/platforms/chrp/setup.c
index 1227864..f1f17bb 100644
--- a/arch/powerpc/platforms/chrp/setup.c
+++ b/arch/powerpc/platforms/chrp/setup.c
@@ -435,8 +435,7 @@ static void __init chrp_find_openpic(void)
 	if (len > 1)
 		isu_size = iranges[3];
 
-	chrp_mpic = mpic_alloc(np, opaddr, MPIC_PRIMARY,
-			       isu_size, 0, " MPIC    ");
+	chrp_mpic = mpic_alloc(np, opaddr, 0, isu_size, 0, " MPIC    ");
 	if (chrp_mpic == NULL) {
 		printk(KERN_ERR "Failed to allocate MPIC structure\n");
 		goto bail;
diff --git a/arch/powerpc/platforms/embedded6xx/holly.c b/arch/powerpc/platforms/embedded6xx/holly.c
index 5ed00a7..9cfcf20 100644
--- a/arch/powerpc/platforms/embedded6xx/holly.c
+++ b/arch/powerpc/platforms/embedded6xx/holly.c
@@ -155,7 +155,7 @@ static void __init holly_init_IRQ(void)
 #endif
 
 	mpic = mpic_alloc(NULL, 0,
-			MPIC_PRIMARY | MPIC_BIG_ENDIAN | MPIC_WANTS_RESET |
+			MPIC_BIG_ENDIAN | MPIC_WANTS_RESET |
 			MPIC_SPV_EOI | MPIC_NO_PTHROU_DIS | MPIC_REGSET_TSI108,
 			24,
 			NR_IRQS-4, /* num_sources used */
diff --git a/arch/powerpc/platforms/embedded6xx/linkstation.c b/arch/powerpc/platforms/embedded6xx/linkstation.c
index 502ff60..bcfad92 100644
--- a/arch/powerpc/platforms/embedded6xx/linkstation.c
+++ b/arch/powerpc/platforms/embedded6xx/linkstation.c
@@ -82,7 +82,7 @@ static void __init linkstation_init_IRQ(void)
 {
 	struct mpic *mpic;
 
-	mpic = mpic_alloc(NULL, 0, MPIC_PRIMARY | MPIC_WANTS_RESET,
+	mpic = mpic_alloc(NULL, 0, MPIC_WANTS_RESET,
 			4, 32, " EPIC     ");
 	BUG_ON(mpic == NULL);
 
diff --git a/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c b/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c
index e0f1127..f3350d7 100644
--- a/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c
+++ b/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c
@@ -109,7 +109,7 @@ static void __init mpc7448_hpc2_init_IRQ(void)
 #endif
 
 	mpic = mpic_alloc(NULL, 0,
-			MPIC_PRIMARY | MPIC_BIG_ENDIAN | MPIC_WANTS_RESET |
+			MPIC_BIG_ENDIAN | MPIC_WANTS_RESET |
 			MPIC_SPV_EOI | MPIC_NO_PTHROU_DIS | MPIC_REGSET_TSI108,
 			24,
 			NR_IRQS-4, /* num_sources used */
diff --git a/arch/powerpc/platforms/embedded6xx/storcenter.c b/arch/powerpc/platforms/embedded6xx/storcenter.c
index 9bd15df..afa6388 100644
--- a/arch/powerpc/platforms/embedded6xx/storcenter.c
+++ b/arch/powerpc/platforms/embedded6xx/storcenter.c
@@ -84,7 +84,7 @@ static void __init storcenter_init_IRQ(void)
 {
 	struct mpic *mpic;
 
-	mpic = mpic_alloc(NULL, 0, MPIC_PRIMARY | MPIC_WANTS_RESET,
+	mpic = mpic_alloc(NULL, 0, MPIC_WANTS_RESET,
 			16, 32, " OpenPIC  ");
 	BUG_ON(mpic == NULL);
 
diff --git a/arch/powerpc/platforms/maple/setup.c b/arch/powerpc/platforms/maple/setup.c
index 4c37204..0bcbfe7 100644
--- a/arch/powerpc/platforms/maple/setup.c
+++ b/arch/powerpc/platforms/maple/setup.c
@@ -221,7 +221,7 @@ static void __init maple_init_IRQ(void)
 	unsigned long openpic_addr = 0;
 	int naddr, n, i, opplen, has_isus = 0;
 	struct mpic *mpic;
-	unsigned int flags = MPIC_PRIMARY;
+	unsigned int flags = 0;
 
 	/* Locate MPIC in the device-tree. Note that there is a bug
 	 * in Maple device-tree where the type of the controller is
diff --git a/arch/powerpc/platforms/pasemi/setup.c b/arch/powerpc/platforms/pasemi/setup.c
index baf20a9..98b7a7c 100644
--- a/arch/powerpc/platforms/pasemi/setup.c
+++ b/arch/powerpc/platforms/pasemi/setup.c
@@ -224,7 +224,7 @@ static __init void pas_init_IRQ(void)
 	openpic_addr = of_read_number(opprop, naddr);
 	printk(KERN_DEBUG "OpenPIC addr: %lx\n", openpic_addr);
 
-	mpic_flags = MPIC_PRIMARY | MPIC_LARGE_VECTORS | MPIC_NO_BIAS;
+	mpic_flags = MPIC_LARGE_VECTORS | MPIC_NO_BIAS;
 
 	nmiprop = of_get_property(mpic_node, "nmi-source", NULL);
 	if (nmiprop)
diff --git a/arch/powerpc/platforms/powermac/pic.c b/arch/powerpc/platforms/powermac/pic.c
index 78456fd..b962101 100644
--- a/arch/powerpc/platforms/powermac/pic.c
+++ b/arch/powerpc/platforms/powermac/pic.c
@@ -499,7 +499,7 @@ static struct mpic * __init pmac_setup_one_mpic(struct device_node *np,
 {
 	const char *name = master ? " MPIC 1   " : " MPIC 2   ";
 	struct mpic *mpic;
-	unsigned int flags = master ? MPIC_PRIMARY : 0;
+	unsigned int flags = master ? 0 : MPIC_SECONDARY;
 
 	pmac_call_feature(PMAC_FTR_ENABLE_MPIC, np, 0, 0);
 
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index c3408ca..01df08d 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -192,8 +192,7 @@ static void __init pseries_mpic_init_IRQ(void)
 	BUG_ON(openpic_addr == 0);
 
 	/* Setup the openpic driver */
-	mpic = mpic_alloc(pSeries_mpic_node, openpic_addr,
-			  MPIC_PRIMARY,
+	mpic = mpic_alloc(pSeries_mpic_node, openpic_addr, 0,
 			  16, 250, /* isu size, irq count */
 			  " MPIC     ");
 	BUG_ON(mpic == NULL);
diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index bb72a62..6d42ad1 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -154,7 +154,7 @@ static inline unsigned int mpic_processor_id(struct mpic *mpic)
 {
 	unsigned int cpu = 0;
 
-	if (mpic->flags & MPIC_PRIMARY)
+	if (!(mpic->flags & MPIC_SECONDARY))
 		cpu = hard_smp_processor_id();
 
 	return cpu;
@@ -990,7 +990,7 @@ static int mpic_host_map(struct irq_host *h, unsigned int virq,
 
 #ifdef CONFIG_SMP
 	else if (hw >= mpic->ipi_vecs[0]) {
-		WARN_ON(!(mpic->flags & MPIC_PRIMARY));
+		WARN_ON(mpic->flags & MPIC_SECONDARY);
 
 		DBG("mpic: mapping as IPI\n");
 		irq_set_chip_data(virq, mpic);
@@ -1001,7 +1001,7 @@ static int mpic_host_map(struct irq_host *h, unsigned int virq,
 #endif /* CONFIG_SMP */
 
 	if (hw >= mpic->timer_vecs[0] && hw <= mpic->timer_vecs[7]) {
-		WARN_ON(!(mpic->flags & MPIC_PRIMARY));
+		WARN_ON(mpic->flags & MPIC_SECONDARY);
 
 		DBG("mpic: mapping as timer\n");
 		irq_set_chip_data(virq, mpic);
@@ -1184,12 +1184,12 @@ struct mpic * __init mpic_alloc(struct device_node *node,
 
 	mpic->hc_irq = mpic_irq_chip;
 	mpic->hc_irq.name = name;
-	if (flags & MPIC_PRIMARY)
+	if (!(flags & MPIC_SECONDARY))
 		mpic->hc_irq.irq_set_affinity = mpic_set_affinity;
 #ifdef CONFIG_MPIC_U3_HT_IRQS
 	mpic->hc_ht_irq = mpic_irq_ht_chip;
 	mpic->hc_ht_irq.name = name;
-	if (flags & MPIC_PRIMARY)
+	if (!(flags & MPIC_SECONDARY))
 		mpic->hc_ht_irq.irq_set_affinity = mpic_set_affinity;
 #endif /* CONFIG_MPIC_U3_HT_IRQS */
 
@@ -1375,7 +1375,7 @@ struct mpic * __init mpic_alloc(struct device_node *node,
 	mpic->next = mpics;
 	mpics = mpic;
 
-	if (flags & MPIC_PRIMARY) {
+	if (!(flags & MPIC_SECONDARY)) {
 		mpic_primary = mpic;
 		irq_set_default_host(mpic->irqhost);
 	}
@@ -1450,7 +1450,7 @@ void __init mpic_init(struct mpic *mpic)
 
 	/* Do the HT PIC fixups on U3 broken mpic */
 	DBG("MPIC flags: %x\n", mpic->flags);
-	if ((mpic->flags & MPIC_U3_HT_IRQS) && (mpic->flags & MPIC_PRIMARY)) {
+	if ((mpic->flags & MPIC_U3_HT_IRQS) && !(mpic->flags & MPIC_SECONDARY)) {
 		mpic_scan_ht_pics(mpic);
 		mpic_u3msi_init(mpic);
 	}
-- 
1.7.2.5
