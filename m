Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <e5996a0c3f7d275b503752238c4f93a6f4815264.1302856271.git.michael@ellerman.id.au>
In-Reply-To: <d284a5076d7760656470a5fd16d98ec6501a9bf3.1302856271.git.michael@ellerman.id.au>
References: <d284a5076d7760656470a5fd16d98ec6501a9bf3.1302856271.git.michael@ellerman.id.au>
Subject: [PATCH 08/15] powerpc: Add A2 cpu support
Date: Fri, 15 Apr 2011 18:32:01 +1000 (EST)
From: michael@ozlabs.org (Michael Ellerman)
Cc: Jimi Xenidis <jimix@watson.ibm.com>, jack@codezen.org, imunsie@au.ibm.com,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Add the cputable entry, regs and setup & restore entries for
the PPC A2.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/include/asm/cputable.h    |    6 +-
 arch/powerpc/include/asm/reg_a2.h      |  156 ++++++++++++++++++++++++++++++++
 arch/powerpc/kernel/Makefile           |    1 +
 arch/powerpc/kernel/cpu_setup_a2.S     |  114 +++++++++++++++++++++++
 arch/powerpc/kernel/cputable.c         |   25 +++++-
 arch/powerpc/platforms/Kconfig.cputype |    4 +
 6 files changed, 302 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index 32a970d..0dd4266 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -438,6 +438,8 @@ extern const char *powerpc_base_platform;
 #define CPU_FTRS_BASE_BOOK3E	(CPU_FTR_USE_TB | CPU_FTR_PPCAS_ARCH_V2 | \
 				 CPU_FTR_NODSISRALIGN | CPU_FTR_NOEXECUTE)
 
+#define CPU_FTRS_A2 (CPU_FTRS_BASE_BOOK3E | CPU_FTR_SMT | CPU_FTR_DBELL)
+
 #if defined(CONFIG_PPC_BOOK3S_64)
 #define CPU_FTRS_POSSIBLE	\
 	    (CPU_FTRS_POWER3 | CPU_FTRS_RS64 | CPU_FTRS_POWER4 |	\
@@ -446,7 +448,7 @@ extern const char *powerpc_base_platform;
 	    CPU_FTR_1T_SEGMENT | CPU_FTR_VSX)
 #elif defined(CONFIG_PPC_BOOK3E_64)
 #define CPU_FTRS_POSSIBLE	\
