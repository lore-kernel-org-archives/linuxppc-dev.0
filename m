Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id 5EBDEDE208
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Apr 2008 19:48:16 +1000 (EST)
Received: from smtp.belgium.cse-semaphore.com (localhost [127.0.0.1])
	by smtp.belgium.cse-semaphore.com (Postfix) with ESMTP id 69B0CA897
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Apr 2008 11:48:13 +0200 (CEST)
Received: from pclaurent.belgium.cse-semaphore.com
	(pclaurent.belgium.cse-semaphore.com [192.168.1.47])
	by smtp.belgium.cse-semaphore.com (Postfix) with ESMTP id 4A42BA7CE
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Apr 2008 11:48:13 +0200 (CEST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc: Implement GPIO LIB API on CPM2 Freescale SoC.
Date: Thu, 17 Apr 2008 11:48:11 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200804171148.11593.laurentp@cse-semaphore.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch implement GPIO LIB support for the CPM2 GPIOs.

The code is based on Jochen Friedrich's patch for the CPM1.

Signed-off-by: Laurent Pinchart <laurentp@cse-semaphore.com>
---
 arch/powerpc/platforms/Kconfig |    2 +
 arch/powerpc/sysdev/cpm2.c     |  123 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 125 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
index b0aa0dc..93ec36e 100644
--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -283,6 +283,8 @@ config CPM2
 	depends on MPC85xx || 8260
 	select CPM
 	select PPC_LIB_RHEAP
+	select GENERIC_GPIO
+	select HAVE_GPIO_LIB
 	help
 	  The CPM2 (Communications Processor Module) is a coprocessor on
 	  embedded CPUs made by Freescale.  Selecting this option means that
diff --git a/arch/powerpc/sysdev/cpm2.c b/arch/powerpc/sysdev/cpm2.c
index 7478e81..f4d72b8 100644
--- a/arch/powerpc/sysdev/cpm2.c
+++ b/arch/powerpc/sysdev/cpm2.c
@@ -33,7 +33,9 @@
 #include <linux/mm.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
+#include <linux/spinlock.h>
 #include <linux/of.h>
+#include <linux/of_gpio.h>
 
 #include <asm/io.h>
 #include <asm/irq.h>
@@ -43,6 +45,7 @@
 #include <asm/cpm2.h>
 #include <asm/rheap.h>
 #include <asm/fs_pd.h>
+#include <asm/gpio.h>
 
 #include <sysdev/fsl_soc.h>
 
@@ -474,3 +477,123 @@ void cpm2_set_pin(int port, int pin, int flags)
 	else
 		clrbits32(&iop[port].odr, pin);
 }
+
+struct cpm2_gpio32_chip {
+	struct of_mm_gpio_chip mm_gc;
+	spinlock_t lock;
+
+	/* shadowed data register to clear/set bits safely */
+	u32 cpdata;
+};
+
+static inline struct cpm2_gpio32_chip *
+to_cpm2_gpio32_chip(struct of_mm_gpio_chip *mm_gc)
+{
+	return container_of(mm_gc, struct cpm2_gpio32_chip, mm_gc);
+}
+
+static void cpm2_gpio32_save_regs(struct of_mm_gpio_chip *mm_gc)
+{
+	struct cpm2_gpio32_chip *cpm2_gc = to_cpm2_gpio32_chip(mm_gc);
+	struct cpm2_ioports __iomem *iop = mm_gc->regs;
+
+	cpm2_gc->cpdata = in_be32(&iop->dat);
+}
+
+static int cpm2_gpio32_get(struct gpio_chip *gc, unsigned int gpio)
+{
+	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
+	struct cpm2_ioports __iomem *iop = mm_gc->regs;
+	u32 pin_mask;
+
+	pin_mask = 1 << (31 - gpio);
+
+	return !!(in_be32(&iop->dat) & pin_mask);
+}
+
+static void cpm2_gpio32_set(struct gpio_chip *gc, unsigned int gpio, int value)
+{
+	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
+	struct cpm2_gpio32_chip *cpm2_gc = to_cpm2_gpio32_chip(mm_gc);
+	struct cpm2_ioports __iomem *iop = mm_gc->regs;
+	unsigned long flags;
+	u32 pin_mask = 1 << (31 - gpio);
+
+	spin_lock_irqsave(&cpm2_gc->lock, flags);
+
+	if (value)
+		cpm2_gc->cpdata |= pin_mask;
+	else
+		cpm2_gc->cpdata &= ~pin_mask;
+
+	out_be32(&iop->dat, cpm2_gc->cpdata);
+
+	spin_unlock_irqrestore(&cpm2_gc->lock, flags);
+}
+
+static int cpm2_gpio32_dir_out(struct gpio_chip *gc, unsigned int gpio, int val)
+{
+	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
+	struct cpm2_ioports __iomem *iop = mm_gc->regs;
+	u32 pin_mask;
+
+	pin_mask = 1 << (31 - gpio);
+
+	setbits32(&iop->dir, pin_mask);
+
+	cpm2_gpio32_set(gc, gpio, val);
+
+	return 0;
+}
+
+static int cpm2_gpio32_dir_in(struct gpio_chip *gc, unsigned int gpio)
+{
+	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
+	struct cpm2_ioports __iomem *iop = mm_gc->regs;
+	u32 pin_mask;
+
+	pin_mask = 1 << (31 - gpio);
+
+	clrbits32(&iop->dir, pin_mask);
+
+	return 0;
+}
+
+int cpm2_gpiochip_add32(struct device_node *np)
+{
+	struct cpm2_gpio32_chip *cpm2_gc;
+	struct of_mm_gpio_chip *mm_gc;
+	struct of_gpio_chip *of_gc;
+	struct gpio_chip *gc;
+
+	cpm2_gc = kzalloc(sizeof(*cpm2_gc), GFP_KERNEL);
+	if (!cpm2_gc)
+		return -ENOMEM;
+
+	spin_lock_init(&cpm2_gc->lock);
+
+	mm_gc = &cpm2_gc->mm_gc;
+	of_gc = &mm_gc->of_gc;
+	gc = &of_gc->gc;
+
+	mm_gc->save_regs = cpm2_gpio32_save_regs;
+	of_gc->gpio_cells = 1;
+	gc->ngpio = 32;
+	gc->direction_input = cpm2_gpio32_dir_in;
+	gc->direction_output = cpm2_gpio32_dir_out;
+	gc->get = cpm2_gpio32_get;
+	gc->set = cpm2_gpio32_set;
+
+	return of_mm_gpiochip_add(np, mm_gc);
+}
+
+static int cpm_init_par_io(void)
+{
+	struct device_node *np;
+
+	for_each_compatible_node(np, NULL, "fsl,cpm2-pario-bank")
+		cpm2_gpiochip_add32(np);
+	return 0;
+}
+arch_initcall(cpm_init_par_io);
+
-- 
1.5.0


-- 
Laurent Pinchart
CSE Semaphore Belgium

Chaussee de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
F +32 (2) 387 42 75
