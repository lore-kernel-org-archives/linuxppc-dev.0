Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id BF5BEDE01D
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Mar 2008 04:10:46 +1100 (EST)
Date: Thu, 27 Mar 2008 20:10:45 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Richard Purdie <rpurdie@rpsys.net>
Subject: Re: [PATCH 3/5] leds: implement OpenFirmare GPIO LEDs driver
Message-ID: <20080327171045.GA3266@localhost.localdomain>
References: <20080326202453.GC1772@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20080326202453.GC1772@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Mar 26, 2008 at 11:24:53PM +0300, Anton Vorontsov wrote:
> Despite leds-gpio and leds-of-gpio similar names and purposes, there
> is actually very few code can be shared between the two (both drivers
> are mostly the driver bindings anyway).
> 
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
> 
> This patch depends on the not yet applied OF/PowerPC GPIO patches, so
> please consider this for RFC only.
> 
> Thanks.

Here is updated patch with new linux,brightness OF property (needed for
MPC8349E-mITX board -- pwr led should be "on" by default).

p.s. I tend to do documentation as a separate patch: I don't want this
patch to depend on the booting-without-of.txt -- it may produce
conflicts easily.

- - - -
From: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: leds: implement OpenFirmare GPIO LEDs driver

Despite leds-gpio and leds-of-gpio similar names and purposes, there
is actually very few code can be shared between the two (both drivers
are mostly the driver bindings anyway).

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 drivers/leds/Kconfig        |    8 ++
 drivers/leds/Makefile       |    1 +
 drivers/leds/leds-of-gpio.c |  204 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 213 insertions(+), 0 deletions(-)
 create mode 100644 drivers/leds/leds-of-gpio.c

diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index 09aac5d..48a1077 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -113,6 +113,14 @@ config LEDS_GPIO
 	  outputs. To be useful the particular board must have LEDs
 	  and they must be connected to the GPIO lines.
 
+config LEDS_OF_GPIO
+	tristate "LED Support for GPIO connected LEDs (OpenFirmware bindings)"
+	depends on LEDS_CLASS && OF_GPIO
+	help
+	  This option enables support for the LEDs connected to GPIO
+	  outputs. To be useful the particular board must have LEDs
+	  and they must be connected to the GPIO lines.
+
 config LEDS_CM_X270
 	tristate "LED Support for the CM-X270 LEDs"
 	depends on LEDS_CLASS && MACH_ARMCORE
diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
index 84ced3b..78926ca 100644
--- a/drivers/leds/Makefile
+++ b/drivers/leds/Makefile
@@ -18,6 +18,7 @@ obj-$(CONFIG_LEDS_H1940)		+= leds-h1940.o
 obj-$(CONFIG_LEDS_COBALT_QUBE)		+= leds-cobalt-qube.o
 obj-$(CONFIG_LEDS_COBALT_RAQ)		+= leds-cobalt-raq.o
 obj-$(CONFIG_LEDS_GPIO)			+= leds-gpio.o
+obj-$(CONFIG_LEDS_OF_GPIO)		+= leds-of-gpio.o
 obj-$(CONFIG_LEDS_CM_X270)              += leds-cm-x270.o
 obj-$(CONFIG_LEDS_CLEVO_MAIL)		+= leds-clevo-mail.o
 obj-$(CONFIG_LEDS_HP6XX)		+= leds-hp6xx.o
