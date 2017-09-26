Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y1rX161WfzDsPK
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Sep 2017 05:25:36 +1000 (AEST)
Subject: Re: [PATCH] powerpc: fix compile error on 64K pages on 40x, 44x
To: Christian Lamparter <chunkeey@googlemail.com>,
 linuxppc-dev@lists.ozlabs.org
Cc: Paul Mackerras <paulus@samba.org>
References: <20170926190345.2341-1-chunkeey@googlemail.com>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <8d7986f1-bb32-133f-d809-edb7b73106bb@c-s.fr>
Date: Tue, 26 Sep 2017 21:25:30 +0200
MIME-Version: 1.0
In-Reply-To: <20170926190345.2341-1-chunkeey@googlemail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 26/09/2017 à 21:03, Christian Lamparter a écrit :
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
> 
> Signed-off-by: Christian Lamparter <chunkeey@googlemail.com>
> ---
>   arch/powerpc/kernel/setup-common.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
> index 0ac741fae90e..436d42a7d761 100644
> --- a/arch/powerpc/kernel/setup-common.c
> +++ b/arch/powerpc/kernel/setup-common.c
> @@ -904,7 +904,9 @@ void __init setup_arch(char **cmdline_p)
>   #endif
>   #endif
>   
> -#ifdef CONFIG_PPC_64K_PAGES
> +#if defined(CONFIG_PPC_64K_PAGES) && \
> +    defined(CONFIG_PPC_BOOK3S_64) && \
> +    defined(CONFIG_PPC_BOOK3E_MMU)

There must be something wrong here.
BOOK3E_MMU is defined if BOOK3E_64 or FSL_BOOKE
BOOK3S_64 and BOOK3E_64 are mutually exclusive
FSL_BOOKE is PPC32 which is mutually exclusive from PPC64.

Therefore you can't have both BOOK3S_64 and BOOK3E_MMU at the same time

Christophe

>   	init_mm.context.pte_frag = NULL;
>   #endif
>   #ifdef CONFIG_SPAPR_TCE_IOMMU
> 
