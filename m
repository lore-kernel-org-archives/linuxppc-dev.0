Return-Path: <rashmicy@gmail.com>
Received: from mail-pa0-x242.google.com (mail-pa0-x242.google.com
 [IPv6:2607:f8b0:400e:c03::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rJ5zb2hM6zDqYc
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 May 2016 16:18:51 +1000 (AEST)
Received: by mail-pa0-x242.google.com with SMTP id x1so4002977pav.1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 May 2016 23:18:51 -0700 (PDT)
From: Rashmica Gupta <rashmicy@gmail.com>
To: mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
 nfont@linux.vnet.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/5] powerpc/pseries: Remove MPIC from pseries kexec
Date: Mon, 30 May 2016 16:18:13 +1000
Message-Id: <1464589095-442-3-git-send-email-rashmicy@gmail.com>
In-Reply-To: <1464589095-442-1-git-send-email-rashmicy@gmail.com>
References: <1464589095-442-1-git-send-email-rashmicy@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

MPIC was only used by Power3 which is now unsupported, so remove MPIC
code. XICS is now the only supported interrupt controller for
pSeries so do some cleanups too.

Signed-off-by: Rashmica Gupta <rashmicy@gmail.com>
---
 arch/powerpc/platforms/pseries/kexec.c   | 23 +----------------------
 arch/powerpc/platforms/pseries/pseries.h |  8 +-------
 arch/powerpc/platforms/pseries/setup.c   |  2 +-
 3 files changed, 3 insertions(+), 30 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/kexec.c b/arch/powerpc/platforms/pseries/kexec.c
index 13fa95b3aa8b..f7a93e6bb630 100644
--- a/arch/powerpc/platforms/pseries/kexec.c
+++ b/arch/powerpc/platforms/pseries/kexec.c
@@ -14,14 +14,13 @@
 #include <asm/page.h>
 #include <asm/firmware.h>
 #include <asm/kexec.h>
-#include <asm/mpic.h>
 #include <asm/xics.h>
 #include <asm/smp.h>
 #include <asm/plpar_wrappers.h>
 
 #include "pseries.h"
 
-static void pseries_kexec_cpu_down(int crash_shutdown, int secondary)
+void pSeries_kexec_cpu_down(int crash_shutdown, int secondary)
 {
 	/* Don't risk a hypervisor call if we're crashing */
 	if (firmware_has_feature(FW_FEATURE_SPLPAR) && !crash_shutdown) {
@@ -51,26 +50,6 @@ static void pseries_kexec_cpu_down(int crash_shutdown, int secondary)
 			       "(hw %d) failed with %d\n", cpu, hwcpu, ret);
 		}
 	}
-}
-
-static void pseries_kexec_cpu_down_mpic(int crash_shutdown, int secondary)
-{
-	pseries_kexec_cpu_down(crash_shutdown, secondary);
-	mpic_teardown_this_cpu(secondary);
-}
 
-void __init setup_kexec_cpu_down_mpic(void)
-{
-	ppc_md.kexec_cpu_down = pseries_kexec_cpu_down_mpic;
-}
-
-static void pseries_kexec_cpu_down_xics(int crash_shutdown, int secondary)
-{
-	pseries_kexec_cpu_down(crash_shutdown, secondary);
 	xics_kexec_teardown_cpu(secondary);
 }
-
-void __init setup_kexec_cpu_down_xics(void)
-{
-	ppc_md.kexec_cpu_down = pseries_kexec_cpu_down_xics;
-}
diff --git a/arch/powerpc/platforms/pseries/pseries.h b/arch/powerpc/platforms/pseries/pseries.h
index edeaec74b656..d81aa1e08478 100644
--- a/arch/powerpc/platforms/pseries/pseries.h
+++ b/arch/powerpc/platforms/pseries/pseries.h
@@ -36,13 +36,7 @@ extern void smp_init_pseries(void);
 static inline void smp_init_pseries(void) { };
 #endif
 
-#ifdef CONFIG_KEXEC
-extern void setup_kexec_cpu_down_xics(void);
-extern void setup_kexec_cpu_down_mpic(void);
-#else
-static inline void setup_kexec_cpu_down_xics(void) { }
-static inline void setup_kexec_cpu_down_mpic(void) { }
-#endif
+extern void pSeries_kexec_cpu_down(int crash_shutdown, int secondary);
 
 extern void pSeries_final_fixup(void);
 
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 32a224d3eaa1..15ca3441cf1d 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -436,7 +436,6 @@ static void __init pSeries_setup_arch(void)
 	set_arch_panic_timeout(10, ARCH_PANIC_TIMEOUT);
 
 	/* Discover PIC type and setup ppc_md accordingly */
-	setup_kexec_cpu_down_xics();
 	smp_init_pseries();
 
 
@@ -786,6 +785,7 @@ define_machine(pseries) {
 	.machine_check_exception = pSeries_machine_check_exception,
 #ifdef CONFIG_KEXEC
 	.machine_kexec          = pSeries_machine_kexec,
+	.kexec_cpu_down         = pSeries_kexec_cpu_down,
 #endif
 #ifdef CONFIG_MEMORY_HOTPLUG_SPARSE
 	.memory_block_size	= pseries_memory_block_size,
-- 
2.5.0
