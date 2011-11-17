Return-Path: <dbaryshkov@gmail.com>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
 [74.125.82.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 1189DB732B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Nov 2011 04:56:53 +1100 (EST)
Received: by wyg36 with SMTP id 36so2385152wyg.38
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2011 09:56:49 -0800 (PST)
From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/6] powerpc/85xx: separate MPIC handling code
Date: Thu, 17 Nov 2011 21:56:18 +0400
Message-Id: <1321552581-29773-3-git-send-email-dbaryshkov@gmail.com>
In-Reply-To: <1321552581-29773-1-git-send-email-dbaryshkov@gmail.com>
References: <1321552581-29773-1-git-send-email-dbaryshkov@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

All mpc85xx boards deal with MPIC initialization in more or less the
same way. The only difrerences are some flags (WANTS_RESET,
BROKEN_FRR_NIRQS, SINGLE_DEST_CPU), and some bugs like leaking device
node counter, etc. To minimize problems, switch all boards to use one
single instance of code.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/powerpc/platforms/85xx/corenet_ds.c     |   29 +-------------
 arch/powerpc/platforms/85xx/ksi8560.c        |   25 +------------
 arch/powerpc/platforms/85xx/mpc8536_ds.c     |   25 +------------
 arch/powerpc/platforms/85xx/mpc85xx.h        |    1 +
 arch/powerpc/platforms/85xx/mpc85xx_ads.c    |   24 +-----------
 arch/powerpc/platforms/85xx/mpc85xx_cds.c    |   27 +-------------
 arch/powerpc/platforms/85xx/mpc85xx_common.c |   43 +++++++++++++++++++++
 arch/powerpc/platforms/85xx/mpc85xx_ds.c     |   53 +++++++-------------------
 arch/powerpc/platforms/85xx/mpc85xx_mds.c    |   23 +-----------
 arch/powerpc/platforms/85xx/mpc85xx_rdb.c    |   37 +----------------
 arch/powerpc/platforms/85xx/p1010rdb.c       |   28 +------------
 arch/powerpc/platforms/85xx/p1022_ds.c       |   27 +-------------
 arch/powerpc/platforms/85xx/p1023_rds.c      |   28 +------------
 arch/powerpc/platforms/85xx/sbc8548.c        |   27 +-------------
 arch/powerpc/platforms/85xx/sbc8560.c        |   24 +-----------
 arch/powerpc/platforms/85xx/socrates.c       |   22 +----------
 arch/powerpc/platforms/85xx/stx_gp3.c        |   24 +-----------
 arch/powerpc/platforms/85xx/tqm85xx.c        |   24 +-----------
 arch/powerpc/platforms/85xx/xes_mpc85xx.c    |   25 +------------
 19 files changed, 82 insertions(+), 434 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/corenet_ds.c b/arch/powerpc/platforms/85xx/corenet_ds.c
index 802ad11..b4abc01 100644
--- a/arch/powerpc/platforms/85xx/corenet_ds.c
+++ b/arch/powerpc/platforms/85xx/corenet_ds.c
@@ -32,34 +32,11 @@
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
 
