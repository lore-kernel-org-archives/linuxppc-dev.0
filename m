Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vj8SX3MnFzDqXy
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Mar 2017 20:24:12 +1100 (AEDT)
Received: by mail-pg0-x243.google.com with SMTP id 25so23251772pgy.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Mar 2017 02:24:12 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Gautham R Shenoy <ego@linux.vnet.ibm.com>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Subject: [PATCH 2/8] powerpc/64s: stop using bit in HSPRG0 to test winkle
Date: Tue, 14 Mar 2017 19:23:43 +1000
Message-Id: <20170314092349.10981-3-npiggin@gmail.com>
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

The POWER8 idle code has a neat trick of programming the power on engine
to restore a low bit into HSPRG0, so idle wakeup code can test and see
if it has been programmed this way and therefore lost all state, and
avoiding the expensive full restore if not.

However this messes with our r13 PACA pointer, and requires HSPRG0 to
be written to throughout the exception handlers and idle wakeup, rather
than just once on kernel entry.

Remove this complexity and assume winkle sleeps always require a state
restore. This speedup is later re-introduced by counting per-core winkles
and setting a bitmap of threads with state loss when all are in winkle.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/exception-64s.h | 13 ++-----------
 arch/powerpc/kernel/exceptions-64s.S     | 21 +++------------------
 arch/powerpc/kernel/idle_book3s.S        | 23 ++++++++---------------
 arch/powerpc/platforms/powernv/idle.c    | 13 -------------
 4 files changed, 13 insertions(+), 57 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index 14752eee3d0c..f5fe7c901b37 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -167,17 +167,14 @@ BEGIN_FTR_SECTION_NESTED(943)						\
 	std	ra,offset(r13);						\
 END_FTR_SECTION_NESTED(ftr,ftr,943)
 
-#define EXCEPTION_PROLOG_0_PACA(area)					\
+#define EXCEPTION_PROLOG_0(area)					\
+	GET_PACA(r13);							\
 	std	r9,area+EX_R9(r13);	/* save r9 */			\
 	OPT_GET_SPR(r9, SPRN_PPR, CPU_FTR_HAS_PPR);			\
 	HMT_MEDIUM;							\
 	std	r10,area+EX_R10(r13);	/* save r10 - r12 */		\
 	OPT_GET_SPR(r10, SPRN_CFAR, CPU_FTR_CFAR)
 
-#define EXCEPTION_PROLOG_0(area)					\
-	GET_PACA(r13);							\
-	EXCEPTION_PROLOG_0_PACA(area)
-
 #define __EXCEPTION_PROLOG_1(area, extra, vec)				\
 	OPT_SAVE_REG_TO_PACA(area+EX_PPR, r9, CPU_FTR_HAS_PPR);		\
 	OPT_SAVE_REG_TO_PACA(area+EX_CFAR, r10, CPU_FTR_CFAR);		\
@@ -208,12 +205,6 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 	EXCEPTION_PROLOG_1(area, extra, vec);				\
 	EXCEPTION_PROLOG_PSERIES_1(label, h);
 
-/* Have the PACA in r13 already */
-#define EXCEPTION_PROLOG_PSERIES_PACA(area, label, h, extra, vec)	\
-	EXCEPTION_PROLOG_0_PACA(area);					\
-	EXCEPTION_PROLOG_1(area, extra, vec);				\
-	EXCEPTION_PROLOG_PSERIES_1(label, h);
-
 #define __KVMTEST(h, n)							\
 	lbz	r10,HSTATE_IN_GUEST(r13);				\
 	cmpwi	r10,0;							\
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 2f837a4a78a2..e390fcd04bcb 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -116,9 +116,7 @@ EXC_VIRT_NONE(0x4000, 0x100)
 
 EXC_REAL_BEGIN(system_reset, 0x100, 0x100)
 	SET_SCRATCH0(r13)
