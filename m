Return-Path: <khandual@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xbPgg3cLRzDrJy
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Aug 2017 16:59:27 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7L6xGBX135530
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Aug 2017 02:59:24 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2cfkpj0gkd-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Aug 2017 02:59:23 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Mon, 21 Aug 2017 16:58:57 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v7L6wtiP34341052
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Aug 2017 16:58:55 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v7L6wsS6007917
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Aug 2017 16:58:56 +1000
Subject: Re: [PATCH v2 20/20] powerpc/mm: Add speculative page fault
To: Laurent Dufour <ldufour@linux.vnet.ibm.com>, paulmck@linux.vnet.ibm.com,
 peterz@infradead.org, akpm@linux-foundation.org, kirill@shutemov.name,
 ak@linux.intel.com, mhocko@kernel.org, dave@stgolabs.net, jack@suse.cz,
 Matthew Wilcox <willy@infradead.org>, benh@kernel.crashing.org,
 mpe@ellerman.id.au, paulus@samba.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 hpa@zytor.com, Will Deacon <will.deacon@arm.com>
References: <1503007519-26777-1-git-send-email-ldufour@linux.vnet.ibm.com>
 <1503007519-26777-21-git-send-email-ldufour@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, haren@linux.vnet.ibm.com,
 khandual@linux.vnet.ibm.com, npiggin@gmail.com, bsingharora@gmail.com,
 Tim Chen <tim.c.chen@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
 x86@kernel.org
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Mon, 21 Aug 2017 12:28:46 +0530
MIME-Version: 1.0
In-Reply-To: <1503007519-26777-21-git-send-email-ldufour@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
Message-Id: <ebe69178-2e8b-a5b9-6268-08b82f476021@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/18/2017 03:35 AM, Laurent Dufour wrote:
> This patch enable the speculative page fault on the PowerPC
> architecture.
> 
> This will try a speculative page fault without holding the mmap_sem,
> if it returns with WM_FAULT_RETRY, the mmap_sem is acquired and the

s/WM_FAULT_RETRY/VM_FAULT_RETRY/

> traditional page fault processing is done.
> 
> Support is only provide for BOOK3S_64 currently because:
> - require CONFIG_PPC_STD_MMU because checks done in
>   set_access_flags_filter()

What checks are done in set_access_flags_filter() ? We are just
adding the code block in do_page_fault().


> - require BOOK3S because we can't support for book3e_hugetlb_preload()
>   called by update_mmu_cache()
> 
> Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/book3s/64/pgtable.h |  5 +++++
>  arch/powerpc/mm/fault.c                      | 30 +++++++++++++++++++++++++++-
>  2 files changed, 34 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
> index 818a58fc3f4f..897f8b9f67e6 100644
> --- a/arch/powerpc/include/asm/book3s/64/pgtable.h
> +++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
> @@ -313,6 +313,11 @@ extern unsigned long pci_io_base;
>  /* Advertise support for _PAGE_SPECIAL */
>  #define __HAVE_ARCH_PTE_SPECIAL
>  
> +/* Advertise that we call the Speculative Page Fault handler */
> +#if defined(CONFIG_PPC_BOOK3S_64)
> +#define __HAVE_ARCH_CALL_SPF
> +#endif
> +
>  #ifndef __ASSEMBLY__
>  
>  /*
> diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
> index 4c422632047b..7b3cc4c30eab 100644
> --- a/arch/powerpc/mm/fault.c
> +++ b/arch/powerpc/mm/fault.c
> @@ -291,9 +291,36 @@ int do_page_fault(struct pt_regs *regs, unsigned long address,
>  	if (is_write && is_user)
>  		store_update_sp = store_updates_sp(regs);
>  
> -	if (is_user)
> +	if (is_user) {
>  		flags |= FAULT_FLAG_USER;
>  
> +#if defined(__HAVE_ARCH_CALL_SPF)
> +		/* let's try a speculative page fault without grabbing the
> +		 * mmap_sem.
> +		 */
> +
> +		/*
> +		 * flags is set later based on the VMA's flags, for the common
> +		 * speculative service, we need some flags to be set.
> +		 */
> +		if (is_write)
> +			flags |= FAULT_FLAG_WRITE;
> +
> +		fault = handle_speculative_fault(mm, address, flags);
> +		if (!(fault & VM_FAULT_RETRY || fault & VM_FAULT_ERROR)) {
> +			perf_sw_event(PERF_COUNT_SW_SPF_DONE, 1,
> +				      regs, address);
> +			goto done;

Why we should retry with classical page fault on VM_FAULT_ERROR ?
We should always return VM_FAULT_RETRY in case there is a clear
collision some where which requires retry with classical method
and return VM_FAULT_ERROR in cases where we know that it cannot
be retried and fail for good. Should not handle_speculative_fault()
be changed to accommodate this ?

> +		}
> +
> +		/*
> +		 * Resetting flags since the following code assumes
> +		 * FAULT_FLAG_WRITE is not set.
> +		 */
> +		flags &= ~FAULT_FLAG_WRITE;
> +#endif /* defined(__HAVE_ARCH_CALL_SPF) */

Setting and resetting of FAULT_FLAG_WRITE seems confusing. Why you
say that some flags need to be set for handle_speculative_fault()
function. Could you elaborate on this ?
