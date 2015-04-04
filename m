Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B047D1A084E
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 Apr 2015 19:28:53 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc: Drop return value of smp_ops->probe()
Date: Sat,  4 Apr 2015 19:28:50 +1100
Message-Id: <1428136130-4406-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

smp_ops->probe() is currently supposed to return the number of cpus in
the system.

The last actual usage of the value was removed in May 2007 in e147ec8f1808
"[POWERPC] Simplify smp_space_timers". We still passed the value around
until June 2010 when even that was finally removed in c1aa687d499a
"powerpc: Clean up obsolete code relating to decrementer and timebase".

So drop that requirement, probe() now returns void, and update all
implementations.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/smp.h         | 4 ++--
 arch/powerpc/include/asm/xics.h        | 2 +-
 arch/powerpc/platforms/cell/smp.c      | 9 +--------
 arch/powerpc/platforms/powermac/smp.c  | 8 +++-----
 arch/powerpc/platforms/ps3/smp.c       | 4 +---
 arch/powerpc/platforms/pseries/smp.c   | 6 ++----
 arch/powerpc/sysdev/mpic.c             | 4 +---
 arch/powerpc/sysdev/xics/xics-common.c | 4 +---
 8 files changed, 12 insertions(+), 29 deletions(-)

diff --git a/arch/powerpc/include/asm/smp.h b/arch/powerpc/include/asm/smp.h
index d607df5081a7..3e7d0abb402b 100644
--- a/arch/powerpc/include/asm/smp.h
+++ b/arch/powerpc/include/asm/smp.h
@@ -42,7 +42,7 @@ struct smp_ops_t {
 #ifdef CONFIG_PPC_SMP_MUXED_IPI
 	void  (*cause_ipi)(int cpu, unsigned long data);
 #endif
-	int   (*probe)(void);
+	void  (*probe)(void);
 	int   (*kick_cpu)(int nr);
 	void  (*setup_cpu)(int nr);
 	void  (*bringup_done)(void);
@@ -175,7 +175,7 @@ static inline void set_hard_smp_processor_id(int cpu, int phys)
 
 extern int smt_enabled_at_boot;
 
-extern int smp_mpic_probe(void);
+extern void smp_mpic_probe(void);
 extern void smp_mpic_setup_cpu(int cpu);
 extern int smp_generic_kick_cpu(int nr);
 extern int smp_generic_cpu_bootable(unsigned int nr);
diff --git a/arch/powerpc/include/asm/xics.h b/arch/powerpc/include/asm/xics.h
index 6997f4a271df..0e25bdb190bb 100644
--- a/arch/powerpc/include/asm/xics.h
+++ b/arch/powerpc/include/asm/xics.h
@@ -146,7 +146,7 @@ extern void xics_update_irq_servers(void);
 extern void xics_set_cpu_giq(unsigned int gserver, unsigned int join);
 extern void xics_mask_unknown_vec(unsigned int vec);
 extern irqreturn_t xics_ipi_dispatch(int cpu);
-extern int xics_smp_probe(void);
+extern void xics_smp_probe(void);
 extern void xics_register_ics(struct ics *ics);
 extern void xics_teardown_cpu(void);
 extern void xics_kexec_teardown_cpu(int secondary);
diff --git a/arch/powerpc/platforms/cell/smp.c b/arch/powerpc/platforms/cell/smp.c
index b64e7ead752f..895560f4be69 100644
--- a/arch/powerpc/platforms/cell/smp.c
+++ b/arch/powerpc/platforms/cell/smp.c
@@ -102,13 +102,6 @@ static inline int smp_startup_cpu(unsigned int lcpu)
 	return 1;
 }
 
