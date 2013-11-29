Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id AD9912C0085
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Nov 2013 21:54:50 +1100 (EST)
Date: Fri, 29 Nov 2013 11:54:43 +0100
From: Anatolij Gustschin <agust@denx.de>
To: Liu Gang <Gang.Liu@freescale.com>, <linus.walleij@linaro.org>
Subject: Re: [PATCH v2] powerpc/gpio: Fix the wrong GPIO input data on
 MPC8572/MPC8536
Message-ID: <20131129115443.2fb15bf8@crub>
In-Reply-To: <1385107960-373-1-git-send-email-Gang.Liu@freescale.com>
References: <1385107960-373-1-git-send-email-Gang.Liu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-gpio@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 r61911@freescale.com, b07421@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 22 Nov 2013 16:12:40 +0800
Liu Gang <Gang.Liu@freescale.com> wrote:

> For MPC8572/MPC8536, the status of GPIOs defined as output
> cannot be determined by reading GPDAT register, so the code
> use shadow data register instead. But the code may give the
> wrong status of GPIOs defined as input under some scenarios:
> 
> 1. If some pins were configured as inputs and were asserted
> high before booting the kernel, the shadow data has been
> initialized with those pin values.
> 2. Some pins have been configured as output first and have
> been set to the high value, then reconfigured as input.
> 
> The above cases will make the shadow data for those input
> pins to be set to high. Then reading the pin status will
> always return high even if the actual pin status is low.
> 
> The code should eliminate the effects of the shadow data to
> the input pins, and the status of those pins should be
> read directly from GPDAT.
> 
> Signed-off-by: Liu Gang <Gang.Liu@freescale.com>
> ---
> changes in v2:
>  - Added more description of the problem.
>  - Reduced one in_be32() call.
>  - Do not modify the shadow data.
> 
>  drivers/gpio/gpio-mpc8xxx.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-mpc8xxx.c b/drivers/gpio/gpio-mpc8xxx.c
> index 914e859..d7d6d72 100644
> --- a/drivers/gpio/gpio-mpc8xxx.c
> +++ b/drivers/gpio/gpio-mpc8xxx.c
> @@ -70,10 +70,14 @@ static int mpc8572_gpio_get(struct gpio_chip *gc, unsigned int gpio)
>  	u32 val;
>  	struct of_mm_gpio_chip *mm = to_of_mm_gpio_chip(gc);
>  	struct mpc8xxx_gpio_chip *mpc8xxx_gc = to_mpc8xxx_gpio_chip(mm);
> +	u32 out_mask, out_shadow;
>  
> -	val = in_be32(mm->regs + GPIO_DAT) & ~in_be32(mm->regs + GPIO_DIR);
> +	out_mask = in_be32(mm->regs + GPIO_DIR);
>  
> -	return (val | mpc8xxx_gc->data) & mpc8xxx_gpio2mask(gpio);
> +	val = in_be32(mm->regs + GPIO_DAT) & ~out_mask;
> +	out_shadow = mpc8xxx_gc->data & out_mask;
> +
> +	return (val | out_shadow) & mpc8xxx_gpio2mask(gpio);
>  }
>  
>  static int mpc8xxx_gpio_get(struct gpio_chip *gc, unsigned int gpio)

Acked-by: Anatolij Gustschin <agust@denx.de>
