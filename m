Return-Path: <daniel.lezcano@linaro.org>
Received: from mail-wg0-f44.google.com (mail-wg0-f44.google.com [74.125.82.44])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 961E62C0099
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jan 2014 19:43:16 +1100 (EST)
Received: by mail-wg0-f44.google.com with SMTP id l18so5228646wgh.35
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jan 2014 00:43:12 -0800 (PST)
Message-ID: <52E61C20.50804@linaro.org>
Date: Mon, 27 Jan 2014 09:43:12 +0100
From: Daniel Lezcano <daniel.lezcano@linaro.org>
MIME-Version: 1.0
To: Nicolas Pitre <nicolas.pitre@linaro.org>,
 Russell King <linux@arm.linux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mundt <lethal@linux-sh.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 8/9] X86: remove redundant cpuidle_idle_call()
References: <1390802904-28399-1-git-send-email-nicolas.pitre@linaro.org>
 <1390802904-28399-9-git-send-email-nicolas.pitre@linaro.org>
In-Reply-To: <1390802904-28399-9-git-send-email-nicolas.pitre@linaro.org>
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
>   arch/x86/kernel/process.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
> index 3fb8d95ab8..4505e2a950 100644
> --- a/arch/x86/kernel/process.c
> +++ b/arch/x86/kernel/process.c
> @@ -298,10 +298,7 @@ void arch_cpu_idle_dead(void)
>    */
>   void arch_cpu_idle(void)
>   {
> -	if (cpuidle_idle_call())
> -		x86_idle();
> -	else
> -		local_irq_enable();

For the record, it was pointless to enable the local irq here because it 
is handled by the cpuidle framework when exiting the idle state.

> +	x86_idle();
>   }
>
>   /*
>


-- 
  <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
