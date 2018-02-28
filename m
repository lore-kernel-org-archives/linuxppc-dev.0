Return-Path: <svaidy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zs3qt6H5DzF195
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Mar 2018 05:24:26 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1SIOJjn031445
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Feb 2018 13:24:23 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2gdysdnbp5-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Feb 2018 13:24:23 -0500
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <svaidy@linux.vnet.ibm.com>;
 Wed, 28 Feb 2018 18:24:21 -0000
Date: Wed, 28 Feb 2018 23:54:13 +0530
From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@ozlabs.org>
Subject: Re: [PATCH 1/3] powerpc/64s/idle: POWER9 implement a separate idle
 stop function for hotplug
Reply-To: svaidy@linux.vnet.ibm.com
References: <20171117140807.22105-1-npiggin@gmail.com>
 <20171117140807.22105-2-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20171117140807.22105-2-npiggin@gmail.com>
Message-Id: <20180228182413.GB20168@drishya.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Nicholas Piggin <npiggin@gmail.com> [2017-11-18 00:08:05]:

> Implement a new function to invoke stop, power9_offline_stop, which is
> like power9_idle_stop but used by the cpu hotplug code.
> 
> Move KVM secondary state manipulation code to the offline case.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Reviewed-by: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>


> ---
>  arch/powerpc/include/asm/processor.h  |  1 +
>  arch/powerpc/kernel/idle_book3s.S     | 24 ++++++++++++++++++------
>  arch/powerpc/platforms/powernv/idle.c |  2 +-
>  3 files changed, 20 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
> index bdab3b74eb98..0ebdb58460ce 100644
> --- a/arch/powerpc/include/asm/processor.h
> +++ b/arch/powerpc/include/asm/processor.h
> @@ -500,6 +500,7 @@ extern int powersave_nap;	/* set if nap mode can be used in idle loop */
>  extern unsigned long power7_idle_insn(unsigned long type); /* PNV_THREAD_NAP/etc*/
>  extern void power7_idle_type(unsigned long type);
>  extern unsigned long power9_idle_stop(unsigned long psscr_val);
> +extern unsigned long power9_offline_stop(unsigned long psscr_val);
>  extern void power9_idle_type(unsigned long stop_psscr_val,
>  			      unsigned long stop_psscr_mask);
> 
> diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
> index 01e1c1997893..2f8364e7b489 100644
> --- a/arch/powerpc/kernel/idle_book3s.S
> +++ b/arch/powerpc/kernel/idle_book3s.S
> @@ -325,12 +325,6 @@ enter_winkle:
>   * r3 - PSSCR value corresponding to the requested stop state.
>   */
>  power_enter_stop:
> -#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
> -	/* Tell KVM we're entering idle */
> -	li	r4,KVM_HWTHREAD_IN_IDLE
> -	/* DO THIS IN REAL MODE!  See comment above. */
> -	stb	r4,HSTATE_HWTHREAD_STATE(r13)
> -#endif
>  /*
>   * Check if we are executing the lite variant with ESL=EC=0
>   */
> @@ -435,6 +429,24 @@ _GLOBAL(power9_idle_stop)
>  	b	pnv_powersave_common
>  	/* No return */
> 
> +/*
> + * Entered with MSR[EE]=0 and no soft-masked interrupts pending.
> + * r3 contains desired PSSCR register value.
> + */
> +_GLOBAL(power9_offline_stop)
> +	std	r3, PACA_REQ_PSSCR(r13)
> +	mtspr 	SPRN_PSSCR,r3
> +#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
> +	/* Tell KVM we're entering idle */
> +	li	r4,KVM_HWTHREAD_IN_IDLE
> +	/* DO THIS IN REAL MODE!  See comment above. */
> +	stb	r4,HSTATE_HWTHREAD_STATE(r13)
> +#endif
> +	LOAD_REG_ADDR(r4,power_enter_stop)
> +	b	pnv_powersave_common
> +	/* No return */
> +

Good optimization.  This code is needed only when an offline thread is
wokenup at 0x100 to get into guest.  Can be skipped in idle wakeup
case.


> +
>  /*
>   * On waking up from stop 0,1,2 with ESL=1 on POWER9 DD1,
>   * HSPRG0 will be set to the HSPRG0 value of one of the
> diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
> index 443d5ca71995..a921d5428d76 100644
> --- a/arch/powerpc/platforms/powernv/idle.c
> +++ b/arch/powerpc/platforms/powernv/idle.c
> @@ -434,7 +434,7 @@ unsigned long pnv_cpu_offline(unsigned int cpu)
>  		psscr = mfspr(SPRN_PSSCR);
>  		psscr = (psscr & ~pnv_deepest_stop_psscr_mask) |
>  						pnv_deepest_stop_psscr_val;
> -		srr1 = power9_idle_stop(psscr);
> +		srr1 = power9_offline_stop(psscr);
> 
>  	} else if ((idle_states & OPAL_PM_WINKLE_ENABLED) &&
>  		   (idle_states & OPAL_PM_LOSE_FULL_CONTEXT)) {
> -- 
> 2.15.0
> 
