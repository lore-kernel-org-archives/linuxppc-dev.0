Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qTgVQ0GZszDq6X
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Mar 2016 15:59:58 +1100 (AEDT)
Message-ID: <1458622797.23205.3.camel@neuling.org>
Subject: Re: [PATCH 09/14] powerpc/mm: Drop WIMG in favour of new constants
From: Michael Neuling <mikey@neuling.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
Date: Tue, 22 Mar 2016 15:59:57 +1100
In-Reply-To: <1457357974-20839-9-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1457357974-20839-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1457357974-20839-9-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-03-07 at 19:09 +0530, Aneesh Kumar K.V wrote:

> PowerISA 3.0 introduce three pte bits with the below meaning
> 000 ->  Normal Memory
> 001 ->  Strong Access Order
> 010 -> Non idempotent I/O ( Also cache inhibited and guarded)
> 100 -> Tolerant I/O (Cache inhibited)

Which PTE are you talking about here?  Radix, new Hash (ISA 3.0) or
old Hash (ISA 2.07)?

A couple more comments below

> We drop the existing WIMG bits in linux page table in favour of above
> contants. We loose _PAGE_WRITETHRU with this conversion. We only use
> writethru via pgprot_cached_wthru() which is used by fbdev/controlfb.c
> which is Apple control display and also PPC32.
>=20
> With respect to _PAGE_COHERENCE, we have been marking hpte
> always coherent for some time now. htab_convert_pte_flags always added
> HPTE_R_M.
>=20
> NOTE: KVM changes need closer review.
>=20
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/book3s/64/hash.h | 47 +++++++++----------------=
------
>  arch/powerpc/include/asm/kvm_book3s_64.h  | 29 ++++++++++---------
>  arch/powerpc/kvm/book3s_64_mmu_hv.c       | 11 ++++----
>  arch/powerpc/kvm/book3s_hv_rm_mmu.c       | 12 ++++----
>  arch/powerpc/mm/hash64_64k.c              |  2 +-
>  arch/powerpc/mm/hash_utils_64.c           | 14 ++++-----
>  arch/powerpc/mm/pgtable.c                 |  2 +-
>  arch/powerpc/mm/pgtable_64.c              |  4 ---
>  arch/powerpc/platforms/pseries/lpar.c     |  4 ---
>  9 files changed, 48 insertions(+), 77 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/inc=
lude/asm/book3s/64/hash.h
> index c2b567456796..edd3d47ef9a4 100644
> --- a/arch/powerpc/include/asm/book3s/64/hash.h
> +++ b/arch/powerpc/include/asm/book3s/64/hash.h
> @@ -21,11 +21,9 @@
>  #define _PAGE_RW		(_PAGE_READ | _PAGE_WRITE)
>  #define _PAGE_RWX		(_PAGE_READ | _PAGE_WRITE | _PAGE_EXEC)
>  #define _PAGE_PRIVILEGED	0x00008 /* page can only be access by kernel */
> -#define _PAGE_GUARDED		0x00010 /* G: guarded (side-effect) page */
> -/* M (memory coherence) is always set in the HPTE, so we don't need it h=
ere */
> -#define _PAGE_COHERENT		0x0
> -#define _PAGE_NO_CACHE		0x00020 /* I: cache inhibit */
> -#define _PAGE_WRITETHRU		0x00040 /* W: cache write-through */
> +#define _PAGE_SAO		0x00010 /* Strong access order */
> +#define _PAGE_NON_IDEMPOTENT	0x00020 /* non idempotent memory */
> +#define _PAGE_TOLERANT		0x00040 /* tolerant memory, cache inhibited */
>  #define _PAGE_DIRTY		0x00080 /* C: page changed */
>  #define _PAGE_ACCESSED		0x00100 /* R: page referenced */
>  #define _PAGE_SPECIAL		0x00400 /* software: special page */
> @@ -122,9 +120,6 @@
>  #define _PAGE_KERNEL_RWX	(_PAGE_PRIVILEGED | _PAGE_DIRTY | \
>  				 _PAGE_RW | _PAGE_EXEC)
> =20
> -/* Strong Access Ordering */
> -#define _PAGE_SAO		(_PAGE_WRITETHRU | _PAGE_NO_CACHE | _PAGE_COHERENT)
> -
>  /* No page size encoding in the linux PTE */
>  #define _PAGE_PSIZE		0
> =20
> @@ -150,10 +145,9 @@
>  /*
>   * Mask of bits returned by pte_pgprot()
>   */
> -#define PAGE_PROT_BITS	(_PAGE_GUARDED | _PAGE_COHERENT | _PAGE_NO_CACHE =
| \
> -			 _PAGE_WRITETHRU | _PAGE_4K_PFN | \
> -			 _PAGE_PRIVILEGED | _PAGE_ACCESSED |  _PAGE_READ |\
> -			 _PAGE_WRITE |  _PAGE_DIRTY | _PAGE_EXEC | \
> +#define PAGE_PROT_BITS  (_PAGE_SAO | _PAGE_NON_IDEMPOTENT | _PAGE_TOLERA=
NT | \
> +			 _PAGE_4K_PFN | _PAGE_PRIVILEGED | _PAGE_ACCESSED | \
> +			 _PAGE_READ | _PAGE_WRITE |  _PAGE_DIRTY | _PAGE_EXEC | \
>  			 _PAGE_SOFT_DIRTY)
>  /*is this
>   * We define 2 sets of base prot bits, one for basic pages (ie,
> @@ -162,7 +156,7 @@
>   * the processor might need it for DMA coherency.
>   */
>  #define _PAGE_BASE_NC	(_PAGE_PRESENT | _PAGE_ACCESSED | _PAGE_PSIZE)
> -#define _PAGE_BASE	(_PAGE_BASE_NC | _PAGE_COHERENT)
> +#define _PAGE_BASE	(_PAGE_BASE_NC)
> =20
>  /* Permission masks used to generate the __P and __S table,
>   *
> @@ -203,9 +197,9 @@
>  /* Permission masks used for kernel mappings */
>  #define PAGE_KERNEL	__pgprot(_PAGE_BASE | _PAGE_KERNEL_RW)
>  #define PAGE_KERNEL_NC	__pgprot(_PAGE_BASE_NC | _PAGE_KERNEL_RW | \
> -				 _PAGE_NO_CACHE)
> +				 _PAGE_TOLERANT)
>  #define PAGE_KERNEL_NCG	__pgprot(_PAGE_BASE_NC | _PAGE_KERNEL_RW | \
> -				 _PAGE_NO_CACHE | _PAGE_GUARDED)
> +				 _PAGE_NON_IDEMPOTENT)
>  #define PAGE_KERNEL_X	__pgprot(_PAGE_BASE | _PAGE_KERNEL_RWX)
>  #define PAGE_KERNEL_RO	__pgprot(_PAGE_BASE | _PAGE_KERNEL_RO)
>  #define PAGE_KERNEL_ROX	__pgprot(_PAGE_BASE | _PAGE_KERNEL_ROX)
> @@ -516,41 +510,26 @@ static inline void __set_pte_at(struct mm_struct *m=
m, unsigned long addr,
>   * Macro to mark a page protection value as "uncacheable".
>   */
> =20
> -#define _PAGE_CACHE_CTL	(_PAGE_COHERENT | _PAGE_GUARDED | _PAGE_NO_CACHE=
 | \
> -			 _PAGE_WRITETHRU)
> +#define _PAGE_CACHE_CTL	(_PAGE_SAO | _PAGE_NON_IDEMPOTENT | _PAGE_TOLERA=
NT)

