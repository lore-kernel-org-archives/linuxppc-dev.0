Return-Path: <julia.cartwright@ni.com>
Received: from mx0b-00010702.pphosted.com (mx0a-00010702.pphosted.com
 [148.163.156.75])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vnnsj1C5kzDq7Z
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Mar 2017 09:43:36 +1100 (AEDT)
From: Julia Cartwright <julia@ni.com>
To: Anatolij Gustschin <agust@denx.de>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael
 Ellerman <mpe@ellerman.id.au>
CC: <linux-kernel@vger.kernel.org>, <linux-rt-users@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH v2 3/9] powerpc: mpc52xx_gpt: make use of raw_spinlock variants
Date: Tue, 21 Mar 2017 17:43:03 -0500
Message-ID: <2142489eb41f758b5d04919a8efbb16794f16b0f.1490135047.git.julia@ni.com>
In-Reply-To: <cover.1490135047.git.julia@ni.com>
References: <cover.1490135047.git.julia@ni.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The mpc52xx_gpt code currently implements an irq_chip for handling
interrupts; due to how irq_chip handling is done, it's necessary for the
irq_chip methods to be invoked from hardirq context, even on a a
real-time kernel.  Because the spinlock_t type becomes a "sleeping"
spinlock w/ RT kernels, it is not suitable to be used with irq_chips.

A quick audit of the operations under the lock reveal that they do only
minimal, bounded work, and are therefore safe to do under a raw spinlock.

Signed-off-by: Julia Cartwright <julia@ni.com>
---
v1 -> v2:
  - No change.

 arch/powerpc/platforms/52xx/mpc52xx_gpt.c | 52 +++++++++++++++----------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/arch/powerpc/platforms/52xx/mpc52xx_gpt.c b/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
index 22645a7c6b8a..18c1383717f2 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
@@ -90,7 +90,7 @@ struct mpc52xx_gpt_priv {
 	struct list_head list;		/* List of all GPT devices */
 	struct device *dev;
 	struct mpc52xx_gpt __iomem *regs;
-	spinlock_t lock;
+	raw_spinlock_t lock;
 	struct irq_domain *irqhost;
 	u32 ipb_freq;
 	u8 wdt_mode;
@@ -141,9 +141,9 @@ static void mpc52xx_gpt_irq_unmask(struct irq_data *d)
 	struct mpc52xx_gpt_priv *gpt = irq_data_get_irq_chip_data(d);
 	unsigned long flags;
 
-	spin_lock_irqsave(&gpt->lock, flags);
+	raw_spin_lock_irqsave(&gpt->lock, flags);
 	setbits32(&gpt->regs->mode, MPC52xx_GPT_MODE_IRQ_EN);
-	spin_unlock_irqrestore(&gpt->lock, flags);
+	raw_spin_unlock_irqrestore(&gpt->lock, flags);
 }
 
 static void mpc52xx_gpt_irq_mask(struct irq_data *d)
@@ -151,9 +151,9 @@ static void mpc52xx_gpt_irq_mask(struct irq_data *d)
 	struct mpc52xx_gpt_priv *gpt = irq_data_get_irq_chip_data(d);
 	unsigned long flags;
 
-	spin_lock_irqsave(&gpt->lock, flags);
+	raw_spin_lock_irqsave(&gpt->lock, flags);
 	clrbits32(&gpt->regs->mode, MPC52xx_GPT_MODE_IRQ_EN);
-	spin_unlock_irqrestore(&gpt->lock, flags);
+	raw_spin_unlock_irqrestore(&gpt->lock, flags);
 }
 
 static void mpc52xx_gpt_irq_ack(struct irq_data *d)
@@ -171,14 +171,14 @@ static int mpc52xx_gpt_irq_set_type(struct irq_data *d, unsigned int flow_type)
 
 	dev_dbg(gpt->dev, "%s: virq=%i type=%x\n", __func__, d->irq, flow_type);
 
