Return-Path: <neko@genesi-usa.com>
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.25])
	by ozlabs.org (Postfix) with ESMTP id 23736DDE1A
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Oct 2008 03:53:05 +1100 (EST)
Received: by qw-out-2122.google.com with SMTP id 9so2247150qwb.15
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Oct 2008 09:53:03 -0700 (PDT)
Message-ID: <4907436D.2060209@genesi-usa.com>
Date: Tue, 28 Oct 2008 11:53:01 -0500
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: avorontsov@ru.mvista.com
Subject: Re: GPIO - marking individual pins (not) available in device tree
References: <20081024044511.GI4267@yookeroo.seuss>
	<490248C2.9020104@genesi-usa.com>
	<20081026234747.GD22339@yookeroo.seuss>
	<4905E0DC.104@genesi-usa.com>
	<20081027183421.GA1009@oksana.dev.rtsoft.ru>
	<49060EC3.1070704@genesi-usa.com>
	<20081027201023.GA18642@oksana.dev.rtsoft.ru>
	<49063929.3060900@genesi-usa.com>
	<20081027231221.GA22008@oksana.dev.rtsoft.ru>
	<490666B0.2010500@genesi-usa.com>
	<20081028023722.GA30057@oksana.dev.rtsoft.ru>
In-Reply-To: <20081028023722.GA30057@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=windows-1251; format=flowed
Sender: Matt Sealey <neko@genesi-usa.com>
Cc: Mitch Bradley <wmb@firmworks.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	devicetree-discuss list <devicetree-discuss@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



Anton Vorontsov wrote:
> On Mon, Oct 27, 2008 at 08:11:12PM -0500, Matt Sealey wrote:
>> Anton Vorontsov wrote:
>>> On Mon, Oct 27, 2008 at 04:56:57PM -0500, Matt Sealey wrote:
>>>> A bunch of things spring to mind:
>>>>
>>>> *   How do you define a GPIO bank in a device tree, not a controller
>>> Not a controller? What do you mean by "bank"? There is no such
>>> thing. There are GPIO controllers, and _maybe_ _their_ banks of
>>> GPIOs.
>> I don't know what you want to call it, I don't know what the official
>> Linux term might be for a grouped bunch of GPIO used for a peripheral.
> 
> You don't know this term because there isn't any. There is no term
> for "bunch of GPIO used for a peripheral".

There should be so we didn't have that conversation just now about
what a "bank" is supposed to mean :)

> But there are:
> 
> - gpio controllers;
> - devices that use some gpios;
> - gpios = <>; property that is used to denote which gpios the device
>   is using.
> 
> What's so hard about that?

*shrug*

> You don't specify the SOC's peripheral memory in the /memory node,
> do you? I bet you don't. Can you? Yes. Bad things will happen? Sure.

You could put SRAM in there and that wouldn't cause any problems. I
don't figure why SRAM is treated differently except that it would
be unlikely and unfortunate for Linux to use it as a generic pool of
RAM. There was a big discussion about whether the device_type should
be "memory" or "sram"... I personally prefer the latter.

>> Comments don't get compiled..
> 
> If you _really_ want to complicate things, you can write gpios for
> devices like this:
> 
> device {
> 	data0-gpio = <&controller1 1 1>;
> 	...
> 	rw-gpio = <&controller1 2 1>;
> }
> 
> This _will_ get compiled in. This is insane, but this is more friendly
> to a device tree reader, if you like.

Is it still possible to perhaps create a node under lcd-controller which
describes the pin groupings? Maybe we should call it a gpio-group.

That way lcd-controller looks like

lcd-controller {
	compatible = "crystalfontz,something-gpio";
	data-bus {
		compatible - "gpio-group";
		gpios = <gpioc 1 gpioc 8 gpioc 42 ... >
	}
	rw-ctrl {
		compatible = "gpio-group";
		gpios = <gpioc 2>
	}
	cmd-ctrl {
		...
	}
};

At least a driver for a particular lcd display geared for GPIO
output can then simply check the device tree for some known
compatibles. With a user header this is not required, just list
out the GPIOs ready for use. With a device where the function is
literally too obvious (it has 8 pins on an 8-bit data bus so how
hard can it be, and the order would be implicit in the gpios
property?) it is also kind of useless.

I definitely think that while possibly overly verbose for some
or even most functionality it would come in handy. The driver
would be able to detect which pins are for which purpose, rather
than what could be a very generic driver for multiple bus types
and platforms being hardcoded to work only on a specific board
(imagine 10 boards with the same LCD controller, all having a
list of which GPIO pins are which, when they are configured ever
so slightly differently).

>> and a driver will have
>> to be written FROM the comments, hardcoding the pins into it, again.
> 
> What do you mean by "hardcoding"? Let's see: interrupts = <33 32>;
> and then extracting them via
> of_irq_to_resource(node, 0, &tx_irq),
> of_irq_to_resource(node, 1, &rx_irq).
> 
> Does this mean "hard-coding"?

No. If you have an array of GPIO pins (gpios property) then how do you
determine which is for data and which is some control pin? Do you
associate these numbers in the driver somehow? Maybe a matchlist or
an array? Given pins A B C D E F G H I J where does the data bus
start and the control pins live? A and B? A and J? I and J?

