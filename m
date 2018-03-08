Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zxZql2175zF1kr
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Mar 2018 13:54:59 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: npiggin@gmail.com
Subject: [PATCH 3/4] powerpc: Rename plapr routines to plpar
Date: Thu,  8 Mar 2018 13:54:41 +1100
Message-Id: <20180308025442.6165-3-mpe@ellerman.id.au>
In-Reply-To: <20180308025442.6165-1-mpe@ellerman.id.au>
References: <20180308025442.6165-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Back in 2013 we added some hypercall wrappers which misspelled
"plpar" (P-series Logical PARtition) as "plapr".

Visually they're hard to distinguish and it almost doesn't matter, but
it is confusing when grepping to miss some calls because of the typo.

They've also started spreading, so before they take over let's fix
them all to be "plpar".

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/plpar_wrappers.h | 6 +++---
 arch/powerpc/platforms/pseries/setup.c    | 2 +-
 arch/powerpc/platforms/pseries/smp.c      | 2 +-
 arch/powerpc/xmon/xmon.c                  | 4 ++--
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/plpar_wrappers.h b/arch/powerpc/include/asm/plpar_wrappers.h
index 09cb26816b2d..9233b84f489a 100644
--- a/arch/powerpc/include/asm/plpar_wrappers.h
+++ b/arch/powerpc/include/asm/plpar_wrappers.h
@@ -305,17 +305,17 @@ static inline long enable_little_endian_exceptions(void)
 	return plpar_set_mode(1, H_SET_MODE_RESOURCE_LE, 0, 0);
 }
 
-static inline long plapr_set_ciabr(unsigned long ciabr)
+static inline long plpar_set_ciabr(unsigned long ciabr)
 {
 	return plpar_set_mode(0, H_SET_MODE_RESOURCE_SET_CIABR, ciabr, 0);
 }
 
-static inline long plapr_set_watchpoint0(unsigned long dawr0, unsigned long dawrx0)
+static inline long plpar_set_watchpoint0(unsigned long dawr0, unsigned long dawrx0)
 {
 	return plpar_set_mode(0, H_SET_MODE_RESOURCE_SET_DAWR, dawr0, dawrx0);
 }
 
-static inline long plapr_signal_sys_reset(long cpu)
+static inline long plpar_signal_sys_reset(long cpu)
 {
 	return plpar_hcall_norets(H_SIGNAL_SYS_RESET, cpu);
 }
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 8ef396dd11ca..60b608eb8fed 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -739,7 +739,7 @@ static int pseries_set_dawr(unsigned long dawr, unsigned long dawrx)
 	/* PAPR says we can't set HYP */
 	dawrx &= ~DAWRX_HYP;
 
-	return  plapr_set_watchpoint0(dawr, dawrx);
+	return  plpar_set_watchpoint0(dawr, dawrx);
 }
 
 #define CMO_CHARACTERISTICS_TOKEN 44
diff --git a/arch/powerpc/platforms/pseries/smp.c b/arch/powerpc/platforms/pseries/smp.c
index d506bf661f0f..3df46123cce3 100644
--- a/arch/powerpc/platforms/pseries/smp.c
+++ b/arch/powerpc/platforms/pseries/smp.c
@@ -215,7 +215,7 @@ static int pseries_cause_nmi_ipi(int cpu)
 		hwcpu = get_hard_smp_processor_id(cpu);
 	}
 
-	if (plapr_signal_sys_reset(hwcpu) == H_SUCCESS)
+	if (plpar_signal_sys_reset(hwcpu) == H_SUCCESS)
 		return 1;
 
 	return 0;
diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index b6574b6f7d4a..ecbb34eb1ddf 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -64,7 +64,7 @@
 #if defined(CONFIG_PPC_SPLPAR)
 #include <asm/plpar_wrappers.h>
 #else
-static inline long plapr_set_ciabr(unsigned long ciabr) {return 0; };
+static inline long plpar_set_ciabr(unsigned long ciabr) {return 0; };
 #endif
 
 #include "nonstdio.h"
@@ -328,7 +328,7 @@ static void write_ciabr(unsigned long ciabr)
 		mtspr(SPRN_CIABR, ciabr);
 		return;
 	}
-	plapr_set_ciabr(ciabr);
+	plpar_set_ciabr(ciabr);
 }
 
 /**
-- 
2.14.1
