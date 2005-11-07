Return-Path: <marcelo.tosatti@cyclades.com>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C80316867C
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  8 Nov 2005 09:04:36 +1100 (EST)
Date: Mon, 7 Nov 2005 15:02:37 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <20051107170237.GC17830@logos.cnet>
References: <200510302203.25390.pantelis.antoniou@gmail.com>
	<20051107084431.GA15180@logos.cnet>
	<1131396000.4652.24.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1131396000.4652.24.camel@gaston>
Cc: linuxppc-embedded@ozlabs.org, Dan Malek <dan@embeddedalley.com>
Subject: Re: [PATCH 2.6.14] mm: 8xx MM fix for
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, Nov 08, 2005 at 07:39:59AM +1100, Benjamin Herrenschmidt wrote:
> On Mon, 2005-11-07 at 06:44 -0200, Marcelo Tosatti wrote:
> 
> > 
> > The bug is that the zeroed TLB is not invalidated (the same reason
> > for the "dcbst" misbehaviour), resulting in infinite TLBError faults.
> 
> I see, so you are in the same situation as ia64 which has valid but
> unmapped TLBs ?
> 
> > Dan, I wonder why we just don't go back to v2.4 behaviour. It is not very
> > clear to me that "two exception" speedup offsets the additional code required
> > for "one exception" version. Have you actually done any measurements? 
> 
> What do you mean by "one exception" version ? You probably get 3 in fact
> since after you have serviced the fault in the common code, you take
> another fault to fill the PTE.

Yep, that would be 3!

> In fact, you could even go back to one exception by pre-filling the TLB
> in update_mmu_cache :)

OK, thats a good idea as we talked on IRC. Working on that.

> > There is chance that the additional code ends up in the same cacheline,
> > which would mean no huge gain by the "two exception" approach. Might be
> > even harmful for performance (you need two exceptions instead of one
> > after all).
> > 
> > The "two exception" approach requires a TLB flush (to nuke the zeroed)
> > at each PTE update for correct behaviour (which BTW is another slowdown):
> 
> I think the current code, even with your fix, is sub-optimal. But of
> course, the only way to be sure is to do real measurements

Indeed.

Thanks!
