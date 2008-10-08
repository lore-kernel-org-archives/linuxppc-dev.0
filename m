Return-Path: <bgat@billgatliff.com>
Received: from venus.billgatliff.com (venus.billgatliff.com [209.251.101.201])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C84CDDDE45
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Oct 2008 04:17:17 +1100 (EST)
From: Bill Gatliff <bgat@billgatliff.com>
To: linuxppc-dev@ozlabs.org
Subject: [RFC 5/6] [PWM] Install new Atmel PWMC driver in Kconfig,
	expunge old one
Date: Wed,  8 Oct 2008 11:43:16 -0500
Message-Id: <475b4a5985463015fdfa943b9835ab8136dbc06a.1223482372.git.bgat@billgatliff.com>
In-Reply-To: <5640f37b779f953c83e79c16b2a0466c0f5da702.1223482372.git.bgat@billgatliff.com>
References: <cover.1223482372.git.bgat@billgatliff.com>
	<4b5c3aa2b1bc2b7efad834da49c2dec8c0a8726b.1223482372.git.bgat@billgatliff.com>
	<88de40673cc33e014928c2ee3a86bdac566021c8.1223482372.git.bgat@billgatliff.com>
	<7b16004ca5f8030184c2de96cbcee38657d56252.1223482372.git.bgat@billgatliff.com>
	<5640f37b779f953c83e79c16b2a0466c0f5da702.1223482372.git.bgat@billgatliff.com>
In-Reply-To: <cover.1223482372.git.bgat@billgatliff.com>
References: <cover.1223482372.git.bgat@billgatliff.com>
Cc: Bill Gatliff <bgat@billgatliff.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Bill Gatliff <bgat@billgatliff.com>
---
 arch/arm/Kconfig         |    2 +
 drivers/Makefile         |    2 +
 drivers/misc/Kconfig     |    9 -
 drivers/misc/Makefile    |    1 -
 drivers/misc/atmel_pwm.c |  409 ----------------------------------------------
 drivers/pwm/Kconfig      |   24 +++
 drivers/pwm/Makefile     |    6 +
 7 files changed, 34 insertions(+), 419 deletions(-)
 delete mode 100644 drivers/misc/atmel_pwm.c
 create mode 100644 drivers/pwm/Kconfig
 create mode 100644 drivers/pwm/Makefile

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 70dba16..fed3eef 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1196,6 +1196,8 @@ source "drivers/spi/Kconfig"
 
 source "drivers/gpio/Kconfig"
 
+source "drivers/pwm/Kconfig"
+
 source "drivers/w1/Kconfig"
 
 source "drivers/power/Kconfig"
diff --git a/drivers/Makefile b/drivers/Makefile
index 2735bde..f242fc6 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -6,6 +6,8 @@
 #
 
 obj-y				+= gpio/
+obj-$(CONFIG_GENERIC_PWM)	+= pwm/
+
 obj-$(CONFIG_PCI)		+= pci/
 obj-$(CONFIG_PARISC)		+= parisc/
 obj-$(CONFIG_RAPIDIO)		+= rapidio/
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index a726f3b..cdea0bb 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -13,15 +13,6 @@ menuconfig MISC_DEVICES
 
 if MISC_DEVICES
 
-config ATMEL_PWM
-	tristate "Atmel AT32/AT91 PWM support"
-	depends on AVR32 || ARCH_AT91
-	help
-	  This option enables device driver support for the PWM channels
-	  on certain Atmel prcoessors.  Pulse Width Modulation is used for
-	  purposes including software controlled power-efficent backlights
-	  on LCD displays, motor control, and waveform generation.
-
 config ATMEL_TCLIB
 	bool "Atmel AT32/AT91 Timer/Counter Library"
 	depends on (AVR32 || ARCH_AT91)
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index c6c13f6..9e67012 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -10,7 +10,6 @@ obj-$(CONFIG_EEEPC_LAPTOP)	+= eeepc-laptop.o
 obj-$(CONFIG_MSI_LAPTOP)	+= msi-laptop.o
 obj-$(CONFIG_COMPAL_LAPTOP)	+= compal-laptop.o
 obj-$(CONFIG_ACER_WMI)		+= acer-wmi.o
