Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 414Yfv4qtTzF41J
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jun 2018 12:26:47 +1000 (AEST)
Date: Tue, 12 Jun 2018 12:26:43 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH kernel 4/6] powerpc/powernv: Add indirect levels to
 it_userspace
Message-ID: <20180612022643.GV2737@umbus.fritz.box>
References: <20180608054633.18659-1-aik@ozlabs.ru>
 <20180608054633.18659-5-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Lez9QO3Seu3ycz0M"
In-Reply-To: <20180608054633.18659-5-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--Lez9QO3Seu3ycz0M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 08, 2018 at 03:46:31PM +1000, Alexey Kardashevskiy wrote:
> We want to support sparse memory and therefore huge chunks of DMA windows
> do not need to be mapped. If a DMA window big enough to require 2 or more
> indirect levels, and a DMA window is used to map all RAM (which is
> a default case for 64bit window), we can actually save some memory by
> not allocation TCE for regions which we are not going to map anyway.
>=20
> The hardware tables alreary support indirect levels but we also keep
> host-physical-to-userspace translation array which is allocated by
> vmalloc() and is a flat array which might use quite some memory.
>=20
> This converts it_userspace from vmalloc'ed array to a multi level table.
>=20
> As the format becomes platform dependend, this replaces the direct access
> to it_usespace with a iommu_table_ops::useraddrptr hook which returns
> a pointer to the userspace copy of a TCE; future extension will return
> NULL if the level was not allocated.
>=20
> This should not change non-KVM handling of TCE tables and it_userspace
> will not be allocated for non-KVM tables.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  arch/powerpc/include/asm/iommu.h              |  6 +--
>  arch/powerpc/platforms/powernv/pci.h          |  3 +-
>  arch/powerpc/kvm/book3s_64_vio_hv.c           |  8 ----
>  arch/powerpc/platforms/powernv/pci-ioda-tce.c | 65 +++++++++++++++++++++=
------
>  arch/powerpc/platforms/powernv/pci-ioda.c     | 31 ++++++++++---
>  drivers/vfio/vfio_iommu_spapr_tce.c           | 46 -------------------
>  6 files changed, 81 insertions(+), 78 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/=
iommu.h
> index 803ac70..4bdcf22 100644
> --- a/arch/powerpc/include/asm/iommu.h
> +++ b/arch/powerpc/include/asm/iommu.h
> @@ -69,6 +69,8 @@ struct iommu_table_ops {
>  			long index,
>  			unsigned long *hpa,
>  			enum dma_data_direction *direction);
> +
> +	__be64 *(*useraddrptr)(struct iommu_table *tbl, long index);
>  #endif
>  	void (*clear)(struct iommu_table *tbl,
>  			long index, long npages);
> @@ -123,9 +125,7 @@ struct iommu_table {
>  };
> =20
>  #define IOMMU_TABLE_USERSPACE_ENTRY(tbl, entry) \
> -		((tbl)->it_userspace ? \
> -			&((tbl)->it_userspace[(entry) - (tbl)->it_offset]) : \
> -			NULL)
> +		((tbl)->it_ops->useraddrptr((tbl), (entry)))
> =20
>  /* Pure 2^n version of get_order */
>  static inline __attribute_const__
> diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platform=
s/powernv/pci.h
> index f507baf..5e02408 100644
> --- a/arch/powerpc/platforms/powernv/pci.h
> +++ b/arch/powerpc/platforms/powernv/pci.h
> @@ -268,11 +268,12 @@ extern int pnv_tce_build(struct iommu_table *tbl, l=
ong index, long npages,
>  extern void pnv_tce_free(struct iommu_table *tbl, long index, long npage=
s);
>  extern int pnv_tce_xchg(struct iommu_table *tbl, long index,
>  		unsigned long *hpa, enum dma_data_direction *direction);
> +extern __be64 *pnv_tce_useraddrptr(struct iommu_table *tbl, long index);
>  extern unsigned long pnv_tce_get(struct iommu_table *tbl, long index);
> =20
>  extern long pnv_pci_ioda2_table_alloc_pages(int nid, __u64 bus_offset,
>  		__u32 page_shift, __u64 window_size, __u32 levels,
> -		struct iommu_table *tbl);
> +		bool alloc_userspace_copy, struct iommu_table *tbl);
>  extern void pnv_pci_ioda2_table_free_pages(struct iommu_table *tbl);
> =20
>  extern long pnv_pci_link_table_and_group(int node, int num,
> diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/book3=
s_64_vio_hv.c
> index 18109f3..db0490c 100644
> --- a/arch/powerpc/kvm/book3s_64_vio_hv.c
> +++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
> @@ -206,10 +206,6 @@ static long kvmppc_rm_tce_iommu_mapped_dec(struct kv=
m *kvm,
>  		/* it_userspace allocation might be delayed */
>  		return H_TOO_HARD;
> =20
> -	pua =3D (void *) vmalloc_to_phys(pua);
> -	if (WARN_ON_ONCE_RM(!pua))
> -		return H_HARDWARE;
> -
>  	mem =3D mm_iommu_lookup_rm(kvm->mm, be64_to_cpu(*pua), pgsize);
>  	if (!mem)
>  		return H_TOO_HARD;
> @@ -282,10 +278,6 @@ static long kvmppc_rm_tce_iommu_do_map(struct kvm *k=
vm, struct iommu_table *tbl,
>  	if (WARN_ON_ONCE_RM(mm_iommu_ua_to_hpa_rm(mem, ua, &hpa)))
>  		return H_HARDWARE;
> =20
> -	pua =3D (void *) vmalloc_to_phys(pua);
> -	if (WARN_ON_ONCE_RM(!pua))
> -		return H_HARDWARE;
> -
>  	if (WARN_ON_ONCE_RM(mm_iommu_mapped_inc(mem)))
>  		return H_CLOSED;
> =20
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda-tce.c b/arch/powerpc=
/platforms/powernv/pci-ioda-tce.c
> index 700ceb1..f14b282 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda-tce.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda-tce.c
> @@ -31,9 +31,9 @@ void pnv_pci_setup_iommu_table(struct iommu_table *tbl,
>  	tbl->it_type =3D TCE_PCI;
>  }
> =20
> -static __be64 *pnv_tce(struct iommu_table *tbl, long idx)
> +static __be64 *pnv_tce(struct iommu_table *tbl, bool user, long idx)
>  {
> -	__be64 *tmp =3D ((__be64 *)tbl->it_base);
> +	__be64 *tmp =3D user ? tbl->it_userspace : (__be64 *) tbl->it_base;
>  	int  level =3D tbl->it_indirect_levels;
>  	const long shift =3D ilog2(tbl->it_level_size);
>  	unsigned long mask =3D (tbl->it_level_size - 1) << (level * shift);
> @@ -67,7 +67,7 @@ int pnv_tce_build(struct iommu_table *tbl, long index, =
long npages,
>  			((rpn + i) << tbl->it_page_shift);
>  		unsigned long idx =3D index - tbl->it_offset + i;
> =20
> -		*(pnv_tce(tbl, idx)) =3D cpu_to_be64(newtce);
> +		*(pnv_tce(tbl, false, idx)) =3D cpu_to_be64(newtce);
>  	}
> =20
>  	return 0;
> @@ -86,12 +86,21 @@ int pnv_tce_xchg(struct iommu_table *tbl, long index,
>  	if (newtce & TCE_PCI_WRITE)
>  		newtce |=3D TCE_PCI_READ;
> =20
> -	oldtce =3D be64_to_cpu(xchg(pnv_tce(tbl, idx), cpu_to_be64(newtce)));
> +	oldtce =3D be64_to_cpu(xchg(pnv_tce(tbl, false, idx),
> +				  cpu_to_be64(newtce)));
>  	*hpa =3D oldtce & ~(TCE_PCI_READ | TCE_PCI_WRITE);
>  	*direction =3D iommu_tce_direction(oldtce);
> =20
>  	return 0;
>  }
> +
> +__be64 *pnv_tce_useraddrptr(struct iommu_table *tbl, long index)
> +{
> +	if (WARN_ON_ONCE(!tbl->it_userspace))
> +		return NULL;
> +
> +	return pnv_tce(tbl, true, index - tbl->it_offset);
> +}
>  #endif
> =20
>  void pnv_tce_free(struct iommu_table *tbl, long index, long npages)
> @@ -101,13 +110,15 @@ void pnv_tce_free(struct iommu_table *tbl, long ind=
ex, long npages)
>  	for (i =3D 0; i < npages; i++) {
>  		unsigned long idx =3D index - tbl->it_offset + i;
> =20
> -		*(pnv_tce(tbl, idx)) =3D cpu_to_be64(0);
> +		*(pnv_tce(tbl, false, idx)) =3D cpu_to_be64(0);
>  	}
>  }
> =20
>  unsigned long pnv_tce_get(struct iommu_table *tbl, long index)
>  {
> -	return be64_to_cpu(*(pnv_tce(tbl, index - tbl->it_offset)));
> +	__be64 *ptce =3D pnv_tce(tbl, false, index - tbl->it_offset);
> +
> +	return be64_to_cpu(*ptce);
>  }
> =20
>  static void pnv_pci_ioda2_table_do_free_pages(__be64 *addr,
> @@ -144,6 +155,10 @@ void pnv_pci_ioda2_table_free_pages(struct iommu_tab=
le *tbl)
> =20
>  	pnv_pci_ioda2_table_do_free_pages((__be64 *)tbl->it_base, size,
>  			tbl->it_indirect_levels);
> +	if (tbl->it_userspace) {
> +		pnv_pci_ioda2_table_do_free_pages(tbl->it_userspace, size,
> +				tbl->it_indirect_levels);
> +	}
>  }
> =20
>  static __be64 *pnv_pci_ioda2_table_do_alloc_pages(int nid, unsigned int =
shift,
> @@ -191,10 +206,11 @@ static __be64 *pnv_pci_ioda2_table_do_alloc_pages(i=
nt nid, unsigned int shift,
> =20
>  long pnv_pci_ioda2_table_alloc_pages(int nid, __u64 bus_offset,
>  		__u32 page_shift, __u64 window_size, __u32 levels,
> -		struct iommu_table *tbl)
> +		bool alloc_userspace_copy, struct iommu_table *tbl)
>  {
> -	void *addr;
> +	void *addr, *uas =3D NULL;
>  	unsigned long offset =3D 0, level_shift, total_allocated =3D 0;
> +	unsigned long total_allocated_uas =3D 0;
>  	const unsigned int window_shift =3D ilog2(window_size);
>  	unsigned int entries_shift =3D window_shift - page_shift;
>  	unsigned int table_shift =3D max_t(unsigned int, entries_shift + 3,
> @@ -228,10 +244,20 @@ long pnv_pci_ioda2_table_alloc_pages(int nid, __u64=
 bus_offset,
>  	 * we did not allocate as much as we wanted,
>  	 * release partially allocated table.
>  	 */
> -	if (offset < tce_table_size) {
> -		pnv_pci_ioda2_table_do_free_pages(addr,
> -				1ULL << (level_shift - 3), levels - 1);
> -		return -ENOMEM;
> +	if (offset < tce_table_size)
> +		goto free_tces_exit;
> +
> +	/* Allocate userspace view of the TCE table */
> +	if (alloc_userspace_copy) {
> +		offset =3D 0;
> +		uas =3D pnv_pci_ioda2_table_do_alloc_pages(nid, level_shift,
> +				levels, tce_table_size, &offset,
> +				&total_allocated_uas);
> +		if (!uas)
> +			goto free_tces_exit;
> +		if (offset < tce_table_size ||
> +				total_allocated_uas !=3D total_allocated)
> +			goto free_uas_exit;
>  	}
> =20
>  	/* Setup linux iommu table */
> @@ -240,11 +266,22 @@ long pnv_pci_ioda2_table_alloc_pages(int nid, __u64=
 bus_offset,
>  	tbl->it_level_size =3D 1ULL << (level_shift - 3);
>  	tbl->it_indirect_levels =3D levels - 1;
>  	tbl->it_allocated_size =3D total_allocated;
> +	tbl->it_userspace =3D uas;
> =20
> -	pr_devel("Created TCE table: ws=3D%08llx ts=3D%lx @%08llx\n",
> -			window_size, tce_table_size, bus_offset);
> +	pr_debug("Created TCE table: ws=3D%08llx ts=3D%lx @%08llx base=3D%lx ua=
s=3D%p levels=3D%d\n",
> +			window_size, tce_table_size, bus_offset, tbl->it_base,
> +			tbl->it_userspace, levels);
> =20
>  	return 0;
> +
> +free_uas_exit:
> +	pnv_pci_ioda2_table_do_free_pages(uas,
> +			1ULL << (level_shift - 3), levels - 1);
> +free_tces_exit:
> +	pnv_pci_ioda2_table_do_free_pages(addr,
> +			1ULL << (level_shift - 3), levels - 1);
> +
> +	return -ENOMEM;
>  }
> =20
>  static void pnv_iommu_table_group_link_free(struct rcu_head *head)
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/pla=
tforms/powernv/pci-ioda.c
> index 9577059..c61c04d 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -2043,6 +2043,7 @@ static struct iommu_table_ops pnv_ioda1_iommu_ops =
=3D {
>  #ifdef CONFIG_IOMMU_API
>  	.exchange =3D pnv_ioda1_tce_xchg,
>  	.exchange_rm =3D pnv_ioda1_tce_xchg_rm,
> +	.useraddrptr =3D pnv_tce_useraddrptr,
>  #endif
>  	.clear =3D pnv_ioda1_tce_free,
>  	.get =3D pnv_tce_get,
> @@ -2207,6 +2208,7 @@ static struct iommu_table_ops pnv_ioda2_iommu_ops =
=3D {
>  #ifdef CONFIG_IOMMU_API
>  	.exchange =3D pnv_ioda2_tce_xchg,
>  	.exchange_rm =3D pnv_ioda2_tce_xchg_rm,
> +	.useraddrptr =3D pnv_tce_useraddrptr,
>  #endif
>  	.clear =3D pnv_ioda2_tce_free,
>  	.get =3D pnv_tce_get,
> @@ -2460,9 +2462,9 @@ void pnv_pci_ioda2_set_bypass(struct pnv_ioda_pe *p=
e, bool enable)
>  		pe->tce_bypass_enabled =3D enable;
>  }
> =20
> -static long pnv_pci_ioda2_create_table(struct iommu_table_group *table_g=
roup,
> +static long pnv_pci_ioda2_do_create_table(struct iommu_table_group *tabl=
e_group,
>  		int num, __u32 page_shift, __u64 window_size, __u32 levels,
> -		struct iommu_table **ptbl)
> +		bool alloc_userspace_copy, struct iommu_table **ptbl)
>  {
>  	struct pnv_ioda_pe *pe =3D container_of(table_group, struct pnv_ioda_pe,
>  			table_group);
> @@ -2479,7 +2481,7 @@ static long pnv_pci_ioda2_create_table(struct iommu=
_table_group *table_group,
> =20
>  	ret =3D pnv_pci_ioda2_table_alloc_pages(nid,
>  			bus_offset, page_shift, window_size,
> -			levels, tbl);
> +			levels, alloc_userspace_copy, tbl);
>  	if (ret) {
>  		iommu_tce_table_put(tbl);
>  		return ret;
> @@ -2599,7 +2601,24 @@ static unsigned long pnv_pci_ioda2_get_table_size(=
__u32 page_shift,
>  				tce_table_size, direct_table_size);
>  	}
> =20
> -	return bytes;
> +	return bytes + bytes; /* one for HW table, one for userspace copy */
> +}
> +
> +static long pnv_pci_ioda2_create_table(struct iommu_table_group *table_g=
roup,
> +		int num, __u32 page_shift, __u64 window_size, __u32 levels,
> +		struct iommu_table **ptbl)
> +{
> +	return pnv_pci_ioda2_do_create_table(table_group,
> +			num, page_shift, window_size, levels, false, ptbl);
> +}
> +
> +static long pnv_pci_ioda2_create_table_userspace(
> +		struct iommu_table_group *table_group,
> +		int num, __u32 page_shift, __u64 window_size, __u32 levels,
> +		struct iommu_table **ptbl)
> +{
> +	return pnv_pci_ioda2_do_create_table(table_group,
> +			num, page_shift, window_size, levels, true, ptbl);
>  }
> =20
>  static void pnv_ioda2_take_ownership(struct iommu_table_group *table_gro=
up)
> @@ -2628,7 +2647,7 @@ static void pnv_ioda2_release_ownership(struct iomm=
u_table_group *table_group)
> =20
>  static struct iommu_table_group_ops pnv_pci_ioda2_ops =3D {
>  	.get_table_size =3D pnv_pci_ioda2_get_table_size,
> -	.create_table =3D pnv_pci_ioda2_create_table,
> +	.create_table =3D pnv_pci_ioda2_create_table_userspace,
>  	.set_window =3D pnv_pci_ioda2_set_window,
>  	.unset_window =3D pnv_pci_ioda2_unset_window,
>  	.take_ownership =3D pnv_ioda2_take_ownership,
> @@ -2733,7 +2752,7 @@ static void pnv_ioda2_npu_take_ownership(struct iom=
mu_table_group *table_group)
> =20
>  static struct iommu_table_group_ops pnv_pci_ioda2_npu_ops =3D {
>  	.get_table_size =3D pnv_pci_ioda2_get_table_size,
> -	.create_table =3D pnv_pci_ioda2_create_table,
> +	.create_table =3D pnv_pci_ioda2_create_table_userspace,
>  	.set_window =3D pnv_pci_ioda2_npu_set_window,
>  	.unset_window =3D pnv_pci_ioda2_npu_unset_window,
>  	.take_ownership =3D pnv_ioda2_npu_take_ownership,
> diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iomm=
u_spapr_tce.c
> index 81f48114..628a948 100644
> --- a/drivers/vfio/vfio_iommu_spapr_tce.c
> +++ b/drivers/vfio/vfio_iommu_spapr_tce.c
> @@ -212,44 +212,6 @@ static long tce_iommu_register_pages(struct tce_cont=
ainer *container,
>  	return 0;
>  }
> =20
> -static long tce_iommu_userspace_view_alloc(struct iommu_table *tbl,
> -		struct mm_struct *mm)
> -{
> -	unsigned long cb =3D _ALIGN_UP(sizeof(tbl->it_userspace[0]) *
> -			tbl->it_size, PAGE_SIZE);
> -	unsigned long *uas;
> -	long ret;
> -
> -	BUG_ON(tbl->it_userspace);
> -
> -	ret =3D try_increment_locked_vm(mm, cb >> PAGE_SHIFT);
> -	if (ret)
> -		return ret;
> -
> -	uas =3D vzalloc(cb);
> -	if (!uas) {
> -		decrement_locked_vm(mm, cb >> PAGE_SHIFT);
> -		return -ENOMEM;
> -	}
> -	tbl->it_userspace =3D (__be64 *) uas;
> -
> -	return 0;
> -}
> -
> -static void tce_iommu_userspace_view_free(struct iommu_table *tbl,
> -		struct mm_struct *mm)
> -{
> -	unsigned long cb =3D _ALIGN_UP(sizeof(tbl->it_userspace[0]) *
> -			tbl->it_size, PAGE_SIZE);
> -
> -	if (!tbl->it_userspace)
> -		return;
> -
> -	vfree(tbl->it_userspace);
> -	tbl->it_userspace =3D NULL;
> -	decrement_locked_vm(mm, cb >> PAGE_SHIFT);
> -}
> -
>  static bool tce_page_is_contained(unsigned long hpa, unsigned page_shift)
>  {
>  	struct page *page =3D __va(realmode_pfn_to_page(hpa >> PAGE_SHIFT));
> @@ -608,12 +570,6 @@ static long tce_iommu_build_v2(struct tce_container =
*container,
>  	unsigned long hpa;
>  	enum dma_data_direction dirtmp;
> =20
> -	if (!tbl->it_userspace) {
> -		ret =3D tce_iommu_userspace_view_alloc(tbl, container->mm);
> -		if (ret)
> -			return ret;
> -	}
> -
>  	for (i =3D 0; i < pages; ++i) {
>  		struct mm_iommu_table_group_mem_t *mem =3D NULL;
>  		__be64 *pua =3D IOMMU_TABLE_USERSPACE_ENTRY(tbl, entry + i);
> @@ -693,7 +649,6 @@ static void tce_iommu_free_table(struct tce_container=
 *container,
>  {
>  	unsigned long pages =3D tbl->it_allocated_size >> PAGE_SHIFT;
> =20
> -	tce_iommu_userspace_view_free(tbl, container->mm);
>  	iommu_tce_table_put(tbl);
>  	decrement_locked_vm(container->mm, pages);
>  }
> @@ -1208,7 +1163,6 @@ static void tce_iommu_release_ownership(struct tce_=
container *container,
>  			continue;
> =20
>  		tce_iommu_clear(container, tbl, tbl->it_offset, tbl->it_size);
> -		tce_iommu_userspace_view_free(tbl, container->mm);
>  		if (tbl->it_map)
>  			iommu_release_ownership(tbl);
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Lez9QO3Seu3ycz0M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsfL2IACgkQbDjKyiDZ
s5JFbxAA3c55RoDuxjOb6/bSdvWKjzrEYI8Zc+WIJbyITNHY9vpbDErnj5fmfy2V
dm0B64N+spG3liksaGK/l8zhj5nBPj8b/PEGI+1E0lmQENEPTuOuRT9dQTD+n1hD
KCGUjubZglYsyJ/Ag7ETk5qJ2+Em8Q5wnfHNpwne7kMfbJEZw08uegH3UCEaDedD
x5WZavXOvDuxR87qpef/xhqBQanWCjkuEN/jEEUGX0+0Ho0xkTQKbjFqXRI9gUbD
1Plz8+/Og2QNszPrzoiKZv0FdWA8/C308tLIqV4hRJCxTAxaei4VNEX1bBiOYRYT
e4DsKHlWbAjh38WMByQmwHhaLRDt4F8Oyr1BllDR8DBR1pkguY2HeDDhj4wsGZgH
Qdw8js486aQGuEWolPfseXW5U+vC6o52e2mmt28Pvhz0o2RsIIcwKByiH36hZvOK
5Wd9/9kQ/QIIW3bvDkmQJj95odU8THZaUBKnlVBz5eGGUX4tQ2Y4y4UYR9gU0jcw
aFqj2hCRuPOtqKUFCb/vbXVB4OEjoaSizgEcHaPN5t6VN4r3e5SjRPtDIj1J3yuy
IIVRJnDIfGaX4jP4SSzFFlBWkBxRt9M2lRZui2AE+h00jMEAlZCuhXql/Oluhxyg
/mateQti1AK0vaGZ/wMVD4+Jc3Q1jfJryGW74ohcC+b50Adr7OY=
=cSeA
-----END PGP SIGNATURE-----

--Lez9QO3Seu3ycz0M--
