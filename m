Return-Path: <cbouatmailru@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.171])
	by ozlabs.org (Postfix) with ESMTP id 861EADDEE3
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Feb 2008 10:51:59 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id q7so1032004uge.0
	for <linuxppc-dev@ozlabs.org>; Sun, 03 Feb 2008 15:51:05 -0800 (PST)
Date: Mon, 4 Feb 2008 02:32:20 +0300
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 04/11] [RFC][GPIOLIB] add gpio_set_dedicated() routine
Message-ID: <20080203233220.GA20105@zarina>
References: <20080203170820.GA18520@localhost.localdomain>
	<20080203171006.GD28024@localhost.localdomain>
	<200802031322.08600.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <200802031322.08600.david-b@pacbell.net>
Cc: linuxppc-dev@ozlabs.org
Reply-To: cbouatmailru@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Feb 03, 2008 at 01:22:08PM -0800, David Brownell wrote:
[...]
> >   One of the biggest things these conventions omit is pin multiplexing,
> >   since this is highly chip-specific and nonportable.
> > 
> > Let me counter: "chip-specific" is a weak argument, IMO.
> 
> Then focus on "nonportable concepts" instead.  :)
> 
> 
> Note that "pin" != "GPIO".  There are platforms that let one GPIO
> be routed to any of several pins/balls; and let a given pin/ball
> be multiplexed to support any of several GPIOs.  (Annoying because
> it's so error prone, but true.  I'll call that the "OMAP1" pinmux
> issue, since that's where I first ran into it.)
> 
> Likewise, not all pins with multiplexed functionality include GPIO
> as one of those functions.
> 
> So when you assume that a GPIO number can uniquely specify a pin for
> use in function multiplexing ... you're stressing a "nonportable"
> aspect of this issue.
> 
> Ditto when you assume that the multiplexing is on a per-pin basis,
> rather than affecting a defined group of pins.  (More common, and
> less annoying, than the OMAP1 issue.)
> 
> (And that doesn't even touch issues like configurable drive strength,
> pullups, pulldowns, and so on.)

This is all true, of course.

> 
> > Imagine some 
> > GPIO controller that can't do inputs, or outputs. First one will be
> > still suitable for gpio_leds, second one will be suitable for gpio_keys.
> 
> The interface easily handles input-only and output-only GPIOs.
> Make the relevant gpio_direction_*() methods fail those requests.

The point was: GPIOs could be "input only" but you still have
"output" callback, and that doesn't troubles anybody. Not sure
why set_dedicated() such a big issue then, it could fail too! :-)

We're talking about General Purpose IOs, right? They're general
enough to support not only input/output stuff. And we want some
API for these General Purpose IOs. GPIO LIB is the best candidate
and we can implement such API at almost no cost, few lines of code.

> > Or... gpio_to_irq/irq_to_gpio. More than chip-specific, isn't it?
> > Some GPIO controllers might provide interrupt sources, some might
> > not.
> 
> Right now there isn't a generic hookup between GPIOs and IRQs;
> that's all very platform-specific.  For example, maybe it doesn't
> use the genirq framework ... and even if it does, there's a huge
> hole where "removing irq_chip and its irqs" fits.
> 
> It's easy enough for most platforms to arrange that a particular
> range of GPIO numbers maps to a particular set of IRQ numbers
> through the IRQ chaining mechanism.

He-he. Actually, I have a patch that adds "to_irq" callback
to GPIO LIB. :-) But I just didn't find time yet to cleanup
the "user" of that addition (ARM-based "samcop" companion chip).

Briefly: gpio<->irq mapping there isn't "flat". It is messed
all around. GPIO 1 is IRQ 12, GPIO 2 if IRQ 45 and so on... no
common pattern. So, to support gpio_to_irq() we have to either:

1. change the mappings of the IRQs, to match GPIOs.
or
2. implement to_irq() callback (way easier).

> > Or let's put it completely different way: IRQs, they are
> > chip specific too, some of them can't do EDGE_FALLING or
> > EDGE_RISING. But these flags still exists for the IRQs,
> > and drivers use them.
> 
> Sure; though as a rule, any driver that specifies trigger modes
> is platform-specific when it does so.  Plus, very few would know
> what to do when they learn that the EDGE_FALLING mode they asked
> for is not supported by the underlying hardware.

