Return-Path: <wsa@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id 2C522DE028
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Jan 2009 08:33:37 +1100 (EST)
Date: Thu, 29 Jan 2009 22:33:31 +0100
From: Wolfram Sang <w.sang@pengutronix.de>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 7/8] powerpc/5200: Refactor mpc5200 interrupt
	controller driver
Message-ID: <20090129213331.GF1406@pengutronix.de>
References: <20090121205506.31232.27908.stgit@localhost.localdomain>
	<20090121205540.31232.77034.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MZf7D3rAEoQgPanC"
In-Reply-To: <20090121205540.31232.77034.stgit@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--MZf7D3rAEoQgPanC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 21, 2009 at 01:55:41PM -0700, Grant Likely wrote:
> From: Grant Likely <grant.likely@secretlab.ca>
>=20
> Rework the mpc5200-pic driver to simplify it and fix up the setting
> of desc->status when set_type is called for internal IRQs (so they
> are reported as level, not edge).  The simplification is due to
> splitting off the handling of external IRQs into a separate block
> so they don't need to be handled as exceptions in the normal
> CRIT, MAIN and PERP paths.
>=20
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> CC: Wolfram Sang <w.sang@pengutronix.de>

Can't say much about this one as I have never dealt with the PIC
directly so far. Yet, my phyCORE-MPC5200B-tiny behaves normal, so

Tested-by: Wolfram Sang <w.sang@pengutronix.de>

