Return-Path: <shreyas@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rD2Jp05YxzDqNS
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 May 2016 01:19:37 +1000 (AEST)
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shreyas@linux.vnet.ibm.com>;
 Mon, 23 May 2016 09:19:33 -0600
From: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, paulus@ozlabs.org,
 linux-kernel@vger.kernel.org, mikey@neuling.org, ego@linux.vnet.ibm.com,
 "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
Subject: [PATCH v3 9/9] powerpc/powernv: Use deepest stop state when cpu is
 offlined
Date: Mon, 23 May 2016 20:48:42 +0530
Message-Id: <1464016722-7488-10-git-send-email-shreyas@linux.vnet.ibm.com>
In-Reply-To: <1464016722-7488-1-git-send-email-shreyas@linux.vnet.ibm.com>
References: <1464016722-7488-1-git-send-email-shreyas@linux.vnet.ibm.com>
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
 arch/powerpc/platforms/powernv/idle.c    | 15 +++++++++++++--
 arch/powerpc/platforms/powernv/powernv.h |  1 +
 arch/powerpc/platforms/powernv/smp.c     |  4 +++-
 3 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
index 989cf5d..4808a67 100644
--- a/arch/powerpc/platforms/powernv/idle.c
+++ b/arch/powerpc/platforms/powernv/idle.c
@@ -240,6 +240,11 @@ static DEVICE_ATTR(fastsleep_workaround_applyonce, 0600,
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
@@ -288,8 +293,11 @@ static int __init pnv_init_idle_states(void)
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
 		pnv_first_deep_stop_state = 0xF;
 		for (i = 0; i < dt_idle_states; i++) {
@@ -298,6 +306,9 @@ static int __init pnv_init_idle_states(void)
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
2.4.11
