Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C7DBB1A0B8E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Apr 2015 18:32:39 +1000 (AEST)
Date: Wed, 15 Apr 2015 17:23:43 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel v8 10/31] powerpc/iommu: Move tce_xxx callbacks
 from ppc_md to iommu_table
Message-ID: <20150415072343.GL25040@voom.redhat.com>
References: <1428647473-11738-1-git-send-email-aik@ozlabs.ru>
 <1428647473-11738-11-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="Ms5iOKSBOB9YS8zC"
In-Reply-To: <1428647473-11738-11-git-send-email-aik@ozlabs.ru>
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


--Ms5iOKSBOB9YS8zC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 10, 2015 at 04:30:52PM +1000, Alexey Kardashevskiy wrote:
> This adds a iommu_table_ops struct and puts pointer to it into
> the iommu_table struct. This moves tce_build/tce_free/tce_get/tce_flush
> callbacks from ppc_md to the new struct where they really belong to.
>=20
> This adds the requirement for @it_ops to be initialized before calling
> iommu_init_table() to make sure that we do not leave any IOMMU table
> with iommu_table_ops uninitialized. This is not a parameter of
> iommu_init_table() though as there will be cases when iommu_init_table()
> will not be called on TCE tables, for example - VFIO.

That seems a little bit clunky to me, but it's not a big enough
objection to delay the patch over, so

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

