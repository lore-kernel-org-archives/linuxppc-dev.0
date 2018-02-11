Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zfkJ52ljGzF0fB
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Feb 2018 09:39:32 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1BMd7Ba045425
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Feb 2018 17:39:31 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2g2engmkgt-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Feb 2018 17:39:30 -0500
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Sun, 11 Feb 2018 22:39:28 -0000
Date: Sun, 11 Feb 2018 14:39:07 -0800
From: Ram Pai <linuxram@us.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V2 3/4] powerpc/mm/hash64: Store the slot information at
 the right offset.
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <20180211150009.21297-1-aneesh.kumar@linux.vnet.ibm.com>
 <20180211150009.21297-3-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180211150009.21297-3-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <20180211223907.GF5559@ram.oc3035372033.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Feb 11, 2018 at 08:30:08PM +0530, Aneesh Kumar K.V wrote:
> The hugetlb pte entries are at the PMD and PUD level. Use the right offset
> for them to get the second half of the table.
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/book3s/64/hash-4k.h  |  3 ++-
>  arch/powerpc/include/asm/book3s/64/hash-64k.h |  9 +++++----
>  arch/powerpc/include/asm/book3s/64/pgtable.h  |  2 +-
>  arch/powerpc/mm/hash64_4k.c                   |  4 ++--
>  arch/powerpc/mm/hash64_64k.c                  |  8 ++++----
>  arch/powerpc/mm/hugetlbpage-hash64.c          | 10 +++++++---
>  arch/powerpc/mm/tlb_hash64.c                  |  9 +++++++--
>  7 files changed, 28 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/book3s/64/hash-4k.h b/arch/powerpc/include/asm/book3s/64/hash-4k.h
> index 949d691094a4..67c5475311ee 100644
> diff --git a/arch/powerpc/mm/tlb_hash64.c b/arch/powerpc/mm/tlb_hash64.c

....snip...

> index 881ebd53ffc2..9b23f12e863c 100644
> --- a/arch/powerpc/mm/tlb_hash64.c
> +++ b/arch/powerpc/mm/tlb_hash64.c
> @@ -51,7 +51,7 @@ void hpte_need_flush(struct mm_struct *mm, unsigned long addr,
>  	unsigned int psize;
>  	int ssize;
>  	real_pte_t rpte;
> -	int i;
> +	int i, offset;
> 
>  	i = batch->index;
> 
> @@ -67,6 +67,10 @@ void hpte_need_flush(struct mm_struct *mm, unsigned long addr,
>  		psize = get_slice_psize(mm, addr);
>  		/* Mask the address for the correct page size */
>  		addr &= ~((1UL << mmu_psize_defs[psize].shift) - 1);
> +		if (unlikely(psize == MMU_PAGE_16G))
> +			offset = PTRS_PER_PUD;
> +		else
> +			offset = PTRS_PER_PMD;

I prefer to encapsulate this under some function/macro; somewhere in hugetlb.h, which returns
the offset given a mmu_size.  But no big deal..


Reviewed-by: Ram Pai <linuxram@us.ibm.com>

RP
