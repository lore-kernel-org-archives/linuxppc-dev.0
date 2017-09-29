Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y3CWP6N7zzDsPK
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Sep 2017 10:44:49 +1000 (AEST)
Date: Fri, 29 Sep 2017 10:39:25 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH kernel v3] vfio/spapr: Add cond_resched() for huge updates
Message-ID: <20170929003925.GC7712@umbus.fritz.box>
References: <20170928091612.20717-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="5QAgd0e35j3NYeGe"
In-Reply-To: <20170928091612.20717-1-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--5QAgd0e35j3NYeGe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 28, 2017 at 07:16:12PM +1000, Alexey Kardashevskiy wrote:
> Clearing very big IOMMU tables can trigger soft lockups. This adds
> cond_resched() to allow the scheduler to do context switching when
> it decides to.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>=20
> The testcase is POWER9 box with 264GB guest, 4 VFIO devices from
> independent IOMMU groups, 64K IOMMU pages. This configuration produces
> 4325376 TCE entries, each entry update incurs 4 OPAL calls to update
> an individual PE TCE cache; this produced lockups for more than 20s.
> Reducing table size to 4194304 (i.e. 256GB guest) or removing one
> of 4 VFIO devices makes the problem go away.
>=20
> ---
> Changes:
> v3:
> * cond_resched() checks for should_resched() so we just call resched()
> and let the cpu scheduler decide whether to switch or not
>=20
> v2:
> * replaced with time based solution
> ---
>  drivers/vfio/vfio_iommu_spapr_tce.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iomm=
u_spapr_tce.c
> index 63112c36ab2d..759a5bdd40e1 100644
> --- a/drivers/vfio/vfio_iommu_spapr_tce.c
> +++ b/drivers/vfio/vfio_iommu_spapr_tce.c
> @@ -507,6 +507,8 @@ static int tce_iommu_clear(struct tce_container *cont=
ainer,
>  	enum dma_data_direction direction;
> =20
>  	for ( ; pages; --pages, ++entry) {
> +		cond_resched();
> +
>  		direction =3D DMA_NONE;
>  		oldhpa =3D 0;
>  		ret =3D iommu_tce_xchg(tbl, entry, &oldhpa, &direction);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--5QAgd0e35j3NYeGe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnNlj0ACgkQbDjKyiDZ
s5LZbhAAkG9N9ajaKO8f66U9FuB/xgbYRSBivBx3+vvwDxetQ2xqFCzb2W0M8JC0
mOwLh2fUGcLg/nNItthid1dCqUQHbpMbzb5z1U4q+hTc6o+w/I2hV1oI5pU8zsfJ
GX9BCNq+miCP75YlLUoCZEjmhEbLGcHRGRdL2YgvxsFBCf0aDyTsMEFzxhF/ESvt
kLbvD6aIzSTsg+2YSy9K43+x9v7KQEjHvYee4IANx6IdHhFybYy8ATlcPbwwIUKf
JDgZWwi1Fjod5IPMkd/3C3+onXYT7vxpzuQo4pUV6MVV6VrBQiC9JFPT1Q/TUsH4
1UlDWqa5GYKVZM4o0tMFogJYhF7COyfw1dZZcmAilPCWqiN7df2SQ9CIr67/7UtE
s4MzHCMGV2hNwB+4UZuZ4TYDPx2bCSNszo2aF2lrvcetJLcGTERdcvrXjaX6ea03
w98KKGY9H2riI5DNGvwn+y1EdOXThMpFwNg7wi18a1g+y0PiRm7cT6eW0gISQYJA
D609bK1ktRUPapbmabb4S1bp598B8ShzeodbGUvengbDgnSt/frKtjtkJDVQeNnk
On5nSZtEOXEqql7Wqw0GTUE8OTFDAbuPJ6VTtxy7LEpo6xW84LBwb5ciLkHlZGZb
Xxh2aRZTuUWoiJPlzchzSsB7uYIgokoLUHetof7HiL290uzpHGk=
=uuTp
-----END PGP SIGNATURE-----

--5QAgd0e35j3NYeGe--
