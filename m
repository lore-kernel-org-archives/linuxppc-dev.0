Return-Path: <daniel.lezcano@linaro.org>
Received: from mail-wg0-f45.google.com (mail-wg0-f45.google.com [74.125.82.45])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C49822C007A
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jan 2014 19:32:23 +1100 (EST)
Received: by mail-wg0-f45.google.com with SMTP id n12so5245022wgh.12
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jan 2014 00:32:18 -0800 (PST)
Message-ID: <52E61993.2090705@linaro.org>
Date: Mon, 27 Jan 2014 09:32:19 +0100
From: Daniel Lezcano <daniel.lezcano@linaro.org>
MIME-Version: 1.0
To: Nicolas Pitre <nicolas.pitre@linaro.org>,
 Russell King <linux@arm.linux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mundt <lethal@linux-sh.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 4/9] idle: move the cpuidle entry point to the generic
 idle loop
References: <1390802904-28399-1-git-send-email-nicolas.pitre@linaro.org>
 <1390802904-28399-5-git-send-email-nicolas.pitre@linaro.org>
In-Reply-To: <1390802904-28399-5-git-send-email-nicolas.pitre@linaro.org>
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
> In order to integrate cpuidle with the scheduler, we must have a better
> proximity in the core code with what cpuidle is doing and not delegate
> such interaction to arch code.
>
> Architectures implementing arch_cpu_idle() should simply enter
> a cheap idle mode in the absence of a proper cpuidle driver.
>
> Signed-off-by: Nicolas Pitre <nico@linaro.org>

This patch without the next ones will lead to an extra call to 
cpuidle_idle_call.

	cpuidle_idle_call
		arch_cpu_idle
			cpuidle_idle_call
				x86_idle

But I guess it is acceptable as it is fixed with the next patches of the 
serie.

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
>   kernel/cpu/idle.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/cpu/idle.c b/kernel/cpu/idle.c
> index 4e327e211b..a6f40ad9f8 100644
> --- a/kernel/cpu/idle.c
> +++ b/kernel/cpu/idle.c
> @@ -3,6 +3,7 @@
>    */
>   #include <linux/sched.h>
>   #include <linux/cpu.h>
> +#include <linux/cpuidle.h>
>   #include <linux/tick.h>
>   #include <linux/mm.h>
>   #include <linux/stackprotector.h>
> @@ -94,7 +95,8 @@ static void cpu_idle_loop(void)
>   				if (!current_clr_polling_and_test()) {
>   					stop_critical_timings();
>   					rcu_idle_enter();
> -					arch_cpu_idle();
> +					if (cpuidle_idle_call())
> +						arch_cpu_idle();
>   					WARN_ON_ONCE(irqs_disabled());
>   					rcu_idle_exit();
>   					start_critical_timings();
>


-- 
  <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
