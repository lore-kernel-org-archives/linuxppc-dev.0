Return-Path: <shreyas@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 62B601A025A
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 22 Mar 2015 15:43:27 +1100 (AEDT)
Received: from /spool/local
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shreyas@linux.vnet.ibm.com>;
 Sat, 21 Mar 2015 22:43:25 -0600
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 6BE4719D8026
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Mar 2015 22:34:28 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2M4hLdn53412006
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Mar 2015 21:43:21 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2M4hK9A018921
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Mar 2015 22:43:21 -0600
From: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] powerpc/powernv: Move cpuidle related code from
 setup.c to new file
Date: Sun, 22 Mar 2015 10:12:58 +0530
Message-Id: <1426999379-20542-2-git-send-email-shreyas@linux.vnet.ibm.com>
In-Reply-To: <1426999379-20542-1-git-send-email-shreyas@linux.vnet.ibm.com>
References: <1426999379-20542-1-git-send-email-shreyas@linux.vnet.ibm.com>
Cc: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a cleanup patch; doesn't change any functionality. Moves
all cpuidle related code from setup.c to a new file.

Signed-off-by: Shreyas B. Prabhu <shreyas@linux.vnet.ibm.com>
---
This patch is new in v3

 arch/powerpc/platforms/powernv/Makefile |   2 +-
 arch/powerpc/platforms/powernv/idle.c   | 186 ++++++++++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/setup.c  | 166 ----------------------------
 3 files changed, 187 insertions(+), 167 deletions(-)
 create mode 100644 arch/powerpc/platforms/powernv/idle.c

diff --git a/arch/powerpc/platforms/powernv/Makefile b/arch/powerpc/platforms/powernv/Makefile
index 6f3c5d3..560ee54 100644
--- a/arch/powerpc/platforms/powernv/Makefile
+++ b/arch/powerpc/platforms/powernv/Makefile
@@ -1,4 +1,4 @@
-obj-y			+= setup.o opal-wrappers.o opal.o opal-async.o
+obj-y			+= setup.o opal-wrappers.o opal.o opal-async.o idle.o
 obj-y			+= opal-rtc.o opal-nvram.o opal-lpc.o opal-flash.o
 obj-y			+= rng.o opal-elog.o opal-dump.o opal-sysparam.o opal-sensor.o
 obj-y			+= opal-msglog.o opal-hmi.o opal-power.o
diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
new file mode 100644
index 0000000..77992f6
--- /dev/null
+++ b/arch/powerpc/platforms/powernv/idle.c
@@ -0,0 +1,186 @@
+/*
+ * PowerNV cpuidle code
+ *
+ * Copyright 2015 IBM Corp.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/types.h>
+#include <linux/mm.h>
+#include <linux/slab.h>
+#include <linux/of.h>
+
+#include <asm/firmware.h>
+#include <asm/opal.h>
+#include <asm/cputhreads.h>
+#include <asm/cpuidle.h>
+#include <asm/code-patching.h>
+
+#include "powernv.h"
+#include "subcore.h"
+
+static u32 supported_cpuidle_states;
+
+int pnv_save_sprs_for_winkle(void)
+{
+	int cpu;
+	int rc;
+
+	/*
+	 * hid0, hid1, hid4, hid5, hmeer and lpcr values are symmetric accross
+	 * all cpus at boot. Get these reg values of current cpu and use the
+	 * same accross all cpus.
+	 */
+	uint64_t lpcr_val = mfspr(SPRN_LPCR) & ~(u64)LPCR_PECE1;
+	uint64_t hid0_val = mfspr(SPRN_HID0);
+	uint64_t hid1_val = mfspr(SPRN_HID1);
+	uint64_t hid4_val = mfspr(SPRN_HID4);
+	uint64_t hid5_val = mfspr(SPRN_HID5);
+	uint64_t hmeer_val = mfspr(SPRN_HMEER);
+
+	for_each_possible_cpu(cpu) {
+		uint64_t pir = get_hard_smp_processor_id(cpu);
+		uint64_t hsprg0_val = (uint64_t)&paca[cpu];
+
+		/*
+		 * HSPRG0 is used to store the cpu's pointer to paca. Hence last
+		 * 3 bits are guaranteed to be 0. Program slw to restore HSPRG0
+		 * with 63rd bit set, so that when a thread wakes up at 0x100 we
+		 * can use this bit to distinguish between fastsleep and
+		 * deep winkle.
+		 */
+		hsprg0_val |= 1;
+
+		rc = opal_slw_set_reg(pir, SPRN_HSPRG0, hsprg0_val);
+		if (rc != 0)
+			return rc;
+
+		rc = opal_slw_set_reg(pir, SPRN_LPCR, lpcr_val);
+		if (rc != 0)
+			return rc;
+
+		/* HIDs are per core registers */
+		if (cpu_thread_in_core(cpu) == 0) {
+
+			rc = opal_slw_set_reg(pir, SPRN_HMEER, hmeer_val);
+			if (rc != 0)
+				return rc;
+
+			rc = opal_slw_set_reg(pir, SPRN_HID0, hid0_val);
+			if (rc != 0)
+				return rc;
+
+			rc = opal_slw_set_reg(pir, SPRN_HID1, hid1_val);
+			if (rc != 0)
+				return rc;
+
+			rc = opal_slw_set_reg(pir, SPRN_HID4, hid4_val);
+			if (rc != 0)
+				return rc;
+
+			rc = opal_slw_set_reg(pir, SPRN_HID5, hid5_val);
+			if (rc != 0)
+				return rc;
+		}
+	}
+
+	return 0;
+}
+
+static void pnv_alloc_idle_core_states(void)
+{
+	int i, j;
+	int nr_cores = cpu_nr_cores();
+	u32 *core_idle_state;
+
+	/*
+	 * core_idle_state - First 8 bits track the idle state of each thread
+	 * of the core. The 8th bit is the lock bit. Initially all thread bits
+	 * are set. They are cleared when the thread enters deep idle state
+	 * like sleep and winkle. Initially the lock bit is cleared.
+	 * The lock bit has 2 purposes
+	 * a. While the first thread is restoring core state, it prevents
+	 * other threads in the core from switching to process context.
+	 * b. While the last thread in the core is saving the core state, it
+	 * prevents a different thread from waking up.
+	 */
+	for (i = 0; i < nr_cores; i++) {
+		int first_cpu = i * threads_per_core;
+		int node = cpu_to_node(first_cpu);
+
+		core_idle_state = kmalloc_node(sizeof(u32), GFP_KERNEL, node);
+		*core_idle_state = PNV_CORE_IDLE_THREAD_BITS;
+
+		for (j = 0; j < threads_per_core; j++) {
+			int cpu = first_cpu + j;
+
+			paca[cpu].core_idle_state_ptr = core_idle_state;
+			paca[cpu].thread_idle_state = PNV_THREAD_RUNNING;
+			paca[cpu].thread_mask = 1 << j;
+		}
+	}
+
+	update_subcore_sibling_mask();
+
+	if (supported_cpuidle_states & OPAL_PM_WINKLE_ENABLED)
+		pnv_save_sprs_for_winkle();
+}
+
+u32 pnv_get_supported_cpuidle_states(void)
+{
+	return supported_cpuidle_states;
+}
+EXPORT_SYMBOL_GPL(pnv_get_supported_cpuidle_states);
+
+static int __init pnv_init_idle_states(void)
+{
+	struct device_node *power_mgt;
+	int dt_idle_states;
+	const __be32 *idle_state_flags;
+	u32 len_flags, flags;
+	int i;
+
+	supported_cpuidle_states = 0;
+
+	if (cpuidle_disable != IDLE_NO_OVERRIDE)
+		return 0;
+
+	if (!firmware_has_feature(FW_FEATURE_OPALv3))
+		return 0;
+
+	power_mgt = of_find_node_by_path("/ibm,opal/power-mgt");
+	if (!power_mgt) {
+		pr_warn("opal: PowerMgmt Node not found\n");
+		return 0;
+	}
+
+	idle_state_flags = of_get_property(power_mgt,
+			"ibm,cpu-idle-state-flags", &len_flags);
+	if (!idle_state_flags) {
+		pr_warn("DT-PowerMgmt: missing ibm,cpu-idle-state-flags\n");
+		return 0;
+	}
+
+	dt_idle_states = len_flags / sizeof(u32);
+
+	for (i = 0; i < dt_idle_states; i++) {
+		flags = be32_to_cpu(idle_state_flags[i]);
+		supported_cpuidle_states |= flags;
+	}
+	if (!(supported_cpuidle_states & OPAL_PM_SLEEP_ENABLED_ER1)) {
+		patch_instruction(
+			(unsigned int *)pnv_fastsleep_workaround_at_entry,
+			PPC_INST_NOP);
+		patch_instruction(
+			(unsigned int *)pnv_fastsleep_workaround_at_exit,
+			PPC_INST_NOP);
+	}
+	pnv_alloc_idle_core_states();
+	return 0;
+}
+
+subsys_initcall(pnv_init_idle_states);
diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
index d2de7d5..30b1c3e 100644
--- a/arch/powerpc/platforms/powernv/setup.c
+++ b/arch/powerpc/platforms/powernv/setup.c
@@ -36,12 +36,8 @@
 #include <asm/opal.h>
 #include <asm/kexec.h>
 #include <asm/smp.h>
