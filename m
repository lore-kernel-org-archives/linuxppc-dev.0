Return-Path: <jochen@scram.de>
Received: from mail.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.scram.de", Issuer "scram e.V. CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 5AD48DE1C2
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Apr 2008 03:10:42 +1000 (EST)
Message-ID: <4808D606.5070309@scram.de>
Date: Fri, 18 Apr 2008 19:10:30 +0200
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH2/2] [POWERPC] CPM1: implement GPIO LIB API on CPM1 Freescale
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

This patch implement GPIO LIB support for the CPM1 GPIOs.

Signed-off-by: Jochen Friedrich <jochen@scram.de>
---
 arch/powerpc/platforms/8xx/Kconfig |   10 ++
 arch/powerpc/sysdev/cpm1.c         |  261 +++++++++++++++++++++++++++++++++++-
 2 files changed, 266 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/platforms/8xx/Kconfig b/arch/powerpc/platforms/8xx/Kconfig
index 6fc849e..3488bb7 100644
--- a/arch/powerpc/platforms/8xx/Kconfig
+++ b/arch/powerpc/platforms/8xx/Kconfig
@@ -105,6 +105,16 @@ config 8xx_COPYBACK
 
 	  If in doubt, say Y here.
 
+config 8xx_GPIO
+	bool "GPIO API Support"
+	select GENERIC_GPIO
+	select HAVE_GPIO_LIB
+	help
+	  Saying Y here will cause the ports on an MPC8xx processor to be used
+	  with the GPIO API.  If you say N here, the kernel needs less memory.
+
+	  If in doubt, say Y here.
+
 config 8xx_CPU6
 	bool "CPU6 Silicon Errata (860 Pre Rev. C)"
 	help
diff --git a/arch/powerpc/sysdev/cpm1.c b/arch/powerpc/sysdev/cpm1.c
index 58292a0..01ae3ae 100644
--- a/arch/powerpc/sysdev/cpm1.c
+++ b/arch/powerpc/sysdev/cpm1.c
@@ -30,6 +30,7 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/module.h>
+#include <linux/spinlock.h>
 #include <asm/page.h>
 #include <asm/pgtable.h>
 #include <asm/8xx_immap.h>
@@ -42,6 +43,10 @@
 
 #include <asm/fs_pd.h>
 
+#ifdef CONFIG_8xx_GPIO
+#include <linux/of_gpio.h>
+#endif
+
 #define CPM_MAP_SIZE    (0x4000)
 
 cpm8xx_t __iomem *cpmp;  /* Pointer to comm processor space */
@@ -290,20 +295,24 @@ struct cpm_ioport16 {
 	__be16 res[3];
 };
 
