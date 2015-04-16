Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B21411A025A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Apr 2015 16:29:25 +1000 (AEST)
Date: Thu, 16 Apr 2015 16:26:19 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel v8 17/31] powerpc/iommu/powernv: Release replaced
 TCE
Message-ID: <20150416062619.GH3632@voom.redhat.com>
References: <1428647473-11738-1-git-send-email-aik@ozlabs.ru>
 <1428647473-11738-18-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="o71xDhNo7p97+qVi"
In-Reply-To: <1428647473-11738-18-git-send-email-aik@ozlabs.ru>
Cc: Alex Williamson <alex.williamson@redhat.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--o71xDhNo7p97+qVi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 10, 2015 at 04:30:59PM +1000, Alexey Kardashevskiy wrote:
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
> the caller can release the pages afterwards.
>=20
> The returned old TCE value is a virtual address as the new TCE value.
> This is different from tce_clear() which returns a physical address.
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
> ---
>  arch/powerpc/include/asm/iommu.h            | 17 ++++++--
>  arch/powerpc/kernel/iommu.c                 | 53 +++++++++---------------
>  arch/powerpc/platforms/powernv/pci-ioda.c   | 38 ++++++++++++++++++
>  arch/powerpc/platforms/powernv/pci-p5ioc2.c |  3 ++
>  arch/powerpc/platforms/powernv/pci.c        | 17 ++++++++
>  arch/powerpc/platforms/powernv/pci.h        |  2 +
>  drivers/vfio/vfio_iommu_spapr_tce.c         | 62 ++++++++++++++++++-----=
------
>  7 files changed, 130 insertions(+), 62 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/=
iommu.h
> index d1f8c6c..bde7ee7 100644
> --- a/arch/powerpc/include/asm/iommu.h
> +++ b/arch/powerpc/include/asm/iommu.h
> @@ -44,11 +44,22 @@ extern int iommu_is_off;
>  extern int iommu_force_on;
> =20
>  struct iommu_table_ops {
> +	/* When called with direction=3D=3DDMA_NONE, it is equal to clear() */
>  	int (*set)(struct iommu_table *tbl,
>  			long index, long npages,
>  			unsigned long uaddr,
>  			enum dma_data_direction direction,
>  			struct dma_attrs *attrs);
> +#ifdef CONFIG_IOMMU_API
> +	/*
> +	 * Exchanges existing TCE with new TCE plus direction bits;
> +	 * returns old TCE and DMA direction mask
> +	 */
> +	int (*exchange)(struct iommu_table *tbl,
> +			long index,
> +			unsigned long *tce,
> +			enum dma_data_direction *direction);
> +#endif
>  	void (*clear)(struct iommu_table *tbl,
>  			long index, long npages);
>  	unsigned long (*get)(struct iommu_table *tbl, long index);
> @@ -152,6 +163,8 @@ extern void iommu_register_group(struct iommu_table_g=
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
> @@ -231,10 +244,6 @@ extern int iommu_tce_clear_param_check(struct iommu_=
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
>  extern int iommu_take_ownership(struct iommu_table_group *table_group);
> diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
> index 068fe4ff..501e8ee 100644
> --- a/arch/powerpc/kernel/iommu.c
> +++ b/arch/powerpc/kernel/iommu.c
> @@ -982,9 +982,6 @@ EXPORT_SYMBOL_GPL(iommu_tce_clear_param_check);
>  int iommu_tce_put_param_check(struct iommu_table *tbl,
>  		unsigned long ioba, unsigned long tce)
>  {
> -	if (!(tce & (TCE_PCI_WRITE | TCE_PCI_READ)))
> -		return -EINVAL;
> -
>  	if (tce & ~(IOMMU_PAGE_MASK(tbl) | TCE_PCI_WRITE | TCE_PCI_READ))
>  		return -EINVAL;
> =20
> @@ -1002,44 +999,20 @@ int iommu_tce_put_param_check(struct iommu_table *=
tbl,
>  }
>  EXPORT_SYMBOL_GPL(iommu_tce_put_param_check);
> =20
> -unsigned long iommu_clear_tce(struct iommu_table *tbl, unsigned long ent=
ry)
> -{
> -	unsigned long oldtce;
> -	struct iommu_pool *pool =3D get_pool(tbl, entry);
> -
> -	spin_lock(&(pool->lock));
> -
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
>  /*
>   * hwaddr is a kernel virtual address here (0xc... bazillion),
>   * tce_build converts it to a physical address.
>   */
> -int iommu_tce_build(struct iommu_table *tbl, unsigned long entry,
> -		unsigned long hwaddr, enum dma_data_direction direction)
> +long iommu_tce_xchg(struct iommu_table *tbl, unsigned long entry,
> +		unsigned long *tce, enum dma_data_direction *direction)
>  {
> -	int ret =3D -EBUSY;
> -	unsigned long oldtce;
> -	struct iommu_pool *pool =3D get_pool(tbl, entry);
> +	long ret;
> =20
> -	spin_lock(&(pool->lock));
> +	ret =3D tbl->it_ops->exchange(tbl, entry, tce, direction);
> =20
> -	oldtce =3D tbl->it_ops->get(tbl, entry);
> -	/* Add new entry if it is not busy */
> -	if (!(oldtce & (TCE_PCI_WRITE | TCE_PCI_READ)))
> -		ret =3D tbl->it_ops->set(tbl, entry, 1, hwaddr, direction, NULL);
> -
> -	spin_unlock(&(pool->lock));
> +	if (!ret && ((*direction =3D=3D DMA_FROM_DEVICE) ||
> +			(*direction =3D=3D DMA_BIDIRECTIONAL)))
> +		SetPageDirty(pfn_to_page(__pa(*tce) >> PAGE_SHIFT));
> =20
>  	/* if (unlikely(ret))
>  		pr_err("iommu_tce: %s failed on hwaddr=3D%lx ioba=3D%lx kva=3D%lx ret=
=3D%d\n",
> @@ -1048,13 +1021,23 @@ int iommu_tce_build(struct iommu_table *tbl, unsi=
gned long entry,
> =20
>  	return ret;
>  }
> -EXPORT_SYMBOL_GPL(iommu_tce_build);
> +EXPORT_SYMBOL_GPL(iommu_tce_xchg);
> =20
>  static int iommu_table_take_ownership(struct iommu_table *tbl)
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
> index fd993bc..4d80502 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -1128,6 +1128,20 @@ static int pnv_ioda1_tce_build_vm(struct iommu_tab=
le *tbl, long index,
>  	return ret;
>  }
> =20
> +#ifdef CONFIG_IOMMU_API
> +static int pnv_ioda1_tce_xchg_vm(struct iommu_table *tbl, long index,
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
>  static void pnv_ioda1_tce_free_vm(struct iommu_table *tbl, long index,
>  		long npages)
>  {
> @@ -1139,6 +1153,9 @@ static void pnv_ioda1_tce_free_vm(struct iommu_tabl=
e *tbl, long index,
> =20
>  struct iommu_table_ops pnv_ioda1_iommu_ops =3D {
>  	.set =3D pnv_ioda1_tce_build_vm,
> +#ifdef CONFIG_IOMMU_API
> +	.exchange =3D pnv_ioda1_tce_xchg_vm,
> +#endif
>  	.clear =3D pnv_ioda1_tce_free_vm,
>  	.get =3D pnv_tce_get,
>  };
> @@ -1190,6 +1207,20 @@ static int pnv_ioda2_tce_build_vm(struct iommu_tab=
le *tbl, long index,
>  	return ret;
>  }
> =20
> +#ifdef CONFIG_IOMMU_API
> +static int pnv_ioda2_tce_xchg_vm(struct iommu_table *tbl, long index,
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
>  static void pnv_ioda2_tce_free_vm(struct iommu_table *tbl, long index,
>  		long npages)
>  {
> @@ -1201,6 +1232,9 @@ static void pnv_ioda2_tce_free_vm(struct iommu_tabl=
e *tbl, long index,
> =20
>  static struct iommu_table_ops pnv_ioda2_iommu_ops =3D {
>  	.set =3D pnv_ioda2_tce_build_vm,
> +#ifdef CONFIG_IOMMU_API
> +	.exchange =3D pnv_ioda2_tce_xchg_vm,
> +#endif
>  	.clear =3D pnv_ioda2_tce_free_vm,
>  	.get =3D pnv_tce_get,
>  };
> @@ -1353,6 +1387,7 @@ static void pnv_pci_ioda2_setup_bypass_pe(struct pn=
v_phb *phb,
>  	pnv_pci_ioda2_set_bypass(pe, true);
>  }
> =20
> +#ifdef CONFIG_IOMMU_API
>  static void pnv_ioda2_set_ownership(struct iommu_table_group *table_grou=
p,
>  				     bool enable)
>  {
> @@ -1369,6 +1404,7 @@ static void pnv_ioda2_set_ownership(struct iommu_ta=
ble_group *table_group,
>  static struct iommu_table_group_ops pnv_pci_ioda2_ops =3D {
>  	.set_ownership =3D pnv_ioda2_set_ownership,
>  };
> +#endif
> =20
>  static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
>  				       struct pnv_ioda_pe *pe)
> @@ -1437,7 +1473,9 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_p=
hb *phb,
>  	}
>  	tbl->it_ops =3D &pnv_ioda2_iommu_ops;
>  	iommu_init_table(tbl, phb->hose->node);
> +#ifdef CONFIG_IOMMU_API
>  	pe->table_group.ops =3D &pnv_pci_ioda2_ops;
> +#endif
>  	iommu_register_group(&pe->table_group, phb->hose->global_number,
>  			pe->pe_number);
> =20
> diff --git a/arch/powerpc/platforms/powernv/pci-p5ioc2.c b/arch/powerpc/p=
latforms/powernv/pci-p5ioc2.c
> index 6906a9c..d2d9092 100644
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
> index a8c05de..a9797dd 100644
> --- a/arch/powerpc/platforms/powernv/pci.c
> +++ b/arch/powerpc/platforms/powernv/pci.c
> @@ -615,6 +615,23 @@ int pnv_tce_build(struct iommu_table *tbl, long inde=
x, long npages,
>  	return 0;
>  }
> =20
> +#ifdef CONFIG_IOMMU_API
> +int pnv_tce_xchg(struct iommu_table *tbl, long index,
> +		unsigned long *tce, enum dma_data_direction *direction)
> +{
> +	u64 proto_tce =3D iommu_direction_to_tce_perm(*direction);
> +	unsigned long newtce =3D  __pa(*tce) | proto_tce;
> +	unsigned long idx =3D index - tbl->it_offset;
> +
> +	*tce =3D xchg(pnv_tce(tbl, idx), cpu_to_be64(newtce));
> +	*tce =3D (unsigned long) __va(be64_to_cpu(*tce));
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
> index 0d4df32..4d1a78c 100644
> --- a/arch/powerpc/platforms/powernv/pci.h
> +++ b/arch/powerpc/platforms/powernv/pci.h
> @@ -220,6 +220,8 @@ extern int pnv_tce_build(struct iommu_table *tbl, lon=
g index, long npages,
>  		unsigned long uaddr, enum dma_data_direction direction,
>  		struct dma_attrs *attrs);
>  extern void pnv_tce_free(struct iommu_table *tbl, long index, long npage=
s);
> +extern int pnv_tce_xchg(struct iommu_table *tbl, long index,
> +		unsigned long *tce, enum dma_data_direction *direction);
>  extern unsigned long pnv_tce_get(struct iommu_table *tbl, long index);
>  extern struct iommu_table_ops pnv_ioda1_iommu_ops;
> =20
> diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iomm=
u_spapr_tce.c
> index d5d8c50..7c3c215 100644
> --- a/drivers/vfio/vfio_iommu_spapr_tce.c
> +++ b/drivers/vfio/vfio_iommu_spapr_tce.c
> @@ -251,9 +251,6 @@ static void tce_iommu_unuse_page(struct tce_container=
 *container,
>  {
>  	struct page *page;
> =20
> -	if (!(oldtce & (TCE_PCI_READ | TCE_PCI_WRITE)))
> -		return;
> -
>  	/*
>  	 * VFIO cannot map/unmap when a container is not enabled so
>  	 * we would not need this check but KVM could map/unmap and if
> @@ -264,10 +261,6 @@ static void tce_iommu_unuse_page(struct tce_containe=
r *container,
>  		return;
> =20
>  	page =3D pfn_to_page(__pa(oldtce) >> PAGE_SHIFT);
> -
> -	if (oldtce & TCE_PCI_WRITE)
> -		SetPageDirty(page);
> -

Seems to me that unuse_page() should get a direction parameter,
instead of moving the PageDirty (and DMA_NONE test) to all the
callers.

>  	put_page(page);
>  }
> =20
> @@ -275,14 +268,21 @@ static int tce_iommu_clear(struct tce_container *co=
ntainer,
>  		struct iommu_table *tbl,
>  		unsigned long entry, unsigned long pages)
>  {
> -	unsigned long oldtce;
> +	long ret;
> +	enum dma_data_direction direction;
> +	unsigned long tce;
> =20
>  	for ( ; pages; --pages, ++entry) {
> -		oldtce =3D iommu_clear_tce(tbl, entry);
> -		if (!oldtce)
> +		direction =3D DMA_NONE;
> +		tce =3D (unsigned long) __va(0);
> +		ret =3D iommu_tce_xchg(tbl, entry, &tce, &direction);
> +		if (ret)
>  			continue;
> =20
> -		tce_iommu_unuse_page(container, (unsigned long) __va(oldtce));
> +		if (direction =3D=3D DMA_NONE)
> +			continue;
> +
> +		tce_iommu_unuse_page(container, tce);
>  	}
> =20
>  	return 0;
> @@ -304,12 +304,13 @@ static int tce_get_hva(unsigned long tce, unsigned =
long *hva)
> =20
>  static long tce_iommu_build(struct tce_container *container,
>  		struct iommu_table *tbl,
> -		unsigned long entry, unsigned long tce, unsigned long pages)
> +		unsigned long entry, unsigned long tce, unsigned long pages,
> +		enum dma_data_direction direction)
>  {
>  	long i, ret =3D 0;
>  	struct page *page;
>  	unsigned long hva;
> -	enum dma_data_direction direction =3D iommu_tce_direction(tce);
> +	enum dma_data_direction dirtmp;
> =20
>  	for (i =3D 0; i < pages; ++i) {
>  		ret =3D tce_get_hva(tce, &hva);
> @@ -324,15 +325,21 @@ static long tce_iommu_build(struct tce_container *c=
ontainer,
> =20
>  		/* Preserve offset within IOMMU page */
>  		hva |=3D tce & IOMMU_PAGE_MASK(tbl) & ~PAGE_MASK;
> +		dirtmp =3D direction;
> =20
> -		ret =3D iommu_tce_build(tbl, entry + i, hva, direction);
> +		ret =3D iommu_tce_xchg(tbl, entry + i, &hva, &dirtmp);
>  		if (ret) {
> +			/* dirtmp cannot be DMA_NONE here */
>  			tce_iommu_unuse_page(container, hva);
>  			pr_err("iommu_tce: %s failed ioba=3D%lx, tce=3D%lx, ret=3D%ld\n",
>  					__func__, entry << tbl->it_page_shift,
>  					tce, ret);
>  			break;
>  		}
> +
> +		if (dirtmp !=3D DMA_NONE)
> +			tce_iommu_unuse_page(container, hva);
> +
>  		tce +=3D IOMMU_PAGE_SIZE(tbl);
>  	}
> =20
> @@ -397,7 +404,7 @@ static long tce_iommu_ioctl(void *iommu_data,
>  	case VFIO_IOMMU_MAP_DMA: {
>  		struct vfio_iommu_type1_dma_map param;
>  		struct iommu_table *tbl;
> -		unsigned long tce;
> +		enum dma_data_direction direction;
> =20
>  		if (!container->enabled)
>  			return -EPERM;
> @@ -418,24 +425,33 @@ static long tce_iommu_ioctl(void *iommu_data,
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
> =20
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

--o71xDhNo7p97+qVi
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVL1YLAAoJEGw4ysog2bOSTv8QAN55APsyeQwMInvx+N0anb7S
Rdiik+o9D3lpF4D5XIU9e9STFbCvAt4a/uUlRDkuaFvuyEbKwq03A5vBZrZPZNom
0floHOb4GlKAvUpL3OfTM6A2vyIEOB3uhZwq68d0ANY+d2JJAR9bt7JvC9lm9mvX
9RRDG8vrQvXYkSoca/Igixw4YOJENyisCIvurkL7bppXT+MXOrZiqCZebNsiPjk7
EAsJ7G7TBMtRBajz0rUWMEy4f/aXs/RWRmosn3Yi+DrMOFyRnGty3xnswxXmFkTG
3LSSXQtYkzSOBxXzSvcLQYb8RKSGYbIlTON/xDAhYTYbME/A00R7l4zJBghKkW+3
xnPtxsc7lrc0r5uyBJlVHtQ2AbweLkrE1oNfn9C8N6syaY1eXqHjwBqIlPjmbV0U
pbnFhKShHc/fxTRGD9WAzY/9V6gG6xfcD1qJc2Q3DTXBqg34lD1Mej1btPE+3+bS
qauN3NNPLsa08dAbMKo8NbH8y9Wc1V5s3gDYjH+WqsO5Auz6k9vQZ9K0r/YmEn1O
L8hyRIJHwonbfFTsaDwTkM7qI4eyM1oYivSwoNE6iJXjNZt+p5xFRHnXR8rg3+VS
zWH4tvFpofPIYyRXVRUYOEipcv2wbfapBmnvlVG0XUqERsoQ4uXeOkNPFPPfrK5+
K84hnyvNfPcZ2p4Ytawv
=2GBC
-----END PGP SIGNATURE-----

--o71xDhNo7p97+qVi--
