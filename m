Return-Path: <preeti@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C5E451A06BD
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 May 2015 19:40:06 +1000 (AEST)
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 0F10D14090B
 for <linuxppc-dev@ozlabs.org>; Tue,  5 May 2015 19:40:05 +1000 (AEST)
Received: from /spool/local
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Tue, 5 May 2015 03:40:03 -0600
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 65B141FF0023
 for <linuxppc-dev@ozlabs.org>; Tue,  5 May 2015 03:31:12 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t459ddU538797338
 for <linuxppc-dev@ozlabs.org>; Tue, 5 May 2015 02:39:39 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t459e12l020459
 for <linuxppc-dev@ozlabs.org>; Tue, 5 May 2015 03:40:01 -0600
Message-ID: <55488FED.4080909@linux.vnet.ibm.com>
Date: Tue, 05 May 2015 15:09:57 +0530
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 6/6] cpufreq: powernv: Restore cpu frequency to
 policy->cur on unthrottling
References: <1430729652-14813-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <1430729652-14813-7-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
In-Reply-To: <1430729652-14813-7-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-6
Cc: viresh.kumar@linaro.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/04/2015 02:24 PM, Shilpasri G Bhat wrote:
> If frequency is throttled due to OCC reset then cpus will be in Psafe
> frequency, so restore the frequency on all cpus to policy->cur when
> OCCs are active again. And if frequency is throttled due to Pmax
> capping then restore the frequency of all the cpus  in the chip on
> unthrottling.
> 
> Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
> ---
>  drivers/cpufreq/powernv-cpufreq.c | 31 +++++++++++++++++++++++++++++--
>  1 file changed, 29 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
> index 0a59d5b..b2915bc 100644
> --- a/drivers/cpufreq/powernv-cpufreq.c
> +++ b/drivers/cpufreq/powernv-cpufreq.c
> @@ -51,6 +51,7 @@ static struct chip {
>  	bool throttled;
>  	cpumask_t mask;
>  	struct work_struct throttle;
> +	bool restore;
>  } *chips;
> 
>  static int nr_chips;
> @@ -418,9 +419,29 @@ static struct notifier_block powernv_cpufreq_reboot_nb = {
>  void powernv_cpufreq_work_fn(struct work_struct *work)
>  {
>  	struct chip *chip = container_of(work, struct chip, throttle);
> +	unsigned int cpu;
> +	cpumask_var_t mask;
> 
>  	smp_call_function_any(&chip->mask,
>  			      powernv_cpufreq_throttle_check, NULL, 0);
> +
> +	if (!chip->restore)
> +		return;
> +
> +	chip->restore = false;
> +	cpumask_copy(mask, &chip->mask);
> +	for_each_cpu_and(cpu, mask, cpu_online_mask) {
> +		int index, tcpu;
> +		struct cpufreq_policy policy;
> +
> +		cpufreq_get_policy(&policy, cpu);
> +		cpufreq_frequency_table_target(&policy, policy.freq_table,
> +					       policy.cur,
> +					       CPUFREQ_RELATION_C, &index);
> +		powernv_cpufreq_target_index(&policy, index);
> +		for_each_cpu(tcpu, policy.cpus)
> +			cpumask_clear_cpu(tcpu, mask);
> +	}
>  }
> 
>  static char throttle_reason[][30] = {
> @@ -473,8 +494,10 @@ static int powernv_cpufreq_occ_msg(struct notifier_block *nb,
>  			throttled = false;
>  			pr_info("OCC: Active\n");
> 
> -			for (i = 0; i < nr_chips; i++)
> +			for (i = 0; i < nr_chips; i++) {
> +				chips[i].restore = true;
>  				schedule_work(&chips[i].throttle);
> +			}
> 
>  			return 0;
>  		}
> @@ -490,8 +513,11 @@ static int powernv_cpufreq_occ_msg(struct notifier_block *nb,
>  			return 0;
> 
>  		for (i = 0; i < nr_chips; i++)
> -			if (chips[i].id == chip_id)
> +			if (chips[i].id == chip_id) {
> +				if (!reason)
> +					chips[i].restore = true;
>  				schedule_work(&chips[i].throttle);
> +			}
>  	}
>  	return 0;
>  }
> @@ -545,6 +571,7 @@ static int init_chip_info(void)
>  		chips[i].throttled = false;
>  		cpumask_copy(&chips[i].mask, cpumask_of_node(chip[i]));
>  		INIT_WORK(&chips[i].throttle, powernv_cpufreq_work_fn);
> +		chips[i].restore = false;
>  	}
> 
>  	return 0;
> 

Reviewed-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
