Return-Path: <shreyas@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rlqT7196wzDr41
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jul 2016 06:48:11 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u67KiwwW027329
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Jul 2016 16:48:09 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2415xmb12t-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 Jul 2016 16:48:09 -0400
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shreyas@linux.vnet.ibm.com>;
 Thu, 7 Jul 2016 16:48:08 -0400
From: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: benh@au1.ibm.com, paulus@ozlabs.org, mikey@neuling.org,
 ego@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, maddy@linux.vnet.ibm.com,
 "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
Subject: [PATCH v7 11/11] powerpc/powernv: Use deepest stop state when cpu is
 offlined
Date: Fri,  8 Jul 2016 02:17:12 +0530
In-Reply-To: <1467924432-29003-1-git-send-email-shreyas@linux.vnet.ibm.com>
References: <1467924432-29003-1-git-send-email-shreyas@linux.vnet.ibm.com>
Message-Id: <1467924432-29003-12-git-send-email-shreyas@linux.vnet.ibm.com>
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
index 006e467..2f6968c 100644
--- a/arch/powerpc/platforms/powernv/idle.c
+++ b/arch/powerpc/platforms/powernv/idle.c
@@ -253,6 +253,11 @@ static void power9_idle(void)
 u64 pnv_first_deep_stop_state;
 
 /*
+ * Deepest stop idle state. Used when a cpu is offlined
+ */
+u64 pnv_deepest_stop_state;
+
+/*
  * Power ISA 3.0 idle initialization.
  *
  * POWER ISA 3.0 defines a new SPR Processor stop Status and Control
@@ -314,8 +319,11 @@ static int __init pnv_arch300_idle_init(struct device_node *np, u32 *flags,
 	}
 
 	/*
-	 * Set pnv_first_deep_stop_state to the first stop level
-	 * to cause hypervisor state loss
+	 * Set pnv_first_deep_stop_state and pnv_deepest_stop_state.
+	 * pnv_first_deep_stop_state should be set to the first stop
+	 * level to cause hypervisor state loss.
+	 * pnv_deepest_stop_state should be set to the deepest stop
+	 * stop state.
 	 */
 	pnv_first_deep_stop_state = MAX_STOP_STATE;
 	for (i = 0; i < dt_idle_states; i++) {
@@ -324,6 +332,9 @@ static int __init pnv_arch300_idle_init(struct device_node *np, u32 *flags,
 		if ((flags[i] & OPAL_PM_LOSE_FULL_CONTEXT) &&
 		     (pnv_first_deep_stop_state > psscr_rl))
 			pnv_first_deep_stop_state = psscr_rl;
+
+		if (pnv_deepest_stop_state < psscr_rl)
+			pnv_deepest_stop_state = psscr_rl;
 	}
 
 out:
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
index ad7b1a3..c789258 100644
--- a/arch/powerpc/platforms/powernv/smp.c
+++ b/arch/powerpc/platforms/powernv/smp.c
@@ -182,7 +182,9 @@ static void pnv_smp_cpu_kill_self(void)
 
 		ppc64_runlatch_off();
 
-		if (idle_states & OPAL_PM_WINKLE_ENABLED)
+		if (cpu_has_feature(CPU_FTR_ARCH_300))
+			srr1 = power9_idle_stop(pnv_deepest_stop_state);
+		else if (idle_states & OPAL_PM_WINKLE_ENABLED)
 			srr1 = power7_winkle();
 		else if ((idle_states & OPAL_PM_SLEEP_ENABLED) ||
 				(idle_states & OPAL_PM_SLEEP_ENABLED_ER1))
-- 
2.4.11
