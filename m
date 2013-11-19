Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 9DDB42C00A9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Nov 2013 02:32:47 +1100 (EST)
Date: Tue, 19 Nov 2013 16:32:30 +0100
From: Anatolij Gustschin <agust@denx.de>
To: Liu Gang <Gang.Liu@freescale.com>
Subject: Re: [PATCH] powerpc/gpio: Fix the wrong GPIO input data on
 MPC8572/MPC8536
Message-ID: <20131119163230.70964d1f@crub>
In-Reply-To: <1384499789-3631-1-git-send-email-Gang.Liu@freescale.com>
References: <1384499789-3631-1-git-send-email-Gang.Liu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Fri, 15 Nov 2013 15:16:29 +0800
Liu Gang <Gang.Liu@freescale.com> wrote:

> For MPC8572/MPC8536, the status of GPIOs defined as output
> cannot be determined by reading GPDAT register, so the code
> use shadow data register instead. But if the input pins are
> asserted high, they will always read high due to the shadow
> data, even if the pins are set to low.

Could you please add a better description of the problem?
I'm having some difficulties to understand the last sentence
above. Does the issue appear if some pins were configured as
inputs and were asserted high before booting the kernel, and
therefore the shadow data has been initialized with these pin
values?

Or does the issue appear if some pin has been configured as output
first and has been set to the high value, then reconfigured as
input? Now reading the pin state will always return high even
if the actual pin state is low?

It seems the issue will appear in both cases. If so, please add
this information to the commit message.

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

we can reduce one in_be32() call here, i.e.

	u32 out_mask;
	...
	out_mask = in_be32(mm->regs + GPIO_DIR);
	val = in_be32(mm->regs + GPIO_DAT) & ~out_mask;
	mpc8xxx_gc->data &= out_mask;

>  	return (val | mpc8xxx_gc->data) & mpc8xxx_gpio2mask(gpio);
>  }

Thanks,

Anatolij

--
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0  Fax: +49-8142-66989-80 Email: office@denx.de
