Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40WHvr42jCzDrDT
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Apr 2018 21:26:32 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id g14so14952227pfh.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Apr 2018 04:26:32 -0700 (PDT)
Date: Wed, 25 Apr 2018 21:26:13 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Cc: rjw@rjwysocki.net, viresh.kumar@linaro.org, benh@kernel.crashing.org,
 mpe@ellerman.id.au, linux-pm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 ppaidipe@linux.vnet.ibm.com, svaidy@linux.vnet.ibm.com,
 <stable@vger.kernel.org>
Subject: Re: [PATCH V3] cpufreq: powernv: Fix the hardlockup by synchronus
 smp_call in timer interrupt
Message-ID: <20180425212613.1fc2c468@roar.ozlabs.ibm.com>
In-Reply-To: <1524653971-4919-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
References: <1524653971-4919-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
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

On Wed, 25 Apr 2018 16:29:31 +0530
Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com> wrote:

> gpstate_timer_handler() uses synchronous smp_call to set the pstate
> on the requested core. This causes the below hard lockup:
> 
> [c000003fe566b320] [c0000000001d5340] smp_call_function_single+0x110/0x180 (unreliable)
> [c000003fe566b390] [c0000000001d55e0] smp_call_function_any+0x180/0x250
> [c000003fe566b3f0] [c000000000acd3e8] gpstate_timer_handler+0x1e8/0x580
> [c000003fe566b4a0] [c0000000001b46b0] call_timer_fn+0x50/0x1c0
> [c000003fe566b520] [c0000000001b4958] expire_timers+0x138/0x1f0
> [c000003fe566b590] [c0000000001b4bf8] run_timer_softirq+0x1e8/0x270
> [c000003fe566b630] [c000000000d0d6c8] __do_softirq+0x158/0x3e4
> [c000003fe566b710] [c000000000114be8] irq_exit+0xe8/0x120
> [c000003fe566b730] [c000000000024d0c] timer_interrupt+0x9c/0xe0
> [c000003fe566b760] [c000000000009014] decrementer_common+0x114/0x120
> -- interrupt: 901 at doorbell_global_ipi+0x34/0x50
> LR = arch_send_call_function_ipi_mask+0x120/0x130
> [c000003fe566ba50] [c00000000004876c]
> arch_send_call_function_ipi_mask+0x4c/0x130
> [c000003fe566ba90] [c0000000001d59f0] smp_call_function_many+0x340/0x450
> [c000003fe566bb00] [c000000000075f18] pmdp_invalidate+0x98/0xe0
> [c000003fe566bb30] [c0000000003a1120] change_huge_pmd+0xe0/0x270
> [c000003fe566bba0] [c000000000349278] change_protection_range+0xb88/0xe40
> [c000003fe566bcf0] [c0000000003496c0] mprotect_fixup+0x140/0x340
> [c000003fe566bdb0] [c000000000349a74] SyS_mprotect+0x1b4/0x350
> [c000003fe566be30] [c00000000000b184] system_call+0x58/0x6c
> 
> One way to avoid this is removing the smp-call. We can ensure that the timer
> always runs on one of the policy-cpus. If the timer gets migrated to a
> cpu outside the policy then re-queue it back on the policy->cpus. This way
> we can get rid of the smp-call which was being used to set the pstate
> on the policy->cpus.
> 
> Fixes: 7bc54b652f13 (timers, cpufreq/powernv: Initialize the gpstate timer as pinned)
> Cc: <stable@vger.kernel.org>        [4.8+]
> Reported-by: Nicholas Piggin <npiggin@gmail.com>
> Reported-by: Pridhiviraj Paidipeddi <ppaidipe@linux.vnet.ibm.com>
> Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>

Thanks, this looks good to me. I don't know the code though, so

Acked-by: Nicholas Piggin <npiggin@gmail.com>

> ---
> Changes from V2:
> - Remove the check for active policy while requeing the migrated timer
> Changes from V1:
> - Remove smp_call in the pstate handler.
> 
>  drivers/cpufreq/powernv-cpufreq.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
> index 71f8682..e368e1f 100644
> --- a/drivers/cpufreq/powernv-cpufreq.c
> +++ b/drivers/cpufreq/powernv-cpufreq.c
> @@ -679,6 +679,16 @@ void gpstate_timer_handler(struct timer_list *t)
>  
>  	if (!spin_trylock(&gpstates->gpstate_lock))
>  		return;

I still think it would be good to do something about the trylock failure.
It may be rare, but if it happens it could stop the timer and lead to
some rare unpredictable behaviour? Not for this patch, but while you're
looking at the code it would be good to consider it. Just queueing up
another timer seems like it should be enough.

> +	/*
> +	 * If the timer has migrated to the different cpu then bring
> +	 * it back to one of the policy->cpus
> +	 */
> +	if (!cpumask_test_cpu(raw_smp_processor_id(), policy->cpus)) {
> +		gpstates->timer.expires = jiffies + msecs_to_jiffies(1);
> +		add_timer_on(&gpstates->timer, cpumask_first(policy->cpus));
> +		spin_unlock(&gpstates->gpstate_lock);
> +		return;
> +	}

Really small nitpick, but you could use cpumask_any there.

Thanks,
Nick


>  
>  	/*
>  	 * If PMCR was last updated was using fast_swtich then
> @@ -718,10 +728,8 @@ void gpstate_timer_handler(struct timer_list *t)
>  	if (gpstate_idx != gpstates->last_lpstate_idx)
>  		queue_gpstate_timer(gpstates);
>  
> +	set_pstate(&freq_data);
>  	spin_unlock(&gpstates->gpstate_lock);
> -
> -	/* Timer may get migrated to a different cpu on cpu hot unplug */
> -	smp_call_function_any(policy->cpus, set_pstate, &freq_data, 1);
>  }
