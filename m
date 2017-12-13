Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yxZC84sMgzDrd5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Dec 2017 22:26:27 +1100 (AEDT)
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/sysdev: change CPM GPIO to platform_device
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Message-Id: <20171213112623.7FEB76C91C@localhost.localdomain>
Date: Wed, 13 Dec 2017 12:26:23 +0100 (CET)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Since commit 9427ecbed46cc ("gpio: Rework of_gpiochip_set_names()
to use device property accessors"), gpio chips have to have a
parent, otherwise devprop_gpiochip_set_names() prematurely exists
with message "GPIO chip parent is NULL" and doesn't proceed
'gpio-line-names' DT property.

This patch wraps the CPM GPIO into a platform driver to allow
assignment of the parent device.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/cpm.h   |  2 +-
 arch/powerpc/include/asm/cpm1.h  |  2 +
 arch/powerpc/sysdev/Makefile     |  3 +-
 arch/powerpc/sysdev/cpm1.c       | 33 ++++-------------
 arch/powerpc/sysdev/cpm2.c       | 11 ------
 arch/powerpc/sysdev/cpm_common.c |  5 ++-
 arch/powerpc/sysdev/cpm_gpio.c   | 80 ++++++++++++++++++++++++++++++++++++++++
 7 files changed, 97 insertions(+), 39 deletions(-)
 create mode 100644 arch/powerpc/sysdev/cpm_gpio.c

diff --git a/arch/powerpc/include/asm/cpm.h b/arch/powerpc/include/asm/cpm.h
index b925df1b87d0..4c24ea8209bb 100644
--- a/arch/powerpc/include/asm/cpm.h
+++ b/arch/powerpc/include/asm/cpm.h
@@ -166,6 +166,6 @@ static inline int cpm_command(u32 command, u8 opcode)
 }
 #endif /* CONFIG_CPM */
 
-int cpm2_gpiochip_add32(struct device_node *np);
+int cpm2_gpiochip_add32(struct device *dev);
 
 #endif
diff --git a/arch/powerpc/include/asm/cpm1.h b/arch/powerpc/include/asm/cpm1.h
index 3db821876d48..a116fe931789 100644
--- a/arch/powerpc/include/asm/cpm1.h
+++ b/arch/powerpc/include/asm/cpm1.h
@@ -605,5 +605,7 @@ enum cpm_clk {
 };
 
 int cpm1_clk_setup(enum cpm_clk_target target, int clock, int mode);
+int cpm1_gpiochip_add16(struct device *dev);
+int cpm1_gpiochip_add32(struct device *dev);
 
 #endif /* __CPM1__ */
diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
index 0baba21404dc..fc31a271830b 100644
--- a/arch/powerpc/sysdev/Makefile
+++ b/arch/powerpc/sysdev/Makefile
@@ -43,7 +43,8 @@ obj-$(CONFIG_OF_RTC)		+= of_rtc.o
 
 obj-$(CONFIG_CPM)		+= cpm_common.o
 obj-$(CONFIG_CPM1)		+= cpm1.o
-obj-$(CONFIG_CPM2)		+= cpm2.o cpm2_pic.o
+obj-$(CONFIG_CPM2)		+= cpm2.o cpm2_pic.o cpm_gpio.o
+obj-$(CONFIG_8xx_GPIO)		+= cpm_gpio.o
 obj-$(CONFIG_QUICC_ENGINE)	+= cpm_common.o
 obj-$(CONFIG_PPC_DCR)		+= dcr.o
 obj-$(CONFIG_UCODE_PATCH)	+= micropatch.o
diff --git a/arch/powerpc/sysdev/cpm1.c b/arch/powerpc/sysdev/cpm1.c
index f5544c6fbd18..e6ec2b1263b1 100644
--- a/arch/powerpc/sysdev/cpm1.c
+++ b/arch/powerpc/sysdev/cpm1.c
@@ -635,8 +635,9 @@ static int cpm1_gpio16_dir_in(struct gpio_chip *gc, unsigned int gpio)
 	return 0;
 }
 
-int cpm1_gpiochip_add16(struct device_node *np)
+int cpm1_gpiochip_add16(struct device *dev)
 {
+	struct device_node *np = dev->of_node;
 	struct cpm1_gpio16_chip *cpm1_gc;
 	struct of_mm_gpio_chip *mm_gc;
 	struct gpio_chip *gc;
@@ -666,6 +667,8 @@ int cpm1_gpiochip_add16(struct device_node *np)
 	gc->get = cpm1_gpio16_get;
 	gc->set = cpm1_gpio16_set;
 	gc->to_irq = cpm1_gpio16_to_irq;
+	gc->parent = dev;
+	gc->owner = THIS_MODULE;
 
 	return of_mm_gpiochip_add_data(np, mm_gc, cpm1_gc);
 }
@@ -761,8 +764,9 @@ static int cpm1_gpio32_dir_in(struct gpio_chip *gc, unsigned int gpio)
 	return 0;
 }
 
-int cpm1_gpiochip_add32(struct device_node *np)
+int cpm1_gpiochip_add32(struct device *dev)
 {
+	struct device_node *np = dev->of_node;
 	struct cpm1_gpio32_chip *cpm1_gc;
 	struct of_mm_gpio_chip *mm_gc;
 	struct gpio_chip *gc;
@@ -782,31 +786,10 @@ int cpm1_gpiochip_add32(struct device_node *np)
 	gc->direction_output = cpm1_gpio32_dir_out;
 	gc->get = cpm1_gpio32_get;
 	gc->set = cpm1_gpio32_set;
+	gc->parent = dev;
+	gc->owner = THIS_MODULE;
 
 	return of_mm_gpiochip_add_data(np, mm_gc, cpm1_gc);
 }
 
