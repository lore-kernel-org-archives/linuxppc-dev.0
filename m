Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AF2F51A0C30
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Apr 2015 17:45:23 +1000 (AEST)
Date: Thu, 30 Apr 2015 17:22:22 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel v9 31/32] vfio: powerpc/spapr: Support multiple
 groups in one container if possible
Message-ID: <20150430072221.GD24886@voom.redhat.com>
References: <1429964096-11524-1-git-send-email-aik@ozlabs.ru>
 <1429964096-11524-32-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="KdquIMZPjGJQvRdI"
In-Reply-To: <1429964096-11524-32-git-send-email-aik@ozlabs.ru>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--KdquIMZPjGJQvRdI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 25, 2015 at 10:14:55PM +1000, Alexey Kardashevskiy wrote:
> At the moment only one group per container is supported.
> POWER8 CPUs have more flexible design and allows naving 2 TCE tables per
> IOMMU group so we can relax this limitation and support multiple groups
> per container.

It's not obvious why allowing multiple TCE tables per PE has any
pearing on allowing multiple groups per container.

> This adds TCE table descriptors to a container and uses iommu_table_group=
_ops
> to create/set DMA windows on IOMMU groups so the same TCE tables will be
> shared between several IOMMU groups.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> [aw: for the vfio related changes]
> Acked-by: Alex Williamson <alex.williamson@redhat.com>
> ---
> Changes:
> v7:
> * updated doc
> ---
>  Documentation/vfio.txt              |   8 +-
>  drivers/vfio/vfio_iommu_spapr_tce.c | 268 ++++++++++++++++++++++++++----=
------
>  2 files changed, 199 insertions(+), 77 deletions(-)
>=20
> diff --git a/Documentation/vfio.txt b/Documentation/vfio.txt
> index 94328c8..7dcf2b5 100644
> --- a/Documentation/vfio.txt
> +++ b/Documentation/vfio.txt
> @@ -289,10 +289,12 @@ PPC64 sPAPR implementation note
> =20
>  This implementation has some specifics:
> =20
> -1) Only one IOMMU group per container is supported as an IOMMU group
> -represents the minimal entity which isolation can be guaranteed for and
> -groups are allocated statically, one per a Partitionable Endpoint (PE)
> +1) On older systems (POWER7 with P5IOC2/IODA1) only one IOMMU group per
> +container is supported as an IOMMU table is allocated at the boot time,
> +one table per a IOMMU group which is a Partitionable Endpoint (PE)
>  (PE is often a PCI domain but not always).

I thought the more fundamental problem was that different PEs tended
to use disjoint bus address ranges, so even by duplicating put_tce
across PEs you couldn't have a common address space.

