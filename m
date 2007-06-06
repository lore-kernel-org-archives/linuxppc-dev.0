Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F26FFDDEDB
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Jun 2007 08:31:43 +1000 (EST)
Subject: Re: 83xx GPIO/EXT int in arch/powerpc/
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <3641c2a601dbccc9757fe9443d9330ca@kernel.crashing.org>
References: <20070604095625.GF17456@chiana.homelinux.org>
	<4E25DA41-741E-40AC-9186-936FEEFE6B29@freescale.com>
	<20070604211740.GN17456@chiana.homelinux.org>
	<C1F9584D-E778-4BE7-B11A-5505BA9B6F6C@freescale.com>
	<cbf493edec7259df199568389814dab6@kernel.crashing.org>
	<1181113438.31677.234.camel@localhost.localdomain>
	<3641c2a601dbccc9757fe9443d9330ca@kernel.crashing.org>
Content-Type: text/plain
Date: Thu, 07 Jun 2007 08:31:33 +1000
Message-Id: <1181169093.31677.260.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-06-06 at 11:47 +0200, Segher Boessenkool wrote:
>   - You can do it in your interrupt-map. That's probably the cleanest 
> > way
> > to do it.
> 
> Not really.  If the device interrupt is physically connected
> directly to a GPIO or a PIC or whatever, if it doesn't go
> through the PCI bus; then it shouldn't be represented in
> the device tree as if it did.  The higher-up bridge has
> nothing whatsoever to do with this device's interrupt.
> 
> It's a simple hack of course, it can be useful sometimes.
> It's not "clean" at all however.

I disagree :-)

The "PCI bus" in that sense is just the INT lines. They are connected
wherever you want, doesn't matter. Look at Apple for example, they are
all connected to GPIOs too.

The interrupt-map simply provides for each slot where the interrupt
goes. It's perfectly fine and clean to use it when those interrupts are
hooked to GPIOs and has been a common practice. I really don't see a
problem with that.

> Depending on the rest of the tree, this would often mean
> you have to do a much bigger interrupt-map-mask than
> without this hack, and the corresponding explosion in
> interrupt-map size.

Not really again. Besides, devices normally use only int#A, only bridges
use more.

> Almost always that's how it works yeah.  And the "GPIO"
> stage isn't normally represented in the device tree, GPIO
> settings are considered a part of the PCB layout ;-) (one
> more reason why Linux shouldn't have to touch it).
> 
> > If that's not the case, you may need some intermediary cascaded
> > interrupt controller or something around those lines.
> 
> Yeah, but that's just the more general case of the
> general case :-)

Segher, I feel here that your inability to resist arguing about
everything in that case is confusing what is a fairly simple issue in
the first place :-) Poor guy trying to figure out the right way to do
his stuff will run away screaming and go back hard coding his number in
his platform code before we are finished :-)

So I would say, taking a dicator hat, that the right way to fix his
problem is also the simplest, which is to make sure the interrupt-map
entry for that slot points to the right GPIO interrupt :-)

Easy isn't it ?

Cheers,
Ben.
