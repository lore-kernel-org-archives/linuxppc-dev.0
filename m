Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xRWPM4gWLzDqjB
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Aug 2017 20:49:43 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v78AnOHA079547
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 8 Aug 2017 06:49:41 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2c7a63web5-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Aug 2017 06:49:40 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Tue, 8 Aug 2017 04:49:40 -0600
Date: Tue, 8 Aug 2017 16:19:35 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>
Subject: Re: [PATCH 13/13] powerpc/64s: idle ESL=0 stop can avoid all
 save/restore overhead
Reply-To: ego@linux.vnet.ibm.com
References: <20170805170241.22966-1-npiggin@gmail.com>
 <20170805170241.22966-14-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170805170241.22966-14-npiggin@gmail.com>
Message-Id: <20170808104935.GD9107@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Aug 06, 2017 at 03:02:41AM +1000, Nicholas Piggin wrote:
> When stop is executed with EC=ESL=0, it appears to execute like a
> normal instruction (resuming from NIP when woken by interrupt).
> So all the save/restore handling can be avoided completely. In
> particular NV GPRs do not have to be saved, and MSR does not have
> to be switched back to kernel MSR.
> 
> So move the test for "lite" sleep states out to power9_idle_stop.

Nice optimization!

Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>

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
> -- 
> 2.11.0
> 
