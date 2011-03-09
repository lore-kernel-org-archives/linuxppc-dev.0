Return-Path: <buytenh@wantstofly.org>
Received: from mail.wantstofly.org (fw.wantstofly.org [80.101.37.227])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 12D991007FF
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  9 Mar 2011 19:27:02 +1100 (EST)
Date: Wed, 9 Mar 2011 09:26:58 +0100
From: Lennert Buytenhek <buytenh@wantstofly.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH v2 21/28] powerpc: sysdev/mpc8xxx_gpio irq_data conversion.
Message-ID: <20110309082658.GR16649@mail.wantstofly.org>
References: <cover.1299541392.git.buytenh@wantstofly.org>
	<20110308000004.GZ16649@mail.wantstofly.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110308000004.GZ16649@mail.wantstofly.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Lennert Buytenhek <buytenh@secretlab.ca>
---
v2: get_irq_chip_data(d->irq) => irq_data_get_irq_chip_data(d)

 arch/powerpc/sysdev/mpc8xxx_gpio.c |   42 ++++++++++++++++++------------------
 1 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/arch/powerpc/sysdev/mpc8xxx_gpio.c b/arch/powerpc/sysdev/mpc8xxx_gpio.c
index c48cd81..11fb518 100644
--- a/arch/powerpc/sysdev/mpc8xxx_gpio.c
+++ b/arch/powerpc/sysdev/mpc8xxx_gpio.c
@@ -155,43 +155,43 @@ static void mpc8xxx_gpio_irq_cascade(unsigned int irq, struct irq_desc *desc)
 						     32 - ffs(mask)));
 }
 
-static void mpc8xxx_irq_unmask(unsigned int virq)
+static void mpc8xxx_irq_unmask(struct irq_data *d)
 {
-	struct mpc8xxx_gpio_chip *mpc8xxx_gc = get_irq_chip_data(virq);
+	struct mpc8xxx_gpio_chip *mpc8xxx_gc = irq_data_get_irq_chip_data(d);
 	struct of_mm_gpio_chip *mm = &mpc8xxx_gc->mm_gc;
 	unsigned long flags;
 
 	spin_lock_irqsave(&mpc8xxx_gc->lock, flags);
 
-	setbits32(mm->regs + GPIO_IMR, mpc8xxx_gpio2mask(virq_to_hw(virq)));
+	setbits32(mm->regs + GPIO_IMR, mpc8xxx_gpio2mask(virq_to_hw(d->irq)));
 
 	spin_unlock_irqrestore(&mpc8xxx_gc->lock, flags);
 }
 
-static void mpc8xxx_irq_mask(unsigned int virq)
+static void mpc8xxx_irq_mask(struct irq_data *d)
 {
-	struct mpc8xxx_gpio_chip *mpc8xxx_gc = get_irq_chip_data(virq);
+	struct mpc8xxx_gpio_chip *mpc8xxx_gc = irq_data_get_irq_chip_data(d);
 	struct of_mm_gpio_chip *mm = &mpc8xxx_gc->mm_gc;
 	unsigned long flags;
 
 	spin_lock_irqsave(&mpc8xxx_gc->lock, flags);
 
-	clrbits32(mm->regs + GPIO_IMR, mpc8xxx_gpio2mask(virq_to_hw(virq)));
+	clrbits32(mm->regs + GPIO_IMR, mpc8xxx_gpio2mask(virq_to_hw(d->irq)));
 
 	spin_unlock_irqrestore(&mpc8xxx_gc->lock, flags);
 }
 
-static void mpc8xxx_irq_ack(unsigned int virq)
+static void mpc8xxx_irq_ack(struct irq_data *d)
 {
-	struct mpc8xxx_gpio_chip *mpc8xxx_gc = get_irq_chip_data(virq);
+	struct mpc8xxx_gpio_chip *mpc8xxx_gc = irq_data_get_irq_chip_data(d);
 	struct of_mm_gpio_chip *mm = &mpc8xxx_gc->mm_gc;
 
-	out_be32(mm->regs + GPIO_IER, mpc8xxx_gpio2mask(virq_to_hw(virq)));
+	out_be32(mm->regs + GPIO_IER, mpc8xxx_gpio2mask(virq_to_hw(d->irq)));
 }
 
