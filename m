Return-Path: <akshay.adiga@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41gyTv33ZmzF1pr
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Aug 2018 14:52:51 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w724kVeR139921
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Aug 2018 00:52:48 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2kktshs0d0-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Aug 2018 00:52:48 -0400
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <akshay.adiga@linux.vnet.ibm.com>;
 Thu, 2 Aug 2018 05:52:46 +0100
From: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: npiggin@gmail.com, mpe@ellerman.id.au, benh@kernel.crashing.org,
 ego@linux.vnet.ibm.com, huntbag@linux.vnet.ibm.com,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Subject: [RFC PATCH 3/3] cpuidle/powernv: Conditionally save-restore sprs
 using opal
Date: Thu,  2 Aug 2018 10:21:32 +0530
In-Reply-To: <20180802045132.12432-1-akshay.adiga@linux.vnet.ibm.com>
References: <20180802045132.12432-1-akshay.adiga@linux.vnet.ibm.com>
Message-Id: <20180802045132.12432-4-akshay.adiga@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Abhishek Goel <huntbag@linux.vnet.ibm.com>

If a state has "opal-supported" compat flag in device-tree, an opal call
needs to be made during the entry and exit of the stop state. This patch
passes a hint to the power9_idle_stop and power9_offline_stop.

This patch moves the saving and restoring of sprs for P9 cpuidle
from kernel to opal. This patch still uses existing code to detect
first thread in core.
In an attempt to make the powernv idle code backward compatible,
and to some extent forward compatible, add support for pre-stop entry
and post-stop exit actions in OPAL. If a kernel knows about this
opal call, then just a firmware supporting newer hardware is required,
instead of waiting for kernel updates.

Signed-off-by: Abhishek Goel <huntbag@linux.vnet.ibm.com>
Signed-off-by: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/cpuidle.h            |  1 +
 arch/powerpc/include/asm/opal-api.h           |  4 +-
 arch/powerpc/include/asm/opal.h               |  3 +
 arch/powerpc/include/asm/paca.h               |  5 +-
 arch/powerpc/include/asm/processor.h          |  6 +-
 arch/powerpc/kernel/asm-offsets.c             |  3 +
 arch/powerpc/kernel/idle_book3s.S             | 55 ++++++++++++++++++-
 arch/powerpc/platforms/powernv/idle.c         | 41 ++++++++++----
 .../powerpc/platforms/powernv/opal-wrappers.S |  2 +
 arch/powerpc/xmon/xmon.c                      | 14 ++---
 10 files changed, 109 insertions(+), 25 deletions(-)

diff --git a/arch/powerpc/include/asm/cpuidle.h b/arch/powerpc/include/asm/cpuidle.h
index b965066560cc..2fb2324d15fc 100644
--- a/arch/powerpc/include/asm/cpuidle.h
+++ b/arch/powerpc/include/asm/cpuidle.h
@@ -96,6 +96,7 @@ struct pnv_idle_states_t {
 	u64 psscr_val;
 	u64 psscr_mask;
 	u32 flags;
+	bool req_opal_call;
 	enum idle_state_type_t type;
 	bool valid;
 };
diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
index 3bab299eda49..6792a737bc9a 100644
--- a/arch/powerpc/include/asm/opal-api.h
+++ b/arch/powerpc/include/asm/opal-api.h
@@ -208,7 +208,9 @@
 #define OPAL_SENSOR_READ_U64			162
 #define OPAL_PCI_GET_PBCQ_TUNNEL_BAR		164
 #define OPAL_PCI_SET_PBCQ_TUNNEL_BAR		165
-#define OPAL_LAST				165
+#define OPAL_IDLE_SAVE				168
+#define OPAL_IDLE_RESTORE			169
+#define OPAL_LAST				169
 
 #define QUIESCE_HOLD			1 /* Spin all calls at entry */
 #define QUIESCE_REJECT			2 /* Fail all calls with OPAL_BUSY */
diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index e1b2910c6e81..12d57aeacde2 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -356,6 +356,9 @@ extern void opal_kmsg_init(void);
 
 extern int opal_event_request(unsigned int opal_event_nr);
 
+extern int opal_cpuidle_save(u64 *stop_sprs, int scope, u64 psscr);
+extern int opal_cpuidle_restore(u64 *stop_sprs, int scope, u64 psscr, u64 srr1);
+
 struct opal_sg_list *opal_vmalloc_to_sg_list(void *vmalloc_addr,
 					     unsigned long vmalloc_size);
 void opal_free_sg_list(struct opal_sg_list *sg);
diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
index 6d34bd71139d..586059594443 100644
--- a/arch/powerpc/include/asm/paca.h
+++ b/arch/powerpc/include/asm/paca.h
@@ -195,11 +195,14 @@ struct paca_struct {
 	/* The PSSCR value that the kernel requested before going to stop */
 	u64 requested_psscr;
 
+	u64 wakeup_psscr;
+	u8 req_opal_call;
 	/*
-	 * Save area for additional SPRs that need to be
+	 * Save area for SPRs that need to be
 	 * saved/restored during cpuidle stop.
 	 */
 	struct stop_sprs stop_sprs;
+	u64 *opal_stop_sprs;
 #endif
 
 #ifdef CONFIG_PPC_BOOK3S_64
diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index 34f572056add..9f9fb1f11dd6 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -513,8 +513,10 @@ enum idle_boot_override {IDLE_NO_OVERRIDE = 0, IDLE_POWERSAVE_OFF};
 extern int powersave_nap;	/* set if nap mode can be used in idle loop */
 extern unsigned long power7_idle_insn(unsigned long type); /* PNV_THREAD_NAP/etc*/
 extern void power7_idle_type(unsigned long type);
-extern unsigned long power9_idle_stop(unsigned long psscr_val);
-extern unsigned long power9_offline_stop(unsigned long psscr_val);
+extern unsigned long power9_idle_stop(unsigned long psscr_val,
+				      bool opal_enabled);
+extern unsigned long power9_offline_stop(unsigned long psscr_val,
+					 bool opal_enabled);
 extern void power9_idle_type(int index);
 
 extern void flush_instruction_cache(void);
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 262c44a90ea1..740ae068ec74 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -768,6 +768,9 @@ int main(void)
 	OFFSET(PACA_SIBLING_PACA_PTRS, paca_struct, thread_sibling_pacas);
 	OFFSET(PACA_REQ_PSSCR, paca_struct, requested_psscr);
 	OFFSET(PACA_DONT_STOP, paca_struct, dont_stop);
+	OFFSET(PACA_WAKEUP_PSSCR, paca_struct, wakeup_psscr);
+	OFFSET(PACA_REQ_OPAL_CALL, paca_struct, req_opal_call);
+	OFFSET(STOP_SPRS, paca_struct, opal_stop_sprs);
 #define STOP_SPR(x, f)	OFFSET(x, paca_struct, stop_sprs.f)
 	STOP_SPR(STOP_PID, pid);
 	STOP_SPR(STOP_LDBAR, ldbar);
diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
index e734f6e45abc..b5f5245011a5 100644
--- a/arch/powerpc/kernel/idle_book3s.S
+++ b/arch/powerpc/kernel/idle_book3s.S
@@ -45,6 +45,9 @@
 
 #define PSSCR_EC_ESL_MASK_SHIFTED          (PSSCR_EC | PSSCR_ESL) >> 16
 
+#define SCOPE_CORE	0
+#define SCOPE_THREAD	1
+
 	.text
 
 /*
@@ -388,7 +391,18 @@ lwarx_loop_stop:
 	bne-    lwarx_loop_stop
 	isync
 
+	ld	r6,PACA_REQ_OPAL_CALL(r13)
+	cmpwi	r6,1
+	beq	opal_save
 	bl	save_sprs_to_stack
+	PPC_STOP
+	b 	.
+
+opal_save:
+	ld      r3,STOP_SPRS(r13)
+	li	r4,SCOPE_CORE
+	ld	r5,PACA_REQ_PSSCR(r13)
+	bl      opal_cpuidle_save
 
 	PPC_STOP	/* Does not return (system reset interrupt) */
 
@@ -435,13 +449,14 @@ _GLOBAL(power9_offline_stop)
 	 * between threads, but in that case KVM has a barrier sync in real
 	 * mode before and after switching between radix and hash.
 	 */
-	li	r4,KVM_HWTHREAD_IN_IDLE
-	stb	r4,HSTATE_HWTHREAD_STATE(r13)
+	li	r5,KVM_HWTHREAD_IN_IDLE
+	stb	r5,HSTATE_HWTHREAD_STATE(r13)
 #endif
 	/* fall through */
 
 _GLOBAL(power9_idle_stop)
 	std	r3, PACA_REQ_PSSCR(r13)
+	std	r4, PACA_REQ_OPAL_CALL(r13)
 #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
 BEGIN_FTR_SECTION
 	sync
@@ -566,6 +581,8 @@ ALT_FTR_SECTION_END_IFSET(CPU_FTR_ARCH_300)
 #endif
 
 	/* Return SRR1 from power7_nap() */
+	rlwinm  r11,r12,47-31,30,31
+	cmpwi   cr3,r11,2
 	blt	cr3,pnv_wakeup_noloss
 	b	pnv_wakeup_loss
 
@@ -576,6 +593,8 @@ ALT_FTR_SECTION_END_IFSET(CPU_FTR_ARCH_300)
  * cr3 - set to gt if waking up with partial/complete hypervisor state loss
  */
 pnv_restore_hyp_resource_arch300:
+	mfspr   r5, SPRN_PSSCR
+	std     r5, PACA_WAKEUP_PSSCR(r13)
 	/*
 	 * Workaround for POWER9, if we lost resources, the ERAT
 	 * might have been mixed up and needs flushing. We also need
@@ -831,7 +850,24 @@ subcore_state_restored:
 	bne	cr2,clear_lock
 
 first_thread_in_core:
+	ld	r6,PACA_REQ_OPAL_CALL(r13)
+	cmpwi	r6,1
+	beq	opal_restore_core
+	b	kernel_restore_core
+
+opal_restore_core:
+	ld      r3,STOP_SPRS(r13)
+	li      r4,SCOPE_CORE
+	ld	r5,PACA_WAKEUP_PSSCR(r13)
+	mr	r6,r19	/*r19 contains SRR1*/
+	bl      opal_cpuidle_restore
+	ld      r1,PACAR1(r13)
+	xoris   r15,r15,PNV_CORE_IDLE_LOCK_BIT@h
+	lwsync
+	stw     r15,0(r14)
+	b	hypervisor_state_restored
 
+kernel_restore_core:
 	/*
 	 * First thread in the core waking up from any state which can cause
 	 * partial or complete hypervisor state loss. It needs to
@@ -885,6 +921,21 @@ clear_lock:
 	stw	r15,0(r14)
 
 common_exit:
+	ld	r6,PACA_REQ_OPAL_CALL(r13)
+	cmpwi	r6,1
+	beq	opal_restore_thread
+	b	kernel_restore_thread
+
+opal_restore_thread:
+	ld      r3,STOP_SPRS(r13)
+	li      r4,SCOPE_THREAD
+	ld	r5,PACA_WAKEUP_PSSCR(r13)
+	mr   	r6,r19	/*r19 contains SRR1*/
+	bl      opal_cpuidle_restore
+	ld      r1,PACAR1(r13)
+	b	hypervisor_state_restored
+
+kernel_restore_thread:
 	/*
 	 * Common to all threads.
 	 *
diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
index a6ef9b68e27b..e5d38524aec3 100644
--- a/arch/powerpc/platforms/powernv/idle.c
+++ b/arch/powerpc/platforms/powernv/idle.c
@@ -147,6 +147,7 @@ static int pnv_save_sprs_for_deep_states(void)
 	return 0;
 }
 
+#define MAX_STOP_SPRS_COUNT 25
 static void pnv_alloc_idle_core_states(void)
 {
 	int i, j;
@@ -186,6 +187,9 @@ static void pnv_alloc_idle_core_states(void)
 		for (j = 0; j < threads_per_core; j++) {
 			int cpu = first_cpu + j;
 
+			paca_ptrs[cpu]->opal_stop_sprs = kmalloc_node(
+					MAX_STOP_SPRS_COUNT * sizeof(u64),
+					GFP_KERNEL, node);
 			paca_ptrs[cpu]->core_idle_state_ptr = core_idle_state;
 			paca_ptrs[cpu]->thread_idle_state = PNV_THREAD_RUNNING;
 			paca_ptrs[cpu]->thread_mask = 1 << j;
@@ -372,7 +376,7 @@ static unsigned long __power9_idle_type(struct pnv_idle_states_t *state)
 	psscr = mfspr(SPRN_PSSCR);
 	psscr = (psscr & ~stop_psscr_mask) | stop_psscr_val;
 	__ppc64_runlatch_off();
-	srr1 = power9_idle_stop(psscr, state->opal_supported);
+	srr1 = power9_idle_stop(psscr, state->req_opal_call);
 	__ppc64_runlatch_on();
 
 	fini_irq_for_idle_irqsoff();
@@ -518,7 +522,7 @@ unsigned long pnv_cpu_offline(unsigned int cpu)
 
 		psscr = mfspr(SPRN_PSSCR);
 		psscr = (psscr & ~state->psscr_mask) |	state->psscr_val;
-		srr1 = power9_offline_stop(psscr, state->opal_supported);
+		srr1 = power9_offline_stop(psscr, state->req_opal_call);
 
 	} else if ((idle_states & OPAL_PM_WINKLE_ENABLED) &&
 		   (idle_states & OPAL_PM_LOSE_FULL_CONTEXT)) {
@@ -815,6 +819,7 @@ static int pnv_parse_cpuidle_dt(void)
 	u32 *temp_u32;
 	u64 *temp_u64;
 	const char **temp_string;
+	bool fall_back_to_opal = false;
 
 	np = of_find_node_by_path("/ibm,opal/power-mgt");
 	if (!np) {
@@ -929,21 +934,33 @@ static int pnv_parse_cpuidle_dt(void)
 	/* Parse each child node with appropriate parser_fn */
 	for_each_child_of_node(np1, dt_node) {
 		bool found_known_version = false;
-		/* we don't have state falling back to opal*/
-		for (i = 0; i < nr_known_versions ; i++) {
-			if (of_device_is_compatible(dt_node, known_versions[i].name)) {
-				rc = known_versions[i].parser_fn(dt_node);
-				if (rc) {
-					pr_err("%s could not parse\n",known_versions[i].name);
-					continue;
+		int idx = nr_pnv_idle_states;
+		if (!fall_back_to_opal) {
+			/* we don't have state falling back to opal*/
+			for (i = 0; i < nr_known_versions ; i++) {
+				if (of_device_is_compatible(dt_node, known_versions[i].name)) {
+					rc = known_versions[i].parser_fn(dt_node);
+					if (rc) {
+						pr_err("%s could not parse\n",known_versions[i].name);
+						continue;
+					}
+					found_known_version = true;
 				}
-				found_known_version = true;
 			}
 		}
-		
-		if (!found_known_version) {
+		if (!found_known_version || fall_back_to_opal) {
+			if (of_device_is_compatible(dt_node, "opal-support")) {
+				rc = known_versions[0].parser_fn(dt_node);
+				if (rc) {
+					pr_err("%s could not parse\n", "opal-support");
+					continue;
+				}
+				pnv_idle_states[idx].req_opal_call = true;
+				fall_back_to_opal = true;
+			} else {
 				pr_info("Unsupported state, skipping all further state\n");
 				goto out;
+			}
 		}
 		nr_pnv_idle_states++;
 	}
diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
index a8d9b4089c31..b75c37d93efd 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -327,3 +327,5 @@ OPAL_CALL(opal_npu_tl_set,			OPAL_NPU_TL_SET);
 OPAL_CALL(opal_pci_get_pbcq_tunnel_bar,		OPAL_PCI_GET_PBCQ_TUNNEL_BAR);
 OPAL_CALL(opal_pci_set_pbcq_tunnel_bar,		OPAL_PCI_SET_PBCQ_TUNNEL_BAR);
 OPAL_CALL(opal_sensor_read_u64,			OPAL_SENSOR_READ_U64);
+OPAL_CALL(opal_cpuidle_save,			OPAL_IDLE_SAVE);
+OPAL_CALL(opal_cpuidle_restore,			OPAL_IDLE_RESTORE);
diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 47166ad2a669..8ae34f37e60a 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -2431,14 +2431,14 @@ static void dump_one_paca(int cpu)
 	DUMP(p, subcore_sibling_mask, "%#-*x");
 	DUMP(p, thread_sibling_pacas, "%-*px");
 	DUMP(p, requested_psscr, "%#-*llx");
-	DUMP(p, stop_sprs.pid, "%#-*llx");
-	DUMP(p, stop_sprs.ldbar, "%#-*llx");
-	DUMP(p, stop_sprs.fscr, "%#-*llx");
-	DUMP(p, stop_sprs.hfscr, "%#-*llx");
-	DUMP(p, stop_sprs.mmcr1, "%#-*llx");
-	DUMP(p, stop_sprs.mmcr2, "%#-*llx");
-	DUMP(p, stop_sprs.mmcra, "%#-*llx");
 	DUMP(p, dont_stop.counter, "%#-*x");
+
+	/*
+	 * TODO Either kernel or opal has sprs stored. If opal stored it,
+	 * we can find a way to make the indices available to kernel through
+	 * paca.
+	 */
+
 #endif
 
 	DUMP(p, accounting.utime, "%#-*lx");
-- 
2.18.0.rc2.85.g1fb9df7
