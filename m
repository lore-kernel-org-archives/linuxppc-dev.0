Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rFgdj0WGBzDqT6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 May 2016 17:24:56 +1000 (AEST)
Subject: Re: [PATCH 2/2] powerpc: Align hot loops of some string functions
To: Anton Blanchard <anton@samba.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 acsawdey@linux.vnet.ibm.com
References: <20160526083813.0f96a454@kryten> <20160526083955.3f7deda4@kryten>
Cc: linuxppc-dev@lists.ozlabs.org
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <14a46745-dd1e-2963-1c1a-7daafa5aed4b@c-s.fr>
Date: Thu, 26 May 2016 09:24:51 +0200
MIME-Version: 1.0
In-Reply-To: <20160526083955.3f7deda4@kryten>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 26/05/2016 à 00:39, Anton Blanchard via Linuxppc-dev a écrit :
> Align the hot loops in our assembly implementation of strncpy(),
> strncmp() and memchr().
Wouldn't it be better to add nops before the function entry in order to 
get the hot loop aligned, instead of adding nops in the middle of the 
function ?

Christophe
>
> Signed-off-by: Anton Blanchard <anton@samba.org>
> ---
>
> Index: linux.junk/arch/powerpc/lib/string.S
> ===================================================================
> --- linux.junk.orig/arch/powerpc/lib/string.S
> +++ linux.junk/arch/powerpc/lib/string.S
> @@ -24,6 +24,7 @@ _GLOBAL(strncpy)
>   	mtctr	r5
>   	addi	r6,r3,-1
>   	addi	r4,r4,-1
> +	.balign 16
>   1:	lbzu	r0,1(r4)
>   	cmpwi	0,r0,0
>   	stbu	r0,1(r6)
> @@ -42,6 +43,7 @@ _GLOBAL(strncmp)
>   	mtctr	r5
>   	addi	r5,r3,-1
>   	addi	r4,r4,-1
> +	.balign 16
>   1:	lbzu	r3,1(r5)
>   	cmpwi	1,r3,0
>   	lbzu	r0,1(r4)
> @@ -73,6 +75,7 @@ _GLOBAL(memchr)
>   	beq-	2f
>   	mtctr	r5
>   	addi	r3,r3,-1
> +	.balign 16
>   1:	lbzu	r0,1(r3)
>   	cmpw	0,r0,r4
>   	bdnzf	2,1b
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
