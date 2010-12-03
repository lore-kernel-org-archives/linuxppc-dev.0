Return-Path: <r58472@freescale.com>
Received: from AM1EHSOBE002.bigfish.com (am1ehsobe002.messaging.microsoft.com
	[213.199.154.205])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A90C6B7398
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  3 Dec 2010 22:41:23 +1100 (EST)
Received: from mail62-am1 (localhost.localdomain [127.0.0.1])	by
	mail62-am1-R.bigfish.com (Postfix) with ESMTP id 9E55937065E	for
	<linuxppc-dev@lists.ozlabs.org>; Fri,  3 Dec 2010 11:41:16 +0000 (UTC)
Received: from AM1EHSMHS008.bigfish.com (unknown [10.3.201.243])	by
	mail62-am1.bigfish.com (Postfix) with ESMTP id 6566F13F8050	for
	<linuxppc-dev@lists.ozlabs.org>; Fri,  3 Dec 2010 11:41:15 +0000 (UTC)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw01.freescale.net (8.14.3/8.14.3) with ESMTP id
	oB3BfAjp023378	for
	<linuxppc-dev@lists.ozlabs.org>; Fri, 3 Dec 2010 04:41:10 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id
	oB3BxAdb018881	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 3 Dec 2010 05:59:13 -0600 (CST)
From: Li Yang <leoli@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 2/7] powerpc/85xx: add HOTPLUG_CPU support
Date: Fri, 3 Dec 2010 20:34:06 +0800
Message-ID: <1291379651-8822-2-git-send-email-leoli@freescale.com>
In-Reply-To: <1291379651-8822-1-git-send-email-leoli@freescale.com>
References: <1291379651-8822-1-git-send-email-leoli@freescale.com>
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

Add support to disable and re-enable individual cores at runtime
on MPC85xx/QorIQ SMP machines.

This makes suspend/resume possible for SMP systems, as the power management
code on SMP always disable non-boot cpus on suspend.

MPC85xx machines use ePAPR spin-table in boot page for CPU kick-off.
This patch brings the bootpage and spin-table from bootloader into
kernel because the bootpage in bootloader might have been lost at
runtime.  Also add support to boot from physical address larger than
32-bit.

Signed-off-by: Yutaka Ando <y.ando@freescale.com>
Signed-off-by: Li Yang <leoli@freescale.com>
---
 arch/powerpc/Kconfig                   |    2 +-
 arch/powerpc/kernel/Makefile           |    2 +-
 arch/powerpc/kernel/head_fsl_booke.S   |   32 +++++
 arch/powerpc/kernel/smp.c              |    4 +-
 arch/powerpc/platforms/85xx/Makefile   |    4 +-
 arch/powerpc/platforms/85xx/bootpage.S |  206 +++++++++++++++++++++++++++++
 arch/powerpc/platforms/85xx/smp.c      |  222 ++++++++++++++++++++++++++------
 7 files changed, 428 insertions(+), 44 deletions(-)
 create mode 100644 arch/powerpc/platforms/85xx/bootpage.S

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index e625e9e..b1982dd 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -320,7 +320,7 @@ config SWIOTLB
 
 config HOTPLUG_CPU
 	bool "Support for enabling/disabling CPUs"
-	depends on SMP && HOTPLUG && EXPERIMENTAL && (PPC_PSERIES || PPC_PMAC)
+	depends on SMP && HOTPLUG && EXPERIMENTAL && (PPC_PSERIES || PPC_PMAC || E500)
 	---help---
 	  Say Y here to be able to disable and re-enable individual
 	  CPUs at runtime on SMP machines.
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 36c30f3..bb20496 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -56,7 +56,7 @@ obj-$(CONFIG_IBMEBUS)           += ibmebus.o
 obj-$(CONFIG_GENERIC_TBSYNC)	+= smp-tbsync.o
 obj-$(CONFIG_CRASH_DUMP)	+= crash_dump.o
 ifeq ($(CONFIG_PPC32),y)
-obj-$(CONFIG_E500)		+= idle_e500.o
+obj-$(CONFIG_E500)		+= idle_e500.o l2cr_85xx.o
 endif
 obj-$(CONFIG_6xx)		+= idle_6xx.o l2cr_6xx.o cpu_setup_6xx.o
 obj-$(CONFIG_TAU)		+= tau_6xx.o
diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
index 529b817..61d9c46 100644
--- a/arch/powerpc/kernel/head_fsl_booke.S
+++ b/arch/powerpc/kernel/head_fsl_booke.S
@@ -23,6 +23,7 @@
  *	PowerPC 44x support, Matt Porter <mporter@kernel.crashing.org>
  *    Copyright 2004 Freescale Semiconductor, Inc
  *	PowerPC e500 modifications, Kumar Gala <galak@kernel.crashing.org>
+ *    Copyright 2008, 2010 Freescale Semiconductor, Inc.
  *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
@@ -254,6 +255,37 @@ _ENTRY(__early_start)
 	lwz	r11, 0(r12);		/* Get Linux PTE */
 #endif
 
+_GLOBAL(flush_disable_L1)
+/*
+ * Flush L1 d-cache, invalidate and disable d-cache,
+ * invalidate and disable i-cache
+ */
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
 /*
  * Interrupt vector entry code
  *
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 68034bb..321cf2e 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -317,6 +317,8 @@ int generic_cpu_disable(void)
 	set_cpu_online(cpu, false);
 #ifdef CONFIG_PPC64
 	vdso_data->processorCount--;
+#endif
+#if defined(CONFIG_PPC64) || defined(CONFIG_E500)
 	fixup_irqs(cpu_online_mask);
 #endif
 	return 0;
@@ -336,7 +338,7 @@ int generic_cpu_enable(unsigned int cpu)
 	while (!cpu_online(cpu))
 		cpu_relax();
 
-#ifdef CONFIG_PPC64
+#if defined(CONFIG_PPC64) || defined(CONFIG_E500)
 	fixup_irqs(cpu_online_mask);
 	/* counter the irq disable in fixup_irqs */
 	local_irq_enable();
diff --git a/arch/powerpc/platforms/85xx/Makefile b/arch/powerpc/platforms/85xx/Makefile
index dd70db7..6bbcf22 100644
--- a/arch/powerpc/platforms/85xx/Makefile
+++ b/arch/powerpc/platforms/85xx/Makefile
@@ -1,7 +1,9 @@
 #
 # Makefile for the PowerPC 85xx linux kernel.
 #
-obj-$(CONFIG_SMP) += smp.o
+obj-$(CONFIG_SMP)         += smp.o
+obj-$(CONFIG_HOTPLUG_CPU) += bootpage.o
+obj-$(CONFIG_SUSPEND)     += suspend-asm.o
 
 obj-$(CONFIG_MPC8540_ADS) += mpc85xx_ads.o
 obj-$(CONFIG_MPC8560_ADS) += mpc85xx_ads.o
