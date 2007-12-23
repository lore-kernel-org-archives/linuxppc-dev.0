Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <20071223033724.GB10699@localhost.localdomain>
References: <20071221202824.GA4607@localhost.localdomain>
	<593200f4887c1fb73d9c9fb9b1db0b8c@kernel.crashing.org>
	<20071223033724.GB10699@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <77aab6d2233de8687320e1827ff695c2@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 0/4] PowerPC: implement GPIO API
Date: Sun, 23 Dec 2007 10:53:05 +0100
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> OF device tree GPIOs bindings are similar to IRQs:
>>
>> But GPIOs are a very different thing.  Most importantly, the "number"
>> of a GPIO is completely local to the GPIO controller.
>
> Yes... just as interrupt specifiers are local to their interrupt
> domain.

Sure, but an interrupt domain can be (and usually is) more than
one device node.  A GPIO controller is just one node.

>>> device@0 {
>>> 	gpios = <bank pin bank pin bank pin>;
>>> 	gpio-parent = <&pario0>;
>>
>> Not every GPIO controller has banks.
>
> That's just bad terminology in the example.  "bank pin" means an
> arbitrary format gpio specifier.

Okay.  Don't split it into two things then, just say "gpio-spec"
or such.

>> Not every device uses GPIOs
>> on a single GPIO controller.  It is inconvenient to force all bindings
>> to use the same name ("gpios") for its property that shows the GPIOs
>> (and for it to have only one such property).
>>
>> So I recommend:
>>
>> -- Advise (in the generic GPIO binding) people to use
>> 	< phandle-of-gpio-controller gpio-id-on-that-controller >
>> to refer to a GPIO from some device node;
>
> Ah, yes, that's a good point.  Given the ugly workarounds we need to
> deal with devices which have interrupts from multiple domains, we
> don't want to copy that limitation to the GPIO scheme.

Yeah, and we even know for a fact that devices exist that do GPIOs
on multiple GPIO controllers.  In the interrupt case, no one thought
anyone would be crazy enough to route their IRQs like that :-)

>> 	-- Define (in the generic GPIO binding) that a "gpio-id" is a number
>> 	   of 32-bit cells, and that that number of cells is encoded as a
>> 32-bit
>> 	   integer in the "#gpio-cells" property in the device node of the
>> 	   respective GPIO controller.
>
> This option was the idea; the "bank pin" information has a format
> local to the gpio controller.  I agree the terminology needs to change
> to "gpio specifier" by analogy with the interrupt tree, though.

Right, with that cleared up, and the binding doc expanded a bit,
you won't hear complaints from me :-)

>> (I like the first option better, unless someone can think of some
>> reasonable
>> situation where some specific GPIO controller binding needs more than
>> 32 bits
>> to encode GPIO #).
>
> I can't think of a situation where it would be strictly speaking
> necessary, but I can think of several where it would be more
> convenient.  GPIO controllers that do have a bank/pin arrangement is
> one.  GPIO controllers than have a pin number, plus some sort of
> direction or level information is another.

Ah yes, a second word for pin "type" information makes a lot of sense.
#gpio-cells it is, then.  Let's please make sure that we put that "type"
thing in the documentation (as an example), and that the first 
controller
bindings we put in use it.


Segher
