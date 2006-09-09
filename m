Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id EBEED67BB9
	for <linuxppc-dev@ozlabs.org>; Sun, 10 Sep 2006 08:43:04 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: [RFC] inline hypercall implementation for pseries
Date: Sun, 10 Sep 2006 00:42:53 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200609100042.54291.arnd@arndb.de>
Cc: paulus@samba.org, anton@samba.org, arnd@arndb.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch goes on top of the latest hcall statistics patch from
Mike Kravetz and changes the implementation of all hcalls to 
end up in an inline assembly. This reduces the number of instructions
required on the side of the caller, so that in most cases we
don't need any stack memory at all.

Unfortunately, I don't have any hypervisor machine to try
this out, so I'm hoping someone else can test it and fix the
obvious bugs.

When statistics are enabled, the code is somewhat larger
than before, but for the regular case, it gets smaller,
this is the 'size' output for
arch/powerpc/platforms/pseries/built-in.o:

   text    data     bss     dec     hex filename
  45940   11584    8860   66384   10350 out of line, without stats
  47152   16240    8860   72252   11a3c out-of-line, with stats
  45492   11488    8860   65840   10130 inline, without stats
  47264   16176    8860   72300   11a6c inline, with stats

As an example, the pSeries_lpar_hpte_invalidate function changes
from:

	mflr 0	 #,
	mr 11,5	 # psize, psize
	li 5,0	 #,
	mr 6,3	 # slot, slot
	li 3,4	 #,
	sldi 9,11,5	 #, tmp128, psize
	cmpdi 7,11,0	 #, tmp134, psize
	std 0,16(1)	 #,
	stdu 1,-144(1)	 #,,
	ori 5,5,32768	 #,,,
	ld 0,.LC26@toc(2)	 #, tmp127
	sldi 5,5,16	 #,,
	add 9,9,0	 # tmp129, tmp128, tmp127
	ld 0,16(9)	 # <variable>.avpnm, <variable>.avpnm
	srdi 9,4,23	 #, tmp126, va
	addi 4,1,112	 #,,
	andc 0,9,0	 #, tmp133, tmp126, <variable>.avpnm
	sldi 0,0,7	 #, want_v, tmp133
	beq 7,.L68	 #
	ori 0,0,4	 #, want_v, want_v,
.L68:
	rldicr 7,0,16,47	 #,,, want_v
	rldicr 7,7,48,56	 #,,,
	bl .plpar_hcall	 #
	nop
	cmpdi 7,3,-7	 #, tmp137, rc
	addic 9,3,-1	 #, rc
	subfe 0,9,3	 # tmp142,, rc
	beq 7,.L72	 #
	tdnei 	0,0	 # tmp142
	addi 1,1,144	 #,,
	ld 0,16(1)	 #,
	mtlr 0	 #,
	blr	 #

to

.pSeries_lpar_hpte_invalidate:
	ld 0,.LC26@toc(2)	 #, tmp126
	sldi 6,5,5	 #, tmp127, psize
	cmpdi 7,5,0	 #, tmp133, psize
	srdi 4,4,23	 #, tmp125, va
	mr 5,3	 # slot, slot
	li 3,4	 # __r3,
	add 6,6,0	 # tmp128, tmp127, tmp126
	ld 0,16(6)	 # <variable>.avpnm, <variable>.avpnm
	andc 0,4,0	 #, tmp132, tmp125, <variable>.avpnm
	sldi 0,0,7	 #, want_v, tmp132
	beq 7,.L68	 #
	ori 0,0,4	 #, want_v, want_v,
	or 2,2,2	     # medium priority
	li 4,0	 # __r4,
	rldicr 6,0,0,56	 #, __r6, want_v
	ori 4,4,32768	 #, __r4, __r4,
	sldi 4,4,16	 #, __r4, __r4
	.long 0x44000022 # HVCALL
	cmpdi 7,3,-7	 #, tmp135, lpar_rc
	addic 9,3,-1	 #, lpar_rc
	subfe 0,9,3	 # tmp140,, lpar_rc
	beqlr 7
	tdnei 	0,0	 # tmp140
	blr

and this also avoid the overhead of writing output arguments
to memory if they are not used afterwards.

	Arnd <><

Index: linus-2.6/arch/powerpc/platforms/pseries/hvCall.S
===================================================================
--- linus-2.6.orig/arch/powerpc/platforms/pseries/hvCall.S	2006-09-10 
00:17:27.000000000 +0200
+++ linus-2.6/arch/powerpc/platforms/pseries/hvCall.S	2006-09-10 
00:17:27.000000000 +0200
@@ -11,154 +11,43 @@
 #include <asm/processor.h>
 #include <asm/ppc_asm.h>
 #include <asm/asm-offsets.h>
