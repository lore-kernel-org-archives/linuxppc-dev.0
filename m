Return-Path: <glikely@secretlab.ca>
Received: from mail-gw0-f42.google.com (mail-gw0-f42.google.com [74.125.83.42])
	by ozlabs.org (Postfix) with ESMTP id E0C94B6EF2
	for <linuxppc-dev@ozlabs.org>; Sun,  8 Aug 2010 01:13:12 +1000 (EST)
Received: by gwj15 with SMTP id 15so5322294gwj.15
	for <linuxppc-dev@ozlabs.org>; Sat, 07 Aug 2010 08:13:10 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1281187711-10215-1-git-send-email-agust@denx.de>
References: <87iq4r5y4q.fsf@macbook.be.48ers.dk>
	<1281187711-10215-1-git-send-email-agust@denx.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Sat, 7 Aug 2010 09:12:50 -0600
Message-ID: <AANLkTimopiF3MZfaAXOO1rJVTptP0HFWSTtmSviAcfT3@mail.gmail.com>
Subject: Re: [PATCH] powerpc/mpc8xxx_gpio.c: extend the driver to support
	mpc512x gpios
To: Anatolij Gustschin <agust@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Wolfgang Denk <wd@denx.de>,
	Detlev Zundel <dzu@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Anatolij,

Looks pretty good, but some comments below...

On Sat, Aug 7, 2010 at 7:28 AM, Anatolij Gustschin <agust@denx.de> wrote:
> Signed-off-by: Anatolij Gustschin <agust@denx.de>

You haven't written a patch description.  Give some details about how
the 512x gpio controller is different from the 8xxx one.

