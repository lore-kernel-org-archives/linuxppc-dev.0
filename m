Return-Path: <nicolas.pitre@linaro.org>
Received: from mail-qk0-x233.google.com (mail-qk0-x233.google.com
 [IPv6:2607:f8b0:400d:c09::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rgNjG72cVzDr5H
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Jul 2016 01:28:18 +1000 (AEST)
Received: by mail-qk0-x233.google.com with SMTP id a125so152029745qkc.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 08:28:18 -0700 (PDT)
Date: Thu, 30 Jun 2016 11:28:14 -0400 (EDT)
From: Nicolas Pitre <nicolas.pitre@linaro.org>
To: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
cc: rjw@rjwysocki.net, Daniel Lezcano <daniel.lezcano@linaro.org>,
 linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, anton@samba.org,
 mpe@ellerman.id.au, bsingharora@gmail.com, David.Laight@ACULAB.COM,
 Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] cpuidle: Fix last_residency division
In-Reply-To: <1467296844-2055-1-git-send-email-shreyas@linux.vnet.ibm.com>
Message-ID: <alpine.LFD.2.20.1606301123430.12094@knanqh.ubzr>
References: <1467296844-2055-1-git-send-email-shreyas@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 30 Jun 2016, Shreyas B. Prabhu wrote:

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

Minor nit:

> +/*
> + * To ensure that there is no overflow while approximation
> + * for dividing val by 1000, we must respect -
> + * val + (val >> 5) <= 0xFFFFFFFF
> + * val + val/32 <= 0xFFFFFFFF
> + * val <= (0xFFFFFFFF * 32) / 33
> + * val <= 0xF83E0F82
> + * Hence the threshold for val below which we can use the
> + * approximation is 0xF83E0F82
> + */
> +#define DIV_APPROXIMATION_THRESHOLD 0xF83E0F82UL
> +
> +/*
> + * Used for calculating last_residency in usec. Optimized for case
> + * where last_residency in nsecs is < DIV_APPROXIMATION_THRESHOLD
> + * Approximated value has less than 1% error.
> + */
> +static inline int convert_nsec_to_usec(u64 nsec)
> +{
> +	if (likely(nsec < DIV_APPROXIMATION_THRESHOLD)) {

To be coherent with the comment, you could use <= instead.

Then you may add:

Reviewed-by: Nicolas Pitre <nico@linaro.org>


Nicolas
