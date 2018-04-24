Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40Vlf300KmzF1Rl
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Apr 2018 00:12:40 +1000 (AEST)
Subject: Re: [PATCH v3 01/19] powerpc/powermac: Mark variable x as unused
To: Mathieu Malaterre <malat@debian.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20180328192717.656-1-malat@debian.org>
 <20180404200746.27379-1-malat@debian.org>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <25e2ab60-2f1a-b491-3b3f-824cdaf1bfe3@c-s.fr>
Date: Tue, 24 Apr 2018 16:12:35 +0200
MIME-Version: 1.0
In-Reply-To: <20180404200746.27379-1-malat@debian.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 04/04/2018 à 22:07, Mathieu Malaterre a écrit :
> Since the value of x is never intended to be read, declare it with gcc
> attribute as unused. Fix warning treated as error with W=1:
> 
>    arch/powerpc/platforms/powermac/bootx_init.c:471:21: error: variable ‘x’ set but not used [-Werror=unused-but-set-variable]
> 
> Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> ---
> v3: style: add missing empty line after declaration
> v2: move x variable within its local scope
> 
>   arch/powerpc/platforms/powermac/bootx_init.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/platforms/powermac/bootx_init.c b/arch/powerpc/platforms/powermac/bootx_init.c
> index c3c9bbb3573a..ba0964c17620 100644
> --- a/arch/powerpc/platforms/powermac/bootx_init.c
> +++ b/arch/powerpc/platforms/powermac/bootx_init.c
> @@ -468,7 +468,7 @@ void __init bootx_init(unsigned long r3, unsigned long r4)
>   	boot_infos_t *bi = (boot_infos_t *) r4;
>   	unsigned long hdr;
>   	unsigned long space;
> -	unsigned long ptr, x;
> +	unsigned long ptr;
>   	char *model;
>   	unsigned long offset = reloc_offset();
>   
> @@ -562,6 +562,8 @@ void __init bootx_init(unsigned long r3, unsigned long r4)
>   	 * MMU switched OFF, so this should not be useful anymore.
>   	 */
>   	if (bi->version < 4) {
> +		unsigned long x __maybe_unused;
> +

That's detail, but shouldn't it be marked __always_unused instead ?

Christophe

>   		bootx_printf("Touching pages...\n");
>   
>   		/*
> 
