Return-Path: <david-b@pacbell.net>
Received: from smtp103.sbc.mail.mud.yahoo.com (smtp103.sbc.mail.mud.yahoo.com
	[68.142.198.202]) by ozlabs.org (Postfix) with SMTP id 68812DDF2C
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Feb 2008 15:43:23 +1100 (EST)
From: David Brownell <david-b@pacbell.net>
To: cbouatmailru@gmail.com
Subject: Re: [PATCH 04/11] [RFC][GPIOLIB] add gpio_set_dedicated() routine
Date: Thu, 14 Feb 2008 20:36:40 -0800
References: <20080203170820.GA18520@localhost.localdomain>
	<200802031322.08600.david-b@pacbell.net>
	<20080203233220.GA20105@zarina>
In-Reply-To: <20080203233220.GA20105@zarina>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200802142036.40770.david-b@pacbell.net>
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
> On Sun, Feb 03, 2008 at 01:22:08PM -0800, David Brownell wrote:
> [...]
> 
> > So when you assume that a GPIO number can uniquely specify a pin for
> > use in function multiplexing ... you're stressing a "nonportable"
> > aspect of this issue.
> > 
> > Ditto when you assume that the multiplexing is on a per-pin basis,
> > rather than affecting a defined group of pins.  (More common, and
> > less annoying, than the OMAP1 issue.)
> > 
> > (And that doesn't even touch issues like configurable drive strength,
> > pullups, pulldowns, and so on.)
> 
> This is all true, of course.

And a related truism:  with at best rare exceptions, those things
get set up once at board setup and don't change later.  So the
audience for reconfiguring pins is quite limited ... basically
it'd all be for code which is already hardware-specific.

That's much less true of GPIOs.  It really *is* practical to have
generic GPIO based drivers for LEDs, keypad buttons, bitbanged
I2C, 1-wire, SPI ... etc.


> > > Imagine some 
> > > GPIO controller that can't do inputs, or outputs. First one will be
> > > still suitable for gpio_leds, second one will be suitable for gpio_keys.
> > 
> > The interface easily handles input-only and output-only GPIOs.
> > Make the relevant gpio_direction_*() methods fail those requests.
> 
> The point was: GPIOs could be "input only" but you still have
> "output" callback, and that doesn't troubles anybody. Not sure
> why set_dedicated() such a big issue then, it could fail too! :-)

See above:  you're equating pin and gpio ... and while GPIOs
have (by definition) standardized boolean input and output
functionality, the rest of what can be done with a pin isn't.


> We're talking about General Purpose IOs, right? They're general
> enough to support not only input/output stuff. And we want some
> API for these General Purpose IOs. GPIO LIB is the best candidate
> and we can implement such API at almost no cost, few lines of code.

GPIOs are not intended to be a kitchen sink though; and that's
the sense in which you seem to mean "best candidate":  it's a
clean lightweight interface, not gummed up with all kinds of
unrelated stuff.


Take your ideas and use them to create a pin configuration
interface.  On some platforms, configurable pins will map
onto GPIOs, one-to-one.  On others, there will be configurable
pins that aren't GPIOs ... GPIOs that can be mapped to any of
several pins ... pins that can be used with several GPIOs ...
pins that can only be used with GPIOs ... and so on.


> He-he. Actually, I have a patch that adds "to_irq" callback
> to GPIO LIB. :-) But I just didn't find time yet to cleanup
> the "user" of that addition (ARM-based "samcop" companion chip).
> 
> Briefly: gpio<->irq mapping there isn't "flat". It is messed
> all around. GPIO 1 is IRQ 12, GPIO 2 if IRQ 45 and so on... no
> common pattern. So, to support gpio_to_irq() we have to either:
> 
> 1. change the mappings of the IRQs, to match GPIOs.
> or
> 2. implement to_irq() callback (way easier).

That seems like maybe a reasonable thing to add to gpiolib.
It's fully within the current scope of the GPIO interface.
Show it when you've got a cleaned up version...

And although the original notion was that those mappings
cost on the order of an addition, I think that's not a big
deal ... except maybe sometimes for irq_to_gpio().


> >  > So, down below is the proposal patch: gpio_set_dedicated() routine.
> > > 
> > > There are other options, tough. But I don't like them:
> > > 
> > > ...
> > > 
> > > - Another option?
> > 
> > The way it's usually done:  platform-specific code to handle those
> > platform-specific pin configuration issues.
> 
> There is a problem. Driver could be cross-platform. For example,
> we have platforms with "CPM1", "CPM2" and "QE" on-chip gpio
> controllers.

So "platform" isn't exactly the right word.  "Hardware-specific"
is more to the point.  You know you're using <Brand-X-SOC-27> and
that means you must reconfigure <this-way> because <reason>; or
likewise, <Vendor-Y-ASIC-2> must be reconfigured <that-way> etc.


> And despite special _set_dedicated() function, this driver
> actually does _use_ pins as GPIOs. And as dedicated functions.
> And as GPIOs. The same pins, but at the different times.

But you're assuming that GPIO identifiers can be used as pin/ball
identifiers ... and as I pointed out, that's chip-specific.



> 	Will you agree to export "chips" so we can write
> GPIO LIB "platform extensions", like
> 
> qe_set_dedicated(unsigned int value_that_we_got_from_gpio_request)

gpio_request() returns zero-or-negative-errno.  Never unsigned int.  ;)


> {
> 	qe_chip = container_of(gpio_to_chip(...), struct qe_chip, chip);
> 	...

You know, you can write all this yourself, without needing any
support from the GPIO framework whatsoever.  The QE stuff that
registered a gpio_chip interface to its hardware probably keeps
some records itself, sufficient for such (infrequent) mappings.


> > > +int gpio_set_dedicated(unsigned gpio, int func)
> > 
> > It's not required that a pin/ball identifier have a one-to-one mapping
> > to "gpio" numbers, or that all pins/balls have "gpio" as one of the
> > possible functions.  So if there were a cross-platform call like this,
> > I'd want to see such it reference not a "gpio" but a "pin".
> > 
> > And for that matter, "dedicated" is inaccurate.
>
>	... deletia ...
> 
> > Of course, the "function" codes are extremely chip-specific ... and
> > some platforms would want to include things like pullups, pulldowns,
> > and so forth as part of pin configuration.
> > 
> > If you want to pursue this problem, don't couple it to GPIOs.
> 
> Um... couple it to what then?..

An abstraction of "pin", where pins don't correspond to GPIOs in a
one-to-one manner.

- dave
