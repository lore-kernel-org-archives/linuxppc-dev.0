Return-Path: <B07421@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe001.messaging.microsoft.com [65.55.88.11])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E00D02C00BD
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Jul 2013 04:49:41 +1000 (EST)
Date: Tue, 30 Jul 2013 13:49:26 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 4/4] kvm: powerpc: set cache coherency only for RAM pages
To: Bhushan Bharat-R65777 <R65777@freescale.com>
In-Reply-To: <6A3DF150A5B70D4F9B66A25E3F7C888D070EBC3F@039-SN2MPN1-013.039d.mgd.msft.net>
 (from R65777@freescale.com on Tue Jul 30 11:22:54 2013)
Message-ID: <1375210166.30721.77@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Alexander Graf <agraf@suse.de>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/30/2013 11:22:54 AM, Bhushan Bharat-R65777 wrote:
> diff --git a/arch/powerpc/kvm/e500_mmu_host.c =20
> b/arch/powerpc/kvm/e500_mmu_host.c
> index 5cbdc8f..a48c13f 100644
> --- a/arch/powerpc/kvm/e500_mmu_host.c
> +++ b/arch/powerpc/kvm/e500_mmu_host.c
> @@ -40,6 +40,84 @@
>=20
>  static struct kvmppc_e500_tlb_params host_tlb_params[E500_TLB_NUM];
>=20
> +/*
> + * find_linux_pte returns the address of a linux pte for a given
> + * effective address and directory.  If not found, it returns zero.
> + */
> +static inline pte_t *find_linux_pte(pgd_t *pgdir, unsigned long ea)
> +{
> +        pgd_t *pg;
> +        pud_t *pu;
> +        pmd_t *pm;
> +        pte_t *pt =3D NULL;
> +
> +        pg =3D pgdir + pgd_index(ea);
> +        if (!pgd_none(*pg)) {
> +                pu =3D pud_offset(pg, ea);
> +                if (!pud_none(*pu)) {
> +                        pm =3D pmd_offset(pu, ea);
> +                        if (pmd_present(*pm))
> +                                pt =3D pte_offset_kernel(pm, ea);
> +                }
> +        }
> +        return pt;
> +}

How is this specific to KVM or e500?

> +#ifdef CONFIG_HUGETLB_PAGE
> +pte_t *find_linux_pte_or_hugepte(pgd_t *pgdir, unsigned long ea,
> +                                 unsigned *shift);
> +#else
> +static inline pte_t *find_linux_pte_or_hugepte(pgd_t *pgdir, =20
> unsigned long ea,
> +                                               unsigned *shift)
> +{
> +        if (shift)
> +                *shift =3D 0;
> +        return find_linux_pte(pgdir, ea);
> +}
> +#endif /* !CONFIG_HUGETLB_PAGE */

This is already declared in asm/pgtable.h.  If we need a non-hugepage =20
alternative, that should also go in asm/pgtable.h.

> +/*
> + * Lock and read a linux PTE.  If it's present and writable, =20
> atomically
> + * set dirty and referenced bits and return the PTE, otherwise =20
> return 0.
> + */
> +static inline pte_t kvmppc_read_update_linux_pte(pte_t *p, int =20
> writing)
> +{
> +       pte_t pte =3D pte_val(*p);
> +
> +       if (pte_present(pte)) {
> +               pte =3D pte_mkyoung(pte);
> +               if (writing && pte_write(pte))
> +                       pte =3D pte_mkdirty(pte);
> +       }
> +
> +       *p =3D pte;
> +
> +       return pte;
> +}
> +
> +static pte_t lookup_linux_pte(pgd_t *pgdir, unsigned long hva,
> +                             int writing, unsigned long *pte_sizep)
> +{
> +       pte_t *ptep;
> +       unsigned long ps =3D *pte_sizep;
> +       unsigned int shift;
> +
> +       ptep =3D find_linux_pte_or_hugepte(pgdir, hva, &shift);
> +       if (!ptep)
> +               return __pte(0);
> +       if (shift)
> +               *pte_sizep =3D 1ul << shift;
> +       else
> +               *pte_sizep =3D PAGE_SIZE;
> +
> +       if (ps > *pte_sizep)
> +               return __pte(0);
> +       if (!pte_present(*ptep))
> +               return __pte(0);
> +
> +       return kvmppc_read_update_linux_pte(ptep, writing);
> +}
> +

None of this belongs in this file either.

> @@ -326,8 +405,8 @@ static void kvmppc_e500_setup_stlbe(
>=20
>         /* Force IPROT=3D0 for all guest mappings. */
>         stlbe->mas1 =3D MAS1_TSIZE(tsize) | get_tlb_sts(gtlbe) | =20
> MAS1_VALID;
> -       stlbe->mas2 =3D (gvaddr & MAS2_EPN) |
> -                     e500_shadow_mas2_attrib(gtlbe->mas2, pfn);
> +       stlbe->mas2 =3D (gvaddr & MAS2_EPN) | (ref->flags & =20
> E500_TLB_WIMGE_MASK);
> +//                   e500_shadow_mas2_attrib(gtlbe->mas2, pfn);

MAS2_E and MAS2_G should be safe to come from the guest.

How does this work for TLB1?  One ref corresponds to one guest entry, =20
which may correspond to multiple host entries, potentially each with =20
different WIM settings.

>         stlbe->mas7_3 =3D ((u64)pfn << PAGE_SHIFT) |
>                         e500_shadow_mas3_attrib(gtlbe->mas7_3, pr);
>=20
> @@ -346,6 +425,8 @@ static inline int kvmppc_e500_shadow_map(struct =20
> kvmppc_vcpu_e500 *vcpu_e500,
>         unsigned long hva;
>         int pfnmap =3D 0;
>         int tsize =3D BOOK3E_PAGESZ_4K;
> +       pte_t pte;
> +       int wimg =3D 0;
>=20
>         /*
>          * Translate guest physical to true physical, acquiring
> @@ -451,6 +532,8 @@ static inline int kvmppc_e500_shadow_map(struct =20
> kvmppc_vcpu_e500 *vcpu_e500,
>=20
>         if (likely(!pfnmap)) {
>                 unsigned long tsize_pages =3D 1 << (tsize + 10 - =20
> PAGE_SHIFT);
> +               pgd_t *pgdir;
> +
>                 pfn =3D gfn_to_pfn_memslot(slot, gfn);
>                 if (is_error_noslot_pfn(pfn)) {
>                         printk(KERN_ERR "Couldn't get real page for =20
> gfn %lx!\n",
> @@ -461,9 +544,15 @@ static inline int kvmppc_e500_shadow_map(struct =20
> kvmppc_vcpu_e500 *vcpu_e500,
>                 /* Align guest and physical address to page map =20
> boundaries */
>                 pfn &=3D ~(tsize_pages - 1);
>                 gvaddr &=3D ~((tsize_pages << PAGE_SHIFT) - 1);
> +               pgdir =3D vcpu_e500->vcpu.arch.pgdir;
> +               pte =3D lookup_linux_pte(pgdir, hva, 1, &tsize_pages);
> +               if (pte_present(pte))
> +                       wimg =3D (pte >> PTE_WIMGE_SHIFT) & =20
> MAS2_WIMGE_MASK;
> +               else
> +                       wimg =3D MAS2_I | MAS2_G;

If the PTE is not present, then we can't map it, right?  So why I+G?

-Scott=
