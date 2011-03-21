Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E0662B6F14
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 21 Mar 2011 12:51:00 +1100 (EST)
Subject: Re: mmotm threatens ppc preemption again
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Hugh Dickins <hughd@google.com>
In-Reply-To: <alpine.LSU.2.00.1103201814320.7035@sister.anvils>
References: <alpine.LSU.2.00.1103192041390.1592@sister.anvils>
	<1300665188.2402.64.camel@pasglop>
	<alpine.LSU.2.00.1103201814320.7035@sister.anvils>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 21 Mar 2011 12:50:07 +1100
Message-ID: <1300672207.2402.205.camel@pasglop>
Mime-Version: 1.0
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, linuxppc-dev@lists.ozlabs.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2011-03-20 at 18:41 -0700, Hugh Dickins wrote:
> > I don't know what the right way to fix that is. We have an absolute
> > requirement that the batching we start within a lazy MMU section
> > is complete and flushed before any other PTE in that section can be
> > touched by anything else. Do we -at least- keep that guarantee ?
> 
> I'm guessing it's a guarantee of the same kind as led me to skip
> page_table_lock on init_mm in 2.6.15: no locking to guarantee it,
> but it would have to be a kernel bug, in a driver or wherever,
> for us to be accessing such a section while it was in transit
> (short of speculative access prior to tlb flush).

As long as the races to avoid are between map/unmap vs. access, yes, it
-should- be fine, and we used to not do demand faulting on kernel space
(but for how long ?). I'm wondering why we don't just stick a ptl in
there or is there a good reason why we can't ?

> I don't see where you're doing batching on init_mm today:
> it looks as if Jeremy's patches, by using the same code as he has
> for user mms, are now enabling batching on init_mm, and you should :-)
> 
> But I may be all wrong: it's between you and Jeremy,
> and until he defends them, his patches should not go forward. 

We don't do it today (batching). Jeremy's patches have the side effect
of "enabling" it, which isn't wrong per-se ... but on our side relies on
some locking assumptions we are missing.

Cheers,
Ben.
