Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wBSgV6x3ZzDqH7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Apr 2017 00:01:26 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: david@gibson.dropbear.id.au,
	thuth@redhat.com,
	jasowang@redhat.com
Subject: [PATCH v2] powerpc/mm: Ensure IRQs are off in switch_mm()
Date: Tue, 25 Apr 2017 00:01:14 +1000
Message-Id: <1493042474-28410-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: David Gibson <david@gibson.dropbear.id.au>

powerpc expects IRQs to already be (soft) disabled when switch_mm() is
called, as made clear in the commit message of 9c1e105238c4 ("powerpc: Allow
perf_counters to access user memory at interrupt time").

Aside from any race conditions that might exist between switch_mm() and an IRQ,
there is also an unconditional hard_irq_disable() in switch_slb(). If that isn't
followed at some point by an IRQ enable then interrupts will remain disabled
until we return to userspace.

It is true that when switch_mm() is called from the scheduler IRQs are off, but
not when it's called by use_mm(). Looking closer we see that last year in commit
f98db6013c55 ("sched/core: Add switch_mm_irqs_off() and use it in the scheduler")
this was made more explicit by the addition of switch_mm_irqs_off() which is now
called by the scheduler, vs switch_mm() which is used by use_mm().

Arguably it is a bug in use_mm() to call switch_mm() in a different context than
it expects, but fixing that will take time.

This was discovered recently when vhost started throwing warnings such as:

  BUG: sleeping function called from invalid context at kernel/mutex.c:578
  in_atomic(): 0, irqs_disabled(): 1, pid: 10768, name: vhost-10760
  no locks held by vhost-10760/10768.
  irq event stamp: 10
  hardirqs last  enabled at (9):  _raw_spin_unlock_irq+0x40/0x80
  hardirqs last disabled at (10): switch_slb+0x2e4/0x490
  softirqs last  enabled at (0):  copy_process+0x5e8/0x1260
  softirqs last disabled at (0):  (null)
  Call Trace:
    show_stack+0x88/0x390 (unreliable)
    dump_stack+0x30/0x44
    __might_sleep+0x1c4/0x2d0
    mutex_lock_nested+0x74/0x5c0
    cgroup_attach_task_all+0x5c/0x180
    vhost_attach_cgroups_work+0x58/0x80 [vhost]
    vhost_worker+0x24c/0x3d0 [vhost]
    kthread+0xec/0x100
    ret_from_kernel_thread+0x5c/0xd4

Prior to commit 04b96e5528ca ("vhost: lockless enqueuing") (Aug 2016) the
vhost_worker() would do a spin_unlock_irq() not long after calling use_mm(),
which had the effect of reenabling IRQs. Since that commit removed the locking
in vhost_worker() the body of the vhost_worker() loop now runs with interrupts
off causing the warnings.

This patch addresses the problem by making the powerpc code mirror the x86 code,
ie. we disable interrupts in switch_mm(), and optimise the scheduler case by
defining switch_mm_irqs_off().

Cc: stable@vger.kernel.org # v4.7+
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
[mpe: Flesh out/rewrite change log, add stable]
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/mmu_context.h | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

v2: No change, just drop the RFC, and make the commit message more verbose.

diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
index 78803a7ebdd9..a114248de2ee 100644
--- a/arch/powerpc/include/asm/mmu_context.h
+++ b/arch/powerpc/include/asm/mmu_context.h
@@ -71,8 +71,9 @@ extern void drop_cop(unsigned long acop, struct mm_struct *mm);
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
@@ -111,6 +112,18 @@ static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
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
2.7.4
