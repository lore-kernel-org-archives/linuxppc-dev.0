Return-Path: <glikely@secretlab.ca>
Received: from mail-yx0-f170.google.com (mail-yx0-f170.google.com
	[209.85.213.170]) by ozlabs.org (Postfix) with ESMTP id 7F34F1007D1
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jun 2010 07:49:04 +1000 (EST)
Received: by yxs7 with SMTP id 7so112001yxs.15
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jun 2010 14:49:02 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1276186867-29094-1-git-send-email-agust@denx.de>
References: <1276185950-28451-1-git-send-email-agust@denx.de>
	<1276186867-29094-1-git-send-email-agust@denx.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 10 Jun 2010 15:48:42 -0600
Message-ID: <AANLkTik7pTXHdY9_sjL9Lyz68gk2qRUs0NaGpj_7nL7K@mail.gmail.com>
Subject: Re: [PATCH V4] powerpc/mpc512x: Add gpio driver
To: Anatolij Gustschin <agust@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Wolfgang Denk <wd@denx.de>,
	Detlev Zundel <dzu@denx.de>, Matthias Fuchs <matthias.fuchs@esd.eu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 10, 2010 at 10:21 AM, Anatolij Gustschin <agust@denx.de> wrote:
> From: Matthias Fuchs <matthias.fuchs@esd.eu>
>
> This patch adds a gpio driver for MPC512X PowerPCs.
>
> It has been tested on our CAN-CBX-CPU5201 module that
> uses a MPC5121 CPU. This platform comes with a couple of
> LEDs and configuration switches that have been used for testing.
>
> Signed-off-by: Matthias Fuchs <matthias.fuchs@esd.eu>
> Signed-off-by: Anatolij Gustschin <agust@denx.de>

Hi Anatolij,

Can you please rework this one on top of my next-devicetree branch.
Change have been made to the of-gpio apis.

g.


