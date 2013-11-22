Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 5152C2C0141
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Nov 2013 07:52:18 +1100 (EST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1822\))
Subject: Re: [PATCH v2] powerpc/gpio: Fix the wrong GPIO input data on
 MPC8572/MPC8536
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1385107960-373-1-git-send-email-Gang.Liu@freescale.com>
Date: Fri, 22 Nov 2013 14:51:52 -0600
Message-Id: <D582D1B3-B20B-4860-B1DE-DDCD04B5D0BA@kernel.crashing.org>
References: <1385107960-373-1-git-send-email-Gang.Liu@freescale.com>
To: Liu Gang <Gang.Liu@freescale.com>
Cc: b07421@freescale.com, linus.walleij@linaro.org, r61911@freescale.com,
 linux-gpio@vger.kernel.org, agust@denx.de, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Nov 22, 2013, at 2:12 AM, Liu Gang <Gang.Liu@freescale.com> wrote:

> For MPC8572/MPC8536, the status of GPIOs defined as output
> cannot be determined by reading GPDAT register, so the code
> use shadow data register instead. But the code may give the
> wrong status of GPIOs defined as input under some scenarios:
>=20
> 1. If some pins were configured as inputs and were asserted
> high before booting the kernel, the shadow data has been
> initialized with those pin values.
> 2. Some pins have been configured as output first and have
> been set to the high value, then reconfigured as input.
>=20
> The above cases will make the shadow data for those input
> pins to be set to high. Then reading the pin status will
> always return high even if the actual pin status is low.
>=20
> The code should eliminate the effects of the shadow data to
> the input pins, and the status of those pins should be
> read directly from GPDAT.
>=20
> Signed-off-by: Liu Gang <Gang.Liu@freescale.com>
> ---
> changes in v2:
> - Added more description of the problem.
> - Reduced one in_be32() call.
> - Do not modify the shadow data.
>=20
> drivers/gpio/gpio-mpc8xxx.c | 8 ++++++--
> 1 file changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpio/gpio-mpc8xxx.c b/drivers/gpio/gpio-mpc8xxx.c
> index 914e859..d7d6d72 100644
> --- a/drivers/gpio/gpio-mpc8xxx.c
> +++ b/drivers/gpio/gpio-mpc8xxx.c
> @@ -70,10 +70,14 @@ static int mpc8572_gpio_get(struct gpio_chip *gc, =
unsigned int gpio)
> 	u32 val;
> 	struct of_mm_gpio_chip *mm =3D to_of_mm_gpio_chip(gc);
> 	struct mpc8xxx_gpio_chip *mpc8xxx_gc =3D =
to_mpc8xxx_gpio_chip(mm);
> +	u32 out_mask, out_shadow;
>=20
> -	val =3D in_be32(mm->regs + GPIO_DAT) & ~in_be32(mm->regs + =
GPIO_DIR);
> +	out_mask =3D in_be32(mm->regs + GPIO_DIR);
>=20
> -	return (val | mpc8xxx_gc->data) & mpc8xxx_gpio2mask(gpio);
> +	val =3D in_be32(mm->regs + GPIO_DAT) & ~out_mask;
> +	out_shadow =3D mpc8xxx_gc->data & out_mask;
> +
> +	return (val | out_shadow) & mpc8xxx_gpio2mask(gpio);
> }

I really think a comment is worth adding here about why we do this.

- k

>=20
> static int mpc8xxx_gpio_get(struct gpio_chip *gc, unsigned int gpio)
> --=20
> 1.8.4.1
>=20
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
