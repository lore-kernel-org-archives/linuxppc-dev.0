Return-Path: <nicolas.pitre@linaro.org>
Received: from relais.videotron.ca (relais.videotron.ca [24.201.245.36])
 by ozlabs.org (Postfix) with ESMTP id E2A032C009F
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Feb 2014 01:17:00 +1100 (EST)
Received: from yoda.home ([66.130.143.177]) by VL-VM-MR006.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0N0K00IP9VO2QR60@VL-VM-MR006.ip.videotron.ca> for
 linuxppc-dev@lists.ozlabs.org; Thu, 06 Feb 2014 09:16:51 -0500 (EST)
From: Nicolas Pitre <nicolas.pitre@linaro.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Preeti U Murthy <preeti@linux.vnet.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 1/2] PPC: powernv: remove redundant cpuidle_idle_call()
Date: Thu, 06 Feb 2014 09:16:27 -0500
Message-id: <1391696188-14540-1-git-send-email-nicolas.pitre@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-pm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The core idle loop now takes care of it.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
---
 arch/powerpc/platforms/powernv/setup.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
index 21166f65c9..a932feb290 100644
--- a/arch/powerpc/platforms/powernv/setup.c
+++ b/arch/powerpc/platforms/powernv/setup.c
@@ -26,7 +26,6 @@
 #include <linux/of_fdt.h>
 #include <linux/interrupt.h>
 #include <linux/bug.h>
-#include <linux/cpuidle.h>
 
 #include <asm/machdep.h>
 #include <asm/firmware.h>
@@ -217,16 +216,6 @@ static int __init pnv_probe(void)
 	return 1;
 }
 
-void powernv_idle(void)
-{
-	/* Hook to cpuidle framework if available, else
-	 * call on default platform idle code
-	 */
-	if (cpuidle_idle_call()) {
-		power7_idle();
-	}
-}
-
 define_machine(powernv) {
 	.name			= "PowerNV",
 	.probe			= pnv_probe,
@@ -236,7 +225,7 @@ define_machine(powernv) {
 	.show_cpuinfo		= pnv_show_cpuinfo,
 	.progress		= pnv_progress,
 	.machine_shutdown	= pnv_shutdown,
-	.power_save             = powernv_idle,
+	.power_save             = power7_idle,
 	.calibrate_decr		= generic_calibrate_decr,
 #ifdef CONFIG_KEXEC
 	.kexec_cpu_down		= pnv_kexec_cpu_down,
-- 
1.8.4.108.g55ea5f6
