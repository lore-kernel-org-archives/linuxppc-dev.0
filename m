Return-Path: <B35336@freescale.com>
Received: from VA3EHSOBE010.bigfish.com (va3ehsobe010.messaging.microsoft.com
 [216.32.180.30]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 72B24B715F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Dec 2011 22:43:26 +1100 (EST)
Received: from mail103-va3 (localhost [127.0.0.1])	by
 mail103-va3-R.bigfish.com (Postfix) with ESMTP id C988C1C028B	for
 <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Dec 2011 11:43:17 +0000 (UTC)
Received: from VA3EHSMHS012.bigfish.com (unknown [10.7.14.237])	by
 mail103-va3.bigfish.com (Postfix) with ESMTP id 2D79460045	for
 <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Dec 2011 11:43:17 +0000 (UTC)
From: Zhao Chenhui <chenhui.zhao@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH v3 1/4] powerpc/85xx: add HOTPLUG_CPU support
Date: Thu, 22 Dec 2011 19:43:31 +0800
Message-ID: <1324554214-19502-1-git-send-email-chenhui.zhao@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Li Yang <leoli@freescale.com>

Add support to disable and re-enable individual cores at runtime
on MPC85xx/QorIQ SMP machines. Currently support e500v1/e500v2 core.

MPC85xx machines use ePAPR spin-table in boot page for CPU kick-off.
This patch uses the boot page from bootloader to boot core at runtime.
It supports 32-bit and 36-bit physical address.

Add generic_set_cpu_up() to set cpu_state as CPU_UP_PREPARE in kick_cpu().

Signed-off-by: Li Yang <leoli@freescale.com>
Signed-off-by: Jin Qing <b24347@freescale.com>
Signed-off-by: Zhao Chenhui <chenhui.zhao@freescale.com>
---
changes for v3
 * Move "out_be32(&spin_table->pir, hw_cpu)" after core reset.
 * Keep the default value of the BPTR register. Don't change it.
 * Merge the timebase patch.
 * Don't support e500mc for HOTPLUG_CPU.

 arch/powerpc/Kconfig                  |    5 +-
 arch/powerpc/include/asm/cacheflush.h |    2 +
 arch/powerpc/include/asm/smp.h        |    2 +
 arch/powerpc/kernel/head_fsl_booke.S  |   28 +++++++
 arch/powerpc/kernel/smp.c             |   10 +++
 arch/powerpc/platforms/85xx/smp.c     |  145 +++++++++++++++++++++++++--------
 6 files changed, 154 insertions(+), 38 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 7c93c7e..bf942b1 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -213,7 +213,7 @@ config ARCH_HIBERNATION_POSSIBLE
 config ARCH_SUSPEND_POSSIBLE
 	def_bool y
 	depends on ADB_PMU || PPC_EFIKA || PPC_LITE5200 || PPC_83xx || \
-		   (PPC_85xx && !SMP) || PPC_86xx || PPC_PSERIES || 44x || 40x
+		   PPC_85xx || PPC_86xx || PPC_PSERIES || 44x || 40x
 
 config PPC_DCR_NATIVE
 	bool
@@ -324,7 +324,8 @@ config SWIOTLB
 
 config HOTPLUG_CPU
 	bool "Support for enabling/disabling CPUs"
-	depends on SMP && HOTPLUG && EXPERIMENTAL && (PPC_PSERIES || PPC_PMAC || PPC_POWERNV)
+	depends on SMP && HOTPLUG && EXPERIMENTAL && (PPC_PSERIES || \
+		PPC_PMAC || PPC_POWERNV || (E500 && !PPC_E500MC))
 	---help---
 	  Say Y here to be able to disable and re-enable individual
 	  CPUs at runtime on SMP machines.
diff --git a/arch/powerpc/include/asm/cacheflush.h b/arch/powerpc/include/asm/cacheflush.h
index ab9e402..dd41442 100644
--- a/arch/powerpc/include/asm/cacheflush.h
+++ b/arch/powerpc/include/asm/cacheflush.h
@@ -30,6 +30,8 @@ extern void flush_dcache_page(struct page *page);
 #define flush_dcache_mmap_lock(mapping)		do { } while (0)
 #define flush_dcache_mmap_unlock(mapping)	do { } while (0)
 
