Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f175.google.com (mail-gx0-f175.google.com
	[209.85.217.175]) by ozlabs.org (Postfix) with ESMTP id BDC13DDF31
	for <linuxppc-dev@ozlabs.org>; Sat,  7 Mar 2009 08:12:36 +1100 (EST)
Received: by gxk23 with SMTP id 23so644598gxk.9
	for <linuxppc-dev@ozlabs.org>; Fri, 06 Mar 2009 13:12:35 -0800 (PST)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [RFC 1/2] powerpc/5200: add general purpose timer API for the MPC5200
To: linuxppc-dev@ozlabs.org
Date: Fri, 06 Mar 2009 14:12:32 -0700
Message-ID: <20090306211123.24316.80764.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

This patch adds an interface for controlling the timer function of the
MPC5200 GPT devices.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

This probably isn't complete, but I wanted to get it out there and reviewed
before I commit to the design.  Comments appreciated.

g.

 arch/powerpc/include/asm/mpc52xx.h        |    7 ++
 arch/powerpc/platforms/52xx/mpc52xx_gpt.c |  132 +++++++++++++++++++++++++++--
 2 files changed, 129 insertions(+), 10 deletions(-)


diff --git a/arch/powerpc/include/asm/mpc52xx.h b/arch/powerpc/include/asm/mpc52xx.h
index 81a2393..8273357 100644
--- a/arch/powerpc/include/asm/mpc52xx.h
+++ b/arch/powerpc/include/asm/mpc52xx.h
@@ -275,6 +275,13 @@ extern void mpc52xx_map_common_devices(void);
 extern int mpc52xx_set_psc_clkdiv(int psc_id, int clkdiv);
 extern void mpc52xx_restart(char *cmd);
 
+/* mpc52xx_gpt.c */
+struct mpc52xx_gpt_priv;
+extern struct mpc52xx_gpt_priv *mpc52xx_gpt_from_irq(int irq);
+extern int mpc52xx_gpt_start_timer(struct mpc52xx_gpt_priv *gpt, int period,
+                            int continuous);
+extern void mpc52xx_gpt_stop_timer(struct mpc52xx_gpt_priv *gpt);
+
 /* mpc52xx_pic.c */
 extern void mpc52xx_init_irq(void);
 extern unsigned int mpc52xx_get_irq(void);
diff --git a/arch/powerpc/platforms/52xx/mpc52xx_gpt.c b/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
index bfbcd41..e9e040f 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
@@ -46,9 +46,12 @@
  * the output mode.  This driver does not change the output mode setting.
  */
 
+#include <linux/device.h>
 #include <linux/irq.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
+#include <linux/list.h>
+#include <linux/mutex.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/of_gpio.h>
@@ -68,16 +71,21 @@ MODULE_LICENSE("GPL");
  * @irqhost: Pointer to irq_host instance; used when IRQ mode is supported
  */
 struct mpc52xx_gpt_priv {
+	struct list_head list;		/* List of all GPT devices */
 	struct device *dev;
 	struct mpc52xx_gpt __iomem *regs;
 	spinlock_t lock;
 	struct irq_host *irqhost;
+	u32 ipb_freq;
 
 #if defined(CONFIG_GPIOLIB)
 	struct of_gpio_chip of_gc;
 #endif
 };
 
+LIST_HEAD(mpc52xx_gpt_list);
+DEFINE_MUTEX(mpc52xx_gpt_list_mutex);
+
 #define MPC52xx_GPT_MODE_MS_MASK	(0x07)
 #define MPC52xx_GPT_MODE_MS_IC		(0x01)
 #define MPC52xx_GPT_MODE_MS_OC		(0x02)
