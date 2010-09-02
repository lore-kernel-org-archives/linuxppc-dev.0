Return-Path: <sposelenov@emcraft.com>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 795EAB7170
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  2 Sep 2010 20:20:36 +1000 (EST)
From: sposelenov@emcraft.com
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/2] [PPC] Motion-PRO: Added LED support for the Promess
	Motion-Pro board. The driver is based on the original
	version(http://www.mail-archive.com/linuxppc-dev@lists.ozlabs.org/msg06694.html),
	adapted for the current kernel structures.
Date: Thu,  2 Sep 2010 12:20:31 +0200
Message-Id: <1283422832-9620-1-git-send-email-sposelenov@emcraft.com>
Cc: Sergei Poselenov <sposelenov@emcraft.com>, wd@denx.de, dzu@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Sergei Poselenov <sposelenov@emcraft.com>

Signed-off-by: Sergei Poselenov <sposelenov@emcraft.com>
---
 arch/powerpc/configs/52xx/motionpro_defconfig |    1 +
 arch/powerpc/include/asm/mpc52xx.h            |    5 +
 drivers/leds/Kconfig                          |    7 +
 drivers/leds/Makefile                         |    1 +
 drivers/leds/leds-motionpro.c                 |  255 +++++++++++++++++++++++++
 5 files changed, 269 insertions(+), 0 deletions(-)
 create mode 100644 drivers/leds/leds-motionpro.c

diff --git a/arch/powerpc/configs/52xx/motionpro_defconfig b/arch/powerpc/configs/52xx/motionpro_defconfig
index 20d53a1..cad1f44 100644
--- a/arch/powerpc/configs/52xx/motionpro_defconfig
+++ b/arch/powerpc/configs/52xx/motionpro_defconfig
@@ -77,6 +77,7 @@ CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_MPC=y
 CONFIG_WATCHDOG=y
 # CONFIG_USB_SUPPORT is not set
+CONFIG_LEDS_MOTIONPRO=y
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
 CONFIG_LEDS_TRIGGERS=y
diff --git a/arch/powerpc/include/asm/mpc52xx.h b/arch/powerpc/include/asm/mpc52xx.h
index 1f41382..b206e47 100644
--- a/arch/powerpc/include/asm/mpc52xx.h
+++ b/arch/powerpc/include/asm/mpc52xx.h
@@ -148,6 +148,11 @@ struct mpc52xx_gpio {
 #define MPC52xx_GPIO_PSC_CONFIG_UART_WITH_CD	5
 #define MPC52xx_GPIO_PCI_DIS			(1<<15)
 
+/* Enables GPT register to operate as simple GPIO output register */
+#define MPC52xx_GPT_ENABLE_OUTPUT	0x00000024
+/* Puts 1 on GPT output pin */
+#define MPC52xx_GPT_OUTPUT_1		0x00000010
+
 /* GPIO with WakeUp*/
 struct mpc52xx_gpio_wkup {
 	u8 wkup_gpioe;		/* GPIO_WKUP + 0x00 */
diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index e411262..f5c3e6b 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -311,6 +311,13 @@ config LEDS_NS2
 	  Network Space v2 board (and parents). This include Internet Space v2,
 	  Network Space (Max) v2 and d2 Network v2 boards.
 
+config LEDS_MOTIONPRO
+	tristate "Motionpro LEDs Support"
+	depends on LEDS_CLASS
+	help
+	  This option enables support for status and ready LEDs connected
+	  to GPIO lines on Motionpro board.
+
 config LEDS_TRIGGERS
 	bool "LED Trigger support"
 	help
diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
index 7d6b958..738e227 100644
--- a/drivers/leds/Makefile
+++ b/drivers/leds/Makefile
@@ -38,6 +38,7 @@ obj-$(CONFIG_LEDS_ADP5520)		+= leds-adp5520.o
 obj-$(CONFIG_LEDS_DELL_NETBOOKS)	+= dell-led.o
 obj-$(CONFIG_LEDS_MC13783)		+= leds-mc13783.o
 obj-$(CONFIG_LEDS_NS2)			+= leds-ns2.o
+obj-$(CONFIG_LEDS_MOTIONPRO)		+= leds-motionpro.o
 
 # LED SPI Drivers
 obj-$(CONFIG_LEDS_DAC124S085)		+= leds-dac124s085.o
diff --git a/drivers/leds/leds-motionpro.c b/drivers/leds/leds-motionpro.c
new file mode 100644
index 0000000..94f6cf8
--- /dev/null
+++ b/drivers/leds/leds-motionpro.c
@@ -0,0 +1,255 @@
+/*
+ * LEDs driver for the Motion-PRO board.
+ *
+ * Copyright (C) 2007 Semihalf
+ * Jan Wrobel <wrr@semihalf.com>
+ * Marian Balakowicz <m8@semihalf.com>
+ *
+ * Porting to the mainline Linux tree.
+ * Copyright (C) 2010 Emcraft Systems
+ * Sergei Poselenov <sposelenov@emcraft.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc., 51
+ * Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ *
+ * Decription:
+ * This driver enables control over Motion-PRO status and ready LEDs through
+ * sysfs. LEDs can be controlled by writing to sysfs files:
+ * class/leds/<led-name>/(brightness|delay_off|delay_on).
+ * See Documentation/leds-class.txt for more details.
+ * <led-name> is the set to the value of 'label' property of the
+ * corresponding GPT node.
+ *
+ * Before user issues first control command via sysfs, LED blinking is
+ * controlled by the kernel ('blink-delay' property of the GPT node
+ * in the device tree blob).
+ *
+ */
+
+#define DEBUG
+
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/leds.h>
+#include <linux/of_platform.h>
+#include <asm/mpc52xx.h>
+
+/* LED control bits */
+#define LED_ON	MPC52xx_GPT_OUTPUT_1
+
+/* LED mode */
+#define LED_MODE_KERNEL		1
+#define LED_MODE_USER		2
+
+struct motionpro_led {
+	spinlock_t led_lock;		/* Protects the LED data */
+	struct mpc52xx_gpt __iomem *gpt;/* LED registers */
+	struct timer_list blink_timer;	/* Used if blink_delay is nonzero */
+	unsigned int blink_delay;	/* [ms], if set to 0 blinking is off */
+	unsigned int mode;		/* kernel/user */
+	struct led_classdev mpled_cdev;	/* LED class */
+};
+
+/*
+ * Timer event - blinks LED before user takes control over it
+ * with the first access via sysfs.
+ */
+static void mpled_timer_toggle(unsigned long data)
+{
+	struct motionpro_led *mpled = (struct motionpro_led *)data;
+
+	spin_lock_bh(&mpled->led_lock);
+	if (mpled->mode == LED_MODE_KERNEL) {
+		u32 val = in_be32(&mpled->gpt->mode);
+		val ^= LED_ON;
+		out_be32(&mpled->gpt->mode, val);
+
+		mod_timer(&mpled->blink_timer,
+			jiffies + msecs_to_jiffies(mpled->blink_delay));
+	}
+	spin_unlock_bh(&mpled->led_lock);
+}
+
+/*
+ * Turn on/off led according to user settings in sysfs.
+ * First call to this function disables kernel blinking.
+ */
+static void mpled_set(struct led_classdev *led_cdev,
+		      enum led_brightness brightness)
+{
+	struct motionpro_led *mpled;
+	int old_mode;
+	u32 val;
+
+	mpled = container_of(led_cdev, struct motionpro_led, mpled_cdev);
+
+	spin_lock_bh(&mpled->led_lock);
+	/* disable kernel controll */
+	old_mode = mpled->mode;
+	if (old_mode == LED_MODE_KERNEL)
+		mpled->mode = LED_MODE_USER;
+
+	val = in_be32(&mpled->gpt->mode);
+	if (brightness)
+		val |= LED_ON;
+	else
+		val &= ~LED_ON;
+	out_be32(&mpled->gpt->mode, val);
+	spin_unlock_bh(&mpled->led_lock);
+
+	/* delete kernel mode blink timer, not needed anymore */
+	if ((old_mode == LED_MODE_KERNEL) && mpled->blink_delay)
+		del_timer(&mpled->blink_timer);
+}
+
+static void mpled_init_led(void __iomem *gpt_mode)
+{
+	u32 val = in_be32(gpt_mode);
+	val |= MPC52xx_GPT_ENABLE_OUTPUT;
+	val &= ~LED_ON;
+	out_be32(gpt_mode, val);
+}
+
+static int __devinit mpled_probe(struct platform_device *op,
+				 const struct of_device_id *match)
+{
+	struct motionpro_led *mpled;
+	const unsigned int *of_blink_delay;
+	const char *label;
+	int err;
+
+	dev_dbg(&op->dev, "mpled_probe: node=%s (op=%p, match=%p)\n",
+		op->name, op, match);
+
+	mpled = kzalloc(sizeof(*mpled), GFP_KERNEL);
+	if (!mpled)
+		return -ENOMEM;
+
+	mpled->gpt = of_iomap(op->dev.of_node, 0);
+	if (!mpled->gpt) {
+		printk(KERN_ERR __FILE__ ": "
+			"Error mapping GPT registers for LED %s\n",
+			op->dev.of_node->full_name);
+		err = -EIO;
+		goto err_free;
+	}
+
+	/* initialize GPT for LED use */
+	mpled_init_led(&mpled->gpt->mode);
+
+	spin_lock_init(&mpled->led_lock);
+	mpled->mode = LED_MODE_KERNEL;
+
+	/* get LED label, used to register led classdev */
+	label = of_get_property(op->dev.of_node, "label", NULL);
+	if (label == NULL) {
+		printk(KERN_ERR __FILE__ ": "
+			"No label property provided for LED %s\n",
+			op->dev.of_node->full_name);
+		err = -EINVAL;
+		goto err;
+	}
+	dev_dbg(&op->dev, "mpled_probe: label = '%s'\n", label);
+
+	/* get 'blink-delay' property if present */
+	of_blink_delay = of_get_property(op->dev.of_node, "blink-delay", NULL);
+	mpled->blink_delay =  of_blink_delay ? *of_blink_delay : 0;
+	dev_dbg(&op->dev, "mpled_probe: blink_delay = %d msec\n",
+		mpled->blink_delay);
+
+	/* initialize kernel blink_timer if blink_delay was provided */
+	if (mpled->blink_delay) {
+		init_timer(&mpled->blink_timer);
+		mpled->blink_timer.function = mpled_timer_toggle;
+		mpled->blink_timer.data = (unsigned long)mpled;
+
+		mod_timer(&mpled->blink_timer,
+			jiffies + msecs_to_jiffies(mpled->blink_delay));
+	}
+
+	/* register LED classdev */
+	mpled->mpled_cdev.name = label;
+	mpled->mpled_cdev.brightness_set = mpled_set;
+	mpled->mpled_cdev.default_trigger = "timer";
+
+	err = led_classdev_register(NULL, &mpled->mpled_cdev);
+	if (err) {
+		printk(KERN_ERR __FILE__ ": "
+			"Error registering class device for LED %s\n",
+			op->dev.of_node->full_name);
+		goto err;
+	}
+
+	dev_set_drvdata(&op->dev, mpled);
+	return 0;
+
+err:
+	if (mpled->blink_delay)
+		del_timer(&mpled->blink_timer);
+	iounmap(mpled->gpt);
+err_free:
+	kfree(mpled);
+
+	return err;
+}
+
+static int mpled_remove(struct platform_device *op)
+{
+	struct motionpro_led *mpled = dev_get_drvdata(&op->dev);
+
+	dev_dbg(&op->dev, "mpled_remove: (%p)\n", op);
+
+	if (mpled->blink_delay && (mpled->mode == LED_MODE_KERNEL))
+		del_timer(&mpled->blink_timer);
+
+	led_classdev_unregister(&mpled->mpled_cdev);
+
+	iounmap(mpled->gpt);
+	kfree(mpled);
+
+	return 0;
+}
+
+static const struct of_device_id mpled_match[] = {
+	{ .compatible = "promess,motionpro-led", },
+	{},
+};
+
+static struct of_platform_driver mpled_driver = {
+	.probe		= mpled_probe,
+	.remove		= mpled_remove,
+	.driver		= {
+		.owner		= THIS_MODULE,
+		.name		= "leds-motionpro",
+		.of_match_table	= mpled_match,
+	},
+};
+
+static int __init mpled_init(void)
+{
+	return of_register_platform_driver(&mpled_driver);
+}
+
+static void __exit mpled_exit(void)
+{
+	of_unregister_platform_driver(&mpled_driver);
+}
+
+module_init(mpled_init);
+module_exit(mpled_exit);
+
+MODULE_LICENSE("GPL")
+MODULE_DESCRIPTION("Motion-PRO LED driver");
+MODULE_AUTHOR("Jan Wrobel <wrr@semihalf.com>");
+MODULE_AUTHOR("Marian Balakowicz <m8@semihalf.com>");
-- 
1.6.2.5
