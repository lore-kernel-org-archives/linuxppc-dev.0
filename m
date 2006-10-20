Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D35C267BDC
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Oct 2006 11:47:53 +1000 (EST)
Subject: [PATCH 5/5] powerpc: Cell timebase bug workaround
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Fri, 20 Oct 2006 11:47:20 +1000
Message-Id: <1161308840.10524.112.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The Cell CPU timebase has an errata. When reading the entire 64 bits of
the timebase with one mftb instruction, there is a handful of cycles
window during which one might read a value with the low order 32 bits
already reset to 0x00000000 but the high order bits not yet incremeted
by one. This fixes it by reading the timebase again until the low order
32 bits is no longer 0. That might introduce occasional latencies if
hitting mftb just at the wrong time, but no more than 70ns on a cell
blade, and that was considered acceptable.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-cell/arch/powerpc/kernel/vdso64/gettimeofday.S
===================================================================
--- linux-cell.orig/arch/powerpc/kernel/vdso64/gettimeofday.S	2006-10-06 13:47:54.000000000 +1000
+++ linux-cell/arch/powerpc/kernel/vdso64/gettimeofday.S	2006-10-13 17:31:57.000000000 +1000
@@ -229,8 +229,10 @@ V_FUNCTION_BEGIN(__do_get_xsec)
 	xor	r0,r8,r8		/* create dependency */
 	add	r3,r3,r0
 
-	/* Get TB & offset it */
-	mftb	r7
+	/* Get TB & offset it. We use the MFTB macro which will generate
+	 * workaround code for Cell.
+	 */
+	MFTB(r7)
 	ld	r9,CFG_TB_ORIG_STAMP(r3)
 	subf	r7,r9,r7
 
Index: linux-cell/include/asm-powerpc/cputable.h
===================================================================
--- linux-cell.orig/include/asm-powerpc/cputable.h	2006-10-13 17:31:53.000000000 +1000
+++ linux-cell/include/asm-powerpc/cputable.h	2006-10-13 17:31:57.000000000 +1000
@@ -143,6 +143,7 @@ extern struct cpu_spec *identify_cpu(uns
 #define CPU_FTR_CI_LARGE_PAGE		LONG_ASM_CONST(0x0000100000000000)
 #define CPU_FTR_PAUSE_ZERO		LONG_ASM_CONST(0x0000200000000000)
 #define CPU_FTR_PURR			LONG_ASM_CONST(0x0000400000000000)
+#define CPU_FTR_CELL_TB_BUG		LONG_ASM_CONST(0x0000800000000000)
 
 #ifndef __ASSEMBLY__
 
@@ -331,7 +332,7 @@ extern struct cpu_spec *identify_cpu(uns
 #define CPU_FTRS_CELL	(CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | \
 	    CPU_FTR_HPTE_TABLE | CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
 	    CPU_FTR_ALTIVEC_COMP | CPU_FTR_MMCRA | CPU_FTR_SMT | \
-	    CPU_FTR_PAUSE_ZERO | CPU_FTR_CI_LARGE_PAGE)
+	    CPU_FTR_PAUSE_ZERO | CPU_FTR_CI_LARGE_PAGE | CPU_FTR_CELL_TB_BUG)
 #define CPU_FTRS_PA6T (CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | \
 	    CPU_FTR_HPTE_TABLE | CPU_FTR_PPCAS_ARCH_V2 | \
 	    CPU_FTR_ALTIVEC_COMP | CPU_FTR_CI_LARGE_PAGE | \
Index: linux-cell/include/asm-powerpc/ppc_asm.h
===================================================================
--- linux-cell.orig/include/asm-powerpc/ppc_asm.h	2006-10-06 13:45:32.000000000 +1000
+++ linux-cell/include/asm-powerpc/ppc_asm.h	2006-10-16 11:07:27.000000000 +1000
@@ -30,9 +30,9 @@ BEGIN_FTR_SECTION;							\
 	mfspr	ra,SPRN_PURR;		/* get processor util. reg */	\
 END_FTR_SECTION_IFSET(CPU_FTR_PURR);					\
 BEGIN_FTR_SECTION;							\
-	mftb	ra;			/* or get TB if no PURR */	\
+	MFTB(ra);			/* or get TB if no PURR */	\
 END_FTR_SECTION_IFCLR(CPU_FTR_PURR);					\
-	ld	rb,PACA_STARTPURR(r13);				\
+	ld	rb,PACA_STARTPURR(r13);					\
 	std	ra,PACA_STARTPURR(r13);					\
 	subf	rb,rb,ra;		/* subtract start value */	\
 	ld	ra,PACA_USER_TIME(r13);					\
@@ -45,9 +45,9 @@ BEGIN_FTR_SECTION;							\
 	mfspr	ra,SPRN_PURR;		/* get processor util. reg */	\
 END_FTR_SECTION_IFSET(CPU_FTR_PURR);					\
 BEGIN_FTR_SECTION;							\
-	mftb	ra;			/* or get TB if no PURR */	\
+	MFTB(ra);			/* or get TB if no PURR */	\
 END_FTR_SECTION_IFCLR(CPU_FTR_PURR);					\
-	ld	rb,PACA_STARTPURR(r13);				\
+	ld	rb,PACA_STARTPURR(r13);					\
 	std	ra,PACA_STARTPURR(r13);					\
 	subf	rb,rb,ra;		/* subtract start value */	\
 	ld	ra,PACA_SYSTEM_TIME(r13);				\