-	    (CPU_FTRS_BASE_BOOK3E)
+	    (CPU_FTRS_BASE_BOOK3E | CPU_FTRS_A2)
 #else
 enum {
 	CPU_FTRS_POSSIBLE =
@@ -492,7 +494,7 @@ enum {
 	    CPU_FTRS_POWER7 & CPU_FTRS_CELL & CPU_FTRS_PA6T & CPU_FTRS_POSSIBLE)
 #elif defined(CONFIG_PPC_BOOK3E_64)
 #define CPU_FTRS_ALWAYS	\
-	    (CPU_FTRS_BASE_BOOK3E)
+	    (CPU_FTRS_BASE_BOOK3E & CPU_FTRS_A2)
 #else
 enum {
 	CPU_FTRS_ALWAYS =
diff --git a/arch/powerpc/include/asm/reg_a2.h b/arch/powerpc/include/asm/reg_a2.h
new file mode 100644
index 0000000..3ba9c6f
--- /dev/null
+++ b/arch/powerpc/include/asm/reg_a2.h
@@ -0,0 +1,156 @@
+/*
+ *  Register definitions specific to the A2 core
+ *
+ *  Copyright (C) 2008 Ben. Herrenschmidt (benh@kernel.crashing.org), IBM Corp.
+ *
+ *  This program is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU General Public License
+ *  as published by the Free Software Foundation; either version
+ *  2 of the License, or (at your option) any later version.
+ */
+
+#ifndef __ASM_POWERPC_REG_A2_H__
+#define __ASM_POWERPC_REG_A2_H__
+
+#define SPRN_TENSR	0x1b5
+#define SPRN_TENS	0x1b6	/* Thread ENable Set */
+#define SPRN_TENC	0x1b7	/* Thread ENable Clear */
+
+#define SPRN_A2_CCR0	0x3f0	/* Core Configuration Register 0 */
+#define SPRN_A2_CCR1	0x3f1	/* Core Configuration Register 1 */
+#define SPRN_A2_CCR2	0x3f2	/* Core Configuration Register 2 */
+#define SPRN_MMUCR0	0x3fc	/* MMU Control Register 0 */
+#define SPRN_MMUCR1	0x3fd	/* MMU Control Register 1 */
+#define SPRN_MMUCR2	0x3fe	/* MMU Control Register 2 */
+#define SPRN_MMUCR3	0x3ff	/* MMU Control Register 3 */
+
+#define SPRN_IAR	0x372
+
+#define SPRN_IUCR0	0x3f3
+#define IUCR0_ICBI_ACK	0x1000
+
+#define SPRN_XUCR0	0x3f6	/* Execution Unit Config Register 0 */
+
+#define A2_IERAT_SIZE	16
+#define A2_DERAT_SIZE	32
+
+/* A2 MMUCR0 bits */
+#define MMUCR0_ECL	0x80000000	/* Extended Class for TLB fills */
+#define MMUCR0_TID_NZ	0x40000000	/* TID is non-zero */
+#define MMUCR0_TS	0x10000000	/* Translation space for TLB fills */
+#define MMUCR0_TGS	0x20000000	/* Guest space for TLB fills */
+#define MMUCR0_TLBSEL	0x0c000000	/* TLB or ERAT target for TLB fills */
+#define MMUCR0_TLBSEL_U	0x00000000	/*  TLBSEL = UTLB */
+#define MMUCR0_TLBSEL_I	0x08000000	/*  TLBSEL = I-ERAT */
+#define MMUCR0_TLBSEL_D	0x0c000000	/*  TLBSEL = D-ERAT */
+#define MMUCR0_LOCKSRSH	0x02000000	/* Use TLB lock on tlbsx. */
+#define MMUCR0_TID_MASK	0x000000ff	/* TID field */
+
+/* A2 MMUCR1 bits */
+#define MMUCR1_IRRE		0x80000000	/* I-ERAT round robin enable */
+#define MMUCR1_DRRE		0x40000000	/* D-ERAT round robin enable */
+#define MMUCR1_REE		0x20000000	/* Reference Exception Enable*/
+#define MMUCR1_CEE		0x10000000	/* Change exception enable */
+#define MMUCR1_CSINV_ALL	0x00000000	/* Inval ERAT on all CS evts */
+#define MMUCR1_CSINV_NISYNC	0x04000000	/* Inval ERAT on all ex isync*/
+#define MMUCR1_CSINV_NEVER	0x0c000000	/* Don't inval ERAT on CS */
+#define MMUCR1_ICTID		0x00080000	/* IERAT class field as TID */
+#define MMUCR1_ITTID		0x00040000	/* IERAT thdid field as TID */
+#define MMUCR1_DCTID		0x00020000	/* DERAT class field as TID */
+#define MMUCR1_DTTID		0x00010000	/* DERAT thdid field as TID */
+#define MMUCR1_DCCD		0x00008000	/* DERAT class ignore */
+#define MMUCR1_TLBWE_BINV	0x00004000	/* back invalidate on tlbwe */
+
+/* A2 MMUCR2 bits */
+#define MMUCR2_PSSEL_SHIFT	4
+
+/* A2 MMUCR3 bits */
+#define MMUCR3_THID		0x0000000f	/* Thread ID */
+
+/* *** ERAT TLB bits definitions */
+#define TLB0_EPN_MASK		ASM_CONST(0xfffffffffffff000)
+#define TLB0_CLASS_MASK		ASM_CONST(0x0000000000000c00)
+#define TLB0_CLASS_00		ASM_CONST(0x0000000000000000)
+#define TLB0_CLASS_01		ASM_CONST(0x0000000000000400)
+#define TLB0_CLASS_10		ASM_CONST(0x0000000000000800)
+#define TLB0_CLASS_11		ASM_CONST(0x0000000000000c00)
+#define TLB0_V			ASM_CONST(0x0000000000000200)
+#define TLB0_X			ASM_CONST(0x0000000000000100)
+#define TLB0_SIZE_MASK		ASM_CONST(0x00000000000000f0)
+#define TLB0_SIZE_4K		ASM_CONST(0x0000000000000010)
+#define TLB0_SIZE_64K		ASM_CONST(0x0000000000000030)
+#define TLB0_SIZE_1M		ASM_CONST(0x0000000000000050)
+#define TLB0_SIZE_16M		ASM_CONST(0x0000000000000070)
+#define TLB0_SIZE_1G		ASM_CONST(0x00000000000000a0)
+#define TLB0_THDID_MASK		ASM_CONST(0x000000000000000f)
+#define TLB0_THDID_0		ASM_CONST(0x0000000000000001)
+#define TLB0_THDID_1		ASM_CONST(0x0000000000000002)
+#define TLB0_THDID_2		ASM_CONST(0x0000000000000004)
+#define TLB0_THDID_3		ASM_CONST(0x0000000000000008)
+#define TLB0_THDID_ALL		ASM_CONST(0x000000000000000f)
+
+#define TLB1_RESVATTR		ASM_CONST(0x00f0000000000000)
+#define TLB1_U0			ASM_CONST(0x0008000000000000)
+#define TLB1_U1			ASM_CONST(0x0004000000000000)
+#define TLB1_U2			ASM_CONST(0x0002000000000000)
+#define TLB1_U3			ASM_CONST(0x0001000000000000)
+#define TLB1_R			ASM_CONST(0x0000800000000000)
+#define TLB1_C			ASM_CONST(0x0000400000000000)
+#define TLB1_RPN_MASK		ASM_CONST(0x000003fffffff000)
+#define TLB1_W			ASM_CONST(0x0000000000000800)
+#define TLB1_I			ASM_CONST(0x0000000000000400)
+#define TLB1_M			ASM_CONST(0x0000000000000200)
+#define TLB1_G			ASM_CONST(0x0000000000000100)
+#define TLB1_E			ASM_CONST(0x0000000000000080)
+#define TLB1_VF			ASM_CONST(0x0000000000000040)
+#define TLB1_UX			ASM_CONST(0x0000000000000020)
+#define TLB1_SX			ASM_CONST(0x0000000000000010)
+#define TLB1_UW			ASM_CONST(0x0000000000000008)
+#define TLB1_SW			ASM_CONST(0x0000000000000004)
+#define TLB1_UR			ASM_CONST(0x0000000000000002)
+#define TLB1_SR			ASM_CONST(0x0000000000000001)
+
+/* A2 erativax attributes definitions */
+#define ERATIVAX_RS_IS_ALL		0x000
+#define ERATIVAX_RS_IS_TID		0x040
+#define ERATIVAX_RS_IS_CLASS		0x080
+#define ERATIVAX_RS_IS_FULLMATCH	0x0c0
+#define ERATIVAX_CLASS_00		0x000
+#define ERATIVAX_CLASS_01		0x010
+#define ERATIVAX_CLASS_10		0x020
+#define ERATIVAX_CLASS_11		0x030
+#define ERATIVAX_PSIZE_4K		(TLB_PSIZE_4K >> 1)
+#define ERATIVAX_PSIZE_64K		(TLB_PSIZE_64K >> 1)
+#define ERATIVAX_PSIZE_1M		(TLB_PSIZE_1M >> 1)
+#define ERATIVAX_PSIZE_16M		(TLB_PSIZE_16M >> 1)
+#define ERATIVAX_PSIZE_1G		(TLB_PSIZE_1G >> 1)
+
+/* A2 eratilx attributes definitions */
+#define ERATILX_T_ALL			0
+#define ERATILX_T_TID			1
+#define ERATILX_T_TGS			2
+#define ERATILX_T_FULLMATCH		3
+#define ERATILX_T_CLASS0		4
+#define ERATILX_T_CLASS1		5
+#define ERATILX_T_CLASS2		6
+#define ERATILX_T_CLASS3		7
+
+/* XUCR0 bits */
+#define XUCR0_TRACE_UM_T0		0x40000000	/* Thread 0 */
+#define XUCR0_TRACE_UM_T1		0x20000000	/* Thread 1 */
+#define XUCR0_TRACE_UM_T2		0x10000000	/* Thread 2 */
+#define XUCR0_TRACE_UM_T3		0x08000000	/* Thread 3 */
+
+/* A2 CCR0 register */
+#define A2_CCR0_PME_DISABLED		0x00000000
+#define A2_CCR0_PME_SLEEP		0x40000000
+#define A2_CCR0_PME_RVW			0x80000000
+#define A2_CCR0_PME_DISABLED2		0xc0000000
+
+/* A2 CCR2 register */
+#define A2_CCR2_ERAT_ONLY_MODE		0x00000001
+#define A2_CCR2_ENABLE_ICSWX		0x00000002
+#define A2_CCR2_ENABLE_PC		0x20000000
+#define A2_CCR2_ENABLE_TRACE		0x40000000
+
+#endif /* __ASM_POWERPC_REG_A2_H__ */
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index b0ba78f..82e0bed 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -41,6 +41,7 @@ obj-$(CONFIG_PPC_BOOK3S_64)	+= cpu_setup_ppc970.o cpu_setup_pa6t.o
 obj-$(CONFIG_PPC_BOOK3S_64)	+= cpu_setup_power7.o
 obj64-$(CONFIG_RELOCATABLE)	+= reloc_64.o
 obj-$(CONFIG_PPC_BOOK3E_64)	+= exceptions-64e.o idle_book3e.o
+obj-$(CONFIG_PPC_A2)		+= cpu_setup_a2.o
 obj-$(CONFIG_PPC64)		+= vdso64/
 obj-$(CONFIG_ALTIVEC)		+= vecemu.o
 obj-$(CONFIG_PPC_970_NAP)	+= idle_power4.o
diff --git a/arch/powerpc/kernel/cpu_setup_a2.S b/arch/powerpc/kernel/cpu_setup_a2.S
new file mode 100644
index 0000000..7f818fe
--- /dev/null
+++ b/arch/powerpc/kernel/cpu_setup_a2.S
@@ -0,0 +1,114 @@
+/*
+ *  A2 specific assembly support code
+ *
+ *  Copyright 2009 Ben Herrenschmidt, IBM Corp.
+ *
+ *  This program is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU General Public License
+ *  as published by the Free Software Foundation; either version
+ *  2 of the License, or (at your option) any later version.
+ */
+
+#include <asm/asm-offsets.h>
+#include <asm/ppc_asm.h>
+#include <asm/ppc-opcode.h>
+#include <asm/processor.h>
+#include <asm/reg_a2.h>
+#include <asm/reg.h>
+#include <asm/thread_info.h>
+
+/*
+ * Disable thdid and class fields in ERATs to bump PID to full 14 bits capacity.
+ * This also prevents external LPID accesses but that isn't a problem when not a
+ * guest. Under PV, this setting will be ignored and MMUCR will return the right
+ * number of PID bits we can use.
+ */
+#define MMUCR1_EXTEND_PID \
+	(MMUCR1_ICTID | MMUCR1_ITTID | MMUCR1_DCTID | \
+	 MMUCR1_DTTID | MMUCR1_DCCD)
+
+/*
+ * Use extended PIDs if enabled.
+ * Don't clear the ERATs on context sync events and enable I & D LRU.
+ * Enable ERAT back invalidate when tlbwe overwrites an entry.
+ */
+#define INITIAL_MMUCR1 \
+	(MMUCR1_EXTEND_PID | MMUCR1_CSINV_NEVER | MMUCR1_IRRE | \
+	 MMUCR1_DRRE | MMUCR1_TLBWE_BINV)
+
+_GLOBAL(__setup_cpu_a2)
+	/* Some of these are actually thread local and some are
+	 * core local but doing it always won't hurt
+	 */
+
+#ifdef CONFIG_PPC_WSP_COPRO
+	/* Make sure ACOP starts out as zero */
+	li	r3,0
+	mtspr   SPRN_ACOP,r3
+
+	/* Enable icswx instruction */
+	mfspr   r3,SPRN_A2_CCR2
+	ori     r3,r3,A2_CCR2_ENABLE_ICSWX
+	mtspr   SPRN_A2_CCR2,r3
+
+	/* Unmask all CTs in HACOP */
+	li      r3,-1
+	mtspr   SPRN_HACOP,r3
+#endif /* CONFIG_PPC_WSP_COPRO */
+
+	/* Enable doorbell */
+	mfspr   r3,SPRN_A2_CCR2
+	oris     r3,r3,A2_CCR2_ENABLE_PC@h
+	mtspr   SPRN_A2_CCR2,r3
+	isync
+
+	/* Setup CCR0 to disable power saving for now as it's busted
+	 * in the current implementations. Setup CCR1 to wake on
+	 * interrupts normally (we write the default value but who
+	 * knows what FW may have clobbered...)
+	 */
+	li	r3,0
+	mtspr	SPRN_A2_CCR0, r3
+	LOAD_REG_IMMEDIATE(r3,0x0f0f0f0f)
+	mtspr	SPRN_A2_CCR1, r3
+
+	/* Initialise MMUCR1 */
+	lis	r3,INITIAL_MMUCR1@h
+	ori	r3,r3,INITIAL_MMUCR1@l
+	mtspr	SPRN_MMUCR1,r3
+
+	/* Set MMUCR2 to enable 4K, 64K, 1M, 16M and 1G pages */
+	LOAD_REG_IMMEDIATE(r3, 0x000a7531)
+	mtspr	SPRN_MMUCR2,r3
+
+	/* Set MMUCR3 to write all thids bit to the TLB */
+	LOAD_REG_IMMEDIATE(r3, 0x0000000f)
+	mtspr	SPRN_MMUCR3,r3
+
+	/* Don't do ERAT stuff if running guest mode */
+	mfmsr	r3
+	andis.	r0,r3,MSR_GS@h
+	bne	1f
+
+	/* Now set the I-ERAT watermark to 15 */
+	lis	r4,(MMUCR0_TLBSEL_I|MMUCR0_ECL)@h
+	mtspr	SPRN_MMUCR0, r4
+	li	r4,A2_IERAT_SIZE-1
+	PPC_ERATWE(r4,r4,3)
+
+	/* Now set the D-ERAT watermark to 31 */
+	lis	r4,(MMUCR0_TLBSEL_D|MMUCR0_ECL)@h
+	mtspr	SPRN_MMUCR0, r4
+	li	r4,A2_DERAT_SIZE-1
+	PPC_ERATWE(r4,r4,3)
+
+	/* And invalidate the beast just in case. That won't get rid of
+	 * a bolted entry though it will be in LRU and so will go away eventually
+	 * but let's not bother for now
+	 */
+	PPC_ERATILX(0,0,0)
+1:
+	blr
+
+_GLOBAL(__restore_cpu_a2)
+	b	__setup_cpu_a2
diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index 70cbae1..69d1e76 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -62,10 +62,12 @@ extern void __setup_cpu_745x(unsigned long offset, struct cpu_spec* spec);
 extern void __setup_cpu_ppc970(unsigned long offset, struct cpu_spec* spec);
 extern void __setup_cpu_ppc970MP(unsigned long offset, struct cpu_spec* spec);
 extern void __setup_cpu_pa6t(unsigned long offset, struct cpu_spec* spec);
+extern void __setup_cpu_a2(unsigned long offset, struct cpu_spec* spec);
 extern void __restore_cpu_pa6t(void);
 extern void __restore_cpu_ppc970(void);
 extern void __setup_cpu_power7(unsigned long offset, struct cpu_spec* spec);
 extern void __restore_cpu_power7(void);
+extern void __restore_cpu_a2(void);
 #endif /* CONFIG_PPC64 */
 #if defined(CONFIG_E500)
 extern void __setup_cpu_e5500(unsigned long offset, struct cpu_spec* spec);
@@ -2011,7 +2013,26 @@ static struct cpu_spec __initdata cpu_specs[] = {
 #endif /* CONFIG_PPC32 */
 #endif /* CONFIG_E500 */
 
-#ifdef CONFIG_PPC_BOOK3E_64
+#ifdef CONFIG_PPC_A2
+	{	/* Standard A2 (>= DD2) + FPU core */
+		.pvr_mask		= 0xffff0000,
+		.pvr_value		= 0x00480000,
+		.cpu_name		= "A2 (>= DD2)",
+		.cpu_features		= CPU_FTRS_A2,
+		.cpu_user_features	= COMMON_USER_PPC64,
+		.mmu_features		= MMU_FTR_TYPE_3E | MMU_FTR_USE_TLBILX |
+					  MMU_FTR_USE_TLBIVAX_BCAST |
+					  MMU_FTR_LOCK_BCAST_INVAL |
+					  MMU_FTR_USE_TLBRSRV |
+					  MMU_FTR_USE_PAIRED_MAS,
+		.icache_bsize		= 64,
+		.dcache_bsize		= 64,
+		.num_pmcs		= 0,
+		.cpu_setup		= __setup_cpu_a2,
+		.cpu_restore		= __restore_cpu_a2,
+		.machine_check		= machine_check_generic,
+		.platform		= "ppca2",
+	},
 	{	/* This is a default entry to get going, to be replaced by
 		 * a real one at some stage
 		 */
@@ -2029,7 +2050,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.machine_check		= machine_check_generic,
 		.platform		= "power6",
 	},
-#endif
+#endif /* CONFIG_PPC_A2 */
 };
 
 static struct cpu_spec the_cpu_spec;
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index 111138c..7c1e1c6 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -107,6 +107,10 @@ config POWER4
 	depends on PPC64 && PPC_BOOK3S
 	def_bool y
 
+config PPC_A2
+	bool
+	depends on PPC_BOOK3E_64
+
 config TUNE_CELL
 	bool "Optimize for Cell Broadband Engine"
 	depends on PPC64 && PPC_BOOK3S
-- 
1.7.1
