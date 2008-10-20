Return-Path: <david-b@pacbell.net>
Received: from smtp125.sbc.mail.sp1.yahoo.com (smtp125.sbc.mail.sp1.yahoo.com
	[69.147.65.184]) by ozlabs.org (Postfix) with SMTP id D7143DDDEC
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Oct 2008 18:30:05 +1100 (EST)
From: David Brownell <david-b@pacbell.net>
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH 4/7] gpiolib: implement dev_gpiochip_{add,remove} calls
Date: Mon, 20 Oct 2008 00:29:57 -0700
References: <20081016171222.GA24812@oksana.dev.rtsoft.ru>
	<200810171324.42650.david-b@pacbell.net>
	<20081017212942.GA1919@oksana.dev.rtsoft.ru>
In-Reply-To: <20081017212942.GA1919@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200810200029.58312.david-b@pacbell.net>
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	i2c@lm-sensors.org, Jean Delvare <khali@linux-fr.org>,
	David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 17 October 2008, Anton Vorontsov wrote:
> On Fri, Oct 17, 2008 at 01:24:42PM -0700, David Brownell wrote:
> > On Thursday 16 October 2008, Anton Vorontsov wrote:
> > > +/*
> > > + * Platforms can define their own __dev_ versions to glue gpio_chips with the
> > > + * architecture-specific code.
> > > + */
> > > +#ifndef __dev_gpiochip_add
> > > +#define __dev_gpiochip_add __dev_gpiochip_add
> > > +static inline int __dev_gpiochip_add(struct device *dev,
> > > +                                    struct gpio_chip *chip)
> > > +{
> > > +       chip->dev = dev;
> > > +       return gpiochip_add(chip);
> > > +}
> > > +#endif /* __dev_gpiochip_add */
> > 
> > This is pretty ugly, especially the implication that *EVERY* gpio_chip
> > provider needs modification to use these calls.
> 
> Anyway most of them need some modifications to work with OF...

The changes I saw were just to cope with not having
the system-specific platform_data provided:  don't
fail if that pointer is NULL, and arrange for dynamic
allocation of some GPIO numbers.

With OpenFirmware, presumably the implication is that
the relevant data is in the OF device tree...


I think that it *barely* makes sense to allow the chips
to bind to drivers without platform data when there's
not even OF in the environment.  ONLY in the case where
the GPIOs are exported through sysfs, in fact, since
otherwise there's no way for other system components
to know those GPIOs even exist!!  And even that seems
pretty marginal to me...


> > Surely it would be a lot simpler to just add platform-specific hooks
> > to gpiochip_{add,remove}(), [...]
> 
> We have printk and dev_printk. kzalloc and devm_kzalloc (though I
> aware that devm_ are different than just dev_).  So I thought that
> dev_gpiochip_* would be logical order of things...

Those aren't platform hook mechanisms though, and
there's no need to modify every driver to use them
in order to work *at all* on OpenFirmware systems.


> If you don't like it, I can readily implement hooks for
> gpiochip_{add,remove}().

It seems a better way to a clean solution, IMO.  For
example, the OF hook for adding a gpio_chip might
know that it's got to stuff chip->base with a number
other than "-1" (say, "42") since that was stored in
some property of the device's OF shadow, and other
devices have properties associating them with GPIO
numbers derived from that (3rd gpio on that chip,
42 + 3 == 45) and so forth.

That said ... there's a LOT of configuration that
doesn't seem to me like it can be generic.  Pullups,
pulldowns, default values, polarity inversion,
what devices depend on those GPIOs being available
before they can come up (GPIO leds and power switches
come quickly to mind), all kinds of chip-specific
details, and more.

Did you look at providing chip-aware OF glue drivers
for this stuff?  Doing stuff like just turn the OF
device properties into the right platform_data, and
maybe runing FORTH bytecodes to do other configuration
magic needed...

- Dave
