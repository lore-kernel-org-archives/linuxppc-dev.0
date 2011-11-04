Return-Path: <B35336@freescale.com>
Received: from DB3EHSOBE004.bigfish.com (db3ehsobe004.messaging.microsoft.com
 [213.199.154.142])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id ECA2FB6F89
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Nov 2011 23:31:35 +1100 (EST)
Received: from mail97-db3 (localhost.localdomain [127.0.0.1])	by
 mail97-db3-R.bigfish.com (Postfix) with ESMTP id 4A20910A8442	for
 <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Nov 2011 12:31:22 +0000 (UTC)
Received: from DB3EHSMHS004.bigfish.com (unknown [10.3.81.251])	by
 mail97-db3.bigfish.com (Postfix) with ESMTP id BCE34EF0052	for
 <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Nov 2011 12:31:21 +0000 (UTC)
From: Zhao Chenhui <chenhui.zhao@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 2/7] powerpc/85xx: add HOTPLUG_CPU support
Date: Fri, 4 Nov 2011 20:31:29 +0800
Message-ID: <1320409889-14408-1-git-send-email-chenhui.zhao@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: chenhui.zhao@freescale.com
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
on MPC85xx/QorIQ SMP machines. Currently support e500 core.

MPC85xx machines use ePAPR spin-table in boot page for CPU kick-off.
This patch uses the boot page from bootloader to boot core at runtime.
It supports 32-bit and 36-bit physical address.

Add delay in generic_cpu_die() to wait core reset.

Signed-off-by: Li Yang <leoli@freescale.com>
Signed-off-by: Jin Qing <b24347@freescale.com>
Signed-off-by: Zhao Chenhui <chenhui.zhao@freescale.com>
---
 arch/powerpc/Kconfig                 |    5 +-
 arch/powerpc/kernel/head_fsl_booke.S |   28 +++++
 arch/powerpc/kernel/smp.c            |    8 +-
 arch/powerpc/platforms/85xx/smp.c    |  220 +++++++++++++++++++++++++++++-----
 4 files changed, 226 insertions(+), 35 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 47682b6..dc7feba 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -212,7 +212,7 @@ config ARCH_HIBERNATION_POSSIBLE
 config ARCH_SUSPEND_POSSIBLE
 	def_bool y
 	depends on ADB_PMU || PPC_EFIKA || PPC_LITE5200 || PPC_83xx || \
-		   (PPC_85xx && !SMP) || PPC_86xx || PPC_PSERIES || 44x || 40x
+		   PPC_85xx || PPC_86xx || PPC_PSERIES || 44x || 40x
 
 config PPC_DCR_NATIVE
 	bool
@@ -323,7 +323,8 @@ config SWIOTLB
 
 config HOTPLUG_CPU
 	bool "Support for enabling/disabling CPUs"
-	depends on SMP && HOTPLUG && EXPERIMENTAL && (PPC_PSERIES || PPC_PMAC)
+	depends on SMP && HOTPLUG && EXPERIMENTAL && (PPC_PSERIES || \
+		PPC_PMAC || E500)
 	---help---
 	  Say Y here to be able to disable and re-enable individual
 	  CPUs at runtime on SMP machines.
diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
index 5084592..d13ae54 100644
--- a/arch/powerpc/kernel/head_fsl_booke.S
+++ b/arch/powerpc/kernel/head_fsl_booke.S
@@ -899,6 +899,34 @@ _GLOBAL(flush_dcache_L1)
 
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
index 7bf2187..12a54f0 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -381,8 +381,14 @@ void generic_cpu_die(unsigned int cpu)
 
 	for (i = 0; i < 100; i++) {
 		smp_rmb();
-		if (per_cpu(cpu_state, cpu) == CPU_DEAD)
+		if (per_cpu(cpu_state, cpu) == CPU_DEAD) {
+			/*
+			 * After another core sets cpu_state to CPU_DEAD,
+			 * it needs some time to die.
+			 */
+			msleep(10);
 			return;
+		}
 		msleep(100);
 	}
 	printk(KERN_ERR "CPU%d didn't die...\n", cpu);
diff --git a/arch/powerpc/platforms/85xx/smp.c b/arch/powerpc/platforms/85xx/smp.c
index 9b0de9c..5a54fc1 100644
--- a/arch/powerpc/platforms/85xx/smp.c
+++ b/arch/powerpc/platforms/85xx/smp.c
@@ -17,6 +17,7 @@
 #include <linux/of.h>
 #include <linux/kexec.h>
 #include <linux/highmem.h>
+#include <linux/cpu.h>
 
 #include <asm/machdep.h>
 #include <asm/pgtable.h>
