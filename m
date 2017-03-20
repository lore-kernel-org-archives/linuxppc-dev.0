Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vn0rQ6fDRzDqYB
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Mar 2017 02:54:46 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2KFs46I014690
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Mar 2017 11:54:43 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0b-001b2d01.pphosted.com with ESMTP id 29af6eb11p-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Mar 2017 11:54:42 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Mon, 20 Mar 2017 09:54:41 -0600
From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling <mikey@neuling.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 "Shreyas B. Prabhu" <shreyasbp@gmail.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Anton Blanchard <anton@samba.org>, Balbir Singh <bsingharora@gmail.com>,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: [v2 PATCH 4/4] powernv: Recover correct PACA on wakeup from a stop on
 P9 DD1
Date: Mon, 20 Mar 2017 21:24:18 +0530
In-Reply-To: <cover.1490024477.git.ego@linux.vnet.ibm.com>
References: <cover.1490024477.git.ego@linux.vnet.ibm.com>
In-Reply-To: <cover.1490024477.git.ego@linux.vnet.ibm.com>
References: <cover.1490024477.git.ego@linux.vnet.ibm.com>
Message-Id: <5beb1c3fb26ef0b487be3aa0488ea31aabfcb311.1490024477.git.ego@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>

POWER9 DD1.0 hardware has an issue due to which the SPRs of a thread
waking up from stop 0,1,2 with ESL=1 can endup being misplaced in the
core. Thus the HSPRG0 of a thread waking up from can contain the paca
pointer of its sibling.

This patch implements a context recovery framework within threads of a
core, by provisioning space in paca_struct for saving every sibling
threads's paca pointers. Basically, we should be able to arrive at the
right paca pointer from any of the thread's existing paca pointer.

At bootup, during powernv idle-init, we save the paca address of every
CPU in each one its siblings paca_struct in the slot corresponding to
this CPU's index in the core.

On wakeup from a stop, the thread will determine its index in the core
from the lower 2 bits of the PIR register and recover its PACA pointer
by indexing into the correct slot in the provisioned space in the
current PACA.

Furthermore, ensure that the NVGPRs are restored from the stack on the
way out by setting the NAPSTATELOST in paca.

[Changelog written with inputs from svaidy@linux.vnet.ibm.com]

Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/paca.h       |  5 ++++
 arch/powerpc/kernel/asm-offsets.c     |  1 +
 arch/powerpc/kernel/idle_book3s.S     | 49 ++++++++++++++++++++++++++++++++++-
 arch/powerpc/platforms/powernv/idle.c | 22 ++++++++++++++++
 4 files changed, 76 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
