Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp04.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id AF8BA2C0256
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Jan 2013 18:36:33 +1100 (EST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Tue, 22 Jan 2013 17:28:35 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id F2AEB357804F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Jan 2013 18:36:26 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r0M7OWUx1376650
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Jan 2013 18:24:32 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r0M7aPBl004708
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Jan 2013 18:36:26 +1100
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v5 06/45] percpu_rwlock: Allow writers to be readers,
 and add lockdep annotations
To: tglx@linutronix.de, peterz@infradead.org, tj@kernel.org, oleg@redhat.com,
 paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, mingo@kernel.org,
 akpm@linux-foundation.org, namhyung@kernel.org
Date: Tue, 22 Jan 2013 13:04:23 +0530
Message-ID: <20130122073416.13822.96504.stgit@srivatsabhat.in.ibm.com>
In-Reply-To: <20130122073210.13822.50434.stgit@srivatsabhat.in.ibm.com>
References: <20130122073210.13822.50434.stgit@srivatsabhat.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linux-arch@vger.kernel.org, linux@arm.linux.org.uk,
 nikunj@linux.vnet.ibm.com, linux-pm@vger.kernel.org, fweisbec@gmail.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 xiaoguangrong@linux.vnet.ibm.com, rjw@sisk.pl, sbw@mit.edu,
 wangyun@linux.vnet.ibm.com, srivatsa.bhat@linux.vnet.ibm.com,
 netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
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

 lib/percpu-rwlock.c |   21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/lib/percpu-rwlock.c b/lib/percpu-rwlock.c
index a8d177a..054a50a 100644
--- a/lib/percpu-rwlock.c
+++ b/lib/percpu-rwlock.c
@@ -84,6 +84,10 @@ void percpu_read_lock_irqsafe(struct percpu_rwlock *pcpu_rwlock)
 
 		if (likely(!writer_active(pcpu_rwlock))) {
 			this_cpu_inc(*pcpu_rwlock->reader_refcnt);
+
+			/* Pretend that we take global_rwlock for lockdep */
+			rwlock_acquire_read(&pcpu_rwlock->global_rwlock.dep_map,
+					    0, 0, _RET_IP_);
 		} else {
 			/* Writer is active, so switch to global rwlock. */
 
@@ -108,6 +112,12 @@ void percpu_read_lock_irqsafe(struct percpu_rwlock *pcpu_rwlock)
 			if (!writer_active(pcpu_rwlock)) {
 				this_cpu_inc(*pcpu_rwlock->reader_refcnt);
 				read_unlock(&pcpu_rwlock->global_rwlock);
+
+				/*
+				 * Pretend that we take global_rwlock for lockdep
+				 */
+				rwlock_acquire_read(&pcpu_rwlock->global_rwlock.dep_map,
+						    0, 0, _RET_IP_);
 			}
 		}
 	}
@@ -128,6 +138,14 @@ void percpu_read_unlock_irqsafe(struct percpu_rwlock *pcpu_rwlock)
 	if (reader_nested_percpu(pcpu_rwlock)) {
 		this_cpu_dec(*pcpu_rwlock->reader_refcnt);
 		smp_wmb(); /* Paired with smp_rmb() in sync_reader() */
+
+		/*
+		 * If this is the last decrement, then it is time to pretend
+		 * to lockdep that we are releasing the read lock.
+		 */
+		if (!reader_nested_percpu(pcpu_rwlock))
+			rwlock_release(&pcpu_rwlock->global_rwlock.dep_map,
+				       1, _RET_IP_);
 	} else {
 		read_unlock(&pcpu_rwlock->global_rwlock);
 	}
@@ -205,11 +223,14 @@ void percpu_write_lock_irqsave(struct percpu_rwlock *pcpu_rwlock,
 	announce_writer_active(pcpu_rwlock);
 	sync_all_readers(pcpu_rwlock);
 	write_lock_irqsave(&pcpu_rwlock->global_rwlock, *flags);
+	this_cpu_inc(*pcpu_rwlock->reader_refcnt);
 }
 
 void percpu_write_unlock_irqrestore(struct percpu_rwlock *pcpu_rwlock,
 			 unsigned long *flags)
 {
+	this_cpu_dec(*pcpu_rwlock->reader_refcnt);
+
 	/*
 	 * Inform all readers that we are done, so that they can switch back
 	 * to their per-cpu refcounts. (We don't need to wait for them to
