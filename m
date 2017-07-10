Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x5k6R3kWJzDq5f
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Jul 2017 21:50:07 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Oliver O'Halloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: Oliver O'Halloran <oohall@gmail.com>
Subject: Re: [PATCH] powerpc/asm: Mark cr0 as clobbered in mftb()
In-Reply-To: <20170706084643.22425-1-oohall@gmail.com>
References: <20170706084643.22425-1-oohall@gmail.com>
Date: Mon, 10 Jul 2017 21:50:06 +1000
Message-ID: <8737a4v7dd.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Oliver O'Halloran <oohall@gmail.com> writes:

> The workaround for the CELL timebase bug does not correctly mark cr0 as
> being clobbered. This can result in GCC making some poor^W completely
> broken optimisations.

Fruit 'n oats, how did we never notice that? Luck I guess. Or subtle
breakage that no one could pin down :E

I'll tag it for stable.

Your change log is not entirely fair, it's not GCC's fault, we changed
register state without telling it, so it's on us :)  I'll reword it a
bit here.

cheers

> diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
> index 7e50e47375d6..a3b6575c7842 100644
> --- a/arch/powerpc/include/asm/reg.h
> +++ b/arch/powerpc/include/asm/reg.h
> @@ -1303,7 +1303,7 @@ static inline void msr_check_and_clear(unsigned long bits)
>  				"	.llong 0\n"			\
>  				".previous"				\
>  			: "=r" (rval) \
> -			: "i" (CPU_FTR_CELL_TB_BUG), "i" (SPRN_TBRL)); \
> +			: "i" (CPU_FTR_CELL_TB_BUG), "i" (SPRN_TBRL) : "cr0"); \
>  			rval;})
>  #else
>  #define mftb()		({unsigned long rval;	\
> -- 
> 2.9.4