> ---
> Please consider this patch for inclusion in 2.6.36. Thanks!
>
> v4: - actually v3 was rebased but without shadow
> =A0 =A0 =A0registers init code as stated in the v3 changelog.
> =A0 =A0 =A0Correct it now.
>
> v3: - rebase to apply on current mainline tree
> =A0 =A0- v2 switched to shadow registers but these are
> =A0 =A0 =A0not pre-initialized (zero). As a result, setting
> =A0 =A0 =A0pin direction or ODR register will clear other bits
> =A0 =A0 =A0in direction and ODR registers. Fix this bug by adding
> =A0 =A0 =A0shadow registers initialization code.
>
> v2: - move driver to arch/powerpc/platforms/512x directory
> =A0 =A0- Kconfig changes are now in arch/powerpc/platform/512x/Kconfig
> =A0 =A0- put struct mpc512x_gpio_regs in driver's .c file
> =A0 =A0- rename GPIO_MASK into MPC512x_GPIO_MASK
> =A0 =A0- use shadow registers instead of r/m/w-operations
> =A0 =A0- don't use arch_initcall but call mpc512x_add_gpiochips()
> =A0 =A0 =A0from mpc512x platform setup code.
>
> =A0arch/powerpc/platforms/512x/Kconfig =A0 =A0 =A0 =A0 =A0| =A0 =A09 +
> =A0arch/powerpc/platforms/512x/Makefile =A0 =A0 =A0 =A0 | =A0 =A01 +
> =A0arch/powerpc/platforms/512x/mpc512x.h =A0 =A0 =A0 =A0| =A0 =A03 +
> =A0arch/powerpc/platforms/512x/mpc512x_gpio.c =A0 | =A0204 ++++++++++++++=
++++++++++++
> =A0arch/powerpc/platforms/512x/mpc512x_shared.c | =A0 =A03 +
> =A05 files changed, 220 insertions(+), 0 deletions(-)
> =A0create mode 100644 arch/powerpc/platforms/512x/mpc512x_gpio.c
>
> diff --git a/arch/powerpc/platforms/512x/Kconfig b/arch/powerpc/platforms=
/512x/Kconfig
> index 4dac9b0..bd763ee 100644
> --- a/arch/powerpc/platforms/512x/Kconfig
> +++ b/arch/powerpc/platforms/512x/Kconfig
> @@ -30,3 +30,12 @@ config MPC5121_GENERIC
>
> =A0 =A0 =A0 =A0 =A0Compatible boards include: =A0Protonic LVT base boards=
 (ZANMCU
> =A0 =A0 =A0 =A0 =A0and VICVT2).
> +
> +config MPC512x_GPIO
> + =A0 =A0 =A0 bool "MPC512x GPIO support"
> + =A0 =A0 =A0 depends on PPC_MPC512x
> + =A0 =A0 =A0 select GENERIC_GPIO
> + =A0 =A0 =A0 select ARCH_REQUIRE_GPIOLIB
> + =A0 =A0 =A0 help
> + =A0 =A0 =A0 =A0 Say Y here if you're going to use hardware that connect=
s to the
> + =A0 =A0 =A0 =A0 MPC512x GPIOs.
> diff --git a/arch/powerpc/platforms/512x/Makefile b/arch/powerpc/platform=
s/512x/Makefile
> index 90be2f5..12518e3 100644
> --- a/arch/powerpc/platforms/512x/Makefile
> +++ b/arch/powerpc/platforms/512x/Makefile
> @@ -4,3 +4,4 @@
> =A0obj-y =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D clock.o =
mpc512x_shared.o
> =A0obj-$(CONFIG_MPC5121_ADS) =A0 =A0 =A0+=3D mpc5121_ads.o mpc5121_ads_cp=
ld.o
> =A0obj-$(CONFIG_MPC5121_GENERIC) =A0+=3D mpc5121_generic.o
> +obj-$(CONFIG_MPC512x_GPIO) =A0 =A0 +=3D mpc512x_gpio.o
> diff --git a/arch/powerpc/platforms/512x/mpc512x.h b/arch/powerpc/platfor=
ms/512x/mpc512x.h
> index b2daca0..4a1b094 100644
> --- a/arch/powerpc/platforms/512x/mpc512x.h
> +++ b/arch/powerpc/platforms/512x/mpc512x.h
> @@ -16,4 +16,7 @@ extern void __init mpc512x_init(void);
> =A0extern int __init mpc5121_clk_init(void);
> =A0void __init mpc512x_declare_of_platform_devices(void);
> =A0extern void mpc512x_restart(char *cmd);
> +#ifdef CONFIG_MPC512x_GPIO
> +extern int mpc512x_add_gpiochips(void);
> +#endif
> =A0#endif =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* __MPC512X_H_=
_ */
> diff --git a/arch/powerpc/platforms/512x/mpc512x_gpio.c b/arch/powerpc/pl=
atforms/512x/mpc512x_gpio.c
> new file mode 100644
> index 0000000..13b2478
> --- /dev/null
> +++ b/arch/powerpc/platforms/512x/mpc512x_gpio.c
> @@ -0,0 +1,204 @@
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
> +
> +#define MPC512x_GPIO_MASK(gpio) (0x80000000 >> (gpio))
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
> +
> +struct mpc512x_chip {
> + =A0 =A0 =A0 struct of_mm_gpio_chip mm_gc;
> + =A0 =A0 =A0 spinlock_t lock;
> +
> + =A0 =A0 =A0 /* shadow registers */
> + =A0 =A0 =A0 u32 dat;
> + =A0 =A0 =A0 u32 odr;
> + =A0 =A0 =A0 u32 dir;
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
> + =A0 =A0 =A0 return in_be32(&regs->gpdat) & MPC512x_GPIO_MASK(gpio);
> +}
> +
> +static inline void
> +__mpc512x_gpio_set(struct of_mm_gpio_chip *mm_gc, unsigned int gpio, int=
 val)
