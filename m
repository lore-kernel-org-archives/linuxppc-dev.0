Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id B6123DDF2F
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jan 2008 12:04:20 +1100 (EST)
Date: Tue, 8 Jan 2008 12:04:09 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [RFC 1/2] mpc5200: Add common clock setting routine
	mpc52xx_set_psc_clkdiv()
Message-Id: <20080108120409.9b8acf75.sfr@canb.auug.org.au>
In-Reply-To: <20080107190335.13535.29837.stgit@trillian.secretlab.ca>
References: <20080107185849.13535.38262.stgit@trillian.secretlab.ca>
	<20080107190335.13535.29837.stgit@trillian.secretlab.ca>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__8_Jan_2008_12_04_09_+1100_PssUl06bROkud=l_"
Cc: linuxppc-dev@ozlabs.org, dragos.carp@toptica.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__8_Jan_2008_12_04_09_+1100_PssUl06bROkud=l_
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 07 Jan 2008 12:03:59 -0700 Grant Likely <grant.likely@secretlab.ca>=
 wrote:
>
> +++ b/arch/powerpc/platforms/52xx/mpc52xx_common.c
> =20
> -static struct of_device_id __init mpc52xx_ids[] =3D {

Why not just leave this here and mark in __initdata?

> +/**
> + * mpc52xx_declare_of_platform_devices: register internal devices and ch=
ildren
> + *					of the localplus bus to the of_platform
> + *					bus.
> + */
>  void __init
>  mpc52xx_declare_of_platform_devices(void)
>  {
> +	const static struct of_device_id mpc52xx_bus_ids[] =3D {

Or just mark it __initdata instead of const?

> +		{ .compatible =3D "fsl,mpc5200-immr", },
> +		{ .compatible =3D "fsl,lpb", },
> +		{ .type =3D "builtin", .compatible =3D "mpc5200", }, /* efika */
> +		{ .type =3D "soc", .compatible =3D "mpc5200", }, /* old */

And you lost the comment about the last two being deprecated mates.

> +mpc52xx_map_common_devices(void)
>  {
>  	struct device_node *np;
> -	struct of_device_id gpt_ids[] =3D {
> +	const static struct of_device_id gpt_ids[] =3D {

Again __initdata?

> +	const static struct of_device_id cdm_ids[] =3D {

And again?

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__8_Jan_2008_12_04_09_+1100_PssUl06bROkud=l_
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHgswNTgG2atn1QN8RAg69AJwIsHkJu+blaS0HGkRlNqnl79FazQCeNI0U
cPgi+BGJCn08uQXdvep+dCI=
=IvuC
-----END PGP SIGNATURE-----

--Signature=_Tue__8_Jan_2008_12_04_09_+1100_PssUl06bROkud=l_--
