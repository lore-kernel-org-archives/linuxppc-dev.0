Return-Path: <dbaryshkov@gmail.com>
Received: from mail-ww0-f45.google.com (mail-ww0-f45.google.com [74.125.82.45])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 400F0B71CA
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Nov 2011 04:56:49 +1100 (EST)
Received: by wwf10 with SMTP id 10so2764655wwf.14
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2011 09:56:45 -0800 (PST)
From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/6] powerpc/85xx: separate cpm2 pic init
Date: Thu, 17 Nov 2011 21:56:16 +0400
Message-Id: <1321552581-29773-1-git-send-email-dbaryshkov@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Separate handling of CPM2 PIC initialization to mpc85xx_cpm2_pic_init()
function.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/powerpc/platforms/85xx/Makefile         |    2 +
 arch/powerpc/platforms/85xx/ksi8560.c        |   29 +--------------
 arch/powerpc/platforms/85xx/mpc8536_ds.c     |    2 +
 arch/powerpc/platforms/85xx/mpc85xx.h        |    9 +++++
 arch/powerpc/platforms/85xx/mpc85xx_ads.c    |   34 ++----------------
 arch/powerpc/platforms/85xx/mpc85xx_cds.c    |    2 +
 arch/powerpc/platforms/85xx/mpc85xx_common.c |   49 ++++++++++++++++++++++++++
 arch/powerpc/platforms/85xx/mpc85xx_ds.c     |    2 +
 arch/powerpc/platforms/85xx/mpc85xx_mds.c    |    2 +
 arch/powerpc/platforms/85xx/mpc85xx_rdb.c    |    2 +
 arch/powerpc/platforms/85xx/p1022_ds.c       |    2 +
 arch/powerpc/platforms/85xx/sbc8560.c        |   34 ++----------------
 arch/powerpc/platforms/85xx/socrates.c       |    1 +
 arch/powerpc/platforms/85xx/stx_gp3.c        |   37 ++------------------
 arch/powerpc/platforms/85xx/tqm85xx.c        |   37 ++------------------
 arch/powerpc/platforms/85xx/xes_mpc85xx.c    |    2 +
 16 files changed, 89 insertions(+), 157 deletions(-)
 create mode 100644 arch/powerpc/platforms/85xx/mpc85xx.h
 create mode 100644 arch/powerpc/platforms/85xx/mpc85xx_common.c

diff --git a/arch/powerpc/platforms/85xx/Makefile b/arch/powerpc/platforms/85xx/Makefile
index bc5acb9..b6beec8 100644
--- a/arch/powerpc/platforms/85xx/Makefile
+++ b/arch/powerpc/platforms/85xx/Makefile
@@ -3,6 +3,8 @@
 #
 obj-$(CONFIG_SMP) += smp.o
 
+obj-y += mpc85xx_common.o
+
 obj-$(CONFIG_MPC8540_ADS) += mpc85xx_ads.o
 obj-$(CONFIG_MPC8560_ADS) += mpc85xx_ads.o
 obj-$(CONFIG_MPC85xx_CDS) += mpc85xx_cds.o
diff --git a/arch/powerpc/platforms/85xx/ksi8560.c b/arch/powerpc/platforms/85xx/ksi8560.c
index c46f935..bf9b1e5 100644
--- a/arch/powerpc/platforms/85xx/ksi8560.c
+++ b/arch/powerpc/platforms/85xx/ksi8560.c
@@ -35,6 +35,7 @@
 #include <asm/cpm2.h>
 #include <sysdev/cpm2_pic.h>
 
+#include "mpc85xx.h"
 
 #define KSI8560_CPLD_HVR		0x04 /* Hardware Version Register */
 #define KSI8560_CPLD_PVR		0x08 /* PLD Version Register */
@@ -54,25 +55,11 @@ static void machine_restart(char *cmd)
 	for (;;);
 }
 
