Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 414ddH3YSszF3rG
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jun 2018 15:25:39 +1000 (AEST)
Date: Tue, 12 Jun 2018 14:17:00 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH kernel 6/6] powerpc/powernv/ioda: Allocate indirect TCE
 levels on demand
Message-ID: <20180612041700.GZ2737@umbus.fritz.box>
References: <20180608054633.18659-1-aik@ozlabs.ru>
 <20180608054633.18659-7-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="E0GpUEom8qu4+vDz"
In-Reply-To: <20180608054633.18659-7-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--E0GpUEom8qu4+vDz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 08, 2018 at 03:46:33PM +1000, Alexey Kardashevskiy wrote:
> At the moment we allocate the entire TCE table, twice (hardware part and
> userspace translation cache). This normally works as we normally have
> contigous memory and the guest will map entire RAM for 64bit DMA.
>=20
> However if we have sparse RAM (one example is a memory device), then
> we will allocate TCEs which will never be used as the guest only maps
> actual memory for DMA. If it is a single level TCE table, there is nothing
> we can really do but if it a multilevel table, we can skip allocating
> TCEs we know we won't need.
>=20
> This adds ability to allocate only first level, saving memory.
>=20
> This changes iommu_table::free() to avoid allocating of an extra level;
> iommu_table::set() will do this when needed.
>=20
> This adds @alloc parameter to iommu_table::exchange() to tell the callback
> if it can allocate an extra level; the flag is set to "false" for
> the realmode KVM handlers of H_PUT_TCE hcalls and the callback returns
> H_TOO_HARD.
>=20
> This still requires the entire table to be counted in mm::locked_vm.
>=20
> To be conservative, this only does on-demand allocation when
> the usespace cache table is requested which is the case of VFIO.
>=20
> The example math for a system replicating a powernv setup with NVLink2
> in a guest:
> 16GB RAM mapped at 0x0
> 128GB GPU RAM window (16GB of actual RAM) mapped at 0x244000000000
>=20
> the table to cover that all with 64K pages takes:
> (((0x244000000000 + 0x2000000000) >> 16)*8)>>20 =3D 4556MB
>=20
> If we allocate only necessary TCE levels, we will only need:
> (((0x400000000 + 0x400000000) >> 16)*8)>>20 =3D 4MB (plus some for indire=
ct
> levels).
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>  arch/powerpc/include/asm/iommu.h              |  7 ++-
>  arch/powerpc/platforms/powernv/pci.h          |  6 ++-
>  arch/powerpc/kvm/book3s_64_vio_hv.c           |  4 +-
>  arch/powerpc/platforms/powernv/pci-ioda-tce.c | 69 ++++++++++++++++++++-=
------
>  arch/powerpc/platforms/powernv/pci-ioda.c     |  8 ++--
>  drivers/vfio/vfio_iommu_spapr_tce.c           |  2 +-
>  6 files changed, 69 insertions(+), 27 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/=
iommu.h
> index 4bdcf22..daa3ee5 100644
> --- a/arch/powerpc/include/asm/iommu.h
> +++ b/arch/powerpc/include/asm/iommu.h
> @@ -70,7 +70,7 @@ struct iommu_table_ops {
>  			unsigned long *hpa,
>  			enum dma_data_direction *direction);
> =20
> -	__be64 *(*useraddrptr)(struct iommu_table *tbl, long index);
> +	__be64 *(*useraddrptr)(struct iommu_table *tbl, long index, bool alloc);
>  #endif
>  	void (*clear)(struct iommu_table *tbl,
>  			long index, long npages);
> @@ -122,10 +122,13 @@ struct iommu_table {
>  	__be64 *it_userspace; /* userspace view of the table */
>  	struct iommu_table_ops *it_ops;
>  	struct kref    it_kref;
> +	int it_nid;
>  };
> =20
> +#define IOMMU_TABLE_USERSPACE_ENTRY_RM(tbl, entry) \
> +		((tbl)->it_ops->useraddrptr((tbl), (entry), false))

Is real mode really the only case where you want to inhibit new
allocations?  I would have thought some paths would be read-only and
you wouldn't want to allocate, even in virtual mode.

