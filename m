Return-Path: <haren@linux.vnet.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e4.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C45312C00F6
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Jul 2012 19:44:03 +1000 (EST)
Received: from /spool/local
 by e4.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <haren@linux.vnet.ibm.com>;
 Sat, 14 Jul 2012 05:44:00 -0400
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 2D3086E804C
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Jul 2012 05:43:47 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q6E9hkd7288636
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Jul 2012 05:43:46 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q6E9hkmE004274
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Jul 2012 06:43:46 -0300
Subject: [PATCH] powerpc: SMT priority (PPR) save and restore
From: Haren Myneni <haren@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, anton@samba.org
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 14 Jul 2012 02:43:44 -0700
Message-ID: <1342259024.11305.38.camel@hbabu-laptop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

powerpc: SMT priority (PPR) save and restore
    
On P7 systems, users can define SMT priority levels 2,3 and 4 for
processes so that some can run higher priority than the other ones.
In the current kernel, the default priority is set to 4 which prohibits
processes to use higher priority. Also the kernel boosts the priority to
4 during exception without saving the user defined priority values when
the task enters the kernel. So we will be loosing the process PPR value
and can not be restored it back when the task exits the kernel.
    
This patch sets the default priority to 3 when tasks are created such
that users can use 4 for higher priority tasks. It also provides to save
and restore the user defined priorities for all tasks.
    
When the task enters in to kernel space, the user defined priority (PPR)
will be saved in to PACA at the beginning of first level exception
vector and then copy from PACA to thread_info in second level vector.
PPR will be restored from thread_info before exits the kernel space.
    
P7 temporarily raises the thread priority to higher level during
exception until the program executes HMT_* calls. But it will not modify
PPR register. So we saves PPR value whenever some register is available
to use and then calls HMT_MEDIUM to increase the priority. This feature
supports on P7 or later processors.
    
Signed-off-by: Haren Myneni <hbabu@us.ibm.com>

diff --git a/arch/powerpc/include/asm/cputable.h
b/arch/powerpc/include/asm/cputable.h
index 50d82c8..e7b80d6 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -203,6 +203,7 @@ extern const char *powerpc_base_platform;
 #define CPU_FTR_POPCNTD			LONG_ASM_CONST(0x0800000000000000)
 #define CPU_FTR_ICSWX			LONG_ASM_CONST(0x1000000000000000)
 #define CPU_FTR_VMX_COPY		LONG_ASM_CONST(0x2000000000000000)
+#define CPU_FTR_HAS_PPR			LONG_ASM_CONST(0x4000000000000000)
 
 #ifndef __ASSEMBLY__
 
@@ -432,7 +433,8 @@ extern const char *powerpc_base_platform;
 	    CPU_FTR_PURR | CPU_FTR_SPURR | CPU_FTR_REAL_LE | \
 	    CPU_FTR_DSCR | CPU_FTR_SAO  | CPU_FTR_ASYM_SMT | \
 	    CPU_FTR_STCX_CHECKS_ADDRESS | CPU_FTR_POPCNTB | CPU_FTR_POPCNTD |
\
-	    CPU_FTR_ICSWX | CPU_FTR_CFAR | CPU_FTR_HVMODE | CPU_FTR_VMX_COPY)
+	    CPU_FTR_ICSWX | CPU_FTR_CFAR | CPU_FTR_HVMODE | CPU_FTR_VMX_COPY |
\
+	    CPU_FTR_HAS_PPR)
 #define CPU_FTRS_CELL	(CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
 	    CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
 	    CPU_FTR_ALTIVEC_COMP | CPU_FTR_MMCRA | CPU_FTR_SMT | \
diff --git a/arch/powerpc/include/asm/exception-64s.h
b/arch/powerpc/include/asm/exception-64s.h
index d58fc4e..1fae8aa 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -47,6 +47,7 @@
 #define EX_R3		64
 #define EX_LR		72
 #define EX_CFAR		80
