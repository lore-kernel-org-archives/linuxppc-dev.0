Return-Path: <scottwood@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0184.outbound.messaging.microsoft.com [213.199.154.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E2BEC2C014D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Nov 2013 09:51:45 +1100 (EST)
Message-ID: <1384901494.1403.383.camel@snotra.buserror.net>
Subject: Re: [PATCH] powerpc/gpio: Fix the wrong GPIO input data on
 MPC8572/MPC8536
From: Scott Wood <scottwood@freescale.com>
To: Liu Gang <Gang.Liu@freescale.com>
Date: Tue, 19 Nov 2013 16:51:34 -0600
In-Reply-To: <1384499789-3631-1-git-send-email-Gang.Liu@freescale.com>
References: <1384499789-3631-1-git-send-email-Gang.Liu@freescale.com>
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

On Fri, 2013-11-15 at 15:16 +0800, Liu Gang wrote:
> For MPC8572/MPC8536, the status of GPIOs defined as output
> cannot be determined by reading GPDAT register, so the code
> use shadow data register instead. But if the input pins are
> asserted high, they will always read high due to the shadow
> data, even if the pins are set to low.
> 
> So the input pins should be read directly from GPDAT, not
> the shadow data.
> 
> Signed-off-by: Liu Gang <Gang.Liu@freescale.com>
> ---
>  drivers/gpio/gpio-mpc8xxx.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpio/gpio-mpc8xxx.c b/drivers/gpio/gpio-mpc8xxx.c
> index 9ae29cc..1d4ac75 100644
> --- a/drivers/gpio/gpio-mpc8xxx.c
> +++ b/drivers/gpio/gpio-mpc8xxx.c
> @@ -71,6 +71,7 @@ static int mpc8572_gpio_get(struct gpio_chip *gc, unsigned int gpio)
>  	struct mpc8xxx_gpio_chip *mpc8xxx_gc = to_mpc8xxx_gpio_chip(mm);
>  
>  	val = in_be32(mm->regs + GPIO_DAT) & ~in_be32(mm->regs + GPIO_DIR);
> +	mpc8xxx_gc->data &= in_be32(mm->regs + GPIO_DIR);
>  
>  	return (val | mpc8xxx_gc->data) & mpc8xxx_gpio2mask(gpio);
>  }

It seems odd to update ->data in a function that's supposed to be
reading things...  Perhaps it would be better to keep ->data in a good
state from the beginning.

-Scott
