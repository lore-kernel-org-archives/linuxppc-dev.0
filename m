Return-Path: <boqun.feng@gmail.com>
Received: from mail-ob0-x22f.google.com (mail-ob0-x22f.google.com
 [IPv6:2607:f8b0:4003:c01::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5639C1A089E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2015 01:50:12 +1000 (AEST)
Received: by obqa2 with SMTP id a2so152859108obq.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2015 08:50:10 -0700 (PDT)
From: Boqun Feng <boqun.feng@gmail.com>
To: linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will.deacon@arm.com>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Waiman Long <waiman.long@hp.com>, Boqun Feng <boqun.feng@gmail.com>
Subject: [RFC v2 2/7] atomics: Allow architectures to define their own
 __atomic_op_* helpers
Date: Wed, 16 Sep 2015 23:49:30 +0800
Message-Id: <1442418575-12297-3-git-send-email-boqun.feng@gmail.com>
In-Reply-To: <1442418575-12297-1-git-send-email-boqun.feng@gmail.com>
References: <1442418575-12297-1-git-send-email-boqun.feng@gmail.com>
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
index 00a5763..590c023 100644
--- a/include/linux/atomic.h
+++ b/include/linux/atomic.h
@@ -34,20 +34,29 @@
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
@@ -56,6 +65,7 @@
 	smp_mb__after_atomic();						\
 	__ret;								\
 })
+#endif
 
 /* atomic_add_return_relaxed */
 #ifndef atomic_add_return_relaxed
-- 
2.5.1
