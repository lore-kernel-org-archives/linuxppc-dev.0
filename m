Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wNzn31w9KzDqFJ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 May 2017 02:57:43 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id w69so3897095pfk.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 May 2017 09:57:43 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Nicholas Piggin <npiggin@gmail.com>, linux-arch@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] spin loop primitives for busy waiting
Date: Fri, 12 May 2017 02:57:27 +1000
Message-Id: <20170511165727.17847-1-npiggin@gmail.com>
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

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---

Hi Linus,

Since last discussion of this, I changed the interface to match what you
suggested (e.g., just start/end to be called as a pair from anywhere
in control flow).

If you find this acceptable, I'd like to start wiring in the powerpc
and adding the annotations to some important core spin loops (there's
not too many really). I'm hoping if you take this patch during this
merge window, I'll be able to start sending small patches to maintainers
for the next window. Unless you have a better suggestion for how to
deal with this.

Thanks,
Nick

 include/linux/processor.h | 62 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 include/linux/processor.h

diff --git a/include/linux/processor.h b/include/linux/processor.h
new file mode 100644
index 000000000000..0a058aaa9bab
--- /dev/null
+++ b/include/linux/processor.h
@@ -0,0 +1,62 @@
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
+ * spin_on_cond can be used to wait for a condition to become true. It
+ * may be expected that the first iteration will true in the common case
+ * (no spinning).
+ */
+#ifndef spin_on_cond
+#define spin_on_cond(cond)					\
+do {								\
+	spin_begin();						\
+	while (cond)						\
+		spin_cpu_relax();				\
+	spin_end();						\
+} while (0)
+#endif
+
+#endif /* _LINUX_PROCESSOR_H */
-- 
2.11.0
