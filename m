Return-Path: <shreyas@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 05D031A0C48
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Jan 2015 19:05:53 +1100 (AEDT)
Received: from /spool/local
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shreyas@linux.vnet.ibm.com>;
 Mon, 19 Jan 2015 01:05:51 -0700
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id F220519D803E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Jan 2015 00:56:59 -0700 (MST)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t0J85wdP27328752
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Jan 2015 01:05:58 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t0J85l3H027240
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Jan 2015 01:05:48 -0700
From: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] powerpc: Add helpers for LPCR PECE1 operations
Date: Mon, 19 Jan 2015 13:35:26 +0530
Message-Id: <1421654727-31656-1-git-send-email-shreyas@linux.vnet.ibm.com>
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

PECE1 bit in LPCR is used to control whether decrementer can cause exit
from powersaving states. PECE1 bit is cleared before entering fastsleep
or deeper powersaving state and it is set on waking up. Since both
cpuidle and cpu offline operations use these powersaving states, add
helper functions to be used in both these places.

Signed-off-by: Shreyas B. Prabhu <shreyas@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/include/asm/reg.h       | 4 ++++
 arch/powerpc/platforms/powernv/smp.c | 4 ++--
 drivers/cpuidle/cpuidle-powernv.c    | 3 +--
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index c870e38..0847303 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -339,6 +339,10 @@
 #define   LPCR_LPES_SH	2
 #define   LPCR_RMI     0x00000002      /* real mode is cache inhibit */
 #define   LPCR_HDICE   0x00000001      /* Hyp Decr enable (HV,PR,EE) */
+/* LPCR PECE1 helpers. Used to disable/enable wake up due to decrementer */
+#define   LPCR_CLEAR_PECE1(old)	(old & ~(u64)LPCR_PECE1)
+#define   LPCR_SET_PECE1(old)	(old | (u64)LPCR_PECE1)
+
 #ifndef SPRN_LPID
 #define SPRN_LPID	0x13F	/* Logical Partition Identifier */
 #endif
diff --git a/arch/powerpc/platforms/powernv/smp.c b/arch/powerpc/platforms/powernv/smp.c
index 781ec45..ab61cb0 100644
--- a/arch/powerpc/platforms/powernv/smp.c
+++ b/arch/powerpc/platforms/powernv/smp.c
@@ -165,7 +165,7 @@ static void pnv_smp_cpu_kill_self(void)
 	/* We don't want to take decrementer interrupts while we are offline,
 	 * so clear LPCR:PECE1. We keep PECE2 enabled.
 	 */
-	mtspr(SPRN_LPCR, mfspr(SPRN_LPCR) & ~(u64)LPCR_PECE1);
+	mtspr(SPRN_LPCR, LPCR_CLEAR_PECE1(mfspr(SPRN_LPCR)));
 	while (!generic_check_cpu_restart(cpu)) {
 
 		ppc64_runlatch_off();
@@ -203,7 +203,7 @@ static void pnv_smp_cpu_kill_self(void)
 		if (!generic_check_cpu_restart(cpu))
 			DBG("CPU%d Unexpected exit while offline !\n", cpu);
 	}
-	mtspr(SPRN_LPCR, mfspr(SPRN_LPCR) | LPCR_PECE1);
+	mtspr(SPRN_LPCR, LPCR_SET_PECE1(mfspr(SPRN_LPCR)));
 	DBG("CPU%d coming online...\n", cpu);
 }
 
diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
index de61b9a..ed0be4c 100644
--- a/drivers/cpuidle/cpuidle-powernv.c
+++ b/drivers/cpuidle/cpuidle-powernv.c
@@ -69,11 +69,10 @@ static int fastsleep_loop(struct cpuidle_device *dev,
 	if (unlikely(system_state < SYSTEM_RUNNING))
 		return index;
 
-	new_lpcr = old_lpcr;
 	/* Do not exit powersave upon decrementer as we've setup the timer
 	 * offload.
 	 */
-	new_lpcr &= ~LPCR_PECE1;
+	new_lpcr = LPCR_CLEAR_PECE1(old_lpcr);
 
 	mtspr(SPRN_LPCR, new_lpcr);
 	power7_sleep();
-- 
1.9.3
