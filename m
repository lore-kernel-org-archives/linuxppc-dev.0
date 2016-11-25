Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tQ3J83VFHzDt3F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Nov 2016 15:39:20 +1100 (AEDT)
Date: Fri, 25 Nov 2016 15:33:57 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Paul Mackerras <paulus@samba.org>, kvm@vger.kernel.org
Subject: Re: [PATCH kernel v6 4/7] vfio/spapr: Add a helper to create default
 DMA window
Message-ID: <20161125043357.GD12287@umbus.fritz.box>
References: <1479966490-8739-1-git-send-email-aik@ozlabs.ru>
 <1479966490-8739-5-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="SO98HVl1bnMOfKZd"
In-Reply-To: <1479966490-8739-5-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--SO98HVl1bnMOfKZd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 24, 2016 at 04:48:07PM +1100, Alexey Kardashevskiy wrote:
> There is already a helper to create a DMA window which does allocate
> a table and programs it to the IOMMU group. However
> tce_iommu_take_ownership_ddw() did not use it and did these 2 calls
> itself to simplify error path.
>=20
> Since we are going to delay the default window creation till
> the default window is accessed/removed or new window is added,
> we need a helper to create a default window from all these cases.
>=20
> This adds tce_iommu_create_default_window(). Since it relies on
> a VFIO container to have at least one IOMMU group (for future use),
> this changes tce_iommu_attach_group() to add a group to the container
> first and then call the new helper.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
> Changes:
> v6:
> * new to the patchset
> ---
>  drivers/vfio/vfio_iommu_spapr_tce.c | 87 ++++++++++++++++++-------------=
------
>  1 file changed, 42 insertions(+), 45 deletions(-)
>=20
> diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iomm=
u_spapr_tce.c
> index 4efd2b2..a67bbfd 100644
> --- a/drivers/vfio/vfio_iommu_spapr_tce.c
> +++ b/drivers/vfio/vfio_iommu_spapr_tce.c
> @@ -710,6 +710,29 @@ static long tce_iommu_remove_window(struct tce_conta=
iner *container,
>  	return 0;
>  }
> =20
> +static long tce_iommu_create_default_window(struct tce_container *contai=
ner)
> +{
> +	long ret;
> +	__u64 start_addr =3D 0;
> +	struct tce_iommu_group *tcegrp;
> +	struct iommu_table_group *table_group;
> +
> +	if (!tce_groups_attached(container))
> +		return -ENODEV;
> +
> +	tcegrp =3D list_first_entry(&container->group_list,
> +			struct tce_iommu_group, next);
> +	table_group =3D iommu_group_get_iommudata(tcegrp->grp);
> +	if (!table_group)
> +		return -ENODEV;
> +
> +	ret =3D tce_iommu_create_window(container, IOMMU_PAGE_SHIFT_4K,
> +			table_group->tce32_size, 1, &start_addr);
> +	WARN_ON_ONCE(!ret && start_addr);
> +
> +	return ret;
> +}
> +
>  static long tce_iommu_ioctl(void *iommu_data,
>  				 unsigned int cmd, unsigned long arg)
>  {
> @@ -1100,9 +1123,6 @@ static void tce_iommu_release_ownership_ddw(struct =
tce_container *container,
>  static long tce_iommu_take_ownership_ddw(struct tce_container *container,
>  		struct iommu_table_group *table_group)
>  {
> -	long i, ret =3D 0;
> -	struct iommu_table *tbl =3D NULL;
> -
>  	if (!table_group->ops->create_table || !table_group->ops->set_window ||
>  			!table_group->ops->release_ownership) {
>  		WARN_ON_ONCE(1);
> @@ -1111,47 +1131,7 @@ static long tce_iommu_take_ownership_ddw(struct tc=
e_container *container,
> =20
>  	table_group->ops->take_ownership(table_group);
> =20
> -	/*
> -	 * If it the first group attached, check if there is
> -	 * a default DMA window and create one if none as
> -	 * the userspace expects it to exist.
> -	 */
> -	if (!tce_groups_attached(container) && !container->tables[0]) {
> -		ret =3D tce_iommu_create_table(container,
> -				table_group,
> -				0, /* window number */
> -				IOMMU_PAGE_SHIFT_4K,
> -				table_group->tce32_size,
> -				1, /* default levels */
> -				&tbl);
> -		if (ret)
> -			goto release_exit;
> -		else
> -			container->tables[0] =3D tbl;
> -	}
> -
> -	/* Set all windows to the new group */
> -	for (i =3D 0; i < IOMMU_TABLE_GROUP_MAX_TABLES; ++i) {
> -		tbl =3D container->tables[i];
> -
> -		if (!tbl)
> -			continue;
> -
> -		/* Set the default window to a new group */
> -		ret =3D table_group->ops->set_window(table_group, i, tbl);
> -		if (ret)
> -			goto release_exit;
> -	}
> -
>  	return 0;
> -
> -release_exit:
> -	for (i =3D 0; i < IOMMU_TABLE_GROUP_MAX_TABLES; ++i)
> -		table_group->ops->unset_window(table_group, i);
> -
> -	table_group->ops->release_ownership(table_group);
> -
> -	return ret;
>  }
> =20
>  static int tce_iommu_attach_group(void *iommu_data,
> @@ -1161,6 +1141,7 @@ static int tce_iommu_attach_group(void *iommu_data,
>  	struct tce_container *container =3D iommu_data;
>  	struct iommu_table_group *table_group;
>  	struct tce_iommu_group *tcegrp =3D NULL;
> +	bool create_default_window =3D false;
> =20
>  	mutex_lock(&container->lock);
> =20
> @@ -1203,14 +1184,30 @@ static int tce_iommu_attach_group(void *iommu_dat=
a,
>  	}
> =20
>  	if (!table_group->ops || !table_group->ops->take_ownership ||
> -			!table_group->ops->release_ownership)
> +			!table_group->ops->release_ownership) {
>  		ret =3D tce_iommu_take_ownership(container, table_group);
> -	else
> +	} else {
>  		ret =3D tce_iommu_take_ownership_ddw(container, table_group);
> +		if (!tce_groups_attached(container) && !container->tables[0])
> +			create_default_window =3D true;
> +	}
> =20
>  	if (!ret) {
>  		tcegrp->grp =3D iommu_group;
>  		list_add(&tcegrp->next, &container->group_list);
> +		/*
> +		 * If it the first group attached, check if there is
> +		 * a default DMA window and create one if none as
> +		 * the userspace expects it to exist.
> +		 */
> +		if (create_default_window) {
> +			ret =3D tce_iommu_create_default_window(container);
> +			if (ret) {
> +				list_del(&tcegrp->next);
> +				tce_iommu_release_ownership_ddw(container,
> +						table_group);
> +			}
> +		}
>  	}
> =20
>  unlock_exit:

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--SO98HVl1bnMOfKZd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYN78yAAoJEGw4ysog2bOSgNMP/1Q5KFDUZIH8DWRJHRexBvd5
aMwgC1z33aLYzXcInLc+iB1OoL68vPgP+1ZcmPgUzOvjHAVDNEql3O9IWgrmfKGy
zfLYEhfWizA1Ags1wivZXHIJt38UwID0SSJoTZVyp0y9f+vK6DktDLZes8LzyMCb
/pMUMKbBFg/C6zsui9VXHLyvQSGmiE3R+8ziADSVW+4ZGz9u4qKDLwJU4L8Qn4Sx
0XQpp4do0UtYxz4tmdYWAiE+KywAKqeMY/K+EdPJ/ggF6uGtqtKeJRMQktMRQC8K
ns+S2/3vL1yZow7jQrHmdB5BLrMOA/JVtRIFlKs7AjEwb/JmLMNK+vwVurSWdoE9
ORcIqBheOjq1EHSOAIrKsoyLeEYaqkE8nVhIV5dVnaN9HAzYnafkaSC/+A6aZOiX
WH12cvU9LZ9R3Yd/rYD1kuDC8aUrA+ndTYlPHM8ji27UQT/nMZOo7MwcLb/eiz/6
5FkL6j6axCFiFyNPAfIp8ijm+ysznzfRSxctI3fGsg8nm/wBepmFYCFFVrVlL2+Z
5hqD8Vppu4wcHE/yCaGW1UtBQ728Twd3U+X/+oMBa1Bj7o8L62fYYa5XegisrIHr
InGqeeLmoSHVGF6yJM2J0pP2wILZr/yuSguYr7JH2fv4q1CasqZy7ieby//37Xgz
2+iXdA5DiBB8K4eO31/e
=sbni
-----END PGP SIGNATURE-----

--SO98HVl1bnMOfKZd--
