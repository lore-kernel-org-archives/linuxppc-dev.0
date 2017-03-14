Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vj8Sy5qmpzDqYc
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Mar 2017 20:24:34 +1100 (AEDT)
Received: by mail-pg0-x241.google.com with SMTP id g2so18770780pge.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Mar 2017 02:24:34 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Gautham R Shenoy <ego@linux.vnet.ibm.com>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Subject: [PATCH 8/8] powerpc/64s: idle POWER8 avoid full state loss recovery
 when possible
Date: Tue, 14 Mar 2017 19:23:49 +1000
Message-Id: <20170314092349.10981-9-npiggin@gmail.com>
In-Reply-To: <20170314092349.10981-1-npiggin@gmail.com>
References: <20170314092349.10981-1-npiggin@gmail.com>
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

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/cpuidle.h | 32 ++++++++++++++++++++++++---
 arch/powerpc/kernel/idle_book3s.S  | 45 +++++++++++++++++++++++++++++++++-----
 2 files changed, 68 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/include/asm/cpuidle.h b/arch/powerpc/include/asm/cpuidle.h
index b9d9f960dffd..b68a5cd75ae8 100644
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
index 3cb75907c5c5..87518a1dca50 100644
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
@@ -437,16 +442,14 @@ pnv_restore_hyp_resource_arch300:
 pnv_restore_hyp_resource_arch207:
 	/*
 	 * POWER ISA 2.07 or less.
-	 * Check if we slept with winkle.
+	 * Check if we slept with sleep or winkle.
 	 */
 	ld	r2,PACATOC(r13);
 
-	lbz	r0,PACA_THREAD_IDLE_STATE(r13)
-	cmpwi	cr2,r0,PNV_THREAD_NAP
-	cmpwi	cr4,r0,PNV_THREAD_WINKLE
+	lbz	r4,PACA_THREAD_IDLE_STATE(r13)
 	li	r0,PNV_THREAD_RUNNING
 	stb	r0,PACA_THREAD_IDLE_STATE(r13)	/* Clear thread state */
-
+	cmpwi	cr2,r4,PNV_THREAD_NAP
 	bgt	cr2,pnv_wakeup_tb_loss	/* Either sleep or Winkle */
 
 
@@ -467,7 +470,12 @@ pnv_restore_hyp_resource_arch207:
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
@@ -482,6 +490,7 @@ pnv_wakeup_tb_loss:
 	 * required to return back to caller after hypervisor state restore is
 	 * complete.
 	 */
+	mr	r18,r4
 	mflr	r17
 	mfspr	r16,SPRN_SRR1
 BEGIN_FTR_SECTION
@@ -517,10 +526,34 @@ END_FTR_SECTION_IFSET(CPU_FTR_HVMODE)
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
+	 * (to match ISA300, above).
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
+	cmpwi	cr4,r18,PNV_THREAD_WINKLE
+
 	lbz	r4,PACA_SUBCORE_SIBLING_MASK(r13)
 	and	r4,r4,r15
 	cmpwi	r4,0	/* Check if first in subcore */
-- 
2.11.0
