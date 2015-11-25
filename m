Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8D45D1A0343
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2015 17:22:43 +1100 (AEDT)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 25 Nov 2015 11:52:40 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 863FB1258019
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2015 11:52:53 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tAP6MXfS66912478
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2015 11:52:34 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tAP6MWm5010085
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2015 11:52:33 +0530
Message-ID: <565553A8.2070006@linux.vnet.ibm.com>
Date: Wed, 25 Nov 2015 11:52:32 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Scott Wood <scottwood@freescale.com>,
 Denis Kirjanov <kda@linux-powerpc.org>
CC: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V5 11/31] powerpc/mm: Move hash64 PTE bits from
 book3s/64/pgtable.h to hash.h
References: <1448274160-28446-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1448274160-28446-12-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1448274160-28446-12-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/23/2015 03:52 PM, Aneesh Kumar K.V wrote:
> +extern struct page *pmd_page(pmd_t pmd);
>  static inline pte_t pud_pte(pud_t pud)
>  {
>  	return __pte(pud_val(pud));
> @@ -294,15 +115,14 @@ static inline void pgd_set(pgd_t *pgdp, unsigned long val)
>   * Find an entry in a page-table-directory.  We combine the address region
>   * (the high order N bits) and the pgd portion of the address.
>   */
> -#define pgd_index(address) (((address) >> (PGDIR_SHIFT)) & (PTRS_PER_PGD - 1))
>  
>  #define pgd_offset(mm, address)	 ((mm)->pgd + pgd_index(address))
>  
>  #define pmd_offset(pudp,addr) \
> -  (((pmd_t *) pud_page_vaddr(*(pudp))) + (((addr) >> PMD_SHIFT) & (PTRS_PER_PMD - 1)))
> +	(((pmd_t *) pud_page_vaddr(*(pudp))) + pmd_index(addr))
>  
>  #define pte_offset_kernel(dir,addr) \
> -  (((pte_t *) pmd_page_vaddr(*(dir))) + (((addr) >> PAGE_SHIFT) & (PTRS_PER_PTE - 1)))
> +	(((pte_t *) pmd_page_vaddr(*(dir))) + pte_index(addr))

These additions of the code should have been done in a separate patch.

This has been observed in some of the previous patches as well. If the
commit message says that PTE definitions need to be moved then the
patch only needs to move them, not change them anyway while on the move.
Any changes to code should be done in separate patch. That will keep
the change log clean, logical and makes it easy to track and understand.

------------------------------------------------------------------------
powerpc/mm: Move hash64 PTE bits from book3s/64/pgtable.h to hash.h
    
This enables us to keep hash64 related bits together, and makes it easy
to follow.
    
Acked-by: Scott Wood <scottwood@freescale.com>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

 arch/powerpc/include/asm/book3s/64/hash.h    | 450 ++++++++++++++++++
 arch/powerpc/include/asm/book3s/64/pgtable.h | 447 ------------------
 arch/powerpc/include/asm/pgtable.h           |   6 --
 3 files changed, 450 insertions(+), 453 deletions(-)
