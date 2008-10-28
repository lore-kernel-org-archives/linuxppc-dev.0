Return-Path: <avorontsov@ru.mvista.com>
Date: Tue, 28 Oct 2008 05:37:22 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Matt Sealey <matt@genesi-usa.com>
Subject: Re: GPIO - marking individual pins (not) available in device tree
Message-ID: <20081028023722.GA30057@oksana.dev.rtsoft.ru>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <490666B0.2010500@genesi-usa.com>
Cc: Mitch Bradley <wmb@firmworks.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	devicetree-discuss list <devicetree-discuss@ozlabs.org>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Oct 27, 2008 at 08:11:12PM -0500, Matt Sealey wrote:
> Anton Vorontsov wrote:
>> On Mon, Oct 27, 2008 at 04:56:57PM -0500, Matt Sealey wrote:
>>>
>>> A bunch of things spring to mind:
>>>
>>> *   How do you define a GPIO bank in a device tree, not a controller
>>
>> Not a controller? What do you mean by "bank"? There is no such
>> thing. There are GPIO controllers, and _maybe_ _their_ banks of
>> GPIOs.
>
> I don't know what you want to call it, I don't know what the official
> Linux term might be for a grouped bunch of GPIO used for a peripheral.

You don't know this term because there isn't any. There is no term
for "bunch of GPIO used for a peripheral".

But there are:

- gpio controllers;
- devices that use some gpios;
- gpios = <>; property that is used to denote which gpios the device
  is using.

What's so hard about that?

>>>     but a grouping of pins which fit that pattern, of which there
>>>     may be multiple groupings for multiple peripheral functions
>>
>> Why do you need this, _exactly_? What problem this would solve? But
>> see below, this is still possible to implement.
>
> I made a pretty good example with the lcd controller, I thought..

Yes, thanks for the example. And I don't see any problems with
describing the lcd controller.

>> But I still wonder what problem exactly you're trying to solve
>> here? Prevent requesting reserved gpios? I don't see any point
>> in this, really.
>
> There's plenty of reason for it, it's totally wrong to be able
> to request a GPIO which has been multiplexed to another device
> in the SoC, and probably completely undefined behaviour if you
> start toggling a pin that's been assigned to an internal
> controller.

Then just don't specify the wrong GPIO in the gpios = <>! It is
that simple.

You don't specify the SOC's peripheral memory in the /memory node,
do you? I bet you don't. Can you? Yes. Bad things will happen? Sure.

You may bring the gpio sysfs example. But I can answer back with the
/dev/mem example. There are plenty of things you can do bad things
with, even being in the userspace.

> Since you have no way of knowing except intimate board design
> knowledge in the driver.. well, that defeats the purpose of the
> device tree in general and is a step back into hardcoded information
> in board support from arch/ppc days etc..
> 
> This information SHOULD be in the device tree specifically because
> there is one very popular chip here which has GPIO multiplexed with
> other very-often-used peripherals, and I can think of at least 5
> other chips which also have device trees and GPIO potential (4 of
> which we have designed boards around) which fit the same model and
> would have the same requirement.
>
> There are two ways you can do it; implicit and explicit. If a
> pin is not defined for a peripheral in the device tree, it is
> not requestable from GPIOLIB. Or, you make sure that you specify

This is doable and _maybe_ a good idea. Though I don't see much
value in this.

>> No problem. Define bindings for "8 GPIOs data group".
>>
>> /* 8bit Parallel I/O port using arbitrary gpios */
>> byte_pio: byte-pio {
>> 	compatible = "byte-pio";
>> 	gpios = <&controller1 0 1   /* data line 0 */
>> 		 &controller2 12 0  /* data line 1 */
>> 		 ...>;
>> };
>>
>> lcd-controller {
>> 	/* the lcd controller can simply use the pio_out_8(),
>> 	 * pio_in_8() API. The API is easily implemented. */
>> 	lcd-data-port = <&byte_pio>;
>> }
>>
>>> and 1 for data/control selection, it would be nice for the
>>> software to know which pin is which and, slightly unrelated,
>>> which way around the data pins went - MSB first or LSB first
>>> - from the device tree, as this is a BOARD LEVEL DESIGN DECISION
>>> which is what the device tree is meant to abstract - in the same
>>> way we define i2c controllers and clients?)
>
> And this? What about the other two control lines? Do they just get
> set in the gpios property of the lcd-controller? How do you determine
> which is which?

This depends on how will you write the bindings.

> Comments don't get compiled..

If you _really_ want to complicate things, you can write gpios for
devices like this:

device {
	data0-gpio = <&controller1 1 1>;
	...
	rw-gpio = <&controller1 2 1>;
}

This _will_ get compiled in. This is insane, but this is more friendly
to a device tree reader, if you like.

> and a driver will have
> to be written FROM the comments, hardcoding the pins into it, again.

What do you mean by "hardcoding"? Let's see: interrupts = <33 32>;
and then extracting them via
of_irq_to_resource(node, 0, &tx_irq),
of_irq_to_resource(node, 1, &rx_irq).

Does this mean "hard-coding"?

[...]
>>> I don't feel the current spec actually takes this into account
>>> and the patch submission the other day from Wolfgang made me
>>> think that if a "base" register is the obvious solution to some
>>> problem, then it either can't be that clear to others (i.e. it
>>> is not just me being stupid) or it is simply not possible under
>>> the current binding.
>>
>> Wolfgang's patch proved to be unnecessary, you haven't seen
>> the solution?
>
> Wolfgang's patch would never have been considered by Wolfgang
> if the solution wasn't more obvious... this is why I started
> the thread :D

Oh, device tree/correct bindings/proper ways to solve things
aren't always obvious? It's news to me. ;-)

[...]
>> I don't know how did you come to these conclusions. Pretty much
>> people were involved into the gpio bindings discussion.
>
> I was watching the threads and I expected a little more than 20
> lines of documentation and a couple LED drivers would come out
> of it.
>
> GPIOLIB excited me when I talked to the original author about
> it, now that there has to be a device tree behind it that is
> an absolutely undefined, gpio-controller-specific implementation
> for every chip

You seem to disagree with the whole device tree idea and the OF
in general. Interrupts are so controller-specific stuff that
we should reconsider using it, right?

> or even every board with significant information
> hardcoded into drivers, I am considerably less enthused.

What's so bad about board-specific drivers for board-specific
devices? If a gpio-header is board-specific, then we have to
write a board-specific driver for it. To make things better
we can write the driver in a such way that the driver could be
easily adopted/extended for similar boards/setups.

OR we can write bindings that could fully describe the gpio
header, and then just use the universal driver for it.

Both solutions are doable.

>>> Yes, your idea, Mitch's discussion was great, I just don't think
>>> anything will get done about it (emotional moment) as usual.
>>
>> Hm. If idea looks ok, then it is matter of implementation. And
>> the gpio-header case is quite easy to implement, really.
>
> Okay. I think I am understanding this enough that I could write
> a bit more comprehensive documentation for it that would
> encompass the result of this discussion and some other things
> going on right now...
>
> As for implementation, since the only hardware I have here to
> test is a) broken b) only has 3 GPIO pins or b) working but
> such a horrid design I wouldn't use it as a doorstop, I don't
> think I am really qualified to put it into action..

Yeah, there are always excuses when it comes to send patches... ;-)

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
