Return-Path: <peterz@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rNcwv6HDMzDqdZ
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Jun 2016 00:47:11 +1000 (AEST)
Date: Mon, 6 Jun 2016 16:46:59 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Will Deacon <will.deacon@arm.com>, Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH v3] powerpc: spinlock: Fix spin_unlock_wait()
Message-ID: <20160606144659.GG30909@twins.programming.kicks-ass.net>
References: <1465213340.2658.1.camel@ellerman.id.au>
 <20160606115655.GD30909@twins.programming.kicks-ass.net>
 <1465215445.2658.4.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1465215445.2658.4.camel@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jun 06, 2016 at 10:17:25PM +1000, Michael Ellerman wrote:
> On Mon, 2016-06-06 at 13:56 +0200, Peter Zijlstra wrote:
> > On Mon, Jun 06, 2016 at 09:42:20PM +1000, Michael Ellerman wrote:
> > > +static inline void arch_spin_unlock_wait(arch_spinlock_t *lock)
> > > +{
> > > +	arch_spinlock_t lock_val;
> > > +
> > > +	smp_mb();
> > > +
> > > +	/*
> > > +	 * Atomically load and store back the lock value (unchanged). This
> > > +	 * ensures that our observation of the lock value is ordered with
> > > +	 * respect to other lock operations.
> > > +	 */
> > > +	__asm__ __volatile__(
> > > +"1:	" PPC_LWARX(%0, 0, %2, 0) "\n"
> > > +"	stwcx. %0, 0, %2\n"
> > > +"	bne- 1b\n"
> > > +	: "=&r" (lock_val), "+m" (*lock)
> > > +	: "r" (lock)
> > > +	: "cr0", "xer");
> > > +
> > > +	if (arch_spin_value_unlocked(lock_val))
> > > +		goto out;
> > > +
> > > +	while (!arch_spin_value_unlocked(*lock)) {
> > > +		HMT_low();
> > > +		if (SHARED_PROCESSOR)
> > > +			__spin_yield(lock);
> > > +	}
> > > +	HMT_medium();
> > > +
> > > +out:
> > > +	smp_mb();
> > > +}
> > 
> > Why the move to in-line this implementation? It looks like a fairly big
> > function.
> 
> I agree it's not pretty.

> 
> I'm not beholden to v3 though if you hate it.

I don't mind; its just that I am in a similar boat with qspinlock and
chose the other option. So I just figured I'd ask :-)
