Return-Path: <wsa@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 70AD4B7D01
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  8 Feb 2010 15:53:37 +1100 (EST)
Date: Mon, 8 Feb 2010 05:53:19 +0100
From: Wolfram Sang <w.sang@pengutronix.de>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH] powerpc: Only print clockevent settings once
Message-ID: <20100208045319.GA1405@pengutronix.de>
References: <20100207222801.GE32246@kryten>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xHFwDpU9dbj6ez1V"
In-Reply-To: <20100207222801.GE32246@kryten>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 08, 2010 at 09:28:01AM +1100, Anton Blanchard wrote:
>=20
> The clockevent multiplier and shift is useful information, but we
> only need to print it once.
>=20
> Signed-off-by: Anton Blanchard <anton@samba.org>
> ---
>=20
> Index: powerpc.git/arch/powerpc/kernel/time.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- powerpc.git.orig/arch/powerpc/kernel/time.c	2010-02-05 14:57:48.83971=
6602 +1100
> +++ powerpc.git/arch/powerpc/kernel/time.c	2010-02-05 14:57:53.057212067 =
+1100
> @@ -930,13 +930,17 @@ static void __init setup_clockevent_mult
> =20
>  static void register_decrementer_clockevent(int cpu)
>  {
> +	static int printed =3D 0;
>  	struct clock_event_device *dec =3D &per_cpu(decrementers, cpu).event;
> =20
>  	*dec =3D decrementer_clockevent;
>  	dec->cpumask =3D cpumask_of(cpu);
> =20
> -	printk(KERN_DEBUG "clockevent: %s mult[%x] shift[%d] cpu[%d]\n",
> -	       dec->name, dec->mult, dec->shift, cpu);
> +	if (!printed) {
> +		printed =3D 1;
> +		printk(KERN_DEBUG "clockevent: %s mult[%x] shift[%d] cpu[%d]\n",
> +		       dec->name, dec->mult, dec->shift, cpu);
> +	}

What about printk_once from kernel.h?

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--xHFwDpU9dbj6ez1V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAktvmL8ACgkQD27XaX1/VRv+iQCePTJJfOw1Ib5wcYrIMs44t5AG
PzIAniOxiNAgjPPfPiFBuAsA3671FvkX
=SLV2
-----END PGP SIGNATURE-----

--xHFwDpU9dbj6ez1V--
