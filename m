Return-Path: <boqun.feng@gmail.com>
Received: from mail-oi0-x243.google.com (mail-oi0-x243.google.com
 [IPv6:2607:f8b0:4003:c06::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BD6FE1A047B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Oct 2015 20:51:49 +1100 (AEDT)
Received: by oifu187 with SMTP id u187so9274709oif.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Oct 2015 02:51:47 -0700 (PDT)
From: Boqun Feng <boqun.feng@gmail.com>
To: linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will.deacon@arm.com>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Waiman Long <waiman.long@hp.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH tip/locking/core v5 3/6] atomics: Allow architectures to
 define their own __atomic_op_* helpers
Date: Mon, 26 Oct 2015 17:50:54 +0800
Message-Id: <1445853057-20735-4-git-send-email-boqun.feng@gmail.com>
In-Reply-To: <1445853057-20735-1-git-send-email-boqun.feng@gmail.com>
References: <1445853057-20735-1-git-send-email-boqun.feng@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Some architectures may have their special barriers for acquire, release
and fence semantics, so that general memory barriers(smp_mb__*_atomic())
in the default __atomic_op_*() may be too strong, so allow architectures
to define their own helpers which can overwrite the default helpers.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 include/linux/atomic.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/atomic.h b/include/linux/atomic.h
index 27e580d..947c1dc 100644
--- a/include/linux/atomic.h
+++ b/include/linux/atomic.h
@@ -43,20 +43,29 @@ static inline int atomic_read_ctrl(const atomic_t *v)
  * The idea here is to build acquire/release variants by adding explicit
  * barriers on top of the relaxed variant. In the case where the relaxed
  * variant is already fully ordered, no additional barriers are needed.
+ *
+ * Besides, if an arch has a special barrier for acquire/release, it could
+ * implement its own __atomic_op_* and use the same framework for building
+ * variants
  */
+#ifndef __atomic_op_acquire
 #define __atomic_op_acquire(op, args...)				\
 ({									\
 	typeof(op##_relaxed(args)) __ret  = op##_relaxed(args);		\
 	smp_mb__after_atomic();						\
 	__ret;								\
 })
+#endif
 
+#ifndef __atomic_op_release
 #define __atomic_op_release(op, args...)				\
 ({									\
 	smp_mb__before_atomic();					\
 	op##_relaxed(args);						\
 })
+#endif
 
+#ifndef __atomic_op_fence
 #define __atomic_op_fence(op, args...)					\
 ({									\
 	typeof(op##_relaxed(args)) __ret;				\
@@ -65,6 +74,7 @@ static inline int atomic_read_ctrl(const atomic_t *v)
 	smp_mb__after_atomic();						\
 	__ret;								\
 })
+#endif
 
 /* atomic_add_return_relaxed */
 #ifndef atomic_add_return_relaxed
-- 
2.6.2
