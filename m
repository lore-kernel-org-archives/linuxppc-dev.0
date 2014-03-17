Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 32B592C0098
 for <linuxppc-dev@ozlabs.org>; Mon, 17 Mar 2014 20:15:07 +1100 (EST)
Received: from /spool/local
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Mon, 17 Mar 2014 03:15:05 -0600
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id BFF4319D8036
 for <linuxppc-dev@ozlabs.org>; Mon, 17 Mar 2014 03:14:59 -0600 (MDT)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp08026.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with
 ESMTP id s2H9EUuZ9699752
 for <linuxppc-dev@ozlabs.org>; Mon, 17 Mar 2014 10:14:30 +0100
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s2H9F2SF005218
 for <linuxppc-dev@ozlabs.org>; Mon, 17 Mar 2014 03:15:02 -0600
Message-ID: <5326BC2E.7060503@linux.vnet.ibm.com>
Date: Mon, 17 Mar 2014 14:41:10 +0530
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
MIME-Version: 1.0
To: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 6/6] powernv:cpufreq: Implement the driver->get() method
References: <1394449861-8688-1-git-send-email-ego@linux.vnet.ibm.com>
 <1394449861-8688-7-git-send-email-ego@linux.vnet.ibm.com>
In-Reply-To: <1394449861-8688-7-git-send-email-ego@linux.vnet.ibm.com>
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

On 03/10/2014 04:41 PM, Gautham R. Shenoy wrote:
> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> 
> The current frequency of a cpu is reported through the sysfs file
> cpuinfo_cur_freq. This requires the driver to implement a
> "->get(unsigned int cpu)" method which will return the current
> operating frequency.
> 
> Implement a function named powernv_cpufreq_get() which reads the local
> pstate from the PMSR and returns the corresponding frequency.
> 
> Set the powernv_cpufreq_driver.get hook to powernv_cpufreq_get().
> 
> Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> ---
>  drivers/cpufreq/powernv-cpufreq.c | 48 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
> 
> diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
> index 183bbc4..6f3b6e1 100644
> --- a/drivers/cpufreq/powernv-cpufreq.c
> +++ b/drivers/cpufreq/powernv-cpufreq.c
> @@ -223,6 +223,53 @@ static inline void set_pmspr(unsigned long sprn, unsigned long val)
>  	BUG();
>  }
>  
> +/*
> + * Computes the current frequency on this cpu
> + * and stores the result in *ret_freq.
> + */
> +static void powernv_read_cpu_freq(void *ret_freq)
> +{
> +	unsigned long pmspr_val;
> +	s8 local_pstate_id;
> +	int *cur_freq, freq, pstate_id;
> +
> +	cur_freq = (int *)ret_freq;
> +	pmspr_val = get_pmspr(SPRN_PMSR);
> +
> +	/* The local pstate id corresponds bits 48..55 in the PMSR.
> +         * Note: Watch out for the sign! */
> +	local_pstate_id = (pmspr_val >> 48) & 0xFF;
> +	pstate_id = local_pstate_id;
> +
> +	freq = pstate_id_to_freq(pstate_id);
> +	pr_debug("cpu %d pmsr %lx pstate_id %d frequency %d \n",
> +		smp_processor_id(), pmspr_val, pstate_id, freq);
> +	*cur_freq = freq;
> +}
> +
> +/*
> + * Returns the cpu frequency as reported by the firmware for 'cpu'.
> + * This value is reported through the sysfs file cpuinfo_cur_freq.
> + */
> +unsigned int powernv_cpufreq_get(unsigned int cpu)
> +{
> +	int ret_freq;
> +	cpumask_var_t sibling_mask;
> +
> +	if (unlikely(!zalloc_cpumask_var(&sibling_mask, GFP_KERNEL))) {
> +		smp_call_function_single(cpu, powernv_read_cpu_freq,
> +					&ret_freq, 1);
> +		return ret_freq;
> +	}
> +
> +	powernv_cpu_to_core_mask(cpu, sibling_mask);
> +	smp_call_function_any(sibling_mask, powernv_read_cpu_freq,
> +			&ret_freq, 1);
> +
> +	free_cpumask_var(sibling_mask);
> +	return ret_freq;
> +}
> +
>  static void set_pstate(void *pstate)
>  {
>  	unsigned long val;
> @@ -309,6 +356,7 @@ static int powernv_cpufreq_target(struct cpufreq_policy *policy,
>  static struct cpufreq_driver powernv_cpufreq_driver = {
>  	.verify		= powernv_cpufreq_verify,
>  	.target		= powernv_cpufreq_target,
> +	.get		= powernv_cpufreq_get,
>  	.init		= powernv_cpufreq_cpu_init,
>  	.exit		= powernv_cpufreq_cpu_exit,
>  	.name		= "powernv-cpufreq",
> 
Reviewed-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