diff --git a/arch/powerpc/platforms/85xx/bootpage.S b/arch/powerpc/platforms/85xx/bootpage.S
new file mode 100644
index 0000000..ff0ca10
--- /dev/null
+++ b/arch/powerpc/platforms/85xx/bootpage.S
@@ -0,0 +1,206 @@
+/*
+ * Copyright 2008-2010 Freescale Semiconductor, Inc.
+ * Kumar Gala <kumar.gala@freescale.com>
+ * This file is taken from u-boot
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation;
+ */
+#include <linux/init.h>
+#include <linux/threads.h>
+#include <asm/processor.h>
+#include <asm/page.h>
+#include <asm/mmu.h>
+#include <asm/pgtable.h>
+#include <asm/cputable.h>
+#include <asm/thread_info.h>
+#include <asm/ppc_asm.h>
+#include <asm/asm-offsets.h>
+#include <asm/cache.h>
+
+/* To boot secondary cpus, we need a place for them to start up.
+ * Normally, they start at 0xfffffffc, but that's usually the
+ * firmware, and we don't want to have to run the firmware again.
+ * Instead, the primary cpu will set the BPTR to point here to
+ * this page.  We then set up the core, and head to
+ * start_secondary.  Note that this means that the code below
+ * must never exceed 1023 instructions (the branch at the end
+ * would then be the 1024th).
+ */
+	.globl	__secondary_start_page
+	.align	12
+__secondary_start_page:
+	lis	r3, 0x8000		/* enable machine check */
+#ifndef CONFIG_PPC_E500MC
+	ori	r3,r3,0x4000		/* enable Timebase */
+#endif
+#ifdef CONFIG_PHYS_64BIT
+	/* for 36-bit addressing */
+	ori	r3,r3,0x0080		/* enable MAS7 updates */
+#endif
+	mtspr	SPRN_HID0,r3
+
+#ifndef CONFIG_PPC_E500MC
+	li	r3,0x3000		/* Addr streaming & broadcast */
+	mtspr	SPRN_HID1,r3
+#endif
+
+	/* Enable branch prediction */
+	li	r3,0x201
+	mtspr	SPRN_BUCSR,r3
+
+	/* Ensure TB is 0 */
+	li	r3,0
+	mttbl	r3
+	mttbu	r3
+
+	mfspr	r0,SPRN_L1CSR1
+	ori	r0,r0,0x0003		/* Enable/invalidate the I-Cache */
+	mtspr	SPRN_L1CSR1,r0
+	isync
+
+
+	mfspr	r0,SPRN_L1CSR0
+	ori	r0,r0,0x0003		/* Enable/invalidate the D-Cache */
+	msync
+	isync
+	mtspr	SPRN_L1CSR0,r0
+	isync
+
+#define toreset(x) (x - __secondary_start_page + 0xfffff000)
+
+	/* get our PIR to figure out our table entry */
+	lis	r3,toreset(__spin_table)@h
+	ori	r3,r3,toreset(__spin_table)@l
+
+	/* r10 has the base address for the entry */
+	mfspr	r0,SPRN_PIR
+#ifdef CONFIG_PPC_E500MC
+	rlwinm	r4,r0,27,27,31
+#else
+	mr	r4,r0
+#endif
+	slwi	r8,r4,5
+	add	r10,r3,r8
+
+#define EPAPR_MAGIC		(0x45504150)
+#define ENTRY_ADDR_UPPER	0
+#define ENTRY_ADDR_LOWER	4
+#define ENTRY_R3_UPPER		8
+#define ENTRY_R3_LOWER		12
+#define ENTRY_RESV		16
+#define ENTRY_PIR		20
+#define ENTRY_R6_UPPER		24
+#define ENTRY_R6_LOWER		28
+#define ENTRY_SIZE		32
+
+	/* setup the entry */
+	li	r3,0
+	li	r8,1
+	stw	r0,ENTRY_PIR(r10)
+	stw	r3,ENTRY_ADDR_UPPER(r10)
+	stw	r8,ENTRY_ADDR_LOWER(r10)
+	stw	r3,ENTRY_R3_UPPER(r10)
+	stw	r4,ENTRY_R3_LOWER(r10)
+	stw	r3,ENTRY_R6_UPPER(r10)
+	stw	r3,ENTRY_R6_LOWER(r10)
+
+	/* setup mapping for AS = 1, and jump there */
+	lis	r11,(MAS0_TLBSEL(1)|MAS0_ESEL(1))@h
+	mtspr	SPRN_MAS0,r11
+	lis	r11,(MAS1_VALID|MAS1_IPROT)@h
+	ori	r11,r11,(MAS1_TS|MAS1_TSIZE(BOOK3E_PAGESZ_4K))@l
+	mtspr	SPRN_MAS1,r11
+	lis	r11,(0xfffff000|MAS2_I|MAS2_G)@h
+	ori	r11,r11,(0xfffff000|MAS2_I|MAS2_G)@l
+	mtspr	SPRN_MAS2,r11
+	lis	r11,(0xfffff000|MAS3_SX|MAS3_SW|MAS3_SR)@h
+	ori	r11,r11,(0xfffff000|MAS3_SX|MAS3_SW|MAS3_SR)@l
+	mtspr	SPRN_MAS3,r11
+	tlbwe
+
+	bl	1f
+1:	mflr	r11
+	addi	r11,r11,28
+	mfmsr	r13
+	ori	r12,r13,MSR_IS|MSR_DS@l
+
+	mtspr	SPRN_SRR0,r11
+	mtspr	SPRN_SRR1,r12
+	rfi
+
+	/* spin waiting for addr */
+2:
+	lwz	r4,ENTRY_ADDR_LOWER(r10)
+	andi.	r11,r4,1
+	bne	2b
+	isync
+
+	/* get the upper bits of the addr */
+	lwz	r11,ENTRY_ADDR_UPPER(r10)
+
+	/* setup branch addr */
+	mtspr	SPRN_SRR0,r4
+
+	/* mark the entry as released */
+	li	r8,3
+	stw	r8,ENTRY_ADDR_LOWER(r10)
+
+	/* mask by ~64M to setup our tlb we will jump to */
+	rlwinm	r12,r4,0,0,5
+
+	/* setup r3, r4, r5, r6, r7, r8, r9 */
+	lwz	r3,ENTRY_R3_LOWER(r10)
+	li	r4,0
+	li	r5,0
+	lwz	r6,ENTRY_R6_LOWER(r10)
+	lis	r7,(64*1024*1024)@h
+	li	r8,0
+	li	r9,0
+
+	/* load up the pir */
+	lwz	r0,ENTRY_PIR(r10)
+	mtspr	SPRN_PIR,r0
+	mfspr	r0,SPRN_PIR
+	stw	r0,ENTRY_PIR(r10)
+
+	mtspr	SPRN_IVPR,r12
+/*
+ * Coming here, we know the cpu has one TLB mapping in TLB1[0]
+ * which maps 0xfffff000-0xffffffff one-to-one.  We set up a
+ * second mapping that maps addr 1:1 for 64M, and then we jump to
+ * addr
+ */
+	lis	r10,(MAS0_TLBSEL(1)|MAS0_ESEL(0))@h
+	mtspr	SPRN_MAS0,r10
+	lis	r10,(MAS1_VALID|MAS1_IPROT)@h
+	ori	r10,r10,(MAS1_TSIZE(BOOK3E_PAGESZ_64M))@l
+	mtspr	SPRN_MAS1,r10
+	/* WIMGE = 0b00000 for now */
+	mtspr	SPRN_MAS2,r12
+	ori	r12,r12,(MAS3_SX|MAS3_SW|MAS3_SR)
+	mtspr	SPRN_MAS3,r12
+#ifdef CONFIG_PHYS_64BIT
+	mtspr	SPRN_MAS7,r11
+#endif
+	tlbwe
+
+/* Now we have another mapping for this page, so we jump to that
+ * mapping
+ */
+	mtspr	SPRN_SRR1,r13
+	rfi
+
+	.align L1_CACHE_SHIFT
+	.globl __spin_table
+__spin_table:
+	.space NR_CPUS*ENTRY_SIZE
+
+	/* Fill in the empty space.  The actual reset vector is
+	 * the last word of the page */
+__secondary_start_code_end:
+	.space 4092 - (__secondary_start_code_end - __secondary_start_page)
+
+__secondary_reset_vector:
+	b	__secondary_start_page
diff --git a/arch/powerpc/platforms/85xx/smp.c b/arch/powerpc/platforms/85xx/smp.c
index 1e8aec8..2ef3e8e 100644
--- a/arch/powerpc/platforms/85xx/smp.c
+++ b/arch/powerpc/platforms/85xx/smp.c
@@ -17,6 +17,7 @@
 #include <linux/of.h>
 #include <linux/kexec.h>
 #include <linux/highmem.h>
