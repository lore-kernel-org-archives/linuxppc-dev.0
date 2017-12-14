Return-Path: <viresh.kumar@linaro.org>
Received: from mail-pg0-x233.google.com (mail-pg0-x233.google.com
 [IPv6:2607:f8b0:400e:c05::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yy1Bw2gcKzDsQZ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Dec 2017 15:42:46 +1100 (AEDT)
Received: by mail-pg0-x233.google.com with SMTP id o2so2673040pgc.8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Dec 2017 20:42:46 -0800 (PST)
Date: Thu, 14 Dec 2017 10:12:39 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Abhishek Goel <huntbag@linux.vnet.ibm.com>, ego@linux.vnet.ibm.com
Cc: rjw@rjwysocki.net, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, linux-pm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: powernv: Add support of frequency domain
Message-ID: <20171214044239.GU3322@vireshk-i7>
References: <20171213081937.16376-1-huntbag@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171213081937.16376-1-huntbag@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

+ Gautham,

@Gautham: Can you please help reviewing this one ?

On 13-12-17, 13:49, Abhishek Goel wrote:
> @@ -693,6 +746,8 @@ static int powernv_cpufreq_target_index(struct cpufreq_policy *policy,
>  {
>  	struct powernv_smp_call_data freq_data;
>  	unsigned int cur_msec, gpstate_idx;
> +	cpumask_t temp;
> +	u32 cpu;
>  	struct global_pstate_info *gpstates = policy->driver_data;
>  
>  	if (unlikely(rebooting) && new_index != get_nominal_index())
> @@ -761,24 +816,48 @@ static int powernv_cpufreq_target_index(struct cpufreq_policy *policy,
>  	spin_unlock(&gpstates->gpstate_lock);
>  
>  	/*
> -	 * Use smp_call_function to send IPI and execute the
> -	 * mtspr on target CPU.  We could do that without IPI
> -	 * if current CPU is within policy->cpus (core)
> +	 * Use smp_call_function to send IPI and execute the mtspr on CPU.
> +	 * This needs to be done on every core of the policy

Why on each CPU ?

>  	 */
> -	smp_call_function_any(policy->cpus, set_pstate, &freq_data, 1);
> +	cpumask_copy(&temp, policy->cpus);
> +
> +	while (!cpumask_empty(&temp)) {
> +		cpu = cpumask_first(&temp);
> +		smp_call_function_any(cpu_sibling_mask(cpu),
> +					set_pstate, &freq_data, 1);
> +		cpumask_andnot(&temp, &temp, cpu_sibling_mask(cpu));
> +	}
> +
>  	return 0;
>  }

-- 
viresh
