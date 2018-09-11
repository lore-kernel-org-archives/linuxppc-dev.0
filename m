Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 428VRl1fp6zF31r
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Sep 2018 13:16:03 +1000 (AEST)
Date: Tue, 11 Sep 2018 13:13:11 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Paul Mackerras <paulus@ozlabs.org>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH kernel v2 1/6] KVM: PPC: Avoid marking DMA-mapped pages
 dirty in real mode
Message-ID: <20180911031311.GI7978@umbus.fritz.box>
References: <20180910082912.13255-1-aik@ozlabs.ru>
 <20180910082912.13255-2-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Q59ABw34pTSIagmi"
In-Reply-To: <20180910082912.13255-2-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--Q59ABw34pTSIagmi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 10, 2018 at 06:29:07PM +1000, Alexey Kardashevskiy wrote:
> At the moment the real mode handler of H_PUT_TCE calls iommu_tce_xchg_rm()
> which in turn reads the old TCE and if it was a valid entry - marks
> the physical page dirty if it was mapped for writing. Since it is
> the real mode, realmode_pfn_to_page() is used instead of pfn_to_page()
> to get the page struct. However SetPageDirty() itself reads the compound
> page head and returns a virtual address for the head page struct and
> setting dirty bit for that kills the system.
>=20
> This adds additional dirty bit tracking into the MM/IOMMU API for use
> in the real mode. Note that this does not change how VFIO and
> KVM (in virtual mode) set this bit. The KVM (real mode) changes include:
> - use the lowest bit of the cached host phys address to carry
> the dirty bit;
> - mark pages dirty when they are unpinned which happens when
> the preregistered memory is released which always happens in virtual
> mode;
> - add mm_iommu_ua_mark_dirty_rm() helper to set delayed dirty bit;
> - change iommu_tce_xchg_rm() to take the kvm struct for the mm to use
> in the new mm_iommu_ua_mark_dirty_rm() helper;
> - move iommu_tce_xchg_rm() to book3s_64_vio_hv.c (which is the only
> caller anyway) to reduce the real mode KVM and IOMMU knowledge
> across different subsystems.
>=20
> This removes realmode_pfn_to_page() as it is not used anymore.
>=20
> While we at it, remove some EXPORT_SYMBOL_GPL() as that code is for
> the real mode only and modules cannot call it anyway.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
> Changes:
> v2:
> * only do delaying dirtying for the real mode
> * no change in VFIO IOMMU SPAPR TCE driver is needed anymore
> * inverted MM_IOMMU_TABLE_GROUP_PAGE_MASK
> ---
>  arch/powerpc/include/asm/book3s/64/pgtable.h |  1 -
>  arch/powerpc/include/asm/iommu.h             |  2 --
>  arch/powerpc/include/asm/mmu_context.h       |  1 +
>  arch/powerpc/kernel/iommu.c                  | 25 --------------
>  arch/powerpc/kvm/book3s_64_vio_hv.c          | 39 +++++++++++++++++-----
>  arch/powerpc/mm/init_64.c                    | 49 ----------------------=
------
>  arch/powerpc/mm/mmu_context_iommu.c          | 34 ++++++++++++++++---
>  7 files changed, 62 insertions(+), 89 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/=
include/asm/book3s/64/pgtable.h
> index 13a688f..2fdc865 100644
> --- a/arch/powerpc/include/asm/book3s/64/pgtable.h
> +++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
> @@ -1051,7 +1051,6 @@ static inline void vmemmap_remove_mapping(unsigned =
long start,
>  	return hash__vmemmap_remove_mapping(start, page_size);
>  }
>  #endif
> -struct page *realmode_pfn_to_page(unsigned long pfn);
> =20
>  static inline pte_t pmd_pte(pmd_t pmd)
>  {
> diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/=
iommu.h
> index ab3a4fb..3d4b88c 100644
> --- a/arch/powerpc/include/asm/iommu.h
> +++ b/arch/powerpc/include/asm/iommu.h
> @@ -220,8 +220,6 @@ extern void iommu_del_device(struct device *dev);
>  extern int __init tce_iommu_bus_notifier_init(void);
>  extern long iommu_tce_xchg(struct iommu_table *tbl, unsigned long entry,
>  		unsigned long *hpa, enum dma_data_direction *direction);
> -extern long iommu_tce_xchg_rm(struct iommu_table *tbl, unsigned long ent=
ry,
> -		unsigned long *hpa, enum dma_data_direction *direction);
>  #else
>  static inline void iommu_register_group(struct iommu_table_group *table_=
group,
>  					int pci_domain_number,
> diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/includ=
e/asm/mmu_context.h
> index b2f89b6..b694d6a 100644
> --- a/arch/powerpc/include/asm/mmu_context.h
> +++ b/arch/powerpc/include/asm/mmu_context.h
> @@ -38,6 +38,7 @@ extern long mm_iommu_ua_to_hpa(struct mm_iommu_table_gr=
oup_mem_t *mem,
>  		unsigned long ua, unsigned int pageshift, unsigned long *hpa);
>  extern long mm_iommu_ua_to_hpa_rm(struct mm_iommu_table_group_mem_t *mem,
>  		unsigned long ua, unsigned int pageshift, unsigned long *hpa);
> +extern void mm_iommu_ua_mark_dirty_rm(struct mm_struct *mm, unsigned lon=
g ua);
>  extern long mm_iommu_mapped_inc(struct mm_iommu_table_group_mem_t *mem);
>  extern void mm_iommu_mapped_dec(struct mm_iommu_table_group_mem_t *mem);
>  #endif
> diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
> index af7a20d..19b4c62 100644
> --- a/arch/powerpc/kernel/iommu.c
> +++ b/arch/powerpc/kernel/iommu.c
> @@ -1013,31 +1013,6 @@ long iommu_tce_xchg(struct iommu_table *tbl, unsig=
ned long entry,
>  }
>  EXPORT_SYMBOL_GPL(iommu_tce_xchg);
> =20
> -#ifdef CONFIG_PPC_BOOK3S_64
> -long iommu_tce_xchg_rm(struct iommu_table *tbl, unsigned long entry,
> -		unsigned long *hpa, enum dma_data_direction *direction)
> -{
> -	long ret;
> -
> -	ret =3D tbl->it_ops->exchange_rm(tbl, entry, hpa, direction);
> -
> -	if (!ret && ((*direction =3D=3D DMA_FROM_DEVICE) ||
> -			(*direction =3D=3D DMA_BIDIRECTIONAL))) {
> -		struct page *pg =3D realmode_pfn_to_page(*hpa >> PAGE_SHIFT);
> -
> -		if (likely(pg)) {
> -			SetPageDirty(pg);
> -		} else {
> -			tbl->it_ops->exchange_rm(tbl, entry, hpa, direction);
> -			ret =3D -EFAULT;
> -		}
> -	}
> -
> -	return ret;
> -}
> -EXPORT_SYMBOL_GPL(iommu_tce_xchg_rm);
> -#endif
> -
>  int iommu_take_ownership(struct iommu_table *tbl)
>  {
>  	unsigned long flags, i, sz =3D (tbl->it_size + 7) >> 3;
> diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/book3=
s_64_vio_hv.c
> index 506a4d4..6821ead 100644
> --- a/arch/powerpc/kvm/book3s_64_vio_hv.c
> +++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
> @@ -187,12 +187,35 @@ long kvmppc_gpa_to_ua(struct kvm *kvm, unsigned lon=
g gpa,
>  EXPORT_SYMBOL_GPL(kvmppc_gpa_to_ua);
> =20
>  #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
> -static void kvmppc_rm_clear_tce(struct iommu_table *tbl, unsigned long e=
ntry)
> +static long iommu_tce_xchg_rm(struct mm_struct *mm, struct iommu_table *=
tbl,
> +		unsigned long entry, unsigned long *hpa,
> +		enum dma_data_direction *direction)
> +{
> +	long ret;
> +
> +	ret =3D tbl->it_ops->exchange_rm(tbl, entry, hpa, direction);
> +
> +	if (!ret && ((*direction =3D=3D DMA_FROM_DEVICE) ||
> +				(*direction =3D=3D DMA_BIDIRECTIONAL))) {
> +		__be64 *pua =3D IOMMU_TABLE_USERSPACE_ENTRY_RM(tbl, entry);
> +		/*
> +		 * kvmppc_rm_tce_iommu_do_map() updates the UA cache after
> +		 * calling this so we still get here a valid UA.
> +		 */
> +		if (pua && *pua)
> +			mm_iommu_ua_mark_dirty_rm(mm, be64_to_cpu(*pua));
> +	}
> +
> +	return ret;
> +}
> +
> +static void kvmppc_rm_clear_tce(struct kvm *kvm, struct iommu_table *tbl,
> +		unsigned long entry)
>  {
>  	unsigned long hpa =3D 0;
>  	enum dma_data_direction dir =3D DMA_NONE;
> =20
> -	iommu_tce_xchg_rm(tbl, entry, &hpa, &dir);
> +	iommu_tce_xchg_rm(kvm->mm, tbl, entry, &hpa, &dir);
>  }
> =20
>  static long kvmppc_rm_tce_iommu_mapped_dec(struct kvm *kvm,
> @@ -224,7 +247,7 @@ static long kvmppc_rm_tce_iommu_do_unmap(struct kvm *=
kvm,
>  	unsigned long hpa =3D 0;
>  	long ret;
> =20
> -	if (iommu_tce_xchg_rm(tbl, entry, &hpa, &dir))
> +	if (iommu_tce_xchg_rm(kvm->mm, tbl, entry, &hpa, &dir))
>  		/*
>  		 * real mode xchg can fail if struct page crosses
>  		 * a page boundary
> @@ -236,7 +259,7 @@ static long kvmppc_rm_tce_iommu_do_unmap(struct kvm *=
kvm,
> =20
>  	ret =3D kvmppc_rm_tce_iommu_mapped_dec(kvm, tbl, entry);
>  	if (ret)
> -		iommu_tce_xchg_rm(tbl, entry, &hpa, &dir);
> +		iommu_tce_xchg_rm(kvm->mm, tbl, entry, &hpa, &dir);
> =20
>  	return ret;
>  }
> @@ -282,7 +305,7 @@ static long kvmppc_rm_tce_iommu_do_map(struct kvm *kv=
m, struct iommu_table *tbl,
>  	if (WARN_ON_ONCE_RM(mm_iommu_mapped_inc(mem)))
>  		return H_CLOSED;
> =20
> -	ret =3D iommu_tce_xchg_rm(tbl, entry, &hpa, &dir);
> +	ret =3D iommu_tce_xchg_rm(kvm->mm, tbl, entry, &hpa, &dir);
>  	if (ret) {
>  		mm_iommu_mapped_dec(mem);
>  		/*
> @@ -371,7 +394,7 @@ long kvmppc_rm_h_put_tce(struct kvm_vcpu *vcpu, unsig=
ned long liobn,
>  			return ret;
> =20
>  		WARN_ON_ONCE_RM(1);
> -		kvmppc_rm_clear_tce(stit->tbl, entry);
> +		kvmppc_rm_clear_tce(vcpu->kvm, stit->tbl, entry);
>  	}
> =20
>  	kvmppc_tce_put(stt, entry, tce);
> @@ -520,7 +543,7 @@ long kvmppc_rm_h_put_tce_indirect(struct kvm_vcpu *vc=
pu,
>  				goto unlock_exit;
> =20
>  			WARN_ON_ONCE_RM(1);
> -			kvmppc_rm_clear_tce(stit->tbl, entry);
> +			kvmppc_rm_clear_tce(vcpu->kvm, stit->tbl, entry);
>  		}
> =20
>  		kvmppc_tce_put(stt, entry + i, tce);
> @@ -571,7 +594,7 @@ long kvmppc_rm_h_stuff_tce(struct kvm_vcpu *vcpu,
>  				return ret;
> =20
>  			WARN_ON_ONCE_RM(1);
> -			kvmppc_rm_clear_tce(stit->tbl, entry);
> +			kvmppc_rm_clear_tce(vcpu->kvm, stit->tbl, entry);
>  		}
>  	}
> =20
> diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
> index 51ce091..7a9886f 100644
> --- a/arch/powerpc/mm/init_64.c
> +++ b/arch/powerpc/mm/init_64.c
> @@ -308,55 +308,6 @@ void register_page_bootmem_memmap(unsigned long sect=
ion_nr,
>  {
>  }
> =20
> -/*
> - * We do not have access to the sparsemem vmemmap, so we fallback to
> - * walking the list of sparsemem blocks which we already maintain for
> - * the sake of crashdump. In the long run, we might want to maintain
> - * a tree if performance of that linear walk becomes a problem.
> - *
> - * realmode_pfn_to_page functions can fail due to:
> - * 1) As real sparsemem blocks do not lay in RAM continously (they
> - * are in virtual address space which is not available in the real mode),
> - * the requested page struct can be split between blocks so get_page/put=
_page
> - * may fail.
> - * 2) When huge pages are used, the get_page/put_page API will fail
> - * in real mode as the linked addresses in the page struct are virtual
> - * too.
> - */
> -struct page *realmode_pfn_to_page(unsigned long pfn)
> -{
> -	struct vmemmap_backing *vmem_back;
> -	struct page *page;
> -	unsigned long page_size =3D 1 << mmu_psize_defs[mmu_vmemmap_psize].shif=
t;
> -	unsigned long pg_va =3D (unsigned long) pfn_to_page(pfn);
> -
> -	for (vmem_back =3D vmemmap_list; vmem_back; vmem_back =3D vmem_back->li=
st) {
> -		if (pg_va < vmem_back->virt_addr)
> -			continue;
> -
> -		/* After vmemmap_list entry free is possible, need check all */
> -		if ((pg_va + sizeof(struct page)) <=3D
> -				(vmem_back->virt_addr + page_size)) {
> -			page =3D (struct page *) (vmem_back->phys + pg_va -
> -				vmem_back->virt_addr);
> -			return page;
> -		}
> -	}
> -
> -	/* Probably that page struct is split between real pages */
> -	return NULL;
> -}
> -EXPORT_SYMBOL_GPL(realmode_pfn_to_page);
> -
> -#else
> -
> -struct page *realmode_pfn_to_page(unsigned long pfn)
> -{
> -	struct page *page =3D pfn_to_page(pfn);
> -	return page;
> -}
> -EXPORT_SYMBOL_GPL(realmode_pfn_to_page);
> -
>  #endif /* CONFIG_SPARSEMEM_VMEMMAP */
> =20
>  #ifdef CONFIG_PPC_BOOK3S_64
> diff --git a/arch/powerpc/mm/mmu_context_iommu.c b/arch/powerpc/mm/mmu_co=
ntext_iommu.c
> index c9ee9e2..56c2234 100644
> --- a/arch/powerpc/mm/mmu_context_iommu.c
> +++ b/arch/powerpc/mm/mmu_context_iommu.c
> @@ -18,11 +18,15 @@
>  #include <linux/migrate.h>
>  #include <linux/hugetlb.h>
>  #include <linux/swap.h>
> +#include <linux/sizes.h>
>  #include <asm/mmu_context.h>
>  #include <asm/pte-walk.h>
> =20
>  static DEFINE_MUTEX(mem_list_mutex);
> =20
> +#define MM_IOMMU_TABLE_GROUP_PAGE_DIRTY	0x1
> +#define MM_IOMMU_TABLE_GROUP_PAGE_MASK	~(SZ_4K - 1)
> +
>  struct mm_iommu_table_group_mem_t {
>  	struct list_head next;
>  	struct rcu_head rcu;
> @@ -263,6 +267,9 @@ static void mm_iommu_unpin(struct mm_iommu_table_grou=
p_mem_t *mem)
>  		if (!page)
>  			continue;
> =20
> +		if (mem->hpas[i] & MM_IOMMU_TABLE_GROUP_PAGE_DIRTY)
> +			SetPageDirty(page);
> +
>  		put_page(page);
>  		mem->hpas[i] =3D 0;
>  	}
> @@ -360,7 +367,6 @@ struct mm_iommu_table_group_mem_t *mm_iommu_lookup_rm=
(struct mm_struct *mm,
> =20
>  	return ret;
>  }
> -EXPORT_SYMBOL_GPL(mm_iommu_lookup_rm);
> =20
>  struct mm_iommu_table_group_mem_t *mm_iommu_find(struct mm_struct *mm,
>  		unsigned long ua, unsigned long entries)
> @@ -390,7 +396,7 @@ long mm_iommu_ua_to_hpa(struct mm_iommu_table_group_m=
em_t *mem,
>  	if (pageshift > mem->pageshift)
>  		return -EFAULT;
> =20
> -	*hpa =3D *va | (ua & ~PAGE_MASK);
> +	*hpa =3D (*va & MM_IOMMU_TABLE_GROUP_PAGE_MASK) | (ua & ~PAGE_MASK);
> =20
>  	return 0;
>  }
> @@ -413,11 +419,31 @@ long mm_iommu_ua_to_hpa_rm(struct mm_iommu_table_gr=
oup_mem_t *mem,
>  	if (!pa)
>  		return -EFAULT;
> =20
> -	*hpa =3D *pa | (ua & ~PAGE_MASK);
> +	*hpa =3D (*pa & MM_IOMMU_TABLE_GROUP_PAGE_MASK) | (ua & ~PAGE_MASK);
> =20
>  	return 0;
>  }
> -EXPORT_SYMBOL_GPL(mm_iommu_ua_to_hpa_rm);
> +
> +extern void mm_iommu_ua_mark_dirty_rm(struct mm_struct *mm, unsigned lon=
g ua)
> +{
> +	struct mm_iommu_table_group_mem_t *mem;
> +	long entry;
> +	void *va;
> +	unsigned long *pa;
> +
> +	mem =3D mm_iommu_lookup_rm(mm, ua, PAGE_SIZE);
> +	if (!mem)
> +		return;
> +
> +	entry =3D (ua - mem->ua) >> PAGE_SHIFT;
> +	va =3D &mem->hpas[entry];
> +
> +	pa =3D (void *) vmalloc_to_phys(va);
> +	if (!pa)
> +		return;
> +
> +	*pa |=3D MM_IOMMU_TABLE_GROUP_PAGE_DIRTY;
> +}
> =20
>  long mm_iommu_mapped_inc(struct mm_iommu_table_group_mem_t *mem)
>  {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Q59ABw34pTSIagmi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAluXMsQACgkQbDjKyiDZ
s5LXEw//RzRIeTffqyaCgpSI3f6jdeheeLSlhaEd8o1V3vqanG49PXtdET5Bs2xn
z/AkoTeRf60nDobOV4/m7cLHj/OF9zSrWAKf5iw25+K8G1GTqqJI5bAZHMEGzjkT
kGpsjM3NZVl+axFzXwmpsVyI8uvMyKUiSkJDq9FqlzazntG1rw57m/Sn640uNleC
Q8SYZ7edORLtTZnJyEF0ZiKEaH9b7MJsnHjPtcXDrrRv6iDsfeMHzKW+9RAiDLiS
9r1D6N22vwh9yGFIOd3JRrv8JlYuszdKP2Zh4ZdTG22jqo0kqCbBz7DWD6p2Gh/p
RFYC7qklT368GRvn2PxSTy6FEQ4fQoWCQhqryaGRZykEYLvv6B3g3SyU6t3ecVeX
DCFn/t0SYceYK5sMRiIXK5a5Tof1qJ2onrCoNBwAa7EWjfo1Q4kN+CUXwC74p+wB
J1YsqDS8Jcx6iuFaVFqumbOajEiJ1PW0oMq4nS7KHCSC6lYf5FxlN4VVIBGXLEMm
7CtOGgbpYKlLYRzKoMkEbD9S3y2VAxPzB/IZfQP31Y9uaUHdTXEcn6hzXAMM9aXV
8S29V49n6C5jS3cwAKv+5f1Bg8ucMMsfnM8GO1pECl7ydAAFwDWadFItwlCAlXOS
hmKT+gfvtqNI93gr5YkLoS1gqLGeI6wpqSU0s/plS5LsbV/fzpY=
=NNMW
-----END PGP SIGNATURE-----

--Q59ABw34pTSIagmi--
