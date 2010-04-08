Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 20BA8B7D2B
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Apr 2010 15:38:27 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v2] powerpc/e500mc: Implement machine check handler.
Date: Thu,  8 Apr 2010 00:38:22 -0500
Message-Id: <1270705102-18343-1-git-send-email-galak@kernel.crashing.org>
Cc: Scott Wood <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Scott Wood <scottwood@freescale.com>

Most of the MSCR bit assigments are different in e500mc versus
e500, and they are now write-one-to-clear.

Some e500mc machine check conditions are made recoverable (as long as
they aren't stuck on), most notably L1 instruction cache parity errors.

Signed-off-by: Scott Wood <scottwood@freescale.com>
Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
* Fix build error

 arch/powerpc/include/asm/cputable.h  |    1 +
 arch/powerpc/include/asm/reg_booke.h |   33 +++++++++----
 arch/powerpc/kernel/cputable.c       |    2 +-
 arch/powerpc/kernel/traps.c          |   88 +++++++++++++++++++++++++++++++++-
 4 files changed, 112 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index abb833b..5536a2c 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -70,6 +70,7 @@ struct pt_regs;
 extern int machine_check_generic(struct pt_regs *regs);
 extern int machine_check_4xx(struct pt_regs *regs);
 extern int machine_check_440A(struct pt_regs *regs);
+extern int machine_check_e500mc(struct pt_regs *regs);
 extern int machine_check_e500(struct pt_regs *regs);
 extern int machine_check_e200(struct pt_regs *regs);
 
diff --git a/arch/powerpc/include/asm/reg_booke.h b/arch/powerpc/include/asm/reg_booke.h
index 414d434..7a8dbff 100644
--- a/arch/powerpc/include/asm/reg_booke.h
+++ b/arch/powerpc/include/asm/reg_booke.h
@@ -4,6 +4,12 @@
  * are not true Book E PowerPCs, they borrowed a number of features
  * before Book E was finalized, and are included here as well.  Unfortunatly,
  * they sometimes used different locations than true Book E CPUs did.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License version 2
+ * as published by the Free Software Foundation.
+ *
+ * Copyright 2009-2010 Freescale Semiconductor, Inc.
  */
 #ifdef __KERNEL__
 #ifndef __ASM_POWERPC_REG_BOOKE_H__
@@ -88,6 +94,7 @@
 #define SPRN_IVOR35	0x213	/* Interrupt Vector Offset Register 35 */
 #define SPRN_IVOR36	0x214	/* Interrupt Vector Offset Register 36 */
 #define SPRN_IVOR37	0x215	/* Interrupt Vector Offset Register 37 */
+#define SPRN_MCARU	0x239	/* Machine Check Address Register Upper */
 #define SPRN_MCSRR0	0x23A	/* Machine Check Save and Restore Register 0 */
 #define SPRN_MCSRR1	0x23B	/* Machine Check Save and Restore Register 1 */
 #define SPRN_MCSR	0x23C	/* Machine Check Status Register */
@@ -192,8 +199,11 @@
 #define MCSR_IMPE	0x00800000 /* Imprecise Machine Check Exception */
 
 #ifdef CONFIG_E500
+/* All e500 */
 #define MCSR_MCP 	0x80000000UL /* Machine Check Input Pin */
 #define MCSR_ICPERR 	0x40000000UL /* I-Cache Parity Error */
+
+/* e500v1/v2 */
 #define MCSR_DCP_PERR 	0x20000000UL /* D-Cache Push Parity Error */
 #define MCSR_DCPERR 	0x10000000UL /* D-Cache Parity Error */
 #define MCSR_BUS_IAERR 	0x00000080UL /* Instruction Address Error */
@@ -205,12 +215,20 @@
 #define MCSR_BUS_IPERR 	0x00000002UL /* Instruction parity Error */
 #define MCSR_BUS_RPERR 	0x00000001UL /* Read parity Error */
 
-/* e500 parts may set unused bits in MCSR; mask these off */
-#define MCSR_MASK	(MCSR_MCP | MCSR_ICPERR | MCSR_DCP_PERR | \
-			MCSR_DCPERR | MCSR_BUS_IAERR | MCSR_BUS_RAERR | \
-			MCSR_BUS_WAERR | MCSR_BUS_IBERR | MCSR_BUS_RBERR | \
-			MCSR_BUS_WBERR | MCSR_BUS_IPERR | MCSR_BUS_RPERR)
+/* e500mc */
+#define MCSR_DCPERR_MC	0x20000000UL /* D-Cache Parity Error */
+#define MCSR_L2MMU_MHIT	0x04000000UL /* Hit on multiple TLB entries */
+#define MCSR_NMI	0x00100000UL /* Non-Maskable Interrupt */
+#define MCSR_MAV	0x00080000UL /* MCAR address valid */
+#define MCSR_MEA	0x00040000UL /* MCAR is effective address */
+#define MCSR_IF		0x00010000UL /* Instruction Fetch */
+#define MCSR_LD		0x00008000UL /* Load */
+#define MCSR_ST		0x00004000UL /* Store */
+#define MCSR_LDG	0x00002000UL /* Guarded Load */
+#define MCSR_TLBSYNC	0x00000002UL /* Multiple tlbsyncs detected */
+#define MCSR_BSL2_ERR	0x00000001UL /* Backside L2 cache error */
 #endif
