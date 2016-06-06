Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rNYcF0Wf5zDqW5
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Jun 2016 22:17:33 +1000 (AEST)
Message-ID: <1465215445.2658.4.camel@ellerman.id.au>
Subject: Re: [PATCH v3] powerpc: spinlock: Fix spin_unlock_wait()
From: Michael Ellerman <mpe@ellerman.id.au>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linuxppc-dev@lists.ozlabs.org, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, "Paul E.
 McKenney" <paulmck@linux.vnet.ibm.com>, Will Deacon <will.deacon@arm.com>,
 Boqun Feng <boqun.feng@gmail.com>
Date: Mon, 06 Jun 2016 22:17:25 +1000
In-Reply-To: <20160606115655.GD30909@twins.programming.kicks-ass.net>
References: <1465213340.2658.1.camel@ellerman.id.au>
 <20160606115655.GD30909@twins.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-06-06 at 13:56 +0200, Peter Zijlstra wrote:
> On Mon, Jun 06, 2016 at 09:42:20PM +1000, Michael Ellerman wrote:
> > +static inline void arch_spin_unlock_wait(arch_spinlock_t *lock)
> > +{
> > +	arch_spinlock_t lock_val;
> > +
> > +	smp_mb();
> > +
> > +	/*
> > +	 * Atomically load and store back the lock value (unchanged). This
> > +	 * ensures that our observation of the lock value is ordered with
> > +	 * respect to other lock operations.
> > +	 */
> > +	__asm__ __volatile__(
> > +"1:	" PPC_LWARX(%0, 0, %2, 0) "\n"
> > +"	stwcx. %0, 0, %2\n"
> > +"	bne- 1b\n"
> > +	: "=&r" (lock_val), "+m" (*lock)
> > +	: "r" (lock)
> > +	: "cr0", "xer");
> > +
> > +	if (arch_spin_value_unlocked(lock_val))
> > +		goto out;
> > +
> > +	while (!arch_spin_value_unlocked(*lock)) {
> > +		HMT_low();
> > +		if (SHARED_PROCESSOR)
> > +			__spin_yield(lock);
> > +	}
> > +	HMT_medium();
> > +
> > +out:
> > +	smp_mb();
> > +}
> 
> Why the move to in-line this implementation? It looks like a fairly big
> function.

I agree it's not pretty.

I just didn't think having it out-of-line made it easier to understand. The
previous version had:

  static inline void arch_spin_unlock_wait(arch_spinlock_t *lock)
  {
  	...
  	if (!arch_spin_is_locked_sync(lock))
  		goto out;

Then elsewhere:

  static inline bool arch_spin_is_locked_sync(arch_spinlock_t *lock)
  {
  	...
  	return !arch_spin_value_unlocked(tmp);
  }


So two negations and one routine called "locked" and one "unlocked", which just
didn't read well IMHO.

Another minor concern was that someone might be "clever" and call the _sync()
version manually (though hopefully we'd catch that in review).

I'm not beholden to v3 though if you hate it.

cheers