Exactly. The question is how much "platforms" that driver could
support. When driver that using EDGE_* works for >= 2 platforms,
then this flag is worthwhile already.

> > The same for GPIO pin multiplexing: some drivers aren't aware of
> > GPIO multiplexing, but some are.
> 
> And if they are aware, that's platform-specific code.  So there can
> be no issue in requiring use of platform-specific calls for that.
> 
> Example, when a given function can come out on either of two pins
> (like MMC0.CMD on some chips), and those pins vary between models
> of that SOC family ... the driver will either know highly nonportable
> details about each chip,

No. Driver don't have to know chip details. _Platform code_ is passing
these details to the driver (via platform data or OF device tree
properties). Then driver is using these details absolutely blindly,
without knowing their meaning.

> or will punt to external code that needs to
> accommodate both board-specific wiring choices and chip-specific
> differences in ballout.  (In fact, that particular situation is
> mostly handled by board-specific setup code, not a driver.)

The point is that driver needs non-static GPIO configuration.
In some cases you can't just configure gpio's dedicated functions
at the start-up and use it for the whole driver's lifecycle. Driver
wants to switch between "pin as GPIO" and "pin as dedicated function".

I think GPIO LIB should provide this ability to do so. See below
though.

>  > So, down below is the proposal patch: gpio_set_dedicated() routine.
> > 
> > There are other options, tough. But I don't like them:
> > 
> > ...
> > 
> > - Another option?
> 
> The way it's usually done:  platform-specific code to handle those
> platform-specific pin configuration issues.

There is a problem. Driver could be cross-platform. For example,
we have platforms with "CPM1", "CPM2" and "QE" on-chip gpio
controllers.

One kernel could run on all these platforms (well, not now, but
there are some plans). Mostly, they share drivers (well, actually no,
but there are some plans :-), i.e. differences between CPM and QE
peripherals usually minor enough to write a driver which is able to
work on both.

At the same time, difference between CPM and QE gpio controllers
are drastic, so we can't use "qe_set_dedicated" for both (assuming
that we don't want "if (is_qe) ... else ..." scheme).

So, imagine driver X which is doing:

qe_set_dedicated(pin);

It will be tied to the "QE" platform. But if we'll do

gpio_set_dedicated(pin);

Then underlaying gpio controller would handle that call,
be it CPM or QE. See? GPIO LIB is a simple dispatcher.

And despite special _set_dedicated() function, this driver
actually does _use_ pins as GPIOs. And as dedicated functions.
And as GPIOs. The same pins, but at the different times.


Okay. FHCI is probably not the case of the cross-platform driver,
so for now we can forget about cross-platform usage. Ok, let's
imagine I'll not use GPIO LIB for these "special" pins. But there
are other pins, usual GPIOs. So, to use gpio api and some special
qe_set_dedicated() we want them to play nicely with each other,
locking e.t.c. Will you agree to export "chips" so we can write
GPIO LIB "platform extensions", like

qe_set_dedicated(unsigned int value_that_we_got_from_gpio_request)
{
	qe_chip = container_of(gpio_to_chip(...), struct qe_chip, chip);
	spin_lock_irqsave(&qe_chip->lock, flags);
	...do qe-specific work...
}

?

> > +int gpio_set_dedicated(unsigned gpio, int func)
> 
> It's not required that a pin/ball identifier have a one-to-one mapping
> to "gpio" numbers, or that all pins/balls have "gpio" as one of the
> possible functions.  So if there were a cross-platform call like this,
> I'd want to see such it reference not a "gpio" but a "pin".
> 
> And for that matter, "dedicated" is inaccurate.  It's not uncommon
> that even after setting a pin function among the N options available
> for that pin on that platform, it still be usable as a GPIO input.

Yes. But again, there are lots of cases when GPIOs are special
just as IRQs being special. And we still want to use them through
single interface: genirq, gpiolib.

> Of course, the "function" codes are extremely chip-specific ... and
> some platforms would want to include things like pullups, pulldowns,
> and so forth as part of pin configuration.
> 
> If you want to pursue this problem, don't couple it to GPIOs.

Um... couple it to what then?..


Thanks,

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
