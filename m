Return-Path: <viresh.kumar@linaro.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 228F01A0290
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Feb 2016 16:20:12 +1100 (AEDT)
Received: from mail-pa0-x231.google.com (mail-pa0-x231.google.com
 [IPv6:2607:f8b0:400e:c03::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 886441402A8
 for <linuxppc-dev@ozlabs.org>; Tue,  9 Feb 2016 16:20:10 +1100 (AEDT)
Received: by mail-pa0-x231.google.com with SMTP id cy9so85615590pac.0
 for <linuxppc-dev@ozlabs.org>; Mon, 08 Feb 2016 21:20:10 -0800 (PST)
Date: Tue, 9 Feb 2016 10:50:04 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
 rjw@rjwysocki.net, linux-pm@vger.kernel.org, pc@us.ibm.com,
 anton@samba.org, ego@linux.vnet.ibm.com, shreyas@linux.vnet.ibm.com,
 bsingharora@gmail.com, linux-api@vger.kernel.org
Subject: Re: [PATCH v9] cpufreq: powernv: Add sysfs attributes to show
 throttle stats
Message-ID: <20160209052004.GA15734@vireshk>
References: <1454942667-13424-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1454942667-13424-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08-02-16, 20:14, Shilpasri G Bhat wrote:
> Create sysfs attributes to export throttle information in
> /sys/devices/system/cpu/cpuX/cpufreq/throttle_stats directory. The
> newly added sysfs files are as follows:
> 
> 1)/sys/devices/system/cpu/cpuX/cpufreq/throttle_stats/turbo_stat
> 2)/sys/devices/system/cpu/cpuX/cpufreq/throttle_stats/sub-turbo_stat
> 3)/sys/devices/system/cpu/cpuX/cpufreq/throttle_stats/unthrottle
> 4)/sys/devices/system/cpu/cpuX/cpufreq/throttle_stats/powercap
> 5)/sys/devices/system/cpu/cpuX/cpufreq/throttle_stats/overtemp
> 6)/sys/devices/system/cpu/cpuX/cpufreq/throttle_stats/supply_fault
> 7)/sys/devices/system/cpu/cpuX/cpufreq/throttle_stats/overcurrent
> 8)/sys/devices/system/cpu/cpuX/cpufreq/throttle_stats/occ_reset
> 
> Detailed explanation of each attribute is added to
> Documentation/ABI/testing/sysfs-devices-system-cpu
> 
> Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
> ---
> Changes from v8:
> - Moved the sysfs attributes from cpu/cpufreq/chipX to cpuX/cpufreq/throttle_stats
> - Adhering to one-value-per-file, replace throttle_table with multiple
>   sysfs files.
> - Using CPUFREQ_POLICY_NOTIFIER to add/remove attribute_group.

Looks far better and sensible, but there are few bugs we have to fix
first.

>  static void powernv_cpufreq_stop_cpu(struct cpufreq_policy *policy)
>  {
>  	struct powernv_smp_call_data freq_data;
> @@ -589,6 +694,7 @@ static int init_chip_info(void)
>  	}
>  
>  	return 0;
> +

Unrelated change.

>  free_chip_map:
>  	kfree(core_to_chip_map);
>  out:
> @@ -615,6 +721,8 @@ static int __init powernv_cpufreq_init(void)
>  	if (rc)
>  		return rc;
>  
> +	cpufreq_register_notifier(&powernv_cpufreq_policy_nb,
> +				  CPUFREQ_POLICY_NOTIFIER);
>  	register_reboot_notifier(&powernv_cpufreq_reboot_nb);
>  	opal_message_notifier_register(OPAL_MSG_OCC, &powernv_cpufreq_opal_nb);
>  	return cpufreq_register_driver(&powernv_cpufreq_driver);

If this fails, you don't unregister the notifiers. Actually, the BUG
is already there, and you must fix that first.

> @@ -626,6 +734,8 @@ static void __exit powernv_cpufreq_exit(void)
>  	unregister_reboot_notifier(&powernv_cpufreq_reboot_nb);
>  	opal_message_notifier_unregister(OPAL_MSG_OCC,
>  					 &powernv_cpufreq_opal_nb);
> +	cpufreq_unregister_notifier(&powernv_cpufreq_policy_nb,
> +				    CPUFREQ_POLICY_NOTIFIER);
>  	kfree(chips);
>  	kfree(core_to_chip_map);
>  	cpufreq_unregister_driver(&powernv_cpufreq_driver);

This is even more stupid. You remove the driver after freeing all
resources :)

Make this reverse of init..

Fix existing issues first and then apply this patch on the top.

-- 
viresh
