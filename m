Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id B8131DDF82
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Oct 2007 13:50:17 +1100 (EST)
Date: Wed, 31 Oct 2007 13:50:12 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Sergej Stepanov <Sergej.Stepanov@ids.de>
Subject: Re: [PATCH] using mii-bitbang on different processor ports
Message-Id: <20071031135012.557228f2.sfr@canb.auug.org.au>
In-Reply-To: <1193760559.6244.25.camel@p60635-ste.ids.de>
References: <1193760559.6244.25.camel@p60635-ste.ids.de>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__31_Oct_2007_13_50_12_+1100_dJHpJE4GgDJlTX0Y"
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__31_Oct_2007_13_50_12_+1100_dJHpJE4GgDJlTX0Y
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 30 Oct 2007 17:09:19 +0100 Sergej Stepanov <Sergej.Stepanov@ids.de>=
 wrote:
>
>  static int __devinit fs_mii_bitbang_init(struct mii_bus *bus,
>                                           struct device_node *np)
>  {
> -	struct resource res;
> +	struct resource res[2];

Why not just reuse the same resource structure?  You don't seem to need
them both at the same time.

> +	if( !of_address_to_resource(np, 1, &res[1]))
> +	{
> +		bitbang->mdio.dir =3D ioremap(res[1].start, res[1].end - res[1].start =
+ 1);
> +		if (!bitbang->mdio.dir)
> +		{
> +			iounmap(bitbang->mdc.dir);
> +			return -ENOMEM;
> +		}
> +		bitbang->mdio.dat =3D bitbang->mdio.dir + 4;
> +	}
> +	else{

Formatting:
	if () {
	} else {
	}
> +	if ( bitbang->mdio.dir !=3D bitbang->mdc.dir)

No spaces after (, please.  Here and elsewhere.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__31_Oct_2007_13_50_12_+1100_dJHpJE4GgDJlTX0Y
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHJ+1pTgG2atn1QN8RAj8LAJ9gdYNJG76d7KAoyU07nKf6Gb7AKwCgh6tG
YsTO3SmXUMHtgGV/atqJqdY=
=/nCS
-----END PGP SIGNATURE-----

--Signature=_Wed__31_Oct_2007_13_50_12_+1100_dJHpJE4GgDJlTX0Y--
