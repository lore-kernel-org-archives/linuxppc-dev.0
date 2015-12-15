Return-Path: <boqun.feng@gmail.com>
Received: from mail-ob0-x243.google.com (mail-ob0-x243.google.com
 [IPv6:2607:f8b0:4003:c01::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DCB7F1A0B50
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Dec 2015 01:25:00 +1100 (AEDT)
Received: by mail-ob0-x243.google.com with SMTP id ny9so722045obb.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Dec 2015 06:25:00 -0800 (PST)
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
Subject: [PATCH v6 1/4] atomics: Allow architectures to define their own
 __atomic_op_* helpers
Date: Tue, 15 Dec 2015 22:24:14 +0800
Message-Id: <1450189457-10589-2-git-send-email-boqun.feng@gmail.com>
In-Reply-To: <1450189457-10589-1-git-send-email-boqun.feng@gmail.com>
References: <1450189457-10589-1-git-send-email-boqun.feng@gmail.com>
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
index 301de78..5f3ee5a 100644
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
2.6.4
