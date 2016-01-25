Return-Path: <viresh.kumar@linaro.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 464BB1A02E6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jan 2016 16:53:59 +1100 (AEDT)
Received: from mail-pa0-x22f.google.com (mail-pa0-x22f.google.com
 [IPv6:2607:f8b0:400e:c03::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B55E51402A1
 for <linuxppc-dev@ozlabs.org>; Mon, 25 Jan 2016 16:53:58 +1100 (AEDT)
Received: by mail-pa0-x22f.google.com with SMTP id cy9so75380889pac.0
 for <linuxppc-dev@ozlabs.org>; Sun, 24 Jan 2016 21:53:57 -0800 (PST)
Date: Mon, 25 Jan 2016 11:23:53 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
 rjw@rjwysocki.net, linux-pm@vger.kernel.org, pc@us.ibm.com,
 anton@samba.org, ego@linux.vnet.ibm.com, shreyas@linux.vnet.ibm.com
Subject: Re: [PATCH v6 2/5] cpufreq: powernv: Remove cpu_to_chip_id() from
 hot-path
Message-ID: <20160125055353.GB3183@vireshk>
References: <1453447145-17722-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <1453447145-17722-3-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1453447145-17722-3-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 22-01-16, 12:49, Shilpasri G Bhat wrote:
> cpu_to_chip_id() does a DT walk through to find out the chip id by
> taking a contended device tree lock. This adds an unnecessary overhead
> in a hot path. So instead of calling cpu_to_chip_id() everytime cache
> the chip ids for all cores in the array 'core_to_chip_map' and use it
> in the hotpath.
> 
> Reported-by: Anton Blanchard <anton@samba.org>
> Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
> Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> ---
> No changes from v5.
> 
> Changes from v4:
> - Taken care of Shreyas's comments to add a core_to_chip_map array to
>   store the chip id.
> 
>  drivers/cpufreq/powernv-cpufreq.c | 24 +++++++++++++++++++++---
>  1 file changed, 21 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
> index 140c75f..6f186dc 100644
> --- a/drivers/cpufreq/powernv-cpufreq.c
> +++ b/drivers/cpufreq/powernv-cpufreq.c
> @@ -43,6 +43,7 @@
>  
>  static struct cpufreq_frequency_table powernv_freqs[POWERNV_MAX_PSTATES+1];
>  static bool rebooting, throttled, occ_reset;
> +static unsigned int *core_to_chip_map;
>  
>  static struct chip {
>  	unsigned int id;
> @@ -313,13 +314,14 @@ static inline unsigned int get_nominal_index(void)
>  static void powernv_cpufreq_throttle_check(void *data)
>  {
>  	unsigned int cpu = smp_processor_id();
> +	unsigned int chip_id = core_to_chip_map[cpu_core_index_of_thread(cpu)];
>  	unsigned long pmsr;
>  	int pmsr_pmax, i;
>  
>  	pmsr = get_pmspr(SPRN_PMSR);
>  
>  	for (i = 0; i < nr_chips; i++)
> -		if (chips[i].id == cpu_to_chip_id(cpu))
> +		if (chips[i].id == chip_id)
>  			break;
>  
>  	/* Check for Pmax Capping */
> @@ -559,19 +561,29 @@ static int init_chip_info(void)
>  	unsigned int chip[256];
>  	unsigned int cpu, i;
>  	unsigned int prev_chip_id = UINT_MAX;
> +	cpumask_t cpu_mask;
> +	int ret = -ENOMEM;
>  
> -	for_each_possible_cpu(cpu) {
> +	cpumask_copy(&cpu_mask, cpu_possible_mask);

Shouldn't this copy be done after the following check, so that we
don't do that on failures ?

> +	core_to_chip_map = kcalloc(cpu_nr_cores(), sizeof(unsigned int),
> +				   GFP_KERNEL);
> +	if (!core_to_chip_map)
> +		goto out;
> +
> +	for_each_cpu(cpu, &cpu_mask) {
>  		unsigned int id = cpu_to_chip_id(cpu);
>  
>  		if (prev_chip_id != id) {
>  			prev_chip_id = id;
>  			chip[nr_chips++] = id;
>  		}
> +		core_to_chip_map[cpu_core_index_of_thread(cpu)] = id;
> +		cpumask_andnot(&cpu_mask, &cpu_mask, cpu_sibling_mask(cpu));
>  	}
>  
>  	chips = kmalloc_array(nr_chips, sizeof(struct chip), GFP_KERNEL);
>  	if (!chips)
> -		return -ENOMEM;
> +		goto free_chip_map;
>  
>  	for (i = 0; i < nr_chips; i++) {
>  		chips[i].id = chip[i];
> @@ -582,6 +594,10 @@ static int init_chip_info(void)
>  	}
>  
>  	return 0;
> +free_chip_map:
> +	kfree(core_to_chip_map);
> +out:
> +	return ret;
>  }
>  
>  static int __init powernv_cpufreq_init(void)
> @@ -615,6 +631,8 @@ static void __exit powernv_cpufreq_exit(void)
>  	unregister_reboot_notifier(&powernv_cpufreq_reboot_nb);
>  	opal_message_notifier_unregister(OPAL_MSG_OCC,
>  					 &powernv_cpufreq_opal_nb);
> +	kfree(chips);

Yeah, this is an important fix, but it shouldn't be part of this
patch, isn't it ?

> +	kfree(core_to_chip_map);
>  	cpufreq_unregister_driver(&powernv_cpufreq_driver);
>  }
>  module_exit(powernv_cpufreq_exit);
> -- 
> 1.9.3

-- 
viresh