>  #define IOMMU_TABLE_USERSPACE_ENTRY(tbl, entry) \
> -		((tbl)->it_ops->useraddrptr((tbl), (entry)))
> +		((tbl)->it_ops->useraddrptr((tbl), (entry), true))
> =20
>  /* Pure 2^n version of get_order */
>  static inline __attribute_const__
> diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platform=
s/powernv/pci.h
> index 5e02408..1fa5590 100644
> --- a/arch/powerpc/platforms/powernv/pci.h
> +++ b/arch/powerpc/platforms/powernv/pci.h
> @@ -267,8 +267,10 @@ extern int pnv_tce_build(struct iommu_table *tbl, lo=
ng index, long npages,
>  		unsigned long attrs);
>  extern void pnv_tce_free(struct iommu_table *tbl, long index, long npage=
s);
>  extern int pnv_tce_xchg(struct iommu_table *tbl, long index,
> -		unsigned long *hpa, enum dma_data_direction *direction);
> -extern __be64 *pnv_tce_useraddrptr(struct iommu_table *tbl, long index);
> +		unsigned long *hpa, enum dma_data_direction *direction,
> +		bool alloc);
> +extern __be64 *pnv_tce_useraddrptr(struct iommu_table *tbl, long index,
> +		bool alloc);
>  extern unsigned long pnv_tce_get(struct iommu_table *tbl, long index);
> =20
>  extern long pnv_pci_ioda2_table_alloc_pages(int nid, __u64 bus_offset,
> diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/book3=
s_64_vio_hv.c
> index db0490c..05b4865 100644
> --- a/arch/powerpc/kvm/book3s_64_vio_hv.c
> +++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
> @@ -200,7 +200,7 @@ static long kvmppc_rm_tce_iommu_mapped_dec(struct kvm=
 *kvm,
>  {
>  	struct mm_iommu_table_group_mem_t *mem =3D NULL;
>  	const unsigned long pgsize =3D 1ULL << tbl->it_page_shift;
> -	__be64 *pua =3D IOMMU_TABLE_USERSPACE_ENTRY(tbl, entry);
> +	__be64 *pua =3D IOMMU_TABLE_USERSPACE_ENTRY_RM(tbl, entry);
> =20
>  	if (!pua)
>  		/* it_userspace allocation might be delayed */
> @@ -264,7 +264,7 @@ static long kvmppc_rm_tce_iommu_do_map(struct kvm *kv=
m, struct iommu_table *tbl,
>  {
>  	long ret;
>  	unsigned long hpa =3D 0;
> -	__be64 *pua =3D IOMMU_TABLE_USERSPACE_ENTRY(tbl, entry);
> +	__be64 *pua =3D IOMMU_TABLE_USERSPACE_ENTRY_RM(tbl, entry);
>  	struct mm_iommu_table_group_mem_t *mem;
> =20
>  	if (!pua)
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda-tce.c b/arch/powerpc=
/platforms/powernv/pci-ioda-tce.c
> index 36c2eb0..a7debfb 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda-tce.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda-tce.c
> @@ -48,7 +48,7 @@ static __be64 *pnv_alloc_tce_level(int nid, unsigned in=
t shift)
>  	return addr;
>  }
> =20
> -static __be64 *pnv_tce(struct iommu_table *tbl, bool user, long idx)
> +static __be64 *pnv_tce(struct iommu_table *tbl, bool user, long idx, boo=
l alloc)
>  {
>  	__be64 *tmp =3D user ? tbl->it_userspace : (__be64 *) tbl->it_base;
>  	int  level =3D tbl->it_indirect_levels;
> @@ -57,7 +57,20 @@ static __be64 *pnv_tce(struct iommu_table *tbl, bool u=
ser, long idx)
> =20
>  	while (level) {
>  		int n =3D (idx & mask) >> (level * shift);
> -		unsigned long tce =3D be64_to_cpu(tmp[n]);
> +		unsigned long tce;
> +
> +		if (tmp[n] =3D=3D 0) {
> +			__be64 *tmp2;
> +
> +			if (!alloc)
> +				return NULL;
> +
> +			tmp2 =3D pnv_alloc_tce_level(tbl->it_nid,
> +					ilog2(tbl->it_level_size) + 3);

What if the allocation fails?

> +			tmp[n] =3D cpu_to_be64(__pa(tmp2) |
> +					TCE_PCI_READ | TCE_PCI_WRITE);
> +		}
> +		tce =3D be64_to_cpu(tmp[n]);
> =20
>  		tmp =3D __va(tce & ~(TCE_PCI_READ | TCE_PCI_WRITE));
>  		idx &=3D ~mask;
> @@ -84,7 +97,7 @@ int pnv_tce_build(struct iommu_table *tbl, long index, =
long npages,
>  			((rpn + i) << tbl->it_page_shift);
>  		unsigned long idx =3D index - tbl->it_offset + i;
> =20
> -		*(pnv_tce(tbl, false, idx)) =3D cpu_to_be64(newtce);
> +		*(pnv_tce(tbl, false, idx, true)) =3D cpu_to_be64(newtce);
>  	}
> =20
>  	return 0;
> @@ -92,31 +105,45 @@ int pnv_tce_build(struct iommu_table *tbl, long inde=
x, long npages,
> =20
>  #ifdef CONFIG_IOMMU_API
>  int pnv_tce_xchg(struct iommu_table *tbl, long index,
> -		unsigned long *hpa, enum dma_data_direction *direction)
> +		unsigned long *hpa, enum dma_data_direction *direction,
> +		bool alloc)
>  {
>  	u64 proto_tce =3D iommu_direction_to_tce_perm(*direction);
>  	unsigned long newtce =3D *hpa | proto_tce, oldtce;
>  	unsigned long idx =3D index - tbl->it_offset;
> +	__be64 *ptce;
> =20
>  	BUG_ON(*hpa & ~IOMMU_PAGE_MASK(tbl));
> =20
>  	if (newtce & TCE_PCI_WRITE)
>  		newtce |=3D TCE_PCI_READ;
> =20
> -	oldtce =3D be64_to_cpu(xchg(pnv_tce(tbl, false, idx),
> -				  cpu_to_be64(newtce)));
> +	ptce =3D pnv_tce(tbl, false, idx, alloc);
> +	if (!ptce) {
> +		if (*direction =3D=3D DMA_NONE) {
> +			*hpa =3D 0;
> +			return 0;
> +		}
> +		/* It is likely to be realmode */
> +		if (!alloc)
> +			return H_TOO_HARD;
> +
> +		return H_HARDWARE;
> +	}
> +
> +	oldtce =3D be64_to_cpu(xchg(ptce, cpu_to_be64(newtce)));
>  	*hpa =3D oldtce & ~(TCE_PCI_READ | TCE_PCI_WRITE);
>  	*direction =3D iommu_tce_direction(oldtce);
> =20
>  	return 0;
>  }
> =20
> -__be64 *pnv_tce_useraddrptr(struct iommu_table *tbl, long index)
> +__be64 *pnv_tce_useraddrptr(struct iommu_table *tbl, long index, bool al=
loc)
>  {
>  	if (WARN_ON_ONCE(!tbl->it_userspace))
>  		return NULL;
> =20
> -	return pnv_tce(tbl, true, index - tbl->it_offset);
> +	return pnv_tce(tbl, true, index - tbl->it_offset, alloc);
>  }
>  #endif
> =20
> @@ -126,14 +153,19 @@ void pnv_tce_free(struct iommu_table *tbl, long ind=
ex, long npages)
> =20
>  	for (i =3D 0; i < npages; i++) {
>  		unsigned long idx =3D index - tbl->it_offset + i;
> +		__be64 *ptce =3D pnv_tce(tbl, false, idx,	false);
> =20
> -		*(pnv_tce(tbl, false, idx)) =3D cpu_to_be64(0);
> +		if (ptce)
> +			*ptce =3D cpu_to_be64(0);
>  	}
>  }
> =20
>  unsigned long pnv_tce_get(struct iommu_table *tbl, long index)
>  {
> -	__be64 *ptce =3D pnv_tce(tbl, false, index - tbl->it_offset);
> +	__be64 *ptce =3D pnv_tce(tbl, false, index - tbl->it_offset, false);
> +
> +	if (!ptce)
> +		return 0;
> =20
>  	return be64_to_cpu(*ptce);
>  }
> @@ -224,6 +256,7 @@ long pnv_pci_ioda2_table_alloc_pages(int nid, __u64 b=
us_offset,
>  	unsigned int table_shift =3D max_t(unsigned int, entries_shift + 3,
>  			PAGE_SHIFT);
>  	const unsigned long tce_table_size =3D 1UL << table_shift;
> +	unsigned int tmplevels =3D levels;
> =20
>  	if (!levels || (levels > POWERNV_IOMMU_MAX_LEVELS))
>  		return -EINVAL;
> @@ -231,6 +264,9 @@ long pnv_pci_ioda2_table_alloc_pages(int nid, __u64 b=
us_offset,
>  	if (!is_power_of_2(window_size))
>  		return -EINVAL;
> =20
> +	if (alloc_userspace_copy && (window_size > (1ULL << 32)))
> +		tmplevels =3D 1;
> +
>  	/* Adjust direct table size from window_size and levels */
>  	entries_shift =3D (entries_shift + levels - 1) / levels;
>  	level_shift =3D entries_shift + 3;
> @@ -241,7 +277,7 @@ long pnv_pci_ioda2_table_alloc_pages(int nid, __u64 b=
us_offset,
> =20
>  	/* Allocate TCE table */
>  	addr =3D pnv_pci_ioda2_table_do_alloc_pages(nid, level_shift,
> -			levels, tce_table_size, &offset, &total_allocated);
> +			tmplevels, tce_table_size, &offset, &total_allocated);
> =20
>  	/* addr=3D=3DNULL means that the first level allocation failed */
>  	if (!addr)
> @@ -252,7 +288,7 @@ long pnv_pci_ioda2_table_alloc_pages(int nid, __u64 b=
us_offset,
>  	 * we did not allocate as much as we wanted,
>  	 * release partially allocated table.
>  	 */
> -	if (offset < tce_table_size)
> +	if (tmplevels =3D=3D levels && offset < tce_table_size)
>  		goto free_tces_exit;
> =20
>  	/* Allocate userspace view of the TCE table */
> @@ -263,8 +299,8 @@ long pnv_pci_ioda2_table_alloc_pages(int nid, __u64 b=
us_offset,
>  				&total_allocated_uas);
>  		if (!uas)
>  			goto free_tces_exit;
> -		if (offset < tce_table_size ||
> -				total_allocated_uas !=3D total_allocated)
> +		if (tmplevels =3D=3D levels && (offset < tce_table_size ||
> +				total_allocated_uas !=3D total_allocated))
>  			goto free_uas_exit;
>  	}
> =20
> @@ -275,10 +311,11 @@ long pnv_pci_ioda2_table_alloc_pages(int nid, __u64=
 bus_offset,
>  	tbl->it_indirect_levels =3D levels - 1;
>  	tbl->it_allocated_size =3D total_allocated;
>  	tbl->it_userspace =3D uas;
> +	tbl->it_nid =3D nid;
> =20
> -	pr_debug("Created TCE table: ws=3D%08llx ts=3D%lx @%08llx base=3D%lx ua=
s=3D%p levels=3D%d\n",
> +	pr_debug("Created TCE table: ws=3D%08llx ts=3D%lx @%08llx base=3D%lx ua=
s=3D%p levels=3D%d/%d\n",
>  			window_size, tce_table_size, bus_offset, tbl->it_base,
> -			tbl->it_userspace, levels);
> +			tbl->it_userspace, tmplevels, levels);
> =20
>  	return 0;
> =20
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/pla=
tforms/powernv/pci-ioda.c
> index c61c04d..d9df620 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -2010,7 +2010,7 @@ static int pnv_ioda1_tce_build(struct iommu_table *=
tbl, long index,
>  static int pnv_ioda1_tce_xchg(struct iommu_table *tbl, long index,
>  		unsigned long *hpa, enum dma_data_direction *direction)
>  {
> -	long ret =3D pnv_tce_xchg(tbl, index, hpa, direction);
> +	long ret =3D pnv_tce_xchg(tbl, index, hpa, direction, true);
> =20
>  	if (!ret)
>  		pnv_pci_p7ioc_tce_invalidate(tbl, index, 1, false);
> @@ -2021,7 +2021,7 @@ static int pnv_ioda1_tce_xchg(struct iommu_table *t=
bl, long index,
>  static int pnv_ioda1_tce_xchg_rm(struct iommu_table *tbl, long index,
>  		unsigned long *hpa, enum dma_data_direction *direction)
>  {
> -	long ret =3D pnv_tce_xchg(tbl, index, hpa, direction);
> +	long ret =3D pnv_tce_xchg(tbl, index, hpa, direction, false);
> =20
>  	if (!ret)
>  		pnv_pci_p7ioc_tce_invalidate(tbl, index, 1, true);
> @@ -2175,7 +2175,7 @@ static int pnv_ioda2_tce_build(struct iommu_table *=
tbl, long index,
>  static int pnv_ioda2_tce_xchg(struct iommu_table *tbl, long index,
>  		unsigned long *hpa, enum dma_data_direction *direction)
>  {
> -	long ret =3D pnv_tce_xchg(tbl, index, hpa, direction);
> +	long ret =3D pnv_tce_xchg(tbl, index, hpa, direction, true);
> =20
>  	if (!ret)
>  		pnv_pci_ioda2_tce_invalidate(tbl, index, 1, false);
> @@ -2186,7 +2186,7 @@ static int pnv_ioda2_tce_xchg(struct iommu_table *t=
bl, long index,
>  static int pnv_ioda2_tce_xchg_rm(struct iommu_table *tbl, long index,
>  		unsigned long *hpa, enum dma_data_direction *direction)
>  {
> -	long ret =3D pnv_tce_xchg(tbl, index, hpa, direction);
> +	long ret =3D pnv_tce_xchg(tbl, index, hpa, direction, false);
> =20
>  	if (!ret)
>  		pnv_pci_ioda2_tce_invalidate(tbl, index, 1, true);
> diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iomm=
u_spapr_tce.c
> index 628a948..f040ab1 100644
> --- a/drivers/vfio/vfio_iommu_spapr_tce.c
> +++ b/drivers/vfio/vfio_iommu_spapr_tce.c
> @@ -639,7 +639,7 @@ static long tce_iommu_create_table(struct tce_contain=
er *container,
>  			page_shift, window_size, levels, ptbl);
> =20
>  	WARN_ON(!ret && !(*ptbl)->it_ops->free);
> -	WARN_ON(!ret && ((*ptbl)->it_allocated_size !=3D table_size));
> +	WARN_ON(!ret && ((*ptbl)->it_allocated_size > table_size));
> =20
>  	return ret;
>  }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--E0GpUEom8qu4+vDz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsfSTkACgkQbDjKyiDZ
s5KoExAA041knITY/UA9KBs4L2eTQC93nL7B2CKuIvUCaDAhz6a11y6bASM/88M5
2Fd5CecTDGEPHjVYFJMalEH5+4TPaFRThmn1pYtxZV6IfyNW0zcAFd9jIkouRb8R
Dt/cSXWwYwBxhzKEpEgVZwbCZEu5upV8IZXJ5TbBuWnnJ6mgAbj8TlAzOo6kezYh
jwfATsTRTZW1BTBnC3NWCtLg9v4PrlL1BnCBY5EQf8W6DwXYvF+6roWzfcpINyzF
A1dcbace4T5WsjQ9u6vVnVVl5XFoyhpp3I/D+0N8LvxnsiW0PdnFeLUG9UiQcipc
necVZiaWWo8M2vfuwo72kybT4nfxRHxYOf0LhvIzsCpS9LhTwlRwKhvUnzOBUMWm
wvA8bijKwVCaBAVPKGRS4B6ERKmx5py5mMyy6ybO6WQky+lcu0xCzTYUFYevkvzR
QQ4jjsuP7d5kQWJ4/9LzYEAG+m+WfDDG9pcZZCuiz1gck/iXsFl2fPP6TJEVApfM
zYscaxvDGgNl6yW3B8G4hFDT+wWbtGNYBKOSsHjx/NfyMWGm4Xyr1EJeovKt6jwI
dX37BABpaRuoBmykRyl1sUil5cczkVUHz2Asq13P2MQcjmoGGFmXaNcIvNN4Xlca
2WnBmsAeU0NT0WfnxOBao5KuDKklqLpx0J/fUOB4QNRSAoiwfNQ=
=wM7Q
-----END PGP SIGNATURE-----

--E0GpUEom8qu4+vDz--