> ---
>=20
>  arch/powerpc/platforms/52xx/mpc52xx_pic.c |  145 ++++++++++++-----------=
------
>  1 files changed, 58 insertions(+), 87 deletions(-)
>=20
>=20
> diff --git a/arch/powerpc/platforms/52xx/mpc52xx_pic.c b/arch/powerpc/pla=
tforms/52xx/mpc52xx_pic.c
> index c0a9559..277c9c5 100644
> --- a/arch/powerpc/platforms/52xx/mpc52xx_pic.c
> +++ b/arch/powerpc/platforms/52xx/mpc52xx_pic.c
> @@ -190,10 +190,10 @@ static void mpc52xx_extirq_ack(unsigned int virq)
> =20
>  static int mpc52xx_extirq_set_type(unsigned int virq, unsigned int flow_=
type)
>  {
> -	struct irq_desc *desc =3D get_irq_desc(virq);
>  	u32 ctrl_reg, type;
>  	int irq;
>  	int l2irq;
> +	void *handler =3D handle_level_irq;
> =20
>  	irq =3D irq_map[virq].hwirq;
>  	l2irq =3D irq & MPC52xx_IRQ_L2_MASK;
> @@ -201,32 +201,21 @@ static int mpc52xx_extirq_set_type(unsigned int vir=
q, unsigned int flow_type)
>  	pr_debug("%s: irq=3D%x. l2=3D%d flow_type=3D%d\n", __func__, irq, l2irq=
, flow_type);
> =20
>  	switch (flow_type) {
> -	case IRQF_TRIGGER_HIGH:
> -		type =3D 0;
> -		break;
> -	case IRQF_TRIGGER_RISING:
> -		type =3D 1;
> -		break;
> -	case IRQF_TRIGGER_FALLING:
> -		type =3D 2;
> -		break;
> -	case IRQF_TRIGGER_LOW:
> -		type =3D 3;
> -		break;
> +	case IRQF_TRIGGER_HIGH: type =3D 0; break;
> +	case IRQF_TRIGGER_RISING: type =3D 1; handler =3D handle_edge_irq; brea=
k;
> +	case IRQF_TRIGGER_FALLING: type =3D 2; handler =3D handle_edge_irq; bre=
ak;
> +	case IRQF_TRIGGER_LOW: type =3D 3; break;
>  	default:
>  		type =3D 0;
>  	}
> =20
> -	desc->status &=3D ~(IRQ_TYPE_SENSE_MASK | IRQ_LEVEL);
> -	desc->status |=3D flow_type & IRQ_TYPE_SENSE_MASK;
> -	if (flow_type & (IRQ_TYPE_LEVEL_HIGH | IRQ_TYPE_LEVEL_LOW))
> -		desc->status |=3D IRQ_LEVEL;
> -
>  	ctrl_reg =3D in_be32(&intr->ctrl);
>  	ctrl_reg &=3D ~(0x3 << (22 - (l2irq * 2)));
>  	ctrl_reg |=3D (type << (22 - (l2irq * 2)));
>  	out_be32(&intr->ctrl, ctrl_reg);
> =20
> +	__set_irq_handler_unlocked(virq, handler);
> +
>  	return 0;
>  }
> =20
> @@ -241,6 +230,11 @@ static struct irq_chip mpc52xx_extirq_irqchip =3D {
>  /*
>   * Main interrupt irq_chip
>   */
> +static int mpc52xx_null_set_type(unsigned int virq, unsigned int flow_ty=
pe)
> +{
> +	return 0; /* Do nothing so that the sense mask will get updated */
> +}
> +
>  static void mpc52xx_main_mask(unsigned int virq)
>  {
>  	int irq;
> @@ -268,6 +262,7 @@ static struct irq_chip mpc52xx_main_irqchip =3D {
>  	.mask =3D mpc52xx_main_mask,
>  	.mask_ack =3D mpc52xx_main_mask,
>  	.unmask =3D mpc52xx_main_unmask,
> +	.set_type =3D mpc52xx_null_set_type,
>  };
> =20
>  /*
> @@ -300,6 +295,7 @@ static struct irq_chip mpc52xx_periph_irqchip =3D {
>  	.mask =3D mpc52xx_periph_mask,
>  	.mask_ack =3D mpc52xx_periph_mask,
>  	.unmask =3D mpc52xx_periph_unmask,
> +	.set_type =3D mpc52xx_null_set_type,
>  };
> =20
>  /*
> @@ -343,9 +339,19 @@ static struct irq_chip mpc52xx_sdma_irqchip =3D {
>  	.mask =3D mpc52xx_sdma_mask,
>  	.unmask =3D mpc52xx_sdma_unmask,
>  	.ack =3D mpc52xx_sdma_ack,
> +	.set_type =3D mpc52xx_null_set_type,
>  };
> =20
>  /**
> + * mpc52xx_is_extirq - Returns true if hwirq number is for an external I=
RQ
> + */
> +static int mpc52xx_is_extirq(int l1, int l2)
> +{
> +	return ((l1 =3D=3D 0) && (l2 =3D=3D 0)) ||
> +	       ((l1 =3D=3D 1) && (l2 >=3D 1) && (l2 <=3D 3));
> +}
> +
> +/**
>   * mpc52xx_irqhost_xlate - translate virq# from device tree interrupts p=
roperty
>   */
>  static int mpc52xx_irqhost_xlate(struct irq_host *h, struct device_node =
*ct,
> @@ -363,38 +369,23 @@ static int mpc52xx_irqhost_xlate(struct irq_host *h=
, struct device_node *ct,
> =20
>  	intrvect_l1 =3D (int)intspec[0];
>  	intrvect_l2 =3D (int)intspec[1];
> -	intrvect_type =3D (int)intspec[2];
> +	intrvect_type =3D (int)intspec[2] & 0x3;
> =20
>  	intrvect_linux =3D (intrvect_l1 << MPC52xx_IRQ_L1_OFFSET) &
>  			 MPC52xx_IRQ_L1_MASK;
>  	intrvect_linux |=3D intrvect_l2 & MPC52xx_IRQ_L2_MASK;
> =20
> -	pr_debug("return %x, l1=3D%d, l2=3D%d\n", intrvect_linux, intrvect_l1,
> -		 intrvect_l2);
> -
>  	*out_hwirq =3D intrvect_linux;
> -	*out_flags =3D mpc52xx_map_senses[intrvect_type];
> +	*out_flags =3D IRQ_TYPE_LEVEL_LOW;
> +	if (mpc52xx_is_extirq(intrvect_l1, intrvect_l2))
> +		*out_flags =3D mpc52xx_map_senses[intrvect_type];
> =20
> +	pr_debug("return %x, l1=3D%d, l2=3D%d\n", intrvect_linux, intrvect_l1,
> +		 intrvect_l2);
>  	return 0;
>  }
> =20
>  /**
> - * mpc52xx_irqx_gettype - determine the IRQ sense type (level/edge)
> - *
> - * Only external IRQs need this.
> - */
> -static int mpc52xx_irqx_gettype(int irq)
> -{
> -	int type;
> -	u32 ctrl_reg;
> -
> -	ctrl_reg =3D in_be32(&intr->ctrl);
> -	type =3D (ctrl_reg >> (22 - irq * 2)) & 0x3;
> -
> -	return mpc52xx_map_senses[type];
> -}
> -
> -/**
>   * mpc52xx_irqhost_map - Hook to map from virq to an irq_chip structure
>   */
>  static int mpc52xx_irqhost_map(struct irq_host *h, unsigned int virq,
> @@ -402,68 +393,46 @@ static int mpc52xx_irqhost_map(struct irq_host *h, =
unsigned int virq,
>  {
>  	int l1irq;
>  	int l2irq;
> -	struct irq_chip *good_irqchip;
> +	struct irq_chip *irqchip;
>  	void *good_handle;
>  	int type;
> +	u32 reg;
> =20
>  	l1irq =3D (irq & MPC52xx_IRQ_L1_MASK) >> MPC52xx_IRQ_L1_OFFSET;
>  	l2irq =3D irq & MPC52xx_IRQ_L2_MASK;
> =20
>  	/*
> -	 * Most of ours IRQs will be level low
> -	 * Only external IRQs on some platform may be others
> +	 * External IRQs are handled differently by the hardware so they are
> +	 * handled by a dedicated irq_chip structure.
>  	 */
> -	type =3D IRQ_TYPE_LEVEL_LOW;
> +	if (mpc52xx_is_extirq(l1irq, l2irq)) {
> +		reg =3D in_be32(&intr->ctrl);
> +		type =3D mpc52xx_map_senses[(reg >> (22 - l2irq * 2)) & 0x3];
> +		if ((type =3D=3D IRQ_TYPE_EDGE_FALLING) ||
> +		    (type =3D=3D IRQ_TYPE_EDGE_RISING))
> +			good_handle =3D handle_edge_irq;
> +		else
> +			good_handle =3D handle_level_irq;
> +
> +		set_irq_chip_and_handler(virq, &mpc52xx_extirq_irqchip, good_handle);
> +		pr_debug("%s: External IRQ%i virq=3D%x, hw=3D%x. type=3D%x\n",
> +			 __func__, l2irq, virq, (int)irq, type);
> +		return 0;
> +	}
> =20
> +	/* It is an internal SOC irq.  Choose the correct irq_chip */
>  	switch (l1irq) {
> -	case MPC52xx_IRQ_L1_CRIT:
> -		pr_debug("%s: Critical. l2=3D%x\n", __func__, l2irq);
> -
> -		BUG_ON(l2irq !=3D 0);
> -
> -		type =3D mpc52xx_irqx_gettype(l2irq);
> -		good_irqchip =3D &mpc52xx_extirq_irqchip;
> -		break;
> -
> -	case MPC52xx_IRQ_L1_MAIN:
> -		pr_debug("%s: Main IRQ[1-3] l2=3D%x\n", __func__, l2irq);
> -
> -		if ((l2irq >=3D 1) && (l2irq <=3D 3)) {
> -			type =3D mpc52xx_irqx_gettype(l2irq);
> -			good_irqchip =3D &mpc52xx_extirq_irqchip;
> -		} else {
> -			good_irqchip =3D &mpc52xx_main_irqchip;
> -		}
> -		break;
> -
> -	case MPC52xx_IRQ_L1_PERP:
> -		pr_debug("%s: Peripherals. l2=3D%x\n", __func__, l2irq);
> -		good_irqchip =3D &mpc52xx_periph_irqchip;
> -		break;
> -
> -	case MPC52xx_IRQ_L1_SDMA:
> -		pr_debug("%s: SDMA. l2=3D%x\n", __func__, l2irq);
> -		good_irqchip =3D &mpc52xx_sdma_irqchip;
> -		break;
> -
> +	case MPC52xx_IRQ_L1_MAIN: irqchip =3D &mpc52xx_main_irqchip; break;
> +	case MPC52xx_IRQ_L1_PERP: irqchip =3D &mpc52xx_periph_irqchip; break;
> +	case MPC52xx_IRQ_L1_SDMA: irqchip =3D &mpc52xx_sdma_irqchip; break;
>  	default:
> -		pr_err("%s: invalid virq requested (0x%x)\n", __func__, virq);
> +		pr_err("%s: invalid irq: virq=3D%i, l1=3D%i, l2=3D%i\n",
> +		       __func__, virq, l1irq, l2irq);
>  		return -EINVAL;
>  	}
> =20
> -	switch (type) {
> -	case IRQ_TYPE_EDGE_FALLING:
> -	case IRQ_TYPE_EDGE_RISING:
> -		good_handle =3D handle_edge_irq;
> -		break;
> -	default:
> -		good_handle =3D handle_level_irq;
> -	}
> -
> -	set_irq_chip_and_handler(virq, good_irqchip, good_handle);
> -
> -	pr_debug("%s: virq=3D%x, hw=3D%x. type=3D%x\n", __func__, virq,
> -		 (int)irq, type);
> +	set_irq_chip_and_handler(virq, irqchip, handle_level_irq);
> +	pr_debug("%s: virq=3D%x, l1=3D%i, l2=3D%i\n", __func__, virq, l1irq, l2=
irq);
> =20
>  	return 0;
>  }
> @@ -502,6 +471,8 @@ void __init mpc52xx_init_irq(void)
>  		panic(__FILE__	": find_and_map failed on 'mpc5200-bestcomm'. "
>  				"Check node !");
> =20
> +	pr_debug("MPC5200 IRQ controller mapped to 0x%p\n", intr);
> +
>  	/* Disable all interrupt sources. */
>  	out_be32(&sdma->IntPend, 0xffffffff);	/* 1 means clear pending */
>  	out_be32(&sdma->IntMask, 0xffffffff);	/* 1 means disabled */
>=20

--=20
  Dipl.-Ing. Wolfram Sang | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry

--MZf7D3rAEoQgPanC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkmCIKsACgkQD27XaX1/VRsmzQCgrkJTdGCVzYQPTYjzunt485um
fe4AoL2fWFwhdjtsZsKB3hio29RGt3IA
=kYaR
-----END PGP SIGNATURE-----

--MZf7D3rAEoQgPanC--
