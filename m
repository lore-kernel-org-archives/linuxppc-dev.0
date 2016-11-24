Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tPRsq4hczzDw2T
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Nov 2016 16:02:55 +1100 (AEDT)
Date: Thu, 24 Nov 2016 15:08:18 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, kvm@vger.kernel.org
Subject: Re: [PATCH kernel v5 4/6] vfio/spapr: Postpone default window creation
Message-ID: <20161124040818.GC23872@umbus.fritz.box>
References: <1478867537-27893-1-git-send-email-aik@ozlabs.ru>
 <1478867537-27893-5-git-send-email-aik@ozlabs.ru>
 <20161122025052.GB28479@umbus.fritz.box>
 <b1aa544a-d4a1-fb2c-8069-63c52f3dbf8d@ozlabs.ru>
 <20161123013546.GH28479@umbus.fritz.box>
 <8475a1f4-fa4f-ec6b-8e41-743219cbe59e@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="vEao7xgI/oilGqZ+"
In-Reply-To: <8475a1f4-fa4f-ec6b-8e41-743219cbe59e@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--vEao7xgI/oilGqZ+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 23, 2016 at 04:06:30PM +1100, Alexey Kardashevskiy wrote:
> On 23/11/16 12:35, David Gibson wrote:
> > On Tue, Nov 22, 2016 at 06:29:39PM +1100, Alexey Kardashevskiy wrote:
> >> On 22/11/16 13:50, David Gibson wrote:
> >>> On Fri, Nov 11, 2016 at 11:32:15PM +1100, Alexey Kardashevskiy wrote:
> >>>> As mentioned in the previous patch, we are going to allow the usersp=
ace
> >>>> to configure container in one memory context and pass container fd to
> >>>> another so we are postponing memory allocations accounted against
> >>>> the locked memory limit. The previous patch took care of it_userspac=
e.
> >>>>
> >>>> At the moment we create the default DMA window when the first group =
is
> >>>> attached to a container; this is done for the userspace which is not
> >>>> DDW-aware but familiar with the SPAPR TCE IOMMU v2 in the part of me=
mory
> >>>> pre-registration - such client expects the default DMA window to exi=
st.
> >>>>
> >>>> This postpones the default DMA window allocation till first map/unmap
> >>>> request happens.
> >>>>
> >>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> >>>> ---
> >>>>  drivers/vfio/vfio_iommu_spapr_tce.c | 98 ++++++++++++++++++--------=
-----------
> >>>>  1 file changed, 47 insertions(+), 51 deletions(-)
> >>>>
> >>>> diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio=
_iommu_spapr_tce.c
> >>>> index 442baac..1c02498 100644
> >>>> --- a/drivers/vfio/vfio_iommu_spapr_tce.c
> >>>> +++ b/drivers/vfio/vfio_iommu_spapr_tce.c
> >>>> @@ -97,6 +97,7 @@ struct tce_container {
> >>>>  	struct mutex lock;
> >>>>  	bool enabled;
> >>>>  	bool v2;
> >>>> +	bool def_window_pending;
> >>>>  	unsigned long locked_pages;
> >>>>  	struct iommu_table *tables[IOMMU_TABLE_GROUP_MAX_TABLES];
> >>>>  	struct list_head group_list;
> >>>> @@ -594,15 +595,6 @@ static long tce_iommu_create_table(struct tce_c=
ontainer *container,
> >>>>  	WARN_ON(!ret && !(*ptbl)->it_ops->free);
> >>>>  	WARN_ON(!ret && ((*ptbl)->it_allocated_size !=3D table_size));
> >>>> =20
> >>>> -	if (!ret && container->v2) {
> >>>> -		ret =3D tce_iommu_userspace_view_alloc(*ptbl);
> >>>> -		if (ret)
> >>>> -			(*ptbl)->it_ops->free(*ptbl);
> >>>> -	}
> >>>
> >>> Does this stuff for the user view belong in the previous patch?
> >>
> >> Yes it does, my mistake, will fix.
> >>
> >>
> >>>
> >>>> -
> >>>> -	if (ret)
> >>>> -		decrement_locked_vm(table_size >> PAGE_SHIFT);
> >>>> -
> >>>>  	return ret;
> >>>>  }
> >>>> =20
> >>>> @@ -719,6 +711,29 @@ static long tce_iommu_remove_window(struct tce_=
container *container,
> >>>>  	return 0;
> >>>>  }
> >>>> =20
> >>>> +static long tce_iommu_create_default_window(struct tce_container *c=
ontainer)
> >>>> +{
> >>>> +	long ret;
> >>>> +	__u64 start_addr =3D 0;
> >>>> +	struct tce_iommu_group *tcegrp;
> >>>> +	struct iommu_table_group *table_group;
> >>>> +
> >>>> +	if (!tce_groups_attached(container))
> >>>> +		return -ENODEV;
> >>>> +
> >>>> +	tcegrp =3D list_first_entry(&container->group_list,
> >>>> +			struct tce_iommu_group, next);
> >>>> +	table_group =3D iommu_group_get_iommudata(tcegrp->grp);
> >>>> +	if (!table_group)
> >>>> +		return -ENODEV;
> >>>> +
> >>>> +	ret =3D tce_iommu_create_window(container, IOMMU_PAGE_SHIFT_4K,
> >>>> +			table_group->tce32_size, 1, &start_addr);
> >>>> +	WARN_ON_ONCE(!ret && start_addr);
> >>>> +
> >>>> +	return ret;
> >>>> +}
> >>>> +
> >>>>  static long tce_iommu_ioctl(void *iommu_data,
> >>>>  				 unsigned int cmd, unsigned long arg)
> >>>>  {
> >>>> @@ -809,6 +824,13 @@ static long tce_iommu_ioctl(void *iommu_data,
> >>>>  				VFIO_DMA_MAP_FLAG_WRITE))
> >>>>  			return -EINVAL;
> >>>> =20
> >>>> +		if (container->def_window_pending) {
> >>>> +			ret =3D tce_iommu_create_default_window(container);
> >>>> +			if (ret)
> >>>> +				return ret;
> >>>> +			container->def_window_pending =3D false;
> >>>
> >>> Would it make sense to clear (and maybe test) def_window_pending
> >>> within create_default_window()?
> >>
> >> Dunno, matter of taste I suppose. I'll move it there.
> >>
> >>
> >>>
> >>>> +		}
> >>>> +
> >>>>  		num =3D tce_iommu_find_table(container, param.iova, &tbl);
> >>>>  		if (num < 0)
> >>>>  			return -ENXIO;
> >>>> @@ -872,6 +894,13 @@ static long tce_iommu_ioctl(void *iommu_data,
> >>>>  		if (param.flags)
> >>>>  			return -EINVAL;
> >>>> =20
> >>>> +		if (container->def_window_pending) {
> >>>> +			ret =3D tce_iommu_create_default_window(container);
> >>>> +			if (ret)
> >>>> +				return ret;
> >>>> +			container->def_window_pending =3D false;
> >>>> +		}
> >>>> +
> >>>>  		num =3D tce_iommu_find_table(container, param.iova, &tbl);
> >>>>  		if (num < 0)
> >>>>  			return -ENXIO;
> >>>> @@ -998,6 +1027,8 @@ static long tce_iommu_ioctl(void *iommu_data,
> >>>> =20
> >>>>  		mutex_lock(&container->lock);
> >>>> =20
> >>>> +		container->def_window_pending =3D false;
> >>>
> >>> Uh.. why is it cleared here, without calling
> >>> tce_iommu_create_default_window() AFAICT?
> >>
> >>
> >> It is a branch which creates new window, if we do not have a default
> >> window, then it will be created as the result of this ioctl(), if ther=
e is
> >> a default window, then the flag should be false already.
> >=20
> > Um.. it will create *a* window, but not necessarily the default one.
> > Consider this scenario:
> >=20
> > 1. Container is opened
> > 2. A group is attached
> > 3. Userspace, expecting the default window to be in place, creates a
> >    second window
> > 4. Mapping starts
> >=20
> > Won't the above code mean that we create what userspace expected to be
> > the second window as the first window replacing the default one
> > instead?
>=20
> Uff. Yes, this is correct.
>=20
> This is a bug in my initial design - I should not have created a "default"
> window in the first place - it does not make sense at this level; and the
> userspace (i.e. QEMU) removes all windows on reset anyway.
>=20
> The only way QEMU will use this default window is when it is at 318f67ce1
> "vfio: spapr: Add DMA memory preregistering (SPAPR IOMMU v2)" - memory
> preregistration is there, but ddw is not yet but it is 2 patches later
> where vfio_connect_container() unconditionally removes the default window.
> Which is unlikely scenario.
>=20
> Taking into account small number of DDW users (basically - QEMU v2.7.0),
> does it still make sense to keep this default window code? The only
> immediate problem I see here is QEMU will receive error from
> vfio_spapr_remove_window() in vfio_connect_container() as there will be no
> default window but I could workaround this.

Hmm.. I dislike changing the semantics now.

Can't you just
	if (def_window_pending)
		create_default_window()

Before completing the CREATE_WINDOW ioctl().  That should handle it,
no?

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--vEao7xgI/oilGqZ+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYNmeyAAoJEGw4ysog2bOS/oQQAIdRXQd4Bz0rHjXMc3qTI8TW
34cVOMKdJWvap35ZTZ8uXRjg8aMac+5n3CUD4SsXVWY9fJXKL2QhpvZ31kg4gCRQ
Vsrycuf6vvU25k6JJcZDBi+z1CTZ6RwHGMpeejVQyV6/xH2vxJlCULuqtEfYw++p
3qrwDwkr1FiFEbtq7tGhAsBhdn8C4Y7ftH4WSqTQyveBG2RBJfUh+fqf1WsjdJ76
N54lhjCcQdEx70CgtRx7SnmlqUrG8g8UrAfk8rV5Xj3XN0xclcnl/ru/GovqMo0q
8Hv+Ekg+dFC92Dwc+zYImyODLeGdpgyufZ4gb2FcbNoAfrkwtoCDSZ3eaqgSlken
/N/vHER9ku4xxmNMN3yMRk2j6iE45D0Eyf8MawNDn4nJb1oI9eJ/f3SgGcrdGFzX
aR9+0h1WtC1XirSYCVOg7T0evozK8i1uVwWLdmY9JTVFgtOk5MVu/FczMOkOvFLf
1BrIPD0FSQHuPbei4oBEn04DmJ1TP7rv22kcvXPZwGYvjd+LHMIuFClOO/oghOT0
WgIU38SllfzRCiONcj2HMJ6PIpcPgh+1zuQJ7tswSbRmAp3UncShgeW2CqCH6p+t
hRryjU31ChM0nH7v7NOgbYfFb9HrARufVu3/J9MImClXd5SMSnTyiATz7IbhSNBf
XTtpVKwF8UN0/68SZC9A
=6XLl
-----END PGP SIGNATURE-----

--vEao7xgI/oilGqZ+--
