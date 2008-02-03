Return-Path: <david-b@pacbell.net>
Received: from smtp118.sbc.mail.sp1.yahoo.com (smtp118.sbc.mail.sp1.yahoo.com
	[69.147.64.91]) by ozlabs.org (Postfix) with SMTP id B0F20DDEC2
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Feb 2008 08:22:12 +1100 (EST)
From: David Brownell <david-b@pacbell.net>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 04/11] [RFC][GPIOLIB] add gpio_set_dedicated() routine
Date: Sun, 3 Feb 2008 13:22:08 -0800
References: <20080203170820.GA18520@localhost.localdomain>
	<20080203171006.GD28024@localhost.localdomain>
In-Reply-To: <20080203171006.GD28024@localhost.localdomain>
MIME-Version: 1.0
Message-Id: <200802031322.08600.david-b@pacbell.net>
Content-Type: text/plain;
  charset="us-ascii"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sunday 03 February 2008, Anton Vorontsov wrote:
> This routine sets dedicated functions of the GPIO pin.
> 
> ---
> 
> Hello David,
> 
> Yes, I did read Documentation/gpio.txt's last chapter. :-)
> 
> ...that says:
> 
>   One of the biggest things these conventions omit is pin multiplexing,
>   since this is highly chip-specific and nonportable.
> 
> Let me counter: "chip-specific" is a weak argument, IMO.

Then focus on "nonportable concepts" instead.  :)


Note that "pin" != "GPIO".  There are platforms that let one GPIO
be routed to any of several pins/balls; and let a given pin/ball
be multiplexed to support any of several GPIOs.  (Annoying because
it's so error prone, but true.  I'll call that the "OMAP1" pinmux
issue, since that's where I first ran into it.)

Likewise, not all pins with multiplexed functionality include GPIO
as one of those functions.

So when you assume that a GPIO number can uniquely specify a pin for
use in function multiplexing ... you're stressing a "nonportable"
aspect of this issue.

Ditto when you assume that the multiplexing is on a per-pin basis,
rather than affecting a defined group of pins.  (More common, and
less annoying, than the OMAP1 issue.)

(And that doesn't even touch issues like configurable drive strength,
pullups, pulldowns, and so on.)


> Imagine some 
> GPIO controller that can't do inputs, or outputs. First one will be
> still suitable for gpio_leds, second one will be suitable for gpio_keys.

The interface easily handles input-only and output-only GPIOs.
Make the relevant gpio_direction_*() methods fail those requests.


> Or... gpio_to_irq/irq_to_gpio. More than chip-specific, isn't it?
> Some GPIO controllers might provide interrupt sources, some might
> not.

Right now there isn't a generic hookup between GPIOs and IRQs;
that's all very platform-specific.  For example, maybe it doesn't
use the genirq framework ... and even if it does, there's a huge
hole where "removing irq_chip and its irqs" fits.

It's easy enough for most platforms to arrange that a particular
range of GPIO numbers maps to a particular set of IRQ numbers
through the IRQ chaining mechanism.


> Or let's put it completely different way: IRQs, they are
> chip specific too, some of them can't do EDGE_FALLING or
> EDGE_RISING. But these flags still exists for the IRQs,
> and drivers use them.

Sure; though as a rule, any driver that specifies trigger modes
is platform-specific when it does so.  Plus, very few would know
what to do when they learn that the EDGE_FALLING mode they asked
for is not supported by the underlying hardware.


> The same for GPIO pin multiplexing: some drivers aren't aware of
> GPIO multiplexing, but some are.

And if they are aware, that's platform-specific code.  So there can
be no issue in requiring use of platform-specific calls for that.

Example, when a given function can come out on either of two pins
(like MMC0.CMD on some chips), and those pins vary between models
of that SOC family ... the driver will either know highly nonportable
details about each chip, or will punt to external code that needs to
accommodate both board-specific wiring choices and chip-specific
differences in ballout.  (In fact, that particular situation is
mostly handled by board-specific setup code, not a driver.)


 > So, down below is the proposal patch: gpio_set_dedicated() routine.
> 
> There are other options, tough. But I don't like them:
> 
> ...
> 
> - Another option?

The way it's usually done:  platform-specific code to handle those
platform-specific pin configuration issues.


> +int gpio_set_dedicated(unsigned gpio, int func)

It's not required that a pin/ball identifier have a one-to-one mapping
to "gpio" numbers, or that all pins/balls have "gpio" as one of the
possible functions.  So if there were a cross-platform call like this,
I'd want to see such it reference not a "gpio" but a "pin".

And for that matter, "dedicated" is inaccurate.  It's not uncommon
that even after setting a pin function among the N options available
for that pin on that platform, it still be usable as a GPIO input.

Of course, the "function" codes are extremely chip-specific ... and
some platforms would want to include things like pullups, pulldowns,
and so forth as part of pin configuration.

If you want to pursue this problem, don't couple it to GPIOs.

- Dave


> +{
> +	struct gpio_chip	*chip;
> +
> +	might_sleep_if(extra_checks);
> +	chip = gpio_to_chip(gpio);
> +	if (chip->set_dedicated)
> +		return chip->set_dedicated(chip, gpio - chip->base, func);
> +
> +	return -ENOSYS;
> +}
> +EXPORT_SYMBOL_GPL(gpio_set_dedicated);
