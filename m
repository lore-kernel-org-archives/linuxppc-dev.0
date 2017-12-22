Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z36nT2QbDzDwP9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Dec 2017 23:11:57 +1100 (AEDT)
Subject: Re: [PATCH] powerpc/mm: Simplify _PAGE_RO handling in page table dump
From: Christophe LEROY <christophe.leroy@c-s.fr>
To: Michael Ellerman <mpe@ellerman.id.au>
References: <20170509141626.F30E767954@pc13941vm.idsi0.si.c-s.fr>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Message-ID: <1560c976-41e0-d9c8-2caa-56300a12f3f9@c-s.fr>
Date: Fri, 22 Dec 2017 13:11:53 +0100
MIME-Version: 1.0
In-Reply-To: <20170509141626.F30E767954@pc13941vm.idsi0.si.c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ping ?

Le 09/05/2017 à 16:16, Christophe Leroy a écrit :
> Commit fd893fe56a130 ("powerpc/mm: Fix missing page attributes in
> page table dump") added support of _PAGE_RO attribute.
> 
> This patch makes it more simple
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>   arch/powerpc/mm/dump_linuxpagetables.c | 7 +------
>   1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/arch/powerpc/mm/dump_linuxpagetables.c b/arch/powerpc/mm/dump_linuxpagetables.c
> index d659345a98d6..eeef51107cff 100644
> --- a/arch/powerpc/mm/dump_linuxpagetables.c
> +++ b/arch/powerpc/mm/dump_linuxpagetables.c
> @@ -121,13 +121,8 @@ static const struct flag_info flag_array[] = {
>   		.set	= "user",
>   		.clear	= "    ",
>   	}, {
> -#if _PAGE_RO == 0
> -		.mask	= _PAGE_RW,
> +		.mask	= _PAGE_RW | _PAGE_RO,
>   		.val	= _PAGE_RW,
> -#else
> -		.mask	= _PAGE_RO,
> -		.val	= 0,
> -#endif
>   		.set	= "rw",
>   		.clear	= "ro",
>   	}, {
> 
