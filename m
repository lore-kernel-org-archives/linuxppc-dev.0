Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 2/2] powerpc: Add power management support to VIO bus
From: Michael Ellerman <michael@ellerman.id.au>
To: Brian King <brking@linux.vnet.ibm.com>
In-Reply-To: <201005071158.o47BwxPT013700@d03av03.boulder.ibm.com>
References: <201005071158.o47BwxPT013700@d03av03.boulder.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-7q1u7PTi9Ra9qQX++qWs"
Date: Mon, 10 May 2010 12:35:06 +1000
Message-ID: <1273458906.6591.4.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-7q1u7PTi9Ra9qQX++qWs
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2010-05-07 at 13:58 -0500, Brian King wrote:
> Adds support for suspend/resume for VIO devices. This is needed for
> support for HMC initiated hibernation.
>=20
> Signed-off-by: Brian King <brking@linux.vnet.ibm.com>
> ---
>=20
>  arch/powerpc/kernel/vio.c |   24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>=20
> diff -puN arch/powerpc/kernel/vio.c~powerpc_vio_bus_pm arch/powerpc/kerne=
l/vio.c
> --- linux-2.6/arch/powerpc/kernel/vio.c~powerpc_vio_bus_pm	2010-05-07 13:=
49:16.000000000 -0500
> +++ linux-2.6-bjking1/arch/powerpc/kernel/vio.c	2010-05-07 13:49:16.00000=
0000 -0500
> @@ -1358,6 +1358,29 @@ static int vio_hotplug(struct device *de
>  	return 0;
>  }
> =20
> +static int vio_pm_suspend(struct device *dev)
> +{
> +	const struct dev_pm_ops *pm =3D dev->driver ? dev->driver->pm : NULL;
> +
> +	if (pm && pm->suspend)
> +		return pm->suspend(dev);
> +	return 0;
> +}
> +
> +static int vio_pm_resume(struct device *dev)
> +{
> +	const struct dev_pm_ops *pm =3D dev->driver ? dev->driver->pm : NULL;
> +
> +	if (pm && pm->resume)
> +		return pm->resume(dev);
> +	return 0;
> +}
> +
> +const struct dev_pm_ops vio_dev_pm_ops =3D {
> +	.suspend =3D vio_pm_suspend,
> +	.resume =3D vio_pm_resume,
> +};

That just looks like boiler plate, is there not a generic version
somewhere?

cheers


--=-7q1u7PTi9Ra9qQX++qWs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkvncNoACgkQdSjSd0sB4dIROgCff8O3KB/7RD1b4BAKljAza546
mIsAn1bf20aNatX/F73PgTmnHGRXxPQo
=Y4U7
-----END PGP SIGNATURE-----

--=-7q1u7PTi9Ra9qQX++qWs--
