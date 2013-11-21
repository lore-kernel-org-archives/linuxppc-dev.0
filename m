Return-Path: <scottwood@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe002.messaging.microsoft.com [207.46.163.25])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8B10C2C00F9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Nov 2013 11:33:16 +1100 (EST)
Message-ID: <1384993966.1403.466.camel@snotra.buserror.net>
Subject: Re: [PATCH] powerpc/gpio: Fix the wrong GPIO input data on
 MPC8572/MPC8536
From: Scott Wood <scottwood@freescale.com>
To: Liu Gang <Gang.Liu@freescale.com>
Date: Wed, 20 Nov 2013 18:32:46 -0600
In-Reply-To: <1384916079.16677.26.camel@linux>
References: <1384499789-3631-1-git-send-email-Gang.Liu@freescale.com>
 <1384901494.1403.383.camel@snotra.buserror.net>
 <1384916079.16677.26.camel@linux>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linux-gpio@vger.kernel.org, linus.walleij@linaro.org,
 linuxppc-dev@lists.ozlabs.org, r61911@freescale.com, b07421@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-11-20 at 10:54 +0800, Liu Gang wrote:
> On Tue, 2013-11-19 at 16:51 -0600, Scott Wood wrote:
> > > @@ -71,6 +71,7 @@ static int mpc8572_gpio_get(struct gpio_chip *gc, unsigned int gpio)
> > >  	struct mpc8xxx_gpio_chip *mpc8xxx_gc = to_mpc8xxx_gpio_chip(mm);
> > >  
> > >  	val = in_be32(mm->regs + GPIO_DAT) & ~in_be32(mm->regs + GPIO_DIR);
> > > +	mpc8xxx_gc->data &= in_be32(mm->regs + GPIO_DIR);
> > >  
> > >  	return (val | mpc8xxx_gc->data) & mpc8xxx_gpio2mask(gpio);
> > >  }
> > 
> > It seems odd to update ->data in a function that's supposed to be
> > reading things...  Perhaps it would be better to keep ->data in a good
> > state from the beginning.
> > 
> > -Scott
> 
> Yes, keeping the ->data in a good state from the beginning will be
> better. But this will need more code in different functions to cover
> all the scenarios.
> First, we should check the direct of the pin in the function
> "mpc8xxx_gpio_set", and clean the input bit in ->data after setting
> operation.

For userspace value setting, it looks like gpiolib blocks the write if
the pin if FLAG_IS_OUT is set.  This suggests that this is an error
condition for other uses as well.  Though, I notice that
mpc8xxx_gpio_dir_out() calls gpio_set() before actually changing the
direction.  So it may be useful to avoid races where the wrong value is
output briefly after the direction is changed (especially in open drain
situations, where the signal could have a meaningful default even before
we begin outputting).  But that raises the question of how you'd do that
from userspace, and it also renders the to-be-output value as write-only
data (until the direction is actually changed), since a readback would
get the input value instead.

> So maybe it's better to eliminate the effects of the ->data to the
> input pins when reading the status, regardless of the possible changes
> of the pins and the data.
> Do you think so?

Perhaps, but that doesn't require you to modify ->data in the get()
function.

-Scott
