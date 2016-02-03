Return-Path: <viresh.kumar@linaro.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 209701A0225
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Feb 2016 19:27:07 +1100 (AEDT)
Received: from mail-pf0-x22f.google.com (mail-pf0-x22f.google.com
 [IPv6:2607:f8b0:400e:c00::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 670D8140BCB
 for <linuxppc-dev@ozlabs.org>; Wed,  3 Feb 2016 19:27:05 +1100 (AEDT)
Received: by mail-pf0-x22f.google.com with SMTP id o185so10081947pfb.1
 for <linuxppc-dev@ozlabs.org>; Wed, 03 Feb 2016 00:27:05 -0800 (PST)
Date: Wed, 3 Feb 2016 13:57:00 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
 rjw@rjwysocki.net, linux-pm@vger.kernel.org, pc@us.ibm.com,
 anton@samba.org, ego@linux.vnet.ibm.com, shreyas@linux.vnet.ibm.com,
 bsingharora@gmail.com, mpe@ellerman.id.au, linux-api@vger.kernel.org
Subject: Re: [PATCH v8 6/6] cpufreq: powernv: Add sysfs attributes to show
 throttle stats
Message-ID: <20160203082700.GZ31828@vireshk>
References: <1454442102-1229-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <1454442102-1229-7-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1454442102-1229-7-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03-02-16, 01:11, Shilpasri G Bhat wrote:
>  static int init_chip_info(void)
>  {
>  	unsigned int chip[256];
> -	unsigned int cpu, i;
> +	unsigned int cpu;
>  	unsigned int prev_chip_id = UINT_MAX;
>  	cpumask_t cpu_mask;
> -	int ret = -ENOMEM;
> +	int i, j, ret = -ENOMEM;
>  
>  	core_to_chip_map = kcalloc(cpu_nr_cores(), sizeof(unsigned int),
>  				   GFP_KERNEL);
> @@ -583,12 +711,51 @@ static int init_chip_info(void)
>  		goto free_chip_map;
>  
>  	for (i = 0; i < nr_chips; i++) {
> +		char name[10];
> +
>  		chips[i].id = chip[i];
>  		cpumask_copy(&chips[i].mask, cpumask_of_node(chip[i]));
>  		INIT_WORK(&chips[i].throttle, powernv_cpufreq_work_fn);
> +
> +		for (j = 0; j <= OCC_MAX_THROTTLE_STATUS; j++) {
> +			chips[i].reason[j] =
> +			     kcalloc(powernv_pstate_info.nr_pstates,
> +				     sizeof(int), GFP_KERNEL);
> +			if (!chips[i].reason[j]) {
> +				ret = -ENOMEM;
> +				goto free_chip;
> +			}
> +		}
> +
> +		snprintf(name, sizeof(name), "chip%d", chips[i].id);
> +		ret = kobject_init_and_add(&chips[i].kobj,
> +					   get_ktype(cpufreq_global_kobject),

Sorry but why do you need to create a kobject here ? A simple
sysfs_create_group() can create groups (directories) for you.

> +					   cpufreq_global_kobject, name);
> +		if (ret)
> +			goto free_chip;
> +
> +		ret = sysfs_create_group(&chips[i].kobj, &throttle_stat_group);
> +		if (ret) {
> +			pr_info("Chip %d failed to create throttle sysfs group\n",
> +				chips[i].id);
> +			goto free_kobject;
> +		}
>  	}

-- 
viresh