+extern void flush_disable_L1(void);
+
 extern void __flush_icache_range(unsigned long, unsigned long);
 static inline void flush_icache_range(unsigned long start, unsigned long stop)
 {
diff --git a/arch/powerpc/include/asm/smp.h b/arch/powerpc/include/asm/smp.h
index adba970..7517863 100644
--- a/arch/powerpc/include/asm/smp.h
+++ b/arch/powerpc/include/asm/smp.h
@@ -65,6 +65,7 @@ int generic_cpu_disable(void);
 void generic_cpu_die(unsigned int cpu);
 void generic_mach_cpu_die(void);
 void generic_set_cpu_dead(unsigned int cpu);
+void generic_set_cpu_up(unsigned int cpu);
 int generic_check_cpu_restart(unsigned int cpu);
 #endif
 
@@ -191,6 +192,7 @@ extern unsigned long __secondary_hold_spinloop;
 extern unsigned long __secondary_hold_acknowledge;
 extern char __secondary_hold;
 
+extern void __early_start(void);
 #endif /* __ASSEMBLY__ */
 
 #endif /* __KERNEL__ */
diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
index 9f5d210..1d93272 100644
--- a/arch/powerpc/kernel/head_fsl_booke.S
+++ b/arch/powerpc/kernel/head_fsl_booke.S
@@ -1004,6 +1004,34 @@ _GLOBAL(flush_dcache_L1)
 
 	blr
 
+/* Flush L1 d-cache, invalidate and disable d-cache and i-cache */
+_GLOBAL(flush_disable_L1)
+	mflr	r10
+	bl	flush_dcache_L1	/* Flush L1 d-cache */
+	mtlr	r10
+
+	mfspr	r4, SPRN_L1CSR0	/* Invalidate and disable d-cache */
+	li	r5, 2
+	rlwimi	r4, r5, 0, 3
+
+	msync
+	isync
+	mtspr	SPRN_L1CSR0, r4
+	isync
+
+1:	mfspr	r4, SPRN_L1CSR0	/* Wait for the invalidate to finish */
+	andi.	r4, r4, 2
+	bne	1b
+
+	mfspr	r4, SPRN_L1CSR1	/* Invalidate and disable i-cache */
+	li	r5, 2
+	rlwimi	r4, r5, 0, 3
+
+	mtspr	SPRN_L1CSR1, r4
+	isync
+
+	blr
+
 #ifdef CONFIG_SMP
 /* When we get here, r24 needs to hold the CPU # */
 	.globl __secondary_start
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index f0abe92..7b675bb 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -423,6 +423,16 @@ void generic_set_cpu_dead(unsigned int cpu)
 	per_cpu(cpu_state, cpu) = CPU_DEAD;
 }
 
