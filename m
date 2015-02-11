Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 99AE81A03D6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Feb 2015 13:09:51 +1100 (AEDT)
Message-ID: <1423620585.5891.22.camel@kernel.crashing.org>
Subject: Re: [PATCH 4/4] powerpc/boot: don't clobber r6 and r7 in epapr boot
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jeremy Kerr <jk@ozlabs.org>
Date: Wed, 11 Feb 2015 13:09:45 +1100
In-Reply-To: <1423570510.219346.759068385066.4.gpush@pablo>
References: <1423570510.219346.759068385066.4.gpush@pablo>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-02-10 at 20:15 +0800, Jeremy Kerr wrote:
> We use r6 and r7 for epapr boot, but the current pre-C init will clobber
> both of these.
> 
> This change does a simple replacement, of r6 -> r12 and r7 -> r13, so
> that we hit platform init with these registers intact.
> 
> Signed-off-by: Jeremy Kerr <jk@ozlabs.org>

You might want to also remove the use of r8 and r9 which are supposed
to contain the OPAL entry and base for debugging purposes. We would also
have to restore them before booting the kernel.

[ Note: kexec is also missing that ]

Ben.

> ---
>  arch/powerpc/boot/crt0.S |   24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/powerpc/boot/crt0.S b/arch/powerpc/boot/crt0.S
> index bf8eeee..7e50211 100644
> --- a/arch/powerpc/boot/crt0.S
> +++ b/arch/powerpc/boot/crt0.S
> @@ -155,29 +155,29 @@ p_base:	mflr	r10		/* r10 now points to runtime addr of p_base */
>  	ld	r9,(p_rela-p_base)(r10)
>  	add	r9,r9,r10
>  
> -	li	r7,0
> +	li	r13,0
>  	li	r8,0
> -9:	ld	r6,0(r11)       /* get tag */
> -	cmpdi	r6,0
> +9:	ld	r12,0(r11)       /* get tag */
> +	cmpdi	r12,0
>  	beq	12f              /* end of list */
> -	cmpdi	r6,RELA
> +	cmpdi	r12,RELA
>  	bne	10f
> -	ld	r7,8(r11)       /* get RELA pointer in r7 */
> +	ld	r13,8(r11)       /* get RELA pointer in r13 */
>  	b	11f
> -10:	addis	r6,r6,(-RELACOUNT)@ha
> -	cmpdi	r6,RELACOUNT@l
> +10:	addis	r12,r12,(-RELACOUNT)@ha
> +	cmpdi	r12,RELACOUNT@l
>  	bne	11f
>  	ld	r8,8(r11)       /* get RELACOUNT value in r8 */
>  11:	addi	r11,r11,16
>  	b	9b
>  12:
> -	cmpdi	r7,0            /* check we have both RELA and RELACOUNT */
> +	cmpdi	r13,0            /* check we have both RELA and RELACOUNT */
>  	cmpdi	cr1,r8,0
>  	beq	3f
>  	beq	cr1,3f
>  
>  	/* Calcuate the runtime offset. */
> -	subf	r7,r7,r9
> +	subf	r13,r13,r9
>  
>  	/* Run through the list of relocations and process the
>  	 * R_PPC64_RELATIVE ones. */
> @@ -185,10 +185,10 @@ p_base:	mflr	r10		/* r10 now points to runtime addr of p_base */
>  13:	ld	r0,8(r9)        /* ELF64_R_TYPE(reloc->r_info) */
>  	cmpdi	r0,22           /* R_PPC64_RELATIVE */
>  	bne	3f
> -	ld	r6,0(r9)        /* reloc->r_offset */
> +	ld	r12,0(r9)        /* reloc->r_offset */
>  	ld	r0,16(r9)       /* reloc->r_addend */
> -	add	r0,r0,r7
> -	stdx	r0,r7,r6
> +	add	r0,r0,r13
> +	stdx	r0,r13,r12
>  	addi	r9,r9,24
>  	bdnz	13b
>  
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
