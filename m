Return-Path: <wsa@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id F25C5DDDF6
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Feb 2009 06:55:15 +1100 (EST)
Date: Wed, 4 Feb 2009 20:55:06 +0100
From: Wolfram Sang <w.sang@pengutronix.de>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v4] powerpc/5200: Rework GPT driver to also be an IRQ
	controller
Message-ID: <20090204195506.GA32613@pengutronix.de>
References: <20090204181907.616.52132.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
In-Reply-To: <20090204181907.616.52132.stgit@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Grant,

On Wed, Feb 04, 2009 at 11:23:05AM -0700, Grant Likely wrote:
> From: Grant Likely <grant.likely@secretlab.ca>
>=20
> This patch adds IRQ controller support to the MPC5200 General
> Purpose Timer (GPT) device driver.  With this patch the mpc5200-gpt
> driver supports both GPIO and IRQ functions.
>=20
> The GPT driver was contained within the mpc52xx_gpio.c file, but this
> patch moves it out into a new file (mpc52xx_gpt.c) since it has more
> than just GPIO functionality now and it was only grouped with the
> mpc52xx-gpio drivers as a matter of convenience before.  Also, this
> driver will most likely get extended again to also provide support
> for the timer function.
>=20
> Implementation note: Alternately, I could have tried to implement
> the IRQ support as a separate driver and left the GPIO portion alone.
> However, multiple functions of this device (ie. GPIO input+interrupt
> controller, or timer+GPIO) can be active at the same time and the
> registers are shared so it is safer to contain all functionality
> within a single driver.
>=20
> v4 changes:
> - Fix compile error when GPIOLIB is not enabled.
> v3 changes:
> - Use set/clbits() for manipulating registers
> - Fix incorrect comments
> - Other minor tidying
> v2 changes:
> - Removed magic numbers
> - Only set to GPIO mode if it has the gpio-controller property.  Otherwise
>   leave the configuration alone.  Firmware may have already configured it.

I have been told to move such a changelog below the dashed lines,
because it is not so important for the git-history.

>=20
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> ---
>=20
> Here is what I hope to be the last version of this patch.  This version f=
ixes
> a compile error when GPIO support is not compiled into the kernel.  I've
> pushed this out to my -next tree.  I'll be asking Ben to pull it tomorrow.

Sorry, but it still has issues. This review in a hurry leaves me with a
bit uneasy feelings, still, if the remaining issues get resolved, you
may add my

Reviewed-by: Wolfram Sang <w.sang@pengutronix.de>

