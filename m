Return-Path: <w.sang@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[IPv6:2001:6f8:1178:4:290:27ff:fe1d:cc33])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BFB7BB6F8A
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Sep 2011 03:32:35 +1000 (EST)
From: Wolfram Sang <w.sang@pengutronix.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/2] gpio: move mpc8xxx/512x gpio driver to drivers/gpio
Date: Tue, 20 Sep 2011 19:32:20 +0200
Message-Id: <1316539941-14092-1-git-send-email-w.sang@pengutronix.de>
Cc: Anatolij Gustschin <agust@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Move the driver to the place where it is expected to be nowadays. Also
rename its CONFIG-name to match the rest and adapt the defconfigs.
Finally, move selection of REQUIRE_GPIOLIB or WANTS_OPTIONAL_GPIOLIB to
the platforms, because this option is per-platform and not per-driver.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Cc: Anatolij Gustschin <agust@denx.de>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

I'd think this should go via ppc, so it is in sync with the defconfig update of
patch 2/2.

 arch/powerpc/configs/85xx/p1023rds_defconfig    |    2 +-
 arch/powerpc/configs/85xx/xes_mpc85xx_defconfig |    2 +-
 arch/powerpc/configs/mpc85xx_defconfig          |    2 +-
 arch/powerpc/configs/mpc85xx_smp_defconfig      |    2 +-
 arch/powerpc/configs/ppc6xx_defconfig           |    2 +-
 arch/powerpc/platforms/512x/Kconfig             |    1 +
 arch/powerpc/platforms/83xx/Kconfig             |    9 +-
 arch/powerpc/platforms/85xx/Kconfig             |   12 +-
 arch/powerpc/platforms/86xx/Kconfig             |    1 +
 arch/powerpc/platforms/Kconfig                  |   10 -
 arch/powerpc/sysdev/Makefile                    |    1 -
 arch/powerpc/sysdev/mpc8xxx_gpio.c              |  395 -----------------------
 drivers/gpio/Kconfig                            |    8 +
 drivers/gpio/Makefile                           |    1 +
 drivers/gpio/gpio-mpc8xxx.c                     |  395 +++++++++++++++++++++++
 15 files changed, 425 insertions(+), 418 deletions(-)
 delete mode 100644 arch/powerpc/sysdev/mpc8xxx_gpio.c
 create mode 100644 drivers/gpio/gpio-mpc8xxx.c

diff --git a/arch/powerpc/configs/85xx/p1023rds_defconfig b/arch/powerpc/configs/85xx/p1023rds_defconfig
index 3ff5a81..c091aaf 100644
--- a/arch/powerpc/configs/85xx/p1023rds_defconfig
+++ b/arch/powerpc/configs/85xx/p1023rds_defconfig
@@ -24,7 +24,7 @@ CONFIG_P1023_RDS=y
 CONFIG_QUICC_ENGINE=y
 CONFIG_QE_GPIO=y
 CONFIG_CPM2=y
-CONFIG_MPC8xxx_GPIO=y
+CONFIG_GPIO_MPC8XXX=y
 CONFIG_HIGHMEM=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
diff --git a/arch/powerpc/configs/85xx/xes_mpc85xx_defconfig b/arch/powerpc/configs/85xx/xes_mpc85xx_defconfig
index 5ea3124..1cd6fcb 100644
--- a/arch/powerpc/configs/85xx/xes_mpc85xx_defconfig
+++ b/arch/powerpc/configs/85xx/xes_mpc85xx_defconfig
@@ -20,7 +20,7 @@ CONFIG_MODULE_FORCE_UNLOAD=y
 CONFIG_MODVERSIONS=y
 # CONFIG_BLK_DEV_BSG is not set
 CONFIG_XES_MPC85xx=y
-CONFIG_MPC8xxx_GPIO=y
+CONFIG_GPIO_MPC8XXX=y
 CONFIG_HIGHMEM=y
 CONFIG_MATH_EMULATION=y
 CONFIG_SPARSE_IRQ=y
diff --git a/arch/powerpc/configs/mpc85xx_defconfig b/arch/powerpc/configs/mpc85xx_defconfig
index a3467bf..2500912 100644
--- a/arch/powerpc/configs/mpc85xx_defconfig
+++ b/arch/powerpc/configs/mpc85xx_defconfig
@@ -41,7 +41,7 @@ CONFIG_TQM8560=y
 CONFIG_SBC8548=y
 CONFIG_QUICC_ENGINE=y
 CONFIG_QE_GPIO=y
-CONFIG_MPC8xxx_GPIO=y
+CONFIG_GPIO_MPC8XXX=y
 CONFIG_HIGHMEM=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
diff --git a/arch/powerpc/configs/mpc85xx_smp_defconfig b/arch/powerpc/configs/mpc85xx_smp_defconfig
index 9693f6e..a4ba13b 100644
--- a/arch/powerpc/configs/mpc85xx_smp_defconfig
+++ b/arch/powerpc/configs/mpc85xx_smp_defconfig
@@ -42,7 +42,7 @@ CONFIG_TQM8560=y
 CONFIG_SBC8548=y
 CONFIG_QUICC_ENGINE=y
 CONFIG_QE_GPIO=y
-CONFIG_MPC8xxx_GPIO=y
+CONFIG_GPIO_MPC8XXX=y
 CONFIG_HIGHMEM=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
diff --git a/arch/powerpc/configs/ppc6xx_defconfig b/arch/powerpc/configs/ppc6xx_defconfig
index 04360f9..c47f2be 100644
--- a/arch/powerpc/configs/ppc6xx_defconfig
+++ b/arch/powerpc/configs/ppc6xx_defconfig
@@ -70,7 +70,7 @@ CONFIG_TAU_AVERAGE=y
 CONFIG_QUICC_ENGINE=y
 CONFIG_QE_GPIO=y
 CONFIG_PPC_BESTCOMM=y
