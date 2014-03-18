Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 6A3742C009E
 for <linuxppc-dev@ozlabs.org>; Wed, 19 Mar 2014 10:37:39 +1100 (EST)
Message-ID: <1395185847.30666.22.camel@pasglop>
Subject: Re: [PATCH v2 2/6] powernv:cpufreq: Create a
 powernv_cpu_to_core_mask() helper.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Date: Wed, 19 Mar 2014 10:37:27 +1100
In-Reply-To: <1394449861-8688-3-git-send-email-ego@linux.vnet.ibm.com>
References: <1394449861-8688-1-git-send-email-ego@linux.vnet.ibm.com>
 <1394449861-8688-3-git-send-email-ego@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, srivatsa.bhat@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-03-10 at 16:40 +0530, Gautham R. Shenoy wrote:
> From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
> 
> Create a helper method that computes the cpumask corresponding to the
> thread-siblings of a cpu. Use this for initializing the policy->cpus
> mask for a given cpu.
> 
> (Original code written by Srivatsa S. Bhat. Gautham moved this to a
> helper function!)

How does that differ from the existing entry in the sibling map  which
you can obtain with the helper cpu_sibling_mask() ? (You probably want
to *copy* the mask of course but I don't see the need of re-creating
one from scratch).

Also, this should have been CCed to the cpufreq mailing list and maybe
the relevant maintainer too.

Cheers,
Ben.

> Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
> Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> ---
>  drivers/cpufreq/powernv-cpufreq.c | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
> index ab1551f..4cad727 100644
> --- a/drivers/cpufreq/powernv-cpufreq.c
> +++ b/drivers/cpufreq/powernv-cpufreq.c
> @@ -115,6 +115,23 @@ static struct freq_attr *powernv_cpu_freq_attr[] = {
>  
>  /* Helper routines */
>  
> +/**
> + * Sets the bits corresponding to the thread-siblings of cpu in its core
> + * in 'cpus'.
> + */
> +static void powernv_cpu_to_core_mask(unsigned int cpu, cpumask_var_t cpus)
> +{
> +	int base, i;
> +
> +	base = cpu_first_thread_sibling(cpu);
> +
> +	for (i = 0; i < threads_per_core; i++) {
> +		cpumask_set_cpu(base + i, cpus);
> +	}
> +
> +	return;
> +}
> +
>  /* Access helpers to power mgt SPR */
>  
>  static inline unsigned long get_pmspr(unsigned long sprn)
> @@ -180,13 +197,8 @@ static int powernv_set_freq(cpumask_var_t cpus, unsigned int new_index)
>  
>  static int powernv_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  {
> -	int base, i;
> -
>  #ifdef CONFIG_SMP
> -	base = cpu_first_thread_sibling(policy->cpu);
> -
> -	for (i = 0; i < threads_per_core; i++)
> -		cpumask_set_cpu(base + i, policy->cpus);
> +	powernv_cpu_to_core_mask(policy->cpu, policy->cpus);
>  #endif
>  	policy->cpuinfo.transition_latency = 25000;
>  