@@ -274,6 +274,16 @@ END_FTR_SECTION_IFSET(CPU_FTR_601)
 #define ISYNC_601
 #endif
 
+#ifdef CONFIG_PPC_CELL
+#define MFTB(dest)			\
+90:	mftb  dest;			\
+BEGIN_FTR_SECTION_NESTED(96);		\
+	cmpwi dest,0;			\
+	beq-  90b;			\
+END_FTR_SECTION_NESTED(CPU_FTR_CELL_TB_BUG, CPU_FTR_CELL_TB_BUG, 96)
+#else
+#define MFTB(dest)			mftb dest
+#endif
 
 #ifndef CONFIG_SMP
 #define TLBSYNC
Index: linux-cell/include/asm-powerpc/reg.h
===================================================================
--- linux-cell.orig/include/asm-powerpc/reg.h	2006-10-09 12:03:34.000000000 +1000
+++ linux-cell/include/asm-powerpc/reg.h	2006-10-16 11:08:14.000000000 +1000
@@ -617,11 +617,33 @@
 			asm volatile("mfspr %0," __stringify(rn) \
 				: "=r" (rval)); rval;})
 #define mtspr(rn, v)	asm volatile("mtspr " __stringify(rn) ",%0" : : "r" (v))
-
+#ifdef CONFIG_PPC_CELL
+#define mftb()		({unsigned long rval;				\
+			asm volatile(					\
+				"90:	mftb %0;\n"			\
+				"97:	cmpwi %0,0;\n"			\
+				"	beq- 90b;\n"			\
+				"99:\n"					\
+				".section __ftr_fixup,\"a\"\n"		\
+				".align 3\n"				\
+				"98:\n"					\
+				"	.llong %1\n"			\
+				"	.llong %1\n"			\
+				"	.llong 97b-98b\n"		\
+				"	.llong 99b-98b\n"		\
+				".previous"				\
+			: "=r" (rval) : "i" (CPU_FTR_CELL_TB_BUG)); rval;})
+#else
 #define mftb()		({unsigned long rval;	\
 			asm volatile("mftb %0" : "=r" (rval)); rval;})
+#endif
+
+#ifndef __powerpc64__
 #define mftbl()		({unsigned long rval;	\
 			asm volatile("mftbl %0" : "=r" (rval)); rval;})
+#define mftbu()		({unsigned long rval;	\
+			asm volatile("mftbu %0" : "=r" (rval)); rval;})
+#endif /* __powerpc64__ */
 
 #define mttbl(v)	asm volatile("mttbl %0":: "r"(v))
 #define mttbu(v)	asm volatile("mttbu %0":: "r"(v))
Index: linux-cell/include/asm-powerpc/time.h
===================================================================
--- linux-cell.orig/include/asm-powerpc/time.h	2006-10-06 13:48:24.000000000 +1000
+++ linux-cell/include/asm-powerpc/time.h	2006-10-13 17:31:57.000000000 +1000
@@ -85,26 +85,28 @@ struct div_result {
 /* On ppc64 this gets us the whole timebase; on ppc32 just the lower half */
 static inline unsigned long get_tbl(void)
 {
-	unsigned long tbl;
-
 #if defined(CONFIG_403GCX)
+	unsigned long tbl;
 	asm volatile("mfspr %0, 0x3dd" : "=r" (tbl));
+	return tbl;
+#elif defined(CONFIG_PPC32)
+	return mftbl();
 #else
-	asm volatile("mftb %0" : "=r" (tbl));
+	return mftb();
 #endif
-	return tbl;
 }
 
 static inline unsigned int get_tbu(void)
 {
+#ifdef CONFIG_403GCX
 	unsigned int tbu;
-
-#if defined(CONFIG_403GCX)
 	asm volatile("mfspr %0, 0x3dc" : "=r" (tbu));
+	return tbu;
+#elif defined(CONFIG_PPC32)
+	return mftbu();
 #else
-	asm volatile("mftbu %0" : "=r" (tbu));
+	return mftb();
 #endif
-	return tbu;
 }
 
 static inline unsigned int get_rtcl(void)
Index: linux-cell/include/asm-powerpc/timex.h
===================================================================
--- linux-cell.orig/include/asm-powerpc/timex.h	2006-10-13 17:31:53.000000000 +1000
+++ linux-cell/include/asm-powerpc/timex.h	2006-10-13 17:31:57.000000000 +1000
@@ -8,6 +8,7 @@
  */
 
 #include <asm/cputable.h>
+#include <asm/reg.h>
 
 #define CLOCK_TICK_RATE	1024000 /* Underlying HZ */
 
@@ -15,13 +16,11 @@ typedef unsigned long cycles_t;
 
 static inline cycles_t get_cycles(void)
 {
-	cycles_t ret;
-
 #ifdef __powerpc64__
-
-	__asm__ __volatile__("mftb %0" : "=r" (ret) : );
-
+	return mftb();
 #else
+	cycles_t ret;
+
 	/*
 	 * For the "cycle" counter we use the timebase lower half.
 	 * Currently only used on SMP.
@@ -41,9 +40,8 @@ static inline cycles_t get_cycles(void)
 		"	.long 99b-98b\n"
 		".previous"
 		: "=r" (ret) : "i" (CPU_FTR_601));
-#endif
-
 	return ret;
+#endif
 }
 
 #endif	/* __KERNEL__ */