-	
-#define STK_PARM(i)     (48 + ((i)-3)*8)
 
-#ifdef CONFIG_HCALL_STATS
-/*
- * precall must preserve all registers.  use unused STK_PARM()
- * areas to save snapshots and opcode.
- */
-#define HCALL_INST_PRECALL					\
-	std	r3,STK_PARM(r3)(r1);	/* save opcode */	\
-	mftb	r0;			/* get timebase and */	\
-	std     r0,STK_PARM(r5)(r1);	/* save for later */	\
-BEGIN_FTR_SECTION;						\
-	mfspr	r0,SPRN_PURR;		/* get PURR and */	\
-	std	r0,STK_PARM(r6)(r1);	/* save for later */	\
-END_FTR_SECTION_IFCLR(CPU_FTR_PURR);
-	
+	.text
+_GLOBAL(hcall_instrument)
 /*
- * postcall is performed immediately before function return which
- * allows liberal use of volatile registers.
+ * Special calling conventions:
+ *  - r3 to r12 are input and output argument registers.
+ *  - r13 contains a pointer to the statistics structure for the
+ *    current hcall number / cpu.
+ *  - r14, r15 and r16 are clobbered during this call and need to
+ *    be saved by the caller.
+ *  - cr is caller clobbered as well
  */
-#define HCALL_INST_POSTCALL					\
-	ld	r4,STK_PARM(r3)(r1);	/* validate opcode */	\
-	cmpldi	cr7,r4,MAX_HCALL_OPCODE;			\
-	bgt-	cr7,1f;						\
-								\
-	/* get time and PURR snapshots after hcall */		\
-	mftb	r7;			/* timebase after */	\
-BEGIN_FTR_SECTION;						\
-	mfspr	r8,SPRN_PURR;		/* PURR after */	\
-	ld	r6,STK_PARM(r6)(r1);	/* PURR before */	\
-	subf	r6,r6,r8;		/* delta */		\
-END_FTR_SECTION_IFCLR(CPU_FTR_PURR);				\
-	ld	r5,STK_PARM(r5)(r1);	/* timebase before */	\
-	subf	r5,r5,r7;		/* time delta */	\
-								\
-	/* calculate address of stat structure r4 = opcode */	\
-	srdi	r4,r4,2;		/* index into array */	\
-	mulli	r4,r4,HCALL_STAT_SIZE;				\
-	LOAD_REG_ADDR(r7, per_cpu__hcall_stats);		\
-	add	r4,r4,r7;					\
-	ld	r7,PACA_DATA_OFFSET(r13); /* per cpu offset */	\
-	add	r4,r4,r7;					\
-								\
-	/* update stats	*/					\
-	ld	r7,HCALL_STAT_CALLS(r4); /* count */		\
-	addi	r7,r7,1;					\
-	std	r7,HCALL_STAT_CALLS(r4);			\
-	ld      r7,HCALL_STAT_TB(r4);	/* timebase */		\
-	add	r7,r7,r5;					\
-	std	r7,HCALL_STAT_TB(r4);				\
-BEGIN_FTR_SECTION;						\
-	ld	r7,HCALL_STAT_PURR(r4);	/* PURR */		\
-	add	r7,r7,r6;					\
-	std	r7,HCALL_STAT_PURR(r4);				\
-END_FTR_SECTION_IFCLR(CPU_FTR_PURR);				\
-1:
-#else
-#define HCALL_INST_PRECALL
-#define HCALL_INST_POSTCALL
-#endif
-
-	.text
-
-_GLOBAL(plpar_hcall_norets)
-	HMT_MEDIUM
-
-	mfcr	r0
-	stw	r0,8(r1)
-
-	HCALL_INST_PRECALL
+	mftb	r15			/* get timebase and */
+BEGIN_FTR_SECTION;
+	mfspr	r16,SPRN_PURR		/* get PURR and */
+END_FTR_SECTION_IFCLR(CPU_FTR_PURR)
 
 	HVSC				/* invoke the hypervisor */
 