-static int mpc8xxx_irq_set_type(unsigned int virq, unsigned int flow_type)
+static int mpc8xxx_irq_set_type(struct irq_data *d, unsigned int flow_type)
 {
-	struct mpc8xxx_gpio_chip *mpc8xxx_gc = get_irq_chip_data(virq);
+	struct mpc8xxx_gpio_chip *mpc8xxx_gc = irq_data_get_irq_chip_data(d);
 	struct of_mm_gpio_chip *mm = &mpc8xxx_gc->mm_gc;
 	unsigned long flags;
 
@@ -199,14 +199,14 @@ static int mpc8xxx_irq_set_type(unsigned int virq, unsigned int flow_type)
 	case IRQ_TYPE_EDGE_FALLING:
 		spin_lock_irqsave(&mpc8xxx_gc->lock, flags);
 		setbits32(mm->regs + GPIO_ICR,
-			  mpc8xxx_gpio2mask(virq_to_hw(virq)));
+			  mpc8xxx_gpio2mask(virq_to_hw(d->irq)));
 		spin_unlock_irqrestore(&mpc8xxx_gc->lock, flags);
 		break;
 
 	case IRQ_TYPE_EDGE_BOTH:
 		spin_lock_irqsave(&mpc8xxx_gc->lock, flags);
 		clrbits32(mm->regs + GPIO_ICR,
-			  mpc8xxx_gpio2mask(virq_to_hw(virq)));
+			  mpc8xxx_gpio2mask(virq_to_hw(d->irq)));
 		spin_unlock_irqrestore(&mpc8xxx_gc->lock, flags);
 		break;
 
@@ -217,11 +217,11 @@ static int mpc8xxx_irq_set_type(unsigned int virq, unsigned int flow_type)
 	return 0;
 }
 
-static int mpc512x_irq_set_type(unsigned int virq, unsigned int flow_type)
+static int mpc512x_irq_set_type(struct irq_data *d, unsigned int flow_type)
 {
-	struct mpc8xxx_gpio_chip *mpc8xxx_gc = get_irq_chip_data(virq);
+	struct mpc8xxx_gpio_chip *mpc8xxx_gc = irq_data_get_irq_chip_data(d);
 	struct of_mm_gpio_chip *mm = &mpc8xxx_gc->mm_gc;
-	unsigned long gpio = virq_to_hw(virq);
+	unsigned long gpio = virq_to_hw(d->irq);
 	void __iomem *reg;
 	unsigned int shift;
 	unsigned long flags;
@@ -264,10 +264,10 @@ static int mpc512x_irq_set_type(unsigned int virq, unsigned int flow_type)
 
 static struct irq_chip mpc8xxx_irq_chip = {
 	.name		= "mpc8xxx-gpio",
-	.unmask		= mpc8xxx_irq_unmask,
-	.mask		= mpc8xxx_irq_mask,
-	.ack		= mpc8xxx_irq_ack,
-	.set_type	= mpc8xxx_irq_set_type,
+	.irq_unmask	= mpc8xxx_irq_unmask,
+	.irq_mask	= mpc8xxx_irq_mask,
+	.irq_ack	= mpc8xxx_irq_ack,
+	.irq_set_type	= mpc8xxx_irq_set_type,
 };
 
 static int mpc8xxx_gpio_irq_map(struct irq_host *h, unsigned int virq,
@@ -276,7 +276,7 @@ static int mpc8xxx_gpio_irq_map(struct irq_host *h, unsigned int virq,
 	struct mpc8xxx_gpio_chip *mpc8xxx_gc = h->host_data;
 
 	if (mpc8xxx_gc->of_dev_id_data)
-		mpc8xxx_irq_chip.set_type = mpc8xxx_gc->of_dev_id_data;
+		mpc8xxx_irq_chip.irq_set_type = mpc8xxx_gc->of_dev_id_data;
 
 	set_irq_chip_data(virq, h->host_data);
 	set_irq_chip_and_handler(virq, &mpc8xxx_irq_chip, handle_level_irq);
-- 
1.7.4
