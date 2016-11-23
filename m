Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tNlw42djCzDvnB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2016 13:02:28 +1100 (AEDT)
Date: Wed, 23 Nov 2016 12:35:46 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, kvm@vger.kernel.org
Subject: Re: [PATCH kernel v5 4/6] vfio/spapr: Postpone default window creation
Message-ID: <20161123013546.GH28479@umbus.fritz.box>
References: <1478867537-27893-1-git-send-email-aik@ozlabs.ru>
 <1478867537-27893-5-git-send-email-aik@ozlabs.ru>
 <20161122025052.GB28479@umbus.fritz.box>
 <b1aa544a-d4a1-fb2c-8069-63c52f3dbf8d@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="VkqCAaSJIySsbD6j"
In-Reply-To: <b1aa544a-d4a1-fb2c-8069-63c52f3dbf8d@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--VkqCAaSJIySsbD6j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 22, 2016 at 06:29:39PM +1100, Alexey Kardashevskiy wrote:
> On 22/11/16 13:50, David Gibson wrote:
> > On Fri, Nov 11, 2016 at 11:32:15PM +1100, Alexey Kardashevskiy wrote:
> >> As mentioned in the previous patch, we are going to allow the userspace
> >> to configure container in one memory context and pass container fd to
> >> another so we are postponing memory allocations accounted against
> >> the locked memory limit. The previous patch took care of it_userspace.
> >>
> >> At the moment we create the default DMA window when the first group is
> >> attached to a container; this is done for the userspace which is not
> >> DDW-aware but familiar with the SPAPR TCE IOMMU v2 in the part of memo=
ry
> >> pre-registration - such client expects the default DMA window to exist.
> >>
> >> This postpones the default DMA window allocation till first map/unmap
> >> request happens.
> >>
> >> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> >> ---
> >>  drivers/vfio/vfio_iommu_spapr_tce.c | 98 ++++++++++++++++++----------=
---------
> >>  1 file changed, 47 insertions(+), 51 deletions(-)
> >>
> >> diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_i=
ommu_spapr_tce.c
> >> index 442baac..1c02498 100644
> >> --- a/drivers/vfio/vfio_iommu_spapr_tce.c
> >> +++ b/drivers/vfio/vfio_iommu_spapr_tce.c
> >> @@ -97,6 +97,7 @@ struct tce_container {
> >>  	struct mutex lock;
> >>  	bool enabled;
> >>  	bool v2;
> >> +	bool def_window_pending;
> >>  	unsigned long locked_pages;
> >>  	struct iommu_table *tables[IOMMU_TABLE_GROUP_MAX_TABLES];
> >>  	struct list_head group_list;
> >> @@ -594,15 +595,6 @@ static long tce_iommu_create_table(struct tce_con=
tainer *container,
> >>  	WARN_ON(!ret && !(*ptbl)->it_ops->free);
> >>  	WARN_ON(!ret && ((*ptbl)->it_allocated_size !=3D table_size));
> >> =20
> >> -	if (!ret && container->v2) {
> >> -		ret =3D tce_iommu_userspace_view_alloc(*ptbl);
> >> -		if (ret)
> >> -			(*ptbl)->it_ops->free(*ptbl);
> >> -	}
> >=20
> > Does this stuff for the user view belong in the previous patch?
>=20
> Yes it does, my mistake, will fix.
>=20
>=20
> >=20
> >> -
> >> -	if (ret)
> >> -		decrement_locked_vm(table_size >> PAGE_SHIFT);
> >> -
> >>  	return ret;
> >>  }
> >> =20
> >> @@ -719,6 +711,29 @@ static long tce_iommu_remove_window(struct tce_co=
ntainer *container,
> >>  	return 0;
> >>  }
> >> =20
> >> +static long tce_iommu_create_default_window(struct tce_container *con=
tainer)
> >> +{
> >> +	long ret;
> >> +	__u64 start_addr =3D 0;
> >> +	struct tce_iommu_group *tcegrp;
> >> +	struct iommu_table_group *table_group;
> >> +
> >> +	if (!tce_groups_attached(container))
> >> +		return -ENODEV;
> >> +
> >> +	tcegrp =3D list_first_entry(&container->group_list,
> >> +			struct tce_iommu_group, next);
> >> +	table_group =3D iommu_group_get_iommudata(tcegrp->grp);
> >> +	if (!table_group)
> >> +		return -ENODEV;
> >> +
> >> +	ret =3D tce_iommu_create_window(container, IOMMU_PAGE_SHIFT_4K,
> >> +			table_group->tce32_size, 1, &start_addr);
> >> +	WARN_ON_ONCE(!ret && start_addr);
> >> +
> >> +	return ret;
> >> +}
> >> +
> >>  static long tce_iommu_ioctl(void *iommu_data,
> >>  				 unsigned int cmd, unsigned long arg)
> >>  {
> >> @@ -809,6 +824,13 @@ static long tce_iommu_ioctl(void *iommu_data,
> >>  				VFIO_DMA_MAP_FLAG_WRITE))
> >>  			return -EINVAL;
> >> =20
> >> +		if (container->def_window_pending) {
> >> +			ret =3D tce_iommu_create_default_window(container);
> >> +			if (ret)
> >> +				return ret;
> >> +			container->def_window_pending =3D false;
> >=20
> > Would it make sense to clear (and maybe test) def_window_pending
> > within create_default_window()?
>=20
> Dunno, matter of taste I suppose. I'll move it there.
>=20
>=20
> >=20
> >> +		}
> >> +
> >>  		num =3D tce_iommu_find_table(container, param.iova, &tbl);
> >>  		if (num < 0)
> >>  			return -ENXIO;
> >> @@ -872,6 +894,13 @@ static long tce_iommu_ioctl(void *iommu_data,
> >>  		if (param.flags)
> >>  			return -EINVAL;
> >> =20
> >> +		if (container->def_window_pending) {
> >> +			ret =3D tce_iommu_create_default_window(container);
> >> +			if (ret)
> >> +				return ret;
> >> +			container->def_window_pending =3D false;
> >> +		}
> >> +
> >>  		num =3D tce_iommu_find_table(container, param.iova, &tbl);
> >>  		if (num < 0)
> >>  			return -ENXIO;
> >> @@ -998,6 +1027,8 @@ static long tce_iommu_ioctl(void *iommu_data,
> >> =20
> >>  		mutex_lock(&container->lock);
> >> =20
> >> +		container->def_window_pending =3D false;
> >=20
> > Uh.. why is it cleared here, without calling
> > tce_iommu_create_default_window() AFAICT?
>=20
>=20
> It is a branch which creates new window, if we do not have a default
> window, then it will be created as the result of this ioctl(), if there is
> a default window, then the flag should be false already.

Um.. it will create *a* window, but not necessarily the default one.
Consider this scenario:

1. Container is opened
2. A group is attached
3. Userspace, expecting the default window to be in place, creates a
   second window
4. Mapping starts

Won't the above code mean that we create what userspace expected to be
the second window as the first window replacing the default one
instead?

>=20
>=20
>=20
>=20
> >=20
> >>  		ret =3D tce_iommu_create_window(container, create.page_shift,
> >>  				create.window_size, create.levels,
> >>  				&create.start_addr);
> >> @@ -1030,6 +1061,12 @@ static long tce_iommu_ioctl(void *iommu_data,
> >>  		if (remove.flags)
> >>  			return -EINVAL;
> >> =20
> >> +		if (container->def_window_pending && !remove.start_addr) {
> >> +			container->def_window_pending =3D false;
> >> +			return 0;
> >> +		}
> >> +		container->def_window_pending =3D false;
> >> +
> >>  		mutex_lock(&container->lock);
> >> =20
> >>  		ret =3D tce_iommu_remove_window(container, remove.start_addr);
> >> @@ -1109,9 +1146,6 @@ static void tce_iommu_release_ownership_ddw(stru=
ct tce_container *container,
> >>  static long tce_iommu_take_ownership_ddw(struct tce_container *contai=
ner,
> >>  		struct iommu_table_group *table_group)
> >>  {
> >> -	long i, ret =3D 0;
> >> -	struct iommu_table *tbl =3D NULL;
> >> -
> >>  	if (!table_group->ops->create_table || !table_group->ops->set_window=
 ||
> >>  			!table_group->ops->release_ownership) {
> >>  		WARN_ON_ONCE(1);
> >> @@ -1120,47 +1154,9 @@ static long tce_iommu_take_ownership_ddw(struct=
 tce_container *container,
> >> =20
> >>  	table_group->ops->take_ownership(table_group);
> >> =20
> >> -	/*
> >> -	 * If it the first group attached, check if there is
> >> -	 * a default DMA window and create one if none as
> >> -	 * the userspace expects it to exist.
> >> -	 */
> >> -	if (!tce_groups_attached(container) && !container->tables[0]) {
> >> -		ret =3D tce_iommu_create_table(container,
> >> -				table_group,
> >> -				0, /* window number */
> >> -				IOMMU_PAGE_SHIFT_4K,
> >> -				table_group->tce32_size,
> >> -				1, /* default levels */
> >> -				&tbl);
> >> -		if (ret)
> >> -			goto release_exit;
> >> -		else
> >> -			container->tables[0] =3D tbl;
> >> -	}
> >> -
> >> -	/* Set all windows to the new group */
> >> -	for (i =3D 0; i < IOMMU_TABLE_GROUP_MAX_TABLES; ++i) {
> >> -		tbl =3D container->tables[i];
> >> -
> >> -		if (!tbl)
> >> -			continue;
> >> -
> >> -		/* Set the default window to a new group */
> >> -		ret =3D table_group->ops->set_window(table_group, i, tbl);
> >=20
> > Uh... nothing in the new code seems to replace these set_window (and
> > unset_window) calls.  What's up with that?
>=20
>=20
> tce_iommu_create_table() + set_window() is replaced with
> tce_iommu_create_default_window() which calls tce_iommu_create_window()
> which calls tce_iommu_create_table() + set_window().
>=20
> I'll split this patch into 2 patches, one with the change I just explained
> and one to postpone the default window creation.

Ah, right, I see.


>=20
>=20
> >=20
> >> -		if (ret)
> >> -			goto release_exit;
> >> -	}
> >> +	container->def_window_pending =3D true;
> >> =20
> >>  	return 0;
> >> -
> >> -release_exit:
> >> -	for (i =3D 0; i < IOMMU_TABLE_GROUP_MAX_TABLES; ++i)
> >> -		table_group->ops->unset_window(table_group, i);
> >> -
> >> -	table_group->ops->release_ownership(table_group);
> >> -
> >> -	return ret;
> >>  }
> >> =20
> >>  static int tce_iommu_attach_group(void *iommu_data,
> >=20
>=20
>=20




--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--VkqCAaSJIySsbD6j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYNPJvAAoJEGw4ysog2bOSXm4QAJ9tCR9WIOWF0xW1bZnD7+py
jsp0PorJwWKtIuEFrWE4qQ0AmM5SyDOK68/sHLIY61melIz9oSg3CtxLrxWR5s7p
Y6JvI+P+p9JFX6Ja5kIyhtK6crJrlMESNfv9y4daAoEtomCH2bDWKGMiuF3Pp+Tx
pAqOW0ECVwQmSne/EkwVLq0OYeyJIb4a92sDr28MTldObBpVmAHXpbU1RAlT46zf
gTxAAVzGwzyQpdPAr12P8ywttKSQGD2oXDUPDkZQ43gCzqgimWSW1Ia/zvCT9uKx
6vRaYFpUwpH/eX42Ykh2xi8U9Lrl/LZAqx/HzD6M9CpxYkbyJPubxbgIfgRZEhpI
r+n/gKppFUMckXQycHa4gp0qTgiyZzbJySMfnp9/rOuhNp6TY7Smmk/fJQ5aVSy3
DJLsksNuOZWsfYA9CzvPH2pRVFJc+yOkoe9LkBl/xX3nw8HEsZY7qSRMHHSoL9YX
KKCFnlVi82qDMOOG1WDm9yZG7EEII5QC0y4R4iOnWPxXSuYzx6G4SBiDBEvW3XiG
9NweRWCgU/fkMLHSErgS8QQ2xMaja6HZL7VM2qRqJ4+jc8ALKgKmw4hJvAVF3aLq
vRyOxDVTt10tqXEXyHrmZJVsufVwjTu0+vSsfz6LvhMBAWGoRwoBaG2c0Db1Ov/7
slJhGviBPjxreQr/4YzG
=NOpX
-----END PGP SIGNATURE-----

--VkqCAaSJIySsbD6j--
