Return-Path: <avorontsov@dev.rtsoft.ru>
Date: Wed, 17 Sep 2008 16:56:00 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: demuxing irqs
Message-ID: <20080917125600.GA20931@oksana.dev.rtsoft.ru>
References: <20080916121740.GA9970@oksana.dev.rtsoft.ru>
	<9e4733910809160537s67812bf5x3d4d46a384f8237f@mail.gmail.com>
	<20080916131203.GA21641@oksana.dev.rtsoft.ru>
	<9e4733910809160636heaa545eld0da835b2d163811@mail.gmail.com>
	<20080916141422.GA29888@oksana.dev.rtsoft.ru>
	<9e4733910809160724x693c5af9y8df2f609e79f5005@mail.gmail.com>
	<20080916174935.GA13142@ld0162-tx32.am.freescale.net>
	<9e4733910809161132j3b0ff194hd60fcdf489fb19e4@mail.gmail.com>
	<20080916214210.GA15987@oksana.dev.rtsoft.ru>
	<9e4733910809161508m3a94baf1g818be7247439848e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <9e4733910809161508m3a94baf1g818be7247439848e@mail.gmail.com>
Cc: Scott Wood <scottwood@freescale.com>,
	linuxppc-dev <Linuxppc-dev@ozlabs.org>, Roland Dreier <rdreier@cisco.com>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Sep 16, 2008 at 06:08:34PM -0400, Jon Smirl wrote:
[...]
> >> >> > Assume that GPIO 8 does not translate to any IRQ, but IRQ 8 is still
> >> >> > valid virq b/c it is mapped for another IRQ controller (particularly
> >> >> > lots of kernel code assumes that IRQ 8 is 8259 PIC's CMOS interrupt,
> >> >> > the PIC and IRQ8 is widely used on PowerPC).
> >> >>
> >> >> Set the base in the GPIO struct such that this won't happen.  You can
> >> >> set the base greater than MAX_IRQ.
> >> >
> >> > And then you'll conflict with some other subsystem that decides to engage
> >> > in the same shenanigans.
> >>
> >> That comment was target at GPIO's that don't support interrupts. Give
> >> those GPIO numbers greater than MAX_IRQ in case someone tries to use
> >> them with the IRQ subsystem. Then they'll get errors.
> >
> > Or we can do the right thing, without messing all other gpio
> > controllers, i.e. implementing MAX_IRQ hacks. Right?
> >
> > I still don't see any problems with .to_irq callback, can you
> > point out any?
> 
> 
> You have to map between GPIO and IRQ inside the interrupt handlers so
> it has to be reasonably fast. This gets done on every shared interrupt
> so you will end up building mapping tables.

I don't get it. The mapping for your gpio controller will be 1:1.
But only for your GPIO controller. You don't have to create any tables.

That is,

static unsigned int your_controller_gpio_to_irq(stuct gpio_chip *gc,
						unsigned int gpio)
{
	return gc->base + gpio; /* guaranteed for this particular
				   irq/gpio controller bundle, because
				   gc->base == virq_base AND we
				   use 1:1 mapping. */
}

gpio_chip->to_irq = your_controller_gpio_to_irq;

Where is the table?

> Also, gpio_to_irq()
> doesn't take the gpio chip struct as a parameter.

You don't need this, since gpio_to_irq will call gpiolib's
__gpio_to_irq(), and gpiolib will call gpio_to_chip() to get the
chip struct. The approach is the same as we do for
gpio_{get,set}_value via gpiolib.

> Why does this mess with all of ther GPIO controllers? If they generate
> interrupts they obviously have to coordinate with the VIRQ system.

Btw, why do you need the gpio_to_irq call in the first place?
Why don't you just configure a gpio to serve as an interrupt source
(inside one of irq_host_ops), and just specify "interrupts = <>"
along side with "gpios = <>" in the "ir" node?

For example,

	gpio_wkup: gpio-wkup@c00 {
		compatible = "fsl,mpc5200b-gpio-wkup","fsl,mpc5200-gpio-wkup";
		reg = <0xc00 0x40>;
		interrupts = <0x1 0x8 0x0 0x0 0x3 0x0>;
		interrupt-parent = <&mpc5200_pic>;
		gpio-controller;
		#gpio-cells = <2>;
		interrupt-controller; <-- added
		#interrupt-cells = <2>; <-- added
	};

	ir {
		interrupts = <0 1>; <-- notice that irq-specific flags
		                         placed where they should.
		interrupt-parent = <&gpio_wkup>;
		gpios = <&gpio_w 0 0>; <-- notice that 1:1 mapping is explicit
	};

...and you don't need the gpio_to_irq.

(Plus. I would rather split the gpio-wkup node into two:
interrupt-controller, and gpio-controller).

> This may be an issue with the way gpio lib is designed, the API for
> the library assumes all gpios in the system are assigned unique
> identifiers.
> 
> Is there any other problem with 1:1 other than it doesn't return an
> error if gpio_to_irq() is called with a gpio number that doesn't
> support irqs?

Yes. We might want non-1:1 mapping for other gpio controllers.

And we can't handle gpio_to_irq() for GPIO0 (yes, sure, we can
implement another hack: reserve GPIO0 for no use. ;-)

> You could always implement gpio_to_irq() like this:
> 
> if (gpio < MAX_HW_IRQ)
>    return -ENOSYSl
> return gpio;

Don't know anything about MAX_HW_IRQ... maybe NR_IRQS? I heard
some rumors about making NR_IRQS dynamic...

> Sure your proposal works too, it's just more complicated. 1:1 mapping
> is working for ARM, why does PowerPC need to be different? I initially
> started coding it the way you propose but then I stumbled across the
> ARM solution and it was way simpler.

I don't see why adding one more gpiolib callback would complicate
things. Today you're _forcing_ every gpio controller to have 1:1
irq:gpio mapping. I think later we will encounter more problems
with it and then we will blame our lack of foresight...

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
