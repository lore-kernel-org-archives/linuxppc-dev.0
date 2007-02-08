Return-Path: <michael@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Thu, 08 Feb 2007 18:34:04 +1100
Subject: [PATCH 4/4] Move MPIC smp routines into mpic.c
In-Reply-To: <1170920031.184014.219881150011.qpush@cradle>
Message-Id: <20070208073407.1FB33DDF0A@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Move a couple of MPIC smp routines into mpic.c, they're inside an SMP
block in mpic.c - so they're still only built for SMP.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 arch/powerpc/kernel/smp.c  |   23 -----------------------
 arch/powerpc/sysdev/mpic.c |   21 +++++++++++++++++++++
 2 files changed, 21 insertions(+), 23 deletions(-)

Index: powerpc/arch/powerpc/kernel/smp.c
===================================================================
--- powerpc.orig/arch/powerpc/kernel/smp.c
+++ powerpc/arch/powerpc/kernel/smp.c
@@ -78,29 +78,6 @@ int smt_enabled_at_boot = 1;
 
 static void (*crash_ipi_function_ptr)(struct pt_regs *) = NULL;
 
-#ifdef CONFIG_MPIC
-int __init smp_mpic_probe(void)
-{
-	int nr_cpus;
-
-	DBG("smp_mpic_probe()...\n");
-
-	nr_cpus = cpus_weight(cpu_possible_map);
-
-	DBG("nr_cpus: %d\n", nr_cpus);
-
-	if (nr_cpus > 1)
-		mpic_request_ipis();
-
-	return nr_cpus;
-}
-
-void __devinit smp_mpic_setup_cpu(int cpu)
-{
-	mpic_setup_this_cpu();
-}
-#endif /* CONFIG_MPIC */
-
 #ifdef CONFIG_PPC64
 void __devinit smp_generic_kick_cpu(int nr)
 {
Index: powerpc/arch/powerpc/sysdev/mpic.c
===================================================================
--- powerpc.orig/arch/powerpc/sysdev/mpic.c
+++ powerpc/arch/powerpc/sysdev/mpic.c
@@ -1375,4 +1375,25 @@ void smp_mpic_message_pass(int target, i
 		break;
 	}
 }
+
+int __init smp_mpic_probe(void)
+{
+	int nr_cpus;
+
+	DBG("smp_mpic_probe()...\n");
+
+	nr_cpus = cpus_weight(cpu_possible_map);
+
+	DBG("nr_cpus: %d\n", nr_cpus);
+
+	if (nr_cpus > 1)
+		mpic_request_ipis();
+
+	return nr_cpus;
+}
+
+void __devinit smp_mpic_setup_cpu(int cpu)
+{
+	mpic_setup_this_cpu();
+}
 #endif /* CONFIG_SMP */
