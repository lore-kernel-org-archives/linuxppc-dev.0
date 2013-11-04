Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e39.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C6E5C2C025E
 for <linuxppc-dev@ozlabs.org>; Tue,  5 Nov 2013 03:27:40 +1100 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Mon, 4 Nov 2013 09:27:39 -0700
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 2E22A38C805C
 for <linuxppc-dev@ozlabs.org>; Mon,  4 Nov 2013 11:27:36 -0500 (EST)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
 by b01cxnp22036.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rA4GRa2r2359744
 for <linuxppc-dev@ozlabs.org>; Mon, 4 Nov 2013 16:27:37 GMT
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
 by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 rA4GUPgr015342
 for <linuxppc-dev@ozlabs.org>; Mon, 4 Nov 2013 09:30:27 -0700
Date: Mon, 4 Nov 2013 08:27:32 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC] arch: Introduce new TSO memory barrier smp_tmb()
Message-ID: <20131104162732.GN3947@linux.vnet.ibm.com>
References: <20131101145634.GH19466@laptop.lan>
 <20131102173239.GB3947@linux.vnet.ibm.com>
 <20131103144017.GA25118@linux.vnet.ibm.com>
 <20131103151704.GJ19466@laptop.lan>
 <CA+55aFx_kuvR-0dwJtjvnhtha5QBc5XcLZPRH=WKT+hYVAKOrw@mail.gmail.com>
 <20131103200124.GK19466@laptop.lan>
 <20131103224242.GF3947@linux.vnet.ibm.com>
 <CA+55aFyD_kCkAHQwHCUBrumO-pH6LaZikTNvyWDW_tWsHdqk6Q@mail.gmail.com>
 <20131104105059.GL3947@linux.vnet.ibm.com>
 <20131104112254.GK28601@twins.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20131104112254.GK28601@twins.programming.kicks-ass.net>
Cc: Michael Neuling <mikey@neuling.org>,
 Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
 Oleg Nesterov <oleg@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
 Linux PPC dev <linuxppc-dev@ozlabs.org>, Anton Blanchard <anton@samba.org>,
 Frederic Weisbecker <fweisbec@gmail.com>,
 Victor Kaplansky <VICTORK@il.ibm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>
Reply-To: paulmck@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Nov 04, 2013 at 12:22:54PM +0100, Peter Zijlstra wrote:
> On Mon, Nov 04, 2013 at 02:51:00AM -0800, Paul E. McKenney wrote:
> > OK, something like this for the definitions (though PowerPC might want
> > to locally abstract the lwsync expansion):
> > 
> > 	#define smp_store_with_release_semantics(p, v) /* x86, s390, etc. */ \
> > 	do { \
> > 		barrier(); \
> > 		ACCESS_ONCE(p) = (v); \
> > 	} while (0)
> > 
> > 	#define smp_store_with_release_semantics(p, v) /* PowerPC. */ \
> > 	do { \
> > 		__asm__ __volatile__ (stringify_in_c(LWSYNC) : : :"memory"); \
> > 		ACCESS_ONCE(p) = (v); \
> > 	} while (0)
> > 
> > 	#define smp_load_with_acquire_semantics(p) /* x86, s390, etc. */ \
> > 	({ \
> > 		typeof(*p) *_________p1 = ACCESS_ONCE(p); \
> > 		barrier(); \
> > 		_________p1; \
> > 	})
> > 
> > 	#define smp_load_with_acquire_semantics(p) /* PowerPC. */ \
> > 	({ \
> > 		typeof(*p) *_________p1 = ACCESS_ONCE(p); \
> > 		__asm__ __volatile__ (stringify_in_c(LWSYNC) : : :"memory"); \
> > 		_________p1; \
> > 	})
> > 
> > For ARM, smp_load_with_acquire_semantics() is a wrapper around the ARM
> > "ldar" instruction and smp_store_with_release_semantics() is a wrapper
> > around the ARM "stlr" instruction.
> 
> This still leaves me confused as to what to do with my case :/
> 
> Slightly modified since last time -- as the simplified version was maybe
> simplified too far.
> 
> To recap, I'd like to get rid of barrier A where possible, since that's
> now a full barrier for every event written.
> 
> However, there's no immediate store I can attach it to; the obvious one
> would be the kbuf->head store, but that's complicated by the
> local_cmpxchg() thing.
> 
> And we need that cmpxchg loop because a hardware NMI event can
> interleave with a software event.
> 
> And to be honest, I'm still totally confused about memory barriers vs
> control flow vs C/C++. The only way we're ever getting to that memcpy is
> if we've already observed ubuf->tail, so that LOAD has to be fully
> processes and completed.
> 
> I'm really not seeing how a STORE from the memcpy() could possibly go
> wrong; and if C/C++ can hoist the memcpy() over a compiler barrier()
> then I suppose we should all just go home.
> 
> /me who wants A to be a barrier() but is terminally confused.

Well, let's see...

