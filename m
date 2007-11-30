Return-Path: <benh@ozlabs.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 30 Nov 2007 17:10:43 +1100
Subject: [PATCH 4/24] powerpc: Fix 440/440A machine check handling
In-Reply-To: <1196403038.569525.367459803520.qpush@grosgo>
Message-Id: <20071130061146.66725DDF06@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This removes CONFIG_440A which was a problem for multiplatform
kernels and instead fixes up the IVOR at runtime from a setup_cpu
function. The "A" version of the machine check also tweaks the
regs->trap value to differenciate the 2 versions at the C level.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

I know we should add a cputable hook for the processor machine check
handler and get rid of the ifdef's, I just didn't have time to do
it yet.

 arch/powerpc/kernel/cpu_setup_44x.S |    8 ++++
 arch/powerpc/kernel/cputable.c      |    5 +++
 arch/powerpc/kernel/head_44x.S      |   14 ++++++--
 arch/powerpc/kernel/head_booke.h    |    2 -
 arch/powerpc/kernel/traps.c         |   58 +++++++++++++++++++++++++++++-------
 arch/powerpc/platforms/44x/Kconfig  |    5 ---
 include/asm-powerpc/ptrace.h        |    3 +
 include/asm-powerpc/reg_booke.h     |    3 -
 8 files changed, 75 insertions(+), 23 deletions(-)

Index: linux-work/arch/powerpc/kernel/cpu_setup_44x.S
===================================================================
--- linux-work.orig/arch/powerpc/kernel/cpu_setup_44x.S	2007-11-26 09:38:47.000000000 +1100
+++ linux-work/arch/powerpc/kernel/cpu_setup_44x.S	2007-11-26 10:09:37.000000000 +1100
@@ -23,11 +23,19 @@ _GLOBAL(__setup_cpu_440epx)
 	mflr	r4
 	bl	__init_fpu_44x
 	bl	__plb_disable_wrp
+	bl	__fixup_440A_mcheck
 	mtlr	r4
 	blr
 _GLOBAL(__setup_cpu_440grx)
 	b	__plb_disable_wrp
+_GLOBAL(__setup_cpu_440gx)
+	b	__fixup_440A_mcheck
 
+ /* Temporary fixup for arch/ppc until we kill the whole thing */
+#ifndef CONFIG_PPC_MERGE
+_GLOBAL(__fixup_440A_mcheck)
+	blr
+#endif
 
 /* enable APU between CPU and FPU */
 _GLOBAL(__init_fpu_44x)
Index: linux-work/arch/powerpc/kernel/cputable.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/cputable.c	2007-11-26 09:38:47.000000000 +1100
+++ linux-work/arch/powerpc/kernel/cputable.c	2007-11-26 09:43:51.000000000 +1100
@@ -33,6 +33,7 @@ EXPORT_SYMBOL(cur_cpu_spec);
 #ifdef CONFIG_PPC32
 extern void __setup_cpu_440ep(unsigned long offset, struct cpu_spec* spec);
 extern void __setup_cpu_440epx(unsigned long offset, struct cpu_spec* spec);
+extern void __setup_cpu_440gx(unsigned long offset, struct cpu_spec* spec);
 extern void __setup_cpu_440grx(unsigned long offset, struct cpu_spec* spec);
 extern void __setup_cpu_603(unsigned long offset, struct cpu_spec* spec);
 extern void __setup_cpu_604(unsigned long offset, struct cpu_spec* spec);
