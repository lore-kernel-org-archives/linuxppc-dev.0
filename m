Return-Path: <shreyas@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rL6HW3X98zDqg5
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Jun 2016 22:39:35 +1000 (AEST)
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shreyas@linux.vnet.ibm.com>;
 Thu, 2 Jun 2016 06:39:32 -0600
From: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: paulus@ozlabs.org, mikey@neuling.org, ego@linux.vnet.ibm.com,
 maddy@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org,
 "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
Subject: [PATCH v5 11/11] powerpc/powernv: Use deepest stop state when cpu is
 offlined
Date: Thu,  2 Jun 2016 07:39:01 -0500
Message-Id: <1464871141-11568-12-git-send-email-shreyas@linux.vnet.ibm.com>
In-Reply-To: <1464871141-11568-1-git-send-email-shreyas@linux.vnet.ibm.com>
References: <1464871141-11568-1-git-send-email-shreyas@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If hardware supports stop state, use the deepest stop state when
the cpu is offlined.

Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
Signed-off-by: Shreyas B. Prabhu <shreyas@linux.vnet.ibm.com>
---
 - No changes since v1

 arch/powerpc/platforms/powernv/idle.c    | 15 +++++++++++++--
 arch/powerpc/platforms/powernv/powernv.h |  1 +
 arch/powerpc/platforms/powernv/smp.c     |  4 +++-
 3 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
index bfbd359..b38cb33 100644
--- a/arch/powerpc/platforms/powernv/idle.c
+++ b/arch/powerpc/platforms/powernv/idle.c
@@ -242,6 +242,11 @@ static DEVICE_ATTR(fastsleep_workaround_applyonce, 0600,
  */
 u64 pnv_first_deep_stop_state;
 
+/*
+ * Deepest stop idle state. Used when a cpu is offlined
+ */
+u64 pnv_deepest_stop_state;
+
 static int __init pnv_init_idle_states(void)
 {
 	struct device_node *power_mgt;
@@ -290,8 +295,11 @@ static int __init pnv_init_idle_states(void)
 		}
 
 		/*
-		 * Set pnv_first_deep_stop_state to the first stop level
-		 * to cause hypervisor state loss
+		 * Set pnv_first_deep_stop_state and pnv_deepest_stop_state.
+		 * pnv_first_deep_stop_state should be set to the first stop
+		 * level to cause hypervisor state loss.
+		 * pnv_deepest_stop_state should be set to the deepest stop
+		 * stop state.
 		 */
 		pnv_first_deep_stop_state = MAX_STOP_STATE;
 		for (i = 0; i < dt_idle_states; i++) {
@@ -300,6 +308,9 @@ static int __init pnv_init_idle_states(void)
 			if ((flags[i] & OPAL_PM_LOSE_FULL_CONTEXT) &&
 			     (pnv_first_deep_stop_state > psscr_rl))
 				pnv_first_deep_stop_state = psscr_rl;
+
+			if (pnv_deepest_stop_state < psscr_rl)
+				pnv_deepest_stop_state = psscr_rl;
 		}
 	}
 
diff --git a/arch/powerpc/platforms/powernv/powernv.h b/arch/powerpc/platforms/powernv/powernv.h
index 6dbc0a1..da7c843 100644
--- a/arch/powerpc/platforms/powernv/powernv.h
+++ b/arch/powerpc/platforms/powernv/powernv.h
@@ -18,6 +18,7 @@ static inline void pnv_pci_shutdown(void) { }
 #endif
 
 extern u32 pnv_get_supported_cpuidle_states(void);
+extern u64 pnv_deepest_stop_state;
 
 extern void pnv_lpc_init(void);
 
diff --git a/arch/powerpc/platforms/powernv/smp.c b/arch/powerpc/platforms/powernv/smp.c
index ad7b1a3..f69ceb6 100644
--- a/arch/powerpc/platforms/powernv/smp.c
+++ b/arch/powerpc/platforms/powernv/smp.c
@@ -182,7 +182,9 @@ static void pnv_smp_cpu_kill_self(void)
 
 		ppc64_runlatch_off();
 
-		if (idle_states & OPAL_PM_WINKLE_ENABLED)
+		if (cpu_has_feature(CPU_FTR_ARCH_300))
+			srr1 = power_stop(pnv_deepest_stop_state);
+		else if (idle_states & OPAL_PM_WINKLE_ENABLED)
 			srr1 = power7_winkle();
 		else if ((idle_states & OPAL_PM_SLEEP_ENABLED) ||
 				(idle_states & OPAL_PM_SLEEP_ENABLED_ER1))
-- 
2.1.4
