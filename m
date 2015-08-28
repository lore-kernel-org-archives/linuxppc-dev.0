Return-Path: <boqun.feng@gmail.com>
Received: from mail-ig0-x234.google.com (mail-ig0-x234.google.com
 [IPv6:2607:f8b0:4001:c05::234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1E4D91A01ED
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Aug 2015 12:48:53 +1000 (AEST)
Received: by igcse8 with SMTP id se8so8740736igc.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Aug 2015 19:48:51 -0700 (PDT)
From: Boqun Feng <boqun.feng@gmail.com>
To: linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will.deacon@arm.com>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Waiman Long <waiman.long@hp.com>, Boqun Feng <boqun.feng@gmail.com>
Subject: [RFC 2/5] atomics: introduce arch_atomic_op_{acquire, release,
 fence} helpers
Date: Fri, 28 Aug 2015 10:48:16 +0800
Message-Id: <1440730099-29133-3-git-send-email-boqun.feng@gmail.com>
In-Reply-To: <1440730099-29133-1-git-send-email-boqun.feng@gmail.com>
References: <1440730099-29133-1-git-send-email-boqun.feng@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Some architectures may have their special barriers for acquire, release
and fence semantics, general memory barriers(smp_mb__*_atomic()) in
__atomic_op_*() may be too strong, so arch_atomic_op_*() helpers are
introduced for architectures to provide their own version helpers to
build different variants based on _relaxed variants.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 include/linux/atomic.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/linux/atomic.h b/include/linux/atomic.h
index 00a5763..622255b 100644
--- a/include/linux/atomic.h
+++ b/include/linux/atomic.h
@@ -34,20 +34,33 @@
  * The idea here is to build acquire/release variants by adding explicit
  * barriers on top of the relaxed variant. In the case where the relaxed
  * variant is already fully ordered, no additional barriers are needed.
+ *
+ * Besides, if an arch has a special barrier for acquire/release, it could
+ * implement its own arch_atomic_op_* and use the same framework for building
+ * variants
  */
+#ifndef arch_atomic_op_acquire
 #define __atomic_op_acquire(op, args...)				\
 ({									\
 	typeof(op##_relaxed(args)) __ret  = op##_relaxed(args);		\
 	smp_mb__after_atomic();						\
 	__ret;								\
 })
+#else
+#define __atomic_op_acquire arch_atomic_op_acquire
+#endif
 
+#ifndef arch_atomic_op_release
 #define __atomic_op_release(op, args...)				\
 ({									\
 	smp_mb__before_atomic();					\
 	op##_relaxed(args);						\
 })
+#else
+#define __atomic_op_release arch_atomic_op_release
+#endif
 
+#ifndef arch_atomic_op_fence
 #define __atomic_op_fence(op, args...)					\
 ({									\
 	typeof(op##_relaxed(args)) __ret;				\
@@ -56,6 +69,9 @@
 	smp_mb__after_atomic();						\
 	__ret;								\
 })
+#else
+#define __atomic_op_fence arch_atomic_op_fence
+#endif
 
 /* atomic_add_return_relaxed */
 #ifndef atomic_add_return_relaxed
-- 
2.5.0
