Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 08E04DDF37
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Oct 2008 08:29:44 +1100 (EST)
Date: Sat, 18 Oct 2008 01:29:42 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 4/7] gpiolib: implement dev_gpiochip_{add,remove} calls
Message-ID: <20081017212942.GA1919@oksana.dev.rtsoft.ru>
References: <20081016171222.GA24812@oksana.dev.rtsoft.ru>
	<20081016171259.GD5515@oksana.dev.rtsoft.ru>
	<200810171324.42650.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <200810171324.42650.david-b@pacbell.net>
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	i2c@lm-sensors.org, Jean Delvare <khali@linux-fr.org>,
	David Miller <davem@davemloft.net>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Oct 17, 2008 at 01:24:42PM -0700, David Brownell wrote:
> On Thursday 16 October 2008, Anton Vorontsov wrote:
> > +/*
> > + * Platforms can define their own __dev_ versions to glue gpio_chips with the
> > + * architecture-specific code.
> > + */
> > +#ifndef __dev_gpiochip_add
> > +#define __dev_gpiochip_add __dev_gpiochip_add
> > +static inline int __dev_gpiochip_add(struct device *dev,
> > +                                    struct gpio_chip *chip)
> > +{
> > +       chip->dev = dev;
> > +       return gpiochip_add(chip);
> > +}
> > +#endif /* __dev_gpiochip_add */
> 
> This is pretty ugly, especially the implication that *EVERY* gpio_chip
> provider needs modification to use these calls.

Anyway most of them need some modifications to work with OF...

> Surely it would be a lot simpler to just add platform-specific hooks
> to gpiochip_{add,remove}(), [...]

We have printk and dev_printk. kzalloc and devm_kzalloc (though I
aware that devm_ are different than just dev_).  So I thought that
dev_gpiochip_* would be logical order of things...

If you don't like it, I can readily implement hooks for
gpiochip_{add,remove}().


Thanks for the comments,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
