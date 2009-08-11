Return-Path: <avorontsov@ru.mvista.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 3554FB6F31
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 11 Aug 2009 23:44:54 +1000 (EST)
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id C24FCDDD04
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Aug 2009 23:44:52 +1000 (EST)
Date: Tue, 11 Aug 2009 17:44:50 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Felix Radensky <felix@embedded-sol.com>
Subject: Re: [PATCH] powerpc/85xx: Workaround MPC8536 GPIO 1 errata.
Message-ID: <20090811134450.GA9820@oksana.dev.rtsoft.ru>
References: <>
 <1249981458-16102-1-git-send-email-felix@embedded-sol.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1249981458-16102-1-git-send-email-felix@embedded-sol.com>
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 11, 2009 at 12:04:18PM +0300, Felix Radensky wrote:
> On MPC8536 Rev 1.0 the status of GPIO pins configured
> as output cannot be determined by reading GPDAT register.
> Workaround by reading the status of input pins from GPDAT
> and the status of output pins from a shadow register.
> 
> Signed-off-by: Felix Radensky <felix@embedded-sol.com>
> ---
>  arch/powerpc/sysdev/mpc8xxx_gpio.c |    6 +++++-
>  1 files changed, 5 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/powerpc/sysdev/mpc8xxx_gpio.c b/arch/powerpc/sysdev/mpc8xxx_gpio.c
> index 103eace..0b996f3 100644
> --- a/arch/powerpc/sysdev/mpc8xxx_gpio.c
> +++ b/arch/powerpc/sysdev/mpc8xxx_gpio.c
> @@ -56,9 +56,13 @@ static void mpc8xxx_gpio_save_regs(struct of_mm_gpio_chip *mm)
>  
>  static int mpc8xxx_gpio_get(struct gpio_chip *gc, unsigned int gpio)
>  {
> +	u32 val;
>  	struct of_mm_gpio_chip *mm = to_of_mm_gpio_chip(gc);
> +	struct mpc8xxx_gpio_chip *mpc8xxx_gc = to_mpc8xxx_gpio_chip(mm);
> +	
> +	val = in_be32(mm->regs + GPIO_DAT) && ~in_be32(mm->regs + GPIO_DIR);

Are you sure about &&?

Plus, this are two reads instead of just one. I think it'll be better
to implement mpc8536_gpio_get(), and then do

if (of_device_is_compatible(np, ... 8536-gpio-bank ...))
	gc->get = mpc8536_gpio_get;
else
	gc->get = mpc8xxx_gpio_get;

> -	return in_be32(mm->regs + GPIO_DAT) & mpc8xxx_gpio2mask(gpio);
> +	return (val | mpc8xxx_gc->data) & mpc8xxx_gpio2mask(gpio);
>  }
>  
>  static void mpc8xxx_gpio_set(struct gpio_chip *gc, unsigned int gpio, int val)

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