@@ -1193,6 +1194,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_user_features	= COMMON_USER_BOOKE,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
+		.cpu_setup		= __setup_cpu_440gx,
 		.platform		= "ppc440",
 	},
 	{ /* 440GX Rev. B */
@@ -1203,6 +1205,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_user_features	= COMMON_USER_BOOKE,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
+		.cpu_setup		= __setup_cpu_440gx,
 		.platform		= "ppc440",
 	},
 	{ /* 440GX Rev. C */
@@ -1213,6 +1216,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_user_features	= COMMON_USER_BOOKE,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
+		.cpu_setup		= __setup_cpu_440gx,
 		.platform		= "ppc440",
 	},
 	{ /* 440GX Rev. F */
@@ -1223,6 +1227,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_user_features	= COMMON_USER_BOOKE,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
+		.cpu_setup		= __setup_cpu_440gx,
 		.platform		= "ppc440",
 	},
 	{ /* 440SP Rev. A */
Index: linux-work/arch/powerpc/kernel/head_44x.S
===================================================================
--- linux-work.orig/arch/powerpc/kernel/head_44x.S	2007-11-26 09:38:47.000000000 +1100
+++ linux-work/arch/powerpc/kernel/head_44x.S	2007-11-26 09:43:51.000000000 +1100
@@ -289,11 +289,8 @@ interrupt_base:
 	CRITICAL_EXCEPTION(0x0100, CriticalInput, unknown_exception)
 
 	/* Machine Check Interrupt */
-#ifdef CONFIG_440A
-	MCHECK_EXCEPTION(0x0200, MachineCheck, machine_check_exception)
-#else
 	CRITICAL_EXCEPTION(0x0200, MachineCheck, machine_check_exception)
-#endif
+	MCHECK_EXCEPTION(0x0210, MachineCheckA, machine_check_exception)
 
 	/* Data Storage Interrupt */
 	START_EXCEPTION(DataStorage)
@@ -674,6 +671,15 @@ finish_tlb_load:
  */
 
 /*
+ * Adjust the machine check IVOR on 440A cores
+ */
+_GLOBAL(__fixup_440A_mcheck)
+	li	r3,MachineCheckA@l
+	mtspr	SPRN_IVOR1,r3
+	sync
+	blr
+
+/*
  * extern void giveup_altivec(struct task_struct *prev)
  *
  * The 44x core does not have an AltiVec unit.
Index: linux-work/arch/powerpc/kernel/traps.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/traps.c	2007-11-26 09:38:47.000000000 +1100
+++ linux-work/arch/powerpc/kernel/traps.c	2007-11-26 09:43:51.000000000 +1100
@@ -334,18 +334,25 @@ static inline int check_io_access(struct
 #define clear_single_step(regs)	((regs)->msr &= ~MSR_SE)
 #endif
 
-static int generic_machine_check_exception(struct pt_regs *regs)
+#if defined(CONFIG_4xx)
+static int decode_machine_check_4xx(struct pt_regs *regs)
 {
 	unsigned long reason = get_mc_reason(regs);
 
-#if defined(CONFIG_4xx) && !defined(CONFIG_440A)
 	if (reason & ESR_IMCP) {
 		printk("Instruction");
 		mtspr(SPRN_ESR, reason & ~ESR_IMCP);
 	} else
 		printk("Data");
 	printk(" machine check in kernel mode.\n");
-#elif defined(CONFIG_440A)
+
+	return 0;
+}
+
+static int decode_machine_check_4xxA(struct pt_regs *regs)
+{
+	unsigned long reason = get_mc_reason(regs);
+
 	printk("Machine check in kernel mode.\n");
 	if (reason & ESR_IMCP){
 		printk("Instruction Synchronous Machine Check exception\n");
@@ -375,7 +382,13 @@ static int generic_machine_check_excepti
 		/* Clear MCSR */
 		mtspr(SPRN_MCSR, mcsr);
 	}
-#elif defined (CONFIG_E500)
+	return 0;
+}
+#elif defined(CONFIG_E500)
+static int decode_machine_check_e500(struct pt_regs *regs)
+{
+	unsigned long reason = get_mc_reason(regs);
+
 	printk("Machine check in kernel mode.\n");
 	printk("Caused by (from MCSR=%lx): ", reason);
 
@@ -403,7 +416,14 @@ static int generic_machine_check_excepti
 		printk("Bus - Instruction Parity Error\n");
 	if (reason & MCSR_BUS_RPERR)
 		printk("Bus - Read Parity Error\n");
-#elif defined (CONFIG_E200)
+
+	return 0;
+}
+#elif defined(CONFIG_E200)
+static int decode_machine_check_e200(struct pt_regs *regs)
+{
+	unsigned long reason = get_mc_reason(regs);
+
 	printk("Machine check in kernel mode.\n");
 	printk("Caused by (from MCSR=%lx): ", reason);
 
@@ -421,7 +441,14 @@ static int generic_machine_check_excepti
 		printk("Bus - Read Bus Error on data load\n");
 	if (reason & MCSR_BUS_WRERR)
 		printk("Bus - Write Bus Error on buffered store or cache line push\n");
-#else /* !CONFIG_4xx && !CONFIG_E500 && !CONFIG_E200 */
+
+	return 0;
+}
+#else
+static int decode_machine_check_generic(struct pt_regs *regs)
+{
+	unsigned long reason = get_mc_reason(regs);
+
 	printk("Machine check in kernel mode.\n");
 	printk("Caused by (from SRR1=%lx): ", reason);
 	switch (reason & 0x601F0000) {
@@ -451,10 +478,9 @@ static int generic_machine_check_excepti
 	default:
 		printk("Unknown values in msr\n");
 	}
-#endif /* CONFIG_4xx */
-
 	return 0;
 }