-CONFIG_MPC8xxx_GPIO=y
+CONFIG_GPIO_MPC8XXX=y
 CONFIG_MCU_MPC8349EMITX=m
 CONFIG_HIGHMEM=y
 CONFIG_NO_HZ=y
diff --git a/arch/powerpc/platforms/512x/Kconfig b/arch/powerpc/platforms/512x/Kconfig
index 27b0651..b3ebce1 100644
--- a/arch/powerpc/platforms/512x/Kconfig
+++ b/arch/powerpc/platforms/512x/Kconfig
@@ -6,6 +6,7 @@ config PPC_MPC512x
 	select PPC_CLOCK
 	select PPC_PCI_CHOICE
 	select FSL_PCI if PCI
+	select ARCH_WANT_OPTIONAL_GPIOLIB
 
 config MPC5121_ADS
 	bool "Freescale MPC5121E ADS"
diff --git a/arch/powerpc/platforms/83xx/Kconfig b/arch/powerpc/platforms/83xx/Kconfig
index 73f4135..670a033 100644
--- a/arch/powerpc/platforms/83xx/Kconfig
+++ b/arch/powerpc/platforms/83xx/Kconfig
@@ -114,18 +114,21 @@ config KMETER1
 
 endif
 
-# used for usb
+# used for usb & gpio
 config PPC_MPC831x
 	bool
+	select ARCH_WANT_OPTIONAL_GPIOLIB
 
 # used for math-emu
 config PPC_MPC832x
 	bool
 
-# used for usb
+# used for usb & gpio
 config PPC_MPC834x
 	bool
+	select ARCH_WANT_OPTIONAL_GPIOLIB
 
-# used for usb
+# used for usb & gpio
 config PPC_MPC837x
 	bool
+	select ARCH_WANT_OPTIONAL_GPIOLIB
diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index 498534c..1b393f4 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -177,7 +177,8 @@ config P2040_RDB
 	select PPC_E500MC
 	select PHYS_64BIT
 	select SWIOTLB
-	select MPC8xxx_GPIO
+	select ARCH_REQUIRE_GPIOLIB
+	select GPIO_MPC8XXX
 	select HAS_RAPIDIO
 	select PPC_EPAPR_HV_PIC
 	help
@@ -189,7 +190,8 @@ config P3041_DS
 	select PPC_E500MC
 	select PHYS_64BIT
 	select SWIOTLB
-	select MPC8xxx_GPIO
+	select ARCH_REQUIRE_GPIOLIB
+	select GPIO_MPC8XXX
 	select HAS_RAPIDIO
 	select PPC_EPAPR_HV_PIC
 	help
@@ -201,7 +203,8 @@ config P4080_DS
 	select PPC_E500MC
 	select PHYS_64BIT
 	select SWIOTLB
-	select MPC8xxx_GPIO
+	select ARCH_REQUIRE_GPIOLIB
+	select GPIO_MPC8XXX
 	select HAS_RAPIDIO
 	select PPC_EPAPR_HV_PIC
 	help
@@ -216,7 +219,8 @@ config P5020_DS
 	select PPC_E500MC
 	select PHYS_64BIT
 	select SWIOTLB
-	select MPC8xxx_GPIO
+	select ARCH_REQUIRE_GPIOLIB
+	select GPIO_MPC8XXX
 	select HAS_RAPIDIO
 	select PPC_EPAPR_HV_PIC
 	help
diff --git a/arch/powerpc/platforms/86xx/Kconfig b/arch/powerpc/platforms/86xx/Kconfig
index a0b5638..8d6599d 100644
--- a/arch/powerpc/platforms/86xx/Kconfig
+++ b/arch/powerpc/platforms/86xx/Kconfig
@@ -4,6 +4,7 @@ menuconfig PPC_86xx
 	depends on 6xx
 	select FSL_SOC
 	select ALTIVEC
+	select ARCH_WANT_OPTIONAL_GPIOLIB
 	help
 	  The Freescale E600 SoCs have 74xx cores.
 
diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
index b9ba861..c0cb1ea 100644
--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -333,16 +333,6 @@ config OF_RTC
 
 source "arch/powerpc/sysdev/bestcomm/Kconfig"
 
-config MPC8xxx_GPIO
-	bool "MPC512x/MPC8xxx GPIO support"
-	depends on PPC_MPC512x || PPC_MPC831x || PPC_MPC834x || PPC_MPC837x || \
-		   FSL_SOC_BOOKE || PPC_86xx
-	select GENERIC_GPIO
-	select ARCH_REQUIRE_GPIOLIB
-	help
-	  Say Y here if you're going to use hardware that connects to the
-	  MPC512x/831x/834x/837x/8572/8610 GPIOs.
-
 config SIMPLE_GPIO
 	bool "Support for simple, memory-mapped GPIO controllers"
 	depends on PPC
diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
index cf736ca..84e1325 100644
--- a/arch/powerpc/sysdev/Makefile
+++ b/arch/powerpc/sysdev/Makefile
@@ -18,7 +18,6 @@ obj-$(CONFIG_FSL_PCI)		+= fsl_pci.o $(fsl-msi-obj-y)
 obj-$(CONFIG_FSL_PMC)		+= fsl_pmc.o
 obj-$(CONFIG_FSL_LBC)		+= fsl_lbc.o
 obj-$(CONFIG_FSL_GTM)		+= fsl_gtm.o
-obj-$(CONFIG_MPC8xxx_GPIO)	+= mpc8xxx_gpio.o
 obj-$(CONFIG_FSL_85XX_CACHE_SRAM)	+= fsl_85xx_l2ctlr.o fsl_85xx_cache_sram.o
 obj-$(CONFIG_SIMPLE_GPIO)	+= simple_gpio.o
 obj-$(CONFIG_FSL_RIO)		+= fsl_rio.o
