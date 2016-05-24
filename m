Return-Path: <ego@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rDWkP5rH1zDqDv
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 May 2016 20:25:01 +1000 (AEST)
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Tue, 24 May 2016 04:24:59 -0600
Date: Tue, 24 May 2016 15:54:49 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, paulus@ozlabs.org,
 linux-kernel@vger.kernel.org, mikey@neuling.org, ego@linux.vnet.ibm.com
Subject: Re: [PATCH v3 7/9] powerpc/powernv: Add platform support for stop
 instruction
Message-ID: <20160524102449.GE12860@in.ibm.com>
Reply-To: ego@linux.vnet.ibm.com
References: <1464016722-7488-1-git-send-email-shreyas@linux.vnet.ibm.com>
 <1464016722-7488-8-git-send-email-shreyas@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1464016722-7488-8-git-send-email-shreyas@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Shreyas,

On Mon, May 23, 2016 at 08:48:40PM +0530, Shreyas B. Prabhu wrote:
> @@ -412,7 +517,8 @@ subcore_state_restored:
>  first_thread_in_core:
> 
>  	/*
> -	 * First thread in the core waking up from fastsleep. It needs to
> +	 * First thread in the core waking up from any state which can cause
> +	 * partial or complete hypervisor state loss. It needs to
>  	 * call the fastsleep workaround code if the platform requires it.
>  	 * Call it unconditionally here. The below branch instruction will
>  	 * be patched out when the idle states are discovered if platform

Please update the comment to 

"The below branch instruction will be patched out if the platform does
not have fastsleep or does not require the workaround. Patching will
be performed during the discovery of idle-states."

> @@ -423,8 +529,10 @@ pnv_fastsleep_workaround_at_exit:
>  	b	fastsleep_workaround_at_exit
> 
>  timebase_resync:
> -	/* Do timebase resync if we are waking up from sleep. Use cr3 value
> -	 * set in exceptions-64s.S */
> +	/*
> +	 * Use cr3 which indicates that we are waking up with atleast partial
> +	 * hypervisor state loss to determine if TIMEBASE RESYNC is needed.
> +	 */
>  	ble	cr3,clear_lock
>  	/* Time base re-sync */
>  	li	r0,OPAL_RESYNC_TIMEBASE


[..snip..]
> @@ -264,6 +275,32 @@ static int __init pnv_init_idle_states(void)
>  		goto out_free;
>  	}
> 
> +	if (cpu_has_feature(CPU_FTR_ARCH_300)) {
> +		psscr_val = kcalloc(dt_idle_states, sizeof(*psscr_val),
> +					GFP_KERNEL);
> +		if (!psscr_val)
> +			goto out_free;
> +		if (of_property_read_u64_array(power_mgt,
> +			"ibm,cpu-idle-state-psscr",
> +			psscr_val, dt_idle_states)) {
> +			pr_warn("cpuidle-powernv: missing ibm,cpu-idle-states-psscr in DT\n");
> +			goto out_free_psscr;
> +		}
> +
> +		/*
> +		 * Set pnv_first_deep_stop_state to the first stop level
> +		 * to cause hypervisor state loss
> +		 */
> +		pnv_first_deep_stop_state = 0xF;
  		
#define MAX_STOP_STATES	0xF ?


> +		for (i = 0; i < dt_idle_states; i++) {
> +			u64 psscr_rl = psscr_val[i] & PSSCR_RL_MASK;
> +
> +			if ((flags[i] & OPAL_PM_LOSE_FULL_CONTEXT) &&
> +			     (pnv_first_deep_stop_state > psscr_rl))
> +				pnv_first_deep_stop_state = psscr_rl;
> +		}
> +	}
> +
>  	for (i = 0; i < dt_idle_states; i++)
>  		supported_cpuidle_states |= flags[i];
> 
