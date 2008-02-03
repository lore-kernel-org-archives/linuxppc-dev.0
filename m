Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 59768DE110
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Feb 2008 04:10:17 +1100 (EST)
Date: Sun, 3 Feb 2008 20:10:06 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 04/11] [RFC][GPIOLIB] add gpio_set_dedicated() routine
Message-ID: <20080203171006.GD28024@localhost.localdomain>
References: <20080203170820.GA18520@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20080203170820.GA18520@localhost.localdomain>
Cc: David Brownell <david-b@pacbell.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This routine sets dedicated functions of the GPIO pin.

---

Hello David,

Yes, I did read Documentation/gpio.txt's last chapter. :-)

...that says:

  One of the biggest things these conventions omit is pin multiplexing,
  since this is highly chip-specific and nonportable.

Let me counter: "chip-specific" is a weak argument, IMO. Imagine some
GPIO controller that can't do inputs, or outputs. First one will be
still suitable for gpio_leds, second one will be suitable for gpio_keys.

Or... gpio_to_irq/irq_to_gpio. More than chip-specific, isn't it?
Some GPIO controllers might provide interrupt sources, some might
not.

Or let's put it completely different way: IRQs, they are
chip specific too, some of them can't do EDGE_FALLING or
EDGE_RISING. But these flags still exists for the IRQs,
and drivers use them.

The same for GPIO pin multiplexing: some drivers aren't aware of
GPIO multiplexing, but some are.

With the device tree/OpenFirmware environment it's quite easy
to pass "dedicated functions" flags to the drivers. Platform device
drivers also may accept functions via platform data (or better yet
via IORESOURCE_GPIO and its flags -- yet to be implemented, of course).

Today, there is a driver for the Freescale USB Host Controller, that
needs switching some pins to GPIOs for short period, and then back to
the dedicated functions...

So, down below is the proposal patch: gpio_set_dedicated() routine.

There are other options, tough. But I don't like them:

- Don't use GPIO API for that driver. Bad idea, this driver
  completely fits in the current GPIO use cases, except
  set_dedicated()...

- Export "gpio_chips", thus we can implement arch-specific functions.
  Bad idea, we'll smear "GPIO LIB" across the whole kernel.

- Implement gpio_chip->free() and gpio_chip->request() callbacks,
  so controllers could restore pin's functions in the ->free().

  Then drivers could do:
  gpio_request();
  gpio_direction_...();
  ...do some GPIO work...
  gpio_free(); /* and controller will restore dedicated function */

  Well, this is viable option. But expensive and it isn't good
  idea to release gpios when driver already probed (think someone
  might request it meantime). Still viable for my case, though.

  Oh, there is no way to pass "func" argument also.

- Another option?

Thanks!

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 drivers/gpio/gpiolib.c     |   13 +++++++++++++
 include/asm-generic/gpio.h |    3 +++
 2 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index d8db2f8..de6e765 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -440,6 +440,19 @@ void gpio_set_value_cansleep(unsigned gpio, int value)
 }
 EXPORT_SYMBOL_GPL(gpio_set_value_cansleep);
 
+int gpio_set_dedicated(unsigned gpio, int func)
+{
+	struct gpio_chip	*chip;
+
+	might_sleep_if(extra_checks);
+	chip = gpio_to_chip(gpio);
+	if (chip->set_dedicated)
+		return chip->set_dedicated(chip, gpio - chip->base, func);
+
+	return -ENOSYS;
+}
+EXPORT_SYMBOL_GPL(gpio_set_dedicated);
+
 
 #ifdef CONFIG_DEBUG_FS
 
diff --git a/include/asm-generic/gpio.h b/include/asm-generic/gpio.h
index 806b86c..cfbeea8 100644
--- a/include/asm-generic/gpio.h
+++ b/include/asm-generic/gpio.h
@@ -61,6 +61,8 @@ struct gpio_chip {
 						unsigned offset, int value);
 	void			(*set)(struct gpio_chip *chip,
 						unsigned offset, int value);
+	int			(*set_dedicated)(struct gpio_chip *chip,
+						unsigned offset, int func);
 	void			(*dbg_show)(struct seq_file *s,
 						struct gpio_chip *chip);
 	int			base;
@@ -88,6 +90,7 @@ extern int gpio_direction_output(unsigned gpio, int value);
 extern int gpio_get_value_cansleep(unsigned gpio);
 extern void gpio_set_value_cansleep(unsigned gpio, int value);
 
+extern int gpio_set_dedicated(unsigned gpio, int func);
 
 /* A platform's <asm/gpio.h> code may want to inline the I/O calls when
  * the GPIO is constant and refers to some always-present controller,
-- 
1.5.2.2
