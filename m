Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by ozlabs.org (Postfix) with ESMTP id A14B12C00C2
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Oct 2013 23:27:22 +1000 (EST)
Subject: Re: [PATCH 4/6 v5] kvm: powerpc: keep only pte search logic in
 lookup_linux_pte
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1379570566-3715-5-git-send-email-Bharat.Bhushan@freescale.com>
Date: Fri, 4 Oct 2013 15:27:16 +0200
Message-Id: <7DEA9422-69D4-4470-BE28-A3B0A623D000@suse.de>
References: <1379570566-3715-1-git-send-email-Bharat.Bhushan@freescale.com>
 <1379570566-3715-5-git-send-email-Bharat.Bhushan@freescale.com>
To: Bharat Bhushan <r65777@freescale.com>
Cc: kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
 Bharat Bhushan <Bharat.Bhushan@freescale.com>, paulus@samba.org,
 scottwood@freescale.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 19.09.2013, at 08:02, Bharat Bhushan wrote:

> lookup_linux_pte() was searching for a pte and also sets access
> flags is writable. This function now searches only pte while
> access flag setting is done explicitly.
>=20
> This pte lookup is not kvm specific, so moved to common code =
(asm/pgtable.h)
> My Followup patch will use this on booke.
>=20
> Signed-off-by: Bharat Bhushan <bharat.bhushan@freescale.com>
> ---
> v4->v5
> - No change
>=20
> arch/powerpc/include/asm/pgtable.h  |   24 +++++++++++++++++++++++
> arch/powerpc/kvm/book3s_hv_rm_mmu.c |   36 =
+++++++++++-----------------------
> 2 files changed, 36 insertions(+), 24 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/pgtable.h =
b/arch/powerpc/include/asm/pgtable.h
> index 7d6eacf..3a5de5c 100644
> --- a/arch/powerpc/include/asm/pgtable.h
> +++ b/arch/powerpc/include/asm/pgtable.h
> @@ -223,6 +223,30 @@ extern int gup_hugepte(pte_t *ptep, unsigned long =
sz, unsigned long addr,
> #endif
> pte_t *find_linux_pte_or_hugepte(pgd_t *pgdir, unsigned long ea,
> 				 unsigned *shift);
> +
> +static inline pte_t *lookup_linux_pte(pgd_t *pgdir, unsigned long =
hva,
> +				     unsigned long *pte_sizep)
> +{
> +	pte_t *ptep;
> +	unsigned long ps =3D *pte_sizep;
> +	unsigned int shift;
> +
> +	ptep =3D find_linux_pte_or_hugepte(pgdir, hva, &shift);
> +	if (!ptep)
> +		return __pte(0);

This returns a struct pte_t, but your return value of the function is a =
struct pte_t *. So this code will fail compiling with =
STRICT_MM_TYPECHECKS set. Any reason you don't just return NULL here?

That way callers could simply check on if (ptep) ... or you leave the =
return value as struct pte_t.


Alex

> +	if (shift)
> +		*pte_sizep =3D 1ul << shift;
> +	else
> +		*pte_sizep =3D PAGE_SIZE;
> +
> +	if (ps > *pte_sizep)
> +		return __pte(0);
> +
> +	if (!pte_present(*ptep))
> +		return __pte(0);

> +
> +	return ptep;
> +}
> #endif /* __ASSEMBLY__ */
>=20
> #endif /* __KERNEL__ */
> diff --git a/arch/powerpc/kvm/book3s_hv_rm_mmu.c =
b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
> index 45e30d6..74fa7f8 100644
> --- a/arch/powerpc/kvm/book3s_hv_rm_mmu.c
> +++ b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
> @@ -134,25 +134,6 @@ static void remove_revmap_chain(struct kvm *kvm, =
long pte_index,
> 	unlock_rmap(rmap);
> }
>=20
> -static pte_t lookup_linux_pte(pgd_t *pgdir, unsigned long hva,
> -			      int writing, unsigned long *pte_sizep)
> -{
> -	pte_t *ptep;
> -	unsigned long ps =3D *pte_sizep;
> -	unsigned int hugepage_shift;
> -
> -	ptep =3D find_linux_pte_or_hugepte(pgdir, hva, &hugepage_shift);
> -	if (!ptep)
> -		return __pte(0);
> -	if (hugepage_shift)
> -		*pte_sizep =3D 1ul << hugepage_shift;
> -	else
> -		*pte_sizep =3D PAGE_SIZE;
> -	if (ps > *pte_sizep)
> -		return __pte(0);
> -	return kvmppc_read_update_linux_pte(ptep, writing, =
hugepage_shift);
> -}
> -
> static inline void unlock_hpte(unsigned long *hpte, unsigned long =
hpte_v)
> {
> 	asm volatile(PPC_RELEASE_BARRIER "" : : : "memory");
> @@ -173,6 +154,7 @@ long kvmppc_do_h_enter(struct kvm *kvm, unsigned =
long flags,
> 	unsigned long is_io;
> 	unsigned long *rmap;
> 	pte_t pte;
> +	pte_t *ptep;
> 	unsigned int writing;
> 	unsigned long mmu_seq;
> 	unsigned long rcbits;
> @@ -231,8 +213,9 @@ long kvmppc_do_h_enter(struct kvm *kvm, unsigned =
long flags,
>=20
> 		/* Look up the Linux PTE for the backing page */
> 		pte_size =3D psize;
> -		pte =3D lookup_linux_pte(pgdir, hva, writing, =
&pte_size);
> -		if (pte_present(pte)) {
> +		ptep =3D lookup_linux_pte(pgdir, hva, &pte_size);
> +		if (pte_present(pte_val(*ptep))) {
> +			pte =3D kvmppc_read_update_linux_pte(ptep, =
writing);
> 			if (writing && !pte_write(pte))
> 				/* make the actual HPTE be read-only */
> 				ptel =3D hpte_make_readonly(ptel);
> @@ -661,15 +644,20 @@ long kvmppc_h_protect(struct kvm_vcpu *vcpu, =
unsigned long flags,
> 			struct kvm_memory_slot *memslot;
> 			pgd_t *pgdir =3D vcpu->arch.pgdir;
> 			pte_t pte;
> +			pte_t *ptep;
>=20
> 			psize =3D hpte_page_size(v, r);
> 			gfn =3D ((r & HPTE_R_RPN) & ~(psize - 1)) >> =
PAGE_SHIFT;
> 			memslot =3D __gfn_to_memslot(kvm_memslots(kvm), =
gfn);
> 			if (memslot) {
> 				hva =3D __gfn_to_hva_memslot(memslot, =
gfn);
> -				pte =3D lookup_linux_pte(pgdir, hva, 1, =
&psize);
> -				if (pte_present(pte) && !pte_write(pte))
> -					r =3D hpte_make_readonly(r);
> +				ptep =3D lookup_linux_pte(pgdir, hva, =
&psize);
> +				if (pte_present(pte_val(*ptep))) {
> +					pte =3D =
kvmppc_read_update_linux_pte(ptep,
> +									 =
  1);
> +					if (pte_present(pte) && =
!pte_write(pte))
> +						r =3D =
hpte_make_readonly(r);
> +				}
> 			}
> 		}
> 	}
> --=20
> 1.7.0.4
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe kvm-ppc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
