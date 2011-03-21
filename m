Return-Path: <jeremy@goop.org>
Received: from claw.goop.org (claw.goop.org [74.207.240.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.goop.org", Issuer "Goop.org CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 4BD7EB6F2B
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 21 Mar 2011 22:30:16 +1100 (EST)
Message-ID: <4D873571.702@goop.org>
Date: Mon, 21 Mar 2011 11:24:33 +0000
From: Jeremy Fitzhardinge <jeremy@goop.org>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: mmotm threatens ppc preemption again
References: <alpine.LSU.2.00.1103192041390.1592@sister.anvils>
	<1300665188.2402.64.camel@pasglop>
In-Reply-To: <1300665188.2402.64.camel@pasglop>
Content-Type: text/plain; charset=UTF-8
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

On 03/20/2011 11:53 PM, Benjamin Herrenschmidt wrote:
> On Sat, 2011-03-19 at 21:11 -0700, Hugh Dickins wrote:
>> As I warned a few weeks ago, Jeremy has vmalloc apply_to_pte_range
>> patches in mmotm, which again assault PowerPC's expectations, and
>> cause lots of noise with CONFIG_PREEMPT=y CONFIG_PREEMPT_DEBUG=y.
>>
>> This time in vmalloc as well as vfree; and Peter's fix to the last
>> lot, which went into 2.6.38, doesn't protect against these ones.
>> Here's what I now see when I swapon and swapoff:
> Right. And we said from day one we had the HARD WIRED assumption that
> arch_enter/leave_lazy_mmu_mode() was ALWAYS going to be called within
> a PTE lock section, and we did get reassurance that it was going to
> remain so.
>
> So why is it ok for them to change those and break us like that ?

In general, the pagetable's locking rules are that all *usermode* pte
updates have to be done under a pte lock, but kernel mode ones do not;
they generally have some kind of per-subsystem ad-hoc locking where
needed, which may or may not be no-preempt.

Originally the enter/leave_lazy_mmu_mode did require preemption to be
disabled for the whole time, but that was incompatible with the above
locking rules, and resulted in preemption being disabled for long
periods when using lazy mode which wouldn't normally happen.  This
raised a number of complaints.

To address this, I changed the x86 implementation to deal with
preemption in lazy mode by dropping out for lazy mode at context switch
time (and recording the fact that we were in lazy mode with a TIF flag
and re-entering on the next context switch).


> Seriously, this is going out of control. If we can't even rely on
> fundamental locking assumptions in the VM to remain reasonably stable
> or at least get some amount of -care- from who changes them as to
> whether they break others and work with us to fix them, wtf ?
>
> I don't know what the right way to fix that is. We have an absolute
> requirement that the batching we start within a lazy MMU section
> is complete and flushed before any other PTE in that section can be
> touched by anything else. Do we -at least- keep that guarantee ?
>
> If yes, then maybe preempt_disable/enable() around
> arch_enter/leave_lazy_mmu_mode() in apply_to_pte_range() would do... 
>
> Or maybe I should just prevent any batching  of init_mm :-(

I'm very sorry about that, I didn't realize power was also using that
interface.  Unfortunately, the "no preemption" definition was an error,
and had to be changed to match the pre-existing locking rules.

Could you implement a similar "flush batched pte updates on context
switch" as x86?

    J
