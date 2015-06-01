Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 280B61A016E
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Jun 2015 16:49:08 +1000 (AEST)
Date: Mon, 1 Jun 2015 16:24:17 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH kernel v11 17/34] powerpc/spapr: vfio: Switch from
 iommu_table to new iommu_table_group
Message-ID: <20150601062417.GJ22789@voom.redhat.com>
References: <1432889098-22924-1-git-send-email-aik@ozlabs.ru>
 <1432889098-22924-18-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="nEsDIrWrg+hrB7l1"
In-Reply-To: <1432889098-22924-18-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--nEsDIrWrg+hrB7l1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2015 at 06:44:41PM +1000, Alexey Kardashevskiy wrote:
> Modern IBM POWERPC systems support multiple (currently two) TCE tables
> per IOMMU group (a.k.a. PE). This adds a iommu_table_group container
> for TCE tables. Right now just one table is supported.
>=20
> For IODA, instead of embedding iommu_table, the new iommu_table_group
> keeps pointers to those. The iommu_table structs are allocated
> dynamically now by a pnv_pci_table_alloc() helper as PCI hotplug
> code (for EEH recovery) and SRIOV are supported there.
>=20
> For P5IOC2, both iommu_table_group and iommu_table are embedded into
> PE struct. As there is no EEH and SRIOV support for P5IOC2,
> iommu_free_table() should not be called on iommu_table struct pointers
> so we can keep it embedded in pnv_phb::p5ioc2.
>=20
> For pSeries, this replaces multiple calls of kzalloc_node() with a new
> iommu_pseries_group_alloc() helper and stores the table group struct
> pointer into the pci_dn struct. For release, a iommu_table_group_free()
> helper is added.
>=20
> This moves iommu_table struct allocation from SR-IOV code to
> the generic DMA initialization code in pnv_pci_ioda2_setup_dma_pe.
>=20
> This replaces a single pointer to iommu_group with a list of
> iommu_table_group structs. For now it is just a single iommu_table_group
> in this list but later with TCE table sharing enabled, the list will
> keep all the IOMMU groups which use the particular table. The list
> uses iommu_table_group_link structs rather than iommu_table_group::next
> as a VFIO container may have 2 IOMMU tables, each will have its own list
> head pointer as it is mainly for TCE invalidation code which should
> walk through all attached groups and invalidate TCE cache so
> the table has to keep the list head pointer. The other option would
> be storing list head in a VFIO container but it would not work as
> the platform code (which does TCE table update and invalidation) has
> no idea about VFIO.
>=20
> This should cause no behavioural change.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> [aw: for the vfio related changes]
> Acked-by: Alex Williamson <alex.williamson@redhat.com>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

It looks like this commit message doesn't match the code - it seems
like an older or newer version of the message from the previous patch.

This patch seems instead to be about changing the table_group <-> table
relationship from 1:1 to many:many.

