Return-Path: <linus.walleij@linaro.org>
Received: from mail-oa0-f46.google.com (mail-oa0-f46.google.com
 [209.85.219.46])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D09A22C00E2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Nov 2013 20:49:56 +1100 (EST)
Received: by mail-oa0-f46.google.com with SMTP id o6so2076886oag.5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Nov 2013 01:49:52 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1384499789-3631-1-git-send-email-Gang.Liu@freescale.com>
References: <1384499789-3631-1-git-send-email-Gang.Liu@freescale.com>
Date: Tue, 19 Nov 2013 10:49:52 +0100
Message-ID: <CACRpkdaZnVn0N64XwxmjDPz0zTXSJvBLU76GBY3onGqKDHmrgw@mail.gmail.com>
Subject: Re: [PATCH] powerpc/gpio: Fix the wrong GPIO input data on
 MPC8572/MPC8536
From: Linus Walleij <linus.walleij@linaro.org>
To: Liu Gang <Gang.Liu@freescale.com>, Anatolij Gustschin <agust@denx.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>,
 r61911@freescale.com, b07421@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Nov 15, 2013 at 8:16 AM, Liu Gang <Gang.Liu@freescale.com> wrote:

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
>         struct mpc8xxx_gpio_chip *mpc8xxx_gc = to_mpc8xxx_gpio_chip(mm);
>
>         val = in_be32(mm->regs + GPIO_DAT) & ~in_be32(mm->regs + GPIO_DIR);
> +       mpc8xxx_gc->data &= in_be32(mm->regs + GPIO_DIR);
>
>         return (val | mpc8xxx_gc->data) & mpc8xxx_gpio2mask(gpio);
>  }

Anatolij, Ben: can either of you take a look at this patch and ACK it
if OK?

Yours,
Linus Walleij
