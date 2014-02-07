Return-Path: <duwe@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id DBFF62C0079
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Feb 2014 04:55:10 +1100 (EST)
Date: Fri, 7 Feb 2014 18:55:05 +0100
From: Torsten Duwe <duwe@lst.de>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2] powerpc ticket locks
Message-ID: <20140207175505.GE2107@lst.de>
References: <20140207165801.GC2107@lst.de>
 <20140207171224.GR5002@laptop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140207171224.GR5002@laptop.programming.kicks-ass.net>
Cc: Tom Musta <tommusta@gmail.com>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 Scott Wood <scottwood@freescale.com>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Ingo Molnar <mingo@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Feb 07, 2014 at 06:12:24PM +0100, Peter Zijlstra wrote:
> On Fri, Feb 07, 2014 at 05:58:01PM +0100, Torsten Duwe wrote:
> > +static __always_inline void arch_spin_lock(arch_spinlock_t *lock)
> >  {
> > +	register struct __raw_tickets old, tmp,
> > +		inc = { .tail = TICKET_LOCK_INC };
> > +
> >  	CLEAR_IO_SYNC;
> > +	__asm__ __volatile__(
> > +"1:	lwarx	%0,0,%4		# arch_spin_lock\n"
> > +"	add	%1,%3,%0\n"
> > +	PPC405_ERR77(0, "%4")
> > +"	stwcx.	%1,0,%4\n"
> > +"	bne-	1b"
> > +	: "=&r" (old), "=&r" (tmp), "+m" (lock->tickets)
> > +	: "r" (inc), "r" (&lock->tickets)
> > +	: "cc");
> > +
> > +	if (likely(old.head == old.tail))
> > +		goto out;
> 
> I would have expected an lwsync someplace hereabouts.

Let me reconsider this. The v1 code worked on an 8 core,
maybe I didn't beat it enough.

> >  static inline void arch_spin_unlock(arch_spinlock_t *lock)
> >  {
> > +	arch_spinlock_t old, new;
> > +
> > +#if defined(CONFIG_PPC_SPLPAR)
> > +	lock->holder = 0;
> > +#endif
> > +	do {
> > +		old.tickets = ACCESS_ONCE(lock->tickets);
> > +		new.tickets.head = old.tickets.head + TICKET_LOCK_INC;
> > +		new.tickets.tail = old.tickets.tail;
> > +	} while (unlikely(__arch_spin_cmpxchg_eq(lock,
> > +						 old.head_tail,
> > +						 new.head_tail)));
> >  	SYNC_IO;
> >  	__asm__ __volatile__("# arch_spin_unlock\n\t"
> >  				PPC_RELEASE_BARRIER: : :"memory");
> 
> Doens't your cmpxchg_eq not already imply a lwsync?

Right.

> > -	lock->slock = 0;
> >  }
> 
> I'm still failing to see why you need an ll/sc pair for unlock.

Like so:
static inline void arch_spin_unlock(arch_spinlock_t *lock)
{
	arch_spinlock_t tmp;

#if defined(CONFIG_PPC_SPLPAR)
	lock->holder = 0;
#endif
	tmp.tickets = ACCESS_ONCE(lock->tickets);
	tmp.tickets.head += TICKET_LOCK_INC;
	lock->tickets.head = tmp.tickets.head;
	SYNC_IO;
	__asm__ __volatile__("# arch_spin_unlock\n\t"
				PPC_RELEASE_BARRIER: : :"memory");
}
?

I'll wrap it all up next week. I only wanted to post an updated v2
with the agreed-upon changes for BenH.

Thanks so far!

	Torsten