+#include "mpc85xx.h"
+
 void __init corenet_ds_pic_init(void)
 {
-	struct mpic *mpic;
-	struct resource r;
-	struct device_node *np = NULL;
-	unsigned int flags = MPIC_PRIMARY | MPIC_BIG_ENDIAN |
-				MPIC_BROKEN_FRR_NIRQS | MPIC_SINGLE_DEST_CPU;
-
-	np = of_find_node_by_type(np, "open-pic");
-
-	if (np == NULL) {
-		printk(KERN_ERR "Could not find open-pic node\n");
-		return;
-	}
-
-	if (of_address_to_resource(np, 0, &r)) {
-		printk(KERN_ERR "Failed to map mpic register space\n");
-		of_node_put(np);
-		return;
-	}
-
-	if (ppc_md.get_irq == mpic_get_coreint_irq)
-		flags |= MPIC_ENABLE_COREINT;
-
-	mpic = mpic_alloc(np, r.start, flags, 0, 256, " OpenPIC  ");
-	BUG_ON(mpic == NULL);
-
-	mpic_init(mpic);
+	mpc85xx_init_mpic(0, 1, 1);
 }
 
 /*
diff --git a/arch/powerpc/platforms/85xx/ksi8560.c b/arch/powerpc/platforms/85xx/ksi8560.c
index 0f3e688..2f5c3bb 100644
--- a/arch/powerpc/platforms/85xx/ksi8560.c
+++ b/arch/powerpc/platforms/85xx/ksi8560.c
@@ -57,30 +57,7 @@ static void machine_restart(char *cmd)
 
 static void __init ksi8560_pic_init(void)
 {
-	struct mpic *mpic;
-	struct resource r;
-	struct device_node *np;
-
-	np = of_find_node_by_type(NULL, "open-pic");
-
-	if (np == NULL) {
-		printk(KERN_ERR "Could not find open-pic node\n");
-		return;
-	}
-
-	if (of_address_to_resource(np, 0, &r)) {
-		printk(KERN_ERR "Could not map mpic register space\n");
-		of_node_put(np);
-		return;
-	}
-
-	mpic = mpic_alloc(np, r.start,
-			MPIC_PRIMARY | MPIC_WANTS_RESET | MPIC_BIG_ENDIAN,
-			0, 256, " OpenPIC  ");
-	BUG_ON(mpic == NULL);
-	of_node_put(np);
-
-	mpic_init(mpic);
+	mpc85xx_init_mpic(1, 0, 0);
 
 	mpc85xx_cpm2_pic_init();
 }
diff --git a/arch/powerpc/platforms/85xx/mpc8536_ds.c b/arch/powerpc/platforms/85xx/mpc8536_ds.c
index 9ee6455..223bb7a 100644
--- a/arch/powerpc/platforms/85xx/mpc8536_ds.c
+++ b/arch/powerpc/platforms/85xx/mpc8536_ds.c
@@ -36,30 +36,7 @@
 
 void __init mpc8536_ds_pic_init(void)
 {
-	struct mpic *mpic;
-	struct resource r;
-	struct device_node *np;
-
-	np = of_find_node_by_type(NULL, "open-pic");
-	if (np == NULL) {
-		printk(KERN_ERR "Could not find open-pic node\n");
-		return;
-	}
-
-	if (of_address_to_resource(np, 0, &r)) {
-		printk(KERN_ERR "Failed to map mpic register space\n");
-		of_node_put(np);
-		return;
-	}
-
-	mpic = mpic_alloc(np, r.start,
-			  MPIC_PRIMARY | MPIC_WANTS_RESET |
-			  MPIC_BIG_ENDIAN | MPIC_BROKEN_FRR_NIRQS,
-			0, 256, " OpenPIC  ");
-	BUG_ON(mpic == NULL);
-	of_node_put(np);
-
-	mpic_init(mpic);
+	mpc85xx_init_mpic(1, 1, 0);
 }
 
 /*
diff --git a/arch/powerpc/platforms/85xx/mpc85xx.h b/arch/powerpc/platforms/85xx/mpc85xx.h
index 2aa7c5d..466923b 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx.h
+++ b/arch/powerpc/platforms/85xx/mpc85xx.h
@@ -1,6 +1,7 @@
 #ifndef MPC85xx_H
 #define MPC85xx_H
 extern int mpc85xx_common_publish_devices(void);
+extern void mpc85xx_init_mpic(bool reset, bool broken_frr, bool singledest);
 
 #ifdef CONFIG_CPM2
 extern void mpc85xx_cpm2_pic_init(void);
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ads.c b/arch/powerpc/platforms/85xx/mpc85xx_ads.c
index 986554b..37edba4 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ads.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ads.c
@@ -50,29 +50,7 @@ static int mpc85xx_exclude_device(struct pci_controller *hose,
 
 static void __init mpc85xx_ads_pic_init(void)
 {
-	struct mpic *mpic;
-	struct resource r;
-	struct device_node *np = NULL;
-
-	np = of_find_node_by_type(np, "open-pic");
-	if (!np) {
-		printk(KERN_ERR "Could not find open-pic node\n");
-		return;
-	}
-
-	if (of_address_to_resource(np, 0, &r)) {
-		printk(KERN_ERR "Could not map mpic register space\n");
-		of_node_put(np);
-		return;
-	}
-
-	mpic = mpic_alloc(np, r.start,
-			MPIC_PRIMARY | MPIC_WANTS_RESET | MPIC_BIG_ENDIAN,
-			0, 256, " OpenPIC  ");
-	BUG_ON(mpic == NULL);
-	of_node_put(np);
-
-	mpic_init(mpic);
+	mpc85xx_init_mpic(1, 0, 0);
 
 	mpc85xx_cpm2_pic_init();
 }
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_cds.c b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
index a268f43..aa42202 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_cds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
@@ -188,32 +188,7 @@ static struct irqaction mpc85xxcds_8259_irqaction = {
 
 static void __init mpc85xx_cds_pic_init(void)
 {
-	struct mpic *mpic;
-	struct resource r;
-	struct device_node *np = NULL;
-
-	np = of_find_node_by_type(np, "open-pic");
-
-	if (np == NULL) {
-		printk(KERN_ERR "Could not find open-pic node\n");
-		return;
-	}
-
-	if (of_address_to_resource(np, 0, &r)) {
-		printk(KERN_ERR "Failed to map mpic register space\n");
-		of_node_put(np);
-		return;
-	}
-
-	mpic = mpic_alloc(np, r.start,
-			MPIC_PRIMARY | MPIC_WANTS_RESET | MPIC_BIG_ENDIAN,
-			0, 256, " OpenPIC  ");
-	BUG_ON(mpic == NULL);
-
-	/* Return the mpic node */
-	of_node_put(np);
-
-	mpic_init(mpic);
+	mpc85xx_init_mpic(1, 0, 0);
 }
 
 #if defined(CONFIG_PPC_I8259) && defined(CONFIG_PCI)
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_common.c b/arch/powerpc/platforms/85xx/mpc85xx_common.c
index fe40668..7579e24 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_common.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_common.c
@@ -7,6 +7,9 @@
  */
 #include <linux/of_platform.h>
 