-obj-$(CONFIG_ATMEL_PWM)		+= atmel_pwm.o
 obj-$(CONFIG_ATMEL_SSC)		+= atmel-ssc.o
 obj-$(CONFIG_ATMEL_TCLIB)	+= atmel_tclib.o
 obj-$(CONFIG_HP_WMI)		+= hp-wmi.o
diff --git a/drivers/misc/atmel_pwm.c b/drivers/misc/atmel_pwm.c
deleted file mode 100644
index 6aa5294..0000000
--- a/drivers/misc/atmel_pwm.c
+++ /dev/null
@@ -1,409 +0,0 @@
-#include <linux/module.h>
-#include <linux/clk.h>
-#include <linux/err.h>
-#include <linux/io.h>
-#include <linux/interrupt.h>
-#include <linux/platform_device.h>
-#include <linux/atmel_pwm.h>
-
-
-/*
- * This is a simple driver for the PWM controller found in various newer
- * Atmel SOCs, including the AVR32 series and the AT91sam9263.
- *
- * Chips with current Linux ports have only 4 PWM channels, out of max 32.
- * AT32UC3A and AT32UC3B chips have 7 channels (but currently no Linux).
- * Docs are inconsistent about the width of the channel counter registers;
- * it's at least 16 bits, but several places say 20 bits.
- */
-#define	PWM_NCHAN	4		/* max 32 */
-
-struct pwm {
-	spinlock_t		lock;
-	struct platform_device	*pdev;
-	u32			mask;
-	int			irq;
-	void __iomem		*base;
-	struct clk		*clk;
-	struct pwm_channel	*channel[PWM_NCHAN];
-	void			(*handler[PWM_NCHAN])(struct pwm_channel *);
-};
-
-
-/* global PWM controller registers */
-#define PWM_MR		0x00
-#define PWM_ENA		0x04
-#define PWM_DIS		0x08
-#define PWM_SR		0x0c
-#define PWM_IER		0x10
-#define PWM_IDR		0x14
-#define PWM_IMR		0x18
-#define PWM_ISR		0x1c
-
-static inline void pwm_writel(const struct pwm *p, unsigned offset, u32 val)
-{
-	__raw_writel(val, p->base + offset);
-}
-
-static inline u32 pwm_readl(const struct pwm *p, unsigned offset)
-{
-	return __raw_readl(p->base + offset);
-}
-
-static inline void __iomem *pwmc_regs(const struct pwm *p, int index)
-{
-	return p->base + 0x200 + index * 0x20;
-}
-
-static struct pwm *pwm;
-
-static void pwm_dumpregs(struct pwm_channel *ch, char *tag)
-{
-	struct device	*dev = &pwm->pdev->dev;
-
-	dev_dbg(dev, "%s: mr %08x, sr %08x, imr %08x\n",
-		tag,
-		pwm_readl(pwm, PWM_MR),
-		pwm_readl(pwm, PWM_SR),
-		pwm_readl(pwm, PWM_IMR));
-	dev_dbg(dev,
-		"pwm ch%d - mr %08x, dty %u, prd %u, cnt %u\n",
-		ch->index,
-		pwm_channel_readl(ch, PWM_CMR),
-		pwm_channel_readl(ch, PWM_CDTY),
-		pwm_channel_readl(ch, PWM_CPRD),
-		pwm_channel_readl(ch, PWM_CCNT));
-}
-
-
-/**
- * pwm_channel_alloc - allocate an unused PWM channel
- * @index: identifies the channel
- * @ch: structure to be initialized
- *
- * Drivers allocate PWM channels according to the board's wiring, and
- * matching board-specific setup code.  Returns zero or negative errno.
- */
-int pwm_channel_alloc(int index, struct pwm_channel *ch)
-{
-	unsigned long	flags;
-	int		status = 0;
-
-	/* insist on PWM init, with this signal pinned out */
-	if (!pwm || !(pwm->mask & 1 << index))
-		return -ENODEV;
-
-	if (index < 0 || index >= PWM_NCHAN || !ch)
-		return -EINVAL;
-	memset(ch, 0, sizeof *ch);
-
-	spin_lock_irqsave(&pwm->lock, flags);
-	if (pwm->channel[index])
-		status = -EBUSY;
-	else {
-		clk_enable(pwm->clk);
-
-		ch->regs = pwmc_regs(pwm, index);
-		ch->index = index;
-
-		/* REVISIT: ap7000 seems to go 2x as fast as we expect!! */
-		ch->mck = clk_get_rate(pwm->clk);
-
-		pwm->channel[index] = ch;
-		pwm->handler[index] = NULL;
-
-		/* channel and irq are always disabled when we return */
-		pwm_writel(pwm, PWM_DIS, 1 << index);
-		pwm_writel(pwm, PWM_IDR, 1 << index);
-	}
-	spin_unlock_irqrestore(&pwm->lock, flags);
-	return status;
-}
-EXPORT_SYMBOL(pwm_channel_alloc);
-
-static int pwmcheck(struct pwm_channel *ch)
-{
-	int		index;
-
-	if (!pwm)
-		return -ENODEV;
-	if (!ch)
-		return -EINVAL;
-	index = ch->index;
-	if (index < 0 || index >= PWM_NCHAN || pwm->channel[index] != ch)
-		return -EINVAL;
-
-	return index;
-}
-
-/**
- * pwm_channel_free - release a previously allocated channel
- * @ch: the channel being released
- *
- * The channel is completely shut down (counter and IRQ disabled),
- * and made available for re-use.  Returns zero, or negative errno.
- */
-int pwm_channel_free(struct pwm_channel *ch)
-{
-	unsigned long	flags;
-	int		t;
-
-	spin_lock_irqsave(&pwm->lock, flags);
-	t = pwmcheck(ch);
-	if (t >= 0) {
-		pwm->channel[t] = NULL;
-		pwm->handler[t] = NULL;
-
-		/* channel and irq are always disabled when we return */
-		pwm_writel(pwm, PWM_DIS, 1 << t);
-		pwm_writel(pwm, PWM_IDR, 1 << t);
-
-		clk_disable(pwm->clk);
-		t = 0;
-	}
-	spin_unlock_irqrestore(&pwm->lock, flags);
-	return t;
-}
-EXPORT_SYMBOL(pwm_channel_free);
-
-int __pwm_channel_onoff(struct pwm_channel *ch, int enabled)
-{
-	unsigned long	flags;
-	int		t;
-
-	/* OMITTED FUNCTIONALITY:  starting several channels in synch */
-
-	spin_lock_irqsave(&pwm->lock, flags);
-	t = pwmcheck(ch);
-	if (t >= 0) {
-		pwm_writel(pwm, enabled ? PWM_ENA : PWM_DIS, 1 << t);
-		t = 0;
-		pwm_dumpregs(ch, enabled ? "enable" : "disable");
-	}
-	spin_unlock_irqrestore(&pwm->lock, flags);
-
-	return t;
-}
-EXPORT_SYMBOL(__pwm_channel_onoff);
-
-/**
- * pwm_clk_alloc - allocate and configure CLKA or CLKB
- * @prescale: from 0..10, the power of two used to divide MCK
- * @div: from 1..255, the linear divisor to use
- *
- * Returns PWM_CPR_CLKA, PWM_CPR_CLKB, or negative errno.  The allocated
- * clock will run with a period of (2^prescale * div) / MCK, or twice as
- * long if center aligned PWM output is used.  The clock must later be
- * deconfigured using pwm_clk_free().
- */
-int pwm_clk_alloc(unsigned prescale, unsigned div)
-{
-	unsigned long	flags;
-	u32		mr;
-	u32		val = (prescale << 8) | div;
-	int		ret = -EBUSY;
-
-	if (prescale >= 10 || div == 0 || div > 255)
-		return -EINVAL;
-
-	spin_lock_irqsave(&pwm->lock, flags);
-	mr = pwm_readl(pwm, PWM_MR);
-	if ((mr & 0xffff) == 0) {
-		mr |= val;
-		ret = PWM_CPR_CLKA;
-	} else if ((mr & (0xffff << 16)) == 0) {
-		mr |= val << 16;
-		ret = PWM_CPR_CLKB;
-	}
-	if (ret > 0)
-		pwm_writel(pwm, PWM_MR, mr);
-	spin_unlock_irqrestore(&pwm->lock, flags);
-	return ret;
-}
-EXPORT_SYMBOL(pwm_clk_alloc);
-
-/**
- * pwm_clk_free - deconfigure and release CLKA or CLKB
- *
- * Reverses the effect of pwm_clk_alloc().
- */
-void pwm_clk_free(unsigned clk)
-{
-	unsigned long	flags;
-	u32		mr;
-
-	spin_lock_irqsave(&pwm->lock, flags);
-	mr = pwm_readl(pwm, PWM_MR);
-	if (clk == PWM_CPR_CLKA)
-		pwm_writel(pwm, PWM_MR, mr & ~(0xffff << 0));
-	if (clk == PWM_CPR_CLKB)
-		pwm_writel(pwm, PWM_MR, mr & ~(0xffff << 16));
-	spin_unlock_irqrestore(&pwm->lock, flags);
-}
-EXPORT_SYMBOL(pwm_clk_free);
-
-/**
- * pwm_channel_handler - manage channel's IRQ handler
- * @ch: the channel
- * @handler: the handler to use, possibly NULL
- *
- * If the handler is non-null, the handler will be called after every
- * period of this PWM channel.  If the handler is null, this channel
- * won't generate an IRQ.
- */
-int pwm_channel_handler(struct pwm_channel *ch,
-		void (*handler)(struct pwm_channel *ch))
-{
-	unsigned long	flags;
-	int		t;
-
-	spin_lock_irqsave(&pwm->lock, flags);
-	t = pwmcheck(ch);
-	if (t >= 0) {
-		pwm->handler[t] = handler;
-		pwm_writel(pwm, handler ? PWM_IER : PWM_IDR, 1 << t);
-		t = 0;
-	}
-	spin_unlock_irqrestore(&pwm->lock, flags);
-
-	return t;
-}
-EXPORT_SYMBOL(pwm_channel_handler);
-
-static irqreturn_t pwm_irq(int id, void *_pwm)
-{
-	struct pwm	*p = _pwm;
-	irqreturn_t	handled = IRQ_NONE;
-	u32		irqstat;
-	int		index;
-
-	spin_lock(&p->lock);
-
-	/* ack irqs, then handle them */
-	irqstat = pwm_readl(pwm, PWM_ISR);
-
-	while (irqstat) {
-		struct pwm_channel *ch;
-		void (*handler)(struct pwm_channel *ch);
-
-		index = ffs(irqstat) - 1;
-		irqstat &= ~(1 << index);
-		ch = pwm->channel[index];
-		handler = pwm->handler[index];
-		if (handler && ch) {
-			spin_unlock(&p->lock);
-			handler(ch);
-			spin_lock(&p->lock);
-			handled = IRQ_HANDLED;
-		}
-	}
-
-	spin_unlock(&p->lock);
-	return handled;
-}
-
-static int __init pwm_probe(struct platform_device *pdev)
-{
-	struct resource *r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	int irq = platform_get_irq(pdev, 0);
-	u32 *mp = pdev->dev.platform_data;
-	struct pwm *p;
-	int status = -EIO;
-
-	if (pwm)
-		return -EBUSY;
-	if (!r || irq < 0 || !mp || !*mp)
-		return -ENODEV;
-	if (*mp & ~((1<<PWM_NCHAN)-1)) {
-		dev_warn(&pdev->dev, "mask 0x%x ... more than %d channels\n",
-			*mp, PWM_NCHAN);
-		return -EINVAL;
-	}
-
-	p = kzalloc(sizeof(*p), GFP_KERNEL);
-	if (!p)
-		return -ENOMEM;
-
-	spin_lock_init(&p->lock);
-	p->pdev = pdev;
-	p->mask = *mp;
-	p->irq = irq;
-	p->base = ioremap(r->start, r->end - r->start + 1);
-	if (!p->base)
-		goto fail;
-	p->clk = clk_get(&pdev->dev, "pwm_clk");
-	if (IS_ERR(p->clk)) {
-		status = PTR_ERR(p->clk);
-		p->clk = NULL;
-		goto fail;
-	}
-
-	status = request_irq(irq, pwm_irq, 0, pdev->name, p);
-	if (status < 0)
-		goto fail;
-
-	pwm = p;
-	platform_set_drvdata(pdev, p);
-
-	return 0;
-
-fail:
-	if (p->clk)
-		clk_put(p->clk);
-	if (p->base)
-		iounmap(p->base);
-
-	kfree(p);
-	return status;
-}
-
-static int __exit pwm_remove(struct platform_device *pdev)
-{
-	struct pwm *p = platform_get_drvdata(pdev);
-
-	if (p != pwm)
-		return -EINVAL;
-
-	clk_enable(pwm->clk);
-	pwm_writel(pwm, PWM_DIS, (1 << PWM_NCHAN) - 1);
-	pwm_writel(pwm, PWM_IDR, (1 << PWM_NCHAN) - 1);
-	clk_disable(pwm->clk);
-
-	pwm = NULL;
-
-	free_irq(p->irq, p);
-	clk_put(p->clk);
-	iounmap(p->base);
-	kfree(p);
-
-	return 0;
-}
-
-static struct platform_driver atmel_pwm_driver = {
-	.driver = {
-		.name = "atmel_pwm",
-		.owner = THIS_MODULE,
-	},
-	.remove = __exit_p(pwm_remove),
-
-	/* NOTE: PWM can keep running in AVR32 "idle" and "frozen" states;
-	 * and all AT91sam9263 states, albeit at reduced clock rate if
-	 * MCK becomes the slow clock (i.e. what Linux labels STR).
-	 */
-};
-
-static int __init pwm_init(void)
-{
-	return platform_driver_probe(&atmel_pwm_driver, pwm_probe);
-}
-module_init(pwm_init);
-
-static void __exit pwm_exit(void)
-{
-	platform_driver_unregister(&atmel_pwm_driver);
-}
-module_exit(pwm_exit);
-
-MODULE_DESCRIPTION("Driver for AT32/AT91 PWM module");
-MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:atmel_pwm");
diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
new file mode 100644
index 0000000..933bb2c
--- /dev/null
+++ b/drivers/pwm/Kconfig
@@ -0,0 +1,24 @@
+#
+# PWM infrastructure and devices
+#
+
+menuconfig GENERIC_PWM
+	tristate "PWM Support"
+	help
+	  This enables PWM support through the generic PWM library.
+	  If unsure, say N.
+
+if GENERIC_PWM
+
+config ATMEL_PWM
+	tristate "Atmel AT32/AT91 PWM support"
+	depends on AVR32 || ARCH_AT91
+	help
+	  This option enables device driver support for the PWMC
+	  peripheral channels found on certain Atmel processors.
+	  Pulse Width Modulation is used many for purposes, including
+	  software controlled power-efficent backlights on LCD
+	  displays, motor control, and waveform generation.  If
+	  unsure, say N.
+
+endif
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
new file mode 100644
index 0000000..21634f6
--- /dev/null
+++ b/drivers/pwm/Makefile
@@ -0,0 +1,6 @@
+#
+# Makefile for pwm devices
+#
+obj-y := pwm.o
+
+obj-$(CONFIG_ATMEL_PWM)		+= atmel-pwm.o
-- 
1.5.6.5
