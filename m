Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6624F1A0201
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Apr 2015 15:50:04 +1000 (AEST)
Date: Wed, 29 Apr 2015 14:18:08 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel v9 18/32] powerpc/iommu/powernv: Release replaced
 TCE
Message-ID: <20150429041808.GO32589@voom.redhat.com>
References: <1429964096-11524-1-git-send-email-aik@ozlabs.ru>
 <1429964096-11524-19-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="KM+e2hnYAO+MCJ5e"
In-Reply-To: <1429964096-11524-19-git-send-email-aik@ozlabs.ru>
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


--KM+e2hnYAO+MCJ5e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 25, 2015 at 10:14:42PM +1000, Alexey Kardashevskiy wrote:
> At the moment writing new TCE value to the IOMMU table fails with EBUSY
> if there is a valid entry already. However PAPR specification allows
> the guest to write new TCE value without clearing it first.
>=20
> Another problem this patch is addressing is the use of pool locks for
> external IOMMU users such as VFIO. The pool locks are to protect
> DMA page allocator rather than entries and since the host kernel does
> not control what pages are in use, there is no point in pool locks and
> exchange()+put_page(oldtce) is sufficient to avoid possible races.
>=20
> This adds an exchange() callback to iommu_table_ops which does the same
> thing as set() plus it returns replaced TCE and DMA direction so
> the caller can release the pages afterwards. The exchange() receives
> a physical address unlike set() which receives linear mapping address;
> and returns a physical address as the clear() does.
>=20
> This implements exchange() for P5IOC2/IODA/IODA2. This adds a requirement
> for a platform to have exchange() implemented in order to support VFIO.
>=20
> This replaces iommu_tce_build() and iommu_clear_tce() with
> a single iommu_tce_xchg().
>=20
> This makes sure that TCE permission bits are not set in TCE passed to
> IOMMU API as those are to be calculated by platform code from DMA directi=
on.
>=20
> This moves SetPageDirty() to the IOMMU code to make it work for both
> VFIO ioctl interface in in-kernel TCE acceleration (when it becomes
> available later).
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> [aw: for the vfio related changes]
> Acked-by: Alex Williamson <alex.williamson@redhat.com>

This looks mostly good, but there are couple of details that need fixing.

