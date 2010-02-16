Return-Path: <glikely@secretlab.ca>
Received: from mail-yw0-f195.google.com (mail-yw0-f195.google.com
	[209.85.211.195]) by ozlabs.org (Postfix) with ESMTP id 8C961B7D43
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Feb 2010 06:20:12 +1100 (EST)
Received: by ywh33 with SMTP id 33so5681988ywh.15
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Feb 2010 11:20:11 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <201001281448.42965.matthias.fuchs@esd-electronics.com>
References: <201001281448.42965.matthias.fuchs@esd-electronics.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 16 Feb 2010 12:19:50 -0700
Message-ID: <fa686aa41002161119x6eb41203rb73b888176ce5040@mail.gmail.com>
Subject: Re: [PATCH] powerpc/mpc512x: Add gpio driver
To: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Matthias.  Thanks for the patch.  Some comments below...

On Thu, Jan 28, 2010 at 6:48 AM, Matthias Fuchs
<matthias.fuchs@esd-electronics.com> wrote:
> Signed-off-by: Matthias Fuchs <matthias.fuchs@esd.eu>

Could use a commit log.  It is useful to give some details about what
this driver has been developed/tested on.

> ---
> =A0arch/powerpc/include/asm/mpc512x_gpio.h | =A0 30 +++++
> =A0arch/powerpc/platforms/Kconfig =A0 =A0 =A0 =A0 =A0| =A0 =A09 ++
> =A0arch/powerpc/sysdev/Makefile =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A01 +
> =A0arch/powerpc/sysdev/mpc512x_gpio.c =A0 =A0 =A0| =A0179 +++++++++++++++=
++++++++++++++++

Move mpc512x_gpio.c to the arch/powerpc/platforms/512x directory.
Also put the Kconfig changes in arch/powerpc/platform/512x/Kconfig.

> =A04 files changed, 219 insertions(+), 0 deletions(-)
> =A0create mode 100644 arch/powerpc/include/asm/mpc512x_gpio.h
> =A0create mode 100644 arch/powerpc/sysdev/mpc512x_gpio.c
>
> diff --git a/arch/powerpc/include/asm/mpc512x_gpio.h b/arch/powerpc/inclu=
de/asm/mpc512x_gpio.h
> new file mode 100644
> index 0000000..8b6922d
> --- /dev/null
> +++ b/arch/powerpc/include/asm/mpc512x_gpio.h
> @@ -0,0 +1,30 @@
> +/*
> + * Copyright (C) 2010 Matthias Fuchs <matthias.fuchs@esd.eu>, esd gmbh
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2
> + * as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA =A002111-130=
7 =A0USA
> + */
> +#ifndef MPC512X_GPIO_H
> +#define MPC512X_GPIO_H
> +
> +struct mpc512x_gpio_regs {
> + =A0 =A0 =A0 u32 gpdir;
> + =A0 =A0 =A0 u32 gpodr;
> + =A0 =A0 =A0 u32 gpdat;
> + =A0 =A0 =A0 u32 gpier;
> + =A0 =A0 =A0 u32 gpimr;
> + =A0 =A0 =A0 u32 gpicr1;
> + =A0 =A0 =A0 u32 gpicr2;
> +};

Currently this is only used by the GPIO driver.  Move the structure
definition into the .c file.

