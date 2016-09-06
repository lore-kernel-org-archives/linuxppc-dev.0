Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sSpVf4VySzDsNR
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Sep 2016 11:12:42 +1000 (AEST)
Message-ID: <1473124362.6491.39.camel@neuling.org>
Subject: Re: [PATCH 3/4] powerpc/mm/radix: Use different pte update sequence
 for different POWER9 revs
From: Michael Neuling <mikey@neuling.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
Date: Tue, 06 Sep 2016 11:12:42 +1000
In-Reply-To: <1472031219-18759-3-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1472031219-18759-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1472031219-18759-3-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

On Wed, 2016-08-24 at 15:03 +0530, Aneesh Kumar K.V wrote:
> POWER9 DD1 requires pte to be marked invalid (V=3D0) before updating
> it with the new value. This makes this distinction for the different
> revisions.
>=20
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Acked-by: Michael Neuling <mikey@neuling.org>

> ---
> =C2=A0arch/powerpc/include/asm/book3s/32/pgtable.h |=C2=A0=C2=A03 +-
> =C2=A0arch/powerpc/include/asm/book3s/64/pgtable.h |=C2=A0=C2=A05 +-
> =C2=A0arch/powerpc/include/asm/book3s/64/radix.h=C2=A0=C2=A0=C2=A0| 75 ++=
++++++++++++++++++++------
> =C2=A0arch/powerpc/include/asm/nohash/32/pgtable.h |=C2=A0=C2=A03 +-
> =C2=A0arch/powerpc/include/asm/nohash/64/pgtable.h |=C2=A0=C2=A03 +-
> =C2=A0arch/powerpc/mm/pgtable-book3s64.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A02 +-
> =C2=A0arch/powerpc/mm/pgtable.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0|=C2=A0=C2=A02 +-
> =C2=A07 files changed, 71 insertions(+), 22 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/book3s/32/pgtable.h b/arch/powerpc/=
include/asm/book3s/32/pgtable.h
> index 38b33dcfcc9d..6b8b2d57fdc8 100644
> --- a/arch/powerpc/include/asm/book3s/32/pgtable.h
> +++ b/arch/powerpc/include/asm/book3s/32/pgtable.h
> @@ -223,7 +223,8 @@ static inline void huge_ptep_set_wrprotect(struct mm_=
struct *mm,
> =C2=A0}
> =C2=A0
> =C2=A0
> -static inline void __ptep_set_access_flags(pte_t *ptep, pte_t entry)
> +static inline void __ptep_set_access_flags(struct mm_struct *mm,
> +					=C2=A0=C2=A0=C2=A0pte_t *ptep, pte_t entry)
> =C2=A0{
> =C2=A0	unsigned long set =3D pte_val(entry) &
> =C2=A0		(_PAGE_DIRTY | _PAGE_ACCESSED | _PAGE_RW | _PAGE_EXEC);
> diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/=
include/asm/book3s/64/pgtable.h
> index 263bf39ced40..8ec8be9495ba 100644
> --- a/arch/powerpc/include/asm/book3s/64/pgtable.h
> +++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
> @@ -565,10 +565,11 @@ static inline bool check_pte_access(unsigned long a=
ccess, unsigned long ptev)
> =C2=A0 * Generic functions with hash/radix callbacks
> =C2=A0 */
> =C2=A0
> -static inline void __ptep_set_access_flags(pte_t *ptep, pte_t entry)
> +static inline void __ptep_set_access_flags(struct mm_struct *mm,
> +					=C2=A0=C2=A0=C2=A0pte_t *ptep, pte_t entry)
> =C2=A0{
> =C2=A0	if (radix_enabled())
> -		return radix__ptep_set_access_flags(ptep, entry);
> +		return radix__ptep_set_access_flags(mm, ptep, entry);
> =C2=A0	return hash__ptep_set_access_flags(ptep, entry);
> =C2=A0}
> =C2=A0
> diff --git a/arch/powerpc/include/asm/book3s/64/radix.h b/arch/powerpc/in=
clude/asm/book3s/64/radix.h
> index a2fe8fbfbd3d..2a46dea8e1b1 100644
> --- a/arch/powerpc/include/asm/book3s/64/radix.h
> +++ b/arch/powerpc/include/asm/book3s/64/radix.h
> @@ -11,6 +11,11 @@
> =C2=A0#include=20
> =C2=A0#endif
> =C2=A0
> +#ifndef __ASSEMBLY__
> +#include=20
> +#include=20
> +#endif
> +
> =C2=A0/* An empty PTE can still have a R or C writeback */
> =C2=A0#define RADIX_PTE_NONE_MASK		(_PAGE_DIRTY | _PAGE_ACCESSED)
> =C2=A0
> @@ -105,11 +110,8 @@
> =C2=A0#define RADIX_PUD_TABLE_SIZE	(sizeof(pud_t) << RADIX_PUD_INDEX_SIZE=
)
> =C2=A0#define RADIX_PGD_TABLE_SIZE	(sizeof(pgd_t) << RADIX_PGD_INDEX_SIZE=
)
> =C2=A0
> -static inline unsigned long radix__pte_update(struct mm_struct *mm,
> -					unsigned long addr,
> -					pte_t *ptep, unsigned long clr,
> -					unsigned long set,
> -					int huge)
> +static inline unsigned long __radix_pte_update(pte_t *ptep, unsigned lon=
g clr,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned long set)
> =C2=A0{
> =C2=A0	pte_t pte;
> =C2=A0	unsigned long old_pte, new_pte;
> @@ -121,9 +123,39 @@ static inline unsigned long radix__pte_update(struct=
 mm_struct *mm,
> =C2=A0
> =C2=A0	} while (!pte_xchg(ptep, __pte(old_pte), __pte(new_pte)));
> =C2=A0
> -	/* We already do a sync in cmpxchg, is ptesync needed ?*/
> +	return old_pte;
> +}
> +
> +
> +static inline unsigned long radix__pte_update(struct mm_struct *mm,
> +					unsigned long addr,
> +					pte_t *ptep, unsigned long clr,
> +					unsigned long set,
> +					int huge)
> +{
> +	unsigned long old_pte;
> +
> +	if (cpu_has_feature(CPU_FTR_POWER9_DD1)) {
> +
> +		unsigned long new_pte;
> +
> +		old_pte =3D __radix_pte_update(ptep, ~0, 0);
> +		asm volatile("ptesync" : : : "memory");
> +		/*
> +		=C2=A0* new value of pte
> +		=C2=A0*/
> +		new_pte =3D (old_pte | set) & ~clr;
> +
> +		/*
> +		=C2=A0* For now let's do heavy pid flush
> +		=C2=A0* radix__flush_tlb_page_psize(mm, addr, mmu_virtual_psize);
> +		=C2=A0*/
> +		radix__flush_tlb_mm(mm);
> +
> +		__radix_pte_update(ptep, 0, new_pte);
> +	} else
> +		old_pte =3D __radix_pte_update(ptep, clr, set);
> =C2=A0	asm volatile("ptesync" : : : "memory");
> -	/* huge pages use the old page table lock */
> =C2=A0	if (!huge)
> =C2=A0		assert_pte_locked(mm, addr);
> =C2=A0
> @@ -134,20 +166,33 @@ static inline unsigned long radix__pte_update(struc=
t mm_struct *mm,
> =C2=A0 * Set the dirty and/or accessed bits atomically in a linux PTE, th=
is
> =C2=A0 * function doesn't need to invalidate tlb.
> =C2=A0 */
> -static inline void radix__ptep_set_access_flags(pte_t *ptep, pte_t entry=
)
> +static inline void radix__ptep_set_access_flags(struct mm_struct *mm,
> +						pte_t *ptep, pte_t entry)
> =C2=A0{
> -	pte_t pte;
> -	unsigned long old_pte, new_pte;
> +
> =C2=A0	unsigned long set =3D pte_val(entry) & (_PAGE_DIRTY | _PAGE_ACCESS=
ED |
> =C2=A0					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0_PAGE_RW | _PAGE_EXEC);
> -	do {
> -		pte =3D READ_ONCE(*ptep);
> -		old_pte =3D pte_val(pte);
> +
> +	if (cpu_has_feature(CPU_FTR_POWER9_DD1)) {
> +
> +		unsigned long old_pte, new_pte;
> +
> +		old_pte =3D __radix_pte_update(ptep, ~0, 0);
> +		asm volatile("ptesync" : : : "memory");
> +		/*
> +		=C2=A0* new value of pte
> +		=C2=A0*/
> =C2=A0		new_pte =3D old_pte | set;
> =C2=A0
> -	} while (!pte_xchg(ptep, __pte(old_pte), __pte(new_pte)));
> +		/*
> +		=C2=A0* For now let's do heavy pid flush
> +		=C2=A0* radix__flush_tlb_page_psize(mm, addr, mmu_virtual_psize);
> +		=C2=A0*/
> +		radix__flush_tlb_mm(mm);
> =C2=A0
> -	/* We already do a sync in cmpxchg, is ptesync needed ?*/
> +		__radix_pte_update(ptep, 0, new_pte);
> +	} else
> +		__radix_pte_update(ptep, 0, set);
> =C2=A0	asm volatile("ptesync" : : : "memory");
> =C2=A0}
> =C2=A0
> diff --git a/arch/powerpc/include/asm/nohash/32/pgtable.h b/arch/powerpc/=
include/asm/nohash/32/pgtable.h
> index 780847597514..c219ef7be53b 100644
> --- a/arch/powerpc/include/asm/nohash/32/pgtable.h
> +++ b/arch/powerpc/include/asm/nohash/32/pgtable.h
> @@ -267,7 +267,8 @@ static inline void huge_ptep_set_wrprotect(struct mm_=
struct *mm,
> =C2=A0}
> =C2=A0
> =C2=A0
> -static inline void __ptep_set_access_flags(pte_t *ptep, pte_t entry)
> +static inline void __ptep_set_access_flags(struct mm_struct *mm,
> +					=C2=A0=C2=A0=C2=A0pte_t *ptep, pte_t entry)
> =C2=A0{
> =C2=A0	unsigned long set =3D pte_val(entry) &
> =C2=A0		(_PAGE_DIRTY | _PAGE_ACCESSED | _PAGE_RW | _PAGE_EXEC);
> diff --git a/arch/powerpc/include/asm/nohash/64/pgtable.h b/arch/powerpc/=
include/asm/nohash/64/pgtable.h
> index d4d808cf905e..653a1838469d 100644
> --- a/arch/powerpc/include/asm/nohash/64/pgtable.h
> +++ b/arch/powerpc/include/asm/nohash/64/pgtable.h
> @@ -300,7 +300,8 @@ static inline void pte_clear(struct mm_struct *mm, un=
signed long addr,
> =C2=A0/* Set the dirty and/or accessed bits atomically in a linux PTE, th=
is
> =C2=A0 * function doesn't need to flush the hash entry
> =C2=A0 */
> -static inline void __ptep_set_access_flags(pte_t *ptep, pte_t entry)
> +static inline void __ptep_set_access_flags(struct mm_struct *mm,
> +					=C2=A0=C2=A0=C2=A0pte_t *ptep, pte_t entry)
> =C2=A0{
> =C2=A0	unsigned long bits =3D pte_val(entry) &
> =C2=A0		(_PAGE_DIRTY | _PAGE_ACCESSED | _PAGE_RW | _PAGE_EXEC);
> diff --git a/arch/powerpc/mm/pgtable-book3s64.c b/arch/powerpc/mm/pgtable=
-book3s64.c
> index 34079302cc17..7328886bca4c 100644
> --- a/arch/powerpc/mm/pgtable-book3s64.c
> +++ b/arch/powerpc/mm/pgtable-book3s64.c
> @@ -35,7 +35,7 @@ int pmdp_set_access_flags(struct vm_area_struct *vma, u=
nsigned long address,
> =C2=A0#endif
> =C2=A0	changed =3D !pmd_same(*(pmdp), entry);
> =C2=A0	if (changed) {
> -		__ptep_set_access_flags(pmdp_ptep(pmdp), pmd_pte(entry));
> +		__ptep_set_access_flags(vma->vm_mm, pmdp_ptep(pmdp), pmd_pte(entry));
> =C2=A0		flush_pmd_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
> =C2=A0	}
> =C2=A0	return changed;
> diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
> index 0b6fb244d0a1..911fdfb63ec1 100644
> --- a/arch/powerpc/mm/pgtable.c
> +++ b/arch/powerpc/mm/pgtable.c
> @@ -224,7 +224,7 @@ int ptep_set_access_flags(struct vm_area_struct *vma,=
 unsigned long address,
> =C2=A0	if (changed) {
> =C2=A0		if (!is_vm_hugetlb_page(vma))
> =C2=A0			assert_pte_locked(vma->vm_mm, address);
> -		__ptep_set_access_flags(ptep, entry);
> +		__ptep_set_access_flags(vma->vm_mm, ptep, entry);
> =C2=A0		flush_tlb_page(vma, address);
> =C2=A0	}
> =C2=A0	return changed;