>=20
> g.
>=20
>  arch/powerpc/platforms/52xx/Makefile       |    2=20
>  arch/powerpc/platforms/52xx/mpc52xx_gpio.c |   85 -----
>  arch/powerpc/platforms/52xx/mpc52xx_gpt.c  |  435 ++++++++++++++++++++++=
++++++
>  3 files changed, 436 insertions(+), 86 deletions(-)
>  create mode 100644 arch/powerpc/platforms/52xx/mpc52xx_gpt.c
>=20
>=20
> diff --git a/arch/powerpc/platforms/52xx/Makefile b/arch/powerpc/platform=
s/52xx/Makefile
> index 9dfbde2..bfd4f52 100644
> --- a/arch/powerpc/platforms/52xx/Makefile
> +++ b/arch/powerpc/platforms/52xx/Makefile
> @@ -1,7 +1,7 @@
>  #
>  # Makefile for 52xx based boards
>  #
> -obj-y				+=3D mpc52xx_pic.o mpc52xx_common.o
> +obj-y				+=3D mpc52xx_pic.o mpc52xx_common.o mpc52xx_gpt.o
>  obj-$(CONFIG_PCI)		+=3D mpc52xx_pci.o
> =20
>  obj-$(CONFIG_PPC_MPC5200_SIMPLE) +=3D mpc5200_simple.o
> diff --git a/arch/powerpc/platforms/52xx/mpc52xx_gpio.c b/arch/powerpc/pl=
atforms/52xx/mpc52xx_gpio.c
> index 07f89ae..2b8d8ef 100644
> --- a/arch/powerpc/platforms/52xx/mpc52xx_gpio.c
> +++ b/arch/powerpc/platforms/52xx/mpc52xx_gpio.c
> @@ -354,88 +354,6 @@ static struct of_platform_driver mpc52xx_simple_gpio=
chip_driver =3D {
>  	.remove =3D mpc52xx_gpiochip_remove,
>  };
> =20
> -/*
> - * GPIO LIB API implementation for gpt GPIOs.
> - *
> - * Each gpt only has a single GPIO.
> - */
> -static int mpc52xx_gpt_gpio_get(struct gpio_chip *gc, unsigned int gpio)
> -{
> -	struct of_mm_gpio_chip *mm_gc =3D to_of_mm_gpio_chip(gc);
> -	struct mpc52xx_gpt __iomem *regs =3D mm_gc->regs;
> -
> -	return (in_be32(&regs->status) & (1 << (31 - 23))) ? 1 : 0;
> -}
> -
> -static void
> -mpc52xx_gpt_gpio_set(struct gpio_chip *gc, unsigned int gpio, int val)
> -{
> -	struct of_mm_gpio_chip *mm_gc =3D to_of_mm_gpio_chip(gc);
> -	struct mpc52xx_gpt __iomem *regs =3D mm_gc->regs;
> -
> -	if (val)
> -		out_be32(&regs->mode, 0x34);
> -	else
> -		out_be32(&regs->mode, 0x24);
> -
> -	pr_debug("%s: gpio: %d val: %d\n", __func__, gpio, val);
> -}
> -
> -static int mpc52xx_gpt_gpio_dir_in(struct gpio_chip *gc, unsigned int gp=
io)
> -{
> -	struct of_mm_gpio_chip *mm_gc =3D to_of_mm_gpio_chip(gc);
> -	struct mpc52xx_gpt __iomem *regs =3D mm_gc->regs;
> -
> -	out_be32(&regs->mode, 0x04);
> -
> -	return 0;
> -}
> -
> -static int
> -mpc52xx_gpt_gpio_dir_out(struct gpio_chip *gc, unsigned int gpio, int va=
l)
> -{
> -	mpc52xx_gpt_gpio_set(gc, gpio, val);
> -	pr_debug("%s: gpio: %d val: %d\n", __func__, gpio, val);
> -
> -	return 0;
> -}
> -
> -static int __devinit mpc52xx_gpt_gpiochip_probe(struct of_device *ofdev,
> -					const struct of_device_id *match)
> -{
> -	struct of_mm_gpio_chip *mmchip;
> -	struct of_gpio_chip *chip;
> -
> -	mmchip =3D kzalloc(sizeof(*mmchip), GFP_KERNEL);
> -	if (!mmchip)
> -		return -ENOMEM;
> -
> -	chip =3D &mmchip->of_gc;
> -
> -	chip->gpio_cells          =3D 2;
> -	chip->gc.ngpio            =3D 1;
> -	chip->gc.direction_input  =3D mpc52xx_gpt_gpio_dir_in;
> -	chip->gc.direction_output =3D mpc52xx_gpt_gpio_dir_out;
> -	chip->gc.get              =3D mpc52xx_gpt_gpio_get;
> -	chip->gc.set              =3D mpc52xx_gpt_gpio_set;
> -
> -	return of_mm_gpiochip_add(ofdev->node, mmchip);
> -}
> -
> -static const struct of_device_id mpc52xx_gpt_gpiochip_match[] =3D {
> -	{
> -		.compatible =3D "fsl,mpc5200-gpt-gpio",
> -	},
> -	{}
> -};
> -
> -static struct of_platform_driver mpc52xx_gpt_gpiochip_driver =3D {
> -	.name =3D "gpio_gpt",
> -	.match_table =3D mpc52xx_gpt_gpiochip_match,
> -	.probe =3D mpc52xx_gpt_gpiochip_probe,
> -	.remove =3D mpc52xx_gpiochip_remove,
> -};
> -
>  static int __init mpc52xx_gpio_init(void)
>  {
>  	if (of_register_platform_driver(&mpc52xx_wkup_gpiochip_driver))
> @@ -444,9 +362,6 @@ static int __init mpc52xx_gpio_init(void)
>  	if (of_register_platform_driver(&mpc52xx_simple_gpiochip_driver))
>  		printk(KERN_ERR "Unable to register simple GPIO driver\n");
> =20
> -	if (of_register_platform_driver(&mpc52xx_gpt_gpiochip_driver))
> -		printk(KERN_ERR "Unable to register gpt GPIO driver\n");
> -
>  	return 0;
>  }
> =20
> diff --git a/arch/powerpc/platforms/52xx/mpc52xx_gpt.c b/arch/powerpc/pla=
tforms/52xx/mpc52xx_gpt.c
> new file mode 100644
> index 0000000..1a834e1
> --- /dev/null
> +++ b/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
> @@ -0,0 +1,435 @@
> +/*
> + * MPC5200 General Purpose Timer device driver
> + *
> + * Copyright (c) 2009 Secret Lab Technologies Ltd.
> + * Copyright (c) 2008 Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
> + *
> + * This program is free software; you can redistribute  it and/or modify=
 it
> + * under  the terms of  the GNU General  Public License as published by =
the
> + * Free Software Foundation;  either version 2 of the  License, or (at y=
our
> + * option) any later version.
> + *
> + * This file is a driver for the the General Purpose Timer (gpt) devices
> + * found on the MPC5200 SoC.  Each timer has an IO pin which can be used
> + * for GPIO or can be used to raise interrupts.  The timer function can
> + * be used independently from the IO pin, or it can be used to control
> + * output signals or measure input signals.
> + *
> + * This driver supports the GPIO and IRQ controller functions of the GPT
> + * device.  Timer functions are not yet supported, nor is the watchdog
> + * timer.
> + *
> + * To use the GPIO function, the following two properties must be added
> + * to the device tree node for the gpt device (typically in the .dts file
> + * for the board):
> + * 	gpio-controller;
> + * 	#gpio-cells =3D < 2 >;
> + * This driver will register the GPIO pin if it finds the gpio-controller
> + * property in the device tree.
> + *
> + * To use the IRQ controller function, the following two properties must
> + * be added to the device tree node for the gpt device:
> + * 	interrupt-controller;
> + * 	#interrupt-cells =3D < 1 >;
> + * The IRQ controller binding only uses one cell to specify the interrup=
t,
> + * and the IRQ flags are encoded in the cell.  A cell is not used to enc=
ode
> + * the IRQ number because the GPT only has a single IRQ source.  For fla=
gs,
> + * a value of '1' means rising edge sensitive and '2' means falling edge.
> + *
> + * The GPIO and the IRQ controller functions can be used at the same tim=
e,
> + * but in this use case the IO line will only work as an input.  Trying =
to
> + * use it as a GPIO output will not work.
> + *
> + * When using the GPIO line as an output, it can either be driven as nor=
mal
> + * IO, or it can be an Open Collector (OC) output.  At the moment it is =
the
> + * responsibility of either the bootloader or the platform setup code to=
 set
> + * the output mode.  This driver does not change the output mode setting.
> + */
> +
> +#include <linux/irq.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/of_gpio.h>
> +#include <linux/kernel.h>
> +#include <asm/mpc52xx.h>
> +
> +MODULE_DESCRIPTION("Freescale MPC52xx gpt driver");
> +MODULE_AUTHOR("Sascha Hauer, Grant Likely");
> +MODULE_LICENSE("GPL");
> +
> +/**
> + * struct mpc52xx_gpt - Private data structure for MPC52xx GPT driver
> + * @dev: pointer to device structure
> + * @regs: virtual address of GPT registers
> + * @lock: spinlock to coordinate between different functions.
> + * @of_gc: of_gpio_chip instance structure; used when GPIO is enabled
> + * @irqhost: Pointer to irq_host instance; used when IRQ mode is support=
ed
> + */
> +struct mpc52xx_gpt_priv {
> +	struct device *dev;
> +	struct mpc52xx_gpt __iomem *regs;
> +	spinlock_t lock;
> +	struct irq_host *irqhost;
> +
> +#if defined(CONFIG_GPIOLIB)
> +	struct of_gpio_chip of_gc;
> +#endif
> +};
> +
> +#define MPC52xx_GPT_MODE_MS_MASK	(0x07)
> +#define MPC52xx_GPT_MODE_MS_IC		(0x01)
> +#define MPC52xx_GPT_MODE_MS_OC		(0x02)
> +#define MPC52xx_GPT_MODE_MS_PWM		(0x03)
> +#define MPC52xx_GPT_MODE_MS_GPIO	(0x04)
> +
> +#define MPC52xx_GPT_MODE_GPIO_MASK	(0x30)
> +#define MPC52xx_GPT_MODE_GPIO_OUT_LOW	(0x20)
> +#define MPC52xx_GPT_MODE_GPIO_OUT_HIGH	(0x30)
> +
> +#define MPC52xx_GPT_MODE_IRQ_EN		(0x0100)
> +
> +#define MPC52xx_GPT_MODE_ICT_MASK	(0x030000)
> +#define MPC52xx_GPT_MODE_ICT_RISING	(0x010000)
> +#define MPC52xx_GPT_MODE_ICT_FALLING	(0x020000)
> +#define MPC52xx_GPT_MODE_ICT_TOGGLE	(0x030000)
> +
> +#define MPC52xx_GPT_STATUS_IRQMASK	(0x000f)
> +
> +/* ---------------------------------------------------------------------
> + * Cascaded interrupt controller hooks
> + */
> +
> +static void mpc52xx_gpt_irq_unmask(unsigned int virq)
> +{
> +	struct mpc52xx_gpt_priv *gpt =3D get_irq_chip_data(virq);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&gpt->lock, flags);
> +	setbits32(&gpt->regs->mode, MPC52xx_GPT_MODE_IRQ_EN);
> +	spin_unlock_irqrestore(&gpt->lock, flags);
> +}
> +
> +static void mpc52xx_gpt_irq_mask(unsigned int virq)
> +{
> +	struct mpc52xx_gpt_priv *gpt =3D get_irq_chip_data(virq);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&gpt->lock, flags);
> +	clrbits32(&gpt->regs->mode, MPC52xx_GPT_MODE_IRQ_EN);
> +	spin_unlock_irqrestore(&gpt->lock, flags);
> +}
> +
> +static void mpc52xx_gpt_irq_ack(unsigned int virq)
> +{
> +	struct mpc52xx_gpt_priv *gpt =3D get_irq_chip_data(virq);
> +
> +	out_be32(&gpt->regs->status, MPC52xx_GPT_STATUS_IRQMASK);
> +}
> +
> +static int mpc52xx_gpt_irq_set_type(unsigned int virq, unsigned int flow=
_type)
> +{
> +	struct mpc52xx_gpt_priv *gpt =3D get_irq_chip_data(virq);
> +	unsigned long flags;
> +	u32 reg;
> +
> +	dev_dbg(gpt->dev, "%s: virq=3D%i type=3D%x\n", __func__, virq, flow_typ=
e);
> +
> +	spin_lock_irqsave(&gpt->lock, flags);
> +	reg =3D in_be32(&gpt->regs->mode) & ~MPC52xx_GPT_MODE_ICT_MASK;
> +	if (flow_type & IRQF_TRIGGER_RISING)
> +		reg |=3D MPC52xx_GPT_MODE_ICT_RISING;
> +	if (flow_type & IRQF_TRIGGER_FALLING)
> +		reg |=3D MPC52xx_GPT_MODE_ICT_FALLING;
> +	out_be32(&gpt->regs->mode, reg);
> +	spin_unlock_irqrestore(&gpt->lock, flags);
> +
> +	return 0;
> +}
> +
> +static struct irq_chip mpc52xx_gpt_irq_chip =3D {
> +	.typename =3D "MPC52xx GPT",
> +	.unmask =3D mpc52xx_gpt_irq_unmask,
> +	.mask =3D mpc52xx_gpt_irq_mask,
> +	.ack =3D mpc52xx_gpt_irq_ack,
> +	.set_type =3D mpc52xx_gpt_irq_set_type,
> +};
> +
> +void mpc52xx_gpt_irq_cascade(unsigned int virq, struct irq_desc *desc)
> +{
> +	struct mpc52xx_gpt_priv *gpt =3D get_irq_data(virq);
> +	int sub_virq;
> +	u32 status;
> +
> +	status =3D in_be32(&gpt->regs->status) | MPC52xx_GPT_STATUS_IRQMASK;

Like I mentioned in my first review, the following if-clause is always
true. You probably mean "& MPC52xx_GPT_STATUS_IRQMASK"?

> +	if (status) {
> +		sub_virq =3D irq_linear_revmap(gpt->irqhost, 0);
> +		generic_handle_irq(sub_virq);
> +	}
> +}
> +
> +static int mpc52xx_gpt_irq_map(struct irq_host *h, unsigned int virq,
> +			       irq_hw_number_t hw)
> +{
> +	struct mpc52xx_gpt_priv *gpt =3D h->host_data;
> +
> +	dev_dbg(gpt->dev, "%s: h=3D%p, virq=3D%i\n", __func__, h, virq);
> +	set_irq_chip_data(virq, gpt);
> +	set_irq_chip_and_handler(virq, &mpc52xx_gpt_irq_chip, handle_edge_irq);
> +
> +	return 0;
> +}
> +
> +static int mpc52xx_gpt_irq_xlate(struct irq_host *h, struct device_node =
*ct,
> +				 u32 *intspec, unsigned int intsize,
> +				 irq_hw_number_t *out_hwirq,
> +				 unsigned int *out_flags)
> +{
> +	struct mpc52xx_gpt_priv *gpt =3D h->host_data;
> +
> +	dev_dbg(gpt->dev, "%s: flags=3D%i\n", __func__, intspec[0]);
> +
> +	if ((intsize < 1) || (intspec[0] < 1) || (intspec[0] > 3)) {
> +		dev_err(gpt->dev, "bad irq specifier in %s\n", ct->full_name);
> +		return -EINVAL;
> +	}
> +
> +	*out_hwirq =3D 0; /* The GPT only has 1 IRQ line */
> +	*out_flags =3D intspec[0];
> +
> +	return 0;
> +}
> +
> +static struct irq_host_ops mpc52xx_gpt_irq_ops =3D {
> +	.map =3D mpc52xx_gpt_irq_map,
> +	.xlate =3D mpc52xx_gpt_irq_xlate,
> +};
> +
> +static void
> +mpc52xx_gpt_irq_setup(struct mpc52xx_gpt_priv *gpt, struct device_node *=
node)
> +{
> +	int cascade_virq;
> +	unsigned long flags;
> +
> +	/* Only setup cascaded IRQ if device tree claims the GPT is
> +	 * an interrupt controller */
> +	if (!of_find_property(node, "interrupt-controller", NULL))
> +		return;
> +
> +	cascade_virq =3D irq_of_parse_and_map(node, 0);
> +
> +	gpt->irqhost =3D irq_alloc_host(node, IRQ_HOST_MAP_LINEAR, 1,
> +				      &mpc52xx_gpt_irq_ops, -1);
> +	if (!gpt->irqhost) {
> +		dev_err(gpt->dev, "irq_alloc_host() failed\n");
> +		return;
> +	}
> +
> +	gpt->irqhost->host_data =3D gpt;
> +
> +	set_irq_data(cascade_virq, gpt);
> +	set_irq_chained_handler(cascade_virq, mpc52xx_gpt_irq_cascade);
> +
> +	/* Set to Input Capture mode */
> +	spin_lock_irqsave(&gpt->lock, flags);
> +	clrsetbits_be32(&gpt->regs->mode, MPC52xx_GPT_MODE_MS_MASK,
> +			MPC52xx_GPT_MODE_MS_IC);
> +	spin_unlock_irqrestore(&gpt->lock, flags);
> +
> +	dev_dbg(gpt->dev, "%s() complete. virq=3D%i\n", __func__, cascade_virq);
> +}
> +
> +
> +/* ---------------------------------------------------------------------
> + * GPIOLIB hooks
> + */
> +#if defined(CONFIG_GPIOLIB)
> +static inline struct mpc52xx_gpt_priv *gc_to_mpc52xx_gpt(struct gpio_chi=
p *gc)
> +{
> +	return container_of(to_of_gpio_chip(gc), struct mpc52xx_gpt_priv,of_gc);

Space after ','. As it is now, this is a checkpatch-error. Lines over 80
chars are a warning.

> +}
> +
> +static int mpc52xx_gpt_gpio_get(struct gpio_chip *gc, unsigned int gpio)
> +{
> +	struct mpc52xx_gpt_priv *gpt =3D gc_to_mpc52xx_gpt(gc);
> +
> +	return (in_be32(&gpt->regs->status) >> 8) & 1;
> +}
> +
> +static void
> +mpc52xx_gpt_gpio_set(struct gpio_chip *gc, unsigned int gpio, int v)
> +{
> +	struct mpc52xx_gpt_priv *gpt =3D gc_to_mpc52xx_gpt(gc);
> +	unsigned long flags;
> +	u32 r;
> +
> +	dev_dbg(gpt->dev, "%s: gpio:%d v:%d\n", __func__, gpio, v);
> +	r =3D v ? MPC52xx_GPT_MODE_GPIO_OUT_HIGH : MPC52xx_GPT_MODE_GPIO_OUT_LO=
W;
> +
> +	spin_lock_irqsave(&gpt->lock, flags);
> +	clrsetbits_be32(&gpt->regs->mode, MPC52xx_GPT_MODE_GPIO_MASK, r);
> +	spin_unlock_irqrestore(&gpt->lock, flags);
> +}
> +
> +static int mpc52xx_gpt_gpio_dir_in(struct gpio_chip *gc, unsigned int gp=
io)
> +{
> +	struct mpc52xx_gpt_priv *gpt =3D gc_to_mpc52xx_gpt(gc);
> +	unsigned long flags;
> +
> +	dev_dbg(gpt->dev, "%s: gpio:%d\n", __func__, gpio);
> +
> +	spin_lock_irqsave(&gpt->lock, flags);
> +	clrbits32(&gpt->regs->mode, MPC52xx_GPT_MODE_GPIO_MASK);
> +	spin_unlock_irqrestore(&gpt->lock, flags);
> +
> +	return 0;
> +}
> +
> +static int
> +mpc52xx_gpt_gpio_dir_out(struct gpio_chip *gc, unsigned int gpio, int va=
l)
> +{
> +	mpc52xx_gpt_gpio_set(gc, gpio, val);
> +	return 0;
> +}
> +
> +static void
> +mpc52xx_gpt_gpio_setup(struct mpc52xx_gpt_priv *gpt, struct device_node =
*node)
> +{
> +	int rc;
> +
> +	/* Only setup GPIO if the device tree claims the GPT is
> +	 * a GPIO controller */
> +	if (!of_find_property(node, "gpio-controller", NULL))
> +		return;
> +
> +	gpt->of_gc.gc.label =3D kstrdup(node->full_name, GFP_KERNEL);
> +	if (!gpt->of_gc.gc.label) {
> +		dev_err(gpt->dev, "out of memory\n");
> +		return;
> +	}
> +
> +	gpt->of_gc.gpio_cells =3D 2;
> +	gpt->of_gc.gc.ngpio =3D 1;
> +	gpt->of_gc.gc.direction_input  =3D mpc52xx_gpt_gpio_dir_in;
> +	gpt->of_gc.gc.direction_output =3D mpc52xx_gpt_gpio_dir_out;
> +	gpt->of_gc.gc.get =3D mpc52xx_gpt_gpio_get;
> +	gpt->of_gc.gc.set =3D mpc52xx_gpt_gpio_set;
> +	gpt->of_gc.gc.base =3D -1;
> +	gpt->of_gc.xlate =3D of_gpio_simple_xlate;
> +	node->data =3D &gpt->of_gc;
> +	of_node_get(node);
> +
> +	/* Setup external pin in GPIO mode */
> +	clrsetbits_be32(&gpt->regs->mode, MPC52xx_GPT_MODE_MS_MASK,
> +			MPC52xx_GPT_MODE_MS_GPIO);
> +
> +	rc =3D gpiochip_add(&gpt->of_gc.gc);
> +	if (rc)
> +		dev_err(gpt->dev, "gpiochip_add() failed; rc=3D%i\n", rc);
> +
> +	dev_dbg(gpt->dev, "%s() complete.\n", __func__);
> +}
> +#else /* defined(CONFIG_GPIOLIB) */
> +static void
> +mpc52xx_gpt_gpio_setup(struct mpc52xx_gpt_priv *p, struct device_node *n=
p) { }
> +#endif /* defined(CONFIG_GPIOLIB) */
> +
> +/***********************************************************************
> + * SYSFS attributes
> + */
> +#if defined(CONFIG_SYSFS)
> +static ssize_t mpc52xx_gpt_show_regs(struct device *dev,
> +				     struct device_attribute *attr, char *buf)
> +{
> +	struct mpc52xx_gpt_priv *gpt =3D dev_get_drvdata(dev);
> +	int i, len =3D 0;
> +	u32 __iomem *regs =3D (void __iomem *) gpt->regs;
> +
> +	for (i =3D 0; i < 4; i++)
> +		len +=3D sprintf(buf + len, "%.8x ", in_be32(regs + i));
> +	len +=3D sprintf(buf + len, "\n");
> +
> +	return len;
> +}
> +
> +static struct device_attribute mpc52xx_gpt_attrib[] =3D {
> +	__ATTR(regs, S_IRUGO | S_IWUSR, mpc52xx_gpt_show_regs, NULL),
> +};
> +
> +static void mpc52xx_gpt_create_attribs(struct mpc52xx_gpt_priv *gpt)
> +{
> +	int i, err =3D 0;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(mpc52xx_gpt_attrib); i++) {
> +		err =3D device_create_file(gpt->dev, &mpc52xx_gpt_attrib[i]);
> +		if (err)
> +			dev_err(gpt->dev, "error creating attribute %i\n", i);
> +	}
> +
> +}
> +
> +#else /* defined(CONFIG_SYSFS) */
> +static void mpc52xx_gpt_create_attribs(struct mpc52xx_gpt_priv *) { retu=
rn 0; }
> +#endif /* defined(CONFIG_SYSFS) */