@@ -30,26 +31,141 @@
 
 extern void __early_start(void);
 
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
+#define MPC85xx_BPTR_OFF		0x00020
+#define MPC85xx_BPTR_EN			0x80000000
+#define MPC85xx_BPTR_BOOT_PAGE_MASK	0x00ffffff
+#define MPC85xx_BRR_OFF			0xe0e4
+#define MPC85xx_ECM_EEBPCR_OFF		0x01010
+#define MPC85xx_PIC_PIR_OFF		0x41090
+
+struct epapr_entry {
+	u32	addr_h;
+	u32	addr_l;
+	u32	r3_h;
+	u32	r3_l;
+	u32	reserved;
+	u32	pir;
+	u32	r6_h;
+	u32	r6_l;
+};
+
+static int is_corenet;
+static void __cpuinit smp_85xx_setup_cpu(int cpu_nr);
+
+#if defined(CONFIG_HOTPLUG_CPU) && defined(CONFIG_PPC32)
+extern void flush_disable_L1(void);
+
+static void __cpuinit smp_85xx_mach_cpu_die(void)
+{
+	unsigned int cpu = smp_processor_id();
+	register u32 tmp;
+
+	local_irq_disable();
+	idle_task_exit();
+	generic_set_cpu_dead(cpu);
+	smp_wmb();
+
+	mtspr(SPRN_TSR, TSR_ENW | TSR_WIS | TSR_DIS | TSR_FIS);
+	mtspr(SPRN_TCR, 0);
+
+	flush_disable_L1();
+
+	tmp = 0;
+	if (cpu_has_feature(CPU_FTR_CAN_NAP))
+		tmp = HID0_NAP;
+	else if (cpu_has_feature(CPU_FTR_CAN_DOZE))
+		tmp = HID0_DOZE;
+	if (tmp) {
+		tmp |= mfspr(SPRN_HID0) & ~(HID0_DOZE|HID0_NAP|HID0_SLEEP);
+
+		smp_mb();
+		isync();
+		mtspr(SPRN_HID0, tmp);
+		isync();
+
+		tmp = mfmsr();
+		tmp |= MSR_WE;
+		smp_mb();
+		mtmsr(tmp);
+		isync();
+	}
+
+	for (;;);
+}
+
+static void __cpuinit smp_85xx_reset_core(int nr)
+{
+	__iomem u32 *vaddr, *pir_vaddr;
+	u32 val, cpu_mask;
+
+	/* If CoreNet platform, use BRR as release register. */
+	if (is_corenet) {
+		cpu_mask = 1 << nr;
+		vaddr = ioremap(get_immrbase() + MPC85xx_BRR_OFF, 4);
+	} else {
+		cpu_mask = 1 << (24 + nr);
+		vaddr = ioremap(get_immrbase() + MPC85xx_ECM_EEBPCR_OFF, 4);
+	}
+	val = in_be32(vaddr);
+	if (!(val & cpu_mask)) {
+		out_be32(vaddr, val | cpu_mask);
+	} else {
+		/* reset core */
+		pir_vaddr = ioremap(get_immrbase() + MPC85xx_PIC_PIR_OFF, 4);
+		val = in_be32(pir_vaddr);
+		/* reset assert */
+		val |= (1 << nr);
+		out_be32(pir_vaddr, val);
+		val = in_be32(pir_vaddr);
+		val &= ~(1 << nr);
+		/* reset negate */
+		out_be32(pir_vaddr, val);
+		iounmap(pir_vaddr);
+	}
+	iounmap(vaddr);
+}
+
+static int __cpuinit smp_85xx_map_bootpg(u32 page)
+{
+	__iomem u32 *bootpg_ptr;
+	u32 bptr;
+
+	/* Get the BPTR */
+	bootpg_ptr = ioremap(get_immrbase() + MPC85xx_BPTR_OFF, 4);
+
+	/* Set the BPTR to the secondary boot page */
+	bptr = MPC85xx_BPTR_EN | (page & MPC85xx_BPTR_BOOT_PAGE_MASK);
+	out_be32(bootpg_ptr, bptr);
+
+	iounmap(bootpg_ptr);
+	return 0;
+}
+
+static int __cpuinit smp_85xx_unmap_bootpg(void)
+{
+	__iomem u32 *bootpg_ptr;
+
+	/* Get the BPTR */
+	bootpg_ptr = ioremap(get_immrbase() + MPC85xx_BPTR_OFF, 4);
+
+	/* Restore the BPTR */
+	if (in_be32(bootpg_ptr) & MPC85xx_BPTR_EN)
+		out_be32(bootpg_ptr, 0);
+
+	iounmap(bootpg_ptr);
+	return 0;
+}
+#endif
+
+static int __cpuinit smp_85xx_kick_cpu(int nr)
 {
 	unsigned long flags;
 	const u64 *cpu_rel_addr;
-	__iomem u32 *bptr_vaddr;
+	__iomem struct epapr_entry *epapr;
 	struct device_node *np;
-	int n = 0;
+	int n = 0, hw_cpu = get_hard_smp_processor_id(nr);
 	int ioremappable;
+	int ret = 0;
 
 	WARN_ON (nr < 0 || nr >= NR_CPUS);
 
@@ -73,46 +189,79 @@ smp_85xx_kick_cpu(int nr)
 
 	/* Map the spin table */
 	if (ioremappable)
-		bptr_vaddr = ioremap(*cpu_rel_addr, SIZE_BOOT_ENTRY);
+		epapr = ioremap(*cpu_rel_addr, sizeof(struct epapr_entry));
 	else
-		bptr_vaddr = phys_to_virt(*cpu_rel_addr);
+		epapr = phys_to_virt(*cpu_rel_addr);
 
 	local_irq_save(flags);
 
-	out_be32(bptr_vaddr + BOOT_ENTRY_PIR, nr);
+	out_be32(&epapr->pir, hw_cpu);
 #ifdef CONFIG_PPC32
-	out_be32(bptr_vaddr + BOOT_ENTRY_ADDR_LOWER, __pa(__early_start));
+#ifdef CONFIG_HOTPLUG_CPU
+	if (system_state == SYSTEM_RUNNING) {
+		out_be32(&epapr->addr_l, 0);
+		smp_85xx_map_bootpg((u32)(*cpu_rel_addr >> PAGE_SHIFT));
+
+		smp_85xx_reset_core(hw_cpu);
+
+		/* wait until core is ready... */
+		n = 0;
+		while ((in_be32(&epapr->addr_l) != 1) && (++n < 1000))
+			udelay(100);
+		if (n > 1000) {
+			pr_err("timeout waiting for core%d to reset\n",	nr);
+			ret = -ENOENT;
+			goto out;
+		}
+		/*  clear the acknowledge status */
+		__secondary_hold_acknowledge = -1;
+
+		smp_85xx_unmap_bootpg();
+	}
+#endif
+	out_be32(&epapr->addr_l, __pa(__early_start));
 
 	if (!ioremappable)
-		flush_dcache_range((ulong)bptr_vaddr,
-				(ulong)(bptr_vaddr + SIZE_BOOT_ENTRY));
+		flush_dcache_range((ulong)epapr,
+				(ulong)epapr + sizeof(struct epapr_entry));
 
 	/* Wait a bit for the CPU to ack. */
-	while ((__secondary_hold_acknowledge != nr) && (++n < 1000))
+	n = 0;
+	while ((__secondary_hold_acknowledge != hw_cpu) && (++n < 1000))
 		mdelay(1);
+	if (n > 1000) {
+		pr_err("timeout waiting for core%d to ack\n", nr);
+		ret = -ENOENT;
+		goto out;
+	}
+out:
 #else
 	smp_generic_kick_cpu(nr);
 
-	out_be64((u64 *)(bptr_vaddr + BOOT_ENTRY_ADDR_UPPER),
+	out_be64((u64 *)(&epapr->addr_h),
 		__pa((u64)*((unsigned long long *) generic_secondary_smp_init)));
 
 	if (!ioremappable)
-		flush_dcache_range((ulong)bptr_vaddr,
-				(ulong)(bptr_vaddr + SIZE_BOOT_ENTRY));
+		flush_dcache_range((ulong)epapr,
+				(ulong)epapr + sizeof(struct epapr_entry));
 #endif
-
 	local_irq_restore(flags);
 
 	if (ioremappable)
-		iounmap(bptr_vaddr);
+		iounmap(epapr);
 
 	pr_debug("waited %d msecs for CPU #%d.\n", n, nr);
 
-	return 0;
+	return ret;
 }
 
 struct smp_ops_t smp_85xx_ops = {
 	.kick_cpu = smp_85xx_kick_cpu,
+	.setup_cpu	= smp_85xx_setup_cpu,
+#ifdef CONFIG_HOTPLUG_CPU
+	.cpu_disable	= generic_cpu_disable,
+	.cpu_die	= generic_cpu_die,
+#endif
 	.give_timebase	= smp_generic_give_timebase,
 	.take_timebase	= smp_generic_take_timebase,
 };
@@ -214,8 +363,7 @@ static void mpc85xx_smp_machine_kexec(struct kimage *image)
 }
 #endif /* CONFIG_KEXEC */
 
-static void __init
-smp_85xx_setup_cpu(int cpu_nr)
+static void __cpuinit smp_85xx_setup_cpu(int cpu_nr)
 {
 	if (smp_85xx_ops.probe == smp_mpic_probe)
 		mpic_setup_this_cpu();
@@ -228,14 +376,18 @@ void __init mpc85xx_smp_init(void)
 {
 	struct device_node *np;
 
-	smp_85xx_ops.setup_cpu = smp_85xx_setup_cpu;
-
 	np = of_find_node_by_type(NULL, "open-pic");
 	if (np) {
 		smp_85xx_ops.probe = smp_mpic_probe;
 		smp_85xx_ops.message_pass = smp_mpic_message_pass;
 	}
 
+	/* Check if the chip is based on CoreNet platform. */
+	is_corenet = 0;
+	np = of_find_compatible_node(NULL, NULL, "fsl,qoriq-device-config-1.0");
+	if (np)
+		is_corenet = 1;
+
 	if (cpu_has_feature(CPU_FTR_DBELL)) {
 		/*
 		 * If left NULL, .message_pass defaults to
@@ -244,6 +396,10 @@ void __init mpc85xx_smp_init(void)
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