-#include <asm/cputhreads.h>
-#include <asm/cpuidle.h>
-#include <asm/code-patching.h>
 
 #include "powernv.h"
-#include "subcore.h"
 
 static void __init pnv_setup_arch(void)
 {
@@ -292,168 +288,6 @@ static void __init pnv_setup_machdep_rtas(void)
 }
 #endif /* CONFIG_PPC_POWERNV_RTAS */
 
-static u32 supported_cpuidle_states;
-
-int pnv_save_sprs_for_winkle(void)
-{
-	int cpu;
-	int rc;
-
-	/*
-	 * hid0, hid1, hid4, hid5, hmeer and lpcr values are symmetric accross
-	 * all cpus at boot. Get these reg values of current cpu and use the
-	 * same accross all cpus.
-	 */
-	uint64_t lpcr_val = mfspr(SPRN_LPCR) & ~(u64)LPCR_PECE1;
-	uint64_t hid0_val = mfspr(SPRN_HID0);
-	uint64_t hid1_val = mfspr(SPRN_HID1);
-	uint64_t hid4_val = mfspr(SPRN_HID4);
-	uint64_t hid5_val = mfspr(SPRN_HID5);
-	uint64_t hmeer_val = mfspr(SPRN_HMEER);
-
-	for_each_possible_cpu(cpu) {
-		uint64_t pir = get_hard_smp_processor_id(cpu);
-		uint64_t hsprg0_val = (uint64_t)&paca[cpu];
-
-		/*
-		 * HSPRG0 is used to store the cpu's pointer to paca. Hence last
-		 * 3 bits are guaranteed to be 0. Program slw to restore HSPRG0
-		 * with 63rd bit set, so that when a thread wakes up at 0x100 we
-		 * can use this bit to distinguish between fastsleep and
-		 * deep winkle.
-		 */
-		hsprg0_val |= 1;
-
-		rc = opal_slw_set_reg(pir, SPRN_HSPRG0, hsprg0_val);
-		if (rc != 0)
-			return rc;
-
-		rc = opal_slw_set_reg(pir, SPRN_LPCR, lpcr_val);
-		if (rc != 0)
-			return rc;
-
-		/* HIDs are per core registers */
-		if (cpu_thread_in_core(cpu) == 0) {
-
-			rc = opal_slw_set_reg(pir, SPRN_HMEER, hmeer_val);
-			if (rc != 0)
-				return rc;
-
-			rc = opal_slw_set_reg(pir, SPRN_HID0, hid0_val);
-			if (rc != 0)
-				return rc;
-
-			rc = opal_slw_set_reg(pir, SPRN_HID1, hid1_val);
-			if (rc != 0)
-				return rc;
-
-			rc = opal_slw_set_reg(pir, SPRN_HID4, hid4_val);
-			if (rc != 0)
-				return rc;
-
-			rc = opal_slw_set_reg(pir, SPRN_HID5, hid5_val);
-			if (rc != 0)
-				return rc;
-		}
-	}
-
-	return 0;
-}
-
-static void pnv_alloc_idle_core_states(void)
-{
-	int i, j;
-	int nr_cores = cpu_nr_cores();
-	u32 *core_idle_state;
-
-	/*
-	 * core_idle_state - First 8 bits track the idle state of each thread
-	 * of the core. The 8th bit is the lock bit. Initially all thread bits
-	 * are set. They are cleared when the thread enters deep idle state
-	 * like sleep and winkle. Initially the lock bit is cleared.
-	 * The lock bit has 2 purposes
-	 * a. While the first thread is restoring core state, it prevents
-	 * other threads in the core from switching to process context.
-	 * b. While the last thread in the core is saving the core state, it
-	 * prevents a different thread from waking up.
-	 */
-	for (i = 0; i < nr_cores; i++) {
-		int first_cpu = i * threads_per_core;
-		int node = cpu_to_node(first_cpu);
-
-		core_idle_state = kmalloc_node(sizeof(u32), GFP_KERNEL, node);
-		*core_idle_state = PNV_CORE_IDLE_THREAD_BITS;
-
-		for (j = 0; j < threads_per_core; j++) {
-			int cpu = first_cpu + j;
-
-			paca[cpu].core_idle_state_ptr = core_idle_state;
-			paca[cpu].thread_idle_state = PNV_THREAD_RUNNING;
-			paca[cpu].thread_mask = 1 << j;
-		}
-	}
-
-	update_subcore_sibling_mask();
-
-	if (supported_cpuidle_states & OPAL_PM_WINKLE_ENABLED)
-		pnv_save_sprs_for_winkle();
-}
-
-u32 pnv_get_supported_cpuidle_states(void)
-{
-	return supported_cpuidle_states;
-}
-EXPORT_SYMBOL_GPL(pnv_get_supported_cpuidle_states);
-
-static int __init pnv_init_idle_states(void)
-{
-	struct device_node *power_mgt;
-	int dt_idle_states;
-	const __be32 *idle_state_flags;
-	u32 len_flags, flags;
-	int i;
-
-	supported_cpuidle_states = 0;
-
-	if (cpuidle_disable != IDLE_NO_OVERRIDE)
-		return 0;
-
-	if (!firmware_has_feature(FW_FEATURE_OPALv3))
-		return 0;
-
-	power_mgt = of_find_node_by_path("/ibm,opal/power-mgt");
-	if (!power_mgt) {
-		pr_warn("opal: PowerMgmt Node not found\n");
-		return 0;
-	}
-
-	idle_state_flags = of_get_property(power_mgt,
-			"ibm,cpu-idle-state-flags", &len_flags);
-	if (!idle_state_flags) {
-		pr_warn("DT-PowerMgmt: missing ibm,cpu-idle-state-flags\n");
-		return 0;
-	}
-
-	dt_idle_states = len_flags / sizeof(u32);
-
-	for (i = 0; i < dt_idle_states; i++) {
-		flags = be32_to_cpu(idle_state_flags[i]);
-		supported_cpuidle_states |= flags;
-	}
-	if (!(supported_cpuidle_states & OPAL_PM_SLEEP_ENABLED_ER1)) {
-		patch_instruction(
-			(unsigned int *)pnv_fastsleep_workaround_at_entry,
-			PPC_INST_NOP);
-		patch_instruction(
-			(unsigned int *)pnv_fastsleep_workaround_at_exit,
-			PPC_INST_NOP);
-	}
-	pnv_alloc_idle_core_states();
-	return 0;
-}
-
-subsys_initcall(pnv_init_idle_states);
-
 static int __init pnv_probe(void)
 {
 	unsigned long root = of_get_flat_dt_root();
-- 
1.9.3
