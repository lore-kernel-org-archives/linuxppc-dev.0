Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 428VGb1PYxzF39K
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Sep 2018 13:08:07 +1000 (AEST)
From: Michael Neuling <mikey@neuling.org>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>,
 paulus@ozlabs.org, mikey@neuling.org
Subject: [PATCH] powerpc/tm: Fix HFSCR bit for no suspend case
Date: Tue, 11 Sep 2018 13:07:56 +1000
Message-Id: <20180911030756.19583-1-mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently on P9N DD2.1 we end up taking infinite TM facility
unavailable exceptions on the first TM usage by userspace.

In the special case of TM no suspend (P9N DD2.1), Linux is told TM is
off via CPU dt-ftrs but told to (partially) use it via
OPAL_REINIT_CPUS_TM_SUSPEND_DISABLED. So HFSCR[TM] will be off from
dt-ftrs but we need to turn it on for the no suspend case.

This patch fixes this by enabling HFSCR TM in this case.

Cc: stable@vger.kernel.org # 4.15+
Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/kernel/setup_64.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 6a501b25dd..faf00222b3 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -243,13 +243,19 @@ static void cpu_ready_for_interrupts(void)
 	}
 
 	/*
-	 * Fixup HFSCR:TM based on CPU features. The bit is set by our
-	 * early asm init because at that point we haven't updated our
-	 * CPU features from firmware and device-tree. Here we have,
-	 * so let's do it.
+	 * Set HFSCR:TM based on CPU features:
+	 * In the special case of TM no suspend (P9N DD2.1), Linux is
+	 * told TM is off via the dt-ftrs but told to (partially) use
+	 * it via OPAL_REINIT_CPUS_TM_SUSPEND_DISABLED. So HFSCR[TM]
+	 * will be off from dt-ftrs but we need to turn it on for the
+	 * no suspend case.
 	 */
-	if (cpu_has_feature(CPU_FTR_HVMODE) && !cpu_has_feature(CPU_FTR_TM_COMP))
-		mtspr(SPRN_HFSCR, mfspr(SPRN_HFSCR) & ~HFSCR_TM);
+	if (cpu_has_feature(CPU_FTR_HVMODE)) {
+		if (cpu_has_feature(CPU_FTR_TM_COMP))
+			mtspr(SPRN_HFSCR, mfspr(SPRN_HFSCR) | HFSCR_TM);
+		else
+			mtspr(SPRN_HFSCR, mfspr(SPRN_HFSCR) & ~HFSCR_TM);
+	}
 
 	/* Set IR and DR in PACA MSR */
 	get_paca()->kernel_msr = MSR_KERNEL;
-- 
2.17.1