-	spin_lock_irqsave(&gpt->lock, flags);
+	raw_spin_lock_irqsave(&gpt->lock, flags);
 	reg = in_be32(&gpt->regs->mode) & ~MPC52xx_GPT_MODE_ICT_MASK;
 	if (flow_type & IRQF_TRIGGER_RISING)
 		reg |= MPC52xx_GPT_MODE_ICT_RISING;
 	if (flow_type & IRQF_TRIGGER_FALLING)
 		reg |= MPC52xx_GPT_MODE_ICT_FALLING;
 	out_be32(&gpt->regs->mode, reg);
-	spin_unlock_irqrestore(&gpt->lock, flags);
+	raw_spin_unlock_irqrestore(&gpt->lock, flags);
 
 	return 0;
 }
@@ -264,11 +264,11 @@ mpc52xx_gpt_irq_setup(struct mpc52xx_gpt_priv *gpt, struct device_node *node)
 	/* If the GPT is currently disabled, then change it to be in Input
 	 * Capture mode.  If the mode is non-zero, then the pin could be
 	 * already in use for something. */
-	spin_lock_irqsave(&gpt->lock, flags);
+	raw_spin_lock_irqsave(&gpt->lock, flags);
 	mode = in_be32(&gpt->regs->mode);
 	if ((mode & MPC52xx_GPT_MODE_MS_MASK) == 0)
 		out_be32(&gpt->regs->mode, mode | MPC52xx_GPT_MODE_MS_IC);
-	spin_unlock_irqrestore(&gpt->lock, flags);
+	raw_spin_unlock_irqrestore(&gpt->lock, flags);
 
 	dev_dbg(gpt->dev, "%s() complete. virq=%i\n", __func__, cascade_virq);
 }
@@ -295,9 +295,9 @@ mpc52xx_gpt_gpio_set(struct gpio_chip *gc, unsigned int gpio, int v)
 	dev_dbg(gpt->dev, "%s: gpio:%d v:%d\n", __func__, gpio, v);
 	r = v ? MPC52xx_GPT_MODE_GPIO_OUT_HIGH : MPC52xx_GPT_MODE_GPIO_OUT_LOW;
 
-	spin_lock_irqsave(&gpt->lock, flags);
+	raw_spin_lock_irqsave(&gpt->lock, flags);
 	clrsetbits_be32(&gpt->regs->mode, MPC52xx_GPT_MODE_GPIO_MASK, r);
-	spin_unlock_irqrestore(&gpt->lock, flags);
+	raw_spin_unlock_irqrestore(&gpt->lock, flags);
 }
 
 static int mpc52xx_gpt_gpio_dir_in(struct gpio_chip *gc, unsigned int gpio)
@@ -307,9 +307,9 @@ static int mpc52xx_gpt_gpio_dir_in(struct gpio_chip *gc, unsigned int gpio)
 
 	dev_dbg(gpt->dev, "%s: gpio:%d\n", __func__, gpio);
 
-	spin_lock_irqsave(&gpt->lock, flags);
+	raw_spin_lock_irqsave(&gpt->lock, flags);
 	clrbits32(&gpt->regs->mode, MPC52xx_GPT_MODE_GPIO_MASK);
-	spin_unlock_irqrestore(&gpt->lock, flags);
+	raw_spin_unlock_irqrestore(&gpt->lock, flags);
 
 	return 0;
 }
@@ -436,16 +436,16 @@ static int mpc52xx_gpt_do_start(struct mpc52xx_gpt_priv *gpt, u64 period,
 	}
 
 	/* Set and enable the timer, reject an attempt to use a wdt as gpt */
-	spin_lock_irqsave(&gpt->lock, flags);
+	raw_spin_lock_irqsave(&gpt->lock, flags);
 	if (as_wdt)
 		gpt->wdt_mode |= MPC52xx_GPT_IS_WDT;
 	else if ((gpt->wdt_mode & MPC52xx_GPT_IS_WDT) != 0) {
-		spin_unlock_irqrestore(&gpt->lock, flags);
+		raw_spin_unlock_irqrestore(&gpt->lock, flags);
 		return -EBUSY;
 	}
 	out_be32(&gpt->regs->count, prescale << 16 | clocks);
 	clrsetbits_be32(&gpt->regs->mode, clear, set);