>=20
> This does s/tce_build/set/, s/tce_free/clear/ and removes "tce_"
> redundand prefixes.
>=20
> This removes tce_xxx_rm handlers from ppc_md but does not add
> them to iommu_table_ops as this will be done later if we decide to
> support TCE hypercalls in real mode.
>=20
> For pSeries, this always uses tce_buildmulti_pSeriesLP/
> tce_buildmulti_pSeriesLP. This changes multi callback to fall back to
> tce_build_pSeriesLP/tce_free_pSeriesLP if FW_FEATURE_MULTITCE is not
> present. The reason for this is we still have to support "multitce=3Doff"
> boot parameter in disable_multitce() and we do not want to walk through
> all IOMMU tables in the system and replace "multi" callbacks with single
> ones.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>  arch/powerpc/include/asm/iommu.h            | 17 +++++++++++
>  arch/powerpc/include/asm/machdep.h          | 25 ----------------
>  arch/powerpc/kernel/iommu.c                 | 46 +++++++++++++++--------=
------
>  arch/powerpc/kernel/vio.c                   |  5 ++++
>  arch/powerpc/platforms/cell/iommu.c         |  8 +++--
>  arch/powerpc/platforms/pasemi/iommu.c       |  7 +++--
>  arch/powerpc/platforms/powernv/pci-ioda.c   |  2 ++
>  arch/powerpc/platforms/powernv/pci-p5ioc2.c |  1 +
>  arch/powerpc/platforms/powernv/pci.c        | 23 ++++-----------
>  arch/powerpc/platforms/powernv/pci.h        |  1 +
>  arch/powerpc/platforms/pseries/iommu.c      | 34 +++++++++++----------
>  arch/powerpc/sysdev/dart_iommu.c            | 12 ++++----
>  12 files changed, 93 insertions(+), 88 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/=
iommu.h
> index 2af2d70..d909e2a 100644
> --- a/arch/powerpc/include/asm/iommu.h
> +++ b/arch/powerpc/include/asm/iommu.h
> @@ -43,6 +43,22 @@
>  extern int iommu_is_off;
>  extern int iommu_force_on;
> =20
> +struct iommu_table_ops {
> +	int (*set)(struct iommu_table *tbl,
> +			long index, long npages,
> +			unsigned long uaddr,
> +			enum dma_data_direction direction,
> +			struct dma_attrs *attrs);
> +	void (*clear)(struct iommu_table *tbl,
> +			long index, long npages);
> +	unsigned long (*get)(struct iommu_table *tbl, long index);
> +	void (*flush)(struct iommu_table *tbl);
> +};
> +
> +/* These are used by VIO */
> +extern struct iommu_table_ops iommu_table_lpar_multi_ops;
> +extern struct iommu_table_ops iommu_table_pseries_ops;
> +
>  /*
>   * IOMAP_MAX_ORDER defines the largest contiguous block
>   * of dma space we can get.  IOMAP_MAX_ORDER =3D 13
> @@ -77,6 +93,7 @@ struct iommu_table {
>  #ifdef CONFIG_IOMMU_API
>  	struct iommu_group *it_group;
>  #endif
> +	struct iommu_table_ops *it_ops;
>  	void (*set_bypass)(struct iommu_table *tbl, bool enable);
>  };
> =20
> diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/as=
m/machdep.h
> index c8175a3..2abe744 100644
> --- a/arch/powerpc/include/asm/machdep.h
> +++ b/arch/powerpc/include/asm/machdep.h
> @@ -65,31 +65,6 @@ struct machdep_calls {
>  	 * destroyed as well */
>  	void		(*hpte_clear_all)(void);
> =20
> -	int		(*tce_build)(struct iommu_table *tbl,
> -				     long index,
> -				     long npages,
> -				     unsigned long uaddr,
> -				     enum dma_data_direction direction,
> -				     struct dma_attrs *attrs);
> -	void		(*tce_free)(struct iommu_table *tbl,
> -				    long index,
> -				    long npages);
> -	unsigned long	(*tce_get)(struct iommu_table *tbl,
> -				    long index);
> -	void		(*tce_flush)(struct iommu_table *tbl);
> -
> -	/* _rm versions are for real mode use only */
> -	int		(*tce_build_rm)(struct iommu_table *tbl,
> -				     long index,
> -				     long npages,
> -				     unsigned long uaddr,
> -				     enum dma_data_direction direction,
> -				     struct dma_attrs *attrs);
> -	void		(*tce_free_rm)(struct iommu_table *tbl,
> -				    long index,
> -				    long npages);
> -	void		(*tce_flush_rm)(struct iommu_table *tbl);
> -
>  	void __iomem *	(*ioremap)(phys_addr_t addr, unsigned long size,
>  				   unsigned long flags, void *caller);
>  	void		(*iounmap)(volatile void __iomem *token);
> diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
> index 029b1ea..eceb214 100644
> --- a/arch/powerpc/kernel/iommu.c
> +++ b/arch/powerpc/kernel/iommu.c
> @@ -322,11 +322,11 @@ static dma_addr_t iommu_alloc(struct device *dev, s=
truct iommu_table *tbl,
>  	ret =3D entry << tbl->it_page_shift;	/* Set the return dma address */
> =20
>  	/* Put the TCEs in the HW table */
> -	build_fail =3D ppc_md.tce_build(tbl, entry, npages,
> +	build_fail =3D tbl->it_ops->set(tbl, entry, npages,
>  				      (unsigned long)page &
>  				      IOMMU_PAGE_MASK(tbl), direction, attrs);
> =20
> -	/* ppc_md.tce_build() only returns non-zero for transient errors.
> +	/* tbl->it_ops->set() only returns non-zero for transient errors.
>  	 * Clean up the table bitmap in this case and return
>  	 * DMA_ERROR_CODE. For all other errors the functionality is
>  	 * not altered.
> @@ -337,8 +337,8 @@ static dma_addr_t iommu_alloc(struct device *dev, str=
uct iommu_table *tbl,
>  	}
> =20
>  	/* Flush/invalidate TLB caches if necessary */
> -	if (ppc_md.tce_flush)
> -		ppc_md.tce_flush(tbl);
> +	if (tbl->it_ops->flush)
> +		tbl->it_ops->flush(tbl);
> =20
>  	/* Make sure updates are seen by hardware */
>  	mb();
> @@ -408,7 +408,7 @@ static void __iommu_free(struct iommu_table *tbl, dma=
_addr_t dma_addr,
>  	if (!iommu_free_check(tbl, dma_addr, npages))
>  		return;
> =20
> -	ppc_md.tce_free(tbl, entry, npages);
> +	tbl->it_ops->clear(tbl, entry, npages);
> =20
>  	spin_lock_irqsave(&(pool->lock), flags);
>  	bitmap_clear(tbl->it_map, free_entry, npages);
> @@ -424,8 +424,8 @@ static void iommu_free(struct iommu_table *tbl, dma_a=
ddr_t dma_addr,
>  	 * not do an mb() here on purpose, it is not needed on any of
>  	 * the current platforms.
>  	 */
> -	if (ppc_md.tce_flush)
> -		ppc_md.tce_flush(tbl);
> +	if (tbl->it_ops->flush)
> +		tbl->it_ops->flush(tbl);
>  }
> =20
>  int ppc_iommu_map_sg(struct device *dev, struct iommu_table *tbl,
> @@ -495,7 +495,7 @@ int ppc_iommu_map_sg(struct device *dev, struct iommu=
_table *tbl,
>  			    npages, entry, dma_addr);
> =20
>  		/* Insert into HW table */
> -		build_fail =3D ppc_md.tce_build(tbl, entry, npages,
> +		build_fail =3D tbl->it_ops->set(tbl, entry, npages,
>  					      vaddr & IOMMU_PAGE_MASK(tbl),
>  					      direction, attrs);
>  		if(unlikely(build_fail))
> @@ -534,8 +534,8 @@ int ppc_iommu_map_sg(struct device *dev, struct iommu=
_table *tbl,
>  	}
> =20
>  	/* Flush/invalidate TLB caches if necessary */
> -	if (ppc_md.tce_flush)
> -		ppc_md.tce_flush(tbl);
> +	if (tbl->it_ops->flush)
> +		tbl->it_ops->flush(tbl);
> =20
>  	DBG("mapped %d elements:\n", outcount);
> =20
> @@ -600,8 +600,8 @@ void ppc_iommu_unmap_sg(struct iommu_table *tbl, stru=
ct scatterlist *sglist,
>  	 * do not do an mb() here, the affected platforms do not need it
>  	 * when freeing.
>  	 */
> -	if (ppc_md.tce_flush)
> -		ppc_md.tce_flush(tbl);
> +	if (tbl->it_ops->flush)
> +		tbl->it_ops->flush(tbl);
>  }
> =20
>  static void iommu_table_clear(struct iommu_table *tbl)
> @@ -613,17 +613,17 @@ static void iommu_table_clear(struct iommu_table *t=
bl)
>  	 */
>  	if (!is_kdump_kernel() || is_fadump_active()) {
>  		/* Clear the table in case firmware left allocations in it */
> -		ppc_md.tce_free(tbl, tbl->it_offset, tbl->it_size);
> +		tbl->it_ops->clear(tbl, tbl->it_offset, tbl->it_size);
>  		return;
>  	}
> =20
>  #ifdef CONFIG_CRASH_DUMP
> -	if (ppc_md.tce_get) {
> +	if (tbl->it_ops->get) {
>  		unsigned long index, tceval, tcecount =3D 0;
> =20
>  		/* Reserve the existing mappings left by the first kernel. */
>  		for (index =3D 0; index < tbl->it_size; index++) {
> -			tceval =3D ppc_md.tce_get(tbl, index + tbl->it_offset);
> +			tceval =3D tbl->it_ops->get(tbl, index + tbl->it_offset);
>  			/*
>  			 * Freed TCE entry contains 0x7fffffffffffffff on JS20
>  			 */
> @@ -657,6 +657,8 @@ struct iommu_table *iommu_init_table(struct iommu_tab=
le *tbl, int nid)
>  	unsigned int i;
>  	struct iommu_pool *p;
> =20
> +	BUG_ON(!tbl->it_ops);
> +
>  	/* number of bytes needed for the bitmap */
>  	sz =3D BITS_TO_LONGS(tbl->it_size) * sizeof(unsigned long);
> =20
> @@ -934,8 +936,8 @@ EXPORT_SYMBOL_GPL(iommu_tce_direction);
>  void iommu_flush_tce(struct iommu_table *tbl)
>  {
>  	/* Flush/invalidate TLB caches if necessary */
> -	if (ppc_md.tce_flush)
> -		ppc_md.tce_flush(tbl);
> +	if (tbl->it_ops->flush)
> +		tbl->it_ops->flush(tbl);
> =20
>  	/* Make sure updates are seen by hardware */
>  	mb();
> @@ -946,7 +948,7 @@ int iommu_tce_clear_param_check(struct iommu_table *t=
bl,
>  		unsigned long ioba, unsigned long tce_value,
>  		unsigned long npages)
>  {
> -	/* ppc_md.tce_free() does not support any value but 0 */
> +	/* tbl->it_ops->clear() does not support any value but 0 */
>  	if (tce_value)
>  		return -EINVAL;
> =20
> @@ -994,9 +996,9 @@ unsigned long iommu_clear_tce(struct iommu_table *tbl=
, unsigned long entry)
> =20
>  	spin_lock(&(pool->lock));
> =20
> -	oldtce =3D ppc_md.tce_get(tbl, entry);
> +	oldtce =3D tbl->it_ops->get(tbl, entry);
>  	if (oldtce & (TCE_PCI_WRITE | TCE_PCI_READ))
> -		ppc_md.tce_free(tbl, entry, 1);
> +		tbl->it_ops->clear(tbl, entry, 1);
>  	else
>  		oldtce =3D 0;
> =20
> @@ -1019,10 +1021,10 @@ int iommu_tce_build(struct iommu_table *tbl, unsi=
gned long entry,
> =20
>  	spin_lock(&(pool->lock));
> =20
> -	oldtce =3D ppc_md.tce_get(tbl, entry);
> +	oldtce =3D tbl->it_ops->get(tbl, entry);
>  	/* Add new entry if it is not busy */
>  	if (!(oldtce & (TCE_PCI_WRITE | TCE_PCI_READ)))
> -		ret =3D ppc_md.tce_build(tbl, entry, 1, hwaddr, direction, NULL);
> +		ret =3D tbl->it_ops->set(tbl, entry, 1, hwaddr, direction, NULL);
> =20
>  	spin_unlock(&(pool->lock));
> =20
> diff --git a/arch/powerpc/kernel/vio.c b/arch/powerpc/kernel/vio.c
> index 5bfdab9..b41426c 100644
> --- a/arch/powerpc/kernel/vio.c
> +++ b/arch/powerpc/kernel/vio.c
> @@ -1196,6 +1196,11 @@ static struct iommu_table *vio_build_iommu_table(s=
truct vio_dev *dev)
>  	tbl->it_type =3D TCE_VB;
>  	tbl->it_blocksize =3D 16;
> =20
> +	if (firmware_has_feature(FW_FEATURE_LPAR))
> +		tbl->it_ops =3D &iommu_table_lpar_multi_ops;
> +	else
> +		tbl->it_ops =3D &iommu_table_pseries_ops;
> +
>  	return iommu_init_table(tbl, -1);
>  }
> =20
> diff --git a/arch/powerpc/platforms/cell/iommu.c b/arch/powerpc/platforms=
/cell/iommu.c
> index c7c8720..72763a8 100644
> --- a/arch/powerpc/platforms/cell/iommu.c
> +++ b/arch/powerpc/platforms/cell/iommu.c
> @@ -465,6 +465,11 @@ static inline u32 cell_iommu_get_ioid(struct device_=
node *np)
>  	return *ioid;
>  }
> =20
> +static struct iommu_table_ops cell_iommu_ops =3D {
> +	.set =3D tce_build_cell,
> +	.clear =3D tce_free_cell
> +};
> +
>  static struct iommu_window * __init
>  cell_iommu_setup_window(struct cbe_iommu *iommu, struct device_node *np,
>  			unsigned long offset, unsigned long size,
> @@ -491,6 +496,7 @@ cell_iommu_setup_window(struct cbe_iommu *iommu, stru=
ct device_node *np,
>  	window->table.it_offset =3D
>  		(offset >> window->table.it_page_shift) + pte_offset;
>  	window->table.it_size =3D size >> window->table.it_page_shift;
> +	window->table.it_ops =3D &cell_iommu_ops;
> =20
>  	iommu_init_table(&window->table, iommu->nid);
> =20
> @@ -1200,8 +1206,6 @@ static int __init cell_iommu_init(void)
>  	/* Setup various ppc_md. callbacks */
>  	ppc_md.pci_dma_dev_setup =3D cell_pci_dma_dev_setup;
>  	ppc_md.dma_get_required_mask =3D cell_dma_get_required_mask;
> -	ppc_md.tce_build =3D tce_build_cell;
> -	ppc_md.tce_free =3D tce_free_cell;
> =20
>  	if (!iommu_fixed_disabled && cell_iommu_fixed_mapping_init() =3D=3D 0)
>  		goto bail;
> diff --git a/arch/powerpc/platforms/pasemi/iommu.c b/arch/powerpc/platfor=
ms/pasemi/iommu.c
> index 2e576f2..b7245b2 100644
> --- a/arch/powerpc/platforms/pasemi/iommu.c
> +++ b/arch/powerpc/platforms/pasemi/iommu.c
> @@ -132,6 +132,10 @@ static void iobmap_free(struct iommu_table *tbl, lon=
g index,
>  	}
>  }
> =20
> +static struct iommu_table_ops iommu_table_iobmap_ops =3D {
> +	.set =3D iobmap_build,
> +	.clear  =3D iobmap_free
> +};
> =20
>  static void iommu_table_iobmap_setup(void)
>  {
> @@ -151,6 +155,7 @@ static void iommu_table_iobmap_setup(void)
>  	 * Should probably be 8 (64 bytes)
>  	 */
>  	iommu_table_iobmap.it_blocksize =3D 4;
> +	iommu_table_iobmap.it_ops =3D &iommu_table_iobmap_ops;
>  	iommu_init_table(&iommu_table_iobmap, 0);
>  	pr_debug(" <- %s\n", __func__);
>  }
> @@ -250,8 +255,6 @@ void __init iommu_init_early_pasemi(void)
> =20
>  	ppc_md.pci_dma_dev_setup =3D pci_dma_dev_setup_pasemi;
>  	ppc_md.pci_dma_bus_setup =3D pci_dma_bus_setup_pasemi;
> -	ppc_md.tce_build =3D iobmap_build;
> -	ppc_md.tce_free  =3D iobmap_free;
>  	set_pci_dma_ops(&dma_iommu_ops);
>  }
> =20
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/pla=
tforms/powernv/pci-ioda.c
> index 6c9ff2b..85e64a5 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -1231,6 +1231,7 @@ static void pnv_pci_ioda_setup_dma_pe(struct pnv_ph=
b *phb,
>  				 TCE_PCI_SWINV_FREE   |
>  				 TCE_PCI_SWINV_PAIR);
>  	}
> +	tbl->it_ops =3D &pnv_iommu_ops;
>  	iommu_init_table(tbl, phb->hose->node);
>  	iommu_register_group(tbl, phb->hose->global_number, pe->pe_number);
> =20
> @@ -1364,6 +1365,7 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_p=
hb *phb,
>  				8);
>  		tbl->it_type |=3D (TCE_PCI_SWINV_CREATE | TCE_PCI_SWINV_FREE);
>  	}
> +	tbl->it_ops =3D &pnv_iommu_ops;
>  	iommu_init_table(tbl, phb->hose->node);
>  	iommu_register_group(tbl, phb->hose->global_number, pe->pe_number);
> =20
> diff --git a/arch/powerpc/platforms/powernv/pci-p5ioc2.c b/arch/powerpc/p=
latforms/powernv/pci-p5ioc2.c
> index 6ef6d4d..0256fcc 100644
> --- a/arch/powerpc/platforms/powernv/pci-p5ioc2.c
> +++ b/arch/powerpc/platforms/powernv/pci-p5ioc2.c
> @@ -87,6 +87,7 @@ static void pnv_pci_p5ioc2_dma_dev_setup(struct pnv_phb=
 *phb,
>  					 struct pci_dev *pdev)
>  {
>  	if (phb->p5ioc2.iommu_table.it_map =3D=3D NULL) {
> +		phb->p5ioc2.iommu_table.it_ops =3D &pnv_iommu_ops;
>  		iommu_init_table(&phb->p5ioc2.iommu_table, phb->hose->node);
>  		iommu_register_group(&phb->p5ioc2.iommu_table,
>  				pci_domain_nr(phb->hose->bus), phb->opal_id);
> diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platform=
s/powernv/pci.c
> index 609f5b1..c619ec6 100644
> --- a/arch/powerpc/platforms/powernv/pci.c
> +++ b/arch/powerpc/platforms/powernv/pci.c
> @@ -647,18 +647,11 @@ static unsigned long pnv_tce_get(struct iommu_table=
 *tbl, long index)
>  	return ((u64 *)tbl->it_base)[index - tbl->it_offset];
>  }
> =20
> -static int pnv_tce_build_rm(struct iommu_table *tbl, long index, long np=
ages,
> -			    unsigned long uaddr,
> -			    enum dma_data_direction direction,
> -			    struct dma_attrs *attrs)
> -{
> -	return pnv_tce_build(tbl, index, npages, uaddr, direction, attrs, true);
> -}
> -
> -static void pnv_tce_free_rm(struct iommu_table *tbl, long index, long np=
ages)
> -{
> -	pnv_tce_free(tbl, index, npages, true);
> -}
> +struct iommu_table_ops pnv_iommu_ops =3D {
> +	.set =3D pnv_tce_build_vm,
> +	.clear =3D pnv_tce_free_vm,
> +	.get =3D pnv_tce_get,
> +};
> =20
>  void pnv_pci_setup_iommu_table(struct iommu_table *tbl,
>  			       void *tce_mem, u64 tce_size,
> @@ -692,6 +685,7 @@ static struct iommu_table *pnv_pci_setup_bml_iommu(st=
ruct pci_controller *hose)
>  		return NULL;
>  	pnv_pci_setup_iommu_table(tbl, __va(be64_to_cpup(basep)),
>  				  be32_to_cpup(sizep), 0, IOMMU_PAGE_SHIFT_4K);
> +	tbl->it_ops =3D &pnv_iommu_ops;
>  	iommu_init_table(tbl, hose->node);
>  	iommu_register_group(tbl, pci_domain_nr(hose->bus), 0);
> =20
> @@ -817,11 +811,6 @@ void __init pnv_pci_init(void)
> =20
>  	/* Configure IOMMU DMA hooks */
>  	ppc_md.pci_dma_dev_setup =3D pnv_pci_dma_dev_setup;
> -	ppc_md.tce_build =3D pnv_tce_build_vm;
> -	ppc_md.tce_free =3D pnv_tce_free_vm;
> -	ppc_md.tce_build_rm =3D pnv_tce_build_rm;
> -	ppc_md.tce_free_rm =3D pnv_tce_free_rm;
> -	ppc_md.tce_get =3D pnv_tce_get;
>  	set_pci_dma_ops(&dma_iommu_ops);
> =20
>  	/* Configure MSIs */
> diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platform=
s/powernv/pci.h
> index 6c02ff8..f726700 100644
> --- a/arch/powerpc/platforms/powernv/pci.h
> +++ b/arch/powerpc/platforms/powernv/pci.h
> @@ -216,6 +216,7 @@ extern struct pci_ops pnv_pci_ops;
>  #ifdef CONFIG_EEH
>  extern struct pnv_eeh_ops ioda_eeh_ops;
>  #endif
> +extern struct iommu_table_ops pnv_iommu_ops;
> =20
>  void pnv_pci_dump_phb_diag_data(struct pci_controller *hose,
>  				unsigned char *log_buff);
> diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platfo=
rms/pseries/iommu.c
> index 7803a19..48d1fde 100644
> --- a/arch/powerpc/platforms/pseries/iommu.c
> +++ b/arch/powerpc/platforms/pseries/iommu.c
> @@ -192,7 +192,7 @@ static int tce_buildmulti_pSeriesLP(struct iommu_tabl=
e *tbl, long tcenum,
>  	int ret =3D 0;
>  	unsigned long flags;
> =20
> -	if (npages =3D=3D 1) {
> +	if ((npages =3D=3D 1) || !firmware_has_feature(FW_FEATURE_MULTITCE)) {
>  		return tce_build_pSeriesLP(tbl, tcenum, npages, uaddr,
>  		                           direction, attrs);
>  	}
> @@ -284,6 +284,9 @@ static void tce_freemulti_pSeriesLP(struct iommu_tabl=
e *tbl, long tcenum, long n
>  {
>  	u64 rc;
> =20
> +	if (!firmware_has_feature(FW_FEATURE_MULTITCE))
> +		return tce_free_pSeriesLP(tbl, tcenum, npages);
> +
>  	rc =3D plpar_tce_stuff((u64)tbl->it_index, (u64)tcenum << 12, 0, npages=
);
> =20
>  	if (rc && printk_ratelimit()) {
> @@ -459,7 +462,6 @@ static int tce_setrange_multi_pSeriesLP_walk(unsigned=
 long start_pfn,
>  	return tce_setrange_multi_pSeriesLP(start_pfn, num_pfn, arg);
>  }
> =20
> -
>  #ifdef CONFIG_PCI
>  static void iommu_table_setparms(struct pci_controller *phb,
>  				 struct device_node *dn,
> @@ -545,6 +547,12 @@ static void iommu_table_setparms_lpar(struct pci_con=
troller *phb,
>  	tbl->it_size =3D size >> tbl->it_page_shift;
>  }
> =20
> +struct iommu_table_ops iommu_table_pseries_ops =3D {
> +	.set =3D tce_build_pSeries,
> +	.clear =3D tce_free_pSeries,
> +	.get =3D tce_get_pseries
> +};
> +
>  static void pci_dma_bus_setup_pSeries(struct pci_bus *bus)
>  {
>  	struct device_node *dn;
> @@ -613,6 +621,7 @@ static void pci_dma_bus_setup_pSeries(struct pci_bus =
*bus)
>  			   pci->phb->node);
> =20
>  	iommu_table_setparms(pci->phb, dn, tbl);
> +	tbl->it_ops =3D &iommu_table_pseries_ops;
>  	pci->iommu_table =3D iommu_init_table(tbl, pci->phb->node);
>  	iommu_register_group(tbl, pci_domain_nr(bus), 0);
> =20
> @@ -624,6 +633,11 @@ static void pci_dma_bus_setup_pSeries(struct pci_bus=
 *bus)
>  	pr_debug("ISA/IDE, window size is 0x%llx\n", pci->phb->dma_window_size);
>  }
> =20
> +struct iommu_table_ops iommu_table_lpar_multi_ops =3D {
> +	.set =3D tce_buildmulti_pSeriesLP,
> +	.clear =3D tce_freemulti_pSeriesLP,
> +	.get =3D tce_get_pSeriesLP
> +};
> =20
>  static void pci_dma_bus_setup_pSeriesLP(struct pci_bus *bus)
>  {
> @@ -658,6 +672,7 @@ static void pci_dma_bus_setup_pSeriesLP(struct pci_bu=
s *bus)
>  		tbl =3D kzalloc_node(sizeof(struct iommu_table), GFP_KERNEL,
>  				   ppci->phb->node);
>  		iommu_table_setparms_lpar(ppci->phb, pdn, tbl, dma_window);
> +		tbl->it_ops =3D &iommu_table_lpar_multi_ops;
>  		ppci->iommu_table =3D iommu_init_table(tbl, ppci->phb->node);
>  		iommu_register_group(tbl, pci_domain_nr(bus), 0);
>  		pr_debug("  created table: %p\n", ppci->iommu_table);
> @@ -685,6 +700,7 @@ static void pci_dma_dev_setup_pSeries(struct pci_dev =
*dev)
>  		tbl =3D kzalloc_node(sizeof(struct iommu_table), GFP_KERNEL,
>  				   phb->node);
>  		iommu_table_setparms(phb, dn, tbl);
> +		tbl->it_ops =3D &iommu_table_pseries_ops;
>  		PCI_DN(dn)->iommu_table =3D iommu_init_table(tbl, phb->node);
>  		iommu_register_group(tbl, pci_domain_nr(phb->bus), 0);
>  		set_iommu_table_base_and_group(&dev->dev,
> @@ -1107,6 +1123,7 @@ static void pci_dma_dev_setup_pSeriesLP(struct pci_=
dev *dev)
>  		tbl =3D kzalloc_node(sizeof(struct iommu_table), GFP_KERNEL,
>  				   pci->phb->node);
>  		iommu_table_setparms_lpar(pci->phb, pdn, tbl, dma_window);
> +		tbl->it_ops =3D &iommu_table_lpar_multi_ops;
>  		pci->iommu_table =3D iommu_init_table(tbl, pci->phb->node);
>  		iommu_register_group(tbl, pci_domain_nr(pci->phb->bus), 0);
>  		pr_debug("  created table: %p\n", pci->iommu_table);
> @@ -1299,22 +1316,11 @@ void iommu_init_early_pSeries(void)
>  		return;
> =20
>  	if (firmware_has_feature(FW_FEATURE_LPAR)) {
> -		if (firmware_has_feature(FW_FEATURE_MULTITCE)) {
> -			ppc_md.tce_build =3D tce_buildmulti_pSeriesLP;
> -			ppc_md.tce_free	 =3D tce_freemulti_pSeriesLP;
> -		} else {
> -			ppc_md.tce_build =3D tce_build_pSeriesLP;
> -			ppc_md.tce_free	 =3D tce_free_pSeriesLP;
> -		}
> -		ppc_md.tce_get   =3D tce_get_pSeriesLP;
>  		ppc_md.pci_dma_bus_setup =3D pci_dma_bus_setup_pSeriesLP;
>  		ppc_md.pci_dma_dev_setup =3D pci_dma_dev_setup_pSeriesLP;
>  		ppc_md.dma_set_mask =3D dma_set_mask_pSeriesLP;
>  		ppc_md.dma_get_required_mask =3D dma_get_required_mask_pSeriesLP;
>  	} else {
> -		ppc_md.tce_build =3D tce_build_pSeries;
> -		ppc_md.tce_free  =3D tce_free_pSeries;
> -		ppc_md.tce_get   =3D tce_get_pseries;
>  		ppc_md.pci_dma_bus_setup =3D pci_dma_bus_setup_pSeries;
>  		ppc_md.pci_dma_dev_setup =3D pci_dma_dev_setup_pSeries;
>  	}
> @@ -1332,8 +1338,6 @@ static int __init disable_multitce(char *str)
>  	    firmware_has_feature(FW_FEATURE_LPAR) &&
>  	    firmware_has_feature(FW_FEATURE_MULTITCE)) {
>  		printk(KERN_INFO "Disabling MULTITCE firmware feature\n");
> -		ppc_md.tce_build =3D tce_build_pSeriesLP;
> -		ppc_md.tce_free	 =3D tce_free_pSeriesLP;
>  		powerpc_firmware_features &=3D ~FW_FEATURE_MULTITCE;
>  	}
>  	return 1;
> diff --git a/arch/powerpc/sysdev/dart_iommu.c b/arch/powerpc/sysdev/dart_=
iommu.c
> index 9e5353f..ab361a3 100644
> --- a/arch/powerpc/sysdev/dart_iommu.c
> +++ b/arch/powerpc/sysdev/dart_iommu.c
> @@ -286,6 +286,12 @@ static int __init dart_init(struct device_node *dart=
_node)
>  	return 0;
>  }
> =20
> +static struct iommu_table_ops iommu_dart_ops =3D {
> +	.set =3D dart_build,
> +	.clear =3D dart_free,
> +	.flush =3D dart_flush,
> +};
> +
>  static void iommu_table_dart_setup(void)
>  {
>  	iommu_table_dart.it_busno =3D 0;
> @@ -298,6 +304,7 @@ static void iommu_table_dart_setup(void)
>  	iommu_table_dart.it_base =3D (unsigned long)dart_vbase;
>  	iommu_table_dart.it_index =3D 0;
>  	iommu_table_dart.it_blocksize =3D 1;
> +	iommu_table_dart.it_ops =3D &iommu_dart_ops;
>  	iommu_init_table(&iommu_table_dart, -1);
> =20
>  	/* Reserve the last page of the DART to avoid possible prefetch
> @@ -386,11 +393,6 @@ void __init iommu_init_early_dart(void)
>  	if (dart_init(dn) !=3D 0)
>  		goto bail;
> =20
> -	/* Setup low level TCE operations for the core IOMMU code */
> -	ppc_md.tce_build =3D dart_build;
> -	ppc_md.tce_free  =3D dart_free;
> -	ppc_md.tce_flush =3D dart_flush;
> -
>  	/* Setup bypass if supported */
>  	if (dart_is_u4)
>  		ppc_md.dma_set_mask =3D dart_dma_set_mask;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Ms5iOKSBOB9YS8zC
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVLhH+AAoJEGw4ysog2bOSDbQP/3MIZaTgji3a4eHPYXNNz3hf
TzcCNsjEtLh47PuUch5bsa2aBcPnnMcbVlJmiXa7lHREJUFeobY4PS+tiFzScK9U
+xbxsCPcsQlgAOr4kAs0LsIk1ajbpjXZxm2TMHcV7Q+eD+bGSLyy1QGX0rVGYse8
1bqdeKzD41r6MO3FBUp2kRunOzKa0JeRWaZGgmiWiNPpwOnSIMNV3t8iX4tWcQWC
ot4yrlbFWRARsQdQc8SKyYkgdQvSfoSkMBUYZWLV2jSOMkQ5gabM+p9TxFNRWJne
zK8LsfPx3s+8lid1QLBeYlDe/W73Gbz9cEOPqmzkkpGoLeoqi913wczCzqcGzQFi
alxs2GyZzSI+MGVieXhvruHvNFiq3JO30R2Xnmn9oSOZU9Iryhrh6ZUOcF7lj3uj
ay2JeuyFtJ6WBKOpBWQPd6I5GOKGwuGAyx26/5SPsBOzsYUjuxd+TEsXYQuOdOVT
KDJljRSdmSB2lQ7QqVJlBMxw2AIBiGrMAmyvyJFA+q440fOxDIFbTbslo84JytY2
Pfcst7GcbgG0Dib5Txpjw4FtMI5WS358gy6ObtasHa4+qqm0fZ2NI/hnsXqrvZ1m
HmCFiszOj/YjCYhuci6m12OSxSRvFZlNYNVo9K4DwBbpSiWlRnpvJi4gczWBT2Jp
ArblBwdncZKwFkdXZJ7v
=gca4
-----END PGP SIGNATURE-----

--Ms5iOKSBOB9YS8zC--
