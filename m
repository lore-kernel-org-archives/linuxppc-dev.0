Return-Path: <eag0628@gmail.com>
Received: from mail-ia0-x22d.google.com (mail-ia0-x22d.google.com
 [IPv6:2607:f8b0:4001:c02::22d])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 328FF2C0091
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Feb 2013 01:17:08 +1100 (EST)
Received: by mail-ia0-f173.google.com with SMTP id h37so3491615iak.4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Feb 2013 06:17:04 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20130218123856.26245.46705.stgit@srivatsabhat.in.ibm.com>
References: <20130218123714.26245.61816.stgit@srivatsabhat.in.ibm.com>
 <20130218123856.26245.46705.stgit@srivatsabhat.in.ibm.com>
Date: Tue, 26 Feb 2013 22:17:03 +0800
Message-ID: <CACvQF529c72xLuosD44CPd_y_0zJBc-tjgNQpBiD0UhbzS8XDg@mail.gmail.com>
Subject: Re: [PATCH v6 04/46] percpu_rwlock: Implement the core design of
 Per-CPU Reader-Writer Locks
From: Lai Jiangshan <eag0628@gmail.com>
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-doc@vger.kernel.org, peterz@infradead.org, fweisbec@gmail.com,
 linux-kernel@vger.kernel.org, walken@google.com, mingo@kernel.org,
 linux-arch@vger.kernel.org, linux@arm.linux.org.uk,
 xiaoguangrong@linux.vnet.ibm.com, wangyun@linux.vnet.ibm.com,
 paulmck@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com,
 linux-pm@vger.kernel.org, rusty@rustcorp.com.au, rostedt@goodmis.org,
 rjw@sisk.pl, namhyung@kernel.org, tglx@linutronix.de,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, oleg@redhat.com,
 vincent.guittot@linaro.org, sbw@mit.edu, tj@kernel.org,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Feb 18, 2013 at 8:38 PM, Srivatsa S. Bhat
<srivatsa.bhat@linux.vnet.ibm.com> wrote:
> Using global rwlocks as the backend for per-CPU rwlocks helps us avoid many
> lock-ordering related problems (unlike per-cpu locks). However, global
> rwlocks lead to unnecessary cache-line bouncing even when there are no
> writers present, which can slow down the system needlessly.

per-CPU rwlocks(yours and mine) are the exactly same as rwlock_t in
the view of lock dependency(except reader-C.S. can be nested in
writer-C.S.)
so they can deadlock in this order:

spin_lock(some_lock);				percpu_write_lock_irqsave()
						case CPU_DYING
percpu_read_lock_irqsafe();	<---deadlock--->	spin_lock(some_lock);

The lockdep can find out such dependency, but we must try our best to
find out them before merge the patchset to mainline. We can  review
all the code of cpu_disable() and CPU_DYING and fix this kinds of lock
dependency, but it is not easy thing, it may be a long term project.

======
And if there is any CPU_DYING code takes no locks and do some
works(because they know they are called via stop_machine()) we need to
add that locking code back if there is such code.(I don't know whether
such code exist or not)

