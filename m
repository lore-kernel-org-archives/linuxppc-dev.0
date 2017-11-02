Return-Path: <khandual@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ySBHV4BLKzDqlM
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Nov 2017 15:02:13 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vA23x3cD122579
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Nov 2017 00:02:11 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2dynbp2j3t-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Nov 2017 00:02:10 -0400
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Thu, 2 Nov 2017 04:02:09 -0000
Subject: Re: [RFC 2/2] powerpc/mm: Enable deferred flushing of TLB during
 reclaim
To: linuxppc-dev@lists.ozlabs.org
References: <20171101101735.2318-1-khandual@linux.vnet.ibm.com>
 <20171101101735.2318-3-khandual@linux.vnet.ibm.com>
Cc: aneesh.kumar@linux.vnet.ibm.com, npiggin@gmail.com
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Thu, 2 Nov 2017 09:32:05 +0530
MIME-Version: 1.0
In-Reply-To: <20171101101735.2318-3-khandual@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
Message-Id: <db008f61-6a6d-f0d7-702e-10e57d4642fc@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/01/2017 03:47 PM, Anshuman Khandual wrote:
> Deferred flushing can only be enabled on POWER9 DD2.0 processor onwards.
> Because prior versions of POWER9 and previous hash table based POWER
> processors will do TLB flushing in pte_get_and_clear() function itself
> which then prevents batching and eventual flush completion later on.
> 
> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> ---
>  arch/powerpc/Kconfig                |  1 +
>  arch/powerpc/include/asm/tlbbatch.h | 30 +++++++++++++++++++++++
>  arch/powerpc/include/asm/tlbflush.h |  3 +++
>  arch/powerpc/mm/tlb-radix.c         | 49 +++++++++++++++++++++++++++++++++++++
>  4 files changed, 83 insertions(+)
>  create mode 100644 arch/powerpc/include/asm/tlbbatch.h
> 
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 809c468..f06b565 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -230,6 +230,7 @@ config PPC
>  	select SPARSE_IRQ
>  	select SYSCTL_EXCEPTION_TRACE
>  	select VIRT_TO_BUS			if !PPC64
> +	select ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH if (PPC64 && PPC_BOOK3S)
>  	#
>  	# Please keep this list sorted alphabetically.
>  	#
> diff --git a/arch/powerpc/include/asm/tlbbatch.h b/arch/powerpc/include/asm/tlbbatch.h
> new file mode 100644
> index 0000000..fc762ef
> --- /dev/null
> +++ b/arch/powerpc/include/asm/tlbbatch.h
> @@ -0,0 +1,30 @@
> +#ifndef _ARCH_POWERPC_TLBBATCH_H
> +#define _ARCH_POWERPC_TLBBATCH_H
> +
> +#include <linux/spinlock.h>
> +
> +#ifdef CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
> +
> +#define MAX_BATCHED_MM 1024
> +
> +struct arch_tlbflush_unmap_batch {
> +	/*
> +	 * Each bit set is a CPU that potentially has a
> +	 * TLB entry for one of the PFN being flushed.
> +	 * This represents whether all deferred struct
> +	 * mm will be flushed for any given CPU.
> +	 */
> +	struct cpumask cpumask;
> +
> +	/* All the deferred struct mm */
> +	struct mm_struct *mm[MAX_BATCHED_MM];
> +	unsigned long int nr_mm;
> +	
> +};
> +
> +extern bool arch_tlbbatch_should_defer(struct mm_struct *mm);
> +extern void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch);
> +extern void arch_tlbbatch_add_mm(struct arch_tlbflush_unmap_batch *batch,
> +					struct mm_struct *mm);
> +#endif /* CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH */
> +#endif /* _ARCH_POWERPC_TLBBATCH_H */
> diff --git a/arch/powerpc/include/asm/tlbflush.h b/arch/powerpc/include/asm/tlbflush.h
> index 13dbcd4..2041923 100644
> --- a/arch/powerpc/include/asm/tlbflush.h
> +++ b/arch/powerpc/include/asm/tlbflush.h
> @@ -20,6 +20,9 @@
>   */
>  #ifdef __KERNEL__
> 
> +#include <linux/sched.h>
> +#include <linux/mm_types.h>
> +
>  #ifdef CONFIG_PPC_MMU_NOHASH
>  /*
>   * TLB flushing for software loaded TLB chips
> diff --git a/arch/powerpc/mm/tlb-radix.c b/arch/powerpc/mm/tlb-radix.c
> index b3e849c..506e7ed 100644
> --- a/arch/powerpc/mm/tlb-radix.c
> +++ b/arch/powerpc/mm/tlb-radix.c
> @@ -12,6 +12,8 @@
>  #include <linux/mm.h>
>  #include <linux/hugetlb.h>
>  #include <linux/memblock.h>
> +#include <linux/mutex.h>
> +#include <linux/smp.h>
> 
>  #include <asm/ppc-opcode.h>
>  #include <asm/tlb.h>
> @@ -519,3 +521,50 @@ extern void radix_kvm_prefetch_workaround(struct mm_struct *mm)
>  }
>  EXPORT_SYMBOL_GPL(radix_kvm_prefetch_workaround);
>  #endif /* CONFIG_KVM_BOOK3S_HV_POSSIBLE */
> +
> +#ifdef CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
> +static void clear_tlb(void *data)
> +{
> +	struct arch_tlbflush_unmap_batch *batch = data;
> +	int i;
> +
> +	WARN_ON(!radix_enabled() || cpu_has_feature(CPU_FTR_POWER9_DD1));
> +
> +	for (i = 0; i < batch->nr_mm; i++) {
> +		if (batch->mm[i])
> +			radix__local_flush_tlb_mm(batch->mm[i]);
> +	}
> +}

Instead of clearing each affected 'struct mm' on the CPU, we can
just TLB flush the entire CPU for the given partition. But its
not really giving any improvement from the flushing mechanism
described above.

diff --git a/arch/powerpc/mm/tlb-radix.c b/arch/powerpc/mm/tlb-radix.c
index 506e7ed..b0eb218 100644
--- a/arch/powerpc/mm/tlb-radix.c
+++ b/arch/powerpc/mm/tlb-radix.c
@@ -525,15 +525,8 @@ extern void radix_kvm_prefetch_workaround(struct mm_struct *mm)
 #ifdef CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
 static void clear_tlb(void *data)
 {
-       struct arch_tlbflush_unmap_batch *batch = data;
-       int i;
-
        WARN_ON(!radix_enabled() || cpu_has_feature(CPU_FTR_POWER9_DD1));
-
-       for (i = 0; i < batch->nr_mm; i++) {
-               if (batch->mm[i])
-                       radix__local_flush_tlb_mm(batch->mm[i]);
-       }
+       cur_cpu_spec->flush_tlb(TLB_INVAL_SCOPE_LPID);
 }

$time ./run case-lru-file-mmap-read

real    4m15.766s
user    108m6.967s
sys     393m15.152s
