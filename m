Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D5D8F1A01E7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Apr 2015 15:50:03 +1000 (AEST)
Date: Wed, 29 Apr 2015 15:30:51 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel v9 23/32] powerpc/powernv/ioda: Define and
 implement DMA table/window management callbacks
Message-ID: <20150429053051.GT32589@voom.redhat.com>
References: <1429964096-11524-1-git-send-email-aik@ozlabs.ru>
 <1429964096-11524-24-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="iiZKCn1f/U0ES2iY"
In-Reply-To: <1429964096-11524-24-git-send-email-aik@ozlabs.ru>
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


--iiZKCn1f/U0ES2iY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 25, 2015 at 10:14:47PM +1000, Alexey Kardashevskiy wrote:
> This extends iommu_table_group_ops by a set of callbacks to support
> dynamic DMA windows management.
>=20
> create_table() creates a TCE table with specific parameters.
> it receives iommu_table_group to know nodeid in order to allocate
> TCE table memory closer to the PHB. The exact format of allocated
> multi-level table might be also specific to the PHB model (not
> the case now though).
> This callback calculated the DMA window offset on a PCI bus from @num
> and stores it in a just created table.
>=20
> set_window() sets the window at specified TVT index + @num on PHB.
>=20
> unset_window() unsets the window from specified TVT.
>=20
> This adds a free() callback to iommu_table_ops to free the memory
> (potentially a tree of tables) allocated for the TCE table.

Doesn't the free callback belong with the previous patch introducing
multi-level tables?

