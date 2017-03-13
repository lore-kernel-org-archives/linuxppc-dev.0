Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vhS1r6BqpzDqYb
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Mar 2017 17:02:08 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2D5x1Pp059204
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Mar 2017 02:01:54 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
 by mx0b-001b2d01.pphosted.com with ESMTP id 294ea29j54-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Mar 2017 02:01:54 -0400
Received: from localhost
 by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Mon, 13 Mar 2017 02:01:53 -0400
From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling <mikey@neuling.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 "Shreyas B. Prabhu" <shreyasbp@gmail.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Anton Blanchard <anton@samba.org>, Balbir Singh <bsingharora@gmail.com>,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: [PATCH 3/3] powernv:Recover correct PACA on wakeup from a stop on P9
 DD1
Date: Mon, 13 Mar 2017 11:31:28 +0530
In-Reply-To: <cover.1489383815.git.ego@linux.vnet.ibm.com>
References: <cover.1489383815.git.ego@linux.vnet.ibm.com>
In-Reply-To: <cover.1489383815.git.ego@linux.vnet.ibm.com>
References: <cover.1489383815.git.ego@linux.vnet.ibm.com>
Message-Id: <6a5d7270f893e4d8df1bd0c0c16c4aa6d10d23fa.1489383815.git.ego@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>

POWER9 platform can be configured to rebalance per-thread resources
within a core in order to improve SMT performance.  Certain STOP
states can be configure to relinquish resources include some
hypervisor SPRs in order to enable SMT thread folding.

Due to relinquishing of per-thread resources under certain platform
configuration, certain SPR context could be lost within a core that
needs to be recovered.  This state lose is due to reconfiguration of
SMT threads and not due to actual electrical power lose.

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

[Changelog written with inputs from svaidy@linux.vnet.ibm.com]

Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/paca.h       |  5 ++++
 arch/powerpc/kernel/asm-offsets.c     |  1 +
 arch/powerpc/kernel/idle_book3s.S     | 43 ++++++++++++++++++++++++++++++++++-
 arch/powerpc/platforms/powernv/idle.c | 22 ++++++++++++++++++
 4 files changed, 70 insertions(+), 1 deletion(-)

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
index 9957287..5a90f2c 100644
--- a/arch/powerpc/kernel/idle_book3s.S
+++ b/arch/powerpc/kernel/idle_book3s.S
@@ -385,7 +385,48 @@ _GLOBAL(power9_idle_stop)
  */
 _GLOBAL(pnv_restore_hyp_resource)
 BEGIN_FTR_SECTION
-	ld	r2,PACATOC(r13);
+BEGIN_FTR_SECTION_NESTED(70)
+/* Save our LR in r17 */
+	mflr 	r17
+/*
+ * On entering certain stop states, the thread might relinquish its
+ * per-thread resources due to some reconfiguration for improved SMT
+ * performance. This would result in certain SPR context such as
+ * HSPRG0 (which contains the paca pointer) to be lost within the core.
+ *
+ * Fortunately, the PIR is invariant to thread reconfiguration. Since
+ * this thread's paca pointer is recorded in all its sibling's
+ * paca, we can correctly recover this thread's paca pointer if we
+ * know the index of this thread in the core.
+ * This index can be obtained from the lower two bits of the PIR.
+ *
+ * i.e, thread's position in the core = PIR[62:63].
+ * If this value is i, then this thread's paca is
+ * paca->thread_sibling_pacas[i].
+ */
+	mfspr	r4, SPRN_PIR
+	andi.	r4, r4, 0x3
+/*
+ * Since each entry in thread_sibling_pacas is 8 bytes
+ * we need to left-shift by 3 bits. Thus r4 = i * 8
+ */
+	sldi	r4, r4, 3
+/* Get &paca->thread_sibling_pacas[0] in r5 */
+	addi	r5, r13, PACA_SIBLING_PACA_PTRS
+/* Load paca->thread_sibling_pacas[i] into r3 */
+	ldx	r3, r4, r5
+/* Move our paca pointer to r13 */
+	mr	r13, r3
+/* Correctly set up our PACA */
+	ld	r2, PACATOC(r13)
+	ld	r1, PACAR1(r13)
+	bl	setup_paca
+/* Now we are all set! Set our LR and TOC */
+	mtlr	r17
+	ld	r2, PACATOC(r13)
+FTR_SECTION_ELSE_NESTED(70)
+	ld	r2, PACATOC(r13)
+ALT_FTR_SECTION_END_NESTED_IFSET(CPU_FTR_POWER9_DD1, 70)
 	/*
 	 * POWER ISA 3. Use PSSCR to determine if we
 	 * are waking up from deep idle state
diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
index 9fde6e4..87311c2 100644
--- a/arch/powerpc/platforms/powernv/idle.c
+++ b/arch/powerpc/platforms/powernv/idle.c
@@ -532,6 +532,28 @@ static int __init pnv_init_idle_states(void)
 
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
 	else if ((supported_cpuidle_states & OPAL_PM_STOP_INST_FAST) &&
-- 
1.9.4
