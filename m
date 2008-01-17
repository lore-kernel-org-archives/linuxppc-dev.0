Return-Path: <jochen@scram.de>
Received: from mail0.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail0.scram.de", Issuer "scram e.V. CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 918C9DDE2B
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jan 2008 23:06:33 +1100 (EST)
Message-ID: <478F4514.7030906@scram.de>
Date: Thu, 17 Jan 2008 13:07:48 +0100
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: [PATCH/RFC] [POWERPC] CPM1: implement GPIO LIB API
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Cc: Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@ozlabs.org,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Jochen Friedrich <jochen@scram.de>
---
 arch/powerpc/platforms/8xx/Kconfig |    2 +
 arch/powerpc/sysdev/commproc.c     |  162 +++++++++++++++++++++++++++++++++++-
 2 files changed, 163 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/8xx/Kconfig b/arch/powerpc/platforms/8xx/Kconfig
index 91fbe42..08e927c 100644
--- a/arch/powerpc/platforms/8xx/Kconfig
+++ b/arch/powerpc/platforms/8xx/Kconfig
@@ -4,6 +4,8 @@ config FADS
 config CPM1
 	bool
 	select CPM
+	select GENERIC_GPIO
+	select GPIO_LIB
 
 choice
 	prompt "8xx Machine Type"
diff --git a/arch/powerpc/sysdev/commproc.c b/arch/powerpc/sysdev/commproc.c
index 621bc6c..be78e65 100644
--- a/arch/powerpc/sysdev/commproc.c
+++ b/arch/powerpc/sysdev/commproc.c
@@ -36,6 +36,7 @@
 #include <asm/8xx_immap.h>
 #include <asm/commproc.h>
 #include <asm/io.h>
+#include <asm/gpio.h>
 #include <asm/tlbflush.h>
 #include <asm/rheap.h>
 #include <asm/prom.h>
@@ -441,7 +442,7 @@ struct cpm_ioport16 {
 };
 
 struct cpm_ioport32 {
-	__be32 dir, par, sor;
+	__be32 dir, par, sor, dat;
 };
 
 static void cpm1_set_pin32(int port, int pin, int flags)
@@ -648,3 +649,162 @@ int cpm1_clk_setup(enum cpm_clk_target target, int clock, int mode)
 
 	return 0;
 }
+
+/*
+ * GPIO LIB API implementation
+ */
+
+static int cpm1_gpio_get16(struct gpio_chip *gc, unsigned int gpio)
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
+static void cpm1_gpio_set16(struct gpio_chip *gc, unsigned int gpio, int value)
+{
+	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
+	struct cpm_ioport16 __iomem *iop = mm_gc->regs;
+	u16 pin_mask;
+
+	pin_mask = 1 << (15 - gpio);
+
+	if (value)
+		setbits16(&iop->dat, pin_mask);
+	else
+		clrbits16(&iop->dat, pin_mask);
+}
+
+static int cpm1_gpio_dir_out16(struct gpio_chip *gc, unsigned int gpio, int val)
+{
+	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
+	struct cpm_ioport16 __iomem *iop = mm_gc->regs;
+	u16 pin_mask;
+
+	pin_mask = 1 << (15 - gpio);
+
+	setbits16(&iop->dir, pin_mask);
+
+	cpm1_gpio_set16(gc, gpio, val);
+
+	return 0;
+}
+
+static int cpm1_gpio_dir_in16(struct gpio_chip *gc, unsigned int gpio)
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
+static struct of_gpio_chip cpm1_gc16 = {
+	.gpio_cells = 1,
+	.xlate = of_gpio_simple_xlate,
+
+	.gc = {
+		.ngpio = 16,
+		.direction_input = cpm1_gpio_dir_in16,
+		.direction_output = cpm1_gpio_dir_out16,
+		.get = cpm1_gpio_get16,
+		.set = cpm1_gpio_set16,
+	},
+};
+
+int cpm1_gpiochip_add16(struct device_node *np)
+{
+	return of_mm_gpiochip_add(np, &cpm1_gc16);
+}
+
+static int cpm1_gpio_get32(struct gpio_chip *gc, unsigned int gpio)
+{
+	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
+	struct cpm_ioport32 __iomem *iop = mm_gc->regs;
+	u32 pin_mask;
+
+	pin_mask = 1 << (31 - gpio);
+
+	return !!(in_be32(&iop->dat) & pin_mask);
+}
+
+static void cpm1_gpio_set32(struct gpio_chip *gc, unsigned int gpio, int value)
+{
+	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
+	struct cpm_ioport32 __iomem *iop = mm_gc->regs;
+	u32 pin_mask;
+
+	pin_mask = 1 << (31 - gpio);
+
+	if (value)
+		setbits32(&iop->dat, pin_mask);
+	else
+		clrbits32(&iop->dat, pin_mask);
+}
+
+static int cpm1_gpio_dir_out32(struct gpio_chip *gc, unsigned int gpio, int val)
+{
+	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
+	struct cpm_ioport32 __iomem *iop = mm_gc->regs;
+	u32 pin_mask;
+
+	pin_mask = 1 << (31 - gpio);
+
+	setbits32(&iop->dir, pin_mask);
+
+	cpm1_gpio_set32(gc, gpio, val);
+
+	return 0;
+}
+
+static int cpm1_gpio_dir_in32(struct gpio_chip *gc, unsigned int gpio)
+{
+	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
+	struct cpm_ioport32 __iomem *iop = mm_gc->regs;
+	u32 pin_mask;
+
+	pin_mask = 1 << (31 - gpio);
+
+	clrbits32(&iop->dir, pin_mask);
+
+	return 0;
+}
+
+static struct of_gpio_chip cpm1_gc32 = {
+	.gpio_cells = 1,
+	.xlate = of_gpio_simple_xlate,
+
+	.gc = {
+		.ngpio = 32,
+		.direction_input = cpm1_gpio_dir_in32,
+		.direction_output = cpm1_gpio_dir_out32,
+		.get = cpm1_gpio_get32,
+		.set = cpm1_gpio_set32,
+	},
+};
+
+int cpm1_gpiochip_add32(struct device_node *np)
+{
+	return of_mm_gpiochip_add(np, &cpm1_gc32);
+}
+
+static int cpm_init_par_io(void)
+{
+	struct device_node *np;
+
+	for_each_compatible_node(np, NULL, "fsl,cpm1-pario-bank16")
+		cpm1_gpiochip_add16(np);
+
+	for_each_compatible_node(np, NULL, "fsl,cpm1-pario-bank32")
+		cpm1_gpiochip_add32(np);
+	return 0;
+}
+arch_initcall(cpm_init_par_io);
-- 
1.5.3.8
