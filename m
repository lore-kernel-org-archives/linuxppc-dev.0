Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4171E1007D7
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 27 Apr 2011 23:26:59 +1000 (EST)
Subject: RE: [PATCH V4] POWER: perf_event: Skip updating kernel counters if
	register value shrinks
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Laight <David.Laight@ACULAB.COM>
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6D8ACFA@saturn3.aculab.com>
References: <AE90C24D6B3A694183C094C60CF0A2F6D8ACFA@saturn3.aculab.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 27 Apr 2011 23:26:32 +1000
Message-ID: <1303910792.2513.176.camel@pasglop>
Mime-Version: 1.0
Cc: a.p.zijlstra@chello.nl, linux-kernel@vger.kernel.org, paulus@samba.org,
	Eric B Munson <emunson@mgebm.net>, acme@ghostprotocols.net,
	mingo@elte.hu, linuxppc-dev@lists.ozlabs.org, stable@kernel.org,
	anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2011-04-27 at 08:40 +0100, David Laight wrote:
> I keep telling Eric that the code below is incorrect
> modulo arithimetic...

His previous versions were wrong yes. This one should be limping along
afaik. But I tend to agree, testing delta is the way to go.

Eric idea was to not test the sign bit to allow for bigger increments of
the counter, since the rollback is limited to 255... But I agree it's
non obvious.

I've put the patch in for now, we can always followup with something
better.

Cheers,
Ben.

> > +static u64 check_and_compute_delta(u64 prev, u64 val)
> > +{
> > +	u64 delta = (val - prev) & 0xfffffffful;
> > +
> > +	/*
> > +	 * POWER7 can roll back counter values, if the new value is
> smaller
> > +	 * than the previous value it will cause the delta and the
> counter to
> > +	 * have bogus values unless we rolled a counter over.  If a
> coutner is
> > +	 * rolled back, it will be smaller, but within 256, which is the
> maximum
> > +	 * number of events to rollback at once.  If we dectect a
> rollback
> > +	 * return 0.  This can lead to a small lack of precision in the
> > +	 * counters.
> > +	 */
> > +	if (prev > val && (prev - val) < 256)
> > +		delta = 0;
> > +
> > +	return delta;
> 
> The code should detect rollback by looking at the value of 'delta'
> otherwise there are horrid end effects near 2^32-1.
> 
> For instance:
> 	u32 delta = val - prev;
> 	return delta & 0x80000000 ? 0 : delta;
> 
> 
>    David
> 
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
