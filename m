Return-Path: <dgibson@ozlabs.org>
Date: Sun, 23 Dec 2007 14:37:24 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 0/4] PowerPC: implement GPIO API
Message-ID: <20071223033724.GB10699@localhost.localdomain>
References: <20071221202824.GA4607@localhost.localdomain>
	<593200f4887c1fb73d9c9fb9b1db0b8c@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <593200f4887c1fb73d9c9fb9b1db0b8c@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Dec 23, 2007 at 03:47:50AM +0100, Segher Boessenkool wrote:
> > OF device tree GPIOs bindings are similar to IRQs:
> 
> But GPIOs are a very different thing.  Most importantly, the "number"
> of a GPIO is completely local to the GPIO controller.

Yes... just as interrupt specifiers are local to their interrupt
domain.

> > pario0: gpio-controller@0 {
> > 	#gpio-cells = <2>;
> 
> Your Linux code doesn't actually use this.  Why is it needed, anyway?
> You should be able to encode a GPIO identifier in a single 32-bit word,
> for any possible GPIO controller.
> 
> > 	num-ports = <7>;
> 
> What is this?  What is a "port"?  This doesn't belong in a generic GPIO
> binding.
> 
> > device@0 {
> > 	gpios = <bank pin bank pin bank pin>;
> > 	gpio-parent = <&pario0>;
> 
> Not every GPIO controller has banks.

That's just bad terminology in the example.  "bank pin" means an
arbitrary format gpio specifier.

> Not every device uses GPIOs
> on a single GPIO controller.  It is inconvenient to force all bindings
> to use the same name ("gpios") for its property that shows the GPIOs
> (and for it to have only one such property).
> 
> So I recommend:
> 
> -- Advise (in the generic GPIO binding) people to use
> 	< phandle-of-gpio-controller gpio-id-on-that-controller >
> to refer to a GPIO from some device node;

Ah, yes, that's a good point.  Given the ugly workarounds we need to
deal with devices which have interrupts from multiple domains, we
don't want to copy that limitation to the GPIO scheme.

> -- And either:
> 	-- Define (in the generic GPIO binding) that a "gpio-id" is a single
> 	   32-bit cell;
>     or
> 	-- Define (in the generic GPIO binding) that a "gpio-id" is a number
> 	   of 32-bit cells, and that that number of cells is encoded as a 
> 32-bit
> 	   integer in the "#gpio-cells" property in the device node of the
> 	   respective GPIO controller.

This option was the idea; the "bank pin" information has a format
local to the gpio controller.  I agree the terminology needs to change
to "gpio specifier" by analogy with the interrupt tree, though.

> (I like the first option better, unless someone can think of some 
> reasonable
> situation where some specific GPIO controller binding needs more than 
> 32 bits
> to encode GPIO #).

I can't think of a situation where it would be strictly speaking
necessary, but I can think of several where it would be more
convenient.  GPIO controllers that do have a bank/pin arrangement is
one.  GPIO controllers than have a pin number, plus some sort of
direction or level information is another.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
