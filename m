Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <d655dc39f94decec5bdfb3bcec9c2d34ef903fbe.1208505275.git.michael@ellerman.id.au>
In-Reply-To: <fbb91d0892c720d6f28501e1830028c78eb6664f.1208505275.git.michael@ellerman.id.au>
References: <fbb91d0892c720d6f28501e1830028c78eb6664f.1208505275.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 05/11] Convert from DBG() to pr_debug() in
	platforms/pseries/smp.c
Date: Fri, 18 Apr 2008 17:54:37 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/platforms/pseries/smp.c |   10 ++--------
 1 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/smp.c b/arch/powerpc/platforms/pseries/smp.c
index ea4c659..e9bc2a5 100644
--- a/arch/powerpc/platforms/pseries/smp.c
+++ b/arch/powerpc/platforms/pseries/smp.c
@@ -51,12 +51,6 @@
 #include "plpar_wrappers.h"
 #include "pseries.h"
 
-#ifdef DEBUG
-#include <asm/udbg.h>
-#define DBG(fmt...) udbg_printf(fmt)
-#else
-#define DBG(fmt...)
-#endif
 
 /*
  * The primary thread of each non-boot processor is recorded here before
@@ -231,7 +225,7 @@ static void __init smp_init_pseries(void)
 {
 	int i;
 
-	DBG(" -> smp_init_pSeries()\n");
+	pr_debug(" -> smp_init_pSeries()\n");
 
 	/* Mark threads which are still spinning in hold loops. */
 	if (cpu_has_feature(CPU_FTR_SMT)) {
@@ -255,7 +249,7 @@ static void __init smp_init_pseries(void)
 		smp_ops->take_timebase = pSeries_take_timebase;
 	}
 
-	DBG(" <- smp_init_pSeries()\n");
+	pr_debug(" <- smp_init_pSeries()\n");
 }
 
 #ifdef CONFIG_MPIC
-- 
1.5.5
