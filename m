Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tHvXW6GdDzDvgf
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Nov 2016 15:28:43 +1100 (AEDT)
Message-ID: <1479184113.2608.45.camel@kernel.crashing.org>
Subject: [PATCH] powerpc/64: Fix setting of AIL in hypervisor mode
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: Anton Blanchard <anton@au1.ibm.com>
Date: Tue, 15 Nov 2016 15:28:33 +1100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit d3cbff1b5 "powerpc: Put exception configuration in a common place"
broke the setting of the AIL bit (which enables taking exceptions with
the MMU still on) on all processors, moving it incorrectly to a function
called only on the boot CPU. This was correct for the guest case but
not when running in hypervisor mode.

This fixes it by partially reverting that commit, putting the setting
back in cpu_ready_for_interrupts()

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Fixes: d3cbff1b5 ("powerpc: Put exception configuration in a common place")
CC: stable@vger.kernel.org # v4.8+
---
 arch/powerpc/kernel/setup_64.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 7ac8e6e..ac75224 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -226,17 +226,25 @@ static void __init configure_exceptions(void)
 		if (firmware_has_feature(FW_FEATURE_OPAL))
 			opal_configure_cores();
 
-		/* Enable AIL if supported, and we are in hypervisor mode */
-		if (early_cpu_has_feature(CPU_FTR_HVMODE) &&
-		    early_cpu_has_feature(CPU_FTR_ARCH_207S)) {
-			unsigned long lpcr = mfspr(SPRN_LPCR);
-			mtspr(SPRN_LPCR, lpcr | LPCR_AIL_3);
-		}
+		/* AIL on native is done in cpu_ready_for_interrupts */
 	}
 }
 
 static void cpu_ready_for_interrupts(void)
 {
+	/*
+	 * Enable AIL if supported, and we are in hypervisor mode. This
+	 * is called once for every processor.
+	 *
+	 * If we are not in hypervisor mode the job is done once for
+	 * the whole partition in configure_exceptions().
+	 */
+	if (early_cpu_has_feature(CPU_FTR_HVMODE) &&
+	    early_cpu_has_feature(CPU_FTR_ARCH_207S)) {
+		unsigned long lpcr = mfspr(SPRN_LPCR);
+		mtspr(SPRN_LPCR, lpcr | LPCR_AIL_3);
+	}
+
 	/* Set IR and DR in PACA MSR */
 	get_paca()->kernel_msr = MSR_KERNEL;
 }
