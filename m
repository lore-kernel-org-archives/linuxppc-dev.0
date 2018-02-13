Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zgtTM3l9zzF1Q7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Feb 2018 06:51:35 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1DJnX7c056925
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Feb 2018 14:51:33 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2g45utshef-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Feb 2018 14:51:32 -0500
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Tue, 13 Feb 2018 19:51:31 -0000
Date: Tue, 13 Feb 2018 11:51:23 -0800
From: Ram Pai <linuxram@us.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V3] powerpc/mm/hash64: memset the pagetable pages on
 allocation.
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <20180213110933.5491-1-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180213110933.5491-1-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <20180213195123.GG5559@ram.oc3035372033.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Feb 13, 2018 at 04:39:33PM +0530, Aneesh Kumar K.V wrote:
> On powerpc we allocate page table pages from slab cache of different sizes. For
> now we have a constructor that zero out the objects when we allocate then for
> the first time. We expect the objects to be zeroed out when we free the the
> object back to slab cache. This happens in the unmap path. For hugetlb pages
> we call huge_pte_get_and_clear to do that. With the current configuration of
> page table size, both pud and pgd level tables get allocated from the same slab
> cache. At the pud level, we use the second half of the table to store the slot
> information. But never clear that when unmapping. When such an freed object get
> allocated at pgd level, we will have part of the page table page not initlaized
> correctly. This result in kernel crash
> 
> Simplify this by calling the object initialization after kmem_cache_alloc
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/book3s/64/pgalloc.h | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/book3s/64/pgalloc.h b/arch/powerpc/include/asm/book3s/64/pgalloc.h
> index 53df86d3cfce..e4d154a4d114 100644
> --- a/arch/powerpc/include/asm/book3s/64/pgalloc.h
> +++ b/arch/powerpc/include/asm/book3s/64/pgalloc.h
> @@ -73,10 +73,13 @@ static inline void radix__pgd_free(struct mm_struct *mm, pgd_t *pgd)
> 
>  static inline pgd_t *pgd_alloc(struct mm_struct *mm)
>  {
> +	pgd_t *pgd;
>  	if (radix_enabled())
>  		return radix__pgd_alloc(mm);
> -	return kmem_cache_alloc(PGT_CACHE(PGD_INDEX_SIZE),
> -		pgtable_gfp_flags(mm, GFP_KERNEL));

kmem_cache_zalloc() wont work?

RP

> +	pgd = kmem_cache_alloc(PGT_CACHE(PGD_INDEX_SIZE),
> +			       pgtable_gfp_flags(mm, GFP_KERNEL));
> +	memset(pgd, 0, PGD_TABLE_SIZE);
> +	return pgd;
>  }
> 
>  static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
> -- 
> 2.14.3

-- 
Ram Pai
