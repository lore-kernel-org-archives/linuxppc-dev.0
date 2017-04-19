Return-Path: <npiggin@gmail.com>
Received: from mail-io0-x242.google.com (mail-io0-x242.google.com
 [IPv6:2607:f8b0:4001:c06::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w7MhM4pzZzDqmS
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 23:06:27 +1000 (AEST)
Received: by mail-io0-x242.google.com with SMTP id x86so3492705ioe.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 06:06:27 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 8/9] powerpc/64s: idle POWER8 avoid full state loss recovery
 where possible
Date: Wed, 19 Apr 2017 23:05:50 +1000
Message-Id: <20170419130551.32378-9-npiggin@gmail.com>
In-Reply-To: <20170419130551.32378-1-npiggin@gmail.com>
References: <20170419130551.32378-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If not all threads were in winkle, full state loss recovery is not
necessary and can be avoided. A previous patch removed this optimisation
due to some complexity with the implementation. Re-implement it by
counting the number of threads in winkle with the per-core idle state.
Only restore full state loss if all threads were in winkle.

This has a small window of false positives right before threads execute
winkle and just after they wake up, when the winkle count does not
reflect the true number of threads in winkle. This is not a significant
problem in comparison with even the minimum winkle duration. For
correctness, a false positive is not a problem (only false negatives
would be).

Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/cpuidle.h | 32 ++++++++++++--
 arch/powerpc/kernel/idle_book3s.S  | 89 +++++++++++++++++++++++++++++++++++---
 2 files changed, 112 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/include/asm/cpuidle.h b/arch/powerpc/include/asm/cpuidle.h
index dd6a63f0a10f..52586f9956bb 100644
--- a/arch/powerpc/include/asm/cpuidle.h
+++ b/arch/powerpc/include/asm/cpuidle.h
@@ -2,13 +2,39 @@
 #define _ASM_POWERPC_CPUIDLE_H
 
 #ifdef CONFIG_PPC_POWERNV
-/* Used in powernv idle state management */
+/* Thread state used in powernv idle state management */
 #define PNV_THREAD_RUNNING              0
 #define PNV_THREAD_NAP                  1
 #define PNV_THREAD_SLEEP                2
 #define PNV_THREAD_WINKLE               3
-#define PNV_CORE_IDLE_LOCK_BIT          0x10000000
-#define PNV_CORE_IDLE_THREAD_BITS       0x000000FF
+
+/*
+ * Core state used in powernv idle for POWER8.
+ *
+ * The lock bit synchronizes updates to the state, as well as parts of the
+ * sleep/wake code (see kernel/idle_book3s.S).
+ *
+ * Bottom 8 bits track the idle state of each thread. Bit is cleared before
+ * the thread executes an idle instruction (nap/sleep/winkle).
+ *
+ * Then there is winkle tracking. A core does not lose complete state
+ * until every thread is in winkle. So the winkle count field counts the
+ * number of threads in winkle (small window of false positives is okay
+ * around the sleep/wake, so long as there are no false negatives).
+ *
+ * When the winkle count reaches 8 (the COUNT_ALL_BIT becomes set), then
+ * the THREAD_WINKLE_BITS are set, which indicate which threads have not
+ * yet woken from the winkle state.
+ */
+#define PNV_CORE_IDLE_LOCK_BIT			0x10000000
+
+#define PNV_CORE_IDLE_WINKLE_COUNT		0x00010000
+#define PNV_CORE_IDLE_WINKLE_COUNT_ALL_BIT	0x00080000
+#define PNV_CORE_IDLE_WINKLE_COUNT_BITS		0x000F0000
+#define PNV_CORE_IDLE_THREAD_WINKLE_BITS_SHIFT	8
+#define PNV_CORE_IDLE_THREAD_WINKLE_BITS	0x0000FF00
+
+#define PNV_CORE_IDLE_THREAD_BITS       	0x000000FF
 
 /*
  * ============================ NOTE =================================
diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
index db60e051fb1c..97c014de0ca3 100644
--- a/arch/powerpc/kernel/idle_book3s.S
+++ b/arch/powerpc/kernel/idle_book3s.S
@@ -210,15 +210,20 @@ pnv_enter_arch207_idle_mode:
 	/* Sleep or winkle */
 	lbz	r7,PACA_THREAD_MASK(r13)
 	ld	r14,PACA_CORE_IDLE_STATE_PTR(r13)
+	li	r5,0
+	beq	cr3,3f
+	lis	r5,PNV_CORE_IDLE_WINKLE_COUNT@h
+3:
 lwarx_loop1:
 	lwarx	r15,0,r14
 
 	andis.	r9,r15,PNV_CORE_IDLE_LOCK_BIT@h
 	bnel-	core_idle_lock_held
 
+	add	r15,r15,r5			/* Add if winkle */
 	andc	r15,r15,r7			/* Clear thread bit */
 
-	andi.	r15,r15,PNV_CORE_IDLE_THREAD_BITS
+	andi.	r9,r15,PNV_CORE_IDLE_THREAD_BITS
 
 /*
  * If cr0 = 0, then current thread is the last thread of the core entering
@@ -509,14 +514,13 @@ ALT_FTR_SECTION_END_IFSET(CPU_FTR_POWER9_DD1)
 pnv_restore_hyp_resource_arch207:
 	/*
 	 * POWER ISA 2.07 or less.
-	 * Check if we slept with winkle.
+	 * Check if we slept with sleep or winkle.
 	 */
 	ld	r2,PACATOC(r13);
 
-	lbz	r0,PACA_THREAD_IDLE_STATE(r13)
-	cmpwi   cr2,r0,PNV_THREAD_NAP
-	cmpwi   cr4,r0,PNV_THREAD_WINKLE
-	bgt     cr2,pnv_wakeup_tb_loss	/* Either sleep or Winkle */
+	lbz	r4,PACA_THREAD_IDLE_STATE(r13)
+	cmpwi	cr2,r4,PNV_THREAD_NAP
+	bgt	cr2,pnv_wakeup_tb_loss	/* Either sleep or Winkle */
 
 	/*
 	 * We fall through here if PACA_THREAD_IDLE_STATE shows we are waking
@@ -535,7 +539,12 @@ pnv_restore_hyp_resource_arch207:
  *
  * r13 - PACA
  * cr3 - gt if waking up with partial/complete hypervisor state loss
+ *
+ * If ISA300:
  * cr4 - gt or eq if waking up from complete hypervisor state loss.
+ *
+ * If ISA207:
+ * r4 - PACA_THREAD_IDLE_STATE
  */
 pnv_wakeup_tb_loss:
 	ld	r1,PACAR1(r13)
@@ -563,6 +572,7 @@ pnv_wakeup_tb_loss:
 	 * required to return back to caller after hypervisor state restore is
 	 * complete.
 	 */
+	mr	r18,r4
 	mflr	r17
 	mfspr	r16,SPRN_SRR1
 BEGIN_FTR_SECTION
@@ -598,10 +608,77 @@ END_FTR_SECTION_IFSET(CPU_FTR_HVMODE)
 	 * At this stage
 	 * cr2 - eq if first thread to wakeup in core
 	 * cr3-  gt if waking up with partial/complete hypervisor state loss
+	 * ISA300:
 	 * cr4 - gt or eq if waking up from complete hypervisor state loss.
 	 */
 
 BEGIN_FTR_SECTION
+	/*
+	 * Were we in winkle?
+	 * If yes, check if all threads were in winkle, decrement our
+	 * winkle count, set all thread winkle bits if all were in winkle.
+	 * Check if our thread has a winkle bit set, and set cr4 accordingly
+	 * (to match ISA300, above). Pseudo-code for core idle state
+	 * transitions for ISA207 is as follows (everything happens atomically
+	 * due to store conditional and/or lock bit):
+	 *
+	 * nap_idle() { }
+	 * nap_wake() { }
+	 *
+	 * sleep_idle()
+	 * {
+	 *	core_idle_state &= ~thread_in_core
+	 * }
+	 *
+	 * sleep_wake()
+	 * {
+	 *     bool first_in_core, first_in_subcore;
+	 *
+	 *     first_in_core = (core_idle_state & IDLE_THREAD_BITS) == 0;
+	 *     first_in_subcore = (core_idle_state & SUBCORE_SIBLING_MASK) == 0;
+	 *
+	 *     core_idle_state |= thread_in_core;
+	 * }
+	 *
+	 * winkle_idle()
+	 * {
+	 *	core_idle_state &= ~thread_in_core;
+	 *	core_idle_state += 1 << WINKLE_COUNT_SHIFT;
+	 * }
+	 *
+	 * winkle_wake()
+	 * {
+	 *     bool first_in_core, first_in_subcore, winkle_state_lost;
+	 *
+	 *     first_in_core = (core_idle_state & IDLE_THREAD_BITS) == 0;
+	 *     first_in_subcore = (core_idle_state & SUBCORE_SIBLING_MASK) == 0;
+	 *
+	 *     core_idle_state |= thread_in_core;
+	 *
+	 *     if ((core_idle_state & WINKLE_MASK) == (8 << WINKLE_COUNT_SIHFT))
+	 *         core_idle_state |= THREAD_WINKLE_BITS;
+	 *     core_idle_state -= 1 << WINKLE_COUNT_SHIFT;
+	 *
+	 *     winkle_state_lost = core_idle_state &
+	 *				(thread_in_core << WINKLE_THREAD_SHIFT);
+	 *     core_idle_state &= ~(thread_in_core << WINKLE_THREAD_SHIFT);
+	 * }
+	 *
+	 */
+	cmpwi	r18,PNV_THREAD_WINKLE
+	bne	2f
+	andis.	r9,r15,PNV_CORE_IDLE_WINKLE_COUNT_ALL_BIT@h
+	subis	r15,r15,PNV_CORE_IDLE_WINKLE_COUNT@h
+	beq	2f
+	ori	r15,r15,PNV_CORE_IDLE_THREAD_WINKLE_BITS /* all were winkle */
+2:
+	/* Shift thread bit to winkle mask, then test if this thread is set,
+	 * and remove it from the winkle bits */
+	slwi	r8,r7,8
+	and	r8,r8,r15
+	andc	r15,r15,r8
+	cmpwi	cr4,r8,1 /* cr4 will be gt if our bit is set, lt if not */
+
 	lbz	r4,PACA_SUBCORE_SIBLING_MASK(r13)
 	and	r4,r4,r15
 	cmpwi	r4,0	/* Check if first in subcore */
-- 
2.11.0