index 708c3e5..4405630 100644
--- a/arch/powerpc/include/asm/paca.h
+++ b/arch/powerpc/include/asm/paca.h
@@ -172,6 +172,11 @@ struct paca_struct {
 	u8 thread_mask;
 	/* Mask to denote subcore sibling threads */
 	u8 subcore_sibling_mask;
+	/*
+	 * Pointer to an array which contains pointer
+	 * to the sibling threads' paca.
+	 */
+	struct paca_struct *thread_sibling_pacas[8];
 #endif
 
 #ifdef CONFIG_PPC_BOOK3S_64
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 4367e7d..6ec5016 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -727,6 +727,7 @@ int main(void)
 	OFFSET(PACA_THREAD_IDLE_STATE, paca_struct, thread_idle_state);
 	OFFSET(PACA_THREAD_MASK, paca_struct, thread_mask);
 	OFFSET(PACA_SUBCORE_SIBLING_MASK, paca_struct, subcore_sibling_mask);
+	OFFSET(PACA_SIBLING_PACA_PTRS, paca_struct, thread_sibling_pacas);
 #endif
 
 	DEFINE(PPC_DBELL_SERVER, PPC_DBELL_SERVER);
diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
index 9957287..c2f2cfb 100644
--- a/arch/powerpc/kernel/idle_book3s.S
+++ b/arch/powerpc/kernel/idle_book3s.S
@@ -375,6 +375,46 @@ _GLOBAL(power9_idle_stop)
 	li	r4,1
 	b	pnv_powersave_common
 	/* No return */
+
+
+/*
+ * On waking up from stop 0,1,2 with ESL=1 on POWER9 DD1,
+ * HSPRG0 will be set to the HSPRG0 value of one of the
+ * threads in this core. Thus the value we have in r13
+ * may not be this thread's paca pointer.
+ *
+ * Fortunately, the PIR remains invariant. Since this thread's
+ * paca pointer is recorded in all its sibling's paca, we can
+ * correctly recover this thread's paca pointer if we
+ * know the index of this thread in the core.
+ *
+ * This index can be obtained from the lower two bits of the PIR.
+ *
+ * i.e, thread's position in the core = PIR[62:63].
+ * If this value is i, then this thread's paca is
+ * paca->thread_sibling_pacas[i].
+ */
+power9_dd1_recover_paca:
+	mfspr	r4, SPRN_PIR
+	clrldi	r4, r4, 62
+	/*
+	 * Since each entry in thread_sibling_pacas is 8 bytes
+	 * we need to left-shift by 3 bits. Thus r4 = i * 8
+	 */
+	sldi	r4, r4, 3
+	/* Get &paca->thread_sibling_pacas[0] in r5 */
+	addi	r5, r13, PACA_SIBLING_PACA_PTRS
+	/* Load paca->thread_sibling_pacas[i] into r13 */
+	ldx	r13, r4, r5
+	SET_PACA(r13)
+	/*
+	 * Indicate that we have lost NVGPR state
+	 * which needs to be restored from the stack.
+	 */
+	li	r3, 1
+	stb	r0,PACA_NAPSTATELOST(r13)
+	blr
+
 /*
  * Called from reset vector. Check whether we have woken up with
  * hypervisor state loss. If yes, restore hypervisor state and return
@@ -385,7 +425,14 @@ _GLOBAL(power9_idle_stop)
  */
 _GLOBAL(pnv_restore_hyp_resource)
 BEGIN_FTR_SECTION
-	ld	r2,PACATOC(r13);
+BEGIN_FTR_SECTION_NESTED(70)
+	mflr 	r6
+	bl	power9_dd1_recover_paca
+	mtlr	r6
+	ld	r2, PACATOC(r13)
+FTR_SECTION_ELSE_NESTED(70)
+	ld	r2, PACATOC(r13)
+ALT_FTR_SECTION_END_NESTED_IFSET(CPU_FTR_POWER9_DD1, 70)
 	/*
 	 * POWER ISA 3. Use PSSCR to determine if we
 	 * are waking up from deep idle state
diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
index 63ade78..5790d4c 100644
--- a/arch/powerpc/platforms/powernv/idle.c
+++ b/arch/powerpc/platforms/powernv/idle.c
@@ -560,6 +560,28 @@ static int __init pnv_init_idle_states(void)
 
 	pnv_alloc_idle_core_states();
 
+	/*
+	 * For each CPU, record its PACA address in each of it's
+	 * sibling thread's PACA at the slot corresponding to this
+	 * CPU's index in the core.
+	 */
+	if (cpu_has_feature(CPU_FTR_POWER9_DD1)) {
+		int cpu;
+
+		pr_info("powernv: idle: Saving PACA pointers of all CPUs in their thread sibling PACA\n");
+		for_each_possible_cpu(cpu) {
+			int base_cpu = cpu_first_thread_sibling(cpu);
+			int idx = cpu_thread_in_core(cpu);
+			int i;
+
+			for (i = 0; i < threads_per_core; i++) {
+				int j = base_cpu + i;
+
+				paca[j].thread_sibling_pacas[idx] = &paca[cpu];
+			}
+		}
+	}
+
 	if (supported_cpuidle_states & OPAL_PM_NAP_ENABLED)
 		ppc_md.power_save = power7_idle;
 
-- 
1.9.4
