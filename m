Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vn0rZ59J3zDqbG
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Mar 2017 02:54:54 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2KFsUNK007993
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Mar 2017 11:54:43 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29ahvyrtx6-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Mar 2017 11:54:43 -0400
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Mon, 20 Mar 2017 09:54:42 -0600
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
Subject: [v2 PATCH 3/4] powernv:idle: Don't override default/deepest directly
 in kernel
Date: Mon, 20 Mar 2017 21:24:17 +0530
In-Reply-To: <cover.1490024477.git.ego@linux.vnet.ibm.com>
References: <cover.1490024477.git.ego@linux.vnet.ibm.com>
In-Reply-To: <cover.1490024477.git.ego@linux.vnet.ibm.com>
References: <cover.1490024477.git.ego@linux.vnet.ibm.com>
Message-Id: <84bfbacbd0ab98dd82241292a29e4d5d1bb456c6.1490024477.git.ego@linux.vnet.ibm.com>
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
 arch/powerpc/platforms/powernv/idle.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
index f335e0f..63ade78 100644
--- a/arch/powerpc/platforms/powernv/idle.c
+++ b/arch/powerpc/platforms/powernv/idle.c
@@ -147,7 +147,6 @@ u32 pnv_get_supported_cpuidle_states(void)
 }
 EXPORT_SYMBOL_GPL(pnv_get_supported_cpuidle_states);
 
-
 static void pnv_fastsleep_workaround_apply(void *info)
 
 {
@@ -241,8 +240,9 @@ static DEVICE_ATTR(fastsleep_workaround_applyonce, 0600,
  * The default stop state that will be used by ppc_md.power_save
  * function on platforms that support stop instruction.
  */
-u64 pnv_default_stop_val;
-u64 pnv_default_stop_mask;
+static u64 pnv_default_stop_val;
+static u64 pnv_default_stop_mask;
+static bool default_stop_found;
 
 /*
  * Used for ppc_md.power_save which needs a function with no parameters
@@ -262,8 +262,9 @@ static void power9_idle(void)
  * psscr value and mask of the deepest stop idle state.
  * Used when a cpu is offlined.
  */
-u64 pnv_deepest_stop_psscr_val;
-u64 pnv_deepest_stop_psscr_mask;
+static u64 pnv_deepest_stop_psscr_val;
+static u64 pnv_deepest_stop_psscr_mask;
+static bool deepest_stop_found;
 
 /*
  * pnv_cpu_offline: A function that puts the CPU into the deepest
@@ -275,7 +276,7 @@ unsigned long pnv_cpu_offline(unsigned int cpu)
 
 	u32 idle_states = pnv_get_supported_cpuidle_states();
 
-	if (cpu_has_feature(CPU_FTR_ARCH_300)) {
+	if (cpu_has_feature(CPU_FTR_ARCH_300) && deepest_stop_found) {
 		srr1 = power9_idle_stop(pnv_deepest_stop_psscr_val,
 					pnv_deepest_stop_psscr_mask);
 	} else if (idle_states & OPAL_PM_WINKLE_ENABLED) {
@@ -385,7 +386,6 @@ static int __init pnv_power9_idle_init(struct device_node *np, u32 *flags,
 	u32 *residency_ns = NULL;
 	u64 max_residency_ns = 0;
 	int rc = 0, i;
-	bool default_stop_found = false, deepest_stop_found = false;
 
 	psscr_val = kcalloc(dt_idle_states, sizeof(*psscr_val), GFP_KERNEL);
 	psscr_mask = kcalloc(dt_idle_states, sizeof(*psscr_mask), GFP_KERNEL);
@@ -465,21 +465,24 @@ static int __init pnv_power9_idle_init(struct device_node *np, u32 *flags,
 		}
 	}
 
-	if (!default_stop_found) {
-		pnv_default_stop_val = PSSCR_HV_DEFAULT_VAL;
-		pnv_default_stop_mask = PSSCR_HV_DEFAULT_MASK;
-		pr_warn("Setting default stop psscr val=0x%016llx,mask=0x%016llx\n",
+	if (unlikely(!default_stop_found)) {
+		pr_warn("cpuidle-powernv: No suitable default stop state found. Disabling platform idle.\n");
+	} else {
+		ppc_md.power_save = power9_idle;
+		pr_info("cpuidle-powernv: Default stop: psscr = 0x%016llx,mask=0x%016llx\n",
 			pnv_default_stop_val, pnv_default_stop_mask);
 	}
 
-	if (!deepest_stop_found) {
-		pnv_deepest_stop_psscr_val = PSSCR_HV_DEFAULT_VAL;
-		pnv_deepest_stop_psscr_mask = PSSCR_HV_DEFAULT_MASK;
-		pr_warn("Setting default stop psscr val=0x%016llx,mask=0x%016llx\n",
+	if (unlikely(!deepest_stop_found)) {
+		pr_warn("cpuidle-powernv: No suitable stop state for CPU-Hotplug. Offlined CPUs will busy wait");
+	} else {
+		pr_info("cpuidle-powernv: Deepest stop: psscr = 0x%016llx,mask=0x%016llx\n",
 			pnv_deepest_stop_psscr_val,
 			pnv_deepest_stop_psscr_mask);
 	}
 
+	pr_info("cpuidle-powernv: Requested Level (RL) value of first deep stop = 0x%llx\n",
+		pnv_first_deep_stop_state);
 out:
 	kfree(psscr_val);
 	kfree(psscr_mask);
@@ -559,8 +562,6 @@ static int __init pnv_init_idle_states(void)
 
 	if (supported_cpuidle_states & OPAL_PM_NAP_ENABLED)
 		ppc_md.power_save = power7_idle;
-	else if (supported_cpuidle_states & OPAL_PM_STOP_INST_FAST)
-		ppc_md.power_save = power9_idle;
 
 out:
 	return 0;
-- 
1.9.4
