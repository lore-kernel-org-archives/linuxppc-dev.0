Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id DC76E2C00B9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Feb 2014 19:18:47 +1100 (EST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Tue, 11 Feb 2014 13:48:44 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 264F63940060
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Feb 2014 13:48:40 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s1B8If2T5505486
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Feb 2014 13:48:42 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s1B8IdGT013256
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Feb 2014 13:48:39 +0530
Message-ID: <52F9DC0C.1000705@linux.vnet.ibm.com>
Date: Tue, 11 Feb 2014 13:45:08 +0530
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Subject: Re: [PATCH v1 2/2] powernv, cpufreq: Add per-core locking to serialize
 frequency transitions
References: <20140211065757.21159.49689.stgit@drishya>
 <20140211070208.21159.86862.stgit@drishya>
In-Reply-To: <20140211070208.21159.86862.stgit@drishya>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org, Anton Blanchard <anton@samba.org>,
 "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Vaidy,

On 02/11/2014 12:32 PM, Vaidyanathan Srinivasan wrote:
> From: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
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
> ---
>  drivers/cpufreq/powernv-cpufreq.c |   21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
> index ea3b630..8240e90 100644
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
> @@ -219,7 +226,7 @@ static int powernv_cpufreq_target(struct cpufreq_policy *policy,
>  	freqs.new = powernv_freqs[new_index].frequency;
>  	freqs.cpu = policy->cpu;
> 
> -	mutex_lock(&freq_switch_mutex);
> +	lock_core_freq(policy->cpu);
>  	cpufreq_notify_transition(policy, &freqs, CPUFREQ_PRECHANGE);
> 
>  	pr_debug("setting frequency for cpu %d to %d kHz index %d pstate %d",
> @@ -231,7 +238,7 @@ static int powernv_cpufreq_target(struct cpufreq_policy *policy,
>  	rc = powernv_set_freq(policy->cpus, new_index);
> 
>  	cpufreq_notify_transition(policy, &freqs, CPUFREQ_POSTCHANGE);
> -	mutex_unlock(&freq_switch_mutex);
> +	unlock_core_freq(policy->cpu);
> 
>  	return rc;
>  }
> @@ -248,7 +255,7 @@ static struct cpufreq_driver powernv_cpufreq_driver = {
> 
>  static int __init powernv_cpufreq_init(void)
>  {
> -	int rc = 0;
> +	int cpu, rc = 0;
> 
>  	/* Discover pstates from device tree and init */
> 
> @@ -258,6 +265,10 @@ static int __init powernv_cpufreq_init(void)
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

This looks good to me.

Reviewed-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>

Thanks

Regards
Preeti U Murthy
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
