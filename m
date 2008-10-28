Return-Path: <neko@genesi-usa.com>
Received: from mail-gx0-f15.google.com (mail-gx0-f15.google.com
	[209.85.217.15]) by ozlabs.org (Postfix) with ESMTP id DFFC5DDE03
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Oct 2008 12:11:18 +1100 (EST)
Received: by gxk8 with SMTP id 8so5651661gxk.9
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Oct 2008 18:11:16 -0700 (PDT)
Message-ID: <490666B0.2010500@genesi-usa.com>
Date: Mon, 27 Oct 2008 20:11:12 -0500
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: avorontsov@ru.mvista.com
Subject: Re: GPIO - marking individual pins (not) available in device tree
References: <20081024032944.GE4267@yookeroo.seuss>
	<49014C69.8020408@firmworks.com>
	<20081024044511.GI4267@yookeroo.seuss>
	<490248C2.9020104@genesi-usa.com>
	<20081026234747.GD22339@yookeroo.seuss>
	<4905E0DC.104@genesi-usa.com>
	<20081027183421.GA1009@oksana.dev.rtsoft.ru>
	<49060EC3.1070704@genesi-usa.com>
	<20081027201023.GA18642@oksana.dev.rtsoft.ru>
	<49063929.3060900@genesi-usa.com>
	<20081027231221.GA22008@oksana.dev.rtsoft.ru>
In-Reply-To: <20081027231221.GA22008@oksana.dev.rtsoft.ru>
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
> On Mon, Oct 27, 2008 at 04:56:57PM -0500, Matt Sealey wrote:
>>
>> A bunch of things spring to mind:
>>
>> *   How do you define a GPIO bank in a device tree, not a controller
> 
> Not a controller? What do you mean by "bank"? There is no such
> thing. There are GPIO controllers, and _maybe_ _their_ banks of
> GPIOs.

I don't know what you want to call it, I don't know what the official
Linux term might be for a grouped bunch of GPIO used for a peripheral.

>>     but a grouping of pins which fit that pattern, of which there
>>     may be multiple groupings for multiple peripheral functions
> 
> Why do you need this, _exactly_? What problem this would solve? But
> see below, this is still possible to implement.

I made a pretty good example with the lcd controller, I thought..

> But I still wonder what problem exactly you're trying to solve
> here? Prevent requesting reserved gpios? I don't see any point
> in this, really.

There's plenty of reason for it, it's totally wrong to be able
to request a GPIO which has been multiplexed to another device
in the SoC, and probably completely undefined behaviour if you
start toggling a pin that's been assigned to an internal
controller.

Since you have no way of knowing except intimate board design
knowledge in the driver.. well, that defeats the purpose of the
device tree in general and is a step back into hardcoded information
in board support from arch/ppc days etc..

This information SHOULD be in the device tree specifically because
there is one very popular chip here which has GPIO multiplexed with
other very-often-used peripherals, and I can think of at least 5
other chips which also have device trees and GPIO potential (4 of
which we have designed boards around) which fit the same model and
would have the same requirement.

There are two ways you can do it; implicit and explicit. If a
pin is not defined for a peripheral in the device tree, it is
not requestable from GPIOLIB. Or, you make sure that you specify


> No problem. Define bindings for "8 GPIOs data group".
> 
> /* 8bit Parallel I/O port using arbitrary gpios */
> byte_pio: byte-pio {
> 	compatible = "byte-pio";
> 	gpios = <&controller1 0 1   /* data line 0 */
> 		 &controller2 12 0  /* data line 1 */
> 		 ...>;
> };
> 
> lcd-controller {
> 	/* the lcd controller can simply use the pio_out_8(),
> 	 * pio_in_8() API. The API is easily implemented. */
> 	lcd-data-port = <&byte_pio>;
> }
> 
>> and 1 for data/control selection, it would be nice for the
>> software to know which pin is which and, slightly unrelated,
>> which way around the data pins went - MSB first or LSB first
>> - from the device tree, as this is a BOARD LEVEL DESIGN DECISION
>> which is what the device tree is meant to abstract - in the same
>> way we define i2c controllers and clients?)

And this? What about the other two control lines? Do they just get
set in the gpios property of the lcd-controller? How do you determine
which is which? Comments don't get compiled.. and a driver will have
to be written FROM the comments, hardcoding the pins into it, again.

I refer you to the little discussion about Xilinx cores and GPIO
which may change from build to build due to pin mapping requirements
and autofitting. There are plenty of cases where you'd implement
some board design where you do not want to rewrite and recompile a
driver after you've just revised your FPGA design for some reason.

>> *   At the end of the day the GPIO device tree binding is barely
>>     20 lines at the bottom of a file that has been superceded by
>>     the ePAPR standard now, so where do we stand on this anyway?
>>
>> (I will ask that same last question of the i2c guys, I have never
>> seen the Linux i2c device binding in the tree - maybe I am not
>> looking hard enough - and the Sun binding seems to be a secret
>> that only special people are allowed to see)
> 
> Please don't mix threads. Start a new thread for i2c guys.

It's simply a reference to a similar problem.

>> I don't feel the current spec actually takes this into account
>> and the patch submission the other day from Wolfgang made me
>> think that if a "base" register is the obvious solution to some
>> problem, then it either can't be that clear to others (i.e. it
>> is not just me being stupid) or it is simply not possible under
>> the current binding.
> 
> Wolfgang's patch proved to be unnecessary, you haven't seen
> the solution?

Wolfgang's patch would never have been considered by Wolfgang
if the solution wasn't more obvious... this is why I started
the thread :D

>> At the very least it needs documenting better,
> 
> Feel free to write a better documentation.

I'm more confused now about how this is meant to be done than
I was when I started.

Device tree authors may as well just make shit up on the spot
at this point... write an entirely specific driver for their
effort, and it will still get in, and everyone will be using
that hack as an example of what is right.

That happens too often by my book.

> I don't know how did you come to these conclusions. Pretty much
> people were involved into the gpio bindings discussion.

I was watching the threads and I expected a little more than 20
lines of documentation and a couple LED drivers would come out
of it.

GPIOLIB excited me when I talked to the original author about
it, now that there has to be a device tree behind it that is
an absolutely undefined, gpio-controller-specific implementation
for every chip or even every board with significant information
hardcoded into drivers, I am considerably less enthused.

>> Yes, your idea, Mitch's discussion was great, I just don't think
>> anything will get done about it (emotional moment) as usual.
> 
> Hm. If idea looks ok, then it is matter of implementation. And
> the gpio-header case is quite easy to implement, really.

Okay. I think I am understanding this enough that I could write
a bit more comprehensive documentation for it that would
encompass the result of this discussion and some other things
going on right now...

As for implementation, since the only hardware I have here to
test is a) broken b) only has 3 GPIO pins or b) working but
such a horrid design I wouldn't use it as a doorstop, I don't
think I am really qualified to put it into action..

The premise draws from some discussions a long while ago with
users about using GPIO in Linux (before GPIOLIB happened) and
from my current work trying to get a framework for students to
do their senior design projects in mechatronics - mostly with
CPLDs but also using boards like the Efika and similar (but with
GPIO to spare) as control. We can't assume these students know
how to program the kernel so the very easiest way to define it
is in the device tree with a more generic driver, something
we could even drop sysfs/GUI tools on top. We simply can't
have them all join the clique kernel hacker society for it.

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
