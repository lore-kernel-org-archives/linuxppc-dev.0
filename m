Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E3D0ADDDEC
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Dec 2008 18:57:54 +1100 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/85xx: Add support for SMP initialization
Date: Tue,  2 Dec 2008 01:55:46 -0600
Message-Id: <1228204546-1506-1-git-send-email-galak@kernel.crashing.org>
Cc: afleming@freescale.com, tpiepho@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Added 85xx specifc smp_ops structure.  We use ePAPR style boot release
and the MPIC for IPIs at this point.

Additionally added routines for secondary cpu entry and initializtion.

Signed-off-by: Andy Fleming <afleming@freescale.com>
Signed-off-by: Trent Piepho <tpiepho@freescale.com>
Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/kernel/head_fsl_booke.S |   70 +++++++++++++++++++++++
 arch/powerpc/platforms/85xx/Makefile |    2 +
 arch/powerpc/platforms/85xx/smp.c    |  104 ++++++++++++++++++++++++++++++++++
 3 files changed, 176 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/platforms/85xx/smp.c

diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
index 2b57605..9a4639c 100644
--- a/arch/powerpc/kernel/head_fsl_booke.S
+++ b/arch/powerpc/kernel/head_fsl_booke.S
@@ -92,6 +92,7 @@ _ENTRY(_start);
  * if needed
  */
 
+_ENTRY(__early_start)
 /* 1. Find the index of the entry we're executing in */
 	bl	invstr				/* Find our address */
 invstr:	mflr	r6				/* Make it accessible */
@@ -348,6 +349,15 @@ skpinv:	addi	r6,r6,1				/* Increment */
 	mtspr	SPRN_DBSR,r2
 #endif
 
+#ifdef CONFIG_SMP
+	/* Check to see if we're the second processor, and jump
+	 * to the secondary_start code if so
+	 */
+	mfspr	r24,SPRN_PIR
+	cmpwi	r24,0
+	bne	__secondary_start
+#endif
+
 	/*
 	 * This is where the main kernel code starts.
 	 */
@@ -740,6 +750,9 @@ finish_tlb_load:
 #else
 	rlwimi	r12, r11, 26, 27, 31	/* extract WIMGE from pte */
 #endif
+#ifdef CONFIG_SMP
+	ori	r12, r12, MAS2_M
+#endif
 	mtspr	SPRN_MAS2, r12
 
 	li	r10, (_PAGE_HWEXEC | _PAGE_PRESENT)
@@ -1042,6 +1055,63 @@ _GLOBAL(flush_dcache_L1)
 
 	blr
 