+#include <asm/machdep.h>
+#include <asm/mpic.h>
+
 #include <sysdev/cpm2_pic.h>
 
 #include "mpc85xx.h"
@@ -63,3 +66,43 @@ void __init mpc85xx_cpm2_pic_init(void)
 	irq_set_chained_handler(irq, cpm2_cascade);
 }
 #endif
+
+
+void __init mpc85xx_init_mpic(bool reset, bool broken_frr, bool singledest)
+{
+	struct mpic *mpic;
+	struct resource r;
+	struct device_node *np = NULL;
+	unsigned int flags = MPIC_PRIMARY | MPIC_BIG_ENDIAN |
+				MPIC_BROKEN_FRR_NIRQS | MPIC_SINGLE_DEST_CPU;
+
+	np = of_find_node_by_type(np, "open-pic");
+
+	if (np == NULL) {
+		printk(KERN_ERR "Could not find open-pic node\n");
+		return;
+	}
+
+	if (of_address_to_resource(np, 0, &r)) {
+		printk(KERN_ERR "Failed to map mpic register space\n");
+		of_node_put(np);
+		return;
+	}
+
+	if (reset)
+		flags |= MPIC_WANTS_RESET;
+	if (broken_frr)
+		flags |= MPIC_BROKEN_FRR_NIRQS;
+	if (singledest)
+		flags |= MPIC_SINGLE_DEST_CPU;
+	if (ppc_md.get_irq == mpic_get_coreint_irq)
+		flags |= MPIC_ENABLE_COREINT;
+
+	mpic = mpic_alloc(np, r.start, flags, 0, 256, " OpenPIC  ");
+	BUG_ON(mpic == NULL);
+
+	/* Return the mpic node */
+	of_node_put(np);
+
+	mpic_init(mpic);
+}
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ds.c b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
index 2113120..7e535da 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
@@ -57,51 +57,13 @@ static void mpc85xx_8259_cascade(unsigned int irq, struct irq_desc *desc)
 	}
 	chip->irq_eoi(&desc->irq_data);
 }
-#endif	/* CONFIG_PPC_I8259 */
 
