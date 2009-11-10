Return-Path: <albrecht.dress@arcor.de>
Received: from smtp5.netcologne.de (smtp5.netcologne.de [194.8.194.25])
	by ozlabs.org (Postfix) with ESMTP id 50422B7C0C
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Nov 2009 09:09:50 +1100 (EST)
Date: Tue, 10 Nov 2009 20:41:58 +0100
From: Albrecht =?iso-8859-1?b?RHJl3w==?= <albrecht.dress@arcor.de>
Subject: [PATCH 2/3] mpc52xx/wdt: merge WDT code into the GPT
To: Linux PPC Development <linuxppc-dev@ozlabs.org>, Grant Likely
	<grant.likely@secretlab.ca>, devicetree-discuss@lists.ozlabs.org,
	Wim Van Sebroeck <wim@iguana.be>
Message-Id: <1257882118.14374.2@antares>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Merge the WDT code into the GPT interface.

Signed-off-by: Albrecht Dre=DF <albrecht.dress@arcor.de>
---

Notes:

The maximum timeout for a 5200 GPT @ 33 MHz clock is ~130 seconds.  As this
exceeds the range of an int, some api's had to be changed to u64.

The WDT api is exported as to keep the WDT driver separated from the GPT
driver.

If GPT0 is used as WDT, this prevents the use of any GPT0 GPT function (i.e=
.
they will fail with -EBUSY).  IOW, the safety function always has precedenc=
e
over the GPT function.  If the kernel has been compiled with
CONFIG_WATCHDOG_NOWAYOUT, this means that GPT0 is locked in WDT mode until
the next reboot - this may be a requirement in safety applications.

 arch/powerpc/include/asm/mpc52xx.h        |   18 ++-
 arch/powerpc/platforms/52xx/mpc52xx_gpt.c |  281 +++++++++++++++++++++++++=
+---
 2 files changed, 270 insertions(+), 29 deletions(-)

diff --git a/arch/powerpc/include/asm/mpc52xx.h b/arch/powerpc/include/asm/=
mpc52xx.h
index 707ab75..0ece07f 100644
--- a/arch/powerpc/include/asm/mpc52xx.h
+++ b/arch/powerpc/include/asm/mpc52xx.h
@@ -279,9 +279,21 @@ extern void mpc52xx_restart(char *cmd);
 /* mpc52xx_gpt.c */
 struct mpc52xx_gpt_priv;
 extern struct mpc52xx_gpt_priv *mpc52xx_gpt_from_irq(int irq);
-extern int mpc52xx_gpt_start_timer(struct mpc52xx_gpt_priv *gpt, int perio=
d,
-                            int continuous);
-extern void mpc52xx_gpt_stop_timer(struct mpc52xx_gpt_priv *gpt);
+extern int mpc52xx_gpt_start_timer(struct mpc52xx_gpt_priv *gpt, u64 perio=
d,
+				   int continuous);
+extern int mpc52xx_gpt_stop_timer(struct mpc52xx_gpt_priv *gpt);
+extern u64 mpc52xx_gpt_timer_period(struct mpc52xx_gpt_priv *gpt);
+#if (defined(CONFIG_MPC5200_WDT)) || (defined(CONFIG_MPC5200_WDT_MODULE))
+extern struct mpc52xx_gpt_priv *mpc52xx_gpt_wdt_probe(void);
+extern int mpc52xx_gpt_wdt_start(struct mpc52xx_gpt_priv *gpt_wdt,
+				 int wdt_timeout);
+extern int mpc52xx_gpt_wdt_ping(struct mpc52xx_gpt_priv *gpt_wdt);
+extern int mpc52xx_gpt_wdt_release(struct mpc52xx_gpt_priv *gpt_wdt);
+#if !defined(CONFIG_WATCHDOG_NOWAYOUT)
+extern int mpc52xx_gpt_wdt_stop(struct mpc52xx_gpt_priv *gpt_wdt);
+#endif  /*  CONFIG_WATCHDOG_NOWAYOUT  */
+#endif  /*  CONFIG_MPC5200_WDT  */
+
=20
 /* mpc52xx_lpbfifo.c */
 #define MPC52XX_LPBFIFO_FLAG_READ		(0)
