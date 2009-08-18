Return-Path: <avorontsov@ru.mvista.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 03D48B707B
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 19 Aug 2009 07:33:59 +1000 (EST)
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 90B04DDD01
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Aug 2009 07:33:57 +1000 (EST)
Date: Wed, 19 Aug 2009 01:33:55 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Michael Barkowski <michaelbarkowski@ruggedcom.com>
Subject: Re: [PATCH v2] qe_lib: Set gpio data before changing the direction
	to output
Message-ID: <20090818213355.GA20966@oksana.dev.rtsoft.ru>
References: <4A8B164E.6030704@ruggedcom.com>
	<20090818210805.GA1725@oksana.dev.rtsoft.ru>
	<4A8B1B2C.5090606@ruggedcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <4A8B1B2C.5090606@ruggedcom.com>
Cc: linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 18, 2009 at 05:20:44PM -0400, Michael Barkowski wrote:
> This avoids having a short glitch if the desired initial value is not
> the same as what was previously in the data register.
> 
> Signed-off-by: Michael Barkowski <michaelbarkowski@ruggedcom.com>

Acked-by: Anton Vorontsov <avorontsov@ru.mvista.com>

Thanks!

> ---
> Anton Vorontsov wrote:
> > There is a recursive locking bug: _set() takes the same spinlock.
> > So you'd better move this call two lines upper. Otherwise the
> > patch looks OK.
> > 
> > Thanks!
> 
> Thanks - here is v2.
> 
>  arch/powerpc/sysdev/qe_lib/gpio.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/sysdev/qe_lib/gpio.c b/arch/powerpc/sysdev/qe_lib/gpio.c
> index 3485288..8e7a776 100644
> --- a/arch/powerpc/sysdev/qe_lib/gpio.c
> +++ b/arch/powerpc/sysdev/qe_lib/gpio.c
> @@ -105,14 +105,14 @@ static int qe_gpio_dir_out(struct gpio_chip *gc, unsigned int gpio, int val)
>  	struct qe_gpio_chip *qe_gc = to_qe_gpio_chip(mm_gc);
>  	unsigned long flags;
>  
> +	qe_gpio_set(gc, gpio, val);
> +
>  	spin_lock_irqsave(&qe_gc->lock, flags);
>  
>  	__par_io_config_pin(mm_gc->regs, gpio, QE_PIO_DIR_OUT, 0, 0, 0);
>  
>  	spin_unlock_irqrestore(&qe_gc->lock, flags);
>  
> -	qe_gpio_set(gc, gpio, val);
> -
>  	return 0;
>  }
>  
> -- 
> 1.6.3.3
> 

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