-static int cpm_init_par_io(void)
-{
-	struct device_node *np;
-
-	for_each_compatible_node(np, NULL, "fsl,cpm1-pario-bank-a")
-		cpm1_gpiochip_add16(np);
-
-	for_each_compatible_node(np, NULL, "fsl,cpm1-pario-bank-b")
-		cpm1_gpiochip_add32(np);
-
-	for_each_compatible_node(np, NULL, "fsl,cpm1-pario-bank-c")
-		cpm1_gpiochip_add16(np);
-
-	for_each_compatible_node(np, NULL, "fsl,cpm1-pario-bank-d")
-		cpm1_gpiochip_add16(np);
-
-	/* Port E uses CPM2 layout */
-	for_each_compatible_node(np, NULL, "fsl,cpm1-pario-bank-e")
-		cpm2_gpiochip_add32(np);
-	return 0;
-}
-arch_initcall(cpm_init_par_io);
-
 #endif /* CONFIG_8xx_GPIO */
diff --git a/arch/powerpc/sysdev/cpm2.c b/arch/powerpc/sysdev/cpm2.c
index f78ff841652c..07718b9a2c99 100644
--- a/arch/powerpc/sysdev/cpm2.c
+++ b/arch/powerpc/sysdev/cpm2.c
@@ -354,14 +354,3 @@ void cpm2_set_pin(int port, int pin, int flags)
 	else
 		clrbits32(&iop[port].odr, pin);
 }
-
-static int cpm_init_par_io(void)
-{
-	struct device_node *np;
-
-	for_each_compatible_node(np, NULL, "fsl,cpm2-pario-bank")
-		cpm2_gpiochip_add32(np);
-	return 0;
-}
-arch_initcall(cpm_init_par_io);
-
diff --git a/arch/powerpc/sysdev/cpm_common.c b/arch/powerpc/sysdev/cpm_common.c
index 51bf749a4f3a..b74508175b67 100644
--- a/arch/powerpc/sysdev/cpm_common.c
+++ b/arch/powerpc/sysdev/cpm_common.c
@@ -190,8 +190,9 @@ static int cpm2_gpio32_dir_in(struct gpio_chip *gc, unsigned int gpio)
 	return 0;
 }
 
-int cpm2_gpiochip_add32(struct device_node *np)
+int cpm2_gpiochip_add32(struct device *dev)
 {
+	struct device_node *np = dev->of_node;
 	struct cpm2_gpio32_chip *cpm2_gc;
 	struct of_mm_gpio_chip *mm_gc;
 	struct gpio_chip *gc;
@@ -211,6 +212,8 @@ int cpm2_gpiochip_add32(struct device_node *np)
 	gc->direction_output = cpm2_gpio32_dir_out;
 	gc->get = cpm2_gpio32_get;
 	gc->set = cpm2_gpio32_set;
+	gc->parent = dev;
+	gc->owner = THIS_MODULE;
 
 	return of_mm_gpiochip_add_data(np, mm_gc, cpm2_gc);
 }
diff --git a/arch/powerpc/sysdev/cpm_gpio.c b/arch/powerpc/sysdev/cpm_gpio.c
new file mode 100644
index 000000000000..0badc90be666
--- /dev/null
+++ b/arch/powerpc/sysdev/cpm_gpio.c
@@ -0,0 +1,80 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Common CPM GPIO wrapper for the CPM GPIO ports
+ *
+ * Author: Christophe Leroy <christophe.leroy@c-s.fr>
+ *
+ * Copyright 2017 CS Systemes d'Information.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/of_device.h>
+
+#include <asm/cpm.h>
+#ifdef CONFIG_8xx_GPIO
+#include <asm/cpm1.h>
+#endif
+
+static int cpm_gpio_probe(struct platform_device *ofdev)
+{
+	struct device *dev = &ofdev->dev;
+	int (*gp_add)(struct device *dev) = of_device_get_match_data(dev);
+
+	if (!gp_add)
+		return -ENODEV;
+
+	return gp_add(dev);
+}
+
+static const struct of_device_id cpm_gpio_match[] = {
+#ifdef CONFIG_8xx_GPIO
+	{
+		.compatible = "fsl,cpm1-pario-bank-a",
+		.data = cpm1_gpiochip_add16,
+	},
+	{
+		.compatible = "fsl,cpm1-pario-bank-b",
+		.data = cpm1_gpiochip_add32,
+	},
+	{
+		.compatible = "fsl,cpm1-pario-bank-c",
+		.data = cpm1_gpiochip_add16,
+	},
+	{
+		.compatible = "fsl,cpm1-pario-bank-d",
+		.data = cpm1_gpiochip_add16,
+	},
+	/* Port E uses CPM2 layout */
+	{
+		.compatible = "fsl,cpm1-pario-bank-e",
+		.data = cpm2_gpiochip_add32,
+	},
+#endif
+	{
+		.compatible = "fsl,cpm2-pario-bank",
+		.data = cpm2_gpiochip_add32,
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, cpm_gpio_match);
+
+static struct platform_driver cpm_gpio_driver = {
+	.probe		= cpm_gpio_probe,
+	.driver		= {
+		.name	= "cpm-gpio",
+		.owner	= THIS_MODULE,
+		.of_match_table	= cpm_gpio_match,
+	},
+};
+
+static int __init cpm_gpio_init(void)
+{
+	return platform_driver_register(&cpm_gpio_driver);
+}
+arch_initcall(cpm_gpio_init);
+
+MODULE_AUTHOR("Christophe Leroy <christophe.leroy@c-s.fr>");
+MODULE_DESCRIPTION("Driver for CPM GPIO");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:cpm-gpio");
-- 
2.13.3
