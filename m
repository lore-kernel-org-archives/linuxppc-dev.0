Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41cFGP0YsvzDq6t
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jul 2018 13:45:01 +1000 (AEST)
Date: Fri, 27 Jul 2018 13:42:21 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@ozlabs.org>,
 Russell Currey <ruscur@russell.cc>
Subject: Re: [PATCH kernel RFC 1/3] powerpc/pseries/iommu: Allow dynamic
 window to start from zero
Message-ID: <20180727034221.GE3694@umbus.fritz.box>
References: <20180725095032.2196-1-aik@ozlabs.ru>
 <20180725095032.2196-2-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="IU5/I01NYhRvwH70"
In-Reply-To: <20180725095032.2196-2-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--IU5/I01NYhRvwH70
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 25, 2018 at 07:50:30PM +1000, Alexey Kardashevskiy wrote:
> At the moment the kernel does not expect dynamic windows to ever start
> at zero on a PCI bus as PAPR requires the hypervisor to create a 32bit
> default window which starts from zero and the pseries kernel only
> creates additional windows.
>=20
> However PAPR permits removing the default window and creating another
> one instead, starting from zero as well. In fact, the kernel used to
> remove the default window after sha1 25ebc45b934 but this has been
> reverted later.
>=20
> Since there are devices capable of more than 32 bits for DMA but less than
> 50, and currently available hardware allows the second window only
> at 1<<59, we will need to be able to create bigger windows starting from
> zero. This does the initial preparation and should not cause any
> behavioral changes.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  arch/powerpc/platforms/pseries/iommu.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platfo=
rms/pseries/iommu.c
> index 06f0296..9ece42f 100644
> --- a/arch/powerpc/platforms/pseries/iommu.c
> +++ b/arch/powerpc/platforms/pseries/iommu.c
> @@ -53,6 +53,8 @@
> =20
>  #include "pseries.h"
> =20
> +#define DDW_INVALID_OFFSET	((uint64_t)-1)
> +
>  static struct iommu_table_group *iommu_pseries_alloc_group(int node)
>  {
>  	struct iommu_table_group *table_group;
> @@ -844,7 +846,7 @@ static u64 find_existing_ddw(struct device_node *pdn)
>  {
>  	struct direct_window *window;
>  	const struct dynamic_dma_window_prop *direct64;
> -	u64 dma_addr =3D 0;
> +	u64 dma_addr =3D DDW_INVALID_OFFSET;
> =20
>  	spin_lock(&direct_window_list_lock);
>  	/* check if we already created a window and dupe that config if so */
> @@ -992,7 +994,7 @@ static u64 enable_ddw(struct pci_dev *dev, struct dev=
ice_node *pdn)
>  	mutex_lock(&direct_window_init_mutex);
> =20
>  	dma_addr =3D find_existing_ddw(pdn);
> -	if (dma_addr !=3D 0)
> +	if (dma_addr !=3D DDW_INVALID_OFFSET)
>  		goto out_unlock;
> =20
>  	/*
> @@ -1228,7 +1230,7 @@ static int dma_set_mask_pSeriesLP(struct device *de=
v, u64 dma_mask)
>  		}
>  		if (pdn && PCI_DN(pdn)) {
>  			dma_offset =3D enable_ddw(pdev, pdn);
> -			if (dma_offset !=3D 0) {
> +			if (dma_offset !=3D DDW_INVALID_OFFSET) {
>  				dev_info(dev, "Using 64-bit direct DMA at offset %llx\n", dma_offset=
);
>  				set_dma_offset(dev, dma_offset);
>  				set_dma_ops(dev, &dma_nommu_ops);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--IU5/I01NYhRvwH70
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAltalJoACgkQbDjKyiDZ
s5KoIhAA4MZ0hYZXaESJX88IP7i3ACjvsHCKNHUBYNIFqH8Tf3wvWWVBy4oNPJgH
boUZx2x2KgYaXovjco3W9LTEfFwjsP96envBPwf1nXs5f6ipI6RZQ3JuzcH4/KuZ
i/eAXP1H+ZlS/Q+99772vTytOMhkA8eip3R0hdV4VyKn6dE0UTIwLE1oSgTZZWYP
YfGN6cmV2JnbJhlSjJMZNXtkAzgxNkNc99WRKtBVBusrCKXXxRGJTekKZzFCD7qC
zNY7lFtoUBIKgDQX1cP1gz5Ks9l486Ue8VSkTurrW/Y6ANUnMImzANcC/KGKAB6M
p106vMGXIt/XNFKYY96wDzod/+eqIFvZ0dbKhN9pKgeP/+DmS6aR0rrAvGK8Q7RK
zfneNGMre5oVLNtlUQPdjPa/u/0dZcCRN122wI6LdNN0/jsf61NUbUqSrukWHrPW
qb5AWMEAflPTofl0un0vxVFwYX0rBnpsAYdwiqYoWnfrc5Awrn3S2hVJpOYiqxf2
l7cafPXgBlwumaw4+bwxxqJaCfuFyCSkveUYTEjZ2sOaJj5GvRTKxRjucBZz0Dj/
7BhEf7qCEDqe+eB0SIIKKILqpCyJ0MOZ3LKk59PHiRwPeQRD7DtJBcERvdC2VvY3
r5pxqLAouDaMmwgtnbjDP0CIjAB7oqUHsSaQpkCcrV1lWpFDhMY=
=BMru
-----END PGP SIGNATURE-----

--IU5/I01NYhRvwH70--
