Return-Path: <dbaryshkov@gmail.com>
Received: from mail-ey0-f177.google.com (mail-ey0-f177.google.com
	[209.85.215.177]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 32DAEB7780
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 19 Jul 2011 18:55:09 +1000 (EST)
Received: by mail-ey0-f177.google.com with SMTP id 6so2714299eyh.36
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 19 Jul 2011 01:55:09 -0700 (PDT)
From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
To: Linux PPC Development <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 14/14] 85xx: separate cpm2 pic init
Date: Tue, 19 Jul 2011 12:53:51 +0400
Message-Id: <1311065631-3429-15-git-send-email-dbaryshkov@gmail.com>
In-Reply-To: <1311065631-3429-1-git-send-email-dbaryshkov@gmail.com>
References: <1311065631-3429-1-git-send-email-dbaryshkov@gmail.com>
Cc: Paul Mackerras <paulus@samba.org>
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
 arch/powerpc/platforms/85xx/ksi8560.c        |   28 +------------------
 arch/powerpc/platforms/85xx/mpc85xx.h        |    7 ++++
 arch/powerpc/platforms/85xx/mpc85xx_ads.c    |   32 +--------------------
 arch/powerpc/platforms/85xx/mpc85xx_common.c |   39 ++++++++++++++++++++++++++
 arch/powerpc/platforms/85xx/sbc8560.c        |   32 +--------------------
 arch/powerpc/platforms/85xx/tqm85xx.c        |   35 +----------------------
 6 files changed, 50 insertions(+), 123 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/ksi8560.c b/arch/powerpc/platforms/85xx/ksi8560.c
index 7657e1a..0f3e688 100644
--- a/arch/powerpc/platforms/85xx/ksi8560.c
+++ b/arch/powerpc/platforms/85xx/ksi8560.c
@@ -55,25 +55,11 @@ static void machine_restart(char *cmd)
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
 
@@ -96,19 +82,7 @@ static void __init ksi8560_pic_init(void)
 
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
diff --git a/arch/powerpc/platforms/85xx/mpc85xx.h b/arch/powerpc/platforms/85xx/mpc85xx.h
index 1a1b4eb..2aa7c5d 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx.h
+++ b/arch/powerpc/platforms/85xx/mpc85xx.h
@@ -1,4 +1,11 @@
 #ifndef MPC85xx_H
 #define MPC85xx_H
 extern int mpc85xx_common_publish_devices(void);
+
+#ifdef CONFIG_CPM2
+extern void mpc85xx_cpm2_pic_init(void);
+#else
+static inline void __init mpc85xx_cpm2_pic_init(void) {}
+#endif /* CONFIG_CPM2 */
+
 #endif
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ads.c b/arch/powerpc/platforms/85xx/mpc85xx_ads.c
index 3bc2acc..0e90422 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ads.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ads.c
@@ -48,29 +48,11 @@ static int mpc85xx_exclude_device(struct pci_controller *hose,
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
@@ -92,19 +74,7 @@ static void __init mpc85xx_ads_pic_init(void)
 
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
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_common.c b/arch/powerpc/platforms/85xx/mpc85xx_common.c
index 999567a..4fdf382 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_common.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_common.c
@@ -8,6 +8,8 @@
 #include <linux/kernel.h>
 #include <linux/of_platform.h>
 
+#include <sysdev/cpm2_pic.h>
+
 #include "mpc85xx.h"
 
 static struct of_device_id __initdata mpc85xx_common_ids[] = {
@@ -24,3 +26,40 @@ int __init mpc85xx_common_publish_devices(void)
 {
 	return of_platform_bus_probe(NULL, mpc85xx_common_ids, NULL);
 }
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
diff --git a/arch/powerpc/platforms/85xx/sbc8560.c b/arch/powerpc/platforms/85xx/sbc8560.c
index bbb656f..f3b4737 100644
--- a/arch/powerpc/platforms/85xx/sbc8560.c
+++ b/arch/powerpc/platforms/85xx/sbc8560.c
@@ -39,29 +39,11 @@
 
 #include "mpc85xx.h"
 
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
@@ -83,19 +65,7 @@ static void __init sbc8560_pic_init(void)
 
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
diff --git a/arch/powerpc/platforms/85xx/tqm85xx.c b/arch/powerpc/platforms/85xx/tqm85xx.c
index 19e711f..2418bf8 100644
--- a/arch/powerpc/platforms/85xx/tqm85xx.c
+++ b/arch/powerpc/platforms/85xx/tqm85xx.c
@@ -42,18 +42,6 @@
 
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
@@ -61,9 +49,6 @@ static void __init tqm85xx_pic_init(void)
 	struct mpic *mpic;
 	struct resource r;
 	struct device_node *np;
-#ifdef CONFIG_CPM2
-	int irq;
-#endif
 
 	np = of_find_node_by_type(NULL, "open-pic");
 	if (!np) {
@@ -85,25 +70,7 @@ static void __init tqm85xx_pic_init(void)
 
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
-- 
1.7.2.5
