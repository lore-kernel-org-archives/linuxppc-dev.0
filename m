Return-Path: <albrecht.dress@arcor.de>
Received: from smtp6.netcologne.de (smtp6.netcologne.de [194.8.194.26])
	by ozlabs.org (Postfix) with ESMTP id 5D533B7BA0
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Nov 2009 05:44:50 +1100 (EST)
Date: Thu, 12 Nov 2009 19:44:47 +0100
From: Albrecht =?iso-8859-1?b?RHJl3w==?= <albrecht.dress@arcor.de>
Subject: [PATCHv2 2/3] mpc52xx/wdt: merge WDT code into the GPT driver
To: "Likely, Grant" <grant.likely@secretlab.ca>, Linux PPC Development
	<linuxppc-dev@ozlabs.org>, Devicetree Discussions
	<devicetree-discuss@lists.ozlabs.org>, Wim Van Sebroeck <wim@iguana.be>
Message-Id: <1258051487.2280.2@antares>
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

Change against v1: fully merge the wdt api into this file.
Note: The patch does also include the tiny GPT api changes from
<http://lists.ozlabs.org/pipermail/linuxppc-dev/2009-November/077647.html>.

 arch/powerpc/include/asm/mpc52xx.h        |    5 +-
 arch/powerpc/platforms/52xx/mpc52xx_gpt.c |  328 +++++++++++++++++++++++++=
++--
 2 files changed, 312 insertions(+), 21 deletions(-)

diff --git a/arch/powerpc/include/asm/mpc52xx.h b/arch/powerpc/include/asm/=
mpc52xx.h
index 707ab75..b664ce7 100644
--- a/arch/powerpc/include/asm/mpc52xx.h
+++ b/arch/powerpc/include/asm/mpc52xx.h
@@ -279,9 +279,10 @@ extern void mpc52xx_restart(char *cmd);
 /* mpc52xx_gpt.c */
 struct mpc52xx_gpt_priv;
 extern struct mpc52xx_gpt_priv *mpc52xx_gpt_from_irq(int irq);
