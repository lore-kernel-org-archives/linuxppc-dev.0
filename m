Return-Path: <viresh.kumar@linaro.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qTrDB6LnjzDq6X
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Mar 2016 22:33:14 +1100 (AEDT)
Received: from mail-pf0-x231.google.com (mail-pf0-x231.google.com
 [IPv6:2607:f8b0:400e:c00::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3qTrDB1FYzz9s4x
 for <linuxppc-dev@ozlabs.org>; Tue, 22 Mar 2016 22:33:13 +1100 (AEDT)
Received: by mail-pf0-x231.google.com with SMTP id u190so308301857pfb.3
 for <linuxppc-dev@ozlabs.org>; Tue, 22 Mar 2016 04:33:13 -0700 (PDT)
Date: Tue, 22 Mar 2016 17:03:07 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
 ego@linux.vnet.ibm.com, linux-pm@vger.kernel.org, rjw@rjwysocki.net,
 shreyas@linux.vnet.ibm.com, linux-api@vger.kernel.org
Subject: Re: [PATCH v12] cpufreq: powernv: Add sysfs attributes to show
 throttle stats
Message-ID: <20160322113307.GI5272@vireshk-i7>
References: <1458643717-2847-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1458643717-2847-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I really wanted to Ack this time, but you know I am nitpicking again :(

On 22-03-16, 16:18, Shilpasri G Bhat wrote:
>  static int powernv_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  {
> -	int base, i;
> +	int base, i, ret;
>  
>  	base = cpu_first_thread_sibling(policy->cpu);
>  
>  	for (i = 0; i < threads_per_core; i++)
>  		cpumask_set_cpu(base + i, policy->cpus);
>  
> +	if (!policy->driver_data) {

Declare ret here, as it is going to be used only within the if block.

> +		ret = sysfs_create_group(&policy->kobj, &throttle_attr_grp);
> +		if (ret) {
> +			pr_info("Failed to create throttle stats directory for cpu %d\n",
> +				policy->cpu);
> +			return ret;
> +		}
> +		/*
> +		 * policy->driver_data is used as a flag for one-time
> +		 * creation of throttle sysfs files.
> +		 */
> +		policy->driver_data = (void *)policy;

This is far better then the ugly solution I suggested on our private chat :),
but you should drop (void *) typecast. Its not required.

-- 
viresh
