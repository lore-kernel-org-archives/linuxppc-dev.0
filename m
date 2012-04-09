Return-Path: <richard@nod.at>
Received: from radon.swed.at (a.ns.miles-group.at [95.130.255.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "radon.swed.at", Issuer "neon.swed.at" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 60AAAB7033
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Apr 2012 23:06:30 +1000 (EST)
Message-ID: <4F82DECD.10100@nod.at>
Date: Mon, 09 Apr 2012 15:06:21 +0200
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
To: Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH] powerpc: 512x: Fix mpc5121_clk_get()
References: <1332788489-27435-1-git-send-email-richard@nod.at>
In-Reply-To: <1332788489-27435-1-git-send-email-richard@nod.at>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig61BF48B0C84F3DAF2FB373EC"
Cc: paulus@samba.org, agust@denx.de, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig61BF48B0C84F3DAF2FB373EC
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Am 26.03.2012 21:01, schrieb Richard Weinberger:
> If try_module_get() fails, mpc5121_clk_get() might return
> a wrong clock.
>=20
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>  arch/powerpc/platforms/512x/clock.c |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/powerpc/platforms/512x/clock.c b/arch/powerpc/platfor=
ms/512x/clock.c
> index 1d8700f..9f771e0 100644
> --- a/arch/powerpc/platforms/512x/clock.c
> +++ b/arch/powerpc/platforms/512x/clock.c
> @@ -54,14 +54,16 @@ static DEFINE_MUTEX(clocks_mutex);
>  static struct clk *mpc5121_clk_get(struct device *dev, const char *id)=

>  {
>  	struct clk *p, *clk =3D ERR_PTR(-ENOENT);
> -	int dev_match =3D 0;
> -	int id_match =3D 0;
> +	int dev_match;
> +	int id_match;
> =20
>  	if (dev =3D=3D NULL || id =3D=3D NULL)
>  		return clk;
> =20
>  	mutex_lock(&clocks_mutex);
>  	list_for_each_entry(p, &clocks, node) {
> +		dev_match =3D id_match =3D 0;
> +
>  		if (dev =3D=3D p->dev)
>  			dev_match++;
>  		if (strcmp(id, p->name) =3D=3D 0)

*ping*

Thanks,
//richard


--------------enig61BF48B0C84F3DAF2FB373EC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQEcBAEBAgAGBQJPgt7OAAoJEN9758yqZn9eGtAIAIp58++YtCQffl7plFuxeSaw
C/VKYCntkUf9DCKPjpNzq8Gn9IqMKsdfUj60+wcF+Kl6cutNImVbUzkICpBIZxea
JYwWck+SXlrQXlRBSrasGqyzIAZYH3ZuE+YB5HNYgyJ5JcSus+BNqhMrS37jSdS9
NUXXITdRd8ael+mvmAXuKA8amn6riLAhl9OU8UdP1lbqG2eeRfkHw5Dp89EOUEQt
Eh2k9GPxQmqEHI0ntsMYiGdc6MDUx45Dd+YKBz1ehcpuHfc525sl5wybqDjXuLX1
mTOAAbHrlCkZxSrFJQn3w5jqU6ej7/6YtjInFyMzkdB1npti0DsMod0cQDC0nSw=
=ble7
-----END PGP SIGNATURE-----

--------------enig61BF48B0C84F3DAF2FB373EC--
