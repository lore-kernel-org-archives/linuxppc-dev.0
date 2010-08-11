Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: benh@kernel.crashing.org
MIME-Version: 1.0
Subject: [PATCH] powerpc: move arch_sd_sibling_asym_packing() to smp.c
Date: Wed, 11 Aug 2010 16:02:05 +1000
Message-ID: <10670.1281506525@neuling.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Simple cleanup by moving arch_sd_sibling_asym_packing from process.c to
smp.c to save an #ifdef CONFIG_SMP

No functionality change.  

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/kernel/process.c |   11 -----------
 arch/powerpc/kernel/smp.c     |    9 +++++++++
 2 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index e78a5ad..551f671 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1299,14 +1299,3 @@ unsigned long randomize_et_dyn(unsigned long base)
 
 	return ret;
 }
-
-#ifdef CONFIG_SMP
-int arch_sd_sibling_asym_packing(void)
-{
-	if (cpu_has_feature(CPU_FTR_ASYM_SMT)) {
-		printk_once(KERN_INFO "Enabling Asymmetric SMT scheduling\n");
-		return SD_ASYM_PACKING;
-	}
-	return 0;
-}
-#endif
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index a61b3dd..41be244 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -580,6 +580,15 @@ void __init smp_cpus_done(unsigned int max_cpus)
 	dump_numa_cpu_topology();
 }
 
+int arch_sd_sibling_asym_packing(void)
+{
+	if (cpu_has_feature(CPU_FTR_ASYM_SMT)) {
+		printk_once(KERN_INFO "Enabling Asymmetric SMT scheduling\n");
+		return SD_ASYM_PACKING;
+	}
+	return 0;
+}
+
 #ifdef CONFIG_HOTPLUG_CPU
 int __cpu_disable(void)
 {
