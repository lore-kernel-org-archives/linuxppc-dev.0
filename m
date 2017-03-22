Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vpCdw0JphzDqY4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Mar 2017 02:04:51 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2MEx4PH096599
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Mar 2017 11:04:39 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0b-001b2d01.pphosted.com with ESMTP id 29b9vqtrp6-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Mar 2017 11:04:39 -0400
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Wed, 22 Mar 2017 09:04:38 -0600
From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling <mikey@neuling.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 "Shreyas B. Prabhu" <shreyasbp@gmail.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Anton Blanchard <anton@samba.org>, Balbir Singh <bsingharora@gmail.com>,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: [v3 PATCH 4/4] powernv: Recover correct PACA on wakeup from a stop on
 P9 DD1
Date: Wed, 22 Mar 2017 20:34:17 +0530
In-Reply-To: <cover.1490194710.git.ego@linux.vnet.ibm.com>
References: <cover.1490194710.git.ego@linux.vnet.ibm.com>
In-Reply-To: <cover.1490194710.git.ego@linux.vnet.ibm.com>
References: <cover.1490194710.git.ego@linux.vnet.ibm.com>
Message-Id: <2387240280c6445bd22ee9be621997b6f951ef3d.1490194710.git.ego@linux.vnet.ibm.com>
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
from the TIR register and recover its PACA pointer by indexing into
the correct slot in the provisioned space in the current PACA.

Furthermore, ensure that the NVGPRs are restored from the stack on the
way out by setting the NAPSTATELOST in paca.

[Changelog written with inputs from svaidy@linux.vnet.ibm.com]

Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/paca.h       |  5 ++++
 arch/powerpc/kernel/asm-offsets.c     |  1 +
 arch/powerpc/kernel/idle_book3s.S     | 48 ++++++++++++++++++++++++++++++++++-
 arch/powerpc/platforms/powernv/idle.c | 30 ++++++++++++++++++++++
 4 files changed, 83 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
index 708c3e5..2a17c15 100644
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
+	struct paca_struct **thread_sibling_pacas;
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
index 9957287..24717a7 100644
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
+ * Fortunately, the TIR remains invariant. Since this thread's
+ * paca pointer is recorded in all its sibling's paca, we can
+ * correctly recover this thread's paca pointer if we
+ * know the index of this thread in the core.
+ *
+ * This index can be obtained from the TIR.
+ *
+ * i.e, thread's position in the core = TIR.
+ * If this value is i, then this thread's paca is
+ * paca->thread_sibling_pacas[i].
+ */
+power9_dd1_recover_paca:
+	mfspr	r4, SPRN_TIR
+	/*
+	 * Since each entry in thread_sibling_pacas is 8 bytes
+	 * we need to left-shift by 3 bits. Thus r4 = i * 8
+	 */
+	sldi	r4, r4, 3
+	/* Get &paca->thread_sibling_pacas[0] in r5 */
+	ld	r5, PACA_SIBLING_PACA_PTRS(r13)
+	/* Load paca->thread_sibling_pacas[i] into r13 */
+	ldx	r13, r4, r5
+	SET_PACA(r13)
+	ld	r2, PACATOC(r13)
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
@@ -385,7 +425,13 @@ _GLOBAL(power9_idle_stop)
  */
 _GLOBAL(pnv_restore_hyp_resource)
 BEGIN_FTR_SECTION
-	ld	r2,PACATOC(r13);
+BEGIN_FTR_SECTION_NESTED(70)
+	mflr 	r6
+	bl	power9_dd1_recover_paca
+	mtlr	r6
+FTR_SECTION_ELSE_NESTED(70)
+	ld	r2, PACATOC(r13)
+ALT_FTR_SECTION_END_NESTED_IFSET(CPU_FTR_POWER9_DD1, 70)
 	/*
 	 * POWER ISA 3. Use PSSCR to determine if we
 	 * are waking up from deep idle state
diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
index 63ade78..b369e39 100644
--- a/arch/powerpc/platforms/powernv/idle.c
+++ b/arch/powerpc/platforms/powernv/idle.c
@@ -122,9 +122,12 @@ static void pnv_alloc_idle_core_states(void)
 	for (i = 0; i < nr_cores; i++) {
 		int first_cpu = i * threads_per_core;
 		int node = cpu_to_node(first_cpu);
+		size_t paca_ptr_array_size;
 
 		core_idle_state = kmalloc_node(sizeof(u32), GFP_KERNEL, node);
 		*core_idle_state = PNV_CORE_IDLE_THREAD_BITS;
+		paca_ptr_array_size = (threads_per_core *
+				       sizeof(struct paca_struct *));
 
 		for (j = 0; j < threads_per_core; j++) {
 			int cpu = first_cpu + j;
@@ -132,6 +135,11 @@ static void pnv_alloc_idle_core_states(void)
 			paca[cpu].core_idle_state_ptr = core_idle_state;
 			paca[cpu].thread_idle_state = PNV_THREAD_RUNNING;
 			paca[cpu].thread_mask = 1 << j;
+			if (!cpu_has_feature(CPU_FTR_POWER9_DD1))
+				continue;
+			paca[cpu].thread_sibling_pacas =
+				kmalloc_node(paca_ptr_array_size,
+					     GFP_KERNEL, node);
 		}
 	}
 
@@ -560,6 +568,28 @@ static int __init pnv_init_idle_states(void)
 
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
