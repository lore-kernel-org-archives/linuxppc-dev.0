Return-Path: <shreyas@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rPvgn4swgzDqST
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jun 2016 02:55:17 +1000 (AEST)
Received: from pps.filterd (m0049461.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u58GsXQs023178
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Jun 2016 12:55:15 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0b-001b2d01.pphosted.com with ESMTP id 23e9mwwe98-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jun 2016 12:55:15 -0400
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shreyas@linux.vnet.ibm.com>;
 Wed, 8 Jun 2016 10:55:13 -0600
From: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: benh@au1.ibm.com, paulus@ozlabs.org, mikey@neuling.org,
 ego@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
Subject: [PATCH v6 11/11] powerpc/powernv: Use deepest stop state when cpu is
 offlined
Date: Wed,  8 Jun 2016 11:54:31 -0500
In-Reply-To: <1465404871-5406-1-git-send-email-shreyas@linux.vnet.ibm.com>
References: <1465404871-5406-1-git-send-email-shreyas@linux.vnet.ibm.com>
Message-Id: <1465404871-5406-12-git-send-email-shreyas@linux.vnet.ibm.com>
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
