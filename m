Return-Path: <benh@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 51ABEB707C
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 15 Jul 2009 16:52:59 +1000 (EST)
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 15 Jul 2009 16:52:54 +1000
Subject: [PATCH 2/4] powerpc: Use names rather than numbers for SPRGs (v2)
Message-Id: <20090715065259.3E19EDDDD4@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The kernel uses SPRG registers for various purposes, typically in
low level assembly code as scratch registers or to hold per-cpu
global infos such as the PACA or the current thread_info pointer.

We want to be able to easily shuffle the usage of those registers
as some implementations have specific constraints realted to some
of them, for example, some have userspace readable aliases, etc..
and the current choice isn't always the best.

This patch should not change any code generation, and replaces the
usage of SPRN_SPRGn everywhere in the kernel with a named replacement
and adds documentation next to the definition of the names as to
what those are used for on each processor family.

The only parts that still use the original numbers are bits of KVM
or suspend/resume code that just blindly needs to save/restore all
the SPRGs.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
--

v2. Missed some iseries bits

 arch/powerpc/include/asm/exception-64s.h   |   18 ++--
 arch/powerpc/include/asm/reg.h             |  113 ++++++++++++++++++++++++++
 arch/powerpc/kernel/cpu_setup_6xx.S        |    2 
 arch/powerpc/kernel/entry_32.S             |   20 ++--
 arch/powerpc/kernel/entry_64.S             |    4 
 arch/powerpc/kernel/exceptions-64s.S       |   44 +++-------
 arch/powerpc/kernel/fpu.S                  |    2 
 arch/powerpc/kernel/head_32.S              |   40 ++++-----
 arch/powerpc/kernel/head_40x.S             |  124 ++++++++++++++---------------
 arch/powerpc/kernel/head_44x.S             |   56 ++++++-------
 arch/powerpc/kernel/head_64.S              |   14 +--
 arch/powerpc/kernel/head_8xx.S             |   13 +--
 arch/powerpc/kernel/head_booke.h           |   50 ++++-------
 arch/powerpc/kernel/head_fsl_booke.S       |   60 +++++++-------
 arch/powerpc/kernel/setup_64.c             |    4 
 arch/powerpc/kernel/vector.S               |    2 
 arch/powerpc/kvm/booke_interrupts.S        |   18 ++--
 arch/powerpc/mm/hash_low_32.S              |    4 
 arch/powerpc/platforms/iseries/exception.S |   28 +++---
 arch/powerpc/platforms/iseries/exception.h |    4 
 20 files changed, 356 insertions(+), 264 deletions(-)

--- linux-work.orig/arch/powerpc/include/asm/reg.h	2009-07-13 10:54:38.000000000 +1000
+++ linux-work/arch/powerpc/include/asm/reg.h	2009-07-15 15:08:10.000000000 +1000
@@ -646,6 +646,119 @@
 #endif
 
 /*
+ * SPRG usage:
+ *
+ * All 64-bit:
+ *	- SPRG3 stores PACA pointer
+ *
+ * 64-bit server:
+ *	- SPRG0 unused (reserved for HV on Power4)
+ *	- SPRG1 scratch for exception vectors
+ *	- SPRG2 scratch for exception vectors
+ *
+ * All 32-bit:
+ *	- SPRG3 current thread_info pointer
+ *        (virtual on BookE, physical on others)
+ *
+ * 32-bit classic:
+ *	- SPRG0 scratch for exception vectors
+ *	- SPRG1 scratch for exception vectors
+ *	- SPRG2 indicator that we are in RTAS
+ *	- SPRG4 (603 only) pseudo TLB LRU data
+ *
+ * 32-bit 40x:
+ *	- SPRG0 scratch for exception vectors
+ *	- SPRG1 scratch for exception vectors
+ *	- SPRG2 scratch for exception vectors
+ *	- SPRG4 scratch for exception vectors (not 403)
+ *	- SPRG5 scratch for exception vectors (not 403)
+ *	- SPRG6 scratch for exception vectors (not 403)
+ *	- SPRG7 scratch for exception vectors (not 403)
+ *
+ * 32-bit 440 and FSL BookE:
+ *	- SPRG0 scratch for exception vectors
+ *	- SPRG1 scratch for exception vectors (*)
+ *	- SPRG2 scratch for crit interrupts handler
+ *	- SPRG4 scratch for exception vectors
+ *	- SPRG5 scratch for exception vectors
+ *	- SPRG6 scratch for machine check handler
+ *	- SPRG7 scratch for exception vectors
+ *	- SPRG9 scratch for debug vectors (e500 only)
+ *
+ *      Additionally, BookE separates "read" and "write"
+ *      of those registers. That allows to use the userspace
+ *      readable variant for reads, which can avoid a fault
+ *      with KVM type virtualization.
+ *
+ *      (*) Under KVM, the host SPRG1 is used to point to
+ *      the current VCPU data structure
+ *
+ * 32-bit 8xx:
+ *	- SPRG0 scratch for exception vectors
+ *	- SPRG1 scratch for exception vectors
+ *	- SPRG2 apparently unused but initialized
+ *
+ */
+#ifdef CONFIG_PPC64
+#define SPRN_SPRG_PACA 		SPRN_SPRG3
+#else
+#define SPRN_SPRG_THREAD 	SPRN_SPRG3
+#endif
+
+#ifdef CONFIG_PPC_BOOK3S_64
+#define SPRN_SPRG_SCRATCH0	SPRN_SPRG1
+#define SPRN_SPRG_SCRATCH1	SPRN_SPRG2
+#endif
+
+#ifdef CONFIG_PPC_BOOK3S_32
+#define SPRN_SPRG_SCRATCH0	SPRN_SPRG0
+#define SPRN_SPRG_SCRATCH1	SPRN_SPRG1
+#define SPRN_SPRG_RTAS		SPRN_SPRG2
+#define SPRN_SPRG_603_LRU	SPRN_SPRG4
+#endif
+
+#ifdef CONFIG_40x
+#define SPRN_SPRG_SCRATCH0	SPRN_SPRG0
+#define SPRN_SPRG_SCRATCH1	SPRN_SPRG1
+#define SPRN_SPRG_SCRATCH2	SPRN_SPRG2
+#define SPRN_SPRG_SCRATCH3	SPRN_SPRG4
+#define SPRN_SPRG_SCRATCH4	SPRN_SPRG5
+#define SPRN_SPRG_SCRATCH5	SPRN_SPRG6
+#define SPRN_SPRG_SCRATCH6	SPRN_SPRG7
+#endif
+
+#ifdef CONFIG_BOOKE
+#define SPRN_SPRG_RSCRATCH0	SPRN_SPRG0
+#define SPRN_SPRG_WSCRATCH0	SPRN_SPRG0
+#define SPRN_SPRG_RSCRATCH1	SPRN_SPRG1
+#define SPRN_SPRG_WSCRATCH1	SPRN_SPRG1
+#define SPRN_SPRG_RSCRATCH_CRIT	SPRN_SPRG2
+#define SPRN_SPRG_WSCRATCH_CRIT	SPRN_SPRG2
+#define SPRN_SPRG_RSCRATCH2	SPRN_SPRG4R
+#define SPRN_SPRG_WSCRATCH2	SPRN_SPRG4W
+#define SPRN_SPRG_RSCRATCH3	SPRN_SPRG5R
+#define SPRN_SPRG_WSCRATCH3	SPRN_SPRG5W
+#define SPRN_SPRG_RSCRATCH_MC	SPRN_SPRG6R
+#define SPRN_SPRG_WSCRATCH_MC	SPRN_SPRG6W
+#define SPRN_SPRG_RSCRATCH4	SPRN_SPRG7R
+#define SPRN_SPRG_WSCRATCH4	SPRN_SPRG7W
+#ifdef CONFIG_E200
+#define SPRN_SPRG_RSCRATCH_DBG	SPRN_SPRG6R
+#define SPRN_SPRG_WSCRATCH_DBG	SPRN_SPRG6W
+#else
+#define SPRN_SPRG_RSCRATCH_DBG	SPRN_SPRG9
+#define SPRN_SPRG_WSCRATCH_DBG	SPRN_SPRG9
+#endif
+#define SPRN_SPRG_RVCPU		SPRN_SPRG1
+#define SPRN_SPRG_WVCPU		SPRN_SPRG1
+#endif
+
+#ifdef CONFIG_8xx
+#define SPRN_SPRG_SCRATCH0	SPRN_SPRG0
+#define SPRN_SPRG_SCRATCH1	SPRN_SPRG1
+#endif
+
+/*
  * An mtfsf instruction with the L bit set. On CPUs that support this a
  * full 64bits of FPSCR is restored and on other CPUs the L bit is ignored.
  *
Index: linux-work/arch/powerpc/include/asm/exception-64s.h
===================================================================
--- linux-work.orig/arch/powerpc/include/asm/exception-64s.h	2009-07-13 11:35:45.000000000 +1000
+++ linux-work/arch/powerpc/include/asm/exception-64s.h	2009-07-15 15:07:50.000000000 +1000
@@ -57,12 +57,12 @@
 	addi	reg,reg,(label)-_stext;	/* virt addr of handler ... */
 
 #define EXCEPTION_PROLOG_1(area)				\
-	mfspr	r13,SPRN_SPRG3;		/* get paca address into r13 */	\
+	mfspr	r13,SPRN_SPRG_PACA;	/* get paca address into r13 */	\
 	std	r9,area+EX_R9(r13);	/* save r9 - r12 */		\
 	std	r10,area+EX_R10(r13);					\
 	std	r11,area+EX_R11(r13);					\
 	std	r12,area+EX_R12(r13);					\
-	mfspr	r9,SPRN_SPRG1;						\
+	mfspr	r9,SPRN_SPRG_SCRATCH0;					\
 	std	r9,area+EX_R13(r13);					\
 	mfcr	r9
 
@@ -144,7 +144,7 @@
 	.globl label##_pSeries;				\
 label##_pSeries:					\
 	HMT_MEDIUM;					\
