Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 72E631A0054
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Jun 2015 10:05:06 +1000 (AEST)
Date: Tue, 2 Jun 2015 09:50:25 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH kernel v11 27/34] powerpc/powernv: Implement multilevel
 TCE tables
Message-ID: <20150601235025.GQ22789@voom.redhat.com>
References: <1432889098-22924-1-git-send-email-aik@ozlabs.ru>
 <1432889098-22924-28-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="LfQcPIWFRhGivmDw"
In-Reply-To: <1432889098-22924-28-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--LfQcPIWFRhGivmDw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2015 at 06:44:51PM +1000, Alexey Kardashevskiy wrote:
> TCE tables might get too big in case of 4K IOMMU pages and DDW enabled
> on huge guests (hundreds of GB of RAM) so the kernel might be unable to
> allocate contiguous chunk of physical memory to store the TCE table.
>=20
> To address this, POWER8 CPU (actually, IODA2) supports multi-level
> TCE tables, up to 5 levels which splits the table into a tree of
> smaller subtables.
>=20
> This adds multi-level TCE tables support to
> pnv_pci_ioda2_table_alloc_pages() and pnv_pci_ioda2_table_free_pages()
> helpers.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
> Changes:
> v10:
> * fixed multiple comments received for v9
>=20
> v9:
> * moved from ioda2 to common powernv pci code
> * fixed cleanup if allocation fails in a middle
> * removed check for the size - all boundary checks happen in the calling =
code
> anyway
> ---
>  arch/powerpc/include/asm/iommu.h          |  2 +
>  arch/powerpc/platforms/powernv/pci-ioda.c | 98 +++++++++++++++++++++++++=
+++---
>  arch/powerpc/platforms/powernv/pci.c      | 13 ++++
>  3 files changed, 104 insertions(+), 9 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/=
iommu.h
> index 4636734..706cfc0 100644
> --- a/arch/powerpc/include/asm/iommu.h
> +++ b/arch/powerpc/include/asm/iommu.h
> @@ -96,6 +96,8 @@ struct iommu_pool {
>  struct iommu_table {
>  	unsigned long  it_busno;     /* Bus number this table belongs to */
>  	unsigned long  it_size;      /* Size of iommu table in entries */
> +	unsigned long  it_indirect_levels;
> +	unsigned long  it_level_size;
>  	unsigned long  it_offset;    /* Offset into global table */
>  	unsigned long  it_base;      /* mapped address of tce table */
>  	unsigned long  it_index;     /* which iommu table this is */
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/pla=
tforms/powernv/pci-ioda.c
> index fda01c1..68ffc7a 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -49,6 +49,9 @@
>  /* 256M DMA window, 4K TCE pages, 8 bytes TCE */
>  #define TCE32_TABLE_SIZE	((0x10000000 / 0x1000) * 8)
> =20
> +#define POWERNV_IOMMU_DEFAULT_LEVELS	1
> +#define POWERNV_IOMMU_MAX_LEVELS	5
> +
>  static void pnv_pci_ioda2_table_free_pages(struct iommu_table *tbl);
> =20
>  static void pe_level_printk(const struct pnv_ioda_pe *pe, const char *le=
vel,
> @@ -1975,6 +1978,8 @@ static long pnv_pci_ioda2_set_window(struct iommu_t=
able_group *table_group,
>  			table_group);
>  	struct pnv_phb *phb =3D pe->phb;
>  	int64_t rc;
> +	const unsigned long size =3D tbl->it_indirect_levels ?
> +			tbl->it_level_size : tbl->it_size;
>  	const __u64 start_addr =3D tbl->it_offset << tbl->it_page_shift;
>  	const __u64 win_size =3D tbl->it_size << tbl->it_page_shift;
> =20
> @@ -1989,9 +1994,9 @@ static long pnv_pci_ioda2_set_window(struct iommu_t=
able_group *table_group,
>  	rc =3D opal_pci_map_pe_dma_window(phb->opal_id,
>  			pe->pe_number,
>  			pe->pe_number << 1,
> -			1,
> +			tbl->it_indirect_levels + 1,
>  			__pa(tbl->it_base),
> -			tbl->it_size << 3,
> +			size << 3,
>  			IOMMU_PAGE_SIZE(tbl));
>  	if (rc) {
>  		pe_err(pe, "Failed to configure TCE table, err %ld\n", rc);
> @@ -2071,11 +2076,19 @@ static void pnv_pci_ioda_setup_opal_tce_kill(stru=
ct pnv_phb *phb)
>  	phb->ioda.tce_inval_reg =3D ioremap(phb->ioda.tce_inval_reg_phys, 8);
>  }
> =20
> -static __be64 *pnv_pci_ioda2_table_do_alloc_pages(int nid, unsigned shif=
t)
> +static __be64 *pnv_pci_ioda2_table_do_alloc_pages(int nid, unsigned shif=
t,
> +		unsigned levels, unsigned long limit,
> +		unsigned long *tce_table_allocated)
>  {
>  	struct page *tce_mem =3D NULL;
> -	__be64 *addr;
> +	__be64 *addr, *tmp;
>  	unsigned order =3D max_t(unsigned, shift, PAGE_SHIFT) - PAGE_SHIFT;
> +	unsigned long local_allocated =3D 1UL << (order + PAGE_SHIFT);
> +	unsigned entries =3D 1UL << (shift - 3);
> +	long i;
> +
> +	if (*tce_table_allocated >=3D limit)
> +		return NULL;

I'm not quite clear what case this limit logic is trying to catch.

> =20
>  	tce_mem =3D alloc_pages_node(nid, GFP_KERNEL, order);
>  	if (!tce_mem) {
> @@ -2083,31 +2096,69 @@ static __be64 *pnv_pci_ioda2_table_do_alloc_pages=
(int nid, unsigned shift)
>  		return NULL;
>  	}
>  	addr =3D page_address(tce_mem);
> -	memset(addr, 0, 1UL << (order + PAGE_SHIFT));
> +	memset(addr, 0, local_allocated);
> +
> +	--levels;
> +	if (!levels) {
> +		*tce_table_allocated +=3D local_allocated;
> +		return addr;
> +	}
> +
> +	for (i =3D 0; i < entries; ++i) {
> +		tmp =3D pnv_pci_ioda2_table_do_alloc_pages(nid, shift,
> +				levels, limit, tce_table_allocated);
> +		if (!tmp)
> +			break;
> +
> +		addr[i] =3D cpu_to_be64(__pa(tmp) |
> +				TCE_PCI_READ | TCE_PCI_WRITE);
> +	}
> =20
>  	return addr;
>  }
> =20
> +static void pnv_pci_ioda2_table_do_free_pages(unsigned long addr,
> +		unsigned long size, unsigned level);
> +
>  static long pnv_pci_ioda2_table_alloc_pages(int nid, __u64 bus_offset,
> -		__u32 page_shift, __u64 window_size, struct iommu_table *tbl)
> +		__u32 page_shift, __u64 window_size, __u32 levels,
> +		struct iommu_table *tbl)
>  {
>  	void *addr;
> +	unsigned long tce_table_allocated =3D 0, level_shift;
>  	const unsigned window_shift =3D ilog2(window_size);
>  	unsigned entries_shift =3D window_shift - page_shift;
>  	unsigned table_shift =3D max_t(unsigned, entries_shift + 3, PAGE_SHIFT);
>  	const unsigned long tce_table_size =3D 1UL << table_shift;
> =20
> +	if (!levels || (levels > POWERNV_IOMMU_MAX_LEVELS))
> +		return -EINVAL;
> +
>  	if ((window_size > memory_hotplug_max()) || !is_power_of_2(window_size))
>  		return -EINVAL;
> =20
> +	/* Adjust direct table size from window_size and levels */
> +	entries_shift =3D (entries_shift + levels - 1) / levels;
> +	level_shift =3D entries_shift + 3;
> +	level_shift =3D max_t(unsigned, level_shift, PAGE_SHIFT);
> +
>  	/* Allocate TCE table */
> -	addr =3D pnv_pci_ioda2_table_do_alloc_pages(nid, table_shift);
> +	addr =3D pnv_pci_ioda2_table_do_alloc_pages(nid, level_shift,
> +			levels, tce_table_size, &tce_table_allocated);
>  	if (!addr)
>  		return -ENOMEM;

If the do_alloc_pages hits the limit partway through its recursion
this will leak memory.

> =20
> +	if (tce_table_size > tce_table_allocated) {
> +		pnv_pci_ioda2_table_do_free_pages((unsigned long) addr,
> +				1ULL << (level_shift - 3), levels - 1);
> +		return -ENOMEM;

The logic here doesn't quite make sense to me.  Is this trying to
catch the case where do_alloc_pages hit the limit before completing?
Comparing the total memory allocated by all the levels to the amount
that would be allocated by a linear table doesn't seem like a useful
thing to do.

> +	}
> +
>  	/* Setup linux iommu table */
>  	pnv_pci_setup_iommu_table(tbl, addr, tce_table_size, bus_offset,
>  			page_shift);
> +	tbl->it_level_size =3D 1ULL << (level_shift - 3);
> +	tbl->it_indirect_levels =3D levels - 1;
> =20
>  	pr_devel("Created TCE table: ws=3D%08llx ts=3D%lx @%08llx\n",
>  			window_size, tce_table_size, bus_offset);
> @@ -2115,12 +2166,40 @@ static long pnv_pci_ioda2_table_alloc_pages(int n=
id, __u64 bus_offset,
>  	return 0;
>  }
> =20
> +static void pnv_pci_ioda2_table_do_free_pages(unsigned long addr,

Since addr is a virtual address, not a physical one, it should be
passed as a pointer.

> +		unsigned long size, unsigned level)
> +{
> +	addr &=3D ~(TCE_PCI_READ | TCE_PCI_WRITE);
> +
> +	if (level) {
> +		long i;
> +		u64 *tmp =3D (u64 *) addr;
> +
> +		for (i =3D 0; i < size; ++i) {
> +			unsigned long hpa =3D be64_to_cpu(tmp[i]);
> +
> +			if (!(hpa & (TCE_PCI_READ | TCE_PCI_WRITE)))
> +				continue;
> +
> +			pnv_pci_ioda2_table_do_free_pages(
> +					(unsigned long) __va(hpa),
> +					size, level - 1);
> +		}
> +	}
> +
> +	free_pages(addr, get_order(size << 3));
> +}
> +
>  static void pnv_pci_ioda2_table_free_pages(struct iommu_table *tbl)
>  {
> +	const unsigned long size =3D tbl->it_indirect_levels ?
> +			tbl->it_level_size : tbl->it_size;
> +
>  	if (!tbl->it_size)
>  		return;
> =20
> -	free_pages(tbl->it_base, get_order(tbl->it_size << 3));
> +	pnv_pci_ioda2_table_do_free_pages(tbl->it_base, size,
> +			tbl->it_indirect_levels);
>  }
> =20
>  static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
> @@ -2148,7 +2227,8 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_p=
hb *phb,
> =20
>  	/* Setup linux iommu table */
>  	rc =3D pnv_pci_ioda2_table_alloc_pages(pe->phb->hose->node,
> -			0, IOMMU_PAGE_SHIFT_4K, phb->ioda.m32_pci_base, tbl);
> +			0, IOMMU_PAGE_SHIFT_4K, phb->ioda.m32_pci_base,
> +			POWERNV_IOMMU_DEFAULT_LEVELS, tbl);
>  	if (rc) {
>  		pe_err(pe, "Failed to create 32-bit TCE table, err %ld", rc);
>  		goto fail;
> diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platform=
s/powernv/pci.c
> index dce3bfd..d4e59f7 100644
> --- a/arch/powerpc/platforms/powernv/pci.c
> +++ b/arch/powerpc/platforms/powernv/pci.c
> @@ -575,6 +575,19 @@ struct pci_ops pnv_pci_ops =3D {
>  static __be64 *pnv_tce(struct iommu_table *tbl, long idx)
>  {
>  	__be64 *tmp =3D ((__be64 *)tbl->it_base);
> +	int  level =3D tbl->it_indirect_levels;
> +	const long shift =3D ilog2(tbl->it_level_size);
> +	unsigned long mask =3D (tbl->it_level_size - 1) << (level * shift);
> +
> +	while (level) {
> +		int n =3D (idx & mask) >> (level * shift);
> +		unsigned long tce =3D be64_to_cpu(tmp[n]);
> +
> +		tmp =3D __va(tce & ~(TCE_PCI_READ | TCE_PCI_WRITE));
> +		idx &=3D ~mask;
> +		mask >>=3D shift;
> +		--level;
> +	}
> =20
>  	return tmp + idx;
>  }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--LfQcPIWFRhGivmDw
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVbO/BAAoJEGw4ysog2bOScmQP/itj/4hAunEYePO2FiY4Tf04
eIaI1rVOcCGLqPl5j9RHkahZuLRZW8UJyYsBRy+QmBe7i5FtOi0u3vaRAlGwtWj7
AeT2+DPu0eme/A9tyc77brE6pWJRS90N4R6wTce49M/oYBkn3SgJDlE5mCYOaWvz
KSy/Li+KD4I5TEdmmNS5UuUwbLi8jj/BemXfvgq+P6uhRRstwLxnLAJTDJF6fUqH
kReG3oDeWbbRcrWmCGWnw4TSwcR6ZGMX5Ujab03ShgHLHvYBBKK1YFZ1xrD6W2TV
pXQE7fVwIP1jewLhhSQDbOqtrzY9+2OvIpwFn0dr6ZPR+de6bUFGYyxxWOHpKNr5
seSVMeb/3PTEI9EXug2JfB8Gtf/PBYJ+k3tnXa3h3fKwoEbUEgdCcJw02N6gfvwp
j72G5zxaeqHAjqYL9dp4H2XmpNQ1cMhpczQGyBjYuk0vtymj0IHymWDhG1FGxuNr
JMyNQkA2gmonbyc4GcmDzX8SC5A5CWr7wfgegGM1F19cl0T9GM+wN0hHYXEsYlQf
3pwEl/6WwCgeVT5oPaOcQ2iXB97lju0kvdmUNRl24bG/zidiGRMWtvxm9xP542ja
RUQ0xbWImRnoDuzCO63TE+SAKa2LQrBo7f81miXKn2DEzTP+i0KhWs9rCPO/UMB1
SCdQhEn3NE+7ZPljHR9r
=yrqH
-----END PGP SIGNATURE-----

--LfQcPIWFRhGivmDw--
