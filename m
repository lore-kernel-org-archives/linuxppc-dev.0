Return-Path: <aik@ozlabs.ru>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tQ5xq3TRszDvp4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Nov 2016 17:38:36 +1100 (AEDT)
Received: by mail-pg0-x241.google.com with SMTP id x23so4868518pgx.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Nov 2016 22:38:36 -0800 (PST)
Subject: Re: [PATCH kernel v6 5/7] vfio/spapr: Postpone default window creation
To: David Gibson <david@gibson.dropbear.id.au>
References: <1479966490-8739-1-git-send-email-aik@ozlabs.ru>
 <1479966490-8739-6-git-send-email-aik@ozlabs.ru>
 <20161125043904.GE12287@umbus.fritz.box>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, Paul Mackerras <paulus@samba.org>,
 kvm@vger.kernel.org
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <2ef5c5f2-fbc7-6d25-93c9-fe225e10669c@ozlabs.ru>
Date: Fri, 25 Nov 2016 17:38:26 +1100
MIME-Version: 1.0
In-Reply-To: <20161125043904.GE12287@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="h3AxgROAKcN0Pt5238WeBTHttxdD2HDJT"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--h3AxgROAKcN0Pt5238WeBTHttxdD2HDJT
Content-Type: multipart/mixed; boundary="sW1mQfBuUCBinBBsVOjeg0tefspoExQwn";
 protected-headers="v1"
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, Paul Mackerras <paulus@samba.org>,
 kvm@vger.kernel.org
Message-ID: <2ef5c5f2-fbc7-6d25-93c9-fe225e10669c@ozlabs.ru>
Subject: Re: [PATCH kernel v6 5/7] vfio/spapr: Postpone default window
 creation
References: <1479966490-8739-1-git-send-email-aik@ozlabs.ru>
 <1479966490-8739-6-git-send-email-aik@ozlabs.ru>
 <20161125043904.GE12287@umbus.fritz.box>
In-Reply-To: <20161125043904.GE12287@umbus.fritz.box>

--sW1mQfBuUCBinBBsVOjeg0tefspoExQwn
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: quoted-printable

On 25/11/16 15:39, David Gibson wrote:
> On Thu, Nov 24, 2016 at 04:48:08PM +1100, Alexey Kardashevskiy wrote:
>> We are going to allow the userspace to configure container in
>> one memory context and pass container fd to another so
>> we are postponing memory allocations accounted against
>> the locked memory limit. One of previous patches took care of
>> it_userspace.
>>
>> At the moment we create the default DMA window when the first group is=

>> attached to a container; this is done for the userspace which is not
>> DDW-aware but familiar with the SPAPR TCE IOMMU v2 in the part of memo=
ry
>> pre-registration - such client expects the default DMA window to exist=
=2E
>>
>> This postpones the default DMA window allocation till one of
>> the folliwing happens:
>> 1. first map/unmap request arrives;
>> 2. new window is requested;
>> This adds noop for the case when the userspace requested removal
>> of the default window which has not been created yet.
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>=20
> Hmm.. it just occurred to me: why do you even need to delay creation
> of the default window?


Because I want to account the memory it uses in locked_vm of the mm which=

will later be used for map/unmap.


>=20
> In order to allow the open container - move to new process - map
> scenario you need to delay binding of the mm to the container until
> mapping actually occurs.  And if you're doing that, you also want to
> delay allocation of the userspace table view, since the "userspace
> view" is only well defined once you're bound to a particular mm.
>=20
> But I don't see why you can't actually create the window - including
> the actual TCE table and all - before that point.  After all, in the
> non-ddw case that's effectively what happens - the fixed window is
> there all the time.
>=20
> If you leave the creation of the default window at the point the first
> group is bound to the container, I think you'll simplify things -
> including because you'll remove an extra difference between the ddw
> and non-ddw cases.
>=20
> The you treat the binding of a table to an mm as a later step, that
> should go together with the allocation of the userspace view.
>=20
>> ---
>> Changes:
>> v6:
>> * new helper tce_iommu_create_default_window() moved to a separate pat=
ch;
>> * creates a default window when new window is requested; it used to
>> reset the def_window_pending flag instead;
>> * def_window_pending handling (mostly) localized in
>> tce_iommu_create_default_window() now, the only exception is removal
>> of not yet created default window.
>> ---
>>  drivers/vfio/vfio_iommu_spapr_tce.c | 40 +++++++++++++++++++++++-----=
---------
>>  1 file changed, 25 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_i=
ommu_spapr_tce.c
>> index a67bbfd..88622be 100644
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
>> @@ -717,6 +718,9 @@ static long tce_iommu_create_default_window(struct=
 tce_container *container)
>>  	struct tce_iommu_group *tcegrp;
>>  	struct iommu_table_group *table_group;
>> =20
>> +	if (!container->def_window_pending)
>> +		return 0;
>> +
>>  	if (!tce_groups_attached(container))
>>  		return -ENODEV;
>> =20
>> @@ -730,6 +734,9 @@ static long tce_iommu_create_default_window(struct=
 tce_container *container)
