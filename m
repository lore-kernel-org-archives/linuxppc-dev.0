Return-Path: <anton@samba.org>
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::147:1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x89kS6WYSzDqg2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Jul 2017 21:41:19 +1000 (AEST)
Date: Fri, 14 Jul 2017 21:41:01 +1000
From: Anton Blanchard <anton@samba.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <masriniv@in.ibm.com>, Michael Neuling
 <mikey@neuling.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Gautham R Shenoy <ego@linux.vnet.ibm.com>, Vaidyanathan Srinivasan
 <svaidy@linux.vnet.ibm.com>
Subject: Re: [PATCH] POWER9 PMU interrupt after idle workaround
Message-ID: <20170714214101.481a0e74@kryten>
In-Reply-To: <20170710061938.22513-1-npiggin@gmail.com>
References: <20170710061938.22513-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Nick,

> POWER9 DD2 can see spurious PMU interrupts after state-loss idle in
> some conditions.
> 
> A solution is to save and reload MMCR0 over state-loss idle.

Thanks, looks good.

Tested-by: Anton Blanchard <anton@samba.org>

Anton

> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  arch/powerpc/kernel/idle_book3s.S | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/idle_book3s.S
> b/arch/powerpc/kernel/idle_book3s.S index 5adb390e773b..516ebef905c0
> 100644 --- a/arch/powerpc/kernel/idle_book3s.S
> +++ b/arch/powerpc/kernel/idle_book3s.S
> @@ -30,6 +30,7 @@
>   * Use unused space in the interrupt stack to save and restore
>   * registers for winkle support.
>   */
> +#define _MMCR0	GPR0
>  #define _SDR1	GPR3
>  #define _PTCR	GPR3
>  #define _RPR	GPR4
> @@ -272,6 +273,14 @@ power_enter_stop:
>  	b 	pnv_wakeup_noloss
>  
>  .Lhandle_esl_ec_set:
> +	/*
> +	 * POWER9 DD2 can incorrectly set PMAO when waking up after a
> +	 * state-loss idle. Saving and restoring MMCR0 over idle is a
> +	 * workaround.
> +	 */
> +	mfspr	r4,SPRN_MMCR0
> +	std	r4,_MMCR0(r1)
> +
>  /*
>   * Check if the requested state is a deep idle state.
>   */
> @@ -450,10 +459,14 @@ ALT_FTR_SECTION_END_IFSET(CPU_FTR_ARCH_300)
>  pnv_restore_hyp_resource_arch300:
>  	/*
>  	 * Workaround for POWER9, if we lost resources, the ERAT
> -	 * might have been mixed up and needs flushing.
> +	 * might have been mixed up and needs flushing. We also need
> +	 * to reload MMCR0 (see comment above).
>  	 */
>  	blt	cr3,1f
>  	PPC_INVALIDATE_ERAT
> +	ld	r1,PACAR1(r13)
> +	ld	r4,_MMCR0(r1)
> +	mtspr	SPRN_MMCR0,r4
>  1:
>  	/*
>  	 * POWER ISA 3. Use PSSCR to determine if we
