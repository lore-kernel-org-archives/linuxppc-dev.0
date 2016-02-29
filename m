Return-Path: <viresh.kumar@linaro.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 431E31A005D
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Feb 2016 17:39:23 +1100 (AEDT)
Received: from mail-pa0-x236.google.com (mail-pa0-x236.google.com
 [IPv6:2607:f8b0:400e:c03::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 567AC140662
 for <linuxppc-dev@ozlabs.org>; Mon, 29 Feb 2016 17:39:21 +1100 (AEDT)
Received: by mail-pa0-x236.google.com with SMTP id fl4so86788467pad.0
 for <linuxppc-dev@ozlabs.org>; Sun, 28 Feb 2016 22:39:21 -0800 (PST)
Date: Mon, 29 Feb 2016 12:09:17 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: rjw@rjwysocki.net, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, ego@linux.vnet.ibm.com,
 shreyas@linux.vnet.ibm.com, linux-api@vger.kernel.org
Subject: Re: [PATCH v10 2/2] cpufreq: powernv: Add sysfs attributes to show
 throttle stats
Message-ID: <20160229063917.GK2791@vireshk-i7>
References: <1456483012-29466-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <1456483012-29466-3-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1456483012-29466-3-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 26-02-16, 16:06, Shilpasri G Bhat wrote:
> +static int powernv_cpufreq_policy_notifier(struct notifier_block *nb,
> +					   unsigned long action, void *data)
> +{
> +	struct cpufreq_policy *policy = data;
> +	int ret;
> +
> +	if (action == CPUFREQ_CREATE_POLICY) {
> +		ret = sysfs_create_group(&policy->kobj, &throttle_attr_grp);
> +		if (ret)
> +			pr_info("Failed to create throttle stats directory for cpu %d\n",
> +				policy->cpu);
> +	} else if (action == CPUFREQ_REMOVE_POLICY) {
> +		sysfs_remove_group(&policy->kobj, &throttle_attr_grp);
> +	}
> +
> +	return NOTIFY_DONE;
> +}
> +
> +static struct notifier_block powernv_cpufreq_policy_nb = {
> +	.notifier_call	= powernv_cpufreq_policy_notifier,
> +	.next		= NULL,
> +};
> +
>  static void powernv_cpufreq_stop_cpu(struct cpufreq_policy *policy)
>  {
>  	struct powernv_smp_call_data freq_data;
> @@ -603,6 +708,8 @@ static inline void clean_chip_info(void)
>  
>  static inline void unregister_all_notifiers(void)
>  {
> +	cpufreq_unregister_notifier(&powernv_cpufreq_policy_nb,
> +				    CPUFREQ_POLICY_NOTIFIER);
>  	opal_message_notifier_unregister(OPAL_MSG_OCC,
>  					 &powernv_cpufreq_opal_nb);
>  	unregister_reboot_notifier(&powernv_cpufreq_reboot_nb);
> @@ -628,6 +735,8 @@ static int __init powernv_cpufreq_init(void)
>  
>  	register_reboot_notifier(&powernv_cpufreq_reboot_nb);
>  	opal_message_notifier_register(OPAL_MSG_OCC, &powernv_cpufreq_opal_nb);
> +	cpufreq_register_notifier(&powernv_cpufreq_policy_nb,
> +				  CPUFREQ_POLICY_NOTIFIER);
>  
>  	rc = cpufreq_register_driver(&powernv_cpufreq_driver);
>  	if (!rc)

@Rafael: This driver needs to do this *ugly* notifier hack, just because we
aren't doing kobject_add() for policy->kobj before ->init(). And we did that
because, we wanted to create the policyX structure with the first CPU in
policy->related_cpus mask and related_cpus mask isn't available until we call
->init()..

Should we do something in core to make this easier for this driver?

-- 
viresh
