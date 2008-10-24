Return-Path: <tpiepho@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BE2F3474C1
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Oct 2008 10:09:17 +1100 (EST)
From: Trent Piepho <tpiepho@freescale.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] leds: Add option to have GPIO LEDs start on
Date: Fri, 24 Oct 2008 16:09:00 -0700
Message-Id: <1224889741-4167-3-git-send-email-tpiepho@freescale.com>
In-Reply-To: <Pine.LNX.4.64.0810241442240.3790@t2.domain.actdsltmp>
References: <Pine.LNX.4.64.0810241442240.3790@t2.domain.actdsltmp>
Cc: linuxppc-dev@ozlabs.org, Richard Purdie <rpurdie@rpsys.net>,
	Sean MacLennan <smaclennan@pikatech.com>,
	Trent Piepho <tpiepho@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Yes, there is the "default-on" trigger but there are problems with that.

For one, it's a inefficient way to do it and requires led trigger support
to be compiled in.

But the real reason is that is produces a glitch on the LED.  The GPIO is
allocate with the LED *off*, then *later* when then trigger runs it is
turned back on.  If the LED was already on via the GPIO's reset default or
action of the firmware, this produces a glitch where the LED goes from on
to off to on.  While normally this is fast enough that it wouldn't be
noticeable to a human observer, there are still serious problems.

One is that there may be something else on the GPIO line, like a hardware
alarm or watchdog, that is fast enough to notice the glitch.

Another is that the kernel may panic before the LED is turned back on, thus
hanging with the LED in the wrong state.  This is not just speculation, but
actually happened to me with an embedded system that has an LED which
should turn off when the kernel finishes booting, which was left in the
incorrect state due to a bug in the OF LED binding code.

The platform device binding gains a field in the platform data "default_state"
that controls this.  The OpenFirmware binding uses a property named
"default-state" that can be set to "on" or "off".  The default the property
isn't present is off.

Signed-off-by: Trent Piepho <tpiepho@freescale.com>
---
 Documentation/powerpc/dts-bindings/gpio/led.txt |    7 +++++++
 drivers/leds/leds-gpio.c                        |    8 ++++++--
 include/linux/leds.h                            |    1 +
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/Documentation/powerpc/dts-bindings/gpio/led.txt b/Documentation/powerpc/dts-bindings/gpio/led.txt
index 9f969c2..544ded7 100644
--- a/Documentation/powerpc/dts-bindings/gpio/led.txt
+++ b/Documentation/powerpc/dts-bindings/gpio/led.txt
@@ -20,6 +20,11 @@ LED sub-node properties:
     "heartbeat" - LED "double" flashes at a load average based rate
     "ide-disk" - LED indicates disk activity
     "timer" - LED flashes at a fixed, configurable rate
+- default-state:  (optional) The initial state of the LED.  Valid
+  values are "on" and "off".  If the LED is already on or off and the
+  default-state property is set the to same value, then no glitch
+  should be produced where the LED momentarily turns off (or on).
+  The default is off if this property is not present.
 
 Examples:
 
@@ -36,8 +41,10 @@ run-control {
 	compatible = "gpio-leds";
 	red {
 		gpios = <&mpc8572 6 0>;
+		default-state = "off";
 	};
 	green {
 		gpios = <&mpc8572 7 0>;
+		default-state = "on";
 	};
 }
diff --git a/drivers/leds/leds-gpio.c b/drivers/leds/leds-gpio.c
index f41b841..0dbad87 100644
--- a/drivers/leds/leds-gpio.c
+++ b/drivers/leds/leds-gpio.c
@@ -92,9 +92,10 @@ static int __devinit create_gpio_led(const struct gpio_led *template,
 		led_dat->cdev.blink_set = gpio_blink_set;
 	}
 	led_dat->cdev.brightness_set = gpio_led_set;
-	led_dat->cdev.brightness = LED_OFF;
+	led_dat->cdev.brightness = template->default_state ? LED_FULL : LED_OFF;
 
-	gpio_direction_output(led_dat->gpio, led_dat->active_low);
+	gpio_direction_output(led_dat->gpio,
+	                      led_dat->active_low ^ template->default_state);
 
 	INIT_WORK(&led_dat->work, gpio_led_work);
 
@@ -256,12 +257,15 @@ static int __devinit of_gpio_leds_probe(struct of_device *ofdev,
 	memset(&led, 0, sizeof(led));
 	for_each_child_of_node(np, child) {
 		unsigned int flags;
+		const char *state;
 
 		led.gpio = of_get_gpio(child, 0, &flags);
 		led.active_low = flags & OF_GPIO_ACTIVE_LOW;
 		led.name = of_get_property(child, "label", NULL) ? : child->name;
 		led.default_trigger =
 			of_get_property(child, "linux,default-trigger", NULL);
+		state = of_get_property(child, "default-state", NULL);
+		led.default_state = state && !strcmp(state, "on");
 
 		ret = create_gpio_led(&led, &pdata->led_data[pdata->num_leds++],
 				      &ofdev->dev, NULL);
diff --git a/include/linux/leds.h b/include/linux/leds.h
index d3a73f5..caa3987 100644
--- a/include/linux/leds.h
+++ b/include/linux/leds.h
@@ -138,6 +138,7 @@ struct gpio_led {
 	const char *default_trigger;
 	unsigned 	gpio;
 	u8 		active_low;
+	u8		default_state;
 };
 
 struct gpio_led_platform_data {
-- 
1.5.4.3
