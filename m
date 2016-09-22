Return-Path: <hbathini@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sg1wP15pvzDsjF
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Sep 2016 02:21:56 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8MGIPav019217
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Sep 2016 12:21:54 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25me2h2k50-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Sep 2016 12:21:54 -0400
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Fri, 23 Sep 2016 02:21:51 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 5A9D82BB0045
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Sep 2016 02:21:49 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8MGLn6i1704400
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Sep 2016 02:21:49 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8MGLnoL008078
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Sep 2016 02:21:49 +1000
Received: from [9.79.210.159] ([9.79.210.159])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 u8MGLlAC008041
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Sep 2016 02:21:48 +1000
Subject: Re: [PATCH v2] powerpc/mm: export current mmu mode info
To: linuxppc-dev@lists.ozlabs.org
References: <147456009252.14735.18189822731283851598.stgit@hbathini.in.ibm.com>
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
Date: Thu, 22 Sep 2016 21:51:47 +0530
MIME-Version: 1.0
In-Reply-To: <147456009252.14735.18189822731283851598.stgit@hbathini.in.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <1e0922fe-0735-aa9f-d0bf-1420aee9f2bf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Thursday 22 September 2016 09:32 PM, Hari Bathini wrote:
> The kernel now supports both radix and hash MMU modes. Tools like crash
> and makedumpfile need to know the current MMU mode the kernel is using,
> to debug/analyze it.  The current MMU mode depends on hardware support
> and also whether disable_radix cmdline parameter is passed to the kernel.
> The mmu_features member of cpu_spec structure holds the current MMU mode
> a cpu is using. But the above mentioned tools need to know the MMU mode
> early in their init process, when they may not have access to offset info
> of structure members. A hard-coded offset may help but it won't be robust.
>
> This patch introduces a new global variable, which holds the current MMU
> mode the kernel is running in and can be accessed by tools early in thier
> init process, helping tools to initialize accurately for each MMU mode.
> This patch also optimizes the radix_enabled() function call.
>
> Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
> ---
>
> Changes from v1:
> * Patch name changed from "ppc64/book3s: export mmu type info"
> * Optimized radix_enabled() function
>
>
>   arch/powerpc/include/asm/mmu.h      |   22 +++++++++++++++++++++-
>   arch/powerpc/kernel/machine_kexec.c |    3 +++
>   arch/powerpc/mm/hash_utils_64.c     |    2 ++
>   arch/powerpc/mm/pgtable-radix.c     |    2 ++
>   arch/powerpc/mm/pgtable.c           |    6 ++++++
>   arch/powerpc/mm/tlb_hash32.c        |    1 +
>   arch/powerpc/mm/tlb_nohash.c        |    2 ++
>   7 files changed, 37 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
> index e2fb408..558987c 100644
> --- a/arch/powerpc/include/asm/mmu.h
> +++ b/arch/powerpc/include/asm/mmu.h
> @@ -199,6 +199,21 @@ static inline void mmu_clear_feature(unsigned long feature)
>
>   extern unsigned int __start___mmu_ftr_fixup, __stop___mmu_ftr_fixup;
>
> +/*
> + * Possible MMU modes
> + */
> +#define MMU_MODE_NONE           0
> +#define MMU_MODE_RADIX          1
> +#define MMU_MODE_HASH           2
> +#define MMU_MODE_HASH32         3
> +#define MMU_MODE_NOHASH         4
> +#define MMU_MODE_NOHASH32       5
> +
> +/*
> + * current MMU mode
> + */
> +extern unsigned int current_mmu_mode __read_mostly;
> +
>   #ifdef CONFIG_PPC64
>   /* This is our real memory area size on ppc64 server, on embedded, we
>    * make it match the size our of bolted TLB area
> @@ -218,7 +233,12 @@ static inline void assert_pte_locked(struct mm_struct *mm, unsigned long addr)
>   #ifdef CONFIG_PPC_RADIX_MMU
>   static inline bool radix_enabled(void)
>   {
> -	return mmu_has_feature(MMU_FTR_TYPE_RADIX);
> +	if (current_mmu_mode == MMU_MODE_RADIX)
> +		return true;
> +	else if (current_mmu_mode != MMU_MODE_NONE)
> +		return false;
> +	else
> +		return mmu_has_feature(MMU_FTR_TYPE_RADIX);
>   }
>
>   static inline bool early_radix_enabled(void)
> diff --git a/arch/powerpc/kernel/machine_kexec.c b/arch/powerpc/kernel/machine_kexec.c
> index 2694d07..4ecc184 100644
> --- a/arch/powerpc/kernel/machine_kexec.c
> +++ b/arch/powerpc/kernel/machine_kexec.c
> @@ -77,6 +77,9 @@ void arch_crash_save_vmcoreinfo(void)
>   	VMCOREINFO_SYMBOL(contig_page_data);
>   #endif
>   #if defined(CONFIG_PPC64) && defined(CONFIG_SPARSEMEM_VMEMMAP)
> +#ifdef CONFIG_PPC_BOOK3S
> +	VMCOREINFO_SYMBOL(current_mmu_mode);

Oops! This doesn't have to be under any flag. Let me resend.

Thanks
Hari
