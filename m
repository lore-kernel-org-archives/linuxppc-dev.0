Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s4hsN71J4zDqQs
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Aug 2016 17:49:12 +1000 (AEST)
Subject: Re: [PATCH] powerpc: Align hot loops of memset() and
 backwards_memcpy()
To: Anton Blanchard <anton@ozlabs.org>, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au, agraf@suse.de
References: <1470293602-11121-1-git-send-email-anton@ozlabs.org>
Cc: linuxppc-dev@lists.ozlabs.org
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <c1370828-f149-5851-9a6d-3e7aeae54101@c-s.fr>
Date: Thu, 4 Aug 2016 09:49:07 +0200
MIME-Version: 1.0
In-Reply-To: <1470293602-11121-1-git-send-email-anton@ozlabs.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Le 04/08/2016 à 08:53, Anton Blanchard a écrit :
> From: Anton Blanchard <anton@samba.org>
>
> Align the hot loops in our assembly implementation of memset()
> and backwards_memcpy().
>
> backwards_memcpy() is called from tcp_v4_rcv(), so we might
> want to optimise this a little more.
>
> Signed-off-by: Anton Blanchard <anton@samba.org>

Shouldn't this patch be titled powerpc/64, as powerpc32 has a different 
memset() ?

Christophe

> ---
>  arch/powerpc/lib/mem_64.S | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/powerpc/lib/mem_64.S b/arch/powerpc/lib/mem_64.S
> index 43435c6..eda7a96 100644
> --- a/arch/powerpc/lib/mem_64.S
> +++ b/arch/powerpc/lib/mem_64.S
> @@ -37,6 +37,7 @@ _GLOBAL(memset)
>  	clrldi	r5,r5,58
>  	mtctr	r0
>  	beq	5f
> +	.balign 16
>  4:	std	r4,0(r6)
>  	std	r4,8(r6)
>  	std	r4,16(r6)
> @@ -90,6 +91,7 @@ _GLOBAL(backwards_memcpy)
>  	andi.	r0,r6,3
>  	mtctr	r7
>  	bne	5f
> +	.balign 16
>  1:	lwz	r7,-4(r4)
>  	lwzu	r8,-8(r4)
>  	stw	r7,-4(r6)
>
