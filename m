Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 98278DDDF9
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Jun 2007 17:04:11 +1000 (EST)
Subject: Re: 83xx GPIO/EXT int in arch/powerpc/
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <cbf493edec7259df199568389814dab6@kernel.crashing.org>
References: <20070604095625.GF17456@chiana.homelinux.org>
	<4E25DA41-741E-40AC-9186-936FEEFE6B29@freescale.com>
	<20070604211740.GN17456@chiana.homelinux.org>
	<C1F9584D-E778-4BE7-B11A-5505BA9B6F6C@freescale.com>
	<cbf493edec7259df199568389814dab6@kernel.crashing.org>
Content-Type: text/plain
Date: Wed, 06 Jun 2007 17:03:58 +1000
Message-Id: <1181113438.31677.234.camel@localhost.localdomain>
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

I'm a bit afraid that our various messages on the subject have been a
tad confusing :-) Especially your blurb on virtual number is a bit scary
Andy :-)

So I'm in a good mood, I'll attempt to explain what's going on.

The powerpc kernel nowadays separate linux IRQ numbers (what you see in
pci_device->irq, or what devices do a request_irq() on) from HW numbers.

The former are what we call "virtual" IRQ numbers, and are just indices
in a giant array (has always been), and can now be arbitrarily mapped to
HW numbers. In addition, linux always reserve numbers 0...15. 0 is
always illegal and 1..15 can only be mapped to a 8259 type legacy ISA
controller. This is to avoid problem with stupid drivers from the x86
world.

HW numbers are local to a given interrupt controller and they should be
all you care about in the device-tree.

If a device has interrupt source 2 on the IPIC, it should have an
interrupts property encoding a 2 (along with whatever the IPIC uses to
encode polarity). This will ultimately be turned into some other number
by linux for a virtual irq, but that's not the business of the dts.

Now, there is no automagic way of setting up GPIOs. You have to manually
(from your firmware that is, or maybe from your platform code),
configure the appropriate GPIO to the appropriate HW irq source on the
IPIC that matches what you put in your DTS.

The way those HW numbers are then parsed and turned into virtual IRQ
numbers depends on the type of device. Basically, you can always do it
manually with the irq_* functions, either by providing directly the low
level values (I wouldn't recommand that in general) or by letting the
linux device-tree parser do it for you.

However, if your device is a PCI device, it might be a simple as letting
the linux PCI code do it for you :-) the linux PCI code uses the parser
to attempt to resolve interrupts for every PCI device in the system.

Thus, you have multiple options here:

 - The easy/hack/bad one: You can have a ppc_md.pci_irq_fixup hook in
your platform code that maps it manually to a hard coded number. That's
ugly, but it will work. Though expect complaints if you ever try to
merge your code upstream.

 - You can create a device-node for the PCI device. PCI devices
normally, in linux, don't need to have device-nodes in the DTS, at least
it's not mandatory, but you -can- do it. If your node has the correct
"reg" property, it should be matches by the linux parser, and thus you
have the ability to put an interrupts property in there. It would
normally be a PCI interrupt specification, but you can specify
explicitely an interrupt parent that points to the IPIC and thus have an
interrupt pointing directly there. That's the example that, I think,
Andy gave you

 - You can do it in your interrupt-map. That's probably the cleanest way
to do it. Basically, you don't need a node for your device (or if you
have one, you let it do the standard "interrupts" for PCI which contains
an interrupt in number). However, in the interrupt-map of the bridge,
you'll notice that there's an entry for every possible dev/fn. Each of
them has an explicit parent PIC specification. Just make sure you have
an entry there for your device pin A dev/fn whose specification points
to the IPIC with the appropriate IRQ number and that should work fine.
If your device emits interrupts on multiple pins, you can always have
multiple entries, etc...

Now, that's assuming GPIOs, when used as external interrupts, are
directly routed to the IPIC. I don't know the 83xx so I just assumed
it :-) If that's not the case, you may need some intermediary cascaded
interrupt controller or something around those lines.

Ben.