-	mtspr	SPRN_SPRG1,r13;		/* save r13 */	\
+	mtspr	SPRN_SPRG_SCRATCH0,r13;		/* save r13 */	\
 	EXCEPTION_PROLOG_PSERIES(PACA_EXGEN, label##_common)
 
 #define HSTD_EXCEPTION_PSERIES(n, label)		\
@@ -152,13 +152,13 @@ label##_pSeries:					\
 	.globl label##_pSeries;				\
 label##_pSeries:					\
 	HMT_MEDIUM;					\
-	mtspr	SPRN_SPRG1,r20;		/* save r20 */	\
+	mtspr	SPRN_SPRG_SCRATCH0,r20;	/* save r20 */	\
 	mfspr	r20,SPRN_HSRR0;		/* copy HSRR0 to SRR0 */ \
 	mtspr	SPRN_SRR0,r20;				\
 	mfspr	r20,SPRN_HSRR1;		/* copy HSRR0 to SRR0 */ \
 	mtspr	SPRN_SRR1,r20;				\
-	mfspr	r20,SPRN_SPRG1;		/* restore r20 */ \
-	mtspr	SPRN_SPRG1,r13;		/* save r13 */	\
+	mfspr	r20,SPRN_SPRG_SCRATCH0;	/* restore r20 */ \
+	mtspr	SPRN_SPRG_SCRATCH0,r13;		/* save r13 */	\
 	EXCEPTION_PROLOG_PSERIES(PACA_EXGEN, label##_common)
 
 
@@ -167,15 +167,15 @@ label##_pSeries:					\
 	.globl label##_pSeries;						\
 label##_pSeries:							\
 	HMT_MEDIUM;							\
-	mtspr	SPRN_SPRG1,r13;		/* save r13 */			\
-	mfspr	r13,SPRN_SPRG3;		/* get paca address into r13 */	\
+	mtspr	SPRN_SPRG_SCRATCH0,r13;	/* save r13 */			\
+	mfspr	r13,SPRN_SPRG_PACA;	/* get paca address into r13 */	\
 	std	r9,PACA_EXGEN+EX_R9(r13);	/* save r9, r10 */	\
 	std	r10,PACA_EXGEN+EX_R10(r13);				\
 	lbz	r10,PACASOFTIRQEN(r13);					\
 	mfcr	r9;							\
 	cmpwi	r10,0;							\
 	beq	masked_interrupt;					\
-	mfspr	r10,SPRN_SPRG1;						\
+	mfspr	r10,SPRN_SPRG_SCRATCH0;					\
 	std	r10,PACA_EXGEN+EX_R13(r13);				\
 	std	r11,PACA_EXGEN+EX_R11(r13);				\
 	std	r12,PACA_EXGEN+EX_R12(r13);				\
Index: linux-work/arch/powerpc/kernel/cpu_setup_6xx.S
===================================================================
--- linux-work.orig/arch/powerpc/kernel/cpu_setup_6xx.S	2009-07-13 10:54:38.000000000 +1000
+++ linux-work/arch/powerpc/kernel/cpu_setup_6xx.S	2009-07-13 11:35:46.000000000 +1000
@@ -21,7 +21,7 @@ _GLOBAL(__setup_cpu_603)
 	mflr	r4
 BEGIN_MMU_FTR_SECTION
 	li	r10,0
-	mtspr	SPRN_SPRG4,r10		/* init SW LRU tracking */
+	mtspr	SPRN_SPRG_603_LRU,r10		/* init SW LRU tracking */
 END_MMU_FTR_SECTION_IFSET(MMU_FTR_NEED_DTLB_SW_LRU)
 BEGIN_FTR_SECTION
 	bl	__init_fpu_registers
Index: linux-work/arch/powerpc/kernel/entry_32.S
===================================================================
--- linux-work.orig/arch/powerpc/kernel/entry_32.S	2009-07-13 10:54:38.000000000 +1000
+++ linux-work/arch/powerpc/kernel/entry_32.S	2009-07-13 11:35:46.000000000 +1000
@@ -88,7 +88,7 @@ crit_transfer_to_handler:
 	mfspr	r0,SPRN_SRR1
 	stw	r0,_SRR1(r11)
 
-	mfspr	r8,SPRN_SPRG3
+	mfspr	r8,SPRN_SPRG_THREAD
 	lwz	r0,KSP_LIMIT(r8)
 	stw	r0,SAVED_KSP_LIMIT(r11)
 	rlwimi	r0,r1,0,0,(31-THREAD_SHIFT)
@@ -108,7 +108,7 @@ crit_transfer_to_handler:
 	mfspr	r0,SPRN_SRR1
 	stw	r0,crit_srr1@l(0)
 
-	mfspr	r8,SPRN_SPRG3
+	mfspr	r8,SPRN_SPRG_THREAD
 	lwz	r0,KSP_LIMIT(r8)
 	stw	r0,saved_ksp_limit@l(0)
 	rlwimi	r0,r1,0,0,(31-THREAD_SHIFT)
@@ -138,7 +138,7 @@ transfer_to_handler:
 	mfspr	r2,SPRN_XER
 	stw	r12,_CTR(r11)
 	stw	r2,_XER(r11)
-	mfspr	r12,SPRN_SPRG3
+	mfspr	r12,SPRN_SPRG_THREAD
 	addi	r2,r12,-THREAD
 	tovirt(r2,r2)			/* set r2 to current */
 	beq	2f			/* if from user, fix up THREAD.regs */
@@ -680,7 +680,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_SPE)
 
 	tophys(r0,r4)
 	CLR_TOP32(r0)
-	mtspr	SPRN_SPRG3,r0	/* Update current THREAD phys addr */
+	mtspr	SPRN_SPRG_THREAD,r0	/* Update current THREAD phys addr */
 	lwz	r1,KSP(r4)	/* Load new stack pointer */
 
 	/* save the old current 'last' for return value */
@@ -1057,7 +1057,7 @@ exc_exit_restart_end:
 #ifdef CONFIG_40x
 	.globl	ret_from_crit_exc
 ret_from_crit_exc:
-	mfspr	r9,SPRN_SPRG3
+	mfspr	r9,SPRN_SPRG_THREAD
 	lis	r10,saved_ksp_limit@ha;
 	lwz	r10,saved_ksp_limit@l(r10);
 	tovirt(r9,r9);
@@ -1074,7 +1074,7 @@ ret_from_crit_exc:
 #ifdef CONFIG_BOOKE
 	.globl	ret_from_crit_exc
 ret_from_crit_exc:
-	mfspr	r9,SPRN_SPRG3
+	mfspr	r9,SPRN_SPRG_THREAD
 	lwz	r10,SAVED_KSP_LIMIT(r1)
 	stw	r10,KSP_LIMIT(r9)
 	RESTORE_xSRR(SRR0,SRR1);
@@ -1083,7 +1083,7 @@ ret_from_crit_exc:
 
 	.globl	ret_from_debug_exc
 ret_from_debug_exc:
-	mfspr	r9,SPRN_SPRG3
+	mfspr	r9,SPRN_SPRG_THREAD
 	lwz	r10,SAVED_KSP_LIMIT(r1)
 	stw	r10,KSP_LIMIT(r9)
 	lwz	r9,THREAD_INFO-THREAD(r9)
@@ -1097,7 +1097,7 @@ ret_from_debug_exc:
 
 	.globl	ret_from_mcheck_exc
 ret_from_mcheck_exc:
-	mfspr	r9,SPRN_SPRG3
+	mfspr	r9,SPRN_SPRG_THREAD
 	lwz	r10,SAVED_KSP_LIMIT(r1)
 	stw	r10,KSP_LIMIT(r9)
 	RESTORE_xSRR(SRR0,SRR1);
@@ -1255,7 +1255,7 @@ _GLOBAL(enter_rtas)
 	MTMSRD(r0)		/* don't get trashed */
 	li	r9,MSR_KERNEL & ~(MSR_IR|MSR_DR)
 	mtlr	r6
-	mtspr	SPRN_SPRG2,r7
+	mtspr	SPRN_SPRG_RTAS,r7
 	mtspr	SPRN_SRR0,r8
 	mtspr	SPRN_SRR1,r9
 	RFI
@@ -1265,7 +1265,7 @@ _GLOBAL(enter_rtas)
 	FIX_SRR1(r9,r0)
 	addi	r1,r1,INT_FRAME_SIZE
 	li	r0,0
-	mtspr	SPRN_SPRG2,r0
+	mtspr	SPRN_SPRG_RTAS,r0
 	mtspr	SPRN_SRR0,r8
 	mtspr	SPRN_SRR1,r9
 	RFI			/* return to caller */
Index: linux-work/arch/powerpc/kernel/exceptions-64s.S
===================================================================
--- linux-work.orig/arch/powerpc/kernel/exceptions-64s.S	2009-07-13 11:35:45.000000000 +1000
+++ linux-work/arch/powerpc/kernel/exceptions-64s.S	2009-07-15 15:07:50.000000000 +1000
@@ -24,18 +24,6 @@
  * 0x8000 -        : Early init and support code
  */
 
-
-/*
- *   SPRG Usage
- *
- *   Register	Definition
- *
- *   SPRG0	reserved for hypervisor
- *   SPRG1	temp - used to save gpr
- *   SPRG2	temp - used to save gpr
- *   SPRG3	virt addr of paca
- */
-
 /*
  * This is the start of the interrupt handlers for pSeries
  * This code runs with relocation off.
@@ -53,16 +41,16 @@ __start_interrupts:
 	. = 0x200
 _machine_check_pSeries:
 	HMT_MEDIUM
-	mtspr	SPRN_SPRG1,r13		/* save r13 */
+	mtspr	SPRN_SPRG_SCRATCH0,r13		/* save r13 */
 	EXCEPTION_PROLOG_PSERIES(PACA_EXMC, machine_check_common)
 
 	. = 0x300
 	.globl data_access_pSeries
 data_access_pSeries:
 	HMT_MEDIUM
-	mtspr	SPRN_SPRG1,r13
+	mtspr	SPRN_SPRG_SCRATCH0,r13
 BEGIN_FTR_SECTION
-	mtspr	SPRN_SPRG2,r12
+	mtspr	SPRN_SPRG_SCRATCH1,r12
 	mfspr	r13,SPRN_DAR
 	mfspr	r12,SPRN_DSISR
 	srdi	r13,r13,60
@@ -71,7 +59,7 @@ BEGIN_FTR_SECTION
 	cmpwi	r13,0x2c
 	beq	do_stab_bolted_pSeries
 	mtcrf	0x80,r12
-	mfspr	r12,SPRN_SPRG2
+	mfspr	r12,SPRN_SPRG_SCRATCH1
 END_FTR_SECTION_IFCLR(CPU_FTR_SLB)
 	EXCEPTION_PROLOG_PSERIES(PACA_EXGEN, data_access_common)
 
@@ -79,8 +67,8 @@ END_FTR_SECTION_IFCLR(CPU_FTR_SLB)
 	.globl data_access_slb_pSeries
 data_access_slb_pSeries:
 	HMT_MEDIUM
-	mtspr	SPRN_SPRG1,r13
-	mfspr	r13,SPRN_SPRG3		/* get paca address into r13 */
+	mtspr	SPRN_SPRG_SCRATCH0,r13
+	mfspr	r13,SPRN_SPRG_PACA		/* get paca address into r13 */
 	std	r3,PACA_EXSLB+EX_R3(r13)
 	mfspr	r3,SPRN_DAR
 	std	r9,PACA_EXSLB+EX_R9(r13)	/* save r9 - r12 */
@@ -93,7 +81,7 @@ data_access_slb_pSeries:
 	std	r10,PACA_EXSLB+EX_R10(r13)
 	std	r11,PACA_EXSLB+EX_R11(r13)
 	std	r12,PACA_EXSLB+EX_R12(r13)
-	mfspr	r10,SPRN_SPRG1
+	mfspr	r10,SPRN_SPRG_SCRATCH0
 	std	r10,PACA_EXSLB+EX_R13(r13)
 	mfspr	r12,SPRN_SRR1		/* and SRR1 */
 #ifndef CONFIG_RELOCATABLE
@@ -117,8 +105,8 @@ data_access_slb_pSeries:
 	.globl instruction_access_slb_pSeries
 instruction_access_slb_pSeries:
 	HMT_MEDIUM
-	mtspr	SPRN_SPRG1,r13
-	mfspr	r13,SPRN_SPRG3		/* get paca address into r13 */
+	mtspr	SPRN_SPRG_SCRATCH0,r13
+	mfspr	r13,SPRN_SPRG_PACA		/* get paca address into r13 */
 	std	r3,PACA_EXSLB+EX_R3(r13)
 	mfspr	r3,SPRN_SRR0		/* SRR0 is faulting address */
 	std	r9,PACA_EXSLB+EX_R9(r13)	/* save r9 - r12 */
@@ -131,7 +119,7 @@ instruction_access_slb_pSeries:
 	std	r10,PACA_EXSLB+EX_R10(r13)
 	std	r11,PACA_EXSLB+EX_R11(r13)
 	std	r12,PACA_EXSLB+EX_R12(r13)
-	mfspr	r10,SPRN_SPRG1
+	mfspr	r10,SPRN_SPRG_SCRATCH0
 	std	r10,PACA_EXSLB+EX_R13(r13)
 	mfspr	r12,SPRN_SRR1		/* and SRR1 */
 #ifndef CONFIG_RELOCATABLE
@@ -161,7 +149,7 @@ BEGIN_FTR_SECTION
 	beq-	1f
 END_FTR_SECTION_IFSET(CPU_FTR_REAL_LE)
 	mr	r9,r13
-	mfspr	r13,SPRN_SPRG3
+	mfspr	r13,SPRN_SPRG_PACA
 	mfspr	r11,SPRN_SRR0
 	ld	r12,PACAKBASE(r13)
 	ld	r10,PACAKMSR(r13)
@@ -230,14 +218,14 @@ masked_interrupt:
 	rotldi	r10,r10,16
 	mtspr	SPRN_SRR1,r10
 	ld	r10,PACA_EXGEN+EX_R10(r13)
-	mfspr	r13,SPRN_SPRG1
+	mfspr	r13,SPRN_SPRG_SCRATCH0
 	rfid
 	b	.
 
 	.align	7
 do_stab_bolted_pSeries:
 	mtcrf	0x80,r12
-	mfspr	r12,SPRN_SPRG2
+	mfspr	r12,SPRN_SPRG_SCRATCH1
 	EXCEPTION_PROLOG_PSERIES(PACA_EXSLB, .do_stab_bolted)
 
 #ifdef CONFIG_PPC_PSERIES
@@ -248,14 +236,14 @@ do_stab_bolted_pSeries:
       .align 7
 system_reset_fwnmi:
 	HMT_MEDIUM
-	mtspr	SPRN_SPRG1,r13		/* save r13 */
+	mtspr	SPRN_SPRG_SCRATCH0,r13		/* save r13 */
 	EXCEPTION_PROLOG_PSERIES(PACA_EXGEN, system_reset_common)
 
 	.globl machine_check_fwnmi
       .align 7
 machine_check_fwnmi:
 	HMT_MEDIUM
-	mtspr	SPRN_SPRG1,r13		/* save r13 */
+	mtspr	SPRN_SPRG_SCRATCH0,r13		/* save r13 */
 	EXCEPTION_PROLOG_PSERIES(PACA_EXMC, machine_check_common)
 
 #endif /* CONFIG_PPC_PSERIES */
@@ -270,7 +258,7 @@ slb_miss_user_pseries:
 	std	r10,PACA_EXGEN+EX_R10(r13)
 	std	r11,PACA_EXGEN+EX_R11(r13)
 	std	r12,PACA_EXGEN+EX_R12(r13)
-	mfspr	r10,SPRG1
+	mfspr	r10,SPRG_SCRATCH0
 	ld	r11,PACA_EXSLB+EX_R9(r13)
 	ld	r12,PACA_EXSLB+EX_R3(r13)
 	std	r10,PACA_EXGEN+EX_R13(r13)
Index: linux-work/arch/powerpc/kernel/fpu.S
===================================================================
--- linux-work.orig/arch/powerpc/kernel/fpu.S	2009-07-13 10:54:38.000000000 +1000
+++ linux-work/arch/powerpc/kernel/fpu.S	2009-07-13 11:35:46.000000000 +1000
@@ -91,7 +91,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_VSX)
 #endif /* CONFIG_SMP */
 	/* enable use of FP after return */
 #ifdef CONFIG_PPC32
