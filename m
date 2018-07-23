Return-Path: <huntbag@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Yt405bRjzDqRM
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jul 2018 17:12:48 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w6N79V27012833
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jul 2018 03:12:45 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2kd9md1yq8-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jul 2018 03:12:45 -0400
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <huntbag@linux.vnet.ibm.com>;
 Mon, 23 Jul 2018 08:12:43 +0100
From: Abhishek Goel <huntbag@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: benh@kernel.crashing.org, stewart@linux.vnet.ibm.com, mikey@neuling.org,
 mpe@ellerman.id.au, npiggin@gmail.com, paulus@samba.org,
 ego@linux.vnet.ibm.com, akshay.adiga@linux.vnet.ibm.com,
 Abhishek Goel <huntbag@linux.vnet.ibm.com>
Subject: [RFC 1/1] cpuidle : Move saving and restoring of sprs to opal
Date: Mon, 23 Jul 2018 02:12:36 -0500
Message-Id: <20180723071236.15543-1-huntbag@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch moves the saving and restoring of sprs for P9 cpuidle
from kernel to opal. This patch still uses existing code to detect
first thread in core.
In an attempt to make the powernv idle code backward compatible,
and to some extent forward compatible, add support for pre-stop entry
and post-stop exit actions in OPAL. If a kernel knows about this
opal call, then just a firmware supporting newer hardware is required,
instead of waiting for kernel updates.

Signed-off-by: Abhishek Goel <huntbag@linux.vnet.ibm.com>
---

Link to the Skiboot patch corresponding to this patch:
http://patchwork.ozlabs.org/patch/947568/

 arch/powerpc/include/asm/cpuidle.h            |  10 --
 arch/powerpc/include/asm/opal-api.h           |   4 +-
 arch/powerpc/include/asm/opal.h               |   3 +
 arch/powerpc/include/asm/paca.h               |   5 +-
 arch/powerpc/kernel/asm-offsets.c             |  10 +-
 arch/powerpc/kernel/idle_book3s.S             | 130 ++++++------------
 arch/powerpc/platforms/powernv/idle.c         |   4 +
 .../powerpc/platforms/powernv/opal-wrappers.S |   2 +
 arch/powerpc/xmon/xmon.c                      |  12 +-
 9 files changed, 61 insertions(+), 119 deletions(-)

diff --git a/arch/powerpc/include/asm/cpuidle.h b/arch/powerpc/include/asm/cpuidle.h
index e210a83eb196..c10f47af9a55 100644
--- a/arch/powerpc/include/asm/cpuidle.h
+++ b/arch/powerpc/include/asm/cpuidle.h
@@ -68,16 +68,6 @@
 #define ERR_DEEP_STATE_ESL_MISMATCH	-2
 
 #ifndef __ASSEMBLY__
