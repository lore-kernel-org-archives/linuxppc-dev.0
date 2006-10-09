Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id ADC43679E9
	for <linuxppc-dev@ozlabs.org>; Mon,  9 Oct 2006 15:10:41 +1000 (EST)
Subject: [PATCH] powerpc: Cell timebase bug workaround
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Mon, 09 Oct 2006 15:10:22 +1000
Message-Id: <1160370623.14601.42.camel@localhost.localdomain>
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
by one. Simply reading the timebase a second time if the low order bits
are 0 is enough (the second read will always miss that window).

Note that there is still a potential issue if the process gets
interrupted between the 2 reads for long enough that the second reads
pricely hits that same window on the next 32 bits wrap. However, this is
so extremely unlikely to happen that we choose not to do anything
against it (the 32 bits wrap happens every few seconds or so, in fact
every few minutes on IBM cell blades).

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/arch/powerpc/kernel/vdso64/gettimeofday.S
===================================================================
--- linux-work.orig/arch/powerpc/kernel/vdso64/gettimeofday.S	2006-10-06 13:47:54.000000000 +1000
+++ linux-work/arch/powerpc/kernel/vdso64/gettimeofday.S	2006-10-09 13:28:54.000000000 +1000
@@ -11,6 +11,8 @@
  * as published by the Free Software Foundation; either version
  * 2 of the License, or (at your option) any later version.
  */
+
+#include <linux/config.h>
 #include <asm/processor.h>
 #include <asm/ppc_asm.h>
 #include <asm/vdso.h>
@@ -229,8 +231,13 @@ V_FUNCTION_BEGIN(__do_get_xsec)
 	xor	r0,r8,r8		/* create dependency */
 	add	r3,r3,r0
 
-	/* Get TB & offset it */
-	mftb	r7
+	/* Get TB & offset it. We use the MFTB macro which will generate
+	 * workaround code for Cell. The macro will generate the ELF bits
+	 * for the CPU feature fixup though those aren't actually applied
+	 * on the vDSO, which means that the workaround will always be
+	 * executed if CONFIG_PPC_CELL is set.
+	 */
+	MFTB(r7)
 	ld	r9,CFG_TB_ORIG_STAMP(r3)
 	subf	r7,r9,r7
 
Index: linux-work/include/asm-powerpc/cputable.h
===================================================================
--- linux-work.orig/include/asm-powerpc/cputable.h	2006-10-06 13:48:23.000000000 +1000
+++ linux-work/include/asm-powerpc/cputable.h	2006-10-09 13:30:02.000000000 +1000
@@ -144,6 +144,7 @@ extern void do_cpu_ftr_fixups(unsigned l
 #define CPU_FTR_CI_LARGE_PAGE		LONG_ASM_CONST(0x0000100000000000)
 #define CPU_FTR_PAUSE_ZERO		LONG_ASM_CONST(0x0000200000000000)
 #define CPU_FTR_PURR			LONG_ASM_CONST(0x0000400000000000)
+#define CPU_FTR_CELL_TB_BUG		LONG_ASM_CONST(0x0000800000000000)
 
 #ifndef __ASSEMBLY__
 
@@ -332,7 +333,7 @@ extern void do_cpu_ftr_fixups(unsigned l
 #define CPU_FTRS_CELL	(CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | \
 	    CPU_FTR_HPTE_TABLE | CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
 	    CPU_FTR_ALTIVEC_COMP | CPU_FTR_MMCRA | CPU_FTR_SMT | \
-	    CPU_FTR_PAUSE_ZERO | CPU_FTR_CI_LARGE_PAGE)
+	    CPU_FTR_PAUSE_ZERO | CPU_FTR_CI_LARGE_PAGE | CPU_FTR_CELL_TB_BUG)
 #define CPU_FTRS_PA6T (CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | \
 	    CPU_FTR_HPTE_TABLE | CPU_FTR_PPCAS_ARCH_V2 | \
 	    CPU_FTR_ALTIVEC_COMP | CPU_FTR_CI_LARGE_PAGE | \
