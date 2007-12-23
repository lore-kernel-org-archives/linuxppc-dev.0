Return-Path: <cbouatmailru@gmail.com>
Received: from fk-out-0910.google.com (fk-out-0910.google.com [209.85.128.185])
	by ozlabs.org (Postfix) with ESMTP id 7A1F4DDDF2
	for <linuxppc-dev@ozlabs.org>; Sun, 23 Dec 2007 22:58:59 +1100 (EST)
Received: by fk-out-0910.google.com with SMTP id z22so1710698fkz.9
	for <linuxppc-dev@ozlabs.org>; Sun, 23 Dec 2007 03:58:58 -0800 (PST)
Date: Sun, 23 Dec 2007 14:47:59 +0300
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 0/4] PowerPC: implement GPIO API
Message-ID: <20071223114759.GA5643@zarina>
References: <20071221202824.GA4607@localhost.localdomain>
	<593200f4887c1fb73d9c9fb9b1db0b8c@kernel.crashing.org>
	<20071223033724.GB10699@localhost.localdomain>
	<77aab6d2233de8687320e1827ff695c2@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <77aab6d2233de8687320e1827ff695c2@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
Reply-To: cbouatmailru@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Dec 23, 2007 at 10:53:05AM +0100, Segher Boessenkool wrote:
[...]
> >>> device@0 {
> >>> 	gpios = <bank pin bank pin bank pin>;
> >>> 	gpio-parent = <&pario0>;
> >>
> >> Not every GPIO controller has banks.
> >
> > That's just bad terminology in the example.  "bank pin" means an
> > arbitrary format gpio specifier.
> 
> Okay.  Don't split it into two things then, just say "gpio-spec"
> or such.

Will do. "bank pin" was just an example of QE/CPMs gpio specifiers, they
could be arbitrary in general.

> >> Not every device uses GPIOs
> >> on a single GPIO controller.  It is inconvenient to force all bindings
> >> to use the same name ("gpios") for its property that shows the GPIOs
> >> (and for it to have only one such property).
> >>
> >> So I recommend:
> >>
> >> -- Advise (in the generic GPIO binding) people to use
> >> 	< phandle-of-gpio-controller gpio-id-on-that-controller >
> >> to refer to a GPIO from some device node;
> >
> > Ah, yes, that's a good point.  Given the ugly workarounds we need to
> > deal with devices which have interrupts from multiple domains, we
> > don't want to copy that limitation to the GPIO scheme.
> 
> Yeah, and we even know for a fact that devices exist that do GPIOs
> on multiple GPIO controllers.  In the interrupt case, no one thought
> anyone would be crazy enough to route their IRQs like that :-)

Oh, <&gpio-controller-phandle gpio-spec> is indeed better
scheme. Well, parsing it would be a bit more complicated, as gpio-spec
is variable length: next placement of phandle depends on previous
gpio-specs... But this is doable of course.

> >> 	-- Define (in the generic GPIO binding) that a "gpio-id" is a number
> >> 	   of 32-bit cells, and that that number of cells is encoded as a
> >> 32-bit
> >> 	   integer in the "#gpio-cells" property in the device node of the
> >> 	   respective GPIO controller.
> >
> > This option was the idea; the "bank pin" information has a format
> > local to the gpio controller.  I agree the terminology needs to change
> > to "gpio specifier" by analogy with the interrupt tree, though.
> 
> Right, with that cleared up, and the binding doc expanded a bit,
> you won't hear complaints from me :-)

Ok, I should write documentation indeed. ;-)

> >> (I like the first option better, unless someone can think of some
> >> reasonable
> >> situation where some specific GPIO controller binding needs more than
> >> 32 bits
> >> to encode GPIO #).
> >
> > I can't think of a situation where it would be strictly speaking
> > necessary, but I can think of several where it would be more
> > convenient.  GPIO controllers that do have a bank/pin arrangement is
> > one.  GPIO controllers than have a pin number, plus some sort of
> > direction or level information is another.
> 
> Ah yes, a second word for pin "type" information makes a lot of sense.
> #gpio-cells it is, then.  Let's please make sure that we put that "type"
> thing in the documentation (as an example), and that the first 
> controller
> bindings we put in use it.

There is no limitation to define gpio direction in the gpio-spec, but
the thing is: we're passing gpios to the drivers which are already
know in what direction gpio should be set up, and we have an API to
set up GPIOs.

Example: fsl_nand, we're passing gpio, and driver is doing
gpio_direction_output() call on it. So we don't have to pass
gpio direction information in the gpio specifier.

As for level, yes this is important information, and encoding it
into gpio-spec seems reasonable (in fsl_nand example, ready-not-busy
(rnb) gpio. GPIO could be wired to be !rnb or just rnb).


Thanks!

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
