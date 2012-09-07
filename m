Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id B8E712C0089
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Sep 2012 14:24:08 +1000 (EST)
Message-ID: <1346991839.2385.42.camel@pasglop>
Subject: Re: [PATCH] powerpc/booke-64: fix tlbsrx. path in bolted tlb handler
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: scott@tyr.buserror.net
Date: Fri, 07 Sep 2012 14:23:59 +1000
In-Reply-To: <20120612220232.GA17228@tyr.buserror.net>
References: <20120612220232.GA17228@tyr.buserror.net>
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

On Tue, 2012-06-12 at 17:02 -0500, Scott Wood wrote:
> It was branching to the cleanup part of the non-bolted handler,
> which would have been bad if there were any chips with tlbsrx.
> that use the bolted handler.

Still relevant ? It doesn't apply anymore :-)

Cheers,
Ben.

> Signed-off-by: Scott Wood <scott@tyr.buserror.net>
> ---
>  arch/powerpc/mm/tlb_low_64e.S |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/powerpc/mm/tlb_low_64e.S b/arch/powerpc/mm/tlb_low_64e.S
> index ff672bd..efe0f33 100644
> --- a/arch/powerpc/mm/tlb_low_64e.S
> +++ b/arch/powerpc/mm/tlb_low_64e.S
> @@ -128,7 +128,7 @@ BEGIN_MMU_FTR_SECTION
>  	 */
>  	PPC_TLBSRX_DOT(0,r16)
>  	ldx	r14,r14,r15		/* grab pgd entry */
> -	beq	normal_tlb_miss_done	/* tlb exists already, bail */
> +	beq	tlb_miss_done_bolted	/* tlb exists already, bail */
>  MMU_FTR_SECTION_ELSE
>  	ldx	r14,r14,r15		/* grab pgd entry */
>  ALT_MMU_FTR_SECTION_END_IFSET(MMU_FTR_USE_TLBRSRV)
> @@ -184,6 +184,7 @@ ALT_MMU_FTR_SECTION_END_IFSET(MMU_FTR_USE_TLBRSRV)
>  	mtspr	SPRN_MAS7_MAS3,r15
>  	tlbwe
>  
> +tlb_miss_done_bolted:
>  	TLB_MISS_STATS_X(MMSTAT_TLB_MISS_NORM_OK)
>  	tlb_epilog_bolted
>  	rfi
