Return-Path: <aik@ozlabs.ru>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tNr0Z3bvSzDw1F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2016 16:06:38 +1100 (AEDT)
Received: by mail-pg0-x244.google.com with SMTP id e9so242936pgc.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 21:06:38 -0800 (PST)
Subject: Re: [PATCH kernel v5 4/6] vfio/spapr: Postpone default window creation
To: David Gibson <david@gibson.dropbear.id.au>
References: <1478867537-27893-1-git-send-email-aik@ozlabs.ru>
 <1478867537-27893-5-git-send-email-aik@ozlabs.ru>
 <20161122025052.GB28479@umbus.fritz.box>
 <b1aa544a-d4a1-fb2c-8069-63c52f3dbf8d@ozlabs.ru>
 <20161123013546.GH28479@umbus.fritz.box>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, kvm@vger.kernel.org
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <8475a1f4-fa4f-ec6b-8e41-743219cbe59e@ozlabs.ru>
Date: Wed, 23 Nov 2016 16:06:30 +1100
MIME-Version: 1.0
In-Reply-To: <20161123013546.GH28479@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="09qUj1Ia8LAATbVvAicN5D3h5P5eoBiNb"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--09qUj1Ia8LAATbVvAicN5D3h5P5eoBiNb
Content-Type: multipart/mixed; boundary="stRBUc9IbPTvwlTrxXc2lUC0bgsrWiPKQ";
 protected-headers="v1"
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, kvm@vger.kernel.org
Message-ID: <8475a1f4-fa4f-ec6b-8e41-743219cbe59e@ozlabs.ru>
Subject: Re: [PATCH kernel v5 4/6] vfio/spapr: Postpone default window
 creation
References: <1478867537-27893-1-git-send-email-aik@ozlabs.ru>
 <1478867537-27893-5-git-send-email-aik@ozlabs.ru>
 <20161122025052.GB28479@umbus.fritz.box>
 <b1aa544a-d4a1-fb2c-8069-63c52f3dbf8d@ozlabs.ru>
 <20161123013546.GH28479@umbus.fritz.box>
In-Reply-To: <20161123013546.GH28479@umbus.fritz.box>

--stRBUc9IbPTvwlTrxXc2lUC0bgsrWiPKQ
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: quoted-printable

On 23/11/16 12:35, David Gibson wrote:
> On Tue, Nov 22, 2016 at 06:29:39PM +1100, Alexey Kardashevskiy wrote:
>> On 22/11/16 13:50, David Gibson wrote:
>>> On Fri, Nov 11, 2016 at 11:32:15PM +1100, Alexey Kardashevskiy wrote:=

>>>> As mentioned in the previous patch, we are going to allow the usersp=
ace
>>>> to configure container in one memory context and pass container fd t=
o
>>>> another so we are postponing memory allocations accounted against
>>>> the locked memory limit. The previous patch took care of it_userspac=
e.
>>>>
>>>> At the moment we create the default DMA window when the first group =
is
>>>> attached to a container; this is done for the userspace which is not=

