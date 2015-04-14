Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1F3A51A0CA1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 17:14:43 +1000 (AEST)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 14 Apr 2015 12:44:41 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 52538E0056
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 12:47:09 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3E7EZ2q1048962
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 12:44:35 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3E6sUQZ015715
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 12:24:31 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Scott Wood <scottwood@freescale.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] powerpc/hugetlb: Call mm_dec_nr_pmds() in
 hugetlb_free_pmd_range()
In-Reply-To: <1428713105-11796-1-git-send-email-scottwood@freescale.com>
References: <1428713105-11796-1-git-send-email-scottwood@freescale.com>
Date: Tue, 14 Apr 2015 12:44:10 +0530
Message-ID: <87fv83rxkt.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Scott Wood <scottwood@freescale.com> writes:

> Commit dc6c9a35b66b5 ("mm: account pmd page tables to the process")
> added a counter that is incremented whenever a PMD is allocated and
> decremented whenever a PMD is freed.  For hugepages on PPC, common code
> is used to allocated PMDs, but arch-specific code is used to free PMDs.
>
> This results in kernel output such as "BUG: non-zero nr_pmds on freeing
> mm: 1" when using hugepages.
>
> Update the PPC hugepage PMD freeing code to decrement the count, just
> as the above commit did for free_pmd_range().
>
> Fixes: dc6c9a35b66b5 ("mm: account pmd page tables to the process")
> Signed-off-by: Scott Wood <scottwood@freescale.com>

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

May be we need to move that mm_dec_nr_pmds to pmd_free_tlb() ?

> ---
> Should we also be touching nr_ptes when we alloc/free hugepage PTEs?
>
>  arch/powerpc/mm/hugetlbpage.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
> index 7e408bf..cecbe00 100644
> --- a/arch/powerpc/mm/hugetlbpage.c
> +++ b/arch/powerpc/mm/hugetlbpage.c
> @@ -581,6 +581,7 @@ static void hugetlb_free_pmd_range(struct mmu_gather *tlb, pud_t *pud,
>  	pmd = pmd_offset(pud, start);
>  	pud_clear(pud);
>  	pmd_free_tlb(tlb, pmd, start);
> +	mm_dec_nr_pmds(tlb->mm);
>  }
>  
>  static void hugetlb_free_pud_range(struct mmu_gather *tlb, pgd_t *pgd,
> -- 
> 2.1.0
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