> ---
> Changes:
> v10:
> * iommu_table is not embedded into iommu_table_group but allocated
> dynamically
> * iommu_table allocation is moved to a single place for IODA2's
> pnv_pci_ioda_setup_dma_pe where it belongs to
> * added list of groups into iommu_table; most of the code just looks at
> the first item to keep the patch simpler
>=20
> v9:
> * s/it_group/it_table_group/
> * added and used iommu_table_group_free(), from now iommu_free_table()
> is only used for VIO
> * added iommu_pseries_group_alloc()
> * squashed "powerpc/iommu: Introduce iommu_table_alloc() helper" into this
> ---
>  arch/powerpc/include/asm/iommu.h            |   8 +-
>  arch/powerpc/kernel/iommu.c                 |   9 +-
>  arch/powerpc/platforms/powernv/pci-ioda.c   |  45 ++++++----
>  arch/powerpc/platforms/powernv/pci-p5ioc2.c |   3 +
>  arch/powerpc/platforms/powernv/pci.c        |  76 +++++++++++++++++
>  arch/powerpc/platforms/powernv/pci.h        |   7 ++
>  arch/powerpc/platforms/pseries/iommu.c      |  33 +++++++-
>  drivers/vfio/vfio_iommu_spapr_tce.c         | 122 ++++++++++++++++++++--=
------
>  8 files changed, 242 insertions(+), 61 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/=
iommu.h
> index 5a7267f..44a20cc 100644
> --- a/arch/powerpc/include/asm/iommu.h
> +++ b/arch/powerpc/include/asm/iommu.h
> @@ -91,7 +91,7 @@ struct iommu_table {
>  	struct iommu_pool pools[IOMMU_NR_POOLS];
>  	unsigned long *it_map;       /* A simple allocation bitmap for now */
>  	unsigned long  it_page_shift;/* table iommu page size */
> -	struct iommu_table_group *it_table_group;
> +	struct list_head it_group_list;/* List of iommu_table_group_link */
>  	struct iommu_table_ops *it_ops;
>  	void (*set_bypass)(struct iommu_table *tbl, bool enable);
>  };
> @@ -126,6 +126,12 @@ extern struct iommu_table *iommu_init_table(struct i=
ommu_table * tbl,
>  					    int nid);
>  #define IOMMU_TABLE_GROUP_MAX_TABLES	1
> =20
> +struct iommu_table_group_link {
> +	struct list_head next;
> +	struct rcu_head rcu;
> +	struct iommu_table_group *table_group;
> +};
> +
>  struct iommu_table_group {
>  	struct iommu_group *group;
>  	struct iommu_table *tables[IOMMU_TABLE_GROUP_MAX_TABLES];
> diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
> index 719f048..e305a8f 100644
> --- a/arch/powerpc/kernel/iommu.c
> +++ b/arch/powerpc/kernel/iommu.c
> @@ -1078,6 +1078,7 @@ EXPORT_SYMBOL_GPL(iommu_release_ownership);
>  int iommu_add_device(struct device *dev)
>  {
>  	struct iommu_table *tbl;
> +	struct iommu_table_group_link *tgl;
> =20
>  	/*
>  	 * The sysfs entries should be populated before
> @@ -1095,15 +1096,17 @@ int iommu_add_device(struct device *dev)
>  	}
> =20
>  	tbl =3D get_iommu_table_base(dev);
> -	if (!tbl || !tbl->it_table_group || !tbl->it_table_group->group) {
> +	if (!tbl || list_empty(&tbl->it_group_list)) {
>  		pr_debug("%s: Skipping device %s with no tbl\n",
>  			 __func__, dev_name(dev));
>  		return 0;
>  	}
> =20
> +	tgl =3D list_first_entry_or_null(&tbl->it_group_list,
> +			struct iommu_table_group_link, next);

Plain list_first_entry() would be clearer sensible here, since you've
already eliminated the case of the empty list (and you don't handle
the null case below).

>  	pr_debug("%s: Adding %s to iommu group %d\n",
>  		 __func__, dev_name(dev),
> -		 iommu_group_id(tbl->it_table_group->group));
> +		 iommu_group_id(tgl->table_group->group));
> =20
>  	if (PAGE_SIZE < IOMMU_PAGE_SIZE(tbl)) {
>  		pr_err("%s: Invalid IOMMU page size %lx (%lx) on %s\n",
> @@ -1112,7 +1115,7 @@ int iommu_add_device(struct device *dev)
>  		return -EINVAL;
>  	}
> =20
> -	return iommu_group_add_device(tbl->it_table_group->group, dev);
> +	return iommu_group_add_device(tgl->table_group->group, dev);

This doesn't look right.  IIUC, you're binding the device to the
iommu group associated with the first table group of the table.  The
case of multiple table_groups for a table is where multiple PEs have
been placed in the same container and so have the same mappings and
therefore the same tables.  But the device still has a real, single PE
that it belongs to.  So if there are multiple PEs in the container,
couldn't this pick the wrong group for the device?

>  }
>  EXPORT_SYMBOL_GPL(iommu_add_device);
> =20
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/pla=
tforms/powernv/pci-ioda.c
> index e60e799..44dce79 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -1288,7 +1288,6 @@ static void pnv_pci_ioda2_release_dma_pe(struct pci=
_dev *dev, struct pnv_ioda_pe
>  	struct iommu_table    *tbl;
>  	unsigned long         addr;
>  	int64_t               rc;
> -	struct iommu_table_group *table_group;
> =20
>  	bus =3D dev->bus;
>  	hose =3D pci_bus_to_host(bus);
> @@ -1308,14 +1307,13 @@ static void pnv_pci_ioda2_release_dma_pe(struct p=
ci_dev *dev, struct pnv_ioda_pe
>  	if (rc)
>  		pe_warn(pe, "OPAL error %ld release DMA window\n", rc);
> =20
> -	table_group =3D tbl->it_table_group;
> -	if (table_group->group) {
> -		iommu_group_put(table_group->group);
> -		BUG_ON(table_group->group);
> +	pnv_pci_unlink_table_and_group(tbl, &pe->table_group);
> +	if (pe->table_group.group) {
> +		iommu_ggroup_put(pe->table_group.group);
> +		BUG_ON(pe->table_group.group);
>  	}
>  	iommu_free_table(tbl, of_node_full_name(dev->dev.of_node));
>  	free_pages(addr, get_order(TCE32_TABLE_SIZE));
> -	pe->table_group.tables[0] =3D NULL;
>  }
> =20
>  static void pnv_ioda_release_vf_PE(struct pci_dev *pdev, u16 num_vfs)
> @@ -1675,7 +1673,10 @@ static void pnv_ioda_setup_bus_dma(struct pnv_ioda=
_pe *pe,
>  static void pnv_pci_ioda1_tce_invalidate(struct iommu_table *tbl,
>  		unsigned long index, unsigned long npages, bool rm)
>  {
> -	struct pnv_ioda_pe *pe =3D container_of(tbl->it_table_group,
> +	struct iommu_table_group_link *tgl =3D list_first_entry_or_null(
> +			&tbl->it_group_list, struct iommu_table_group_link,
> +			next);
> +	struct pnv_ioda_pe *pe =3D container_of(tgl->table_group,
>  			struct pnv_ioda_pe, table_group);

For the invalidate case, the thing you're invalidating is caches at
the PE level, yes?  So don't you need to do the invalidate for every
table_group - and therefore every PE - to which the table belongs?

>  	__be64 __iomem *invalidate =3D rm ?
>  		(__be64 __iomem *)pe->tce_inval_reg_phys :
> @@ -1753,7 +1754,10 @@ static struct iommu_table_ops pnv_ioda1_iommu_ops =
=3D {
>  static void pnv_pci_ioda2_tce_invalidate(struct iommu_table *tbl,
>  		unsigned long index, unsigned long npages, bool rm)
>  {
> -	struct pnv_ioda_pe *pe =3D container_of(tbl->it_table_group,
> +	struct iommu_table_group_link *tgl =3D list_first_entry_or_null(
> +			&tbl->it_group_list, struct iommu_table_group_link,
> +			next);
> +	struct pnv_ioda_pe *pe =3D container_of(tgl->table_group,
>  			struct pnv_ioda_pe, table_group);
>  	unsigned long start, end, inc;
>  	__be64 __iomem *invalidate =3D rm ?
> @@ -1830,12 +1834,10 @@ static void pnv_pci_ioda_setup_dma_pe(struct pnv_=
phb *phb,
>  	if (WARN_ON(pe->tce32_seg >=3D 0))
>  		return;
> =20
> -	tbl =3D kzalloc_node(sizeof(struct iommu_table), GFP_KERNEL,
> -			phb->hose->node);
> -	tbl->it_table_group =3D &pe->table_group;
> -	pe->table_group.tables[0] =3D tbl;
> +	tbl =3D pnv_pci_table_alloc(phb->hose->node);
>  	iommu_register_group(&pe->table_group, phb->hose->global_number,
>  			pe->pe_number);
> +	pnv_pci_link_table_and_group(phb->hose->node, 0, tbl, &pe->table_group);
> =20
>  	/* Grab a 32-bit TCE table */
>  	pe->tce32_seg =3D base;
> @@ -1910,11 +1912,18 @@ static void pnv_pci_ioda_setup_dma_pe(struct pnv_=
phb *phb,
>  		pe->tce32_seg =3D -1;
>  	if (tce_mem)
>  		__free_pages(tce_mem, get_order(TCE32_TABLE_SIZE * segs));
> +	if (tbl) {
> +		pnv_pci_unlink_table_and_group(tbl, &pe->table_group);
> +		iommu_free_table(tbl, "pnv");
> +	}
>  }
> =20
>  static void pnv_pci_ioda2_set_bypass(struct iommu_table *tbl, bool enabl=
e)
>  {
> -	struct pnv_ioda_pe *pe =3D container_of(tbl->it_table_group,
> +	struct iommu_table_group_link *tgl =3D list_first_entry_or_null(
> +			&tbl->it_group_list, struct iommu_table_group_link,
> +			next);
> +	struct pnv_ioda_pe *pe =3D container_of(tgl->table_group,
>  			struct pnv_ioda_pe, table_group);

Likewise, IIUC, the bypass magic is set per PE, so don't you need to
iterate through all the PEs.

>  	uint16_t window_id =3D (pe->pe_number << 1 ) + 1;
>  	int64_t rc;
> @@ -1969,12 +1978,10 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv=
_phb *phb,
>  	if (WARN_ON(pe->tce32_seg >=3D 0))
>  		return;
> =20
> -	tbl =3D kzalloc_node(sizeof(struct iommu_table), GFP_KERNEL,
> -			phb->hose->node);
> -	tbl->it_table_group =3D &pe->table_group;
> -	pe->table_group.tables[0] =3D tbl;
> +	tbl =3D pnv_pci_table_alloc(phb->hose->node);
>  	iommu_register_group(&pe->table_group, phb->hose->global_number,
>  			pe->pe_number);
> +	pnv_pci_link_table_and_group(phb->hose->node, 0, tbl, &pe->table_group);
> =20
>  	/* The PE will reserve all possible 32-bits space */
>  	pe->tce32_seg =3D 0;
> @@ -2047,6 +2054,10 @@ fail:
>  		pe->tce32_seg =3D -1;
>  	if (tce_mem)
>  		__free_pages(tce_mem, get_order(tce_table_size));
> +	if (tbl) {
> +		pnv_pci_unlink_table_and_group(tbl, &pe->table_group);
> +		iommu_free_table(tbl, "pnv");
> +	}
>  }
> =20
>  static void pnv_ioda_setup_dma(struct pnv_phb *phb)
> diff --git a/arch/powerpc/platforms/powernv/pci-p5ioc2.c b/arch/powerpc/p=
latforms/powernv/pci-p5ioc2.c
> index 4ea9def..b524b17 100644
> --- a/arch/powerpc/platforms/powernv/pci-p5ioc2.c
> +++ b/arch/powerpc/platforms/powernv/pci-p5ioc2.c
> @@ -99,6 +99,9 @@ static void pnv_pci_p5ioc2_dma_dev_setup(struct pnv_phb=
 *phb,
>  		iommu_init_table(tbl, phb->hose->node);
>  		iommu_register_group(&phb->p5ioc2.table_group,
>  				pci_domain_nr(phb->hose->bus), phb->opal_id);
> +		INIT_LIST_HEAD_RCU(&tbl->it_group_list);
> +		pnv_pci_link_table_and_group(phb->hose->node, 0,
> +				tbl, &phb->p5ioc2.table_group);
>  	}
> =20
>  	set_iommu_table_base(&pdev->dev, tbl);
> diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platform=
s/powernv/pci.c
> index 84b4ea4..4b4c583 100644
> --- a/arch/powerpc/platforms/powernv/pci.c
> +++ b/arch/powerpc/platforms/powernv/pci.c
> @@ -606,6 +606,82 @@ unsigned long pnv_tce_get(struct iommu_table *tbl, l=
ong index)
>  	return ((u64 *)tbl->it_base)[index - tbl->it_offset];
>  }
> =20
> +struct iommu_table *pnv_pci_table_alloc(int nid)
> +{
> +	struct iommu_table *tbl;
> +
> +	tbl =3D kzalloc_node(sizeof(struct iommu_table), GFP_KERNEL, nid);
> +	INIT_LIST_HEAD_RCU(&tbl->it_group_list);
> +
> +	return tbl;
> +}
> +
> +long pnv_pci_link_table_and_group(int node, int num,
> +		struct iommu_table *tbl,
> +		struct iommu_table_group *table_group)

What's pnv specific about this function?

> +{
> +	struct iommu_table_group_link *tgl =3D NULL;
> +
> +	BUG_ON(!tbl);
> +	BUG_ON(!table_group);
> +	BUG_ON(!table_group->group);
> +
> +	tgl =3D kzalloc_node(sizeof(struct iommu_table_group_link), GFP_KERNEL,
> +			node);
> +	if (!tgl)
> +		return -ENOMEM;
> +
> +	tgl->table_group =3D table_group;
> +	list_add_rcu(&tgl->next, &tbl->it_group_list);
> +
> +	table_group->tables[num] =3D tbl;
> +
> +	return 0;
> +}
> +
> +static void pnv_iommu_table_group_link_free(struct rcu_head *head)
> +{
> +	struct iommu_table_group_link *tgl =3D container_of(head,
> +			struct iommu_table_group_link, rcu);
> +
> +	kfree(tgl);
> +}
> +
> +void pnv_pci_unlink_table_and_group(struct iommu_table *tbl,
> +		struct iommu_table_group *table_group)
> +{
> +	long i;
> +	bool found;
> +	struct iommu_table_group_link *tgl;
> +
> +	if (!tbl || !table_group)
> +		return;
> +
> +	/* Remove link to a group from table's list of attached groups */
> +	found =3D false;
> +	list_for_each_entry_rcu(tgl, &tbl->it_group_list, next) {
> +		if (tgl->table_group =3D=3D table_group) {
> +			list_del_rcu(&tgl->next);
> +			call_rcu(&tgl->rcu, pnv_iommu_table_group_link_free);
> +			found =3D true;
> +			break;
> +		}
> +	}
> +	if (WARN_ON(!found))
> +		return;
> +
> +	/* Clean a pointer to iommu_table in iommu_table_group::tables[] */
> +	found =3D false;
> +	for (i =3D 0; i < IOMMU_TABLE_GROUP_MAX_TABLES; ++i) {
> +		if (table_group->tables[i] =3D=3D tbl) {
> +			table_group->tables[i] =3D NULL;
> +			found =3D true;
> +			break;
> +		}
> +	}
> +	WARN_ON(!found);
> +}
> +
>  void pnv_pci_setup_iommu_table(struct iommu_table *tbl,
>  			       void *tce_mem, u64 tce_size,
>  			       u64 dma_offset, unsigned page_shift)
> diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platform=
s/powernv/pci.h
> index 720cc99..87bdd4f 100644
> --- a/arch/powerpc/platforms/powernv/pci.h
> +++ b/arch/powerpc/platforms/powernv/pci.h
> @@ -213,6 +213,13 @@ int pnv_pci_cfg_read(struct pci_dn *pdn,
>  		     int where, int size, u32 *val);
>  int pnv_pci_cfg_write(struct pci_dn *pdn,
>  		      int where, int size, u32 val);
> +extern struct iommu_table *pnv_pci_table_alloc(int nid);
> +
> +extern long pnv_pci_link_table_and_group(int node, int num,
> +		struct iommu_table *tbl,
> +		struct iommu_table_group *table_group);
> +extern void pnv_pci_unlink_table_and_group(struct iommu_table *tbl,
> +		struct iommu_table_group *table_group);
>  extern void pnv_pci_setup_iommu_table(struct iommu_table *tbl,
>  				      void *tce_mem, u64 tce_size,
>  				      u64 dma_offset, unsigned page_shift);
> diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platfo=
rms/pseries/iommu.c
> index 307d704..b0a9ba4 100644
> --- a/arch/powerpc/platforms/pseries/iommu.c
> +++ b/arch/powerpc/platforms/pseries/iommu.c
> @@ -37,6 +37,7 @@
>  #include <linux/memory.h>
>  #include <linux/of.h>
>  #include <linux/iommu.h>
> +#include <linux/rculist.h>
>  #include <asm/io.h>
>  #include <asm/prom.h>
>  #include <asm/rtas.h>
> @@ -56,6 +57,7 @@ static struct iommu_table_group *iommu_pseries_alloc_gr=
oup(int node)
>  {
>  	struct iommu_table_group *table_group =3D NULL;
>  	struct iommu_table *tbl =3D NULL;
> +	struct iommu_table_group_link *tgl =3D NULL;
> =20
>  	table_group =3D kzalloc_node(sizeof(struct iommu_table_group), GFP_KERN=
EL,
>  			   node);
> @@ -66,12 +68,21 @@ static struct iommu_table_group *iommu_pseries_alloc_=
group(int node)
>  	if (!tbl)
>  		goto fail_exit;
> =20
> -	tbl->it_table_group =3D table_group;
> +	tgl =3D kzalloc_node(sizeof(struct iommu_table_group_link), GFP_KERNEL,
> +			node);
> +	if (!tgl)
> +		goto fail_exit;

> +
> +	INIT_LIST_HEAD_RCU(&tbl->it_group_list);
> +	tgl->table_group =3D table_group;
> +	list_add_rcu(&tgl->next, &tbl->it_group_list);
> +

Can't you use your existing link_table_and_group() helper here?


>  	table_group->tables[0] =3D tbl;
> =20
>  	return table_group;
> =20
>  fail_exit:
> +	kfree(tgl);
>  	kfree(table_group);
>  	kfree(tbl);
> =20
> @@ -82,10 +93,27 @@ static void iommu_pseries_free_group(struct iommu_tab=
le_group *table_group,
>  		const char *node_name)
>  {
>  	struct iommu_table *tbl;
> +	long i;
> =20
>  	if (!table_group)
>  		return;
> =20
> +	for (i =3D 0; i < IOMMU_TABLE_GROUP_MAX_TABLES; ++i) {
> +		tbl =3D table_group->tables[i];
> +
> +		if (tbl) {
> +#ifdef CONFIG_IOMMU_API
> +			struct iommu_table_group_link *tgl, *tmp;
> +
> +			list_for_each_entry_safe(tgl, tmp, &tbl->it_group_list,
> +					next) {
> +				list_del_rcu(&tgl->next);

Don't you only want to remove links to 'table_group' not to every
table group?

> +				kfree(tgl);
> +			}
> +#endif
> +			iommu_free_table(tbl, node_name);
> +		}
> +	}
>  #ifdef CONFIG_IOMMU_API
>  	if (table_group->group) {
>  		iommu_group_put(table_group->group);
> @@ -93,9 +121,6 @@ static void iommu_pseries_free_group(struct iommu_tabl=
e_group *table_group,
>  	}
>  #endif
> =20
> -	tbl =3D table_group->tables[0];
> -	iommu_free_table(tbl, node_name);
> -
>  	kfree(table_group);
>  }
> =20
> diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iomm=
u_spapr_tce.c
> index bd87e46..ed3310b 100644
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
> @@ -103,13 +103,42 @@ static bool tce_page_is_contained(struct page *page=
, unsigned page_shift)
>  	return (PAGE_SHIFT + compound_order(compound_head(page))) >=3D page_shi=
ft;
>  }
> =20
> +static long tce_iommu_find_table(struct tce_container *container,
> +		phys_addr_t ioba, struct iommu_table **ptbl)
> +{
> +	long i;
> +	struct iommu_table_group *table_group;
> +
> +	table_group =3D iommu_group_get_iommudata(container->grp);
> +	if (!table_group)
> +		return -1;
> +
> +	for (i =3D 0; i < IOMMU_TABLE_GROUP_MAX_TABLES; ++i) {
> +		struct iommu_table *tbl =3D table_group->tables[i];
> +
> +		if (tbl) {
> +			unsigned long entry =3D ioba >> tbl->it_page_shift;
> +			unsigned long start =3D tbl->it_offset;
> +			unsigned long end =3D start + tbl->it_size;
> +
> +			if ((start <=3D entry) && (entry < end)) {
> +				*ptbl =3D tbl;
> +				return i;
> +			}
> +		}
> +	}
> +
> +	return -1;
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
> @@ -143,6 +172,11 @@ static int tce_iommu_enable(struct tce_container *co=
ntainer)
>  	 * as this information is only available from KVM and VFIO is
>  	 * KVM agnostic.
>  	 */
> +	table_group =3D iommu_group_get_iommudata(container->grp);
> +	if (!table_group)
> +		return -ENODEV;
> +
> +	tbl =3D table_group->tables[0];
>  	locked =3D (tbl->it_size << tbl->it_page_shift) >> PAGE_SHIFT;
>  	ret =3D try_increment_locked_vm(locked);
>  	if (ret)
> @@ -190,11 +224,10 @@ static void tce_iommu_release(void *iommu_data)
>  {
>  	struct tce_container *container =3D iommu_data;
> =20
> -	WARN_ON(container->tbl && !container->tbl->it_table_group->group);
> +	WARN_ON(container->grp);
> =20
> -	if (container->tbl && container->tbl->it_table_group->group)
> -		tce_iommu_detach_group(iommu_data,
> -				container->tbl->it_table_group->group);
> +	if (container->grp)
> +		tce_iommu_detach_group(iommu_data, container->grp);
> =20
>  	tce_iommu_disable(container);
>  	mutex_destroy(&container->lock);
> @@ -312,9 +345,16 @@ static long tce_iommu_ioctl(void *iommu_data,
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
> +		tbl =3D table_group->tables[0];
> +		if (WARN_ON_ONCE(!tbl))
>  			return -ENXIO;
> =20
>  		minsz =3D offsetofend(struct vfio_iommu_spapr_tce_info,
> @@ -337,17 +377,13 @@ static long tce_iommu_ioctl(void *iommu_data,
>  	}
>  	case VFIO_IOMMU_MAP_DMA: {
>  		struct vfio_iommu_type1_dma_map param;
> -		struct iommu_table *tbl =3D container->tbl;
> +		struct iommu_table *tbl =3D NULL;
>  		unsigned long tce;
> +		long num;
> =20
>  		if (!container->enabled)
>  			return -EPERM;
> =20
> -		if (!tbl)
> -			return -ENXIO;
> -
> -		BUG_ON(!tbl->it_table_group->group);
> -
>  		minsz =3D offsetofend(struct vfio_iommu_type1_dma_map, size);
> =20
>  		if (copy_from_user(&param, (void __user *)arg, minsz))
> @@ -360,6 +396,10 @@ static long tce_iommu_ioctl(void *iommu_data,
>  				VFIO_DMA_MAP_FLAG_WRITE))
>  			return -EINVAL;
> =20
> +		num =3D tce_iommu_find_table(container, param.iova, &tbl);
> +		if (num < 0)
> +			return -ENXIO;
> +
>  		if ((param.size & ~IOMMU_PAGE_MASK(tbl)) ||
>  				(param.vaddr & ~IOMMU_PAGE_MASK(tbl)))
>  			return -EINVAL;
> @@ -385,14 +425,12 @@ static long tce_iommu_ioctl(void *iommu_data,
>  	}
>  	case VFIO_IOMMU_UNMAP_DMA: {
>  		struct vfio_iommu_type1_dma_unmap param;
> -		struct iommu_table *tbl =3D container->tbl;
> +		struct iommu_table *tbl =3D NULL;
> +		long num;
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
> @@ -406,6 +444,10 @@ static long tce_iommu_ioctl(void *iommu_data,
>  		if (param.flags)
>  			return -EINVAL;
> =20
> +		num =3D tce_iommu_find_table(container, param.iova, &tbl);
> +		if (num < 0)
> +			return -ENXIO;
> +
>  		if (param.size & ~IOMMU_PAGE_MASK(tbl))
>  			return -EINVAL;
> =20
> @@ -434,12 +476,11 @@ static long tce_iommu_ioctl(void *iommu_data,
>  		mutex_unlock(&container->lock);
>  		return 0;
>  	case VFIO_EEH_PE_OP:
> -		if (!container->tbl || !container->tbl->it_table_group->group)
> +		if (!container->grp)
>  			return -ENODEV;
> =20
> -		return vfio_spapr_iommu_eeh_ioctl(
> -				container->tbl->it_table_group->group,
> -				cmd, arg);
> +		return vfio_spapr_iommu_eeh_ioctl(container->grp,
> +						  cmd, arg);
>  	}
> =20
>  	return -ENOTTY;
> @@ -450,17 +491,15 @@ static int tce_iommu_attach_group(void *iommu_data,
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
> -				iommu_group_id(container->tbl->
> -						it_table_group->group),
> +				iommu_group_id(container->grp),
>  				iommu_group_id(iommu_group));
>  		ret =3D -EBUSY;
>  		goto unlock_exit;
> @@ -473,9 +512,15 @@ static int tce_iommu_attach_group(void *iommu_data,
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
> +	ret =3D iommu_take_ownership(table_group->tables[0]);
>  	if (!ret)
> -		container->tbl =3D tbl;
> +		container->grp =3D iommu_group;
> =20
>  unlock_exit:
>  	mutex_unlock(&container->lock);
> @@ -487,26 +532,31 @@ static void tce_iommu_detach_group(void *iommu_data,
>  		struct iommu_group *iommu_group)
>  {
>  	struct tce_container *container =3D iommu_data;
> -	struct iommu_table *tbl =3D iommu_group_get_iommudata(iommu_group);
> +	struct iommu_table_group *table_group;
> +	struct iommu_table *tbl;
> =20
> -	BUG_ON(!tbl);
>  	mutex_lock(&container->lock);
> -	if (tbl !=3D container->tbl) {
> +	if (iommu_group !=3D container->grp) {
>  		pr_warn("tce_vfio: detaching group #%u, expected group is #%u\n",
>  				iommu_group_id(iommu_group),
> -				iommu_group_id(tbl->it_table_group->group));
> +				iommu_group_id(container->grp));
>  		goto unlock_exit;
>  	}
> =20
>  	if (container->enabled) {
>  		pr_warn("tce_vfio: detaching group #%u from enabled container, forcing=
 disable\n",
> -				iommu_group_id(tbl->it_table_group->group));
> +				iommu_group_id(container->grp));
>  		tce_iommu_disable(container);
>  	}
> =20
>  	/* pr_debug("tce_vfio: detaching group #%u from iommu %p\n",
>  	   iommu_group_id(iommu_group), iommu_group); */
> -	container->tbl =3D NULL;
> +	container->grp =3D NULL;
> +
> +	table_group =3D iommu_group_get_iommudata(iommu_group);
> +	BUG_ON(!table_group);
> +
> +	tbl =3D table_group->tables[0];
>  	tce_iommu_clear(container, tbl, tbl->it_offset, tbl->it_size);
>  	iommu_release_ownership(tbl);
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--nEsDIrWrg+hrB7l1
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVa/qRAAoJEGw4ysog2bOSohUP/1ieZzXutb/bmt7uESiPinr/
a4jP8LEPCw+6d2+EySOz2UZvnMZ+zIkW5XtQ1GzrbINvzrS4m7HIH0AA3Xc4X1ko
Wg5CbR9KMw8j8G/OpZnhi98eEO2nAwUQJgQxcfD3rFaoR6REC2WpbKqr9pRUdxes
CcoaPKEzOTP+vD7C1IPaJ7pST8Yho3Iw9fyQI53gfd1EILstz4Pi7kLjEvrcl4H6
zUirW15NtTFM5LtbZUx5UyP6xozQlVWq1os/SOoMDRwPXQcT/5OCTZe5G2qNTQBl
cqjzQfLqP4bZujoGOHFtZv2Q9vLVWDQgFBIDxWUmDYNzD0PF6D3LMYW3x8W0nEtD
cZq0K5TzSwK1yZnNn6f4kwIcKdw49Tb3tCLpnJt9tfS9DB5ruzVJCWoUOruHe4td
Xtt4cpwA04tURTzT6dvEwDeFec6cpiMfog2E2MTe5t4hJD9EsQL+hvAa1B/R8qlS
gKx+zsZWnQ0/G+NGG9rJ0vfKh99tWWHSvu/HMQdaMDxL38CqCQTd0z6nIvI5kvxQ
wL3OHDzMgbs3kBJPytXCf6KBfZEn20jAmrvQcBbZWNkElCYVr5+7FIicfDf1wgAO
ISqhMaXAkSuSj5CdCDHN6CiJg0nuCopbpzJm+mqQrs4woDKjTNRXN8hd0t1HdmWu
BSWUUfSAs1HccPPDpAbS
=OQWZ
-----END PGP SIGNATURE-----

--nEsDIrWrg+hrB7l1--