-void __init mpc85xx_ds_pic_init(void)
+static void __init mpc85xx_ds_i8259_init(void)
 {
-	struct mpic *mpic;
-	struct resource r;
 	struct device_node *np;
-#ifdef CONFIG_PPC_I8259
 	struct device_node *cascade_node = NULL;
 	int cascade_irq;
-#endif
-	unsigned long root = of_get_flat_dt_root();
-
-	np = of_find_node_by_type(NULL, "open-pic");
-	if (np == NULL) {
-		printk(KERN_ERR "Could not find open-pic node\n");
-		return;
-	}
-
-	if (of_address_to_resource(np, 0, &r)) {
-		printk(KERN_ERR "Failed to map mpic register space\n");
-		of_node_put(np);
-		return;
-	}
-
-	if (of_flat_dt_is_compatible(root, "fsl,MPC8572DS-CAMP")) {
-		mpic = mpic_alloc(np, r.start,
-			MPIC_PRIMARY |
-			MPIC_BIG_ENDIAN | MPIC_BROKEN_FRR_NIRQS |
-			MPIC_SINGLE_DEST_CPU,
-			0, 256, " OpenPIC  ");
-	} else {
-		mpic = mpic_alloc(np, r.start,
-			  MPIC_PRIMARY | MPIC_WANTS_RESET |
-			  MPIC_BIG_ENDIAN | MPIC_BROKEN_FRR_NIRQS |
-			  MPIC_SINGLE_DEST_CPU,
-			0, 256, " OpenPIC  ");
-	}
-
-	BUG_ON(mpic == NULL);
-	of_node_put(np);
-
-	mpic_init(mpic);
 
-#ifdef CONFIG_PPC_I8259
 	/* Initialize the i8259 controller */
 	for_each_node_by_type(np, "interrupt-controller")
 	    if (of_device_is_compatible(np, "chrp,iic")) {
@@ -126,7 +88,20 @@ void __init mpc85xx_ds_pic_init(void)
 	of_node_put(cascade_node);
 
 	irq_set_chained_handler(cascade_irq, mpc85xx_8259_cascade);
+}
+#else
+#define mpc85xx_ds_i8259_init do {} while (0)
 #endif	/* CONFIG_PPC_I8259 */
+
+void __init mpc85xx_ds_pic_init(void)
+{
+	unsigned long root = of_get_flat_dt_root();
+
+	mpc85xx_init_mpic(
+		!of_flat_dt_is_compatible(root, "fsl,MPC8572DS-CAMP"),
+		1, 1);
+
+	mpc85xx_ds_i8259_init();
 }
 
 #ifdef CONFIG_PCI
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_mds.c b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
index 3beb00b..c49d31f 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_mds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
@@ -441,28 +441,7 @@ machine_arch_initcall(p1021_mds, swiotlb_setup_bus_notifier);
 
 static void __init mpc85xx_mds_pic_init(void)
 {
-	struct mpic *mpic;
-	struct resource r;
-	struct device_node *np = NULL;
-
-	np = of_find_node_by_type(NULL, "open-pic");
-	if (!np)
-		return;
-
-	if (of_address_to_resource(np, 0, &r)) {
-		printk(KERN_ERR "Failed to map mpic register space\n");
-		of_node_put(np);
-		return;
-	}
-
-	mpic = mpic_alloc(np, r.start,
-			MPIC_PRIMARY | MPIC_WANTS_RESET | MPIC_BIG_ENDIAN |
-			MPIC_BROKEN_FRR_NIRQS | MPIC_SINGLE_DEST_CPU,
-			0, 256, " OpenPIC  ");
-	BUG_ON(mpic == NULL);
-	of_node_put(np);
-
-	mpic_init(mpic);
+	mpc85xx_init_mpic(1, 1, 1);
 	mpc85xx_mds_qeic_init();
 }
 
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
index 9feccbb..d9ac565 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
@@ -43,42 +43,11 @@
 
 void __init mpc85xx_rdb_pic_init(void)
 {
-	struct mpic *mpic;
-	struct resource r;
-	struct device_node *np;
 	unsigned long root = of_get_flat_dt_root();
 
-	np = of_find_node_by_type(NULL, "open-pic");
-	if (np == NULL) {
-		printk(KERN_ERR "Could not find open-pic node\n");
-		return;
-	}
-
-	if (of_address_to_resource(np, 0, &r)) {
-		printk(KERN_ERR "Failed to map mpic register space\n");
-		of_node_put(np);
-		return;
-	}
-
-	if (of_flat_dt_is_compatible(root, "fsl,MPC85XXRDB-CAMP")) {
-		mpic = mpic_alloc(np, r.start,
-			MPIC_PRIMARY |
-			MPIC_BIG_ENDIAN | MPIC_BROKEN_FRR_NIRQS |
-			MPIC_SINGLE_DEST_CPU,
-			0, 256, " OpenPIC  ");
-	} else {
-		mpic = mpic_alloc(np, r.start,
-		  MPIC_PRIMARY | MPIC_WANTS_RESET |
-		  MPIC_BIG_ENDIAN | MPIC_BROKEN_FRR_NIRQS |
-		  MPIC_SINGLE_DEST_CPU,
-		  0, 256, " OpenPIC  ");
-	}
-
-	BUG_ON(mpic == NULL);
-	of_node_put(np);
-
-	mpic_init(mpic);
-
+	mpc85xx_init_mpic(
+		!of_flat_dt_is_compatible(root, "fsl,MPC85XXRDB-CAMP"),
+		1, 1);
 }
 
 /*
diff --git a/arch/powerpc/platforms/85xx/p1010rdb.c b/arch/powerpc/platforms/85xx/p1010rdb.c
index d7387fa..9273c6a 100644
--- a/arch/powerpc/platforms/85xx/p1010rdb.c
+++ b/arch/powerpc/platforms/85xx/p1010rdb.c
@@ -28,33 +28,11 @@
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
 
+#include "mpc85xx.h"
+
 void __init p1010_rdb_pic_init(void)
 {
-	struct mpic *mpic;
-	struct resource r;
-	struct device_node *np;
-
-	np = of_find_node_by_type(NULL, "open-pic");
-	if (np == NULL) {
-		printk(KERN_ERR "Could not find open-pic node\n");
-		return;
-	}
-
-	if (of_address_to_resource(np, 0, &r)) {
-		printk(KERN_ERR "Failed to map mpic register space\n");
-		of_node_put(np);
-		return;
-	}
-
-	mpic = mpic_alloc(np, r.start, MPIC_PRIMARY | MPIC_WANTS_RESET |
-	  MPIC_BIG_ENDIAN | MPIC_BROKEN_FRR_NIRQS | MPIC_SINGLE_DEST_CPU,
-	  0, 256, " OpenPIC  ");
-
-	BUG_ON(mpic == NULL);
-	of_node_put(np);
-
-	mpic_init(mpic);
-
+	mpc85xx_init_mpic(1, 1, 1);
 }
 
 
diff --git a/arch/powerpc/platforms/85xx/p1022_ds.c b/arch/powerpc/platforms/85xx/p1022_ds.c
index cacb4d4..6a7fc02 100644
--- a/arch/powerpc/platforms/85xx/p1022_ds.c
+++ b/arch/powerpc/platforms/85xx/p1022_ds.c
@@ -242,32 +242,7 @@ int p1022ds_set_sysfs_monitor_port(int val)
 
 void __init p1022_ds_pic_init(void)
 {
-	struct mpic *mpic;
-	struct resource r;
-	struct device_node *np;
-
-	np = of_find_node_by_type(NULL, "open-pic");
-	if (!np) {
-		pr_err("Could not find open-pic node\n");
-		return;
-	}
-
-	if (of_address_to_resource(np, 0, &r)) {
-		pr_err("Failed to map mpic register space\n");
-		of_node_put(np);
-		return;
-	}
-
-	mpic = mpic_alloc(np, r.start,
-		MPIC_PRIMARY | MPIC_WANTS_RESET |
-		MPIC_BIG_ENDIAN | MPIC_BROKEN_FRR_NIRQS |
-		MPIC_SINGLE_DEST_CPU,
-		0, 256, " OpenPIC  ");
-
-	BUG_ON(mpic == NULL);
-	of_node_put(np);
-
-	mpic_init(mpic);
+	mpc85xx_init_mpic(1, 1, 1);
 }
 
 #ifdef CONFIG_SMP
diff --git a/arch/powerpc/platforms/85xx/p1023_rds.c b/arch/powerpc/platforms/85xx/p1023_rds.c
index 835e0b3..f6fc2b7 100644
--- a/arch/powerpc/platforms/85xx/p1023_rds.c
+++ b/arch/powerpc/platforms/85xx/p1023_rds.c
@@ -34,6 +34,8 @@
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
 
+#include "mpc85xx.h"
+
 /* ************************************************************************
  *
  * Setup the architecture
@@ -111,31 +113,7 @@ machine_device_initcall(p1023_rds, p1023_publish_devices);
 
 static void __init mpc85xx_rds_pic_init(void)
 {
-	struct mpic *mpic;
-	struct resource r;
-	struct device_node *np = NULL;
-
-	np = of_find_node_by_type(NULL, "open-pic");
-	if (!np) {
-		printk(KERN_ERR "Could not find open-pic node\n");
-		return;
-	}
-
-	if (of_address_to_resource(np, 0, &r)) {
-		printk(KERN_ERR "Failed to map mpic register space\n");
-		of_node_put(np);
-		return;
-	}
-
-	mpic = mpic_alloc(np, r.start,
-		MPIC_PRIMARY | MPIC_WANTS_RESET | MPIC_BIG_ENDIAN |
-		MPIC_BROKEN_FRR_NIRQS | MPIC_SINGLE_DEST_CPU,
-		0, 256, " OpenPIC  ");
-
-	BUG_ON(mpic == NULL);
-	of_node_put(np);
-
-	mpic_init(mpic);
+	mpc85xx_init_mpic(1, 1, 1);
 }
 
 static int __init p1023_rds_probe(void)
diff --git a/arch/powerpc/platforms/85xx/sbc8548.c b/arch/powerpc/platforms/85xx/sbc8548.c
index 35deaa9..862c16e 100644
--- a/arch/powerpc/platforms/85xx/sbc8548.c
+++ b/arch/powerpc/platforms/85xx/sbc8548.c
@@ -55,32 +55,7 @@ static int sbc_rev;
 
 static void __init sbc8548_pic_init(void)
 {
-	struct mpic *mpic;
-	struct resource r;
-	struct device_node *np = NULL;
-
-	np = of_find_node_by_type(np, "open-pic");
-
-	if (np == NULL) {
-		printk(KERN_ERR "Could not find open-pic node\n");
-		return;
-	}
-
-	if (of_address_to_resource(np, 0, &r)) {
-		printk(KERN_ERR "Failed to map mpic register space\n");
-		of_node_put(np);
-		return;
-	}
-
-	mpic = mpic_alloc(np, r.start,
-			MPIC_PRIMARY | MPIC_WANTS_RESET | MPIC_BIG_ENDIAN,
-			0, 256, " OpenPIC  ");
-	BUG_ON(mpic == NULL);
-
-	/* Return the mpic node */
-	of_node_put(np);
-
-	mpic_init(mpic);
+	mpc85xx_init_mpic(1, 0, 0);
 }
 
 /* Extract the HW Rev from the EPLD on the board */
