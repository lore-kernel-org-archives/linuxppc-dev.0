Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vCq0P3X6VzDqD7
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Feb 2017 14:50:29 +1100 (AEDT)
Date: Wed, 1 Feb 2017 14:39:59 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org
Subject: Re: [PATCH kernel] vfio/spapr: Fix missing mutex unlock when
 creating a window
Message-ID: <20170201033959.GL30639@umbus.fritz.box>
References: <20170201032616.23350-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="V3eawNQxI9TAjvgi"
In-Reply-To: <20170201032616.23350-1-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--V3eawNQxI9TAjvgi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 01, 2017 at 02:26:16PM +1100, Alexey Kardashevskiy wrote:
> d9c728949ddc: "vfio/spapr: Postpone default window creation" added
> an additional exit to the VFIO_IOMMU_SPAPR_TCE_CREATE case and made it
> possible to return from tce_iommu_ioctl() without unlocking
> container->lock; this fixes the issue.
>=20
> Fixes: d9c728949ddc
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  drivers/vfio/vfio_iommu_spapr_tce.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iomm=
u_spapr_tce.c
> index 128d10282d16..7690e5bf3cf1 100644
> --- a/drivers/vfio/vfio_iommu_spapr_tce.c
> +++ b/drivers/vfio/vfio_iommu_spapr_tce.c
> @@ -1123,12 +1123,11 @@ static long tce_iommu_ioctl(void *iommu_data,
>  		mutex_lock(&container->lock);
> =20
>  		ret =3D tce_iommu_create_default_window(container);
> -		if (ret)
> -			return ret;
> -
> -		ret =3D tce_iommu_create_window(container, create.page_shift,
> -				create.window_size, create.levels,
> -				&create.start_addr);
> +		if (!ret)
> +			ret =3D tce_iommu_create_window(container,
> +					create.page_shift,
> +					create.window_size, create.levels,
> +					&create.start_addr);
> =20
>  		mutex_unlock(&container->lock);
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--V3eawNQxI9TAjvgi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYkViNAAoJEGw4ysog2bOS3xUP/26cZ2M4eL6GzhddpoP1gH0E
u+z3wy8ZXIy6vJtfKxOAvUE8PFYrSuknLLTvaFw58Q30rcxxNRkGCL8QlTi5ocOF
In7Q4tfoeSQ4kpIp+oGJlePfjdAK5pFEKfGjX/MlTzbmZz8GiFpO4HkIIh9OiZWd
4DYedWAPnUHjYgWxUoFkd39Jigjqa+2HOUAa5WdAiXz35xdVljoXR+t8SsUP6iXk
u+HFhFHm4IYvLKuMXoBiUfBz0Em6AaODIZLWm2ZY1bGPZJjQc5fD34a/EW+9n2sY
4QL0HJc2JnO3pOvtolZHOy5uryDmrtiakV8isB1q7fWZwICZh0rj33SEOzTDWHmW
+Deu9GOmifgI5VWjSN3EXkBSsm01h2beXmYEoanZZhOtTCQmXVxLjSfcLeVntKoW
OzATpNLcxEgT2AZ6CMGfeMko8T/LKQCVsu4Rbaaa5L3PV8sISppYuykU2aBskOdm
yrZWQ0FLpD7dMK/IEmiqJx4uMy4o92Re03S0C7aulwMdpqLgCqC8ksWWZJvUeipa
EfmZunaFaCvU8fyk2wfUE99qm2XRc2DoM4DuQGwLs+VvIal5DB4nYchn/9VFEnBV
edqe5KiqAR8BJTJWRPJd836UO0U8aDXFKaCaJhyCyeJYT66bEBduiqsRmyeUVfSA
8ATbyVs9avtnOSvCK2zk
=iDgb
-----END PGP SIGNATURE-----

--V3eawNQxI9TAjvgi--