The comment here says 'Macro to mark a page protection value as
"uncacheable"' but why do we put _PAGE_SAO in that?

> =20
>  #define pgprot_noncached pgprot_noncached
>  static inline pgprot_t pgprot_noncached(pgprot_t prot)
>  {
>  	return __pgprot((pgprot_val(prot) & ~_PAGE_CACHE_CTL) |
> -			_PAGE_NO_CACHE | _PAGE_GUARDED);
> +			_PAGE_NON_IDEMPOTENT);
>  }
> =20
>  #define pgprot_noncached_wc pgprot_noncached_wc
>  static inline pgprot_t pgprot_noncached_wc(pgprot_t prot)
>  {
>  	return __pgprot((pgprot_val(prot) & ~_PAGE_CACHE_CTL) |
> -			_PAGE_NO_CACHE);
> +			_PAGE_TOLERANT);
>  }
> =20
>  #define pgprot_cached pgprot_cached
>  static inline pgprot_t pgprot_cached(pgprot_t prot)
>  {
> -	return __pgprot((pgprot_val(prot) & ~_PAGE_CACHE_CTL) |
> -			_PAGE_COHERENT);
> -}
> -
> -#define pgprot_cached_wthru pgprot_cached_wthru
> -static inline pgprot_t pgprot_cached_wthru(pgprot_t prot)
> -{
> -	return __pgprot((pgprot_val(prot) & ~_PAGE_CACHE_CTL) |
> -			_PAGE_COHERENT | _PAGE_WRITETHRU);
> -}
> -
> -#define pgprot_cached_noncoherent pgprot_cached_noncoherent
> -static inline pgprot_t pgprot_cached_noncoherent(pgprot_t prot)
> -{
> -	return __pgprot(pgprot_val(prot) & ~_PAGE_CACHE_CTL);
> +	return __pgprot((pgprot_val(prot) & ~_PAGE_CACHE_CTL));
>  }
> =20
>  #define pgprot_writecombine pgprot_writecombine
> diff --git a/arch/powerpc/include/asm/kvm_book3s_64.h b/arch/powerpc/incl=
ude/asm/kvm_book3s_64.h
> index f9a7a89a3e4f..f23b1698ad3c 100644
> --- a/arch/powerpc/include/asm/kvm_book3s_64.h
> +++ b/arch/powerpc/include/asm/kvm_book3s_64.h
> @@ -278,19 +278,24 @@ static inline unsigned long hpte_make_readonly(unsi=
gned long ptel)
>  	return ptel;
>  }
> =20
> -static inline int hpte_cache_flags_ok(unsigned long ptel, unsigned long =
io_type)
> +static inline bool hpte_cache_flags_ok(unsigned long hptel, bool is_ci)
>  {
> -	unsigned int wimg =3D ptel & HPTE_R_WIMG;
> +	unsigned int wimg =3D hptel & HPTE_R_WIMG;
> =20
>  	/* Handle SAO */
>  	if (wimg =3D=3D (HPTE_R_W | HPTE_R_I | HPTE_R_M) &&
>  	    cpu_has_feature(CPU_FTR_ARCH_206))
>  		wimg =3D HPTE_R_M;
> =20
> -	if (!io_type)
> +	if (!is_ci)
>  		return wimg =3D=3D HPTE_R_M;
> -
> -	return (wimg & (HPTE_R_W | HPTE_R_I)) =3D=3D io_type;
> +	/*
> +	 * if host is mapped cache inhibited, make sure hptel also have
> +	 * cache inhibited.
> +	 */
> +	if (wimg & HPTE_R_W) /* FIXME!! is this ok for all guest. ? */
> +		return false;
> +	return !!(wimg & HPTE_R_I);
>  }
> =20
>  /*
> @@ -333,16 +338,12 @@ static inline pte_t kvmppc_read_update_linux_pte(pt=
e_t *ptep, int writing)
>  	return new_pte;
>  }
> =20
> -
> -/* Return HPTE cache control bits corresponding to Linux pte bits */
> -static inline unsigned long hpte_cache_bits(unsigned long pte_val)
> +/*
> + * check whether the mapping is cache inhibited
> + */
> +static inline bool hpte_is_cache_inhibited(unsigned long pte_val)
>  {
> -#if _PAGE_NO_CACHE =3D=3D HPTE_R_I && _PAGE_WRITETHRU =3D=3D HPTE_R_W
> -	return pte_val & (HPTE_R_W | HPTE_R_I);
> -#else
> -	return ((pte_val & _PAGE_NO_CACHE) ? HPTE_R_I : 0) +
> -		((pte_val & _PAGE_WRITETHRU) ? HPTE_R_W : 0);
> -#endif
> +	return !!(pte_val & (_PAGE_TOLERANT | _PAGE_NON_IDEMPOTENT));

Can we use _PAGE_CACHE_CTL here?

>  }
> =20
>  static inline bool hpte_read_permission(unsigned long pp, unsigned long =
key)
> diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3=
s_64_mmu_hv.c
> index c7b78d8336b2..40ad06c41ca1 100644
> --- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
> +++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
> @@ -447,7 +447,7 @@ int kvmppc_book3s_hv_page_fault(struct kvm_run *run, =
struct kvm_vcpu *vcpu,
>  	struct revmap_entry *rev;
>  	struct page *page, *pages[1];
>  	long index, ret, npages;
> -	unsigned long is_io;
> +	bool is_ci;
>  	unsigned int writing, write_ok;
>  	struct vm_area_struct *vma;
>  	unsigned long rcbits;
> @@ -503,7 +503,7 @@ int kvmppc_book3s_hv_page_fault(struct kvm_run *run, =
struct kvm_vcpu *vcpu,
>  	smp_rmb();
> =20
>  	ret =3D -EFAULT;
> -	is_io =3D 0;
> +	is_ci =3D false;
>  	pfn =3D 0;
>  	page =3D NULL;
>  	pte_size =3D PAGE_SIZE;
> @@ -521,7 +521,7 @@ int kvmppc_book3s_hv_page_fault(struct kvm_run *run, =
struct kvm_vcpu *vcpu,
>  			pfn =3D vma->vm_pgoff +
>  				((hva - vma->vm_start) >> PAGE_SHIFT);
>  			pte_size =3D psize;
> -			is_io =3D hpte_cache_bits(pgprot_val(vma->vm_page_prot));
> +			is_ci =3D hpte_is_cache_inhibited(pgprot_val(vma->vm_page_prot));
>  			write_ok =3D vma->vm_flags & VM_WRITE;
>  		}
>  		up_read(&current->mm->mmap_sem);
> @@ -558,10 +558,9 @@ int kvmppc_book3s_hv_page_fault(struct kvm_run *run,=
 struct kvm_vcpu *vcpu,
>  		goto out_put;
> =20
>  	/* Check WIMG vs. the actual page we're accessing */
> -	if (!hpte_cache_flags_ok(r, is_io)) {
> -		if (is_io)
> +	if (!hpte_cache_flags_ok(r, is_ci)) {
> +		if (is_ci)
>  			goto out_put;
> -
>  		/*
>  		 * Allow guest to map emulated device memory as
>  		 * uncacheable, but actually make it cacheable.
> diff --git a/arch/powerpc/kvm/book3s_hv_rm_mmu.c b/arch/powerpc/kvm/book3=
s_hv_rm_mmu.c
> index 4cb8db05f3e5..3ebd620589a9 100644
> --- a/arch/powerpc/kvm/book3s_hv_rm_mmu.c
> +++ b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
> @@ -175,7 +175,7 @@ long kvmppc_do_h_enter(struct kvm *kvm, unsigned long=
 flags,
>  	unsigned long g_ptel;
>  	struct kvm_memory_slot *memslot;
>  	unsigned hpage_shift;
> -	unsigned long is_io;
> +	bool is_ci;
>  	unsigned long *rmap;
>  	pte_t *ptep;
>  	unsigned int writing;
> @@ -199,7 +199,7 @@ long kvmppc_do_h_enter(struct kvm *kvm, unsigned long=
 flags,
>  	gfn =3D gpa >> PAGE_SHIFT;
>  	memslot =3D __gfn_to_memslot(kvm_memslots_raw(kvm), gfn);
>  	pa =3D 0;
> -	is_io =3D ~0ul;
> +	is_ci =3D false;
>  	rmap =3D NULL;
>  	if (!(memslot && !(memslot->flags & KVM_MEMSLOT_INVALID))) {
>  		/* Emulated MMIO - mark this with key=3D31 */
> @@ -250,7 +250,7 @@ long kvmppc_do_h_enter(struct kvm *kvm, unsigned long=
 flags,
>  			if (writing && !pte_write(pte))
>  				/* make the actual HPTE be read-only */
>  				ptel =3D hpte_make_readonly(ptel);
> -			is_io =3D hpte_cache_bits(pte_val(pte));
> +			is_ci =3D hpte_is_cache_inhibited(pte_val(pte));
>  			pa =3D pte_pfn(pte) << PAGE_SHIFT;
>  			pa |=3D hva & (host_pte_size - 1);
>  			pa |=3D gpa & ~PAGE_MASK;
> @@ -267,9 +267,9 @@ long kvmppc_do_h_enter(struct kvm *kvm, unsigned long=
 flags,
>  	else
>  		pteh |=3D HPTE_V_ABSENT;
> =20
> -	/* Check WIMG */
> -	if (is_io !=3D ~0ul && !hpte_cache_flags_ok(ptel, is_io)) {
> -		if (is_io)
> +	/*If we had host pte mapping then  Check WIMG */
> +	if (ptep && !hpte_cache_flags_ok(ptel, is_ci)) {
> +		if (is_ci)
>  			return H_PARAMETER;
>  		/*
>  		 * Allow guest to map emulated device memory as
> diff --git a/arch/powerpc/mm/hash64_64k.c b/arch/powerpc/mm/hash64_64k.c
> index f33b410d6c8a..243c822913e4 100644
> --- a/arch/powerpc/mm/hash64_64k.c
> +++ b/arch/powerpc/mm/hash64_64k.c
> @@ -248,7 +248,7 @@ int __hash_page_64K(unsigned long ea, unsigned long a=
ccess,
>  		 * If so, bail out and refault as a 4k page
>  		 */
>  		if (!mmu_has_feature(MMU_FTR_CI_LARGE_PAGE) &&
> -		    unlikely(old_pte & _PAGE_NO_CACHE))
> +		    unlikely(old_pte & _PAGE_TOLERANT))
>  			return 0;
>  		/*
>  		 * Try to lock the PTE, add ACCESSED and DIRTY if it was
> diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils=
_64.c
> index c81c08aaff0e..728acd17f2a6 100644
> --- a/arch/powerpc/mm/hash_utils_64.c
> +++ b/arch/powerpc/mm/hash_utils_64.c
> @@ -192,12 +192,12 @@ unsigned long htab_convert_pte_flags(unsigned long =
pteflags)
>  	/*
>  	 * Add in WIG bits
>  	 */
> -	if (pteflags & _PAGE_WRITETHRU)
> -		rflags |=3D HPTE_R_W;
> -	if (pteflags & _PAGE_NO_CACHE)
> +	if (pteflags & _PAGE_TOLERANT)
>  		rflags |=3D HPTE_R_I;
> -	if (pteflags & _PAGE_GUARDED)
> -		rflags |=3D HPTE_R_G;
> +	if (pteflags & _PAGE_NON_IDEMPOTENT)
> +		rflags |=3D (HPTE_R_I | HPTE_R_G);
> +	if (pteflags & _PAGE_SAO)
> +		rflags |=3D (HPTE_R_I | HPTE_R_W);
> =20
>  	return rflags;
>  }
> @@ -1139,7 +1139,7 @@ int hash_page_mm(struct mm_struct *mm, unsigned lon=
g ea,
>  	 * using non cacheable large pages, then we switch to 4k
>  	 */
>  	if (mmu_ci_restrictions && psize =3D=3D MMU_PAGE_64K &&
> -	    (pte_val(*ptep) & _PAGE_NO_CACHE)) {
> +	    (pte_val(*ptep) & _PAGE_TOLERANT)) {
>  		if (user_region) {
>  			demote_segment_4k(mm, ea);
>  			psize =3D MMU_PAGE_4K;
> @@ -1298,7 +1298,7 @@ void hash_preload(struct mm_struct *mm, unsigned lo=
ng ea,
>  	 * That way we don't have to duplicate all of the logic for segment
>  	 * page size demotion here
>  	 */
> -	if (pte_val(*ptep) & (_PAGE_4K_PFN | _PAGE_NO_CACHE))
> +	if (pte_val(*ptep) & (_PAGE_4K_PFN | _PAGE_TOLERANT))
>  		goto out_exit;
>  #endif /* CONFIG_PPC_64K_PAGES */
> =20
> diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
> index 7b492283d502..ad8b6432f7e3 100644
> --- a/arch/powerpc/mm/pgtable.c
> +++ b/arch/powerpc/mm/pgtable.c
> @@ -46,7 +46,7 @@ static inline int pte_looks_normal(pte_t pte)
> =20
>  #if defined(CONFIG_PPC_BOOK3S_64)
>  	if ((pte_val(pte) &
> -	     (_PAGE_PRESENT | _PAGE_SPECIAL | _PAGE_NO_CACHE)) =3D=3D
> +	     (_PAGE_PRESENT | _PAGE_SPECIAL | _PAGE_TOLERANT)) =3D=3D
>  	    _PAGE_PRESENT) {
>  		if (!(pte_val(pte) & _PAGE_PRIVILEGED))
>  			return 1;
> diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
> index 6f1b7064f822..db924c54f370 100644
> --- a/arch/powerpc/mm/pgtable_64.c
> +++ b/arch/powerpc/mm/pgtable_64.c
> @@ -167,10 +167,6 @@ void __iomem * __ioremap_at(phys_addr_t pa, void *ea=
, unsigned long size,
>  	if ((flags & _PAGE_PRESENT) =3D=3D 0)
>  		flags |=3D pgprot_val(PAGE_KERNEL);
> =20
> -	/* Non-cacheable page cannot be coherent */
> -	if (flags & _PAGE_NO_CACHE)
> -		flags &=3D ~_PAGE_COHERENT;
> -
>  	/* We don't support the 4K PFN hack with ioremap */
>  	if (flags & _PAGE_4K_PFN)
>  		return NULL;
> diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platfor=
ms/pseries/lpar.c
> index 2415a0d31f8f..0d4608990702 100644
> --- a/arch/powerpc/platforms/pseries/lpar.c
> +++ b/arch/powerpc/platforms/pseries/lpar.c
> @@ -152,10 +152,6 @@ static long pSeries_lpar_hpte_insert(unsigned long h=
pte_group,
>  	/* Exact =3D 0                   */
>  	flags =3D 0;
> =20
> -	/* Make pHyp happy */
> -	if ((rflags & _PAGE_NO_CACHE) && !(rflags & _PAGE_WRITETHRU))
> -		hpte_r &=3D ~HPTE_R_M;
> -
>  	if (firmware_has_feature(FW_FEATURE_XCMO) && !(hpte_r & HPTE_R_N))
>  		flags |=3D H_COALESCE_CAND;
> =20
