Return-Path: <daniel.lezcano@linaro.org>
Received: from mail-we0-f175.google.com (mail-we0-f175.google.com
 [74.125.82.175])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 220BB2C0099
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jan 2014 19:23:01 +1100 (EST)
Received: by mail-we0-f175.google.com with SMTP id p61so4833489wes.20
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jan 2014 00:22:56 -0800 (PST)
Message-ID: <52E6175F.1050401@linaro.org>
Date: Mon, 27 Jan 2014 09:22:55 +0100
From: Daniel Lezcano <daniel.lezcano@linaro.org>
MIME-Version: 1.0
To: Nicolas Pitre <nicolas.pitre@linaro.org>,
 Russell King <linux@arm.linux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mundt <lethal@linux-sh.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/9] ARM: get rid of arch_cpu_idle_prepare()
References: <1390802904-28399-1-git-send-email-nicolas.pitre@linaro.org>
 <1390802904-28399-2-git-send-email-nicolas.pitre@linaro.org>
In-Reply-To: <1390802904-28399-2-git-send-email-nicolas.pitre@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/27/2014 07:08 AM, Nicolas Pitre wrote:
> ARM and ARM64 are the only two architectures implementing
> arch_cpu_idle_prepare() simply to call local_fiq_enable().
>
> We have secondary_start_kernel() already calling local_fiq_enable() and
> this is done a second time in arch_cpu_idle_prepare() in that case. And
> enabling FIQs has nothing to do with idling the CPU to start with.
>
> So let's introduce init_fiq_boot_cpu() to take care of FIQs on the boot
> CPU and remove arch_cpu_idle_prepare(). This is now done a bit earlier
> at late_initcall time but this shouldn't make a difference in practice
> i.e. when FIQs are actually used.
>
> Signed-off-by: Nicolas Pitre <nico@linaro.org>

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
>   arch/arm/kernel/process.c | 5 -----
>   arch/arm/kernel/setup.c   | 7 +++++++
>   2 files changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
> index 92f7b15dd2..725b8c95e0 100644
> --- a/arch/arm/kernel/process.c
> +++ b/arch/arm/kernel/process.c
> @@ -142,11 +142,6 @@ static void default_idle(void)
>   	local_irq_enable();
>   }
>
> -void arch_cpu_idle_prepare(void)
> -{
> -	local_fiq_enable();
> -}
> -
>   void arch_cpu_idle_enter(void)
>   {
>   	ledtrig_cpu(CPU_LED_IDLE_START);
> diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
> index 987a7f5bce..d027b1a6fe 100644
> --- a/arch/arm/kernel/setup.c
> +++ b/arch/arm/kernel/setup.c
> @@ -789,6 +789,13 @@ static int __init init_machine_late(void)
>   }
>   late_initcall(init_machine_late);
>
> +static int __init init_fiq_boot_cpu(void)
> +{
> +	local_fiq_enable();
> +	return 0;
> +}
> +late_initcall(init_fiq_boot_cpu);
> +
>   #ifdef CONFIG_KEXEC
>   static inline unsigned long long get_total_mem(void)
>   {
>


-- 
  <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
