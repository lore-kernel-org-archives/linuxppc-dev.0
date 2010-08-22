Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DE596B6F11
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 23 Aug 2010 08:35:00 +1000 (EST)
Subject: Re: [PATCH] powerpc: mtmsrd not defined
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sean MacLennan <smaclennan@pikatech.com>
In-Reply-To: <20100822180958.6305f5b1@lappy.seanm.ca>
References: <20100822180958.6305f5b1@lappy.seanm.ca>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 23 Aug 2010 08:34:54 +1000
Message-ID: <1282516494.22370.440.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2010-08-22 at 18:09 -0400, Sean MacLennan wrote:
> Let's try a patch to get the ball rolling. 
> 
> ldstfp.S does not compile if mtmsrd not defined. But is it only defined
> for BOOK3S_64. This defines mtmsrd to be mtmsr on all but BOOK3S_64.
> This solves the compile problem... but I am not sure how to test it.
> 
> I am also not sure if this is the best place to define it. If the
> mapping of mtmsrd to mtmsr is correct, maybe it should be in asm/reg.h?

I'd rather have a macro somewhere in ppc_asm.h (MTMSR ?) that does the
right thing. We might even already have one...

Cheers,
Ben.

> Signed-off-by: Sean MacLennan <smaclennan@pikatech.com>
> ---
> diff --git a/arch/powerpc/lib/ldstfp.S b/arch/powerpc/lib/ldstfp.S
> index f644863..df8a03b 100644
> --- a/arch/powerpc/lib/ldstfp.S
> +++ b/arch/powerpc/lib/ldstfp.S
> @@ -17,6 +17,10 @@
>  #include <asm/asm-offsets.h>
>  #include <linux/errno.h>
>  
> +#ifndef CONFIG_PPC_BOOK3S_64
> +#define mtmsrd mtmsr
> +#endif
> +
>  #define STKFRM	(PPC_MIN_STKFRM + 16)
>  
>  	.macro	extab	instr,handler
> 
> Cheers,
>    Sean
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
