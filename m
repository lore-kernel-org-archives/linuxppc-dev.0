Return-Path: <svaidy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zs43v3xswzF1cM
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Mar 2018 05:34:51 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1SIXej3036780
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Feb 2018 13:34:47 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2gdyjpxr20-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Feb 2018 13:34:47 -0500
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <svaidy@linux.vnet.ibm.com>;
 Wed, 28 Feb 2018 18:34:45 -0000
Date: Thu, 1 Mar 2018 00:04:39 +0530
From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@ozlabs.org>
Subject: Re: [PATCH 3/3] powerpc/64s/idle: POWER9 ESL=0 stop avoid
 save/restore overhead
Reply-To: svaidy@linux.vnet.ibm.com
References: <20171117140807.22105-1-npiggin@gmail.com>
 <20171117140807.22105-4-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20171117140807.22105-4-npiggin@gmail.com>
Message-Id: <20180228183439.GC20168@drishya.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Nicholas Piggin <npiggin@gmail.com> [2017-11-18 00:08:07]:

> When stop is executed with EC=ESL=0, it appears to execute like a
> normal instruction (resuming from NIP when woken by interrupt). So all
> the save/restore handling can be avoided completely. In particular NV
> GPRs do not have to be saved, and MSR does not have to be switched
> back to kernel MSR.
> 
> So move the test for EC=ESL=0 sleep states out to power9_idle_stop,
> and return directly to the caller after stop in that case. The mtspr
> to PSSCR is moved to the top of power9_offline_stop just so it matches
> power9_idle_stop.
> 
> This improves performance for ping-pong benchmark with the stop0_lite
> idle state by 2.54% for 2 threads in the same core, and 2.57% for
> different cores.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Reviewed-by: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>

> ---
>  arch/powerpc/kernel/idle_book3s.S     | 43 +++++++++++------------------------
>  arch/powerpc/platforms/powernv/idle.c |  7 +++++-
>  2 files changed, 19 insertions(+), 31 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
> index 07a306173c5a..6243da99b26c 100644
> --- a/arch/powerpc/kernel/idle_book3s.S
> +++ b/arch/powerpc/kernel/idle_book3s.S
> @@ -324,31 +324,8 @@ enter_winkle:
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
>  BEGIN_FTR_SECTION
>  	/*
>  	 * POWER9 DD2.0 or earlier can incorrectly set PMAO when waking up after
> @@ -423,26 +400,32 @@ ALT_FTR_SECTION_END_NESTED_IFSET(CPU_FTR_ARCH_207S, 66);		\
>   * r3 contains desired PSSCR register value.
>   */
>  _GLOBAL(power9_idle_stop)
> -	std	r3, PACA_REQ_PSSCR(r13)
>  	mtspr 	SPRN_PSSCR,r3
> -	LOAD_REG_ADDR(r4,power_enter_stop)
> +	andis.	r4,r3,PSSCR_EC_ESL_MASK_SHIFTED
> +	bne	1f
> +	PPC_STOP
> +	li	r3,0  /* Since we didn't lose state, return 0 */
> +	blr
> +
> +1:	std	r3, PACA_REQ_PSSCR(r13)
> +	LOAD_REG_ADDR(r4,power_enter_stop_esl)
>  	b	pnv_powersave_common
>  	/* No return */

Good optimization to skip the context save and directly execute stop
for ESL=EC=0 case.

>  /*
> - * Entered with MSR[EE]=0 and no soft-masked interrupts pending.
> - * r3 contains desired PSSCR register value.
> + * This is the same as the above, but it sets KVM state for secondaries,
> + * and it must have PSSCR[EC]=1
>   */
>  _GLOBAL(power9_offline_stop)
> -	std	r3, PACA_REQ_PSSCR(r13)
>  	mtspr 	SPRN_PSSCR,r3
> +	std	r3, PACA_REQ_PSSCR(r13)
>  #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
>  	/* Tell KVM we're entering idle */
>  	li	r4,KVM_HWTHREAD_IN_IDLE
>  	/* DO THIS IN REAL MODE!  See comment above. */
>  	stb	r4,HSTATE_HWTHREAD_STATE(r13)
>  #endif
> -	LOAD_REG_ADDR(r4,power_enter_stop)
> +	LOAD_REG_ADDR(r4,power_enter_stop_esl)
>  	b	pnv_powersave_common
>  	/* No return */
> 
> diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
> index a921d5428d76..610b1637c16f 100644
> --- a/arch/powerpc/platforms/powernv/idle.c
> +++ b/arch/powerpc/platforms/powernv/idle.c
> @@ -621,7 +621,12 @@ static int __init pnv_power9_idle_init(struct device_node *np, u32 *flags,
>  			continue;
>  		}
> 
> -		if (max_residency_ns < residency_ns[i]) {
> +		/*
> +		 * Deepest stop for unplug must be PSSCR[EC]=1 (wakeup at
> +		 * 0x100.
> +		 */
> +		if ((max_residency_ns < residency_ns[i])&&
> +				(psscr_val[i] & PSSCR_EC)) {
>  			max_residency_ns = residency_ns[i];
>  			pnv_deepest_stop_psscr_val = psscr_val[i];
>  			pnv_deepest_stop_psscr_mask = psscr_mask[i];

If firmware did not provide any ESL=EC=1 state, we can still leave
threads in stop ESL=0 state.  This is just a corner case or random
test scenario.  Why do we want to enforce that offline cpus really use
a ESL=0 state or just spin? 

--Vaidy
