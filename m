Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vhS1c485gzDqY4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Mar 2017 17:01:56 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2D5x0Jp053693
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Mar 2017 02:01:55 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 by mx0a-001b2d01.pphosted.com with ESMTP id 294emes8sg-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Mar 2017 02:01:54 -0400
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
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
Subject: [PATCH 2/3] powernv:idle: Don't override default/deepest directly in
 kernel
Date: Mon, 13 Mar 2017 11:31:27 +0530
In-Reply-To: <cover.1489383815.git.ego@linux.vnet.ibm.com>
References: <cover.1489383815.git.ego@linux.vnet.ibm.com>
In-Reply-To: <cover.1489383815.git.ego@linux.vnet.ibm.com>
References: <cover.1489383815.git.ego@linux.vnet.ibm.com>
Message-Id: <d8ca81ac95beaa82feae91a9028b98be3334c589.1489383815.git.ego@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>

Currently during idle-init on power9, if we don't find suitable stop
states in the device tree that can be used as the
default_stop/deepest_stop, we set stop0 (ESL=1,EC=1) as the default
stop state psscr to be used by power9_idle and deepest stop state
which is used by CPU-Hotplug.

However, if the platform firmware has not configured or enabled a stop
state, the kernel should not make any assumptions and fallback to a
default choice.

If the kernel uses a stop state that is not configured by the platform
firmware, it may lead to further failures which should be avoided.

In this patch, we modify the init code to ensure that the kernel uses
only the stop states exposed by the firmware through the device
tree. When a suitable default stop state isn't found, we disable
ppc_md.power_save for power9. Similarly, when a suitable
deepest_stop_state is not found in the device tree exported by the
firmware, fall back to the default busy-wait loop in the CPU-Hotplug
code.

[Changelog written with inputs from svaidy@linux.vnet.ibm.com]

Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/idle.c    | 27 ++++++++++++++++++---------
 arch/powerpc/platforms/powernv/powernv.h |  1 +
 arch/powerpc/platforms/powernv/smp.c     |  8 +++++++-
 3 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
index 4ee837e..9fde6e4 100644
--- a/arch/powerpc/platforms/powernv/idle.c
+++ b/arch/powerpc/platforms/powernv/idle.c
@@ -147,7 +147,6 @@ u32 pnv_get_supported_cpuidle_states(void)
 }
 EXPORT_SYMBOL_GPL(pnv_get_supported_cpuidle_states);
 