-/* Additional SPRs that need to be saved/restored during stop */
-struct stop_sprs {
-	u64 pid;
-	u64 ldbar;
-	u64 fscr;
-	u64 hfscr;
-	u64 mmcr1;
-	u64 mmcr2;
-	u64 mmcra;
-};
 
 extern u32 pnv_fastsleep_workaround_at_entry[];
 extern u32 pnv_fastsleep_workaround_at_exit[];
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
index 6d34bd71139d..765524e76beb 100644
--- a/arch/powerpc/include/asm/paca.h
+++ b/arch/powerpc/include/asm/paca.h
@@ -195,11 +195,12 @@ struct paca_struct {
 	/* The PSSCR value that the kernel requested before going to stop */
 	u64 requested_psscr;
 
+	u64 wakeup_psscr;
 	/*
-	 * Save area for additional SPRs that need to be
+	 * Save area for SPRs that need to be
 	 * saved/restored during cpuidle stop.
 	 */
-	struct stop_sprs stop_sprs;
+	u64 *opal_stop_sprs;
 #endif
 
 #ifdef CONFIG_PPC_BOOK3S_64
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 0a0544335950..65a3d8582017 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -769,14 +769,8 @@ int main(void)
 	OFFSET(PACA_SIBLING_PACA_PTRS, paca_struct, thread_sibling_pacas);
 	OFFSET(PACA_REQ_PSSCR, paca_struct, requested_psscr);
 	OFFSET(PACA_DONT_STOP, paca_struct, dont_stop);
-#define STOP_SPR(x, f)	OFFSET(x, paca_struct, stop_sprs.f)
-	STOP_SPR(STOP_PID, pid);
-	STOP_SPR(STOP_LDBAR, ldbar);
-	STOP_SPR(STOP_FSCR, fscr);
-	STOP_SPR(STOP_HFSCR, hfscr);
-	STOP_SPR(STOP_MMCR1, mmcr1);
-	STOP_SPR(STOP_MMCR2, mmcr2);
-	STOP_SPR(STOP_MMCRA, mmcra);
+	OFFSET(PACA_WAKEUP_PSSCR, paca_struct, wakeup_psscr);
+	OFFSET(STOP_SPRS, paca_struct, opal_stop_sprs);
 #endif
 
 	DEFINE(PPC_DBELL_SERVER, PPC_DBELL_SERVER);
diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
index e734f6e45abc..66fc955abee3 100644
--- a/arch/powerpc/kernel/idle_book3s.S
+++ b/arch/powerpc/kernel/idle_book3s.S
@@ -45,6 +45,9 @@
 
 #define PSSCR_EC_ESL_MASK_SHIFTED          (PSSCR_EC | PSSCR_ESL) >> 16
 
+#define SCOPE_CORE	0
+#define SCOPE_THREAD	1
+
 	.text
 
 /*
@@ -56,19 +59,8 @@ save_sprs_to_stack:
 	 * Note all register i.e per-core, per-subcore or per-thread is saved
 	 * here since any thread in the core might wake up first
 	 */
-BEGIN_FTR_SECTION
-	/*
-	 * Note - SDR1 is dropped in Power ISA v3. Hence not restoring
-	 * SDR1 here
-	 */
-	mfspr	r3,SPRN_PTCR
-	std	r3,_PTCR(r1)
-	mfspr	r3,SPRN_LPCR
-	std	r3,_LPCR(r1)
-FTR_SECTION_ELSE
 	mfspr	r3,SPRN_SDR1
 	std	r3,_SDR1(r1)
-ALT_FTR_SECTION_END_IFSET(CPU_FTR_ARCH_300)
 	mfspr	r3,SPRN_RPR
 	std	r3,_RPR(r1)
 	mfspr	r3,SPRN_SPURR
@@ -85,66 +77,6 @@ ALT_FTR_SECTION_END_IFSET(CPU_FTR_ARCH_300)
 	std	r3,_WORT(r1)
 	mfspr	r3,SPRN_WORC
 	std	r3,_WORC(r1)
-/*
- * On POWER9, there are idle states such as stop4, invoked via cpuidle,
- * that lose hypervisor resources. In such cases, we need to save
- * additional SPRs before entering those idle states so that they can
- * be restored to their older values on wakeup from the idle state.
- *
- * On POWER8, the only such deep idle state is winkle which is used
- * only in the context of CPU-Hotplug, where these additional SPRs are
- * reinitiazed to a sane value. Hence there is no need to save/restore
- * these SPRs.
- */
-BEGIN_FTR_SECTION
-	blr
-END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_300)
-
-power9_save_additional_sprs:
-	mfspr	r3, SPRN_PID
-	mfspr	r4, SPRN_LDBAR
-	std	r3, STOP_PID(r13)
-	std	r4, STOP_LDBAR(r13)
-
-	mfspr	r3, SPRN_FSCR
-	mfspr	r4, SPRN_HFSCR
-	std	r3, STOP_FSCR(r13)
-	std	r4, STOP_HFSCR(r13)
-
-	mfspr	r3, SPRN_MMCRA
-	mfspr	r4, SPRN_MMCR0
-	std	r3, STOP_MMCRA(r13)
-	std	r4, _MMCR0(r1)
-
-	mfspr	r3, SPRN_MMCR1
-	mfspr	r4, SPRN_MMCR2
-	std	r3, STOP_MMCR1(r13)
-	std	r4, STOP_MMCR2(r13)
-	blr
-
-power9_restore_additional_sprs:
-	ld	r3,_LPCR(r1)
-	ld	r4, STOP_PID(r13)
-	mtspr	SPRN_LPCR,r3
-	mtspr	SPRN_PID, r4
-
-	ld	r3, STOP_LDBAR(r13)
-	ld	r4, STOP_FSCR(r13)
-	mtspr	SPRN_LDBAR, r3
-	mtspr	SPRN_FSCR, r4
-
-	ld	r3, STOP_HFSCR(r13)
-	ld	r4, STOP_MMCRA(r13)
-	mtspr	SPRN_HFSCR, r3
-	mtspr	SPRN_MMCRA, r4
-
-	ld	r3, _MMCR0(r1)
-	ld	r4, STOP_MMCR1(r13)
-	mtspr	SPRN_MMCR0, r3
-	mtspr	SPRN_MMCR1, r4
-
-	ld	r3, STOP_MMCR2(r13)
-	mtspr	SPRN_MMCR2, r3
 	blr
 
 /*
@@ -388,7 +320,14 @@ lwarx_loop_stop:
 	bne-    lwarx_loop_stop
 	isync
 
-	bl	save_sprs_to_stack
+BEGIN_FTR_SECTION
+	ld      r3,STOP_SPRS(r13)
+	li	r4,SCOPE_CORE
+	ld	r5,PACA_REQ_PSSCR(r13)
+	bl      opal_cpuidle_save
+FTR_SECTION_ELSE
+	bl      save_sprs_to_stack
+ALT_FTR_SECTION_END_IFSET(CPU_FTR_ARCH_300)
 
 	PPC_STOP	/* Does not return (system reset interrupt) */
 