-	HCALL_INST_POSTCALL
-
-	lwz	r0,8(r1)
-	mtcrf	0xff,r0
-	blr				/* return r3 = status */
-
-_GLOBAL(plpar_hcall)
-	HMT_MEDIUM
-
-	mfcr	r0
-	stw	r0,8(r1)
-
-	HCALL_INST_PRECALL
-
-	std     r4,STK_PARM(r4)(r1)     /* Save ret buffer */
-
-	mr	r4,r5
-	mr	r5,r6
-	mr	r6,r7
-	mr	r7,r8
-	mr	r8,r9
-	mr	r9,r10
-
-	HVSC				/* invoke the hypervisor */
-
-	ld	r12,STK_PARM(r4)(r1)
-	std	r4,  0(r12)
-	std	r5,  8(r12)
-	std	r6, 16(r12)
-	std	r7, 24(r12)
-
-	HCALL_INST_POSTCALL
-
-	lwz	r0,8(r1)
-	mtcrf	0xff,r0
-
-	blr				/* return r3 = status */
-
-_GLOBAL(plpar_hcall9)
-	HMT_MEDIUM
-
-	mfcr	r0
-	stw	r0,8(r1)
-
-	HCALL_INST_PRECALL
-
-	std     r4,STK_PARM(r4)(r1)     /* Save ret buffer */
-
-	mr	r4,r5
-	mr	r5,r6
-	mr	r6,r7
-	mr	r7,r8
-	mr	r8,r9
-	mr	r9,r10
-	ld	r10,STK_PARM(r11)(r1)	 /* put arg7 in R10 */
-	ld	r11,STK_PARM(r12)(r1)	 /* put arg8 in R11 */
-	ld	r12,STK_PARM(r13)(r1)    /* put arg9 in R12 */
-
-	HVSC				/* invoke the hypervisor */
-
-	ld	r12,STK_PARM(r4)(r1)
-	std	r4,  0(r12)
-	std	r5,  8(r12)
-	std	r6, 16(r12)
-	std	r7, 24(r12)
-	std	r8, 32(r12)
-	std	r9, 40(r12)
-	std	r10,48(r12)
-	std	r11,56(r12)
-	std	r12,64(r12)
-
-	HCALL_INST_POSTCALL
-
-	lwz	r0,8(r1)
-	mtcrf	0xff,r0
-
-	blr				/* return r3 = status */
+	/* get time and PURR snapshots after hcall */
+	mftb	r14			/* timebase after */
+	subf	r15,r15,r14		/* time delta */
+BEGIN_FTR_SECTION
+	mfspr	r14,SPRN_PURR		/* PURR after */
+	subf	r16,r16,r14		/* delta */
+END_FTR_SECTION_IFCLR(CPU_FTR_PURR)
+
+	/* update stats	*/
+	ld	r14,HCALL_STAT_CALLS(r13) /* count */
+	addi	r14,r14,1
+	std	r14,HCALL_STAT_CALLS(r13)
+	ld      r14,HCALL_STAT_TB(r13)	/* timebase */
+	add	r14,r14,r5
+	std	r14,HCALL_STAT_TB(r13)
+BEGIN_FTR_SECTION
+	ld	r14,HCALL_STAT_PURR(r13)/* PURR */
+	add	r14,r14,r6
+	std	r14,HCALL_STAT_PURR(r13)
+END_FTR_SECTION_IFCLR(CPU_FTR_PURR)
+1:	blr
Index: linus-2.6/arch/powerpc/kernel/asm-offsets.c
===================================================================
--- linus-2.6.orig/arch/powerpc/kernel/asm-offsets.c	2006-09-10 
00:17:27.000000000 +0200
+++ linus-2.6/arch/powerpc/kernel/asm-offsets.c	2006-09-10 00:17:27.000000000 
+0200
@@ -44,6 +44,7 @@
 #include <asm/cache.h>
 #include <asm/compat.h>
 #include <asm/mmu.h>
+#include <asm/hvcall.h>
 #endif
 
 #define DEFINE(sym, val) \
Index: linus-2.6/include/asm-powerpc/hvcall.h
===================================================================
--- linus-2.6.orig/include/asm-powerpc/hvcall.h	2006-09-10 00:17:27.000000000 
+0200
+++ linus-2.6/include/asm-powerpc/hvcall.h	2006-09-10 00:17:27.000000000 +0200
@@ -2,6 +2,13 @@
 #define _ASM_POWERPC_HVCALL_H
 #ifdef __KERNEL__
 
+#ifndef __ASSEMBLY__
+#include <asm/reg.h>
+#include <asm/time.h>
+#include <asm/cputable.h>
+#include <linux/percpu.h>
+#endif
+
 #define HVSC			.long 0x44000022
 
 #define H_SUCCESS	0
@@ -212,6 +219,194 @@
 
 #ifndef __ASSEMBLY__
 