-struct cpm_ioport32 {
-	__be32 dir, par, sor;
+struct cpm_ioport32b {
+	__be32 dir, par, odr, dat;
+};
+
+struct cpm_ioport32e {
+	__be32 dir, par, sor, odr, dat;
 };
 
 static void cpm1_set_pin32(int port, int pin, int flags)
 {
-	struct cpm_ioport32 __iomem *iop;
+	struct cpm_ioport32e __iomem *iop;
 	pin = 1 << (31 - pin);
 
 	if (port == CPM_PORTB)
-		iop = (struct cpm_ioport32 __iomem *)
+		iop = (struct cpm_ioport32e __iomem *)
 		      &mpc8xx_immr->im_cpm.cp_pbdir;
 	else
-		iop = (struct cpm_ioport32 __iomem *)
+		iop = (struct cpm_ioport32e __iomem *)
 		      &mpc8xx_immr->im_cpm.cp_pedir;
 
 	if (flags & CPM_PIN_OUTPUT)
@@ -498,3 +507,245 @@ int cpm1_clk_setup(enum cpm_clk_target target, int clock, int mode)
 
 	return 0;
 }
+
+/*
+ * GPIO LIB API implementation
+ */
+#ifdef CONFIG_8xx_GPIO
+
+struct cpm1_gpio16_chip {
+	struct of_mm_gpio_chip mm_gc;
+	spinlock_t lock;
+
+	/* shadowed data register to clear/set bits safely */
+	u16 cpdata;
+};
+
+static inline struct cpm1_gpio16_chip *
+to_cpm1_gpio16_chip(struct of_mm_gpio_chip *mm_gc)
+{
+	return container_of(mm_gc, struct cpm1_gpio16_chip, mm_gc);
+}
+
+static void cpm1_gpio16_save_regs(struct of_mm_gpio_chip *mm_gc)
+{
+	struct cpm1_gpio16_chip *cpm1_gc = to_cpm1_gpio16_chip(mm_gc);
+	struct cpm_ioport16 __iomem *iop = mm_gc->regs;
+
+	cpm1_gc->cpdata = in_be16(&iop->dat);
+}
+
+static int cpm1_gpio16_get(struct gpio_chip *gc, unsigned int gpio)
+{
+	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
+	struct cpm_ioport16 __iomem *iop = mm_gc->regs;
+	u16 pin_mask;
+
+	pin_mask = 1 << (15 - gpio);
+
+	return !!(in_be16(&iop->dat) & pin_mask);
+}
+
+static void cpm1_gpio16_set(struct gpio_chip *gc, unsigned int gpio, int value)
+{
+	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
+	struct cpm1_gpio16_chip *cpm1_gc = to_cpm1_gpio16_chip(mm_gc);
+	struct cpm_ioport16 __iomem *iop = mm_gc->regs;
+	unsigned long flags;
+	u16 pin_mask = 1 << (15 - gpio);
+
+	spin_lock_irqsave(&cpm1_gc->lock, flags);
+
+	if (value)
+		cpm1_gc->cpdata |= pin_mask;
+	else
+		cpm1_gc->cpdata &= ~pin_mask;
+
+	out_be16(&iop->dat, cpm1_gc->cpdata);
+
+	spin_unlock_irqrestore(&cpm1_gc->lock, flags);
+}
+
+static int cpm1_gpio16_dir_out(struct gpio_chip *gc, unsigned int gpio, int val)
+{
+	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
+	struct cpm_ioport16 __iomem *iop = mm_gc->regs;
+	u16 pin_mask;
+
+	pin_mask = 1 << (15 - gpio);
+
+	setbits16(&iop->dir, pin_mask);
+
+	cpm1_gpio16_set(gc, gpio, val);
+
+	return 0;
+}
+
+static int cpm1_gpio16_dir_in(struct gpio_chip *gc, unsigned int gpio)
+{
+	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
+	struct cpm_ioport16 __iomem *iop = mm_gc->regs;
+	u16 pin_mask;
+
+	pin_mask = 1 << (15 - gpio);
+
+	clrbits16(&iop->dir, pin_mask);
+
+	return 0;
+}
+
+int cpm1_gpiochip_add16(struct device_node *np)
+{
+	struct cpm1_gpio16_chip *cpm1_gc;
+	struct of_mm_gpio_chip *mm_gc;
+	struct of_gpio_chip *of_gc;
+	struct gpio_chip *gc;
+
+	cpm1_gc = kzalloc(sizeof(*cpm1_gc), GFP_KERNEL);
+	if (!cpm1_gc)
+		return -ENOMEM;
+
+	spin_lock_init(&cpm1_gc->lock);
+
+	mm_gc = &cpm1_gc->mm_gc;
+	of_gc = &mm_gc->of_gc;
+	gc = &of_gc->gc;
+
+	mm_gc->save_regs = cpm1_gpio16_save_regs;
+	of_gc->gpio_cells = 1;
+	gc->ngpio = 16;
+	gc->direction_input = cpm1_gpio16_dir_in;
+	gc->direction_output = cpm1_gpio16_dir_out;
+	gc->get = cpm1_gpio16_get;
+	gc->set = cpm1_gpio16_set;
+
+	return of_mm_gpiochip_add(np, mm_gc);
+}
+
+struct cpm1_gpio32_chip {
+	struct of_mm_gpio_chip mm_gc;
+	spinlock_t lock;
+
+	/* shadowed data register to clear/set bits safely */
+	u32 cpdata;
+};
+
+static inline struct cpm1_gpio32_chip *
+to_cpm1_gpio32_chip(struct of_mm_gpio_chip *mm_gc)
+{
+	return container_of(mm_gc, struct cpm1_gpio32_chip, mm_gc);
+}
+
+static void cpm1_gpio32_save_regs(struct of_mm_gpio_chip *mm_gc)
+{
+	struct cpm1_gpio32_chip *cpm1_gc = to_cpm1_gpio32_chip(mm_gc);
+	struct cpm_ioport32b __iomem *iop = mm_gc->regs;
+
+	cpm1_gc->cpdata = in_be32(&iop->dat);
+}
+
+static int cpm1_gpio32_get(struct gpio_chip *gc, unsigned int gpio)
+{
+	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
+	struct cpm_ioport32b __iomem *iop = mm_gc->regs;
+	u32 pin_mask;
+
+	pin_mask = 1 << (31 - gpio);
+
+	return !!(in_be32(&iop->dat) & pin_mask);
+}
+
+static void cpm1_gpio32_set(struct gpio_chip *gc, unsigned int gpio, int value)
+{
+	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
+	struct cpm1_gpio32_chip *cpm1_gc = to_cpm1_gpio32_chip(mm_gc);
+	struct cpm_ioport32b __iomem *iop = mm_gc->regs;
+	unsigned long flags;
+	u32 pin_mask = 1 << (31 - gpio);
+
+	spin_lock_irqsave(&cpm1_gc->lock, flags);
+
+	if (value)
+		cpm1_gc->cpdata |= pin_mask;
+	else
+		cpm1_gc->cpdata &= ~pin_mask;
+
+	out_be32(&iop->dat, cpm1_gc->cpdata);
+
+	spin_unlock_irqrestore(&cpm1_gc->lock, flags);
+}
+
+static int cpm1_gpio32_dir_out(struct gpio_chip *gc, unsigned int gpio, int val)
+{
+	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
+	struct cpm_ioport32b __iomem *iop = mm_gc->regs;
+	u32 pin_mask;
+
+	pin_mask = 1 << (31 - gpio);
+
+	setbits32(&iop->dir, pin_mask);
+
+	cpm1_gpio32_set(gc, gpio, val);
+
+	return 0;
+}
+
+static int cpm1_gpio32_dir_in(struct gpio_chip *gc, unsigned int gpio)
+{
+	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
+	struct cpm_ioport32b __iomem *iop = mm_gc->regs;
+	u32 pin_mask;
+
+	pin_mask = 1 << (31 - gpio);
+
+	clrbits32(&iop->dir, pin_mask);
+
+	return 0;
+}
+
+int cpm1_gpiochip_add32(struct device_node *np)
+{
+	struct cpm1_gpio32_chip *cpm1_gc;
+	struct of_mm_gpio_chip *mm_gc;
+	struct of_gpio_chip *of_gc;
+	struct gpio_chip *gc;
+
+	cpm1_gc = kzalloc(sizeof(*cpm1_gc), GFP_KERNEL);
+	if (!cpm1_gc)
+		return -ENOMEM;
+
+	spin_lock_init(&cpm1_gc->lock);
+
+	mm_gc = &cpm1_gc->mm_gc;
+	of_gc = &mm_gc->of_gc;
+	gc = &of_gc->gc;
+
+	mm_gc->save_regs = cpm1_gpio32_save_regs;
+	of_gc->gpio_cells = 1;
+	gc->ngpio = 32;
+	gc->direction_input = cpm1_gpio32_dir_in;
+	gc->direction_output = cpm1_gpio32_dir_out;
+	gc->get = cpm1_gpio32_get;
+	gc->set = cpm1_gpio32_set;
+
+	return of_mm_gpiochip_add(np, mm_gc);
+}
+
+static int cpm_init_par_io(void)
+{
+	struct device_node *np;
+
+	for_each_compatible_node(np, NULL, "fsl,cpm1-pario-bank16")
+		cpm1_gpiochip_add16(np);
+
+	for_each_compatible_node(np, NULL, "fsl,cpm1-pario-bank32b")
+		cpm1_gpiochip_add32(np);
+
+	/* Port E uses CPM2 layout */
+	for_each_compatible_node(np, NULL, "fsl,cpm1-pario-bank32e")
+		cpm2_gpiochip_add32(np);
+	return 0;
+}
+arch_initcall(cpm_init_par_io);
+
+#endif /* CONFIG_8xx_GPIO */
-- 
1.5.5
