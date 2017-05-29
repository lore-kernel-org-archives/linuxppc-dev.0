Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wbgW041sqzDq7Z
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 May 2017 12:22:36 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id s62so4897310pgc.0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 28 May 2017 19:22:36 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Nicholas Piggin <npiggin@gmail.com>, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2] spin loop primitives for busy waiting
Date: Mon, 29 May 2017 12:22:23 +1000
Message-Id: <20170529022223.14793-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Current busy-wait loops are implemented by repeatedly calling cpu_relax()
to give an arch option for a low-latency option to improve power and/or
SMT resource contention.

This poses some difficulties for powerpc, which has SMT priority setting
instructions (priorities determine how ifetch cycles are apportioned).
powerpc's cpu_relax() is implemented by setting a low priority then
setting normal priority. This has several problems:

 - Changing thread priority can have some execution cost and potential
   impact to other threads in the core. It's inefficient to execute them
   every time around a busy-wait loop.

 - Depending on implementation details, a `low ; medium` sequence may
   not have much if any affect. Some software with similar pattern
   actually inserts a lot of nops between, in order to cause a few fetch
   cycles with the low priority.

 - The busy-wait loop runs with regular priority. This might only be a few
   fetch cycles, but if there are several threads running such loops, they
   could cause a noticable impact on a non-idle thread.

Implement spin_begin, spin_end primitives that can be used around busy
wait loops, which default to no-ops. And spin_cpu_relax which defaults to
cpu_relax.

This will allow architectures to hook the entry and exit of busy-wait
loops, and will allow powerpc to set low SMT priority at entry, and
normal priority at exit.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---

Since last time:
- Fixed spin_do_cond with initial test as suggested by Linus.
- Renamed it to spin_until_cond, which reads a little better.

 include/linux/processor.h | 70 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)
 create mode 100644 include/linux/processor.h

diff --git a/include/linux/processor.h b/include/linux/processor.h
new file mode 100644
index 000000000000..da0c5e56ca02
--- /dev/null
+++ b/include/linux/processor.h
@@ -0,0 +1,70 @@
+/* Misc low level processor primitives */
+#ifndef _LINUX_PROCESSOR_H
+#define _LINUX_PROCESSOR_H
+
+#include <asm/processor.h>
+
+/*
+ * spin_begin is used before beginning a busy-wait loop, and must be paired
+ * with spin_end when the loop is exited. spin_cpu_relax must be called
+ * within the loop.
+ *
+ * The loop body should be as small and fast as possible, on the order of
+ * tens of instructions/cycles as a guide. It should and avoid calling
+ * cpu_relax, or any "spin" or sleep type of primitive including nested uses
+ * of these primitives. It should not lock or take any other resource.
+ * Violations of these guidelies will not cause a bug, but may cause sub
+ * optimal performance.
+ *
+ * These loops are optimized to be used where wait times are expected to be
+ * less than the cost of a context switch (and associated overhead).
+ *
+ * Detection of resource owner and decision to spin or sleep or guest-yield
+ * (e.g., spin lock holder vcpu preempted, or mutex owner not on CPU) can be
+ * tested within the loop body.
+ */
+#ifndef spin_begin
+#define spin_begin()
+#endif
+
+#ifndef spin_cpu_relax
+#define spin_cpu_relax() cpu_relax()
+#endif
+
+/*
+ * spin_cpu_yield may be called to yield (undirected) to the hypervisor if
+ * necessary. This should be used if the wait is expected to take longer
+ * than context switch overhead, but we can't sleep or do a directed yield.
+ */
+#ifndef spin_cpu_yield
+#define spin_cpu_yield() cpu_relax_yield()
+#endif
+
+#ifndef spin_end
+#define spin_end()
+#endif
+
+/*
+ * spin_until_cond can be used to wait for a condition to become true. It
+ * may be expected that the first iteration will true in the common case
+ * (no spinning), so that callers should not require a first "likely" test
+ * for the uncontended case before using this primitive.
+ *
+ * Usage and implementation guidelines are the same as for the spin_begin
+ * primitives, above.
+ */
+#ifndef spin_until_cond
+#define spin_until_cond(cond)					\
+do {								\
+	if (unlikely(!(cond))) {				\
+		spin_begin();					\
+		do {						\
+			spin_cpu_relax();			\
+		} while (!(cond));				\
+		spin_end();					\
+	}							\
+} while (0)
+
+#endif
+
+#endif /* _LINUX_PROCESSOR_H */
-- 
2.11.0