Hmmm, I still have problems with this sysfs-entry. If you say that this
is good for debugging, then please make it #DEBUG at least. Imagine
every driver doing such things, this adds bloat. I'd still rather
suggest using

~ memedit /dev/mem
-> map <MBAR> 0x4000
-> md 0x600

which does the same and even allows for more (writing for example).

> +
> +/* ---------------------------------------------------------------------
> + * of_platform bus binding code
> + */
> +static int __devinit mpc52xx_gpt_probe(struct of_device *ofdev,
> +				       const struct of_device_id *match)
> +{
> +	struct mpc52xx_gpt_priv *gpt;
> +
> +	gpt =3D kzalloc(sizeof *gpt, GFP_KERNEL);
> +	if (!gpt)
> +		return -ENOMEM;
> +
> +	spin_lock_init(&gpt->lock);
> +	gpt->dev =3D &ofdev->dev;
> +	gpt->regs =3D of_iomap(ofdev->node, 0);
> +	if (!gpt->regs) {
> +		kfree(gpt);
> +		return -ENOMEM;
> +	}
> +
> +	dev_set_drvdata(&ofdev->dev, gpt);
> +
> +	mpc52xx_gpt_create_attribs(gpt);
> +	mpc52xx_gpt_gpio_setup(gpt, ofdev->node);
> +	mpc52xx_gpt_irq_setup(gpt, ofdev->node);
> +
> +	return 0;
> +}
> +
> +static int mpc52xx_gpt_remove(struct of_device *ofdev)
> +{
> +	return -EBUSY;
> +}
> +
> +static const struct of_device_id mpc52xx_gpt_match[] =3D {
> +	{ .compatible =3D "fsl,mpc5200-gpt", },
> +
> +	/* Depreciated compatible values; don't use for new dts files */
> +	{ .compatible =3D "fsl,mpc5200-gpt-gpio", },
> +	{ .compatible =3D "mpc5200-gpt", },
> +	{}
> +};
> +
> +static struct of_platform_driver mpc52xx_gpt_driver =3D {
> +	.name =3D "mpc52xx-gpt",
> +	.match_table =3D mpc52xx_gpt_match,
> +	.probe =3D mpc52xx_gpt_probe,
> +	.remove =3D mpc52xx_gpt_remove,
> +};
> +
> +static int __init mpc52xx_gpt_init(void)
> +{
> +	if (of_register_platform_driver(&mpc52xx_gpt_driver))
> +		pr_err("error registering MPC52xx GPT driver\n");
> +
> +	return 0;
> +}
> +
> +/* Make sure GPIOs and IRQs get set up before anyone tries to use them */
> +subsys_initcall(mpc52xx_gpt_init);
>=20

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkmJ8poACgkQD27XaX1/VRs41gCfRAmXZKEeNA//uyzfXphAgkaJ
NtwAnjx2RzHaIWEM6uBKWTgcIoqetQrO
=Djy+
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--