diff --git a/arch/powerpc/platforms/85xx/sbc8560.c b/arch/powerpc/platforms/85xx/sbc8560.c
index e9a7ed2..b211b63 100644
--- a/arch/powerpc/platforms/85xx/sbc8560.c
+++ b/arch/powerpc/platforms/85xx/sbc8560.c
@@ -41,29 +41,7 @@
 
 static void __init sbc8560_pic_init(void)
 {
-	struct mpic *mpic;
-	struct resource r;
-	struct device_node *np = NULL;
-
-	np = of_find_node_by_type(np, "open-pic");
-	if (!np) {
-		printk(KERN_ERR "Could not find open-pic node\n");
-		return;
-	}
-
-	if (of_address_to_resource(np, 0, &r)) {
-		printk(KERN_ERR "Could not map mpic register space\n");
-		of_node_put(np);
-		return;
-	}
-
-	mpic = mpic_alloc(np, r.start,
-			MPIC_PRIMARY | MPIC_WANTS_RESET | MPIC_BIG_ENDIAN,
-			0, 256, " OpenPIC  ");
-	BUG_ON(mpic == NULL);
-	of_node_put(np);
-
-	mpic_init(mpic);
+	mpc85xx_init_mpic(1, 0, 0);
 
 	mpc85xx_cpm2_pic_init();
 }
