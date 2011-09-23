Return-Path: <beckyb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 96840B6F85
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Sep 2011 02:40:04 +1000 (EST)
Subject: Re: [PATCH] powerpc: Fix hugetlb with CONFIG_PPC_MM_SLICES=y
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Becky Bruce <beckyb@kernel.crashing.org>
In-Reply-To: <20110921055810.GA21681@drongo>
Date: Fri, 23 Sep 2011 11:39:51 -0500
Message-Id: <0F6988C7-32FA-4829-BB81-A68B9F71214F@kernel.crashing.org>
References: <20110921055810.GA21681@drongo>
To: Paul Mackerras <paulus@samba.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: list linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Sep 21, 2011, at 12:58 AM, Paul Mackerras wrote:

> Commit 41151e77a4 ("powerpc: Hugetlb for BookE") added some
> #ifdef CONFIG_MM_SLICES conditionals to hugetlb_get_unmapped_area()
> and vma_mmu_pagesize().  Unfortunately this is not the correct config
> symbol; it should be CONFIG_PPC_MM_SLICES.  The result is that
> attempting to use hugetlbfs on 64-bit Power server processors results
> in an infinite stack recursion between get_unmapped_area() and
> hugetlb_get_unmapped_area().
>=20
> This fixes it by changing the #ifdef to use CONFIG_PPC_MM_SLICES
> in those functions and also in book3e_hugetlb_preload().
>=20
> Signed-off-by: Paul Mackerras <paulus@samba.org>

Paul, Ben,

ACK since it looks like Ben has picked this up already..... but FYI I =
have a different version of this fix in my tree.  The =
get_unmapped_area() shouldn't be there  *at all*  - we can just use the =
generic code if we don't have slices.  So instead the whole =
hugetlb_get_unmapped_area function should be wrapped in PPC_MM_SLICES.  =
This is crufty debug stuff that I missed yanking out when I pushed the =
patch, my apologies.

I'll just submit a followup patch to fix this.

Cheers,
B

> ---
> arch/powerpc/mm/hugetlbpage-book3e.c |    2 +-
> arch/powerpc/mm/hugetlbpage.c        |    4 ++--
> 2 files changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/powerpc/mm/hugetlbpage-book3e.c =
b/arch/powerpc/mm/hugetlbpage-book3e.c
> index 1295b7c..343ad0b 100644
> --- a/arch/powerpc/mm/hugetlbpage-book3e.c
> +++ b/arch/powerpc/mm/hugetlbpage-book3e.c
> @@ -52,7 +52,7 @@ void book3e_hugetlb_preload(struct mm_struct *mm, =
unsigned long ea, pte_t pte)
> 	if (unlikely(is_kernel_addr(ea)))
> 		return;
>=20
> -#ifdef CONFIG_MM_SLICES
> +#ifdef CONFIG_PPC_MM_SLICES
> 	psize =3D mmu_get_tsize(get_slice_psize(mm, ea));
> 	tsize =3D mmu_get_psize(psize);
> 	shift =3D mmu_psize_defs[psize].shift;
> diff --git a/arch/powerpc/mm/hugetlbpage.c =
b/arch/powerpc/mm/hugetlbpage.c
> index 3a5f59d..48b65be 100644
> --- a/arch/powerpc/mm/hugetlbpage.c
> +++ b/arch/powerpc/mm/hugetlbpage.c
> @@ -690,7 +690,7 @@ unsigned long hugetlb_get_unmapped_area(struct =
file *file, unsigned long addr,
> 					unsigned long len, unsigned long =
pgoff,
> 					unsigned long flags)
> {
> -#ifdef CONFIG_MM_SLICES
> +#ifdef CONFIG_PPC_MM_SLICES
> 	struct hstate *hstate =3D hstate_file(file);
> 	int mmu_psize =3D shift_to_mmu_psize(huge_page_shift(hstate));
>=20
> @@ -702,7 +702,7 @@ unsigned long hugetlb_get_unmapped_area(struct =
file *file, unsigned long addr,
>=20
> unsigned long vma_mmu_pagesize(struct vm_area_struct *vma)
> {
> -#ifdef CONFIG_MM_SLICES
> +#ifdef CONFIG_PPC_MM_SLICES
> 	unsigned int psize =3D get_slice_psize(vma->vm_mm, =
vma->vm_start);
>=20
> 	return 1UL << mmu_psize_to_shift(psize);
> --=20
> 1.7.5.4
