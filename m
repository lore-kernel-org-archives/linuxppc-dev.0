Return-Path: <borntraeger@de.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t0kjr5hF8zDvXs
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Oct 2016 22:59:12 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u9LBwXbu143485
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Oct 2016 07:59:10 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0a-001b2d01.pphosted.com with ESMTP id 267er5u157-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Oct 2016 07:59:10 -0400
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <borntraeger@de.ibm.com>;
 Fri, 21 Oct 2016 12:59:08 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 24C621B08077
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Oct 2016 13:01:10 +0100 (BST)
Received: from d06av10.portsmouth.uk.ibm.com (d06av10.portsmouth.uk.ibm.com
 [9.149.37.251])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u9LBx5cS29950140
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Oct 2016 11:59:05 GMT
Received: from d06av10.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av10.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u9LAx6ET005263
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Oct 2016 04:59:07 -0600
From: Christian Borntraeger <borntraeger@de.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
 linux-s390 <linux-s390@vger.kernel.org>, linux-arch@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, Noam Camus <noamc@ezchip.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 4/5] Remove cpu_relax_lowlatency users
Date: Fri, 21 Oct 2016 13:58:57 +0200
In-Reply-To: <1477051138-1610-1-git-send-email-borntraeger@de.ibm.com>
References: <1477051138-1610-1-git-send-email-borntraeger@de.ibm.com>
Message-Id: <1477051138-1610-5-git-send-email-borntraeger@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

With the s390 special case of a yielding cpu_relax implementation gone,
we can now remove all users of cpu_relax_lowlatency.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 drivers/gpu/drm/i915/i915_gem_request.c | 2 +-
 drivers/vhost/net.c                     | 4 ++--
 kernel/locking/mcs_spinlock.h           | 4 ++--
 kernel/locking/mutex.c                  | 4 ++--
 kernel/locking/osq_lock.c               | 6 +++---
 kernel/locking/qrwlock.c                | 6 +++---
 kernel/locking/rwsem-xadd.c             | 4 ++--
 lib/lockref.c                           | 2 +-
 8 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_gem_request.c b/drivers/gpu/drm/i915/i915_gem_request.c
index 8832f8e..383d134 100644
--- a/drivers/gpu/drm/i915/i915_gem_request.c
+++ b/drivers/gpu/drm/i915/i915_gem_request.c
@@ -723,7 +723,7 @@ bool __i915_spin_request(const struct drm_i915_gem_request *req,
 		if (busywait_stop(timeout_us, cpu))
 			break;
 
-		cpu_relax_lowlatency();
+		cpu_relax();
 	} while (!need_resched());
 
 	return false;
diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 5dc128a..5dc3465 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -342,7 +342,7 @@ static int vhost_net_tx_get_vq_desc(struct vhost_net *net,
 		endtime = busy_clock() + vq->busyloop_timeout;
 		while (vhost_can_busy_poll(vq->dev, endtime) &&
 		       vhost_vq_avail_empty(vq->dev, vq))
-			cpu_relax_lowlatency();
+			cpu_relax();
 		preempt_enable();
 		r = vhost_get_vq_desc(vq, vq->iov, ARRAY_SIZE(vq->iov),
 				      out_num, in_num, NULL, NULL);
@@ -533,7 +533,7 @@ static int vhost_net_rx_peek_head_len(struct vhost_net *net, struct sock *sk)
 		while (vhost_can_busy_poll(&net->dev, endtime) &&
 		       !sk_has_rx_data(sk) &&
 		       vhost_vq_avail_empty(&net->dev, vq))
-			cpu_relax_lowlatency();
+			cpu_relax();
 
 		preempt_enable();
 
diff --git a/kernel/locking/mcs_spinlock.h b/kernel/locking/mcs_spinlock.h
index c835270..6a385aa 100644
--- a/kernel/locking/mcs_spinlock.h
+++ b/kernel/locking/mcs_spinlock.h
@@ -28,7 +28,7 @@ struct mcs_spinlock {
 #define arch_mcs_spin_lock_contended(l)					\
 do {									\
 	while (!(smp_load_acquire(l)))					\
-		cpu_relax_lowlatency();					\
+		cpu_relax();						\
 } while (0)
 #endif
 
@@ -108,7 +108,7 @@ void mcs_spin_unlock(struct mcs_spinlock **lock, struct mcs_spinlock *node)
 			return;
 		/* Wait until the next pointer is set */
 		while (!(next = READ_ONCE(node->next)))
-			cpu_relax_lowlatency();
+			cpu_relax();
 	}
 
 	/* Pass lock to next waiter. */
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index a70b90d..4463405 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -241,7 +241,7 @@ bool mutex_spin_on_owner(struct mutex *lock, struct task_struct *owner)
 			break;
 		}
 
