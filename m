Return-Path: <paulus@bilbo.ozlabs.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id B039DB70BA
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 18 Aug 2009 09:01:34 +1000 (EST)
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 94454DDD01
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Aug 2009 09:01:34 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <19081.57621.37210.987830@cargo.ozlabs.ibm.com>
Date: Tue, 18 Aug 2009 09:00:37 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/3 v3] powerpc: Allow perf_counters to access user memory at
	interrupt time
In-Reply-To: <19081.57584.173693.798535@cargo.ozlabs.ibm.com>
References: <19081.57584.173693.798535@cargo.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This provides a mechanism to allow the perf_counters code to access
user memory in a PMU interrupt routine.  Such an access can cause
various kinds of interrupt: SLB miss, MMU hash table miss, segment
table miss, or TLB miss, depending on the processor.  This commit
only deals with 64-bit classic/server processors, which use an MMU
hash table.  32-bit processors are already able to access user memory
at interrupt time.  Since we don't soft-disable on 32-bit, we avoid
the possibility of reentering hash_page or the TLB miss handlers,
since they run with interrupts disabled.

On 64-bit processors, an SLB miss interrupt on a user address will
update the slb_cache and slb_cache_ptr fields in the paca.  This is
OK except in the case where a PMU interrupt occurs in switch_slb,
which also accesses those fields.  To prevent this, we hard-disable
interrupts in switch_slb.  Interrupts are already soft-disabled at
this point, and will get hard-enabled when they get soft-enabled
later.

This also reworks slb_flush_and_rebolt: to avoid hard-disabling twice,
and to make sure that it clears the slb_cache_ptr when called from
other callers than switch_slb, the existing routine is renamed to
__slb_flush_and_rebolt, which is called by switch_slb and the new
version of slb_flush_and_rebolt.

Similarly, switch_stab (used on POWER3 and RS64 processors) gets a
hard_irq_disable() to protect the per-cpu variables used there and
in ste_allocate.

If a MMU hashtable miss interrupt occurs, normally we would call
hash_page to look up the Linux PTE for the address and create a HPTE.
However, hash_page is fairly complex and takes some locks, so to
avoid the possibility of deadlock, we check the preemption count
to see if we are in a (pseudo-)NMI handler, and if so, we don't call
hash_page but instead treat it like a bad access that will get
reported up through the exception table mechanism.  An interrupt
whose handler runs even though the interrupt occurred when
soft-disabled (such as the PMU interrupt) is considered a pseudo-NMI
handler, which should use nmi_enter()/nmi_exit() rather than
irq_enter()/irq_exit().

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/kernel/asm-offsets.c    |    2 +
 arch/powerpc/kernel/exceptions-64s.S |   19 +++++++++++++++++
 arch/powerpc/mm/slb.c                |   37 +++++++++++++++++++++++----------
 arch/powerpc/mm/stab.c               |   11 +++++++++-
 4 files changed, 57 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 561b646..197b156 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -67,6 +67,8 @@ int main(void)
 	DEFINE(MMCONTEXTID, offsetof(struct mm_struct, context.id));
 #ifdef CONFIG_PPC64
 	DEFINE(AUDITCONTEXT, offsetof(struct task_struct, audit_context));
+	DEFINE(SIGSEGV, SIGSEGV);
+	DEFINE(NMI_MASK, NMI_MASK);
 #else
 	DEFINE(THREAD_INFO, offsetof(struct task_struct, stack));
 #endif /* CONFIG_PPC64 */
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index eb89811..8ac85e0 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -729,6 +729,11 @@ BEGIN_FTR_SECTION
 	bne-	do_ste_alloc		/* If so handle it */
 END_FTR_SECTION_IFCLR(CPU_FTR_SLB)
 
+	clrrdi	r11,r1,THREAD_SHIFT
+	lwz	r0,TI_PREEMPT(r11)	/* If we're in an "NMI" */
+	andis.	r0,r0,NMI_MASK@h	/* (i.e. an irq when soft-disabled) */
+	bne	77f			/* then don't call hash_page now */
+
 	/*
 	 * On iSeries, we soft-disable interrupts here, then
 	 * hard-enable interrupts so that the hash_page code can spin on
@@ -833,6 +838,20 @@ handle_page_fault:
 	bl	.low_hash_fault
 	b	.ret_from_except
 
+/*
+ * We come here as a result of a DSI at a point where we don't want
+ * to call hash_page, such as when we are accessing memory (possibly
+ * user memory) inside a PMU interrupt that occurred while interrupts
+ * were soft-disabled.  We want to invoke the exception handler for
+ * the access, or panic if there isn't a handler.
+ */
+77:	bl	.save_nvgprs
+	mr	r4,r3
+	addi	r3,r1,STACK_FRAME_OVERHEAD
+	li	r5,SIGSEGV
+	bl	.bad_page_fault
+	b	.ret_from_except
+
 	/* here we have a segment miss */
 do_ste_alloc:
 	bl	.ste_allocate		/* try to insert stab entry */
diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
index 5b7038f..a685652 100644
--- a/arch/powerpc/mm/slb.c
+++ b/arch/powerpc/mm/slb.c
@@ -92,15 +92,13 @@ static inline void create_shadowed_slbe(unsigned long ea, int ssize,
 		     : "memory" );
 }
 
-void slb_flush_and_rebolt(void)
+static void __slb_flush_and_rebolt(void)
 {
 	/* If you change this make sure you change SLB_NUM_BOLTED
 	 * appropriately too. */
 	unsigned long linear_llp, vmalloc_llp, lflags, vflags;
 	unsigned long ksp_esid_data, ksp_vsid_data;
 
-	WARN_ON(!irqs_disabled());
-
 	linear_llp = mmu_psize_defs[mmu_linear_psize].sllp;
 	vmalloc_llp = mmu_psize_defs[mmu_vmalloc_psize].sllp;
 	lflags = SLB_VSID_KERNEL | linear_llp;
@@ -117,12 +115,6 @@ void slb_flush_and_rebolt(void)
 		ksp_vsid_data = get_slb_shadow()->save_area[2].vsid;
 	}
 
-	/*
-	 * We can't take a PMU exception in the following code, so hard
-	 * disable interrupts.
-	 */
-	hard_irq_disable();
-
 	/* We need to do this all in asm, so we're sure we don't touch
 	 * the stack between the slbia and rebolting it. */
 	asm volatile("isync\n"
@@ -139,6 +131,21 @@ void slb_flush_and_rebolt(void)
 		     : "memory");
 }
 
+void slb_flush_and_rebolt(void)
+{
+
+	WARN_ON(!irqs_disabled());
+
+	/*
+	 * We can't take a PMU exception in the following code, so hard
+	 * disable interrupts.
+	 */
+	hard_irq_disable();
+
+	__slb_flush_and_rebolt();
+	get_paca()->slb_cache_ptr = 0;
+}
+
 void slb_vmalloc_update(void)
 {
 	unsigned long vflags;
@@ -180,12 +187,20 @@ static inline int esids_match(unsigned long addr1, unsigned long addr2)
 /* Flush all user entries from the segment table of the current processor. */
 void switch_slb(struct task_struct *tsk, struct mm_struct *mm)
 {
-	unsigned long offset = get_paca()->slb_cache_ptr;
+	unsigned long offset;
 	unsigned long slbie_data = 0;
 	unsigned long pc = KSTK_EIP(tsk);
 	unsigned long stack = KSTK_ESP(tsk);
 	unsigned long unmapped_base;
 
+	/*
+	 * We need interrupts hard-disabled here, not just soft-disabled,
+	 * so that a PMU interrupt can't occur, which might try to access
+	 * user memory (to get a stack trace) and possible cause an SLB miss
+	 * which would update the slb_cache/slb_cache_ptr fields in the PACA.
+	 */
+	hard_irq_disable();
+	offset = get_paca()->slb_cache_ptr;
 	if (!cpu_has_feature(CPU_FTR_NO_SLBIE_B) &&
 	    offset <= SLB_CACHE_ENTRIES) {
 		int i;
@@ -200,7 +215,7 @@ void switch_slb(struct task_struct *tsk, struct mm_struct *mm)
 		}
 		asm volatile("isync" : : : "memory");
 	} else {
-		slb_flush_and_rebolt();
+		__slb_flush_and_rebolt();
 	}
 
 	/* Workaround POWER5 < DD2.1 issue */
diff --git a/arch/powerpc/mm/stab.c b/arch/powerpc/mm/stab.c
index 98cd1dc..ab5fb48 100644
--- a/arch/powerpc/mm/stab.c
+++ b/arch/powerpc/mm/stab.c
@@ -164,7 +164,7 @@ void switch_stab(struct task_struct *tsk, struct mm_struct *mm)
 {
 	struct stab_entry *stab = (struct stab_entry *) get_paca()->stab_addr;
 	struct stab_entry *ste;
-	unsigned long offset = __get_cpu_var(stab_cache_ptr);
+	unsigned long offset;
 	unsigned long pc = KSTK_EIP(tsk);
 	unsigned long stack = KSTK_ESP(tsk);
 	unsigned long unmapped_base;
@@ -172,6 +172,15 @@ void switch_stab(struct task_struct *tsk, struct mm_struct *mm)
 	/* Force previous translations to complete. DRENG */
 	asm volatile("isync" : : : "memory");
 
+	/*
+	 * We need interrupts hard-disabled here, not just soft-disabled,
+	 * so that a PMU interrupt can't occur, which might try to access
+	 * user memory (to get a stack trace) and possible cause an STAB miss
+	 * which would update the stab_cache/stab_cache_ptr per-cpu variables.
+	 */
+	hard_irq_disable();
+
+	offset = __get_cpu_var(stab_cache_ptr);
 	if (offset <= NR_STAB_CACHE_ENTRIES) {
 		int i;
 
-- 
1.6.0.4
