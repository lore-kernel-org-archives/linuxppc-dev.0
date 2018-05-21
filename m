Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40q7ZT6z2hzF12M
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 May 2018 16:06:25 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4L64SmQ060878
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 May 2018 02:06:23 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2j3qpg9np8-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 May 2018 02:06:21 -0400
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 21 May 2018 07:06:17 +0100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 1/7] powerpc/64s/radix: do not flush TLB on spurious
 fault
In-Reply-To: <20180520004347.19508-2-npiggin@gmail.com>
References: <20180520004347.19508-1-npiggin@gmail.com>
 <20180520004347.19508-2-npiggin@gmail.com>
Date: Mon, 21 May 2018 11:36:12 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87efi5y23v.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nicholas Piggin <npiggin@gmail.com> writes:

> In the case of a spurious fault (which can happen due to a race with
> another thread that changes the page table), the default Linux mm code
> calls flush_tlb_page for that address. This is not required because
> the pte will be re-fetched. Hash does not wire this up to a hardware
> TLB flush for this reason. This patch avoids the flush for radix.
>
> From Power ISA v3.0B, p.1090:
>
>     Setting a Reference or Change Bit or Upgrading Access Authority
>     (PTE Subject to Atomic Hardware Updates)
>
>     If the only change being made to a valid PTE that is subject to
>     atomic hardware updates is to set the Refer- ence or Change bit to
>     1 or to add access authorities, a simpler sequence suffices
>     because the translation hardware will refetch the PTE if an access
>     is attempted for which the only problems were reference and/or
>     change bits needing to be set or insufficient access authority.
>
> The nest MMU on POWER9 does not re-fetch the PTE after such an access
> attempt before faulting, so address spaces with a coprocessor
> attached will continue to flush in these cases.
>
> This reduces tlbies for a kernel compile workload from 0.95M to 0.90M.
>
> fork --fork --exec benchmark improved 0.5% (12300->12400).
>


Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Do you want to use flush_tlb_fix_spurious_fault in
ptep_set_access_flags() also?. That would bring it closer to generic version?

> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
> Since v1:
> - Added NMMU handling
>
>  arch/powerpc/include/asm/book3s/64/tlbflush.h | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/include/asm/book3s/64/tlbflush.h b/arch/powerpc/include/asm/book3s/64/tlbflush.h
> index 0cac17253513..ebf572ea621e 100644
> --- a/arch/powerpc/include/asm/book3s/64/tlbflush.h
> +++ b/arch/powerpc/include/asm/book3s/64/tlbflush.h
> @@ -4,7 +4,7 @@
>  
>  #define MMU_NO_CONTEXT	~0UL
>  
> -
> +#include <linux/mm_types.h>
>  #include <asm/book3s/64/tlbflush-hash.h>
>  #include <asm/book3s/64/tlbflush-radix.h>
>  
> @@ -137,6 +137,16 @@ static inline void flush_all_mm(struct mm_struct *mm)
>  #define flush_tlb_page(vma, addr)	local_flush_tlb_page(vma, addr)
>  #define flush_all_mm(mm)		local_flush_all_mm(mm)
>  #endif /* CONFIG_SMP */
> +
> +#define flush_tlb_fix_spurious_fault flush_tlb_fix_spurious_fault
> +static inline void flush_tlb_fix_spurious_fault(struct vm_area_struct *vma,
> +						unsigned long address)
> +{
> +	/* See ptep_set_access_flags comment */
> +	if (atomic_read(&vma->vm_mm->context.copros) > 0)
> +		flush_tlb_page(vma, address);
> +}
> +
>  /*
>   * flush the page walk cache for the address
>   */
> -- 
> 2.17.0