> +
> +#endif /* MPC512X_GPIO_H */
> diff --git a/arch/powerpc/sysdev/mpc512x_gpio.c b/arch/powerpc/sysdev/mpc=
512x_gpio.c
> new file mode 100644
> index 0000000..09f075b
> --- /dev/null
> +++ b/arch/powerpc/sysdev/mpc512x_gpio.c
> @@ -0,0 +1,179 @@
> +/*
> + * MPC512x gpio driver
> + *
> + * Copyright (c) 2010 Matthias Fuchs <matthias.fuchs@esd.eu>, esd gmbh
> + *
> + * derived from ppc4xx gpio driver
> + *
> + * Copyright (c) 2008 Harris Corporation
> + * Copyright (c) 2008 Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
> + * Copyright (c) MontaVista Software, Inc. 2008.
> + *
> + * Author: Steve Falco <sfalco@harris.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2
> + * as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA =A002111-130=
7 =A0USA
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/spinlock.h>
> +#include <linux/io.h>
> +#include <linux/of.h>
> +#include <linux/of_gpio.h>
> +#include <linux/gpio.h>
> +#include <linux/types.h>
> +#include <asm/mpc512x_gpio.h>
> +
> +#define GPIO_MASK(gpio) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x80000000 >> (g=
pio))

For clarity, this local define should also be prefixed with MPC5121_
so it is not confused with core gpio code.

> +
> +struct mpc512x_chip {
> + =A0 =A0 =A0 struct of_mm_gpio_chip mm_gc;
> + =A0 =A0 =A0 spinlock_t lock;
> +};
> +
> +/*
> + * GPIO LIB API implementation for GPIOs
> + *
> + * There are a maximum of 32 gpios in each gpio controller.
> + */
> +static inline struct mpc512x_chip *
> +to_mpc512x_gpiochip(struct of_mm_gpio_chip *mm_gc)
> +{
> + =A0 =A0 =A0 return container_of(mm_gc, struct mpc512x_chip, mm_gc);
> +}
> +
> +static int mpc512x_gpio_get(struct gpio_chip *gc, unsigned int gpio)
> +{
> + =A0 =A0 =A0 struct of_mm_gpio_chip *mm_gc =3D to_of_mm_gpio_chip(gc);
> + =A0 =A0 =A0 struct mpc512x_gpio_regs __iomem *regs =3D mm_gc->regs;
> +
> + =A0 =A0 =A0 return in_be32(&regs->gpdat) & GPIO_MASK(gpio);
> +}
> +
> +static inline void
> +__mpc512x_gpio_set(struct gpio_chip *gc, unsigned int gpio, int val)
> +{
> + =A0 =A0 =A0 struct of_mm_gpio_chip *mm_gc =3D to_of_mm_gpio_chip(gc);
> + =A0 =A0 =A0 struct mpc512x_gpio_regs __iomem *regs =3D mm_gc->regs;
> +
> + =A0 =A0 =A0 if (val)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 setbits32(&regs->gpdat, GPIO_MASK(gpio));
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clrbits32(&regs->gpdat, GPIO_MASK(gpio));

Rather than the read/modify/write cycle you're using here, you should
consider maintaining a shadow register for the GPIO output register.
Even though it is the SoC local bus, bus cycles can be expensive when
a shadow reg may already be in the cache.

Also, this may be a bug.  If you read the data register, modify just
the bit you care about and then write it back, then you are also
setting the output state of pins currently marked for input.  That
doesn't sound bad, but some drivers change the output state by
switching back and forth between input and output mode.  Using a
read/modify/write on the data register will break it.

> +}
> +
> +static void
> +mpc512x_gpio_set(struct gpio_chip *gc, unsigned int gpio, int val)
> +{
> + =A0 =A0 =A0 struct of_mm_gpio_chip *mm_gc =3D to_of_mm_gpio_chip(gc);
> + =A0 =A0 =A0 struct mpc512x_chip *chip =3D to_mpc512x_gpiochip(mm_gc);
> + =A0 =A0 =A0 unsigned long flags;
> +
> + =A0 =A0 =A0 spin_lock_irqsave(&chip->lock, flags);
> +
> + =A0 =A0 =A0 __mpc512x_gpio_set(gc, gpio, val);
> +
> + =A0 =A0 =A0 spin_unlock_irqrestore(&chip->lock, flags);
> +
> + =A0 =A0 =A0 pr_debug("%s: gpio: %d val: %d\n", __func__, gpio, val);
> +}
> +
> +static int mpc512x_gpio_dir_in(struct gpio_chip *gc, unsigned int gpio)
> +{
> + =A0 =A0 =A0 struct of_mm_gpio_chip *mm_gc =3D to_of_mm_gpio_chip(gc);
> + =A0 =A0 =A0 struct mpc512x_chip *chip =3D to_mpc512x_gpiochip(mm_gc);
> + =A0 =A0 =A0 struct mpc512x_gpio_regs __iomem *regs =3D mm_gc->regs;
> + =A0 =A0 =A0 unsigned long flags;
> +
> + =A0 =A0 =A0 spin_lock_irqsave(&chip->lock, flags);
> +
> + =A0 =A0 =A0 /* Disable open-drain function */
> + =A0 =A0 =A0 clrbits32(&regs->gpodr, GPIO_MASK(gpio));
> +
> + =A0 =A0 =A0 /* Float the pin */
> + =A0 =A0 =A0 clrbits32(&regs->gpdir, GPIO_MASK(gpio));
> +
> + =A0 =A0 =A0 spin_unlock_irqrestore(&chip->lock, flags);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static int
> +mpc512x_gpio_dir_out(struct gpio_chip *gc, unsigned int gpio, int val)
> +{
> + =A0 =A0 =A0 struct of_mm_gpio_chip *mm_gc =3D to_of_mm_gpio_chip(gc);
> + =A0 =A0 =A0 struct mpc512x_chip *chip =3D to_mpc512x_gpiochip(mm_gc);
> + =A0 =A0 =A0 struct mpc512x_gpio_regs __iomem *regs =3D mm_gc->regs;
> + =A0 =A0 =A0 unsigned long flags;
> +
> + =A0 =A0 =A0 spin_lock_irqsave(&chip->lock, flags);
> +
> + =A0 =A0 =A0 /* First set initial value */
> + =A0 =A0 =A0 __mpc512x_gpio_set(gc, gpio, val);
> +
> + =A0 =A0 =A0 /* Disable open-drain function */
> + =A0 =A0 =A0 clrbits32(&regs->gpodr, GPIO_MASK(gpio));
> +
> + =A0 =A0 =A0 /* Drive the pin */
> + =A0 =A0 =A0 setbits32(&regs->gpdir, GPIO_MASK(gpio));
> +
> + =A0 =A0 =A0 spin_unlock_irqrestore(&chip->lock, flags);
> +
> + =A0 =A0 =A0 pr_debug("%s: gpio: %d val: %d\n", __func__, gpio, val);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static int __init mpc512x_add_gpiochips(void)
> +{
> + =A0 =A0 =A0 struct device_node *np;
> +
> + =A0 =A0 =A0 for_each_compatible_node(np, NULL, "fsl,mpc5121-gpio") {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int ret;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct mpc512x_chip *mpc512x_gc;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct of_mm_gpio_chip *mm_gc;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct of_gpio_chip *of_gc;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct gpio_chip *gc;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mpc512x_gc =3D kzalloc(sizeof(*mpc512x_gc),=
 GFP_KERNEL);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!mpc512x_gc) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_init(&mpc512x_gc->lock);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mm_gc =3D &mpc512x_gc->mm_gc;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 of_gc =3D &mm_gc->of_gc;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gc =3D &of_gc->gc;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gc->ngpio =3D 32;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gc->direction_input =3D mpc512x_gpio_dir_in=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gc->direction_output =3D mpc512x_gpio_dir_o=
ut;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gc->get =3D mpc512x_gpio_get;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gc->set =3D mpc512x_gpio_set;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D of_mm_gpiochip_add(np, mm_gc);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
> +err:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: registration failed with status=
 %d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0np->full_name, ret);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(mpc512x_gc);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* try others anyway */
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 return 0;
> +}
> +arch_initcall(mpc512x_add_gpiochips);

Don't do this.  Either make this a proper of_platform device driver,
or call mpc512x_add_gpiochips() explicitly from the arch platform
setup code.  Otherwise, if the kernel is built for multiplatform, this
function will get executed regardless of the platform.

Cheers,
g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
