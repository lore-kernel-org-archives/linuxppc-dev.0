Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 808F1B6F74
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 22 Mar 2011 09:53:11 +1100 (EST)
Subject: Re: mmotm threatens ppc preemption again
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jeremy Fitzhardinge <jeremy@goop.org>
In-Reply-To: <4D873571.702@goop.org>
References: <alpine.LSU.2.00.1103192041390.1592@sister.anvils>
	<1300665188.2402.64.camel@pasglop>  <4D873571.702@goop.org>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 22 Mar 2011 09:52:22 +1100
Message-ID: <1300747942.2402.262.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	Hugh Dickins <hughd@google.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2011-03-21 at 11:24 +0000, Jeremy Fitzhardinge wrote:
> 
> I'm very sorry about that, I didn't realize power was also using that
> interface.  Unfortunately, the "no preemption" definition was an error,
> and had to be changed to match the pre-existing locking rules.
> 
> Could you implement a similar "flush batched pte updates on context
> switch" as x86? 

Well, we already do that for -rt & co.

However, we have another issue which is the reason we used those
lazy_mmu hooks to do our flushing.

Our PTEs eventually get faulted into a hash table which is what the real
MMU uses. We must never (ever) allow that hash table to contain a
duplicate entry for a given virtual address.

When we do a batch, we remove things from the linux PTE, and keep a
reference in our batch structure, and only update the hash table at the
end of the batch.

That means that we must not allow a hash fault to populate the hash with
a "new" PTE value prior to the old one having been flushed out (which is
possible if they different in protection attributes for example). For
that to happen, we must basically not allow a page fault to re-populate
a PTE invalidated by a batch before that batch has completed.

That translates to batches must only happen within a PTE lock section.

Cheers,
Ben.
