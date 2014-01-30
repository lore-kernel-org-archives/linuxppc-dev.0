Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 113032C00CD
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jan 2014 14:42:25 +1100 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Wed, 29 Jan 2014 22:42:21 -0500
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id B556A38C8045
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jan 2014 22:42:18 -0500 (EST)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp22036.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s0U3gIU67733628
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jan 2014 03:42:18 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s0U3gH1S004291
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jan 2014 22:42:18 -0500
Message-ID: <52E9C946.50704@linux.vnet.ibm.com>
Date: Thu, 30 Jan 2014 09:08:46 +0530
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [PATCH v2 1/6] idle: move the cpuidle entry point to the generic
 idle loop
References: <1391017513-12995-1-git-send-email-nicolas.pitre@linaro.org>
 <1391017513-12995-2-git-send-email-nicolas.pitre@linaro.org>
 <alpine.LFD.2.11.1401291526320.1652@knanqh.ubzr>
In-Reply-To: <alpine.LFD.2.11.1401291526320.1652@knanqh.ubzr>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linaro-kernel@lists.linaro.org, Russell King <linux@arm.linux.org.uk>,
 linux-pm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org,
 Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org,
 Olof Johansson <olof@lixom.net>, Thomas Gleixner <tglx@linutronix.de>,
 linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@redhat.com>,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Nicolas,

On 01/30/2014 02:01 AM, Nicolas Pitre wrote:
> On Wed, 29 Jan 2014, Nicolas Pitre wrote:
> 
>> In order to integrate cpuidle with the scheduler, we must have a better
>> proximity in the core code with what cpuidle is doing and not delegate
>> such interaction to arch code.
>>
>> Architectures implementing arch_cpu_idle() should simply enter
>> a cheap idle mode in the absence of a proper cpuidle driver.
>>
>> Signed-off-by: Nicolas Pitre <nico@linaro.org>
>> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> 
> As mentioned in my reply to Olof's comment on patch #5/6, here's a new 
> version of this patch adding the safety local_irq_enable() to the core 
> code.
> 
> ----- >8
> 
> From: Nicolas Pitre <nicolas.pitre@linaro.org>
> Subject: idle: move the cpuidle entry point to the generic idle loop
> 
> In order to integrate cpuidle with the scheduler, we must have a better
> proximity in the core code with what cpuidle is doing and not delegate
> such interaction to arch code.
> 
> Architectures implementing arch_cpu_idle() should simply enter
> a cheap idle mode in the absence of a proper cpuidle driver.
> 
> In both cases i.e. whether it is a cpuidle driver or the default
> arch_cpu_idle(), the calling convention expects IRQs to be disabled
> on entry and enabled on exit. There is a warning in place already but
> let's add a forced IRQ enable here as well.  This will allow for
> removing the forced IRQ enable some implementations do locally and 

Why would this patch allow for removing the forced IRQ enable that are
being done on some archs in arch_cpu_idle()? Isn't this patch expecting
the default arch_cpu_idle() to have re-enabled the interrupts after
exiting from the default idle state? Its supposed to only catch faulty
cpuidle drivers that haven't enabled IRQs on exit from idle state but
are expected to have done so, isn't it?

Thanks

Regards
Preeti U Murthy

> allowing for the warning to trig.
> 
> Signed-off-by: Nicolas Pitre <nico@linaro.org>
> 
> diff --git a/kernel/cpu/idle.c b/kernel/cpu/idle.c
> index 988573a9a3..14ca43430a 100644
> --- a/kernel/cpu/idle.c
> +++ b/kernel/cpu/idle.c
> @@ -3,6 +3,7 @@
>   */
>  #include <linux/sched.h>
>  #include <linux/cpu.h>
> +#include <linux/cpuidle.h>
>  #include <linux/tick.h>
>  #include <linux/mm.h>
>  #include <linux/stackprotector.h>
> @@ -95,8 +96,10 @@ static void cpu_idle_loop(void)
>  				if (!current_clr_polling_and_test()) {
>  					stop_critical_timings();
>  					rcu_idle_enter();
> -					arch_cpu_idle();
> -					WARN_ON_ONCE(irqs_disabled());
> +					if (cpuidle_idle_call())
> +						arch_cpu_idle();
> +					if (WARN_ON_ONCE(irqs_disabled()))
> +						local_irq_enable();
>  					rcu_idle_exit();
>  					start_critical_timings();
>  				} else {
> 
