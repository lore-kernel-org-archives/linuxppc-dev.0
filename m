Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id C54F2DDE0E
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Feb 2008 13:34:34 +1100 (EST)
Date: Fri, 29 Feb 2008 13:34:33 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Alexandr Smirnov <asmirnov@ru.mvista.com>
Subject: Re: [PATCH 4/4] Emerson KSI8560 base support
Message-Id: <20080229133433.b606dee4.sfr@canb.auug.org.au>
In-Reply-To: <20080228185202.GE26971@ru.mvista.com>
References: <20080228183503.GA26971@ru.mvista.com>
	<20080228185202.GE26971@ru.mvista.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Fri__29_Feb_2008_13_34_33_+1100_EiT3x.ING.nVEvWO"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Fri__29_Feb_2008_13_34_33_+1100_EiT3x.ING.nVEvWO
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Alexandr,

On Thu, 28 Feb 2008 21:52:02 +0300 Alexandr Smirnov <asmirnov@ru.mvista.com=
> wrote:
>
> +void __iomem *cpld_base =3D NULL;

Should this be static?

> +static void cpm2_cascade(unsigned int irq, struct irq_desc *desc)
> +{
> +	int cascade_irq;
> +
> +	while ((cascade_irq =3D cpm2_get_irq()) >=3D 0) {
> +		generic_handle_irq(cascade_irq);
> +	}

We normally don't bracket single line blocks.

> +static void __init ksi8560_pic_init(void)
> +{
> +	struct mpic *mpic;
> +	struct resource r;
> +	struct device_node *np =3D NULL;
> +#ifdef CONFIG_CPM2
> +	int irq;
> +#endif
> +
> +	np =3D of_find_node_by_type(np, "open-pic");

You can pass NULL as the first argument here, so you don't need the
initialisation of "np" above.

> +static struct cpm_pin ksi8560_pins[] =3D {

This should be marked __init.

> +static void ksi8560_show_cpuinfo(struct seq_file *m)
> +{

> +	seq_printf(m, "Hardware rev\t: %d\n",
> +				in_8(cpld_base + KSI8560_CPLD_HVR));

What if cpld_base is NULL?

> +static struct of_device_id __initdata of_bus_ids[] =3D {
> +	{ .type =3D "soc", },
> +	{ .name =3D "cpm", },
> +	{ .name =3D "localbus", },
> +	{},
> +};
> +
> +static int __init declare_of_platform_devices(void)
> +{
> +	if (!machine_is(ksi8560))
> +		return 0;

You don't need this test because this is a machine_init_call.

> +static int __init ksi8560_probe(void)
> +{
> +	unsigned long root =3D of_get_flat_dt_root();
> +
> +	return of_flat_dt_is_compatible(root, "emerson,KSI8560");

You need to include asm/prom.h to use these routines.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__29_Feb_2008_13_34_33_+1100_EiT3x.ING.nVEvWO
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHx289TgG2atn1QN8RAtRNAJ9gR4O2q5Bcd/EGCAkT+9tdogpNMQCgjsq/
eDIq9IAMzqsyWKr2B89FMcI=
=YPmp
-----END PGP SIGNATURE-----

--Signature=_Fri__29_Feb_2008_13_34_33_+1100_EiT3x.ING.nVEvWO--
