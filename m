Return-Path: <michael@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Thu, 08 Feb 2007 18:33:55 +1100
Subject: [PATCH 2/4] Cleanup pseries smp initialisation code
In-Reply-To: <1170920031.184014.219881150011.qpush@cradle>
Message-Id: <20070208073354.2A398DDE30@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Move some extern declarations from setup.c into the new pseries.h.
While we're at it, provide dummy implementations for !SMP, to avoid
cluttering the C file with more #ifdefs.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 arch/powerpc/platforms/pseries/pseries.h |    8 ++++++++
 arch/powerpc/platforms/pseries/setup.c   |    6 ------
 arch/powerpc/platforms/pseries/smp.c     |    1 +
 3 files changed, 9 insertions(+), 6 deletions(-)

Index: powerpc/arch/powerpc/platforms/pseries/pseries.h
===================================================================
--- powerpc.orig/arch/powerpc/platforms/pseries/pseries.h
+++ powerpc/arch/powerpc/platforms/pseries/pseries.h
@@ -17,4 +17,12 @@ struct pt_regs;
 extern int pSeries_system_reset_exception(struct pt_regs *regs);
 extern int pSeries_machine_check_exception(struct pt_regs *regs);
 
+#ifdef CONFIG_SMP
+extern void smp_init_pseries_mpic(void);
+extern void smp_init_pseries_xics(void);
+#else
+static inline smp_init_pseries_mpic(void) { };
+static inline smp_init_pseries_xics(void) { };
+#endif
+
 #endif /* _PSERIES_PSERIES_H */
Index: powerpc/arch/powerpc/platforms/pseries/setup.c
===================================================================
--- powerpc.orig/arch/powerpc/platforms/pseries/setup.c
+++ powerpc/arch/powerpc/platforms/pseries/setup.c
@@ -77,8 +77,6 @@
 #endif
 
 /* move those away to a .h */
-extern void smp_init_pseries_mpic(void);
-extern void smp_init_pseries_xics(void);
 extern void find_udbg_vterm(void);
 
 int fwnmi_active;  /* TRUE if an FWNMI handler is present */
@@ -272,18 +270,14 @@ static void __init pseries_discover_pic(
 #ifdef CONFIG_KEXEC
 			ppc_md.kexec_cpu_down = pseries_kexec_cpu_down_mpic;
 #endif
-#ifdef CONFIG_SMP
 			smp_init_pseries_mpic();
-#endif
 			return;
 		} else if (strstr(typep, "ppc-xicp")) {
 			ppc_md.init_IRQ       = xics_init_IRQ;
 #ifdef CONFIG_KEXEC
 			ppc_md.kexec_cpu_down = pseries_kexec_cpu_down_xics;
 #endif
-#ifdef CONFIG_SMP
 			smp_init_pseries_xics();
-#endif
 			return;
 		}
 	}
Index: powerpc/arch/powerpc/platforms/pseries/smp.c
===================================================================
--- powerpc.orig/arch/powerpc/platforms/pseries/smp.c
+++ powerpc/arch/powerpc/platforms/pseries/smp.c
@@ -48,6 +48,7 @@
 #include <asm/vdso_datapage.h>
 
 #include "plpar_wrappers.h"
+#include "pseries.h"
 
 #ifdef DEBUG
 #include <asm/udbg.h>
