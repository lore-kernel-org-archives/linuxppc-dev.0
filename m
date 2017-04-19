Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w7C4k72cZzDqBS
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 16:38:30 +1000 (AEST)
From: David Gibson <david@gibson.dropbear.id.au>
To: michael@ellerman.id.au,
	paulus@samba.org
Cc: linuxppc-dev@lists.ozlabs.org, jasowang@redhat.com, thuth@redhat.com,
 David Gibson <david@gibson.dropbear.id.au>
Subject: [RFC] arch/powerpc: Turn off irqs in switch_mm()
Date: Wed, 19 Apr 2017 16:38:26 +1000
Message-Id: <20170419063826.1678-1-david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There seems to be a mismatch in expectations between the powerpc arch code
and the generic (and x86) code in terms of the irq state when switch_mm()
is called.

powerpc expects irqs to already be (soft) disabled when switch_mm() is
called, as made clear in the commit message of 9c1e105 "powerpc: Allow
perf_counters to access user memory at interrupt time".

That seems to be true when it's called from the schedule, but not for
use_mm().  This becomes clear when looking at the x86 code paths for
switch_mm().  There, switch_mm() itself disable irqs, with a
switch_mm_irqs_off() variant which expects that to be already done.

This patch addresses the problem, making the powerpc code mirror the x86
code.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 arch/powerpc/include/asm/mmu_context.h | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

RH-Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1437794

It seems that some more recent changes in vhost have made it more
likely to hit this problem, triggering a WARN.

diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
index b9e3f0a..0012f03 100644
--- a/arch/powerpc/include/asm/mmu_context.h
+++ b/arch/powerpc/include/asm/mmu_context.h
@@ -70,8 +70,9 @@ extern void drop_cop(unsigned long acop, struct mm_struct *mm);
  * switch_mm is the entry point called from the architecture independent
  * code in kernel/sched/core.c
  */
-static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
-			     struct task_struct *tsk)
+static inline void switch_mm_irqs_off(struct mm_struct *prev,
+				      struct mm_struct *next,
+				      struct task_struct *tsk)
 {
 	/* Mark this context has been used on the new CPU */
 	if (!cpumask_test_cpu(smp_processor_id(), mm_cpumask(next)))
@@ -110,6 +111,18 @@ static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 	switch_mmu_context(prev, next, tsk);
 }
 
+static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
+			     struct task_struct *tsk)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	switch_mm_irqs_off(prev, next, tsk);
+	local_irq_restore(flags);
+}
+#define switch_mm_irqs_off switch_mm_irqs_off
+
+
 #define deactivate_mm(tsk,mm)	do { } while (0)
 
 /*
-- 
2.9.3