-static void cpm2_cascade(unsigned int irq, struct irq_desc *desc)
-{
-	struct irq_chip *chip = irq_desc_get_chip(desc);
-	int cascade_irq;
-
-	while ((cascade_irq = cpm2_get_irq()) >= 0)
-		generic_handle_irq(cascade_irq);
-
-	chip->irq_eoi(&desc->irq_data);
-}
-
 static void __init ksi8560_pic_init(void)
 {
 	struct mpic *mpic;
 	struct resource r;
 	struct device_node *np;
-#ifdef CONFIG_CPM2
-	int irq;
-#endif
 
 	np = of_find_node_by_type(NULL, "open-pic");
 
@@ -95,19 +82,7 @@ static void __init ksi8560_pic_init(void)
 
 	mpic_init(mpic);
 
-#ifdef CONFIG_CPM2
-	/* Setup CPM2 PIC */
-	np = of_find_compatible_node(NULL, NULL, "fsl,cpm2-pic");
-	if (np == NULL) {
-		printk(KERN_ERR "PIC init: can not find fsl,cpm2-pic node\n");
-		return;
-	}
-	irq = irq_of_parse_and_map(np, 0);
-
-	cpm2_pic_init(np);
-	of_node_put(np);
-	irq_set_chained_handler(irq, cpm2_cascade);
-#endif
+	mpc85xx_cpm2_pic_init();
 }
 
 #ifdef CONFIG_CPM2
diff --git a/arch/powerpc/platforms/85xx/mpc8536_ds.c b/arch/powerpc/platforms/85xx/mpc8536_ds.c
index f79f2f1..6a4b2c1 100644
--- a/arch/powerpc/platforms/85xx/mpc8536_ds.c
+++ b/arch/powerpc/platforms/85xx/mpc8536_ds.c
@@ -32,6 +32,8 @@
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
 
