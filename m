Return-Path: <nicolas.pitre@linaro.org>
Received: from mail-qk0-x22a.google.com (mail-qk0-x22a.google.com
 [IPv6:2607:f8b0:400d:c09::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rgNvX1qbRzDrBQ
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Jul 2016 01:37:12 +1000 (AEST)
Received: by mail-qk0-x22a.google.com with SMTP id a125so152558127qkc.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 08:37:12 -0700 (PDT)
Date: Thu, 30 Jun 2016 11:37:08 -0400 (EDT)
From: Nicolas Pitre <nicolas.pitre@linaro.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
cc: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>, rjw@rjwysocki.net,
 linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, anton@samba.org,
 mpe@ellerman.id.au, bsingharora@gmail.com, David.Laight@ACULAB.COM,
 arnd@arndb.de
Subject: Re: [PATCH v4] cpuidle: Fix last_residency division
In-Reply-To: <5775335E.2040003@linaro.org>
Message-ID: <alpine.LFD.2.20.1606301132350.12094@knanqh.ubzr>
References: <1467297253-2171-1-git-send-email-shreyas@linux.vnet.ibm.com>
 <5775335E.2040003@linaro.org>
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

On Thu, 30 Jun 2016, Daniel Lezcano wrote:

> On 06/30/2016 04:34 PM, Shreyas B. Prabhu wrote:
> > Snooze is a poll idle state in powernv and pseries platforms. Snooze
> > has a timeout so that if a cpu stays in snooze for more than target
> > residency of the next available idle state, then it would exit thereby
> > giving chance to the cpuidle governor to re-evaluate and
> > promote the cpu to a deeper idle state. Therefore whenever snooze exits
> > due to this timeout, its last_residency will be target_residency of next
> > deeper state.
> >
> > commit e93e59ce5b85 ("cpuidle: Replace ktime_get() with local_clock()")
> > changed the math around last_residency calculation. Specifically, while
> > converting last_residency value from nanoseconds to microseconds it does
> > right shift by 10. Due to this, in snooze timeout exit scenarios
> > last_residency calculated is roughly 2.3% less than target_residency of
> > next available state. This pattern is picked up get_typical_interval()
> > in the menu governor and therefore expected_interval in menu_select() is
> > frequently less than the target_residency of any state but snooze.
> >
> > Due to this we are entering snooze at a higher rate, thereby affecting
> > the single thread performance.
> >
> > Fix this by using a better approximation for division by 1000.
> >
> > Reported-by: Anton Blanchard <anton@samba.org>
> > Bisected-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
> > Suggested-by David Laight <david.laight@aculab.com>
> > Signed-off-by: Shreyas B. Prabhu <shreyas@linux.vnet.ibm.com>
> > ---
> > Changes in v4
> > =============
> >   - Increasing the threshold upto which approximation can be used.
> >   - Removed explicit cast. Instead added a comment saying why cast
> >     is safe.
> >
> > Changes in v3
> > =============
> >   - Using approximation suggested by David
> >
> > Changes in v2
> > =============
> >   - Fixing it in the cpuidle core code instead of driver code.
> >
> >   drivers/cpuidle/cpuidle.c | 11 +++--------
> >   drivers/cpuidle/cpuidle.h | 38 ++++++++++++++++++++++++++++++++++++++
> >   2 files changed, 41 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> > index a4d0059..f55ad01 100644
> > --- a/drivers/cpuidle/cpuidle.c
> > +++ b/drivers/cpuidle/cpuidle.c
> > @@ -174,7 +174,6 @@ int cpuidle_enter_state(struct cpuidle_device *dev,
> > struct cpuidle_driver *drv,
> >    struct cpuidle_state *target_state = &drv->states[index];
> >    bool broadcast = !!(target_state->flags & CPUIDLE_FLAG_TIMER_STOP);
> >    u64 time_start, time_end;
> > -	s64 diff;
> >
> >    /*
> >   	 * Tell the time framework to switch to a broadcast timer because our
> > @@ -218,14 +217,10 @@ int cpuidle_enter_state(struct cpuidle_device *dev,
> > struct cpuidle_driver *drv,
> >     local_irq_enable();
> >
> >   	/*
> > -	 * local_clock() returns the time in nanosecond, let's shift
> > -	 * by 10 (divide by 1024) to have microsecond based time.
> > +	 * local_clock() returns the time in nanoseconds, convert it to
> > +	 * microsecond based time.
> >   	 */
> > -	diff = (time_end - time_start) >> 10;
> > -	if (diff > INT_MAX)
> > -		diff = INT_MAX;
> > -
> > -	dev->last_residency = (int) diff;
> > +	dev->last_residency = convert_nsec_to_usec(time_end - time_start);
> >
> >    if (entered_state >= 0) {
> >   		/* Update cpuidle counters */
> > diff --git a/drivers/cpuidle/cpuidle.h b/drivers/cpuidle/cpuidle.h
> > index f87f399..a027b35 100644
> > --- a/drivers/cpuidle/cpuidle.h
> > +++ b/drivers/cpuidle/cpuidle.h
> > @@ -68,4 +68,42 @@ static inline void
> > cpuidle_coupled_unregister_device(struct cpuidle_device *dev)
> >   }
> >   #endif
> >
> > +/*
> > + * To ensure that there is no overflow while approximation
> > + * for dividing val by 1000, we must respect -
> > + * val + (val >> 5) <= 0xFFFFFFFF
> > + * val + val/32 <= 0xFFFFFFFF
> > + * val <= (0xFFFFFFFF * 32) / 33
> > + * val <= 0xF83E0F82
> > + * Hence the threshold for val below which we can use the
> > + * approximation is 0xF83E0F82
> > + */
> > +#define DIV_APPROXIMATION_THRESHOLD 0xF83E0F82UL
> > +
> > +/*
> > + * Used for calculating last_residency in usec. Optimized for case
> > + * where last_residency in nsecs is < DIV_APPROXIMATION_THRESHOLD
> > + * Approximated value has less than 1% error.
> > + */
> > +static inline int convert_nsec_to_usec(u64 nsec)
> > +{
> > +	if (likely(nsec < DIV_APPROXIMATION_THRESHOLD)) {
> > +		u32 usec = nsec;
> > +
> > +		usec += usec >> 5;
> > +		usec = usec >> 10;
> > +
> > +		/* Can safely cast to int since usec is < INT_MAX */
> > +		return usec;
> > +	} else {
> > +		u64 usec = div_u64(nsec, 1000);
> > +
> > +		if (usec > INT_MAX)
> > +			usec = INT_MAX;
> > +
> > +		/* Can safely cast to int since usec is < INT_MAX */
> > +		return usec;
> > +	}
> > +}
> 
> 
> What bothers me with this division is the benefit of adding an extra ultra
> optimized division by 1000 in cpuidle.h while we have already ktime_divns
> which is optimized in ktime.h.

It is "optimized" but still much heavier than what is presented above as 
it provides maximum precision.

It all depends on how important the performance gain from the original 
shift by 10 was in the first place.


Nicolas
