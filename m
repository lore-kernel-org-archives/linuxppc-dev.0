Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e7.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 91DA92C02AE
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Feb 2013 06:48:10 +1100 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Sun, 10 Feb 2013 14:48:06 -0500
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 8E81538C801B
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 Feb 2013 14:48:04 -0500 (EST)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r1AJm3dX305128
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 Feb 2013 14:48:04 -0500
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r1AJm28P031728
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 Feb 2013 12:48:03 -0700
Date: Sun, 10 Feb 2013 11:47:59 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH v5 04/45] percpu_rwlock: Implement the core design of
 Per-CPU Reader-Writer Locks
Message-ID: <20130210194759.GJ2666@linux.vnet.ibm.com>
References: <20130122073210.13822.50434.stgit@srivatsabhat.in.ibm.com>
 <20130122073347.13822.85876.stgit@srivatsabhat.in.ibm.com>
 <20130208231017.GK2666@linux.vnet.ibm.com>
 <5117F0C0.2030605@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5117F0C0.2030605@linux.vnet.ibm.com>
Cc: linux-doc@vger.kernel.org, peterz@infradead.org, fweisbec@gmail.com,
 linux-kernel@vger.kernel.org, mingo@kernel.org, linux-arch@vger.kernel.org,
 linux@arm.linux.org.uk, xiaoguangrong@linux.vnet.ibm.com,
 wangyun@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com,
 linux-pm@vger.kernel.org, rusty@rustcorp.com.au, rostedt@goodmis.org,
 rjw@sisk.pl, namhyung@kernel.org, tglx@linutronix.de,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, oleg@redhat.com,
 sbw@mit.edu, tj@kernel.org, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org
