Return-Path: <glikely@secretlab.ca>
Received: from mail-iw0-f203.google.com (mail-iw0-f203.google.com
	[209.85.223.203]) by ozlabs.org (Postfix) with ESMTP id 0F051B7D0C
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Feb 2010 04:08:21 +1100 (EST)
Received: by iwn41 with SMTP id 41so2832755iwn.9
	for <linuxppc-dev@ozlabs.org>; Tue, 09 Feb 2010 09:08:20 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20100205203236.GC1475@oksana.dev.rtsoft.ru>
References: <20100205203201.GA32281@oksana.dev.rtsoft.ru>
	<20100205203236.GC1475@oksana.dev.rtsoft.ru>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 9 Feb 2010 10:08:00 -0700
Message-ID: <fa686aa41002090908tbeed469k417af2a59757f8a@mail.gmail.com>
Subject: Re: [PATCH 3/4] of/gpio: Implement GPIOLIB notifier hooks
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Bill Gatliff <bgat@billgatliff.com>,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Feb 5, 2010 at 1:32 PM, Anton Vorontsov
<avorontsov@ru.mvista.com> wrote:
> This patch implements GPIOLIB notifier hooks, and thus makes device-enabl=
ed
> GPIO chips (i.e. the ones that have gpio_chip->dev specified) automatical=
ly
> attached to the OpenFirmware subsystem. Which means that now we can handl=
e
> I2C and SPI GPIO chips almost* transparently.
>
> * "Almost" because some chips still require platform data, and for these
> =A0chips OF-glue is still needed, though with this support the glue will
> =A0be much smaller.
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
> =A0drivers/of/gpio.c | =A0100 +++++++++++++++++++++++++++++++++++++++++++=
++++++++++
> =A01 files changed, 100 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/of/gpio.c b/drivers/of/gpio.c
> index 12c4af0..9d8df77 100644
> --- a/drivers/of/gpio.c
> +++ b/drivers/of/gpio.c
> @@ -13,6 +13,7 @@
>
> =A0#include <linux/kernel.h>
> =A0#include <linux/errno.h>
> +#include <linux/notifier.h>
> =A0#include <linux/io.h>
> =A0#include <linux/of.h>
> =A0#include <linux/of_gpio.h>
> @@ -236,3 +237,102 @@ err0:
> =A0 =A0 =A0 =A0return ret;
> =A0}
> =A0EXPORT_SYMBOL(of_mm_gpiochip_add);
> +
> +/**
> + * of_gpiochip_register_simple - Register a chip with the OF GPIO subsys=
tem
> + * @chip =A0 =A0 =A0 pointer to a GPIO chip
> + * @np: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0device node to register the GPIO =
chip with
> + *
> + * This function registers a GPIO chip with the OF infrastructure. It is
> + * assumed that the chip was previsously allocated and added to a generi=
c
> + * GPIOLIB framework (using gpiochip_add() function).
> + *
> + * The `simple' name means that the chip is using simple two-cells schem=
e for
> + * the gpio-specifier.
> + */
> +static int of_gpiochip_register_simple(struct gpio_chip *chip,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0struct device_node *np)
> +{
> + =A0 =A0 =A0 struct of_gpio_chip *of_gc;
> +
> + =A0 =A0 =A0 if (np->data) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 WARN_ON(1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EBUSY;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 of_gc =3D kzalloc(sizeof(*of_gc), GFP_KERNEL);
> + =A0 =A0 =A0 if (!of_gc)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> +
> + =A0 =A0 =A0 of_gc->gpio_cells =3D 2;
> + =A0 =A0 =A0 of_gc->xlate =3D of_gpio_simple_xlate;
> + =A0 =A0 =A0 of_gc->chip =3D chip;

One concern.

How does an OF-aware GPIO driver override these settings?  What is to
be done when a GPIO chip requires a different xlate hook?  Or a
different number of gpio_cells?

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