diff --git a/arch/powerpc/platforms/52xx/mpc52xx_gpt.c b/arch/powerpc/platf=
orms/52xx/mpc52xx_gpt.c
index 2c3fa13..8274ebb 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
@@ -60,9 +60,13 @@
 #include <asm/mpc52xx.h>
=20
 MODULE_DESCRIPTION("Freescale MPC52xx gpt driver");
-MODULE_AUTHOR("Sascha Hauer, Grant Likely");
+MODULE_AUTHOR("Sascha Hauer, Grant Likely, Albrecht Dre=DF");
 MODULE_LICENSE("GPL");
=20
+#if (defined(CONFIG_MPC5200_WDT)) || (defined(CONFIG_MPC5200_WDT_MODULE))
+#define HAVE_MPC5200_WDT
+#endif
+
 /**
  * struct mpc52xx_gpt - Private data structure for MPC52xx GPT driver
  * @dev: pointer to device structure
@@ -70,6 +74,8 @@ MODULE_LICENSE("GPL");
  * @lock: spinlock to coordinate between different functions.
  * @of_gc: of_gpio_chip instance structure; used when GPIO is enabled
  * @irqhost: Pointer to irq_host instance; used when IRQ mode is supported
+ * @wdt_mode: only used for gpt 0: 0 gpt-only timer, 1 can be used as a
+ *            wdt, 2 currently used as wdt, cannot be used as gpt
  */
 struct mpc52xx_gpt_priv {
 	struct list_head list;		/* List of all GPT devices */
@@ -78,6 +84,9 @@ struct mpc52xx_gpt_priv {
 	spinlock_t lock;
 	struct irq_host *irqhost;
 	u32 ipb_freq;
+#if defined(HAVE_MPC5200_WDT)
+	u8 wdt_mode;
+#endif
=20
 #if defined(CONFIG_GPIOLIB)
 	struct of_gpio_chip of_gc;
@@ -101,14 +110,23 @@ DEFINE_MUTEX(mpc52xx_gpt_list_mutex);
 #define MPC52xx_GPT_MODE_CONTINUOUS	(0x0400)
 #define MPC52xx_GPT_MODE_OPEN_DRAIN	(0x0200)
 #define MPC52xx_GPT_MODE_IRQ_EN		(0x0100)
+#define MPC52xx_GPT_MODE_WDT_EN		(0x8000)
=20
 #define MPC52xx_GPT_MODE_ICT_MASK	(0x030000)
 #define MPC52xx_GPT_MODE_ICT_RISING	(0x010000)
 #define MPC52xx_GPT_MODE_ICT_FALLING	(0x020000)
 #define MPC52xx_GPT_MODE_ICT_TOGGLE	(0x030000)
=20
+#define MPC52xx_GPT_MODE_WDT_PING	(0xa5)
+
 #define MPC52xx_GPT_STATUS_IRQMASK	(0x000f)
=20
+#define NS_PER_SEC			1000000000LL
+
+#define MPC52xx_GPT_CAN_WDT		(1 << 0)
+#define MPC52xx_GPT_IS_WDT		(1 << 1)
+
+
 /* ---------------------------------------------------------------------
  * Cascaded interrupt controller hooks
  */
@@ -375,36 +393,22 @@ struct mpc52xx_gpt_priv *mpc52xx_gpt_from_irq(int irq=
)
 }
 EXPORT_SYMBOL(mpc52xx_gpt_from_irq);
=20
-/**
- * mpc52xx_gpt_start_timer - Set and enable the GPT timer
- * @gpt: Pointer to gpt private data structure
- * @period: period of timer
- * @continuous: set to 1 to make timer continuous free running
- *
- * An interrupt will be generated every time the timer fires
- */
-int mpc52xx_gpt_start_timer(struct mpc52xx_gpt_priv *gpt, int period,
-                            int continuous)
+/* Calculate the timer counter input register MBAR + 0x6n4 from the
+ * period in ns.  The maximum period for 33 MHz IPB clock is ~130s. */
+static int mpc52xx_gpt_calc_counter_input(u64 period, u64 ipb_freq,
+					  u32 *reg_val)
 {
-	u32 clear, set;
 	u64 clocks;
 	u32 prescale;
-	unsigned long flags;
-
-	clear =3D MPC52xx_GPT_MODE_MS_MASK | MPC52xx_GPT_MODE_CONTINUOUS;
-	set =3D MPC52xx_GPT_MODE_MS_GPIO | MPC52xx_GPT_MODE_COUNTER_ENABLE;
-	if (continuous)
-		set |=3D MPC52xx_GPT_MODE_CONTINUOUS;
=20
 	/* Determine the number of clocks in the requested period.  64 bit
 	 * arithmatic is done here to preserve the precision until the value
-	 * is scaled back down into the u32 range.  Period is in 'ns', bus
-	 * frequency is in Hz. */
-	clocks =3D (u64)period * (u64)gpt->ipb_freq;
-	do_div(clocks, 1000000000); /* Scale it down to ns range */
+	 * is scaled back down into the u32 range. */
+	clocks =3D period * ipb_freq;
+	do_div(clocks, NS_PER_SEC);         /* Scale it down to ns range */
=20
-	/* This device cannot handle a clock count greater than 32 bits */
-	if (clocks > 0xffffffff)
+	/* the maximum count is 0x10000 pre-scaler * 0xffff count */
+	if (clocks > 0xffff0000)
 		return -EINVAL;
=20
 	/* Calculate the prescaler and count values from the clocks value.
@@ -427,9 +431,47 @@ int mpc52xx_gpt_start_timer(struct mpc52xx_gpt_priv *g=
pt, int period,
 		return -EINVAL;
 	}
=20
+	*reg_val =3D (prescale & 0xffff) << 16 | clocks;
+	return 0;
+}
+
+/**
+ * mpc52xx_gpt_start_timer - Set and enable the GPT timer
+ * @gpt: Pointer to gpt private data structure
+ * @period: period of timer in ns
+ * @continuous: set to 1 to make timer continuous free running
+ *
+ * An interrupt will be generated every time the timer fires
+ */
+int mpc52xx_gpt_start_timer(struct mpc52xx_gpt_priv *gpt, u64 period,
+			    int continuous)
+{
+	u32 clear, set;
+	u32 counter_reg;
+	unsigned long flags;
+
+#if defined(HAVE_MPC5200_WDT)
+	/* reject the operation if the timer is used as watchdog (gpt 0 only) */
+	spin_lock_irqsave(&gpt->lock, flags);
+	if ((gpt->wdt_mode & MPC52xx_GPT_IS_WDT)) {
+		spin_unlock_irqrestore(&gpt->lock, flags);
+		return -EBUSY;
+	}
+	spin_unlock_irqrestore(&gpt->lock, flags);
+#endif
+
+	clear =3D MPC52xx_GPT_MODE_MS_MASK | MPC52xx_GPT_MODE_CONTINUOUS;
+	set =3D MPC52xx_GPT_MODE_MS_GPIO | MPC52xx_GPT_MODE_COUNTER_ENABLE;
+	if (continuous)
+		set |=3D MPC52xx_GPT_MODE_CONTINUOUS;
+
+	if (mpc52xx_gpt_calc_counter_input(period, (u64)gpt->ipb_freq,
+					   &counter_reg) !=3D 0)
+		return -EINVAL;
+
 	/* Set and enable the timer */
 	spin_lock_irqsave(&gpt->lock, flags);
-	out_be32(&gpt->regs->count, prescale << 16 | clocks);
+	out_be32(&gpt->regs->count, counter_reg);
 	clrsetbits_be32(&gpt->regs->mode, clear, set);
 	spin_unlock_irqrestore(&gpt->lock, flags);
=20
@@ -437,12 +479,175 @@ int mpc52xx_gpt_start_timer(struct mpc52xx_gpt_priv =
*gpt, int period,
 }
 EXPORT_SYMBOL(mpc52xx_gpt_start_timer);
=20
-void mpc52xx_gpt_stop_timer(struct mpc52xx_gpt_priv *gpt)
+/**
+ * mpc52xx_gpt_timer_period - Return the timer period in nanoseconds
+ * Note: reads the timer config directly from the hardware
+ */
+u64 mpc52xx_gpt_timer_period(struct mpc52xx_gpt_priv *gpt)
+{
+	u64 period;
+	u32 prescale;
+	unsigned long flags;
+
+	spin_lock_irqsave(&gpt->lock, flags);
+	period =3D in_be32(&gpt->regs->count);
+	spin_unlock_irqrestore(&gpt->lock, flags);
+
+	prescale =3D period >> 16;
+	period &=3D 0xffff;
+	if (prescale =3D=3D 0)
+		prescale =3D 0x10000;
+	period =3D period * (u64) prescale * NS_PER_SEC;
+	do_div(period, (u64)gpt->ipb_freq);
+	return period;
+}
+EXPORT_SYMBOL(mpc52xx_gpt_timer_period);
+
+int mpc52xx_gpt_stop_timer(struct mpc52xx_gpt_priv *gpt)
 {
+	unsigned long flags;
+
+	/* reject the operation if the timer is used as watchdog (gpt 0 only) */
+	spin_lock_irqsave(&gpt->lock, flags);
+#if defined(HAVE_MPC5200_WDT)
+	if ((gpt->wdt_mode & MPC52xx_GPT_IS_WDT)) {
+		spin_unlock_irqrestore(&gpt->lock, flags);
+		return -EBUSY;
+	}
+#endif
+
 	clrbits32(&gpt->regs->mode, MPC52xx_GPT_MODE_COUNTER_ENABLE);
+	spin_unlock_irqrestore(&gpt->lock, flags);
+	return 0;
 }
 EXPORT_SYMBOL(mpc52xx_gpt_stop_timer);
=20
+#if defined(HAVE_MPC5200_WDT)
+/**
+ * mpc52xx_gpt_wdt_probe - Find the wdt devide in the gpt list
+ */
+struct mpc52xx_gpt_priv *mpc52xx_gpt_wdt_probe(void)
+{
+	struct list_head *pos;
+	struct mpc52xx_gpt_priv *this_gpt =3D NULL;
+
+	/* find the wdt device in our list */
+	mutex_lock(&mpc52xx_gpt_list_mutex);
+	list_for_each(pos, &mpc52xx_gpt_list) {
+		this_gpt =3D container_of(pos, struct mpc52xx_gpt_priv, list);
+		if ((this_gpt->wdt_mode & MPC52xx_GPT_CAN_WDT)) {
+			mutex_unlock(&mpc52xx_gpt_list_mutex);
+			return this_gpt;
+		}
+	}
+	mutex_unlock(&mpc52xx_gpt_list_mutex);
+	return NULL;
+}
+EXPORT_SYMBOL(mpc52xx_gpt_wdt_probe);
+
+/**
+ * mpc52xx_gpt_wdt_start - Start the passed timer as watchdog
+ * @gpt_wdt: the watchdog gpt
+ * @wdt_timeout: watchdog timeout in seconds
+ *
+ * Note: the function does not protect itself form being called without a
+ * timer or with a timer which cannot function as wdt.
+ */
+int mpc52xx_gpt_wdt_start(struct mpc52xx_gpt_priv *gpt_wdt, int wdt_timeou=
t)
+{
+	u32 clear, set;
+	u32 counter_reg;
+	unsigned long flags;
+
+	/* calculate register settings */
+	if (mpc52xx_gpt_calc_counter_input((u64) wdt_timeout * NS_PER_SEC,
+					   (u64)gpt_wdt->ipb_freq,
+					   &counter_reg) !=3D 0) {
+		dev_info(gpt_wdt->dev, "bad timeout value %d\n", wdt_timeout);
+		return -EINVAL;
+	}
+
+	clear =3D MPC52xx_GPT_MODE_MS_MASK | MPC52xx_GPT_MODE_CONTINUOUS |
+		MPC52xx_GPT_MODE_IRQ_EN;
+	set =3D MPC52xx_GPT_MODE_MS_GPIO | MPC52xx_GPT_MODE_COUNTER_ENABLE |
+		MPC52xx_GPT_MODE_WDT_EN;
+
+	/* set the time-out and launch as wdt */
+	spin_lock_irqsave(&gpt_wdt->lock, flags);
+	out_be32(&gpt_wdt->regs->count, counter_reg);
+	clrsetbits_be32(&gpt_wdt->regs->mode, clear, set);
+	gpt_wdt->wdt_mode |=3D MPC52xx_GPT_IS_WDT;
+	spin_unlock_irqrestore(&gpt_wdt->lock, flags);
+
+	return 0;
+}
+EXPORT_SYMBOL(mpc52xx_gpt_wdt_start);
+
+/**
+ * mpc52xx_gpt_wdt_ping - Toggle the keep-alive signal of the watchdog
+ * @gpt_wdt: the watchdog gpt
+ *
+ * Note: the function does not protect itself form being called without a
+ * timer or with a timer which cannot function as wdt.
+ */
+int mpc52xx_gpt_wdt_ping(struct mpc52xx_gpt_priv *gpt_wdt)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&gpt_wdt->lock, flags);
+	out_8((u8 *) &gpt_wdt->regs->mode, MPC52xx_GPT_MODE_WDT_PING);
+	spin_unlock_irqrestore(&gpt_wdt->lock, flags);
+
+	return 0;
+}
+EXPORT_SYMBOL(mpc52xx_gpt_wdt_ping);
+
+/**
+ * mpc52xx_gpt_wdt_release - Release the watchdog so it can be used as gpt
+ * @gpt_wdt: the watchdog gpt
+ *
+ * Note: Stops the watchdog if CONFIG_WATCHDOG_NOWAYOUT is not defined.
+ * the function does not protect itself form being called without a
+ * timer or with a timer which cannot function as wdt.
+ */
+int mpc52xx_gpt_wdt_release(struct mpc52xx_gpt_priv *gpt_wdt)
+{
+#if !defined(CONFIG_WATCHDOG_NOWAYOUT)
+	unsigned long flags;
+
+	spin_lock_irqsave(&gpt_wdt->lock, flags);
+	clrbits32(&gpt_wdt->regs->mode,
+		  MPC52xx_GPT_MODE_COUNTER_ENABLE | MPC52xx_GPT_MODE_WDT_EN);
+	gpt_wdt->wdt_mode &=3D ~MPC52xx_GPT_IS_WDT;
+	spin_unlock_irqrestore(&gpt_wdt->lock, flags);
+#endif
+	return 0;
+}
+EXPORT_SYMBOL(mpc52xx_gpt_wdt_release);
+
+#if !defined(CONFIG_WATCHDOG_NOWAYOUT)
+/**
+ * mpc52xx_gpt_wdt_stop - Stop the watchdog
+ * @gpt_wdt: the watchdog gpt
+ *
+ * Note: the function does not protect itself form being called without a
+ * timer or with a timer which cannot function as wdt.
+ */
+int mpc52xx_gpt_wdt_stop(struct mpc52xx_gpt_priv *gpt_wdt)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&gpt_wdt->lock, flags);
+	clrbits32(&gpt_wdt->regs->mode,
+		  MPC52xx_GPT_MODE_COUNTER_ENABLE | MPC52xx_GPT_MODE_WDT_EN);
+	gpt_wdt->wdt_mode &=3D ~MPC52xx_GPT_IS_WDT;
+	spin_unlock_irqrestore(&gpt_wdt->lock, flags);
+	return 0;
+}
+EXPORT_SYMBOL(mpc52xx_gpt_wdt_stop);
+#endif  /*  CONFIG_WATCHDOG_NOWAYOUT  */
+#endif  /*  HAVE_MPC5200_WDT  */
+
 /* ---------------------------------------------------------------------
  * of_platform bus binding code
  */
