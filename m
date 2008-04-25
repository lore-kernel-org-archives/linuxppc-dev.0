Return-Path: <sha@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2BF57DDF6A
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Apr 2008 20:51:08 +1000 (EST)
Date: Fri, 25 Apr 2008 12:53:33 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] add gpiolib support for mpc5200
Message-ID: <20080425105333.GM6692@pengutronix.de>
References: <20080424153659.GJ6692@pengutronix.de>
	<fa686aa40804241145x39165ffp78108c53d0d5a911@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <fa686aa40804241145x39165ffp78108c53d0d5a911@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 24, 2008 at 12:45:49PM -0600, Grant Likely wrote:
> On Thu, Apr 24, 2008 at 9:36 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> > Hi all,
> >
> >  Feel free to comment on this.
> >
> >  Sascha
> >
> >
> >  This patch adds gpiolib support for mpc5200 SOCs. I'm not sure
> >  whether it's a good idea to make this optional via kconfig.
> >  The gpt devices only support a single gpio. In the current of_gpio
> >  implementation each chip consumes 32 GPIOs which leads to huge
> >  gaps.
> >
> >  Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> 
> Looks pretty good.  You've saved me the need to go write a driver
> myself.  Comments below, but I'll pull it into my tree and give it a
> spin.
> 
> I don't see any mechanism for setting the open drain state of the pin.
>  That will either need to be done by platform code or encoded into the
> device tree.  Does the OF gpio infrastructure provide any callback to
> the driver when something requests the pin?  That would seem to be the
> ideal place to set the open drain state.

No, unfortunately not. The generic gpio stuff does not provide this
callback, so of gpio has no chance to do so.
This would also be a good place to catch the registration of reserved
pins, so maybe it's worth discussing this with the gpiolib maintainers.


> 
> You'll also need to document the format of the gpio pin specifier for
> these devices (ie. first cell is GPIO number, second cell is ????).

I've taken the two-cell approach from booting-without-of.txt. There the
second cell is for flags. We could encode the open drain state into
this.

> 
> As for the wide spans caused by gpt gpios, it is probably okay for
> now, but we can rework it to do something clever (like have a single
> registration for all gpt gpios) at a later date.

I would rather teach the of gpio infrastructure not to reserve 32 gpios
for each chip. This will bite us once we want to support gpio chips with
more than 32 gpios anyway.

> >  + *
> >  + */
> >  +static int mpc52xx_wkup_gpio_get(struct gpio_chip *gc, unsigned int gpio)
> >  +{
> >  +       struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
> >  +       struct mpc52xx_gpio_wkup __iomem *regs = mm_gc->regs;
> >  +       unsigned int ret;
> >  +
> >  +       ret = (in_8(&regs->wkup_ival) >> (7 - gpio)) & 1;
> >  +
> >  +       pr_debug("%s: gpio: %d ret: %d\n", __func__, gpio, ret);
> 
> dev_dbg maybe?

We would have to carry the device from the probe function to this
function just for the debugging output. I'm not sure if it's worth it.

> 
> >  +
> >  +       return ret;
> >  +}
> >  +
> >  +static void mpc52xx_wkup_gpio_set(struct gpio_chip *gc, unsigned int gpio, int val)
> >  +{
> >  +       struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
> >  +       struct mpc52xx_gpio_wkup __iomem *regs = mm_gc->regs;
> >  +       unsigned int tmp;
> >  +       unsigned long flags;
> >  +
> >  +       spin_lock_irqsave(&gpio_lock, flags);
> >  +
> >  +       tmp = in_8(&regs->wkup_dvo);
> >  +       if (val)
> >  +               tmp |= 1 << (7 - gpio);
> >  +       else
> >  +               tmp &= ~(1 << (7 - gpio));
> >  +       out_8(&regs->wkup_dvo, tmp);
> 
> Rather than read/modify/write of the device register; the function
> would probably be faster (one fewer barrier) if you used a shadow
> register of the pin state and the critical region would be
> shorter/simpler.  Also, while this device doesn't have the side
> effects associated with shared input/output register, it might still
> be good form to use a shadow register just for the sake of clarity.

OK

> 
> >  +
> >  +       spin_unlock_irqrestore(&gpio_lock, flags);
> >  +
> >  +       pr_debug("%s: gpio: %d val: %d\n", __func__, gpio, val);
> >  +}
> >  +
> >  +static int mpc52xx_wkup_gpio_dir_in(struct gpio_chip *gc, unsigned int gpio)
> >  +{
> >  +       struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
> >  +       struct mpc52xx_gpio_wkup *regs = mm_gc->regs;
> >  +       unsigned int tmp;
> >  +       unsigned long flags;
> >  +
> >  +       spin_lock_irqsave(&gpio_lock, flags);
> >  +
> >  +       tmp = in_8(&regs->wkup_ddr);
> >  +       tmp &= ~(1 << (7 - gpio));
> >  +       out_8(&regs->wkup_ddr, tmp);
> >  +
> >  +       spin_unlock_irqrestore(&gpio_lock, flags);
> >  +
> >  +       return 0;
> >  +}
> >  +
> >  +static int mpc52xx_wkup_gpio_dir_out(struct gpio_chip *gc, unsigned int gpio, int val)
> >  +{
> >  +       struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
> >  +       struct mpc52xx_gpio_wkup *regs = mm_gc->regs;
> >  +       unsigned int tmp;
> >  +       unsigned long flags;
> >  +
> >  +       /* First set initial value */
> >  +       mpc52xx_wkup_gpio_set(gc, gpio, val);
> >  +
> >  +       spin_lock_irqsave(&gpio_lock, flags);
> >  +
> >  +       /* Then set direction */
> >  +       tmp = in_8(&regs->wkup_ddr);
> >  +       tmp |= 1 << (7 - gpio);
> >  +       out_8(&regs->wkup_ddr, tmp);
> >  +
> >  +       /* Finally enable the pin */
> >  +       tmp = in_8(&regs->wkup_gpioe);
> >  +       tmp |= 1 << (7 - gpio);
> >  +       out_8(&regs->wkup_gpioe, tmp);
> 
> Do you want/need the cost of enabling the pin every time dir_out is
> called?  Can it be done when the pin is requested instead?  Or by the
> board firmware/platform code?  Some drivers (for example the i2c
> bitbang driver for the clock signal; see i2c-gpio.c) change the state
> by changing the direction of the pin.

I changed this to use shadow registers aswell, so we have two fewer register
accesses. I don't have a good feeling about enabling the pins in the
platform code because at the moment we can change the gpio routing without
recompiling the kernel.

Just to know what we are talking about I made some measurements. As a
first improvement I added a lockless inline version of gpio_set so that
we do not have to aqcuire the spinlock twice. With this I get a maximum
toggle frequency using gpio_direction_output() of 760 KHz. Without pin
enabling this frequency increases to 870 KHz. Using gpio_set_value() we
have 3.3 MHz.

See my other mail for an updated patch

Sascha

-- 
Pengutronix e.K. - Linux Solutions for Science and Industry
-----------------------------------------------------------
Kontakt-Informationen finden Sie im Header dieser Mail oder
auf der Webseite -> http://www.pengutronix.de/impressum/ <-
