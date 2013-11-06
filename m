Return-Path: <daniel.lezcano@linaro.org>
Received: from mail-we0-f178.google.com (mail-we0-f178.google.com
 [74.125.82.178])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 801792C0141
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Nov 2013 08:01:12 +1100 (EST)
Received: by mail-we0-f178.google.com with SMTP id q59so65354wes.9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 Nov 2013 13:01:09 -0800 (PST)
Message-ID: <527AAE13.2090400@linaro.org>
Date: Wed, 06 Nov 2013 22:01:07 +0100
From: Daniel Lezcano <daniel.lezcano@linaro.org>
MIME-Version: 1.0
To: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH V7 3/7] pseries/cpuidle: Make pseries_idle backend driver
 a non-module.
References: <20131029110052.31547.82682.stgit@deepthi.in.ibm.com>
 <20131029110134.31547.86550.stgit@deepthi.in.ibm.com>
In-Reply-To: <20131029110134.31547.86550.stgit@deepthi.in.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: preeti@linux.vnet.ibm.com, srivatsa.bhat@linux.vnet.ibm.com,
 scottwood@freescale.com, linux-pm@lists.linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/29/2013 12:01 PM, Deepthi Dharwar wrote:
> Currently pseries_idle cpuidle backend driver cannot be
> built as a module due to dependencies. Therefore the driver has
> to be built in. The dependency is around update_snooze_delay() defined
> in cpuidle driver and called from kernel/sysfs.c.
> This patch is removes all the module related code.
>
> Signed-off-by: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
>   drivers/cpuidle/cpuidle-ibm-power.c |   15 +--------------
>   1 file changed, 1 insertion(+), 14 deletions(-)
>
> diff --git a/drivers/cpuidle/cpuidle-ibm-power.c b/drivers/cpuidle/cpuidle-ibm-power.c
> index faf8cc1..8c9e42c 100644
> --- a/drivers/cpuidle/cpuidle-ibm-power.c
> +++ b/drivers/cpuidle/cpuidle-ibm-power.c
> @@ -292,17 +292,4 @@ static int __init pseries_processor_idle_init(void)
>   	return 0;
>   }
>
> -static void __exit pseries_processor_idle_exit(void)
> -{
> -
> -	unregister_cpu_notifier(&setup_hotplug_notifier);
> -	cpuidle_unregister(&pseries_idle_driver);
> -	return;
> -}
> -
> -module_init(pseries_processor_idle_init);
> -module_exit(pseries_processor_idle_exit);
> -
> -MODULE_AUTHOR("Deepthi Dharwar <deepthi@linux.vnet.ibm.com>");
> -MODULE_DESCRIPTION("Cpuidle driver for POWER");
> -MODULE_LICENSE("GPL");
> +device_initcall(pseries_processor_idle_init);
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>


-- 
  <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
