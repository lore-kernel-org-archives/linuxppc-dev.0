Return-Path: <jacmet@gmail.com>
Received: from mail-ew0-f215.google.com (mail-ew0-f215.google.com
	[209.85.219.215]) by ozlabs.org (Postfix) with ESMTP id D2B9B100855
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  2 Dec 2009 07:48:30 +1100 (EST)
Received: by ewy7 with SMTP id 7so6199131ewy.8
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 01 Dec 2009 12:48:28 -0800 (PST)
Sender: Peter Korsgaard <jacmet@gmail.com>
From: Peter Korsgaard <jacmet@sunsite.dk>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/3] mpc8xxx_gpio: add interrupt support
Date: Tue,  1 Dec 2009 21:48:14 +0100
Message-Id: <1259700494-17869-3-git-send-email-jacmet@sunsite.dk>
In-Reply-To: <1259700494-17869-2-git-send-email-jacmet@sunsite.dk>
References: <1259700494-17869-1-git-send-email-jacmet@sunsite.dk>
	<1259700494-17869-2-git-send-email-jacmet@sunsite.dk>
To: Anton Vorontsov <avorontsov@ru.mvista.com>,
	Kumar Gala <galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>
---
 arch/powerpc/sysdev/mpc8xxx_gpio.c |  147 ++++++++++++++++++++++++++++++++++++
 1 files changed, 147 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/sysdev/mpc8xxx_gpio.c b/arch/powerpc/sysdev/mpc8xxx_gpio.c
index 103eace..b46f28b 100644
--- a/arch/powerpc/sysdev/mpc8xxx_gpio.c
+++ b/arch/powerpc/sysdev/mpc8xxx_gpio.c
@@ -15,6 +15,7 @@
 #include <linux/of.h>
 #include <linux/of_gpio.h>
 #include <linux/gpio.h>
+#include <linux/irq.h>
 
 #define MPC8XXX_GPIO_PINS	32
 
@@ -34,6 +35,7 @@ struct mpc8xxx_gpio_chip {
 	 * open drain mode safely
 	 */
 	u32 data;
+	struct irq_host *irq;
 };
 
 static inline u32 mpc8xxx_gpio2mask(unsigned int gpio)