> ---
> =A0arch/powerpc/platforms/Kconfig =A0 =A0 | =A0 =A07 ++--
> =A0arch/powerpc/sysdev/mpc8xxx_gpio.c | =A0 54 ++++++++++++++++++++++++++=
+++++++++-
> =A02 files changed, 57 insertions(+), 4 deletions(-)
>
> diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kcon=
fig
> index d1663db..471115a 100644
> --- a/arch/powerpc/platforms/Kconfig
> +++ b/arch/powerpc/platforms/Kconfig
> @@ -304,13 +304,14 @@ config OF_RTC
> =A0source "arch/powerpc/sysdev/bestcomm/Kconfig"
>
> =A0config MPC8xxx_GPIO
> - =A0 =A0 =A0 bool "MPC8xxx GPIO support"
> - =A0 =A0 =A0 depends on PPC_MPC831x || PPC_MPC834x || PPC_MPC837x || FSL=
_SOC_BOOKE || PPC_86xx
> + =A0 =A0 =A0 bool "MPC512x/MPC8xxx GPIO support"
> + =A0 =A0 =A0 depends on PPC_MPC512x || PPC_MPC831x || PPC_MPC834x || PPC=
_MPC837x || \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0FSL_SOC_BOOKE || PPC_86xx
> =A0 =A0 =A0 =A0select GENERIC_GPIO
> =A0 =A0 =A0 =A0select ARCH_REQUIRE_GPIOLIB
> =A0 =A0 =A0 =A0help
> =A0 =A0 =A0 =A0 =A0Say Y here if you're going to use hardware that connec=
ts to the
> - =A0 =A0 =A0 =A0 MPC831x/834x/837x/8572/8610 GPIOs.
> + =A0 =A0 =A0 =A0 MPC512x/831x/834x/837x/8572/8610 GPIOs.
>
> =A0config SIMPLE_GPIO
> =A0 =A0 =A0 =A0bool "Support for simple, memory-mapped GPIO controllers"
> diff --git a/arch/powerpc/sysdev/mpc8xxx_gpio.c b/arch/powerpc/sysdev/mpc=
8xxx_gpio.c
> index 2b69084..f5b4959 100644
> --- a/arch/powerpc/sysdev/mpc8xxx_gpio.c
> +++ b/arch/powerpc/sysdev/mpc8xxx_gpio.c
> @@ -1,5 +1,5 @@
> =A0/*
> - * GPIOs on MPC8349/8572/8610 and compatible
> + * GPIOs on MPC512x/8349/8572/8610 and compatible
> =A0*
> =A0* Copyright (C) 2008 Peter Korsgaard <jacmet@sunsite.dk>
> =A0*
> @@ -26,6 +26,7 @@
> =A0#define GPIO_IER =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x0c
> =A0#define GPIO_IMR =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x10
> =A0#define GPIO_ICR =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x14
> +#define GPIO_ICR2 =A0 =A0 =A0 =A0 =A0 =A0 =A00x18
>
> =A0struct mpc8xxx_gpio_chip {
> =A0 =A0 =A0 =A0struct of_mm_gpio_chip mm_gc;
> @@ -215,6 +216,51 @@ static int mpc8xxx_irq_set_type(unsigned int virq, u=
nsigned int flow_type)
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> +static int mpc512x_irq_set_type(unsigned int virq, unsigned int flow_typ=
e)
> +{
> + =A0 =A0 =A0 struct mpc8xxx_gpio_chip *mpc8xxx_gc =3D get_irq_chip_data(=
virq);
> + =A0 =A0 =A0 struct of_mm_gpio_chip *mm =3D &mpc8xxx_gc->mm_gc;
> + =A0 =A0 =A0 unsigned long gpio =3D virq_to_hw(virq);
> + =A0 =A0 =A0 void __iomem *reg;
> + =A0 =A0 =A0 unsigned int shift;
> + =A0 =A0 =A0 unsigned long flags;
> +
> + =A0 =A0 =A0 if (gpio < 16) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D mm->regs + GPIO_ICR;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 shift =3D (15 - gpio) * 2;
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D mm->regs + GPIO_ICR2;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 shift =3D (15 - (gpio % 16)) * 2;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 switch (flow_type) {
> + =A0 =A0 =A0 case IRQ_TYPE_EDGE_FALLING:
> + =A0 =A0 =A0 case IRQ_TYPE_LEVEL_LOW:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irqsave(&mpc8xxx_gc->lock, flags)=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clrsetbits_be32(reg, 3 << shift, 2 << shift=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&mpc8xxx_gc->lock, f=
lags);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> + =A0 =A0 =A0 case IRQ_TYPE_EDGE_RISING:
> + =A0 =A0 =A0 case IRQ_TYPE_LEVEL_HIGH:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irqsave(&mpc8xxx_gc->lock, flags)=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clrsetbits_be32(reg, 3 << shift, 1 << shift=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&mpc8xxx_gc->lock, f=
lags);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> + =A0 =A0 =A0 case IRQ_TYPE_EDGE_BOTH:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irqsave(&mpc8xxx_gc->lock, flags)=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clrbits32(reg, 3 << shift);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&mpc8xxx_gc->lock, f=
lags);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> + =A0 =A0 =A0 default:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> =A0static struct irq_chip mpc8xxx_irq_chip =3D {
> =A0 =A0 =A0 =A0.name =A0 =A0 =A0 =A0 =A0 =3D "mpc8xxx-gpio",
> =A0 =A0 =A0 =A0.unmask =A0 =A0 =A0 =A0 =3D mpc8xxx_irq_unmask,
> @@ -226,6 +272,9 @@ static struct irq_chip mpc8xxx_irq_chip =3D {
> =A0static int mpc8xxx_gpio_irq_map(struct irq_host *h, unsigned int virq,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0irq_hw_num=
ber_t hw)
> =A0{
> + =A0 =A0 =A0 if (of_device_is_compatible(h->of_node, "fsl,mpc5121-gpio")=
)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mpc8xxx_irq_chip.set_type =3D mpc512x_irq_s=
et_type;
> +

You can put the set type hook into the of_match_table data which you
will need for of_find_matching_node() (see below).

> =A0 =A0 =A0 =A0set_irq_chip_data(virq, h->host_data);
> =A0 =A0 =A0 =A0set_irq_chip_and_handler(virq, &mpc8xxx_irq_chip, handle_l=
evel_irq);
> =A0 =A0 =A0 =A0set_irq_type(virq, IRQ_TYPE_NONE);
> @@ -330,6 +379,9 @@ static int __init mpc8xxx_add_gpiochips(void)
> =A0 =A0 =A0 =A0for_each_compatible_node(np, NULL, "fsl,mpc8610-gpio")
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mpc8xxx_add_controller(np);
>
> + =A0 =A0 =A0 for_each_compatible_node(np, NULL, "fsl,mpc5121-gpio")
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mpc8xxx_add_controller(np);
> +

This list is getting too long.  Refactor this function to use
for_each_matching_node().  Also doing it this way is dangerous because
if say a 5121 gpio node claims compatibility with a 8610 gpio node,
then the gpio controller will get registered twice.

> =A0 =A0 =A0 =A0return 0;
> =A0}
> =A0arch_initcall(mpc8xxx_add_gpiochips);
> --
> 1.7.0.4
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