-static int __init smp_iic_probe(void)
-{
-	iic_request_IPIs();
-
-	return num_possible_cpus();
-}
-
 static void smp_cell_setup_cpu(int cpu)
 {
 	if (cpu != boot_cpuid)
@@ -139,7 +132,7 @@ static int smp_cell_kick_cpu(int nr)
 
 static struct smp_ops_t bpa_iic_smp_ops = {
 	.message_pass	= iic_message_pass,
-	.probe		= smp_iic_probe,
+	.probe		= iic_request_IPIs,
 	.kick_cpu	= smp_cell_kick_cpu,
 	.setup_cpu	= smp_cell_setup_cpu,
 	.cpu_bootable	= smp_generic_cpu_bootable,
diff --git a/arch/powerpc/platforms/powermac/smp.c b/arch/powerpc/platforms/powermac/smp.c
index af094ae03dbb..f84ac7ee1107 100644
--- a/arch/powerpc/platforms/powermac/smp.c
+++ b/arch/powerpc/platforms/powermac/smp.c
@@ -268,7 +268,7 @@ static void __init psurge_quad_init(void)
 	mdelay(33);
 }
 
-static int __init smp_psurge_probe(void)
+static void __init smp_psurge_probe(void)
 {
 	int i, ncpus;
 	struct device_node *dn;
@@ -766,7 +766,7 @@ static void __init smp_core99_setup(int ncpus)
 		powersave_nap = 0;
 }
 
-static int __init smp_core99_probe(void)
+static void __init smp_core99_probe(void)
 {
 	struct device_node *cpus;
 	int ncpus = 0;
@@ -781,7 +781,7 @@ static int __init smp_core99_probe(void)
 
 	/* Nothing more to do if less than 2 of them */
 	if (ncpus <= 1)
-		return 1;
+		return;
 
 	/* We need to perform some early initialisations before we can start
 	 * setting up SMP as we are running before initcalls
@@ -797,8 +797,6 @@ static int __init smp_core99_probe(void)
 
 	/* Collect l2cr and l3cr values from CPU 0 */
 	core99_init_caches(0);
-
-	return ncpus;
 }
 
 static int smp_core99_kick_cpu(int nr)
diff --git a/arch/powerpc/platforms/ps3/smp.c b/arch/powerpc/platforms/ps3/smp.c
index b358bec6c8cb..3c7707af3384 100644
--- a/arch/powerpc/platforms/ps3/smp.c
+++ b/arch/powerpc/platforms/ps3/smp.c
@@ -57,7 +57,7 @@ static void ps3_smp_message_pass(int cpu, int msg)
 			" (%d)\n", __func__, __LINE__, cpu, msg, result);
 }
 
-static int __init ps3_smp_probe(void)
+static void __init ps3_smp_probe(void)
 {
 	int cpu;
 
@@ -100,8 +100,6 @@ static int __init ps3_smp_probe(void)
 
 		DBG(" <- %s:%d: (%d)\n", __func__, __LINE__, cpu);
 	}
-
-	return 2;
 }
 
 void ps3_smp_cleanup_cpu(int cpu)
diff --git a/arch/powerpc/platforms/pseries/smp.c b/arch/powerpc/platforms/pseries/smp.c
index a3555b10c1a5..6932ea803e33 100644
--- a/arch/powerpc/platforms/pseries/smp.c
+++ b/arch/powerpc/platforms/pseries/smp.c
@@ -197,16 +197,14 @@ static void pSeries_cause_ipi_mux(int cpu, unsigned long data)
 		xics_cause_ipi(cpu, data);
 }
 
-static __init int pSeries_smp_probe(void)
+static __init void pSeries_smp_probe(void)
 {
-	int ret = xics_smp_probe();
+	xics_smp_probe();
 
 	if (cpu_has_feature(CPU_FTR_DBELL)) {
 		xics_cause_ipi = smp_ops->cause_ipi;
 		smp_ops->cause_ipi = pSeries_cause_ipi_mux;
 	}
-
-	return ret;
 }
 
 static struct smp_ops_t pSeries_mpic_smp_ops = {
diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index f72b592d60cc..d4ca85fbebfe 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -1888,7 +1888,7 @@ void smp_mpic_message_pass(int cpu, int msg)
 		       msg * MPIC_INFO(CPU_IPI_DISPATCH_STRIDE), physmask);
 }
 
-int __init smp_mpic_probe(void)
+void __init smp_mpic_probe(void)
 {
 	int nr_cpus;
 
@@ -1900,8 +1900,6 @@ int __init smp_mpic_probe(void)
 
 	if (nr_cpus > 1)
 		mpic_request_ipis();
-
-	return nr_cpus;
 }
 
 void smp_mpic_setup_cpu(int cpu)
diff --git a/arch/powerpc/sysdev/xics/xics-common.c b/arch/powerpc/sysdev/xics/xics-common.c
index 125743b58c70..878a54036a25 100644
--- a/arch/powerpc/sysdev/xics/xics-common.c
+++ b/arch/powerpc/sysdev/xics/xics-common.c
@@ -140,15 +140,13 @@ static void xics_request_ipi(void)
 			   IRQF_PERCPU | IRQF_NO_THREAD, "IPI", NULL));
 }
 
-int __init xics_smp_probe(void)
+void __init xics_smp_probe(void)
 {
 	/* Setup cause_ipi callback  based on which ICP is used */
 	smp_ops->cause_ipi = icp_ops->cause_ipi;
 
 	/* Register all the IPIs */
 	xics_request_ipi();
-
-	return num_possible_cpus();
 }
 
 #endif /* CONFIG_SMP */
-- 
2.1.0
