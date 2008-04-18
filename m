Return-Path: <jochen@scram.de>
Received: from mail.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.scram.de", Issuer "scram e.V. CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 800E1DEB7C
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Apr 2008 03:07:51 +1000 (EST)
Message-ID: <4808D556.90000@scram.de>
Date: Fri, 18 Apr 2008 19:07:34 +0200
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH1/2] [POWERPC] CPM2: Implement GPIO LIB API on CPM2 Freescale
	SoC.
Content-Type: text/plain; charset=ISO-8859-15
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Scott Wood <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Based on earlier work by Laurent Pinchart.

This patch implement GPIO LIB support for the CPM2 GPIOs.

Signed-off-by: Jochen Friedrich <jochen@scram.de>
Cc: Laurent Pinchart <laurentp@cse-semaphore.com>
---
 arch/powerpc/platforms/Kconfig   |    2 +
 arch/powerpc/sysdev/cpm2.c       |   11 ++++
 arch/powerpc/sysdev/cpm_common.c |  120 ++++++++++++++++++++++++++++++++++++++
 include/asm-powerpc/cpm.h        |    3 +
 4 files changed, 136 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
index f6eecd1..78911f6 100644
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
index 5a6c5df..9311778 100644
--- a/arch/powerpc/sysdev/cpm2.c
+++ b/arch/powerpc/sysdev/cpm2.c
@@ -377,3 +377,14 @@ void cpm2_set_pin(int port, int pin, int flags)
 	else
 		clrbits32(&iop[port].odr, pin);
 }
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
diff --git a/arch/powerpc/sysdev/cpm_common.c b/arch/powerpc/sysdev/cpm_common.c
index cb7df2d..07d694c 100644
--- a/arch/powerpc/sysdev/cpm_common.c
+++ b/arch/powerpc/sysdev/cpm_common.c
@@ -19,6 +19,9 @@
 
 #include <linux/init.h>
 #include <linux/of_device.h>
+#include <linux/spinlock.h>
+#include <linux/of.h>
+#include <linux/of_gpio.h>
 
 #include <asm/udbg.h>
 #include <asm/io.h>
@@ -198,3 +201,120 @@ dma_addr_t cpm_muram_dma(void __iomem *addr)
 	return muram_pbase + ((u8 __iomem *)addr - muram_vbase);
 }
 EXPORT_SYMBOL(cpm_muram_dma);
+
+#if defined(CONFIG_CPM2) || defined(CONFIG_8xx_GPIO)
+
+struct cpm2_ioports {
+	u32 dir, par, sor, odr, dat;
+	u32 res[3];
+};
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
+#endif /* CONFIG_CPM2 || CONFIG_8xx_GPIO */
diff --git a/include/asm-powerpc/cpm.h b/include/asm-powerpc/cpm.h
index ede38ff..23b72ee 100644
--- a/include/asm-powerpc/cpm.h
+++ b/include/asm-powerpc/cpm.h
@@ -3,6 +3,7 @@
 
 #include <linux/compiler.h>
 #include <linux/types.h>
+#include <linux/of.h>
 
 /* Opcodes common to CPM1 and CPM2
 */
@@ -99,4 +100,6 @@ void __iomem *cpm_muram_addr(unsigned long offset);
 dma_addr_t cpm_muram_dma(void __iomem *addr);
 int cpm_command(u32 command, u8 opcode);
 
+int cpm2_gpiochip_add32(struct device_node *np);
+
 #endif
-- 
1.5.5