+#define EX_PPR		88	/* SMT thread status register (priority) */
 
 /*
  * We're short on space and time in the exception prolog, so we can't
@@ -61,10 +62,46 @@
 #define EXC_HV	H
 #define EXC_STD
 
+/* 
+ * PPR save/restore macros - Used only on P7 or later processors
+ */
+#define SAVE_PPR(area, ra, rb)
\
+BEGIN_FTR_SECTION_NESTED(940)
\
+       ld      ra,area+EX_PPR(r13);    /* Read PPR from paca */
\
+       clrrdi  rb,r1,THREAD_SHIFT;     /* thread_info struct */
\
+       std     ra,TI_PPR(rb);          /* Save PPR in thread_info */
\
+END_FTR_SECTION_NESTED(CPU_FTR_HAS_PPR,CPU_FTR_HAS_PPR,940)
+
+#define RESTORE_PPR(ra,rb)
\
+BEGIN_FTR_SECTION_NESTED(941)
\
+       clrrdi  ra,r1,THREAD_SHIFT;
\
+       ld      rb,TI_PPR(ra);          /* Read PPR from thread_info */
\
+       mtspr   SPRN_PPR,rb;            /* Restore PPR */
\
+END_FTR_SECTION_NESTED(CPU_FTR_HAS_PPR,CPU_FTR_HAS_PPR,941)
+
+#define RESTORE_PPR_PACA(area,ra)
\
+BEGIN_FTR_SECTION_NESTED(942)
\
+       ld      ra,area+EX_PPR(r13);
\
+       mtspr   SPRN_PPR,ra;
\
+END_FTR_SECTION_NESTED(CPU_FTR_HAS_PPR,CPU_FTR_HAS_PPR,942)
+
+#define HMT_FTR_NO_PPR
\
+BEGIN_FTR_SECTION_NESTED(944)					       \
+       HMT_MEDIUM;
\
+END_FTR_SECTION_NESTED(CPU_FTR_HAS_PPR,0,944) 	/*non P7*/
+
+#define HMT_FTR_HAS_PPR(area, ra)
\
+BEGIN_FTR_SECTION_NESTED(943)
\
+       mfspr   ra,SPRN_PPR;            /* Read PPR */
\
+       std     ra,area+EX_PPR(r13);    /* Save PPR in paca */
\
+       HMT_MEDIUM;
\
+END_FTR_SECTION_NESTED(CPU_FTR_HAS_PPR,CPU_FTR_HAS_PPR,943) /* P7 */
+
 #define __EXCEPTION_PROLOG_1(area, extra, vec)				\
 	GET_PACA(r13);							\
-	std	r9,area+EX_R9(r13);	/* save r9 - r12 */		\
-	std	r10,area+EX_R10(r13);					\
+	std	r9,area+EX_R9(r13);	/* save r9 */			\
+	HMT_FTR_HAS_PPR(area,r9); 					\
+	std	r10,area+EX_R10(r13);	/* save r10 - r12 */		\
 	BEGIN_FTR_SECTION_NESTED(66);					\
 	mfspr	r10,SPRN_CFAR;						\
 	std	r10,area+EX_CFAR(r13);					\
@@ -176,8 +213,10 @@ do_kvm_##n:								\
 	std	r10,0(r1);		/* make stack chain pointer	*/ \
 	std	r0,GPR0(r1);		/* save r0 in stackframe	*/ \
 	std	r10,GPR1(r1);		/* save r1 in stackframe	*/ \
+	beq	4f;							   \
 	ACCOUNT_CPU_USER_ENTRY(r9, r10);				   \
-	std	r2,GPR2(r1);		/* save r2 in stackframe	*/ \
+	SAVE_PPR(area, r9, r10);					   \
+4:	std	r2,GPR2(r1);		/* save r2 in stackframe	*/ \
 	SAVE_4GPRS(3, r1);		/* save r3 - r6 in stackframe	*/ \
 	SAVE_2GPRS(7, r1);		/* save r7, r8 in stackframe	*/ \
 	ld	r9,area+EX_R9(r13);	/* move r9, r10 to stackframe	*/ \
@@ -218,7 +257,7 @@ do_kvm_##n:								\
 	. = loc;					\
 	.globl label##_pSeries;				\
 label##_pSeries:					\
