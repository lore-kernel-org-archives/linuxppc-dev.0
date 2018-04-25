Return-Path: <viresh.kumar@linaro.org>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40W9F63NH0zDrDT
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Apr 2018 16:25:57 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id j5so14310744pfh.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Apr 2018 23:25:57 -0700 (PDT)
Date: Wed, 25 Apr 2018 11:55:52 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Cc: rjw@rjwysocki.net, benh@kernel.crashing.org, mpe@ellerman.id.au,
 linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, svaidy@linux.vnet.ibm.com
Subject: Re: [PATCH] cpufreq: powernv: Remove global pstate ramp-down timer
 in POWER9
Message-ID: <20180425062552.udhulffnd7gq564j@vireshk-i7>
References: <1524636895-27185-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1524636895-27185-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 25-04-18, 11:44, Shilpasri G Bhat wrote:
> POWER9 doesnot support global pstate requests for the chip. So remove
> the timer logic which slowly ramps down the global pstate in P9
> platforms.
> 
> Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
> ---
>  drivers/cpufreq/powernv-cpufreq.c | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
> index 0591874..71f8682 100644
> --- a/drivers/cpufreq/powernv-cpufreq.c
> +++ b/drivers/cpufreq/powernv-cpufreq.c
> @@ -750,8 +750,13 @@ static int powernv_cpufreq_target_index(struct cpufreq_policy *policy,
>  
>  	cur_msec = jiffies_to_msecs(get_jiffies_64());
>  
> -	spin_lock(&gpstates->gpstate_lock);
>  	freq_data.pstate_id = idx_to_pstate(new_index);
> +	if (!gpstates) {
> +		freq_data.gpstate_id = freq_data.pstate_id;
> +		goto no_gpstate;
> +	}
> +
> +	spin_lock(&gpstates->gpstate_lock);
>  
>  	if (!gpstates->last_sampled_time) {
>  		gpstate_idx = new_index;
> @@ -801,6 +806,7 @@ static int powernv_cpufreq_target_index(struct cpufreq_policy *policy,
>  
>  	spin_unlock(&gpstates->gpstate_lock);
>  
> +no_gpstate:
>  	/*
>  	 * Use smp_call_function to send IPI and execute the
>  	 * mtspr on target CPU.  We could do that without IPI
> @@ -835,6 +841,13 @@ static int powernv_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  		kernfs_put(kn);
>  	}
>  
> +	policy->freq_table = powernv_freqs;
> +	policy->fast_switch_possible = true;
> +
> +	if (pvr_version_is(PVR_POWER9))
> +		return 0;
> +
> +	/* Initialise Gpstate ramp-down timer only on POWER8 */
>  	gpstates =  kzalloc(sizeof(*gpstates), GFP_KERNEL);
>  	if (!gpstates)
>  		return -ENOMEM;
> @@ -849,15 +862,14 @@ static int powernv_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  				msecs_to_jiffies(GPSTATE_TIMER_INTERVAL);
>  	spin_lock_init(&gpstates->gpstate_lock);
>  
> -	policy->freq_table = powernv_freqs;
> -	policy->fast_switch_possible = true;
>  	return 0;
>  }
>  
>  static int powernv_cpufreq_cpu_exit(struct cpufreq_policy *policy)
>  {
>  	/* timer is deleted in cpufreq_cpu_stop() */
> -	kfree(policy->driver_data);
> +	if (policy->driver_data)
> +		kfree(policy->driver_data);
>  
>  	return 0;
>  }
> @@ -990,7 +1002,8 @@ static void powernv_cpufreq_stop_cpu(struct cpufreq_policy *policy)
>  	freq_data.pstate_id = idx_to_pstate(powernv_pstate_info.min);
>  	freq_data.gpstate_id = idx_to_pstate(powernv_pstate_info.min);
>  	smp_call_function_single(policy->cpu, set_pstate, &freq_data, 1);
> -	del_timer_sync(&gpstates->timer);
> +	if (gpstates)
> +		del_timer_sync(&gpstates->timer);
>  }
>  
>  static unsigned int powernv_fast_switch(struct cpufreq_policy *policy,

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
