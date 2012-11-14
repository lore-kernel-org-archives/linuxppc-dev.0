Return-Path: <daniel.lezcano@linaro.org>
Received: from mail-lb0-f179.google.com (mail-lb0-f179.google.com
 [209.85.217.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C06C52C009F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Nov 2012 22:05:08 +1100 (EST)
Received: by mail-lb0-f179.google.com with SMTP id c1so257288lbg.38
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Nov 2012 03:05:05 -0800 (PST)
Message-ID: <50A37ADD.8040000@linaro.org>
Date: Wed, 14 Nov 2012 12:05:01 +0100
From: Daniel Lezcano <daniel.lezcano@linaro.org>
MIME-Version: 1.0
To: Julius Werner <jwerner@chromium.org>
Subject: Re: [PATCH] cpuidle: Measure idle state durations with monotonic clock
References: <1352843563-16392-1-git-send-email-jwerner@chromium.org>
In-Reply-To: <1352843563-16392-1-git-send-email-jwerner@chromium.org>
Content-Type: text/plain; charset=UTF-8
Cc: Kevin Hilman <khilman@ti.com>, Deepthi Dharwar <deepthi@linux.vnet.ibm.com>,
 Trinabh Gupta <g.trinabh@gmail.com>,
 Lists Linaro-dev <linaro-dev@lists.linaro.org>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>,
 linux-acpi@vger.kernel.org,
 "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 Sameer Nanda <snanda@chromium.org>, Len Brown <lenb@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/13/2012 10:52 PM, Julius Werner wrote:
> Many cpuidle drivers measure their time spent in an idle state by
> reading the wallclock time before and after idling and calculating the
> difference. This leads to erroneous results when the wallclock time gets
> updated by another processor in the meantime, adding that clock
> adjustment to the idle state's time counter.
> 
> If the clock adjustment was negative, the result is even worse due to an
> erroneous cast from int to unsigned long long of the last_residency
> variable. The negative 32 bit integer will zero-extend and result in a
> forward time jump of roughly four billion milliseconds or 1.3 hours on
> the idle state residency counter.
> 
> This patch changes all affected cpuidle drivers to use the monotonic
> clock for their measurements instead. It also removes the erroneous
> cast, making sure that negative residency values are applied correctly
> even though they should not appear anymore.
> 
> Signed-off-by: Julius Werner <jwerner@chromium.org>
> ---
>  arch/powerpc/platforms/pseries/processor_idle.c |    4 ++--
>  drivers/acpi/processor_idle.c                   |   12 ++++++------
>  drivers/cpuidle/cpuidle.c                       |    3 +--
>  drivers/idle/intel_idle.c                       |   13 ++++---------
>  4 files changed, 13 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/processor_idle.c b/arch/powerpc/platforms/pseries/processor_idle.c
> index 45d00e5..4d806b4 100644
> --- a/arch/powerpc/platforms/pseries/processor_idle.c
> +++ b/arch/powerpc/platforms/pseries/processor_idle.c
> @@ -36,7 +36,7 @@ static struct cpuidle_state *cpuidle_state_table;
>  static inline void idle_loop_prolog(unsigned long *in_purr, ktime_t *kt_before)
>  {
>  
> -	*kt_before = ktime_get_real();
> +	*kt_before = ktime_get();
>  	*in_purr = mfspr(SPRN_PURR);
>  	/*
>  	 * Indicate to the HV that we are idle. Now would be
> @@ -50,7 +50,7 @@ static inline  s64 idle_loop_epilog(unsigned long in_purr, ktime_t kt_before)
>  	get_lppaca()->wait_state_cycles += mfspr(SPRN_PURR) - in_purr;
>  	get_lppaca()->idle = 0;
>  
> -	return ktime_to_us(ktime_sub(ktime_get_real(), kt_before));
> +	return ktime_to_us(ktime_sub(ktime_get(), kt_before));
>  }
>  
>  static int snooze_loop(struct cpuidle_device *dev,
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
> index e8086c7..8c98d73 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -751,9 +751,9 @@ static int acpi_idle_enter_c1(struct cpuidle_device *dev,
>  
>  
>  	lapic_timer_state_broadcast(pr, cx, 1);
> -	kt1 = ktime_get_real();
> +	kt1 = ktime_get();
>  	acpi_idle_do_entry(cx);
> -	kt2 = ktime_get_real();
> +	kt2 = ktime_get();
>  	idle_time =  ktime_to_us(ktime_sub(kt2, kt1));
>  
>  	/* Update device last_residency*/
> @@ -843,11 +843,11 @@ static int acpi_idle_enter_simple(struct cpuidle_device *dev,
>  	if (cx->type == ACPI_STATE_C3)
>  		ACPI_FLUSH_CPU_CACHE();
>  
> -	kt1 = ktime_get_real();
> +	kt1 = ktime_get();
>  	/* Tell the scheduler that we are going deep-idle: */
>  	sched_clock_idle_sleep_event();
>  	acpi_idle_do_entry(cx);
> -	kt2 = ktime_get_real();
> +	kt2 = ktime_get();
>  	idle_time_ns = ktime_to_ns(ktime_sub(kt2, kt1));
>  	idle_time = idle_time_ns;
>  	do_div(idle_time, NSEC_PER_USEC);
> @@ -934,7 +934,7 @@ static int acpi_idle_enter_bm(struct cpuidle_device *dev,
>  	 */
>  	lapic_timer_state_broadcast(pr, cx, 1);
>  
> -	kt1 = ktime_get_real();
> +	kt1 = ktime_get();
>  	/*
>  	 * disable bus master
>  	 * bm_check implies we need ARB_DIS
> @@ -965,7 +965,7 @@ static int acpi_idle_enter_bm(struct cpuidle_device *dev,
>  		c3_cpu_count--;
>  		raw_spin_unlock(&c3_lock);
>  	}
> -	kt2 = ktime_get_real();
> +	kt2 = ktime_get();
>  	idle_time_ns = ktime_to_ns(ktime_sub(kt2, kt1));
>  	idle_time = idle_time_ns;
>  	do_div(idle_time, NSEC_PER_USEC);


Maybe you can remove all these computations and set the flag
en_core_tk_irqen for the driver ? That will be handled by the cpuidle
framework, no ?

Same comment for the intel_idle driver.

Thanks
  -- Daniel

-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
