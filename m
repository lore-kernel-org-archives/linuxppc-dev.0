Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 18 Aug 2008 14:23:48 +1000
Subject: [PATCH 1/2] powerpc: Turn get/set_hard_smp_proccessor_id into inlines
Message-Id: <20080818042422.1283BDDE1D@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

They don't need to be macros, and having them as inline
functions avoids warnings about unused variables on some
configurations when the argument isn't evaluated.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/include/asm/smp.h |   39 +++++++++++++++++++++++++++++----------
 1 file changed, 29 insertions(+), 10 deletions(-)

--- linux-work.orig/arch/powerpc/include/asm/smp.h	2008-08-18 11:57:47.000000000 +1000
+++ linux-work/arch/powerpc/include/asm/smp.h	2008-08-18 12:03:55.000000000 +1000
@@ -56,9 +56,16 @@ extern int smp_hw_index[];
 
 #define raw_smp_processor_id()	(current_thread_info()->cpu)
 #define hard_smp_processor_id() 	(smp_hw_index[smp_processor_id()])
-#define get_hard_smp_processor_id(cpu)	(smp_hw_index[(cpu)])
-#define set_hard_smp_processor_id(cpu, phys)\
-					(smp_hw_index[(cpu)] = (phys))
+
+static inline int get_hard_smp_processor_id(int cpu)
+{
+	return smp_hw_index[cpu];
+}
+
+static inline void set_hard_smp_processor_id(int cpu, int phys)
+{
+	smp_hw_index[cpu] = phys;
+}
 #endif
 
 DECLARE_PER_CPU(cpumask_t, cpu_sibling_map);
@@ -92,9 +99,15 @@ extern void __cpu_die(unsigned int cpu);
 #endif /* CONFIG_SMP */
 
 #ifdef CONFIG_PPC64
-#define get_hard_smp_processor_id(CPU) (paca[(CPU)].hw_cpu_id)
-#define set_hard_smp_processor_id(CPU, VAL) \
-	do { (paca[(CPU)].hw_cpu_id = (VAL)); } while (0)
+static inline int get_hard_smp_processor_id(int cpu)
+{
+	return paca[cpu].hw_cpu_id;
+}
+
+static inline void set_hard_smp_processor_id(int cpu, int phys)
+{
+	paca[cpu].hw_cpu_id = phys;
+}
 
 extern void smp_release_cpus(void);
 
@@ -102,10 +115,16 @@ extern void smp_release_cpus(void);
 /* 32-bit */
 #ifndef CONFIG_SMP
 extern int boot_cpuid_phys;
-#define get_hard_smp_processor_id(cpu) 	boot_cpuid_phys
-#define set_hard_smp_processor_id(cpu, phys)
-#endif
-#endif
+static inline int get_hard_smp_processor_id(int cpu)
+{
+	return boot_cpuid_phys;
+}
+
+static inline void set_hard_smp_processor_id(int cpu, int phys)
+{
+}
+#endif /* !CONFIG_SMP */
+#endif /* !CONFIG_PPC64 */
 
 extern int smt_enabled_at_boot;
 
