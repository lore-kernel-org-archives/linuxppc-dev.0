Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 7D2DFDDE0A
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Dec 2007 10:24:30 +1100 (EST)
Date: Sat, 22 Dec 2007 10:24:24 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 8/21] [POWERPC] EP405 boards support for arch/powerpc
Message-Id: <20071222102424.bc96d03c.sfr@canb.auug.org.au>
In-Reply-To: <20071221043931.1A5CCDDEC0@ozlabs.org>
References: <20071221043931.1A5CCDDEC0@ozlabs.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Sat__22_Dec_2007_10_24_24_+1100_Io74PDJpFzs9rOPg"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Sat__22_Dec_2007_10_24_24_+1100_Io74PDJpFzs9rOPg
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Ben,

Just a couple of trivial things.

On Fri, 21 Dec 2007 15:39:26 +1100 Benjamin Herrenschmidt <benh@kernel.cras=
hing.org> wrote:
>
> +++ linux-merge/arch/powerpc/boot/4xx.c	2007-12-21 14:19:46.000000000 +11=
00
> @@ -179,13 +179,16 @@ void ibm40x_dbcr_reset(void)
>  #define EMAC_RESET 0x20000000
>  void ibm4xx_quiesce_eth(u32 *emac0, u32 *emac1)
>  {
> -	/* Quiesce the MAL and EMAC(s) since PIBS/OpenBIOS don't do this for us=
 */
> +	/* Quiesce the MAL and EMAC(s) since PIBS/OpenBIOS don't
> +	 * do this for us
> +	 */
>  	if (emac0)
>  		*emac0 =3D EMAC_RESET;
>  	if (emac1)
>  		*emac1 =3D EMAC_RESET;
> =20
>  	mtdcr(DCRN_MAL0_CFG, MAL_RESET);
> +	while (mfdcr(DCRN_MAL0_CFG) & MAL_RESET) {};

You need the {} or the ; but not both and please put them indented on the
next line so that it is very clear that this is an empty loop.

> +	if (cpc0_cr0 & 0x80) {
> +		/* uart0 uses the external clock */
> +		uart0 =3D ser_clk;
> +	} else {
> +		uart0 =3D cpu / udiv;
> +	}

The braces aren't really needed. (Yes, I noticed that you just moved the
code here)

> +	if (cpc0_cr0 & 0x40) {
> +		/* uart1 uses the external clock */
> +		uart1 =3D ser_clk;
> +	} else {
> +		uart1 =3D cpu / udiv;
> +	}

And again.

> +++ linux-merge/arch/powerpc/platforms/40x/ep405.c	2007-12-21 14:19:46.00=
0000000 +1100
> +
> +static struct of_device_id ep405_of_bus[] =3D {

__initdata (preferably) or const

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Sat__22_Dec_2007_10_24_24_+1100_Io74PDJpFzs9rOPg
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHbEstTgG2atn1QN8RAnl2AJ9X6Iiipwd/vlcYaUc6+7EFgVl80gCfRhtj
H/OTW7fRz6a0V6RJPlHfeqU=
=Sm5h
-----END PGP SIGNATURE-----

--Signature=_Sat__22_Dec_2007_10_24_24_+1100_Io74PDJpFzs9rOPg--
