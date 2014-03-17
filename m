Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 2ACF72C00A0
 for <linuxppc-dev@ozlabs.org>; Mon, 17 Mar 2014 20:07:54 +1100 (EST)
Received: from /spool/local
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Mon, 17 Mar 2014 03:07:52 -0600
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id A018C3E4004F
 for <linuxppc-dev@ozlabs.org>; Mon, 17 Mar 2014 03:07:49 -0600 (MDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp08026.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s2H97Hfo10027324
 for <linuxppc-dev@ozlabs.org>; Mon, 17 Mar 2014 10:07:17 +0100
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s2H97nOo003328
 for <linuxppc-dev@ozlabs.org>; Mon, 17 Mar 2014 03:07:49 -0600
Message-ID: <5326BA82.3010004@linux.vnet.ibm.com>
Date: Mon, 17 Mar 2014 14:34:02 +0530
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
MIME-Version: 1.0
To: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 3/6] powernv, cpufreq:Add per-core locking to serialize
 frequency transitions
References: <1394449861-8688-1-git-send-email-ego@linux.vnet.ibm.com>
 <1394449861-8688-4-git-send-email-ego@linux.vnet.ibm.com>
In-Reply-To: <1394449861-8688-4-git-send-email-ego@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, srivatsa.bhat@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/10/2014 04:40 PM, Gautham R. Shenoy wrote:
> From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
> 
> On POWER systems, the CPU frequency is controlled at a core-level and
> hence we need to serialize so that only one of the threads in the core
> switches the core's frequency at a time.
> 
> Using a global mutex lock would needlessly serialize _all_ frequency
> transitions in the system (across all cores). So introduce per-core
> locking to enable finer-grained synchronization and thereby enhance
> the speed and responsiveness of the cpufreq driver to varying workload
> demands.
> 
> The design of per-core locking is very simple and straight-forward: we
> first define a Per-CPU lock and use the ones that belongs to the first
> thread sibling of the core.
> 
> cpu_first_thread_sibling() macro is used to find the *common* lock for
> all thread siblings belonging to a core.
> 
> Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
> Signed-off-by: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
> Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> ---
>  drivers/cpufreq/powernv-cpufreq.c | 21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
> index 4cad727..4c2e8ca 100644
> --- a/drivers/cpufreq/powernv-cpufreq.c
> +++ b/drivers/cpufreq/powernv-cpufreq.c
> @@ -24,8 +24,15 @@
>  #include <linux/of.h>
>  #include <asm/cputhreads.h>
>  
> -/* FIXME: Make this per-core */
> -static DEFINE_MUTEX(freq_switch_mutex);
> +/* Per-Core locking for frequency transitions */
> +static DEFINE_PER_CPU(struct mutex, freq_switch_lock);
> +
> +#define lock_core_freq(cpu)				\
> +			mutex_lock(&per_cpu(freq_switch_lock,\
> +				cpu_first_thread_sibling(cpu)));
> +#define unlock_core_freq(cpu)				\
> +			mutex_unlock(&per_cpu(freq_switch_lock,\
> +				cpu_first_thread_sibling(cpu)));
>  
>  #define POWERNV_MAX_PSTATES	256
>  
> @@ -233,7 +240,7 @@ static int powernv_cpufreq_target(struct cpufreq_policy *policy,
>  	freqs.new = powernv_freqs[new_index].frequency;
>  	freqs.cpu = policy->cpu;
>  
> -	mutex_lock(&freq_switch_mutex);
> +	lock_core_freq(policy->cpu);
>  	cpufreq_notify_transition(policy, &freqs, CPUFREQ_PRECHANGE);
>  
>  	pr_debug("setting frequency for cpu %d to %d kHz index %d pstate %d",
> @@ -245,7 +252,7 @@ static int powernv_cpufreq_target(struct cpufreq_policy *policy,
>  	rc = powernv_set_freq(policy->cpus, new_index);
>  
>  	cpufreq_notify_transition(policy, &freqs, CPUFREQ_POSTCHANGE);
> -	mutex_unlock(&freq_switch_mutex);
> +	unlock_core_freq(policy->cpu);
>  
>  	return rc;
>  }
> @@ -262,7 +269,7 @@ static struct cpufreq_driver powernv_cpufreq_driver = {
>  
>  static int __init powernv_cpufreq_init(void)
>  {
> -	int rc = 0;
> +	int cpu, rc = 0;
>  
>  	/* Discover pstates from device tree and init */
>  
> @@ -272,6 +279,10 @@ static int __init powernv_cpufreq_init(void)
>  		pr_info("powernv-cpufreq disabled\n");
>  		return rc;
>  	}
> +	/* Init per-core mutex */
> +	for_each_possible_cpu(cpu) {
> +		mutex_init(&per_cpu(freq_switch_lock, cpu));
> +	}
>  
>  	rc = cpufreq_register_driver(&powernv_cpufreq_driver);
>  	return rc;
> 
Reviewed-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
