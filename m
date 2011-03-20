Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 39A82B6EEA
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 21 Mar 2011 10:54:04 +1100 (EST)
Subject: Re: mmotm threatens ppc preemption again
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Hugh Dickins <hughd@google.com>
In-Reply-To: <alpine.LSU.2.00.1103192041390.1592@sister.anvils>
References: <alpine.LSU.2.00.1103192041390.1592@sister.anvils>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 21 Mar 2011 10:53:08 +1100
Message-ID: <1300665188.2402.64.camel@pasglop>
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

On Sat, 2011-03-19 at 21:11 -0700, Hugh Dickins wrote:
> 
> As I warned a few weeks ago, Jeremy has vmalloc apply_to_pte_range
> patches in mmotm, which again assault PowerPC's expectations, and
> cause lots of noise with CONFIG_PREEMPT=y CONFIG_PREEMPT_DEBUG=y.
> 
> This time in vmalloc as well as vfree; and Peter's fix to the last
> lot, which went into 2.6.38, doesn't protect against these ones.
> Here's what I now see when I swapon and swapoff:

Right. And we said from day one we had the HARD WIRED assumption that
arch_enter/leave_lazy_mmu_mode() was ALWAYS going to be called within
a PTE lock section, and we did get reassurance that it was going to
remain so.

So why is it ok for them to change those and break us like that ?

Seriously, this is going out of control. If we can't even rely on
fundamental locking assumptions in the VM to remain reasonably stable
or at least get some amount of -care- from who changes them as to
whether they break others and work with us to fix them, wtf ?

I don't know what the right way to fix that is. We have an absolute
requirement that the batching we start within a lazy MMU section
is complete and flushed before any other PTE in that section can be
touched by anything else. Do we -at least- keep that guarantee ?

If yes, then maybe preempt_disable/enable() around
arch_enter/leave_lazy_mmu_mode() in apply_to_pte_range() would do... 

Or maybe I should just prevent any batching  of init_mm :-(

Cheers,
Ben.