-	mfspr	r5,SPRN_SPRG3		/* current task's THREAD (phys) */
+	mfspr	r5,SPRN_SPRG_THREAD		/* current task's THREAD (phys) */
 	lwz	r4,THREAD_FPEXC_MODE(r5)
 	ori	r9,r9,MSR_FP		/* enable FP for current */
 	or	r9,r9,r4
Index: linux-work/arch/powerpc/kernel/head_32.S
===================================================================
--- linux-work.orig/arch/powerpc/kernel/head_32.S	2009-07-13 10:54:38.000000000 +1000
+++ linux-work/arch/powerpc/kernel/head_32.S	2009-07-13 11:35:46.000000000 +1000
@@ -244,8 +244,8 @@ __secondary_hold_acknowledge:
  * task's thread_struct.
  */
 #define EXCEPTION_PROLOG	\
-	mtspr	SPRN_SPRG0,r10;	\
-	mtspr	SPRN_SPRG1,r11;	\
+	mtspr	SPRN_SPRG_SCRATCH0,r10;	\
+	mtspr	SPRN_SPRG_SCRATCH1,r11;	\
 	mfcr	r10;		\
 	EXCEPTION_PROLOG_1;	\
 	EXCEPTION_PROLOG_2
@@ -255,7 +255,7 @@ __secondary_hold_acknowledge:
 	andi.	r11,r11,MSR_PR;	\
 	tophys(r11,r1);			/* use tophys(r1) if kernel */ \
 	beq	1f;		\
-	mfspr	r11,SPRN_SPRG3;	\
+	mfspr	r11,SPRN_SPRG_THREAD;	\
 	lwz	r11,THREAD_INFO-THREAD(r11);	\
 	addi	r11,r11,THREAD_SIZE;	\
 	tophys(r11,r11);	\
@@ -267,9 +267,9 @@ __secondary_hold_acknowledge:
 	stw	r10,_CCR(r11);		/* save registers */ \
 	stw	r12,GPR12(r11);	\
 	stw	r9,GPR9(r11);	\
-	mfspr	r10,SPRN_SPRG0;	\
+	mfspr	r10,SPRN_SPRG_SCRATCH0;	\
 	stw	r10,GPR10(r11);	\
-	mfspr	r12,SPRN_SPRG1;	\
+	mfspr	r12,SPRN_SPRG_SCRATCH1;	\
 	stw	r12,GPR11(r11);	\
 	mflr	r10;		\
 	stw	r10,_LINK(r11);	\
@@ -355,11 +355,11 @@ i##n:								\
  *	-- paulus.
  */
 	. = 0x200
-	mtspr	SPRN_SPRG0,r10
-	mtspr	SPRN_SPRG1,r11
+	mtspr	SPRN_SPRG_SCRATCH0,r10
+	mtspr	SPRN_SPRG_SCRATCH1,r11
 	mfcr	r10
 #ifdef CONFIG_PPC_CHRP
-	mfspr	r11,SPRN_SPRG2
+	mfspr	r11,SPRN_SPRG_RTAS
 	cmpwi	0,r11,0
 	bne	7f
 #endif /* CONFIG_PPC_CHRP */
@@ -367,7 +367,7 @@ i##n:								\
 7:	EXCEPTION_PROLOG_2
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 #ifdef CONFIG_PPC_CHRP
-	mfspr	r4,SPRN_SPRG2
+	mfspr	r4,SPRN_SPRG_RTAS
 	cmpwi	cr1,r4,0
 	bne	cr1,1f
 #endif
@@ -485,7 +485,7 @@ InstructionTLBMiss:
 	mfspr	r3,SPRN_IMISS
 	lis	r1,PAGE_OFFSET@h		/* check if kernel address */
 	cmplw	0,r1,r3
-	mfspr	r2,SPRN_SPRG3
+	mfspr	r2,SPRN_SPRG_THREAD
 	li	r1,_PAGE_USER|_PAGE_PRESENT /* low addresses tested as user */
 	lwz	r2,PGDIR(r2)
 	bge-	112f
@@ -559,7 +559,7 @@ DataLoadTLBMiss:
 	mfspr	r3,SPRN_DMISS
 	lis	r1,PAGE_OFFSET@h		/* check if kernel address */
 	cmplw	0,r1,r3
-	mfspr	r2,SPRN_SPRG3
+	mfspr	r2,SPRN_SPRG_THREAD
 	li	r1,_PAGE_USER|_PAGE_PRESENT /* low addresses tested as user */
 	lwz	r2,PGDIR(r2)
 	bge-	112f
