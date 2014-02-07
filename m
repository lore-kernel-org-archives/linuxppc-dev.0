Return-Path: <peterz@infradead.org>
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:4978:20e::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 161BE2C009F
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Feb 2014 21:31:51 +1100 (EST)
Date: Fri, 7 Feb 2014 11:31:39 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Torsten Duwe <duwe@lst.de>
Subject: Re: [PATCH] Convert powerpc simple spinlocks into ticket locks
Message-ID: <20140207103139.GP5002@laptop.programming.kicks-ass.net>
References: <20140206103736.GA18054@lst.de>
 <20140206163837.GT2936@laptop.programming.kicks-ass.net>
 <20140206173727.GA13048@lst.de>
 <1391717992.6733.232.camel@snotra.buserror.net>
 <20140207090248.GB26811@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140207090248.GB26811@lst.de>
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

On Fri, Feb 07, 2014 at 10:02:48AM +0100, Torsten Duwe wrote:
> On Thu, Feb 06, 2014 at 02:19:52PM -0600, Scott Wood wrote:
> > On Thu, 2014-02-06 at 18:37 +0100, Torsten Duwe wrote:
> > > On Thu, Feb 06, 2014 at 05:38:37PM +0100, Peter Zijlstra wrote:
> > 
> > > > Can you pair lwarx with sthcx ? I couldn't immediately find the answer
> > > > in the PowerISA doc. If so I think you can do better by being able to
> > > > atomically load both tickets but only storing the head without affecting
> > > > the tail.
> 
> Can I simply write the half word, without a reservation, or will the HW caches
> mess up the other half? Will it ruin the cache coherency on some (sub)architectures?

So if you have ll/sc on the whole word concurrent with the half-word
store, you can loose the half-word store like:

  lwarx &tickets
  ...			sth &tail
  stwcd &tickets


The stwcd will over-write the tail store.

Anyway, what might work is something like (please forgive my ppc asm, I
can barely read the thing, I've never before attempted writing it):

lock:
1:	lharx	%0, 0, &head
	mov	%1, %0
	addic	%0, %0, 1
	stwcd   %0, 0, &head
	bne-	1b

2:	lhax	%0, 0, &tail
	lwsync
	cmp	0, %0, %0
	bne-	2b


unlock:
	lhz	%0, 0, &tail
	addic	%0, %0, 1
	lwsync
	sth	%0, 0, &tail


Which would somewhat translate into C as:

static inline void ticket_spin_lock(tickets_t *lock)
{
	ticket_t mine = xadd(&lock->head);

	while (smp_load_acquire(&lock->tail) != mine)
		cpu_relax();
}

static inline void ticket_spin_unlock(tickets_t *lock)
{
	ticket_t tail = lock->tail + 1;

	smp_store_release(&lock->tail, tail);
}

Where xadd() returns the value before addition and we assume half word
single-copy atomicy, such that the head and tail updates will not
interfere.

The x86 implementation uses the 32bit xadd and places the head at the
MSB end to get the atomic add + tail load in a single instruction, but
for PPC its much better to have an extra load (to an already hot
cacheline) and avoid a second ll/sc pair, as the ll/sc things are stupid
slow for your arch afaik.