Reply-To: paulmck@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Feb 11, 2013 at 12:40:56AM +0530, Srivatsa S. Bhat wrote:
> On 02/09/2013 04:40 AM, Paul E. McKenney wrote:
> > On Tue, Jan 22, 2013 at 01:03:53PM +0530, Srivatsa S. Bhat wrote:
> >> Using global rwlocks as the backend for per-CPU rwlocks helps us avoid many
> >> lock-ordering related problems (unlike per-cpu locks). However, global
> >> rwlocks lead to unnecessary cache-line bouncing even when there are no
> >> writers present, which can slow down the system needlessly.
> >>
> [...]
> > 
> > Looks pretty close!  Some comments interspersed below.  Please either
> > fix the code or my confusion, as the case may be.  ;-)
> > 
> 
> Sure :-)
> 
> >> ---
> >>
> >>  include/linux/percpu-rwlock.h |   10 +++
> >>  lib/percpu-rwlock.c           |  128 ++++++++++++++++++++++++++++++++++++++++-
> >>  2 files changed, 136 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/include/linux/percpu-rwlock.h b/include/linux/percpu-rwlock.h
> >> index 8dec8fe..6819bb8 100644
> >> --- a/include/linux/percpu-rwlock.h
> >> +++ b/include/linux/percpu-rwlock.h
> >> @@ -68,4 +68,14 @@ extern void percpu_free_rwlock(struct percpu_rwlock *);
> >>  	__percpu_init_rwlock(pcpu_rwlock, #pcpu_rwlock, &rwlock_key);	\
> >>  })
> >>
> >> +#define reader_uses_percpu_refcnt(pcpu_rwlock, cpu)			\
> >> +		(ACCESS_ONCE(per_cpu(*((pcpu_rwlock)->reader_refcnt), cpu)))
> >> +
> >> +#define reader_nested_percpu(pcpu_rwlock)				\
> >> +			(__this_cpu_read(*((pcpu_rwlock)->reader_refcnt)) > 1)
> >> +
> >> +#define writer_active(pcpu_rwlock)					\
> >> +			(__this_cpu_read(*((pcpu_rwlock)->writer_signal)))
> >> +
> >>  #endif
> >> +
> >> diff --git a/lib/percpu-rwlock.c b/lib/percpu-rwlock.c
> >> index 80dad93..992da5c 100644
> >> --- a/lib/percpu-rwlock.c
> >> +++ b/lib/percpu-rwlock.c
> >> @@ -64,21 +64,145 @@ void percpu_free_rwlock(struct percpu_rwlock *pcpu_rwlock)
> >>
> >>  void percpu_read_lock(struct percpu_rwlock *pcpu_rwlock)
> >>  {
> >> -	read_lock(&pcpu_rwlock->global_rwlock);
> >> +	preempt_disable();
> >> +
> >> +	/* First and foremost, let the writer know that a reader is active */
> >> +	this_cpu_inc(*pcpu_rwlock->reader_refcnt);
> >> +
> >> +	/*
> >> +	 * If we are already using per-cpu refcounts, it is not safe to switch
> >> +	 * the synchronization scheme. So continue using the refcounts.
> >> +	 */
> >> +	if (reader_nested_percpu(pcpu_rwlock)) {
> >> +		goto out;
> >> +	} else {
> >> +		/*
> >> +		 * The write to 'reader_refcnt' must be visible before we
> >> +		 * read 'writer_signal'.
> >> +		 */
> >> +		smp_mb(); /* Paired with smp_rmb() in sync_reader() */
> >> +
> >> +		if (likely(!writer_active(pcpu_rwlock))) {
> >> +			goto out;
> >> +		} else {
> >> +			/* Writer is active, so switch to global rwlock. */
> >> +			read_lock(&pcpu_rwlock->global_rwlock);
> >> +
> >> +			/*
> >> +			 * We might have raced with a writer going inactive
> >> +			 * before we took the read-lock. So re-evaluate whether
> >> +			 * we still need to hold the rwlock or if we can switch
> >> +			 * back to per-cpu refcounts. (This also helps avoid
> >> +			 * heterogeneous nesting of readers).
> >> +			 */
> >> +			if (writer_active(pcpu_rwlock))
> > 
> > The above writer_active() can be reordered with the following this_cpu_dec(),
> > strange though it might seem.  But this is OK because holding the rwlock
> > is conservative.  But might be worth a comment.
> > 
> 
> Ok..
> 
> >> +				this_cpu_dec(*pcpu_rwlock->reader_refcnt);
> >> +			else
> > 
> > In contrast, no reordering can happen here because read_unlock() is
> > required to keep the critical section underneath the lock.
> >
> 
> Ok..
> 
> >> +				read_unlock(&pcpu_rwlock->global_rwlock);
> >> +		}
> >> +	}
> >> +
> >> +out:
> >> +	/* Prevent reordering of any subsequent reads */
> >> +	smp_rmb();
> > 
> > This should be smp_mb().  "Readers" really can do writes.  Hence the
> > name lglock -- "local/global" rather than "reader/writer".
> > 
> 
> Ok!
> 
> [ We were trying to avoid full memory barriers in get/put_online_cpus_atomic()
> in the fastpath, as far as possible... Now it feels like all that discussion
> was for nothing :-( ]
> 
> >>  }
> >>
> >>  void percpu_read_unlock(struct percpu_rwlock *pcpu_rwlock)
> >>  {
> >> -	read_unlock(&pcpu_rwlock->global_rwlock);
> > 
> > We need an smp_mb() here to keep the critical section ordered before the
> > this_cpu_dec() below.  Otherwise, if a writer shows up just after we
> > exit the fastpath, that writer is not guaranteed to see the effects of
> > our critical section.  Equivalently, the prior read-side critical section
> > just might see some of the writer's updates, which could be a bit of
> > a surprise to the reader.
> > 
> 
> Ok, will add it.
> 
> >> +	/*
> >> +	 * We never allow heterogeneous nesting of readers. So it is trivial
> >> +	 * to find out the kind of reader we are, and undo the operation
> >> +	 * done by our corresponding percpu_read_lock().
> >> +	 */
> >> +	if (__this_cpu_read(*pcpu_rwlock->reader_refcnt)) {
> >> +		this_cpu_dec(*pcpu_rwlock->reader_refcnt);
> >> +		smp_wmb(); /* Paired with smp_rmb() in sync_reader() */
> > 
> > Given an smp_mb() above, I don't understand the need for this smp_wmb().
> > Isn't the idea that if the writer sees ->reader_refcnt decremented to
> > zero, it also needs to see the effects of the corresponding reader's
> > critical section?
> >
> 
> Not sure what you meant, but my idea here was that the writer should see
> the reader_refcnt falling to zero as soon as possible, to avoid keeping the
> writer waiting in a tight loop for longer than necessary.
> I might have been a little over-zealous to use lighter memory barriers though,
> (given our lengthy discussions in the previous versions to reduce the memory
> barrier overheads), so the smp_wmb() used above might be wrong.
> 
> So, are you saying that the smp_mb() you indicated above would be enough
> to make the writer observe the 1->0 transition of reader_refcnt immediately?
> 
> > Or am I missing something subtle here?  In any case, if this smp_wmb()
> > really is needed, there should be some subsequent write that the writer
> > might observe.  From what I can see, there is no subsequent write from
> > this reader that the writer cares about.
> 
> I thought the smp_wmb() here and the smp_rmb() at the writer would ensure
> immediate reflection of the reader state at the writer side... Please correct
> me if my understanding is incorrect.

Ah, but memory barriers are not so much about making data move faster
through the machine, but more about making sure that ordering constraints
are met.  After all, memory barriers cannot make electrons flow faster
through silicon.  You should therefore use memory barriers only to
constrain ordering, not to try to expedite electrons.

> >> +	} else {
> >> +		read_unlock(&pcpu_rwlock->global_rwlock);
> >> +	}
> >> +
> >> +	preempt_enable();
> >> +}
> >> +
> >> +static inline void raise_writer_signal(struct percpu_rwlock *pcpu_rwlock,
> >> +				       unsigned int cpu)
> >> +{
> >> +	per_cpu(*pcpu_rwlock->writer_signal, cpu) = true;
> >> +}
> >> +
> >> +static inline void drop_writer_signal(struct percpu_rwlock *pcpu_rwlock,
> >> +				      unsigned int cpu)
> >> +{
> >> +	per_cpu(*pcpu_rwlock->writer_signal, cpu) = false;
> >> +}
> >> +
> >> +static void announce_writer_active(struct percpu_rwlock *pcpu_rwlock)
> >> +{
> >> +	unsigned int cpu;
> >> +
> >> +	for_each_online_cpu(cpu)
> >> +		raise_writer_signal(pcpu_rwlock, cpu);
> >> +
> >> +	smp_mb(); /* Paired with smp_rmb() in percpu_read_[un]lock() */
> >> +}
> >> +
> >> +static void announce_writer_inactive(struct percpu_rwlock *pcpu_rwlock)
> >> +{
> >> +	unsigned int cpu;
> >> +
> >> +	drop_writer_signal(pcpu_rwlock, smp_processor_id());
> > 
> > Why do we drop ourselves twice?  More to the point, why is it important to
> > drop ourselves first?
> 
> I don't see where we are dropping ourselves twice. Note that we are no longer
> in the cpu_online_mask, so the 'for' loop below won't include us. So we need
> to manually drop ourselves. It doesn't matter whether we drop ourselves first
> or later.

Good point, apologies for my confusion!  Still worth a commment, though.

> >> +
> >> +	for_each_online_cpu(cpu)
> >> +		drop_writer_signal(pcpu_rwlock, cpu);
> >> +
> >> +	smp_mb(); /* Paired with smp_rmb() in percpu_read_[un]lock() */
> >> +}
> >> +
> >> +/*
> >> + * Wait for the reader to see the writer's signal and switch from percpu
> >> + * refcounts to global rwlock.
> >> + *
> >> + * If the reader is still using percpu refcounts, wait for him to switch.
> >> + * Else, we can safely go ahead, because either the reader has already
> >> + * switched over, or the next reader that comes along on that CPU will
> >> + * notice the writer's signal and will switch over to the rwlock.
> >> + */
> >> +static inline void sync_reader(struct percpu_rwlock *pcpu_rwlock,
> >> +			       unsigned int cpu)
> >> +{
> >> +	smp_rmb(); /* Paired with smp_[w]mb() in percpu_read_[un]lock() */
> > 
> > As I understand it, the purpose of this memory barrier is to ensure
> > that the stores in drop_writer_signal() happen before the reads from
> > ->reader_refcnt in reader_uses_percpu_refcnt(),
> 
> No, that was not what I intended. announce_writer_inactive() already does
> a full smp_mb() after calling drop_writer_signal().
> 
> I put the smp_rmb() here and the smp_wmb() at the reader side (after updates
> to the ->reader_refcnt) to reflect the state change of ->reader_refcnt
> immediately at the writer, so that the writer doesn't have to keep spinning
> unnecessarily still referring to the old (non-zero) value of ->reader_refcnt.
> Or perhaps I am confused about how to use memory barriers properly.. :-(

Sadly, no, memory barriers don't make electrons move faster.  So you
should only need the one -- the additional memory barriers are just
slowing things down.

> > thus preventing the
> > race between a new reader attempting to use the fastpath and this writer
> > acquiring the lock.  Unless I am confused, this must be smp_mb() rather
> > than smp_rmb().
> > 
> > Also, why not just have a single smp_mb() at the beginning of
> > sync_all_readers() instead of executing one barrier per CPU?
> 
> Well, since my intention was to help the writer see the update (->reader_refcnt
> dropping to zero) ASAP, I kept the multiple smp_rmb()s.

At least you were consistent.  ;-)

> >> +
> >> +	while (reader_uses_percpu_refcnt(pcpu_rwlock, cpu))
> >> +		cpu_relax();
> >> +}
> >> +
> >> +static void sync_all_readers(struct percpu_rwlock *pcpu_rwlock)
> >> +{
> >> +	unsigned int cpu;
> >> +
> >> +	for_each_online_cpu(cpu)
> >> +		sync_reader(pcpu_rwlock, cpu);
> >>  }
> >>
> >>  void percpu_write_lock(struct percpu_rwlock *pcpu_rwlock)
> >>  {
> >> +	/*
> >> +	 * Tell all readers that a writer is becoming active, so that they
> >> +	 * start switching over to the global rwlock.
> >> +	 */
> >> +	announce_writer_active(pcpu_rwlock);
> >> +	sync_all_readers(pcpu_rwlock);
> >>  	write_lock(&pcpu_rwlock->global_rwlock);
> >>  }
> >>
> >>  void percpu_write_unlock(struct percpu_rwlock *pcpu_rwlock)
> >>  {
> >> +	/*
> >> +	 * Inform all readers that we are done, so that they can switch back
> >> +	 * to their per-cpu refcounts. (We don't need to wait for them to
> >> +	 * see it).
> >> +	 */
> >> +	announce_writer_inactive(pcpu_rwlock);
> >>  	write_unlock(&pcpu_rwlock->global_rwlock);
> >>  }
> >>
> >>
> 
> Thanks a lot for your detailed review and comments! :-)

It will be good to get this in!

							Thanx, Paul