+#include <linux/cpu.h>
 
 #include <asm/machdep.h>
 #include <asm/pgtable.h>
@@ -28,26 +29,116 @@
 #include <sysdev/fsl_soc.h>
 #include <sysdev/mpic.h>
 
+#define MPC85xx_BPTR_OFF		0x00020
+#define MPC85xx_BPTR_EN			0x80000000
+#define MPC85xx_ECM_EEBPCR_OFF		0x01010
+#define MPC85xx_PIC_PIR_OFF		0x41090
+
+extern void mpc85xx_cpu_down(void) __attribute__((noreturn));
 extern void __early_start(void);
+extern void __secondary_start_page(void);
+extern volatile unsigned long __spin_table;
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
+/* access per cpu vars from generic smp.c */
+DECLARE_PER_CPU(int, cpu_state);
 
-static void __init
+#ifdef CONFIG_HOTPLUG_CPU
+static void __cpuinit
+smp_85xx_mach_cpu_die(void)
+{
+	__get_cpu_var(cpu_state) = CPU_DEAD;
+	smp_wmb();
+
+	local_irq_disable();
+	idle_task_exit();
+	mtspr(SPRN_TSR, TSR_ENW | TSR_WIS | TSR_DIS | TSR_FIS);
+	mtspr(SPRN_TCR, 0);
+	mpc85xx_cpu_down();
+}
+
+static void __cpuinit
+smp_85xx_reset_core(int nr)
+{
+	__iomem u32 *ecm_vaddr;
+	__iomem u32 *pic_vaddr;
+	u32 pcr, pir, cpu;
+
+	cpu = (1 << 24) << nr;
+	ecm_vaddr = ioremap(get_immrbase() + MPC85xx_ECM_EEBPCR_OFF, 4);
+	pcr = in_be32(ecm_vaddr);
+	if (pcr & cpu) {
+		pic_vaddr = ioremap(get_immrbase() + MPC85xx_PIC_PIR_OFF, 4);
+		pir = in_be32(pic_vaddr);
+		/* reset assert */
+		pir |= (1 << nr);
+		out_be32(pic_vaddr, pir);
+		pir = in_be32(pic_vaddr);
+		pir &= ~(1 << nr);
+		/* reset negate */
+		out_be32(pic_vaddr, pir);
+		(void)in_be32(pic_vaddr);
+		iounmap(pic_vaddr);
+	} else {
+		out_be32(ecm_vaddr, pcr | cpu);
+		(void)in_be32(ecm_vaddr);
+	}
+	iounmap(ecm_vaddr);
+}
+
+static int __cpuinit
+smp_85xx_map_bootpg(unsigned long pa)
+{
+	__iomem u32 *bootpg_ptr;
+	u32 bptr;
+
+	/* Get the BPTR */
+	bootpg_ptr = ioremap(get_immrbase() + MPC85xx_BPTR_OFF, 4);
+
+	/* Set the BPTR to the secondary boot page */
+	(void)in_be32(bootpg_ptr);
+
+	bptr = (MPC85xx_BPTR_EN | (pa >> 12));
+	out_be32(bootpg_ptr, bptr);
+	(void)in_be32(bootpg_ptr);
+	iounmap(bootpg_ptr);
+	return 0;
+}
+
+static int __cpuinit
+smp_85xx_unmap_bootpg(void)
+{
+	__iomem u32 *bootpg_ptr;
+
+	/* Get the BPTR */
+	bootpg_ptr = ioremap(get_immrbase() + MPC85xx_BPTR_OFF, 4);
+
+	/* Restore the BPTR */
+	if (in_be32(bootpg_ptr) & MPC85xx_BPTR_EN) {
+		out_be32(bootpg_ptr, 0);
+		(void)in_be32(bootpg_ptr);
+	}
+	iounmap(bootpg_ptr);
+	return 0;
+}
+#endif
+
+static void __cpuinit
 smp_85xx_kick_cpu(int nr)
 {
 	unsigned long flags;
-	const u64 *cpu_rel_addr;
-	__iomem u32 *bptr_vaddr;
-	struct device_node *np;
+	phys_addr_t cpu_rel_addr;
+	__iomem struct epapr_entry *epapr;
 	int n = 0;
 	int ioremappable;
 
@@ -55,41 +146,83 @@ smp_85xx_kick_cpu(int nr)
 
 	pr_debug("smp_85xx_kick_cpu: kick CPU #%d\n", nr);
 
-	np = of_get_cpu_node(nr, NULL);
-	cpu_rel_addr = of_get_property(np, "cpu-release-addr", NULL);
+	if (system_state < SYSTEM_RUNNING) {
+		/* booting, using __spin_table from u-boot */
+		struct device_node *np;
+		const u64 *prop;
 
-	if (cpu_rel_addr == NULL) {
-		printk(KERN_ERR "No cpu-release-addr for cpu %d\n", nr);
-		return;
-	}
+		np = of_get_cpu_node(nr, NULL);
+		if (np == NULL)
+			return;
 
-	/*
-	 * A secondary core could be in a spinloop in the bootpage
-	 * (0xfffff000), somewhere in highmem, or somewhere in lowmem.
-	 * The bootpage and highmem can be accessed via ioremap(), but
-	 * we need to directly access the spinloop if its in lowmem.
-	 */
-	ioremappable = *cpu_rel_addr > virt_to_phys(high_memory);
+		prop = of_get_property(np, "cpu-release-addr", NULL);
+		if (prop == NULL) {
+			of_node_put(np);
+			printk(KERN_ERR "No cpu-release-addr for cpu %d\n", nr);
+			return;
+		}
+		cpu_rel_addr = (phys_addr_t)*prop;
+		of_node_put(np);
+
+		/*
+		 * A secondary core could be in a spinloop in the bootpage
+		 * (0xfffff000), somewhere in highmem, or somewhere in lowmem.
+		 * The bootpage and highmem can be accessed via ioremap(), but
+		 * we need to directly access the spinloop if its in lowmem.
+		 */
+		ioremappable = cpu_rel_addr > virt_to_phys(high_memory);
+
+		if (ioremappable)
+			epapr = ioremap(cpu_rel_addr,
+						sizeof(struct epapr_entry));
+		else
+			epapr = phys_to_virt(cpu_rel_addr);
+
+		local_irq_save(flags);
+	} else {
+#ifdef CONFIG_HOTPLUG_CPU
+		/* spin table in kernel, no need to remap */
+		ioremappable = 0;
+		epapr = (void *)&__spin_table + nr * sizeof(struct epapr_entry);
 
-	/* Map the spin table */
-	if (ioremappable)
-		bptr_vaddr = ioremap(*cpu_rel_addr, SIZE_BOOT_ENTRY);
-	else
-		bptr_vaddr = phys_to_virt(*cpu_rel_addr);
+		/* prevent bootpage from being accessed by others */
+		local_irq_save(flags);
+
+		smp_85xx_map_bootpg(__pa(__secondary_start_page));
 
-	local_irq_save(flags);
+		smp_85xx_reset_core(nr);
 
-	out_be32(bptr_vaddr + BOOT_ENTRY_PIR, nr);
+		/* wait until core(nr) is ready... */
+		while ((in_be32(&epapr->addr_l) != 1) && (++n < 1000))
+			udelay(100);
+
+		if (n == 1000) {
+			pr_err("timeout waiting for core%d to reset\n",
+					nr);
+			goto out;
+		}
+#else
+		pr_err("runtime kick cpu not supported\n");
+		return;
+#endif
+	}
+
+	out_be32(&epapr->pir, nr);
 #ifdef CONFIG_PPC32
-	out_be32(bptr_vaddr + BOOT_ENTRY_ADDR_LOWER, __pa(__early_start));
+	/* clear the acknowledge status */
+	__secondary_hold_acknowledge = -1;
+	out_be32(&epapr->addr_l, __pa(__early_start));
 
 	if (!ioremappable)
-		flush_dcache_range((ulong)bptr_vaddr,
-				(ulong)(bptr_vaddr + SIZE_BOOT_ENTRY));
+		flush_dcache_range((ulong)epapr,
+				(ulong)epapr + sizeof(struct epapr_entry));
 
 	/* Wait a bit for the CPU to ack. */
+	n = 0;
 	while ((__secondary_hold_acknowledge != nr) && (++n < 1000))
 		mdelay(1);
+	if (n == 1000)
+		pr_err("timeout waiting for core%d to ack\n", nr);
 #else
 	out_be64((u64 *)(bptr_vaddr + BOOT_ENTRY_ADDR_UPPER),
 		__pa((u64)*((unsigned long long *) generic_secondary_smp_init)));
@@ -97,12 +230,15 @@ smp_85xx_kick_cpu(int nr)
 	smp_generic_kick_cpu(nr);
 #endif
 
+out:
+#ifdef CONFIG_HOTPLUG_CPU
+	if (system_state >= SYSTEM_RUNNING)
+		smp_85xx_unmap_bootpg();
+#endif
 	local_irq_restore(flags);
 
 	if (ioremappable)
-		iounmap(bptr_vaddr);
-
-	pr_debug("waited %d msecs for CPU #%d.\n", n, nr);
+		iounmap(epapr);
 }
 
 static void __init
@@ -232,6 +368,12 @@ void __init mpc85xx_smp_init(void)
 
 	BUG_ON(!smp_85xx_ops.message_pass);
 
+#ifdef CONFIG_HOTPLUG_CPU
+	smp_85xx_ops.cpu_disable   = generic_cpu_disable;
+	smp_85xx_ops.cpu_die	= generic_cpu_die;
+	ppc_md.cpu_die		= smp_85xx_mach_cpu_die;
+#endif
+
 	smp_ops = &smp_85xx_ops;
 
 #ifdef CONFIG_KEXEC
-- 
1.6.6-rc1.GIT
