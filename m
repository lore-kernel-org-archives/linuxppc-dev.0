Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48E7E1A006B
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Jun 2015 14:31:18 +1000 (AEST)
Date: Tue, 2 Jun 2015 14:17:49 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH kernel v11 33/34] vfio: powerpc/spapr: Register memory
 and define IOMMU v2
Message-ID: <20150602041749.GF3186@voom.fritz.box>
References: <1432889098-22924-1-git-send-email-aik@ozlabs.ru>
 <1432889098-22924-34-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="iBwuxWUsK/REspAd"
In-Reply-To: <1432889098-22924-34-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--iBwuxWUsK/REspAd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2015 at 06:44:57PM +1000, Alexey Kardashevskiy wrote:
> The existing implementation accounts the whole DMA window in
> the locked_vm counter. This is going to be worse with multiple
> containers and huge DMA windows. Also, real-time accounting would requite
> additional tracking of accounted pages due to the page size difference -
> IOMMU uses 4K pages and system uses 4K or 64K pages.
>=20
> Another issue is that actual pages pinning/unpinning happens on every
> DMA map/unmap request. This does not affect the performance much now as
> we spend way too much time now on switching context between
> guest/userspace/host but this will start to matter when we add in-kernel
> DMA map/unmap acceleration.
>=20
> This introduces a new IOMMU type for SPAPR - VFIO_SPAPR_TCE_v2_IOMMU.
> New IOMMU deprecates VFIO_IOMMU_ENABLE/VFIO_IOMMU_DISABLE and introduces
> 2 new ioctls to register/unregister DMA memory -
> VFIO_IOMMU_SPAPR_REGISTER_MEMORY and VFIO_IOMMU_SPAPR_UNREGISTER_MEMORY -
> which receive user space address and size of a memory region which
> needs to be pinned/unpinned and counted in locked_vm.
> New IOMMU splits physical pages pinning and TCE table update
> into 2 different operations. It requires:
> 1) guest pages to be registered first
> 2) consequent map/unmap requests to work only with pre-registered memory.
> For the default single window case this means that the entire guest
> (instead of 2GB) needs to be pinned before using VFIO.
> When a huge DMA window is added, no additional pinning will be
> required, otherwise it would be guest RAM + 2GB.
>=20
> The new memory registration ioctls are not supported by
> VFIO_SPAPR_TCE_IOMMU. Dynamic DMA window and in-kernel acceleration
> will require memory to be preregistered in order to work.
>=20
> The accounting is done per the user process.
>=20
> This advertises v2 SPAPR TCE IOMMU and restricts what the userspace
> can do with v1 or v2 IOMMUs.
>=20
> In order to support memory pre-registration, we need a way to track
> the use of every registered memory region and only allow unregistration
> if a region is not in use anymore. So we need a way to tell from what
> region the just cleared TCE was from.
>=20
> This adds a userspace view of the TCE table into iommu_table struct.
> It contains userspace address, one per TCE entry. The table is only
> allocated when the ownership over an IOMMU group is taken which means
> it is only used from outside of the powernv code (such as VFIO).
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> [aw: for the vfio related changes]
> Acked-by: Alex Williamson <alex.williamson@redhat.com>
> ---
> Changes:
> v11:
> * mm_iommu_put() does not return a code so this does not check it
> * moved "v2" in tce_container to pack the struct
>=20
> v10:
> * moved it_userspace allocation to vfio_iommu_spapr_tce as it VFIO
> specific thing
> * squashed "powerpc/iommu: Add userspace view of TCE table" into this as
> it is
> a part of IOMMU v2
> * s/tce_iommu_use_page_v2/tce_iommu_prereg_ua_to_hpa/
> * fixed some function names to have "tce_iommu_" in the beginning rather
> just "tce_"
> * as mm_iommu_mapped_inc() can now fail, check for the return code
>=20
> v9:
> * s/tce_get_hva_cached/tce_iommu_use_page_v2/
>=20
> v7:
> * now memory is registered per mm (i.e. process)
> * moved memory registration code to powerpc/mmu
> * merged "vfio: powerpc/spapr: Define v2 IOMMU" into this
> * limited new ioctls to v2 IOMMU
> * updated doc
> * unsupported ioclts return -ENOTTY instead of -EPERM
>=20
> v6:
> * tce_get_hva_cached() returns hva via a pointer
>=20
> v4:
> * updated docs
> * s/kzmalloc/vzalloc/
> * in tce_pin_pages()/tce_unpin_pages() removed @vaddr, @size and
> replaced offset with index
> * renamed vfio_iommu_type_register_memory to vfio_iommu_spapr_register_me=
mory
> and removed duplicating vfio_iommu_spapr_register_memory
> ---
>  Documentation/vfio.txt              |  31 ++-
>  arch/powerpc/include/asm/iommu.h    |   6 +
>  drivers/vfio/vfio_iommu_spapr_tce.c | 512 ++++++++++++++++++++++++++++++=
------
>  include/uapi/linux/vfio.h           |  27 ++
>  4 files changed, 487 insertions(+), 89 deletions(-)
>=20
> diff --git a/Documentation/vfio.txt b/Documentation/vfio.txt
> index 96978ec..7dcf2b5 100644
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
> +Newer systems (POWER8 with IODA2) have improved hardware design which al=
lows
> +to remove this limitation and have multiple IOMMU groups per a VFIO cont=
ainer.
> =20
>  2) The hardware supports so called DMA windows - the PCI address range
>  within which DMA transfer is allowed, any attempt to access address space
> @@ -427,6 +429,29 @@ The code flow from the example above should be sligh=
tly changed:
> =20
>  	....
> =20
> +5) There is v2 of SPAPR TCE IOMMU. It deprecates VFIO_IOMMU_ENABLE/
> +VFIO_IOMMU_DISABLE and implements 2 new ioctls:
> +VFIO_IOMMU_SPAPR_REGISTER_MEMORY and VFIO_IOMMU_SPAPR_UNREGISTER_MEMORY
> +(which are unsupported in v1 IOMMU).
> +
> +PPC64 paravirtualized guests generate a lot of map/unmap requests,
> +and the handling of those includes pinning/unpinning pages and updating
> +mm::locked_vm counter to make sure we do not exceed the rlimit.
> +The v2 IOMMU splits accounting and pinning into separate operations:
> +
> +- VFIO_IOMMU_SPAPR_REGISTER_MEMORY/VFIO_IOMMU_SPAPR_UNREGISTER_MEMORY io=
ctls
> +receive a user space address and size of the block to be pinned.
> +Bisecting is not supported and VFIO_IOMMU_UNREGISTER_MEMORY is expected =
to
> +be called with the exact address and size used for registering
> +the memory block. The userspace is not expected to call these often.
> +The ranges are stored in a linked list in a VFIO container.
> +
> +- VFIO_IOMMU_MAP_DMA/VFIO_IOMMU_UNMAP_DMA ioctls only update the actual
> +IOMMU table and do not do pinning; instead these check that the userspace
> +address is from pre-registered range.
> +
> +This separation helps in optimizing DMA for guests.
> +
>  ------------------------------------------------------------------------=
-------
> =20
>  [1] VFIO was originally an acronym for "Virtual Function I/O" in its
> diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/=
iommu.h
> index 9d37492..f9957eb 100644
> --- a/arch/powerpc/include/asm/iommu.h
> +++ b/arch/powerpc/include/asm/iommu.h
> @@ -112,9 +112,15 @@ struct iommu_table {
>  	unsigned long *it_map;       /* A simple allocation bitmap for now */
>  	unsigned long  it_page_shift;/* table iommu page size */
>  	struct list_head it_group_list;/* List of iommu_table_group_link */
> +	unsigned long *it_userspace; /* userspace view of the table */
>  	struct iommu_table_ops *it_ops;
>  };
> =20
> +#define IOMMU_TABLE_USERSPACE_ENTRY(tbl, entry) \
> +		((tbl)->it_userspace ? \
> +			&((tbl)->it_userspace[(entry) - (tbl)->it_offset]) : \
> +			NULL)
> +
>  /* Pure 2^n version of get_order */
>  static inline __attribute_const__
>  int get_iommu_order(unsigned long size, struct iommu_table *tbl)
> diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iomm=
u_spapr_tce.c
> index 7a84110..cadd9f8 100644
> --- a/drivers/vfio/vfio_iommu_spapr_tce.c
> +++ b/drivers/vfio/vfio_iommu_spapr_tce.c
> @@ -19,8 +19,10 @@
>  #include <linux/uaccess.h>
>  #include <linux/err.h>
>  #include <linux/vfio.h>
> +#include <linux/vmalloc.h>
>  #include <asm/iommu.h>
>  #include <asm/tce.h>
> +#include <asm/mmu_context.h>
> =20
>  #define DRIVER_VERSION  "0.1"
>  #define DRIVER_AUTHOR   "aik@ozlabs.ru"
> @@ -81,6 +83,11 @@ static void decrement_locked_vm(long npages)
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
> @@ -88,11 +95,84 @@ static void decrement_locked_vm(long npages)
>   */
>  struct tce_container {
>  	struct mutex lock;
> -	struct iommu_group *grp;
>  	bool enabled;
> +	bool v2;
>  	unsigned long locked_pages;
> +	struct iommu_table *tables[IOMMU_TABLE_GROUP_MAX_TABLES];
> +	struct list_head group_list;
>  };
> =20
> +static long tce_iommu_unregister_pages(struct tce_container *container,
> +		__u64 vaddr, __u64 size)
> +{
> +	struct mm_iommu_table_group_mem_t *mem;
> +
> +	if ((vaddr & ~PAGE_MASK) || (size & ~PAGE_MASK))
> +		return -EINVAL;
> +
> +	mem =3D mm_iommu_lookup(vaddr, size >> PAGE_SHIFT);
> +	if (!mem)
> +		return -EINVAL;

Uh.. contrary to the commit message this doesn't enforce that the
unregister is called on the exact same vaddr and size as was
registered.  Instead a call to unregister will unregister the first
registered region that overlaps with the specified region.

Also, ENOENT might be a better error code for this case (couldn't find
a matching registered region) - EINVAL is rather overused.

> +
> +	return mm_iommu_put(mem);
> +}
> +
> +static long tce_iommu_register_pages(struct tce_container *container,
> +		__u64 vaddr, __u64 size)
> +{
> +	long ret =3D 0;
> +	struct mm_iommu_table_group_mem_t *mem =3D NULL;
> +	unsigned long entries =3D size >> PAGE_SHIFT;
> +
> +	if ((vaddr & ~PAGE_MASK) || (size & ~PAGE_MASK) ||
> +			((vaddr + size) < vaddr))
> +		return -EINVAL;
> +
> +	ret =3D mm_iommu_get(vaddr, entries, &mem);
> +	if (ret)
> +		return ret;
> +
> +	container->enabled =3D true;

I'm assuming that once any region is registered you can no longer add
or remove groups from the container?  That's fine but it might want a
more prominent notice in the docs.

> +
> +	return 0;
> +}
> +
> +static long tce_iommu_userspace_view_alloc(struct iommu_table *tbl)
> +{
> +	unsigned long cb =3D _ALIGN_UP(sizeof(tbl->it_userspace[0]) *
> +			tbl->it_size, PAGE_SIZE);
> +	unsigned long *uas;
> +	long ret;
> +
> +	BUG_ON(tbl->it_userspace);
> +
> +	ret =3D try_increment_locked_vm(cb >> PAGE_SHIFT);
> +	if (ret)
> +		return ret;
> +
> +	uas =3D vzalloc(cb);
> +	if (!uas) {
> +		decrement_locked_vm(cb >> PAGE_SHIFT);
> +		return -ENOMEM;
> +	}
> +	tbl->it_userspace =3D uas;
> +
> +	return 0;
> +}
> +
> +static void tce_iommu_userspace_view_free(struct iommu_table *tbl)
> +{
> +	unsigned long cb =3D _ALIGN_UP(sizeof(tbl->it_userspace[0]) *
> +			tbl->it_size, PAGE_SIZE);
> +
> +	if (!tbl->it_userspace)
> +		return;
> +
> +	vfree(tbl->it_userspace);
> +	tbl->it_userspace =3D NULL;
> +	decrement_locked_vm(cb >> PAGE_SHIFT);
> +}
> +
>  static bool tce_page_is_contained(struct page *page, unsigned page_shift)
>  {
>  	/*
> @@ -103,18 +183,18 @@ static bool tce_page_is_contained(struct page *page=
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
>  static long tce_iommu_find_table(struct tce_container *container,
>  		phys_addr_t ioba, struct iommu_table **ptbl)
>  {
>  	long i;
> -	struct iommu_table_group *table_group;
> -
> -	table_group =3D iommu_group_get_iommudata(container->grp);
> -	if (!table_group)
> -		return -1;
> =20
>  	for (i =3D 0; i < IOMMU_TABLE_GROUP_MAX_TABLES; ++i) {
> -		struct iommu_table *tbl =3D table_group->tables[i];
> +		struct iommu_table *tbl =3D container->tables[i];
> =20
>  		if (tbl) {
>  			unsigned long entry =3D ioba >> tbl->it_page_shift;
> @@ -136,9 +216,7 @@ static int tce_iommu_enable(struct tce_container *con=
tainer)
>  	int ret =3D 0;
>  	unsigned long locked;
>  	struct iommu_table_group *table_group;
> -
> -	if (!container->grp)
> -		return -ENXIO;
> +	struct tce_iommu_group *tcegrp;
>  	if (!current->mm)
>  		return -ESRCH; /* process exited */
> @@ -175,7 +253,12 @@ static int tce_iommu_enable(struct tce_container *co=
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
> @@ -211,7 +294,7 @@ static void *tce_iommu_open(unsigned long arg)
>  {
>  	struct tce_container *container;
> =20
> -	if (arg !=3D VFIO_SPAPR_TCE_IOMMU) {
> +	if ((arg !=3D VFIO_SPAPR_TCE_IOMMU) && (arg !=3D VFIO_SPAPR_TCE_v2_IOMM=
U)) {
>  		pr_err("tce_vfio: Wrong IOMMU type\n");
>  		return ERR_PTR(-EINVAL);
>  	}
> @@ -221,18 +304,45 @@ static void *tce_iommu_open(unsigned long arg)
>  		return ERR_PTR(-ENOMEM);
> =20
>  	mutex_init(&container->lock);
> +	INIT_LIST_HEAD_RCU(&container->group_list);
> +
> +	container->v2 =3D arg =3D=3D VFIO_SPAPR_TCE_v2_IOMMU;
> =20
>  	return container;
>  }
> =20
> +static int tce_iommu_clear(struct tce_container *container,
> +		struct iommu_table *tbl,
> +		unsigned long entry, unsigned long pages);
> +static void tce_iommu_free_table(struct iommu_table *tbl);
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
> +		struct iommu_table *tbl =3D container->tables[i];
> +
> +		if (!tbl)
> +			continue;
> +
> +		tce_iommu_clear(container, tbl, tbl->it_offset, tbl->it_size);
> +		tce_iommu_free_table(tbl);
> +	}
> =20
>  	tce_iommu_disable(container);
>  	mutex_destroy(&container->lock);
> @@ -249,6 +359,47 @@ static void tce_iommu_unuse_page(struct tce_containe=
r *container,
>  	put_page(page);
>  }
> =20
> +static int tce_iommu_prereg_ua_to_hpa(unsigned long tce, unsigned long s=
ize,
> +		unsigned long *phpa, struct mm_iommu_table_group_mem_t **pmem)
> +{
> +	long ret =3D 0;
> +	struct mm_iommu_table_group_mem_t *mem;
> +
> +	mem =3D mm_iommu_lookup(tce, size);
> +	if (!mem)
> +		return -EINVAL;
> +
> +	ret =3D mm_iommu_ua_to_hpa(mem, tce, phpa);
> +	if (ret)
> +		return -EINVAL;
> +
> +	*pmem =3D mem;
> +
> +	return 0;
> +}
> +
> +static void tce_iommu_unuse_page_v2(struct iommu_table *tbl,
> +		unsigned long entry)
> +{
> +	struct mm_iommu_table_group_mem_t *mem =3D NULL;
> +	int ret;
> +	unsigned long hpa =3D 0;
> +	unsigned long *pua =3D IOMMU_TABLE_USERSPACE_ENTRY(tbl, entry);
> +
> +	if (!pua || !current || !current->mm)
> +		return;
> +
> +	ret =3D tce_iommu_prereg_ua_to_hpa(*pua, IOMMU_PAGE_SIZE(tbl),
> +			&hpa, &mem);
> +	if (ret)
> +		pr_debug("%s: tce %lx at #%lx was not cached, ret=3D%d\n",
> +				__func__, *pua, entry, ret);
> +	if (mem)
> +		mm_iommu_mapped_dec(mem);
> +
> +	*pua =3D 0;
> +}
> +
>  static int tce_iommu_clear(struct tce_container *container,
>  		struct iommu_table *tbl,
>  		unsigned long entry, unsigned long pages)
> @@ -267,6 +418,11 @@ static int tce_iommu_clear(struct tce_container *con=
tainer,
>  		if (direction =3D=3D DMA_NONE)
>  			continue;
> =20
> +		if (container->v2) {
> +			tce_iommu_unuse_page_v2(tbl, entry);
> +			continue;
> +		}
> +
>  		tce_iommu_unuse_page(container, oldhpa);
>  	}
> =20
> @@ -333,6 +489,64 @@ static long tce_iommu_build(struct tce_container *co=
ntainer,
>  	return ret;
>  }
> =20
> +static long tce_iommu_build_v2(struct tce_container *container,
> +		struct iommu_table *tbl,
> +		unsigned long entry, unsigned long tce, unsigned long pages,
> +		enum dma_data_direction direction)
> +{
> +	long i, ret =3D 0;
> +	struct page *page;
> +	unsigned long hpa;
> +	enum dma_data_direction dirtmp;
> +
> +	for (i =3D 0; i < pages; ++i) {
> +		struct mm_iommu_table_group_mem_t *mem =3D NULL;
> +		unsigned long *pua =3D IOMMU_TABLE_USERSPACE_ENTRY(tbl,
> +				entry + i);
> +
> +		ret =3D tce_iommu_prereg_ua_to_hpa(tce, IOMMU_PAGE_SIZE(tbl),
> +				&hpa, &mem);
> +		if (ret)
> +			break;
> +
> +		page =3D pfn_to_page(hpa >> PAGE_SHIFT);
> +		if (!tce_page_is_contained(page, tbl->it_page_shift)) {
> +			ret =3D -EPERM;
> +			break;
> +		}
> +
> +		/* Preserve offset within IOMMU page */
> +		hpa |=3D tce & IOMMU_PAGE_MASK(tbl) & ~PAGE_MASK;
> +		dirtmp =3D direction;
> +
> +		/* The registered region is being unregistered */
> +		if (mm_iommu_mapped_inc(mem))
> +			break;
> +
> +		ret =3D iommu_tce_xchg(tbl, entry + i, &hpa, &dirtmp);
> +		if (ret) {
> +			/* dirtmp cannot be DMA_NONE here */
> +			tce_iommu_unuse_page_v2(tbl, entry + i);
> +			pr_err("iommu_tce: %s failed ioba=3D%lx, tce=3D%lx, ret=3D%ld\n",
> +					__func__, entry << tbl->it_page_shift,
> +					tce, ret);
> +			break;
> +		}
> +
> +		if (dirtmp !=3D DMA_NONE)
> +			tce_iommu_unuse_page_v2(tbl, entry + i);
> +
> +		*pua =3D tce;
> +
> +		tce +=3D IOMMU_PAGE_SIZE(tbl);
> +	}
> +
> +	if (ret)
> +		tce_iommu_clear(container, tbl, entry, i);
> +
> +	return ret;
> +}
> +
>  static long tce_iommu_create_table(struct tce_container *container,
>  			struct iommu_table_group *table_group,
>  			int num,
> @@ -358,6 +572,12 @@ static long tce_iommu_create_table(struct tce_contai=
ner *container,
>  	WARN_ON(!ret && !(*ptbl)->it_ops->free);
>  	WARN_ON(!ret && ((*ptbl)->it_allocated_size !=3D table_size));
> =20
> +	if (!ret && container->v2) {
> +		ret =3D tce_iommu_userspace_view_alloc(*ptbl);
> +		if (ret)
> +			(*ptbl)->it_ops->free(*ptbl);
> +	}
> +
>  	if (ret)
>  		decrement_locked_vm(table_size >> PAGE_SHIFT);
> =20
> @@ -368,6 +588,7 @@ static void tce_iommu_free_table(struct iommu_table *=
tbl)
>  {
>  	unsigned long pages =3D tbl->it_allocated_size >> PAGE_SHIFT;
> =20
> +	tce_iommu_userspace_view_free(tbl);
>  	tbl->it_ops->free(tbl);
>  	decrement_locked_vm(pages);
>  }
> @@ -383,6 +604,7 @@ static long tce_iommu_ioctl(void *iommu_data,
>  	case VFIO_CHECK_EXTENSION:
>  		switch (arg) {
>  		case VFIO_SPAPR_TCE_IOMMU:
> +		case VFIO_SPAPR_TCE_v2_IOMMU:
>  			ret =3D 1;
>  			break;
>  		default:
> @@ -394,12 +616,15 @@ static long tce_iommu_ioctl(void *iommu_data,
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
> @@ -468,11 +693,18 @@ static long tce_iommu_ioctl(void *iommu_data,
>  		if (ret)
>  			return ret;
> =20
> -		ret =3D tce_iommu_build(container, tbl,
> -				param.iova >> tbl->it_page_shift,
> -				param.vaddr,
> -				param.size >> tbl->it_page_shift,
> -				direction);
> +		if (container->v2)
> +			ret =3D tce_iommu_build_v2(container, tbl,
> +					param.iova >> tbl->it_page_shift,
> +					param.vaddr,
> +					param.size >> tbl->it_page_shift,
> +					direction);
> +		else
> +			ret =3D tce_iommu_build(container, tbl,
> +					param.iova >> tbl->it_page_shift,
> +					param.vaddr,
> +					param.size >> tbl->it_page_shift,
> +					direction);
> =20
>  		iommu_flush_tce(tbl);
> =20
> @@ -518,7 +750,61 @@ static long tce_iommu_ioctl(void *iommu_data,
> =20
>  		return ret;
>  	}
> +	case VFIO_IOMMU_SPAPR_REGISTER_MEMORY: {
> +		struct vfio_iommu_spapr_register_memory param;
> +
> +		if (!container->v2)
> +			break;
> +
> +		minsz =3D offsetofend(struct vfio_iommu_spapr_register_memory,
> +				size);
> +
> +		if (copy_from_user(&param, (void __user *)arg, minsz))
> +			return -EFAULT;
> +
> +		if (param.argsz < minsz)
> +			return -EINVAL;
> +
> +		/* No flag is supported now */
> +		if (param.flags)
> +			return -EINVAL;
> +
> +		mutex_lock(&container->lock);
> +		ret =3D tce_iommu_register_pages(container, param.vaddr,
> +				param.size);
> +		mutex_unlock(&container->lock);
> +
> +		return ret;
> +	}
> +	case VFIO_IOMMU_SPAPR_UNREGISTER_MEMORY: {
> +		struct vfio_iommu_spapr_register_memory param;
> +
> +		if (!container->v2)
> +			break;
> +
> +		minsz =3D offsetofend(struct vfio_iommu_spapr_register_memory,
> +				size);
> +
> +		if (copy_from_user(&param, (void __user *)arg, minsz))
> +			return -EFAULT;
> +
> +		if (param.argsz < minsz)
> +			return -EINVAL;
> +
> +		/* No flag is supported now */
> +		if (param.flags)
> +			return -EINVAL;
> +
> +		mutex_lock(&container->lock);
> +		ret =3D tce_iommu_unregister_pages(container, param.vaddr, param.size);
> +		mutex_unlock(&container->lock);
> +
> +		return ret;
> +	}
>  	case VFIO_IOMMU_ENABLE:
> +		if (container->v2)
> +			break;
> +
>  		mutex_lock(&container->lock);
>  		ret =3D tce_iommu_enable(container);
>  		mutex_unlock(&container->lock);
> @@ -526,16 +812,27 @@ static long tce_iommu_ioctl(void *iommu_data,
> =20
> =20
>  	case VFIO_IOMMU_DISABLE:
> +		if (container->v2)
> +			break;
> +
>  		mutex_lock(&container->lock);
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
> +		}
> +		return ret;
> +	}
> +
>  	}
> =20
>  	return -ENOTTY;
> @@ -547,14 +844,17 @@ static void tce_iommu_release_ownership(struct tce_=
container *container,
>  	int i;
> =20
>  	for (i =3D 0; i < IOMMU_TABLE_GROUP_MAX_TABLES; ++i) {
> -		struct iommu_table *tbl =3D table_group->tables[i];
> +		struct iommu_table *tbl =3D container->tables[i];
> =20
>  		if (!tbl)
>  			continue;
> =20
>  		tce_iommu_clear(container, tbl, tbl->it_offset, tbl->it_size);
> +		tce_iommu_userspace_view_free(tbl);
>  		if (tbl->it_map)
>  			iommu_release_ownership(tbl);
> +
> +		container->tables[i] =3D NULL;
>  	}
>  }
> =20
> @@ -569,7 +869,10 @@ static int tce_iommu_take_ownership(struct tce_conta=
iner *container,
>  		if (!tbl || !tbl->it_map)
>  			continue;
> =20
> -		rc =3D iommu_take_ownership(tbl);
> +		rc =3D tce_iommu_userspace_view_alloc(tbl);
> +		if (!rc)
> +			rc =3D iommu_take_ownership(tbl);
> +
>  		if (rc) {
>  			for (j =3D 0; j < i; ++j)
>  				iommu_release_ownership(
> @@ -579,6 +882,9 @@ static int tce_iommu_take_ownership(struct tce_contai=
ner *container,
>  		}
>  	}
> =20
> +	for (i =3D 0; i < IOMMU_TABLE_GROUP_MAX_TABLES; ++i)
> +		container->tables[i] =3D table_group->tables[i];
> +
>  	return 0;
>  }
> =20
> @@ -592,18 +898,8 @@ static void tce_iommu_release_ownership_ddw(struct t=
ce_container *container,
>  		return;
>  	}
> =20
> -	for (i =3D 0; i < IOMMU_TABLE_GROUP_MAX_TABLES; ++i) {
> -		/* Store table pointer as unset_window resets it */
> -		struct iommu_table *tbl =3D table_group->tables[i];
> -
> -		if (!tbl)
> -			continue;
> -
> +	for (i =3D 0; i < IOMMU_TABLE_GROUP_MAX_TABLES; ++i)
>  		table_group->ops->unset_window(table_group, i);
> -		tce_iommu_clear(container, tbl,
> -				tbl->it_offset, tbl->it_size);
> -		tce_iommu_free_table(tbl);
> -	}
> =20
>  	table_group->ops->release_ownership(table_group);
>  }
> @@ -611,7 +907,7 @@ static void tce_iommu_release_ownership_ddw(struct tc=
e_container *container,
>  static long tce_iommu_take_ownership_ddw(struct tce_container *container,
>  		struct iommu_table_group *table_group)
>  {
> -	long ret;
> +	long i, ret =3D 0;
>  	struct iommu_table *tbl =3D NULL;
> =20
>  	if (!table_group->ops->create_table || !table_group->ops->set_window ||
> @@ -622,23 +918,45 @@ static long tce_iommu_take_ownership_ddw(struct tce=
_container *container,
> =20
>  	table_group->ops->take_ownership(table_group);
> =20
> -	ret =3D tce_iommu_create_table(container,
> -			table_group,
> -			0, /* window number */
> -			IOMMU_PAGE_SHIFT_4K,
> -			table_group->tce32_size,
> -			1, /* default levels */
> -			&tbl);
> -	if (!ret) {
> -		ret =3D table_group->ops->set_window(table_group, 0, tbl);
> +	/*
> +	 * If it the first group attached, check if there is
> +	 * a default DMA window and create one if none as
> +	 * the userspace expects it to exist.

You could choose not to create the 32-bit DMA window by default for v2
containers.  But I don't know if that would actually simplify anything.

> +	 */
> +	if (!tce_groups_attached(container) && !container->tables[0]) {
> +		ret =3D tce_iommu_create_table(container,
> +				table_group,
> +				0, /* window number */
> +				IOMMU_PAGE_SHIFT_4K,
> +				table_group->tce32_size,
> +				1, /* default levels */
> +				&tbl);
>  		if (ret)
> -			tce_iommu_free_table(tbl);
> +			goto release_exit;
>  		else
> -			table_group->tables[0] =3D tbl;
> +			container->tables[0] =3D tbl;
>  	}
> =20
> -	if (ret)
> -		table_group->ops->release_ownership(table_group);
> +	/* Set all windows to the new group */
> +	for (i =3D 0; i < IOMMU_TABLE_GROUP_MAX_TABLES; ++i) {
> +		tbl =3D container->tables[i];
> +
> +		if (!tbl)
> +			continue;
> +
> +		/* Set the default window to a new group */
> +		ret =3D table_group->ops->set_window(table_group, i, tbl);
> +		if (ret)
> +			goto release_exit;
> +	}
> +
> +	return 0;
> +
> +release_exit:
> +	for (i =3D 0; i < IOMMU_TABLE_GROUP_MAX_TABLES; ++i)
> +		table_group->ops->unset_window(table_group, i);
> +
> +	table_group->ops->release_ownership(table_group);
> =20
>  	return ret;
>  }
> @@ -649,29 +967,44 @@ static int tce_iommu_attach_group(void *iommu_data,
>  	int ret;
>  	struct tce_container *container =3D iommu_data;
>  	struct iommu_table_group *table_group;
> +	struct tce_iommu_group *tcegrp =3D NULL;
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
> +	if (tce_groups_attached(container) && (!table_group->ops ||
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
> @@ -681,10 +1014,15 @@ static int tce_iommu_attach_group(void *iommu_data,
>  	else
>  		ret =3D tce_iommu_take_ownership_ddw(container, table_group);
> =20
> -	if (!ret)
> -		container->grp =3D iommu_group;
> +	if (!ret) {
> +		tcegrp->grp =3D iommu_group;
> +		list_add(&tcegrp->next, &container->group_list);
> +	}
> =20
>  unlock_exit:
> +	if (ret && tcegrp)
> +		kfree(tcegrp);
> +
>  	mutex_unlock(&container->lock);
> =20
>  	return ret;
> @@ -695,24 +1033,26 @@ static void tce_iommu_detach_group(void *iommu_dat=
a,
>  {
>  	struct tce_container *container =3D iommu_data;
>  	struct iommu_table_group *table_group;
> +	bool found =3D false;
> +	struct tce_iommu_group *tcegrp;
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
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index b57b750..8fdcfb9 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -36,6 +36,8 @@
>  /* Two-stage IOMMU */
>  #define VFIO_TYPE1_NESTING_IOMMU	6	/* Implies v2 */
> =20
> +#define VFIO_SPAPR_TCE_v2_IOMMU		7
> +
>  /*
>   * The IOCTL interface is designed for extensibility by embedding the
>   * structure length (argsz) and flags into structures passed between
> @@ -495,6 +497,31 @@ struct vfio_eeh_pe_op {
> =20
>  #define VFIO_EEH_PE_OP			_IO(VFIO_TYPE, VFIO_BASE + 21)
> =20
> +/**
> + * VFIO_IOMMU_SPAPR_REGISTER_MEMORY - _IOW(VFIO_TYPE, VFIO_BASE + 17, st=
ruct vfio_iommu_spapr_register_memory)
> + *
> + * Registers user space memory where DMA is allowed. It pins
> + * user pages and does the locked memory accounting so
> + * subsequent VFIO_IOMMU_MAP_DMA/VFIO_IOMMU_UNMAP_DMA calls
> + * get faster.
> + */
> +struct vfio_iommu_spapr_register_memory {
> +	__u32	argsz;
> +	__u32	flags;
> +	__u64	vaddr;				/* Process virtual address */
> +	__u64	size;				/* Size of mapping (bytes) */
> +};
> +#define VFIO_IOMMU_SPAPR_REGISTER_MEMORY	_IO(VFIO_TYPE, VFIO_BASE + 17)
> +
> +/**
> + * VFIO_IOMMU_SPAPR_UNREGISTER_MEMORY - _IOW(VFIO_TYPE, VFIO_BASE + 18, =
struct vfio_iommu_spapr_register_memory)
> + *
> + * Unregisters user space memory registered with
> + * VFIO_IOMMU_SPAPR_REGISTER_MEMORY.
> + * Uses vfio_iommu_spapr_register_memory for parameters.
> + */
> +#define VFIO_IOMMU_SPAPR_UNREGISTER_MEMORY	_IO(VFIO_TYPE, VFIO_BASE + 18)
> +
>  /* ***************************************************************** */
> =20
>  #endif /* _UAPIVFIO_H */

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--iBwuxWUsK/REspAd
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVbS5sAAoJEGw4ysog2bOSSjMP/27t1LAvkvB2C+BSbNKYBNUp
MeYFwVStVOwWoV73LqyiqMnGBuDVQuAc+GuruOCnDdecwlyPrHrZ1Kzbi9B1yjfz
GwRYgr9/RKqmYEiEt6bivgtbx/ug1qy1biNHnvaEwXFq78lJPqxWifC7TxEN9OpI
PNiVcMM8QGC/OaeBF4mfiyMgM8ll9f1MjvOzLQVSHBfaAwZP0UYuantSJBgsKFIQ
Ltm4JbiiHBYaQNMPXS4VW6/ZFMGM7SuxbNdWCalbtl1g4kXZzAD8eqhx5xNaj6Cl
2z1QfFA5s5BLCq4dIapwgneaHn/l/PJv1CRnzg+P9LUy1Bvhj1VK0St34kmApkSb
1jAdI/FvSEDSRFsXchK1m02q4GVQ339tD0Al6hu9u5ap6daaecxOkR5sFMgqDHWb
GWZOqK01q79haTGlKZMtmP+H08Dc5VO0qetEqcnsy/b/tuvD8Xe6C8vstTcGa8lu
vVh1RV608n4u1BESfKdbNuzXNerWOnuNRPlQyVcd7d4j7yI/CYNkpoPAXRj3XlmX
X+oD7au0LirZh3Da293FpvRc+vil6Sm6IecUQ/fRn1cxoRbWSm8CJuo4qY7hrG8h
HJ0xA0Wj49rsZmSzyKFl2Sf80RaIcSfhX4Cpaxze5usqMTg10Yt3B13xkDTLb8py
znlkX1mi09emFIWMaYwJ
=QGra
-----END PGP SIGNATURE-----

--iBwuxWUsK/REspAd--
