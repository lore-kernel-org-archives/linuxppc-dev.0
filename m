Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CBCA9B6F9C
	for <linuxppc-dev@ozlabs.org>; Sun, 11 Sep 2011 00:20:17 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 02/21] powerpc/smp: More generic support for "soft hotplug"
Date: Sat, 10 Sep 2011 11:19:49 -0300
Message-Id: <1315664408-16797-2-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1315664408-16797-1-git-send-email-benh@kernel.crashing.org>
References: <1315664408-16797-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This adds more generic support for doing CPU hotplug with a simple
idle loop and no actual reset of the processors. The generic
smp_generic_kick_cpu() does the hotplug bringup trick if the PACA
shows that the CPU has already been started at boot and we provide
an accessor for the CPU state.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/smp.h |    1 +
 arch/powerpc/kernel/smp.c      |   30 +++++++++++++++++++++++++-----
 2 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/smp.h b/arch/powerpc/include/asm/smp.h
index 15a70b7..adba970 100644
--- a/arch/powerpc/include/asm/smp.h
+++ b/arch/powerpc/include/asm/smp.h
@@ -65,6 +65,7 @@ int generic_cpu_disable(void);
 void generic_cpu_die(unsigned int cpu);
 void generic_mach_cpu_die(void);
 void generic_set_cpu_dead(unsigned int cpu);
+int generic_check_cpu_restart(unsigned int cpu);
 #endif
 
 #ifdef CONFIG_PPC64
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 7bf2187..af7e772 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -70,6 +70,10 @@
 static DEFINE_PER_CPU(struct task_struct *, idle_thread_array);
 #define get_idle_for_cpu(x)      (per_cpu(idle_thread_array, x))
 #define set_idle_for_cpu(x, p)   (per_cpu(idle_thread_array, x) = (p))
+
+/* State of each CPU during hotplug phases */
+static DEFINE_PER_CPU(int, cpu_state) = { 0 };
+
 #else
 static struct task_struct *idle_thread_array[NR_CPUS] __cpuinitdata ;
 #define get_idle_for_cpu(x)      (idle_thread_array[(x)])
@@ -104,12 +108,25 @@ int __devinit smp_generic_kick_cpu(int nr)
 	 * cpu_start field to become non-zero After we set cpu_start,
 	 * the processor will continue on to secondary_start
 	 */
-	paca[nr].cpu_start = 1;
-	smp_mb();
+	if (!paca[nr].cpu_start) {
+		paca[nr].cpu_start = 1;
+		smp_mb();
+		return 0;
+	}
+
+#ifdef CONFIG_HOTPLUG_CPU
+	/*
+	 * Ok it's not there, so it might be soft-unplugged, let's
+	 * try to bring it back
+	 */
+	per_cpu(cpu_state, nr) = CPU_UP_PREPARE;
+	smp_wmb();
+	smp_send_reschedule(nr);
+#endif /* CONFIG_HOTPLUG_CPU */
 
 	return 0;
 }
-#endif
+#endif /* CONFIG_PPC64 */
 
 static irqreturn_t call_function_action(int irq, void *data)
 {
@@ -357,8 +374,6 @@ void __devinit smp_prepare_boot_cpu(void)
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
-/* State of each CPU during hotplug phases */
-static DEFINE_PER_CPU(int, cpu_state) = { 0 };
 
 int generic_cpu_disable(void)
 {
@@ -406,6 +421,11 @@ void generic_set_cpu_dead(unsigned int cpu)
 {
 	per_cpu(cpu_state, cpu) = CPU_DEAD;
 }
+
+int generic_check_cpu_restart(unsigned int cpu)
+{
+	return per_cpu(cpu_state, cpu) == CPU_UP_PREPARE;
+}
 #endif
 
 struct create_idle {
-- 
1.7.4.1
