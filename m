Return-Path: <npiggin@gmail.com>
Received: from mail-pa0-x244.google.com (mail-pa0-x244.google.com
 [IPv6:2607:f8b0:400e:c03::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ryV915gMLzDqQ0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jul 2016 15:26:13 +1000 (AEST)
Received: by mail-pa0-x244.google.com with SMTP id ez1so10767605pab.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 24 Jul 2016 22:26:13 -0700 (PDT)
Date: Mon, 25 Jul 2016 15:26:05 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH for-4.8 V2 01/10] powerpc/mm: Add __cpu/__mmu_has_feature
Message-ID: <20160725152605.780c6458@roar.ozlabs.ibm.com>
In-Reply-To: <1469265163-1491-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1469265163-1491-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1469265163-1491-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

On Sat, 23 Jul 2016 14:42:34 +0530
"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> wrote:

> In later patches, we will be switching cpu and mmu feature check to
> use static keys. This would require us to have a variant of feature
> check that can be used in early boot before jump label is initialized.
> This patch adds the same. We also add a variant for radix_enabled()
> check
> 
> We also update the return type to bool.
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/book3s/64/mmu.h | 19 +++++++++++++++----
>  arch/powerpc/include/asm/cputable.h      | 15 ++++++++++-----
>  arch/powerpc/include/asm/mmu.h           | 13 +++++++++++--
>  arch/powerpc/xmon/ppc-dis.c              |  1 +
>  4 files changed, 37 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/book3s/64/mmu.h
> b/arch/powerpc/include/asm/book3s/64/mmu.h index
> 6d8306d9aa7a..1bb0e536c76b 100644 ---
> a/arch/powerpc/include/asm/book3s/64/mmu.h +++
> b/arch/powerpc/include/asm/book3s/64/mmu.h @@ -24,9 +24,20 @@ struct
> mmu_psize_def { extern struct mmu_psize_def
> mmu_psize_defs[MMU_PAGE_COUNT]; 
>  #ifdef CONFIG_PPC_RADIX_MMU
> -#define radix_enabled() mmu_has_feature(MMU_FTR_TYPE_RADIX)
> +static inline bool radix_enabled(void)
> +{
> +	return mmu_has_feature(MMU_FTR_TYPE_RADIX);
> +}
> +#define radix_enabled radix_enabled
> +
> +static inline bool __radix_enabled(void)
> +{
> +	return __mmu_has_feature(MMU_FTR_TYPE_RADIX);
> +}

I'm probably guilty of this too, but the prefix-more-underscores naming
convention for a "special" variant of a function sucks, especially for
names used beyond a single file.

Might _early or similar be an improvement?

Thanks,
Nick
