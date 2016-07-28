Return-Path: <bsingharora@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s0HsR2RgNzDsSp
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jul 2016 13:48:59 +1000 (AEST)
Received: from mail-pa0-x241.google.com (mail-pa0-x241.google.com
 [IPv6:2607:f8b0:400e:c03::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3s0HsQ5R5rz9t18
 for <linuxppc-dev@ozlabs.org>; Thu, 28 Jul 2016 13:48:58 +1000 (AEST)
Received: by mail-pa0-x241.google.com with SMTP id q2so2775591pap.0
 for <linuxppc-dev@ozlabs.org>; Wed, 27 Jul 2016 20:48:58 -0700 (PDT)
Subject: Re: [PATCH v3 04/21] powerpc/mm: Do radix device tree scanning earlier
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
References: <1469629097-30859-1-git-send-email-mpe@ellerman.id.au>
 <1469629097-30859-4-git-send-email-mpe@ellerman.id.au>
Cc: haokexin@gmail.com, aneesh.kumar@linux.vnet.ibm.com
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <4dce619e-1901-4528-9522-02c0a466d130@gmail.com>
Date: Thu, 28 Jul 2016 13:48:52 +1000
MIME-Version: 1.0
In-Reply-To: <1469629097-30859-4-git-send-email-mpe@ellerman.id.au>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 28/07/16 00:18, Michael Ellerman wrote:
> Like we just did for hash, split the device tree scanning parts out and
> call them from mmu_early_init_devtree().
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  arch/powerpc/include/asm/book3s/64/mmu.h | 1 +
>  arch/powerpc/mm/init_64.c                | 4 +++-
>  arch/powerpc/mm/pgtable-radix.c          | 3 +--
>  3 files changed, 5 insertions(+), 3 deletions(-)
> 
> v3: Merged into this series.
> 
> diff --git a/arch/powerpc/include/asm/book3s/64/mmu.h b/arch/powerpc/include/asm/book3s/64/mmu.h
> index 358f1410dc0d..9ee00c2576d0 100644
> --- a/arch/powerpc/include/asm/book3s/64/mmu.h
> +++ b/arch/powerpc/include/asm/book3s/64/mmu.h
> @@ -109,6 +109,7 @@ extern int mmu_io_psize;
>  /* MMU initialization */
>  void mmu_early_init_devtree(void);
>  void hash__early_init_devtree(void);
> +void radix__early_init_devtree(void);
>  extern void radix_init_native(void);
>  extern void hash__early_init_mmu(void);
>  extern void radix__early_init_mmu(void);
> diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
> index d023333c6c9a..e0ab33d20a10 100644
> --- a/arch/powerpc/mm/init_64.c
> +++ b/arch/powerpc/mm/init_64.c
> @@ -427,7 +427,9 @@ void __init mmu_early_init_devtree(void)
>  	if (disable_radix)
>  		cur_cpu_spec->mmu_features &= ~MMU_FTR_RADIX;
>  
> -	if (!radix_enabled())
> +	if (radix_enabled())
> +		radix__early_init_devtree();
> +	else
>  		hash__early_init_devtree();
>  }
>  #endif /* CONFIG_PPC_STD_MMU_64 */
> diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
> index 003ff48a11b6..f34ccdbe0fbd 100644
> --- a/arch/powerpc/mm/pgtable-radix.c
> +++ b/arch/powerpc/mm/pgtable-radix.c
> @@ -264,7 +264,7 @@ static int __init radix_dt_scan_page_sizes(unsigned long node,
>  	return 1;
>  }
>  
> -static void __init radix_init_page_sizes(void)
> +void __init radix__early_init_devtree(void)
>  {
>  	int rc;
>  
> @@ -343,7 +343,6 @@ void __init radix__early_init_mmu(void)
>  	__pte_frag_nr = H_PTE_FRAG_NR;
>  	__pte_frag_size_shift = H_PTE_FRAG_SIZE_SHIFT;
>  
> -	radix_init_page_sizes();
>  	if (!firmware_has_feature(FW_FEATURE_LPAR)) {
>  		radix_init_native();
>  		lpcr = mfspr(SPRN_LPCR);
>

If I am reading this correctly, radix_init_page_sizes() has become
radix__early_init_devtree() where as hash__early_init_devtree() initializes
both segment and page sizes? I would still like to keep

mmu_early_init_devtree()
	-> radix__early_init_devtree()
		-> radix__init_page_sizes()


Balbir Singh.
