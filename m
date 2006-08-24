Return-Path: <michael@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Thu, 24 Aug 2006 16:54:08 +1000
Subject: [PATCH] Split out vpa unregister logic from
	pseries_kexec_cpu_down_xics()
Message-Id: <20060824065409.645DD67C42@ozlabs.org>
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

As part of the new irq code pseries_kexec_cpu_down() was split into a
xics and mpic version. The vpa unregister logic is now only done in the
xics routine, and although that's ok in practice (we don't have SPLPAR
machines with mpic), I'd rather have the two concepts stay separate.

So move the vpa unregister into pseries_kexec_cpu_down(), which gets called
by both the xics and mpic routines. This also gives us an obvious place to
put any new kexec-down logic needed in future.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 arch/powerpc/platforms/pseries/setup.c |   18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

Index: to-merge/arch/powerpc/platforms/pseries/setup.c
===================================================================
--- to-merge.orig/arch/powerpc/platforms/pseries/setup.c
+++ to-merge/arch/powerpc/platforms/pseries/setup.c
@@ -223,12 +223,7 @@ static void pseries_lpar_enable_pmcs(voi
 }
 
 #ifdef CONFIG_KEXEC
-static void pseries_kexec_cpu_down_mpic(int crash_shutdown, int secondary)
-{
-	mpic_teardown_this_cpu(secondary);
-}
-
-static void pseries_kexec_cpu_down_xics(int crash_shutdown, int secondary)
+static void pseries_kexec_cpu_down(int crash_shutdown, int secondary)
 {
 	/* Don't risk a hypervisor call if we're crashing */
 	if (firmware_has_feature(FW_FEATURE_SPLPAR) && !crash_shutdown) {
@@ -248,6 +243,17 @@ static void pseries_kexec_cpu_down_xics(
 					hard_smp_processor_id());
 		}
 	}
+}
+
+static void pseries_kexec_cpu_down_mpic(int crash_shutdown, int secondary)
+{
+	pseries_kexec_cpu_down(crash_shutdown, secondary);
+	mpic_teardown_this_cpu(secondary);
+}
+
+static void pseries_kexec_cpu_down_xics(int crash_shutdown, int secondary)
+{
+	pseries_kexec_cpu_down(crash_shutdown, secondary);
 	xics_teardown_cpu(secondary);
 }
 #endif /* CONFIG_KEXEC */
