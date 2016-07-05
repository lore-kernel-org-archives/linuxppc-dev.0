Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rkBdb6zBjzDqpb
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jul 2016 15:04:51 +1000 (AEST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rkBdX3q4qz9s9G
 for <linuxppc-dev@ozlabs.org>; Tue,  5 Jul 2016 15:04:47 +1000 (AEST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 08/41] powerpc: Move epapr_paravirt_early_init() to
 early_init_devtree()
Date: Tue,  5 Jul 2016 15:03:44 +1000
Message-Id: <1467695057-12431-9-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1467695057-12431-1-git-send-email-benh@kernel.crashing.org>
References: <1467695057-12431-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The function is called by both 32-bit and 64-bit early setup right
after early_init_devtree(). All it does is run yet another early
DT parser which is precisely what early_init_devtree() is about,
so move it in there.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/prom.c     | 2 ++
 arch/powerpc/kernel/setup_32.c | 3 ---
 arch/powerpc/kernel/setup_64.c | 3 ---
 3 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 946e34f..48434be 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -56,6 +56,7 @@
 #include <asm/opal.h>
 #include <asm/fadump.h>
 #include <asm/debug.h>
+#include <asm/epapr_hcalls.h>
 
 #include <mm/mmu_decl.h>
 
@@ -739,6 +740,7 @@ void __init early_init_devtree(void *params)
 	/* Scan and build the list of machine check recoverable ranges */
 	of_scan_flat_dt(early_init_dt_scan_recoverable_ranges, NULL);
 #endif
+	epapr_paravirt_early_init();
 
 	DBG(" <- early_init_devtree()\n");
 }
diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index 3d06fab..34e61d68 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -37,7 +37,6 @@
 #include <asm/serial.h>
 #include <asm/udbg.h>
 #include <asm/mmu_context.h>
-#include <asm/epapr_hcalls.h>
 #include <asm/code-patching.h>
 
 #define DBG(fmt...)
@@ -110,8 +109,6 @@ notrace void __init machine_init(u64 dt_ptr)
 	/* Do some early initialization based on the flat device tree */
 	early_init_devtree(__va(dt_ptr));
 
-	epapr_paravirt_early_init();
-
 	early_init_mmu();
 
 	probe_machine();
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index bcc95ac..e1b2e6f 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -68,7 +68,6 @@
 #include <asm/code-patching.h>
 #include <asm/kvm_ppc.h>
 #include <asm/hugetlb.h>
-#include <asm/epapr_hcalls.h>
 #include <asm/livepatch.h>
 
 #ifdef DEBUG
@@ -270,8 +269,6 @@ void __init early_setup(unsigned long dt_ptr)
 	 */
 	early_init_devtree(__va(dt_ptr));
 
-	epapr_paravirt_early_init();
-
 	/* Now we know the logical id of our boot cpu, setup the paca. */
 	setup_paca(&paca[boot_cpuid]);
 	fixup_boot_paca();
-- 
2.7.4
