Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xPr1p3D26zDql1
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  6 Aug 2017 03:11:58 +1000 (AEST)
Received: by mail-pg0-x241.google.com with SMTP id l64so4739221pge.2
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 05 Aug 2017 10:11:58 -0700 (PDT)
Date: Sun, 6 Aug 2017 03:11:39 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>
Subject: Re: [PATCH 13/13] powerpc/64s: idle ESL=0 stop can avoid all
 save/restore overhead
Message-ID: <20170806031139.1351e813@roar.ozlabs.ibm.com>
In-Reply-To: <20170805170241.22966-14-npiggin@gmail.com>
References: <20170805170241.22966-1-npiggin@gmail.com>
 <20170805170241.22966-14-npiggin@gmail.com>
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

On Sun,  6 Aug 2017 03:02:41 +1000
Nicholas Piggin <npiggin@gmail.com> wrote:

> When stop is executed with EC=ESL=0, it appears to execute like a
> normal instruction (resuming from NIP when woken by interrupt).
> So all the save/restore handling can be avoided completely. In
> particular NV GPRs do not have to be saved, and MSR does not have
> to be switched back to kernel MSR.
> 
> So move the test for "lite" sleep states out to power9_idle_stop.

I forgot to mention this actually breaks in the simulator because
it sets MSR as though it's taken a system reset interrupt when
resuming from EC=0 stop. It works on real hardware.

This might have to be quirked away by firmware or something, but
I've reported the bug so waiting to hear back first.

Thanks,
Nick

> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  arch/powerpc/kernel/idle_book3s.S | 38 +++++++++++++-------------------------
>  1 file changed, 13 insertions(+), 25 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
> index 8ac366a51bb5..9eb47c99dc39 100644
> --- a/arch/powerpc/kernel/idle_book3s.S
> +++ b/arch/powerpc/kernel/idle_book3s.S
> @@ -251,31 +251,8 @@ enter_winkle:
>  /*
>   * r3 - PSSCR value corresponding to the requested stop state.
>   */
> -power_enter_stop:
> -/*
> - * Check if we are executing the lite variant with ESL=EC=0
> - */
> -	andis.   r4,r3,PSSCR_EC_ESL_MASK_SHIFTED
> +power_enter_stop_esl:
>  	clrldi   r3,r3,60 /* r3 = Bits[60:63] = Requested Level (RL) */
> -	bne	 .Lhandle_esl_ec_set
> -	PPC_STOP
> -	li	r3,0  /* Since we didn't lose state, return 0 */
> -
> -	/*
> -	 * pnv_wakeup_noloss() expects r12 to contain the SRR1 value so
> -	 * it can determine if the wakeup reason is an HMI in
> -	 * CHECK_HMI_INTERRUPT.
> -	 *
> -	 * However, when we wakeup with ESL=0, SRR1 will not contain the wakeup
> -	 * reason, so there is no point setting r12 to SRR1.
> -	 *
> -	 * Further, we clear r12 here, so that we don't accidentally enter the
> -	 * HMI in pnv_wakeup_noloss() if the value of r12[42:45] == WAKE_HMI.
> -	 */
> -	li	r12, 0
> -	b 	pnv_wakeup_noloss
> -
> -.Lhandle_esl_ec_set:
>  	/*
>  	 * POWER9 DD2 can incorrectly set PMAO when waking up after a
>  	 * state-loss idle. Saving and restoring MMCR0 over idle is a
> @@ -348,9 +325,20 @@ ALT_FTR_SECTION_END_NESTED_IFSET(CPU_FTR_ARCH_207S, 66);		\
>   * r3 contains desired PSSCR register value.
>   */
>  _GLOBAL(power9_idle_stop)
> +	/*
> +	 * Check if we are executing the lite variant with ESL=EC=0
> +	 * This case resumes execution after the stop instruction without
> +	 * losing any state, so nothing has to be saved.
> +	 */
> +	andis.	r4,r3,PSSCR_EC_ESL_MASK_SHIFTED
> +	bne	1f
> +	PPC_STOP
> +	li	r3,0  /* Since we didn't lose state, return 0 */
> +	blr
> +1:	/* state-loss idle */
>  	std	r3, PACA_REQ_PSSCR(r13)
>  	mtspr 	SPRN_PSSCR,r3
> -	LOAD_REG_ADDR(r4,power_enter_stop)
> +	LOAD_REG_ADDR(r4,power_enter_stop_esl)
>  	b	pnv_powersave_common
>  	/* No return */
>  