+#ifdef CONFIG_SMP
+/* When we get here, r24 needs to hold the CPU # */
+	.globl __secondary_start
+__secondary_start:
+	lis	r3,__secondary_hold_acknowledge@h
+	ori	r3,r3,__secondary_hold_acknowledge@l
+	stw	r24,0(r3)
+
+	li	r3,0
+	mr	r4,r24		/* Why? */
+	bl	call_setup_cpu
+
+	lis	r3,tlbcam_index@ha
+	lwz	r3,tlbcam_index@l(r3)
+	mtctr	r3
+	li	r26,0		/* r26 safe? */
+
+	/* Load each CAM entry */
+1:	mr	r3,r26
+	bl	loadcam_entry
+	addi	r26,r26,1
+	bdnz	1b
+
+	/* get current_thread_info and current */
+	lis	r1,secondary_ti@ha
+	lwz	r1,secondary_ti@l(r1)
+	lwz	r2,TI_TASK(r1)
+
+	/* stack */
+	addi	r1,r1,THREAD_SIZE-STACK_FRAME_OVERHEAD
+	li	r0,0
+	stw	r0,0(r1)
+
+	/* ptr to current thread */
+	addi	r4,r2,THREAD	/* address of our thread_struct */
+	mtspr	SPRN_SPRG3,r4
+
+	/* Setup the defaults for TLB entries */
+	li	r4,(MAS4_TSIZED(BOOKE_PAGESZ_4K))@l
+	mtspr	SPRN_MAS4,r4
+
+	/* Jump to start_secondary */
+	lis	r4,MSR_KERNEL@h
+	ori	r4,r4,MSR_KERNEL@l
+	lis	r3,start_secondary@h
+	ori	r3,r3,start_secondary@l
+	mtspr	SPRN_SRR0,r3
+	mtspr	SPRN_SRR1,r4
+	sync
+	rfi
+	sync
+
+	.globl __secondary_hold_acknowledge
+__secondary_hold_acknowledge:
+	.long	-1
+#endif
+
 /*
  * We put a few things here that have to be page-aligned. This stuff
  * goes at the beginning of the data segment, which is page-aligned.
diff --git a/arch/powerpc/platforms/85xx/Makefile b/arch/powerpc/platforms/85xx/Makefile
index cb3054e..f0798c0 100644
--- a/arch/powerpc/platforms/85xx/Makefile
+++ b/arch/powerpc/platforms/85xx/Makefile
@@ -1,6 +1,8 @@
 #
 # Makefile for the PowerPC 85xx linux kernel.
 #
+obj-$(CONFIG_SMP) += smp.o
+
 obj-$(CONFIG_MPC8540_ADS) += mpc85xx_ads.o
 obj-$(CONFIG_MPC8560_ADS) += mpc85xx_ads.o
 obj-$(CONFIG_MPC85xx_CDS) += mpc85xx_cds.o
diff --git a/arch/powerpc/platforms/85xx/smp.c b/arch/powerpc/platforms/85xx/smp.c
new file mode 100644
index 0000000..d652c71
--- /dev/null
+++ b/arch/powerpc/platforms/85xx/smp.c
@@ -0,0 +1,104 @@
+/*
+ * Author: Andy Fleming <afleming@freescale.com>
+ * 	   Kumar Gala <galak@kernel.crashing.org>
+ *
+ * Copyright 2006-2008 Freescale Semiconductor Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/stddef.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/of.h>
+
+#include <asm/machdep.h>
+#include <asm/pgtable.h>
+#include <asm/page.h>
+#include <asm/mpic.h>
+#include <asm/cacheflush.h>
+
+#include <sysdev/fsl_soc.h>
+
+extern volatile unsigned long __secondary_hold_acknowledge;
+extern void __early_start(void);
+
+#define BOOT_ENTRY_ADDR_UPPER	0
+#define BOOT_ENTRY_ADDR_LOWER	1
+#define BOOT_ENTRY_R3_UPPER	2
+#define BOOT_ENTRY_R3_LOWER	3
+#define BOOT_ENTRY_RESV		4
+#define BOOT_ENTRY_PIR		5
+#define BOOT_ENTRY_R6_UPPER	6
+#define BOOT_ENTRY_R6_LOWER	7
+#define NUM_BOOT_ENTRY		8
+#define SIZE_BOOT_ENTRY		(NUM_BOOT_ENTRY * sizeof(u32))
+
+static void __init
+smp_85xx_kick_cpu(int nr)
+{
+	unsigned long flags;
+	const u64 *cpu_rel_addr;
+	__iomem u32 *bptr_vaddr;
+	struct device_node *np;
+	int n = 0;
+
+	WARN_ON (nr < 0 || nr >= NR_CPUS);
+
+	pr_debug("smp_85xx_kick_cpu: kick CPU #%d\n", nr);
+
+	local_irq_save(flags);
+
+	np = of_get_cpu_node(nr, NULL);
+	cpu_rel_addr = of_get_property(np, "cpu-release-addr", NULL);
+
+	if (cpu_rel_addr == NULL) {
+		printk(KERN_ERR "No cpu-release-addr for cpu %d\n", nr);
+		return;
+	}
+
+	/* Map the spin table */
+	bptr_vaddr = ioremap(*cpu_rel_addr, SIZE_BOOT_ENTRY);
+
+	out_be32(bptr_vaddr + BOOT_ENTRY_PIR, nr);
+	out_be32(bptr_vaddr + BOOT_ENTRY_ADDR_LOWER, __pa(__early_start));
+
+	/* Wait a bit for the CPU to ack. */
+	while ((__secondary_hold_acknowledge != nr) && (++n < 1000))
+		mdelay(1);
+
+	iounmap(bptr_vaddr);
+
+	local_irq_restore(flags);
+
+	pr_debug("waited %d msecs for CPU #%d.\n", n, nr);
+}
+
+static void __init
+smp_85xx_setup_cpu(int cpu_nr)
+{
+	mpic_setup_this_cpu();
+
+	/* Clear any pending timer interrupts */
+	mtspr(SPRN_TSR, TSR_ENW | TSR_WIS | TSR_DIS | TSR_FIS);
+
+	/* Enable decrementer interrupt */
+	mtspr(SPRN_TCR, TCR_DIE);
+}
+
+struct smp_ops_t smp_85xx_ops = {
+	.message_pass = smp_mpic_message_pass,
+	.probe = smp_mpic_probe,
+	.kick_cpu = smp_85xx_kick_cpu,
+	.setup_cpu = smp_85xx_setup_cpu,
+};
+
+void __init
+mpc85xx_smp_init(void)
+{
+	smp_ops = &smp_85xx_ops;
+}
-- 
1.5.6.5
