Return-Path: <tpiepho@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id EC5A1DDF2B
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Dec 2008 02:41:57 +1100 (EST)
From: Trent Piepho <tpiepho@freescale.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] leds: Use tristate property in platform data
Date: Wed, 10 Dec 2008 07:41:43 -0800
Message-Id: <1228923703-16370-4-git-send-email-tpiepho@freescale.com>
In-Reply-To: <1228923703-16370-1-git-send-email-tpiepho@freescale.com>
References: <1228923703-16370-1-git-send-email-tpiepho@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Richard Purdie <rpurdie@rpsys.net>,
	Trent Piepho <tpiepho@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Replace the two boolean properties default_state and keep_state with a
single tristate property that can be set to
LEDS_GPIO_DEFSTATE_(ON|OFF|KEEP).  This ends up being more complicated,
requires more code, and makes developers remember not just the name of the
field to set but also the symbolic constant to set it to.  Yet despite
these shortcomings it remains more popular.

Signed-off-by: Trent Piepho <tpiepho@freescale.com>
---
 drivers/leds/leds-gpio.c |   15 +++++++++++----
 include/linux/leds.h     |    7 +++++--
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/leds/leds-gpio.c b/drivers/leds/leds-gpio.c
index e33cdd3..47da332 100644
--- a/drivers/leds/leds-gpio.c
+++ b/drivers/leds/leds-gpio.c
@@ -92,10 +92,10 @@ static int __devinit create_gpio_led(const struct gpio_led *template,
 		led_dat->cdev.blink_set = gpio_blink_set;
 	}
 	led_dat->cdev.brightness_set = gpio_led_set;
-	if (template->keep_state)
+	if (template->default_state == LEDS_GPIO_DEFSTATE_KEEP)
 		state = !!gpio_get_value(led_dat->gpio) ^ led_dat->active_low;
 	else
-		state = template->default_state;
+		state = (template->default_state == LEDS_GPIO_DEFSTATE_ON);
 	led_dat->cdev.brightness = state ? LED_FULL : LED_OFF;
 
 	gpio_direction_output(led_dat->gpio, led_dat->active_low ^ state);
@@ -268,8 +268,15 @@ static int __devinit of_gpio_leds_probe(struct of_device *ofdev,
 		led.default_trigger =
 			of_get_property(child, "linux,default-trigger", NULL);
 		state = of_get_property(child, "default-state", NULL);
-		led.default_state = state && !strcmp(state, "on");
-		led.keep_state = state && !strcmp(state, "keep");
+		if (state) {
+			if (!strcmp(state, "keep")) {
+				led.default_state = LEDS_GPIO_DEFSTATE_KEEP;
+			} else if(!strcmp(state, "on")) {
+				led.default_state = LEDS_GPIO_DEFSTATE_ON;
+			} else {
+				led.default_state = LEDS_GPIO_DEFSTATE_OFF;
+			}
+		}
 
 		ret = create_gpio_led(&led, &pdata->led_data[pdata->num_leds++],
 				      &ofdev->dev, NULL);
diff --git a/include/linux/leds.h b/include/linux/leds.h
index c51b625..f4a125c 100644
--- a/include/linux/leds.h
+++ b/include/linux/leds.h
@@ -138,9 +138,12 @@ struct gpio_led {
 	const char *default_trigger;
 	unsigned 	gpio;
 	u8 		active_low;
-	u8		default_state;	/* 0 = off, 1 = on */
-	u8		keep_state; /* overrides default_state */
+	u8		default_state;
+	/* default_state should be one of LEDS_GPIO_DEFSTATE_(ON|OFF|KEEP) */
 };
+#define LEDS_GPIO_DEFSTATE_OFF	0
+#define LEDS_GPIO_DEFSTATE_ON	1
+#define LEDS_GPIO_DEFSTATE_KEEP	2
 
 struct gpio_led_platform_data {
 	int 		num_leds;
-- 
1.5.4.1
