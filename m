Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rLXv01Q0KzDqcg
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Jun 2016 15:38:19 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id 62so10427005pfd.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Jun 2016 22:38:19 -0700 (PDT)
Received: from balbir.ozlabs.ibm.com ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id ba4sm2330996pac.42.2016.06.02.22.38.15
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLSv1/SSLv3 cipher=OTHER);
 Thu, 02 Jun 2016 22:38:16 -0700 (PDT)
Subject: Re: [PATCH 1/3] powerpc/mm/radix: Update LPCR only if it is powernv
To: linuxppc-dev@lists.ozlabs.org
References: <1464675991-13023-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <afaa4959-e92b-927b-7206-5490f0ad0cc5@gmail.com>
Date: Fri, 3 Jun 2016 15:38:13 +1000
MIME-Version: 1.0
In-Reply-To: <1464675991-13023-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 31/05/16 16:26, Aneesh Kumar K.V wrote:
> LPCR cannot be updated when running in guest mode.
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  arch/powerpc/mm/pgtable-radix.c | 23 ++++++++++-------------
>  1 file changed, 10 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
> index 18b2c11604fa..c939e6e57a9e 100644
> --- a/arch/powerpc/mm/pgtable-radix.c
> +++ b/arch/powerpc/mm/pgtable-radix.c
> @@ -296,11 +296,6 @@ found:
>  void __init radix__early_init_mmu(void)
>  {
>  	unsigned long lpcr;

Move this to

> -	/*
> -	 * setup LPCR UPRT based on mmu_features
> -	 */
> -	lpcr = mfspr(SPRN_LPCR);
> -	mtspr(SPRN_LPCR, lpcr | LPCR_UPRT);
>  
>  #ifdef CONFIG_PPC_64K_PAGES
>  	/* PAGE_SIZE mappings */
> @@ -343,8 +338,11 @@ void __init radix__early_init_mmu(void)
>  	__pte_frag_size_shift = H_PTE_FRAG_SIZE_SHIFT;
>  
>  	radix_init_page_sizes();
> -	if (!firmware_has_feature(FW_FEATURE_LPAR))
> +	if (!firmware_has_feature(FW_FEATURE_LPAR)) {
>  	unsigned long lpcr;

Here

> +		lpcr = mfspr(SPRN_LPCR);
> +		mtspr(SPRN_LPCR, lpcr | LPCR_UPRT);
>  		radix_init_partition_table();
> +	}
>  
>  	radix_init_pgtable();
>  }
> @@ -353,16 +351,15 @@ void radix__early_init_mmu_secondary(void)
>  {
>  	unsigned long lpcr;

Same as above

>  	/*
> -	 * setup LPCR UPRT based on mmu_features
> +	 * update partition table control register and UPRT
>  	 */
> -	lpcr = mfspr(SPRN_LPCR);
> -	mtspr(SPRN_LPCR, lpcr | LPCR_UPRT);
> -	/*
> -	 * update partition table control register, 64 K size.
> -	 */
> -	if (!firmware_has_feature(FW_FEATURE_LPAR))
> +	if (!firmware_has_feature(FW_FEATURE_LPAR)) {
> +		lpcr = mfspr(SPRN_LPCR);
> +		mtspr(SPRN_LPCR, lpcr | LPCR_UPRT);
> +
>  		mtspr(SPRN_PTCR,
>  		      __pa(partition_tb) | (PATB_SIZE_SHIFT - 12));
> +	}
>  }
>  
>  void radix__setup_initial_memory_limit(phys_addr_t first_memblock_base,
> 


Balbir Singh.