@@ -88,6 +96,9 @@ struct mpc52xx_gpt_priv {
 #define MPC52xx_GPT_MODE_GPIO_OUT_LOW	(0x20)
 #define MPC52xx_GPT_MODE_GPIO_OUT_HIGH	(0x30)
 
+#define MPC52xx_GPT_MODE_COUNTER_ENABLE	(0x1000)
+#define MPC52xx_GPT_MODE_CONTINUOUS	(0x0400)
+#define MPC52xx_GPT_MODE_OPEN_DRAIN	(0x0200)
 #define MPC52xx_GPT_MODE_IRQ_EN		(0x0100)
 
 #define MPC52xx_GPT_MODE_ICT_MASK	(0x030000)
@@ -190,7 +201,7 @@ static int mpc52xx_gpt_irq_xlate(struct irq_host *h, struct device_node *ct,
 
 	dev_dbg(gpt->dev, "%s: flags=%i\n", __func__, intspec[0]);
 
-	if ((intsize < 1) || (intspec[0] < 1) || (intspec[0] > 3)) {
+	if ((intsize < 1) || (intspec[0] > 3)) {
 		dev_err(gpt->dev, "bad irq specifier in %s\n", ct->full_name);
 		return -EINVAL;
 	}
@@ -211,13 +222,11 @@ mpc52xx_gpt_irq_setup(struct mpc52xx_gpt_priv *gpt, struct device_node *node)
 {
 	int cascade_virq;
 	unsigned long flags;
-
-	/* Only setup cascaded IRQ if device tree claims the GPT is
-	 * an interrupt controller */
-	if (!of_find_property(node, "interrupt-controller", NULL))
-		return;
+	u32 mode;
 
 	cascade_virq = irq_of_parse_and_map(node, 0);
+	if (!cascade_virq)
+		return;
 
 	gpt->irqhost = irq_alloc_host(node, IRQ_HOST_MAP_LINEAR, 1,
 				      &mpc52xx_gpt_irq_ops, -1);
@@ -227,14 +236,16 @@ mpc52xx_gpt_irq_setup(struct mpc52xx_gpt_priv *gpt, struct device_node *node)
 	}
 
 	gpt->irqhost->host_data = gpt;
-
 	set_irq_data(cascade_virq, gpt);
 	set_irq_chained_handler(cascade_virq, mpc52xx_gpt_irq_cascade);
 
-	/* Set to Input Capture mode */
+	/* If the GPT is currently disabled, then change it to be in Input
+	 * Capture mode.  If the mode is non-zero, then the pin could be
+	 * already in use for something. */
 	spin_lock_irqsave(&gpt->lock, flags);
-	clrsetbits_be32(&gpt->regs->mode, MPC52xx_GPT_MODE_MS_MASK,
-			MPC52xx_GPT_MODE_MS_IC);
+	mode = in_be32(&gpt->regs->mode);
+	if ((mode & MPC52xx_GPT_MODE_MS_MASK) == 0)
+		out_be32(&gpt->regs->mode, mode | MPC52xx_GPT_MODE_MS_IC);
 	spin_unlock_irqrestore(&gpt->lock, flags);
 
 	dev_dbg(gpt->dev, "%s() complete. virq=%i\n", __func__, cascade_virq);
@@ -335,6 +346,102 @@ static void
 mpc52xx_gpt_gpio_setup(struct mpc52xx_gpt_priv *p, struct device_node *np) { }
 #endif /* defined(CONFIG_GPIOLIB) */
 
+/***********************************************************************
+ * Timer API
+ */
+
+/**
+ * mpc52xx_gpt_from_irq - Return the GPT device associated with an IRQ number
+ * @irq: irq of timer.
+ */
+struct mpc52xx_gpt_priv *mpc52xx_gpt_from_irq(int irq)
+{
+	struct mpc52xx_gpt_priv *gpt;
+	struct list_head *pos;
+
+	/* Iterate over the list of timers looking for a matching device */
+	mutex_lock(&mpc52xx_gpt_list_mutex);
+	list_for_each(pos, &mpc52xx_gpt_list) {
+		gpt = container_of(pos, struct mpc52xx_gpt_priv, list);
+		if (gpt->irqhost && irq == irq_linear_revmap(gpt->irqhost, 0)) {
+			mutex_unlock(&mpc52xx_gpt_list_mutex);
+			return gpt;
+		}
+	}
+	mutex_unlock(&mpc52xx_gpt_list_mutex);
+
+	return NULL;
+}
+EXPORT_SYMBOL(mpc52xx_gpt_from_irq);
+
+/**
+ * mpc52xx_gpt_start_timer - Set and enable the GPT timer
+ * @gpt: Pointer to gpt private data structure
+ * @period: period of timer
+ * @continuous: set to 1 to make timer continuous free running
+ *
+ * An interrupt will be generated every time the timer fires
+ */
+int mpc52xx_gpt_start_timer(struct mpc52xx_gpt_priv *gpt, int period,
+                            int continuous)
+{
+	u32 clear, set;
+	//u64 clocks;
+	u32 clocks;
+	u32 count, prescale;
+	unsigned long flags;
+
+	clear = MPC52xx_GPT_MODE_MS_MASK | MPC52xx_GPT_MODE_CONTINUOUS;
+	set = MPC52xx_GPT_MODE_MS_GPIO | MPC52xx_GPT_MODE_COUNTER_ENABLE;
+	if (continuous)
+		set |= MPC52xx_GPT_MODE_CONTINUOUS;
+
+	/* Determine the number of clocks in the requested period.  64 bit
+	 * arithmatic is done here to preserve the precision until the value
+	 * is scaled back down into the u32 range.  Period is in 'ns', bus
+	 * frequency is in Hz. */
+	//clocks = (u64)period * (u64)gpt->ipb_freq;
+	//clocks = clocks / 1000000000; /* Scale it down to ns range */
+	clocks = (period / 1000) * (gpt->ipb_freq / 1000000);
+
+	/* This device cannot handle a clock count greater than 32 bits */
+	if (clocks > 0xffffffff)
+		return -EINVAL;
+
+	/* Calculate the prescaler and count values from the clocks value.
+	 * 'clocks' is the number of clock ticks in the period.  The timer
+	 * has 16 bit precision and a 16 bit prescaler.  Prescaler is
+	 * calculated by integer dividing the clocks by 0x10000 (shifting
+	 * down 16 bits) to obtain the smallest possible divisor for clocks
+	 * to get a 16 bit count value.
+	 *
+	 * Note: the prescale register is '1' based, not '0' based.  ie. a
+	 * value of '1' means divide the clock by one.  0xffff divides the
+	 * clock by 0xffff.  '0x0000' does not divide by zero, but wraps
+	 * around and divides by 0x10000.  That is why prescale must be
+	 * a u32 variable, not a u16, for this calculation. */
+	prescale = (clocks >> 16) + 1;
+	count = clocks / prescale;
+	if (count > 0xffff)
+		pr_err("calculation error; count:%x prescale:%x clocks:%x\n",
+		       count, prescale, clocks);
+
+	/* Set and enable the timer */
+	spin_lock_irqsave(&gpt->lock, flags);
+	out_be32(&gpt->regs->count, prescale << 16 | count);
+	clrsetbits_be32(&gpt->regs->mode, clear, set);
+	spin_unlock_irqrestore(&gpt->lock, flags);
+
+	return 0;
+}
+EXPORT_SYMBOL(mpc52xx_gpt_start_timer);
+
+void mpc52xx_gpt_stop_timer(struct mpc52xx_gpt_priv *gpt)
+{
+	clrbits32(&gpt->regs->mode, MPC52xx_GPT_MODE_COUNTER_ENABLE);
+}
+EXPORT_SYMBOL(mpc52xx_gpt_stop_timer);
+
 /* ---------------------------------------------------------------------
  * of_platform bus binding code
  */
@@ -349,6 +456,7 @@ static int __devinit mpc52xx_gpt_probe(struct of_device *ofdev,
 
 	spin_lock_init(&gpt->lock);
 	gpt->dev = &ofdev->dev;
+	gpt->ipb_freq = mpc52xx_find_ipb_freq(ofdev->node);
 	gpt->regs = of_iomap(ofdev->node, 0);
 	if (!gpt->regs) {
 		kfree(gpt);
@@ -360,6 +468,10 @@ static int __devinit mpc52xx_gpt_probe(struct of_device *ofdev,
 	mpc52xx_gpt_gpio_setup(gpt, ofdev->node);
 	mpc52xx_gpt_irq_setup(gpt, ofdev->node);
 
+	mutex_lock(&mpc52xx_gpt_list_mutex);
+	list_add(&gpt->list, &mpc52xx_gpt_list);
+	mutex_unlock(&mpc52xx_gpt_list_mutex);
+
 	return 0;
 }
 