@@ -473,6 +678,30 @@ static int __devinit mpc52xx_gpt_probe(struct of_devic=
e *ofdev,
 	list_add(&gpt->list, &mpc52xx_gpt_list);
 	mutex_unlock(&mpc52xx_gpt_list_mutex);
=20
+#if defined(HAVE_MPC5200_WDT)
+	/* check if this device could be a watchdog */
+	if (of_get_property(ofdev->node, "fsl,has-wdt", NULL) ||
+	    of_get_property(ofdev->node, "has-wdt", NULL)) {
+		const u32 *on_boot_wdt;
+
+		gpt->wdt_mode =3D MPC52xx_GPT_CAN_WDT;
+
+		/* check if the device shall be used as on-boot watchdog */
+		on_boot_wdt =3D of_get_property(ofdev->node, "wdt,on-boot", NULL);
+		if (on_boot_wdt) {
+			gpt->wdt_mode |=3D MPC52xx_GPT_IS_WDT;
+			if (*on_boot_wdt > 0 &&
+			    mpc52xx_gpt_wdt_start(gpt, *on_boot_wdt) =3D=3D 0)
+				dev_info(gpt->dev,
+					 "running as wdt, timeout %us\n",
+					 *on_boot_wdt);
+			else
+				dev_info(gpt->dev, "reserved as wdt\n");
+		} else
+			dev_info(gpt->dev, "can function as wdt\n");
+	}
+#endif
+
 	return 0;
 }
=20
