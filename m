Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xpRMF4c3VzDrJl
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Sep 2017 15:53:28 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v885pG6w009871
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Sep 2017 01:53:26 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2cueahuj0n-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 08 Sep 2017 01:53:26 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 8 Sep 2017 15:53:24 +1000
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v885rL6h33816700
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Sep 2017 15:53:22 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v885rLWe001966
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Sep 2017 15:53:21 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Anton Blanchard <anton@samba.org>
Subject: Re: [RFC PATCH 8/8] powerpc/64s/radix: Only flush local TLB for
 spurious fault flushes
In-Reply-To: <20170907145148.24398-9-npiggin@gmail.com>
References: <20170907145148.24398-1-npiggin@gmail.com>
 <20170907145148.24398-9-npiggin@gmail.com>
Date: Fri, 08 Sep 2017 11:23:18 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87377xspm9.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nicholas Piggin <npiggin@gmail.com> writes:

> When permissiveness is relaxed, or found to have been relaxed by
> another thread, we flush that address out of the TLB to avoid a
> future fault or micro-fault due to a stale TLB entry.
>
> Currently for processes with TLBs on other CPUs, this flush is always
> done with a global tlbie. Although that could reduce faults on remote
> CPUs, a broadcast operation seems to be wasteful for something that
> can be handled in-core by the remote CPU if it comes to it.
>
> This is not benchmarked yet. It does seem cut some tlbie operations
> from the bus.
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  .../powerpc/include/asm/book3s/64/tlbflush-radix.h |  5 ++++
>  arch/powerpc/include/asm/book3s/64/tlbflush.h      | 11 +++++++++
>  arch/powerpc/mm/pgtable-book3s64.c                 |  5 +++-
>  arch/powerpc/mm/pgtable.c                          |  2 +-
>  arch/powerpc/mm/tlb-radix.c                        | 27 ++++++++++++++++++++++
>  5 files changed, 48 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h b/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h
> index b12460b306a7..34cd864b8fc1 100644
> --- a/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h
> +++ b/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h
> @@ -16,6 +16,8 @@ extern bool radix__flush_tlb_range_psize(struct mm_struct *mm, unsigned long sta
>  					 unsigned long end, int psize);
>  extern void radix__flush_pmd_tlb_range(struct vm_area_struct *vma,
>  				       unsigned long start, unsigned long end);
> +extern void radix__local_flush_pmd_tlb_range(struct vm_area_struct *vma,
> +				unsigned long start, unsigned long end);
>  extern void radix__flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
>  			    unsigned long end);
>  extern void radix__flush_tlb_kernel_range(unsigned long start, unsigned long end);
> @@ -24,6 +26,9 @@ extern void radix__local_flush_tlb_mm(struct mm_struct *mm);
>  extern void radix__local_flush_tlb_page(struct vm_area_struct *vma, unsigned long vmaddr);
>  extern void radix__local_flush_tlb_page_psize(struct mm_struct *mm, unsigned long vmaddr,
>  					      int psize);
> +extern void radix__local_flush_tlb_range_psize(struct mm_struct *mm,
> +				unsigned long start, unsigned long end,
> +				int psize);
>  extern void radix__tlb_flush(struct mmu_gather *tlb);
>  #ifdef CONFIG_SMP
>  extern void radix__flush_tlb_mm(struct mm_struct *mm);
> diff --git a/arch/powerpc/include/asm/book3s/64/tlbflush.h b/arch/powerpc/include/asm/book3s/64/tlbflush.h
> index 72b925f97bab..8a8b3e11a28e 100644
> --- a/arch/powerpc/include/asm/book3s/64/tlbflush.h
> +++ b/arch/powerpc/include/asm/book3s/64/tlbflush.h
> @@ -83,6 +83,17 @@ static inline void flush_tlb_page(struct vm_area_struct *vma,
>  #define flush_tlb_mm(mm)		local_flush_tlb_mm(mm)
>  #define flush_tlb_page(vma, addr)	local_flush_tlb_page(vma, addr)
>  #endif /* CONFIG_SMP */
> +
> +#define flush_tlb_fix_spurious_fault flush_tlb_fix_spurious_fault
> +static inline void flush_tlb_fix_spurious_fault(struct vm_area_struct *vma,
> +						unsigned long address)
> +{
> +	if (radix_enabled())
> +		radix__local_flush_tlb_page(vma, address);
> +	else
> +		flush_tlb_page(vma, address);
> +}
> +
>  /*
>   * flush the page walk cache for the address
>   */
> diff --git a/arch/powerpc/mm/pgtable-book3s64.c b/arch/powerpc/mm/pgtable-book3s64.c
> index 3b65917785a5..e46f346388d6 100644
> --- a/arch/powerpc/mm/pgtable-book3s64.c
> +++ b/arch/powerpc/mm/pgtable-book3s64.c
> @@ -40,7 +40,10 @@ int pmdp_set_access_flags(struct vm_area_struct *vma, unsigned long address,
>  	if (changed) {
>  		__ptep_set_access_flags(vma->vm_mm, pmdp_ptep(pmdp),
>  					pmd_pte(entry), address);
> -		flush_pmd_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
> +		if (radix_enabled())
> +			radix__local_flush_pmd_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
> +		else
> +			flush_pmd_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
			^^^^  this is no-op for hash.


>  	}
>  	return changed;
>  }
> diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
> index a03ff3d99e0c..acd6ae8062ce 100644


-aneesh