>>>> DDW-aware but familiar with the SPAPR TCE IOMMU v2 in the part of me=
mory
>>>> pre-registration - such client expects the default DMA window to exi=
st.
>>>>
>>>> This postpones the default DMA window allocation till first map/unma=
p
>>>> request happens.
>>>>
>>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>>>> ---
>>>>  drivers/vfio/vfio_iommu_spapr_tce.c | 98 ++++++++++++++++++--------=
-----------
>>>>  1 file changed, 47 insertions(+), 51 deletions(-)
>>>>
>>>> diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio=
_iommu_spapr_tce.c
>>>> index 442baac..1c02498 100644
>>>> --- a/drivers/vfio/vfio_iommu_spapr_tce.c
>>>> +++ b/drivers/vfio/vfio_iommu_spapr_tce.c
>>>> @@ -97,6 +97,7 @@ struct tce_container {
>>>>  	struct mutex lock;
>>>>  	bool enabled;
>>>>  	bool v2;
>>>> +	bool def_window_pending;
>>>>  	unsigned long locked_pages;
>>>>  	struct iommu_table *tables[IOMMU_TABLE_GROUP_MAX_TABLES];
>>>>  	struct list_head group_list;
>>>> @@ -594,15 +595,6 @@ static long tce_iommu_create_table(struct tce_c=
ontainer *container,
>>>>  	WARN_ON(!ret && !(*ptbl)->it_ops->free);
>>>>  	WARN_ON(!ret && ((*ptbl)->it_allocated_size !=3D table_size));
>>>> =20
>>>> -	if (!ret && container->v2) {
>>>> -		ret =3D tce_iommu_userspace_view_alloc(*ptbl);
>>>> -		if (ret)
>>>> -			(*ptbl)->it_ops->free(*ptbl);
>>>> -	}
>>>
>>> Does this stuff for the user view belong in the previous patch?
>>
>> Yes it does, my mistake, will fix.
>>
>>
>>>
>>>> -
>>>> -	if (ret)
>>>> -		decrement_locked_vm(table_size >> PAGE_SHIFT);
>>>> -
>>>>  	return ret;
>>>>  }
>>>> =20
>>>> @@ -719,6 +711,29 @@ static long tce_iommu_remove_window(struct tce_=
container *container,
>>>>  	return 0;
>>>>  }
>>>> =20
>>>> +static long tce_iommu_create_default_window(struct tce_container *c=
ontainer)
>>>> +{
>>>> +	long ret;
>>>> +	__u64 start_addr =3D 0;
>>>> +	struct tce_iommu_group *tcegrp;
>>>> +	struct iommu_table_group *table_group;
>>>> +
>>>> +	if (!tce_groups_attached(container))
>>>> +		return -ENODEV;
>>>> +
>>>> +	tcegrp =3D list_first_entry(&container->group_list,
>>>> +			struct tce_iommu_group, next);
>>>> +	table_group =3D iommu_group_get_iommudata(tcegrp->grp);
>>>> +	if (!table_group)
>>>> +		return -ENODEV;
>>>> +
>>>> +	ret =3D tce_iommu_create_window(container, IOMMU_PAGE_SHIFT_4K,
>>>> +			table_group->tce32_size, 1, &start_addr);
>>>> +	WARN_ON_ONCE(!ret && start_addr);
>>>> +
>>>> +	return ret;
>>>> +}
>>>> +
>>>>  static long tce_iommu_ioctl(void *iommu_data,
>>>>  				 unsigned int cmd, unsigned long arg)
>>>>  {
>>>> @@ -809,6 +824,13 @@ static long tce_iommu_ioctl(void *iommu_data,
>>>>  				VFIO_DMA_MAP_FLAG_WRITE))
>>>>  			return -EINVAL;
>>>> =20
>>>> +		if (container->def_window_pending) {
>>>> +			ret =3D tce_iommu_create_default_window(container);
>>>> +			if (ret)
>>>> +				return ret;
>>>> +			container->def_window_pending =3D false;
>>>
>>> Would it make sense to clear (and maybe test) def_window_pending
>>> within create_default_window()?
>>
>> Dunno, matter of taste I suppose. I'll move it there.
>>
>>
>>>
>>>> +		}
>>>> +
>>>>  		num =3D tce_iommu_find_table(container, param.iova, &tbl);
>>>>  		if (num < 0)
>>>>  			return -ENXIO;
>>>> @@ -872,6 +894,13 @@ static long tce_iommu_ioctl(void *iommu_data,
>>>>  		if (param.flags)
>>>>  			return -EINVAL;
>>>> =20
>>>> +		if (container->def_window_pending) {
>>>> +			ret =3D tce_iommu_create_default_window(container);
>>>> +			if (ret)
>>>> +				return ret;
>>>> +			container->def_window_pending =3D false;
>>>> +		}
>>>> +
>>>>  		num =3D tce_iommu_find_table(container, param.iova, &tbl);
>>>>  		if (num < 0)
>>>>  			return -ENXIO;
>>>> @@ -998,6 +1027,8 @@ static long tce_iommu_ioctl(void *iommu_data,
>>>> =20
>>>>  		mutex_lock(&container->lock);
>>>> =20
>>>> +		container->def_window_pending =3D false;
>>>
>>> Uh.. why is it cleared here, without calling
>>> tce_iommu_create_default_window() AFAICT?
>>
>>
>> It is a branch which creates new window, if we do not have a default
>> window, then it will be created as the result of this ioctl(), if ther=
e is
>> a default window, then the flag should be false already.
>=20
> Um.. it will create *a* window, but not necessarily the default one.
> Consider this scenario:
>=20
> 1. Container is opened
> 2. A group is attached
> 3. Userspace, expecting the default window to be in place, creates a
>    second window
> 4. Mapping starts
>=20
> Won't the above code mean that we create what userspace expected to be
> the second window as the first window replacing the default one
> instead?

Uff. Yes, this is correct.

This is a bug in my initial design - I should not have created a "default=
"
window in the first place - it does not make sense at this level; and the=

userspace (i.e. QEMU) removes all windows on reset anyway.

The only way QEMU will use this default window is when it is at 318f67ce1=

"vfio: spapr: Add DMA memory preregistering (SPAPR IOMMU v2)" - memory
preregistration is there, but ddw is not yet but it is 2 patches later
where vfio_connect_container() unconditionally removes the default window=
=2E
Which is unlikely scenario.

Taking into account small number of DDW users (basically - QEMU v2.7.0),
does it still make sense to keep this default window code? The only
immediate problem I see here is QEMU will receive error from
vfio_spapr_remove_window() in vfio_connect_container() as there will be n=
o
default window but I could workaround this.



>=20
>>
>>
>>
>>
>>>
>>>>  		ret =3D tce_iommu_create_window(container, create.page_shift,
>>>>  				create.window_size, create.levels,
>>>>  				&create.start_addr);
>>>> @@ -1030,6 +1061,12 @@ static long tce_iommu_ioctl(void *iommu_data,=

>>>>  		if (remove.flags)
>>>>  			return -EINVAL;
>>>> =20
>>>> +		if (container->def_window_pending && !remove.start_addr) {
>>>> +			container->def_window_pending =3D false;
>>>> +			return 0;
>>>> +		}
>>>> +		container->def_window_pending =3D false;
>>>> +
>>>>  		mutex_lock(&container->lock);
>>>> =20
>>>>  		ret =3D tce_iommu_remove_window(container, remove.start_addr);
>>>> @@ -1109,9 +1146,6 @@ static void tce_iommu_release_ownership_ddw(st=
ruct tce_container *container,
>>>>  static long tce_iommu_take_ownership_ddw(struct tce_container *cont=
ainer,
>>>>  		struct iommu_table_group *table_group)
>>>>  {
>>>> -	long i, ret =3D 0;
>>>> -	struct iommu_table *tbl =3D NULL;
>>>> -
>>>>  	if (!table_group->ops->create_table || !table_group->ops->set_wind=
ow ||
>>>>  			!table_group->ops->release_ownership) {
>>>>  		WARN_ON_ONCE(1);
>>>> @@ -1120,47 +1154,9 @@ static long tce_iommu_take_ownership_ddw(stru=
ct tce_container *container,
>>>> =20
>>>>  	table_group->ops->take_ownership(table_group);
>>>> =20
>>>> -	/*
>>>> -	 * If it the first group attached, check if there is
>>>> -	 * a default DMA window and create one if none as
>>>> -	 * the userspace expects it to exist.
>>>> -	 */
>>>> -	if (!tce_groups_attached(container) && !container->tables[0]) {
>>>> -		ret =3D tce_iommu_create_table(container,
>>>> -				table_group,
>>>> -				0, /* window number */
>>>> -				IOMMU_PAGE_SHIFT_4K,
>>>> -				table_group->tce32_size,
>>>> -				1, /* default levels */
>>>> -				&tbl);
>>>> -		if (ret)
>>>> -			goto release_exit;
>>>> -		else
>>>> -			container->tables[0] =3D tbl;
>>>> -	}
>>>> -
>>>> -	/* Set all windows to the new group */
>>>> -	for (i =3D 0; i < IOMMU_TABLE_GROUP_MAX_TABLES; ++i) {
>>>> -		tbl =3D container->tables[i];
>>>> -
>>>> -		if (!tbl)
>>>> -			continue;
>>>> -
>>>> -		/* Set the default window to a new group */
>>>> -		ret =3D table_group->ops->set_window(table_group, i, tbl);
>>>
>>> Uh... nothing in the new code seems to replace these set_window (and
>>> unset_window) calls.  What's up with that?
>>
>>
>> tce_iommu_create_table() + set_window() is replaced with
>> tce_iommu_create_default_window() which calls tce_iommu_create_window(=
)
>> which calls tce_iommu_create_table() + set_window().
>>
>> I'll split this patch into 2 patches, one with the change I just expla=
ined
>> and one to postpone the default window creation.
>=20
> Ah, right, I see.
>=20
>=20
>>
>>
>>>
>>>> -		if (ret)
>>>> -			goto release_exit;
>>>> -	}
>>>> +	container->def_window_pending =3D true;
>>>> =20
>>>>  	return 0;
>>>> -
>>>> -release_exit:
>>>> -	for (i =3D 0; i < IOMMU_TABLE_GROUP_MAX_TABLES; ++i)
>>>> -		table_group->ops->unset_window(table_group, i);
>>>> -
>>>> -	table_group->ops->release_ownership(table_group);
>>>> -
>>>> -	return ret;
>>>>  }
>>>> =20
>>>>  static int tce_iommu_attach_group(void *iommu_data,
>>>
>>
>>
>=20
>=20
>=20
>=20


--=20
Alexey


--stRBUc9IbPTvwlTrxXc2lUC0bgsrWiPKQ--

--09qUj1Ia8LAATbVvAicN5D3h5P5eoBiNb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIrBAEBCAAVBQJYNSPWDhxhaWtAb3psYWJzLnJ1AAoJEIYTPdgrwSC5YygP/1zR
F7/QxdN4lHBglOzXmu1hcD/RiNnnyAxwUzQOM25tQPibvjxhXRgU3JcsSubLWjYJ
pkSquncKdKIlwCOgsVXF4bkKbaEONFh5Ms8UPdJDqKVKYQMDGUtrhQLJWFEFtIyR
TFNYdmP4D94n8yn8hvZmaopA5d5t04ptPxkxnFMvSPF2H58Vzrs4qUFeGGDLJUSS
u/DBeUKzbnOGaL3Plnb295GtqWulfRA90hI9Ao2ZtBCSEai+aOoirOdMT9oksvp1
pVgCxjPF6yFVxlU7mFccgnvg4f1JoKOUyGcvc96E2zm4g22JN854q9p7DyuX8HlI
meAC265OSBZX/PsWncdtO+KIxO37EHt+S71DDFhwp7RcRsYADo8179laNggwMBPm
vPgwpJoAxTQBwlTrvZ6+iTZYrHvmwnzA6fgkwEVjdKr7oJ4RdE5f75Ub7VX3QRW1
piMPFnQp/QOlEcqQVtWBElkBn9zFk1CA6EGUyV5H9NTzzaCJbnEdIjvMu4sAzUGo
JoDpQuKsepGfe85l0qfKkU+7HiV2qCw/eHgeFBATUcD8v03/GkpiltjvUeRNrXqZ
wWRJJNP+UFixCxv6YQei7vADkPjAv8KqkJRERTvfuVk0GsynHBQmV94m2fdrDMZN
jN2JiTP/LEKrbcmofqTwao7g3AiPd8lhojg//hMZ
=plPa
-----END PGP SIGNATURE-----

--09qUj1Ia8LAATbVvAicN5D3h5P5eoBiNb--