@@ -566,6 +505,8 @@ ALT_FTR_SECTION_END_IFSET(CPU_FTR_ARCH_300)
 #endif
 
 	/* Return SRR1 from power7_nap() */
+	rlwinm  r11,r12,47-31,30,31
+	cmpwi   cr3,r11,2
 	blt	cr3,pnv_wakeup_noloss
 	b	pnv_wakeup_loss
 
@@ -576,6 +517,8 @@ ALT_FTR_SECTION_END_IFSET(CPU_FTR_ARCH_300)
  * cr3 - set to gt if waking up with partial/complete hypervisor state loss
  */
 pnv_restore_hyp_resource_arch300:
+	mfspr   r5, SPRN_PSSCR
+	std     r5, PACA_WAKEUP_PSSCR(r13)
 	/*
 	 * Workaround for POWER9, if we lost resources, the ERAT
 	 * might have been mixed up and needs flushing. We also need
@@ -832,6 +775,19 @@ subcore_state_restored:
 
 first_thread_in_core:
 
+BEGIN_FTR_SECTION
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
+END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)
+
 	/*
 	 * First thread in the core waking up from any state which can cause
 	 * partial or complete hypervisor state loss. It needs to
@@ -865,14 +821,6 @@ timebase_resync:
 	 * complete hypervisor state loss. Restore per core hypervisor
 	 * state.
 	 */
-BEGIN_FTR_SECTION
-	ld	r4,_PTCR(r1)
-	mtspr	SPRN_PTCR,r4
-	ld	r4,_RPR(r1)
-	mtspr	SPRN_RPR,r4
-	ld	r4,_AMOR(r1)
-	mtspr	SPRN_AMOR,r4
-END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)
 
 	ld	r4,_TSCR(r1)
 	mtspr	SPRN_TSCR,r4
@@ -885,6 +833,17 @@ clear_lock:
 	stw	r15,0(r14)
 
 common_exit:
+
+BEGIN_FTR_SECTION
+	ld      r3,STOP_SPRS(r13)
+	li      r4,SCOPE_THREAD
+	ld	r5,PACA_WAKEUP_PSSCR(r13)
+	mr   	r6,r19	/*r19 contains SRR1*/
+	bl      opal_cpuidle_restore
+	ld      r1,PACAR1(r13)
+	b	hypervisor_state_restored
+END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)
+
 	/*
 	 * Common to all threads.
 	 *
@@ -934,17 +893,6 @@ no_segments:
 	mtctr	r12
 	bctrl
 
-/*
- * On POWER9, we can come here on wakeup from a cpuidle stop state.
- * Hence restore the additional SPRs to the saved value.
- *
- * On POWER8, we come here only on winkle. Since winkle is used
- * only in the case of CPU-Hotplug, we don't need to restore
- * the additional SPRs.
- */
-BEGIN_FTR_SECTION
-	bl 	power9_restore_additional_sprs
-END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)
 hypervisor_state_restored:
 
 	mr	r12,r19
diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
index 1c5d0675b43c..8a8b87740df9 100644
--- a/arch/powerpc/platforms/powernv/idle.c
+++ b/arch/powerpc/platforms/powernv/idle.c
@@ -135,6 +135,7 @@ static int pnv_save_sprs_for_deep_states(void)
 	return 0;
 }
 
+#define MAX_STOP_SPRS_COUNT 25
 static void pnv_alloc_idle_core_states(void)
 {
 	int i, j;
@@ -174,6 +175,9 @@ static void pnv_alloc_idle_core_states(void)
 		for (j = 0; j < threads_per_core; j++) {
 			int cpu = first_cpu + j;
 
+			paca_ptrs[cpu]->opal_stop_sprs = kmalloc_node(
+					MAX_STOP_SPRS_COUNT * sizeof(u64),
+					GFP_KERNEL, node);
 			paca_ptrs[cpu]->core_idle_state_ptr = core_idle_state;
 			paca_ptrs[cpu]->thread_idle_state = PNV_THREAD_RUNNING;
 			paca_ptrs[cpu]->thread_mask = 1 << j;
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
index 47166ad2a669..5ad762a481f8 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -2431,14 +2431,12 @@ static void dump_one_paca(int cpu)
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
+	/* TODO paca still has sprs stored, but only opal knows the index for
+	 * each spr. We can find a way to make the indices available to kernel.
+	 */
+
 #endif
 
 	DUMP(p, accounting.utime, "%#-*lx");
-- 
2.17.0