-	spin_unlock_irqrestore(&gpt->lock, flags);
+	raw_spin_unlock_irqrestore(&gpt->lock, flags);
 
 	return 0;
 }
@@ -476,14 +476,14 @@ int mpc52xx_gpt_stop_timer(struct mpc52xx_gpt_priv *gpt)
 	unsigned long flags;
 
 	/* reject the operation if the timer is used as watchdog (gpt 0 only) */
-	spin_lock_irqsave(&gpt->lock, flags);
+	raw_spin_lock_irqsave(&gpt->lock, flags);
 	if ((gpt->wdt_mode & MPC52xx_GPT_IS_WDT) != 0) {
-		spin_unlock_irqrestore(&gpt->lock, flags);
+		raw_spin_unlock_irqrestore(&gpt->lock, flags);
 		return -EBUSY;
 	}
 
 	clrbits32(&gpt->regs->mode, MPC52xx_GPT_MODE_COUNTER_ENABLE);
-	spin_unlock_irqrestore(&gpt->lock, flags);
+	raw_spin_unlock_irqrestore(&gpt->lock, flags);
 	return 0;
 }
 EXPORT_SYMBOL(mpc52xx_gpt_stop_timer);
@@ -500,9 +500,9 @@ u64 mpc52xx_gpt_timer_period(struct mpc52xx_gpt_priv *gpt)
 	u64 prescale;
 	unsigned long flags;
 
-	spin_lock_irqsave(&gpt->lock, flags);
+	raw_spin_lock_irqsave(&gpt->lock, flags);
 	period = in_be32(&gpt->regs->count);
-	spin_unlock_irqrestore(&gpt->lock, flags);
+	raw_spin_unlock_irqrestore(&gpt->lock, flags);
 
 	prescale = period >> 16;
 	period &= 0xffff;
@@ -532,9 +532,9 @@ static inline void mpc52xx_gpt_wdt_ping(struct mpc52xx_gpt_priv *gpt_wdt)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&gpt_wdt->lock, flags);
+	raw_spin_lock_irqsave(&gpt_wdt->lock, flags);
 	out_8((u8 *) &gpt_wdt->regs->mode, MPC52xx_GPT_MODE_WDT_PING);
-	spin_unlock_irqrestore(&gpt_wdt->lock, flags);
+	raw_spin_unlock_irqrestore(&gpt_wdt->lock, flags);
 }
 
 /* wdt misc device api */
@@ -638,11 +638,11 @@ static int mpc52xx_wdt_release(struct inode *inode, struct file *file)
 	struct mpc52xx_gpt_priv *gpt_wdt = file->private_data;
 	unsigned long flags;
 
-	spin_lock_irqsave(&gpt_wdt->lock, flags);
+	raw_spin_lock_irqsave(&gpt_wdt->lock, flags);
 	clrbits32(&gpt_wdt->regs->mode,
 		  MPC52xx_GPT_MODE_COUNTER_ENABLE | MPC52xx_GPT_MODE_WDT_EN);
 	gpt_wdt->wdt_mode &= ~MPC52xx_GPT_IS_WDT;
-	spin_unlock_irqrestore(&gpt_wdt->lock, flags);
+	raw_spin_unlock_irqrestore(&gpt_wdt->lock, flags);
 #endif
 	clear_bit(0, &wdt_is_active);
 	return 0;
@@ -723,7 +723,7 @@ static int mpc52xx_gpt_probe(struct platform_device *ofdev)
 	if (!gpt)
 		return -ENOMEM;
 
-	spin_lock_init(&gpt->lock);
+	raw_spin_lock_init(&gpt->lock);
 	gpt->dev = &ofdev->dev;
 	gpt->ipb_freq = mpc5xxx_get_bus_frequency(ofdev->dev.of_node);
 	gpt->regs = of_iomap(ofdev->dev.of_node, 0);
-- 
2.12.0
