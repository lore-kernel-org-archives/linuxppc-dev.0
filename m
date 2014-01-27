Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 49D5C2C009E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jan 2014 23:03:52 +1100 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Mon, 27 Jan 2014 07:03:47 -0500
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id A6A7438C8047
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jan 2014 07:03:45 -0500 (EST)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp23034.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s0RC3jdY7143868
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jan 2014 12:03:45 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s0RC3ggI008180
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jan 2014 07:03:45 -0500
Message-ID: <52E64A37.4090405@linux.vnet.ibm.com>
Date: Mon, 27 Jan 2014 17:29:51 +0530
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [PATCH 6/9] PPC: remove redundant cpuidle_idle_call()
References: <1390802904-28399-1-git-send-email-nicolas.pitre@linaro.org>
 <1390802904-28399-7-git-send-email-nicolas.pitre@linaro.org>
In-Reply-To: <1390802904-28399-7-git-send-email-nicolas.pitre@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linaro-kernel@lists.linaro.org, Russell King <linux@arm.linux.org.uk>,
 linux-pm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org,
 linux-sh@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>,
 Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org,
 Ingo Molnar <mingo@redhat.com>, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Nicolas,

On 01/27/2014 11:38 AM, Nicolas Pitre wrote:
> The core idle loop now takes care of it.  However a few things need
> checking:
> 
> - Invocation of cpuidle_idle_call() in pseries_lpar_idle() happened
>   through arch_cpu_idle() and was therefore always preceded by a call
>   to ppc64_runlatch_off().  To preserve this property now that
>   cpuidle_idle_call() is invoked directly from core code, a call to
>   ppc64_runlatch_off() has been added to idle_loop_prolog() in
>   platforms/pseries/processor_idle.c.
> 
> - Similarly, cpuidle_idle_call() was followed by ppc64_runlatch_off()
>   so a call to the later has been added to idle_loop_epilog().
> 
> - And since arch_cpu_idle() always made sure to re-enable IRQs if they
>   were not enabled, this is now
>   done in idle_loop_epilog() as well.
> 
> The above was made in order to keep the execution flow close to the
> original.  I don't know if that was strictly necessary. Someone well
> aquainted with the platform details might find some room for possible
> optimizations.
> 
> Signed-off-by: Nicolas Pitre <nico@linaro.org>
> ---
>  arch/powerpc/platforms/pseries/processor_idle.c |  5 ++++
>  arch/powerpc/platforms/pseries/setup.c          | 34 ++++++++++---------------
>  2 files changed, 19 insertions(+), 20 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/processor_idle.c b/arch/powerpc/platforms/pseries/processor_idle.c
> index a166e38bd6..72ddfe3d2f 100644
> --- a/arch/powerpc/platforms/pseries/processor_idle.c
> +++ b/arch/powerpc/platforms/pseries/processor_idle.c
> @@ -33,6 +33,7 @@ static struct cpuidle_state *cpuidle_state_table;
> 
>  static inline void idle_loop_prolog(unsigned long *in_purr)
>  {
> +	ppc64_runlatch_off();
>  	*in_purr = mfspr(SPRN_PURR);
>  	/*
>  	 * Indicate to the HV that we are idle. Now would be
> @@ -49,6 +50,10 @@ static inline void idle_loop_epilog(unsigned long in_purr)
>  	wait_cycles += mfspr(SPRN_PURR) - in_purr;
>  	get_lppaca()->wait_state_cycles = cpu_to_be64(wait_cycles);
>  	get_lppaca()->idle = 0;
> +
> +	if (irqs_disabled())
> +		local_irq_enable();
> +	ppc64_runlatch_on();
>  }
> 
>  static int snooze_loop(struct cpuidle_device *dev,
> diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
> index c1f1908587..7604c19d54 100644
> --- a/arch/powerpc/platforms/pseries/setup.c
> +++ b/arch/powerpc/platforms/pseries/setup.c
> @@ -39,7 +39,6 @@
>  #include <linux/irq.h>
>  #include <linux/seq_file.h>
>  #include <linux/root_dev.h>
> -#include <linux/cpuidle.h>
>  #include <linux/of.h>
>  #include <linux/kexec.h>
> 
> @@ -356,29 +355,24 @@ early_initcall(alloc_dispatch_log_kmem_cache);
> 
>  static void pseries_lpar_idle(void)
>  {
> -	/* This would call on the cpuidle framework, and the back-end pseries
> -	 * driver to  go to idle states
> +	/*
> +	 * Default handler to go into low thread priority and possibly
> +	 * low power mode by cedeing processor to hypervisor
>  	 */
> -	if (cpuidle_idle_call()) {
> -		/* On error, execute default handler
> -		 * to go into low thread priority and possibly
> -		 * low power mode by cedeing processor to hypervisor
> -		 */
> 
> -		/* Indicate to hypervisor that we are idle. */
> -		get_lppaca()->idle = 1;
> +	/* Indicate to hypervisor that we are idle. */
> +	get_lppaca()->idle = 1;
> 
> -		/*
> -		 * Yield the processor to the hypervisor.  We return if
> -		 * an external interrupt occurs (which are driven prior
> -		 * to returning here) or if a prod occurs from another
> -		 * processor. When returning here, external interrupts
> -		 * are enabled.
> -		 */
> -		cede_processor();
> +	/*
> +	 * Yield the processor to the hypervisor.  We return if
> +	 * an external interrupt occurs (which are driven prior
> +	 * to returning here) or if a prod occurs from another
> +	 * processor. When returning here, external interrupts
> +	 * are enabled.
> +	 */
> +	cede_processor();
> 
> -		get_lppaca()->idle = 0;
> -	}
> +	get_lppaca()->idle = 0;
>  }
> 
>  /*
> 

Reviewed-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>

The consequence of this would be for other Power platforms like PowerNV,
we will need to invoke ppc_runlatch_off() and ppc_runlatch_on() in each
of the idle routines since the idle_loop_prologue() and
idle_loop_epilogue() are not invoked by them, but we will take care of this.

Regards
Preeti U Murthy