> ---
> 
> 
> /*
>  * One important detail is that the kbuf part and the kbuf_writer() are
>  * strictly per cpu and we can thus rely on program order for those.
>  *
>  * Only the userspace consumer can possibly run on another cpu, and thus we
>  * need to ensure data consistency for those.
>  */
> 
> struct buffer {
>         u64 size;
>         u64 tail;
>         u64 head;
>         void *data;
> };
> 
> struct buffer *kbuf, *ubuf;
> 
> /*
>  * If there's space in the buffer; store the data @buf; otherwise
>  * discard it.
>  */
> void kbuf_write(int sz, void *buf)
> {
> 	u64 tail, head, offset;
> 
> 	do {
> 		tail = ACCESS_ONCE(ubuf->tail);

So the above load is the key load.  It determines whether or not we
have space in the buffer.  This of course assumes that only this CPU
writes to ->head.

If so, then:

		tail = smp_load_with_acquire_semantics(ubuf->tail); /* A -> D */

> 		offset = head = kbuf->head;
> 		if (CIRC_SPACE(head, tail, kbuf->size) < sz) {
> 			/* discard @buf */
> 			return;
> 		}
> 		head += sz;
> 	} while (local_cmpxchg(&kbuf->head, offset, head) != offset)

If there is an issue with kbuf->head, presumably local_cmpxchg() fails
and we retry.

But sheesh, do you think we could have buried the definitions of
local_cmpxchg() under a few more layers of macro expansion just to
keep things more obscure?  Anyway, griping aside...

o	__cmpxchg_local_generic() in include/asm-generic/cmpxchg-local.h
	doesn't seem to exclude NMIs, so is not safe for this usage.

o	__cmpxchg_local() in ARM handles NMI as long as the
	argument is 32 bits, otherwise, it uses the aforementionted
	__cmpxchg_local_generic(), which does not handle NMI.  Given your
	u64, this does not look good...

	And some ARM subarches (e.g., metag) seem to fail to handle NMI
	even in the 32-bit case.

o	FRV and M32r seem to act similar to ARM.

Or maybe these architectures don't do NMIs?  If they do, local_cmpxchg()
does not seem to be safe against NMIs in general.  :-/

That said, powerpc, 64-bit s390, sparc, and x86 seem to handle it.

Of course, x86's local_cmpxchg() has full memory barriers implicitly.

> 
>         /*
>          * Ensure that if we see the userspace tail (ubuf->tail) such
>          * that there is space to write @buf without overwriting data
>          * userspace hasn't seen yet, we won't in fact store data before
>          * that read completes.
>          */
> 
>         smp_mb(); /* A, matches with D */

Given a change to smp_load_with_acquire_semantics() above, you should not
need this smp_mb().

>         memcpy(kbuf->data + offset, buf, sz);
> 
>         /*
>          * Ensure that we write all the @buf data before we update the
>          * userspace visible ubuf->head pointer.
>          */
>         smp_wmb(); /* B, matches with C */
> 
>         ubuf->head = kbuf->head;

Replace the smp_wmb() and the assignment with:

	smp_store_with_release_semantics(ubuf->head, kbuf->head); /* B -> C */

> }
> 
> /*
>  * Consume the buffer data and update the tail pointer to indicate to
>  * kernel space there's 'free' space.
>  */
> void ubuf_read(void)
> {
>         u64 head, tail;
> 
>         tail = ACCESS_ONCE(ubuf->tail);

Does anyone else write tail?  Or is this defense against NMIs?

If no one else writes to tail and if NMIs cannot muck things up, then
the above ACCESS_ONCE() is not needed, though I would not object to its
staying.

>         head = ACCESS_ONCE(ubuf->head);

Make the above be:

	head = smp_load_with_acquire_semantics(ubuf->head);  /* C -> B */

>         /*
>          * Ensure we read the buffer boundaries before the actual buffer
>          * data...
>          */
>         smp_rmb(); /* C, matches with B */

And drop the above memory barrier.

>         while (tail != head) {
>                 obj = ubuf->data + tail;
>                 /* process obj */
>                 tail += obj->size;
>                 tail %= ubuf->size;
>         }
> 
>         /*
>          * Ensure all data reads are complete before we issue the
>          * ubuf->tail update; once that update hits, kbuf_write() can
>          * observe and overwrite data.
>          */
>         smp_mb(); /* D, matches with A */
> 
>         ubuf->tail = tail;

Replace the above barrier and the assignment with:

	smp_store_with_release_semantics(ubuf->tail, tail); /* D -> B. */

> }

All this is leading me to suggest the following shortenings of names:

	smp_load_with_acquire_semantics() -> smp_load_acquire()

	smp_store_with_release_semantics() -> smp_store_release()

But names aside, the above gets rid of explicit barriers on TSO architectures,
allows ARM to avoid full DMB, and allows PowerPC to use lwsync instead of
the heavier-weight sync.

								Thanx, Paul
