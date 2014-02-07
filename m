Return-Path: <peterz@infradead.org>
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:4978:20e::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 8B4DD2C00A1
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Feb 2014 02:18:58 +1100 (EST)
Date: Fri, 7 Feb 2014 16:18:47 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Torsten Duwe <duwe@lst.de>
Subject: Re: [PATCH] Convert powerpc simple spinlocks into ticket locks
Message-ID: <20140207151847.GB3104@twins.programming.kicks-ass.net>
References: <20140206103736.GA18054@lst.de>
 <20140206163837.GT2936@laptop.programming.kicks-ass.net>
 <20140206173727.GA13048@lst.de>
 <1391717992.6733.232.camel@snotra.buserror.net>
 <20140207090248.GB26811@lst.de>
 <20140207103139.GP5002@laptop.programming.kicks-ass.net>
 <20140207104530.GG5126@laptop.programming.kicks-ass.net>
 <20140207114949.GA2107@lst.de>
 <20140207122837.GA3104@twins.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140207122837.GA3104@twins.programming.kicks-ass.net>
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

On Fri, Feb 07, 2014 at 01:28:37PM +0100, Peter Zijlstra wrote:
> Anyway, you can do a version with lwarx/stwcx if you're looking get rid
> of lharx.

the below seems to compile into relatively ok asm. It can be done better
if you write the entire thing by hand though.

---

typedef unsigned short ticket_t;

typedef struct {
	union {
		unsigned int pair;
		struct {
			/* ensure @head is the MSB */
#ifdef __BIG_ENDIAN__
			ticket_t head,tail;
#else
			ticket_t tail,head;
#endif
		};
	};
} tickets_t;

#define ACCESS_ONCE(x) (*(volatile typeof(x) *)&(x))

#define barrier()	__asm__ __volatile__ ("" : : :"memory")
#define __lwsync()	__asm__ __volatile__ ("lwsync" : : :"memory")

#define smp_store_release(p, v)                                         \
do {                                                                    \
        __lwsync();                                                     \
        ACCESS_ONCE(*p) = (v);                                          \
} while (0)

#define smp_load_acquire(p)                                             \
({                                                                      \
        typeof(*p) ___p1 = ACCESS_ONCE(*p);                             \
        __lwsync();                                                     \
        ___p1;                                                          \
})

#define likely(x)	__builtin_expect(!!(x), 1)

#define cpu_relax()	barrier();

static inline unsigned int xadd(unsigned int *v, unsigned int i)
{
	int t, ret;
	
	__asm__ __volatile__ (
"1:	lwarx	%0, 0, %4\n"
"	mr	%1, %0\n"
"	add	%0, %3, %0\n"
"	stwcx.	%0, %0, %4\n"
"	bne-	1b\n"
	: "=&r" (t), "=&r" (ret), "+m" (*v)
	: "r" (i), "r" (v)
	: "cc");

	return ret;
}

void ticket_lock(tickets_t *lock)
{
	tickets_t t;

	/*
	 * Because @head is MSB, the direct increment wrap doesn't disturb
	 * @tail.
	 */
	t.pair = xadd(&lock->pair, 1<<16);

	if (likely(t.head == t.tail)) {
		__lwsync(); /* acquire */
		return;
	}

	while (smp_load_acquire(&lock->tail) != t.tail)
		cpu_relax();
}

void ticket_unlock(tickets_t *lock)
{
	ticket_t tail = lock->tail + 1;

	/*
	 * The store is save against the xadd for it will make the ll/sc fail
	 * and try again. Aside from that PowerISA guarantees single-copy
	 * atomicy for half-word writes.
	 *
	 * And since only the lock owner will ever write the tail, we're good.
	 */
	smp_store_release(&lock->tail, tail);
}