@@ -431,30 +432,34 @@ static inline int cpu_has_feature(unsign
 
 #ifdef __ASSEMBLY__
 
-#define BEGIN_FTR_SECTION		98:
+#define BEGIN_FTR_SECTION_NESTED(label)	label:
+#define BEGIN_FTR_SECTION		BEGIN_FTR_SECTION_NESTED(98)
 
 #ifndef __powerpc64__
-#define END_FTR_SECTION(msk, val)		\
+#define END_FTR_SECTION_NESTED(msk, val, label) \
 99:						\
 	.section __ftr_fixup,"a";		\
 	.align 2;				\
 	.long msk;				\
 	.long val;				\
-	.long 98b;				\
+	.long label##b;				\
 	.long 99b;				\
 	.previous
 #else /* __powerpc64__ */
-#define END_FTR_SECTION(msk, val)		\
+#define END_FTR_SECTION_NESTED(msk, val, label) \
 99:						\
 	.section __ftr_fixup,"a";		\
 	.align 3;				\
 	.llong msk;				\
 	.llong val;				\
-	.llong 98b;				\
+	.llong label##b;				\
 	.llong 99b;	 			\
 	.previous
 #endif /* __powerpc64__ */
 
+#define END_FTR_SECTION(msk, val)		\
+	END_FTR_SECTION_NESTED(msk, val, 98)
+
 #define END_FTR_SECTION_IFSET(msk)	END_FTR_SECTION((msk), (msk))
 #define END_FTR_SECTION_IFCLR(msk)	END_FTR_SECTION((msk), 0)
 #endif /* __ASSEMBLY__ */
Index: linux-work/include/asm-powerpc/ppc_asm.h
===================================================================
--- linux-work.orig/include/asm-powerpc/ppc_asm.h	2006-10-06 13:45:32.000000000 +1000
+++ linux-work/include/asm-powerpc/ppc_asm.h	2006-10-09 13:28:54.000000000 +1000
@@ -29,10 +29,10 @@
 BEGIN_FTR_SECTION;							\
 	mfspr	ra,SPRN_PURR;		/* get processor util. reg */	\
 END_FTR_SECTION_IFSET(CPU_FTR_PURR);					\
-BEGIN_FTR_SECTION;							\
-	mftb	ra;			/* or get TB if no PURR */	\
-END_FTR_SECTION_IFCLR(CPU_FTR_PURR);					\
-	ld	rb,PACA_STARTPURR(r13);				\
+BEGIN_FTR_SECTION_NESTED(96);						\
+	MFTB(ra);			/* or get TB if no PURR */	\
+END_FTR_SECTION_NESTED(CPU_FTR_PURR, 0, 96);				\
+	ld	rb,PACA_STARTPURR(r13);					\
 	std	ra,PACA_STARTPURR(r13);					\
 	subf	rb,rb,ra;		/* subtract start value */	\
 	ld	ra,PACA_USER_TIME(r13);					\
@@ -44,9 +44,9 @@ END_FTR_SECTION_IFCLR(CPU_FTR_PURR);				
 BEGIN_FTR_SECTION;							\
 	mfspr	ra,SPRN_PURR;		/* get processor util. reg */	\
 END_FTR_SECTION_IFSET(CPU_FTR_PURR);					\
-BEGIN_FTR_SECTION;							\
-	mftb	ra;			/* or get TB if no PURR */	\
-END_FTR_SECTION_IFCLR(CPU_FTR_PURR);					\
+BEGIN_FTR_SECTION_NESTED(96);						\
+	MFTB(ra);			/* or get TB if no PURR */	\
+END_FTR_SECTION_NESTED(CPU_FTR_PURR, 0, 96);				\
 	ld	rb,PACA_STARTPURR(r13);				\
 	std	ra,PACA_STARTPURR(r13);					\
 	subf	rb,rb,ra;		/* subtract start value */	\
@@ -274,6 +274,18 @@ END_FTR_SECTION_IFSET(CPU_FTR_601)
 #define ISYNC_601
 #endif
 
+#ifdef CONFIG_PPC_CELL
+#define MFTB(dest)			\
+	mftb  dest;			\
+BEGIN_FTR_SECTION;			\
+	cmpwi dest,0;			\
+	bne+  97f;			\
+	mftb  dest;			\
+97:					\
+END_FTR_SECTION_IFSET(CPU_FTR_CELL_TB_BUG)
+#else
+#define MFTB(dest)			mftb dest
+#endif
 
 #ifndef CONFIG_SMP
 #define TLBSYNC
Index: linux-work/include/asm-powerpc/reg.h
===================================================================
--- linux-work.orig/include/asm-powerpc/reg.h	2006-10-09 12:03:34.000000000 +1000
+++ linux-work/include/asm-powerpc/reg.h	2006-10-09 13:28:54.000000000 +1000
@@ -617,9 +617,26 @@
 			asm volatile("mfspr %0," __stringify(rn) \
 				: "=r" (rval)); rval;})
 #define mtspr(rn, v)	asm volatile("mtspr " __stringify(rn) ",%0" : : "r" (v))
-
+#ifdef CONFIG_PPC_CELL
+#define mftb()		({unsigned long rval;				\
+			asm volatile(					\
+				"	mftb %0;\n"			\
+				"98:	cmpwi %0,0;\n"			\
+				"	bne+ 99f;\n"			\
+				"	mftb %0;\n"			\
+				"99:\n"					\
+				".section __ftr_fixup,\"a\"\n"		\
+				"	.llong %1\n"			\
+				"	.llong 0\n"			\
+				"	.llong 98b\n"			\
+				"	.llong 99b\n"			\
+				".previous"				\
+			: "=r" (rval) : "i" (CPU_FTR_CELL_TB_BUG)); rval;})
+#else
 #define mftb()		({unsigned long rval;	\
 			asm volatile("mftb %0" : "=r" (rval)); rval;})
+#endif
+
 #define mftbl()		({unsigned long rval;	\
 			asm volatile("mftbl %0" : "=r" (rval)); rval;})
 
Index: linux-work/include/asm-powerpc/time.h
===================================================================
--- linux-work.orig/include/asm-powerpc/time.h	2006-10-06 13:48:24.000000000 +1000
+++ linux-work/include/asm-powerpc/time.h	2006-10-09 13:28:54.000000000 +1000
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
Index: linux-work/include/asm-powerpc/timex.h
===================================================================
--- linux-work.orig/include/asm-powerpc/timex.h	2006-10-06 13:45:32.000000000 +1000
+++ linux-work/include/asm-powerpc/timex.h	2006-10-09 13:28:54.000000000 +1000
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
@@ -39,9 +38,8 @@ static inline cycles_t get_cycles(void)
 		"	.long 99b\n"
 		".previous"
 		: "=r" (ret) : "i" (CPU_FTR_601));
-#endif
-
 	return ret;
+#endif
 }
 
 #endif	/* __KERNEL__ */
