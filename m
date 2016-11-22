Return-Path: <aik@ozlabs.ru>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tNHDB59NkzDw0N
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 18:29:46 +1100 (AEDT)
Received: by mail-pg0-x244.google.com with SMTP id e9so1303788pgc.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Nov 2016 23:29:46 -0800 (PST)
Subject: Re: [PATCH kernel v5 4/6] vfio/spapr: Postpone default window creation
To: David Gibson <david@gibson.dropbear.id.au>
References: <1478867537-27893-1-git-send-email-aik@ozlabs.ru>
 <1478867537-27893-5-git-send-email-aik@ozlabs.ru>
 <20161122025052.GB28479@umbus.fritz.box>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, kvm@vger.kernel.org
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <b1aa544a-d4a1-fb2c-8069-63c52f3dbf8d@ozlabs.ru>
Date: Tue, 22 Nov 2016 18:29:39 +1100
MIME-Version: 1.0
In-Reply-To: <20161122025052.GB28479@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="bhaOtJWvdKbNFMhMCuxC00GOmpmxdEI20"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bhaOtJWvdKbNFMhMCuxC00GOmpmxdEI20
Content-Type: multipart/mixed; boundary="bsFoAdND5jbq9Nva71M6gK1DSFVHNxCi9";
 protected-headers="v1"
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, kvm@vger.kernel.org
Message-ID: <b1aa544a-d4a1-fb2c-8069-63c52f3dbf8d@ozlabs.ru>
Subject: Re: [PATCH kernel v5 4/6] vfio/spapr: Postpone default window
 creation
References: <1478867537-27893-1-git-send-email-aik@ozlabs.ru>
 <1478867537-27893-5-git-send-email-aik@ozlabs.ru>
 <20161122025052.GB28479@umbus.fritz.box>
In-Reply-To: <20161122025052.GB28479@umbus.fritz.box>

--bsFoAdND5jbq9Nva71M6gK1DSFVHNxCi9
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: quoted-printable

On 22/11/16 13:50, David Gibson wrote:
> On Fri, Nov 11, 2016 at 11:32:15PM +1100, Alexey Kardashevskiy wrote:
>> As mentioned in the previous patch, we are going to allow the userspac=
e
>> to configure container in one memory context and pass container fd to
>> another so we are postponing memory allocations accounted against
>> the locked memory limit. The previous patch took care of it_userspace.=

>>
>> At the moment we create the default DMA window when the first group is=