+/*
+ * The cpu_state should be set to CPU_UP_PREPARE in kick_cpu(), otherwise
+ * the cpu_state is always CPU_DEAD after calling generic_set_cpu_dead(),
+ * which makes the delay in generic_cpu_die() not happen.
+ */
+void generic_set_cpu_up(unsigned int cpu)
+{
+	per_cpu(cpu_state, cpu) = CPU_UP_PREPARE;
+}
+
 int generic_check_cpu_restart(unsigned int cpu)
 {
 	return per_cpu(cpu_state, cpu) == CPU_UP_PREPARE;
diff --git a/arch/powerpc/platforms/85xx/smp.c b/arch/powerpc/platforms/85xx/smp.c
index 2df4785..2bff696 100644
--- a/arch/powerpc/platforms/85xx/smp.c
+++ b/arch/powerpc/platforms/85xx/smp.c
@@ -17,6 +17,7 @@
 #include <linux/of.h>
 #include <linux/kexec.h>
 #include <linux/highmem.h>
+#include <linux/cpu.h>
 
 #include <asm/machdep.h>
 #include <asm/pgtable.h>
@@ -28,28 +29,58 @@
 #include <sysdev/fsl_soc.h>
 #include <sysdev/mpic.h>
 
-extern void __early_start(void);
-
-#define BOOT_ENTRY_ADDR_UPPER	0
-#define BOOT_ENTRY_ADDR_LOWER	1
-#define BOOT_ENTRY_R3_UPPER	2
-#define BOOT_ENTRY_R3_LOWER	3
-#define BOOT_ENTRY_RESV		4
-#define BOOT_ENTRY_PIR		5
-#define BOOT_ENTRY_R6_UPPER	6
-#define BOOT_ENTRY_R6_LOWER	7
-#define NUM_BOOT_ENTRY		8
-#define SIZE_BOOT_ENTRY		(NUM_BOOT_ENTRY * sizeof(u32))
-
-static int __init
-smp_85xx_kick_cpu(int nr)
+struct epapr_spin_table {
+	u32	addr_h;
+	u32	addr_l;
+	u32	r3_h;
+	u32	r3_l;
+	u32	reserved;
+	u32	pir;
+};
+
+static void __cpuinit smp_85xx_setup_cpu(int cpu_nr);
+
+#ifdef CONFIG_HOTPLUG_CPU
+static void __cpuinit smp_85xx_mach_cpu_die(void)
+{
+	unsigned int cpu = smp_processor_id();
+	register u32 tmp;
+
+	local_irq_disable();
+	idle_task_exit();
+	generic_set_cpu_dead(cpu);
+	mb();
+
+	mtspr(SPRN_TCR, 0);
+
+	flush_disable_L1();
+	tmp = (mfspr(SPRN_HID0) & ~(HID0_DOZE|HID0_SLEEP)) | HID0_NAP;
+	mb();
+	isync();
+	mtspr(SPRN_HID0, tmp);
+	isync();
+
+	/* Enter NAP mode. */
+	tmp = mfmsr();
+	tmp |= MSR_WE;
+	mb();
+	mtmsr(tmp);
+	isync();
+
+	for (;;);
+}
+#endif
+
+static int __cpuinit smp_85xx_kick_cpu(int nr)
+
 {
 	unsigned long flags;
 	const u64 *cpu_rel_addr;
-	__iomem u32 *bptr_vaddr;
+	__iomem struct epapr_spin_table *spin_table;
 	struct device_node *np;
 	int n = 0, hw_cpu = get_hard_smp_processor_id(nr);
 	int ioremappable;
+	int ret = 0;
 
 	WARN_ON(nr < 0 || nr >= NR_CPUS);
 	WARN_ON(hw_cpu < 0 || hw_cpu >= NR_CPUS);
@@ -60,7 +91,8 @@ smp_85xx_kick_cpu(int nr)
 	cpu_rel_addr = of_get_property(np, "cpu-release-addr", NULL);
 
 	if (cpu_rel_addr == NULL) {
-		printk(KERN_ERR "No cpu-release-addr for cpu %d\n", nr);
+		pr_err("%s: No cpu-release-addr for cpu %d\n",
+					__func__, nr);
 		return -ENOENT;
 	}
 
@@ -74,50 +106,89 @@ smp_85xx_kick_cpu(int nr)
 
 	/* Map the spin table */
 	if (ioremappable)
-		bptr_vaddr = ioremap(*cpu_rel_addr, SIZE_BOOT_ENTRY);
+		spin_table = ioremap(*cpu_rel_addr,
+				sizeof(struct epapr_spin_table));
 	else
-		bptr_vaddr = phys_to_virt(*cpu_rel_addr);
+		spin_table = phys_to_virt(*cpu_rel_addr);
 
 	local_irq_save(flags);
-
-	out_be32(bptr_vaddr + BOOT_ENTRY_PIR, hw_cpu);
 #ifdef CONFIG_PPC32
-	out_be32(bptr_vaddr + BOOT_ENTRY_ADDR_LOWER, __pa(__early_start));
+#ifdef CONFIG_HOTPLUG_CPU
+	/* Corresponding to generic_set_cpu_dead() */
+	generic_set_cpu_up(nr);
+
+	if (system_state == SYSTEM_RUNNING) {
+		out_be32(&spin_table->addr_l, 0);
+
+		/*
+		 * We don't set the BPTR register here upon it points
+		 * to the boot page properly.
+		 */
+		mpic_reset_core(hw_cpu);
+
+		/* wait until core is ready... */
+		n = 0;
+		while ((in_be32(&spin_table->addr_l) != 1) && (++n < 1000))
+			udelay(100);
+		if (n >= 1000) {
+			pr_err("%s: timeout waiting for core %d to reset\n",
+							__func__, hw_cpu);
+			ret = -ENOENT;
+			goto out;
+		}
+		/*  clear the acknowledge status */
+		__secondary_hold_acknowledge = -1;
+	}
+#endif
+	out_be32(&spin_table->pir, hw_cpu);
+	out_be32(&spin_table->addr_l, __pa(__early_start));
 
 	if (!ioremappable)
-		flush_dcache_range((ulong)bptr_vaddr,
-				(ulong)(bptr_vaddr + SIZE_BOOT_ENTRY));
+		flush_dcache_range((ulong)spin_table,
+			(ulong)spin_table + sizeof(struct epapr_spin_table));
 
 	/* Wait a bit for the CPU to ack. */
+	n = 0;
 	while ((__secondary_hold_acknowledge != hw_cpu) && (++n < 1000))
 		mdelay(1);
+	if (n >= 1000) {
+		pr_err("%s: timeout waiting for core %d to ack\n",
+						__func__, hw_cpu);
+		ret = -ENOENT;
+		goto out;
+	}
+out:
 #else
 	smp_generic_kick_cpu(nr);
 
-	out_be64((u64 *)(bptr_vaddr + BOOT_ENTRY_ADDR_UPPER),
-		__pa((u64)*((unsigned long long *) generic_secondary_smp_init)));
+	out_be32(&spin_table->pir, hw_cpu);
+	out_be64((u64 *)(&spin_table->addr_h),
+	  __pa((u64)*((unsigned long long *)generic_secondary_smp_init)));
 
 	if (!ioremappable)
-		flush_dcache_range((ulong)bptr_vaddr,
-				(ulong)(bptr_vaddr + SIZE_BOOT_ENTRY));
+		flush_dcache_range((ulong)spin_table,
+			(ulong)spin_table + sizeof(struct epapr_spin_table));
 #endif
 
 	local_irq_restore(flags);
 
 	if (ioremappable)
-		iounmap(bptr_vaddr);
+		iounmap(spin_table);
 
 	pr_debug("waited %d msecs for CPU #%d.\n", n, nr);
 
-	return 0;
+	return ret;
 }
 
 struct smp_ops_t smp_85xx_ops = {
 	.kick_cpu = smp_85xx_kick_cpu,
-#ifdef CONFIG_KEXEC
+	.setup_cpu	= smp_85xx_setup_cpu,
+#ifdef CONFIG_HOTPLUG_CPU
+	.cpu_disable	= generic_cpu_disable,
+	.cpu_die	= generic_cpu_die,
+#endif
 	.give_timebase	= smp_generic_give_timebase,
 	.take_timebase	= smp_generic_take_timebase,
-#endif
 };
 
 #ifdef CONFIG_KEXEC
@@ -217,8 +288,7 @@ static void mpc85xx_smp_machine_kexec(struct kimage *image)
 }
 #endif /* CONFIG_KEXEC */
 
