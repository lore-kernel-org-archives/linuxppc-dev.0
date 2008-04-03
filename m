Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 7B0CBDE0C6
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Apr 2008 23:18:44 +1100 (EST)
Date: Thu, 3 Apr 2008 16:18:48 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Laurent Pinchart <laurentp@cse-semaphore.com>
Subject: Re: [PATCH 2/4] [POWERPC] Implement support for the GPIO LIB API
Message-ID: <20080403121848.GA16186@polina.dev.rtsoft.ru>
References: <20080311184012.GA28466@localhost.localdomain>
	<20080311184220.GB32164@localhost.localdomain>
	<200804031305.53469.laurentp@cse-semaphore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <200804031305.53469.laurentp@cse-semaphore.com>
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 03, 2008 at 01:05:51PM +0200, Laurent Pinchart wrote:
> Hi Anton,
> 
> On Tuesday 11 March 2008 19:42, Anton Vorontsov wrote:
> > This patch implements support for the GPIO LIB API. Two calls
> > unimplemented though: irq_to_gpio and gpio_to_irq.
> > 
> > Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> > ---
> >  Documentation/powerpc/booting-without-of.txt |   52 ++++++++++++++++++++++++
> >  arch/powerpc/Kconfig                         |    5 ++
> >  include/asm-powerpc/gpio.h                   |   55 ++++++++++++++++++++++++++
> >  3 files changed, 112 insertions(+), 0 deletions(-)
> >  create mode 100644 include/asm-powerpc/gpio.h
> 
> [snip]
> 
> > diff --git a/include/asm-powerpc/gpio.h b/include/asm-powerpc/gpio.h
> > new file mode 100644
> > index 0000000..057840d
> > --- /dev/null
> > +++ b/include/asm-powerpc/gpio.h
> > @@ -0,0 +1,55 @@
> > +/*
> > + * Generic GPIO API implementation for PowerPC.
> > + *
> > + * Copyright (c) 2007-2008  MontaVista Software, Inc.
> > + *
> > + * Author: Anton Vorontsov <avorontsov@ru.mvista.com>
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License as published by
> > + * the Free Software Foundation; either version 2 of the License, or
> > + * (at your option) any later version.
> > + */
> > +
> > +#ifndef __ASM_POWERPC_GPIO_H
> > +#define __ASM_POWERPC_GPIO_H
> > +
> > +#include <asm-generic/gpio.h>
> > +
> > +#ifdef CONFIG_HAVE_GPIO_LIB
> > +
> > +/*
> > + * We don't (yet) implement inlined/rapid versions for on-chip gpios.
> > + * Just call gpiolib.
> > + */
> > +static inline int gpio_get_value(unsigned int gpio)
> > +{
> > +	return __gpio_get_value(gpio);
> > +}
> > +
> > +static inline void gpio_set_value(unsigned int gpio, int value)
> > +{
> > +	__gpio_set_value(gpio, value);
> > +}
> > +
> > +static inline int gpio_cansleep(unsigned int gpio)
> > +{
> > +	return __gpio_cansleep(gpio);
> > +}
> > +
> > +/*
> > + * Not implemented, yet.
> > + */
> > +static inline int gpio_to_irq(unsigned int gpio)
> > +{
> > +	return -ENOSYS;
> > +}
> > +
> > +static inline int irq_to_gpio(unsigned int irq)
> > +{
> > +	return -EINVAL;
> > +}
> 
> You should include <linux/errno.h>.

Yeah, much thanks for catching this!

-- 
Anton Vorontsov
email: cboumailru@gmail.com
irc://irc.freenode.net/bd2
