Return-Path: <daniel.lezcano@linaro.org>
Received: from mail-wg0-f49.google.com (mail-wg0-f49.google.com [74.125.82.49])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 5A1192C032F
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Nov 2013 08:06:44 +1100 (EST)
Received: by mail-wg0-f49.google.com with SMTP id x12so65382wgg.28
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 Nov 2013 13:06:40 -0800 (PST)
Message-ID: <527AAF5E.6080709@linaro.org>
Date: Wed, 06 Nov 2013 22:06:38 +0100
From: Daniel Lezcano <daniel.lezcano@linaro.org>
MIME-Version: 1.0
To: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH V7 6/7] POWER/cpuidle: Enable powernv cpuidle support.
References: <20131029110052.31547.82682.stgit@deepthi.in.ibm.com>
 <20131029110154.31547.94129.stgit@deepthi.in.ibm.com>
In-Reply-To: <20131029110154.31547.94129.stgit@deepthi.in.ibm.com>
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
> The following patch extends the current power backend
> idle driver to the powernv platform.
>
> Signed-off-by: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
>   drivers/cpuidle/cpuidle-ibm-power.c |   39 ++++++++++++++++++++++++++++++++---
>   1 file changed, 36 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/cpuidle/cpuidle-ibm-power.c b/drivers/cpuidle/cpuidle-ibm-power.c
> index 5b92242..f790ea2 100644
> --- a/drivers/cpuidle/cpuidle-ibm-power.c
> +++ b/drivers/cpuidle/cpuidle-ibm-power.c
> @@ -52,9 +52,10 @@ static int snooze_loop(struct cpuidle_device *dev,
>   			struct cpuidle_driver *drv,
>   			int index)
>   {
> -	unsigned long in_purr;
> +	unsigned long in_purr = 0;
>
> -	idle_loop_prolog(&in_purr);
> +	if (firmware_has_feature(FW_FEATURE_SPLPAR))
> +		idle_loop_prolog(&in_purr);
>   	local_irq_enable();
>   	set_thread_flag(TIF_POLLING_NRFLAG);
>
> @@ -68,7 +69,8 @@ static int snooze_loop(struct cpuidle_device *dev,
>   	clear_thread_flag(TIF_POLLING_NRFLAG);
>   	smp_mb();
>
> -	idle_loop_epilog(in_purr);
> +	if (firmware_has_feature(FW_FEATURE_SPLPAR))
> +		idle_loop_epilog(in_purr);
>
>   	return index;
>   }
> @@ -132,6 +134,15 @@ static int shared_cede_loop(struct cpuidle_device *dev,
>   	return index;
>   }
>
> +static int nap_loop(struct cpuidle_device *dev,
> +			struct cpuidle_driver *drv,
> +			int index)
> +{
> +	ppc64_runlatch_off();
> +	power7_idle();
> +	return index;
> +}
> +
>   /*
>    * States for dedicated partition case.
>    */
> @@ -165,6 +176,23 @@ static struct cpuidle_state shared_states[] = {
>   		.enter = &shared_cede_loop },
>   };
>
> +static struct cpuidle_state powernv_states[] = {
> +	{ /* Snooze */
> +		.name = "snooze",
> +		.desc = "snooze",
> +		.flags = CPUIDLE_FLAG_TIME_VALID,
> +		.exit_latency = 0,
> +		.target_residency = 0,
> +		.enter = &snooze_loop },
> +	{ /* NAP */
> +		.name = "NAP",
> +		.desc = "NAP",
> +		.flags = CPUIDLE_FLAG_TIME_VALID,
> +		.exit_latency = 10,
> +		.target_residency = 100,
> +		.enter = &nap_loop },
> +};
> +
>   void update_smt_snooze_delay(int cpu, int residency)
>   {
>   	struct cpuidle_driver *drv = cpuidle_get_driver();
> @@ -258,6 +286,11 @@ static int power_idle_probe(void)
>   			cpuidle_state_table = dedicated_states;
>   			max_idle_state = ARRAY_SIZE(dedicated_states);
>   		}
> +
> +	} else if (firmware_has_feature(FW_FEATURE_OPALv3)) {
> +		cpuidle_state_table = powernv_states;
> +		max_idle_state = ARRAY_SIZE(powernv_states);
> +
>   	} else
>   		return -ENODEV;
>
>


-- 
  <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