diff --git a/drivers/leds/leds-of-gpio.c b/drivers/leds/leds-of-gpio.c
new file mode 100644
index 0000000..d9b7dcd
--- /dev/null
+++ b/drivers/leds/leds-of-gpio.c
@@ -0,0 +1,204 @@
+/*
+ * LEDs driver for GPIOs (OpenFirmware bindings)
+ *
+ * Copyright (C) 2007 8D Technologies inc.
+ * Raphael Assenat <raph@8d.com>
+ * Copyright (C) 2008 MontaVista Software, Inc.
+ * Anton Vorontsov <avorontsov@ru.mvista.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/of_platform.h>
+#include <linux/of_gpio.h>
+#include <linux/leds.h>
+#include <linux/workqueue.h>
+
+struct of_gpio_led {
+	struct device_node *np;
+	struct led_classdev cdev;
+	struct work_struct work;
+	unsigned int gpio;
+	bool new_level;
+	bool can_sleep;
+	bool active_low;
+};
+
+static void gpio_led_work(struct work_struct *work)
+{
+	struct of_gpio_led *led = container_of(work, struct of_gpio_led, work);
+
+	gpio_set_value_cansleep(led->gpio, led->new_level);
+}
+
+static void gpio_led_set(struct led_classdev *led_cdev,
+			 enum led_brightness value)
+{
+	struct of_gpio_led *led = container_of(led_cdev, struct of_gpio_led,
+					       cdev);
+	bool level;
+
+	if (value == LED_OFF)
+		level = false;
+	else
+		level = true;
+
+	if (led->active_low)
+		level = !level;
+
+	/* setting GPIOs with I2C/etc requires a preemptible task context */
+	if (led->can_sleep) {
+		if (preempt_count()) {
+			led->new_level = level;
+			schedule_work(&led->work);
+		} else {
+			gpio_set_value_cansleep(led->gpio, level);
+		}
+	} else {
+		gpio_set_value(led->gpio, level);
+	}
+}
+
+static int __devinit of_gpio_leds_probe(struct of_device *ofdev,
+					const struct of_device_id *match)
+{
+	int ret;
+	struct of_gpio_led *led;
+	struct device_node *np = ofdev->node;
+	const int *brightness;
+	int size;
+
+	led = kzalloc(sizeof(*led), GFP_KERNEL);
+	if (!led)
+		return -ENOMEM;
+
+	led->np = np;
+
+	ret = of_get_gpio(np, 0);
+	if (!gpio_is_valid(ret)) {
+		dev_err(&ofdev->dev, "gpio is invalid\n");
+		goto err_get_gpio;
+	}
+	led->gpio = ret;
+	led->can_sleep = gpio_cansleep(led->gpio);
+
+	led->cdev.name = of_get_property(np, "linux,name", NULL);
+	if (!led->cdev.name)
+		led->cdev.name = ofdev->dev.bus_id;
+	led->cdev.default_trigger = of_get_property(np,
+					"linux,default-trigger", NULL);
+	led->active_low = of_get_property(np, "linux,active-low", NULL) ?
+					  1 : 0;
+	led->cdev.brightness_set = gpio_led_set;
+	led->cdev.brightness = LED_OFF;
+	brightness = of_get_property(np, "linux,brightness", &size);
+	if (!brightness || size != sizeof(u32))
+		led->cdev.brightness = LED_OFF;
+	else
+		led->cdev.brightness = *brightness;
+
+	ret = gpio_request(led->gpio, ofdev->dev.bus_id);
+	if (ret < 0) {
+		dev_err(&ofdev->dev, "could not request gpio, status is %d\n",
+			ret);
+		goto err_gpio;
+	}
+
+	ret = gpio_direction_output(led->gpio, led->active_low);
+	if (ret) {
+		dev_err(&ofdev->dev, "gpio could not be an output, "
+			"status is %d\n", ret);
+		goto err_gpio;
+	}
+
+	INIT_WORK(&led->work, gpio_led_work);
+	gpio_led_set(&led->cdev, led->cdev.brightness);
+
+	ret = led_classdev_register(&ofdev->dev, &led->cdev);
+	if (ret < 0) {
+		dev_err(&ofdev->dev, "could register led cdev, status is %d\n",
+			ret);
+		gpio_free(led->gpio);
+		goto err_reg_cdev;
+	}
+
+	dev_set_drvdata(&ofdev->dev, led);
+
+	return 0;
+
+err_reg_cdev:
+	cancel_work_sync(&led->work);
+err_gpio:
+	gpio_free(led->gpio);
+err_get_gpio:
+	kfree(led);
+	return ret;
+}
+
+static int __devexit of_gpio_leds_remove(struct of_device *ofdev)
+{
+	struct of_gpio_led *led = dev_get_drvdata(&ofdev->dev);
+
+	led_classdev_unregister(&led->cdev);
+	cancel_work_sync(&led->work);
+	gpio_free(led->gpio);
+	of_node_put(led->np);
+	kfree(led);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int of_gpio_led_suspend(struct of_device *ofdev, pm_message_t state)
+{
+	struct of_gpio_led *led = dev_get_drvdata(&ofdev->dev);
+
+	led_classdev_suspend(&led->cdev);
+	return 0;
+}
+
+static int of_gpio_led_resume(struct of_device *ofdev)
+{
+	struct of_gpio_led *led = dev_get_drvdata(&ofdev->dev);
+
+	led_classdev_resume(&led->cdev);
+	return 0;
+}
+#else
+#define of_gpio_led_suspend NULL
+#define of_gpio_led_resume NULL
+#endif /* CONFIG_PM */
+
+static const struct of_device_id of_gpio_leds_match[] = {
+	{ .compatible = "gpio-led", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, of_gpio_leds_match);
+
+static struct of_platform_driver of_gpio_leds_drv = {
+	.name = "of_gpio_leds",
+	.match_table = of_gpio_leds_match,
+	.probe = of_gpio_leds_probe,
+	.remove = __devexit_p(of_gpio_leds_remove),
+	.suspend = of_gpio_led_suspend,
+	.resume = of_gpio_led_resume,
+};
+
+static int __init of_gpio_leds_init(void)
+{
+	return of_register_platform_driver(&of_gpio_leds_drv);
+}
+module_init(of_gpio_leds_init);
+
+static void __exit of_gpio_leds_exit(void)
+{
+	of_unregister_platform_driver(&of_gpio_leds_drv);
+}
+module_exit(of_gpio_leds_exit);
+
+MODULE_DESCRIPTION("OF-platform GPIO LEDs driver");
+MODULE_AUTHOR("Anton Vorontsov <avorontsov@ru.mvista.com>");
+MODULE_LICENSE("GPL");
-- 
1.5.2.2
