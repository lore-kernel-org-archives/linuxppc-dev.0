Return-Path: <daniel.lezcano@linaro.org>
Received: from mail-wm0-x233.google.com (mail-wm0-x233.google.com
 [IPv6:2a00:1450:400c:c09::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rfZJ75hqrzDqrK
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 17:37:11 +1000 (AEST)
Received: by mail-wm0-x233.google.com with SMTP id r201so59644373wme.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 00:37:11 -0700 (PDT)
Subject: Re: [PATCH v3] cpuidle: Fix last_residency division
To: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>, rjw@rjwysocki.net
References: <1467183971-12327-1-git-send-email-shreyas@linux.vnet.ibm.com>
Cc: linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, anton@samba.org,
 mpe@ellerman.id.au, bsingharora@gmail.com, David.Laight@ACULAB.COM,
 arnd@arndb.de, Nicolas Pitre <nicolas.pitre@linaro.org>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <57737AA1.7050201@linaro.org>
Date: Wed, 29 Jun 2016 09:37:05 +0200
MIME-Version: 1.0
In-Reply-To: <1467183971-12327-1-git-send-email-shreyas@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/29/2016 09:06 AM, Shreyas B. Prabhu wrote:
> Snooze is a poll idle state in powernv and pseries platforms. Snooze
> has a timeout so that if a cpu stays in snooze for more than target
> residency of the next available idle state, then it would exit thereby
> giving chance to the cpuidle governor to re-evaluate and
> promote the cpu to a deeper idle state. Therefore whenever snooze exits
> due to this timeout, its last_residency will be target_residency of next
> deeper state.
>
> commit e93e59ce5b85 ("cpuidle: Replace ktime_get() with local_clock()")
> changed the math around last_residency calculation. Specifically, while
> converting last_residency value from nanoseconds to microseconds it does
> right shift by 10. Due to this, in snooze timeout exit scenarios
> last_residency calculated is roughly 2.3% less than target_residency of
> next available state. This pattern is picked up get_typical_interval()
> in the menu governor and therefore expected_interval in menu_select() is
> frequently less than the target_residency of any state but snooze.
>
> Due to this we are entering snooze at a higher rate, thereby affecting
> the single thread performance.
>
> Fix this by using a better approximation for division by 1000.
>
> Reported-by: Anton Blanchard <anton@samba.org>
> Bisected-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
> Suggested-by David Laight <david.laight@aculab.com>
> Signed-off-by: Shreyas B. Prabhu <shreyas@linux.vnet.ibm.com>

[Cc'ed Nicolas Pitre]

> ---
> Changes in v3
> =============
>   - Using approximation suggested by David
>
> Changes in v2
> =============
>   - Fixing it in the cpuidle core code instead of driver code.
>
>   drivers/cpuidle/cpuidle.c | 11 +++--------
>   drivers/cpuidle/cpuidle.h | 23 +++++++++++++++++++++++
>   2 files changed, 26 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index a4d0059..e9a7f74 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -174,7 +174,6 @@ int cpuidle_enter_state(struct cpuidle_device *dev, struct cpuidle_driver *drv,
>   	struct cpuidle_state *target_state = &drv->states[index];
>   	bool broadcast = !!(target_state->flags & CPUIDLE_FLAG_TIMER_STOP);
>   	u64 time_start, time_end;
> -	s64 diff;
>
>   	/*
>   	 * Tell the time framework to switch to a broadcast timer because our
> @@ -218,14 +217,10 @@ int cpuidle_enter_state(struct cpuidle_device *dev, struct cpuidle_driver *drv,
>   		local_irq_enable();
>
>   	/*
> -	 * local_clock() returns the time in nanosecond, let's shift
> -	 * by 10 (divide by 1024) to have microsecond based time.
> +	 * local_clock() returns the time in nanosecond, convert it to
> +	 * microsecond based time.
>   	 */
> -	diff = (time_end - time_start) >> 10;
> -	if (diff > INT_MAX)
> -		diff = INT_MAX;
> -
> -	dev->last_residency = (int) diff;
> +	dev->last_residency = convert_nsec_to_usec(time_end - time_start);
>
>   	if (entered_state >= 0) {
>   		/* Update cpuidle counters */
> diff --git a/drivers/cpuidle/cpuidle.h b/drivers/cpuidle/cpuidle.h
> index f87f399..c8ea5ad 100644
> --- a/drivers/cpuidle/cpuidle.h
> +++ b/drivers/cpuidle/cpuidle.h
> @@ -68,4 +68,27 @@ static inline void cpuidle_coupled_unregister_device(struct cpuidle_device *dev)
>   }
>   #endif
>
> +/*
> + * Used for calculating last_residency in usec. Optimized for case
> + * where last_residency in nsecs is < INT_MAX/2 by using faster
> + * approximation. Approximated value has less than 1% error.
> + */
> +static inline int convert_nsec_to_usec(u64 nsec)
> +{
> +	if (likely(nsec < INT_MAX / 2)) {

UINT_MAX ?

> +		int usec = (int)nsec;
> +
> +		usec += usec >> 5;
> +		usec = usec >> 10;
> +		return usec;
> +	} else {
> +		u64 usec = div_u64(nsec, 1000);
> +
> +		if (usec > INT_MAX)
> +			usec = INT_MAX;
> +		return (int)usec;
> +	}
> +}



-- 
  <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
