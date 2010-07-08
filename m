Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B5656B6EF3
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  8 Jul 2010 15:10:52 +1000 (EST)
Subject: Re: [PATCH] arch/powerpc/lib/copy_32.S: Use alternate memcpy for
	MPC512x and MPC52xx
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Steve Deiters <SteveDeiters@BASLER.com>
In-Reply-To: <181804936ABC2349BE503168465576460F272CA4@exchserver.basler.com>
References: <181804936ABC2349BE503168465576460F272CA4@exchserver.basler.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 08 Jul 2010 15:10:45 +1000
Message-ID: <1278565845.28659.75.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2010-06-29 at 11:04 -0500, Steve Deiters wrote:
> These processors will corrupt data if accessing the local bus with
> unaligned
> addresses. This version fixes the typical case of copying from Flash on
> the
> local bus by keeping the source address always aligned.

Shouldn't this be solved by using memcpy_to/fromio ?

Cheers,
Ben.

> Signed-off-by: Steve Deiters <SteveDeiters@basler.com>
> ---
>  arch/powerpc/lib/copy_32.S |   56
> ++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 56 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/lib/copy_32.S b/arch/powerpc/lib/copy_32.S
> index 74a7f41..42e7df5 100644
> --- a/arch/powerpc/lib/copy_32.S
> +++ b/arch/powerpc/lib/copy_32.S
> @@ -226,6 +226,60 @@ _GLOBAL(memmove)
>  	bgt	backwards_memcpy
>  	/* fall through */
>  
> +#if defined(CONFIG_PPC_MPC512x) || defined(CONFIG_PPC_MPC52xx)
> +
> +/*
> + * Alternate memcpy for MPC512x and MPC52xx to guarantee source
> + * address is always aligned to prevent corruption issues when
> + * copying unaligned from the local bus. This only fixes the usage
> + * when copying from the local bus (e.g. Flash) and will not fix
> + * issues copying to the local bus
> + */
> +_GLOBAL(memcpy)
> +	srwi.	r7,r5,3
> +	addi	r6,r3,-4
> +	addi	r4,r4,-4
> +	beq	2f			/* if less than 8 bytes to do */
> +	andi.	r0,r4,3			/* get src word aligned */
> +	mtctr	r7
> +	bne	5f
> +1:	lwz	r7,4(r4)
> +	lwzu	r8,8(r4)
> +	stw	r7,4(r6)
> +	stwu	r8,8(r6)
> +	bdnz	1b
> +	andi.	r5,r5,7
> +2:	cmplwi	0,r5,4
> +	blt	3f
> +	andi.	r0,r4,3
> +	bne	3f
> +	lwzu	r0,4(r4)
> +	addi	r5,r5,-4
> +	stwu	r0,4(r6)
> +3:	cmpwi	0,r5,0
> +	beqlr
> +	mtctr	r5
> +	addi	r4,r4,3
> +	addi	r6,r6,3
> +4:	lbzu	r0,1(r4)
> +	stbu	r0,1(r6)
> +	bdnz	4b
> +	blr
> +5:	subfic	r0,r0,4
> +	mtctr	r0
> +6:	lbz	r7,4(r4)
> +	addi	r4,r4,1
> +	stb	r7,4(r6)
> +	addi	r6,r6,1
> +	bdnz	6b
> +	subf	r5,r0,r5
> +	rlwinm.	r7,r5,32-3,3,31
> +	beq	2b
> +	mtctr	r7
> +	b	1b
> +
> +#else
> +
>  _GLOBAL(memcpy)
>  	srwi.	r7,r5,3
>  	addi	r6,r3,-4
> @@ -267,6 +321,8 @@ _GLOBAL(memcpy)
>  	mtctr	r7
>  	b	1b
>  
> +#endif
> +
>  _GLOBAL(backwards_memcpy)
>  	rlwinm.	r7,r5,32-3,3,31		/* r0 = r5 >> 3 */
>  	add	r6,r3,r5
