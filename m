Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-10.arcor-online.net (mail-in-10.arcor-online.net
	[151.189.21.50])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D31DFDDEB9
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Jun 2007 19:47:52 +1000 (EST)
In-Reply-To: <1181113438.31677.234.camel@localhost.localdomain>
References: <20070604095625.GF17456@chiana.homelinux.org>
	<4E25DA41-741E-40AC-9186-936FEEFE6B29@freescale.com>
	<20070604211740.GN17456@chiana.homelinux.org>
	<C1F9584D-E778-4BE7-B11A-5505BA9B6F6C@freescale.com>
	<cbf493edec7259df199568389814dab6@kernel.crashing.org>
	<1181113438.31677.234.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <3641c2a601dbccc9757fe9443d9330ca@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: 83xx GPIO/EXT int in arch/powerpc/
Date: Wed, 6 Jun 2007 11:47:42 +0200
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

> In addition, linux always reserve numbers 0...15. 0 is
> always illegal and 1..15 can only be mapped to a 8259 type legacy ISA
> controller. This is to avoid problem with stupid drivers from the x86
> world.

Of course, it doesn't help if you have an i8259 but have
non-legacy-PC devices on it.  Oh the horror!

> Now, there is no automagic way of setting up GPIOs. You have to 
> manually
> (from your firmware that is, or maybe from your platform code),
> configure the appropriate GPIO to the appropriate HW irq source on the
> IPIC that matches what you put in your DTS.

It *really* shouldn't be Linux platform code, if you can
avoid it at all.  It's just more trouble than it's worth.

>  - You can create a device-node for the PCI device. PCI devices
> normally, in linux, don't need to have device-nodes in the DTS, at 
> least
> it's not mandatory, but you -can- do it. If your node has the correct
> "reg" property,

What is "correct" in this case?  We probably should describe
what properties are required in a (non-phb) pci node for
platforms that don't use the device tree for probing PCI.
In this specific case, do you only need the configuration
address in the "reg"?

> it should be matches by the linux parser, and thus you
> have the ability to put an interrupts property in there. It would
> normally be a PCI interrupt specification, but you can specify
> explicitely an interrupt parent that points to the IPIC and thus have 
> an
> interrupt pointing directly there. That's the example that, I think,
> Andy gave you

Yeah.

>  - You can do it in your interrupt-map. That's probably the cleanest 
> way
> to do it.

Not really.  If the device interrupt is physically connected
directly to a GPIO or a PIC or whatever, if it doesn't go
through the PCI bus; then it shouldn't be represented in
the device tree as if it did.  The higher-up bridge has
nothing whatsoever to do with this device's interrupt.

It's a simple hack of course, it can be useful sometimes.
It's not "clean" at all however.

> Just make sure you have
> an entry there for your device pin A dev/fn whose specification points
> to the IPIC with the appropriate IRQ number and that should work fine.

Depending on the rest of the tree, this would often mean
you have to do a much bigger interrupt-map-mask than
without this hack, and the corresponding explosion in
interrupt-map size.

> Now, that's assuming GPIOs, when used as external interrupts, are
> directly routed to the IPIC. I don't know the 83xx so I just assumed
> it :-)

Almost always that's how it works yeah.  And the "GPIO"
stage isn't normally represented in the device tree, GPIO
settings are considered a part of the PCB layout ;-) (one
more reason why Linux shouldn't have to touch it).

> If that's not the case, you may need some intermediary cascaded
> interrupt controller or something around those lines.

Yeah, but that's just the more general case of the
general case :-)


Segher