-static void __init
-smp_85xx_setup_cpu(int cpu_nr)
+static void __cpuinit smp_85xx_setup_cpu(int cpu_nr)
 {
 	if (smp_85xx_ops.probe == smp_mpic_probe)
 		mpic_setup_this_cpu();
@@ -231,13 +301,12 @@ void __init mpc85xx_smp_init(void)
 {
 	struct device_node *np;
 
-	smp_85xx_ops.setup_cpu = smp_85xx_setup_cpu;
-
 	np = of_find_node_by_type(NULL, "open-pic");
 	if (np) {
 		smp_85xx_ops.probe = smp_mpic_probe;
 		smp_85xx_ops.message_pass = smp_mpic_message_pass;
 	}
+	of_node_put(np);
 
 	if (cpu_has_feature(CPU_FTR_DBELL)) {
 		/*
@@ -248,6 +317,10 @@ void __init mpc85xx_smp_init(void)
 		smp_85xx_ops.cause_ipi = doorbell_cause_ipi;
 	}
 
+#ifdef CONFIG_HOTPLUG_CPU
+	ppc_md.cpu_die		= smp_85xx_mach_cpu_die;
+#endif
+
 	smp_ops = &smp_85xx_ops;
 
 #ifdef CONFIG_KEXEC
-- 
1.6.4.1
