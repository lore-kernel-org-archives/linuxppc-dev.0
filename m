Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xh8S41dt1zDqGX
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Aug 2017 10:20:52 +1000 (AEST)
Date: Tue, 29 Aug 2017 10:20:48 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org
Subject: Re: [PATCH v3 4/4] powerpc/64s: idle ESL=0 stop can avoid MSR and
 save/restore overhead
Message-ID: <20170829002048.GG12629@fergus.ozlabs.ibm.com>
References: <20170825043036.18236-1-npiggin@gmail.com>
 <20170825043036.18236-5-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170825043036.18236-5-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 25, 2017 at 02:30:36PM +1000, Nicholas Piggin wrote:
> When stop is executed with EC=ESL=0, it appears to execute like a
> normal instruction (resuming from NIP when woken by interrupt).
> So all the save/restore handling can be avoided completely. In
> particular NV GPRs do not have to be saved, and MSR does not have
> to be switched back to kernel MSR.
> 
> So move the test for "lite" sleep states out to power9_idle_stop.
> 
> Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  arch/powerpc/kernel/idle_book3s.S | 35 ++++++++++++++++++++++++-----------
>  1 file changed, 24 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
> index 32d65ee323a0..fa56120bd0bc 100644
> --- a/arch/powerpc/kernel/idle_book3s.S
> +++ b/arch/powerpc/kernel/idle_book3s.S
> @@ -315,9 +315,6 @@ enter_winkle:
>  
>  	ARCH207_IDLE_STATE_ENTER_SEQ_NORET(PPC_WINKLE)
>  
> -/*
> - * r3 - PSSCR value corresponding to the requested stop state.
> - */
>  #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
>  power_enter_stop_kvm_rm:
>  	/*
> @@ -330,14 +327,11 @@ power_enter_stop_kvm_rm:
>  	li	r4,KVM_HWTHREAD_IN_IDLE
>  	/* DO THIS IN REAL MODE!  See comment above. */
>  	stb	r4,HSTATE_HWTHREAD_STATE(r13)
> -#endif
> -power_enter_stop:
>  /*
>   * Check if we are executing the lite variant with ESL=EC=0
>   */
> -	andis.   r4,r3,PSSCR_EC_ESL_MASK_SHIFTED
> -	clrldi   r3,r3,60 /* r3 = Bits[60:63] = Requested Level (RL) */
> -	bne	 .Lhandle_esl_ec_set
> +	andis.	r4,r3,PSSCR_EC_ESL_MASK_SHIFTED
> +	bne	power_enter_stop_esl
>  	PPC_STOP
>  	li	r3,0  /* Since we didn't lose state, return 0 */
>  
> @@ -354,8 +348,13 @@ power_enter_stop:
>  	 */
>  	li	r12, 0
>  	b 	pnv_wakeup_noloss
> +#endif
>  
> -.Lhandle_esl_ec_set:
> +/*
> + * r3 - PSSCR value corresponding to the requested stop state.
> + */
> +power_enter_stop_esl:
> +	clrldi   r3,r3,60 /* r3 = Bits[60:63] = Requested Level (RL) */
>  	/*
>  	 * POWER9 DD2 can incorrectly set PMAO when waking up after a
>  	 * state-loss idle. Saving and restoring MMCR0 over idle is a
> @@ -428,9 +427,23 @@ ALT_FTR_SECTION_END_NESTED_IFSET(CPU_FTR_ARCH_207S, 66);		\
>   * r3 contains desired PSSCR register value.
>   */
>  _GLOBAL(power9_idle_stop)
> -	std	r3, PACA_REQ_PSSCR(r13)
>  	mtspr 	SPRN_PSSCR,r3
> -	LOAD_REG_ADDR(r4,power_enter_stop)
> +
> +	/*
> +	 * Check if we are executing the lite variant with ESL=EC=0
> +	 * This case resumes execution after the stop instruction without
> +	 * losing any state, so nothing has to be saved. The following
> +	 * instructions up to the blr must be skipped if we want to
> +	 * use power_enter_stop_kvm_rm.
> +	 */
> +	andis.	r4,r3,PSSCR_EC_ESL_MASK_SHIFTED

I realize you're just moving existing code, but I think this would be
clearer (to me, anyway) as

	andis.	r4, r3, (PSSCR_EC | PSSCR_ESL)@h

Apart from that very minor nit,

Reviewed-by: Paul Mackerras <paulus@ozlabs.org>