-	GET_PACA(r13)
-	clrrdi	r13,r13,1 /* Last bit of HSPRG0 is set if waking from winkle */
-	EXCEPTION_PROLOG_PSERIES_PACA(PACA_EXGEN, system_reset_common, EXC_STD,
+	EXCEPTION_PROLOG_PSERIES(PACA_EXGEN, system_reset_common, EXC_STD,
 				 IDLETEST, 0x100)
 
 EXC_REAL_END(system_reset, 0x100, 0x100)
@@ -148,14 +146,6 @@ EXC_REAL_BEGIN(machine_check, 0x200, 0x100)
 	 * vector
 	 */
 	SET_SCRATCH0(r13)		/* save r13 */
-	/*
-	 * Running native on arch 2.06 or later, we may wakeup from winkle
-	 * inside machine check. If yes, then last bit of HSPRG0 would be set
-	 * to 1. Hence clear it unconditionally.
-	 */
-	GET_PACA(r13)
-	clrrdi	r13,r13,1
-	SET_PACA(r13)
 	EXCEPTION_PROLOG_0(PACA_EXMC)
 BEGIN_FTR_SECTION
 	b	machine_check_powernv_early
@@ -339,7 +329,7 @@ EXC_COMMON_BEGIN(machine_check_handle_early)
 	 * Go back to nap/sleep/winkle mode again if (b) is true.
 	 */
 	rlwinm.	r11,r12,47-31,30,31	/* Was it in power saving mode? */
-	beq	4f			/* No, it wasn;t */
+	beq	4f			/* No, it wasn't */
 	/* Thread was in power saving mode. Go back to nap again. */
 	cmpwi	r11,2
 	blt	3f
@@ -369,13 +359,8 @@ EXC_COMMON_BEGIN(machine_check_handle_early)
 	/*
 	 * Go back to winkle. Please note that this thread was woken up in
 	 * machine check from winkle and have not restored the per-subcore
-	 * state. Hence before going back to winkle, set last bit of HSPRG0
-	 * to 1. This will make sure that if this thread gets woken up
-	 * again at reset vector 0x100 then it will get chance to restore
-	 * the subcore state.
+	 * state.
 	 */
-	ori	r13,r13,1
-	SET_PACA(r13)
 	IDLE_STATE_ENTER_SEQ_NORET(PPC_WINKLE)
 	/* No return */
 4:
diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
index 4313c107da5d..405631b2c229 100644
--- a/arch/powerpc/kernel/idle_book3s.S
+++ b/arch/powerpc/kernel/idle_book3s.S
@@ -377,11 +377,12 @@ _GLOBAL(power9_idle_stop)
 	b	pnv_powersave_common
 	/* No return */
 
+/*
+ * Called from reset vector for powersave wakeups.
+ * cr3 - set to gt if waking up with partial/complete hypervisor state loss
+ */
 .global pnv_powersave_wakeup
 pnv_powersave_wakeup:
-BEGIN_FTR_SECTION
-	GET_PACA(r13) /* Restore HSPRG0 to get the winkle bit in r13 */
-END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_300)
 	bl	pnv_restore_hyp_resource
 
 	li	r0,PNV_THREAD_RUNNING
@@ -408,12 +409,12 @@ END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_300)
  * Check whether we have woken up with hypervisor state loss.
  * If yes, restore hypervisor state and return back to link.
  *
- * r13 - Contents of HSPRG0
  * cr3 - set to gt if waking up with partial/complete hypervisor state loss
  */
 pnv_restore_hyp_resource:
-BEGIN_FTR_SECTION
 	ld	r2,PACATOC(r13);
+
+BEGIN_FTR_SECTION
 	/*
 	 * POWER ISA 3. Use PSSCR to determine if we
 	 * are waking up from deep idle state
@@ -436,19 +437,11 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)
 
 	/*
 	 * POWER ISA 2.07 or less.
-	 * Check if last bit of HSPGR0 is set. This indicates whether we are
-	 * waking up from winkle.
+	 * Check if we slept with winkle.
 	 */
-	clrldi	r5,r13,63
-	clrrdi	r13,r13,1
-
-	/* Now that we are sure r13 is corrected, load TOC */
-	ld	r2,PACATOC(r13);
-	cmpwi	cr4,r5,1
-	mtspr	SPRN_HSPRG0,r13
-
 	lbz	r0,PACA_THREAD_IDLE_STATE(r13)
 	cmpwi   cr2,r0,PNV_THREAD_NAP
+	cmpwi   cr4,r0,PNV_THREAD_WINKLE
 	bgt     cr2,pnv_wakeup_tb_loss	/* Either sleep or Winkle */
 
 	/*
diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
index 4ee837e6391a..f9fe0ff0f03a 100644
--- a/arch/powerpc/platforms/powernv/idle.c
+++ b/arch/powerpc/platforms/powernv/idle.c
@@ -53,19 +53,6 @@ static int pnv_save_sprs_for_deep_states(void)
 		uint64_t pir = get_hard_smp_processor_id(cpu);
 		uint64_t hsprg0_val = (uint64_t)&paca[cpu];
 
-		if (!cpu_has_feature(CPU_FTR_ARCH_300)) {
-			/*
-			 * HSPRG0 is used to store the cpu's pointer to paca.
-			 * Hence last 3 bits are guaranteed to be 0. Program
-			 * slw to restore HSPRG0 with 63rd bit set, so that
-			 * when a thread wakes up at 0x100 we can use this bit
-			 * to distinguish between fastsleep and deep winkle.
-			 * This is not necessary with stop/psscr since PLS
-			 * field of psscr indicates which state we are waking
-			 * up from.
-			 */
-			hsprg0_val |= 1;
-		}
 		rc = opal_slw_set_reg(pir, SPRN_HSPRG0, hsprg0_val);
 		if (rc != 0)
 			return rc;
-- 
2.11.0
