Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp04.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 624112C0349
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2013 23:41:03 +1100 (EST)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Mon, 18 Feb 2013 18:08:36 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id AFB19394004F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2013 18:10:57 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r1ICetZ718743450
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2013 18:10:55 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r1ICerZo030799
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2013 23:40:56 +1100
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v6 04/46] percpu_rwlock: Implement the core design of Per-CPU
 Reader-Writer Locks
To: tglx@linutronix.de, peterz@infradead.org, tj@kernel.org, oleg@redhat.com,
 paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, mingo@kernel.org,
 akpm@linux-foundation.org, namhyung@kernel.org
Date: Mon, 18 Feb 2013 18:08:56 +0530
Message-ID: <20130218123856.26245.46705.stgit@srivatsabhat.in.ibm.com>
In-Reply-To: <20130218123714.26245.61816.stgit@srivatsabhat.in.ibm.com>
References: <20130218123714.26245.61816.stgit@srivatsabhat.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linux-arch@vger.kernel.org, linux@arm.linux.org.uk,
 nikunj@linux.vnet.ibm.com, linux-pm@vger.kernel.org, fweisbec@gmail.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 xiaoguangrong@linux.vnet.ibm.com, rjw@sisk.pl, sbw@mit.edu,
 wangyun@linux.vnet.ibm.com, srivatsa.bhat@linux.vnet.ibm.com,
 netdev@vger.kernel.org, vincent.guittot@linaro.org, walken@google.com,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Using global rwlocks as the backend for per-CPU rwlocks helps us avoid many
lock-ordering related problems (unlike per-cpu locks). However, global
rwlocks lead to unnecessary cache-line bouncing even when there are no
writers present, which can slow down the system needlessly.

Per-cpu counters can help solve the cache-line bouncing problem. So we
actually use the best of both: per-cpu counters (no-waiting) at the reader
side in the fast-path, and global rwlocks in the slowpath.

[ Fastpath = no writer is active; Slowpath = a writer is active ]

IOW, the readers just increment/decrement their per-cpu refcounts (disabling
interrupts during the updates, if necessary) when no writer is active.
When a writer becomes active, he signals all readers to switch to global
rwlocks for the duration of his activity. The readers switch over when it
is safe for them (ie., when they are about to start a fresh, non-nested
read-side critical section) and start using (holding) the global rwlock for
read in their subsequent critical sections.

The writer waits for every existing reader to switch, and then acquires the
global rwlock for write and enters his critical section. Later, the writer
signals all readers that he is done, and that they can go back to using their
per-cpu refcounts again.

Note that the lock-safety (despite the per-cpu scheme) comes from the fact
that the readers can *choose* _when_ to switch to rwlocks upon the writer's
signal. And the readers don't wait on anybody based on the per-cpu counters.
The only true synchronization that involves waiting at the reader-side in this
scheme, is the one arising from the global rwlock, which is safe from circular
locking dependency issues.

Reader-writer locks and per-cpu counters are recursive, so they can be
used in a nested fashion in the reader-path, which makes per-CPU rwlocks also
recursive. Also, this design of switching the synchronization scheme ensures
that you can safely nest and use these locks in a very flexible manner.

I'm indebted to Michael Wang and Xiao Guangrong for their numerous thoughtful
suggestions and ideas, which inspired and influenced many of the decisions in
this as well as previous designs. Thanks a lot Michael and Xiao!

Cc: David Howells <dhowells@redhat.com>
Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 lib/percpu-rwlock.c |  139 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 137 insertions(+), 2 deletions(-)

diff --git a/lib/percpu-rwlock.c b/lib/percpu-rwlock.c
index f938096..edefdea 100644
--- a/lib/percpu-rwlock.c
+++ b/lib/percpu-rwlock.c
@@ -27,6 +27,24 @@
 #include <linux/percpu-rwlock.h>
 #include <linux/errno.h>
 
+#include <asm/processor.h>
+
+
+#define reader_yet_to_switch(pcpu_rwlock, cpu)				    \
+	(ACCESS_ONCE(per_cpu_ptr((pcpu_rwlock)->rw_state, cpu)->reader_refcnt))
+
+#define reader_percpu_nesting_depth(pcpu_rwlock)		  \
+	(__this_cpu_read((pcpu_rwlock)->rw_state->reader_refcnt))
+
+#define reader_uses_percpu_refcnt(pcpu_rwlock)				\
+				reader_percpu_nesting_depth(pcpu_rwlock)
+
+#define reader_nested_percpu(pcpu_rwlock)				\
+			(reader_percpu_nesting_depth(pcpu_rwlock) > 1)
+
+#define writer_active(pcpu_rwlock)					\
+	(__this_cpu_read((pcpu_rwlock)->rw_state->writer_signal))
+
 
 int __percpu_init_rwlock(struct percpu_rwlock *pcpu_rwlock,
 			 const char *name, struct lock_class_key *rwlock_key)
