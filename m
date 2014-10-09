Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CE9551A18F8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Oct 2014 02:04:52 +1100 (EST)
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 0C0E41400BB
 for <linuxppc-dev@ozlabs.org>; Fri, 10 Oct 2014 02:04:51 +1100 (EST)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 9 Oct 2014 20:34:50 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Michael Neuling <mikey@neuling.org>, greg@kroah.com, arnd@arndb.de,
 mpe@ellerman.id.au, benh@kernel.crashing.org
Subject: Re: [PATCH v4 03/16] powerpc/cell: Make spu_flush_all_slbs() generic
In-Reply-To: <1412758505-23495-4-git-send-email-mikey@neuling.org>
References: <1412758505-23495-1-git-send-email-mikey@neuling.org>
 <1412758505-23495-4-git-send-email-mikey@neuling.org>
Date: Thu, 09 Oct 2014 20:34:44 +0530
Message-ID: <874mvd2sj7.fsf@linux.vnet.ibm.com>
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
> This moves spu_flush_all_slbs() into a generic call copro_flush_all_slbs().
>
> This will be useful when we add cxl which also needs a similar SLB flush call.
>

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

> Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> ---
>  arch/powerpc/include/asm/copro.h |  6 ++++++
>  arch/powerpc/mm/copro_fault.c    |  9 +++++++++
>  arch/powerpc/mm/hash_utils_64.c  | 10 +++-------
>  arch/powerpc/mm/slice.c          | 10 +++-------
>  4 files changed, 21 insertions(+), 14 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/copro.h b/arch/powerpc/include/asm/copro.h
> index b0e6a18..ce216df 100644
> --- a/arch/powerpc/include/asm/copro.h
> +++ b/arch/powerpc/include/asm/copro.h
> @@ -20,4 +20,10 @@ int copro_handle_mm_fault(struct mm_struct *mm, unsigned long ea,
>  
>  int copro_calculate_slb(struct mm_struct *mm, u64 ea, struct copro_slb *slb);
>  
> +
> +#ifdef CONFIG_PPC_COPRO_BASE
> +void copro_flush_all_slbs(struct mm_struct *mm);
> +#else
> +static inline void copro_flush_all_slbs(struct mm_struct *mm) {}
> +#endif
>  #endif /* _ASM_POWERPC_COPRO_H */
> diff --git a/arch/powerpc/mm/copro_fault.c b/arch/powerpc/mm/copro_fault.c
> index a15a23e..f2aa5a8 100644
> --- a/arch/powerpc/mm/copro_fault.c
> +++ b/arch/powerpc/mm/copro_fault.c
> @@ -25,6 +25,7 @@
>  #include <linux/export.h>
>  #include <asm/reg.h>
>  #include <asm/copro.h>
> +#include <asm/spu.h>
>  
>  /*
>   * This ought to be kept in sync with the powerpc specific do_page_fault
> @@ -136,3 +137,11 @@ int copro_calculate_slb(struct mm_struct *mm, u64 ea, struct copro_slb *slb)
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(copro_calculate_slb);
> +
> +void copro_flush_all_slbs(struct mm_struct *mm)
> +{
> +#ifdef CONFIG_SPU_BASE
> +	spu_flush_all_slbs(mm);
> +#endif
> +}
> +EXPORT_SYMBOL_GPL(copro_flush_all_slbs);
> diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
> index daee7f4..5c0738d 100644
> --- a/arch/powerpc/mm/hash_utils_64.c
> +++ b/arch/powerpc/mm/hash_utils_64.c
> @@ -51,7 +51,7 @@
>  #include <asm/cacheflush.h>
>  #include <asm/cputable.h>
>  #include <asm/sections.h>
> -#include <asm/spu.h>
> +#include <asm/copro.h>
>  #include <asm/udbg.h>
>  #include <asm/code-patching.h>
>  #include <asm/fadump.h>
> @@ -901,9 +901,7 @@ void demote_segment_4k(struct mm_struct *mm, unsigned long addr)
>  	if (get_slice_psize(mm, addr) == MMU_PAGE_4K)
>  		return;
>  	slice_set_range_psize(mm, addr, 1, MMU_PAGE_4K);
> -#ifdef CONFIG_SPU_BASE
> -	spu_flush_all_slbs(mm);
> -#endif
> +	copro_flush_all_slbs(mm);
>  	if (get_paca_psize(addr) != MMU_PAGE_4K) {
>  		get_paca()->context = mm->context;
>  		slb_flush_and_rebolt();
> @@ -1141,9 +1139,7 @@ int hash_page(unsigned long ea, unsigned long access, unsigned long trap)
>  			       "to 4kB pages because of "
>  			       "non-cacheable mapping\n");
>  			psize = mmu_vmalloc_psize = MMU_PAGE_4K;
> -#ifdef CONFIG_SPU_BASE
> -			spu_flush_all_slbs(mm);
> -#endif
> +			copro_flush_all_slbs(mm);
>  		}
>  	}
>  
> diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
> index b0c75cc..a81791c 100644
> --- a/arch/powerpc/mm/slice.c
> +++ b/arch/powerpc/mm/slice.c
> @@ -32,7 +32,7 @@
>  #include <linux/export.h>
>  #include <asm/mman.h>
>  #include <asm/mmu.h>
> -#include <asm/spu.h>
> +#include <asm/copro.h>
>  
>  /* some sanity checks */
>  #if (PGTABLE_RANGE >> 43) > SLICE_MASK_SIZE
> @@ -232,9 +232,7 @@ static void slice_convert(struct mm_struct *mm, struct slice_mask mask, int psiz
>  
>  	spin_unlock_irqrestore(&slice_convert_lock, flags);
>  
> -#ifdef CONFIG_SPU_BASE
> -	spu_flush_all_slbs(mm);
> -#endif
> +	copro_flush_all_slbs(mm);
>  }
>  
>  /*
> @@ -671,9 +669,7 @@ void slice_set_psize(struct mm_struct *mm, unsigned long address,
>  
>  	spin_unlock_irqrestore(&slice_convert_lock, flags);
>  
> -#ifdef CONFIG_SPU_BASE
> -	spu_flush_all_slbs(mm);
> -#endif
> +	copro_flush_all_slbs(mm);
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
