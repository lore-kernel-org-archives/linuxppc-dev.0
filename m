Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 8BE4ADDF07
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Dec 2007 04:07:40 +1100 (EST)
Date: Wed, 12 Dec 2007 20:10:43 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH RFC 1/7] [POWERPC] Implement GPIO API embryo
Message-ID: <20071212171043.GA32725@localhost.localdomain>
References: <20071210204705.GA31263@localhost.localdomain>
	<20071210204825.GA32278@localhost.localdomain>
	<20071212164847.GC4329@loki.buserror.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20071212164847.GC4329@loki.buserror.net>
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Dec 12, 2007 at 10:48:47AM -0600, Scott Wood wrote:
> On Mon, Dec 10, 2007 at 11:48:25PM +0300, Anton Vorontsov wrote:
> > diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> > index 232c298..596982f 100644
> > --- a/arch/powerpc/Kconfig
> > +++ b/arch/powerpc/Kconfig
> > @@ -73,6 +73,10 @@ config GENERIC_FIND_NEXT_BIT
> >  	bool
> >  	default y
> >  
> > +config GENERIC_GPIO
> > +	bool
> > +	default n
> > +
> 
> default n is the default.  No need to explicitly state it.

Thanks, fill fix.

> > +
> > +int __of_parse_gpio_bank_pin(struct device_node *np, int index,
> > +			     int bank_width, int max_bank)
> 
> Why the leading underscores?

This is low-level helper/library function, used by gpio controllers to
parse "bank pin" gpio = <> scheme. To denote that this isn't some kind
of API leading underscores are used.

> > diff --git a/include/asm-powerpc/gpio.h b/include/asm-powerpc/gpio.h
> > new file mode 100644
> > index 0000000..f7513ff
> > --- /dev/null
> > +++ b/include/asm-powerpc/gpio.h
> > @@ -0,0 +1,51 @@
> > +/*
> > + * Generic GPIO API implementation for PowerPC.
> 
> Is there anything really powerpc specific here, or should it go under
> drivers/of?

Because <asm/gpio.h> should be used by all architectures to match
generic GPIO API. asm-sh/gpio.h asm-arm/gpio.h asm-avr32/gpio.h
and so on.

The only thing I can place into of.h is
- - - -
/*
 * OF specific gpio_chip handler.
 */
struct of_gpio_chip {
        int (*xlate)(struct device_node *np, int index);
};
- - - -

But frankly speaking, of_gpio_chip could be architecture-specific
too.

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
