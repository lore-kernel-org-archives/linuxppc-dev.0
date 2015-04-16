Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 379841A0021
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Apr 2015 15:58:24 +1000 (AEST)
Date: Thu, 16 Apr 2015 15:55:55 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel v8 12/31] powerpc/spapr: vfio: Switch from
 iommu_table to new iommu_table_group
Message-ID: <20150416055555.GC3632@voom.redhat.com>
References: <1428647473-11738-1-git-send-email-aik@ozlabs.ru>
 <1428647473-11738-13-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="0vzXIDBeUiKkjNJl"
In-Reply-To: <1428647473-11738-13-git-send-email-aik@ozlabs.ru>
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


--0vzXIDBeUiKkjNJl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 10, 2015 at 04:30:54PM +1000, Alexey Kardashevskiy wrote:
> Modern IBM POWERPC systems support multiple (currently two) TCE tables
> per IOMMU group (a.k.a. PE). This adds a iommu_table_group container
> for TCE tables. Right now just one table is supported.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>  arch/powerpc/include/asm/iommu.h            |  18 +++--
>  arch/powerpc/kernel/iommu.c                 |  34 ++++----
>  arch/powerpc/platforms/powernv/pci-ioda.c   |  38 +++++----
>  arch/powerpc/platforms/powernv/pci-p5ioc2.c |  17 ++--
>  arch/powerpc/platforms/powernv/pci.c        |   2 +-
>  arch/powerpc/platforms/powernv/pci.h        |   4 +-
>  arch/powerpc/platforms/pseries/iommu.c      |   9 ++-
>  drivers/vfio/vfio_iommu_spapr_tce.c         | 120 ++++++++++++++++++++--=
------
>  8 files changed, 160 insertions(+), 82 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/=
iommu.h
> index eb75726..667aa1a 100644
> --- a/arch/powerpc/include/asm/iommu.h
> +++ b/arch/powerpc/include/asm/iommu.h
> @@ -90,9 +90,7 @@ struct iommu_table {
>  	struct iommu_pool pools[IOMMU_NR_POOLS];
>  	unsigned long *it_map;       /* A simple allocation bitmap for now */
>  	unsigned long  it_page_shift;/* table iommu page size */
> -#ifdef CONFIG_IOMMU_API
> -	struct iommu_group *it_group;
> -#endif
> +	struct iommu_table_group *it_group;
>  	struct iommu_table_ops *it_ops;
>  	void (*set_bypass)(struct iommu_table *tbl, bool enable);
>  };
> @@ -126,14 +124,24 @@ extern void iommu_free_table(struct iommu_table *tb=
l, const char *node_name);
>   */
>  extern struct iommu_table *iommu_init_table(struct iommu_table * tbl,
>  					    int nid);
> +
> +#define IOMMU_TABLE_GROUP_MAX_TABLES	1
> +
> +struct iommu_table_group {
>  #ifdef CONFIG_IOMMU_API
> -extern void iommu_register_group(struct iommu_table *tbl,
> +	struct iommu_group *group;
> +#endif
> +	struct iommu_table tables[IOMMU_TABLE_GROUP_MAX_TABLES];

There's nothing to indicate which of the tables are in use at the
current time.  I mean, it doesn't matter now because there's only one,
but the patch doesn't make a whole lot of sense without that.

> +};
> +
> +#ifdef CONFIG_IOMMU_API
> +extern void iommu_register_group(struct iommu_table_group *table_group,
>  				 int pci_domain_number, unsigned long pe_num);
>  extern int iommu_add_device(struct device *dev);
>  extern void iommu_del_device(struct device *dev);
>  extern int __init tce_iommu_bus_notifier_init(void);
>  #else
> -static inline void iommu_register_group(struct iommu_table *tbl,
> +static inline void iommu_register_group(struct iommu_table_group *table_=
group,
>  					int pci_domain_number,
>  					unsigned long pe_num)
>  {
> diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
> index b39d00a..fd49c8e 100644
> --- a/arch/powerpc/kernel/iommu.c
> +++ b/arch/powerpc/kernel/iommu.c
> @@ -712,17 +712,20 @@ struct iommu_table *iommu_init_table(struct iommu_t=
able *tbl, int nid)
> =20
>  struct iommu_table *iommu_table_alloc(int node)
>  {
> -	struct iommu_table *tbl;
> +	struct iommu_table_group *table_group;
> =20
> -	tbl =3D kzalloc_node(sizeof(struct iommu_table), GFP_KERNEL, node);
> +	table_group =3D kzalloc_node(sizeof(struct iommu_table_group), GFP_KERN=
EL,
> +			   node);
> +	table_group->tables[0].it_group =3D table_group;
> =20
> -	return tbl;
> +	return &table_group->tables[0];
>  }
> =20
>  void iommu_free_table(struct iommu_table *tbl, const char *node_name)

Surely the free function should take a table group rather than a table
as argument.

>  {
>  	unsigned long bitmap_sz;
>  	unsigned int order;
> +	struct iommu_table_group *table_group =3D tbl->it_group;
> =20
>  	if (!tbl || !tbl->it_map) {
>  		printk(KERN_ERR "%s: expected TCE map for %s\n", __func__,
> @@ -738,9 +741,9 @@ void iommu_free_table(struct iommu_table *tbl, const =
char *node_name)
>  		clear_bit(0, tbl->it_map);
> =20
>  #ifdef CONFIG_IOMMU_API
> -	if (tbl->it_group) {
> -		iommu_group_put(tbl->it_group);
> -		BUG_ON(tbl->it_group);
> +	if (table_group->group) {
> +		iommu_group_put(table_group->group);
> +		BUG_ON(table_group->group);
>  	}
>  #endif
> =20
> @@ -756,7 +759,7 @@ void iommu_free_table(struct iommu_table *tbl, const =
char *node_name)
>  	free_pages((unsigned long) tbl->it_map, order);
> =20
>  	/* free table */
> -	kfree(tbl);
> +	kfree(table_group);
>  }
> =20
>  /* Creates TCEs for a user provided buffer.  The user buffer must be
> @@ -903,11 +906,12 @@ EXPORT_SYMBOL_GPL(iommu_direction_to_tce_perm);
>   */
>  static void group_release(void *iommu_data)
>  {
> -	struct iommu_table *tbl =3D iommu_data;
> -	tbl->it_group =3D NULL;
> +	struct iommu_table_group *table_group =3D iommu_data;
> +
> +	table_group->group =3D NULL;
>  }
> =20
> -void iommu_register_group(struct iommu_table *tbl,
> +void iommu_register_group(struct iommu_table_group *table_group,
>  		int pci_domain_number, unsigned long pe_num)
>  {
>  	struct iommu_group *grp;
> @@ -919,8 +923,8 @@ void iommu_register_group(struct iommu_table *tbl,
>  				PTR_ERR(grp));
>  		return;
>  	}
> -	tbl->it_group =3D grp;
> -	iommu_group_set_iommudata(grp, tbl, group_release);
> +	table_group->group =3D grp;
> +	iommu_group_set_iommudata(grp, table_group, group_release);
>  	name =3D kasprintf(GFP_KERNEL, "domain%d-pe%lx",
>  			pci_domain_number, pe_num);
>  	if (!name)
> @@ -1108,7 +1112,7 @@ int iommu_add_device(struct device *dev)
>  	}
> =20
>  	tbl =3D get_iommu_table_base(dev);
> -	if (!tbl || !tbl->it_group) {
> +	if (!tbl || !tbl->it_group || !tbl->it_group->group) {
>  		pr_debug("%s: Skipping device %s with no tbl\n",
>  			 __func__, dev_name(dev));
>  		return 0;
> @@ -1116,7 +1120,7 @@ int iommu_add_device(struct device *dev)
> =20
>  	pr_debug("%s: Adding %s to iommu group %d\n",
>  		 __func__, dev_name(dev),
> -		 iommu_group_id(tbl->it_group));
> +		 iommu_group_id(tbl->it_group->group));
> =20
>  	if (PAGE_SIZE < IOMMU_PAGE_SIZE(tbl)) {
>  		pr_err("%s: Invalid IOMMU page size %lx (%lx) on %s\n",
> @@ -1125,7 +1129,7 @@ int iommu_add_device(struct device *dev)
>  		return -EINVAL;
>  	}
> =20
> -	return iommu_group_add_device(tbl->it_group, dev);
> +	return iommu_group_add_device(tbl->it_group->group, dev);
>  }
>  EXPORT_SYMBOL_GPL(iommu_add_device);
> =20
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/pla=
tforms/powernv/pci-ioda.c
> index 85e64a5..a964c50 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -23,6 +23,7 @@
>  #include <linux/io.h>
>  #include <linux/msi.h>
>  #include <linux/memblock.h>
> +#include <linux/iommu.h>
> =20
>  #include <asm/sections.h>
>  #include <asm/io.h>
> @@ -989,7 +990,7 @@ static void pnv_pci_ioda_dma_dev_setup(struct pnv_phb=
 *phb, struct pci_dev *pdev
> =20
>  	pe =3D &phb->ioda.pe_array[pdn->pe_number];
>  	WARN_ON(get_dma_ops(&pdev->dev) !=3D &dma_iommu_ops);
> -	set_iommu_table_base_and_group(&pdev->dev, &pe->tce32_table);
> +	set_iommu_table_base_and_group(&pdev->dev, &pe->table_group.tables[0]);
>  }
> =20
>  static int pnv_pci_ioda_dma_set_mask(struct pnv_phb *phb,
> @@ -1016,7 +1017,7 @@ static int pnv_pci_ioda_dma_set_mask(struct pnv_phb=
 *phb,
>  	} else {
>  		dev_info(&pdev->dev, "Using 32-bit DMA via iommu\n");
>  		set_dma_ops(&pdev->dev, &dma_iommu_ops);
> -		set_iommu_table_base(&pdev->dev, &pe->tce32_table);
> +		set_iommu_table_base(&pdev->dev, &pe->table_group.tables[0]);
>  	}
>  	*pdev->dev.dma_mask =3D dma_mask;
>  	return 0;
> @@ -1053,9 +1054,10 @@ static void pnv_ioda_setup_bus_dma(struct pnv_ioda=
_pe *pe,
>  	list_for_each_entry(dev, &bus->devices, bus_list) {
>  		if (add_to_iommu_group)
>  			set_iommu_table_base_and_group(&dev->dev,
> -						       &pe->tce32_table);
> +					&pe->table_group.tables[0]);
>  		else
> -			set_iommu_table_base(&dev->dev, &pe->tce32_table);
> +			set_iommu_table_base(&dev->dev,
> +					&pe->table_group.tables[0]);
> =20
>  		if (dev->subordinate)
>  			pnv_ioda_setup_bus_dma(pe, dev->subordinate,
> @@ -1145,8 +1147,8 @@ static void pnv_pci_ioda2_tce_invalidate(struct pnv=
_ioda_pe *pe,
>  void pnv_pci_ioda_tce_invalidate(struct iommu_table *tbl,
>  				 __be64 *startp, __be64 *endp, bool rm)
>  {
> -	struct pnv_ioda_pe *pe =3D container_of(tbl, struct pnv_ioda_pe,
> -					      tce32_table);
> +	struct pnv_ioda_pe *pe =3D container_of(tbl->it_group, struct pnv_ioda_=
pe,
> +					      table_group);
>  	struct pnv_phb *phb =3D pe->phb;
> =20
>  	if (phb->type =3D=3D PNV_PHB_IODA1)
> @@ -1211,8 +1213,11 @@ static void pnv_pci_ioda_setup_dma_pe(struct pnv_p=
hb *phb,
>  		}
>  	}
> =20
> +	/* Setup iommu */
> +	pe->table_group.tables[0].it_group =3D &pe->table_group;
> +
>  	/* Setup linux iommu table */
> -	tbl =3D &pe->tce32_table;
> +	tbl =3D &pe->table_group.tables[0];
>  	pnv_pci_setup_iommu_table(tbl, addr, TCE32_TABLE_SIZE * segs,
>  				  base << 28, IOMMU_PAGE_SHIFT_4K);
> =20
> @@ -1233,7 +1238,8 @@ static void pnv_pci_ioda_setup_dma_pe(struct pnv_ph=
b *phb,
>  	}
>  	tbl->it_ops =3D &pnv_iommu_ops;
>  	iommu_init_table(tbl, phb->hose->node);
> -	iommu_register_group(tbl, phb->hose->global_number, pe->pe_number);
> +	iommu_register_group(&pe->table_group, phb->hose->global_number,
> +			pe->pe_number);
> =20
>  	if (pe->pdev)
>  		set_iommu_table_base_and_group(&pe->pdev->dev, tbl);
> @@ -1251,8 +1257,8 @@ static void pnv_pci_ioda_setup_dma_pe(struct pnv_ph=
b *phb,
> =20
>  static void pnv_pci_ioda2_set_bypass(struct iommu_table *tbl, bool enabl=
e)
>  {
> -	struct pnv_ioda_pe *pe =3D container_of(tbl, struct pnv_ioda_pe,
> -					      tce32_table);
> +	struct pnv_ioda_pe *pe =3D container_of(tbl->it_group, struct pnv_ioda_=
pe,
> +					      table_group);
>  	uint16_t window_id =3D (pe->pe_number << 1 ) + 1;
>  	int64_t rc;
> =20
> @@ -1297,10 +1303,10 @@ static void pnv_pci_ioda2_setup_bypass_pe(struct =
pnv_phb *phb,
>  	pe->tce_bypass_base =3D 1ull << 59;
> =20
>  	/* Install set_bypass callback for VFIO */
> -	pe->tce32_table.set_bypass =3D pnv_pci_ioda2_set_bypass;
> +	pe->table_group.tables[0].set_bypass =3D pnv_pci_ioda2_set_bypass;
> =20
>  	/* Enable bypass by default */
> -	pnv_pci_ioda2_set_bypass(&pe->tce32_table, true);
> +	pnv_pci_ioda2_set_bypass(&pe->table_group.tables[0], true);
>  }
> =20
>  static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
> @@ -1347,8 +1353,11 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_=
phb *phb,
>  		goto fail;
>  	}
> =20
> +	/* Setup iommu */
> +	pe->table_group.tables[0].it_group =3D &pe->table_group;
> +
>  	/* Setup linux iommu table */
> -	tbl =3D &pe->tce32_table;
> +	tbl =3D &pe->table_group.tables[0];
>  	pnv_pci_setup_iommu_table(tbl, addr, tce_table_size, 0,
>  			IOMMU_PAGE_SHIFT_4K);
> =20
> @@ -1367,7 +1376,8 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_p=
hb *phb,
>  	}
>  	tbl->it_ops =3D &pnv_iommu_ops;
>  	iommu_init_table(tbl, phb->hose->node);
> -	iommu_register_group(tbl, phb->hose->global_number, pe->pe_number);
> +	iommu_register_group(&pe->table_group, phb->hose->global_number,
> +			pe->pe_number);
> =20
>  	if (pe->pdev)
>  		set_iommu_table_base_and_group(&pe->pdev->dev, tbl);
> diff --git a/arch/powerpc/platforms/powernv/pci-p5ioc2.c b/arch/powerpc/p=
latforms/powernv/pci-p5ioc2.c
> index 0256fcc..ff68cac 100644
> --- a/arch/powerpc/platforms/powernv/pci-p5ioc2.c
> +++ b/arch/powerpc/platforms/powernv/pci-p5ioc2.c
> @@ -86,14 +86,16 @@ static void pnv_pci_init_p5ioc2_msis(struct pnv_phb *=
phb) { }
>  static void pnv_pci_p5ioc2_dma_dev_setup(struct pnv_phb *phb,
>  					 struct pci_dev *pdev)
>  {
> -	if (phb->p5ioc2.iommu_table.it_map =3D=3D NULL) {
> -		phb->p5ioc2.iommu_table.it_ops =3D &pnv_iommu_ops;
> -		iommu_init_table(&phb->p5ioc2.iommu_table, phb->hose->node);
> -		iommu_register_group(&phb->p5ioc2.iommu_table,
> +	if (phb->p5ioc2.table_group.tables[0].it_map =3D=3D NULL) {
> +		phb->p5ioc2.table_group.tables[0].it_ops =3D &pnv_iommu_ops;
> +		iommu_init_table(&phb->p5ioc2.table_group.tables[0],
> +				phb->hose->node);
> +		iommu_register_group(&phb->p5ioc2.table_group,
>  				pci_domain_nr(phb->hose->bus), phb->opal_id);
>  	}
> =20
> -	set_iommu_table_base_and_group(&pdev->dev, &phb->p5ioc2.iommu_table);
> +	set_iommu_table_base_and_group(&pdev->dev,
> +			&phb->p5ioc2.table_group.tables[0]);
>  }
> =20
>  static void __init pnv_pci_init_p5ioc2_phb(struct device_node *np, u64 h=
ub_id,
> @@ -167,9 +169,12 @@ static void __init pnv_pci_init_p5ioc2_phb(struct de=
vice_node *np, u64 hub_id,
>  	/* Setup MSI support */
>  	pnv_pci_init_p5ioc2_msis(phb);
> =20
> +	/* Setup iommu */
> +	phb->p5ioc2.table_group.tables[0].it_group =3D &phb->p5ioc2.table_group;
> +
>  	/* Setup TCEs */
>  	phb->dma_dev_setup =3D pnv_pci_p5ioc2_dma_dev_setup;
> -	pnv_pci_setup_iommu_table(&phb->p5ioc2.iommu_table,
> +	pnv_pci_setup_iommu_table(&phb->p5ioc2.table_group.tables[0],
>  				  tce_mem, tce_size, 0,
>  				  IOMMU_PAGE_SHIFT_4K);
>  }
> diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platform=
s/powernv/pci.c
> index 1c31ac8..3050cc8 100644
> --- a/arch/powerpc/platforms/powernv/pci.c
> +++ b/arch/powerpc/platforms/powernv/pci.c
> @@ -687,7 +687,7 @@ static struct iommu_table *pnv_pci_setup_bml_iommu(st=
ruct pci_controller *hose)
>  				  be32_to_cpup(sizep), 0, IOMMU_PAGE_SHIFT_4K);
>  	tbl->it_ops =3D &pnv_iommu_ops;
>  	iommu_init_table(tbl, hose->node);
> -	iommu_register_group(tbl, pci_domain_nr(hose->bus), 0);
> +	iommu_register_group(tbl->it_group, pci_domain_nr(hose->bus), 0);
> =20
>  	/* Deal with SW invalidated TCEs when needed (BML way) */
>  	swinvp =3D of_get_property(hose->dn, "linux,tce-sw-invalidate-info",
> diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platform=
s/powernv/pci.h
> index f726700..762d906 100644
> --- a/arch/powerpc/platforms/powernv/pci.h
> +++ b/arch/powerpc/platforms/powernv/pci.h
> @@ -53,7 +53,7 @@ struct pnv_ioda_pe {
>  	/* "Base" iommu table, ie, 4K TCEs, 32-bit DMA */
>  	int			tce32_seg;
>  	int			tce32_segcount;
> -	struct iommu_table	tce32_table;
> +	struct iommu_table_group table_group;
>  	phys_addr_t		tce_inval_reg_phys;
> =20
>  	/* 64-bit TCE bypass region */
> @@ -138,7 +138,7 @@ struct pnv_phb {
> =20
>  	union {
>  		struct {
> -			struct iommu_table iommu_table;
> +			struct iommu_table_group table_group;
>  		} p5ioc2;
> =20
>  		struct {
> diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platfo=
rms/pseries/iommu.c
> index 41a8b14..75ea581 100644
> --- a/arch/powerpc/platforms/pseries/iommu.c
> +++ b/arch/powerpc/platforms/pseries/iommu.c
> @@ -622,7 +622,7 @@ static void pci_dma_bus_setup_pSeries(struct pci_bus =
*bus)
>  	iommu_table_setparms(pci->phb, dn, tbl);
>  	tbl->it_ops =3D &iommu_table_pseries_ops;
>  	pci->iommu_table =3D iommu_init_table(tbl, pci->phb->node);
> -	iommu_register_group(tbl, pci_domain_nr(bus), 0);
> +	iommu_register_group(tbl->it_group, pci_domain_nr(bus), 0);
> =20
>  	/* Divide the rest (1.75GB) among the children */
>  	pci->phb->dma_window_size =3D 0x80000000ul;
> @@ -672,7 +672,7 @@ static void pci_dma_bus_setup_pSeriesLP(struct pci_bu=
s *bus)
>  		iommu_table_setparms_lpar(ppci->phb, pdn, tbl, dma_window);
>  		tbl->it_ops =3D &iommu_table_lpar_multi_ops;
>  		ppci->iommu_table =3D iommu_init_table(tbl, ppci->phb->node);
> -		iommu_register_group(tbl, pci_domain_nr(bus), 0);
> +		iommu_register_group(tbl->it_group, pci_domain_nr(bus), 0);
>  		pr_debug("  created table: %p\n", ppci->iommu_table);
>  	}
>  }
> @@ -699,7 +699,7 @@ static void pci_dma_dev_setup_pSeries(struct pci_dev =
*dev)
>  		iommu_table_setparms(phb, dn, tbl);
>  		tbl->it_ops =3D &iommu_table_pseries_ops;
>  		PCI_DN(dn)->iommu_table =3D iommu_init_table(tbl, phb->node);
> -		iommu_register_group(tbl, pci_domain_nr(phb->bus), 0);
> +		iommu_register_group(tbl->it_group, pci_domain_nr(phb->bus), 0);
>  		set_iommu_table_base_and_group(&dev->dev,
>  					       PCI_DN(dn)->iommu_table);
>  		return;
> @@ -1121,7 +1121,8 @@ static void pci_dma_dev_setup_pSeriesLP(struct pci_=
dev *dev)
>  		iommu_table_setparms_lpar(pci->phb, pdn, tbl, dma_window);
>  		tbl->it_ops =3D &iommu_table_lpar_multi_ops;
>  		pci->iommu_table =3D iommu_init_table(tbl, pci->phb->node);
> -		iommu_register_group(tbl, pci_domain_nr(pci->phb->bus), 0);
> +		iommu_register_group(tbl->it_group,
> +				pci_domain_nr(pci->phb->bus), 0);
>  		pr_debug("  created table: %p\n", pci->iommu_table);
>  	} else {
>  		pr_debug("  found DMA window, table: %p\n", pci->iommu_table);
> diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iomm=
u_spapr_tce.c
> index 244c958..d61aad2 100644
> --- a/drivers/vfio/vfio_iommu_spapr_tce.c
> +++ b/drivers/vfio/vfio_iommu_spapr_tce.c
> @@ -88,7 +88,7 @@ static void decrement_locked_vm(long npages)
>   */
>  struct tce_container {
>  	struct mutex lock;
> -	struct iommu_table *tbl;
> +	struct iommu_group *grp;
>  	bool enabled;
>  	unsigned long locked_pages;
>  };
> @@ -103,13 +103,41 @@ static bool tce_page_is_contained(struct page *page=
, unsigned page_shift)
>  	return (PAGE_SHIFT + compound_order(compound_head(page))) >=3D page_shi=
ft;
>  }
> =20
> +static struct iommu_table *spapr_tce_find_table(
> +		struct tce_container *container,
> +		phys_addr_t ioba)
> +{
> +	long i;
> +	struct iommu_table *ret =3D NULL;
> +	struct iommu_table_group *table_group;
> +
> +	table_group =3D iommu_group_get_iommudata(container->grp);
> +	if (!table_group)
> +		return NULL;
> +
> +	for (i =3D 0; i < IOMMU_TABLE_GROUP_MAX_TABLES; ++i) {
> +		struct iommu_table *tbl =3D &table_group->tables[i];
> +		unsigned long entry =3D ioba >> tbl->it_page_shift;
> +		unsigned long start =3D tbl->it_offset;
> +		unsigned long end =3D start + tbl->it_size;
> +
> +		if ((start <=3D entry) && (entry < end)) {
> +			ret =3D tbl;
> +			break;
> +		}
> +	}
> +
> +	return ret;
> +}
> +
>  static int tce_iommu_enable(struct tce_container *container)
>  {
>  	int ret =3D 0;
>  	unsigned long locked;
> -	struct iommu_table *tbl =3D container->tbl;
> +	struct iommu_table *tbl;
> +	struct iommu_table_group *table_group;
> =20
> -	if (!container->tbl)
> +	if (!container->grp)
>  		return -ENXIO;
> =20
>  	if (!current->mm)
> @@ -143,6 +171,11 @@ static int tce_iommu_enable(struct tce_container *co=
ntainer)
>  	 * as this information is only available from KVM and VFIO is
>  	 * KVM agnostic.
>  	 */
> +	table_group =3D iommu_group_get_iommudata(container->grp);
> +	if (!table_group)
> +		return -ENODEV;
> +
> +	tbl =3D &table_group->tables[0];
>  	locked =3D (tbl->it_size << tbl->it_page_shift) >> PAGE_SHIFT;
>  	ret =3D try_increment_locked_vm(locked);
>  	if (ret)
> @@ -193,15 +226,17 @@ static int tce_iommu_clear(struct tce_container *co=
ntainer,
>  static void tce_iommu_release(void *iommu_data)
>  {
>  	struct tce_container *container =3D iommu_data;
> -	struct iommu_table *tbl =3D container->tbl;
> +	struct iommu_table *tbl;
> +	struct iommu_table_group *table_group;
> =20
> -	WARN_ON(tbl && !tbl->it_group);
> +	WARN_ON(container->grp);
> =20
> -	if (tbl) {
> +	if (container->grp) {
> +		table_group =3D iommu_group_get_iommudata(container->grp);
> +		tbl =3D &table_group->tables[0];
>  		tce_iommu_clear(container, tbl,	tbl->it_offset, tbl->it_size);
> =20
> -		if (tbl->it_group)
> -			tce_iommu_detach_group(iommu_data, tbl->it_group);
> +		tce_iommu_detach_group(iommu_data, container->grp);
>  	}
> =20
>  	tce_iommu_disable(container);
> @@ -329,9 +364,16 @@ static long tce_iommu_ioctl(void *iommu_data,
> =20
>  	case VFIO_IOMMU_SPAPR_TCE_GET_INFO: {
>  		struct vfio_iommu_spapr_tce_info info;
> -		struct iommu_table *tbl =3D container->tbl;
> +		struct iommu_table *tbl;
> +		struct iommu_table_group *table_group;
> =20
> -		if (WARN_ON(!tbl))
> +		if (WARN_ON(!container->grp))
> +			return -ENXIO;
> +
> +		table_group =3D iommu_group_get_iommudata(container->grp);
> +
> +		tbl =3D &table_group->tables[0];
> +		if (WARN_ON_ONCE(!tbl))
>  			return -ENXIO;
> =20
>  		minsz =3D offsetofend(struct vfio_iommu_spapr_tce_info,
> @@ -354,17 +396,12 @@ static long tce_iommu_ioctl(void *iommu_data,
>  	}
>  	case VFIO_IOMMU_MAP_DMA: {
>  		struct vfio_iommu_type1_dma_map param;
> -		struct iommu_table *tbl =3D container->tbl;
> +		struct iommu_table *tbl;
>  		unsigned long tce;
> =20
>  		if (!container->enabled)
>  			return -EPERM;
> =20
> -		if (!tbl)
> -			return -ENXIO;
> -
> -		BUG_ON(!tbl->it_group);
> -
>  		minsz =3D offsetofend(struct vfio_iommu_type1_dma_map, size);
> =20
>  		if (copy_from_user(&param, (void __user *)arg, minsz))
> @@ -377,6 +414,10 @@ static long tce_iommu_ioctl(void *iommu_data,
>  				VFIO_DMA_MAP_FLAG_WRITE))
>  			return -EINVAL;
> =20
> +		tbl =3D spapr_tce_find_table(container, param.iova);
> +		if (!tbl)
> +			return -ENXIO;
> +
>  		if ((param.size & ~IOMMU_PAGE_MASK(tbl)) ||
>  				(param.vaddr & ~IOMMU_PAGE_MASK(tbl)))
>  			return -EINVAL;
> @@ -402,14 +443,11 @@ static long tce_iommu_ioctl(void *iommu_data,
>  	}
>  	case VFIO_IOMMU_UNMAP_DMA: {
>  		struct vfio_iommu_type1_dma_unmap param;
> -		struct iommu_table *tbl =3D container->tbl;
> +		struct iommu_table *tbl;
> =20
>  		if (!container->enabled)
>  			return -EPERM;
> =20
> -		if (WARN_ON(!tbl))
> -			return -ENXIO;
> -
>  		minsz =3D offsetofend(struct vfio_iommu_type1_dma_unmap,
>  				size);
> =20
> @@ -423,6 +461,10 @@ static long tce_iommu_ioctl(void *iommu_data,
>  		if (param.flags)
>  			return -EINVAL;
> =20
> +		tbl =3D spapr_tce_find_table(container, param.iova);
> +		if (!tbl)
> +			return -ENXIO;
> +
>  		if (param.size & ~IOMMU_PAGE_MASK(tbl))
>  			return -EINVAL;
> =20
> @@ -451,10 +493,10 @@ static long tce_iommu_ioctl(void *iommu_data,
>  		mutex_unlock(&container->lock);
>  		return 0;
>  	case VFIO_EEH_PE_OP:
> -		if (!container->tbl || !container->tbl->it_group)
> +		if (!container->grp)
>  			return -ENODEV;
> =20
> -		return vfio_spapr_iommu_eeh_ioctl(container->tbl->it_group,
> +		return vfio_spapr_iommu_eeh_ioctl(container->grp,
>  						  cmd, arg);
>  	}
> =20
> @@ -466,16 +508,15 @@ static int tce_iommu_attach_group(void *iommu_data,
>  {
>  	int ret;
>  	struct tce_container *container =3D iommu_data;
> -	struct iommu_table *tbl =3D iommu_group_get_iommudata(iommu_group);
> +	struct iommu_table_group *table_group;
> =20
> -	BUG_ON(!tbl);
>  	mutex_lock(&container->lock);
> =20
>  	/* pr_debug("tce_vfio: Attaching group #%u to iommu %p\n",
>  			iommu_group_id(iommu_group), iommu_group); */
> -	if (container->tbl) {
> +	if (container->grp) {
>  		pr_warn("tce_vfio: Only one group per IOMMU container is allowed, exis=
ting id=3D%d, attaching id=3D%d\n",
> -				iommu_group_id(container->tbl->it_group),
> +				iommu_group_id(container->grp),
>  				iommu_group_id(iommu_group));
>  		ret =3D -EBUSY;
>  		goto unlock_exit;
> @@ -488,9 +529,15 @@ static int tce_iommu_attach_group(void *iommu_data,
>  		goto unlock_exit;
>  	}
> =20
> -	ret =3D iommu_take_ownership(tbl);
> +	table_group =3D iommu_group_get_iommudata(iommu_group);
> +	if (!table_group) {
> +		ret =3D -ENXIO;
> +		goto unlock_exit;
> +	}
> +
> +	ret =3D iommu_take_ownership(&table_group->tables[0]);
>  	if (!ret)
> -		container->tbl =3D tbl;
> +		container->grp =3D iommu_group;
> =20
>  unlock_exit:
>  	mutex_unlock(&container->lock);
> @@ -502,27 +549,30 @@ static void tce_iommu_detach_group(void *iommu_data,
>  		struct iommu_group *iommu_group)
>  {
>  	struct tce_container *container =3D iommu_data;
> -	struct iommu_table *tbl =3D iommu_group_get_iommudata(iommu_group);
> +	struct iommu_table_group *table_group;
> =20
> -	BUG_ON(!tbl);
>  	mutex_lock(&container->lock);
> -	if (tbl !=3D container->tbl) {
> +	if (iommu_group !=3D container->grp) {
>  		pr_warn("tce_vfio: detaching group #%u, expected group is #%u\n",
>  				iommu_group_id(iommu_group),
> -				iommu_group_id(tbl->it_group));
> +				iommu_group_id(container->grp));
>  		goto unlock_exit;
>  	}
> =20
>  	if (container->enabled) {
>  		pr_warn("tce_vfio: detaching group #%u from enabled container, forcing=
 disable\n",
> -				iommu_group_id(tbl->it_group));
> +				iommu_group_id(container->grp));
>  		tce_iommu_disable(container);
>  	}
> =20
>  	/* pr_debug("tce_vfio: detaching group #%u from iommu %p\n",
>  	   iommu_group_id(iommu_group), iommu_group); */
> -	container->tbl =3D NULL;
> -	iommu_release_ownership(tbl);
> +	container->grp =3D NULL;
> +
> +	table_group =3D iommu_group_get_iommudata(iommu_group);
> +	BUG_ON(!table_group);
> +
> +	iommu_release_ownership(&table_group->tables[0]);
> =20
>  unlock_exit:
>  	mutex_unlock(&container->lock);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--0vzXIDBeUiKkjNJl
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVL07qAAoJEGw4ysog2bOSyfAQANFsW+aAI9omBfjVlq254+0U
iQMhNSohbj4JjUhkJpsdKiYggudLxNdFhQFwvUy7ZI6W81Rj1WZdHoKHSBqAFsUL
Wb2zu58zAgGj+CHOeOO42PVt24XH93KqjZuzpuObA/key5T0ZcADAUfujmE9kBLH
I5Mu3woOYibK0A03QgjFdpjjXScC/sF2Um0r0L5BTusu0anDMZn7cLrscYdngWPt
88OCzgI67iaq3K9lqEZAEtLfIG+TsEitk/PL8tN1mmuZqGlFRZBE1zueNRbJFrTI
j0JTk/41yFcZXN66oBjxzA5UmrsjQEimajKAjIWsId8yTkR0YYkLRrMEJHOZwWLP
alPgv1ChLdVSau9ejLiHehLlm8LbUDIdmS2ZPODMiP/E7woBnqFapaWuaTa6ZUZd
WrdD4KrgO3RRRzpsZ2xXjEcDahjj8FR6/uIpFsdeDcutTv7rZMgxsZQKh5JRXDUb
eKI03d99snwHqsw71TPXZOUc6VEgnUFm6TZ6gvaPlG4jQ0MSrFij0VzJkuMn3ZmU
2Wh3VD4jFnENIda2jbio/io70D12bUlrt/BTWdGoSJSq8iaayYKRXRKWeb+olhoh
B4lxsU868AHFTVxdD/fj8nmH6m4WFGO1U/owY9y6vVkN9Fsfuyayrelef6rB7tkP
PxZtMz442jd0+LqBXOgO
=xuHU
-----END PGP SIGNATURE-----

--0vzXIDBeUiKkjNJl--