> ---
> Changes:
> v9:
> * changed exchange() to work with physical addresses as these addresses
> are never accessed by the code and physical addresses are actual values
> we put into the IOMMU table
> ---
>  arch/powerpc/include/asm/iommu.h            | 22 +++++++++--
>  arch/powerpc/kernel/iommu.c                 | 57 +++++++++--------------=
-----
>  arch/powerpc/platforms/powernv/pci-ioda.c   | 34 +++++++++++++++++
>  arch/powerpc/platforms/powernv/pci-p5ioc2.c |  3 ++
>  arch/powerpc/platforms/powernv/pci.c        | 17 +++++++++
>  arch/powerpc/platforms/powernv/pci.h        |  2 +
>  drivers/vfio/vfio_iommu_spapr_tce.c         | 58 ++++++++++++++++++-----=
------
>  7 files changed, 128 insertions(+), 65 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/=
iommu.h
> index e63419e..7e7ca0a 100644
> --- a/arch/powerpc/include/asm/iommu.h
> +++ b/arch/powerpc/include/asm/iommu.h
> @@ -45,13 +45,29 @@ extern int iommu_is_off;
>  extern int iommu_force_on;
> =20
>  struct iommu_table_ops {
> +	/*
> +	 * When called with direction=3D=3DDMA_NONE, it is equal to clear().
> +	 * uaddr is a linear map address.
> +	 */
>  	int (*set)(struct iommu_table *tbl,
>  			long index, long npages,
>  			unsigned long uaddr,
>  			enum dma_data_direction direction,
>  			struct dma_attrs *attrs);
> +#ifdef CONFIG_IOMMU_API
> +	/*
> +	 * Exchanges existing TCE with new TCE plus direction bits;
> +	 * returns old TCE and DMA direction mask.
> +	 * @tce is a physical address.
> +	 */
> +	int (*exchange)(struct iommu_table *tbl,
> +			long index,
> +			unsigned long *tce,

I'd prefer to call this "address" or "paddr" or something, since it's
not a full TCE entry (which would contain permission bits).

> +			enum dma_data_direction *direction);
> +#endif
>  	void (*clear)(struct iommu_table *tbl,
>  			long index, long npages);
> +	/* get() returns a physical address */
>  	unsigned long (*get)(struct iommu_table *tbl, long index);
>  	void (*flush)(struct iommu_table *tbl);
>  };
> @@ -152,6 +168,8 @@ extern void iommu_register_group(struct iommu_table_g=
roup *table_group,
>  extern int iommu_add_device(struct device *dev);
>  extern void iommu_del_device(struct device *dev);
>  extern int __init tce_iommu_bus_notifier_init(void);
> +extern long iommu_tce_xchg(struct iommu_table *tbl, unsigned long entry,
> +		unsigned long *tce, enum dma_data_direction *direction);
>  #else
>  static inline void iommu_register_group(struct iommu_table_group *table_=
group,
>  					int pci_domain_number,
> @@ -231,10 +249,6 @@ extern int iommu_tce_clear_param_check(struct iommu_=
table *tbl,
>  		unsigned long npages);
>  extern int iommu_tce_put_param_check(struct iommu_table *tbl,
>  		unsigned long ioba, unsigned long tce);
> -extern int iommu_tce_build(struct iommu_table *tbl, unsigned long entry,
> -		unsigned long hwaddr, enum dma_data_direction direction);
> -extern unsigned long iommu_clear_tce(struct iommu_table *tbl,
> -		unsigned long entry);
> =20
>  extern void iommu_flush_tce(struct iommu_table *tbl);
>  extern int iommu_take_ownership(struct iommu_table *tbl);
> diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
> index ea2c8ba..2eaba0c 100644
> --- a/arch/powerpc/kernel/iommu.c
> +++ b/arch/powerpc/kernel/iommu.c
> @@ -975,9 +975,6 @@ EXPORT_SYMBOL_GPL(iommu_tce_clear_param_check);
>  int iommu_tce_put_param_check(struct iommu_table *tbl,
>  		unsigned long ioba, unsigned long tce)
>  {
> -	if (!(tce & (TCE_PCI_WRITE | TCE_PCI_READ)))
> -		return -EINVAL;
> -
>  	if (tce & ~(IOMMU_PAGE_MASK(tbl) | TCE_PCI_WRITE | TCE_PCI_READ))
>  		return -EINVAL;

Since the value you're passing is now an address rather than a full
TCE, can't you remove the permission bits from this check, rather than
checking that elsewhere?

> @@ -995,44 +992,16 @@ int iommu_tce_put_param_check(struct iommu_table *t=
bl,
>  }
>  EXPORT_SYMBOL_GPL(iommu_tce_put_param_check);
> =20
> -unsigned long iommu_clear_tce(struct iommu_table *tbl, unsigned long ent=
ry)
> +long iommu_tce_xchg(struct iommu_table *tbl, unsigned long entry,
> +		unsigned long *tce, enum dma_data_direction *direction)
>  {
> -	unsigned long oldtce;
> -	struct iommu_pool *pool =3D get_pool(tbl, entry);
> +	long ret;
> =20
> -	spin_lock(&(pool->lock));
> +	ret =3D tbl->it_ops->exchange(tbl, entry, tce, direction);
> =20
> -	oldtce =3D tbl->it_ops->get(tbl, entry);
> -	if (oldtce & (TCE_PCI_WRITE | TCE_PCI_READ))
> -		tbl->it_ops->clear(tbl, entry, 1);
> -	else
> -		oldtce =3D 0;
> -
> -	spin_unlock(&(pool->lock));
> -
> -	return oldtce;
> -}
> -EXPORT_SYMBOL_GPL(iommu_clear_tce);
> -
> -/*
> - * hwaddr is a kernel virtual address here (0xc... bazillion),
> - * tce_build converts it to a physical address.
> - */
> -int iommu_tce_build(struct iommu_table *tbl, unsigned long entry,
> -		unsigned long hwaddr, enum dma_data_direction direction)
> -{
> -	int ret =3D -EBUSY;
> -	unsigned long oldtce;
> -	struct iommu_pool *pool =3D get_pool(tbl, entry);
> -
> -	spin_lock(&(pool->lock));
> -
> -	oldtce =3D tbl->it_ops->get(tbl, entry);
> -	/* Add new entry if it is not busy */
> -	if (!(oldtce & (TCE_PCI_WRITE | TCE_PCI_READ)))
> -		ret =3D tbl->it_ops->set(tbl, entry, 1, hwaddr, direction, NULL);
> -
> -	spin_unlock(&(pool->lock));
> +	if (!ret && ((*direction =3D=3D DMA_FROM_DEVICE) ||
> +			(*direction =3D=3D DMA_BIDIRECTIONAL)))
> +		SetPageDirty(pfn_to_page(*tce >> PAGE_SHIFT));
> =20
>  	/* if (unlikely(ret))
>  		pr_err("iommu_tce: %s failed on hwaddr=3D%lx ioba=3D%lx kva=3D%lx ret=
=3D%d\n",
> @@ -1041,13 +1010,23 @@ int iommu_tce_build(struct iommu_table *tbl, unsi=
gned long entry,
> =20
>  	return ret;
>  }
> -EXPORT_SYMBOL_GPL(iommu_tce_build);
> +EXPORT_SYMBOL_GPL(iommu_tce_xchg);
> =20
>  int iommu_take_ownership(struct iommu_table *tbl)
>  {
>  	unsigned long flags, i, sz =3D (tbl->it_size + 7) >> 3;
>  	int ret =3D 0;
> =20
> +	/*
> +	 * VFIO does not control TCE entries allocation and the guest
> +	 * can write new TCEs on top of existing ones so iommu_tce_build()
> +	 * must be able to release old pages. This functionality
> +	 * requires exchange() callback defined so if it is not
> +	 * implemented, we disallow taking ownership over the table.
> +	 */
> +	if (!tbl->it_ops->exchange)
> +		return -EINVAL;
> +
>  	spin_lock_irqsave(&tbl->large_pool.lock, flags);
>  	for (i =3D 0; i < tbl->nr_pools; i++)
>  		spin_lock(&tbl->pools[i].lock);
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/pla=
tforms/powernv/pci-ioda.c
> index b22b3ca..fb765af 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -1728,6 +1728,20 @@ static int pnv_ioda1_tce_build(struct iommu_table =
*tbl, long index,
>  	return ret;
>  }
> =20
> +#ifdef CONFIG_IOMMU_API
> +static int pnv_ioda1_tce_xchg(struct iommu_table *tbl, long index,
> +		unsigned long *tce, enum dma_data_direction *direction)
> +{
> +	long ret =3D pnv_tce_xchg(tbl, index, tce, direction);
> +
> +	if (!ret && (tbl->it_type &
> +			(TCE_PCI_SWINV_CREATE | TCE_PCI_SWINV_FREE)))
> +		pnv_pci_ioda1_tce_invalidate(tbl, index, 1, false);
> +
> +	return ret;
> +}
> +#endif
> +
>  static void pnv_ioda1_tce_free(struct iommu_table *tbl, long index,
>  		long npages)
>  {
> @@ -1739,6 +1753,9 @@ static void pnv_ioda1_tce_free(struct iommu_table *=
tbl, long index,
> =20
>  static struct iommu_table_ops pnv_ioda1_iommu_ops =3D {
>  	.set =3D pnv_ioda1_tce_build,
> +#ifdef CONFIG_IOMMU_API
> +	.exchange =3D pnv_ioda1_tce_xchg,
> +#endif
>  	.clear =3D pnv_ioda1_tce_free,
>  	.get =3D pnv_tce_get,
>  };
> @@ -1800,6 +1817,20 @@ static int pnv_ioda2_tce_build(struct iommu_table =
*tbl, long index,
>  	return ret;
>  }
> =20
> +#ifdef CONFIG_IOMMU_API
> +static int pnv_ioda2_tce_xchg(struct iommu_table *tbl, long index,
> +		unsigned long *tce, enum dma_data_direction *direction)
> +{
> +	long ret =3D pnv_tce_xchg(tbl, index, tce, direction);
> +
> +	if (!ret && (tbl->it_type &
> +			(TCE_PCI_SWINV_CREATE | TCE_PCI_SWINV_FREE)))
> +		pnv_pci_ioda2_tce_invalidate(tbl, index, 1, false);
> +
> +	return ret;
> +}
> +#endif
> +
>  static void pnv_ioda2_tce_free(struct iommu_table *tbl, long index,
>  		long npages)
>  {
> @@ -1811,6 +1842,9 @@ static void pnv_ioda2_tce_free(struct iommu_table *=
tbl, long index,
> =20
>  static struct iommu_table_ops pnv_ioda2_iommu_ops =3D {
>  	.set =3D pnv_ioda2_tce_build,
> +#ifdef CONFIG_IOMMU_API
> +	.exchange =3D pnv_ioda2_tce_xchg,
> +#endif
>  	.clear =3D pnv_ioda2_tce_free,
>  	.get =3D pnv_tce_get,
>  };
> diff --git a/arch/powerpc/platforms/powernv/pci-p5ioc2.c b/arch/powerpc/p=
latforms/powernv/pci-p5ioc2.c
> index a073af0..7a6fd92 100644
> --- a/arch/powerpc/platforms/powernv/pci-p5ioc2.c
> +++ b/arch/powerpc/platforms/powernv/pci-p5ioc2.c
> @@ -85,6 +85,9 @@ static void pnv_pci_init_p5ioc2_msis(struct pnv_phb *ph=
b) { }
> =20
>  static struct iommu_table_ops pnv_p5ioc2_iommu_ops =3D {
>  	.set =3D pnv_tce_build,
> +#ifdef CONFIG_IOMMU_API
> +	.exchange =3D pnv_tce_xchg,
> +#endif
>  	.clear =3D pnv_tce_free,
>  	.get =3D pnv_tce_get,
>  };
> diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platform=
s/powernv/pci.c
> index ba75aa5..e8802ac 100644
> --- a/arch/powerpc/platforms/powernv/pci.c
> +++ b/arch/powerpc/platforms/powernv/pci.c
> @@ -598,6 +598,23 @@ int pnv_tce_build(struct iommu_table *tbl, long inde=
x, long npages,
>  	return 0;
>  }
> =20
> +#ifdef CONFIG_IOMMU_API
> +int pnv_tce_xchg(struct iommu_table *tbl, long index,
> +		unsigned long *tce, enum dma_data_direction *direction)
> +{
> +	u64 proto_tce =3D iommu_direction_to_tce_perm(*direction);
> +	unsigned long newtce =3D *tce | proto_tce;
> +	unsigned long idx =3D index - tbl->it_offset;

Should this have a BUG_ON or WARN_ON if the supplied tce has bits set
below the page mask?

> +	*tce =3D xchg(pnv_tce(tbl, idx), cpu_to_be64(newtce));
> +	*tce =3D be64_to_cpu(*tce);
> +	*direction =3D iommu_tce_direction(*tce);
> +	*tce &=3D ~(TCE_PCI_READ | TCE_PCI_WRITE);
> +
> +	return 0;
> +}
> +#endif
> +
>  void pnv_tce_free(struct iommu_table *tbl, long index, long npages)
>  {
>  	long i;
> diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platform=
s/powernv/pci.h
> index bd83d85..b15cce5 100644
> --- a/arch/powerpc/platforms/powernv/pci.h
> +++ b/arch/powerpc/platforms/powernv/pci.h
> @@ -205,6 +205,8 @@ extern int pnv_tce_build(struct iommu_table *tbl, lon=
g index, long npages,
>  		unsigned long uaddr, enum dma_data_direction direction,
>  		struct dma_attrs *attrs);
>  extern void pnv_tce_free(struct iommu_table *tbl, long index, long npage=
s);
> +extern int pnv_tce_xchg(struct iommu_table *tbl, long index,
> +		unsigned long *tce, enum dma_data_direction *direction);
>  extern unsigned long pnv_tce_get(struct iommu_table *tbl, long index);
> =20
>  void pnv_pci_dump_phb_diag_data(struct pci_controller *hose,
> diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iomm=
u_spapr_tce.c
> index dacc738..2d51bbf 100644
> --- a/drivers/vfio/vfio_iommu_spapr_tce.c
> +++ b/drivers/vfio/vfio_iommu_spapr_tce.c
> @@ -239,14 +239,7 @@ static void tce_iommu_unuse_page(struct tce_containe=
r *container,
>  {
>  	struct page *page;
> =20
> -	if (!(oldtce & (TCE_PCI_READ | TCE_PCI_WRITE)))
> -		return;
> -
>  	page =3D pfn_to_page(oldtce >> PAGE_SHIFT);
> -
> -	if (oldtce & TCE_PCI_WRITE)
> -		SetPageDirty(page);
> -
>  	put_page(page);
>  }
> =20
> @@ -255,10 +248,17 @@ static int tce_iommu_clear(struct tce_container *co=
ntainer,
>  		unsigned long entry, unsigned long pages)
>  {
>  	unsigned long oldtce;
> +	long ret;
> +	enum dma_data_direction direction;
> =20
>  	for ( ; pages; --pages, ++entry) {
> -		oldtce =3D iommu_clear_tce(tbl, entry);
> -		if (!oldtce)
> +		direction =3D DMA_NONE;
> +		oldtce =3D 0;
> +		ret =3D iommu_tce_xchg(tbl, entry, &oldtce, &direction);
> +		if (ret)
> +			continue;
> +
> +		if (direction =3D=3D DMA_NONE)
>  			continue;
> =20
>  		tce_iommu_unuse_page(container, oldtce);
> @@ -283,12 +283,13 @@ static int tce_iommu_use_page(unsigned long tce, un=
signed long *hpa)
> =20
>  static long tce_iommu_build(struct tce_container *container,
>  		struct iommu_table *tbl,
> -		unsigned long entry, unsigned long tce, unsigned long pages)
> +		unsigned long entry, unsigned long tce, unsigned long pages,
> +		enum dma_data_direction direction)
>  {
>  	long i, ret =3D 0;
>  	struct page *page;
>  	unsigned long hpa;
> -	enum dma_data_direction direction =3D iommu_tce_direction(tce);
> +	enum dma_data_direction dirtmp;
> =20
>  	for (i =3D 0; i < pages; ++i) {
>  		unsigned long offset =3D tce & IOMMU_PAGE_MASK(tbl) & ~PAGE_MASK;
> @@ -304,8 +305,8 @@ static long tce_iommu_build(struct tce_container *con=
tainer,
>  		}
> =20
>  		hpa |=3D offset;
> -		ret =3D iommu_tce_build(tbl, entry + i, (unsigned long) __va(hpa),
> -				direction);
> +		dirtmp =3D direction;
> +		ret =3D iommu_tce_xchg(tbl, entry + i, &hpa, &dirtmp);
>  		if (ret) {
>  			tce_iommu_unuse_page(container, hpa);
>  			pr_err("iommu_tce: %s failed ioba=3D%lx, tce=3D%lx, ret=3D%ld\n",
> @@ -313,6 +314,10 @@ static long tce_iommu_build(struct tce_container *co=
ntainer,
>  					tce, ret);
>  			break;
>  		}
> +
> +		if (dirtmp !=3D DMA_NONE)
> +			tce_iommu_unuse_page(container, hpa);
> +
>  		tce +=3D IOMMU_PAGE_SIZE(tbl);
>  	}
> =20
> @@ -377,7 +382,7 @@ static long tce_iommu_ioctl(void *iommu_data,
>  	case VFIO_IOMMU_MAP_DMA: {
>  		struct vfio_iommu_type1_dma_map param;
>  		struct iommu_table *tbl;
> -		unsigned long tce;
> +		enum dma_data_direction direction;
> =20
>  		if (!container->enabled)
>  			return -EPERM;
> @@ -398,24 +403,33 @@ static long tce_iommu_ioctl(void *iommu_data,
>  		if (!tbl)
>  			return -ENXIO;
> =20
> -		if ((param.size & ~IOMMU_PAGE_MASK(tbl)) ||
> -				(param.vaddr & ~IOMMU_PAGE_MASK(tbl)))
> +		if (param.size & ~IOMMU_PAGE_MASK(tbl))
> +			return -EINVAL;
> +
> +		if (param.vaddr & (TCE_PCI_READ | TCE_PCI_WRITE))
>  			return -EINVAL;

This doesn't look right - the existing check against PAGE_MASK
is still correct and included the check for the permission bits as well.

>  		/* iova is checked by the IOMMU API */
> -		tce =3D param.vaddr;
>  		if (param.flags & VFIO_DMA_MAP_FLAG_READ)
> -			tce |=3D TCE_PCI_READ;
> -		if (param.flags & VFIO_DMA_MAP_FLAG_WRITE)
> -			tce |=3D TCE_PCI_WRITE;
> +			if (param.flags & VFIO_DMA_MAP_FLAG_WRITE)
> +				direction =3D DMA_BIDIRECTIONAL;
> +			else
> +				direction =3D DMA_TO_DEVICE;
> +		else
> +			if (param.flags & VFIO_DMA_MAP_FLAG_WRITE)
> +				direction =3D DMA_FROM_DEVICE;
> +			else
> +				return -EINVAL;
> =20
> -		ret =3D iommu_tce_put_param_check(tbl, param.iova, tce);
> +		ret =3D iommu_tce_put_param_check(tbl, param.iova, param.vaddr);
>  		if (ret)
>  			return ret;
> =20
>  		ret =3D tce_iommu_build(container, tbl,
>  				param.iova >> tbl->it_page_shift,
> -				tce, param.size >> tbl->it_page_shift);
> +				param.vaddr,
> +				param.size >> tbl->it_page_shift,
> +				direction);
> =20
>  		iommu_flush_tce(tbl);
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--KM+e2hnYAO+MCJ5e
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVQFuAAAoJEGw4ysog2bOSZHQQALlbcTWVP9cB4H+vwO2SzGjR
eE2Rfu6DCIKTVvp5uh3T9oqjG6D68XfsSPjEYYGyiWl3aij5Ld/HwXYfMuoVg2ac
oqXz2EjLRngohD6DQMor5SAX2fjT9Dwtve/EWhZDy947a8TQLXxhkJmLygj0zruJ
ZTIKy5lt89fasw6ohaLjf1zzZDGpV2Uk/V8TxkE1klKaHl+w2ww0pJ27Iy0SU9p0
Gwx9VEjrwqOIK8YICUVA4XEA6hr7cv8Vd7L2+Q4+eM8IHZmUXy9qVccU1jxXoFUM
ernC3uutoQfq+XsOouTW2M8yc63C8srNhQ8XhfFb70tzTYI6abI2Kgck3rZVfwGg
tmN4k5Ylcz5rQ9PkMIZ9sBHgOfODkRlgdhG5cyY3eS4/Ho87CysTUM/ErykP+GmU
KT0rIJhMKi39CZinVx+5cw767NOoATvwUwkeKmv7zbV0/B7PV0OhQuLI6t+EQDZy
fN3MiJfkMbgoBEC0gckyIV+zmN2NalxFGECJ/VzDlOKAX19KrM6ppalrZ1d7C57B
Lk7X6ZC9VljVes3eizTWwsyCYQNX478Ujl3DNBtqLQL55bp/5WLzfVwrm8Vb9BIq
OSqhOTR+9iyBgIUcYUkwBaMf8c00U2lOOkxKAj5VTjjVPQQjzJQdDt5DZzYp8j+0
Zbgat2fxuqycMkwSYFBR
=/EYQ
-----END PGP SIGNATURE-----

--KM+e2hnYAO+MCJ5e--
