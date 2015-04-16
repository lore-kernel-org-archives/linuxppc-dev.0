Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 05C871A001E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Apr 2015 16:11:09 +1000 (AEST)
Date: Thu, 16 Apr 2015 16:00:36 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel v8 13/31] vfio: powerpc/spapr: powerpc/iommu:
 Rework IOMMU ownership control
Message-ID: <20150416060036.GD3632@voom.redhat.com>
References: <1428647473-11738-1-git-send-email-aik@ozlabs.ru>
 <1428647473-11738-14-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="zS7rBR6csb6tI2e1"
In-Reply-To: <1428647473-11738-14-git-send-email-aik@ozlabs.ru>
Cc: Alex Williamson <alex.williamson@redhat.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--zS7rBR6csb6tI2e1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 10, 2015 at 04:30:55PM +1000, Alexey Kardashevskiy wrote:
> This replaces iommu_take_ownership()/iommu_release_ownership() calls
> with the callback calls and it is up to the platform code to call
> iommu_take_ownership()/iommu_release_ownership() if needed.

I think this commit message is out of date - I don't see any callbacks
here.

> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>  arch/powerpc/include/asm/iommu.h    |  4 +--
>  arch/powerpc/kernel/iommu.c         | 50 ++++++++++++++++++++++++++++---=
------
>  drivers/vfio/vfio_iommu_spapr_tce.c |  4 +--
>  3 files changed, 42 insertions(+), 16 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/=
iommu.h
> index 667aa1a..b9e50d3 100644
> --- a/arch/powerpc/include/asm/iommu.h
> +++ b/arch/powerpc/include/asm/iommu.h
> @@ -225,8 +225,8 @@ extern unsigned long iommu_clear_tce(struct iommu_tab=
le *tbl,
>  		unsigned long entry);
> =20
>  extern void iommu_flush_tce(struct iommu_table *tbl);
> -extern int iommu_take_ownership(struct iommu_table *tbl);
> -extern void iommu_release_ownership(struct iommu_table *tbl);
> +extern int iommu_take_ownership(struct iommu_table_group *table_group);
> +extern void iommu_release_ownership(struct iommu_table_group *table_grou=
p);
> =20
>  extern enum dma_data_direction iommu_tce_direction(unsigned long tce);
>  extern unsigned long iommu_direction_to_tce_perm(enum dma_data_direction=
 dir);
> diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
> index fd49c8e..7d6089b 100644
> --- a/arch/powerpc/kernel/iommu.c
> +++ b/arch/powerpc/kernel/iommu.c
> @@ -1050,7 +1050,7 @@ int iommu_tce_build(struct iommu_table *tbl, unsign=
ed long entry,
>  }
>  EXPORT_SYMBOL_GPL(iommu_tce_build);
> =20
> -int iommu_take_ownership(struct iommu_table *tbl)
> +static int iommu_table_take_ownership(struct iommu_table *tbl)
>  {
>  	unsigned long sz =3D (tbl->it_size + 7) >> 3;
> =20
> @@ -1064,19 +1064,36 @@ int iommu_take_ownership(struct iommu_table *tbl)
> =20
>  	memset(tbl->it_map, 0xff, sz);
> =20
> -	/*
> -	 * Disable iommu bypass, otherwise the user can DMA to all of
> -	 * our physical memory via the bypass window instead of just
> -	 * the pages that has been explicitly mapped into the iommu
> -	 */
> -	if (tbl->set_bypass)
> -		tbl->set_bypass(tbl, false);

The code to disable bypass is removed, and doesn't seem to be replaced
with anything.  That doesn't look safe.

> +	return 0;
> +}
> +
> +static void iommu_table_release_ownership(struct iommu_table *tbl);
> +
> +int iommu_take_ownership(struct iommu_table_group *table_group)
> +{
> +	int i, j, rc =3D 0;
> +
> +	for (i =3D 0; i < IOMMU_TABLE_GROUP_MAX_TABLES; ++i) {
> +		struct iommu_table *tbl =3D &table_group->tables[i];
> +
> +		if (!tbl->it_map)
> +			continue;
> +
> +		rc =3D iommu_table_take_ownership(tbl);
> +		if (rc) {
> +			for (j =3D 0; j < i; ++j)
> +				iommu_table_release_ownership(
> +						&table_group->tables[j]);
> +
> +			return rc;
> +		}
> +	}
> =20
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(iommu_take_ownership);
> =20
> -void iommu_release_ownership(struct iommu_table *tbl)
> +static void iommu_table_release_ownership(struct iommu_table *tbl)
>  {
>  	unsigned long sz =3D (tbl->it_size + 7) >> 3;
> =20
> @@ -1086,9 +1103,18 @@ void iommu_release_ownership(struct iommu_table *t=
bl)
>  	if (tbl->it_offset =3D=3D 0)
>  		set_bit(0, tbl->it_map);
> =20
> -	/* The kernel owns the device now, we can restore the iommu bypass */
> -	if (tbl->set_bypass)
> -		tbl->set_bypass(tbl, true);
> +}
> +
> +extern void iommu_release_ownership(struct iommu_table_group *table_grou=
p)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < IOMMU_TABLE_GROUP_MAX_TABLES; ++i) {
> +		struct iommu_table *tbl =3D &table_group->tables[i];
> +
> +		if (tbl->it_map)
> +			iommu_table_release_ownership(tbl);
> +	}
>  }
>  EXPORT_SYMBOL_GPL(iommu_release_ownership);
> =20
> diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iomm=
u_spapr_tce.c
> index d61aad2..9f38351 100644
> --- a/drivers/vfio/vfio_iommu_spapr_tce.c
> +++ b/drivers/vfio/vfio_iommu_spapr_tce.c
> @@ -535,7 +535,7 @@ static int tce_iommu_attach_group(void *iommu_data,
>  		goto unlock_exit;
>  	}
> =20
> -	ret =3D iommu_take_ownership(&table_group->tables[0]);
> +	ret =3D iommu_take_ownership(table_group);
>  	if (!ret)
>  		container->grp =3D iommu_group;
> =20
> @@ -572,7 +572,7 @@ static void tce_iommu_detach_group(void *iommu_data,
>  	table_group =3D iommu_group_get_iommudata(iommu_group);
>  	BUG_ON(!table_group);
> =20
> -	iommu_release_ownership(&table_group->tables[0]);
> +	iommu_release_ownership(table_group);
> =20
>  unlock_exit:
>  	mutex_unlock(&container->lock);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--zS7rBR6csb6tI2e1
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVL1AEAAoJEGw4ysog2bOS4BYQAKC+gha/+4952kVMMRwCzbQr
W1KZ7w8t1HbW7kX7OPcHMFwdLj02wWUKQTyE4ZaVkdxyA92imcXzUeBoLcgx2lqr
FGK24P0yKKMaDuddB8NX5CV7rTbBXfOeEQ76NPvC5MaDAXiZwn1GoJ84muq/5XN9
6kn1xcYZs4kCbrvVxk19rDNGfbD2V7tb9zne83QWXrREp7BHfsIX6UUHpMo+P4fg
qcVkLqwmOU4vopDcxabHwqAe6T+ilGYSfgOzXSmabfIza0U4uVZDtXN0dFxKPNVu
6AbREQLE1FtcQeM6k3BxuUH9lBGkzlkmVYqPyf1BwOzoVJoc9x53ULZtA4Vm5nHL
57gsTe2dadwEchtHGN8tivjSfZx0bS6Maq0w5ejnQ4tONpgAIEL4xUOejxB7tOo/
as+Gbv0snZF7g43Y9hTdKzcRk98f+gD19jDs4riG8AR6sEA+odEqHF11Elds0mTa
Lee+xkvddOKo8ZAvClyowElZG4n80izF9p67fohCC4/roELeHVfZtnEO84Wt9Di/
v1xJc7LzAbUhXHM5ip8cwJyXhzhHPChZQrl69LAOXqzh006clkrfTtSSAgZT2FN6
zO1SzQwytfe0OwWU7q7sJmOE6133CI0vzqjYD66O3N+pcZkdkelKEtlMIa5HqcEc
1fYGdZKIWfbndvgNSkxW
=RUAS
-----END PGP SIGNATURE-----

--zS7rBR6csb6tI2e1--