>
> Per-cpu counters can help solve the cache-line bouncing problem. So we
> actually use the best of both: per-cpu counters (no-waiting) at the reader
> side in the fast-path, and global rwlocks in the slowpath.
>
> [ Fastpath = no writer is active; Slowpath = a writer is active ]
>
> IOW, the readers just increment/decrement their per-cpu refcounts (disabling
> interrupts during the updates, if necessary) when no writer is active.
> When a writer becomes active, he signals all readers to switch to global
> rwlocks for the duration of his activity. The readers switch over when it
> is safe for them (ie., when they are about to start a fresh, non-nested
> read-side critical section) and start using (holding) the global rwlock for
> read in their subsequent critical sections.
>
> The writer waits for every existing reader to switch, and then acquires the
> global rwlock for write and enters his critical section. Later, the writer
> signals all readers that he is done, and that they can go back to using their
> per-cpu refcounts again.
>
> Note that the lock-safety (despite the per-cpu scheme) comes from the fact
> that the readers can *choose* _when_ to switch to rwlocks upon the writer's
> signal. And the readers don't wait on anybody based on the per-cpu counters.
> The only true synchronization that involves waiting at the reader-side in this
> scheme, is the one arising from the global rwlock, which is safe from circular
> locking dependency issues.
>
> Reader-writer locks and per-cpu counters are recursive, so they can be
> used in a nested fashion in the reader-path, which makes per-CPU rwlocks also
> recursive. Also, this design of switching the synchronization scheme ensures
> that you can safely nest and use these locks in a very flexible manner.
>
> I'm indebted to Michael Wang and Xiao Guangrong for their numerous thoughtful
> suggestions and ideas, which inspired and influenced many of the decisions in
> this as well as previous designs. Thanks a lot Michael and Xiao!
>
> Cc: David Howells <dhowells@redhat.com>
> Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
> ---
>
>  lib/percpu-rwlock.c |  139 ++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 137 insertions(+), 2 deletions(-)
>
> diff --git a/lib/percpu-rwlock.c b/lib/percpu-rwlock.c
> index f938096..edefdea 100644
> --- a/lib/percpu-rwlock.c
> +++ b/lib/percpu-rwlock.c
> @@ -27,6 +27,24 @@
>  #include <linux/percpu-rwlock.h>
>  #include <linux/errno.h>
>
> +#include <asm/processor.h>
> +
> +
> +#define reader_yet_to_switch(pcpu_rwlock, cpu)                             \
> +       (ACCESS_ONCE(per_cpu_ptr((pcpu_rwlock)->rw_state, cpu)->reader_refcnt))
> +
> +#define reader_percpu_nesting_depth(pcpu_rwlock)                 \
> +       (__this_cpu_read((pcpu_rwlock)->rw_state->reader_refcnt))
> +
> +#define reader_uses_percpu_refcnt(pcpu_rwlock)                         \
> +                               reader_percpu_nesting_depth(pcpu_rwlock)
> +
> +#define reader_nested_percpu(pcpu_rwlock)                              \
> +                       (reader_percpu_nesting_depth(pcpu_rwlock) > 1)
> +
> +#define writer_active(pcpu_rwlock)                                     \
> +       (__this_cpu_read((pcpu_rwlock)->rw_state->writer_signal))
> +
>
>  int __percpu_init_rwlock(struct percpu_rwlock *pcpu_rwlock,
>                          const char *name, struct lock_class_key *rwlock_key)
> @@ -55,21 +73,138 @@ void percpu_free_rwlock(struct percpu_rwlock *pcpu_rwlock)
>
>  void percpu_read_lock(struct percpu_rwlock *pcpu_rwlock)
>  {
> -       read_lock(&pcpu_rwlock->global_rwlock);
> +       preempt_disable();
> +
> +       /*
> +        * Let the writer know that a reader is active, even before we choose
> +        * our reader-side synchronization scheme.
> +        */
> +       this_cpu_inc(pcpu_rwlock->rw_state->reader_refcnt);
> +
> +       /*
> +        * If we are already using per-cpu refcounts, it is not safe to switch
> +        * the synchronization scheme. So continue using the refcounts.
> +        */
> +       if (reader_nested_percpu(pcpu_rwlock))
> +               return;
> +
> +       /*
> +        * The write to 'reader_refcnt' must be visible before we read
> +        * 'writer_signal'.
> +        */
> +       smp_mb();
> +
> +       if (likely(!writer_active(pcpu_rwlock))) {
> +               goto out;
> +       } else {
> +               /* Writer is active, so switch to global rwlock. */
> +               read_lock(&pcpu_rwlock->global_rwlock);
> +
> +               /*
> +                * We might have raced with a writer going inactive before we
> +                * took the read-lock. So re-evaluate whether we still need to
> +                * hold the rwlock or if we can switch back to per-cpu
> +                * refcounts. (This also helps avoid heterogeneous nesting of
> +                * readers).
> +                */
> +               if (writer_active(pcpu_rwlock)) {
> +                       /*
> +                        * The above writer_active() check can get reordered
> +                        * with this_cpu_dec() below, but this is OK, because
> +                        * holding the rwlock is conservative.
> +                        */
> +                       this_cpu_dec(pcpu_rwlock->rw_state->reader_refcnt);
> +               } else {
> +                       read_unlock(&pcpu_rwlock->global_rwlock);
> +               }
> +       }
> +
> +out:
> +       /* Prevent reordering of any subsequent reads/writes */
> +       smp_mb();
>  }
>
>  void percpu_read_unlock(struct percpu_rwlock *pcpu_rwlock)
>  {
> -       read_unlock(&pcpu_rwlock->global_rwlock);
> +       /*
> +        * We never allow heterogeneous nesting of readers. So it is trivial
> +        * to find out the kind of reader we are, and undo the operation
> +        * done by our corresponding percpu_read_lock().
> +        */
> +
> +       /* Try to fast-path: a nested percpu reader is the simplest case */
> +       if (reader_nested_percpu(pcpu_rwlock)) {
> +               this_cpu_dec(pcpu_rwlock->rw_state->reader_refcnt);
> +               preempt_enable();
> +               return;
> +       }
> +
> +       /*
> +        * Now we are left with only 2 options: a non-nested percpu reader,
> +        * or a reader holding rwlock
> +        */
> +       if (reader_uses_percpu_refcnt(pcpu_rwlock)) {
> +               /*
> +                * Complete the critical section before decrementing the
> +                * refcnt. We can optimize this away if we are a nested
> +                * reader (the case above).
> +                */
> +               smp_mb();
> +               this_cpu_dec(pcpu_rwlock->rw_state->reader_refcnt);
> +       } else {
> +               read_unlock(&pcpu_rwlock->global_rwlock);
> +       }
> +
> +       preempt_enable();
>  }
>
>  void percpu_write_lock(struct percpu_rwlock *pcpu_rwlock)
>  {
> +       unsigned int cpu;
> +
> +       /*
> +        * Tell all readers that a writer is becoming active, so that they
> +        * start switching over to the global rwlock.
> +        */
> +       for_each_possible_cpu(cpu)
> +               per_cpu_ptr(pcpu_rwlock->rw_state, cpu)->writer_signal = true;
> +
> +       smp_mb();
> +
> +       /*
> +        * Wait for every reader to see the writer's signal and switch from
> +        * percpu refcounts to global rwlock.
> +        *
> +        * If a reader is still using percpu refcounts, wait for him to switch.
> +        * Else, we can safely go ahead, because either the reader has already
> +        * switched over, or the next reader that comes along on that CPU will
> +        * notice the writer's signal and will switch over to the rwlock.
> +        */
> +
> +       for_each_possible_cpu(cpu) {
> +               while (reader_yet_to_switch(pcpu_rwlock, cpu))
> +                       cpu_relax();
> +       }
> +
> +       smp_mb(); /* Complete the wait-for-readers, before taking the lock */
>         write_lock(&pcpu_rwlock->global_rwlock);
>  }
>
>  void percpu_write_unlock(struct percpu_rwlock *pcpu_rwlock)
>  {
> +       unsigned int cpu;
> +
> +       /* Complete the critical section before clearing ->writer_signal */
> +       smp_mb();
> +
> +       /*
> +        * Inform all readers that we are done, so that they can switch back
> +        * to their per-cpu refcounts. (We don't need to wait for them to
> +        * see it).
> +        */
> +       for_each_possible_cpu(cpu)
> +               per_cpu_ptr(pcpu_rwlock->rw_state, cpu)->writer_signal = false;
> +
>         write_unlock(&pcpu_rwlock->global_rwlock);
>  }
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
