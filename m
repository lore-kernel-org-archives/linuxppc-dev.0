Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xdL8W53q0zDrJx
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Aug 2017 20:27:39 +1000 (AEST)
Date: Thu, 24 Aug 2017 20:27:35 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org
Subject: Re: [PATCH v2 12/14] KVM: PPC: Book3S HV: POWER9 can execute stop
 without a sync sequence
Message-ID: <20170824102735.GI27401@fergus.ozlabs.ibm.com>
References: <20170811163912.28783-1-npiggin@gmail.com>
 <20170811163912.28783-13-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170811163912.28783-13-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Aug 12, 2017 at 02:39:10AM +1000, Nicholas Piggin wrote:
> Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  arch/powerpc/kvm/book3s_hv_rmhandlers.S | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> index 3e024fd71fe8..edb47738a686 100644
> --- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> +++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> @@ -2527,7 +2527,17 @@ BEGIN_FTR_SECTION
>  END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
>  
>  kvm_nap_sequence:		/* desired LPCR value in r5 */
> -BEGIN_FTR_SECTION
> +BEGIN_FTR_SECTION	/* nap sequence */
> +	mtspr	SPRN_LPCR,r5
> +	isync
> +	li	r0, 0
> +	std	r0, HSTATE_SCRATCH0(r13)
> +	ptesync
> +	ld	r0, HSTATE_SCRATCH0(r13)
> +1:	cmpd	r0, r0
> +	bne	1b
> +	nap
> +FTR_SECTION_ELSE	/* stop sequence */
>  	/*
>  	 * PSSCR bits:	exit criterion = 1 (wakeup based on LPCR at sreset)
>  	 *		enable state loss = 1 (allow SMT mode switch)
> @@ -2539,18 +2549,8 @@ BEGIN_FTR_SECTION
>  	li	r4, LPCR_PECE_HVEE@higher
>  	sldi	r4, r4, 32
>  	or	r5, r5, r4
> -END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)
>  	mtspr	SPRN_LPCR,r5
> -	isync
> -	li	r0, 0
> -	std	r0, HSTATE_SCRATCH0(r13)
> -	ptesync
> -	ld	r0, HSTATE_SCRATCH0(r13)
> -1:	cmpd	r0, r0
> -	bne	1b
> -BEGIN_FTR_SECTION
> -	nap
> -FTR_SECTION_ELSE
> +
>  	PPC_STOP
>  ALT_FTR_SECTION_END_IFCLR(CPU_FTR_ARCH_300)
>  	b	.
> -- 
> 2.13.3

Currently we never get to kvm_nap_sequence on POWER9 because we are
always running one vcpu per vcore, so I haven't worried about this
code too much.  In future we might need this for running HPT guests on
a radix host, though.

Paul.
