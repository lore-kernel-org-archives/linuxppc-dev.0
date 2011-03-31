Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6B56EB6F0D
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 31 Mar 2011 17:05:03 +1100 (EST)
Subject: Re: [PATCH] POWER: perf_event: Skip updating kernel counters if
	register value shrinks
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Eric B Munson <emunson@mgebm.net>
In-Reply-To: <20110330183656.GA2564@mgebm.net>
References: <1301059689-4556-1-git-send-email-emunson@mgebm.net>
	<1301378637.2402.671.camel@pasglop> <20110329142519.GA3527@mgebm.net>
	<1301433165.2402.689.camel@pasglop> <20110330183656.GA2564@mgebm.net>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 31 Mar 2011 17:04:36 +1100
Message-ID: <1301551476.2407.61.camel@pasglop>
Mime-Version: 1.0
Cc: a.p.zijlstra@chello.nl, linux-kernel@vger.kernel.org, paulus@samba.org,
	anton@samba.org, acme@ghostprotocols.net, mingo@elte.hu,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2011-03-30 at 14:36 -0400, Eric B Munson wrote:
> On Wed, 30 Mar 2011, Benjamin Herrenschmidt wrote:
> 
> > On Tue, 2011-03-29 at 10:25 -0400, Eric B Munson wrote:
> > > Here I made the assumption that the hardware would never remove more events in
> > > a speculative roll back than it had added.  This is not a situation I
> > > encoutered in my limited testing, so I didn't think underflow was possible.  I
> > > will send out a V2 using the signed 32 bit delta and remeber to CC stable
> > > this time. 
> > 
> > I'm not thinking about underflow but rollover... or that isn't possible
> > with those counters ? IE. They don't wrap back to 0 after hitting
> > ffffffff ?
> > 
> 
> They do roll over to 0 after ffffffff, but I thought that case was already
> covered by the perf_event_interrupt.  Are you concerned that we will reset a
> counter and speculative roll back will underflow that counter?

No, but take this part of the patch:

> --- a/arch/powerpc/kernel/perf_event.c
> +++ b/arch/powerpc/kernel/perf_event.c
> @@ -416,6 +416,15 @@ static void power_pmu_read(struct perf_event *event)
>  		prev = local64_read(&event->hw.prev_count);
>  		barrier();
>  		val = read_pmc(event->hw.idx);
> +		/*
> +		 * POWER7 can roll back counter values, if the new value is
> +		 * smaller than the previous value it will cause the delta
> +		 * and the counter to have bogus values.  If this is the
> +		 * case skip updating anything until the counter grows again.
> +		 * This can lead to a small lack of precision in the counters.
> +		 */
> +		if (val < prev)
> +			return;
>  	} while (local64_cmpxchg(&event->hw.prev_count, prev, val) != prev);

Doesn't that mean that power_pmu_read() can only ever increase the value of
the perf_event and so will essentially -stop- once the counter rolls over ?

Similar comments every where you do this type of comparison.

Cheers,
Ben.
