Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 39DE2DDF4B
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jan 2008 11:20:35 +1100 (EST)
Date: Wed, 9 Jan 2008 11:20:22 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 1/3] [POWERPC] Implement support for the GPIO LIB API
Message-Id: <20080109112022.f2f99034.sfr@canb.auug.org.au>
In-Reply-To: <20080108184518.GA18445@localhost.localdomain>
References: <20080108184341.GA29753@localhost.localdomain>
	<20080108184518.GA18445@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__9_Jan_2008_11_20_22_+1100_cf6/YVWNx.ePj9s3"
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__9_Jan_2008_11_20_22_+1100_cf6/YVWNx.ePj9s3
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 8 Jan 2008 21:45:18 +0300 Anton Vorontsov <avorontsov@ru.mvista.com=
> wrote:
>
> +int of_mm_gpiochip_add(struct device_node *np,
> +		       const struct of_gpio_chip *of_gc)
> +{
> +	int ret =3D -ENOMEM;
> +	struct of_mm_gpio_chip *mm_gc;
> +
> +	mm_gc =3D kzalloc(sizeof(*mm_gc), GFP_KERNEL);
> +	if (!mm_gc)
> +		goto err0;
> +
> +	mm_gc->of_gc =3D *of_gc;
> +
> +	mm_gc->of_gc.gc.label =3D kstrdup(np->full_name, GFP_KERNEL);
> +	if (!mm_gc->of_gc.gc.label)
> +		goto err1;
> +
> +	ret =3D of_get_gpiochip_base(np);
> +	if (ret < 0)
> +		goto err2;
> +
> +	mm_gc->regs =3D of_iomap(np, 0);
> +	if (!mm_gc->regs) {
> +		ret =3D -ENOMEM;
> +		goto err1;

Should this be err2?

> +	}
> +
> +	mm_gc->of_gc.gc.base =3D ret;
> +
> +	np->data =3D &mm_gc->of_gc;
> +
> +	ret =3D gpiochip_add(&mm_gc->of_gc.gc);
> +	if (ret)
> +		goto err2;
> +
> +	of_node_get(np);

Why do you this of_node_get(np) when you do not keep a reference to np in
this routine?

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__9_Jan_2008_11_20_22_+1100_cf6/YVWNx.ePj9s3
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHhBNKTgG2atn1QN8RAuZYAJ0dEhSe4ZrYiPjh/3XJc3oW5kr1KQCaAh6q
5LbiXgBHBrP6BwnRD6btwTg=
=yiKT
-----END PGP SIGNATURE-----

--Signature=_Wed__9_Jan_2008_11_20_22_+1100_cf6/YVWNx.ePj9s3--
