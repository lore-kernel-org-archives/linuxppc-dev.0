Return-Path: <daniel.lezcano@linaro.org>
Received: from mail-we0-f174.google.com (mail-we0-f174.google.com
 [74.125.82.174])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 013BF2C0305
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jan 2014 19:35:46 +1100 (EST)
Received: by mail-we0-f174.google.com with SMTP id x55so4830226wes.19
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jan 2014 00:35:43 -0800 (PST)
Message-ID: <52E61A60.3030202@linaro.org>
Date: Mon, 27 Jan 2014 09:35:44 +0100
From: Daniel Lezcano <daniel.lezcano@linaro.org>
MIME-Version: 1.0
To: Nicolas Pitre <nicolas.pitre@linaro.org>,
 Russell King <linux@arm.linux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mundt <lethal@linux-sh.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 7/9] SH: remove redundant cpuidle_idle_call()
References: <1390802904-28399-1-git-send-email-nicolas.pitre@linaro.org>
 <1390802904-28399-8-git-send-email-nicolas.pitre@linaro.org>
In-Reply-To: <1390802904-28399-8-git-send-email-nicolas.pitre@linaro.org>
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
> The core idle loop now takes care of it.
>
> Signed-off-by: Nicolas Pitre <nico@linaro.org>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
>   arch/sh/kernel/idle.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/arch/sh/kernel/idle.c b/arch/sh/kernel/idle.c
> index 2ea4483fd7..be616ee0cf 100644
> --- a/arch/sh/kernel/idle.c
> +++ b/arch/sh/kernel/idle.c
> @@ -16,7 +16,6 @@
>   #include <linux/thread_info.h>
>   #include <linux/irqflags.h>
>   #include <linux/smp.h>
> -#include <linux/cpuidle.h>
>   #include <linux/atomic.h>
>   #include <asm/pgalloc.h>
>   #include <asm/smp.h>
> @@ -40,8 +39,7 @@ void arch_cpu_idle_dead(void)
>
>   void arch_cpu_idle(void)
>   {
> -	if (cpuidle_idle_call())
> -		sh_idle();
> +	sh_idle();
>   }
>
>   void __init select_idle_routine(void)
>


-- 
  <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
