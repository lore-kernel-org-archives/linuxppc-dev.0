Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tlFll1FnzzDw7K
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Dec 2016 15:29:22 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uBN4SaEF052707
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Dec 2016 23:29:20 -0500
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 by mx0a-001b2d01.pphosted.com with ESMTP id 27gueqaah3-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Dec 2016 23:29:20 -0500
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Thu, 22 Dec 2016 21:29:19 -0700
Date: Fri, 23 Dec 2016 09:59:10 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Cc: rjw@rjwysocki.net, viresh.kumar@linaro.org, ego@linux.vnet.ibm.com,
 akshay.adiga@linux.vnet.ibm.com, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 svaidy@linux.vnet.ibm.com
Subject: Re: [PATCH] cpufreq: powernv: Add boost files to export ultra-turbo
 frequencies
Reply-To: ego@linux.vnet.ibm.com
References: <1481886788-25324-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1481886788-25324-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Message-Id: <20161223042910.GC6433@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Shilpa,

On Fri, Dec 16, 2016 at 04:43:08PM +0530, Shilpasri G Bhat wrote:
> In P8+, Workload Optimized Frequency(WOF) provides the capability to
> boost the cpu frequency based on the utilization of the other cpus
> running in the chip. The On-Chip-Controller(OCC) firmware will control
> the achievability of these frequencies depending on the power headroom
> available in the chip. Currently the ultra-turbo frequencies provided
> by this feature are exported along with the turbo and sub-turbo
> frequencies as scaling_available_frequencies. This patch will export
> the ultra-turbo frequencies separately as scaling_boost_frequencies in
> WOF enabled systems. This patch will add the boost sysfs file which
> can be used to disable/enable ultra-turbo frequencies.
> 
> Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
> ---
>  drivers/cpufreq/powernv-cpufreq.c | 48 ++++++++++++++++++++++++++++++++++++---
>  1 file changed, 45 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
> index 37671b5..56dfd91 100644
> --- a/drivers/cpufreq/powernv-cpufreq.c
> +++ b/drivers/cpufreq/powernv-cpufreq.c
> @@ -144,6 +144,7 @@ enum throttle_reason_type {
>  	unsigned int max;
>  	unsigned int nominal;
>  	unsigned int nr_pstates;
> +	bool wof_enabled;
>  } powernv_pstate_info;
> 
>  /* Use following macros for conversions between pstate_id and index */
> @@ -203,6 +204,7 @@ static int init_powernv_pstates(void)
>  	const __be32 *pstate_ids, *pstate_freqs;
>  	u32 len_ids, len_freqs;
>  	u32 pstate_min, pstate_max, pstate_nominal;
> +	u32 pstate_turbo, pstate_ultra_turbo;
> 
>  	power_mgt = of_find_node_by_path("/ibm,opal/power-mgt");
>  	if (!power_mgt) {
> @@ -225,6 +227,25 @@ static int init_powernv_pstates(void)
>  		pr_warn("ibm,pstate-nominal not found\n");
>  		return -ENODEV;
>  	}
> +
> +	if (of_property_read_u32(power_mgt, "ibm,pstate-ultra-turbo",
> +				 &pstate_ultra_turbo)) {
> +		powernv_pstate_info.wof_enabled = false;
> +		goto next;
> +	}
> +
> +	if (of_property_read_u32(power_mgt, "ibm,pstate-turbo",
> +				 &pstate_turbo)) {
> +		powernv_pstate_info.wof_enabled = false;
> +		goto next;
> +	}
> +
> +	if (pstate_turbo == pstate_ultra_turbo)
> +		powernv_pstate_info.wof_enabled = false;
> +	else
> +		powernv_pstate_info.wof_enabled = true;
> +
> +next:
>  	pr_info("cpufreq pstate min %d nominal %d max %d\n", pstate_min,
>  		pstate_nominal, pstate_max);

Could you also print if ultra_turbo is enabled ?

> 
> @@ -268,6 +289,13 @@ static int init_powernv_pstates(void)
>  			powernv_pstate_info.nominal = i;
>  		else if (id == pstate_min)
>  			powernv_pstate_info.min = i;
> +
> +		if (powernv_pstate_info.wof_enabled && id == pstate_turbo) {

powernv_pstate_info.wof_enabled check is not required since we will
bail out of the loop below as j < powernv_pstate_info.max in case when
turbo = ultra-turbo or if ultra-turbo is not defined.

That said, it makes the code more readable so let us keep it.

> +			int j;
> +
> +			for (j = i - 1; j >= (int)powernv_pstate_info.max; j--)
> +				powernv_freqs[j].flags = CPUFREQ_BOOST_FREQ;
> +		}
> 
>  	/* End of list marker entry */
> @@ -305,9 +333,12 @@ static ssize_t cpuinfo_nominal_freq_show(struct cpufreq_policy *policy,
>  struct freq_attr cpufreq_freq_attr_cpuinfo_nominal_freq =
>  	__ATTR_RO(cpuinfo_nominal_freq);
> 
> +#define SCALING_BOOST_FREQS_ATTR_INDEX		2
> +
>  static struct freq_attr *powernv_cpu_freq_attr[] = {
>  	&cpufreq_freq_attr_scaling_available_freqs,
>  	&cpufreq_freq_attr_cpuinfo_nominal_freq,
> +	&cpufreq_freq_attr_scaling_boost_freqs,
>  	NULL,
>  };
> 
> @@ -1013,11 +1044,22 @@ static int __init powernv_cpufreq_init(void)
>  	register_reboot_notifier(&powernv_cpufreq_reboot_nb);
>  	opal_message_notifier_register(OPAL_MSG_OCC, &powernv_cpufreq_opal_nb);
> 
> +	if (powernv_pstate_info.wof_enabled)
> +		powernv_cpufreq_driver.boost_enabled = true;
> +	else
> +		powernv_cpu_freq_attr[SCALING_BOOST_FREQS_ATTR_INDEX] = NULL;
> +
>  	rc = cpufreq_register_driver(&powernv_cpufreq_driver);
> -	if (!rc)
> -		return 0;
> +	if (rc) {
> +		pr_info("Failed to register the cpufreq driver (%d)\n", rc);
> +		goto clean_notifiers;

cleanup_notifiers ?

> +	}
> 
> -	pr_info("Failed to register the cpufreq driver (%d)\n", rc);
> +	if (powernv_pstate_info.wof_enabled)
> +		cpufreq_enable_boost_support();
> +
> +	return 0;
> +clean_notifiers:
>  	unregister_all_notifiers();
>  	clean_chip_info();
>  out:
> -- 
> 1.8.3.1
> 

Looks good otherwise.
Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