-		cpu_relax_lowlatency();
+		cpu_relax();
 	}
 	rcu_read_unlock();
 
@@ -377,7 +377,7 @@ static bool mutex_optimistic_spin(struct mutex *lock,
 		 * memory barriers as we'll eventually observe the right
 		 * values at the cost of a few extra spins.
 		 */
-		cpu_relax_lowlatency();
+		cpu_relax();
 	}
 
 	osq_unlock(&lock->osq);
diff --git a/kernel/locking/osq_lock.c b/kernel/locking/osq_lock.c
index 05a3785..4ea2710 100644
--- a/kernel/locking/osq_lock.c
+++ b/kernel/locking/osq_lock.c
@@ -75,7 +75,7 @@ osq_wait_next(struct optimistic_spin_queue *lock,
 				break;
 		}
 
-		cpu_relax_lowlatency();
+		cpu_relax();
 	}
 
 	return next;
@@ -122,7 +122,7 @@ bool osq_lock(struct optimistic_spin_queue *lock)
 		if (need_resched())
 			goto unqueue;
 
-		cpu_relax_lowlatency();
+		cpu_relax();
 	}
 	return true;
 
@@ -148,7 +148,7 @@ bool osq_lock(struct optimistic_spin_queue *lock)
 		if (smp_load_acquire(&node->locked))
 			return true;
 
-		cpu_relax_lowlatency();
+		cpu_relax();
 
 		/*
 		 * Or we race against a concurrent unqueue()'s step-B, in which
diff --git a/kernel/locking/qrwlock.c b/kernel/locking/qrwlock.c
index 19248dd..cc3ed0c 100644
--- a/kernel/locking/qrwlock.c
+++ b/kernel/locking/qrwlock.c
@@ -54,7 +54,7 @@ static __always_inline void
 rspin_until_writer_unlock(struct qrwlock *lock, u32 cnts)
 {
 	while ((cnts & _QW_WMASK) == _QW_LOCKED) {
-		cpu_relax_lowlatency();
+		cpu_relax();
 		cnts = atomic_read_acquire(&lock->cnts);
 	}
 }
@@ -130,7 +130,7 @@ void queued_write_lock_slowpath(struct qrwlock *lock)
 		   (cmpxchg_relaxed(&l->wmode, 0, _QW_WAITING) == 0))
 			break;
 
-		cpu_relax_lowlatency();
+		cpu_relax();
 	}
 
 	/* When no more readers, set the locked flag */
@@ -141,7 +141,7 @@ void queued_write_lock_slowpath(struct qrwlock *lock)
 					    _QW_LOCKED) == _QW_WAITING))
 			break;
 
-		cpu_relax_lowlatency();
+		cpu_relax();
 	}
 unlock:
 	arch_spin_unlock(&lock->wait_lock);
diff --git a/kernel/locking/rwsem-xadd.c b/kernel/locking/rwsem-xadd.c
index 2337b4b..2fa2e2e6 100644
--- a/kernel/locking/rwsem-xadd.c
+++ b/kernel/locking/rwsem-xadd.c
@@ -368,7 +368,7 @@ static noinline bool rwsem_spin_on_owner(struct rw_semaphore *sem)
 			return false;
 		}
 
-		cpu_relax_lowlatency();
+		cpu_relax();
 	}
 	rcu_read_unlock();
 out:
@@ -423,7 +423,7 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem)
 		 * memory barriers as we'll eventually observe the right
 		 * values at the cost of a few extra spins.
 		 */
-		cpu_relax_lowlatency();
+		cpu_relax();
 	}
 	osq_unlock(&sem->osq);
 done:
diff --git a/lib/lockref.c b/lib/lockref.c
index 5a92189..c4bfcb8 100644
--- a/lib/lockref.c
+++ b/lib/lockref.c
@@ -20,7 +20,7 @@
 		if (likely(old.lock_count == prev.lock_count)) {		\
 			SUCCESS;						\
 		}								\
-		cpu_relax_lowlatency();						\
+		cpu_relax();							\
 	}									\
 } while (0)
 
-- 
2.5.5