> create_table() and free() are supposed to be called once per
> VFIO container and set_window()/unset_window() are supposed to be
> called for every group in a container.
>=20
> This adds IOMMU capabilities to iommu_table_group such as default
> 32bit window parameters and others.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>  arch/powerpc/include/asm/iommu.h            | 19 ++++++++
>  arch/powerpc/platforms/powernv/pci-ioda.c   | 75 +++++++++++++++++++++++=
+++---
>  arch/powerpc/platforms/powernv/pci-p5ioc2.c | 12 +++--
>  3 files changed, 96 insertions(+), 10 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/=
iommu.h
> index 0f50ee2..7694546 100644
> --- a/arch/powerpc/include/asm/iommu.h
> +++ b/arch/powerpc/include/asm/iommu.h
> @@ -70,6 +70,7 @@ struct iommu_table_ops {
>  	/* get() returns a physical address */
>  	unsigned long (*get)(struct iommu_table *tbl, long index);
>  	void (*flush)(struct iommu_table *tbl);
> +	void (*free)(struct iommu_table *tbl);
>  };
> =20
>  /* These are used by VIO */
> @@ -148,6 +149,17 @@ extern struct iommu_table *iommu_init_table(struct i=
ommu_table * tbl,
>  struct iommu_table_group;
> =20
>  struct iommu_table_group_ops {
> +	long (*create_table)(struct iommu_table_group *table_group,
> +			int num,
> +			__u32 page_shift,
> +			__u64 window_size,
> +			__u32 levels,
> +			struct iommu_table *tbl);
> +	long (*set_window)(struct iommu_table_group *table_group,
> +			int num,
> +			struct iommu_table *tblnew);
> +	long (*unset_window)(struct iommu_table_group *table_group,
> +			int num);
>  	/*
>  	 * Switches ownership from the kernel itself to an external
>  	 * user. While onwership is taken, the kernel cannot use IOMMU itself.
> @@ -160,6 +172,13 @@ struct iommu_table_group {
>  #ifdef CONFIG_IOMMU_API
>  	struct iommu_group *group;
>  #endif
> +	/* Some key properties of IOMMU */
> +	__u32 tce32_start;
> +	__u32 tce32_size;
> +	__u64 pgsizes; /* Bitmap of supported page sizes */
> +	__u32 max_dynamic_windows_supported;
> +	__u32 max_levels;

With this information, table_group seems even more like a bad name.
"iommu_state" maybe?

>  	struct iommu_table tables[IOMMU_TABLE_GROUP_MAX_TABLES];
>  	struct iommu_table_group_ops *ops;
>  };
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/pla=
tforms/powernv/pci-ioda.c
> index cc1d09c..4828837 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -24,6 +24,7 @@
>  #include <linux/msi.h>
>  #include <linux/memblock.h>
>  #include <linux/iommu.h>
> +#include <linux/sizes.h>
> =20
>  #include <asm/sections.h>
>  #include <asm/io.h>
> @@ -1846,6 +1847,7 @@ static struct iommu_table_ops pnv_ioda2_iommu_ops =
=3D {
>  #endif
>  	.clear =3D pnv_ioda2_tce_free,
>  	.get =3D pnv_tce_get,
> +	.free =3D pnv_pci_free_table,
>  };
> =20
>  static void pnv_pci_ioda_setup_opal_tce_kill(struct pnv_phb *phb,
> @@ -1936,6 +1938,8 @@ static void pnv_pci_ioda_setup_dma_pe(struct pnv_ph=
b *phb,
>  				 TCE_PCI_SWINV_PAIR);
> =20
>  	tbl->it_ops =3D &pnv_ioda1_iommu_ops;
> +	pe->table_group.tce32_start =3D tbl->it_offset << tbl->it_page_shift;
> +	pe->table_group.tce32_size =3D tbl->it_size << tbl->it_page_shift;
>  	iommu_init_table(tbl, phb->hose->node);
> =20
>  	if (pe->flags & PNV_IODA_PE_DEV) {
> @@ -1961,7 +1965,7 @@ static void pnv_pci_ioda_setup_dma_pe(struct pnv_ph=
b *phb,
>  }
> =20
>  static long pnv_pci_ioda2_set_window(struct iommu_table_group *table_gro=
up,
> -		struct iommu_table *tbl)
> +		int num, struct iommu_table *tbl)
>  {
>  	struct pnv_ioda_pe *pe =3D container_of(table_group, struct pnv_ioda_pe,
>  			table_group);
> @@ -1972,9 +1976,10 @@ static long pnv_pci_ioda2_set_window(struct iommu_=
table_group *table_group,
>  	const __u64 start_addr =3D tbl->it_offset << tbl->it_page_shift;
>  	const __u64 win_size =3D tbl->it_size << tbl->it_page_shift;
> =20
> -	pe_info(pe, "Setting up window at %llx..%llx "
> +	pe_info(pe, "Setting up window#%d at %llx..%llx "
>  			"pgsize=3D0x%x tablesize=3D0x%lx "
>  			"levels=3D%d levelsize=3D%x\n",
> +			num,
>  			start_addr, start_addr + win_size - 1,
>  			1UL << tbl->it_page_shift, tbl->it_size << 3,
>  			tbl->it_indirect_levels + 1, tbl->it_level_size << 3);
> @@ -1987,7 +1992,7 @@ static long pnv_pci_ioda2_set_window(struct iommu_t=
able_group *table_group,
>  	 */
>  	rc =3D opal_pci_map_pe_dma_window(phb->opal_id,
>  			pe->pe_number,
> -			pe->pe_number << 1,
> +			(pe->pe_number << 1) + num,

Heh, yes, well, that makes it rather clear that only 2 tables are possible.

>  			tbl->it_indirect_levels + 1,
>  			__pa(tbl->it_base),
>  			size << 3,
> @@ -2000,7 +2005,7 @@ static long pnv_pci_ioda2_set_window(struct iommu_t=
able_group *table_group,
>  	pnv_pci_ioda2_tvt_invalidate(pe);
> =20
>  	/* Store fully initialized *tbl (may be external) in PE */
> -	pe->table_group.tables[0] =3D *tbl;
> +	pe->table_group.tables[num] =3D *tbl;

I'm a bit confused by this whole set_window thing.  Is the idea that
with multiple groups in a container you have multiple table_group s
each with different copies of the iommu_table structures, but pointing
to the same actual TCE entries (it_base)?  It seems to me not terribly
obvious when you "create" a table and when you "set" a window.
It's also kind of hard to assess whether the relative lifetimes are
correct of the table_group, struct iommu_table and the actual TCE tables.

Would it make more sense for table_group to become the
non-vfio-specific counterpart to the vfio container?
i.e. representing one set of DMA mappings, which one or more PEs could
be bound to.

>  	return 0;
>  fail:
> @@ -2061,6 +2066,53 @@ static void pnv_pci_ioda2_setup_bypass_pe(struct p=
nv_phb *phb,
>  }
> =20
>  #ifdef CONFIG_IOMMU_API
> +static long pnv_pci_ioda2_create_table(struct iommu_table_group *table_g=
roup,
> +		int num, __u32 page_shift, __u64 window_size, __u32 levels,
> +		struct iommu_table *tbl)
> +{
> +	struct pnv_ioda_pe *pe =3D container_of(table_group, struct pnv_ioda_pe,
> +			table_group);
> +	int nid =3D pe->phb->hose->node;
> +	__u64 bus_offset =3D num ? pe->tce_bypass_base : 0;
> +	long ret;
> +
> +	ret =3D pnv_pci_create_table(table_group, nid, bus_offset, page_shift,
> +			window_size, levels, tbl);
> +	if (ret)
> +		return ret;
> +
> +	tbl->it_ops =3D &pnv_ioda2_iommu_ops;
> +	if (pe->tce_inval_reg)
> +		tbl->it_type |=3D (TCE_PCI_SWINV_CREATE | TCE_PCI_SWINV_FREE);
> +
> +	return 0;
> +}
> +
> +static long pnv_pci_ioda2_unset_window(struct iommu_table_group *table_g=
roup,
> +		int num)
> +{
> +	struct pnv_ioda_pe *pe =3D container_of(table_group, struct pnv_ioda_pe,
> +			table_group);
> +	struct pnv_phb *phb =3D pe->phb;
> +	struct iommu_table *tbl =3D &pe->table_group.tables[num];
> +	long ret;
> +
> +	pe_info(pe, "Removing DMA window #%d\n", num);
> +
> +	ret =3D opal_pci_map_pe_dma_window(phb->opal_id, pe->pe_number,
> +			(pe->pe_number << 1) + num,
> +			0/* levels */, 0/* table address */,
> +			0/* table size */, 0/* page size */);
> +	if (ret)
> +		pe_warn(pe, "Unmapping failed, ret =3D %ld\n", ret);
> +	else
> +		pnv_pci_ioda2_tvt_invalidate(pe);
> +
> +	memset(tbl, 0, sizeof(*tbl));
> +
> +	return ret;
> +}
> +
>  static void pnv_ioda2_take_ownership(struct iommu_table_group *table_gro=
up)
>  {
>  	struct pnv_ioda_pe *pe =3D container_of(table_group, struct pnv_ioda_pe,
> @@ -2080,6 +2132,9 @@ static void pnv_ioda2_release_ownership(struct iomm=
u_table_group *table_group)
>  }
> =20
>  static struct iommu_table_group_ops pnv_pci_ioda2_ops =3D {
> +	.create_table =3D pnv_pci_ioda2_create_table,
> +	.set_window =3D pnv_pci_ioda2_set_window,
> +	.unset_window =3D pnv_pci_ioda2_unset_window,
>  	.take_ownership =3D pnv_ioda2_take_ownership,
>  	.release_ownership =3D pnv_ioda2_release_ownership,
>  };
> @@ -2102,8 +2157,16 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_=
phb *phb,
>  	pe_info(pe, "Setting up 32-bit TCE table at 0..%08x\n",
>  		phb->ioda.m32_pci_base);
> =20
> +	pe->table_group.tce32_start =3D 0;
> +	pe->table_group.tce32_size =3D phb->ioda.m32_pci_base;
> +	pe->table_group.max_dynamic_windows_supported =3D
> +			IOMMU_TABLE_GROUP_MAX_TABLES;
> +	pe->table_group.max_levels =3D POWERNV_IOMMU_MAX_LEVELS;
> +	pe->table_group.pgsizes =3D SZ_4K | SZ_64K | SZ_16M;
> +
>  	rc =3D pnv_pci_create_table(&pe->table_group, pe->phb->hose->node,
> -			0, IOMMU_PAGE_SHIFT_4K, phb->ioda.m32_pci_base,
> +			pe->table_group.tce32_start, IOMMU_PAGE_SHIFT_4K,
> +			pe->table_group.tce32_size,
>  			POWERNV_IOMMU_DEFAULT_LEVELS, tbl);
>  	if (rc) {
>  		pe_err(pe, "Failed to create 32-bit TCE table, err %ld", rc);
> @@ -2119,7 +2182,7 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_p=
hb *phb,
>  	pe->table_group.ops =3D &pnv_pci_ioda2_ops;
>  #endif
> =20
> -	rc =3D pnv_pci_ioda2_set_window(&pe->table_group, tbl);
> +	rc =3D pnv_pci_ioda2_set_window(&pe->table_group, 0, tbl);
>  	if (rc) {
>  		pe_err(pe, "Failed to configure 32-bit TCE table,"
>  		       " err %ld\n", rc);
> diff --git a/arch/powerpc/platforms/powernv/pci-p5ioc2.c b/arch/powerpc/p=
latforms/powernv/pci-p5ioc2.c
> index 7a6fd92..d9de4c7 100644
> --- a/arch/powerpc/platforms/powernv/pci-p5ioc2.c
> +++ b/arch/powerpc/platforms/powernv/pci-p5ioc2.c
> @@ -116,6 +116,8 @@ static void __init pnv_pci_init_p5ioc2_phb(struct dev=
ice_node *np, u64 hub_id,
>  	u64 phb_id;
>  	int64_t rc;
>  	static int primary =3D 1;
> +	struct iommu_table_group *table_group;
> +	struct iommu_table *tbl;
> =20
>  	pr_info(" Initializing p5ioc2 PHB %s\n", np->full_name);
> =20
> @@ -181,14 +183,16 @@ static void __init pnv_pci_init_p5ioc2_phb(struct d=
evice_node *np, u64 hub_id,
>  	pnv_pci_init_p5ioc2_msis(phb);
> =20
>  	/* Setup iommu */
> -	phb->p5ioc2.table_group.tables[0].it_table_group =3D
> -			&phb->p5ioc2.table_group;
> +	table_group =3D &phb->p5ioc2.table_group;
> +	tbl =3D &phb->p5ioc2.table_group.tables[0];
> +	tbl->it_table_group =3D table_group;
> =20
>  	/* Setup TCEs */
>  	phb->dma_dev_setup =3D pnv_pci_p5ioc2_dma_dev_setup;
> -	pnv_pci_setup_iommu_table(&phb->p5ioc2.table_group.tables[0],
> -				  tce_mem, tce_size, 0,
> +	pnv_pci_setup_iommu_table(tbl, tce_mem, tce_size, 0,
>  				  IOMMU_PAGE_SHIFT_4K);
> +	table_group->tce32_start =3D tbl->it_offset << tbl->it_page_shift;
> +	table_group->tce32_size =3D tbl->it_size << tbl->it_page_shift;

Doesn't pgsizes need to be set here (although it will only include 4K,
I'm assuming).

>  }
> =20
>  void __init pnv_pci_init_p5ioc2_hub(struct device_node *np)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--iiZKCn1f/U0ES2iY
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVQGyKAAoJEGw4ysog2bOSjhkP/iYy5aH+plwsiS/R+n8TeQAT
rQelXh40YB7CzCf2Xc6XHn/EaI5yfyE9vkxOeoWHrmPfWDuqkw7w+ZaX8oggS5Tn
K6caPy/Y43GxZW4YyMrZU2fp6yZUkSsgziCTAd4Z1Zu77wTQx01gY/ezt/HnHn8O
U0rkjeXLax/v4jrXEeavPDTSrJbgm7jNxiZyM26rfoc3gWrorc37DMNz4Cw38NWU
aux+ky0CtP7yEJCz0EeNj0xRBON0/z3GzVAMb6fpNe4bYe8LEwa/qocc5Xvs76R0
U4G67r8+VP1KAwe7MX80uNthKZl2RVSMMRLFLBxAAaWsLSnZO5aJLG0m6RQtxVVh
S58zqmjxyNP1IOroqdUF/eYldSdPfa+xuIuGs1rU0t88lgFED3clYbX2/CaWFntW
aseNh+/NewK5BWf/biYT2Z/0qk6JtRXAgoaZ3aeod1WK+vA6bw5iJfqmtD3KC3C3
yg/yVXLElZ0CxY3DRyfJDGcC1nCQVv/L2AGPI7QrxtTdvDDjeDC1awMpXhPkt/i1
8dQKI8+haOC7d9D8PZqRCXxNqGeJX8jrxXXitAWcZt1GkPukfzvhOIvplIXqczKj
cgIktzWFX3UH1RJKW3rRgHMiTrC8/TTXEHC7W2rqprqZRIy0qTgz96kDAtlLOmbu
+RDU2KCmOB89/An+TN+a
=Kkvq
-----END PGP SIGNATURE-----

--iiZKCn1f/U0ES2iY--