diff --git a/arch/powerpc/sysdev/mpc8xxx_gpio.c b/arch/powerpc/sysdev/mpc8xxx_gpio.c
deleted file mode 100644
index fb4963a..0000000
--- a/arch/powerpc/sysdev/mpc8xxx_gpio.c
+++ /dev/null
@@ -1,395 +0,0 @@
-/*
- * GPIOs on MPC512x/8349/8572/8610 and compatible
- *
- * Copyright (C) 2008 Peter Korsgaard <jacmet@sunsite.dk>
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
- */
-
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/spinlock.h>
-#include <linux/io.h>
-#include <linux/of.h>
-#include <linux/of_gpio.h>
-#include <linux/gpio.h>
-#include <linux/slab.h>
-#include <linux/irq.h>
-
-#define MPC8XXX_GPIO_PINS	32
-
-#define GPIO_DIR		0x00
-#define GPIO_ODR		0x04
-#define GPIO_DAT		0x08
-#define GPIO_IER		0x0c
-#define GPIO_IMR		0x10
-#define GPIO_ICR		0x14
-#define GPIO_ICR2		0x18
-
-struct mpc8xxx_gpio_chip {
-	struct of_mm_gpio_chip mm_gc;
-	spinlock_t lock;
-
-	/*
-	 * shadowed data register to be able to clear/set output pins in
-	 * open drain mode safely
-	 */
-	u32 data;
-	struct irq_host *irq;
-	void *of_dev_id_data;
-};
-
-static inline u32 mpc8xxx_gpio2mask(unsigned int gpio)
-{
-	return 1u << (MPC8XXX_GPIO_PINS - 1 - gpio);
-}
-
-static inline struct mpc8xxx_gpio_chip *
-to_mpc8xxx_gpio_chip(struct of_mm_gpio_chip *mm)
-{
-	return container_of(mm, struct mpc8xxx_gpio_chip, mm_gc);
-}
-
-static void mpc8xxx_gpio_save_regs(struct of_mm_gpio_chip *mm)
-{
-	struct mpc8xxx_gpio_chip *mpc8xxx_gc = to_mpc8xxx_gpio_chip(mm);
-
-	mpc8xxx_gc->data = in_be32(mm->regs + GPIO_DAT);
-}
-
-/* Workaround GPIO 1 errata on MPC8572/MPC8536. The status of GPIOs
- * defined as output cannot be determined by reading GPDAT register,
- * so we use shadow data register instead. The status of input pins
- * is determined by reading GPDAT register.
- */
-static int mpc8572_gpio_get(struct gpio_chip *gc, unsigned int gpio)
-{
-	u32 val;
-	struct of_mm_gpio_chip *mm = to_of_mm_gpio_chip(gc);
-	struct mpc8xxx_gpio_chip *mpc8xxx_gc = to_mpc8xxx_gpio_chip(mm);
-
-	val = in_be32(mm->regs + GPIO_DAT) & ~in_be32(mm->regs + GPIO_DIR);
-
-	return (val | mpc8xxx_gc->data) & mpc8xxx_gpio2mask(gpio);
-}
-
-static int mpc8xxx_gpio_get(struct gpio_chip *gc, unsigned int gpio)
-{
-	struct of_mm_gpio_chip *mm = to_of_mm_gpio_chip(gc);
-
-	return in_be32(mm->regs + GPIO_DAT) & mpc8xxx_gpio2mask(gpio);
-}
-
-static void mpc8xxx_gpio_set(struct gpio_chip *gc, unsigned int gpio, int val)
-{
-	struct of_mm_gpio_chip *mm = to_of_mm_gpio_chip(gc);
-	struct mpc8xxx_gpio_chip *mpc8xxx_gc = to_mpc8xxx_gpio_chip(mm);
-	unsigned long flags;
-
-	spin_lock_irqsave(&mpc8xxx_gc->lock, flags);
-
-	if (val)
-		mpc8xxx_gc->data |= mpc8xxx_gpio2mask(gpio);
-	else
-		mpc8xxx_gc->data &= ~mpc8xxx_gpio2mask(gpio);
-
-	out_be32(mm->regs + GPIO_DAT, mpc8xxx_gc->data);
-
-	spin_unlock_irqrestore(&mpc8xxx_gc->lock, flags);
-}
-
-static int mpc8xxx_gpio_dir_in(struct gpio_chip *gc, unsigned int gpio)
-{
-	struct of_mm_gpio_chip *mm = to_of_mm_gpio_chip(gc);
-	struct mpc8xxx_gpio_chip *mpc8xxx_gc = to_mpc8xxx_gpio_chip(mm);
-	unsigned long flags;
-
-	spin_lock_irqsave(&mpc8xxx_gc->lock, flags);
-
-	clrbits32(mm->regs + GPIO_DIR, mpc8xxx_gpio2mask(gpio));
-
-	spin_unlock_irqrestore(&mpc8xxx_gc->lock, flags);
-
-	return 0;
-}
-
-static int mpc8xxx_gpio_dir_out(struct gpio_chip *gc, unsigned int gpio, int val)
-{
-	struct of_mm_gpio_chip *mm = to_of_mm_gpio_chip(gc);
-	struct mpc8xxx_gpio_chip *mpc8xxx_gc = to_mpc8xxx_gpio_chip(mm);
-	unsigned long flags;
-
-	mpc8xxx_gpio_set(gc, gpio, val);
-
-	spin_lock_irqsave(&mpc8xxx_gc->lock, flags);
-
-	setbits32(mm->regs + GPIO_DIR, mpc8xxx_gpio2mask(gpio));
-
-	spin_unlock_irqrestore(&mpc8xxx_gc->lock, flags);
-
-	return 0;
-}
-
-static int mpc8xxx_gpio_to_irq(struct gpio_chip *gc, unsigned offset)
-{
-	struct of_mm_gpio_chip *mm = to_of_mm_gpio_chip(gc);
-	struct mpc8xxx_gpio_chip *mpc8xxx_gc = to_mpc8xxx_gpio_chip(mm);
-
-	if (mpc8xxx_gc->irq && offset < MPC8XXX_GPIO_PINS)
-		return irq_create_mapping(mpc8xxx_gc->irq, offset);
-	else
-		return -ENXIO;
-}
-
-static void mpc8xxx_gpio_irq_cascade(unsigned int irq, struct irq_desc *desc)
-{
-	struct mpc8xxx_gpio_chip *mpc8xxx_gc = irq_desc_get_handler_data(desc);
-	struct of_mm_gpio_chip *mm = &mpc8xxx_gc->mm_gc;
-	unsigned int mask;
-
-	mask = in_be32(mm->regs + GPIO_IER) & in_be32(mm->regs + GPIO_IMR);
-	if (mask)
-		generic_handle_irq(irq_linear_revmap(mpc8xxx_gc->irq,
-						     32 - ffs(mask)));
-}
-
-static void mpc8xxx_irq_unmask(struct irq_data *d)
-{
-	struct mpc8xxx_gpio_chip *mpc8xxx_gc = irq_data_get_irq_chip_data(d);
-	struct of_mm_gpio_chip *mm = &mpc8xxx_gc->mm_gc;
-	unsigned long flags;
-
-	spin_lock_irqsave(&mpc8xxx_gc->lock, flags);
-
-	setbits32(mm->regs + GPIO_IMR, mpc8xxx_gpio2mask(irqd_to_hwirq(d)));
-
-	spin_unlock_irqrestore(&mpc8xxx_gc->lock, flags);
-}
-
-static void mpc8xxx_irq_mask(struct irq_data *d)
-{
-	struct mpc8xxx_gpio_chip *mpc8xxx_gc = irq_data_get_irq_chip_data(d);
-	struct of_mm_gpio_chip *mm = &mpc8xxx_gc->mm_gc;
-	unsigned long flags;
-
-	spin_lock_irqsave(&mpc8xxx_gc->lock, flags);
-
-	clrbits32(mm->regs + GPIO_IMR, mpc8xxx_gpio2mask(irqd_to_hwirq(d)));
-
-	spin_unlock_irqrestore(&mpc8xxx_gc->lock, flags);
-}
-
-static void mpc8xxx_irq_ack(struct irq_data *d)
-{
-	struct mpc8xxx_gpio_chip *mpc8xxx_gc = irq_data_get_irq_chip_data(d);
-	struct of_mm_gpio_chip *mm = &mpc8xxx_gc->mm_gc;
-
-	out_be32(mm->regs + GPIO_IER, mpc8xxx_gpio2mask(irqd_to_hwirq(d)));
-}
-
-static int mpc8xxx_irq_set_type(struct irq_data *d, unsigned int flow_type)
-{
-	struct mpc8xxx_gpio_chip *mpc8xxx_gc = irq_data_get_irq_chip_data(d);
-	struct of_mm_gpio_chip *mm = &mpc8xxx_gc->mm_gc;
-	unsigned long flags;
-
-	switch (flow_type) {
-	case IRQ_TYPE_EDGE_FALLING:
-		spin_lock_irqsave(&mpc8xxx_gc->lock, flags);
-		setbits32(mm->regs + GPIO_ICR,
-			  mpc8xxx_gpio2mask(irqd_to_hwirq(d)));
-		spin_unlock_irqrestore(&mpc8xxx_gc->lock, flags);
-		break;
-
-	case IRQ_TYPE_EDGE_BOTH:
-		spin_lock_irqsave(&mpc8xxx_gc->lock, flags);
-		clrbits32(mm->regs + GPIO_ICR,
-			  mpc8xxx_gpio2mask(irqd_to_hwirq(d)));
-		spin_unlock_irqrestore(&mpc8xxx_gc->lock, flags);
-		break;
-
-	default:
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-static int mpc512x_irq_set_type(struct irq_data *d, unsigned int flow_type)
-{
-	struct mpc8xxx_gpio_chip *mpc8xxx_gc = irq_data_get_irq_chip_data(d);
-	struct of_mm_gpio_chip *mm = &mpc8xxx_gc->mm_gc;
-	unsigned long gpio = irqd_to_hwirq(d);
-	void __iomem *reg;
-	unsigned int shift;
-	unsigned long flags;
-
-	if (gpio < 16) {
-		reg = mm->regs + GPIO_ICR;
-		shift = (15 - gpio) * 2;
-	} else {
-		reg = mm->regs + GPIO_ICR2;
-		shift = (15 - (gpio % 16)) * 2;
-	}
-
-	switch (flow_type) {
-	case IRQ_TYPE_EDGE_FALLING:
-	case IRQ_TYPE_LEVEL_LOW:
-		spin_lock_irqsave(&mpc8xxx_gc->lock, flags);
-		clrsetbits_be32(reg, 3 << shift, 2 << shift);
-		spin_unlock_irqrestore(&mpc8xxx_gc->lock, flags);
-		break;
-
-	case IRQ_TYPE_EDGE_RISING:
-	case IRQ_TYPE_LEVEL_HIGH:
-		spin_lock_irqsave(&mpc8xxx_gc->lock, flags);
-		clrsetbits_be32(reg, 3 << shift, 1 << shift);
-		spin_unlock_irqrestore(&mpc8xxx_gc->lock, flags);
-		break;
-
-	case IRQ_TYPE_EDGE_BOTH:
-		spin_lock_irqsave(&mpc8xxx_gc->lock, flags);
-		clrbits32(reg, 3 << shift);
-		spin_unlock_irqrestore(&mpc8xxx_gc->lock, flags);
-		break;
-
-	default:
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-static struct irq_chip mpc8xxx_irq_chip = {
-	.name		= "mpc8xxx-gpio",
-	.irq_unmask	= mpc8xxx_irq_unmask,
-	.irq_mask	= mpc8xxx_irq_mask,
-	.irq_ack	= mpc8xxx_irq_ack,
-	.irq_set_type	= mpc8xxx_irq_set_type,
-};
-
-static int mpc8xxx_gpio_irq_map(struct irq_host *h, unsigned int virq,
-				irq_hw_number_t hw)
-{
-	struct mpc8xxx_gpio_chip *mpc8xxx_gc = h->host_data;
-
-	if (mpc8xxx_gc->of_dev_id_data)
-		mpc8xxx_irq_chip.irq_set_type = mpc8xxx_gc->of_dev_id_data;
-
-	irq_set_chip_data(virq, h->host_data);
-	irq_set_chip_and_handler(virq, &mpc8xxx_irq_chip, handle_level_irq);
-	irq_set_irq_type(virq, IRQ_TYPE_NONE);
-
-	return 0;
-}
-
-static int mpc8xxx_gpio_irq_xlate(struct irq_host *h, struct device_node *ct,
-				  const u32 *intspec, unsigned int intsize,
-				  irq_hw_number_t *out_hwirq,
-				  unsigned int *out_flags)
-
-{
-	/* interrupt sense values coming from the device tree equal either
-	 * EDGE_FALLING or EDGE_BOTH
-	 */
-	*out_hwirq = intspec[0];
-	*out_flags = intspec[1];
-
-	return 0;
-}
-
-static struct irq_host_ops mpc8xxx_gpio_irq_ops = {
-	.map	= mpc8xxx_gpio_irq_map,
-	.xlate	= mpc8xxx_gpio_irq_xlate,
-};
-
-static struct of_device_id mpc8xxx_gpio_ids[] __initdata = {
-	{ .compatible = "fsl,mpc8349-gpio", },
-	{ .compatible = "fsl,mpc8572-gpio", },
-	{ .compatible = "fsl,mpc8610-gpio", },
-	{ .compatible = "fsl,mpc5121-gpio", .data = mpc512x_irq_set_type, },
-	{ .compatible = "fsl,qoriq-gpio",   },
-	{}
-};
-
-static void __init mpc8xxx_add_controller(struct device_node *np)
-{
-	struct mpc8xxx_gpio_chip *mpc8xxx_gc;
-	struct of_mm_gpio_chip *mm_gc;
-	struct gpio_chip *gc;
-	const struct of_device_id *id;
-	unsigned hwirq;
-	int ret;
-
-	mpc8xxx_gc = kzalloc(sizeof(*mpc8xxx_gc), GFP_KERNEL);
-	if (!mpc8xxx_gc) {
-		ret = -ENOMEM;
-		goto err;
-	}
-
-	spin_lock_init(&mpc8xxx_gc->lock);
-
-	mm_gc = &mpc8xxx_gc->mm_gc;
-	gc = &mm_gc->gc;
-
-	mm_gc->save_regs = mpc8xxx_gpio_save_regs;
-	gc->ngpio = MPC8XXX_GPIO_PINS;
-	gc->direction_input = mpc8xxx_gpio_dir_in;
-	gc->direction_output = mpc8xxx_gpio_dir_out;
-	if (of_device_is_compatible(np, "fsl,mpc8572-gpio"))
-		gc->get = mpc8572_gpio_get;
-	else
-		gc->get = mpc8xxx_gpio_get;
-	gc->set = mpc8xxx_gpio_set;
-	gc->to_irq = mpc8xxx_gpio_to_irq;
-
-	ret = of_mm_gpiochip_add(np, mm_gc);
-	if (ret)
-		goto err;
-
-	hwirq = irq_of_parse_and_map(np, 0);
-	if (hwirq == NO_IRQ)
-		goto skip_irq;
-
-	mpc8xxx_gc->irq =
-		irq_alloc_host(np, IRQ_HOST_MAP_LINEAR, MPC8XXX_GPIO_PINS,
-			       &mpc8xxx_gpio_irq_ops, MPC8XXX_GPIO_PINS);
-	if (!mpc8xxx_gc->irq)
-		goto skip_irq;
-
-	id = of_match_node(mpc8xxx_gpio_ids, np);
-	if (id)
-		mpc8xxx_gc->of_dev_id_data = id->data;
-
-	mpc8xxx_gc->irq->host_data = mpc8xxx_gc;
-
-	/* ack and mask all irqs */
-	out_be32(mm_gc->regs + GPIO_IER, 0xffffffff);
-	out_be32(mm_gc->regs + GPIO_IMR, 0);
-
-	irq_set_handler_data(hwirq, mpc8xxx_gc);
-	irq_set_chained_handler(hwirq, mpc8xxx_gpio_irq_cascade);
-
-skip_irq:
-	return;
-
-err:
-	pr_err("%s: registration failed with status %d\n",
-	       np->full_name, ret);
-	kfree(mpc8xxx_gc);
-
-	return;
-}
-
-static int __init mpc8xxx_add_gpiochips(void)
-{
-	struct device_node *np;
-
-	for_each_matching_node(np, mpc8xxx_gpio_ids)
-		mpc8xxx_add_controller(np);
-
-	return 0;
-}
-arch_initcall(mpc8xxx_add_gpiochips);
diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index d539efd..4744cf2 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -103,6 +103,14 @@ config GPIO_MPC5200
 	def_bool y
 	depends on PPC_MPC52xx
 
+config GPIO_MPC8XXX
+	bool "MPC512x/MPC8xxx GPIO support"
+	depends on PPC_MPC512x || PPC_MPC831x || PPC_MPC834x || PPC_MPC837x || \
+		   FSL_SOC_BOOKE || PPC_86xx
+	help
+	  Say Y here if you're going to use hardware that connects to the
+	  MPC512x/831x/834x/837x/8572/8610 GPIOs.
+
 config GPIO_MSM_V1
 	tristate "Qualcomm MSM GPIO v1"
 	depends on GPIOLIB && ARCH_MSM
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 9588948..828bba9 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -27,6 +27,7 @@ obj-$(CONFIG_GPIO_MC33880)	+= gpio-mc33880.o
 obj-$(CONFIG_GPIO_MCP23S08)	+= gpio-mcp23s08.o
 obj-$(CONFIG_GPIO_ML_IOH)	+= gpio-ml-ioh.o
 obj-$(CONFIG_GPIO_MPC5200)	+= gpio-mpc5200.o
+obj-$(CONFIG_GPIO_MPC8XXX)	+= gpio-mpc8xxx.o
 obj-$(CONFIG_GPIO_MSM_V1)	+= gpio-msm-v1.o
 obj-$(CONFIG_GPIO_MSM_V2)	+= gpio-msm-v2.o
 obj-$(CONFIG_GPIO_MXC)		+= gpio-mxc.o
diff --git a/drivers/gpio/gpio-mpc8xxx.c b/drivers/gpio/gpio-mpc8xxx.c
new file mode 100644
index 0000000..fb4963a
--- /dev/null
+++ b/drivers/gpio/gpio-mpc8xxx.c
@@ -0,0 +1,395 @@
+/*
+ * GPIOs on MPC512x/8349/8572/8610 and compatible
+ *
+ * Copyright (C) 2008 Peter Korsgaard <jacmet@sunsite.dk>
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/spinlock.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_gpio.h>
+#include <linux/gpio.h>
+#include <linux/slab.h>
+#include <linux/irq.h>
+
+#define MPC8XXX_GPIO_PINS	32
+
+#define GPIO_DIR		0x00
+#define GPIO_ODR		0x04
+#define GPIO_DAT		0x08
+#define GPIO_IER		0x0c
+#define GPIO_IMR		0x10
+#define GPIO_ICR		0x14
+#define GPIO_ICR2		0x18
+
+struct mpc8xxx_gpio_chip {
+	struct of_mm_gpio_chip mm_gc;
+	spinlock_t lock;
+
+	/*
+	 * shadowed data register to be able to clear/set output pins in
+	 * open drain mode safely
+	 */
+	u32 data;
+	struct irq_host *irq;
+	void *of_dev_id_data;
+};
+
+static inline u32 mpc8xxx_gpio2mask(unsigned int gpio)
+{
+	return 1u << (MPC8XXX_GPIO_PINS - 1 - gpio);
+}
+
+static inline struct mpc8xxx_gpio_chip *
+to_mpc8xxx_gpio_chip(struct of_mm_gpio_chip *mm)
+{
+	return container_of(mm, struct mpc8xxx_gpio_chip, mm_gc);
+}
+
+static void mpc8xxx_gpio_save_regs(struct of_mm_gpio_chip *mm)
+{
+	struct mpc8xxx_gpio_chip *mpc8xxx_gc = to_mpc8xxx_gpio_chip(mm);
+
+	mpc8xxx_gc->data = in_be32(mm->regs + GPIO_DAT);
+}
+
+/* Workaround GPIO 1 errata on MPC8572/MPC8536. The status of GPIOs
+ * defined as output cannot be determined by reading GPDAT register,
+ * so we use shadow data register instead. The status of input pins
+ * is determined by reading GPDAT register.
+ */
+static int mpc8572_gpio_get(struct gpio_chip *gc, unsigned int gpio)
+{
+	u32 val;
+	struct of_mm_gpio_chip *mm = to_of_mm_gpio_chip(gc);
+	struct mpc8xxx_gpio_chip *mpc8xxx_gc = to_mpc8xxx_gpio_chip(mm);
+
+	val = in_be32(mm->regs + GPIO_DAT) & ~in_be32(mm->regs + GPIO_DIR);
+
+	return (val | mpc8xxx_gc->data) & mpc8xxx_gpio2mask(gpio);
+}
+
+static int mpc8xxx_gpio_get(struct gpio_chip *gc, unsigned int gpio)
+{
+	struct of_mm_gpio_chip *mm = to_of_mm_gpio_chip(gc);
+
+	return in_be32(mm->regs + GPIO_DAT) & mpc8xxx_gpio2mask(gpio);
+}
+
+static void mpc8xxx_gpio_set(struct gpio_chip *gc, unsigned int gpio, int val)
+{
+	struct of_mm_gpio_chip *mm = to_of_mm_gpio_chip(gc);
+	struct mpc8xxx_gpio_chip *mpc8xxx_gc = to_mpc8xxx_gpio_chip(mm);
+	unsigned long flags;
+
+	spin_lock_irqsave(&mpc8xxx_gc->lock, flags);
+
+	if (val)
+		mpc8xxx_gc->data |= mpc8xxx_gpio2mask(gpio);
+	else
+		mpc8xxx_gc->data &= ~mpc8xxx_gpio2mask(gpio);
+
+	out_be32(mm->regs + GPIO_DAT, mpc8xxx_gc->data);
+
+	spin_unlock_irqrestore(&mpc8xxx_gc->lock, flags);
+}
+
+static int mpc8xxx_gpio_dir_in(struct gpio_chip *gc, unsigned int gpio)
+{
+	struct of_mm_gpio_chip *mm = to_of_mm_gpio_chip(gc);
+	struct mpc8xxx_gpio_chip *mpc8xxx_gc = to_mpc8xxx_gpio_chip(mm);
+	unsigned long flags;
+
+	spin_lock_irqsave(&mpc8xxx_gc->lock, flags);
+
+	clrbits32(mm->regs + GPIO_DIR, mpc8xxx_gpio2mask(gpio));
+
+	spin_unlock_irqrestore(&mpc8xxx_gc->lock, flags);
+
+	return 0;
+}
+
+static int mpc8xxx_gpio_dir_out(struct gpio_chip *gc, unsigned int gpio, int val)
+{
+	struct of_mm_gpio_chip *mm = to_of_mm_gpio_chip(gc);
+	struct mpc8xxx_gpio_chip *mpc8xxx_gc = to_mpc8xxx_gpio_chip(mm);
+	unsigned long flags;
+
+	mpc8xxx_gpio_set(gc, gpio, val);
+
+	spin_lock_irqsave(&mpc8xxx_gc->lock, flags);
+
+	setbits32(mm->regs + GPIO_DIR, mpc8xxx_gpio2mask(gpio));
+
+	spin_unlock_irqrestore(&mpc8xxx_gc->lock, flags);
+
+	return 0;
+}
+
+static int mpc8xxx_gpio_to_irq(struct gpio_chip *gc, unsigned offset)
+{
+	struct of_mm_gpio_chip *mm = to_of_mm_gpio_chip(gc);
+	struct mpc8xxx_gpio_chip *mpc8xxx_gc = to_mpc8xxx_gpio_chip(mm);
+
+	if (mpc8xxx_gc->irq && offset < MPC8XXX_GPIO_PINS)
+		return irq_create_mapping(mpc8xxx_gc->irq, offset);
+	else
+		return -ENXIO;
+}
+
+static void mpc8xxx_gpio_irq_cascade(unsigned int irq, struct irq_desc *desc)
+{
+	struct mpc8xxx_gpio_chip *mpc8xxx_gc = irq_desc_get_handler_data(desc);
+	struct of_mm_gpio_chip *mm = &mpc8xxx_gc->mm_gc;
+	unsigned int mask;
+
+	mask = in_be32(mm->regs + GPIO_IER) & in_be32(mm->regs + GPIO_IMR);
+	if (mask)
+		generic_handle_irq(irq_linear_revmap(mpc8xxx_gc->irq,
+						     32 - ffs(mask)));
+}
+
+static void mpc8xxx_irq_unmask(struct irq_data *d)
+{
+	struct mpc8xxx_gpio_chip *mpc8xxx_gc = irq_data_get_irq_chip_data(d);
+	struct of_mm_gpio_chip *mm = &mpc8xxx_gc->mm_gc;
+	unsigned long flags;
+
+	spin_lock_irqsave(&mpc8xxx_gc->lock, flags);
+
+	setbits32(mm->regs + GPIO_IMR, mpc8xxx_gpio2mask(irqd_to_hwirq(d)));
+
+	spin_unlock_irqrestore(&mpc8xxx_gc->lock, flags);
+}
+
+static void mpc8xxx_irq_mask(struct irq_data *d)
+{
+	struct mpc8xxx_gpio_chip *mpc8xxx_gc = irq_data_get_irq_chip_data(d);
+	struct of_mm_gpio_chip *mm = &mpc8xxx_gc->mm_gc;
+	unsigned long flags;
+
+	spin_lock_irqsave(&mpc8xxx_gc->lock, flags);
+
+	clrbits32(mm->regs + GPIO_IMR, mpc8xxx_gpio2mask(irqd_to_hwirq(d)));
+
+	spin_unlock_irqrestore(&mpc8xxx_gc->lock, flags);
+}
+
+static void mpc8xxx_irq_ack(struct irq_data *d)
+{
+	struct mpc8xxx_gpio_chip *mpc8xxx_gc = irq_data_get_irq_chip_data(d);
+	struct of_mm_gpio_chip *mm = &mpc8xxx_gc->mm_gc;
+
+	out_be32(mm->regs + GPIO_IER, mpc8xxx_gpio2mask(irqd_to_hwirq(d)));
+}
+
+static int mpc8xxx_irq_set_type(struct irq_data *d, unsigned int flow_type)
+{
+	struct mpc8xxx_gpio_chip *mpc8xxx_gc = irq_data_get_irq_chip_data(d);
+	struct of_mm_gpio_chip *mm = &mpc8xxx_gc->mm_gc;
+	unsigned long flags;
+
+	switch (flow_type) {
+	case IRQ_TYPE_EDGE_FALLING:
+		spin_lock_irqsave(&mpc8xxx_gc->lock, flags);
+		setbits32(mm->regs + GPIO_ICR,
+			  mpc8xxx_gpio2mask(irqd_to_hwirq(d)));
+		spin_unlock_irqrestore(&mpc8xxx_gc->lock, flags);
+		break;
+
+	case IRQ_TYPE_EDGE_BOTH:
+		spin_lock_irqsave(&mpc8xxx_gc->lock, flags);
+		clrbits32(mm->regs + GPIO_ICR,
+			  mpc8xxx_gpio2mask(irqd_to_hwirq(d)));
+		spin_unlock_irqrestore(&mpc8xxx_gc->lock, flags);
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int mpc512x_irq_set_type(struct irq_data *d, unsigned int flow_type)
+{
+	struct mpc8xxx_gpio_chip *mpc8xxx_gc = irq_data_get_irq_chip_data(d);
+	struct of_mm_gpio_chip *mm = &mpc8xxx_gc->mm_gc;
+	unsigned long gpio = irqd_to_hwirq(d);
+	void __iomem *reg;
+	unsigned int shift;
+	unsigned long flags;
+
+	if (gpio < 16) {
+		reg = mm->regs + GPIO_ICR;
+		shift = (15 - gpio) * 2;
+	} else {
+		reg = mm->regs + GPIO_ICR2;
+		shift = (15 - (gpio % 16)) * 2;
+	}
+
+	switch (flow_type) {
+	case IRQ_TYPE_EDGE_FALLING:
+	case IRQ_TYPE_LEVEL_LOW:
+		spin_lock_irqsave(&mpc8xxx_gc->lock, flags);
+		clrsetbits_be32(reg, 3 << shift, 2 << shift);
+		spin_unlock_irqrestore(&mpc8xxx_gc->lock, flags);
+		break;
+
+	case IRQ_TYPE_EDGE_RISING:
+	case IRQ_TYPE_LEVEL_HIGH:
+		spin_lock_irqsave(&mpc8xxx_gc->lock, flags);
+		clrsetbits_be32(reg, 3 << shift, 1 << shift);
+		spin_unlock_irqrestore(&mpc8xxx_gc->lock, flags);
+		break;
+
+	case IRQ_TYPE_EDGE_BOTH:
+		spin_lock_irqsave(&mpc8xxx_gc->lock, flags);
+		clrbits32(reg, 3 << shift);
+		spin_unlock_irqrestore(&mpc8xxx_gc->lock, flags);
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static struct irq_chip mpc8xxx_irq_chip = {
+	.name		= "mpc8xxx-gpio",
+	.irq_unmask	= mpc8xxx_irq_unmask,
+	.irq_mask	= mpc8xxx_irq_mask,
+	.irq_ack	= mpc8xxx_irq_ack,
+	.irq_set_type	= mpc8xxx_irq_set_type,
+};
+
+static int mpc8xxx_gpio_irq_map(struct irq_host *h, unsigned int virq,
+				irq_hw_number_t hw)
+{
+	struct mpc8xxx_gpio_chip *mpc8xxx_gc = h->host_data;
+
+	if (mpc8xxx_gc->of_dev_id_data)
+		mpc8xxx_irq_chip.irq_set_type = mpc8xxx_gc->of_dev_id_data;
+
+	irq_set_chip_data(virq, h->host_data);
+	irq_set_chip_and_handler(virq, &mpc8xxx_irq_chip, handle_level_irq);
+	irq_set_irq_type(virq, IRQ_TYPE_NONE);
+
+	return 0;
+}
+
+static int mpc8xxx_gpio_irq_xlate(struct irq_host *h, struct device_node *ct,
+				  const u32 *intspec, unsigned int intsize,
+				  irq_hw_number_t *out_hwirq,
+				  unsigned int *out_flags)
+
+{
+	/* interrupt sense values coming from the device tree equal either
+	 * EDGE_FALLING or EDGE_BOTH
+	 */
+	*out_hwirq = intspec[0];
+	*out_flags = intspec[1];
+
+	return 0;
+}
+
+static struct irq_host_ops mpc8xxx_gpio_irq_ops = {
+	.map	= mpc8xxx_gpio_irq_map,
+	.xlate	= mpc8xxx_gpio_irq_xlate,
+};
+
+static struct of_device_id mpc8xxx_gpio_ids[] __initdata = {
+	{ .compatible = "fsl,mpc8349-gpio", },
+	{ .compatible = "fsl,mpc8572-gpio", },
+	{ .compatible = "fsl,mpc8610-gpio", },
+	{ .compatible = "fsl,mpc5121-gpio", .data = mpc512x_irq_set_type, },
+	{ .compatible = "fsl,qoriq-gpio",   },
+	{}
+};
+
+static void __init mpc8xxx_add_controller(struct device_node *np)
+{
+	struct mpc8xxx_gpio_chip *mpc8xxx_gc;
+	struct of_mm_gpio_chip *mm_gc;
+	struct gpio_chip *gc;
+	const struct of_device_id *id;
+	unsigned hwirq;
+	int ret;
+
+	mpc8xxx_gc = kzalloc(sizeof(*mpc8xxx_gc), GFP_KERNEL);
+	if (!mpc8xxx_gc) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	spin_lock_init(&mpc8xxx_gc->lock);
+
+	mm_gc = &mpc8xxx_gc->mm_gc;
+	gc = &mm_gc->gc;
+
+	mm_gc->save_regs = mpc8xxx_gpio_save_regs;
+	gc->ngpio = MPC8XXX_GPIO_PINS;
+	gc->direction_input = mpc8xxx_gpio_dir_in;
+	gc->direction_output = mpc8xxx_gpio_dir_out;
+	if (of_device_is_compatible(np, "fsl,mpc8572-gpio"))
+		gc->get = mpc8572_gpio_get;
+	else
+		gc->get = mpc8xxx_gpio_get;
+	gc->set = mpc8xxx_gpio_set;
+	gc->to_irq = mpc8xxx_gpio_to_irq;
+
+	ret = of_mm_gpiochip_add(np, mm_gc);
+	if (ret)
+		goto err;
+
+	hwirq = irq_of_parse_and_map(np, 0);
+	if (hwirq == NO_IRQ)
+		goto skip_irq;
+
+	mpc8xxx_gc->irq =
+		irq_alloc_host(np, IRQ_HOST_MAP_LINEAR, MPC8XXX_GPIO_PINS,
+			       &mpc8xxx_gpio_irq_ops, MPC8XXX_GPIO_PINS);
+	if (!mpc8xxx_gc->irq)
+		goto skip_irq;
+
+	id = of_match_node(mpc8xxx_gpio_ids, np);
+	if (id)
+		mpc8xxx_gc->of_dev_id_data = id->data;
+
+	mpc8xxx_gc->irq->host_data = mpc8xxx_gc;
+
+	/* ack and mask all irqs */
+	out_be32(mm_gc->regs + GPIO_IER, 0xffffffff);
+	out_be32(mm_gc->regs + GPIO_IMR, 0);
+
+	irq_set_handler_data(hwirq, mpc8xxx_gc);
+	irq_set_chained_handler(hwirq, mpc8xxx_gpio_irq_cascade);
+
+skip_irq:
+	return;
+
+err:
+	pr_err("%s: registration failed with status %d\n",
+	       np->full_name, ret);
+	kfree(mpc8xxx_gc);
+
+	return;
+}
+
+static int __init mpc8xxx_add_gpiochips(void)
+{
+	struct device_node *np;
+
+	for_each_matching_node(np, mpc8xxx_gpio_ids)
+		mpc8xxx_add_controller(np);
+
+	return 0;
+}
+arch_initcall(mpc8xxx_add_gpiochips);
-- 
1.7.5.4
