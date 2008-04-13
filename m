Return-Path: <jwboyer@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.180])
	by ozlabs.org (Postfix) with ESMTP id 6D961DE1D4
	for <linuxppc-dev@ozlabs.org>; Sun, 13 Apr 2008 10:41:35 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id z59so1091263pyg.27
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Apr 2008 17:41:34 -0700 (PDT)
Subject: Re: [PATCH 4/5] LED driver
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Sean MacLennan <smaclennan@pikatech.com>
In-Reply-To: <20080412141039.25e14fae@lappy.seanm.ca>
References: <20080412134831.424480cf@lappy.seanm.ca>
	<20080412141039.25e14fae@lappy.seanm.ca>
Content-Type: text/plain
Date: Sat, 12 Apr 2008 19:41:30 -0500
Message-Id: <1208047290.5869.31.camel@vader.jdub.homelinux.org>
Mime-Version: 1.0
Sender: Josh Boyer <jwboyer@gmail.com>
Cc: linuxppc-dev@ozlabs.org
Reply-To: jwboyer@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2008-04-12 at 14:10 -0400, Sean MacLennan wrote:
> Signed-off-by: Sean MacLennan <smaclennan@pikatech.com>

This should be sent to Richard Purdie.

josh
> 
> diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
> index 859814f..31e1746 100644
> --- a/drivers/leds/Kconfig
> +++ b/drivers/leds/Kconfig
> @@ -145,6 +145,12 @@ config LEDS_CLEVO_MAIL
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called leds-clevo-mail.
>  
> +config LEDS_WARP
> +	tristate "LED Support for the PIKA Warp LEDs"
> +	depends on LEDS_CLASS && WARP
> +	help
> +	  This option enables support for the PIKA Warp LEDs.
> +
>  comment "LED Triggers"
>  
>  config LEDS_TRIGGERS
> diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
> index 84ced3b..eb60fb1 100644
> --- a/drivers/leds/Makefile
> +++ b/drivers/leds/Makefile
> @@ -21,6 +21,7 @@ obj-$(CONFIG_LEDS_GPIO)			+= leds-gpio.o
>  obj-$(CONFIG_LEDS_CM_X270)              += leds-cm-x270.o
>  obj-$(CONFIG_LEDS_CLEVO_MAIL)		+= leds-clevo-mail.o
>  obj-$(CONFIG_LEDS_HP6XX)		+= leds-hp6xx.o
> +obj-$(CONFIG_LEDS_WARP)			+= leds-warp.o
>  
>  # LED Triggers
>  obj-$(CONFIG_LEDS_TRIGGER_TIMER)	+= ledtrig-timer.o
> diff --git a/drivers/leds/leds-warp.c b/drivers/leds/leds-warp.c
> new file mode 100644
> index 0000000..0fbe0b7
> --- /dev/null
> +++ b/drivers/leds/leds-warp.c
> @@ -0,0 +1,148 @@
> +/*
> + * Copyright (c) 2008 PIKA Technologies
> + *   Sean MacLennan <smaclennan at pikatech.com>
> + *
> + * This is just a temporary driver until the GPIO/GPIO_OF_LEDS drivers
> + * get sorted out.
> + */
> +#include <linux/module.h>
> +#include <linux/leds.h>
> +#include <linux/of_platform.h>
> +#include <asm/machdep.h>
> +
> +
> +#define LED_GREEN (0x80000000 >> 0)
> +#define LED_RED   (0x80000000 >> 1)
> +
> +static void __iomem *gpio_base;
> +
> +
> +static void warp_green_set(struct led_classdev *led_cdev,
> +			   enum led_brightness brightness)
> +{
> +	unsigned leds = in_be32(gpio_base);
> +
> +	if (brightness)
> +		leds |=  LED_GREEN;
> +	else
> +		leds &= ~LED_GREEN;
> +
> +	out_be32(gpio_base, leds);
> +}
> +
> +static void warp_red_set(struct led_classdev *led_cdev,
> +			 enum led_brightness brightness)
> +{
> +	unsigned leds = in_be32(gpio_base);
> +
> +	if (brightness)
> +		leds |=  LED_RED;
> +	else
> +		leds &= ~LED_RED;
> +
> +	out_be32(gpio_base, leds);
> +}
> +
> +static struct led_classdev warp_green_led = {
> +	.name = "warp-green",
> +	.brightness_set = warp_green_set,
> +};
> +
> +static struct led_classdev warp_red_led = {
> +	.name = "warp-red",
> +	.brightness_set = warp_red_set,
> +};
> +
> +static int __devinit warp_led_probe(struct platform_device *pdev)
> +{
> +	struct device_node *np;
> +	int rc;
> +
> +	/* Power LEDS are on the second GPIO controller */
> +	np = of_find_compatible_node(NULL, NULL, "ibm,gpio-440EP");
> +	if (np)
> +		np = of_find_compatible_node(np, NULL, "ibm,gpio-440EP");
> +	if (np == NULL) {
> +		printk(KERN_ERR __FILE__ ": Unable to find gpio\n");
> +		return -ENOENT;
> +	}
> +
> +	gpio_base = of_iomap(np, 0);
> +	of_node_put(np);
> +	if (gpio_base == NULL) {
> +		printk(KERN_ERR __FILE__ ": Unable to map gpio");
> +		return -ENOMEM;
> +	}
> +
> +	rc = led_classdev_register(&pdev->dev, &warp_green_led);
> +	if (rc) {
> +		iounmap(gpio_base);
> +		return rc;
> +	}
> +
> +	rc = led_classdev_register(&pdev->dev, &warp_red_led);
> +	if (rc) {
> +		led_classdev_unregister(&warp_green_led);
> +		iounmap(gpio_base);
> +		return rc;
> +	}
> +
> +	return 0;
> +}
> +
> +static int __devexit warp_led_remove(struct platform_device *pdev)
> +{
> +	led_classdev_unregister(&warp_green_led);
> +	led_classdev_unregister(&warp_red_led);
> +
> +	iounmap(gpio_base);
> +
> +	return 0;
> +}
> +
> +/* We *must* have a release. */
> +static void warp_led_release(struct device *dev) {}
> +
> +static struct platform_driver warp_led_driver = {
> +	.probe	 = warp_led_probe,
> +	.remove	 = __devexit_p(warp_led_remove),
> +	.driver	 = {
> +		.name	= "warp-led",
> +	},
> +};
> +
> +static struct platform_device warp_led_device = {
> +	.name   = "warp-led",
> +	.id     = 0,
> +	.dev = {
> +		.release = warp_led_release,
> +	},
> +};
> +
> +static int __init warp_led_init(void)
> +{
> +	int rc;
> +
> +	rc = platform_device_register(&warp_led_device);
> +	if (rc)
> +		return rc;
> +	rc = platform_driver_register(&warp_led_driver);
> +	if (rc) {
> +		platform_device_unregister(&warp_led_device);
> +		return rc;
> +	}
> +
> +	return 0;
> +}
> +
> +static void __exit warp_led_exit(void)
> +{
> +	platform_driver_unregister(&warp_led_driver);
> +	platform_device_unregister(&warp_led_device);
> +}
> +
> +module_init(warp_led_init);
> +module_exit(warp_led_exit);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Sean MacLennan <smaclennan@pikatech.com>");
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
