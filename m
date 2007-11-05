Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id EFCFBDDDF6
	for <linuxppc-dev@ozlabs.org>; Mon,  5 Nov 2007 11:23:17 +1100 (EST)
Date: Mon, 5 Nov 2007 11:23:07 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] pasemi: clean up gpio_mdio init
Message-Id: <20071105112307.13d4b8bb.sfr@canb.auug.org.au>
In-Reply-To: <20071104213709.GA13266@lixom.net>
References: <472DF914.7020601@tiscali.nl> <20071104174701.GB10191@lixom.net>
	<472E0569.7070601@tiscali.nl> <20071104213709.GA13266@lixom.net>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Mon__5_Nov_2007_11_23_07_+1100_0OJbPv433SZckeoB"
Cc: linuxppc-dev@ozlabs.org, Roel Kluin <12o3l@tiscali.nl>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Mon__5_Nov_2007_11_23_07_+1100_0OJbPv433SZckeoB
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Olof,

Just a couple of small things ...

On Sun, 4 Nov 2007 15:37:09 -0600 Olof Johansson <olof@lixom.net> wrote:
>
> +		ip =3D of_get_property(phy_dn, "interrupts", NULL);
> +		regp =3D of_get_property(phy_dn, "reg", NULL);
> +		if (!ip || !regp)
> +			continue;
> +		new_bus->irq[*regp] =3D irq_create_mapping(NULL, *ip);

Paranoid me says to check that *regp is in range.

>  int gpio_mdio_init(void)
>  {
> +	struct device_node *np;
> +
> +	np =3D of_find_compatible_node(NULL, "gpio", "1682m-gpio");
> +	if (!np)
> +		return -ENODEV;
> +	gpio_regs =3D of_iomap(np, 0);

	of_node_put(np);		?

> +	if (!gpio_regs)
> +		return -ENODEV;
> +
>  	return of_register_platform_driver(&gpio_mdio_driver);
>  }
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Mon__5_Nov_2007_11_23_07_+1100_0OJbPv433SZckeoB
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHLmJ0TgG2atn1QN8RAsrrAJ9Oad/HCtr6INGVMyiCu8zS1s70KgCgjhpn
X2k5ckrGX6bGVGAKOIEynf4=
=2Ydb
-----END PGP SIGNATURE-----

--Signature=_Mon__5_Nov_2007_11_23_07_+1100_0OJbPv433SZckeoB--
