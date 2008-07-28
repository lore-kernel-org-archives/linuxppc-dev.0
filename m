Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id E1154DDF13
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jul 2008 18:43:29 +1000 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCHv4] cpm2: Implement GPIO LIB API on CPM2 Freescale SoC.
Date: Mon, 28 Jul 2008 10:43:22 +0200
References: <4808D75B.9000002@scram.de>
	<200807241800.27146.laurentp@cse-semaphore.com>
	<1C0E875E-1FFA-4FDB-BF87-36D9A03939E0@kernel.crashing.org>
In-Reply-To: <1C0E875E-1FFA-4FDB-BF87-36D9A03939E0@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200807281043.22736.laurentp@cse-semaphore.com>
Cc: Scott Wood <scottwood@freescale.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
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
 arch/powerpc/sysdev/cpm_common.c |  123 ++++++++++++++++++++++++++++++++++++++
 include/asm-powerpc/cpm.h        |    3 +
 4 files changed, 139 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
index 87454c5..7e67e26 100644
--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -280,6 +280,8 @@ config CPM2
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
index cb7df2d..b957a48 100644
--- a/arch/powerpc/sysdev/cpm_common.c
+++ b/arch/powerpc/sysdev/cpm_common.c
@@ -19,6 +19,8 @@
 
 #include <linux/init.h>
 #include <linux/of_device.h>
+#include <linux/spinlock.h>
+#include <linux/of.h>
 
 #include <asm/udbg.h>
 #include <asm/io.h>
@@ -28,6 +30,10 @@
 
 #include <mm/mmu_decl.h>
 
+#if defined(CONFIG_CPM2) || defined(CONFIG_8xx_GPIO)
+#include <linux/of_gpio.h>
+#endif
+
 #ifdef CONFIG_PPC_EARLY_DEBUG_CPM
 static u32 __iomem *cpm_udbg_txdesc =
 	(u32 __iomem __force *)CONFIG_PPC_EARLY_DEBUG_CPM_ADDR;
@@ -198,3 +204,120 @@ dma_addr_t cpm_muram_dma(void __iomem *addr)
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
+	of_gc->gpio_cells = 2;
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
1.5.0

-- 
Laurent Pinchart
CSE Semaphore Belgium

Chaussee de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
F +32 (2) 387 42 75
