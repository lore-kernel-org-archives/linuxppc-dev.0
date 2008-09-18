Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 75E40DDE0D
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Sep 2008 21:20:23 +1000 (EST)
Date: Thu, 18 Sep 2008 15:20:20 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: [PATCH v2] powerpc: implement support for MPC8349-compatible
	SOC GPIOs
Message-ID: <20080918112020.GA11584@oksana.dev.rtsoft.ru>
References: <20080917175820.GA22539@oksana.dev.rtsoft.ru>
	<871vziwoxj.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <871vziwoxj.fsf@macbook.be.48ers.dk>
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

On Wed, Sep 17, 2008 at 09:30:16PM +0200, Peter Korsgaard wrote:
> >>>>> "Anton" == Anton Vorontsov <avorontsov@ru.mvista.com> writes:
> 
> Hi,
> 
>  Anton> This patch implements GPIOLIB support for MPC8349-compatible SOC GPIOs.
>  Anton> MPC8610 adopted this GPIO unit, so let's place it into sysdev.
> 
>  Anton> We'll need these gpios to support IrDA transceiver on MPC8610HPCD.
> 
> It seems basically the same as my patch (gpio driver for
> mpc831x/mpc834x/mpc837x with OF bindings) from September 5th except
> you don't have any documentation

Well, do we really need documentation for every trivial gpio controller?
The bindings are the same, only different compatible entries...

If we do need the documentation for this, I can readily include it.

> and the Kconfig doesn't depend on
> 831x/834x/837x.

This is purposely. We also need support for 8610, and maybe
later we'll find another chip with the same unit. So, to not touch
the Kconfig for every new chip I just made it PPC32-wide. Other
option is to depend on FSL_SOC, but the driver really does not
depend on any fsl_soc stuff...

> Galak, did you have time to look at these patches yet?
> 
>  Anton> +struct fsl_gpio_chip {
>  Anton> +	struct of_mm_gpio_chip mm_gc;
>  Anton> +	spinlock_t lock;
>  Anton> +
>  Anton> +	/* shadowed data register to clear/set bits safely */
>  Anton> +	u32 gpdat;
> 
> Why do you need this when you have the lock?

See this discussion:

http://www.mail-archive.com/linuxppc-dev@ozlabs.org/msg12299.html

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
