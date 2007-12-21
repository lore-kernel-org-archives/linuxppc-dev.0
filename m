Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 7DD7CDDF20
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Dec 2007 16:16:14 +1100 (EST)
Date: Fri, 21 Dec 2007 16:16:09 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: Enable RTC for Ebony and Walnut
Message-Id: <20071221161609.b6061eb3.sfr@canb.auug.org.au>
In-Reply-To: <20071221022130.GI2665@localhost.localdomain>
References: <20071221022130.GI2665@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Fri__21_Dec_2007_16_16_09_+1100_OeptH_rJ=uBzbC56"
Cc: linuxppc-dev@ozlabs.org, Paul, Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Fri__21_Dec_2007_16_16_09_+1100_OeptH_rJ=uBzbC56
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 21 Dec 2007 13:21:30 +1100 David Gibson <david@gibson.dropbear.id.a=
u> wrote:
>
> +++ working-2.6/arch/powerpc/sysdev/of_rtc.c	2007-12-21 13:11:34.00000000=
0 +1100
> +#include <asm/of_platform.h>

Use linux/of_platform.h, please.

> +
> +static struct {

const or __initdata

> +	char *compatible;

const

> +	char *plat_name;

const (ok, no, thanks to platform_device_register_simple()).

> +} of_rtc_table[] =3D {
> +	{ "ds1743-nvram", "rtc-ds1742" },
> +};
> +
> +void __init of_instantiate_rtc(void)
> +{
> +	struct device_node *node;
> +	int err;
> +	int i;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(of_rtc_table); i++) {
> +		char *compatible =3D of_rtc_table[i].compatible;

const (or maybe just use of_rtc_table[i].compatible directly in the one
place it is used).

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__21_Dec_2007_16_16_09_+1100_OeptH_rJ=uBzbC56
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHa0wdTgG2atn1QN8RAgQgAJ9kkwGaf2dIly37DHzFqVOWunaDYACdHHao
xIycKE18jQZyxdMUYPysuKM=
=hMPC
-----END PGP SIGNATURE-----

--Signature=_Fri__21_Dec_2007_16_16_09_+1100_OeptH_rJ=uBzbC56--
