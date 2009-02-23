Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DC5ADDDEDD
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Feb 2009 14:54:35 +1100 (EST)
Subject: Re: [patch] powerpc: estimate G5 cpufreq transition latency
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nick Piggin <npiggin@suse.de>
In-Reply-To: <20090219170741.GI1747@wotan.suse.de>
References: <20090219170741.GI1747@wotan.suse.de>
Content-Type: text/plain
Date: Mon, 23 Feb 2009 14:54:28 +1100
Message-Id: <1235361268.8805.227.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2009-02-19 at 18:07 +0100, Nick Piggin wrote:
> Setting G5's cpu frequency transition latency to CPUFREQ_ETERNAL stops
> ondemand governor from working. I measured the latency using sched_clock
> and haven't seen much higher than 11000ns, so I set this to 12000ns for
> my configuration. Possibly other configurations will be different?
> Ideally the generic code would be able to measure it in case the platform
> does not provide it.
> 
> But this simple patch at least makes it throttle again.
> 
> Signed-off-by: Nick Piggin <npiggin@suse.de>
> ---

Oh well, I've never used ondemand but some userspace stuff instead :-)

No objection appart from the change to drivers/cpufreq/cpufreq.c which
should be in a separate patch to whoever maintains that code :-)

Cheers,
Ben.

> Index: linux-2.6/arch/powerpc/platforms/powermac/cpufreq_64.c
> ===================================================================
> --- linux-2.6.orig/arch/powerpc/platforms/powermac/cpufreq_64.c	2009-02-20 01:42:41.000000000 +1100
> +++ linux-2.6/arch/powerpc/platforms/powermac/cpufreq_64.c	2009-02-20 01:50:15.000000000 +1100
> @@ -86,6 +86,7 @@
>  
>  static DEFINE_MUTEX(g5_switch_mutex);
>  
> +static unsigned long transition_latency;
>  
>  #ifdef CONFIG_PMAC_SMU
>  
> @@ -357,7 +358,7 @@
>  
>  static int g5_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  {
> -	policy->cpuinfo.transition_latency = CPUFREQ_ETERNAL;
> +	policy->cpuinfo.transition_latency = transition_latency;
>  	policy->cur = g5_cpu_freqs[g5_query_freq()].frequency;
>  	/* secondary CPUs are tied to the primary one by the
>  	 * cpufreq core if in the secondary policy we tell it that
> @@ -500,6 +501,7 @@
>  	g5_cpu_freqs[1].frequency = max_freq/2;
>  
>  	/* Set callbacks */
> +	transition_latency = 12000;
>  	g5_switch_freq = g5_scom_switch_freq;
>  	g5_query_freq = g5_scom_query_freq;
>  	freq_method = "SCOM";
> @@ -675,6 +677,7 @@
>  	g5_cpu_freqs[1].frequency = min_freq;
>  
>  	/* Set callbacks */
> +	transition_latency = CPUFREQ_ETERNAL;
>  	g5_switch_volt = g5_pfunc_switch_volt;
>  	g5_switch_freq = g5_pfunc_switch_freq;
>  	g5_query_freq = g5_pfunc_query_freq;
> Index: linux-2.6/drivers/cpufreq/cpufreq.c
> ===================================================================
> --- linux-2.6.orig/drivers/cpufreq/cpufreq.c	2009-02-20 01:42:43.000000000 +1100
> +++ linux-2.6/drivers/cpufreq/cpufreq.c	2009-02-20 01:50:15.000000000 +1100
> @@ -1559,9 +1559,11 @@
>  		else {
>  			printk(KERN_WARNING "%s governor failed, too long"
>  			       " transition latency of HW, fallback"
> -			       " to %s governor\n",
> +			       " to %s governor (latency=%lld max=%lld)\n",
>  			       policy->governor->name,
> -			       gov->name);
> +			       gov->name,
> +			       policy->cpuinfo.transition_latency,
> +			       policy->governor->max_transition_latency);
>  			policy->governor = gov;
>  		}
>  	}