-	HMT_MEDIUM;					\
+	HMT_FTR_NO_PPR; 				\
 	SET_SCRATCH0(r13);		/* save r13 */		\
 	EXCEPTION_PROLOG_PSERIES(PACA_EXGEN, label##_common,	\
 				 EXC_STD, KVMTEST_PR, vec)
@@ -227,7 +266,7 @@ label##_pSeries:					\
 	. = loc;					\
 	.globl label##_hv;				\
 label##_hv:						\
-	HMT_MEDIUM;					\
+	HMT_FTR_NO_PPR; 				\
 	SET_SCRATCH0(r13);	/* save r13 */			\
 	EXCEPTION_PROLOG_PSERIES(PACA_EXGEN, label##_common,	\
 				 EXC_HV, KVMTEST, vec)
@@ -258,7 +297,7 @@ label##_hv:						\
 	_SOFTEN_TEST(EXC_STD, vec)
 
 #define __MASKABLE_EXCEPTION_PSERIES(vec, label, h, extra)		\
-	HMT_MEDIUM;							\
+	HMT_FTR_NO_PPR;  						\
 	SET_SCRATCH0(r13);    /* save r13 */				\
 	__EXCEPTION_PROLOG_1(PACA_EXGEN, extra, vec);		\
 	EXCEPTION_PROLOG_PSERIES_1(label##_common, h);
diff --git a/arch/powerpc/include/asm/paca.h
b/arch/powerpc/include/asm/paca.h
index daf813f..d32b1e5 100644
--- a/arch/powerpc/include/asm/paca.h
+++ b/arch/powerpc/include/asm/paca.h
@@ -93,9 +93,9 @@ struct paca_struct {
 	 * Now, starting in cacheline 2, the exception save areas
 	 */
 	/* used for most interrupts/exceptions */
-	u64 exgen[11] __attribute__((aligned(0x80)));
-	u64 exmc[11];		/* used for machine checks */
-	u64 exslb[11];		/* used for SLB/segment table misses
+	u64 exgen[12] __attribute__((aligned(0x80)));
+	u64 exmc[12];		/* used for machine checks */
+	u64 exslb[12];		/* used for SLB/segment table misses
  				 * on the linear mapping */
 	/* SLB related definitions */
 	u16 vmalloc_sllp;
diff --git a/arch/powerpc/include/asm/ppc_asm.h
b/arch/powerpc/include/asm/ppc_asm.h
index 1544420..b5437a2 100644
--- a/arch/powerpc/include/asm/ppc_asm.h
+++ b/arch/powerpc/include/asm/ppc_asm.h
@@ -30,7 +30,6 @@
 #define ACCOUNT_STOLEN_TIME
 #else
 #define ACCOUNT_CPU_USER_ENTRY(ra, rb)					\
-	beq	2f;			/* if from kernel mode */	\
 	MFTB(ra);			/* get timebase */		\
 	ld	rb,PACA_STARTTIME_USER(r13);				\
 	std	ra,PACA_STARTTIME(r13);					\
@@ -38,7 +37,6 @@
 	ld	ra,PACA_USER_TIME(r13);					\
 	add	ra,ra,rb;		/* add on to user time */	\
 	std	ra,PACA_USER_TIME(r13);					\
-2:
 
 #define ACCOUNT_CPU_USER_EXIT(ra, rb)					\
 	MFTB(ra);			/* get timebase */		\
diff --git a/arch/powerpc/include/asm/reg.h
b/arch/powerpc/include/asm/reg.h
index f0cb7f4..1e61116 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -284,6 +284,7 @@
 #define SPRN_DBAT6U	0x23C	/* Data BAT 6 Upper Register */
 #define SPRN_DBAT7L	0x23F	/* Data BAT 7 Lower Register */
 #define SPRN_DBAT7U	0x23E	/* Data BAT 7 Upper Register */
+#define SPRN_PPR	0x380	/* Local SMT Thread status resgiter */
 
 #define SPRN_DEC	0x016		/* Decrement Register */
 #define SPRN_DER	0x095		/* Debug Enable Regsiter */
diff --git a/arch/powerpc/include/asm/thread_info.h
b/arch/powerpc/include/asm/thread_info.h
index 68831e9..618e35c 100644
--- a/arch/powerpc/include/asm/thread_info.h
+++ b/arch/powerpc/include/asm/thread_info.h
@@ -40,10 +40,22 @@ struct thread_info {
 	struct restart_block restart_block;
 	unsigned long	local_flags;		/* private flags for thread */
 
+#ifdef CONFIG_PPC64
+	unsigned long	ppr;			/* SMT Thread status register */
+#endif
 	/* low level flags - has atomic operations done on it */
 	unsigned long	flags ____cacheline_aligned_in_smp;
 };
 
+#ifdef CONFIG_PPC64
+/* Default SMT priority to (11- 13bits). */
+/* .ppr is Used to save/restore only on P7 or later */
+#define INIT_PPR \
+	.ppr =  (3ull << 50),
+#else
+#define INIT_PPR 
+#endif
+
 /*
  * macros/functions for gaining access to the thread information
structure
  */
@@ -56,6 +68,7 @@ struct thread_info {
 	.restart_block = {			\
 		.fn = do_no_restart_syscall,	\
 	},					\
+	INIT_PPR				\
 	.flags =	0,			\
 }
 
diff --git a/arch/powerpc/kernel/asm-offsets.c
b/arch/powerpc/kernel/asm-offsets.c
index 52c7ad7..0b3a5fe 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -127,6 +127,7 @@ int main(void)
 	DEFINE(TI_CPU, offsetof(struct thread_info, cpu));
 
 #ifdef CONFIG_PPC64
+	DEFINE(TI_PPR,  offsetof(struct thread_info, ppr));
 	DEFINE(DCACHEL1LINESIZE, offsetof(struct ppc64_caches, dline_size));
 	DEFINE(DCACHEL1LOGLINESIZE, offsetof(struct ppc64_caches,
log_dline_size));
 	DEFINE(DCACHEL1LINESPERPAGE, offsetof(struct ppc64_caches,
dlines_per_page));
diff --git a/arch/powerpc/kernel/entry_64.S
b/arch/powerpc/kernel/entry_64.S
index 5971c85..671a3db 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -33,6 +33,7 @@
 #include <asm/irqflags.h>
 #include <asm/ftrace.h>
 #include <asm/hw_irq.h>
+#include <asm/exception-64s.h> /* SAVE_PPR and RESTORE_PPR */
 
 /*
  * System calls.
@@ -62,8 +63,10 @@ system_call_common:
 	std	r12,_MSR(r1)
 	std	r0,GPR0(r1)
 	std	r10,GPR1(r1)
+	beq	2f
 	ACCOUNT_CPU_USER_ENTRY(r10, r11)
-	std	r2,GPR2(r1)
+	SAVE_PPR(PACA_EXGEN, r10, r11)  
+2:	std	r2,GPR2(r1)
 	std	r3,GPR3(r1)
 	mfcr	r2
 	std	r4,GPR4(r1)
@@ -228,6 +231,7 @@ END_FTR_SECTION_IFCLR(CPU_FTR_STCX_CHECKS_ADDRESS)
 
 	beq-	1f
 	ACCOUNT_CPU_USER_EXIT(r11, r12)
+	RESTORE_PPR(r11, r12)		
 	ld	r13,GPR13(r1)	/* only restore r13 if returning to usermode */
 1:	ld	r2,GPR2(r1)
 	ld	r1,GPR1(r1)
@@ -698,6 +702,7 @@ fast_exception_return:
 	andi.	r0,r3,MSR_PR
 	beq	1f
 	ACCOUNT_CPU_USER_EXIT(r2, r4)
+	RESTORE_PPR(r2, r4)		
 	REST_GPR(13, r1)
 1:
 	mtspr	SPRN_SRR1,r3
diff --git a/arch/powerpc/kernel/exceptions-64s.S
b/arch/powerpc/kernel/exceptions-64s.S
index 1c06d29..c3bddf8 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -40,7 +40,7 @@ __start_interrupts:
 
 	.globl system_reset_pSeries;
 system_reset_pSeries:
-	HMT_MEDIUM;
+	HMT_FTR_NO_PPR  
 	SET_SCRATCH0(r13)
 #ifdef CONFIG_PPC_P7_NAP
 BEGIN_FTR_SECTION
@@ -94,7 +94,7 @@ machine_check_pSeries_1:
 	. = 0x300
 	.globl data_access_pSeries
 data_access_pSeries:
-	HMT_MEDIUM
+	HMT_FTR_NO_PPR
 	SET_SCRATCH0(r13)
 BEGIN_FTR_SECTION
 	b	data_access_check_stab
@@ -106,7 +106,7 @@ END_MMU_FTR_SECTION_IFCLR(MMU_FTR_SLB)
 	. = 0x380
 	.globl data_access_slb_pSeries
 data_access_slb_pSeries:
-	HMT_MEDIUM
+	HMT_FTR_NO_PPR  
 	SET_SCRATCH0(r13)
 	EXCEPTION_PROLOG_1(PACA_EXSLB, KVMTEST, 0x380)
 	std	r3,PACA_EXSLB+EX_R3(r13)
@@ -137,7 +137,7 @@ data_access_slb_pSeries:
 	. = 0x480
 	.globl instruction_access_slb_pSeries
 instruction_access_slb_pSeries:
-	HMT_MEDIUM
+	HMT_FTR_NO_PPR  
 	SET_SCRATCH0(r13)
 	EXCEPTION_PROLOG_1(PACA_EXSLB, KVMTEST_PR, 0x480)
 	std	r3,PACA_EXSLB+EX_R3(r13)
@@ -197,7 +197,7 @@ hardware_interrupt_hv:
 	. = 0xc00
 	.globl	system_call_pSeries
 system_call_pSeries:
-	HMT_MEDIUM
+	HMT_FTR_NO_PPR  
 #ifdef CONFIG_KVM_BOOK3S_64_HANDLER
 	SET_SCRATCH0(r13)
 	GET_PACA(r13)
@@ -213,6 +213,7 @@ BEGIN_FTR_SECTION
 END_FTR_SECTION_IFSET(CPU_FTR_REAL_LE)
 	mr	r9,r13
 	GET_PACA(r13)
+	HMT_FTR_HAS_PPR(PACA_EXGEN,r10)
 	mfspr	r11,SPRN_SRR0
 	mfspr	r12,SPRN_SRR1
 	ld	r10,PACAKBASE(r13)
@@ -295,7 +296,7 @@ vsx_unavailable_pSeries_1:
 machine_check_pSeries:
 	.globl machine_check_fwnmi
 machine_check_fwnmi:
-	HMT_MEDIUM
+	HMT_FTR_NO_PPR  
 	SET_SCRATCH0(r13)		/* save r13 */
 	EXCEPTION_PROLOG_PSERIES(PACA_EXMC, machine_check_common,
 				 EXC_STD, KVMTEST, 0x200)
@@ -417,7 +418,7 @@ _GLOBAL(__replay_interrupt)
 	.globl system_reset_fwnmi
       .align 7
 system_reset_fwnmi:
-	HMT_MEDIUM
+	HMT_FTR_NO_PPR  
 	SET_SCRATCH0(r13)		/* save r13 */
 	EXCEPTION_PROLOG_PSERIES(PACA_EXGEN, system_reset_common, EXC_STD,
 				 NOTEST, 0x100)
@@ -717,7 +718,8 @@ _GLOBAL(slb_miss_realmode)
 	mtcrf	0x80,r9
 	mtcrf	0x01,r9		/* slb_allocate uses cr0 and cr7 */
 .machine	pop
-
+	
+	RESTORE_PPR_PACA(PACA_EXSLB,r9)		
 	ld	r9,PACA_EXSLB+EX_R9(r13)
 	ld	r10,PACA_EXSLB+EX_R10(r13)
 	ld	r11,PACA_EXSLB+EX_R11(r13)
@@ -1048,7 +1050,7 @@ initial_stab:
 
 #ifdef CONFIG_PPC_POWERNV
 _GLOBAL(opal_mc_secondary_handler)
-	HMT_MEDIUM
+	HMT_FTR_NO_PPR  
 	SET_SCRATCH0(r13)
 	GET_PACA(r13)
 	clrldi	r3,r3,2
