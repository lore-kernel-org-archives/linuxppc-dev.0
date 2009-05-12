Return-Path: <xyzzy@speakeasy.org>
Received: from mail3.sea5.speakeasy.net (mail3.sea5.speakeasy.net
	[69.17.117.5])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.speakeasy.net", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 64BECDDFAE
	for <linuxppc-dev@ozlabs.org>; Wed, 13 May 2009 08:33:26 +1000 (EST)
Received: from 71-36-41-54.tukw.qwest.net (HELO localhost.localdomain)
	(xyzzy@[71.36.41.54]) (envelope-sender <xyzzy@speakeasy.org>)
	by mail3.sea5.speakeasy.net (qmail-ldap-1.03) with SMTP
	for <linuxppc-dev@ozlabs.org>; 12 May 2009 22:33:21 -0000
From: Trent Piepho <xyzzy@speakeasy.org>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>, Richard Purdie <rpurdie@rpsys.net>
Subject: [PATCH] leds: Add options to have GPIO LEDs start on or keep their
	state
Date: Tue, 12 May 2009 15:33:12 -0700
Message-Id: <1242167592-14649-1-git-send-email-xyzzy@speakeasy.org>
In-Reply-To: <fa686aa40904172207sc0f923eoefe8fb0a2703d548@mail.gmail.com>
References: <fa686aa40904172207sc0f923eoefe8fb0a2703d548@mail.gmail.com>
Cc: Trent Piepho <xyzzy@speakeasy.org>,
	Sean MacLennan <smaclennan@pikatech.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

There already is a "default-on" trigger but there are problems with it.

For one, it's a inefficient way to do it and requires led trigger support
to be compiled in.

But the real reason is that is produces a glitch on the LED.  The GPIO is
allocate with the LED *off*, then *later* when the trigger runs it is
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

We also let GPIO LEDs get their initial value from whatever the current
state of the GPIO line is.  On some systems the LEDs are put into some
state by the firmware or hardware before Linux boots, and it is desired to
have them keep this state which is otherwise unknown to Linux.

This requires that the underlying GPIO driver support reading the value of
output GPIOs.  Some drivers support this and some do not.

The platform device binding gains a field in the platform data
"default_state" that controls this.  There are three constants defined to
select from on, off, or keeping the current state.  The OpenFirmware
binding uses a property named "default-state" that can be set to "on",
"off", or "keep".  The default if the property isn't present is off.

Signed-off-by: Trent Piepho <xyzzy@speakeasy.org>
Acked-by: Grant Likely <grant.likely@secretlab.ca>
---
 Documentation/powerpc/dts-bindings/gpio/led.txt |   17 ++++++++++++++++-
 drivers/leds/leds-gpio.c                        |   21 ++++++++++++++++++---
 include/linux/leds.h                            |    9 +++++++--
 3 files changed, 41 insertions(+), 6 deletions(-)

diff --git a/Documentation/powerpc/dts-bindings/gpio/led.txt b/Documentation/powerpc/dts-bindings/gpio/led.txt
index 4fe14de..064db92 100644
--- a/Documentation/powerpc/dts-bindings/gpio/led.txt
+++ b/Documentation/powerpc/dts-bindings/gpio/led.txt
@@ -16,10 +16,17 @@ LED sub-node properties:
   string defining the trigger assigned to the LED.  Current triggers are:
     "backlight" - LED will act as a back-light, controlled by the framebuffer
 		  system
-    "default-on" - LED will turn on
+    "default-on" - LED will turn on, but see "default-state" below
     "heartbeat" - LED "double" flashes at a load average based rate
     "ide-disk" - LED indicates disk activity
     "timer" - LED flashes at a fixed, configurable rate
+- default-state:  (optional) The initial state of the LED.  Valid
+  values are "on", "off", and "keep".  If the LED is already on or off
+  and the default-state property is set the to same value, then no
+  glitch should be produced where the LED momentarily turns off (or
+  on).  The "keep" setting will keep the LED at whatever its current
+  state is, without producing a glitch.  The default is off if this
+  property is not present.
 
 Examples:
 
@@ -30,14 +37,22 @@ leds {
 		gpios = <&mcu_pio 0 1>; /* Active low */
 		linux,default-trigger = "ide-disk";
 	};
+
+	fault {
+		gpios = <&mcu_pio 1 0>;
+		/* Keep LED on if BIOS detected hardware fault */
+		default-state = "keep";
+	};
 };
 
 run-control {
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
index d210905..b5fd008 100644
--- a/drivers/leds/leds-gpio.c
+++ b/drivers/leds/leds-gpio.c
@@ -76,7 +76,7 @@ static int __devinit create_gpio_led(const struct gpio_led *template,
 	struct gpio_led_data *led_dat, struct device *parent,
 	int (*blink_set)(unsigned, unsigned long *, unsigned long *))
 {
-	int ret;
+	int ret, state;
 
 	/* skip leds that aren't available */
 	if (!gpio_is_valid(template->gpio)) {
@@ -99,11 +99,15 @@ static int __devinit create_gpio_led(const struct gpio_led *template,
 		led_dat->cdev.blink_set = gpio_blink_set;
 	}
 	led_dat->cdev.brightness_set = gpio_led_set;
-	led_dat->cdev.brightness = LED_OFF;
+	if (template->default_state == LEDS_GPIO_DEFSTATE_KEEP)
+		state = !!gpio_get_value(led_dat->gpio) ^ led_dat->active_low;
+	else
+		state = (template->default_state == LEDS_GPIO_DEFSTATE_ON);
+	led_dat->cdev.brightness = state ? LED_FULL : LED_OFF;
 	if (!template->retain_state_suspended)
 		led_dat->cdev.flags |= LED_CORE_SUSPENDRESUME;
 
-	ret = gpio_direction_output(led_dat->gpio, led_dat->active_low);
+	ret = gpio_direction_output(led_dat->gpio, led_dat->active_low ^ state);
 	if (ret < 0)
 		goto err;
 
@@ -223,12 +227,23 @@ static int __devinit of_gpio_leds_probe(struct of_device *ofdev,
 	memset(&led, 0, sizeof(led));
 	for_each_child_of_node(np, child) {
 		enum of_gpio_flags flags;
+		const char *state;
 
 		led.gpio = of_get_gpio_flags(child, 0, &flags);
 		led.active_low = flags & OF_GPIO_ACTIVE_LOW;
 		led.name = of_get_property(child, "label", NULL) ? : child->name;
 		led.default_trigger =
 			of_get_property(child, "linux,default-trigger", NULL);
+		state = of_get_property(child, "default-state", NULL);
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
index 376fe07..66e7d75 100644
--- a/include/linux/leds.h
+++ b/include/linux/leds.h
@@ -141,9 +141,14 @@ struct gpio_led {
 	const char *name;
 	const char *default_trigger;
 	unsigned 	gpio;
-	u8 		active_low : 1;
-	u8		retain_state_suspended : 1;
+	unsigned	active_low : 1;
+	unsigned	retain_state_suspended : 1;
+	unsigned	default_state : 2;
+	/* default_state should be one of LEDS_GPIO_DEFSTATE_(ON|OFF|KEEP) */
 };
+#define LEDS_GPIO_DEFSTATE_OFF	0
+#define LEDS_GPIO_DEFSTATE_ON	1
+#define LEDS_GPIO_DEFSTATE_KEEP	2
 
 struct gpio_led_platform_data {
 	int 		num_leds;
-- 
1.5.4.1