@@ -55,21 +73,138 @@ void percpu_free_rwlock(struct percpu_rwlock *pcpu_rwlock)
 
 void percpu_read_lock(struct percpu_rwlock *pcpu_rwlock)
 {
-	read_lock(&pcpu_rwlock->global_rwlock);
+	preempt_disable();
+
+	/*
+	 * Let the writer know that a reader is active, even before we choose
+	 * our reader-side synchronization scheme.
+	 */
+	this_cpu_inc(pcpu_rwlock->rw_state->reader_refcnt);
+
+	/*
+	 * If we are already using per-cpu refcounts, it is not safe to switch
+	 * the synchronization scheme. So continue using the refcounts.
+	 */
+	if (reader_nested_percpu(pcpu_rwlock))
+		return;
+
+	/*
+	 * The write to 'reader_refcnt' must be visible before we read
+	 * 'writer_signal'.
+	 */
+	smp_mb();
+
+	if (likely(!writer_active(pcpu_rwlock))) {
+		goto out;
+	} else {
+		/* Writer is active, so switch to global rwlock. */
+		read_lock(&pcpu_rwlock->global_rwlock);
+
+		/*
+		 * We might have raced with a writer going inactive before we
+		 * took the read-lock. So re-evaluate whether we still need to
+		 * hold the rwlock or if we can switch back to per-cpu
+		 * refcounts. (This also helps avoid heterogeneous nesting of
+		 * readers).
+		 */
+		if (writer_active(pcpu_rwlock)) {
+			/*
+			 * The above writer_active() check can get reordered
+			 * with this_cpu_dec() below, but this is OK, because
+			 * holding the rwlock is conservative.
+			 */
+			this_cpu_dec(pcpu_rwlock->rw_state->reader_refcnt);
+		} else {
+			read_unlock(&pcpu_rwlock->global_rwlock);
+		}
+	}
+
+out:
+	/* Prevent reordering of any subsequent reads/writes */
+	smp_mb();
 }
 
 void percpu_read_unlock(struct percpu_rwlock *pcpu_rwlock)
 {
-	read_unlock(&pcpu_rwlock->global_rwlock);
+	/*
+	 * We never allow heterogeneous nesting of readers. So it is trivial
+	 * to find out the kind of reader we are, and undo the operation
+	 * done by our corresponding percpu_read_lock().
+	 */
+
+	/* Try to fast-path: a nested percpu reader is the simplest case */
+	if (reader_nested_percpu(pcpu_rwlock)) {
+		this_cpu_dec(pcpu_rwlock->rw_state->reader_refcnt);
+		preempt_enable();
+		return;
+	}
+
+	/*
+	 * Now we are left with only 2 options: a non-nested percpu reader,
+	 * or a reader holding rwlock
+	 */
+	if (reader_uses_percpu_refcnt(pcpu_rwlock)) {
+		/*
+		 * Complete the critical section before decrementing the
+		 * refcnt. We can optimize this away if we are a nested
+		 * reader (the case above).
+		 */
+		smp_mb();
+		this_cpu_dec(pcpu_rwlock->rw_state->reader_refcnt);
+	} else {
+		read_unlock(&pcpu_rwlock->global_rwlock);
+	}
+
+	preempt_enable();
 }
 
 void percpu_write_lock(struct percpu_rwlock *pcpu_rwlock)
 {
+	unsigned int cpu;
+
+	/*
+	 * Tell all readers that a writer is becoming active, so that they
+	 * start switching over to the global rwlock.
+	 */
+	for_each_possible_cpu(cpu)
+		per_cpu_ptr(pcpu_rwlock->rw_state, cpu)->writer_signal = true;
+
+	smp_mb();
+
+	/*
+	 * Wait for every reader to see the writer's signal and switch from
+	 * percpu refcounts to global rwlock.
+	 *
+	 * If a reader is still using percpu refcounts, wait for him to switch.
+	 * Else, we can safely go ahead, because either the reader has already
+	 * switched over, or the next reader that comes along on that CPU will
+	 * notice the writer's signal and will switch over to the rwlock.
+	 */
+
+	for_each_possible_cpu(cpu) {
+		while (reader_yet_to_switch(pcpu_rwlock, cpu))
+			cpu_relax();
+	}
+
+	smp_mb(); /* Complete the wait-for-readers, before taking the lock */
 	write_lock(&pcpu_rwlock->global_rwlock);
 }
 
 void percpu_write_unlock(struct percpu_rwlock *pcpu_rwlock)
 {
+	unsigned int cpu;
+
+	/* Complete the critical section before clearing ->writer_signal */
+	smp_mb();
+
+	/*
+	 * Inform all readers that we are done, so that they can switch back
+	 * to their per-cpu refcounts. (We don't need to wait for them to
+	 * see it).
+	 */
+	for_each_possible_cpu(cpu)
+		per_cpu_ptr(pcpu_rwlock->rw_state, cpu)->writer_signal = false;
+
 	write_unlock(&pcpu_rwlock->global_rwlock);
 }
 