@@ -111,12 +113,136 @@ static int mpc8xxx_gpio_dir_out(struct gpio_chip *gc, unsigned int gpio, int val
 	return 0;
 }
 
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
+	struct mpc8xxx_gpio_chip *mpc8xxx_gc = get_irq_desc_data(desc);
+	struct of_mm_gpio_chip *mm = &mpc8xxx_gc->mm_gc;
+	unsigned int mask;
+
+	mask = in_be32(mm->regs + GPIO_IER) & in_be32(mm->regs + GPIO_IMR);
+	if (mask)
+		generic_handle_irq(irq_linear_revmap(mpc8xxx_gc->irq,
+						     32 - ffs(mask)));
+}
+
+static void mpc8xxx_irq_unmask(unsigned int virq)
+{
+	struct mpc8xxx_gpio_chip *mpc8xxx_gc = get_irq_chip_data(virq);
+	struct of_mm_gpio_chip *mm = &mpc8xxx_gc->mm_gc;
+	unsigned long flags;
+
+	spin_lock_irqsave(&mpc8xxx_gc->lock, flags);
+
+	setbits32(mm->regs + GPIO_IMR, mpc8xxx_gpio2mask(virq_to_hw(virq)));
+
+	spin_unlock_irqrestore(&mpc8xxx_gc->lock, flags);
+}
+
+static void mpc8xxx_irq_mask(unsigned int virq)
+{
+	struct mpc8xxx_gpio_chip *mpc8xxx_gc = get_irq_chip_data(virq);
+	struct of_mm_gpio_chip *mm = &mpc8xxx_gc->mm_gc;
+	unsigned long flags;
+
+	spin_lock_irqsave(&mpc8xxx_gc->lock, flags);
+
+	clrbits32(mm->regs + GPIO_IMR, mpc8xxx_gpio2mask(virq_to_hw(virq)));
+
+	spin_unlock_irqrestore(&mpc8xxx_gc->lock, flags);
+}
+
+static void mpc8xxx_irq_ack(unsigned int virq)
+{
+	struct mpc8xxx_gpio_chip *mpc8xxx_gc = get_irq_chip_data(virq);
+	struct of_mm_gpio_chip *mm = &mpc8xxx_gc->mm_gc;
+
+	out_be32(mm->regs + GPIO_IER, mpc8xxx_gpio2mask(virq_to_hw(virq)));
+}
+
+static int mpc8xxx_irq_set_type(unsigned int virq, unsigned int flow_type)
+{
+	struct mpc8xxx_gpio_chip *mpc8xxx_gc = get_irq_chip_data(virq);
+	struct of_mm_gpio_chip *mm = &mpc8xxx_gc->mm_gc;
+	unsigned long flags;
+
+	switch (flow_type) {
+	case IRQ_TYPE_EDGE_FALLING:
+		spin_lock_irqsave(&mpc8xxx_gc->lock, flags);
+		setbits32(mm->regs + GPIO_ICR,
+			  mpc8xxx_gpio2mask(virq_to_hw(virq)));
+		spin_unlock_irqrestore(&mpc8xxx_gc->lock, flags);
+		break;
+
+	case IRQ_TYPE_EDGE_BOTH:
+		spin_lock_irqsave(&mpc8xxx_gc->lock, flags);
+		clrbits32(mm->regs + GPIO_ICR,
+			  mpc8xxx_gpio2mask(virq_to_hw(virq)));
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
+	.unmask		= mpc8xxx_irq_unmask,
+	.mask		= mpc8xxx_irq_mask,
+	.ack		= mpc8xxx_irq_ack,
+	.set_type	= mpc8xxx_irq_set_type,
+};
+
+static int mpc8xxx_gpio_irq_map(struct irq_host *h, unsigned int virq,
+				irq_hw_number_t hw)
+{
+	set_irq_chip_data(virq, h->host_data);
+	set_irq_chip_and_handler(virq, &mpc8xxx_irq_chip, handle_level_irq);
+	set_irq_type(virq, IRQ_TYPE_NONE);
+
+	return 0;
+}
+
+static int mpc8xxx_gpio_irq_xlate(struct irq_host *h, struct device_node *ct,
+				  u32 *intspec, unsigned int intsize,
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
 static void __init mpc8xxx_add_controller(struct device_node *np)
 {
 	struct mpc8xxx_gpio_chip *mpc8xxx_gc;
 	struct of_mm_gpio_chip *mm_gc;
 	struct of_gpio_chip *of_gc;
 	struct gpio_chip *gc;
+	unsigned hwirq;
 	int ret;
 
 	mpc8xxx_gc = kzalloc(sizeof(*mpc8xxx_gc), GFP_KERNEL);
@@ -138,11 +264,32 @@ static void __init mpc8xxx_add_controller(struct device_node *np)
 	gc->direction_output = mpc8xxx_gpio_dir_out;
 	gc->get = mpc8xxx_gpio_get;
 	gc->set = mpc8xxx_gpio_set;
+	gc->to_irq = mpc8xxx_gpio_to_irq;
 
 	ret = of_mm_gpiochip_add(np, mm_gc);
 	if (ret)
 		goto err;
 
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
+	mpc8xxx_gc->irq->host_data = mpc8xxx_gc;
+
+	/* ack and mask all irqs */
+	out_be32(mm_gc->regs + GPIO_IER, 0xffffffff);
+	out_be32(mm_gc->regs + GPIO_IMR, 0);
+
+	set_irq_data(hwirq, mpc8xxx_gc);
+	set_irq_chained_handler(hwirq, mpc8xxx_gpio_irq_cascade);
+
+skip_irq:
 	return;
 
 err:
-- 
1.6.5
