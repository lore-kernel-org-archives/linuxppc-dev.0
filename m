Return-Path: <dhowells@redhat.com>
From: David Howells <dhowells@redhat.com>
In-Reply-To: <17204.41449.162199.476757@cargo.ozlabs.ibm.com>
References: <17204.41449.162199.476757@cargo.ozlabs.ibm.com>
	<E1EIXAI-0006Q0-OS@jdl.com>
	<606.1127460740@warthog.cambridge.redhat.com>
To: Paul Mackerras <paulus@samba.org>
Date: Mon, 26 Sep 2005 12:38:21 +0100
Message-ID: <25552.1127734701@warthog.cambridge.redhat.com>
Sender: dhowells@redhat.com
Cc: David Howells <dhowells@redhat.com>, linuxppc-dev@ozlabs.org,
	linuxppc64-dev@ozlabs.org
Subject: Re: PATCH powerpc Merge asm-ppc*/rwsem.h
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul Mackerras <paulus@samba.org> wrote:

>
> > rwsems on ppc64 should really be using a 64-bit counter, not a 32-bit
> > counter, otherwise you limit the maximum number of processes to 32K-ish.
> >
> > The counter should be "signed long" really.
>
> It has long annoyed me that we waste half the bits in the rwsem
> counter, just because you assume a lowest-common-denominator set of
> atomic ops.  IIRC your implementation replaced the earlier ppc
> implementation which had a 32-bit counter and didn't have the 32k
> process limit.

And also didn't work, at least not on i386.

> I'd have to study it in more detail, but I strongly suspect that with
> an atomic operation that did something like
>
> 	*p = max(*p, limit) + inc

There is no requirement for an arch to use the XADD-based algorithm for doing
this - that's optimised for use with the i386/x86_64 XADD instruction. That
can be emulated by cmpxchg or load-locked/store-conditional type constructs
like MIPS, Alpha and ppc have.

> atomically (or alternatively a min), we could increase the limit to at
> least 1G processes with a 32-bit counter, without needing to change
> your common slow-path implementation.

I think you'd probably need a different slow-path for what you want. My XADD
optimised slow patch assumes that certain values represent certain states, and
if you're using different values, then it won't necessarily work. This is why
the thing is contingent on CONFIG_RWSEM_XCHGADD_ALGORITHM.

> Such an atomic op is easy to implement with load-and-reserve /
> store-conditional instructions.  Look at __sem_update_count in
> arch/ppc64/kernel/semaphore.c for an example.

So that does (I think):

	do {
		int old_count = load_reserve(&sem->count);

		int tmp = old_count >> 31;   // not sure about this: 31 or 1?

		tmp = old_count & ~tmp;

		tmp = tmp + incr;

	} while (!conditionally_assign(&sem->count, tmp));

PPC asm makes my head hurt; in particular the description of the SRAWI
instruction I've got is a delight to behold, and is inconsistent with the
description of the SRAW instruction:-/

I'm guessing it does a shift by 31 to leave tmp filled with copies of bit 0
(the sign bit) of old_count. The manual suggests the shift is 32-N (or 1 in
this case) which would seem odd.

I see how it works, then. What's "limit" in this formula:

> 	*p = max(*p, limit) + inc

Is it the maximum number of processes that may hold readlocks? Or maybe the
negated quantity thereof.

It's hard to see immediately how this will work. The counter has to represent
several things:

 (1) The number of active readers (max N) or the number of active writers (max
     1).

 (2) Whether or not there is potential contention.

I do this with my XADD algorithm by splitting the word into two halves:

 MSH = #active_writers + #failed_writers + #sleepers

 LSH = #active_readers + #active_writers + #failed_contenders

Basically, the counter is a lock additional to the spinlock.

Perhaps you could do something like this:

	COUNT			MEANING
	=======================	==========================================
	0			Not in use
	0x00000001 - 0x7fffffff	N readers
	0x80000000		last active reader or writer done, contention
	0x80000001 - 0xffffffff	N active readers or writers, contention

So up_read() and up_write() would decrement the count. If the result reaches
0x80000000 then you have to perform contention resolution.

down_read() would increment the count if >= 0, or attempt to sleep otherwise.

down_write() would just set the sign bit of the count and sleep if != 0, or set
the count to 0x80000001 and return.

We could also divide the space in two, and use the second most significant bit
(0x40000000) to record the fact that there are sleeping contenders or to record
which type of lock is actually active.

However, I think there's a problem with doing that, and that is:

	COUNT	 PROCESS 0		PROCESS 1
	======== ======================	================================
	00000000
		 down_read()
	00000001
					-->down_write()
					lwarx
					stwcx [set sign bit]
	80000001
					-->down_write_slow()
		 -->up_read()
		 lwarx
		 stwcx [dec]
	80000000
		 -->up_read_slow()
		 -->lock sem->wait_lock
		 <--lock sem->wait_lock
					-->lock sem->wait_lock
		 count indicated contention
		  but nothing on sem->wait_list
		  - do we leave the count unaltered?
		  - do we clear the count?
		  - do we set the count to 0x80000001?

If we leave the count set to 0x80000000, then the down_write_slow() when it
runs won't be able to tell whether it got sem->wait_lock before or after
down_read_slow() did. In one case it should go to sleep and in the other it
should claim the lock.

If we set the count to 0x80000001, then the case where _two_ CPUs are
contending with the releaser may _both_ think they have the lock, and in any
case can't tell the difference between that and a sleeping process just having
been woken up and given a writelock.

If we clear the count, then other processes may be able to queue jump (which
isn't necessarily a problem since spinlocks aren't fair anyway, though they
could be made so). down_write_slow() would have to attempt to take the lock
again, though this time it would already have the spinlock. But what might
happen is that:

	COUNT	 PROCESS 0		PROCESS 1	PROCESS 2
	======== ======================	===============	===============
	80000000
					-->lock sem->wait_lock
		 count indicated contention
		  but nothing on sem->wait_list
		  - do we clear the count?
	00000000
							down_write()
	80000001
		 unlock sem->wait_lock
		 <--up_read_slow()
		 <--up_read()
					<--lock sem->wait_lock
					lwarx
					stwcx [set sign bit]
	80000001
							-->up_write()
							lwarx
							stwcx [dec]
	80000000
							-->up_write_slow()
							-->lock sem->wait_lock
					list_add_tail()
		 			unlock sem->wait_lock
					sleep
							<--lock sem->wait_lock
							dequeue process 1
							set count
	80000001
							unlock sem->wait_lock
							<--up_write_slow()
							<--up_write()
					wake
					<--up_write_slow()
					<--up_write()

Ummm... that does seem to work. I think their may be a multi-process race in
there somewhere, but I can't work it out if there is; just as long as
up_write() always does contention resolution.

The down side of this is that you always have to get the spinlock in up_write,
unlike in the XADD implementation where the counter includes a contention
counter.

I think downgrade_write() should simply be a matter of: whilst holding the
spinlock, set the counter to the number of outstanding reads, and only set the
sign bit if there's a sleeping writer left at the front of the queue.

Should interruptible rwsems arrive, then I think just dequeuing the aborted
down op should be enough. Leave the contention counter with the sign bit set as
it'll sort itself out later.

David
