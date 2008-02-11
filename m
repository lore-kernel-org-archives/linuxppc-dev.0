Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 399CFDDEDA
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Feb 2008 10:51:17 +1100 (EST)
Date: Tue, 12 Feb 2008 10:51:13 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Dave Jiang <djiang@mvista.com>
Subject: Re: [PATCH] powerpc: Marvell 64x60 EDAC platform devices setup
Message-Id: <20080212105113.553659b0.sfr@canb.auug.org.au>
In-Reply-To: <20080211225023.GA15541@blade.az.mvista.com>
References: <20080211225023.GA15541@blade.az.mvista.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__12_Feb_2008_10_51_13_+1100_Z8qwgCNSV0N.m8w="
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__12_Feb_2008_10_51_13_+1100_Z8qwgCNSV0N.m8w=
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Dave,

On Mon, 11 Feb 2008 15:50:23 -0700 Dave Jiang <djiang@mvista.com> wrote:
>
> +static int __init mv64x60_edac_pdev_init(struct device_node *np,
> +                                         int id,
> +                                         int num_addr,
> +                                         char *pdev_name)

The pdev_name is just passed to platform_device_register_simple() which
take a "const char *", so make pdev_name consta as well, please.

> +static int __init mv64x60_pci_fixup(struct device_node *np)
> +{
> +	struct resource res;
> +	void __iomem *pci_serr;
> +	int ret;
> +
> +	ret =3D of_address_to_resource(np, 1, &res);
> +	if (ret)
> +		return ret;
> +
> +	pci_serr =3D ioremap(res.start, res.end - res.start + 1);

Why not use of_iomap(np, 1), then you don't need res.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__12_Feb_2008_10_51_13_+1100_Z8qwgCNSV0N.m8w=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHsN91TgG2atn1QN8RArlVAJ9FIIF2JYLBrrbZl5obr8ZdhOY/awCghisD
eVzHSeE44nDyOOX1HbMirdY=
=sDJD
-----END PGP SIGNATURE-----

--Signature=_Tue__12_Feb_2008_10_51_13_+1100_Z8qwgCNSV0N.m8w=--
