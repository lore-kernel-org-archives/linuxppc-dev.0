Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xC90v0M1yzDrVJ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jul 2017 18:19:10 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6J8IuYA146913
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jul 2017 04:19:09 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2bt1uv531g-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jul 2017 04:19:08 -0400
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Wed, 19 Jul 2017 02:19:08 -0600
From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling <mikey@neuling.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: [v2 PATCH 2/2] powernv/powerpc: Clear PECE1 in LPCR via stop-api only
 on Hotplug
Date: Wed, 19 Jul 2017 13:48:50 +0530
In-Reply-To: <cover.1500452107.git.ego@linux.vnet.ibm.com>
References: <cover.1500452107.git.ego@linux.vnet.ibm.com>
In-Reply-To: <cover.1500452107.git.ego@linux.vnet.ibm.com>
References: <cover.1500452107.git.ego@linux.vnet.ibm.com>
Message-Id: <4142c685fd33835db00eaecedf69186458c1c039.1500452107.git.ego@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>

Currently we use the stop-api provided by the firmware to program the
SLW engine to restore the values of hypervisor resources that get lost
on deeper idle states (such as winkle). Since the deep states were
only used for CPU-Hotplug on POWER8 systems, we would program the LPCR
to have the PECE1 bit since Hotplugged CPUs shouldn't be spuriously
woken up by decrementer.

On POWER9, some of the deep platform idle states such as stop4 can be
used in cpuidle as well. In this case, we want the CPU in stop4 to be
woken up by the decrementer when some timer on the CPU expires.

In this patch, for POWER9, we program the stop-api for LPCR with PECE1
bit cleared only when we are offlining the CPU.

Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/idle.c | 45 ++++++++++++++++++++++++++++++++++-
 arch/powerpc/platforms/powernv/smp.c  | 10 --------
 2 files changed, 44 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
index 2abee07..a6c69b7 100644
--- a/arch/powerpc/platforms/powernv/idle.c
+++ b/arch/powerpc/platforms/powernv/idle.c
@@ -68,7 +68,7 @@ static int pnv_save_sprs_for_deep_states(void)
 	 * all cpus at boot. Get these reg values of current cpu and use the
 	 * same across all cpus.
 	 */
-	uint64_t lpcr_val = mfspr(SPRN_LPCR) & ~(u64)LPCR_PECE1;
+	uint64_t lpcr_val = mfspr(SPRN_LPCR);
 	uint64_t hid0_val = mfspr(SPRN_HID0);
 	uint64_t hid1_val = mfspr(SPRN_HID1);
 	uint64_t hid4_val = mfspr(SPRN_HID4);
@@ -85,6 +85,16 @@ static int pnv_save_sprs_for_deep_states(void)
 		if (rc != 0)
 			return rc;
 
+		/*
+		 * On POWER8, the only state that uses SLW engine is
+		 * winkle.  This is only used for CPU-Hotplug. So we
+		 * clear the decrementer bit from LPCR since we
+		 * don't want to be woken up on decrementer when in
+		 * winkle.
+		 */
+		if (!cpu_has_feature(CPU_FTR_ARCH_300))
+			lpcr_val = lpcr_val & ~(u64)LPCR_PECE1;
+
 		rc = opal_slw_set_reg(pir, SPRN_LPCR, lpcr_val);
 		if (rc != 0)
 			return rc;
@@ -355,6 +365,15 @@ void power9_idle(void)
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
+static void pnv_program_cpu_hotplug_lpcr(unsigned int cpu, u64 lpcr_val)
+{
+	u64 pir = get_hard_smp_processor_id(cpu);
+
+	mtspr(SPRN_LPCR, lpcr_val);
+	if (cpu_has_feature(CPU_FTR_ARCH_300))
+		opal_slw_set_reg(pir, SPRN_LPCR, lpcr_val);
+}
+
 /*
  * pnv_cpu_offline: A function that puts the CPU into the deepest
  * available platform idle state on a CPU-Offline.
@@ -364,6 +383,20 @@ unsigned long pnv_cpu_offline(unsigned int cpu)
 {
 	unsigned long srr1;
 	u32 idle_states = pnv_get_supported_cpuidle_states();
+	u64 lpcr_val;
+
+	/*
+	 * We don't want to take decrementer interrupts while we are
+	 * offline, so clear LPCR:PECE1. We keep PECE2 (and
+	 * LPCR_PECE_HVEE on P9) enabled as to let IPIs in.
+	 *
+	 * If the CPU gets woken up by a special wakeup, ensure that
+	 * the SLW engine sets LPCR with decrementer bit cleared, else
+	 * the CPU will come back to the kernel due to a spurious
+	 * wakeup.
+	 */
+	lpcr_val = mfspr(SPRN_LPCR) & ~(u64)LPCR_PECE1;
+	pnv_program_cpu_hotplug_lpcr(cpu, lpcr_val);
 
 	__ppc64_runlatch_off();
 
@@ -394,6 +427,16 @@ unsigned long pnv_cpu_offline(unsigned int cpu)
 
 	__ppc64_runlatch_on();
 
+	/*
+	 * Re-enable decrementer interrupts in LPCR.
+	 *
+	 * Further on POWER9, we want stop states to be woken up by
+	 * decrementer for non-hotplug cases. So program the LPCR via
+	 * stop api as well.
+	 */
+	lpcr_val = mfspr(SPRN_LPCR) | (u64)LPCR_PECE1;
+	pnv_program_cpu_hotplug_lpcr(cpu, lpcr_val);
+
 	return srr1;
 }
 #endif
diff --git a/arch/powerpc/platforms/powernv/smp.c b/arch/powerpc/platforms/powernv/smp.c
index 40dae96..9ef6b37 100644
--- a/arch/powerpc/platforms/powernv/smp.c
+++ b/arch/powerpc/platforms/powernv/smp.c
@@ -164,12 +164,6 @@ static void pnv_smp_cpu_kill_self(void)
 	if (cpu_has_feature(CPU_FTR_ARCH_207S))
 		wmask = SRR1_WAKEMASK_P8;
 
-	/* We don't want to take decrementer interrupts while we are offline,
-	 * so clear LPCR:PECE1. We keep PECE2 (and LPCR_PECE_HVEE on P9)
-	 * enabled as to let IPIs in.
-	 */
-	mtspr(SPRN_LPCR, mfspr(SPRN_LPCR) & ~(u64)LPCR_PECE1);
-
 	while (!generic_check_cpu_restart(cpu)) {
 		/*
 		 * Clear IPI flag, since we don't handle IPIs while
@@ -181,7 +175,6 @@ static void pnv_smp_cpu_kill_self(void)
 		kvmppc_set_host_ipi(cpu, 0);
 
 		srr1 = pnv_cpu_offline(cpu);
-
 		WARN_ON(lazy_irq_pending());
 
 		/*
@@ -216,11 +209,8 @@ static void pnv_smp_cpu_kill_self(void)
 		if (srr1 && !generic_check_cpu_restart(cpu))
 			DBG("CPU%d Unexpected exit while offline srr1=%lx!\n",
 					cpu, srr1);
-
 	}
 
-	/* Re-enable decrementer interrupts */
-	mtspr(SPRN_LPCR, mfspr(SPRN_LPCR) | LPCR_PECE1);
 	DBG("CPU%d coming online...\n", cpu);
 }
 
-- 
1.9.4
