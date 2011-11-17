Return-Path: <dbaryshkov@gmail.com>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
 [74.125.82.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 482FBB727B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Nov 2011 04:56:57 +1100 (EST)
Received: by wyg36 with SMTP id 36so2385260wyg.38
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2011 09:56:54 -0800 (PST)
From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 5/6] powerpc/85xx: separate i8259 handling to common function
Date: Thu, 17 Nov 2011 21:56:20 +0400
Message-Id: <1321552581-29773-5-git-send-email-dbaryshkov@gmail.com>
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

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/powerpc/platforms/85xx/mpc85xx.h        |    4 +++
 arch/powerpc/platforms/85xx/mpc85xx_cds.c    |   25 +-----------------
 arch/powerpc/platforms/85xx/mpc85xx_common.c |   36 ++++++++++++++++++++++++++
 arch/powerpc/platforms/85xx/mpc85xx_ds.c     |   27 +------------------
 4 files changed, 42 insertions(+), 50 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/mpc85xx.h b/arch/powerpc/platforms/85xx/mpc85xx.h
index e2a6631..1bf61f3 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx.h
+++ b/arch/powerpc/platforms/85xx/mpc85xx.h
@@ -12,4 +12,8 @@ static inline void __init mpc85xx_cpm2_pic_init(void) {}
 #define MPC85xx_NO_PRIMARY_PHB 0xffff
 extern void mpc85xx_setup_arch(unsigned primary_phb_addr);
 
+#ifdef CONFIG_PPC_I8259
+extern int mpc85xx_i8259_setup_irq(void);
+#endif
+
 #endif
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_cds.c b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
index 49366e7..0e551d7 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_cds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
@@ -195,30 +195,7 @@ static void __init mpc85xx_cds_pic_init(void)
 static int mpc85xx_cds_8259_attach(void)
 {
 	int ret;
-	struct device_node *np = NULL;
-	struct device_node *cascade_node = NULL;
-	int cascade_irq;
-
-	/* Initialize the i8259 controller */
-	for_each_node_by_type(np, "interrupt-controller")
-		if (of_device_is_compatible(np, "chrp,iic")) {
-			cascade_node = np;
-			break;
-		}
-
-	if (cascade_node == NULL) {
-		printk(KERN_DEBUG "Could not find i8259 PIC\n");
-		return -ENODEV;
-	}
-
-	cascade_irq = irq_of_parse_and_map(cascade_node, 0);
-	if (cascade_irq == NO_IRQ) {
-		printk(KERN_ERR "Failed to map cascade interrupt\n");
-		return -ENXIO;
-	}
-
-	i8259_init(cascade_node, 0);
-	of_node_put(cascade_node);
+	int cascade_irq = mpc85xx_i8259_setup_irq();
 
 	/*
 	 *  Hook the interrupt to make sure desc->action is never NULL.
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_common.c b/arch/powerpc/platforms/85xx/mpc85xx_common.c
index 87e61a3..1602c7a 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_common.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_common.c
@@ -9,6 +9,7 @@
 #include <linux/of_platform.h>
 #include <linux/pci.h>
 
+#include <asm/i8259.h>
 #include <asm/machdep.h>
 #include <asm/mpic.h>
 
@@ -158,3 +159,38 @@ void __init mpc85xx_setup_arch(unsigned primary_phb_addr)
 	}
 #endif
 }
+
+#ifdef CONFIG_PPC_I8259
+int __init mpc85xx_i8259_setup_irq(void)
+{
+	struct device_node *np;
+	struct device_node *cascade_node = NULL;
+	int cascade_irq;
+
+	/* Initialize the i8259 controller */
+	for_each_node_by_type(np, "interrupt-controller")
+		if (of_device_is_compatible(np, "chrp,iic")) {
+			cascade_node = np;
+			break;
+		}
+
+	if (cascade_node == NULL) {
+		printk(KERN_DEBUG "Could not find i8259 PIC\n");
+		return -ENODEV;
+	}
+
+	cascade_irq = irq_of_parse_and_map(cascade_node, 0);
+	if (cascade_irq == NO_IRQ) {
+		printk(KERN_ERR "Failed to map cascade interrupt\n");
+		return -ENXIO;
+	}
+
+	pr_debug("%s: cascade mapped to irq %d\n", __func__, cascade_irq);
+
+	i8259_init(cascade_node, 0);
+	of_node_put(cascade_node);
+
+	return cascade_irq;
+}
+
+#endif
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ds.c b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
index bd9931a..246d33a 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
@@ -60,32 +60,7 @@ static void mpc85xx_8259_cascade(unsigned int irq, struct irq_desc *desc)
 
 static void __init mpc85xx_ds_i8259_init(void)
 {
-	struct device_node *np;
-	struct device_node *cascade_node = NULL;
-	int cascade_irq;
-
-	/* Initialize the i8259 controller */
-	for_each_node_by_type(np, "interrupt-controller")
-	    if (of_device_is_compatible(np, "chrp,iic")) {
-		cascade_node = np;
-		break;
-	}
-
-	if (cascade_node == NULL) {
-		printk(KERN_DEBUG "Could not find i8259 PIC\n");
-		return;
-	}
-
-	cascade_irq = irq_of_parse_and_map(cascade_node, 0);
-	if (cascade_irq == NO_IRQ) {
-		printk(KERN_ERR "Failed to map cascade interrupt\n");
-		return;
-	}
-
-	DBG("mpc85xxds: cascade mapped to irq %d\n", cascade_irq);
-
-	i8259_init(cascade_node, 0);
-	of_node_put(cascade_node);
+	int cascade_irq = mpc85xx_i8259_setup_irq();
 
 	irq_set_chained_handler(cascade_irq, mpc85xx_8259_cascade);
 }
-- 
1.7.7.1
