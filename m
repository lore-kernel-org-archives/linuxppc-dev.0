Return-Path: <davidlohr@hp.com>
Received: from g4t3426.houston.hp.com (g4t3426.houston.hp.com [15.201.208.54])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 7726B2C00AD
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Mar 2014 05:03:36 +1100 (EST)
Message-ID: <1395338607.14694.23.camel@buesod1.americas.hpqcorp.net>
Subject: Re: Tasks stuck in futex code (in 3.14-rc6)
From: Davidlohr Bueso <davidlohr@hp.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 20 Mar 2014 11:03:27 -0700
In-Reply-To: <CA+55aFw-gGQ5hTdVPovpRgcEHGyhf3YDzoSLpavzP4SefkkBDg@mail.gmail.com>
References: <20140319152619.GB10406@linux.vnet.ibm.com>
 <20140319154705.GB8557@laptop.programming.kicks-ass.net>
 <20140319170829.GD8557@laptop.programming.kicks-ass.net>
 <20140320053350.GB30295@linux.vnet.ibm.com>
 <1395295019.2612.11.camel@buesod1.americas.hpqcorp.net>
 <CA+55aFzP60Ucn0snFchHNw2tOnS6HYp-6n+f+9nxrbTPw8fTfQ@mail.gmail.com>
 <1395335909.14694.15.camel@buesod1.americas.hpqcorp.net>
 <CA+55aFw-gGQ5hTdVPovpRgcEHGyhf3YDzoSLpavzP4SefkkBDg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
 Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>,
 Paul Mackerras <paulus@samba.org>, Thomas Gleixner <tglx@linutronix.de>,
 Paul McKenney <paulmck@linux.vnet.ibm.com>,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>, Ingo Molnar <mingo@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-03-20 at 10:42 -0700, Linus Torvalds wrote:
> On Thu, Mar 20, 2014 at 10:18 AM, Davidlohr Bueso <davidlohr@hp.com> wrote:
> >> It strikes me that the "spin_is_locked()" test has no barriers wrt the
> >> writing of the new futex value on the wake path. And the read barrier
> >> obviously does nothing wrt the write either. Or am I missing
> >> something? So the write that actually released the futex might be
> >> almost arbitrarily delayed on the waking side. So the waiting side may
> >> not see the new value, even though the waker assumes it does due to
> >> the ordering of it doing the write first.
> >
> > Aha, that would certainly violate the ordering guarantees. I feared
> > _something_ like that when we originally discussed your suggestion as
> > opposed to the atomics one, but didn't have any case for it either.
> 
> Actually, looking closer, we have the memory barrier in
> get_futex_key_refs() (called by "get_futex_key()") so that's not it.
> In fact, your "atomic_read(&hb->waiters)" doesn't have any more
> serialization than the spin_is_locked() test had.
> 
> But the spin_is_locked() and queue-empty tests are two separate memory
> reads, and maybe there is some ordering wrt those two that we missed,
> so the "waiters" patch is worth trying anyway.

Well, imho we would have seen something wrong much much earlier. This
patch has been very heavily tested (including with the java workload
used by Shrikar). 

I still wonder about ppc and spinlocks (no ticketing!!) ... sure the
"waiters" patch might fix the problem just because we explicitly count
the members of the plist. And I guess if we cannot rely on all archs
having an equivalent spinlock implementation, we simply cannot use this
technique for futexes.

Thanks,
Davidlohr