-
 static void pnv_fastsleep_workaround_apply(void *info)
 
 {
@@ -243,6 +242,7 @@ static DEVICE_ATTR(fastsleep_workaround_applyonce, 0600,
  */
 u64 pnv_default_stop_val;
 u64 pnv_default_stop_mask;
+bool default_stop_found;
 
 /*
  * Used for ppc_md.power_save which needs a function with no parameters
@@ -264,6 +264,7 @@ static void power9_idle(void)
  */
 u64 pnv_deepest_stop_psscr_val;
 u64 pnv_deepest_stop_psscr_mask;
+bool deepest_stop_found;
 
 /*
  * Power ISA 3.0 idle initialization.
@@ -352,7 +353,6 @@ static int __init pnv_power9_idle_init(struct device_node *np, u32 *flags,
 	u32 *residency_ns = NULL;
 	u64 max_residency_ns = 0;
 	int rc = 0, i;
-	bool default_stop_found = false, deepest_stop_found = false;
 
 	psscr_val = kcalloc(dt_idle_states, sizeof(*psscr_val), GFP_KERNEL);
 	psscr_mask = kcalloc(dt_idle_states, sizeof(*psscr_mask), GFP_KERNEL);
@@ -433,20 +433,22 @@ static int __init pnv_power9_idle_init(struct device_node *np, u32 *flags,
 	}
 
 	if (!default_stop_found) {
-		pnv_default_stop_val = PSSCR_HV_DEFAULT_VAL;
-		pnv_default_stop_mask = PSSCR_HV_DEFAULT_MASK;
-		pr_warn("Setting default stop psscr val=0x%016llx,mask=0x%016llx\n",
+		pr_warn("powernv:idle: Default stop not found. Disabling ppcmd.powersave\n");
+	} else {
+		pr_info("powernv:idle: Default stop: psscr = 0x%016llx,mask=0x%016llx\n",
 			pnv_default_stop_val, pnv_default_stop_mask);
 	}
 
 	if (!deepest_stop_found) {
-		pnv_deepest_stop_psscr_val = PSSCR_HV_DEFAULT_VAL;
-		pnv_deepest_stop_psscr_mask = PSSCR_HV_DEFAULT_MASK;
-		pr_warn("Setting default stop psscr val=0x%016llx,mask=0x%016llx\n",
+		pr_warn("powernv:idle: Deepest stop not found. CPU-Hotplug is affected\n");
+	} else {
+		pr_info("powernv:idle: Deepest stop: psscr = 0x%016llx,mask=0x%016llx\n",
 			pnv_deepest_stop_psscr_val,
 			pnv_deepest_stop_psscr_mask);
 	}
 
+	pr_info("powernv:idle: RL value of first deep stop = 0x%llx\n",
+		pnv_first_deep_stop_state);
 out:
 	kfree(psscr_val);
 	kfree(psscr_mask);
@@ -454,6 +456,12 @@ static int __init pnv_power9_idle_init(struct device_node *np, u32 *flags,
 	return rc;
 }
 
+bool pnv_check_deepest_stop(void)
+{
+	return deepest_stop_found;
+}
+EXPORT_SYMBOL_GPL(pnv_check_deepest_stop);
+
 /*
  * Probe device tree for supported idle states
  */
@@ -526,7 +534,8 @@ static int __init pnv_init_idle_states(void)
 
 	if (supported_cpuidle_states & OPAL_PM_NAP_ENABLED)
 		ppc_md.power_save = power7_idle;
-	else if (supported_cpuidle_states & OPAL_PM_STOP_INST_FAST)
+	else if ((supported_cpuidle_states & OPAL_PM_STOP_INST_FAST) &&
+		 default_stop_found)
 		ppc_md.power_save = power9_idle;
 
 out:
diff --git a/arch/powerpc/platforms/powernv/powernv.h b/arch/powerpc/platforms/powernv/powernv.h
index 6130522..9acd5eb 100644
--- a/arch/powerpc/platforms/powernv/powernv.h
+++ b/arch/powerpc/platforms/powernv/powernv.h
@@ -18,6 +18,7 @@ static inline void pnv_pci_shutdown(void) { }
 #endif
 
 extern u32 pnv_get_supported_cpuidle_states(void);
+bool pnv_check_deepest_stop(void);
 extern u64 pnv_deepest_stop_psscr_val;
 extern u64 pnv_deepest_stop_psscr_mask;
 
diff --git a/arch/powerpc/platforms/powernv/smp.c b/arch/powerpc/platforms/powernv/smp.c
index 8d5b99e..3f66e6f 100644
--- a/arch/powerpc/platforms/powernv/smp.c
+++ b/arch/powerpc/platforms/powernv/smp.c
@@ -140,6 +140,7 @@ static void pnv_smp_cpu_kill_self(void)
 	unsigned int cpu;
 	unsigned long srr1, wmask;
 	u32 idle_states;
+	bool deepest_stop_found;
 
 	/* Standard hot unplug procedure */
 	local_irq_disable();
@@ -155,6 +156,7 @@ static void pnv_smp_cpu_kill_self(void)
 		wmask = SRR1_WAKEMASK_P8;
 
 	idle_states = pnv_get_supported_cpuidle_states();
+	deepest_stop_found = pnv_check_deepest_stop();
 
 	/* We don't want to take decrementer interrupts while we are offline,
 	 * so clear LPCR:PECE1. We keep PECE2 (and LPCR_PECE_HVEE on P9)
@@ -184,7 +186,11 @@ static void pnv_smp_cpu_kill_self(void)
 
 		ppc64_runlatch_off();
 
-		if (cpu_has_feature(CPU_FTR_ARCH_300)) {
+		if (cpu_has_feature(CPU_FTR_ARCH_300) && deepest_stop_found) {
+			pr_info("CPU %u offlining with psscr = 0x%016llx\n",
+				cpu, pnv_deepest_stop_psscr_val);
+			pr_info("CPU%d down paca pir %016x pir %lx\n",
+				cpu, hard_smp_processor_id(), mfspr(SPRN_PIR));
 			srr1 = power9_idle_stop(pnv_deepest_stop_psscr_val,
 						pnv_deepest_stop_psscr_mask);
 		} else if (idle_states & OPAL_PM_WINKLE_ENABLED) {
-- 
1.9.4
