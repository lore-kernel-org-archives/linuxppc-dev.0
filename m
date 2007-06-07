Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-10.arcor-online.net (mail-in-10.arcor-online.net
	[151.189.21.50])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5FF8EDDEDB
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Jun 2007 22:55:37 +1000 (EST)
In-Reply-To: <1181169093.31677.260.camel@localhost.localdomain>
References: <20070604095625.GF17456@chiana.homelinux.org>
	<4E25DA41-741E-40AC-9186-936FEEFE6B29@freescale.com>
	<20070604211740.GN17456@chiana.homelinux.org>
	<C1F9584D-E778-4BE7-B11A-5505BA9B6F6C@freescale.com>
	<cbf493edec7259df199568389814dab6@kernel.crashing.org>
	<1181113438.31677.234.camel@localhost.localdomain>
	<3641c2a601dbccc9757fe9443d9330ca@kernel.crashing.org>
	<1181169093.31677.260.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <d3c57096eec4553de180adab085d0145@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: 83xx GPIO/EXT int in arch/powerpc/
Date: Thu, 7 Jun 2007 14:55:10 +0200
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>   - You can do it in your interrupt-map. That's probably the cleanest
>>> way
>>> to do it.
>>
>> Not really.  If the device interrupt is physically connected
>> directly to a GPIO or a PIC or whatever, if it doesn't go
>> through the PCI bus; then it shouldn't be represented in
>> the device tree as if it did.  The higher-up bridge has
>> nothing whatsoever to do with this device's interrupt.
>>
>> It's a simple hack of course, it can be useful sometimes.
>> It's not "clean" at all however.
>
> I disagree :-)

I think you didn't notice that I was talking about
pretending the IRQ signal of a device on PCI bus #1
being routed through PCI bus #0, the grandparent bus
of the device instead of the parent bus.  If it were
about the direct parent bus than anything could be
handled with an interrupt-map just fine, in the current
situation it is just ugly and wrong and it cannot work
in slightly more general situations, either.

> The interrupt-map simply provides for each slot where the interrupt
> goes. It's perfectly fine and clean to use it when those interrupts are
> hooked to GPIOs and has been a common practice. I really don't see a
> problem with that.

You shouldn't map interrupts from devices on your
children's busses, that's the problem.

>> Depending on the rest of the tree, this would often mean
>> you have to do a much bigger interrupt-map-mask than
>> without this hack, and the corresponding explosion in
>> interrupt-map size.
>
> Not really again. Besides, devices normally use only int#A, only 
> bridges
> use more.

Again, in the case under discussion, PCI bus# needs to
be part of the map-mask, and you can't do swizzling (or
a simple direct translation, whatever is appropriate)
for the bus-bus connection -- you have to spell out every
source deep down the domain.

> Segher, I feel here that your inability to resist arguing about
> everything in that case is confusing what is a fairly simple issue in
> the first place :-)

It isn't simple.  It is also wrong.  If a bus does
not deliver interrupts from its children to its
parent, than the device tree should not pretend it
does.

> Poor guy trying to figure out the right way to do
> his stuff will run away screaming and go back hard coding his number in
> his platform code before we are finished :-)

Heh I hope not.

> So I would say, taking a dicator hat, that the right way to fix his
> problem is also the simplest, which is to make sure the interrupt-map
> entry for that slot points to the right GPIO interrupt :-)

It's wrong and not simple.  Let me show you with some
pictures.  A device X on PCI bus P1, interrupt goes
straight to interrupt controller I.

Here's what you say is right:

P0      interrupt-map < ...reg 19000 irq IRQ -> I... >
|
P1
|
X@12    reg <19000>
         interrupt-parent <P0>
         interrupt <IRQ>

And here is my version:

P0
|
P1      interrupt-map < ... reg 9000 irq IRQ -> I ... >
|
X@12    reg <19000>
         interrupt-parent <P0>
         interrupt <IRQ>

> Easy isn't it ?

Yes, it's only hard if you're trying to avoid doing
mapping properties where they are necessary, including
stand-alone interrupt nexus nodes (not needed in this
case btw, not needed most simple cases).


Segher
