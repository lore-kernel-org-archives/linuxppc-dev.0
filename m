Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 7A1CADDE0A
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Sep 2008 09:30:00 +1000 (EST)
Date: Thu, 25 Sep 2008 03:29:56 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 2/4] powerpc/qe: new call to revert a gpio to a
	dedicated function
Message-ID: <20080924232956.GA27533@oksana.dev.rtsoft.ru>
References: <20080924000255.GA28054@oksana.dev.rtsoft.ru>
	<20080924000336.GB29733@oksana.dev.rtsoft.ru>
	<200809241154.25722.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <200809241154.25722.david-b@pacbell.net>
Cc: Greg Kroah-Hartman <greg@kroah.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Li Yang <leoli@freescale.com>, Timur Tabi <timur@freescale.com>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Sep 24, 2008 at 11:54:24AM -0700, David Brownell wrote:
[...]
> You'd be better off calling something other than of_get_gpio()
> for those three pins in of_fhci_probe() ... call something
> that returns a "qe_pin" structure (e.g. wrapping an instance of
> the misnamed qe_gpio_chip plus an offset) which holds the
> pinmux primitives you need.  Like this one to put the pin into
> its normal mode.

The driver anyway will have to call of_get_gpio(), because it
have to use the pins as gpios. At least it have to specify a
direction, luckily for this we have the gpio_set_direction call
already. ;-)

But true, switching a pin to a dedicated function isn't a gpio
controller's job, it is a pinmuxing.

> When I look at patch 4 of this series I observe that only
> two pins are true GPIOs:  the optional POWER and SPEED pins.
> (External transceiver support?)

Yes.

[...]
> And in turn, the reason to want this call is so that you can
> have io_port_generate_reset() generate a short reset on the
> single downstream USB port.  ("Short" meaning "45 msec below
> USB spec requirements for root hub resets" ...)
> 
> And to top it off ... that driver does gpio_request(), runs
> those pins as GPIOs for virtually no time, and then uses
> them as "dedicated functions" the rest of the time (after
> the reset completes)!!
> 
> 
> Which highlights the fact that these pins are fundamentally
> NOT used as GPIOs.

Well.. they are used as gpios anyway, to signal a reset.
This is host's duty, and we have to support it, otherwise
things won't work. There is no other way to signal a reset
than turning these *pins* to a gpio state, setting the
direction and then reverting them back to a dedicated function.

But true, most of it isn't gpio controller's authority.

[...]
> But there are other requirements for this no-kerneldoc call:
> 
> > +	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
> 
> ... it must be part of an of_mm_gpio_chip (in <linux/of_gpio.h>,
> which might seem less odd to me if I read its supporting code).
> 
> Can you first ensure that it *is* an of_mm_gpio_chip
> instance?  When it isn't, this code will oops rudely.

Yeah, unfortunately. The "oops" thought didn't visit my mind though,
because I'm still thinking it terms of this patch:

http://ozlabs.org/pipermail/linuxppc-dev/2008-February/051230.html

^^ with that patch no oops is possible, and we could detect anything
you pointed out here and below in your post. Which doesn't mean that
the patch above was ideologically correct, though.

But you clearly pointed out the issues which ruin the whole approach.


Anyway, just want to thank you for your time and persistence on this
matter, you're forcing others' people brains to *work*. And since you
rejected this approach too, I have no other option but to implement
something else... something better. ;-)

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
