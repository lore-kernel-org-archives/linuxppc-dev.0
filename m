Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y5t1V1WMZzDqhh
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Oct 2017 19:46:36 +1100 (AEDT)
Subject: Re: [PATCH v3] powerpc: fix compile error on 64K pages on 40x, 44x
To: Christian Lamparter <chunkeey@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: Paul Mackerras <paulus@samba.org>
References: <20171001143303.15671-1-chunkeey@gmail.com>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <d14b99bc-2e5c-03d8-ce51-c5c7862ccd55@c-s.fr>
Date: Tue, 3 Oct 2017 10:46:31 +0200
MIME-Version: 1.0
In-Reply-To: <20171001143303.15671-1-chunkeey@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 01/10/2017 à 16:33, Christian Lamparter a écrit :
> The mmu context on the 40x, 44x does not define pte_frag
> entry. This causes gcc abort the compilation due to:
> 
> setup-common.c: In function ‘setup_arch’:
> setup-common.c:908: error: ‘mm_context_t’ has no ‘pte_frag’
> 
> This patch fixes the issue by removing the pte_frag
> initialization in setup-common.c.
> 
> This is possible, because the compiler will do the
> initialization, since the mm_context is a sub struct of
> init_mm. init_mm is declared in mm_types.h as external linkage.
> according to C99 6.2.4.3:
> "An object whose identifier is declared with external linkage
> [...] has static storage duration."
> 
> C99 defines in 6.7.8.10 that: "
> If an object that has static storage duration is not
> initialized explicitly, then:
> - if it has pointer type, it is initialized to a null pointer
> [...]
> "
> 
> Signed-off-by: Christian Lamparter <chunkeey@gmail.com>

Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>

> ---
>   arch/powerpc/kernel/setup-common.c | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
> index 0ac741fae90e..2e3bc16d02b2 100644
> --- a/arch/powerpc/kernel/setup-common.c
> +++ b/arch/powerpc/kernel/setup-common.c
> @@ -904,9 +904,6 @@ void __init setup_arch(char **cmdline_p)
>   #endif
>   #endif
>   
> -#ifdef CONFIG_PPC_64K_PAGES
> -	init_mm.context.pte_frag = NULL;
> -#endif
>   #ifdef CONFIG_SPAPR_TCE_IOMMU
>   	mm_iommu_init(&init_mm);
>   #endif
> 
