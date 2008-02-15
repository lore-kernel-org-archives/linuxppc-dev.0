Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 40687DDF04
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Feb 2008 22:40:31 +1100 (EST)
Date: Fri, 15 Feb 2008 14:40:29 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 04/11] [RFC][GPIOLIB] add gpio_set_dedicated() routine
Message-ID: <20080215114029.GA16810@localhost.localdomain>
References: <20080203170820.GA18520@localhost.localdomain>
	<200802031322.08600.david-b@pacbell.net>
	<20080203233220.GA20105@zarina>
	<200802142036.40770.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <200802142036.40770.david-b@pacbell.net>
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

On Thu, Feb 14, 2008 at 08:36:40PM -0800, David Brownell wrote:
[...]
> > The point was: GPIOs could be "input only" but you still have
> > "output" callback, and that doesn't troubles anybody. Not sure
> > why set_dedicated() such a big issue then, it could fail too! :-)
> 
> See above:  you're equating pin and gpio ... and while GPIOs
> have (by definition) standardized boolean input and output
> functionality, the rest of what can be done with a pin isn't.

There is nothing much left to do with a "pin", IMO. Pin can be GPIO
or abstract "dedicated function". Am I missing anything else here?

> > We're talking about General Purpose IOs, right? They're general
> > enough to support not only input/output stuff. And we want some
> > API for these General Purpose IOs. GPIO LIB is the best candidate
> > and we can implement such API at almost no cost, few lines of code.
> 
> GPIOs are not intended to be a kitchen sink though; and that's
> the sense in which you seem to mean "best candidate":  it's a
> clean lightweight interface, not gummed up with all kinds of
> unrelated stuff.

Just one more callback won't bloat lightweight interface...  Later
I'll ask to add another one, and someone will ask for another. Yes, I
see the pattern. Surely, if you want to keep it clean and lightweight,
you should resist to additions -- I fully understand that. :-)

> Take your ideas and use them to create a pin configuration
> interface.  On some platforms, configurable pins will map
> onto GPIOs, one-to-one.  On others, there will be configurable
> pins that aren't GPIOs ... GPIOs that can be mapped to any of
> several pins ... pins that can be used with several GPIOs ...
> pins that can only be used with GPIOs ... and so on.

Sure, that's doable. But IMO this idea is about overcomplicating
the trivial task. Let's call it pinlib, with:

1. pin_request
2. pin_configure(pin, integer-representing-configuration)
3. pin_free

Hm... 2 auxiliary functions with the full-fledged subsystem just to
configure some pins? Plus count here that drivers would have to deal
with the two separate subsystems. Both GPIO/Pin-providers and
drivers that would use these GPIOs/Pins.

> > > The way it's usually done:  platform-specific code to handle those
> > > platform-specific pin configuration issues.
> > 
> > There is a problem. Driver could be cross-platform. For example,
> > we have platforms with "CPM1", "CPM2" and "QE" on-chip gpio
> > controllers.
> 
> So "platform" isn't exactly the right word.  "Hardware-specific"
> is more to the point.  You know you're using <Brand-X-SOC-27> and
> that means you must reconfigure <this-way> because <reason>; or
> likewise, <Vendor-Y-ASIC-2> must be reconfigured <that-way> etc.

<this-way> or <that-way> is passed through platform data,
platform code knowns "hardware-specific" details.

> > And despite special _set_dedicated() function, this driver
> > actually does _use_ pins as GPIOs. And as dedicated functions.
> > And as GPIOs. The same pins, but at the different times.
> 
> But you're assuming that GPIO identifiers can be used as pin/ball
> identifiers ... and as I pointed out, that's chip-specific.

Heh. I did re-read Documentation/gpio.txt once again, and still don't
get it, where are the differences between GPIOs and Pins? Yes, some
pins can't be GPIOs, but any GPIO must have associated Pin (internal
or external doesn't matter, it's "logical Pin").

For pins that can not be "GPIOs", we can just return errors from
output/input callbacks. Is it violation of the current GPIO API
conventions? Yes, but this is extension that will not break anything,
neither we contradict the "GPIO" term here, btw.

> > {
> > 	qe_chip = container_of(gpio_to_chip(...), struct qe_chip, chip);
> > 	...
> 
> You know, you can write all this yourself, without needing any
> support from the GPIO framework whatsoever.  The QE stuff that
> registered a gpio_chip interface to its hardware probably keeps
> some records itself, sufficient for such (infrequent) mappings.

Yes, surely. And as I've said already, I do know how to workaround
that, without GPIOLIB support. The thing is that I don't like the
way I'm going to do it.

[...]
> > > Of course, the "function" codes are extremely chip-specific ... and
> > > some platforms would want to include things like pullups, pulldowns,
> > > and so forth as part of pin configuration.
> > > 
> > > If you want to pursue this problem, don't couple it to GPIOs.
> > 
> > Um... couple it to what then?..
> 
> An abstraction of "pin", where pins don't correspond to GPIOs in a
> one-to-one manner.

Keeping in mind that GPIOLIB was brewing a year (?), I think another
GPIOLIB-alike subsystem not worth powder and shot, pins and GPIOs
will be obsolete at that time. :-)


Thanks,

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