diff --git a/arch/powerpc/platforms/85xx/socrates.c b/arch/powerpc/platforms/85xx/socrates.c
index fec496a..a390d67 100644
--- a/arch/powerpc/platforms/85xx/socrates.c
+++ b/arch/powerpc/platforms/85xx/socrates.c
@@ -46,29 +46,9 @@
 
 static void __init socrates_pic_init(void)
 {
-	struct mpic *mpic;
-	struct resource r;
 	struct device_node *np;
 
-	np = of_find_node_by_type(NULL, "open-pic");
-	if (!np) {
-		printk(KERN_ERR "Could not find open-pic node\n");
-		return;
-	}
-
-	if (of_address_to_resource(np, 0, &r)) {
-		printk(KERN_ERR "Could not map mpic register space\n");
-		of_node_put(np);
-		return;
-	}
-
-	mpic = mpic_alloc(np, r.start,
-			MPIC_PRIMARY | MPIC_WANTS_RESET | MPIC_BIG_ENDIAN,
-			0, 256, " OpenPIC  ");
-	BUG_ON(mpic == NULL);
-	of_node_put(np);
-
-	mpic_init(mpic);
+	mpc85xx_init_mpic(1, 0, 0);
 
 	np = of_find_compatible_node(NULL, NULL, "abb,socrates-fpga-pic");
 	if (!np) {
diff --git a/arch/powerpc/platforms/85xx/stx_gp3.c b/arch/powerpc/platforms/85xx/stx_gp3.c
index b44c936..cdd2d35 100644
--- a/arch/powerpc/platforms/85xx/stx_gp3.c
+++ b/arch/powerpc/platforms/85xx/stx_gp3.c
@@ -48,29 +48,7 @@
 
 static void __init stx_gp3_pic_init(void)
 {
-	struct mpic *mpic;
-	struct resource r;
-	struct device_node *np;
-
-	np = of_find_node_by_type(NULL, "open-pic");
-	if (!np) {
-		printk(KERN_ERR "Could not find open-pic node\n");
-		return;
-	}
-
-	if (of_address_to_resource(np, 0, &r)) {
-		printk(KERN_ERR "Could not map mpic register space\n");
-		of_node_put(np);
-		return;
-	}
-
-	mpic = mpic_alloc(np, r.start,
-			MPIC_PRIMARY | MPIC_WANTS_RESET | MPIC_BIG_ENDIAN,
-			0, 256, " OpenPIC  ");
-	BUG_ON(mpic == NULL);
-	of_node_put(np);
-
-	mpic_init(mpic);
+	mpc85xx_init_mpic(1, 0, 0);
 
 	mpc85xx_cpm2_pic_init();
 }
diff --git a/arch/powerpc/platforms/85xx/tqm85xx.c b/arch/powerpc/platforms/85xx/tqm85xx.c
index 2418bf8..800842b 100644
--- a/arch/powerpc/platforms/85xx/tqm85xx.c
+++ b/arch/powerpc/platforms/85xx/tqm85xx.c
@@ -46,29 +46,7 @@
 
 static void __init tqm85xx_pic_init(void)
 {
-	struct mpic *mpic;
-	struct resource r;
-	struct device_node *np;
-
-	np = of_find_node_by_type(NULL, "open-pic");
-	if (!np) {
-		printk(KERN_ERR "Could not find open-pic node\n");
-		return;
-	}
-
-	if (of_address_to_resource(np, 0, &r)) {
-		printk(KERN_ERR "Could not map mpic register space\n");
-		of_node_put(np);
-		return;
-	}
-
-	mpic = mpic_alloc(np, r.start,
-			MPIC_PRIMARY | MPIC_WANTS_RESET | MPIC_BIG_ENDIAN,
-			0, 256, " OpenPIC  ");
-	BUG_ON(mpic == NULL);
-	of_node_put(np);
-
-	mpic_init(mpic);
+	mpc85xx_init_mpic(1, 0, 0);
 
 	mpc85xx_cpm2_pic_init();
 }
diff --git a/arch/powerpc/platforms/85xx/xes_mpc85xx.c b/arch/powerpc/platforms/85xx/xes_mpc85xx.c
index 4632c1b..136b732 100644
--- a/arch/powerpc/platforms/85xx/xes_mpc85xx.c
+++ b/arch/powerpc/platforms/85xx/xes_mpc85xx.c
@@ -42,30 +42,7 @@
 
 void __init xes_mpc85xx_pic_init(void)
 {
-	struct mpic *mpic;
-	struct resource r;
-	struct device_node *np;
-
-	np = of_find_node_by_type(NULL, "open-pic");
-	if (np == NULL) {
-		printk(KERN_ERR "Could not find open-pic node\n");
-		return;
-	}
-
-	if (of_address_to_resource(np, 0, &r)) {
-		printk(KERN_ERR "Failed to map mpic register space\n");
-		of_node_put(np);
-		return;
-	}
-
-	mpic = mpic_alloc(np, r.start,
-			  MPIC_PRIMARY | MPIC_WANTS_RESET |
-			  MPIC_BIG_ENDIAN | MPIC_BROKEN_FRR_NIRQS,
-			0, 256, " OpenPIC  ");
-	BUG_ON(mpic == NULL);
-	of_node_put(np);
-
-	mpic_init(mpic);
+	mpc85xx_init_mpic(1, 1, 0);
 }
 
 static void xes_mpc85xx_configure_l2(void __iomem *l2_base)
-- 
1.7.7.1
