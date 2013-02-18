Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp04.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BCF842C033A
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2013 23:41:24 +1100 (EST)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Mon, 18 Feb 2013 18:08:57 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 2A916394004E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2013 18:11:19 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r1ICfGGo29819068
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2013 18:11:16 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r1ICfBqm010674
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2013 23:41:18 +1100
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v6 07/46] percpu_rwlock: Allow writers to be readers,
 and add lockdep annotations
To: tglx@linutronix.de, peterz@infradead.org, tj@kernel.org, oleg@redhat.com,
 paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, mingo@kernel.org,
 akpm@linux-foundation.org, namhyung@kernel.org
Date: Mon, 18 Feb 2013 18:09:14 +0530
Message-ID: <20130218123913.26245.7713.stgit@srivatsabhat.in.ibm.com>
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

CPU hotplug (which will be the first user of per-CPU rwlocks) has a special
requirement with respect to locking: the writer, after acquiring the per-CPU
rwlock for write, must be allowed to take the same lock for read, without
deadlocking and without getting complaints from lockdep. In comparison, this
is similar to what get_online_cpus()/put_online_cpus() does today: it allows
a hotplug writer (who holds the cpu_hotplug.lock mutex) to invoke it without
locking issues, because it silently returns if the caller is the hotplug
writer itself.

This can be easily achieved with per-CPU rwlocks as well (even without a
"is this a writer?" check) by incrementing the per-CPU refcount of the writer
immediately after taking the global rwlock for write, and then decrementing
the per-CPU refcount before releasing the global rwlock.
This ensures that any reader that comes along on that CPU while the writer is
active (on that same CPU), notices the non-zero value of the nested counter
and assumes that it is a nested read-side critical section and proceeds by
just incrementing the refcount. Thus we prevent the reader from taking the
global rwlock for read, which prevents the writer from deadlocking itself.

Add that support and teach lockdep about this special locking scheme so
that it knows that this sort of usage is valid. Also add the required lockdep
annotations to enable it to detect common locking problems with per-CPU
rwlocks.

Cc: David Howells <dhowells@redhat.com>
Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 lib/percpu-rwlock.c |   33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/lib/percpu-rwlock.c b/lib/percpu-rwlock.c
index ed36531..bf95e40 100644
--- a/lib/percpu-rwlock.c
+++ b/lib/percpu-rwlock.c
@@ -102,6 +102,10 @@ void percpu_read_lock_irqsafe(struct percpu_rwlock *pcpu_rwlock)
 
 	if (likely(!writer_active(pcpu_rwlock))) {
 		this_cpu_inc(pcpu_rwlock->rw_state->reader_refcnt);
+
+		/* Pretend that we take global_rwlock for lockdep */
+		rwlock_acquire_read(&pcpu_rwlock->global_rwlock.dep_map,
+				    0, 0, _RET_IP_);
 	} else {
 		/* Writer is active, so switch to global rwlock. */
 
@@ -126,6 +130,12 @@ void percpu_read_lock_irqsafe(struct percpu_rwlock *pcpu_rwlock)
 		if (!writer_active(pcpu_rwlock)) {
 			this_cpu_inc(pcpu_rwlock->rw_state->reader_refcnt);
 			read_unlock(&pcpu_rwlock->global_rwlock);
+
+			/*
+			 * Pretend that we take global_rwlock for lockdep
+			 */
+			rwlock_acquire_read(&pcpu_rwlock->global_rwlock.dep_map,
+					    0, 0, _RET_IP_);
 		}
 	}
 
@@ -162,6 +172,13 @@ void percpu_read_unlock_irqsafe(struct percpu_rwlock *pcpu_rwlock)
 		 */
 		smp_mb();
 		this_cpu_dec(pcpu_rwlock->rw_state->reader_refcnt);
+
+		/*
+		 * Since this is the last decrement, it is time to pretend
+		 * to lockdep that we are releasing the read lock.
+		 */
+		rwlock_release(&pcpu_rwlock->global_rwlock.dep_map,
+			       1, _RET_IP_);
 	} else {
 		read_unlock(&pcpu_rwlock->global_rwlock);
 	}
@@ -200,6 +217,16 @@ void percpu_write_lock_irqsave(struct percpu_rwlock *pcpu_rwlock,
 
 	smp_mb(); /* Complete the wait-for-readers, before taking the lock */
 	write_lock_irqsave(&pcpu_rwlock->global_rwlock, *flags);
+
+	/*
+	 * It is desirable to allow the writer to acquire the percpu-rwlock
+	 * for read (if necessary), without deadlocking or getting complaints
+	 * from lockdep. To achieve that, just increment the reader_refcnt of
+	 * this CPU - that way, any attempt by the writer to acquire the
+	 * percpu-rwlock for read, will get treated as a case of nested percpu
+	 * reader, which is safe, from a locking perspective.
+	 */
+	this_cpu_inc(pcpu_rwlock->rw_state->reader_refcnt);
 }
 
 void percpu_write_unlock_irqrestore(struct percpu_rwlock *pcpu_rwlock,
@@ -207,6 +234,12 @@ void percpu_write_unlock_irqrestore(struct percpu_rwlock *pcpu_rwlock,
 {
 	unsigned int cpu;
 
+	/*
+	 * Undo the special increment that we had done in the write-lock path
+	 * in order to allow writers to be readers.
+	 */
+	this_cpu_dec(pcpu_rwlock->rw_state->reader_refcnt);
+
 	/* Complete the critical section before clearing ->writer_signal */
 	smp_mb();
 