> +{
> + =A0 =A0 =A0 struct mpc512x_chip *chip =3D to_mpc512x_gpiochip(mm_gc);
> + =A0 =A0 =A0 struct mpc512x_gpio_regs __iomem *regs =3D mm_gc->regs;
> +
> +
> + =A0 =A0 =A0 if (val)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 chip->dat |=3D MPC512x_GPIO_MASK(gpio);
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 chip->dat &=3D ~MPC512x_GPIO_MASK(gpio);
> +
> + =A0 =A0 =A0 out_be32(&regs->gpdat, chip->dat);
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
> + =A0 =A0 =A0 __mpc512x_gpio_set(mm_gc, gpio, val);
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
> + =A0 =A0 =A0 chip->odr &=3D ~MPC512x_GPIO_MASK(gpio);
> + =A0 =A0 =A0 out_be32(&regs->gpodr, chip->odr);
> +
> + =A0 =A0 =A0 /* Float the pin */
> + =A0 =A0 =A0 chip->dir &=3D ~MPC512x_GPIO_MASK(gpio);
> + =A0 =A0 =A0 out_be32(&regs->gpdir, chip->dir);
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
> + =A0 =A0 =A0 __mpc512x_gpio_set(mm_gc, gpio, val);
> +
> + =A0 =A0 =A0 /* Disable open-drain function */
> + =A0 =A0 =A0 chip->odr &=3D ~MPC512x_GPIO_MASK(gpio);
> + =A0 =A0 =A0 out_be32(&regs->gpodr, chip->odr);
> +
> + =A0 =A0 =A0 /* Drive the pin */
> + =A0 =A0 =A0 chip->dir |=3D MPC512x_GPIO_MASK(gpio);
> + =A0 =A0 =A0 out_be32(&regs->gpdir, chip->dir);
> +
> + =A0 =A0 =A0 spin_unlock_irqrestore(&chip->lock, flags);
> +
> + =A0 =A0 =A0 pr_debug("%s: gpio: %d val: %d\n", __func__, gpio, val);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +void __init mpc512x_add_gpiochips(void)
> +{
> + =A0 =A0 =A0 struct device_node *np;
> +
> + =A0 =A0 =A0 for_each_compatible_node(np, NULL, "fsl,mpc5121-gpio") {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int ret;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct mpc512x_chip *chip;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct of_mm_gpio_chip *mm_gc;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct of_gpio_chip *of_gc;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct gpio_chip *gc;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct mpc512x_gpio_regs __iomem *regs;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 chip =3D kzalloc(sizeof(*chip), GFP_KERNEL)=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!chip) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_init(&chip->lock);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mm_gc =3D &chip->mm_gc;
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
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 regs =3D mm_gc->regs;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 chip->dat =3D in_be32(&regs->gpdat);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 chip->dir =3D in_be32(&regs->gpdir);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 chip->odr =3D in_be32(&regs->gpodr);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
> +err:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: registration failed with status=
 %d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0np->full_name, ret);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(chip);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* try others anyway */
> + =A0 =A0 =A0 }
> +}
> diff --git a/arch/powerpc/platforms/512x/mpc512x_shared.c b/arch/powerpc/=
platforms/512x/mpc512x_shared.c
> index 707e572..15da1bc 100644
> --- a/arch/powerpc/platforms/512x/mpc512x_shared.c
> +++ b/arch/powerpc/platforms/512x/mpc512x_shared.c
> @@ -178,4 +178,7 @@ void __init mpc512x_init(void)
> =A0 =A0 =A0 =A0mpc5121_clk_init();
> =A0 =A0 =A0 =A0mpc512x_restart_init();
> =A0 =A0 =A0 =A0mpc512x_psc_fifo_init();
> +#ifdef CONFIG_MPC512x_GPIO
> + =A0 =A0 =A0 mpc512x_add_gpiochips();
> +#endif
> =A0}
> --
> 1.7.0.4
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