+#include "mpc85xx.h"
+
 void __init mpc8536_ds_pic_init(void)
 {
 	struct mpic *mpic;
diff --git a/arch/powerpc/platforms/85xx/mpc85xx.h b/arch/powerpc/platforms/85xx/mpc85xx.h
new file mode 100644
index 0000000..fa55e8b
--- /dev/null
+++ b/arch/powerpc/platforms/85xx/mpc85xx.h
@@ -0,0 +1,9 @@
+#ifndef MPC85xx_H
+#define MPC85xx_H
+#ifdef CONFIG_CPM2
+extern void mpc85xx_cpm2_pic_init(void);
+#else
+static inline void __init mpc85xx_cpm2_pic_init(void) {}
+#endif /* CONFIG_CPM2 */
+
+#endif
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ads.c b/arch/powerpc/platforms/85xx/mpc85xx_ads.c
index 3b2c9bb..8b8f7a2 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ads.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ads.c
@@ -35,6 +35,8 @@
 #include <sysdev/cpm2_pic.h>
 #endif
 
+#include "mpc85xx.h"
+
 #ifdef CONFIG_PCI
 static int mpc85xx_exclude_device(struct pci_controller *hose,
 				   u_char bus, u_char devfn)
@@ -46,29 +48,11 @@ static int mpc85xx_exclude_device(struct pci_controller *hose,
 }
 #endif /* CONFIG_PCI */
 
-#ifdef CONFIG_CPM2
-
-static void cpm2_cascade(unsigned int irq, struct irq_desc *desc)
-{
-	struct irq_chip *chip = irq_desc_get_chip(desc);
-	int cascade_irq;
-
-	while ((cascade_irq = cpm2_get_irq()) >= 0)
-		generic_handle_irq(cascade_irq);
-
-	chip->irq_eoi(&desc->irq_data);
-}
-
-#endif /* CONFIG_CPM2 */
-
 static void __init mpc85xx_ads_pic_init(void)
 {
 	struct mpic *mpic;
 	struct resource r;
 	struct device_node *np = NULL;
-#ifdef CONFIG_CPM2
-	int irq;
-#endif
 
 	np = of_find_node_by_type(np, "open-pic");
 	if (!np) {
@@ -90,19 +74,7 @@ static void __init mpc85xx_ads_pic_init(void)
 
 	mpic_init(mpic);
 
-#ifdef CONFIG_CPM2
-	/* Setup CPM2 PIC */
-	np = of_find_compatible_node(NULL, NULL, "fsl,cpm2-pic");
-	if (np == NULL) {
-		printk(KERN_ERR "PIC init: can not find fsl,cpm2-pic node\n");
-		return;
-	}
-	irq = irq_of_parse_and_map(np, 0);
-
-	cpm2_pic_init(np);
-	of_node_put(np);
-	irq_set_chained_handler(irq, cpm2_cascade);
-#endif
+	mpc85xx_cpm2_pic_init();
 }
 
 /*
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_cds.c b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
index 2bf9978..93bf18a 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_cds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
@@ -47,6 +47,8 @@
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
 
+#include "mpc85xx.h"
+
 /* CADMUS info */
 /* xxx - galak, move into device tree */
 #define CADMUS_BASE (0xf8004000)
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_common.c b/arch/powerpc/platforms/85xx/mpc85xx_common.c
new file mode 100644
index 0000000..49d781c
--- /dev/null
+++ b/arch/powerpc/platforms/85xx/mpc85xx_common.c
@@ -0,0 +1,49 @@
+/*
+ * Routines common to most mpc85xx-based boards.
+ *
+ * This is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/of_platform.h>
+
+#include <sysdev/cpm2_pic.h>
+
+#include "mpc85xx.h"
+
+#ifdef CONFIG_CPM2
+static void cpm2_cascade(unsigned int irq, struct irq_desc *desc)
+{
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	int cascade_irq;
+
+	while ((cascade_irq = cpm2_get_irq()) >= 0)
+		generic_handle_irq(cascade_irq);
+
+	chip->irq_eoi(&desc->irq_data);
+}
+
+
+void __init mpc85xx_cpm2_pic_init(void)
+{
+	struct device_node *np;
+	int irq;
+
+	/* Setup CPM2 PIC */
+	np = of_find_compatible_node(NULL, NULL, "fsl,cpm2-pic");
+	if (np == NULL) {
+		printk(KERN_ERR "PIC init: can not find fsl,cpm2-pic node\n");
+		return;
+	}
+	irq = irq_of_parse_and_map(np, 0);
+	if (irq == NO_IRQ) {
+		of_node_put(np);
+		printk(KERN_ERR "PIC init: got no IRQ for cpm cascade\n");
+		return;
+	}
+
+	cpm2_pic_init(np);
+	of_node_put(np);
+	irq_set_chained_handler(irq, cpm2_cascade);
+}
+#endif
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ds.c b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
index 1b9a8cf..55075b9 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
@@ -36,6 +36,8 @@
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
 
+#include "mpc85xx.h"
+
 #undef DEBUG
 
 #ifdef DEBUG
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_mds.c b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
index 973b3f4..2ee487a 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_mds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
@@ -53,6 +53,8 @@
 #include <asm/mpic.h>
 #include <asm/swiotlb.h>
 
+#include "mpc85xx.h"
+
 #undef DEBUG
 #ifdef DEBUG
 #define DBG(fmt...) udbg_printf(fmt)
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
index f5ff911..824d2b6 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
@@ -30,6 +30,8 @@
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
 
+#include "mpc85xx.h"
+
 #undef DEBUG
 
 #ifdef DEBUG
diff --git a/arch/powerpc/platforms/85xx/p1022_ds.c b/arch/powerpc/platforms/85xx/p1022_ds.c
index 6a0b973..00d93a4 100644
--- a/arch/powerpc/platforms/85xx/p1022_ds.c
+++ b/arch/powerpc/platforms/85xx/p1022_ds.c
@@ -27,6 +27,8 @@
 #include <sysdev/fsl_pci.h>
 #include <asm/fsl_guts.h>
 
+#include "mpc85xx.h"
+
 #if defined(CONFIG_FB_FSL_DIU) || defined(CONFIG_FB_FSL_DIU_MODULE)
 
 /*
diff --git a/arch/powerpc/platforms/85xx/sbc8560.c b/arch/powerpc/platforms/85xx/sbc8560.c
index cebd786..43711f8 100644
--- a/arch/powerpc/platforms/85xx/sbc8560.c
+++ b/arch/powerpc/platforms/85xx/sbc8560.c
@@ -32,34 +32,18 @@
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
 
+#include "mpc85xx.h"
+
 #ifdef CONFIG_CPM2
 #include <asm/cpm2.h>
 #include <sysdev/cpm2_pic.h>
 #endif
 
-#ifdef CONFIG_CPM2
-
-static void cpm2_cascade(unsigned int irq, struct irq_desc *desc)
-{
-	struct irq_chip *chip = irq_desc_get_chip(desc);
-	int cascade_irq;
-
-	while ((cascade_irq = cpm2_get_irq()) >= 0)
-		generic_handle_irq(cascade_irq);
-
-	chip->irq_eoi(&desc->irq_data);
-}
-
-#endif /* CONFIG_CPM2 */
-
 static void __init sbc8560_pic_init(void)
 {
 	struct mpic *mpic;
 	struct resource r;
 	struct device_node *np = NULL;
-#ifdef CONFIG_CPM2
-	int irq;
-#endif
 
 	np = of_find_node_by_type(np, "open-pic");
 	if (!np) {
@@ -81,19 +65,7 @@ static void __init sbc8560_pic_init(void)
 
 	mpic_init(mpic);
 
-#ifdef CONFIG_CPM2
-	/* Setup CPM2 PIC */
-	np = of_find_compatible_node(NULL, NULL, "fsl,cpm2-pic");
-	if (np == NULL) {
-		printk(KERN_ERR "PIC init: can not find fsl,cpm2-pic node\n");
-		return;
-	}
-	irq = irq_of_parse_and_map(np, 0);
-
-	cpm2_pic_init(np);
-	of_node_put(np);
-	irq_set_chained_handler(irq, cpm2_cascade);
-#endif
+	mpc85xx_cpm2_pic_init();
 }
 
 /*
diff --git a/arch/powerpc/platforms/85xx/socrates.c b/arch/powerpc/platforms/85xx/socrates.c
index 747d8fb..9d0fc28 100644
--- a/arch/powerpc/platforms/85xx/socrates.c
+++ b/arch/powerpc/platforms/85xx/socrates.c
@@ -41,6 +41,7 @@
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
 
+#include "mpc85xx.h"
 #include "socrates_fpga_pic.h"
 
 static void __init socrates_pic_init(void)
diff --git a/arch/powerpc/platforms/85xx/stx_gp3.c b/arch/powerpc/platforms/85xx/stx_gp3.c
index 5387e9f..d24192b 100644
--- a/arch/powerpc/platforms/85xx/stx_gp3.c
+++ b/arch/powerpc/platforms/85xx/stx_gp3.c
@@ -40,20 +40,10 @@
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
 
+#include "mpc85xx.h"
+
 #ifdef CONFIG_CPM2
 #include <asm/cpm2.h>
-#include <sysdev/cpm2_pic.h>
-
-static void cpm2_cascade(unsigned int irq, struct irq_desc *desc)
-{
-	struct irq_chip *chip = irq_desc_get_chip(desc);
-	int cascade_irq;
-
-	while ((cascade_irq = cpm2_get_irq()) >= 0)
-		generic_handle_irq(cascade_irq);
-
-	chip->irq_eoi(&desc->irq_data);
-}
 #endif /* CONFIG_CPM2 */
 
 static void __init stx_gp3_pic_init(void)
@@ -61,9 +51,6 @@ static void __init stx_gp3_pic_init(void)
 	struct mpic *mpic;
 	struct resource r;
 	struct device_node *np;
-#ifdef CONFIG_CPM2
-	int irq;
-#endif
 
 	np = of_find_node_by_type(NULL, "open-pic");
 	if (!np) {
@@ -85,25 +72,7 @@ static void __init stx_gp3_pic_init(void)
 
 	mpic_init(mpic);
 
-#ifdef CONFIG_CPM2
-	/* Setup CPM2 PIC */
-	np = of_find_compatible_node(NULL, NULL, "fsl,cpm2-pic");
-	if (np == NULL) {
-		printk(KERN_ERR "PIC init: can not find fsl,cpm2-pic node\n");
-		return;
-	}
-	irq = irq_of_parse_and_map(np, 0);
-
-	if (irq == NO_IRQ) {
-		of_node_put(np);
-		printk(KERN_ERR "PIC init: got no IRQ for cpm cascade\n");
-		return;
-	}
-
-	cpm2_pic_init(np);
-	of_node_put(np);
-	irq_set_chained_handler(irq, cpm2_cascade);
-#endif
+	mpc85xx_cpm2_pic_init();
 }
 
 /*
diff --git a/arch/powerpc/platforms/85xx/tqm85xx.c b/arch/powerpc/platforms/85xx/tqm85xx.c
index 325de77..b9e53cc 100644
--- a/arch/powerpc/platforms/85xx/tqm85xx.c
+++ b/arch/powerpc/platforms/85xx/tqm85xx.c
@@ -38,20 +38,10 @@
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
 
+#include "mpc85xx.h"
+
 #ifdef CONFIG_CPM2
 #include <asm/cpm2.h>
-#include <sysdev/cpm2_pic.h>
-
-static void cpm2_cascade(unsigned int irq, struct irq_desc *desc)
-{
-	struct irq_chip *chip = irq_desc_get_chip(desc);
-	int cascade_irq;
-
-	while ((cascade_irq = cpm2_get_irq()) >= 0)
-		generic_handle_irq(cascade_irq);
-
-	chip->irq_eoi(&desc->irq_data);
-}
 #endif /* CONFIG_CPM2 */
 
 static void __init tqm85xx_pic_init(void)
@@ -59,9 +49,6 @@ static void __init tqm85xx_pic_init(void)
 	struct mpic *mpic;
 	struct resource r;
 	struct device_node *np;
-#ifdef CONFIG_CPM2
-	int irq;
-#endif
 
 	np = of_find_node_by_type(NULL, "open-pic");
 	if (!np) {
@@ -83,25 +70,7 @@ static void __init tqm85xx_pic_init(void)
 
 	mpic_init(mpic);
 
-#ifdef CONFIG_CPM2
-	/* Setup CPM2 PIC */
-	np = of_find_compatible_node(NULL, NULL, "fsl,cpm2-pic");
-	if (np == NULL) {
-		printk(KERN_ERR "PIC init: can not find fsl,cpm2-pic node\n");
-		return;
-	}
-	irq = irq_of_parse_and_map(np, 0);
-
-	if (irq == NO_IRQ) {
-		of_node_put(np);
-		printk(KERN_ERR "PIC init: got no IRQ for cpm cascade\n");
-		return;
-	}
-
-	cpm2_pic_init(np);
-	of_node_put(np);
-	irq_set_chained_handler(irq, cpm2_cascade);
-#endif
+	mpc85xx_cpm2_pic_init();
 }
 
 /*
diff --git a/arch/powerpc/platforms/85xx/xes_mpc85xx.c b/arch/powerpc/platforms/85xx/xes_mpc85xx.c
index a9dc5e7..ab7025a 100644
--- a/arch/powerpc/platforms/85xx/xes_mpc85xx.c
+++ b/arch/powerpc/platforms/85xx/xes_mpc85xx.c
@@ -33,6 +33,8 @@
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
 
+#include "mpc85xx.h"
+
 /* A few bit definitions needed for fixups on some boards */
 #define MPC85xx_L2CTL_L2E		0x80000000 /* L2 enable */
 #define MPC85xx_L2CTL_L2I		0x40000000 /* L2 flash invalidate */
-- 
1.7.7.1
