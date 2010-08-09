Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f170.google.com (mail-gx0-f170.google.com
	[209.85.161.170]) by ozlabs.org (Postfix) with ESMTP id AED57B70D4
	for <linuxppc-dev@ozlabs.org>; Mon,  9 Aug 2010 16:21:15 +1000 (EST)
Received: by gxk25 with SMTP id 25so5909937gxk.15
	for <linuxppc-dev@ozlabs.org>; Sun, 08 Aug 2010 23:21:14 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1281333528-20694-1-git-send-email-agust@denx.de>
References: <1281331211-17878-1-git-send-email-agust@denx.de>
	<1281333528-20694-1-git-send-email-agust@denx.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 9 Aug 2010 00:20:54 -0600
Message-ID: <AANLkTin_Y9W-3w=A0080hGpmjVCNtE9uA-b5YpOinRdm@mail.gmail.com>
Subject: Re: [PATCH v4] powerpc/mpc8xxx_gpio.c: extend the driver to support
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

On Sun, Aug 8, 2010 at 11:58 PM, Anatolij Gustschin <agust@denx.de> wrote:
> The GPIO controller of MPC512x is slightly different from
> 8xxx GPIO controllers. The register interface is the same
> except the external interrupt control register. The MPC512x
> GPIO controller differentiates between four interrupt event
> types and therefore provides two interrupt control registers,
> GPICR1 and GPICR2. GPIO[0:15] interrupt event types are
> configured in GPICR1 register, GPIO[16:31] - in GPICR2 register.
>
> This patch adds MPC512x speciffic set_type() callback and
> updates config file and comments. Additionally the gpio chip
> registration function is changed to use for_each_matching_node()
> preventing multiple registration if a node claimes compatibility
> with another gpio controller type.
>
> Signed-off-by: Anatolij Gustschin <agust@denx.de>
> ---
> v4:
> =A0- undo function merging as it was wrong
> =A0- fix commit message

Looks good, thanks.  I'll pick it up after the merge window closes in
prep for 2.6.27

g.

>
> v3:
> =A0- merge mpc8xxx_add_controller() into mpc8xxx_add_gpiochips()
> =A0- do not use of_node's data field for set type hook,
> =A0 =A0use added void data pointer in the gpio chip struct
> =A0 =A0instead.
>
> v2:
> =A0- add patch description
> =A0- use match table data to set irq set_type hook as
> =A0 recommended
> =A0- refactor to use for_each_matching_node() in
> =A0 mpc8xxx_add_gpiochips() as suggested by Grant
>
> =A0arch/powerpc/platforms/Kconfig =A0 =A0 | =A0 =A07 ++-
> =A0arch/powerpc/sysdev/mpc8xxx_gpio.c | =A0 75 ++++++++++++++++++++++++++=
++++++----
> =A02 files changed, 71 insertions(+), 11 deletions(-)
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
> index 2b69084..3649939 100644
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
> @@ -37,6 +38,7 @@ struct mpc8xxx_gpio_chip {
> =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0u32 data;
> =A0 =A0 =A0 =A0struct irq_host *irq;
> + =A0 =A0 =A0 void *of_dev_id_data;
> =A0};
>
> =A0static inline u32 mpc8xxx_gpio2mask(unsigned int gpio)
> @@ -215,6 +217,51 @@ static int mpc8xxx_irq_set_type(unsigned int virq, u=
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
> @@ -226,6 +273,11 @@ static struct irq_chip mpc8xxx_irq_chip =3D {
> =A0static int mpc8xxx_gpio_irq_map(struct irq_host *h, unsigned int virq,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0irq_hw_num=
ber_t hw)
> =A0{
> + =A0 =A0 =A0 struct mpc8xxx_gpio_chip *mpc8xxx_gc =3D h->host_data;
> +
> + =A0 =A0 =A0 if (mpc8xxx_gc->of_dev_id_data)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mpc8xxx_irq_chip.set_type =3D mpc8xxx_gc->o=
f_dev_id_data;
> +
> =A0 =A0 =A0 =A0set_irq_chip_data(virq, h->host_data);
> =A0 =A0 =A0 =A0set_irq_chip_and_handler(virq, &mpc8xxx_irq_chip, handle_l=
evel_irq);
> =A0 =A0 =A0 =A0set_irq_type(virq, IRQ_TYPE_NONE);
> @@ -253,11 +305,20 @@ static struct irq_host_ops mpc8xxx_gpio_irq_ops =3D=
 {
> =A0 =A0 =A0 =A0.xlate =A0=3D mpc8xxx_gpio_irq_xlate,
> =A0};
>
> +static struct of_device_id mpc8xxx_gpio_ids[] __initdata =3D {
> + =A0 =A0 =A0 { .compatible =3D "fsl,mpc8349-gpio", },
> + =A0 =A0 =A0 { .compatible =3D "fsl,mpc8572-gpio", },
> + =A0 =A0 =A0 { .compatible =3D "fsl,mpc8610-gpio", },
> + =A0 =A0 =A0 { .compatible =3D "fsl,mpc5121-gpio", .data =3D mpc512x_irq=
_set_type, },
> + =A0 =A0 =A0 {}
> +};
> +
> =A0static void __init mpc8xxx_add_controller(struct device_node *np)
> =A0{
> =A0 =A0 =A0 =A0struct mpc8xxx_gpio_chip *mpc8xxx_gc;
> =A0 =A0 =A0 =A0struct of_mm_gpio_chip *mm_gc;
> =A0 =A0 =A0 =A0struct gpio_chip *gc;
> + =A0 =A0 =A0 const struct of_device_id *id;
> =A0 =A0 =A0 =A0unsigned hwirq;
> =A0 =A0 =A0 =A0int ret;
>
> @@ -297,6 +358,10 @@ static void __init mpc8xxx_add_controller(struct dev=
ice_node *np)
> =A0 =A0 =A0 =A0if (!mpc8xxx_gc->irq)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto skip_irq;
>
> + =A0 =A0 =A0 id =3D of_match_node(mpc8xxx_gpio_ids, np);
> + =A0 =A0 =A0 if (id)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mpc8xxx_gc->of_dev_id_data =3D id->data;
> +
> =A0 =A0 =A0 =A0mpc8xxx_gc->irq->host_data =3D mpc8xxx_gc;
>
> =A0 =A0 =A0 =A0/* ack and mask all irqs */
> @@ -321,13 +386,7 @@ static int __init mpc8xxx_add_gpiochips(void)
> =A0{
> =A0 =A0 =A0 =A0struct device_node *np;
>
> - =A0 =A0 =A0 for_each_compatible_node(np, NULL, "fsl,mpc8349-gpio")
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mpc8xxx_add_controller(np);
> -
> - =A0 =A0 =A0 for_each_compatible_node(np, NULL, "fsl,mpc8572-gpio")
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mpc8xxx_add_controller(np);
> -
> - =A0 =A0 =A0 for_each_compatible_node(np, NULL, "fsl,mpc8610-gpio")
> + =A0 =A0 =A0 for_each_matching_node(np, mpc8xxx_gpio_ids)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mpc8xxx_add_controller(np);
>
> =A0 =A0 =A0 =A0return 0;
> --
> 1.7.0.4
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