+
 #ifdef CONFIG_E200
 #define MCSR_MCP 	0x80000000UL /* Machine Check Input Pin */
 #define MCSR_CP_PERR 	0x20000000UL /* Cache Push Parity Error */
@@ -221,11 +239,6 @@
 #define MCSR_BUS_DRERR 	0x00000008UL /* Read Bus Error on data load */
 #define MCSR_BUS_WRERR 	0x00000004UL /* Write Bus Error on buffered
 					store or cache line push */
-
-/* e200 parts may set unused bits in MCSR; mask these off */
-#define MCSR_MASK	(MCSR_MCP | MCSR_CP_PERR | MCSR_CPERR | \
-			MCSR_EXCP_ERR | MCSR_BUS_IRERR | MCSR_BUS_DRERR | \
-			MCSR_BUS_WRERR)
 #endif
 
 /* Bit definitions for the DBSR. */
diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index 8af4949..c6c9563 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -1811,7 +1811,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.oprofile_cpu_type	= "ppc/e500mc",
 		.oprofile_type		= PPC_OPROFILE_FSL_EMB,
 		.cpu_setup		= __setup_cpu_e500mc,
-		.machine_check		= machine_check_e500,
+		.machine_check		= machine_check_e500mc,
 		.platform		= "ppce500mc",
 	},
 	{	/* default match */
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 696626a..e893122 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -1,5 +1,6 @@
 /*
  *  Copyright (C) 1995-1996  Gary Thomas (gdt@linuxppc.org)
+ *  Copyright 2007-2010 Freescale Semiconductor, Inc.
  *
  *  This program is free software; you can redistribute it and/or
  *  modify it under the terms of the GNU General Public License
@@ -306,7 +307,7 @@ static inline int check_io_access(struct pt_regs *regs)
 #ifndef CONFIG_FSL_BOOKE
 #define get_mc_reason(regs)	((regs)->dsisr)
 #else
-#define get_mc_reason(regs)	(mfspr(SPRN_MCSR) & MCSR_MASK)
+#define get_mc_reason(regs)	(mfspr(SPRN_MCSR))
 #endif
 #define REASON_FP		ESR_FP
 #define REASON_ILLEGAL		(ESR_PIL | ESR_PUO)
@@ -382,6 +383,91 @@ int machine_check_440A(struct pt_regs *regs)
 	return 0;
 }
 #elif defined(CONFIG_E500)
+int machine_check_e500mc(struct pt_regs *regs)
+{
+	unsigned long mcsr = mfspr(SPRN_MCSR);
+	unsigned long reason = mcsr;
+	int recoverable = 1;
+
+	printk("Machine check in kernel mode.\n");
+	printk("Caused by (from MCSR=%lx): ", reason);
+
+	if (reason & MCSR_MCP)
+		printk("Machine Check Signal\n");
+
+	if (reason & MCSR_ICPERR) {
+		printk("Instruction Cache Parity Error\n");
+
+		/*
+		 * This is recoverable by invalidating the i-cache.
+		 */
+		mtspr(SPRN_L1CSR1, mfspr(SPRN_L1CSR1) | L1CSR1_ICFI);
+		while (mfspr(SPRN_L1CSR1) & L1CSR1_ICFI)
+			;
+
+		/*
+		 * This will generally be accompanied by an instruction
+		 * fetch error report -- only treat MCSR_IF as fatal
+		 * if it wasn't due to an L1 parity error.
+		 */
+		reason &= ~MCSR_IF;
+	}
+
+	if (reason & MCSR_DCPERR_MC) {
+		printk("Data Cache Parity Error\n");
+		recoverable = 0;
+	}
+
+	if (reason & MCSR_L2MMU_MHIT) {
+		printk("Hit on multiple TLB entries\n");
+		recoverable = 0;
+	}
+
+	if (reason & MCSR_NMI)
+		printk("Non-maskable interrupt\n");
+
+	if (reason & MCSR_IF) {
+		printk("Instruction Fetch Error Report\n");
+		recoverable = 0;
+	}
+
+	if (reason & MCSR_LD) {
+		printk("Load Error Report\n");
+		recoverable = 0;
+	}
+
+	if (reason & MCSR_ST) {
+		printk("Store Error Report\n");
+		recoverable = 0;
+	}
+
+	if (reason & MCSR_LDG) {
+		printk("Guarded Load Error Report\n");
+		recoverable = 0;
+	}
+
+	if (reason & MCSR_TLBSYNC)
+		printk("Simultaneous tlbsync operations\n");
+
+	if (reason & MCSR_BSL2_ERR) {
+		printk("Level 2 Cache Error\n");
+		recoverable = 0;
+	}
+
+	if (reason & MCSR_MAV) {
+		u64 addr;
+
+		addr = mfspr(SPRN_MCAR);
+		addr |= (u64)mfspr(SPRN_MCARU) << 32;
+
+		printk("Machine Check %s Address: %#llx\n",
+		       reason & MCSR_MEA ? "Effective" : "Physical", addr);
+	}
+
+	mtspr(SPRN_MCSR, mcsr);
+	return mfspr(SPRN_MCSR) == 0 && recoverable;
+}
+
 int machine_check_e500(struct pt_regs *regs)
 {
 	unsigned long reason = get_mc_reason(regs);
-- 
1.6.0.6
