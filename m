Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 8F13BDDF0D
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Mar 2008 10:27:16 +1100 (EST)
Date: Thu, 20 Mar 2008 10:27:10 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Stefan Roese <sr@denx.de>
Subject: Re: [PATCH 1/2] [POWERPC] Add PPC4xx L2-cache support (440GX &
	460EX/GT)
Message-Id: <20080320102710.4b6d8060.sfr@canb.auug.org.au>
In-Reply-To: <1205847389-17771-1-git-send-email-sr@denx.de>
References: <1205847389-17771-1-git-send-email-sr@denx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__20_Mar_2008_10_27_10_+1100_RiM/DoE=WGaY19pm"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Thu__20_Mar_2008_10_27_10_+1100_RiM/DoE=WGaY19pm
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Stefan,

Just a few trivial things ...

On Tue, 18 Mar 2008 14:36:29 +0100 Stefan Roese <sr@denx.de> wrote:
>
> +++ b/arch/powerpc/sysdev/ppc4xx_soc.c
>
> +static int __init ppc4xx_l2c_probe(void)
> +{
> +	struct device_node *np =3D NULL;

This initialisation is unneeded.

> +	/* Map DCRs */
> +	dcrreg =3D of_get_property(np, "dcr-reg", &len);
> +	if (!dcrreg || (len !=3D 4*sizeof(u32))) {

I prefer spaces around binary operators.

> +		printk(KERN_ERR "%s: Can't get DCR register base !",
> +		       np->full_name);
> +		return -ENODEV;

Since of_find_compatible_node() gets a reference to np, you need an
of_node_put(np) before you return.

> +	if (irq =3D=3D NO_IRQ) {
> +		printk(KERN_ERR "irq_of_parse_and_map failed\n");
> +		return -ENODEV;

And again.

> +	if (request_irq(irq, l2c_error_handler, IRQF_DISABLED, "L2C", 0) < 0) {
> +		printk(KERN_ERR "Cannot install L2C error handler"
> +		       ", cache is not enabled\n");
> +		return -ENODEV;

And again.

> +	return 0;

And again.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__20_Mar_2008_10_27_10_+1100_RiM/DoE=WGaY19pm
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFH4aFTTgG2atn1QN8RAitVAJ9GqzTbnooh1VOMF9FvhvY2R8r9TwCeLQJR
AvASKDXlNEWGE7F7RU8m8JE=
=5aSn
-----END PGP SIGNATURE-----

--Signature=_Thu__20_Mar_2008_10_27_10_+1100_RiM/DoE=WGaY19pm--