@@ -598,12 +598,12 @@ END_FTR_SECTION_IFCLR(CPU_FTR_NEED_COHER
 	mtcrf	0x80,r2
 BEGIN_MMU_FTR_SECTION
 	li	r0,1
-	mfspr	r1,SPRN_SPRG4
+	mfspr	r1,SPRN_SPRG_603_LRU
 	rlwinm	r2,r3,20,27,31		/* Get Address bits 15:19 */
 	slw	r0,r0,r2
 	xor	r1,r0,r1
 	srw	r0,r1,r2
-	mtspr   SPRN_SPRG4,r1
+	mtspr   SPRN_SPRG_603_LRU,r1
 	mfspr	r2,SPRN_SRR1
 	rlwimi	r2,r0,31-14,14,14
 	mtspr   SPRN_SRR1,r2
@@ -643,7 +643,7 @@ DataStoreTLBMiss:
 	mfspr	r3,SPRN_DMISS
 	lis	r1,PAGE_OFFSET@h		/* check if kernel address */
 	cmplw	0,r1,r3
-	mfspr	r2,SPRN_SPRG3
+	mfspr	r2,SPRN_SPRG_THREAD
 	li	r1,_PAGE_RW|_PAGE_USER|_PAGE_PRESENT /* access flags */
 	lwz	r2,PGDIR(r2)
 	bge-	112f
@@ -678,12 +678,12 @@ END_FTR_SECTION_IFCLR(CPU_FTR_NEED_COHER
 	mtcrf	0x80,r2
 BEGIN_MMU_FTR_SECTION
 	li	r0,1
-	mfspr	r1,SPRN_SPRG4
+	mfspr	r1,SPRN_SPRG_603_LRU
 	rlwinm	r2,r3,20,27,31		/* Get Address bits 15:19 */
 	slw	r0,r0,r2
 	xor	r1,r0,r1
 	srw	r0,r1,r2
-	mtspr   SPRN_SPRG4,r1
+	mtspr   SPRN_SPRG_603_LRU,r1
 	mfspr	r2,SPRN_SRR1
 	rlwimi	r2,r0,31-14,14,14
 	mtspr   SPRN_SRR1,r2
@@ -864,9 +864,9 @@ __secondary_start:
 	tophys(r4,r2)
 	addi	r4,r4,THREAD	/* phys address of our thread_struct */
 	CLR_TOP32(r4)
-	mtspr	SPRN_SPRG3,r4
+	mtspr	SPRN_SPRG_THREAD,r4
 	li	r3,0
-	mtspr	SPRN_SPRG2,r3	/* 0 => not in RTAS */
+	mtspr	SPRN_SPRG_RTAS,r3	/* 0 => not in RTAS */
 
 	/* enable MMU and jump to start_secondary */
 	li	r4,MSR_KERNEL
@@ -947,9 +947,9 @@ start_here:
 	tophys(r4,r2)
 	addi	r4,r4,THREAD	/* init task's THREAD */
 	CLR_TOP32(r4)
-	mtspr	SPRN_SPRG3,r4
+	mtspr	SPRN_SPRG_THREAD,r4
 	li	r3,0
-	mtspr	SPRN_SPRG2,r3	/* 0 => not in RTAS */
+	mtspr	SPRN_SPRG_RTAS,r3	/* 0 => not in RTAS */
 
 	/* stack */
 	lis	r1,init_thread_union@ha
Index: linux-work/arch/powerpc/kernel/setup_64.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/setup_64.c	2009-07-13 10:54:38.000000000 +1000
+++ linux-work/arch/powerpc/kernel/setup_64.c	2009-07-15 13:18:34.000000000 +1000
@@ -142,11 +142,11 @@ early_param("smt-enabled", early_smt_ena
 #define check_smt_enabled()
 #endif /* CONFIG_SMP */
 
-/* Put the paca pointer into r13 and SPRG3 */
+/* Put the paca pointer into r13 and SPRG_PACA */
 void __init setup_paca(int cpu)
 {
 	local_paca = &paca[cpu];
-	mtspr(SPRN_SPRG3, local_paca);
+	mtspr(SPRN_SPRG_PACA, local_paca);
 }
 
 /*
Index: linux-work/arch/powerpc/kernel/vector.S
===================================================================
--- linux-work.orig/arch/powerpc/kernel/vector.S	2009-07-13 10:54:38.000000000 +1000
+++ linux-work/arch/powerpc/kernel/vector.S	2009-07-13 11:35:46.000000000 +1000
@@ -65,7 +65,7 @@ _GLOBAL(load_up_altivec)
 1:
 	/* enable use of VMX after return */
 #ifdef CONFIG_PPC32
-	mfspr	r5,SPRN_SPRG3		/* current task's THREAD (phys) */
+	mfspr	r5,SPRN_SPRG_THREAD		/* current task's THREAD (phys) */
 	oris	r9,r9,MSR_VEC@h
 #else
 	ld	r4,PACACURRENT(r13)
Index: linux-work/arch/powerpc/kernel/head_fsl_booke.S
===================================================================
--- linux-work.orig/arch/powerpc/kernel/head_fsl_booke.S	2009-07-13 10:54:38.000000000 +1000
+++ linux-work/arch/powerpc/kernel/head_fsl_booke.S	2009-07-13 11:35:47.000000000 +1000
@@ -361,7 +361,7 @@ skpinv:	addi	r6,r6,1				/* Increment */
 
 	/* ptr to current thread */
 	addi	r4,r2,THREAD	/* init task's THREAD */
-	mtspr	SPRN_SPRG3,r4
+	mtspr	SPRN_SPRG_THREAD,r4
 
 	/* stack */
 	lis	r1,init_thread_union@h
@@ -532,12 +532,12 @@ interrupt_base:
 
 	/* Data TLB Error Interrupt */
 	START_EXCEPTION(DataTLBError)
-	mtspr	SPRN_SPRG0, r10		/* Save some working registers */
-	mtspr	SPRN_SPRG1, r11
-	mtspr	SPRN_SPRG4W, r12
-	mtspr	SPRN_SPRG5W, r13
+	mtspr	SPRN_SPRG_WSCRATCH0, r10 /* Save some working registers */
+	mtspr	SPRN_SPRG_WSCRATCH1, r11
+	mtspr	SPRN_SPRG_WSCRATCH2, r12
+	mtspr	SPRN_SPRG_WSCRATCH3, r13
 	mfcr	r11
-	mtspr	SPRN_SPRG7W, r11
+	mtspr	SPRN_SPRG_WSCRATCH4, r11
 	mfspr	r10, SPRN_DEAR		/* Get faulting address */
 
 	/* If we are faulting a kernel address, we have to use the
@@ -557,7 +557,7 @@ interrupt_base:
 
 	/* Get the PGD for the current thread */
 3:
-	mfspr	r11,SPRN_SPRG3
+	mfspr	r11,SPRN_SPRG_THREAD
 	lwz	r11,PGDIR(r11)
 
 4:
@@ -598,12 +598,12 @@ interrupt_base:
 	/* The bailout.  Restore registers to pre-exception conditions
 	 * and call the heavyweights to help us out.
 	 */
-	mfspr	r11, SPRN_SPRG7R
+	mfspr	r11, SPRN_SPRG_RSCRATCH4
 	mtcr	r11
-	mfspr	r13, SPRN_SPRG5R
-	mfspr	r12, SPRN_SPRG4R
-	mfspr	r11, SPRN_SPRG1
-	mfspr	r10, SPRN_SPRG0
+	mfspr	r13, SPRN_SPRG_RSCRATCH3
+	mfspr	r12, SPRN_SPRG_RSCRATCH2
+	mfspr	r11, SPRN_SPRG_RSCRATCH1
+	mfspr	r10, SPRN_SPRG_RSCRATCH0
 	b	DataStorage
 
 	/* Instruction TLB Error Interrupt */
@@ -613,12 +613,12 @@ interrupt_base:
 	 * to a different point.
 	 */
 	START_EXCEPTION(InstructionTLBError)
-	mtspr	SPRN_SPRG0, r10		/* Save some working registers */
-	mtspr	SPRN_SPRG1, r11
-	mtspr	SPRN_SPRG4W, r12
-	mtspr	SPRN_SPRG5W, r13
+	mtspr	SPRN_SPRG_WSCRATCH0, r10 /* Save some working registers */
+	mtspr	SPRN_SPRG_WSCRATCH1, r11
+	mtspr	SPRN_SPRG_WSCRATCH2, r12
+	mtspr	SPRN_SPRG_WSCRATCH3, r13
 	mfcr	r11
-	mtspr	SPRN_SPRG7W, r11
+	mtspr	SPRN_SPRG_WSCRATCH4, r11
 	mfspr	r10, SPRN_SRR0		/* Get faulting address */
 
 	/* If we are faulting a kernel address, we have to use the
@@ -638,7 +638,7 @@ interrupt_base:
 
 	/* Get the PGD for the current thread */
 3:
-	mfspr	r11,SPRN_SPRG3
+	mfspr	r11,SPRN_SPRG_THREAD
 	lwz	r11,PGDIR(r11)
 
 4:
@@ -666,12 +666,12 @@ interrupt_base:
 	/* The bailout.  Restore registers to pre-exception conditions
 	 * and call the heavyweights to help us out.
 	 */
-	mfspr	r11, SPRN_SPRG7R
+	mfspr	r11, SPRN_SPRG_RSCRATCH4
 	mtcr	r11
-	mfspr	r13, SPRN_SPRG5R
-	mfspr	r12, SPRN_SPRG4R
-	mfspr	r11, SPRN_SPRG1
-	mfspr	r10, SPRN_SPRG0
+	mfspr	r13, SPRN_SPRG_RSCRATCH3
+	mfspr	r12, SPRN_SPRG_RSCRATCH2
+	mfspr	r11, SPRN_SPRG_RSCRATCH1
+	mfspr	r10, SPRN_SPRG_RSCRATCH0
 	b	InstructionStorage
 
 #ifdef CONFIG_SPE
@@ -790,12 +790,12 @@ END_MMU_FTR_SECTION_IFSET(MMU_FTR_BIG_PH
 	tlbwe
 
 	/* Done...restore registers and get out of here.  */
-	mfspr	r11, SPRN_SPRG7R
+	mfspr	r11, SPRN_SPRG_RSCRATCH4
 	mtcr	r11
-	mfspr	r13, SPRN_SPRG5R
-	mfspr	r12, SPRN_SPRG4R
-	mfspr	r11, SPRN_SPRG1
-	mfspr	r10, SPRN_SPRG0
+	mfspr	r13, SPRN_SPRG_RSCRATCH3
+	mfspr	r12, SPRN_SPRG_RSCRATCH2
+	mfspr	r11, SPRN_SPRG_RSCRATCH1
+	mfspr	r10, SPRN_SPRG_RSCRATCH0
 	rfi					/* Force context change */
 
 #ifdef CONFIG_SPE
@@ -839,7 +839,7 @@ load_up_spe:
 #endif /* !CONFIG_SMP */
 	/* enable use of SPE after return */
 	oris	r9,r9,MSR_SPE@h
-	mfspr	r5,SPRN_SPRG3		/* current task's THREAD (phys) */
+	mfspr	r5,SPRN_SPRG_THREAD	/* current task's THREAD (phys) */
 	li	r4,1
 	li	r10,THREAD_ACC
 	stw	r4,THREAD_USED_SPE(r5)
@@ -1118,7 +1118,7 @@ __secondary_start:
 
 	/* ptr to current thread */
 	addi	r4,r2,THREAD	/* address of our thread_struct */
-	mtspr	SPRN_SPRG3,r4
+	mtspr	SPRN_SPRG_THREAD,r4
 
 	/* Setup the defaults for TLB entries */
 	li	r4,(MAS4_TSIZED(BOOK3E_PAGESZ_4K))@l
Index: linux-work/arch/powerpc/kernel/head_40x.S
===================================================================
--- linux-work.orig/arch/powerpc/kernel/head_40x.S	2009-07-13 10:54:38.000000000 +1000
+++ linux-work/arch/powerpc/kernel/head_40x.S	2009-07-13 11:35:47.000000000 +1000
@@ -103,21 +103,21 @@ _ENTRY(saved_ksp_limit)
 
 /*
  * Exception vector entry code. This code runs with address translation
- * turned off (i.e. using physical addresses). We assume SPRG3 has the
- * physical address of the current task thread_struct.
+ * turned off (i.e. using physical addresses). We assume SPRG_THREAD has
+ * the physical address of the current task thread_struct.
  * Note that we have to have decremented r1 before we write to any fields
  * of the exception frame, since a critical interrupt could occur at any
  * time, and it will write to the area immediately below the current r1.
  */
 #define NORMAL_EXCEPTION_PROLOG						     \
-	mtspr	SPRN_SPRG0,r10;		/* save two registers to work with */\
-	mtspr	SPRN_SPRG1,r11;						     \
-	mtspr	SPRN_SPRG2,r1;						     \
+	mtspr	SPRN_SPRG_SCRATCH0,r10;	/* save two registers to work with */\
+	mtspr	SPRN_SPRG_SCRATCH1,r11;					     \
+	mtspr	SPRN_SPRG_SCRATCH2,r1;					     \
 	mfcr	r10;			/* save CR in r10 for now	   */\
 	mfspr	r11,SPRN_SRR1;		/* check whether user or kernel    */\
 	andi.	r11,r11,MSR_PR;						     \
 	beq	1f;							     \
-	mfspr	r1,SPRN_SPRG3;		/* if from user, start at top of   */\
+	mfspr	r1,SPRN_SPRG_THREAD;	/* if from user, start at top of   */\
 	lwz	r1,THREAD_INFO-THREAD(r1); /* this thread's kernel stack   */\
 	addi	r1,r1,THREAD_SIZE;					     \
 1:	subi	r1,r1,INT_FRAME_SIZE;	/* Allocate an exception frame     */\
@@ -125,13 +125,13 @@ _ENTRY(saved_ksp_limit)
 	stw	r10,_CCR(r11);          /* save various registers	   */\
 	stw	r12,GPR12(r11);						     \
 	stw	r9,GPR9(r11);						     \
-	mfspr	r10,SPRN_SPRG0;						     \
+	mfspr	r10,SPRN_SPRG_SCRATCH0;					     \
 	stw	r10,GPR10(r11);						     \
-	mfspr	r12,SPRN_SPRG1;						     \
+	mfspr	r12,SPRN_SPRG_SCRATCH1;					     \
 	stw	r12,GPR11(r11);						     \
 	mflr	r10;							     \
 	stw	r10,_LINK(r11);						     \
-	mfspr	r10,SPRN_SPRG2;						     \
+	mfspr	r10,SPRN_SPRG_SCRATCH2;					     \
 	mfspr	r12,SPRN_SRR0;						     \
 	stw	r10,GPR1(r11);						     \
 	mfspr	r9,SPRN_SRR1;						     \
@@ -160,7 +160,7 @@ _ENTRY(saved_ksp_limit)
 	lwz	r11,critirq_ctx@l(r11);					     \
 	beq	1f;							     \
 	/* COMING FROM USER MODE */					     \
-	mfspr	r11,SPRN_SPRG3;		/* if from user, start at top of   */\
+	mfspr	r11,SPRN_SPRG_THREAD;	/* if from user, start at top of   */\
 	lwz	r11,THREAD_INFO-THREAD(r11); /* this thread's kernel stack */\
 1:	addi	r11,r11,THREAD_SIZE-INT_FRAME_SIZE; /* Alloc an excpt frm  */\
 	tophys(r11,r11);						     \
@@ -265,8 +265,8 @@ label:
  * and exit.  Otherwise, we call heavywight functions to do the work.
  */
 	START_EXCEPTION(0x0300,	DataStorage)
-	mtspr	SPRN_SPRG0, r10		/* Save some working registers */
-	mtspr	SPRN_SPRG1, r11
+	mtspr	SPRN_SPRG_SCRATCH0, r10 /* Save some working registers */
+	mtspr	SPRN_SPRG_SCRATCH1, r11
 #ifdef CONFIG_403GCX
 	stw     r12, 0(r0)
 	stw     r9, 4(r0)
@@ -275,12 +275,12 @@ label:
 	stw     r11, 8(r0)
 	stw     r12, 12(r0)
 #else
-	mtspr	SPRN_SPRG4, r12
-	mtspr	SPRN_SPRG5, r9
+	mtspr	SPRN_SPRG_SCRATCH3, r12
+	mtspr	SPRN_SPRG_SCRATCH4, r9
 	mfcr	r11
 	mfspr	r12, SPRN_PID
-	mtspr	SPRN_SPRG7, r11
-	mtspr	SPRN_SPRG6, r12
+	mtspr	SPRN_SPRG_SCRATCH6, r11
+	mtspr	SPRN_SPRG_SCRATCH5, r12
 #endif
 
 	/* First, check if it was a zone fault (which means a user
@@ -308,7 +308,7 @@ label:
 	/* Get the PGD for the current thread.
 	 */
 3:
-	mfspr	r11,SPRN_SPRG3
+	mfspr	r11,SPRN_SPRG_THREAD
 	lwz	r11,PGDIR(r11)
 4:
 	tophys(r11, r11)
@@ -355,15 +355,15 @@ label:
 	lwz     r9, 4(r0)
 	lwz     r12, 0(r0)
 #else
-	mfspr	r12, SPRN_SPRG6
-	mfspr	r11, SPRN_SPRG7
+	mfspr	r12, SPRN_SPRG_SCRATCH5
+	mfspr	r11, SPRN_SPRG_SCRATCH6
 	mtspr	SPRN_PID, r12
 	mtcr	r11
-	mfspr	r9, SPRN_SPRG5
-	mfspr	r12, SPRN_SPRG4
+	mfspr	r9, SPRN_SPRG_SCRATCH4
+	mfspr	r12, SPRN_SPRG_SCRATCH3
 #endif
-	mfspr	r11, SPRN_SPRG1
-	mfspr	r10, SPRN_SPRG0
+	mfspr	r11, SPRN_SPRG_SCRATCH1
+	mfspr	r10, SPRN_SPRG_SCRATCH0
 	PPC405_ERR77_SYNC
 	rfi			/* Should sync shadow TLBs */
 	b	.		/* prevent prefetch past rfi */
@@ -380,15 +380,15 @@ label:
 	lwz     r9, 4(r0)
 	lwz     r12, 0(r0)
 #else
-	mfspr	r12, SPRN_SPRG6
-	mfspr	r11, SPRN_SPRG7
+	mfspr	r12, SPRN_SPRG_SCRATCH5
+	mfspr	r11, SPRN_SPRG_SCRATCH6
 	mtspr	SPRN_PID, r12
 	mtcr	r11
-	mfspr	r9, SPRN_SPRG5
-	mfspr	r12, SPRN_SPRG4
+	mfspr	r9, SPRN_SPRG_SCRATCH4
+	mfspr	r12, SPRN_SPRG_SCRATCH3
 #endif
-	mfspr	r11, SPRN_SPRG1
-	mfspr	r10, SPRN_SPRG0
+	mfspr	r11, SPRN_SPRG_SCRATCH1
+	mfspr	r10, SPRN_SPRG_SCRATCH0
 	b	DataAccess
 
 /*
@@ -466,8 +466,8 @@ label:
  * load TLB entries from the page table if they exist.
  */
 	START_EXCEPTION(0x1100,	DTLBMiss)
-	mtspr	SPRN_SPRG0, r10		/* Save some working registers */
-	mtspr	SPRN_SPRG1, r11
+	mtspr	SPRN_SPRG_SCRATCH0, r10 /* Save some working registers */
+	mtspr	SPRN_SPRG_SCRATCH1, r11
 #ifdef CONFIG_403GCX
 	stw     r12, 0(r0)
 	stw     r9, 4(r0)
@@ -476,12 +476,12 @@ label:
 	stw     r11, 8(r0)
 	stw     r12, 12(r0)
 #else
-	mtspr	SPRN_SPRG4, r12
-	mtspr	SPRN_SPRG5, r9
+	mtspr	SPRN_SPRG_SCRATCH3, r12
+	mtspr	SPRN_SPRG_SCRATCH4, r9
 	mfcr	r11
 	mfspr	r12, SPRN_PID
-	mtspr	SPRN_SPRG7, r11
-	mtspr	SPRN_SPRG6, r12
+	mtspr	SPRN_SPRG_SCRATCH6, r11
+	mtspr	SPRN_SPRG_SCRATCH5, r12
 #endif
 	mfspr	r10, SPRN_DEAR		/* Get faulting address */
 
@@ -500,7 +500,7 @@ label:
 	/* Get the PGD for the current thread.
 	 */
 3:
-	mfspr	r11,SPRN_SPRG3
+	mfspr	r11,SPRN_SPRG_THREAD
 	lwz	r11,PGDIR(r11)
 4:
 	tophys(r11, r11)
@@ -550,15 +550,15 @@ label:
 	lwz     r9, 4(r0)
 	lwz     r12, 0(r0)
 #else
-	mfspr	r12, SPRN_SPRG6
-	mfspr	r11, SPRN_SPRG7
+	mfspr	r12, SPRN_SPRG_SCRATCH5
+	mfspr	r11, SPRN_SPRG_SCRATCH6
 	mtspr	SPRN_PID, r12
 	mtcr	r11
-	mfspr	r9, SPRN_SPRG5
-	mfspr	r12, SPRN_SPRG4
+	mfspr	r9, SPRN_SPRG_SCRATCH4
+	mfspr	r12, SPRN_SPRG_SCRATCH3
 #endif
-	mfspr	r11, SPRN_SPRG1
-	mfspr	r10, SPRN_SPRG0
+	mfspr	r11, SPRN_SPRG_SCRATCH1
+	mfspr	r10, SPRN_SPRG_SCRATCH0
 	b	DataAccess
 
 /* 0x1200 - Instruction TLB Miss Exception
@@ -566,8 +566,8 @@ label:
  * registers and bailout to a different point.
  */
 	START_EXCEPTION(0x1200,	ITLBMiss)
-	mtspr	SPRN_SPRG0, r10		/* Save some working registers */
-	mtspr	SPRN_SPRG1, r11
+	mtspr	SPRN_SPRG_SCRATCH0, r10	 /* Save some working registers */
+	mtspr	SPRN_SPRG_SCRATCH1, r11
 #ifdef CONFIG_403GCX
 	stw     r12, 0(r0)
 	stw     r9, 4(r0)
@@ -576,12 +576,12 @@ label:
 	stw     r11, 8(r0)
 	stw     r12, 12(r0)
 #else
-	mtspr	SPRN_SPRG4, r12
-	mtspr	SPRN_SPRG5, r9
+	mtspr	SPRN_SPRG_SCRATCH3, r12
+	mtspr	SPRN_SPRG_SCRATCH4, r9
 	mfcr	r11
 	mfspr	r12, SPRN_PID
-	mtspr	SPRN_SPRG7, r11
-	mtspr	SPRN_SPRG6, r12
+	mtspr	SPRN_SPRG_SCRATCH6, r11
+	mtspr	SPRN_SPRG_SCRATCH5, r12
 #endif
 	mfspr	r10, SPRN_SRR0		/* Get faulting address */
 
@@ -600,7 +600,7 @@ label:
 	/* Get the PGD for the current thread.
 	 */
 3:
-	mfspr	r11,SPRN_SPRG3
+	mfspr	r11,SPRN_SPRG_THREAD
 	lwz	r11,PGDIR(r11)
 4:
 	tophys(r11, r11)
@@ -650,15 +650,15 @@ label:
 	lwz     r9, 4(r0)
 	lwz     r12, 0(r0)
 #else
-	mfspr	r12, SPRN_SPRG6
-	mfspr	r11, SPRN_SPRG7
+	mfspr	r12, SPRN_SPRG_SCRATCH5
+	mfspr	r11, SPRN_SPRG_SCRATCH6
 	mtspr	SPRN_PID, r12
 	mtcr	r11
-	mfspr	r9, SPRN_SPRG5
-	mfspr	r12, SPRN_SPRG4
+	mfspr	r9, SPRN_SPRG_SCRATCH4
+	mfspr	r12, SPRN_SPRG_SCRATCH3
 #endif
-	mfspr	r11, SPRN_SPRG1
-	mfspr	r10, SPRN_SPRG0
+	mfspr	r11, SPRN_SPRG_SCRATCH1
+	mfspr	r10, SPRN_SPRG_SCRATCH0
 	b	InstructionAccess
 
 	EXCEPTION(0x1300, Trap_13, unknown_exception, EXC_XFER_EE)
@@ -803,15 +803,15 @@ finish_tlb_load:
 	lwz     r9, 4(r0)
 	lwz     r12, 0(r0)
 #else
-	mfspr	r12, SPRN_SPRG6
-	mfspr	r11, SPRN_SPRG7
+	mfspr	r12, SPRN_SPRG_SCRATCH5
+	mfspr	r11, SPRN_SPRG_SCRATCH6
 	mtspr	SPRN_PID, r12
 	mtcr	r11
-	mfspr	r9, SPRN_SPRG5
-	mfspr	r12, SPRN_SPRG4
+	mfspr	r9, SPRN_SPRG_SCRATCH4
+	mfspr	r12, SPRN_SPRG_SCRATCH3
 #endif
-	mfspr	r11, SPRN_SPRG1
-	mfspr	r10, SPRN_SPRG0
+	mfspr	r11, SPRN_SPRG_SCRATCH1
+	mfspr	r10, SPRN_SPRG_SCRATCH0
 	PPC405_ERR77_SYNC
 	rfi			/* Should sync shadow TLBs */
 	b	.		/* prevent prefetch past rfi */
@@ -835,7 +835,7 @@ start_here:
 	/* ptr to phys current thread */
 	tophys(r4,r2)
 	addi	r4,r4,THREAD	/* init task's THREAD */
-	mtspr	SPRN_SPRG3,r4
+	mtspr	SPRN_SPRG_THREAD,r4
 
 	/* stack */
 	lis	r1,init_thread_union@ha
Index: linux-work/arch/powerpc/kernel/head_44x.S
===================================================================
--- linux-work.orig/arch/powerpc/kernel/head_44x.S	2009-07-13 10:54:38.000000000 +1000
+++ linux-work/arch/powerpc/kernel/head_44x.S	2009-07-13 11:35:47.000000000 +1000
@@ -239,7 +239,7 @@ skpinv:	addi	r4,r4,1				/* Increment */
 
 	/* ptr to current thread */
 	addi	r4,r2,THREAD	/* init task's THREAD */
-	mtspr	SPRN_SPRG3,r4
+	mtspr	SPRN_SPRG_THREAD,r4
 
 	/* stack */
 	lis	r1,init_thread_union@h
@@ -350,12 +350,12 @@ interrupt_base:
 
 	/* Data TLB Error Interrupt */
 	START_EXCEPTION(DataTLBError)
-	mtspr	SPRN_SPRG0, r10		/* Save some working registers */
-	mtspr	SPRN_SPRG1, r11
-	mtspr	SPRN_SPRG4W, r12
-	mtspr	SPRN_SPRG5W, r13
+	mtspr	SPRN_SPRG_WSCRATCH0, r10		/* Save some working registers */
+	mtspr	SPRN_SPRG_WSCRATCH1, r11
+	mtspr	SPRN_SPRG_WSCRATCH2, r12
+	mtspr	SPRN_SPRG_WSCRATCH3, r13
 	mfcr	r11
-	mtspr	SPRN_SPRG7W, r11
+	mtspr	SPRN_SPRG_WSCRATCH4, r11
 	mfspr	r10, SPRN_DEAR		/* Get faulting address */
 
 	/* If we are faulting a kernel address, we have to use the
@@ -374,7 +374,7 @@ interrupt_base:
 
 	/* Get the PGD for the current thread */
 3:
-	mfspr	r11,SPRN_SPRG3
+	mfspr	r11,SPRN_SPRG_THREAD
 	lwz	r11,PGDIR(r11)
 
 	/* Load PID into MMUCR TID */
@@ -446,12 +446,12 @@ tlb_44x_patch_hwater_D:
 	/* The bailout.  Restore registers to pre-exception conditions
 	 * and call the heavyweights to help us out.
 	 */
-	mfspr	r11, SPRN_SPRG7R
+	mfspr	r11, SPRN_SPRG_RSCRATCH4
 	mtcr	r11
-	mfspr	r13, SPRN_SPRG5R
-	mfspr	r12, SPRN_SPRG4R
-	mfspr	r11, SPRN_SPRG1
-	mfspr	r10, SPRN_SPRG0
+	mfspr	r13, SPRN_SPRG_RSCRATCH3
+	mfspr	r12, SPRN_SPRG_RSCRATCH2
+	mfspr	r11, SPRN_SPRG_RSCRATCH1
+	mfspr	r10, SPRN_SPRG_RSCRATCH0
 	b	DataStorage
 
 	/* Instruction TLB Error Interrupt */
@@ -461,12 +461,12 @@ tlb_44x_patch_hwater_D:
 	 * to a different point.
 	 */
 	START_EXCEPTION(InstructionTLBError)
-	mtspr	SPRN_SPRG0, r10		/* Save some working registers */
-	mtspr	SPRN_SPRG1, r11
-	mtspr	SPRN_SPRG4W, r12
-	mtspr	SPRN_SPRG5W, r13
+	mtspr	SPRN_SPRG_WSCRATCH0, r10 /* Save some working registers */
+	mtspr	SPRN_SPRG_WSCRATCH1, r11
+	mtspr	SPRN_SPRG_WSCRATCH2, r12
+	mtspr	SPRN_SPRG_WSCRATCH3, r13
 	mfcr	r11
-	mtspr	SPRN_SPRG7W, r11
+	mtspr	SPRN_SPRG_WSCRATCH4, r11
 	mfspr	r10, SPRN_SRR0		/* Get faulting address */
 
 	/* If we are faulting a kernel address, we have to use the
@@ -485,7 +485,7 @@ tlb_44x_patch_hwater_D:
 
 	/* Get the PGD for the current thread */
 3:
-	mfspr	r11,SPRN_SPRG3
+	mfspr	r11,SPRN_SPRG_THREAD
 	lwz	r11,PGDIR(r11)
 
 	/* Load PID into MMUCR TID */
@@ -542,12 +542,12 @@ tlb_44x_patch_hwater_I:
 	/* The bailout.  Restore registers to pre-exception conditions
 	 * and call the heavyweights to help us out.
 	 */
-	mfspr	r11, SPRN_SPRG7R
+	mfspr	r11, SPRN_SPRG_RSCRATCH4
 	mtcr	r11
-	mfspr	r13, SPRN_SPRG5R
-	mfspr	r12, SPRN_SPRG4R
-	mfspr	r11, SPRN_SPRG1
-	mfspr	r10, SPRN_SPRG0
+	mfspr	r13, SPRN_SPRG_RSCRATCH3
+	mfspr	r12, SPRN_SPRG_RSCRATCH2
+	mfspr	r11, SPRN_SPRG_RSCRATCH1
+	mfspr	r10, SPRN_SPRG_RSCRATCH0
 	b	InstructionStorage
 
 	/* Debug Interrupt */
@@ -593,12 +593,12 @@ finish_tlb_load:
 
 	/* Done...restore registers and get out of here.
 	*/
-	mfspr	r11, SPRN_SPRG7R
+	mfspr	r11, SPRN_SPRG_RSCRATCH4
 	mtcr	r11
-	mfspr	r13, SPRN_SPRG5R
-	mfspr	r12, SPRN_SPRG4R
-	mfspr	r11, SPRN_SPRG1
-	mfspr	r10, SPRN_SPRG0
+	mfspr	r13, SPRN_SPRG_RSCRATCH3
+	mfspr	r12, SPRN_SPRG_RSCRATCH2
+	mfspr	r11, SPRN_SPRG_RSCRATCH1
+	mfspr	r10, SPRN_SPRG_RSCRATCH0
 	rfi					/* Force context change */
 
 /*
Index: linux-work/arch/powerpc/kernel/head_64.S
===================================================================
--- linux-work.orig/arch/powerpc/kernel/head_64.S	2009-07-13 11:35:45.000000000 +1000
+++ linux-work/arch/powerpc/kernel/head_64.S	2009-07-15 13:18:34.000000000 +1000
@@ -195,7 +195,7 @@ _GLOBAL(generic_secondary_smp_init)
 	mr	r3,r24			/* not found, copy phys to r3	 */
 	b	.kexec_wait		/* next kernel might do better	 */
 
-2:	mtspr	SPRN_SPRG3,r13		/* Save vaddr of paca in SPRG3	 */
+2:	mtspr	SPRN_SPRG_PACA,r13	/* Save vaddr of paca in an SPRG */
 	/* From now on, r24 is expected to be logical cpuid */
 	mr	r24,r5
 3:	HMT_LOW
@@ -484,7 +484,7 @@ _GLOBAL(pmac_secondary_start)
 	LOAD_REG_ADDR(r4,paca)		/* Get base vaddr of paca array	*/
 	mulli	r13,r24,PACA_SIZE	/* Calculate vaddr of right paca */
 	add	r13,r13,r4		/* for this processor.		*/
-	mtspr	SPRN_SPRG3,r13		/* Save vaddr of paca in SPRG3	*/
+	mtspr	SPRN_SPRG_PACA,r13	/* Save vaddr of paca in an SPRG*/
 
 	/* Create a temp kernel stack for use before relocation is on.	*/
 	ld	r1,PACAEMERGSP(r13)
@@ -502,10 +502,10 @@ _GLOBAL(pmac_secondary_start)
  *   1. Processor number
  *   2. Segment table pointer (virtual address)
  * On entry the following are set:
- *   r1	= stack pointer.  vaddr for iSeries, raddr (temp stack) for pSeries
- *   r24   = cpu# (in Linux terms)
- *   r13   = paca virtual address
- *   SPRG3 = paca virtual address
+ *   r1	       = stack pointer.  vaddr for iSeries, raddr (temp stack) for pSeries
+ *   r24       = cpu# (in Linux terms)
+ *   r13       = paca virtual address
+ *   SPRG_PACA = paca virtual address
  */
 	.globl	__secondary_start
 __secondary_start:
@@ -641,7 +641,7 @@ _INIT_STATIC(start_here_multiplatform)
 
 	/* Restore parameters passed from prom_init/kexec */
 	mr	r3,r31
-	bl	.early_setup		/* also sets r13 and SPRG3 */
+	bl	.early_setup		/* also sets r13 and SPRG_PACA */
 
 	LOAD_REG_ADDR(r3, .start_here_common)
 	ld	r4,PACAKMSR(r13)
Index: linux-work/arch/powerpc/kernel/head_8xx.S
===================================================================
--- linux-work.orig/arch/powerpc/kernel/head_8xx.S	2009-07-13 10:54:38.000000000 +1000
+++ linux-work/arch/powerpc/kernel/head_8xx.S	2009-07-13 11:35:47.000000000 +1000
@@ -110,8 +110,8 @@ turn_on_mmu:
  * task's thread_struct.
  */
 #define EXCEPTION_PROLOG	\
-	mtspr	SPRN_SPRG0,r10;	\
-	mtspr	SPRN_SPRG1,r11;	\
+	mtspr	SPRN_SPRG_SCRATCH0,r10;	\
+	mtspr	SPRN_SPRG_SCRATCH1,r11;	\
 	mfcr	r10;		\
 	EXCEPTION_PROLOG_1;	\
 	EXCEPTION_PROLOG_2
@@ -121,7 +121,7 @@ turn_on_mmu:
 	andi.	r11,r11,MSR_PR;	\
 	tophys(r11,r1);			/* use tophys(r1) if kernel */ \
 	beq	1f;		\
-	mfspr	r11,SPRN_SPRG3;	\
+	mfspr	r11,SPRN_SPRG_THREAD;	\
 	lwz	r11,THREAD_INFO-THREAD(r11);	\
 	addi	r11,r11,THREAD_SIZE;	\
 	tophys(r11,r11);	\
@@ -133,9 +133,9 @@ turn_on_mmu:
 	stw	r10,_CCR(r11);		/* save registers */ \
 	stw	r12,GPR12(r11);	\
 	stw	r9,GPR9(r11);	\
-	mfspr	r10,SPRN_SPRG0;	\
+	mfspr	r10,SPRN_SPRG_SCRATCH0;	\
 	stw	r10,GPR10(r11);	\
-	mfspr	r12,SPRN_SPRG1;	\
+	mfspr	r12,SPRN_SPRG_SCRATCH1;	\
 	stw	r12,GPR11(r11);	\
 	mflr	r10;		\
 	stw	r10,_LINK(r11);	\
@@ -603,8 +603,9 @@ start_here:
 	/* ptr to phys current thread */
 	tophys(r4,r2)
 	addi	r4,r4,THREAD	/* init task's THREAD */
-	mtspr	SPRN_SPRG3,r4
+	mtspr	SPRN_SPRG_THREAD,r4
 	li	r3,0
+	/* XXX What is that for ? SPRG2 appears otherwise unused on 8xx */
 	mtspr	SPRN_SPRG2,r3	/* 0 => r1 has kernel sp */
 
 	/* stack */
Index: linux-work/arch/powerpc/kernel/head_booke.h
===================================================================
--- linux-work.orig/arch/powerpc/kernel/head_booke.h	2009-07-13 10:54:38.000000000 +1000
+++ linux-work/arch/powerpc/kernel/head_booke.h	2009-07-13 11:35:47.000000000 +1000
@@ -20,14 +20,14 @@
 #endif
 
 #define NORMAL_EXCEPTION_PROLOG						     \
-	mtspr	SPRN_SPRG0,r10;		/* save two registers to work with */\
-	mtspr	SPRN_SPRG1,r11;						     \
-	mtspr	SPRN_SPRG4W,r1;						     \
+	mtspr	SPRN_SPRG_WSCRATCH0,r10;/* save two registers to work with */\
+	mtspr	SPRN_SPRG_WSCRATCH1,r11;				     \
+	mtspr	SPRN_SPRG_WSCRATCH2,r1;					     \
 	mfcr	r10;			/* save CR in r10 for now	   */\
 	mfspr	r11,SPRN_SRR1;		/* check whether user or kernel    */\
 	andi.	r11,r11,MSR_PR;						     \
 	beq	1f;							     \
-	mfspr	r1,SPRN_SPRG3;		/* if from user, start at top of   */\
+	mfspr	r1,SPRN_SPRG_THREAD;	/* if from user, start at top of   */\
 	lwz	r1,THREAD_INFO-THREAD(r1); /* this thread's kernel stack   */\
 	ALLOC_STACK_FRAME(r1, THREAD_SIZE);				     \
 1:	subi	r1,r1,INT_FRAME_SIZE;	/* Allocate an exception frame     */\
@@ -35,13 +35,13 @@
 	stw	r10,_CCR(r11);          /* save various registers	   */\
 	stw	r12,GPR12(r11);						     \
 	stw	r9,GPR9(r11);						     \
-	mfspr	r10,SPRN_SPRG0;						     \
+	mfspr	r10,SPRN_SPRG_RSCRATCH0;					\
 	stw	r10,GPR10(r11);						     \
-	mfspr	r12,SPRN_SPRG1;						     \
+	mfspr	r12,SPRN_SPRG_RSCRATCH1;				     \
 	stw	r12,GPR11(r11);						     \
 	mflr	r10;							     \
 	stw	r10,_LINK(r11);						     \
-	mfspr	r10,SPRN_SPRG4R;					     \
+	mfspr	r10,SPRN_SPRG_RSCRATCH2;				     \
 	mfspr	r12,SPRN_SRR0;						     \
 	stw	r10,GPR1(r11);						     \
 	mfspr	r9,SPRN_SRR1;						     \
@@ -69,21 +69,11 @@
  * providing configurations that micro-optimize space usage.
  */
 
-/* CRIT_SPRG only used in critical exception handling */
-#define CRIT_SPRG	SPRN_SPRG2
-/* MCHECK_SPRG only used in machine check exception handling */
-#define MCHECK_SPRG	SPRN_SPRG6W
-
-#define MCHECK_STACK_BASE	mcheckirq_ctx
+#define MC_STACK_BASE		mcheckirq_ctx
 #define CRIT_STACK_BASE		critirq_ctx
 
 /* only on e500mc/e200 */
-#define DEBUG_STACK_BASE	dbgirq_ctx
-#ifdef CONFIG_E200
-#define DEBUG_SPRG		SPRN_SPRG6W
-#else
-#define DEBUG_SPRG		SPRN_SPRG9
-#endif
+#define DBG_STACK_BASE		dbgirq_ctx
 
 #define EXC_LVL_FRAME_OVERHEAD	(THREAD_SIZE - INT_FRAME_SIZE - EXC_LVL_SIZE)
 
@@ -110,7 +100,7 @@
  * critical/machine check exception stack at low physical addresses.
  */
 #define EXC_LEVEL_EXCEPTION_PROLOG(exc_level, exc_level_srr0, exc_level_srr1) \
-	mtspr	exc_level##_SPRG,r8;					     \
+	mtspr	SPRN_SPRG_WSCRATCH_##exc_level,r8;			     \
 	BOOKE_LOAD_EXC_LEVEL_STACK(exc_level);/* r8 points to the exc_level stack*/ \
 	stw	r9,GPR9(r8);		/* save various registers	   */\
 	mfcr	r9;			/* save CR in r9 for now	   */\
@@ -119,7 +109,7 @@
 	stw	r9,_CCR(r8);		/* save CR on stack		   */\
 	mfspr	r10,exc_level_srr1;	/* check whether user or kernel    */\
 	andi.	r10,r10,MSR_PR;						     \
-	mfspr	r11,SPRN_SPRG3;		/* if from user, start at top of   */\
+	mfspr	r11,SPRN_SPRG_THREAD;	/* if from user, start at top of   */\
 	lwz	r11,THREAD_INFO-THREAD(r11); /* this thread's kernel stack */\
 	addi	r11,r11,EXC_LVL_FRAME_OVERHEAD;	/* allocate stack frame    */\
 	beq	1f;							     \
@@ -140,7 +130,7 @@
 	lwz	r9,TI_TASK-EXC_LVL_FRAME_OVERHEAD(r11);			     \
 	stw	r9,TI_TASK-EXC_LVL_FRAME_OVERHEAD(r8);			     \
 	mr	r11,r8;							     \
-2:	mfspr	r8,exc_level##_SPRG;					     \
+2:	mfspr	r8,SPRN_SPRG_RSCRATCH_##exc_level;			     \
 	stw	r12,GPR12(r11);		/* save various registers	   */\
 	mflr	r10;							     \
 	stw	r10,_LINK(r11);						     \
@@ -161,9 +151,9 @@
 #define CRITICAL_EXCEPTION_PROLOG \
 		EXC_LEVEL_EXCEPTION_PROLOG(CRIT, SPRN_CSRR0, SPRN_CSRR1)
 #define DEBUG_EXCEPTION_PROLOG \
-		EXC_LEVEL_EXCEPTION_PROLOG(DEBUG, SPRN_DSRR0, SPRN_DSRR1)
+		EXC_LEVEL_EXCEPTION_PROLOG(DBG, SPRN_DSRR0, SPRN_DSRR1)
 #define MCHECK_EXCEPTION_PROLOG \
-		EXC_LEVEL_EXCEPTION_PROLOG(MCHECK, SPRN_MCSRR0, SPRN_MCSRR1)
+		EXC_LEVEL_EXCEPTION_PROLOG(MC, SPRN_MCSRR0, SPRN_MCSRR1)
 
 /*
  * Exception vectors.
@@ -282,13 +272,13 @@ label:
 	mtspr	SPRN_DSRR1,r9;						      \
 	lwz	r9,GPR9(r11);						      \
 	lwz	r12,GPR12(r11);						      \
-	mtspr	DEBUG_SPRG,r8;						      \
-	BOOKE_LOAD_EXC_LEVEL_STACK(DEBUG); /* r8 points to the debug stack */ \
+	mtspr	SPRN_SPRG_WSCRATCH_DBG,r8;				      \
+	BOOKE_LOAD_EXC_LEVEL_STACK(DBG); /* r8 points to the debug stack */ \
 	lwz	r10,GPR10(r8);						      \
 	lwz	r11,GPR11(r8);						      \
-	mfspr	r8,DEBUG_SPRG;						      \
+	mfspr	r8,SPRN_SPRG_RSCRATCH_DBG;				      \
 									      \
-	PPC_RFDI;								      \
+	PPC_RFDI;							      \
 	b	.;							      \
 									      \
 	/* continue normal handling for a debug exception... */		      \
@@ -335,11 +325,11 @@ label:
 	mtspr	SPRN_CSRR1,r9;						      \
 	lwz	r9,GPR9(r11);						      \
 	lwz	r12,GPR12(r11);						      \
-	mtspr	CRIT_SPRG,r8;						      \
+	mtspr	SPRN_SPRG_WSCRATCH_CRIT,r8;				      \
 	BOOKE_LOAD_EXC_LEVEL_STACK(CRIT); /* r8 points to the debug stack */  \
 	lwz	r10,GPR10(r8);						      \
 	lwz	r11,GPR11(r8);						      \
-	mfspr	r8,CRIT_SPRG;						      \
+	mfspr	r8,SPRN_SPRG_RSCRATCH_CRIT;				      \
 									      \
 	rfci;								      \
 	b	.;							      \
Index: linux-work/arch/powerpc/kvm/booke_interrupts.S
===================================================================
--- linux-work.orig/arch/powerpc/kvm/booke_interrupts.S	2009-07-13 10:54:38.000000000 +1000
+++ linux-work/arch/powerpc/kvm/booke_interrupts.S	2009-07-13 11:35:47.000000000 +1000
@@ -56,8 +56,8 @@
 .macro KVM_HANDLER ivor_nr
 _GLOBAL(kvmppc_handler_\ivor_nr)
 	/* Get pointer to vcpu and record exit number. */
-	mtspr	SPRN_SPRG0, r4
-	mfspr	r4, SPRN_SPRG1
+	mtspr	SPRN_SPRG_WSCRATCH0, r4
+	mfspr	r4, SPRN_SPRG_RVCPU
 	stw	r5, VCPU_GPR(r5)(r4)
 	stw	r6, VCPU_GPR(r6)(r4)
 	mfctr	r5
@@ -95,7 +95,7 @@ _GLOBAL(kvmppc_handler_len)
 
 
 /* Registers:
- *  SPRG0: guest r4
+ *  SPRG_SCRATCH0: guest r4
  *  r4: vcpu pointer
  *  r5: KVM exit number
  */
@@ -181,7 +181,7 @@ _GLOBAL(kvmppc_resume_host)
 	stw	r3, VCPU_LR(r4)
 	mfxer	r3
 	stw	r3, VCPU_XER(r4)
-	mfspr	r3, SPRN_SPRG0
+	mfspr	r3, SPRN_SPRG_RSCRATCH0
 	stw	r3, VCPU_GPR(r4)(r4)
 	mfspr	r3, SPRN_SRR0
 	stw	r3, VCPU_PC(r4)
@@ -374,7 +374,7 @@ lightweight_exit:
 	mtspr	SPRN_IVPR, r8
 
 	/* Save vcpu pointer for the exception handlers. */
-	mtspr	SPRN_SPRG1, r4
+	mtspr	SPRN_SPRG_WVCPU, r4
 
 	/* Can't switch the stack pointer until after IVPR is switched,
 	 * because host interrupt handlers would get confused. */
@@ -384,13 +384,13 @@ lightweight_exit:
 	/* Host interrupt handlers may have clobbered these guest-readable
 	 * SPRGs, so we need to reload them here with the guest's values. */
 	lwz	r3, VCPU_SPRG4(r4)
-	mtspr	SPRN_SPRG4, r3
+	mtspr	SPRN_SPRG4W, r3
 	lwz	r3, VCPU_SPRG5(r4)
-	mtspr	SPRN_SPRG5, r3
+	mtspr	SPRN_SPRG5W, r3
 	lwz	r3, VCPU_SPRG6(r4)
-	mtspr	SPRN_SPRG6, r3
+	mtspr	SPRN_SPRG6W, r3
 	lwz	r3, VCPU_SPRG7(r4)
-	mtspr	SPRN_SPRG7, r3
+	mtspr	SPRN_SPRG7W, r3
 
 #ifdef CONFIG_KVM_EXIT_TIMING
 	/* save enter time */
Index: linux-work/arch/powerpc/mm/hash_low_32.S
===================================================================
--- linux-work.orig/arch/powerpc/mm/hash_low_32.S	2009-07-13 10:54:38.000000000 +1000
+++ linux-work/arch/powerpc/mm/hash_low_32.S	2009-07-13 11:35:47.000000000 +1000
@@ -40,7 +40,7 @@ mmu_hash_lock:
  * The address is in r4, and r3 contains an access flag:
  * _PAGE_RW (0x400) if a write.
  * r9 contains the SRR1 value, from which we use the MSR_PR bit.
- * SPRG3 contains the physical address of the current task's thread.
+ * SPRG_THREAD contains the physical address of the current task's thread.
  *
  * Returns to the caller if the access is illegal or there is no
  * mapping for the address.  Otherwise it places an appropriate PTE
@@ -68,7 +68,7 @@ _GLOBAL(hash_page)
 	/* Get PTE (linux-style) and check access */
 	lis	r0,KERNELBASE@h		/* check if kernel address */
 	cmplw	0,r4,r0
-	mfspr	r8,SPRN_SPRG3		/* current task's THREAD (phys) */
+	mfspr	r8,SPRN_SPRG_THREAD	/* current task's THREAD (phys) */
 	ori	r3,r3,_PAGE_USER|_PAGE_PRESENT /* test low addresses as user */
 	lwz	r5,PGDIR(r8)		/* virt page-table root */
 	blt+	112f			/* assume user more likely */
Index: linux-work/arch/powerpc/platforms/iseries/exception.S
===================================================================
--- linux-work.orig/arch/powerpc/platforms/iseries/exception.S	2009-07-13 10:54:38.000000000 +1000
+++ linux-work/arch/powerpc/platforms/iseries/exception.S	2009-07-15 15:07:50.000000000 +1000
@@ -47,7 +47,7 @@ system_reset_iSeries:
 	LOAD_REG_ADDR(r13, paca)
 	mulli	r0,r23,PACA_SIZE
 	add	r13,r13,r0
-	mtspr	SPRN_SPRG3,r13		/* Save it away for the future */
+	mtspr	SPRN_SPRG_PACA,r13	/* Save it away for the future */
 	mfmsr	r24
 	ori	r24,r24,MSR_RI
 	mtmsrd	r24			/* RI on */
@@ -116,7 +116,7 @@ iSeries_secondary_smp_loop:
 #endif /* CONFIG_SMP */
 	li	r0,-1			/* r0=-1 indicates a Hypervisor call */
 	sc				/* Invoke the hypervisor via a system call */
-	mfspr	r13,SPRN_SPRG3		/* Put r13 back ???? */
+	mfspr	r13,SPRN_SPRG_PACA	/* Put r13 back ???? */
 	b	2b			/* If SMP not configured, secondaries
 					 * loop forever */
 
@@ -126,9 +126,9 @@ iSeries_secondary_smp_loop:
 
 	.globl data_access_iSeries
 data_access_iSeries:
-	mtspr	SPRN_SPRG1,r13
+	mtspr	SPRN_SPRG_SCRATCH0,r13
 BEGIN_FTR_SECTION
-	mtspr	SPRN_SPRG2,r12
+	mtspr	SPRN_SPRG_SCRATCH1,r12
 	mfspr	r13,SPRN_DAR
 	mfspr	r12,SPRN_DSISR
 	srdi	r13,r13,60
@@ -137,7 +137,7 @@ BEGIN_FTR_SECTION
 	cmpwi	r13,0x2c
 	beq	.do_stab_bolted_iSeries
 	mtcrf	0x80,r12
-	mfspr	r12,SPRN_SPRG2
+	mfspr	r12,SPRN_SPRG_SCRATCH1
 END_FTR_SECTION_IFCLR(CPU_FTR_SLB)
 	EXCEPTION_PROLOG_1(PACA_EXGEN)
 	EXCEPTION_PROLOG_ISERIES_1
@@ -145,15 +145,15 @@ END_FTR_SECTION_IFCLR(CPU_FTR_SLB)
 
 .do_stab_bolted_iSeries:
 	mtcrf	0x80,r12
-	mfspr	r12,SPRN_SPRG2
+	mfspr	r12,SPRN_SPRG_SCRATCH1
 	EXCEPTION_PROLOG_1(PACA_EXSLB)
 	EXCEPTION_PROLOG_ISERIES_1
 	b	.do_stab_bolted
 
 	.globl	data_access_slb_iSeries
 data_access_slb_iSeries:
-	mtspr	SPRN_SPRG1,r13		/* save r13 */
-	mfspr	r13,SPRN_SPRG3		/* get paca address into r13 */
+	mtspr	SPRN_SPRG_SCRATCH0,r13	/* save r13 */
+	mfspr	r13,SPRN_SPRG_PACA	/* get paca address into r13 */
 	std	r3,PACA_EXSLB+EX_R3(r13)
 	mfspr	r3,SPRN_DAR
 	std	r9,PACA_EXSLB+EX_R9(r13)
@@ -165,7 +165,7 @@ data_access_slb_iSeries:
 	std	r10,PACA_EXSLB+EX_R10(r13)
 	std	r11,PACA_EXSLB+EX_R11(r13)
 	std	r12,PACA_EXSLB+EX_R12(r13)
-	mfspr	r10,SPRN_SPRG1
+	mfspr	r10,SPRN_SPRG_SCRATCH0
 	std	r10,PACA_EXSLB+EX_R13(r13)
 	ld	r12,PACALPPACAPTR(r13)
 	ld	r12,LPPACASRR1(r12)
@@ -175,8 +175,8 @@ data_access_slb_iSeries:
 
 	.globl	instruction_access_slb_iSeries
 instruction_access_slb_iSeries:
-	mtspr	SPRN_SPRG1,r13		/* save r13 */
-	mfspr	r13,SPRN_SPRG3		/* get paca address into r13 */
+	mtspr	SPRN_SPRG_SCRATCH0,r13	/* save r13 */
+	mfspr	r13,SPRN_SPRG_PACA	/* get paca address into r13 */
 	std	r3,PACA_EXSLB+EX_R3(r13)
 	ld	r3,PACALPPACAPTR(r13)
 	ld	r3,LPPACASRR0(r3)	/* get SRR0 value */
@@ -189,7 +189,7 @@ instruction_access_slb_iSeries:
 	std	r10,PACA_EXSLB+EX_R10(r13)
 	std	r11,PACA_EXSLB+EX_R11(r13)
 	std	r12,PACA_EXSLB+EX_R12(r13)
-	mfspr	r10,SPRN_SPRG1
+	mfspr	r10,SPRN_SPRG_SCRATCH0
 	std	r10,PACA_EXSLB+EX_R13(r13)
 	ld	r12,PACALPPACAPTR(r13)
 	ld	r12,LPPACASRR1(r12)
@@ -200,7 +200,7 @@ slb_miss_user_iseries:
 	std	r10,PACA_EXGEN+EX_R10(r13)
 	std	r11,PACA_EXGEN+EX_R11(r13)
 	std	r12,PACA_EXGEN+EX_R12(r13)
-	mfspr	r10,SPRG1
+	mfspr	r10,SPRG_SCRATCH0
 	ld	r11,PACA_EXSLB+EX_R9(r13)
 	ld	r12,PACA_EXSLB+EX_R3(r13)
 	std	r10,PACA_EXGEN+EX_R13(r13)
@@ -221,7 +221,7 @@ slb_miss_user_iseries:
 	.globl	system_call_iSeries
 system_call_iSeries:
 	mr	r9,r13
-	mfspr	r13,SPRN_SPRG3
+	mfspr	r13,SPRN_SPRG_PACA
 	EXCEPTION_PROLOG_ISERIES_1
 	b	system_call_common
 
Index: linux-work/arch/powerpc/platforms/iseries/exception.h
===================================================================
--- linux-work.orig/arch/powerpc/platforms/iseries/exception.h	2009-07-13 11:35:45.000000000 +1000
+++ linux-work/arch/powerpc/platforms/iseries/exception.h	2009-07-13 11:35:47.000000000 +1000
@@ -38,7 +38,7 @@
 	.globl label##_iSeries;						\
 label##_iSeries:							\
 	HMT_MEDIUM;							\
-	mtspr	SPRN_SPRG1,r13;		/* save r13 */			\
+	mtspr	SPRN_SPRG_SCRATCH0,r13;	/* save r13 */			\
 	EXCEPTION_PROLOG_1(area);					\
 	EXCEPTION_PROLOG_ISERIES_1;					\
 	b	label##_common
@@ -47,7 +47,7 @@ label##_iSeries:							\
 	.globl label##_iSeries;						\
 label##_iSeries:							\
 	HMT_MEDIUM;							\
-	mtspr	SPRN_SPRG1,r13;		/* save r13 */			\
+	mtspr	SPRN_SPRG_SCRATCH0,r13;	/* save r13 */			\
 	EXCEPTION_PROLOG_1(PACA_EXGEN);					\
 	lbz	r10,PACASOFTIRQEN(r13);					\
 	cmpwi	0,r10,0;						\
Index: linux-work/arch/powerpc/kernel/entry_64.S
===================================================================
--- linux-work.orig/arch/powerpc/kernel/entry_64.S	2009-07-13 10:54:38.000000000 +1000
+++ linux-work/arch/powerpc/kernel/entry_64.S	2009-07-13 11:35:47.000000000 +1000
@@ -762,7 +762,7 @@ _GLOBAL(enter_rtas)
 
 _STATIC(rtas_return_loc)
 	/* relocation is off at this point */
-	mfspr	r4,SPRN_SPRG3	        /* Get PACA */
+	mfspr	r4,SPRN_SPRG_PACA	/* Get PACA */
 	clrldi	r4,r4,2			/* convert to realmode address */
 
 	bcl	20,31,$+4
@@ -793,7 +793,7 @@ _STATIC(rtas_restore_regs)
 	REST_8GPRS(14, r1)		/* Restore the non-volatiles */
 	REST_10GPRS(22, r1)		/* ditto */
 
-	mfspr	r13,SPRN_SPRG3
+	mfspr	r13,SPRN_SPRG_PACA
 
 	ld	r4,_CCR(r1)
 	mtcr	r4