+#define __hvcall_plpar(nr, nr_in, i1, i2, i3, i4, i5, i6, i7, i8, o1, o2, o3, 
o4, o5, o6, o7) \
+({ \
+	register unsigned long __r3 asm("r3") = nr; \
+	register unsigned long __r4 asm("r4"); \
+	register unsigned long __r5 asm("r5"); \
+	register unsigned long __r6 asm("r6"); \
+	register unsigned long __r7 asm("r7"); \
+	register unsigned long __r8 asm("r8"); \
+	register unsigned long __r9 asm("r9"); \
+	register unsigned long __r10 asm("r10"); \
+	register unsigned long __r11 asm("r11"); \
+	HMT_medium(); \
+	if ((nr_in) >= 1) __r4 = (unsigned long)i1; \
+	if ((nr_in) >= 2) __r5 = (unsigned long)i2; \
+	if ((nr_in) >= 3) __r6 = (unsigned long)i3; \
+	if ((nr_in) >= 4) __r7 = (unsigned long)i4; \
+	if ((nr_in) >= 5) __r8 = (unsigned long)i5; \
+	if ((nr_in) >= 6) __r9 = (unsigned long)i6; \
+	if ((nr_in) >= 7) __r10 = (unsigned long)i7; \
+	if ((nr_in) >= 8) __r11 = (unsigned long)i8; \
+	asm volatile(".long 0x44000022" : \
+			"+r" (__r3), \
+			"+r" (__r4), \
+			"+r" (__r5), \
+			"+r" (__r6), \
+			"+r" (__r7), \
+			"+r" (__r8), \
+			"+r" (__r9), \
+			"+r" (__r10), \
+			"+r" (__r11) : \
+			"0" (__r3), \
+			"1" (__r4), \
+			"2" (__r5), \
+			"3" (__r6), \
+			"4" (__r7), \
+			"5" (__r8), \
+			"6" (__r9), \
+			"7" (__r10), \
+			"8" (__r11) : \
+			"cc", "memory"); \
+	*(o1) = (typeof (*(o1)))__r4; \
+	*(o2) = (typeof (*(o2)))__r5; \
+	*(o3) = (typeof (*(o3)))__r6; \
+	*(o4) = (typeof (*(o4)))__r7; \
+	*(o5) = (typeof (*(o5)))__r8; \
+	*(o6) = (typeof (*(o6)))__r9; \
+	*(o7) = (typeof (*(o7)))__r10; \
+	__r3; \
+})
+
+#define __hvcall_plpar_stats(nr, nr_in, i1, i2, i3, i4, i5, i6, i7, i8, o1, 
o2, o3, o4, o5, o6, o7) \
+({ \
+	register unsigned long __r3 asm("r3") = nr; \
+	register unsigned long __r4 asm("r4"); \
+	register unsigned long __r5 asm("r5"); \
+	register unsigned long __r6 asm("r6"); \
+	register unsigned long __r7 asm("r7"); \
+	register unsigned long __r8 asm("r8"); \
+	register unsigned long __r9 asm("r9"); \
+	register unsigned long __r10 asm("r10"); \
+	register unsigned long __r11 asm("r11"); \
+	register unsigned long __r13 asm("r13"); \
+	HMT_medium(); \
+	BUILD_BUG_ON(nr > MAX_HCALL_OPCODE); \
+	if ((nr_in) >= 1) __r4 = (unsigned long)i1; \
+	if ((nr_in) >= 2) __r5 = (unsigned long)i2; \
+	if ((nr_in) >= 3) __r6 = (unsigned long)i3; \
+	if ((nr_in) >= 4) __r7 = (unsigned long)i4; \
+	if ((nr_in) >= 5) __r8 = (unsigned long)i5; \
+	if ((nr_in) >= 6) __r9 = (unsigned long)i6; \
+	if ((nr_in) >= 7) __r10 = (unsigned long)i7; \
+	if ((nr_in) >= 8) __r11 = (unsigned long)i8; \
+ 	__r13 = (unsigned long)&__get_cpu_var(hcall_stats)[nr >> 2]; \
+	asm volatile("bl .hcall_instrument" : \
+			"+r" (__r3), \
+			"+r" (__r4), \
+			"+r" (__r5), \
+			"+r" (__r6), \
+			"+r" (__r7), \
+			"+r" (__r8), \
+			"+r" (__r9), \
+			"+r" (__r10), \
+			"+r" (__r11), \
+			"+r" (__r13) : \
+			"0" (__r3), \
+			"1" (__r4), \
+			"2" (__r5), \
+			"3" (__r6), \
+			"4" (__r7), \
+			"5" (__r8), \
+			"6" (__r9), \
+			"7" (__r10), \
+			"8" (__r11) : \
+			"cc", "memory", "r14", "r15", "r16"); \
+	*(o1) = (typeof (*(o1)))__r4; \
+	*(o2) = (typeof (*(o2)))__r5; \
+	*(o3) = (typeof (*(o3)))__r6; \
+	*(o4) = (typeof (*(o4)))__r7; \
+	*(o5) = (typeof (*(o5)))__r8; \
+	*(o6) = (typeof (*(o6)))__r9; \
+	*(o7) = (typeof (*(o7)))__r10; \
+	__r3; \
+})
+
+/* inline hypercall statistics */
+struct hcall_stats {
+	unsigned long   num_calls;      /* number of calls (on this CPU) */
+	unsigned long   tb_total;       /* total wall time (mftb) of calls. */
+	unsigned long   purr_total;     /* total cpu time (PURR) of calls. */
+};
+
+DECLARE_PER_CPU(struct hcall_stats[], hcall_stats);
+
+/* resolve variable number of output arguments */
+
+#define __hvcall_out7(type, nr, nr_in, i1, i2, i3, i4, i5, i6, i7, i8, o1, 
o2, o3, o4, o5, o6, o7) \
+__hvcall_ ## type(nr, nr_in, i1, i2, i3, i4, i5, i6, i7, i8, o1, o2, o3, o4, 
o5, o6, o7)
+
+#define __hvcall_out6(type, nr, nr_in, i1, i2, i3, i4, i5, i6, i7, i8, o1, 
o2, o3, o4, o5, o6) \
+unsigned long o7; __hvcall_out7(type, nr, nr_in, i1, i2, i3, i4, i5, i6, i7, 
i8, o1, o2, o3, o4, o5, o6, &o7)
+
+#define __hvcall_out5(type, nr, nr_in, i1, i2, i3, i4, i5, i6, i7, i8, o1, 
o2, o3, o4, o5) \
+unsigned long o6; __hvcall_out6(type, nr, nr_in, i1, i2, i3, i4, i5, i6, i7, 
i8, o1, o2, o3, o4, o5, &o6)
+
+#define __hvcall_out4(type, nr, nr_in, i1, i2, i3, i4, i5, i6, i7, i8, o1, 
o2, o3, o4) \
+unsigned long o5; __hvcall_out5(type, nr, nr_in, i1, i2, i3, i4, i5, i6, i7, 
i8, o1, o2, o3, o4, &o5)
+
+#define __hvcall_out3(type, nr, nr_in, i1, i2, i3, i4, i5, i6, i7, i8, o1, 
o2, o3) \
+unsigned long o4; __hvcall_out4(type, nr, nr_in, i1, i2, i3, i4, i5, i6, i7, 
i8, o1, o2, o3, &o4)
+
+#define __hvcall_out2(type, nr, nr_in, i1, i2, i3, i4, i5, i6, i7, i8, o1, 
o2) \
+unsigned long o3; __hvcall_out3(type, nr, nr_in, i1, i2, i3, i4, i5, i6, i7, 
i8, o1, o2, &o3)
+
+#define __hvcall_out1(type, nr, nr_in, i1, i2, i3, i4, i5, i6, i7, i8, o1) \
+unsigned long o2; __hvcall_out2(type, nr, nr_in, i1, i2, i3, i4, i5, i6, i7, 
i8, o1, &o2)
+
+#define __hvcall_out0(type, nr, nr_in, i1, i2, i3, i4, i5, i6, i7, i8) \
+unsigned long o1; __hvcall_out1(type, nr, nr_in, i1, i2, i3, i4, i5, i6, i7, 
i8, &o1)
+
+/* resolve variable number of input arguments */
+
+#define __hvcall_in8(type, nr, nr_in, nr_out, i1, i2, i3, i4, i5, i6, i7, i8, 
o...) \
+__hvcall_out ## nr_out(type, nr, nr_in, i1, i2, i3, i4, i5, i6, i7, i8, ## o)
+
+#define __hvcall_in7(type, nr, nr_in, nr_out, i1, i2, i3, i4, i5, i6, i7, 
o...) \
+__hvcall_in8(type, nr, nr_in, nr_out, i1, i2, i3, i4, i5, i6, i7, 0, ## o)
+
+#define __hvcall_in6(type, nr, nr_in, nr_out, i1, i2, i3, i4, i5, i6, o...) \
+__hvcall_in7(type, nr, nr_in, nr_out, i1, i2, i3, i4, i5, i6, 0, ## o)
+
+#define __hvcall_in5(type, nr, nr_in, nr_out, i1, i2, i3, i4, i5, o...) \
+__hvcall_in6(type, nr, nr_in, nr_out, i1, i2, i3, i4, i5, 0, ## o)
+
+#define __hvcall_in4(type, nr, nr_in, nr_out, i1, i2, i3, i4, o...) \
+__hvcall_in5(type, nr, nr_in, nr_out, i1, i2, i3, i4, 0, ## o)
+
+#define __hvcall_in3(type, nr, nr_in, nr_out, i1, i2, i3, o...) \
+__hvcall_in4(type, nr, nr_in, nr_out, i1, i2, i3, 0, ## o)
+
+#define __hvcall_in2(type, nr, nr_in, nr_out, i1, i2, o...) \
+__hvcall_in3(type, nr, nr_in, nr_out, i1, i2, 0, ## o)
+
+#define __hvcall_in1(type, nr, nr_in, nr_out, i1, o...) \
+__hvcall_in2(type, nr, nr_in, nr_out, i1, 0, ## o)
+
+#define __hvcall_in0(type, nr, nr_in, nr_out, o...) \
+__hvcall_in1(type, nr, nr_in, nr_out, 0, ## o)
+
+#ifndef CONFIG_HCALL_STATS
+/**
+ * hvcall: the main entry point for calling a hypervisor function
+ *
+ * @nr: hcall API number
+ * @nr_in: numer of input arguments
+ * @nr_out: number of output arguments
+ * @args: input and output arguments, number must match nr_in + nr_out
+ *
+ * Arguments can be of any basic type that can be casted to
+ * unsigned long. Output arguments are passed as pointers.
+ */
+#define plpar_hcall(nr, nr_in, nr_out, args...) \
+({ __hvcall_in ## nr_in(plpar, nr, nr_in, nr_out, ## args); })
+#else
+#define plpar_hcall(nr, nr_in, nr_out, args...) \
+({ __hvcall_in ## nr_in(plpar_stats, nr, nr_in, nr_out, ## args); })
+#endif
+
+#if 0
 /**
  * plpar_hcall_norets: - Make a pseries hypervisor call with no return 
arguments
  * @opcode: The hypervisor call to make.
@@ -256,6 +451,12 @@
                        unsigned long purr_delta);
 #define HCALL_STAT_ARRAY_SIZE  ((MAX_HCALL_OPCODE >> 2) + 1)
 
+#endif
+
+void update_hcall_stats(unsigned long opcode, unsigned long tb_delta,
+                       unsigned long purr_delta);
+#define HCALL_STAT_ARRAY_SIZE  ((MAX_HCALL_OPCODE >> 2) + 1)
+
 #endif /* __ASSEMBLY__ */
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_HVCALL_H */
Index: linus-2.6/arch/powerpc/kernel/rtas.c
===================================================================
--- linus-2.6.orig/arch/powerpc/kernel/rtas.c	2006-09-10 00:17:12.000000000 
+0200
+++ linus-2.6/arch/powerpc/kernel/rtas.c	2006-09-10 00:17:27.000000000 +0200
@@ -665,7 +665,7 @@
 	 */
 	local_irq_save(flags);
 	do {
-		rc = plpar_hcall_norets(H_JOIN);
+		rc = plpar_hcall(H_JOIN, 0, 0);
 		smp_rmb();
 	} while (rc == H_SUCCESS && data->waiting > 0);
 	if (rc == H_SUCCESS)
@@ -676,7 +676,7 @@
 		data->args->args[data->args->nargs] =
 			rtas_call(ibm_suspend_me_token, 0, 1, NULL);
 		for_each_possible_cpu(i)
-			plpar_hcall_norets(H_PROD,i);
+			plpar_hcall(H_PROD, 1, 0, i);
 	} else {
 		data->waiting = -EBUSY;
 		printk(KERN_ERR "Error on H_JOIN hypervisor call\n");
@@ -692,14 +692,11 @@
 	int i;
 	long state;
 	long rc;
-	unsigned long retbuf[PLPAR_HCALL_BUFSIZE];
 	struct rtas_suspend_me_data data;
 
 	/* Make sure the state is valid */
-	rc = plpar_hcall(H_VASI_STATE, retbuf,
-			 ((u64)args->args[0] << 32) | args->args[1]);
-
-	state = retbuf[0];
+	rc = plpar_hcall(H_VASI_STATE, 1, 1,
+			 ((u64)args->args[0] << 32) | args->args[1], &state);
 
 	if (rc) {
 		printk(KERN_ERR "rtas_ibm_suspend_me: vasi_state returned %ld\n",rc);
@@ -730,7 +727,7 @@
 	 * anyone we successfully put to sleep with H_JOIN.
 	 */
 	for_each_possible_cpu(i)
-		plpar_hcall_norets(H_PROD, i);
+		plpar_hcall(H_PROD, 1, 0, i);
 
 	return data.waiting;
 }
Index: linus-2.6/arch/powerpc/platforms/pseries/plpar_wrappers.h
===================================================================
--- linus-2.6.orig/arch/powerpc/platforms/pseries/plpar_wrappers.h	2006-09-10 
00:17:12.000000000 +0200
+++ linus-2.6/arch/powerpc/platforms/pseries/plpar_wrappers.h	2006-09-10 
00:17:27.000000000 +0200
@@ -5,17 +5,17 @@
 
 static inline long poll_pending(void)
 {
-	return plpar_hcall_norets(H_POLL_PENDING);
+	return plpar_hcall(H_POLL_PENDING, 0, 0);
 }
 
 static inline long prod_processor(void)
 {
-	return plpar_hcall_norets(H_PROD);
+	return plpar_hcall(H_PROD, 0, 0);
 }
 
 static inline long cede_processor(void)
 {
-	return plpar_hcall_norets(H_CEDE);
+	return plpar_hcall(H_CEDE, 0, 0);
 }
 
 static inline long vpa_call(unsigned long flags, unsigned long cpu,
@@ -24,7 +24,7 @@
 	/* flags are in bits 16-18 (counting from most significant bit) */
 	flags = flags << (63 - 18);
 
-	return plpar_hcall_norets(H_REGISTER_VPA, flags, cpu, vpa);
+	return plpar_hcall(H_REGISTER_VPA, 3, 0, flags, cpu, vpa);
 }
 
 static inline long unregister_vpa(unsigned long cpu, unsigned long vpa)
@@ -53,131 +53,86 @@
 		unsigned long hpte_group, unsigned long hpte_v,
 		unsigned long hpte_r, unsigned long *slot)
 {
-	long rc;
-	unsigned long retbuf[PLPAR_HCALL_BUFSIZE];
-
-	rc = plpar_hcall(H_ENTER, retbuf, flags, hpte_group, hpte_v, hpte_r);
-
-	*slot = retbuf[0];
-
-	return rc;
+	return  plpar_hcall(H_ENTER, 4, 1, flags, hpte_group, hpte_v, hpte_r, slot);
 }
 
 static inline long plpar_pte_remove(unsigned long flags, unsigned long ptex,
 		unsigned long avpn, unsigned long *old_pteh_ret,
 		unsigned long *old_ptel_ret)
 {
-	long rc;
-	unsigned long retbuf[PLPAR_HCALL_BUFSIZE];
-
-	rc = plpar_hcall(H_REMOVE, retbuf, flags, ptex, avpn);
-
-	*old_pteh_ret = retbuf[0];
-	*old_ptel_ret = retbuf[1];
-
-	return rc;
+	return plpar_hcall(H_REMOVE, 3, 2, flags, ptex, avpn, old_pteh_ret, 
old_ptel_ret);
 }
 
 static inline long plpar_pte_read(unsigned long flags, unsigned long ptex,
 		unsigned long *old_pteh_ret, unsigned long *old_ptel_ret)
 {
-	long rc;
-	unsigned long retbuf[PLPAR_HCALL_BUFSIZE];
-
-	rc = plpar_hcall(H_READ, retbuf, flags, ptex);
-
-	*old_pteh_ret = retbuf[0];
-	*old_ptel_ret = retbuf[1];
-
-	return rc;
+	return plpar_hcall(H_READ, 2, 2, flags, ptex, old_pteh_ret, old_ptel_ret);
 }
 
 static inline long plpar_pte_protect(unsigned long flags, unsigned long ptex,
 		unsigned long avpn)
 {
-	return plpar_hcall_norets(H_PROTECT, flags, ptex, avpn);
+	return plpar_hcall(H_PROTECT, 3, 0, flags, ptex, avpn);
 }
 
 static inline long plpar_tce_get(unsigned long liobn, unsigned long ioba,
 		unsigned long *tce_ret)
 {
-	long rc;
-	unsigned long retbuf[PLPAR_HCALL_BUFSIZE];
-
-	rc = plpar_hcall(H_GET_TCE, retbuf, liobn, ioba);
-
-	*tce_ret = retbuf[0];
-
-	return rc;
+	return plpar_hcall(H_GET_TCE, 2, 1, liobn, ioba, tce_ret);
 }
 
 static inline long plpar_tce_put(unsigned long liobn, unsigned long ioba,
 		unsigned long tceval)
 {
-	return plpar_hcall_norets(H_PUT_TCE, liobn, ioba, tceval);
+	return plpar_hcall(H_PUT_TCE, 3, 0, liobn, ioba, tceval);
 }
 
 static inline long plpar_tce_put_indirect(unsigned long liobn,
 		unsigned long ioba, unsigned long page, unsigned long count)
 {
-	return plpar_hcall_norets(H_PUT_TCE_INDIRECT, liobn, ioba, page, count);
+	return plpar_hcall(H_PUT_TCE_INDIRECT, 4, 0, liobn, ioba, page, count);
 }
 
 static inline long plpar_tce_stuff(unsigned long liobn, unsigned long ioba,
 		unsigned long tceval, unsigned long count)
 {
-	return plpar_hcall_norets(H_STUFF_TCE, liobn, ioba, tceval, count);
+	return plpar_hcall(H_STUFF_TCE, 4, 0, liobn, ioba, tceval, count);
 }
 
 static inline long plpar_get_term_char(unsigned long termno,
 		unsigned long *len_ret, char *buf_ret)
 {
-	long rc;
-	unsigned long retbuf[PLPAR_HCALL_BUFSIZE];
 	unsigned long *lbuf = (unsigned long *)buf_ret;	/* TODO: alignment? */
 
-	rc = plpar_hcall(H_GET_TERM_CHAR, retbuf, termno);
-
-	*len_ret = retbuf[0];
-	lbuf[0] = retbuf[1];
-	lbuf[1] = retbuf[2];
-
-	return rc;
+	return plpar_hcall(H_GET_TERM_CHAR, 1, 3, termno, len_ret, lbuf, lbuf+1);
 }
 
 static inline long plpar_put_term_char(unsigned long termno, unsigned long 
len,
 		const char *buffer)
 {
 	unsigned long *lbuf = (unsigned long *)buffer;	/* TODO: alignment? */
-	return plpar_hcall_norets(H_PUT_TERM_CHAR, termno, len, lbuf[0],
+	return plpar_hcall(H_PUT_TERM_CHAR, 4, 0, termno, len, lbuf[0],
 			lbuf[1]);
 }
 
 static inline long plpar_eoi(unsigned long xirr)
 {
-	return plpar_hcall_norets(H_EOI, xirr);
+	return plpar_hcall(H_EOI, 1, 0, xirr);
 }
 
 static inline long plpar_cppr(unsigned long cppr)
 {
-	return plpar_hcall_norets(H_CPPR, cppr);
+	return plpar_hcall(H_CPPR, 1, 0, cppr);
 }
 
 static inline long plpar_ipi(unsigned long servernum, unsigned long mfrr)
 {
-	return plpar_hcall_norets(H_IPI, servernum, mfrr);
+	return plpar_hcall(H_IPI, 2, 0, servernum, mfrr);
 }
 
 static inline long plpar_xirr(unsigned long *xirr_ret)
 {
-	long rc;
-	unsigned long retbuf[PLPAR_HCALL_BUFSIZE];
-
-	rc = plpar_hcall(H_XIRR, retbuf);
-
-	*xirr_ret = retbuf[0];
-
-	return rc;
+	return plpar_hcall(H_XIRR, 0, 1, xirr_ret);
 }
 
 #endif /* _PSERIES_PLPAR_WRAPPERS_H */
Index: linus-2.6/include/asm-powerpc/vio.h
===================================================================
--- linus-2.6.orig/include/asm-powerpc/vio.h	2006-09-10 00:17:12.000000000 
+0200
+++ linus-2.6/include/asm-powerpc/vio.h	2006-09-10 00:17:27.000000000 +0200
@@ -34,7 +34,7 @@
 /* End architecture-specific constants */
 
 #define h_vio_signal(ua, mode) \
-  plpar_hcall_norets(H_VIO_SIGNAL, ua, mode)
+  plpar_hcall(H_VIO_SIGNAL, 2, 0, ua, mode)
 
 #define VIO_IRQ_DISABLE		0UL
 #define VIO_IRQ_ENABLE		1UL
Index: linus-2.6/arch/powerpc/platforms/pseries/setup.c
===================================================================
--- linus-2.6.orig/arch/powerpc/platforms/pseries/setup.c	2006-09-10 
00:17:12.000000000 +0200
+++ linus-2.6/arch/powerpc/platforms/pseries/setup.c	2006-09-10 
00:17:27.000000000 +0200
@@ -215,7 +215,7 @@
 
 	set = 1UL << 63;
 	reset = 0;
-	plpar_hcall_norets(H_PERFMON, set, reset);
+	plpar_hcall(H_PERFMON, 2, 0, set, reset);
 
 	/* instruct hypervisor to maintain PMCs */
 	if (firmware_has_feature(FW_FEATURE_SPLPAR))
@@ -355,13 +355,13 @@
 
 static int pseries_set_dabr(unsigned long dabr)
 {
-	return plpar_hcall_norets(H_SET_DABR, dabr);
+	return plpar_hcall(H_SET_DABR, 1, 0, dabr);
 }
 
 static int pseries_set_xdabr(unsigned long dabr)
 {
 	/* We want to catch accesses from kernel and userspace */
-	return plpar_hcall_norets(H_SET_XDABR, dabr,
+	return plpar_hcall(H_SET_XDABR, 2, 0, dabr,
 			H_DABRX_KERNEL | H_DABRX_USER);
 }
 
Index: linus-2.6/arch/powerpc/platforms/pseries/lpar.c
===================================================================
--- linus-2.6.orig/arch/powerpc/platforms/pseries/lpar.c	2006-09-10 
00:17:48.000000000 +0200
+++ linus-2.6/arch/powerpc/platforms/pseries/lpar.c	2006-09-10 
00:18:10.000000000 +0200
@@ -48,11 +48,6 @@
 #define DBG_LOW(fmt...) do { } while(0)
 #endif
 
-/* in hvCall.S */
-EXPORT_SYMBOL(plpar_hcall);
-EXPORT_SYMBOL(plpar_hcall9);
-EXPORT_SYMBOL(plpar_hcall_norets);
-
 extern void pSeries_find_serial_port(void);
 
 
