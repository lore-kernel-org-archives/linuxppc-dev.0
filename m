Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 13AF02C008F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jan 2014 10:27:29 +1100 (EST)
Message-ID: <1389569240.4672.113.camel@pasglop>
Subject: Re: [PATCH v2] powerpc/booke-64: fix tlbsrx. path in bolted tlb
 handler
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
Date: Mon, 13 Jan 2014 10:27:20 +1100
In-Reply-To: <1389396656-27813-1-git-send-email-scottwood@freescale.com>
References: <1389396656-27813-1-git-send-email-scottwood@freescale.com>
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

On Fri, 2014-01-10 at 17:30 -0600, Scott Wood wrote:
> From: Scott Wood <scott@tyr.buserror.net>
> 
> It was branching to the cleanup part of the non-bolted handler,
> which would have been bad if there were any chips with tlbsrx.
> that use the bolted handler.
> 
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
> v2: rebase

Ack.

>  arch/powerpc/mm/tlb_low_64e.S | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/mm/tlb_low_64e.S b/arch/powerpc/mm/tlb_low_64e.S
> index 75f5d27..16250b1 100644
> --- a/arch/powerpc/mm/tlb_low_64e.S
> +++ b/arch/powerpc/mm/tlb_low_64e.S
> @@ -136,7 +136,7 @@ BEGIN_MMU_FTR_SECTION
>  	 */
>  	PPC_TLBSRX_DOT(0,R16)
>  	ldx	r14,r14,r15		/* grab pgd entry */
> -	beq	normal_tlb_miss_done	/* tlb exists already, bail */
> +	beq	tlb_miss_done_bolted	/* tlb exists already, bail */
>  MMU_FTR_SECTION_ELSE
>  	ldx	r14,r14,r15		/* grab pgd entry */
>  ALT_MMU_FTR_SECTION_END_IFSET(MMU_FTR_USE_TLBRSRV)
> @@ -192,6 +192,7 @@ ALT_MMU_FTR_SECTION_END_IFSET(MMU_FTR_USE_TLBRSRV)
>  	mtspr	SPRN_MAS7_MAS3,r15
>  	tlbwe
>  
> +tlb_miss_done_bolted:
>  	TLB_MISS_STATS_X(MMSTAT_TLB_MISS_NORM_OK)
>  	tlb_epilog_bolted
>  	rfi