>> attached to a container; this is done for the userspace which is not
>> DDW-aware but familiar with the SPAPR TCE IOMMU v2 in the part of memo=
ry
>> pre-registration - such client expects the default DMA window to exist=
=2E
>>
>> This postpones the default DMA window allocation till first map/unmap
>> request happens.
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> ---
>>  drivers/vfio/vfio_iommu_spapr_tce.c | 98 ++++++++++++++++++----------=
---------
>>  1 file changed, 47 insertions(+), 51 deletions(-)
>>
>> diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_i=
ommu_spapr_tce.c
>> index 442baac..1c02498 100644
>> --- a/drivers/vfio/vfio_iommu_spapr_tce.c
>> +++ b/drivers/vfio/vfio_iommu_spapr_tce.c
>> @@ -97,6 +97,7 @@ struct tce_container {
>>  	struct mutex lock;
>>  	bool enabled;
>>  	bool v2;
>> +	bool def_window_pending;
>>  	unsigned long locked_pages;
>>  	struct iommu_table *tables[IOMMU_TABLE_GROUP_MAX_TABLES];
>>  	struct list_head group_list;
>> @@ -594,15 +595,6 @@ static long tce_iommu_create_table(struct tce_con=
tainer *container,
>>  	WARN_ON(!ret && !(*ptbl)->it_ops->free);
>>  	WARN_ON(!ret && ((*ptbl)->it_allocated_size !=3D table_size));
>> =20
>> -	if (!ret && container->v2) {
>> -		ret =3D tce_iommu_userspace_view_alloc(*ptbl);
>> -		if (ret)
>> -			(*ptbl)->it_ops->free(*ptbl);
>> -	}
>=20
> Does this stuff for the user view belong in the previous patch?

Yes it does, my mistake, will fix.


>=20
>> -
>> -	if (ret)
>> -		decrement_locked_vm(table_size >> PAGE_SHIFT);
>> -
>>  	return ret;
>>  }
>> =20
>> @@ -719,6 +711,29 @@ static long tce_iommu_remove_window(struct tce_co=
ntainer *container,
>>  	return 0;
>>  }
>> =20
>> +static long tce_iommu_create_default_window(struct tce_container *con=
tainer)
>> +{
>> +	long ret;
>> +	__u64 start_addr =3D 0;
>> +	struct tce_iommu_group *tcegrp;
>> +	struct iommu_table_group *table_group;
>> +
>> +	if (!tce_groups_attached(container))
>> +		return -ENODEV;
>> +
>> +	tcegrp =3D list_first_entry(&container->group_list,
>> +			struct tce_iommu_group, next);
>> +	table_group =3D iommu_group_get_iommudata(tcegrp->grp);
>> +	if (!table_group)
>> +		return -ENODEV;
>> +
>> +	ret =3D tce_iommu_create_window(container, IOMMU_PAGE_SHIFT_4K,
>> +			table_group->tce32_size, 1, &start_addr);
>> +	WARN_ON_ONCE(!ret && start_addr);
>> +
>> +	return ret;
>> +}
>> +
>>  static long tce_iommu_ioctl(void *iommu_data,
>>  				 unsigned int cmd, unsigned long arg)
>>  {
>> @@ -809,6 +824,13 @@ static long tce_iommu_ioctl(void *iommu_data,
>>  				VFIO_DMA_MAP_FLAG_WRITE))
>>  			return -EINVAL;
>> =20
>> +		if (container->def_window_pending) {
>> +			ret =3D tce_iommu_create_default_window(container);
>> +			if (ret)
>> +				return ret;
>> +			container->def_window_pending =3D false;
>=20
> Would it make sense to clear (and maybe test) def_window_pending
> within create_default_window()?

Dunno, matter of taste I suppose. I'll move it there.


>=20
>> +		}
>> +
>>  		num =3D tce_iommu_find_table(container, param.iova, &tbl);
>>  		if (num < 0)
>>  			return -ENXIO;
>> @@ -872,6 +894,13 @@ static long tce_iommu_ioctl(void *iommu_data,
>>  		if (param.flags)
>>  			return -EINVAL;
>> =20
>> +		if (container->def_window_pending) {
>> +			ret =3D tce_iommu_create_default_window(container);
>> +			if (ret)
>> +				return ret;
>> +			container->def_window_pending =3D false;
>> +		}
>> +
>>  		num =3D tce_iommu_find_table(container, param.iova, &tbl);
>>  		if (num < 0)
>>  			return -ENXIO;
>> @@ -998,6 +1027,8 @@ static long tce_iommu_ioctl(void *iommu_data,
>> =20
>>  		mutex_lock(&container->lock);
>> =20
>> +		container->def_window_pending =3D false;
>=20
> Uh.. why is it cleared here, without calling
> tce_iommu_create_default_window() AFAICT?


It is a branch which creates new window, if we do not have a default
window, then it will be created as the result of this ioctl(), if there i=
s
a default window, then the flag should be false already.




>=20
>>  		ret =3D tce_iommu_create_window(container, create.page_shift,
>>  				create.window_size, create.levels,
>>  				&create.start_addr);
>> @@ -1030,6 +1061,12 @@ static long tce_iommu_ioctl(void *iommu_data,
>>  		if (remove.flags)
>>  			return -EINVAL;
>> =20
>> +		if (container->def_window_pending && !remove.start_addr) {
>> +			container->def_window_pending =3D false;
>> +			return 0;
>> +		}
>> +		container->def_window_pending =3D false;
>> +
>>  		mutex_lock(&container->lock);
>> =20
>>  		ret =3D tce_iommu_remove_window(container, remove.start_addr);
>> @@ -1109,9 +1146,6 @@ static void tce_iommu_release_ownership_ddw(stru=
ct tce_container *container,
>>  static long tce_iommu_take_ownership_ddw(struct tce_container *contai=
ner,
>>  		struct iommu_table_group *table_group)
>>  {
>> -	long i, ret =3D 0;
>> -	struct iommu_table *tbl =3D NULL;
>> -
>>  	if (!table_group->ops->create_table || !table_group->ops->set_window=
 ||
>>  			!table_group->ops->release_ownership) {
>>  		WARN_ON_ONCE(1);
>> @@ -1120,47 +1154,9 @@ static long tce_iommu_take_ownership_ddw(struct=
 tce_container *container,
>> =20
>>  	table_group->ops->take_ownership(table_group);
>> =20
>> -	/*
>> -	 * If it the first group attached, check if there is
>> -	 * a default DMA window and create one if none as
>> -	 * the userspace expects it to exist.
>> -	 */
>> -	if (!tce_groups_attached(container) && !container->tables[0]) {
>> -		ret =3D tce_iommu_create_table(container,
>> -				table_group,
>> -				0, /* window number */
>> -				IOMMU_PAGE_SHIFT_4K,
>> -				table_group->tce32_size,
>> -				1, /* default levels */
>> -				&tbl);
>> -		if (ret)
>> -			goto release_exit;
>> -		else
>> -			container->tables[0] =3D tbl;
>> -	}
>> -
>> -	/* Set all windows to the new group */
>> -	for (i =3D 0; i < IOMMU_TABLE_GROUP_MAX_TABLES; ++i) {
>> -		tbl =3D container->tables[i];
>> -
>> -		if (!tbl)
>> -			continue;
>> -
>> -		/* Set the default window to a new group */
>> -		ret =3D table_group->ops->set_window(table_group, i, tbl);
>=20
> Uh... nothing in the new code seems to replace these set_window (and
> unset_window) calls.  What's up with that?


tce_iommu_create_table() + set_window() is replaced with
tce_iommu_create_default_window() which calls tce_iommu_create_window()
which calls tce_iommu_create_table() + set_window().

I'll split this patch into 2 patches, one with the change I just explaine=
d
and one to postpone the default window creation.


>=20
>> -		if (ret)
>> -			goto release_exit;
>> -	}
>> +	container->def_window_pending =3D true;
>> =20
>>  	return 0;
>> -
>> -release_exit:
>> -	for (i =3D 0; i < IOMMU_TABLE_GROUP_MAX_TABLES; ++i)
>> -		table_group->ops->unset_window(table_group, i);
>> -
>> -	table_group->ops->release_ownership(table_group);
>> -
>> -	return ret;
>>  }
>> =20
>>  static int tce_iommu_attach_group(void *iommu_data,
>=20


--=20
Alexey


--bsFoAdND5jbq9Nva71M6gK1DSFVHNxCi9--

--bhaOtJWvdKbNFMhMCuxC00GOmpmxdEI20
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIrBAEBCAAVBQJYM/PjDhxhaWtAb3psYWJzLnJ1AAoJEIYTPdgrwSC5IPgQALEH
N8MHzGRVgy93Wxp2riDpcMgoIQbWkwEsjjc+xg5CntcEkPgMAWDEwInPlL0GLG5K
kjoiu5MOwhOPz+D5VBC/i77gJ2S/AlSzhyN04m50rf+KdcJ8EhkY+AORdhg81rWp
PdZTilqSOfGELjTizipeuvwgv/UhwQeB8s5yHVnRNRlAVkjxBr4dlAAzWmosv3TM
x1bBvCfHWtr+PDFWvityeuyj+KUuexNjK6xCEzrMvxGvLOAj9g6wyxqTEsFeMuiv
LAoxKZSC61rXbVE7x3dFeUEE5cVtCzSMSfE82/uj9ztSmk9YmKiIj+dP5WldX64s
gTLTGmhgY0jYZ6y3e78Je2O+rn70OtDGFpMngyA5xNNomT6SxePuslWeCMoHbBjM
59aF0wykgcN339La3AxkxyOVAFPjagKn7EDRs2mxbm+WFIc42799usaduRuC6sTH
hqfYWnGldRhCtWIhOV24agwwsdNHav/WA8AhvjpiiDBrIwhW1TpQQhbtSci6pOdl
SjNR9gL0eRzArIGA5oPZINsZLTojLOlXr72yUh1LlFqbWjGp5dySPFghfwKYDC+A
0sxgCzzVRBcfxAkLh6h6/9gHE1Zhc/dYs0M7E5A4P33TYQnxZOF53fFm2Lc8rxoa
EStc8DnAT20VjxcnQwvYbDRsip8DkqOVruF9/dPJ
=Uw7p
-----END PGP SIGNATURE-----

--bhaOtJWvdKbNFMhMCuxC00GOmpmxdEI20--
