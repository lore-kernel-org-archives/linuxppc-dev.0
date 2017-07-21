Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xDSX34RxbzDqtr
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Jul 2017 21:02:11 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6LAwlUS144608
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Jul 2017 07:02:09 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2buckr8xbs-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Jul 2017 07:02:09 -0400
Received: from localhost
 by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Fri, 21 Jul 2017 07:02:08 -0400
From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling <mikey@neuling.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: [RESEND] [v3 PATCH 2/2] powernv/powerpc: Clear PECE1 in LPCR via
 stop-api only on Hotplug
Date: Fri, 21 Jul 2017 16:31:34 +0530
In-Reply-To: <cover.1500631040.git.ego@linux.vnet.ibm.com>
References: <cover.1500631040.git.ego@linux.vnet.ibm.com>
Message-Id: <1500634894-18352-1-git-send-email-ego@linux.vnet.ibm.com>
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

In this patch, we program the stop-api for LPCR with PECE1
bit cleared only when we are offlining the CPU and set it
back once the CPU is online.

Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
---
v2 --> v3:
- Program the LPCR during platform idle entry/exit on both POWER8 and
  POWER9

v1 --> v2:
- Move the LPCR manipulations for CPU-Hotplug into idle.c

 arch/powerpc/platforms/powernv/idle.c | 34 +++++++++++++++++++++++++++++++++-
 arch/powerpc/platforms/powernv/smp.c  |  8 --------
 2 files changed, 33 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
index 2abee07..a1296e7 100644
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
@@ -355,6 +355,14 @@ void power9_idle(void)
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
+static void pnv_program_cpu_hotplug_lpcr(unsigned int cpu, u64 lpcr_val)
+{
+	u64 pir = get_hard_smp_processor_id(cpu);
+
+	mtspr(SPRN_LPCR, lpcr_val);
+	opal_slw_set_reg(pir, SPRN_LPCR, lpcr_val);
+}
+
 /*
  * pnv_cpu_offline: A function that puts the CPU into the deepest
  * available platform idle state on a CPU-Offline.
@@ -364,6 +372,20 @@ unsigned long pnv_cpu_offline(unsigned int cpu)
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
 
@@ -394,6 +416,16 @@ unsigned long pnv_cpu_offline(unsigned int cpu)
 
 	__ppc64_runlatch_on();
 
+	/*
+	 * Re-enable decrementer interrupts in LPCR.
+	 *
+	 * Further, we want stop states to be woken up by decrementer
+	 * for non-hotplug cases. So program the LPCR via stop api as
+	 * well.
+	 */
+	lpcr_val = mfspr(SPRN_LPCR) | (u64)LPCR_PECE1;
+	pnv_program_cpu_hotplug_lpcr(cpu, lpcr_val);
+
 	return srr1;
 }
 #endif
diff --git a/arch/powerpc/platforms/powernv/smp.c b/arch/powerpc/platforms/powernv/smp.c
index 40dae96..536b07b 100644
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
@@ -219,8 +213,6 @@ static void pnv_smp_cpu_kill_self(void)
 
 	}
 
-	/* Re-enable decrementer interrupts */
-	mtspr(SPRN_LPCR, mfspr(SPRN_LPCR) | LPCR_PECE1);
 	DBG("CPU%d coming online...\n", cpu);
 }
 
-- 
1.9.4
