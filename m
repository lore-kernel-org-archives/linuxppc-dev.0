Return-Path: <R65777@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E57212C00CE
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Oct 2013 23:44:15 +1000 (EST)
From: Bhushan Bharat-R65777 <R65777@freescale.com>
To: Alexander Graf <agraf@suse.de>
Subject: RE: [PATCH 4/6 v5] kvm: powerpc: keep only pte search logic in
 lookup_linux_pte
Date: Fri, 4 Oct 2013 13:44:07 +0000
Message-ID: <6A3DF150A5B70D4F9B66A25E3F7C888D07190372@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1379570566-3715-1-git-send-email-Bharat.Bhushan@freescale.com>
 <1379570566-3715-5-git-send-email-Bharat.Bhushan@freescale.com>
 <7DEA9422-69D4-4470-BE28-A3B0A623D000@suse.de>
In-Reply-To: <7DEA9422-69D4-4470-BE28-A3B0A623D000@suse.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
 "paulus@samba.org" <paulus@samba.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Alexander Graf [mailto:agraf@suse.de]
> Sent: Friday, October 04, 2013 6:57 PM
> To: Bhushan Bharat-R65777
> Cc: benh@kernel.crashing.org; paulus@samba.org; kvm@vger.kernel.org; kvm-
> ppc@vger.kernel.org; linuxppc-dev@lists.ozlabs.org; Wood Scott-B07421; Bh=
ushan
> Bharat-R65777
> Subject: Re: [PATCH 4/6 v5] kvm: powerpc: keep only pte search logic in
> lookup_linux_pte
>=20
>=20
> On 19.09.2013, at 08:02, Bharat Bhushan wrote:
>=20
> > lookup_linux_pte() was searching for a pte and also sets access flags
> > is writable. This function now searches only pte while access flag
> > setting is done explicitly.
> >
> > This pte lookup is not kvm specific, so moved to common code
> > (asm/pgtable.h) My Followup patch will use this on booke.
> >
> > Signed-off-by: Bharat Bhushan <bharat.bhushan@freescale.com>
> > ---
> > v4->v5
> > - No change
> >
> > arch/powerpc/include/asm/pgtable.h  |   24 +++++++++++++++++++++++
> > arch/powerpc/kvm/book3s_hv_rm_mmu.c |   36 +++++++++++-----------------=
------
> > 2 files changed, 36 insertions(+), 24 deletions(-)
> >
> > diff --git a/arch/powerpc/include/asm/pgtable.h
> > b/arch/powerpc/include/asm/pgtable.h
> > index 7d6eacf..3a5de5c 100644
> > --- a/arch/powerpc/include/asm/pgtable.h
> > +++ b/arch/powerpc/include/asm/pgtable.h
> > @@ -223,6 +223,30 @@ extern int gup_hugepte(pte_t *ptep, unsigned long
> > sz, unsigned long addr, #endif pte_t *find_linux_pte_or_hugepte(pgd_t
> > *pgdir, unsigned long ea,
> > 				 unsigned *shift);
> > +
> > +static inline pte_t *lookup_linux_pte(pgd_t *pgdir, unsigned long hva,
> > +				     unsigned long *pte_sizep)
> > +{
> > +	pte_t *ptep;
> > +	unsigned long ps =3D *pte_sizep;
> > +	unsigned int shift;
> > +
> > +	ptep =3D find_linux_pte_or_hugepte(pgdir, hva, &shift);
> > +	if (!ptep)
> > +		return __pte(0);
>=20
> This returns a struct pte_t, but your return value of the function is a s=
truct
> pte_t *. So this code will fail compiling with STRICT_MM_TYPECHECKS set. =
Any
> reason you don't just return NULL here?

I want to return the ptep (pte pointer) , so yes this should be NULL.
Will correct this.

Thanks
-Bharat

>=20
> That way callers could simply check on if (ptep) ... or you leave the ret=
urn
> value as struct pte_t.
>=20
>=20
> Alex
>=20
> > +	if (shift)
> > +		*pte_sizep =3D 1ul << shift;
> > +	else
> > +		*pte_sizep =3D PAGE_SIZE;
> > +
> > +	if (ps > *pte_sizep)
> > +		return __pte(0);
> > +
> > +	if (!pte_present(*ptep))
> > +		return __pte(0);
>=20
> > +
> > +	return ptep;
> > +}
> > #endif /* __ASSEMBLY__ */
> >
> > #endif /* __KERNEL__ */
> > diff --git a/arch/powerpc/kvm/book3s_hv_rm_mmu.c
> > b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
> > index 45e30d6..74fa7f8 100644
> > --- a/arch/powerpc/kvm/book3s_hv_rm_mmu.c
> > +++ b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
> > @@ -134,25 +134,6 @@ static void remove_revmap_chain(struct kvm *kvm, l=
ong
> pte_index,
> > 	unlock_rmap(rmap);
> > }
> >
> > -static pte_t lookup_linux_pte(pgd_t *pgdir, unsigned long hva,
> > -			      int writing, unsigned long *pte_sizep)
> > -{
> > -	pte_t *ptep;
> > -	unsigned long ps =3D *pte_sizep;
> > -	unsigned int hugepage_shift;
> > -
> > -	ptep =3D find_linux_pte_or_hugepte(pgdir, hva, &hugepage_shift);
> > -	if (!ptep)
> > -		return __pte(0);
> > -	if (hugepage_shift)
> > -		*pte_sizep =3D 1ul << hugepage_shift;
> > -	else
> > -		*pte_sizep =3D PAGE_SIZE;
> > -	if (ps > *pte_sizep)
> > -		return __pte(0);
> > -	return kvmppc_read_update_linux_pte(ptep, writing, hugepage_shift);
> > -}
> > -
> > static inline void unlock_hpte(unsigned long *hpte, unsigned long
> > hpte_v) {
> > 	asm volatile(PPC_RELEASE_BARRIER "" : : : "memory"); @@ -173,6 +154,7
> > @@ long kvmppc_do_h_enter(struct kvm *kvm, unsigned long flags,
> > 	unsigned long is_io;
> > 	unsigned long *rmap;
> > 	pte_t pte;
> > +	pte_t *ptep;
> > 	unsigned int writing;
> > 	unsigned long mmu_seq;
> > 	unsigned long rcbits;
> > @@ -231,8 +213,9 @@ long kvmppc_do_h_enter(struct kvm *kvm, unsigned
> > long flags,
> >
> > 		/* Look up the Linux PTE for the backing page */
> > 		pte_size =3D psize;
> > -		pte =3D lookup_linux_pte(pgdir, hva, writing, &pte_size);
> > -		if (pte_present(pte)) {
> > +		ptep =3D lookup_linux_pte(pgdir, hva, &pte_size);
> > +		if (pte_present(pte_val(*ptep))) {
> > +			pte =3D kvmppc_read_update_linux_pte(ptep, writing);
> > 			if (writing && !pte_write(pte))
> > 				/* make the actual HPTE be read-only */
> > 				ptel =3D hpte_make_readonly(ptel);
> > @@ -661,15 +644,20 @@ long kvmppc_h_protect(struct kvm_vcpu *vcpu, unsi=
gned
> long flags,
> > 			struct kvm_memory_slot *memslot;
> > 			pgd_t *pgdir =3D vcpu->arch.pgdir;
> > 			pte_t pte;
> > +			pte_t *ptep;
> >
> > 			psize =3D hpte_page_size(v, r);
> > 			gfn =3D ((r & HPTE_R_RPN) & ~(psize - 1)) >> PAGE_SHIFT;
> > 			memslot =3D __gfn_to_memslot(kvm_memslots(kvm), gfn);
> > 			if (memslot) {
> > 				hva =3D __gfn_to_hva_memslot(memslot, gfn);
> > -				pte =3D lookup_linux_pte(pgdir, hva, 1, &psize);
> > -				if (pte_present(pte) && !pte_write(pte))
> > -					r =3D hpte_make_readonly(r);
> > +				ptep =3D lookup_linux_pte(pgdir, hva, &psize);
> > +				if (pte_present(pte_val(*ptep))) {
> > +					pte =3D kvmppc_read_update_linux_pte(ptep,
> > +									   1);
> > +					if (pte_present(pte) && !pte_write(pte))
> > +						r =3D hpte_make_readonly(r);
> > +				}
> > 			}
> > 		}
> > 	}
> > --
> > 1.7.0.4
> >
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe kvm-ppc" in
> > the body of a message to majordomo@vger.kernel.org More majordomo info
> > at  http://vger.kernel.org/majordomo-info.html
>=20