+#endif /* everything else */
 
 void machine_check_exception(struct pt_regs *regs)
 {
@@ -463,8 +489,20 @@ void machine_check_exception(struct pt_r
 	/* See if any machine dependent calls */
 	if (ppc_md.machine_check_exception)
 		recover = ppc_md.machine_check_exception(regs);
-	else
-		recover = generic_machine_check_exception(regs);
+	else {
+#ifdef CONFIG_4xx
+		if (IS_MCHECK_EXC(regs))
+			recover = decode_machine_check_4xxA(regs);
+		else
+			recover = decode_machine_check_4xx(regs);
+#elif defined (CONFIG_E500)
+		recover = decode_machine_check_e500(regs);
+#elif defined (CONFIG_E200)
+		recover = decode_machine_check_e200(regs);
+#else
+		recover = decode_machine_check_generic(regs);
+#endif
+	}
 
 	if (recover)
 		return;
Index: linux-work/arch/powerpc/platforms/44x/Kconfig
===================================================================
--- linux-work.orig/arch/powerpc/platforms/44x/Kconfig	2007-11-26 09:38:47.000000000 +1100
+++ linux-work/arch/powerpc/platforms/44x/Kconfig	2007-11-26 10:08:44.000000000 +1100
@@ -62,11 +62,6 @@ config 440GX
 config 440SP
 	bool
 
-config 440A
-	bool
-	depends on 440GX || 440EPX
-	default y
-
 # 44x errata/workaround config symbols, selected by the CPU models above
 config IBM440EP_ERR42
 	bool
Index: linux-work/arch/powerpc/kernel/head_booke.h
===================================================================
--- linux-work.orig/arch/powerpc/kernel/head_booke.h	2007-11-26 09:38:47.000000000 +1100
+++ linux-work/arch/powerpc/kernel/head_booke.h	2007-11-26 09:43:51.000000000 +1100
@@ -166,7 +166,7 @@ label:
 	mfspr	r5,SPRN_ESR;					\
 	stw	r5,_ESR(r11);					\
 	addi	r3,r1,STACK_FRAME_OVERHEAD;			\
-	EXC_XFER_TEMPLATE(hdlr, n+2, (MSR_KERNEL & ~(MSR_ME|MSR_DE|MSR_CE)), \
+	EXC_XFER_TEMPLATE(hdlr, n+4, (MSR_KERNEL & ~(MSR_ME|MSR_DE|MSR_CE)), \
 			  NOCOPY, mcheck_transfer_to_handler,   \
 			  ret_from_mcheck_exc)
 
Index: linux-work/include/asm-powerpc/ptrace.h
===================================================================
--- linux-work.orig/include/asm-powerpc/ptrace.h	2007-11-26 09:38:47.000000000 +1100
+++ linux-work/include/asm-powerpc/ptrace.h	2007-11-26 09:43:51.000000000 +1100
@@ -106,7 +106,8 @@ extern int ptrace_put_reg(struct task_st
  */
 #define FULL_REGS(regs)		(((regs)->trap & 1) == 0)
 #ifndef __powerpc64__
-#define IS_CRITICAL_EXC(regs)	(((regs)->trap & 2) == 0)
+#define IS_CRITICAL_EXC(regs)	(((regs)->trap & 2) != 0)
+#define IS_MCHECK_EXC(regs)	(((regs)->trap & 4) != 0)
 #endif /* ! __powerpc64__ */
 #define TRAP(regs)		((regs)->trap & ~0xF)
 #ifdef __powerpc64__
Index: linux-work/include/asm-powerpc/reg_booke.h
===================================================================
--- linux-work.orig/include/asm-powerpc/reg_booke.h	2007-11-26 09:38:47.000000000 +1100
+++ linux-work/include/asm-powerpc/reg_booke.h	2007-11-26 09:43:51.000000000 +1100
@@ -207,7 +207,6 @@
 #define	CCR1_TCS	0x00000080 /* Timer Clock Select */
 
 /* Bit definitions for the MCSR. */
-#ifdef CONFIG_440A
 #define MCSR_MCS	0x80000000 /* Machine Check Summary */
 #define MCSR_IB		0x40000000 /* Instruction PLB Error */
 #define MCSR_DRB	0x20000000 /* Data Read PLB Error */
@@ -217,7 +216,7 @@
 #define MCSR_DCSP	0x02000000 /* D-Cache Search Parity Error */
 #define MCSR_DCFP	0x01000000 /* D-Cache Flush Parity Error */
 #define MCSR_IMPE	0x00800000 /* Imprecise Machine Check Exception */
-#endif
+
 #ifdef CONFIG_E500
 #define MCSR_MCP 	0x80000000UL /* Machine Check Input Pin */
 #define MCSR_ICPERR 	0x40000000UL /* I-Cache Parity Error */
