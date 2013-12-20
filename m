Return-Path: <daniel.lezcano@linaro.org>
Received: from mail-we0-f173.google.com (mail-we0-f173.google.com
 [74.125.82.173])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 7DCC42C009E
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Dec 2013 08:48:37 +1100 (EST)
Received: by mail-we0-f173.google.com with SMTP id u57so3093579wes.32
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Dec 2013 13:48:33 -0800 (PST)
Message-ID: <52B4BB34.70804@linaro.org>
Date: Fri, 20 Dec 2013 22:48:36 +0100
From: Daniel Lezcano <daniel.lezcano@linaro.org>
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 rjw@rjwysocki.net
Subject: Re: [PATCH v2 7/9] intel_idle: remove superfluous dev->state_count
 initialization
References: <1387565251-7051-1-git-send-email-b.zolnierkie@samsung.com>
 <1387565251-7051-8-git-send-email-b.zolnierkie@samsung.com>
In-Reply-To: <1387565251-7051-8-git-send-email-b.zolnierkie@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, kyungmin.park@samsung.com,
 linuxppc-dev@lists.ozlabs.org, lenb@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/20/2013 07:47 PM, Bartlomiej Zolnierkiewicz wrote:
> intel_idle driver sets dev->state_count to drv->state_count so
> the default dev->state_count initialization in cpuidle_enable_device()
> (called from cpuidle_register_device()) can be used instead.
>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: Len Brown <lenb@kernel.org>

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
>   drivers/idle/intel_idle.c | 29 -----------------------------
>   1 file changed, 29 deletions(-)
>
> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> index 38da3fb..524d07b 100644
> --- a/drivers/idle/intel_idle.c
> +++ b/drivers/idle/intel_idle.c
> @@ -639,39 +639,10 @@ static int __init intel_idle_cpuidle_driver_init(void)
>    */
>   static int intel_idle_cpu_init(int cpu)
>   {
> -	int cstate;
>   	struct cpuidle_device *dev;
>
>   	dev = per_cpu_ptr(intel_idle_cpuidle_devices, cpu);
>
> -	dev->state_count = 1;
> -
> -	for (cstate = 0; cstate < CPUIDLE_STATE_MAX; ++cstate) {
> -		int num_substates, mwait_hint, mwait_cstate, mwait_substate;
> -
> -		if (cpuidle_state_table[cstate].enter == NULL)
> -			break;
> -
> -		if (cstate + 1 > max_cstate) {
> -			printk(PREFIX "max_cstate %d reached\n", max_cstate);
> -			break;
> -		}
> -
> -		mwait_hint = flg2MWAIT(cpuidle_state_table[cstate].flags);
> -		mwait_cstate = MWAIT_HINT2CSTATE(mwait_hint);
> -		mwait_substate = MWAIT_HINT2SUBSTATE(mwait_hint);
> -
> -		/* does the state exist in CPUID.MWAIT? */
> -		num_substates = (mwait_substates >> ((mwait_cstate + 1) * 4))
> -					& MWAIT_SUBSTATE_MASK;
> -
> -		/* if sub-state in table is not enumerated by CPUID */
> -		if ((mwait_substate + 1) > num_substates)
> -			continue;
> -
> -		dev->state_count += 1;
> -	}
> -
>   	dev->cpu = cpu;
>
>   	if (cpuidle_register_device(dev)) {
>


-- 
  <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
