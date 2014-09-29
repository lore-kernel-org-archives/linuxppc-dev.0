Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A3FF51A0054
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Sep 2014 19:11:12 +1000 (EST)
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 4415114012C
 for <linuxppc-dev@ozlabs.org>; Mon, 29 Sep 2014 19:11:09 +1000 (EST)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 29 Sep 2014 14:41:04 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Michael Neuling <mikey@neuling.org>, greg@kroah.com, arnd@arndb.de,
 mpe@ellerman.id.au, benh@kernel.crashing.org
Subject: Re: [PATCH 10/15] powerpc/mm: Add hooks for cxl
In-Reply-To: <1411028820-29933-11-git-send-email-mikey@neuling.org>
References: <1411028820-29933-1-git-send-email-mikey@neuling.org>
 <1411028820-29933-11-git-send-email-mikey@neuling.org>
Date: Mon, 29 Sep 2014 14:40:33 +0530
Message-ID: <87tx3qpzau.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: cbe-oss-dev@lists.ozlabs.org, mikey@neuling.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, jk@ozlabs.org,
 imunsie@au1.ibm.com, anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Neuling <mikey@neuling.org> writes:

> From: Ian Munsie <imunsie@au1.ibm.com>
>
> This add a hook into tlbie() so that we use global invalidations when there are
> cxl contexts active.
>
> Normally cxl snoops broadcast tlbie.  cxl can have TLB entries invalidated via
> MMIO, but we aren't doing that yet.  So for now we are just disabling local
> tlbies when cxl contexts are active.  In future we can make tlbie() local mode
> smarter so that it invalidates cxl contexts explicitly when it needs to.
>
> This also adds a hooks for when SLBs are invalidated to ensure any
> corresponding SLBs in cxl are also invalidated at the same time.

We are not really invalidating cx1 SLB's when we are doing
slb_flush_and_rebolt(). May be add some code documentation around to
explain when we are invalidating cx1 slb here. ?

>
> Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> ---
>  arch/powerpc/mm/hash_native_64.c | 6 +++++-
>  arch/powerpc/mm/hash_utils_64.c  | 3 +++
>  arch/powerpc/mm/slice.c          | 3 +++
>  3 files changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/mm/hash_native_64.c b/arch/powerpc/mm/hash_native_64.c
> index afc0a82..ae4962a 100644
> --- a/arch/powerpc/mm/hash_native_64.c
> +++ b/arch/powerpc/mm/hash_native_64.c
> @@ -29,6 +29,8 @@
>  #include <asm/kexec.h>
>  #include <asm/ppc-opcode.h>
>  
> +#include <misc/cxl.h>
> +
>  #ifdef DEBUG_LOW
>  #define DBG_LOW(fmt...) udbg_printf(fmt)
>  #else
> @@ -149,9 +151,11 @@ static inline void __tlbiel(unsigned long vpn, int psize, int apsize, int ssize)
>  static inline void tlbie(unsigned long vpn, int psize, int apsize,
>  			 int ssize, int local)
>  {
> -	unsigned int use_local = local && mmu_has_feature(MMU_FTR_TLBIEL);
> +	unsigned int use_local;
>  	int lock_tlbie = !mmu_has_feature(MMU_FTR_LOCKLESS_TLBIE);
>  
> +	use_local = local && mmu_has_feature(MMU_FTR_TLBIEL) && !cxl_ctx_in_use();
> +
>  	if (use_local)
>  		use_local = mmu_psize_defs[psize].tlbiel;
>  	if (lock_tlbie && !use_local)
> diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
> index 66071af..be40ff7 100644
> --- a/arch/powerpc/mm/hash_utils_64.c
> +++ b/arch/powerpc/mm/hash_utils_64.c
> @@ -34,6 +34,7 @@
>  #include <linux/signal.h>
>  #include <linux/memblock.h>
>  #include <linux/context_tracking.h>
> +#include <misc/cxl.h>
>  
>  #include <asm/processor.h>
>  #include <asm/pgtable.h>
> @@ -906,6 +907,7 @@ void demote_segment_4k(struct mm_struct *mm, unsigned long addr)
>  #ifdef CONFIG_SPU_BASE
>  	spu_flush_all_slbs(mm);
>  #endif
> +	cxl_slbia(mm);
>  	if (get_paca_psize(addr) != MMU_PAGE_4K) {
>  		get_paca()->context = mm->context;
>  		slb_flush_and_rebolt();
> @@ -1145,6 +1147,7 @@ int hash_page_mm(struct mm_struct *mm, unsigned long ea, unsigned long access, u
>  #ifdef CONFIG_SPU_BASE
>  			spu_flush_all_slbs(mm);
>  #endif
> +			cxl_slbia(mm);
>  		}
>  	}
>  
> diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
> index b0c75cc..4d3a34b 100644
> --- a/arch/powerpc/mm/slice.c
> +++ b/arch/powerpc/mm/slice.c
> @@ -30,6 +30,7 @@
>  #include <linux/err.h>
>  #include <linux/spinlock.h>
>  #include <linux/export.h>
> +#include <misc/cxl.h>
>  #include <asm/mman.h>
>  #include <asm/mmu.h>
>  #include <asm/spu.h>
> @@ -235,6 +236,7 @@ static void slice_convert(struct mm_struct *mm, struct slice_mask mask, int psiz
>  #ifdef CONFIG_SPU_BASE
>  	spu_flush_all_slbs(mm);
>  #endif
> +	cxl_slbia(mm);
>  }
>  
>  /*
> @@ -674,6 +676,7 @@ void slice_set_psize(struct mm_struct *mm, unsigned long address,
>  #ifdef CONFIG_SPU_BASE
>  	spu_flush_all_slbs(mm);
>  #endif
> +	cxl_slbia(mm);
>  }
>  
>  void slice_set_range_psize(struct mm_struct *mm, unsigned long start,
> -- 
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
