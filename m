Return-Path: <daniel.lezcano@linaro.org>
Received: from mail-wi0-f175.google.com (mail-wi0-f175.google.com
 [209.85.212.175])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 91F8C2C009E
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Dec 2013 08:52:36 +1100 (EST)
Received: by mail-wi0-f175.google.com with SMTP id hi5so8996476wib.14
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Dec 2013 13:52:32 -0800 (PST)
Message-ID: <52B4BC23.4080102@linaro.org>
Date: Fri, 20 Dec 2013 22:52:35 +0100
From: Daniel Lezcano <daniel.lezcano@linaro.org>
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 rjw@rjwysocki.net
Subject: Re: [PATCH v2 6/9] intel_idle: do C1E promotion disable quirk for
 hotplugged CPUs
References: <1387565251-7051-1-git-send-email-b.zolnierkie@samsung.com>
 <1387565251-7051-7-git-send-email-b.zolnierkie@samsung.com>
In-Reply-To: <1387565251-7051-7-git-send-email-b.zolnierkie@samsung.com>
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
> If the system is booted with some CPUs offline C1E promotion disable quirk
> won't be applied because on_each_cpu() in intel_idle_cpuidle_driver_init()
> operates only on online CPUs. Fix it by adding the C1E promotion disable
> handling to intel_idle_cpu_init() (which is also called during CPU_ONLINE
> operation).
>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: Len Brown <lenb@kernel.org>

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
>   drivers/idle/intel_idle.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> index 92d1206..38da3fb 100644
> --- a/drivers/idle/intel_idle.c
> +++ b/drivers/idle/intel_idle.c
> @@ -683,6 +683,9 @@ static int intel_idle_cpu_init(int cpu)
>   	if (icpu->auto_demotion_disable_flags)
>   		smp_call_function_single(cpu, auto_demotion_disable, NULL, 1);
>
> +	if (icpu->disable_promotion_to_c1e)
> +		smp_call_function_single(cpu, c1e_promotion_disable, NULL, 1);
> +
>   	return 0;
>   }

-- 
  <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
