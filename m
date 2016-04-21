Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x236.google.com (mail-pf0-x236.google.com
 [IPv6:2607:f8b0:400e:c00::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qr5MG1m2TzDqbF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Apr 2016 14:27:37 +1000 (AEST)
Received: by mail-pf0-x236.google.com with SMTP id 184so25764028pff.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Apr 2016 21:27:37 -0700 (PDT)
Subject: Re: [PATCH V2 27/68] powerpc/mm/radix: Dummy radix_enabled()
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
References: <1460182444-2468-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1460182444-2468-28-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <571856B3.4010302@gmail.com>
Date: Thu, 21 Apr 2016 14:27:31 +1000
MIME-Version: 1.0
In-Reply-To: <1460182444-2468-28-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 09/04/16 16:13, Aneesh Kumar K.V wrote:
> In this patch we add the radix Kconfig and conditional check.
> radix_enabled is written to always return 0 here. Once we have
> all needed radix changes added, we will update this to mmu_feature
> check.
> 
> We need to addt this early so that we can get it all build in the early
> stage.

s/addt/add

> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> 
> radix kconfig variable
> ---
>  arch/powerpc/include/asm/book3s/64/mmu.h | 2 ++
>  arch/powerpc/include/asm/mmu.h           | 3 +++
>  arch/powerpc/platforms/Kconfig.cputype   | 4 ++++
>  3 files changed, 9 insertions(+)
> 
> diff --git a/arch/powerpc/include/asm/book3s/64/mmu.h b/arch/powerpc/include/asm/book3s/64/mmu.h
> index b86786f2521c..593d9e3ce8e7 100644
> --- a/arch/powerpc/include/asm/book3s/64/mmu.h
> +++ b/arch/powerpc/include/asm/book3s/64/mmu.h
> @@ -19,6 +19,8 @@ struct mmu_psize_def {
>  	unsigned long	sllp;	/* SLB L||LP (exact mask to use in slbmte) */
>  };
>  extern struct mmu_psize_def mmu_psize_defs[MMU_PAGE_COUNT];
> +
> +#define radix_enabled() (0)
>  #endif /* __ASSEMBLY__ */
>  
>  /* 64-bit classic hash table MMU */
> diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
> index 5f55024f9522..decde4c4870d 100644
> --- a/arch/powerpc/include/asm/mmu.h
> +++ b/arch/powerpc/include/asm/mmu.h
> @@ -204,6 +204,9 @@ static inline void assert_pte_locked(struct mm_struct *mm, unsigned long addr)
>  #  include <asm/mmu-8xx.h>
>  #endif
>  
> +#ifndef radix_enabled
> +#define radix_enabled() (0)
> +#endif
>  
>  #endif /* __KERNEL__ */
>  #endif /* _ASM_POWERPC_MMU_H_ */
> diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
> index 142dff5e96d6..53299182dba9 100644
> --- a/arch/powerpc/platforms/Kconfig.cputype
> +++ b/arch/powerpc/platforms/Kconfig.cputype
> @@ -331,6 +331,10 @@ config PPC_STD_MMU_64
>  	def_bool y
>  	depends on PPC_STD_MMU && PPC64
>  
> +config PPC_RADIX_MMU
> +        def_bool y
> +        depends on PPC_BOOK3S_64
> +

Some help would be nice here

>  config PPC_MMU_NOHASH
>  	def_bool y
>  	depends on !PPC_STD_MMU
> 
