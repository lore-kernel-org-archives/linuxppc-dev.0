Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 734B71A03D6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Feb 2015 13:57:44 +1100 (AEDT)
Message-ID: <1423620717.5891.31.camel@kernel.crashing.org>
Subject: Re: [PATCH 3/4] powerpc/boot: Fix stack corruption in epapr entry
 point
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jeremy Kerr <jk@ozlabs.org>
Date: Wed, 11 Feb 2015 13:11:57 +1100
In-Reply-To: <1423570510.219047.52227904007.3.gpush@pablo>
References: <1423570510.219047.52227904007.3.gpush@pablo>
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
> Currently, a 64-bit little-endian zImage.epapr won't boot in epapr mode,
> as as we never return from platform_init.
> 
> Before entering C, we initialise our stack by setting r1 16 bytes below
> the end of the _bss_stack:
> 
>   stwu	r0,-16(r1)	/* establish a stack frame */
> 
> However, the called function will save the caller's lr in the caller's
> frame's lr save area, at -16(r1) to -32(r1).
> 
> This means that writes to the fdt variable corrupt the saved link
> register:
> 
>  0000000020c06018 l     O .bss   0000000000001000 _bss_stack
>  0000000020c07018 l     O .bss   0000000000000008 fdt
> 
> This change allocates the minimum of 32 bytes for the base of the stack
> instead.

Is that sufficient for ABI v1 ? It feels like it's broken for BE as
well...

Ben.

> Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
> 
> ---
>  arch/powerpc/boot/crt0.S |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/boot/crt0.S b/arch/powerpc/boot/crt0.S
> index 14de4f8..bf8eeee 100644
> --- a/arch/powerpc/boot/crt0.S
> +++ b/arch/powerpc/boot/crt0.S
> @@ -218,7 +218,7 @@ p_base:	mflr	r10		/* r10 now points to runtime addr of p_base */
>  	beq	6f
>  	ld	r1,0(r8)
>  	li	r0,0
> -	stdu	r0,-16(r1)	/* establish a stack frame */
> +	stdu	r0,-32(r1)	/* establish a stack frame */
>  6:
>  #endif  /* __powerpc64__ */
>  	/* Call platform_init() */
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
