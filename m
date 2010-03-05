Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A5E13B7BEE
	for <linuxppc-dev@ozlabs.org>; Sat,  6 Mar 2010 06:59:27 +1100 (EST)
Date: Fri, 5 Mar 2010 11:59:18 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 1/4] gpiolib: Introduce chip addition/removal notifier
Message-Id: <20100305115918.f6c75b12.akpm@linux-foundation.org>
In-Reply-To: <fa686aa41002090916w613efcb9te15e4969a880f724@mail.gmail.com>
References: <20100205203201.GA32281@oksana.dev.rtsoft.ru>
	<20100205203232.GA1475@oksana.dev.rtsoft.ru>
	<fa686aa41002090916w613efcb9te15e4969a880f724@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Bill Gatliff <bgat@billgatliff.com>,
	Anton Vorontsov <avorontsov@ru.mvista.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 9 Feb 2010 10:16:44 -0700
Grant Likely <grant.likely@secretlab.ca> wrote:

> On Fri, Feb 5, 2010 at 1:32 PM, Anton Vorontsov
> <avorontsov@ru.mvista.com> wrote:
> > Some platforms (e.g. OpenFirmware) want to know when a particular chip
> > added or removed, so that the platforms could add their specifics for
> > non-platform devices, like I2C or SPI GPIO chips.
> >
> > This patch implements the notifier for chip addition and removal events.
> >
> > Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> > ---
> > drivers/gpio/gpiolib.c   |  14 ++++++++++++++
> > include/asm-generic/gpio.h |  8 ++++++++
> > 2 files changed, 22 insertions(+), 0 deletions(-)
> >
> > diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> > index 350842a..375c03a 100644
> > --- a/drivers/gpio/gpiolib.c
> > +++ b/drivers/gpio/gpiolib.c
> > @@ -9,6 +9,7 @@
> > #include <linux/seq_file.h>
> > #include <linux/gpio.h>
> > #include <linux/idr.h>
> > +#include <linux/notifier.h>
> >
> >
> > /* Optional implementation infrastructure for GPIO interfaces.
> > @@ -1029,6 +1030,9 @@ static inline void gpiochip_unexport(struct gpio_chip *chip)
> >
> > #endif /* CONFIG_GPIO_SYSFS */
> >
> > +BLOCKING_NOTIFIER_HEAD(gpio_notifier);
> > +EXPORT_SYMBOL_GPL(gpio_notifier);
> > +
> > /**
> > * gpiochip_add() - register a gpio_chip
> > * @chip: the chip to register, with chip->base initialized
> > @@ -1103,6 +1107,9 @@ fail:
> >        pr_err("gpiochip_add: gpios %d..%d (%s) not registered\n",
> >            chip->base, chip->base + chip->ngpio - 1,
> >            chip->label ? : "generic");
> > +    else
> > +        blocking_notifier_call_chain(&gpio_notifier,
> > +                      GPIO_NOTIFY_CHIP_ADDED, chip);
> 
> Rather than doing an else block which will need to be reworked if/when
> any additional code is added to the bottom of this routine, please
> rework the if() block to bail on failure instead of implicitly falling
> through to the return statement.

This still hasn't happened.

> Otherwise, this patch looks okay to me, so you can go ahead and add my:
> 
> Acked-by: Grant Likely <grant.likely@secretlab.ca>
> 

I'll merge it anyway and will ask you guys to keep track of this issue,
thanks.
