Return-Path: <avorontsov@ru.mvista.com>
Date: Tue, 28 Oct 2008 02:12:21 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Matt Sealey <matt@genesi-usa.com>
Subject: Re: GPIO - marking individual pins (not) available in device tree
Message-ID: <20081027231221.GA22008@oksana.dev.rtsoft.ru>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <49063929.3060900@genesi-usa.com>
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

On Mon, Oct 27, 2008 at 04:56:57PM -0500, Matt Sealey wrote:
> Anton Vorontsov wrote:
>> Can you _simply_ describe the problem you're trying to solve,
>> w/o that much emotions? Can you give examples of what
>> you've tried, and describe why you don't like it?
>
> I've not tried anything because I don't feel confident that the
> documentation or device tree examples explain the situation at
> all.
>
> Here's the basic premise;
>
> MPC5200B has three GPIO banks, one for standard, one for wakeups,
> one for timer GPIO. They're all implemented as 32-bit registers
> (but each bank does not necessarily have 32 pins escaping the
> chip). Several of the GPIO are multiplexed with other devices
> which can and does leave gaping holes of GPIO in the 32-bit
> register where anything up to 7 pins are given over to another
> device and therefore are no longer GPIO (this example is held
> up by the implementation of ethernet on the MPC5200B).
>
> Given GPIO functionality where you need more pins than a single
> device mux can offer, and some device muxing making those holes
> splitting up a contiguous allocation of pins that can be defined
> by a base pin number and a count of pins to assign, you may have
> to allocate several GPIO pins out of the register which are NOT
> contiguous.
>
> So in a 32-bit register, let's say 0 is a GPIO we don't need (or
> available but used for some other GPIO peripheral), and X is a
> GPIO muxed to another device (therefore not GPIO anymore) and 1
> is one we do want to use:
>
> 00011XXXXXXX111XX1111XXX00000XX1
>
> (imagine them routed to a 12-pin connector with VCC and GND
> and 10 data pins. This may be an LCD display controller such
> as you can buy from Sparkfun or CrystalFontz, if you need a
> physical example)
>
> A bunch of things spring to mind:
>
> *   How do you define a GPIO bank in a device tree, not a controller

Not a controller? What do you mean by "bank"? There is no such
thing. There are GPIO controllers, and _maybe_ _their_ banks of
GPIOs.

>     but a grouping of pins which fit that pattern, of which there
>     may be multiple groupings for multiple peripheral functions

Why do you need this, _exactly_? What problem this would solve? But
see below, this is still possible to implement.

> (for instance an LED controller, and an IR receiver, and a bitbang
> SPI implemented using these GPIO pins)?

So you need indirect GPIOs to use with devices? I.e. you want
to reference a GPIO header's GPIOs? Don't see any point in this
(other than just introducing the indirectness), but anyway this
will look like this:

cpu_pio: cpu-gpio-controller {
	#gpio-cells = <2>;
	gpio-controller;
};

header_pio: gpio-header {
	/*
	 * This controller defines a group of GPIOs wired to a
	 * external header. The header enumerates pins from 1
	 * to 12. So gpio-spec "&header_pio 4 0" will reference
	 * the 5-th pin, no matter what underlaying GPIO controller
	 * provides it.
	 */
	#gpio-cells = <2>;
	gpio-controller;
	gpios = <&cpu_pio 12 0
		 &cpu_pio 21 0
		 &i2c_controller 2 0
		 ...>
}

spi-controller {
	/* We want to _not_ care what underlaying GPIOs there are,
	 * we reference the header pins instead. */
	gpios = <&header_pio 0 0 /* MISO */
		 &header_pio 1 0 /* MOSI */
		 ...
		 &header_pio 11 0 /* CS0 */
		 ...>;
}

> *   How do you stop GPIOLIB from blindly approving requests to use
>     pins marked X, without making it "controller-specific"?

Driver can implement a .request() hook, and check for compatible
entries for this specific gpio controller. If this particular
gpio controller doesn't provide some pin it can return -ENODEV.

But I still wonder what problem exactly you're trying to solve
here? Prevent requesting reserved gpios? I don't see any point
in this, really.

>     GPIOLIB
>     can be as controller-specific as it likes, but having 20 different
>     ways to define "X pins" or "available pins" complicates a
>     device tree unnecessarily.
>
> (I've been implementing a "gpio-mask" property in MY device trees
> because I thought of this problem ages ago but just never had any
> reason to make use of it. But it's very controller-specific, and
> therefore pretty useless (and actually on other GPIO controllers
> which use a register-per-pin is not actually any use at all, but
> the question above remains!))
>
> *   Since we're looking at an example where we interface a fairly
>     complex device which is technically a bus, with a subordinate
>     device which may or may not be probe-able, could you define
>     that GPIO configuration in such a way that it is a device node
>     of it's own, that the pins are marked for their purpose
>
> (on such an LCD example, 8 data pins in a group, 1 for r/w selection

No problem. Define bindings for "8 GPIOs data group".

/* 8bit Parallel I/O port using arbitrary gpios */
byte_pio: byte-pio {
	compatible = "byte-pio";
	gpios = <&controller1 0 1   /* data line 0 */
		 &controller2 12 0  /* data line 1 */
		 ...>;
};

lcd-controller {
	/* the lcd controller can simply use the pio_out_8(),
	 * pio_in_8() API. The API is easily implemented. */
	lcd-data-port = <&byte_pio>;
}

> and 1 for data/control selection, it would be nice for the
> software to know which pin is which and, slightly unrelated,
> which way around the data pins went - MSB first or LSB first
> - from the device tree, as this is a BOARD LEVEL DESIGN DECISION
> which is what the device tree is meant to abstract - in the same
> way we define i2c controllers and clients?)

> *   At the end of the day the GPIO device tree binding is barely
>     20 lines at the bottom of a file that has been superceded by
>     the ePAPR standard now, so where do we stand on this anyway?
>
> (I will ask that same last question of the i2c guys, I have never
> seen the Linux i2c device binding in the tree - maybe I am not
> looking hard enough - and the Sun binding seems to be a secret
> that only special people are allowed to see)

Please don't mix threads. Start a new thread for i2c guys.

> I don't feel the current spec actually takes this into account
> and the patch submission the other day from Wolfgang made me
> think that if a "base" register is the obvious solution to some
> problem, then it either can't be that clear to others (i.e. it
> is not just me being stupid) or it is simply not possible under
> the current binding.

Wolfgang's patch proved to be unnecessary, you haven't seen
the solution?

> At the very least it needs documenting better,

Feel free to write a better documentation.

> worst case is
> it needs a damn good rethink taking into account a set of
> controllers which comprise a representative number of GPIO
> controller types and potential uses.

The proposal is.. quite vague.

> I actually saw the voltage
> controller framework go into 2.6.27 and they have designed it
> around the operation of two PMUI chips which are pretty much
> the industry standard.

Good for them. How does it relate to this GPIO discussion?

> GPIO device tree does not seem to have
> gotten the same amount of attention.

I don't know how did you come to these conclusions. Pretty much
people were involved into the gpio bindings discussion.

> Yes, your idea, Mitch's discussion was great, I just don't think
> anything will get done about it (emotional moment) as usual.

Hm. If idea looks ok, then it is matter of implementation. And
the gpio-header case is quite easy to implement, really.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