> +Newer systems (POWER8 with IODA2) have improved hardware design which al=
lows
> +to remove this limitation and have multiple IOMMU groups per a VFIO cont=
ainer.
> =20
>  2) The hardware supports so called DMA windows - the PCI address range
>  within which DMA transfer is allowed, any attempt to access address space
> diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iomm=
u_spapr_tce.c
> index a7d6729..970e3a2 100644
> --- a/drivers/vfio/vfio_iommu_spapr_tce.c
> +++ b/drivers/vfio/vfio_iommu_spapr_tce.c
> @@ -82,6 +82,11 @@ static void decrement_locked_vm(long npages)
>   * into DMA'ble space using the IOMMU
>   */
> =20
> +struct tce_iommu_group {
> +	struct list_head next;
> +	struct iommu_group *grp;
> +};
> +
>  /*
>   * The container descriptor supports only a single group per container.
>   * Required by the API as the container is not supplied with the IOMMU g=
roup
> @@ -89,10 +94,11 @@ static void decrement_locked_vm(long npages)
>   */
>  struct tce_container {
>  	struct mutex lock;
> -	struct iommu_group *grp;
>  	bool enabled;
>  	unsigned long locked_pages;
>  	bool v2;
> +	struct iommu_table tables[IOMMU_TABLE_GROUP_MAX_TABLES];

Hrm,  so here we have more copies of the full iommu_table structures,
which again muddies the lifetime.  The table_group pointer is
presumably meaningless in these copies, which seems dangerously
confusing.

> +	struct list_head group_list;
>  };
> =20
>  static long tce_unregister_pages(struct tce_container *container,
> @@ -154,20 +160,20 @@ static bool tce_page_is_contained(struct page *page=
, unsigned page_shift)
>  	return (PAGE_SHIFT + compound_order(compound_head(page))) >=3D page_shi=
ft;
>  }
> =20
> +static inline bool tce_groups_attached(struct tce_container *container)
> +{
> +	return !list_empty(&container->group_list);
> +}
> +
>  static struct iommu_table *spapr_tce_find_table(
>  		struct tce_container *container,
>  		phys_addr_t ioba)
>  {
>  	long i;
>  	struct iommu_table *ret =3D NULL;
> -	struct iommu_table_group *table_group;
> -
> -	table_group =3D iommu_group_get_iommudata(container->grp);
> -	if (!table_group)
> -		return NULL;
> =20
>  	for (i =3D 0; i < IOMMU_TABLE_GROUP_MAX_TABLES; ++i) {
> -		struct iommu_table *tbl =3D &table_group->tables[i];
> +		struct iommu_table *tbl =3D &container->tables[i];
>  		unsigned long entry =3D ioba >> tbl->it_page_shift;
>  		unsigned long start =3D tbl->it_offset;
>  		unsigned long end =3D start + tbl->it_size;
> @@ -186,9 +192,7 @@ static int tce_iommu_enable(struct tce_container *con=
tainer)
>  	int ret =3D 0;
>  	unsigned long locked;
>  	struct iommu_table_group *table_group;
> -
> -	if (!container->grp)
> -		return -ENXIO;
> +	struct tce_iommu_group *tcegrp;
> =20
>  	if (!current->mm)
>  		return -ESRCH; /* process exited */
> @@ -225,7 +229,12 @@ static int tce_iommu_enable(struct tce_container *co=
ntainer)
>  	 * as there is no way to know how much we should increment
>  	 * the locked_vm counter.
>  	 */
> -	table_group =3D iommu_group_get_iommudata(container->grp);
> +	if (!tce_groups_attached(container))
> +		return -ENODEV;
> +
> +	tcegrp =3D list_first_entry(&container->group_list,
> +			struct tce_iommu_group, next);
> +	table_group =3D iommu_group_get_iommudata(tcegrp->grp);
>  	if (!table_group)
>  		return -ENODEV;
> =20
> @@ -257,6 +266,48 @@ static void tce_iommu_disable(struct tce_container *=
container)
>  	decrement_locked_vm(container->locked_pages);
>  }
> =20
> +static long tce_iommu_create_table(struct iommu_table_group *table_group,
> +			int num,
> +			__u32 page_shift,
> +			__u64 window_size,
> +			__u32 levels,
> +			struct iommu_table *tbl)

With multiple groups (and therefore PEs) per container, this seems
wrong.  There's only one table_group per PE, so what's special about
PE whose table group is passed in here.

> +{
> +	long ret, table_size;
> +
> +	table_size =3D table_group->ops->get_table_size(page_shift, window_size,
> +			levels);
> +	if (!table_size)
> +		return -EINVAL;
> +
> +	ret =3D try_increment_locked_vm(table_size >> PAGE_SHIFT);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D table_group->ops->create_table(table_group, num,
> +			page_shift, window_size, levels, tbl);
> +
> +	WARN_ON(!ret && !tbl->it_ops->free);
> +	WARN_ON(!ret && (tbl->it_allocated_size !=3D table_size));
> +
> +	if (ret)
> +		decrement_locked_vm(table_size >> PAGE_SHIFT);
> +
> +	return ret;
> +}
> +
> +static void tce_iommu_free_table(struct iommu_table *tbl)
> +{
> +	unsigned long pages =3D tbl->it_allocated_size >> PAGE_SHIFT;
> +
> +	if (!tbl->it_size)
> +		return;
> +
> +	tbl->it_ops->free(tbl);

So, this is exactly the case where the lifetimes are badly confusing.
How can you be confident here that another copy of the iommu_table
struct isn't referencing the same TCE tables?

> +	decrement_locked_vm(pages);
> +	memset(tbl, 0, sizeof(*tbl));
> +}
> +
>  static void *tce_iommu_open(unsigned long arg)
>  {
>  	struct tce_container *container;
> @@ -271,19 +322,41 @@ static void *tce_iommu_open(unsigned long arg)
>  		return ERR_PTR(-ENOMEM);
> =20
>  	mutex_init(&container->lock);
> +	INIT_LIST_HEAD_RCU(&container->group_list);

I see no other mentions of rcu related to this list, which doesn't
seem right.

>  	container->v2 =3D arg =3D=3D VFIO_SPAPR_TCE_v2_IOMMU;
> =20
>  	return container;
>  }
> =20
> +static int tce_iommu_clear(struct tce_container *container,
> +		struct iommu_table *tbl,
> +		unsigned long entry, unsigned long pages);
> +
>  static void tce_iommu_release(void *iommu_data)
>  {
>  	struct tce_container *container =3D iommu_data;
> +	struct iommu_table_group *table_group;
> +	struct tce_iommu_group *tcegrp;
> +	long i;
> =20
> -	WARN_ON(container->grp);
> +	while (tce_groups_attached(container)) {
> +		tcegrp =3D list_first_entry(&container->group_list,
> +				struct tce_iommu_group, next);
> +		table_group =3D iommu_group_get_iommudata(tcegrp->grp);
> +		tce_iommu_detach_group(iommu_data, tcegrp->grp);
> +	}
> =20
> -	if (container->grp)
> -		tce_iommu_detach_group(iommu_data, container->grp);
> +	/*
> +	 * If VFIO created a table, it was not disposed
> +	 * by tce_iommu_detach_group() so do it now.
> +	 */
> +	for (i =3D 0; i < IOMMU_TABLE_GROUP_MAX_TABLES; ++i) {
> +		struct iommu_table *tbl =3D &container->tables[i];
> +
> +		tce_iommu_clear(container, tbl, tbl->it_offset, tbl->it_size);
> +		tce_iommu_free_table(tbl);
> +	}
> =20
>  	tce_iommu_disable(container);
>  	mutex_destroy(&container->lock);
> @@ -509,12 +582,15 @@ static long tce_iommu_ioctl(void *iommu_data,
> =20
>  	case VFIO_IOMMU_SPAPR_TCE_GET_INFO: {
>  		struct vfio_iommu_spapr_tce_info info;
> +		struct tce_iommu_group *tcegrp;
>  		struct iommu_table_group *table_group;
> =20
> -		if (WARN_ON(!container->grp))
> +		if (!tce_groups_attached(container))
>  			return -ENXIO;
> =20
> -		table_group =3D iommu_group_get_iommudata(container->grp);
> +		tcegrp =3D list_first_entry(&container->group_list,
> +				struct tce_iommu_group, next);
> +		table_group =3D iommu_group_get_iommudata(tcegrp->grp);
> =20
>  		if (!table_group)
>  			return -ENXIO;
> @@ -707,12 +783,20 @@ static long tce_iommu_ioctl(void *iommu_data,
>  		tce_iommu_disable(container);
>  		mutex_unlock(&container->lock);
>  		return 0;
> -	case VFIO_EEH_PE_OP:
> -		if (!container->grp)
> -			return -ENODEV;
> =20
> -		return vfio_spapr_iommu_eeh_ioctl(container->grp,
> -						  cmd, arg);
> +	case VFIO_EEH_PE_OP: {
> +		struct tce_iommu_group *tcegrp;
> +
> +		ret =3D 0;
> +		list_for_each_entry(tcegrp, &container->group_list, next) {
> +			ret =3D vfio_spapr_iommu_eeh_ioctl(tcegrp->grp,
> +					cmd, arg);
> +			if (ret)
> +				return ret;

Hrm.  It occurs to me that EEH may need a way of referencing
individual groups.  Even if multiple PEs are referencing the same TCE
tables, presumably EEH will isolate them individually.

> +		}
> +		return ret;
> +	}
> +
>  	}
> =20
>  	return -ENOTTY;
> @@ -724,11 +808,14 @@ static void tce_iommu_release_ownership(struct tce_=
container *container,
>  	int i;
> =20
>  	for (i =3D 0; i < IOMMU_TABLE_GROUP_MAX_TABLES; ++i) {
> -		struct iommu_table *tbl =3D &table_group->tables[i];
> +		struct iommu_table *tbl =3D &container->tables[i];
> =20
>  		tce_iommu_clear(container, tbl, tbl->it_offset, tbl->it_size);
>  		if (tbl->it_map)
>  			iommu_release_ownership(tbl);
> +
> +		/* Reset the container's copy of the table descriptor */
> +		memset(tbl, 0, sizeof(*tbl));
>  	}
>  }
> =20
> @@ -758,38 +845,56 @@ static int tce_iommu_take_ownership(struct iommu_ta=
ble_group *table_group)
>  static int tce_iommu_attach_group(void *iommu_data,
>  		struct iommu_group *iommu_group)
>  {
> -	int ret;
> +	int ret, i;
>  	struct tce_container *container =3D iommu_data;
>  	struct iommu_table_group *table_group;
> +	struct tce_iommu_group *tcegrp =3D NULL;
> +	bool first_group =3D !tce_groups_attached(container);
> =20
>  	mutex_lock(&container->lock);
> =20
>  	/* pr_debug("tce_vfio: Attaching group #%u to iommu %p\n",
>  			iommu_group_id(iommu_group), iommu_group); */
> -	if (container->grp) {
> -		pr_warn("tce_vfio: Only one group per IOMMU container is allowed, exis=
ting id=3D%d, attaching id=3D%d\n",
> -				iommu_group_id(container->grp),
> -				iommu_group_id(iommu_group));
> -		ret =3D -EBUSY;
> -		goto unlock_exit;
> -	}
> -
> -	if (container->enabled) {
> -		pr_err("tce_vfio: attaching group #%u to enabled container\n",
> -				iommu_group_id(iommu_group));
> -		ret =3D -EBUSY;
> -		goto unlock_exit;
> -	}
> -
>  	table_group =3D iommu_group_get_iommudata(iommu_group);
> -	if (!table_group) {
> -		ret =3D -ENXIO;
> +
> +	if (!first_group && (!table_group->ops ||
> +			!table_group->ops->take_ownership ||
> +			!table_group->ops->release_ownership)) {
> +		ret =3D -EBUSY;
> +		goto unlock_exit;
> +	}
> +
> +	/* Check if new group has the same iommu_ops (i.e. compatible) */
> +	list_for_each_entry(tcegrp, &container->group_list, next) {
> +		struct iommu_table_group *table_group_tmp;
> +
> +		if (tcegrp->grp =3D=3D iommu_group) {
> +			pr_warn("tce_vfio: Group %d is already attached\n",
> +					iommu_group_id(iommu_group));
> +			ret =3D -EBUSY;
> +			goto unlock_exit;
> +		}
> +		table_group_tmp =3D iommu_group_get_iommudata(tcegrp->grp);
> +		if (table_group_tmp->ops !=3D table_group->ops) {
> +			pr_warn("tce_vfio: Group %d is incompatible with group %d\n",
> +					iommu_group_id(iommu_group),
> +					iommu_group_id(tcegrp->grp));
> +			ret =3D -EPERM;
> +			goto unlock_exit;
> +		}
> +	}
> +
> +	tcegrp =3D kzalloc(sizeof(*tcegrp), GFP_KERNEL);
> +	if (!tcegrp) {
> +		ret =3D -ENOMEM;
>  		goto unlock_exit;
>  	}
> =20
>  	if (!table_group->ops || !table_group->ops->take_ownership ||
>  			!table_group->ops->release_ownership) {
>  		ret =3D tce_iommu_take_ownership(table_group);
> +		if (!ret)
> +			container->tables[0] =3D table_group->tables[0];
>  	} else if (!table_group->ops->create_table ||
>  			!table_group->ops->set_window) {
>  		WARN_ON_ONCE(1);
> @@ -801,23 +906,46 @@ static int tce_iommu_attach_group(void *iommu_data,
>  		 * the pages that has been explicitly mapped into the iommu
>  		 */
>  		table_group->ops->take_ownership(table_group);
> -		ret =3D table_group->ops->create_table(table_group,
> -				0, /* window number */
> -				IOMMU_PAGE_SHIFT_4K,
> -				table_group->tce32_size,
> -				1, /* default levels */
> -				&table_group->tables[0]);
> -		if (!ret)
> -			ret =3D table_group->ops->set_window(table_group, 0,
> -					&table_group->tables[0]);
> +		/*
> +		 * If it the first group attached, check if there is
> +		 * a default DMA window and create one if none as
> +		 * the userspace expects it to exist.
> +		 */
> +		if (first_group && !container->tables[0].it_size) {
> +			ret =3D tce_iommu_create_table(table_group,
> +					0, /* window number */
> +					IOMMU_PAGE_SHIFT_4K,
> +					table_group->tce32_size,
> +					1, /* default levels */
> +					&container->tables[0]);
> +			if (ret)
> +				goto unlock_exit;
> +		}
> +
> +		/* Set all windows to the new group */
> +		for (i =3D 0; i < IOMMU_TABLE_GROUP_MAX_TABLES; ++i) {
> +			struct iommu_table *tbl =3D &container->tables[i];
> +
> +			if (!tbl->it_size)
> +				continue;
> +
> +			/* Set the default window to a new group */
> +			ret =3D table_group->ops->set_window(table_group, i, tbl);
> +			if (ret)
> +				break;
> +		}
>  	}
> =20
>  	if (ret)
>  		goto unlock_exit;
> =20
> -	container->grp =3D iommu_group;
> +	tcegrp->grp =3D iommu_group;
> +	list_add(&tcegrp->next, &container->group_list);
> =20
>  unlock_exit:
> +	if (ret && tcegrp)
> +		kfree(tcegrp);
> +
>  	mutex_unlock(&container->lock);
> =20
>  	return ret;
> @@ -828,25 +956,27 @@ static void tce_iommu_detach_group(void *iommu_data,
>  {
>  	struct tce_container *container =3D iommu_data;
>  	struct iommu_table_group *table_group;
> +	struct tce_iommu_group *tcegrp;
>  	long i;
> +	bool found =3D false;
> =20
>  	mutex_lock(&container->lock);
> -	if (iommu_group !=3D container->grp) {
> -		pr_warn("tce_vfio: detaching group #%u, expected group is #%u\n",
> -				iommu_group_id(iommu_group),
> -				iommu_group_id(container->grp));
> +
> +	list_for_each_entry(tcegrp, &container->group_list, next) {
> +		if (tcegrp->grp =3D=3D iommu_group) {
> +			found =3D true;
> +			break;
> +		}
> +	}
> +
> +	if (!found) {
> +		pr_warn("tce_vfio: detaching unattached group #%u\n",
> +				iommu_group_id(iommu_group));
>  		goto unlock_exit;
>  	}
> =20
> -	if (container->enabled) {
> -		pr_warn("tce_vfio: detaching group #%u from enabled container, forcing=
 disable\n",
> -				iommu_group_id(container->grp));
> -		tce_iommu_disable(container);
> -	}
> -
> -	/* pr_debug("tce_vfio: detaching group #%u from iommu %p\n",
> -	   iommu_group_id(iommu_group), iommu_group); */
> -	container->grp =3D NULL;
> +	list_del(&tcegrp->next);
> +	kfree(tcegrp);
> =20
>  	table_group =3D iommu_group_get_iommudata(iommu_group);
>  	BUG_ON(!table_group);
> @@ -857,18 +987,8 @@ static void tce_iommu_detach_group(void *iommu_data,
>  	else if (!table_group->ops->unset_window)
>  		WARN_ON_ONCE(1);
>  	else {
> -		for (i =3D 0; i < IOMMU_TABLE_GROUP_MAX_TABLES; ++i) {
> -			struct iommu_table tbl =3D table_group->tables[i];
> -
> -			if (!tbl.it_size)
> -				continue;
> -
> +		for (i =3D 0; i < IOMMU_TABLE_GROUP_MAX_TABLES; ++i)
>  			table_group->ops->unset_window(table_group, i);
> -			tce_iommu_clear(container, &tbl,
> -					tbl.it_offset, tbl.it_size);
> -			if (tbl.it_ops->free)
> -				tbl.it_ops->free(&tbl);
> -		}
> =20
>  		table_group->ops->release_ownership(table_group);
>  	}

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--KdquIMZPjGJQvRdI
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVQdgtAAoJEGw4ysog2bOSe2gQAMMVk0a29sPatSi4tGk/C0/X
arEQEkq4EFuY7Uafzng6ZjtfxrP2+FDgFhTf2F5DGP3xr0FxG8kMOzeMAHCanjf/
zgWJeAdMMp0HY+wMUOuTOv9DPBlBC+J7x9ftbLDIAUK7UOU/saiIWQzFGo+RvwvK
aFR4XnrgNlpVcucewJAL6aH96hHa70U+W1gLEGdR/1wSjN1GtUFZ4hAuiKcKfSbn
OUa/dnBOGUJjCh+bcfTHuEDVP91cWF0BDj5BXGemaYFub+Osa2oDjP6caXu0lqWC
025L/QE5xxBxuLkuRD5QaTp4/wFyJPQiqKDA81pRu7wlNDp1y4AThFuzixX8arBS
qwybL34VCxa7b1UIDAH0V/tRf8jt5ft0zER80Hb1aLxFxBWQla8jcezcgWZOlcdu
pjR3InsJAsQOXtqVKYFYrp6jCVUasArme6UnE6s3F9tiuaFtCt68Km7jw6Y7/WKM
rAK4ccKf0MiGKdg0m/p6xWfC9V6y41ODiOYNdUevqYoZxFgNh8KEyxx/TPxG013m
DgnAoMP/KD3+8E10F8LR8fUTvlxgAUaIUmq2JxsnONnT+gAWiRYrs8LRjd/GspEI
nLNooRT7BVt6IKO4vGYesdB2CY2sq9pg7v9tLPhu0CtaqnvONTgYzS4ugdJtuHrR
Om5eyQRwdGWfFYdw5F5w
=Xk4U
-----END PGP SIGNATURE-----

--KdquIMZPjGJQvRdI--
