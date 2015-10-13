Return-Path: <will.deacon@arm.com>
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 3136C1A0291
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2015 01:43:36 +1100 (AEDT)
Date: Tue, 13 Oct 2015 15:43:33 +0100
From: Will Deacon <will.deacon@arm.com>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Gleixner <tglx@linutronix.de>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Waiman Long <waiman.long@hp.com>, Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [PATCH v3 6/6] powerpc: atomic: Implement cmpxchg{,64}_* and
 atomic{,64}_cmpxchg_* variants
Message-ID: <20151013144333.GN21550@arm.com>
References: <1444659246-24769-1-git-send-email-boqun.feng@gmail.com>
 <1444659246-24769-7-git-send-email-boqun.feng@gmail.com>
 <20151013132404.GI21550@arm.com>
 <20151013143259.GB23991@fixme-laptop.cn.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151013143259.GB23991@fixme-laptop.cn.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Oct 13, 2015 at 10:32:59PM +0800, Boqun Feng wrote:
> On Tue, Oct 13, 2015 at 02:24:04PM +0100, Will Deacon wrote:
> > On Mon, Oct 12, 2015 at 10:14:06PM +0800, Boqun Feng wrote:
> > > Implement cmpxchg{,64}_relaxed and atomic{,64}_cmpxchg_relaxed, based on
> > > which _release variants can be built.
> > > 
> > > To avoid superfluous barriers in _acquire variants, we implement these
> > > operations with assembly code rather use __atomic_op_acquire() to build
> > > them automatically.
> > 
> > The "superfluous barriers" are for the case where the cmpxchg fails, right?
> 
> Yes.
> 
> > And you don't do the same thing for release, because you want to avoid a
> > barrier in the middle of the critical section?
> > 
> 
> Mostly because of the comments in include/linux/atomic.h:
> 
>  * For compound atomics performing both a load and a store, ACQUIRE
>  * semantics apply only to the load and RELEASE semantics only to the
>  * store portion of the operation. Note that a failed cmpxchg_acquire
>  * does -not- imply any memory ordering constraints.
> 
> so I thought only the barrier in cmpxchg_acquire() is conditional, and
> the barrier in cmpxchg_release() is not. Maybe we'd better call it out
> that cmpxchg *family* doesn't have any order guarantee if cmp fails, as
> a complement of
> 
> ed2de9f74ecb ("locking/Documentation: Clarify failed cmpxchg() memory ordering semantics")
> 
> Because it seems this commit only claims that the barriers in fully
> ordered version are conditional.

I didn't think this was ambiguous... A failed cmpxchg_release doesn't
perform a store, so because the RELEASE semantics only apply to the
store portion of the operation, it therefore doesn't have any ordering
guarantees. Acquire is called out as a special case because it *does*
actually perform a load on the failure case.

> If cmpxchg_release doesn't have order guarantee when failed, I guess I
> can implement it with a barrier in the middle as you mentioned:
> 
> 	unsigned int prev;
> 
> 	__asm__ __volatile__ (
> "1:	lwarx	%0,0,%2		
> 	cmpw	0,%0,%3\n\
> 	bne-	2f\n"
> 	PPC_RELEASE_BARRIER
> "	stwcx.	%4,0,%2\n\
> 	bne-	1b"
> 	"\n\
> 2:"
> 	: "=&r" (prev), "+m" (*p)
> 	: "r" (p), "r" (old), "r" (new)
> 	: "cc", "memory");
> 
> 	return prev;
> 
> 
> However, I need to check whether the architecture allows this and any
> other problem exists.
> 
> Besides, I don't think it's a good idea to do the "put barrier in the
> middle" thing in this patchset, because that seems a premature
> optimization and if we go further, I guess we can also replace the
> PPC_RELEASE_BARRIER above with a "sync" to implement a fully ordered
> version cmpxchg(). Too much needs to investigate then..

Putting a barrier in the middle of that critical section is probably a
terrible idea, and that's why I thought you were avoiding it (hence my
original question). Perhaps just add a comment to that effect, since I
fear adding more words to memory-barriers.txt is just likely to create
further confusion.

Will