-extern int mpc52xx_gpt_start_timer(struct mpc52xx_gpt_priv *gpt, int perio=
d,
+extern int mpc52xx_gpt_start_timer(struct mpc52xx_gpt_priv *gpt, u64 perio=
d,
                             int continuous);
-extern void mpc52xx_gpt_stop_timer(struct mpc52xx_gpt_priv *gpt);
+extern u64 mpc52xx_gpt_timer_period(struct mpc52xx_gpt_priv *gpt);
+extern int mpc52xx_gpt_stop_timer(struct mpc52xx_gpt_priv *gpt);

 /* mpc52xx_lpbfifo.c */
 #define MPC52XX_LPBFIFO_FLAG_READ		(0)
diff --git a/arch/powerpc/platforms/52xx/mpc52xx_gpt.c b/arch/powerpc/platf=
orms/52xx/mpc52xx_gpt.c
index 2c3fa13..42caecf 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
@@ -16,8 +16,14 @@
  * output signals or measure input signals.
  *
  * This driver supports the GPIO and IRQ controller functions of the GPT
- * device.  Timer functions are not yet supported, nor is the watchdog
- * timer.
+ * device.  Timer functions are not yet supported.
+ *
+ * The timer gpt0 can be used as watchdog (wdt).  If the wdt mode is used,
+ * this prevents the use of any gpt0 gpt function (i.e. they will fail wit=
h
+ * -EBUSY).  Thus, the safety wdt function always has precedence over the =
gpt
+ * function.  If the kernel has been compiled with CONFIG_WATCHDOG_NOWAYOU=
T,
+ * this means that gpt0 is locked in wdt mode until the next reboot - this
+ * may be a requirement in safety applications.
  *
  * To use the GPIO function, the following two properties must be added
  * to the device tree node for the gpt device (typically in the .dts file
@@ -56,11 +62,14 @@
 #include <linux/of_platform.h>
 #include <linux/of_gpio.h>
 #include <linux/kernel.h>
+#include <linux/watchdog.h>
+#include <linux/miscdevice.h>
+#include <linux/uaccess.h>
 #include <asm/div64.h>
 #include <asm/mpc52xx.h>

 MODULE_DESCRIPTION("Freescale MPC52xx gpt driver");
-MODULE_AUTHOR("Sascha Hauer, Grant Likely");
+MODULE_AUTHOR("Sascha Hauer, Grant Likely, Albrecht Dre=DF");
 MODULE_LICENSE("GPL");

 /**
@@ -70,6 +79,9 @@ MODULE_LICENSE("GPL");
  * @lock: spinlock to coordinate between different functions.
  * @of_gc: of_gpio_chip instance structure; used when GPIO is enabled
  * @irqhost: Pointer to irq_host instance; used when IRQ mode is supported
+ * @wdt_mode: only relevant for gpt0: bit 0 (MPC52xx_GPT_CAN_WDT) indicate=
s
+ *   if the gpt may be used as wdt, bit 1 (MPC52xx_GPT_IS_WDT) indicates
+ *   if the timer is actively used as wdt which blocks gpt functions
  */
 struct mpc52xx_gpt_priv {
 	struct list_head list;		/* List of all GPT devices */
@@ -78,6 +90,7 @@ struct mpc52xx_gpt_priv {
 	spinlock_t lock;
 	struct irq_host *irqhost;
 	u32 ipb_freq;
+	u8 wdt_mode;

 #if defined(CONFIG_GPIOLIB)
 	struct of_gpio_chip of_gc;
@@ -101,14 +114,21 @@ DEFINE_MUTEX(mpc52xx_gpt_list_mutex);
 #define MPC52xx_GPT_MODE_CONTINUOUS	(0x0400)
 #define MPC52xx_GPT_MODE_OPEN_DRAIN	(0x0200)
 #define MPC52xx_GPT_MODE_IRQ_EN		(0x0100)
+#define MPC52xx_GPT_MODE_WDT_EN		(0x8000)

 #define MPC52xx_GPT_MODE_ICT_MASK	(0x030000)
 #define MPC52xx_GPT_MODE_ICT_RISING	(0x010000)
 #define MPC52xx_GPT_MODE_ICT_FALLING	(0x020000)
 #define MPC52xx_GPT_MODE_ICT_TOGGLE	(0x030000)

+#define MPC52xx_GPT_MODE_WDT_PING	(0xa5)
+
 #define MPC52xx_GPT_STATUS_IRQMASK	(0x000f)

+#define MPC52xx_GPT_CAN_WDT		(1 << 0)
+#define MPC52xx_GPT_IS_WDT		(1 << 1)
+
+
 /* ---------------------------------------------------------------------
  * Cascaded interrupt controller hooks
  */
@@ -375,16 +395,8 @@ struct mpc52xx_gpt_priv *mpc52xx_gpt_from_irq(int irq)
 }
 EXPORT_SYMBOL(mpc52xx_gpt_from_irq);

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
+static int mpc52xx_gpt_do_start(struct mpc52xx_gpt_priv *gpt, u64 period,
+				int continuous, int as_wdt)
 {
 	u32 clear, set;
 	u64 clocks;
@@ -393,15 +405,19 @@ int mpc52xx_gpt_start_timer(struct mpc52xx_gpt_priv *=
gpt, int period,

 	clear =3D MPC52xx_GPT_MODE_MS_MASK | MPC52xx_GPT_MODE_CONTINUOUS;
 	set =3D MPC52xx_GPT_MODE_MS_GPIO | MPC52xx_GPT_MODE_COUNTER_ENABLE;
-	if (continuous)
+	if (as_wdt) {
+		clear |=3D MPC52xx_GPT_MODE_IRQ_EN;
+		set |=3D MPC52xx_GPT_MODE_WDT_EN;
+	} else if (continuous)
 		set |=3D MPC52xx_GPT_MODE_CONTINUOUS;

 	/* Determine the number of clocks in the requested period.  64 bit
 	 * arithmatic is done here to preserve the precision until the value
 	 * is scaled back down into the u32 range.  Period is in 'ns', bus
-	 * frequency is in Hz. */
-	clocks =3D (u64)period * (u64)gpt->ipb_freq;
-	do_div(clocks, 1000000000); /* Scale it down to ns range */
+	 * frequency is in Hz.	The maximum timeout @33MHz IPB clock is ~130
+	 * seconds*/
+	clocks =3D period * (u64)gpt->ipb_freq;
+	do_div(clocks, 1000000000ULL); /* Scale it down to ns range */

 	/* This device cannot handle a clock count greater than 32 bits */
 	if (clocks > 0xffffffff)
@@ -427,22 +443,279 @@ int mpc52xx_gpt_start_timer(struct mpc52xx_gpt_priv =
*gpt, int period,
 		return -EINVAL;
 	}

-	/* Set and enable the timer */
+	/* Set and enable the timer, reject an attempt to use a wdt as gpt */
 	spin_lock_irqsave(&gpt->lock, flags);
+	if (as_wdt)
+		gpt->wdt_mode |=3D MPC52xx_GPT_IS_WDT;
+	else if ((gpt->wdt_mode & MPC52xx_GPT_IS_WDT) !=3D 0) {
+		spin_unlock_irqrestore(&gpt->lock, flags);
+		return -EBUSY;
+	}
 	out_be32(&gpt->regs->count, prescale << 16 | clocks);
 	clrsetbits_be32(&gpt->regs->mode, clear, set);
 	spin_unlock_irqrestore(&gpt->lock, flags);

 	return 0;
 }
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
+	return mpc52xx_gpt_do_start(gpt, period, continuous, 0);
+}
 EXPORT_SYMBOL(mpc52xx_gpt_start_timer);

-void mpc52xx_gpt_stop_timer(struct mpc52xx_gpt_priv *gpt)
+/**
+ * mpc52xx_gpt_stop_timer - Stop a gpt
+ * @gpt: Pointer to gpt private data structure
+ *
+ * Returns an error if attempting to stop a wdt
+ */
+int mpc52xx_gpt_stop_timer(struct mpc52xx_gpt_priv *gpt)
 {
+	unsigned long flags;
+
+	/* reject the operation if the timer is used as watchdog (gpt 0 only) */
+	spin_lock_irqsave(&gpt->lock, flags);
+	if ((gpt->wdt_mode & MPC52xx_GPT_IS_WDT) !=3D 0) {
+		spin_unlock_irqrestore(&gpt->lock, flags);
+		return -EBUSY;
+	}
+
 	clrbits32(&gpt->regs->mode, MPC52xx_GPT_MODE_COUNTER_ENABLE);
+	spin_unlock_irqrestore(&gpt->lock, flags);
+	return 0;
 }
 EXPORT_SYMBOL(mpc52xx_gpt_stop_timer);

+/**
+ * mpc52xx_gpt_timer_period - Read the timer period
+ * @gpt: Pointer to gpt private data structure
+ *
+ * Returns the timer period in ns
+ */
+u64 mpc52xx_gpt_timer_period(struct mpc52xx_gpt_priv *gpt)
+{
+	u64 period;
+	u64 prescale;
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
+	period =3D period * prescale * 1000000000ULL;
+	do_div(period, (u64)gpt->ipb_freq);
+	return period;
+}
+EXPORT_SYMBOL(mpc52xx_gpt_timer_period);
+
+#if defined(CONFIG_MPC5200_WDT)
+/***********************************************************************
+ * Watchdog API for gpt0
+ */
+
+#define WDT_IDENTITY	    "mpc52xx watchdog on GPT0"
+
+/* wdt_is_active stores wether or not the /dev/watchdog device is opened *=
/
+static unsigned long wdt_is_active;
+
+/* wdt-capable gpt */
+static struct mpc52xx_gpt_priv *mpc52xx_gpt_wdt;
+
+/* low-level wdt functions */
+static inline void mpc52xx_gpt_wdt_ping(struct mpc52xx_gpt_priv *gpt_wdt)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&gpt_wdt->lock, flags);
+	out_8((u8 *) &gpt_wdt->regs->mode, MPC52xx_GPT_MODE_WDT_PING);
+	spin_unlock_irqrestore(&gpt_wdt->lock, flags);
+}
+
+/* wdt misc device api */
+static ssize_t mpc52xx_wdt_write(struct file *file, const char __user *dat=
a,
+				 size_t len, loff_t *ppos)
+{
+	struct mpc52xx_gpt_priv *gpt_wdt =3D file->private_data;
+	mpc52xx_gpt_wdt_ping(gpt_wdt);
+	return 0;
+}
+
+static struct watchdog_info mpc5200_wdt_info =3D {
+	.options	=3D WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING,
+	.identity	=3D WDT_IDENTITY,
+};
+
+static long mpc52xx_wdt_ioctl(struct file *file, unsigned int cmd,
+			      unsigned long arg)
+{
+	struct mpc52xx_gpt_priv *gpt_wdt =3D file->private_data;
+	int __user *data =3D (int __user *)arg;
+	int timeout;
+	u64 real_timeout;
+	int ret =3D 0;
+
+	switch (cmd) {
+	case WDIOC_GETSUPPORT:
+		ret =3D copy_to_user(data, &mpc5200_wdt_info,
+				   sizeof(mpc5200_wdt_info));
+		if (ret)
+			ret =3D -EFAULT;
+		break;
+
+	case WDIOC_GETSTATUS:
+	case WDIOC_GETBOOTSTATUS:
+		ret =3D put_user(0, data);
+		break;
+
+	case WDIOC_KEEPALIVE:
+		mpc52xx_gpt_wdt_ping(gpt_wdt);
+		break;
+
+	case WDIOC_SETTIMEOUT:
+		ret =3D get_user(timeout, data);
+		if (ret)
+			break;
+		real_timeout =3D (u64) timeout * 1000000000ULL;
+		ret =3D mpc52xx_gpt_do_start(gpt_wdt, real_timeout, 0, 1);
+		if (ret)
+			break;
+		/* fall through and return the timeout */
+
+	case WDIOC_GETTIMEOUT:
+		/* we need to round here as to avoid e.g. the following
+		 * situation:
+		 * - timeout requested is 1 second;
+		 * - real timeout @33MHz is 999997090ns
+		 * - the int divide by 10^9 will return 0.
+		 */
+		real_timeout =3D
+			mpc52xx_gpt_timer_period(gpt_wdt) + 500000000ULL;
+		do_div(real_timeout, 1000000000ULL);
+		timeout =3D (int) real_timeout;
+		ret =3D put_user(timeout, data);
+		break;
+
+	default:
+		ret =3D -ENOTTY;
+	}
+	return ret;
+}
+
+static int mpc52xx_wdt_open(struct inode *inode, struct file *file)
+{
+	int ret;
+
+	/* sanity check */
+	if (!mpc52xx_gpt_wdt)
+		return -ENODEV;
+
+	/* /dev/watchdog can only be opened once */
+	if (test_and_set_bit(0, &wdt_is_active))
+		return -EBUSY;
+
+	/* Set and activate the watchdog with 30 seconds timeout */
+	ret =3D mpc52xx_gpt_do_start(mpc52xx_gpt_wdt, 30ULL * 1000000000ULL,
+				   0, 1);
+	if (ret) {
+		clear_bit(0, &wdt_is_active);
+		return ret;
+	}
+
+	file->private_data =3D mpc52xx_gpt_wdt;
+	return nonseekable_open(inode, file);
+}
+
+static int mpc52xx_wdt_release(struct inode *inode, struct file *file)
+{
+	/* note: releasing the wdt in NOWAYOUT-mode does not stop it */
+#if !defined(CONFIG_WATCHDOG_NOWAYOUT)
+	struct mpc52xx_gpt_priv *gpt_wdt =3D file->private_data;
+	unsigned long flags;
+
+	spin_lock_irqsave(&gpt_wdt->lock, flags);
+	clrbits32(&gpt_wdt->regs->mode,
+		  MPC52xx_GPT_MODE_COUNTER_ENABLE | MPC52xx_GPT_MODE_WDT_EN);
+	gpt_wdt->wdt_mode &=3D ~MPC52xx_GPT_IS_WDT;
+	spin_unlock_irqrestore(&gpt_wdt->lock, flags);
+#endif
+	clear_bit(0, &wdt_is_active);
+	return 0;
+}
+
+
+static const struct file_operations mpc52xx_wdt_fops =3D {
+	.owner		=3D THIS_MODULE,
+	.llseek		=3D no_llseek,
+	.write		=3D mpc52xx_wdt_write,
+	.unlocked_ioctl =3D mpc52xx_wdt_ioctl,
+	.open		=3D mpc52xx_wdt_open,
+	.release	=3D mpc52xx_wdt_release,
+};
+
+static struct miscdevice mpc52xx_wdt_miscdev =3D {
+	.minor		=3D WATCHDOG_MINOR,
+	.name		=3D "watchdog",
+	.fops		=3D &mpc52xx_wdt_fops,
+};
+
+static int __devinit mpc52xx_gpt_wdt_init(void)
+{
+	int err;
+
+	/* try to register the watchdog misc device */
+	err =3D misc_register(&mpc52xx_wdt_miscdev);
+	if (err)
+		pr_err("%s: cannot register watchdog device\n", WDT_IDENTITY);
+	else
+		pr_info("%s: watchdog device registered\n", WDT_IDENTITY);
+	return err;
+}
+
+static int mpc52xx_gpt_wdt_setup(struct mpc52xx_gpt_priv *gpt,
+				 const u32 *period)
+{
+	u64 real_timeout;
+
+	/* remember the gpt for the wdt operation */
+	mpc52xx_gpt_wdt =3D gpt;
+
+	/* configure the wdt if the device tree contained a timeout */
+	if (!period || *period =3D=3D 0)
+		return 0;
+
+	real_timeout =3D (u64) *period * 1000000000ULL;
+	if (mpc52xx_gpt_do_start(gpt, real_timeout, 0, 1))
+		dev_warn(gpt->dev, "starting as wdt failed\n");
+	else
+		dev_info(gpt->dev, "watchdog set to %us timeout\n", *period);
+	return 0;
+}
+
+#else
+
+static int __devinit mpc52xx_gpt_wdt_init(void)
+{
+	return 0;
+}
+
+#define mpc52xx_gpt_wdt_setup(x, y)		(0)
+
+#endif	/*  CONFIG_MPC5200_WDT	*/
+
 /* ---------------------------------------------------------------------
  * of_platform bus binding code
  */
@@ -473,6 +746,22 @@ static int __devinit mpc52xx_gpt_probe(struct of_devic=
e *ofdev,
 	list_add(&gpt->list, &mpc52xx_gpt_list);
 	mutex_unlock(&mpc52xx_gpt_list_mutex);

+	/* check if this device could be a watchdog */
+	if (of_get_property(ofdev->node, "fsl,has-wdt", NULL) ||
+	    of_get_property(ofdev->node, "has-wdt", NULL)) {
+		const u32 *on_boot_wdt;
+
+		gpt->wdt_mode =3D MPC52xx_GPT_CAN_WDT;
+		on_boot_wdt =3D of_get_property(ofdev->node, "fsl,wdt-on-boot",
+					      NULL);
+		if (on_boot_wdt) {
+			dev_info(gpt->dev, "used as watchdog\n");
+			gpt->wdt_mode |=3D MPC52xx_GPT_IS_WDT;
+		} else
+			dev_info(gpt->dev, "can function as watchdog\n");
+		mpc52xx_gpt_wdt_setup(gpt, on_boot_wdt);
+	}
+
 	return 0;
 }

@@ -507,3 +796,4 @@ static int __init mpc52xx_gpt_init(void)

 /* Make sure GPIOs and IRQs get set up before anyone tries to use them */
 subsys_initcall(mpc52xx_gpt_init);
+device_initcall(mpc52xx_gpt_wdt_init);
