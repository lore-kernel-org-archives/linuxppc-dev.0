Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y41j12ncrzDqT0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Sep 2017 18:25:55 +1000 (AEST)
Subject: Re: [PATCH v2] powerpc: fix compile error on 64K pages on 40x, 44x
To: Christian Lamparter <chunkeey@googlemail.com>,
 linuxppc-dev@lists.ozlabs.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
References: <20170928183232.15367-1-chunkeey@googlemail.com>
From: christophe leroy <christophe.leroy@c-s.fr>
Message-ID: <b0281459-f8b7-40e1-d4a6-1e4a122593f7@c-s.fr>
Date: Sat, 30 Sep 2017 10:25:45 +0200
MIME-Version: 1.0
In-Reply-To: <20170928183232.15367-1-chunkeey@googlemail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 28/09/2017 à 20:32, Christian Lamparter a écrit :
> The mmu context on the 40x, 44x does not define pte_frag
> entry. This causes gcc abort the compilation due to:
> 
> setup-common.c: In function ‘setup_arch’:
> setup-common.c:908: error: ‘mm_context_t’ has no ‘pte_frag’
> 
> This patch fixes the issue by adding additional guard
> conditions, that limit the initialization to just
> platforms that define the pte_frag variable in the
> mmu context.

Wouldn't it be better to amend mm_context_t with the following, just 
like other platforms, instead of a #ifdef in setup_arch() ?

#ifdef CONFIG_PPC_64K_PAGES
	/* for 4K PTE fragment support */
	void *pte_frag;
#endif

Otherwise, since init_mm is defined in BSS, is setting pte_frag to NULL 
needed at all ?
I think removing this line would be better.

Christophe

> 
> Signed-off-by: Christian Lamparter <chunkeey@googlemail.com>
> ---
>   arch/powerpc/kernel/setup-common.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
> index 0ac741fae90e..4a22ec6b34de 100644
> --- a/arch/powerpc/kernel/setup-common.c
> +++ b/arch/powerpc/kernel/setup-common.c
> @@ -904,7 +904,8 @@ void __init setup_arch(char **cmdline_p)
>   #endif
>   #endif
>   
> -#ifdef CONFIG_PPC_64K_PAGES
> +#if defined(CONFIG_PPC_64K_PAGES) && \
> +    (defined(CONFIG_PPC_BOOK3S_64) || defined(CONFIG_PPC_BOOK3E_MMU))
>   	init_mm.context.pte_frag = NULL;
>   #endif
>   #ifdef CONFIG_SPAPR_TCE_IOMMU
> 

---
L'absence de virus dans ce courrier électronique a été vérifiée par le logiciel antivirus Avast.
https://www.avast.com/antivirus
