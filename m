Return-Path: <hughd@google.com>
Received: from smtp-out.google.com (smtp-out.google.com [216.239.44.51])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 243BEB6F01
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 21 Mar 2011 12:42:14 +1100 (EST)
Received: from kpbe15.cbf.corp.google.com (kpbe15.cbf.corp.google.com
	[172.25.105.79]) by smtp-out.google.com with ESMTP id p2L1g7hq008955
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 20 Mar 2011 18:42:08 -0700
Received: from iwn9 (iwn9.prod.google.com [10.241.68.73])
	by kpbe15.cbf.corp.google.com with ESMTP id p2L1efHG001500
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 20 Mar 2011 18:42:06 -0700
Received: by iwn9 with SMTP id 9so7412078iwn.23
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 20 Mar 2011 18:42:06 -0700 (PDT)
Date: Sun, 20 Mar 2011 18:41:56 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: mmotm threatens ppc preemption again
In-Reply-To: <1300665188.2402.64.camel@pasglop>
Message-ID: <alpine.LSU.2.00.1103201814320.7035@sister.anvils>
References: <alpine.LSU.2.00.1103192041390.1592@sister.anvils>
	<1300665188.2402.64.camel@pasglop>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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

On Mon, 21 Mar 2011, Benjamin Herrenschmidt wrote:
> On Sat, 2011-03-19 at 21:11 -0700, Hugh Dickins wrote:
> > 
> > As I warned a few weeks ago, Jeremy has vmalloc apply_to_pte_range
> > patches in mmotm, which again assault PowerPC's expectations, and
> > cause lots of noise with CONFIG_PREEMPT=y CONFIG_PREEMPT_DEBUG=y.
> > 
> > This time in vmalloc as well as vfree; and Peter's fix to the last
> > lot, which went into 2.6.38, doesn't protect against these ones.
> > Here's what I now see when I swapon and swapoff:
> 
> Right. And we said from day one we had the HARD WIRED assumption that
> arch_enter/leave_lazy_mmu_mode() was ALWAYS going to be called within
> a PTE lock section, and we did get reassurance that it was going to
> remain so.
> 
> So why is it ok for them to change those and break us like that ?

It's not ok.  Sounds like Andrew should not forward

mm-remove-unused-token-argument-from-apply_to_page_range-callback.patch
mm-add-apply_to_page_range_batch.patch
ioremap-use-apply_to_page_range_batch-for-ioremap_page_range.patch
vmalloc-use-plain-pte_clear-for-unmaps.patch
vmalloc-use-apply_to_page_range_batch-for-vunmap_page_range.patch
vmalloc-use-apply_to_page_range_batch-for-vmap_page_range_noflush.patch
vmalloc-use-apply_to_page_range_batch-in-alloc_vm_area.patch
xen-mmu-use-apply_to_page_range_batch-in-xen_remap_domain_mfn_range.patch
xen-grant-table-use-apply_to_page_range_batch.patch

or some subset (the vmalloc-use-apply ones? and the ioremap one?)
of that set to Linus for 2.6.39.  Your call.

> 
> Seriously, this is going out of control. If we can't even rely on
> fundamental locking assumptions in the VM to remain reasonably stable
> or at least get some amount of -care- from who changes them as to
> whether they break others and work with us to fix them, wtf ?

I know next to nothing of arch_enter/leave_lazy_mmu_mode(),
and the same is probably true of most mm developers.  The only
people who have it defined to anything interesting appear to be
powerpc and xen and lguest: so it would be a gentleman's agreement
between you and Jeremy and Rusty.

If Jeremy has changed the rules without your agreement, then you
can fight a duel at daybreak, or, since your daybreaks are at
different times, Jeremy's patches just shouldn't go forward yet.

> 
> I don't know what the right way to fix that is. We have an absolute
> requirement that the batching we start within a lazy MMU section
> is complete and flushed before any other PTE in that section can be
> touched by anything else. Do we -at least- keep that guarantee ?

I'm guessing it's a guarantee of the same kind as led me to skip
page_table_lock on init_mm in 2.6.15: no locking to guarantee it,
but it would have to be a kernel bug, in a driver or wherever,
for us to be accessing such a section while it was in transit
(short of speculative access prior to tlb flush).

> 
> If yes, then maybe preempt_disable/enable() around
> arch_enter/leave_lazy_mmu_mode() in apply_to_pte_range() would do... 
> 
> Or maybe I should just prevent any batching  of init_mm :-(

I don't see where you're doing batching on init_mm today:
it looks as if Jeremy's patches, by using the same code as he has
for user mms, are now enabling batching on init_mm, and you should :-)

But I may be all wrong: it's between you and Jeremy,
and until he defends them, his patches should not go forward.

Hugh
