Return-Path: <daniel.lezcano@linaro.org>
Received: from mail-wi0-f179.google.com (mail-wi0-f179.google.com
 [209.85.212.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 8EE742C0091
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Dec 2013 08:16:15 +1100 (EST)
Received: by mail-wi0-f179.google.com with SMTP id z2so4263788wiv.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Dec 2013 13:16:10 -0800 (PST)
Message-ID: <52B4B39C.2010202@linaro.org>
Date: Fri, 20 Dec 2013 22:16:12 +0100
From: Daniel Lezcano <daniel.lezcano@linaro.org>
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 rjw@rjwysocki.net
Subject: Re: [PATCH v2 1/9] ARM: EXYNOS: cpuidle: fix AFTR mode check
References: <1387565251-7051-1-git-send-email-b.zolnierkie@samsung.com>
 <1387565251-7051-2-git-send-email-b.zolnierkie@samsung.com>
In-Reply-To: <1387565251-7051-2-git-send-email-b.zolnierkie@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, kyungmin.park@samsung.com,
 Kukjin Kim <kgene.kim@samsung.com>, linuxppc-dev@lists.ozlabs.org,
 lenb@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/20/2013 07:47 PM, Bartlomiej Zolnierkiewicz wrote:
> The EXYNOS cpuidle driver code assumes that cpuidle core will handle
> dev->state_count smaller than drv->state_count but currently this is
> untrue (dev->state_count is used only for handling cpuidle state sysfs
> entries and drv->state_count is used for all other cases) and will not
> be fixed in the future as dev->state_count is planned to be removed.
>
> Fix the issue by checking for the max supported idle state in AFTR
> state's ->enter handler (exynos4_enter_lowpower()) and entering AFTR
> mode only when cores other than CPU0 are offline.
>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> ---
>   arch/arm/mach-exynos/cpuidle.c | 8 ++------
>   1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/mach-exynos/cpuidle.c b/arch/arm/mach-exynos/cpuidle.c
> index da65b03..f57cb91 100644
> --- a/arch/arm/mach-exynos/cpuidle.c
> +++ b/arch/arm/mach-exynos/cpuidle.c
> @@ -172,8 +172,8 @@ static int exynos4_enter_lowpower(struct cpuidle_device *dev,
>   {
>   	int new_index = index;
>
> -	/* This mode only can be entered when other core's are offline */
> -	if (num_online_cpus() > 1)
> +	/* AFTR can only be entered when cores other than CPU0 are offline */
> +	if (num_online_cpus() > 1 || dev->cpu != 0)
>   		new_index = drv->safe_state_index;
>
>   	if (new_index == 0)
> @@ -235,10 +235,6 @@ static int exynos_cpuidle_probe(struct platform_device *pdev)
>   		device = &per_cpu(exynos4_cpuidle_device, cpu_id);
>   		device->cpu = cpu_id;
>
> -		/* Support IDLE only */
> -		if (cpu_id != 0)
> -			device->state_count = 1;
> -
>   		ret = cpuidle_register_device(device);
>   		if (ret) {
>   			dev_err(&pdev->dev, "failed to register cpuidle device\n");
>

Hi Bartlomiej,

thanks for this cleanup. May be you can also add another patch to switch 
to the generic cpuidle_register function ?

Thanks
   -- Daniel

-- 
  <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