It would be definitely frivolous to define a whole device tree binding
for the *order in which you MUST specify the gpios for this particular
device*. There is obviously an implicit ordering of the GPIOs to make
up the data bus (you'd expect an order from MSB to LSB.. or perhaps
LSB to MSB... that might be better defined than undefined)

>> GPIOLIB excited me when I talked to the original author about
>> it, now that there has to be a device tree behind it that is
>> an absolutely undefined, gpio-controller-specific implementation
>> for every chip
> 
> You seem to disagree with the whole device tree idea and the OF
> in general.

Actually I love Open Firmware, if I had a nickel for every time I had
nagged the guys at bplan to port it to one of these Freescale dev
boards so I didn't have to crawl through U-Boot every time I booted,
I would be able to fund the port myself.

The device tree, I guess I am a die-hard. I don't think shoehorning
a device tree into U-Boot is a great idea (I don't see why you can't
have a real OF!) and if Firmworks can port OF to OLPC and have it be
a success, what on earth is the point of U-Boot?

I love being able to "boot" anything that is bootable, and not have
to use a specific filesystem load command (ext2load, tftp etc.)
because the information and software to decode that booting process
is contained in the device tree and client interface, and not some
esoteric script command. I love the abstraction and the OPPORTUNITY
for abstraction and not just description.

What I don't so much agree with is the arbitrary definitions we had
to deal with when we made the Efika. The MPC5200B binding was in
flux (and for a chip Freescale do not encourage for new designs, the
device tree is still moving around. In 5 years nobody fixed it down?)
and we had arguments over "memory" or "sram" and stupid things like
"the node with all the SoC peripherals in *MUST* be device_type "soc"
and have name "soc"!!!! (we call it "builtin", it's compatible
property has always been "mpc5200b" though, so how can you have a problem
detecting that?)

 > Interrupts are so controller-specific stuff that
> we should reconsider using it, right?

No, because while controller specific, interrupt controllers have
well-defined layouts with interrupt-parent, cascading and the
connection of certain pins to certain interrupt hosts (PCI INTA,
B, C, D) is all explicit in the device tree. If you have an MPC5200B
interrupt in a device tree node, you know the 3 numbers are
encoded as TYPE NUMBER LEVEL (type being critital, main or
peripheral or "bestcomm", number being encoded as an offset into
a register, and the level being 0-3 for edge, blah blah) because
the bindings say so. But when you allocate an IRQ using the device
tree as input, you do not even need to know what these things mean,
just hope that someone used the right one in the device tree. The
binding does not affect the driver, it actually works to make the
driver MUCH simpler here, and far more generic and maintainable
and promotes shared code.

GPIO does not have this explicit layout option, only a randomly
ordered list of gpios which are hooked to a device which do not
have any "purpose" assigned to them. Rather than specific ways
to define a GPIO data it's not specific. So one device may encode
the purpose of the pin as a flag. These flags change per-chip.
And at the end of the day if you go down that route you risk
being clobbered by a new standard which defines a new flag right
over the one you wanted to use for your "this is a data pin and
this is a control pin" flag.

While I see a device binding that says that the encoding of the
gpios field and the gpio-cells is arbitrary per controller and
if flags are specified, these flags are controller-specific, I
do not see any definition of what they are for a SPECIFIC
CONTROLLER. What do I use for flags with the MPC5200B? Which
ones are spare? :D

>> or even every board with significant information
>> hardcoded into drivers, I am considerably less enthused.
> 
> What's so bad about board-specific drivers for board-specific
> devices?

I doubt you will only see one LCD controller kind on one board
any time soon.

That LCD controller may be able to be driven over a couple of
methods - be that one bus or another or a GPIO method, in the
same way you can use MII or a 7-wire ethernet controller on
the same chip. 99.9% of the driver is the same except the
abstraction to how it communicates with the PHY.

Without some purposeful definition in the device tree, the
layout of the gpios property has to be defined, maintained
and extracted by the driver using intimate knowledge of the
board, extracted from a comment or a document, possibly
extended from the one for the controller if you need "more
flags".

Let's be honest, using the flags field in "gpios" is not
very human readable, and if we're using device tree examples
as documentation, this just makes it harder on the developer
as well as a user browsing the device tree on their device.

> If a gpio-header is board-specific, then we have to
> write a board-specific driver for it. To make things better
> we can write the driver in a such way that the driver could be
> easily adopted/extended for similar boards/setups.

Indeed.

> OR we can write bindings that could fully describe the gpio
> header, and then just use the universal driver for it.

Sure. This is what I mean.

> Both solutions are doable.
> 
>> Okay. I think I am understanding this enough that I could write
>> a bit more comprehensive documentation for it that would
>> encompass the result of this discussion and some other things
>> going on right now...
>>
>> As for implementation, since the only hardware I have here to
>> test is a) broken b) only has 3 GPIO pins or b) working but
>> such a horrid design I wouldn't use it as a doorstop, I don't
>> think I am really qualified to put it into action..
> 
> Yeah, there are always excuses when it comes to send patches... ;-)

That and I am busy, yes. I need to document it first though.

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
