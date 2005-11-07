Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 38EA568698
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  8 Nov 2005 07:40:24 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
In-Reply-To: <20051107084431.GA15180@logos.cnet>
References: <200510302203.25390.pantelis.antoniou@gmail.com>
	<20051107084431.GA15180@logos.cnet>
Content-Type: text/plain
Date: Tue, 08 Nov 2005 07:39:59 +1100
Message-Id: <1131396000.4652.24.camel@gaston>
Mime-Version: 1.0
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

On Mon, 2005-11-07 at 06:44 -0200, Marcelo Tosatti wrote:

> 
> The bug is that the zeroed TLB is not invalidated (the same reason
> for the "dcbst" misbehaviour), resulting in infinite TLBError faults.

I see, so you are in the same situation as ia64 which has valid but
unmapped TLBs ?

> Dan, I wonder why we just don't go back to v2.4 behaviour. It is not very
> clear to me that "two exception" speedup offsets the additional code required
> for "one exception" version. Have you actually done any measurements? 

What do you mean by "one exception" version ? You probably get 3 in fact
since after you have serviced the fault in the common code, you take
another fault to fill the PTE.

In fact, you could even go back to one exception by pre-filling the TLB
in update_mmu_cache :)

> There is chance that the additional code ends up in the same cacheline,
> which would mean no huge gain by the "two exception" approach. Might be
> even harmful for performance (you need two exceptions instead of one
> after all).
> 
> The "two exception" approach requires a TLB flush (to nuke the zeroed)
> at each PTE update for correct behaviour (which BTW is another slowdown):

I think the current code, even with your fix, is sub-optimal. But of
course, the only way to be sure is to do real measurements

Ben.
