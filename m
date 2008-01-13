Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 0BE36DDE23
	for <linuxppc-dev@ozlabs.org>; Sun, 13 Jan 2008 11:35:58 +1100 (EST)
Date: Sun, 13 Jan 2008 11:35:45 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Sean MacLennan <smaclennan@pikatech.com>
Subject: Re: [PATCH 1/5] Warp Base Platform
Message-Id: <20080113113545.f08d9199.sfr@canb.auug.org.au>
In-Reply-To: <47892645.5070003@pikatech.com>
References: <47852C41.8000506@pikatech.com>
	<20080111115143.4ed89ab6@zod.rchland.ibm.com>
	<4787FE23.7010201@pikatech.com> <200801120723.29393.sr@denx.de>
	<4789235E.1030901@pikatech.com> <47892645.5070003@pikatech.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Sun__13_Jan_2008_11_35_45_+1100_+3y1rxbnJt5Yz.o+"
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Sun__13_Jan_2008_11_35_45_+1100_+3y1rxbnJt5Yz.o+
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Sean,

On Sat, 12 Jan 2008 15:42:45 -0500 Sean MacLennan <smaclennan@pikatech.com>=
 wrote:
>
> +++ b/arch/powerpc/platforms/44x/warp.c

> +static int __init warp_probe(void)
> +{
> +	unsigned long root =3D of_get_flat_dt_root();
> +
> +	if (!of_flat_dt_is_compatible(root, "pika,warp"))
> +		return 0;
> +
> +	return 1;

I should have noticed this earlier and it is really only a simple cleanup
but it could be done if you do another respin.

	return of_flat_dt_is_compatible(root, "pika,warp");

> +void warp_set_power_leds(int green, int red)
> +{
> +	static void __iomem *gpio_base =3D NULL;
> +	unsigned leds;
> +
> +	if (gpio_base =3D=3D NULL) {
> +		struct device_node *np, *from;
> +		int i;
> +
> +		/* Power LEDS are on the second GPIO controller */
> +		for (from =3D NULL, i =3D 0; i < 2; ++i, from =3D np) {
> +			np =3D of_find_compatible_node(from, NULL, "ibm,gpio-440EP");
> +			if (np =3D=3D NULL) {
> +				printk(KERN_ERR __FILE__ ": Unable to find gpio\n");
> +				return;
> +			}
> +		}

		struct device_node *np;
		int i =3D 0;

		for_each_compatible_node(np, NULL, "ibm,gpio-440EP")
			if (i++ =3D=3D 1)
				break;
		if (i < 2) {
			printk(KERN_ERR __FILE__ ": Unable to find gpio\n");
			return;
		}

or

		struct device_node *np =3D of_find_compatible_node(NULL, NULL, "ibm,gpio-=
440EP");

		if (np)
			np =3D of_find_compatible_node(np, NULL, "ibm,gpio-440EP");
		if (!np) {
			printk(KERN_ERR __FILE__ ": Unable to find gpio\n");
			return;
		}

One small thing - all three solutions assume that the device tree
routines return the nodes in the order that they are in the dts file ...
which is OK for now, but something to consider.

> +		gpio_base =3D of_iomap(np, 0);

		of_node_put(np);

> +static int __devinit warp_fpga_init(void)

> +	irq =3D irq_of_parse_and_map(np, 0);
> +	if (irq  =3D=3D NO_IRQ) {

		of_node_put(np);

> +		printk(KERN_ERR __FILE__ ": irq_of_parse_and_map failed\n");
> +		return -EBUSY;
> +	}
> +
> +	/* We do not call of_iomap here since it would map in the entire
> +	 * fpga space, which is over 8k.
> +	 */
> +	if (of_address_to_resource(np, 0, &res)) {

		of_node_put(np);

> +		printk(KERN_ERR __FILE__ ": Unable to get FPGA address\n");
> +		return -ENOENT;
> +	}

	of_node_put(np);

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Sun__13_Jan_2008_11_35_45_+1100_+3y1rxbnJt5Yz.o+
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHiVzmTgG2atn1QN8RAgsPAJ9Vdy9CJ5uE2vFpHyYjP8hxo3Rg6ACfStX1
e/769gcp0LKlr+okej5Qhgs=
=Lh33
-----END PGP SIGNATURE-----

--Signature=_Sun__13_Jan_2008_11_35_45_+1100_+3y1rxbnJt5Yz.o+--
