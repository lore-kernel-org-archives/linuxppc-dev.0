Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 45D23DDDF8
	for <linuxppc-dev@ozlabs.org>; Sun, 23 Dec 2007 13:47:59 +1100 (EST)
In-Reply-To: <20071221202824.GA4607@localhost.localdomain>
References: <20071221202824.GA4607@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <593200f4887c1fb73d9c9fb9b1db0b8c@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 0/4] PowerPC: implement GPIO API
Date: Sun, 23 Dec 2007 03:47:50 +0100
To: avorontsov@ru.mvista.com
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> OF device tree GPIOs bindings are similar to IRQs:

But GPIOs are a very different thing.  Most importantly, the "number"
of a GPIO is completely local to the GPIO controller.

> pario0: gpio-controller@0 {
> 	#gpio-cells = <2>;

Your Linux code doesn't actually use this.  Why is it needed, anyway?
You should be able to encode a GPIO identifier in a single 32-bit word,
for any possible GPIO controller.

> 	num-ports = <7>;

What is this?  What is a "port"?  This doesn't belong in a generic GPIO
binding.

> device@0 {
> 	gpios = <bank pin bank pin bank pin>;
> 	gpio-parent = <&pario0>;

Not every GPIO controller has banks.  Not every device uses GPIOs
on a single GPIO controller.  It is inconvenient to force all bindings
to use the same name ("gpios") for its property that shows the GPIOs
(and for it to have only one such property).

So I recommend:

-- Advise (in the generic GPIO binding) people to use
	< phandle-of-gpio-controller gpio-id-on-that-controller >
to refer to a GPIO from some device node;

-- And either:
	-- Define (in the generic GPIO binding) that a "gpio-id" is a single
	   32-bit cell;
    or
	-- Define (in the generic GPIO binding) that a "gpio-id" is a number
	   of 32-bit cells, and that that number of cells is encoded as a 
32-bit
	   integer in the "#gpio-cells" property in the device node of the
	   respective GPIO controller.

(I like the first option better, unless someone can think of some 
reasonable
situation where some specific GPIO controller binding needs more than 
32 bits
to encode GPIO #).


Segher
