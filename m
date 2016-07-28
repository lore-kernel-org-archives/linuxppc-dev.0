Return-Path: <npiggin@gmail.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s0P7L2gSZzDqVN
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jul 2016 17:46:22 +1000 (AEST)
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3s0P7K4mC3z9t23
 for <linuxppc-dev@ozlabs.org>; Thu, 28 Jul 2016 17:46:21 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id h186so3226119pfg.2
 for <linuxppc-dev@ozlabs.org>; Thu, 28 Jul 2016 00:46:21 -0700 (PDT)
Date: Thu, 28 Jul 2016 17:46:11 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: <linuxppc-dev@ozlabs.org>, haokexin@gmail.com,
 aneesh.kumar@linux.vnet.ibm.com
Subject: Re: [PATCH v3 10/21] powerpc/mm: Define radix_enabled() in one
 place & use static inline
Message-ID: <20160728174611.1ec99066@roar.ozlabs.ibm.com>
In-Reply-To: <1469629097-30859-10-git-send-email-mpe@ellerman.id.au>
References: <1469629097-30859-1-git-send-email-mpe@ellerman.id.au>
 <1469629097-30859-10-git-send-email-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 28 Jul 2016 00:18:06 +1000
Michael Ellerman <mpe@ellerman.id.au> wrote:

> Currently we have radix_enabled() three times, twice in
> asm/book3s/64/mmu.h and then a fallback in asm/mmu.h.
> 
> Consolidate them in asm/mmu.h. While we're at it convert them to be
> static inlines, and change the fallback case to returning a bool, like
> mmu_has_feature().
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  arch/powerpc/include/asm/book3s/64/mmu.h |  7 -------
>  arch/powerpc/include/asm/mmu.h           | 16 ++++++++++++----
>  2 files changed, 12 insertions(+), 11 deletions(-)
> 
> v3: New.
> 
> diff --git a/arch/powerpc/include/asm/book3s/64/mmu.h
> b/arch/powerpc/include/asm/book3s/64/mmu.h index
> ad2d501cddcf..70c995870297 100644 ---
> a/arch/powerpc/include/asm/book3s/64/mmu.h +++
> b/arch/powerpc/include/asm/book3s/64/mmu.h @@ -23,13 +23,6 @@ struct
> mmu_psize_def { };
>  extern struct mmu_psize_def mmu_psize_defs[MMU_PAGE_COUNT];
>  
> -#ifdef CONFIG_PPC_RADIX_MMU
> -#define radix_enabled() mmu_has_feature(MMU_FTR_TYPE_RADIX)
> -#else
> -#define radix_enabled() (0)
> -#endif
> -
> -
>  #endif /* __ASSEMBLY__ */
>  
>  /* 64-bit classic hash table MMU */
> diff --git a/arch/powerpc/include/asm/mmu.h
> b/arch/powerpc/include/asm/mmu.h index eb942a446969..f413b3213a3b
> 100644 --- a/arch/powerpc/include/asm/mmu.h
> +++ b/arch/powerpc/include/asm/mmu.h
> @@ -163,6 +163,18 @@ static inline void assert_pte_locked(struct
> mm_struct *mm, unsigned long addr) }
>  #endif /* !CONFIG_DEBUG_VM */
>  
> +#ifdef CONFIG_PPC_RADIX_MMU
> +static inline bool radix_enabled(void)
> +{
> +	return mmu_has_feature(MMU_FTR_TYPE_RADIX);
> +}
> +#else
> +static inline bool radix_enabled(void)
> +{
> +	return false;
> +}
> +#endif

Won't MMU_FTRS_POSSIBLE just do the right thing when
!CONFIG_PPC_RADIX_MMU?

Thanks,
Nick