>>  			table_group->tce32_size, 1, &start_addr);
>>  	WARN_ON_ONCE(!ret && start_addr);
>> =20
>> +	if (!ret)
>> +		container->def_window_pending =3D false;
>> +
>>  	return ret;
>>  }
>> =20
>> @@ -823,6 +830,10 @@ static long tce_iommu_ioctl(void *iommu_data,
>>  				VFIO_DMA_MAP_FLAG_WRITE))
>>  			return -EINVAL;
>> =20
>> +		ret =3D tce_iommu_create_default_window(container);
>> +		if (ret)
>> +			return ret;
>> +
>>  		num =3D tce_iommu_find_table(container, param.iova, &tbl);
>>  		if (num < 0)
>>  			return -ENXIO;
>> @@ -886,6 +897,10 @@ static long tce_iommu_ioctl(void *iommu_data,
>>  		if (param.flags)
>>  			return -EINVAL;
>> =20
>> +		ret =3D tce_iommu_create_default_window(container);
>> +		if (ret)
>> +			return ret;
>> +
>>  		num =3D tce_iommu_find_table(container, param.iova, &tbl);
>>  		if (num < 0)
>>  			return -ENXIO;
>> @@ -1012,6 +1027,10 @@ static long tce_iommu_ioctl(void *iommu_data,
>> =20
>>  		mutex_lock(&container->lock);
>> =20
>> +		ret =3D tce_iommu_create_default_window(container);
>> +		if (ret)
>> +			return ret;
>> +
>>  		ret =3D tce_iommu_create_window(container, create.page_shift,
>>  				create.window_size, create.levels,
>>  				&create.start_addr);
>> @@ -1044,6 +1063,11 @@ static long tce_iommu_ioctl(void *iommu_data,
>>  		if (remove.flags)
>>  			return -EINVAL;
>> =20
>> +		if (container->def_window_pending && !remove.start_addr) {
>> +			container->def_window_pending =3D false;
>> +			return 0;
>> +		}
>> +
>>  		mutex_lock(&container->lock);
>> =20
>>  		ret =3D tce_iommu_remove_window(container, remove.start_addr);
>> @@ -1141,7 +1165,6 @@ static int tce_iommu_attach_group(void *iommu_da=
ta,
>>  	struct tce_container *container =3D iommu_data;
>>  	struct iommu_table_group *table_group;
>>  	struct tce_iommu_group *tcegrp =3D NULL;
>> -	bool create_default_window =3D false;
>> =20
>>  	mutex_lock(&container->lock);
>> =20
>> @@ -1189,25 +1212,12 @@ static int tce_iommu_attach_group(void *iommu_=
data,
>>  	} else {
>>  		ret =3D tce_iommu_take_ownership_ddw(container, table_group);
>>  		if (!tce_groups_attached(container) && !container->tables[0])
>> -			create_default_window =3D true;
>> +			container->def_window_pending =3D true;
>>  	}
>> =20
>>  	if (!ret) {
>>  		tcegrp->grp =3D iommu_group;
>>  		list_add(&tcegrp->next, &container->group_list);
>> -		/*
>> -		 * If it the first group attached, check if there is
>> -		 * a default DMA window and create one if none as
>> -		 * the userspace expects it to exist.
>> -		 */
>> -		if (create_default_window) {
>> -			ret =3D tce_iommu_create_default_window(container);
>> -			if (ret) {
>> -				list_del(&tcegrp->next);
>> -				tce_iommu_release_ownership_ddw(container,
>> -						table_group);
>> -			}
>> -		}
>>  	}
>> =20
>>  unlock_exit:
>=20


--=20
Alexey


--sW1mQfBuUCBinBBsVOjeg0tefspoExQwn--

--h3AxgROAKcN0Pt5238WeBTHttxdD2HDJT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIrBAEBCAAVBQJYN9xiDhxhaWtAb3psYWJzLnJ1AAoJEIYTPdgrwSC5Cq4P/jSP
WuCWIFQ9XJUpkATbrG7XchoeK+jpBJ1MPm1NHIOOc4SvZu2HF4pVzPEpVZcLlPVt
ay/babC4R1+dfKqJSj8xpVdnyN8vQzcPMB3lI8vPjo436F3bOG5mcs//y9D9J+vW
9Ddon0RnTVc4KzkTEEVwMmL+NpphOxbnwyaN0lie+4AQu0pTP6bRaoVWhTAs/toL
TqRhmy32Vy5TEXoC3O4ixNWxsZcxCLny4pr3UZu4U2o9X6R+lEQLxbAeV7xUEbYF
BoGFjwlqxPhG4WbQjNkTwWcee26vW09pqI8d5bWyyADiHLjI9Faq2/fDsNOrKrzd
Izmg2EOQBmk1So4w1QjuPIsFDZLPg2ivtZ36b8EYlJXM0GdWJE4+pzSC+DHOhtrJ
ptEJDNSNclhdBacL6N7weOMzWxRhT1xuuwzwTUCgAh7ejMpGZ9zEcxFmi/nXpcjT
AaziEdTWaFU21dRd6ekdF6OJ5XBWwiZxMA8wc6X7R2Nut8KyK8hoqvqu9Q8H5ugc
rOXAqwZiB2VobxcYzTwPwdkoHIN0GtmmZkHmMFtb2c3ZhR5oZDe3J/2e5Mb1Sfpb
FuchMv5uOWyKPC0KPio3znfgGy1a5+5qx5qay5jxJIipEuVxwnV1+E9/p1PBx64y
zF0kGVDnQRvOnI4LqQGUIU8RbIiJdV5Z5jHtgg71
=bzpR
-----END PGP SIGNATURE-----

--h3AxgROAKcN0Pt5238WeBTHttxdD2HDJT--
