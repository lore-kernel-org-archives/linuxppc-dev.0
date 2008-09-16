Return-Path: <avorontsov@ru.mvista.com>
Date: Tue, 16 Sep 2008 18:14:22 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: demuxing irqs
Message-ID: <20080916141422.GA29888@oksana.dev.rtsoft.ru>
References: <9e4733910809131554mb0c6660r3bcc993bb2ca082d@mail.gmail.com>
	<adaljxvir57.fsf@cisco.com>
	<9e4733910809131623pe990495l96b31bd546d9fa6b@mail.gmail.com>
	<9e4733910809140706i599d70b2q12d3582c7a95498c@mail.gmail.com>
	<9e4733910809141625u3cd94e7jf05584031be7c1d9@mail.gmail.com>
	<9e4733910809142006x350e96abs6af304d8807ccd67@mail.gmail.com>
	<20080916121740.GA9970@oksana.dev.rtsoft.ru>
	<9e4733910809160537s67812bf5x3d4d46a384f8237f@mail.gmail.com>
	<20080916131203.GA21641@oksana.dev.rtsoft.ru>
	<9e4733910809160636heaa545eld0da835b2d163811@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <9e4733910809160636heaa545eld0da835b2d163811@mail.gmail.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>, Roland Dreier <rdreier@cisco.com>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Sep 16, 2008 at 09:36:22AM -0400, Jon Smirl wrote:
[...]
> >> >> -/*
> >> >> - * Not implemented, yet.
> >> >> - */
> >> >> -static inline int gpio_to_irq(unsigned int gpio)
> >> >> +static inline unsigned int gpio_to_irq(unsigned int gpio)
> >> >>  {
> >> >> -       return -ENOSYS;
> >> >> +       return gpio;
> >> >
> >> > "GPIO 0" is valid gpio, but "IRQ 0" isn't valid virq. So you
> >> > can't do 1:1 mapping. :-(
> >>
> >> I changed the GPIO numbers inside of Linux to match the virqs.
> >>
> >>       ofchip->gc.base             = IRQ_GPIO_WKUP(0);
> >
> > Well, I didn't say that it will not work, what I'm trying to say
> > is that I don't quite like the idea of 1:1 mapping for all gpio
> > chips.
> >
> > It is error prone, i.e. gpio_to_irq() can't fail, so you can't
> > tell if gpio to irq translation really happened or not. Plus
> > we might decide to not do 1:1 mapping for other gpio chips.
> 
> From reading the ARM code my understanding is that gpio_to_irq() and
> irq_to_gpio() are meant to be fast paths without error checking.

Nope. gpio_to_irq and irq_to_gpio don't have to be fast.

> In
> the gpiolib doc it says these functions should only take a couple of
> instructions.

This is for gpio_get/set_value and gpio_set_direction*.

> You'll detect errors if you take an invalid IRQ from the function and
> feed it into any of the rest of the IRQ API.

Assume that GPIO 8 does not translate to any IRQ, but IRQ 8 is still
valid virq b/c it is mapped for another IRQ controller (particularly
lots of kernel code assumes that IRQ 8 is 8259 PIC's CMOS interrupt,
the PIC and IRQ8 is widely used on PowerPC).

So gpio_to_irq will succeed, and request_irq will succeed too. Though
this would be not correct.

> The idea for setting the GPIO number equal to the VIRQ number came out
> of the ARM code. Making GPIO==VIRQ greatly simplified the code.

Adding .to_irq callback won't complicate code either, but will let
you do the things right.

As for the ARM code... ARM has been using GPIO API long before
GPIOLIB, and back then you didn't have many options.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
