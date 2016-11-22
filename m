Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tN9n22yHGzDvSR
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 14:24:22 +1100 (AEDT)
Date: Tue, 22 Nov 2016 13:50:52 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, kvm@vger.kernel.org
Subject: Re: [PATCH kernel v5 4/6] vfio/spapr: Postpone default window creation
Message-ID: <20161122025052.GB28479@umbus.fritz.box>
References: <1478867537-27893-1-git-send-email-aik@ozlabs.ru>
 <1478867537-27893-5-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="JYK4vJDZwFMowpUq"
In-Reply-To: <1478867537-27893-5-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--JYK4vJDZwFMowpUq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 11, 2016 at 11:32:15PM +1100, Alexey Kardashevskiy wrote:
> As mentioned in the previous patch, we are going to allow the userspace
> to configure container in one memory context and pass container fd to
> another so we are postponing memory allocations accounted against
> the locked memory limit. The previous patch took care of it_userspace.
>=20
> At the moment we create the default DMA window when the first group is
> attached to a container; this is done for the userspace which is not
> DDW-aware but familiar with the SPAPR TCE IOMMU v2 in the part of memory
> pre-registration - such client expects the default DMA window to exist.
>=20
> This postpones the default DMA window allocation till first map/unmap
> request happens.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>  drivers/vfio/vfio_iommu_spapr_tce.c | 98 ++++++++++++++++++-------------=
------
>  1 file changed, 47 insertions(+), 51 deletions(-)
>=20
> diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iomm=
u_spapr_tce.c
> index 442baac..1c02498 100644
> --- a/drivers/vfio/vfio_iommu_spapr_tce.c
> +++ b/drivers/vfio/vfio_iommu_spapr_tce.c
> @@ -97,6 +97,7 @@ struct tce_container {
>  	struct mutex lock;
>  	bool enabled;
>  	bool v2;
> +	bool def_window_pending;
>  	unsigned long locked_pages;
>  	struct iommu_table *tables[IOMMU_TABLE_GROUP_MAX_TABLES];
>  	struct list_head group_list;
> @@ -594,15 +595,6 @@ static long tce_iommu_create_table(struct tce_contai=
ner *container,
>  	WARN_ON(!ret && !(*ptbl)->it_ops->free);
>  	WARN_ON(!ret && ((*ptbl)->it_allocated_size !=3D table_size));
> =20
> -	if (!ret && container->v2) {
> -		ret =3D tce_iommu_userspace_view_alloc(*ptbl);
> -		if (ret)
> -			(*ptbl)->it_ops->free(*ptbl);
> -	}

Does this stuff for the user view belong in the previous patch?

> -
> -	if (ret)
> -		decrement_locked_vm(table_size >> PAGE_SHIFT);
> -
>  	return ret;
>  }
> =20
> @@ -719,6 +711,29 @@ static long tce_iommu_remove_window(struct tce_conta=
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
> @@ -809,6 +824,13 @@ static long tce_iommu_ioctl(void *iommu_data,
>  				VFIO_DMA_MAP_FLAG_WRITE))
>  			return -EINVAL;
> =20
> +		if (container->def_window_pending) {
> +			ret =3D tce_iommu_create_default_window(container);
> +			if (ret)
> +				return ret;
> +			container->def_window_pending =3D false;

Would it make sense to clear (and maybe test) def_window_pending
within create_default_window()?

> +		}
> +
>  		num =3D tce_iommu_find_table(container, param.iova, &tbl);
>  		if (num < 0)
>  			return -ENXIO;
> @@ -872,6 +894,13 @@ static long tce_iommu_ioctl(void *iommu_data,
>  		if (param.flags)
>  			return -EINVAL;
> =20
> +		if (container->def_window_pending) {
> +			ret =3D tce_iommu_create_default_window(container);
> +			if (ret)
> +				return ret;
> +			container->def_window_pending =3D false;
> +		}
> +
>  		num =3D tce_iommu_find_table(container, param.iova, &tbl);
>  		if (num < 0)
>  			return -ENXIO;
> @@ -998,6 +1027,8 @@ static long tce_iommu_ioctl(void *iommu_data,
> =20
>  		mutex_lock(&container->lock);
> =20
> +		container->def_window_pending =3D false;

Uh.. why is it cleared here, without calling
tce_iommu_create_default_window() AFAICT?

>  		ret =3D tce_iommu_create_window(container, create.page_shift,
>  				create.window_size, create.levels,
>  				&create.start_addr);
> @@ -1030,6 +1061,12 @@ static long tce_iommu_ioctl(void *iommu_data,
>  		if (remove.flags)
>  			return -EINVAL;
> =20
> +		if (container->def_window_pending && !remove.start_addr) {
> +			container->def_window_pending =3D false;
> +			return 0;
> +		}
> +		container->def_window_pending =3D false;
> +
>  		mutex_lock(&container->lock);
> =20
>  		ret =3D tce_iommu_remove_window(container, remove.start_addr);
> @@ -1109,9 +1146,6 @@ static void tce_iommu_release_ownership_ddw(struct =
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
> @@ -1120,47 +1154,9 @@ static long tce_iommu_take_ownership_ddw(struct tc=
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

Uh... nothing in the new code seems to replace these set_window (and
unset_window) calls.  What's up with that?

> -		if (ret)
> -			goto release_exit;
> -	}
> +	container->def_window_pending =3D true;
> =20
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

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--JYK4vJDZwFMowpUq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYM7KKAAoJEGw4ysog2bOS3sgQAMR+tjnBSMY6oRX+x9lmVAuE
JaVJaRvqN0n96KjxsscZaYcvBwLxDI8wYgHGl/CrJ+9qXz6Oanlh/JdKiW7oGji6
nNMp0lzKnxtBYJv6oQdK1tUlbcSgf6ZJ79ogQajc2auVgMALz/P4Jzwpe/0/ouze
G+db3xmxs3HqPLBzSDP/MnhuvwJR9XLWe7mfPG8FMZlnGeL7l8UYwJJTNxvC9dWI
nCWTbuXWLoTHLb4V2YwPdaHyhXqSDtWaMuuV3fDBf3yrZy15MyF3PLWSe10FTo2c
ubNUjMi5Y5TIjcPlfMqsOPHf+CXluSaYjp+yt/7duy2lPMOSbxaWYPEPbdOodJUY
0fL+6wTuy03KbyPmQs2pefW9UwnVi44IPrwDkENBDDEPS4BHzqyed1XMDhIDZTTf
7BoKZLMTpNf01FWu9RNx0r3eX2uVZP1DB7I5RyHDITZnrOj059onABnRLQK19497
t4Z1lqVKV2/nVDAWHujgiqj5+uCzcpj2OgXfK0yy1aHl2Pm7piRTWMuC7CJyEFDQ
90HgC1bHWyLdwbdgird/7vNp/QU5Ec2Cl0xFgpAVem+6o3LXzsveiPepe/bI3gag
/5t+VPu+yOpwmiIVRzAUpGyekjfqlMfnQ5+PW1xsdIK4LKkhGXTP2ooRdqj3fRkh
pCPAa0GqwjkWjYBR7mD8
=KSoi
-----END PGP SIGNATURE-----

--JYK4vJDZwFMowpUq--
