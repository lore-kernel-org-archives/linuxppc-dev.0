Return-Path: <bsingharora@gmail.com>
Received: from mail-pa0-x243.google.com (mail-pa0-x243.google.com
 [IPv6:2607:f8b0:400e:c03::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rlzck1RybzDr5F
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jul 2016 12:55:17 +1000 (AEST)
Received: by mail-pa0-x243.google.com with SMTP id dx3so3231144pab.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 Jul 2016 19:55:17 -0700 (PDT)
Subject: Re: [RFC/PATCH 2/4] powerpc/64/kexec: Fix MMU cleanup on radix
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
References: <1467779659.13965.101.camel@kernel.crashing.org>
Cc: Anton Blanchard <anton@au1.ibm.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <4b35285e-88c3-7b96-2991-8b42ed50f267@gmail.com>
Date: Fri, 8 Jul 2016 12:55:09 +1000
MIME-Version: 1.0
In-Reply-To: <1467779659.13965.101.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 06/07/16 14:34, Benjamin Herrenschmidt wrote:
> Just using the hash ops won't work anymore since radix will have
> NULL in there. Instead create an mmu_cleanup_all() function which
> will do the right thing based on the MMU mode.
> 
> For Radix, for now I clear UPRT and the PTCR, effectively switching
> back to Radix with no partition table setup.
> 
> Currently set it to NULL on BookE thought it might be a good idea
> to wipe the TLB there (Scott ?)
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

<snip>

> +
> +/* For use by kexec */
> +void mmu_cleanup_all(void)
> +{
> +	if (radix_enabled())
> +		radix__mmu_cleanup_all();


Should this be more than just radix -- cpu_has_feature(CPU_FTR_ARCH_300)?

> +	else if (mmu_hash_ops.hpte_clear_all)
> +		mmu_hash_ops.hpte_clear_all();
> +}
> diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
> index 3ababda..f127baa 100644
> --- a/arch/powerpc/mm/pgtable-radix.c
> +++ b/arch/powerpc/mm/pgtable-radix.c
> @@ -366,6 +366,16 @@ void radix__early_init_mmu_secondary(void)
>  	}
>  }
>  
> +void radix__mmu_cleanup_all(void)
> +{
> +	unsigned long lpcr;
> +	if (!firmware_has_feature(FW_FEATURE_LPAR)) {
> +		lpcr = mfspr(SPRN_LPCR);
> +		mtspr(SPRN_LPCR, lpcr & ~LPCR_UPRT);
> +		mtspr(SPRN_PTCR, 0);

Free up the patb data structure here?

We also need tlbie's to invalidate any caches pointing to the patb entries

Balbir Singh.
