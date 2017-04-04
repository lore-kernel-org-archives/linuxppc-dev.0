Return-Path: <srs0=bjuu=3m=gmail.com=npiggin@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vxwX63H8rzDqJp
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Apr 2017 14:11:34 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3vxwX62SqXz8t03
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Apr 2017 14:11:34 +1000 (AEST)
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vxwX567rvz9s8D
 for <linuxppc-dev@ozlabs.org>; Tue,  4 Apr 2017 14:11:33 +1000 (AEST)
Received: by mail-pg0-x244.google.com with SMTP id o123so34271262pga.1
 for <linuxppc-dev@ozlabs.org>; Mon, 03 Apr 2017 21:11:33 -0700 (PDT)
Date: Tue, 4 Apr 2017 14:11:21 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>, Anton Blanchard
 <anton@samba.org>, linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: Re: [RFC][PATCH] spin loop arch primitives for busy waiting
Message-ID: <20170404141121.5510e925@roar.ozlabs.ibm.com>
In-Reply-To: <20170404130233.1f45115b@roar.ozlabs.ibm.com>
References: <20170403081328.30266-1-npiggin@gmail.com>
 <CA+55aFx92vOh28CWp5zid8RzbM=5pO0Or51zS4D8M97L=69hHA@mail.gmail.com>
 <20170404095001.664718b8@roar.ozlabs.ibm.com>
 <CA+55aFzdUMZHzXtn9PyhJg7GjYNQ5fy6=LzBNJx==Ab=U=YYjw@mail.gmail.com>
 <20170404130233.1f45115b@roar.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 4 Apr 2017 13:02:33 +1000
Nicholas Piggin <npiggin@gmail.com> wrote:

> On Mon, 3 Apr 2017 17:43:05 -0700
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 

> > But that depends on architectures having some pattern that we *can*
> > abstract. Would some "begin/in-loop/end" pattern like the above be
> > sufficient?  
> 
> Yes. begin/in/end would be sufficient for powerpc SMT priority, and
> for x86, and it looks like sparc64 too. So we could do that if you
> prefer.

How's this? I changed your name a bit just so we have a common spin_
prefix. With example powerpc implementation and one caller converted
to see the effect.

---
 arch/powerpc/include/asm/processor.h | 17 +++++++++++++
 include/linux/processor.h            | 48 ++++++++++++++++++++++++++++++++++++
 kernel/sched/idle.c                  |  7 +++++-
 3 files changed, 71 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/processor.h

diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index e9bbd450d966..1274dc818e74 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -402,6 +402,23 @@ static inline unsigned long __pack_fe01(unsigned int fpmode)
 
 #ifdef CONFIG_PPC64
 #define cpu_relax()	do { HMT_low(); HMT_medium(); barrier(); } while (0)
+
+#ifndef spin_begin
+#define spin_begin()	HMT_low()
+#endif
+
+#ifndef spin_cpu_relax
+#define spin_cpu_relax()	barrier()
+#endif
+
+#ifndef spin_cpu_yield
+#define spin_cpu_yield()
+#endif
+
+#ifndef spin_end
+#define spin_end()	HMT_medium()
+#endif
+
 #else
 #define cpu_relax()	barrier()
 #endif
diff --git a/include/linux/processor.h b/include/linux/processor.h
new file mode 100644
index 000000000000..65e5635d0069
--- /dev/null
+++ b/include/linux/processor.h
@@ -0,0 +1,48 @@
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
+ * These loop body should be as small and fast as possible, on the order of
+ * tens of instructions/cycles as a guide. It should and avoid calling
+ * cpu_relax, or any "spin" or sleep type of primitive including nested uses
+ * of these primitives. It should not lock or take any other resource.
+ * Violations of this will not cause a bug, but may cause sub optimal
+ * performance.
+ *
+ * These loops are optimized to be used where wait times are expected to be
+ * less than the cost of a context switch (and associated overhead).
+ *
+ * Detection of resource owner and decision to spin or sleep or guest-yield
+ * (e.g., spin lock holder vcpu preempted, or mutex owner not on CPU) can be
+ * tested within the busy loop body if necessary.
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
+#endif /* _LINUX_PROCESSOR_H */
+
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index ac6d5176463d..99a032d9f4a9 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -10,6 +10,7 @@
 #include <linux/mm.h>
 #include <linux/stackprotector.h>
 #include <linux/suspend.h>
+#include <linux/processor.h>
 
 #include <asm/tlb.h>
 
@@ -63,9 +64,13 @@ static noinline int __cpuidle cpu_idle_poll(void)
 	trace_cpu_idle_rcuidle(0, smp_processor_id());
 	local_irq_enable();
 	stop_critical_timings();
+
+	spin_begin();
 	while (!tif_need_resched() &&
 		(cpu_idle_force_poll || tick_check_broadcast_expired()))
-		cpu_relax();
+		spin_cpu_relax();
+	spin_end();
+
 	start_critical_timings();
 	trace_cpu_idle_rcuidle(PWR_EVENT_EXIT, smp_processor_id());
 	rcu_idle_exit();
-- 
2.11.0
