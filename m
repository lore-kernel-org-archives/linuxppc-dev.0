Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e9.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id EEDF02C008E
 for <linuxppc-dev@ozlabs.org>; Sat, 22 Dec 2012 12:08:12 +1100 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Fri, 21 Dec 2012 20:08:08 -0500
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id D14FB6E8059
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Dec 2012 20:08:02 -0500 (EST)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 qBM183k5349102
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Dec 2012 20:08:03 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 qBM182ea015299
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Dec 2012 23:08:02 -0200
Date: Fri, 21 Dec 2012 17:07:50 -0800
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH 1/2] powerpc/perf: Fix finding overflowed PMC in interrupt
Message-ID: <20121222010750.GA17237@us.ibm.com>
References: <20120921003805.GA4507@us.ibm.com>
 <1352164118-19450-1-git-send-email-mikey@neuling.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1352164118-19450-1-git-send-email-mikey@neuling.org>
Cc: Linux PPC dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
 Anton Blanchard <anton@samba.org>,
 Benjamin Herrenschmidt <^Cnh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ben

Will these two patches be pushed upstream or are they waiting for
review/test ?

They fix a hang that we get with some perf events.

Thanks,

Sukadev


Michael Neuling [mikey@neuling.org] wrote:
| If a PMC is about to overflow on a counter that's on an active perf event
| (ie. less than 256 from the end) and a _different_ PMC overflows just at this
| time (a PMC that's not on an active perf event), we currently mark the event as
| found, but in reality it's not as it's likely the other PMC that caused the
| IRQ.  Since we mark it as found the second catch all for overflows doesn't run,
| and we don't reset the overflowing PMC ever.  Hence we keep hitting that same
| PMC IRQ over and over and don't reset the actual overflowing counter.
| 
| This is a rewrite of the perf interrupt handler for book3s to get around this.
| We now check to see if any of the PMCs have actually overflowed (ie >=
| 0x80000000).  If yes, record it for active counters and just reset it for
| inactive counters.  If it's not overflowed, then we check to see if it's one of
| the buggy power7 counters and if it is, record it and continue.  If none of the
| PMCs match this, then we make note that we couldn't find the PMC that caused
| the IRQ.
| 
| Signed-off-by: Michael Neuling <mikey@neuling.org>
| Reviewed-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
| cc: Paul Mackerras <paulus@samba.org>
| cc: Anton Blanchard <anton@samba.org>
| cc: Linux PPC dev <linuxppc-dev@ozlabs.org>
| ---
|  arch/powerpc/perf/core-book3s.c |   83 +++++++++++++++++++++++++--------------
|  1 file changed, 54 insertions(+), 29 deletions(-)
| 
| diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
| index aa2465e..3575def 100644
| --- a/arch/powerpc/perf/core-book3s.c
| +++ b/arch/powerpc/perf/core-book3s.c
| @@ -1412,11 +1412,8 @@ unsigned long perf_instruction_pointer(struct pt_regs *regs)
|  		return regs->nip;
|  }
| 
| -static bool pmc_overflow(unsigned long val)
| +static bool pmc_overflow_power7(unsigned long val)
|  {
| -	if ((int)val < 0)
| -		return true;
| -
|  	/*
|  	 * Events on POWER7 can roll back if a speculative event doesn't
|  	 * eventually complete. Unfortunately in some rare cases they will
| @@ -1428,7 +1425,15 @@ static bool pmc_overflow(unsigned long val)
|  	 * PMCs because a user might set a period of less than 256 and we
|  	 * don't want to mistakenly reset them.
|  	 */
| -	if (pvr_version_is(PVR_POWER7) && ((0x80000000 - val) <= 256))
| +	if ((0x80000000 - val) <= 256)
| +		return true;
| +
| +	return false;
| +}
| +
| +static bool pmc_overflow(unsigned long val)
| +{
| +	if ((int)val < 0)
|  		return true;
| 
|  	return false;
| @@ -1439,11 +1444,11 @@ static bool pmc_overflow(unsigned long val)
|   */
|  static void perf_event_interrupt(struct pt_regs *regs)
|  {
| -	int i;
| +	int i, j;
|  	struct cpu_hw_events *cpuhw = &__get_cpu_var(cpu_hw_events);
|  	struct perf_event *event;
| -	unsigned long val;
| -	int found = 0;
| +	unsigned long val[8];
| +	int found, active;
|  	int nmi;
| 
|  	if (cpuhw->n_limited)
| @@ -1458,33 +1463,53 @@ static void perf_event_interrupt(struct pt_regs *regs)
|  	else
|  		irq_enter();
| 
| -	for (i = 0; i < cpuhw->n_events; ++i) {
| -		event = cpuhw->event[i];
| -		if (!event->hw.idx || is_limited_pmc(event->hw.idx))
| +	/* Read all the PMCs since we'll need them a bunch of times */
| +	for (i = 0; i < ppmu->n_counter; ++i)
| +		val[i] = read_pmc(i + 1);
| +
| +	/* Try to find what caused the IRQ */
| +	found = 0;
| +	for (i = 0; i < ppmu->n_counter; ++i) {
| +		if (!pmc_overflow(val[i]))
|  			continue;
| -		val = read_pmc(event->hw.idx);
| -		if ((int)val < 0) {
| -			/* event has overflowed */
| -			found = 1;
| -			record_and_restart(event, val, regs);
| +		if (is_limited_pmc(i + 1))
| +			continue; /* these won't generate IRQs */
| +		/*
| +		 * We've found one that's overflowed.  For active
| +		 * counters we need to log this.  For inactive
| +		 * counters, we need to reset it anyway
| +		 */
| +		found = 1;
| +		active = 0;
| +		for (j = 0; j < cpuhw->n_events; ++j) {
| +			event = cpuhw->event[j];
| +			if (event->hw.idx == (i + 1)) {
| +				active = 1;
| +				record_and_restart(event, val[i], regs);
| +				break;
| +			}
|  		}
| +		if (!active)
| +			/* reset non active counters that have overflowed */
| +			write_pmc(i + 1, 0);
|  	}
| -
| -	/*
| -	 * In case we didn't find and reset the event that caused
| -	 * the interrupt, scan all events and reset any that are
| -	 * negative, to avoid getting continual interrupts.
| -	 * Any that we processed in the previous loop will not be negative.
| -	 */
| -	if (!found) {
| -		for (i = 0; i < ppmu->n_counter; ++i) {
| -			if (is_limited_pmc(i + 1))
| +	if (!found && pvr_version_is(PVR_POWER7)) {
| +		/* check active counters for special buggy p7 overflow */
| +		for (i = 0; i < cpuhw->n_events; ++i) {
| +			event = cpuhw->event[i];
| +			if (!event->hw.idx || is_limited_pmc(event->hw.idx))
|  				continue;
| -			val = read_pmc(i + 1);
| -			if (pmc_overflow(val))
| -				write_pmc(i + 1, 0);
| +			if (pmc_overflow_power7(val[event->hw.idx - 1])) {
| +				/* event has overflowed in a buggy way*/
| +				found = 1;
| +				record_and_restart(event,
| +						   val[event->hw.idx - 1],
| +						   regs);
| +			}
|  		}
|  	}
| +	if (!found)
| +		printk(KERN_WARNING "Can't find PMC that caused IRQ\n");
| 
|  	/*
|  	 * Reset MMCR0 to its normal value.  This will set PMXE and
| -- 
| 1.7.9.5
