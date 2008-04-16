Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <0709e3bcb1c8a4341b474f530c1823d2735d26ce.1208317906.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 1/2] Move prototype for find_udbg_vterm() into a header file
Date: Wed, 16 Apr 2008 13:51:48 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Move the prototype for find_udbg_vterm() into pseries.h, removing
it from setup.c

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/platforms/pseries/lpar.c    |    1 +
 arch/powerpc/platforms/pseries/pseries.h |    2 ++
 arch/powerpc/platforms/pseries/setup.c   |    3 ---
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index 233d9be..8a20452 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -40,6 +40,7 @@
 #include <asm/smp.h>
 
 #include "plpar_wrappers.h"
+#include "pseries.h"
 
 #ifdef DEBUG_LOW
 #define DBG_LOW(fmt...) do { udbg_printf(fmt); } while(0)
diff --git a/arch/powerpc/platforms/pseries/pseries.h b/arch/powerpc/platforms/pseries/pseries.h
index 61136d0..9e17c0d 100644
--- a/arch/powerpc/platforms/pseries/pseries.h
+++ b/arch/powerpc/platforms/pseries/pseries.h
@@ -38,4 +38,6 @@ extern void pSeries_final_fixup(void);
 /* Poweron flag used for enabling auto ups restart */
 extern unsigned long rtas_poweron_auto;
 
+extern void find_udbg_vterm(void);
+
 #endif /* _PSERIES_PSERIES_H */
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 90555a3..fccca89 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -76,9 +76,6 @@
 #define DBG(fmt...)
 #endif
 
-/* move those away to a .h */
-extern void find_udbg_vterm(void);
-
 int fwnmi_active;  /* TRUE if an FWNMI handler is present */
 
 static void pseries_shared_idle_sleep(void);
-- 
1.5.5
