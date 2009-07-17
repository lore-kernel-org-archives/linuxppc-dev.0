Return-Path: <benh@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id DA977B707E
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 17 Jul 2009 15:36:58 +1000 (EST)
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 17 Jul 2009 15:36:57 +1000
Subject: [PATCH] powerpc: Remove use of a second scratch SPRG in STAB code (v2)
Message-Id: <20090717053658.C39DCDDD1B@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The STAB code used on Power3 and RS/64 uses a second scratch SPRG to
save a GPR in order to decide whether to go to do_stab_bolted_* or
to handle a normal data access exception.

This prevents our scheme of freeing SPRG3 which is user visible for
user uses since we cannot use SPRG0 which, on RS/64, seems to be
read-only for supervisor mode (like POWER4).

This reworks the STAB exception entry to use the PACA as temporary
storage instead.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

v2. Don't break SLB machines :-) Use alternate CPU features to nicely
overlay the code for SLB vs STAB

 arch/powerpc/include/asm/exception-64s.h   |    7 +++--
 arch/powerpc/include/asm/reg.h             |    3 --
 arch/powerpc/kernel/exceptions-64s.S       |   38 +++++++++++++++++++----------
 arch/powerpc/platforms/iseries/exception.S |   37 ++++++++++++++++++----------
 4 files changed, 55 insertions(+), 30 deletions(-)

--- linux-work.orig/arch/powerpc/include/asm/exception-64s.h	2009-07-15 17:42:43.000000000 +1000
+++ linux-work/arch/powerpc/include/asm/exception-64s.h	2009-07-15 17:42:43.000000000 +1000
@@ -66,8 +66,7 @@
 	std	r9,area+EX_R13(r13);					\
 	mfcr	r9
 
-#define EXCEPTION_PROLOG_PSERIES(area, label)				\
-	EXCEPTION_PROLOG_1(area);					\
+#define EXCEPTION_PROLOG_PSERIES_1(label)				\
 	ld	r12,PACAKBASE(r13);	/* get high part of &label */	\
 	ld	r10,PACAKMSR(r13);	/* get MSR value for kernel */	\
 	mfspr	r11,SPRN_SRR0;		/* save SRR0 */			\
@@ -78,6 +77,10 @@
 	rfid;								\
 	b	.	/* prevent speculative execution */
 
+#define EXCEPTION_PROLOG_PSERIES(area, label)				\
+	EXCEPTION_PROLOG_1(area);					\
+	EXCEPTION_PROLOG_PSERIES_1(label);
+
 /*
  * The common exception prolog is used for all except a few exceptions
  * such as a segment miss on a kernel address.  We have to be prepared
Index: linux-work/arch/powerpc/kernel/exceptions-64s.S
===================================================================
--- linux-work.orig/arch/powerpc/kernel/exceptions-64s.S	2009-07-15 17:42:43.000000000 +1000
+++ linux-work/arch/powerpc/kernel/exceptions-64s.S	2009-07-17 12:42:54.000000000 +1000
@@ -50,18 +50,28 @@ data_access_pSeries:
 	HMT_MEDIUM
 	mtspr	SPRN_SPRG_SCRATCH0,r13
 BEGIN_FTR_SECTION
-	mtspr	SPRN_SPRG_SCRATCH1,r12
-	mfspr	r13,SPRN_DAR
-	mfspr	r12,SPRN_DSISR
-	srdi	r13,r13,60
-	rlwimi	r13,r12,16,0x20
-	mfcr	r12
-	cmpwi	r13,0x2c
+	mfspr	r13,SPRN_SPRG_PACA
+	std	r9,PACA_EXSLB+EX_R9(r13)
+	std	r10,PACA_EXSLB+EX_R10(r13)
+	mfspr	r10,SPRN_DAR
+	mfspr	r9,SPRN_DSISR
+	srdi	r10,r10,60
+	rlwimi	r10,r9,16,0x20
+	mfcr	r9
+	cmpwi	r10,0x2c
 	beq	do_stab_bolted_pSeries
-	mtcrf	0x80,r12
-	mfspr	r12,SPRN_SPRG_SCRATCH1
-END_FTR_SECTION_IFCLR(CPU_FTR_SLB)
+	ld	r10,PACA_EXSLB+EX_R10(r13)
+	std	r11,PACA_EXGEN+EX_R11(r13)
+	ld	r11,PACA_EXSLB+EX_R9(r13)
+	std	r12,PACA_EXGEN+EX_R12(r13)
+	mfspr	r12,SPRN_SPRG_SCRATCH0
+	std	r10,PACA_EXGEN+EX_R10(r13)
+	std	r11,PACA_EXGEN+EX_R9(r13)
+	std	r12,PACA_EXGEN+EX_R13(r13)
+	EXCEPTION_PROLOG_PSERIES_1(data_access_common)
+FTR_SECTION_ELSE
 	EXCEPTION_PROLOG_PSERIES(PACA_EXGEN, data_access_common)
+ALT_FTR_SECTION_END_IFCLR(CPU_FTR_SLB)
 
 	. = 0x380
 	.globl data_access_slb_pSeries
@@ -224,9 +234,11 @@ masked_interrupt:
 
 	.align	7
 do_stab_bolted_pSeries:
-	mtcrf	0x80,r12
-	mfspr	r12,SPRN_SPRG_SCRATCH1
-	EXCEPTION_PROLOG_PSERIES(PACA_EXSLB, .do_stab_bolted)
+	std	r11,PACA_EXSLB+EX_R11(r13)
+	std	r12,PACA_EXSLB+EX_R12(r13)
+	mfspr	r10,SPRN_SPRG_SCRATCH0
+	std	r10,PACA_EXSLB+EX_R13(r13)
+	EXCEPTION_PROLOG_PSERIES_1(.do_stab_bolted)
 
 #ifdef CONFIG_PPC_PSERIES
 /*
Index: linux-work/arch/powerpc/platforms/iseries/exception.S
===================================================================
--- linux-work.orig/arch/powerpc/platforms/iseries/exception.S	2009-07-15 17:42:43.000000000 +1000
+++ linux-work/arch/powerpc/platforms/iseries/exception.S	2009-07-17 12:43:01.000000000 +1000
@@ -128,25 +128,36 @@ iSeries_secondary_smp_loop:
 data_access_iSeries:
 	mtspr	SPRN_SPRG_SCRATCH0,r13
 BEGIN_FTR_SECTION
-	mtspr	SPRN_SPRG_SCRATCH1,r12
-	mfspr	r13,SPRN_DAR
-	mfspr	r12,SPRN_DSISR
-	srdi	r13,r13,60
-	rlwimi	r13,r12,16,0x20
-	mfcr	r12
-	cmpwi	r13,0x2c
+	mfspr	r13,SPRN_SPRG_PACA
+	std	r9,PACA_EXSLB+EX_R9(r13)
+	std	r10,PACA_EXSLB+EX_R10(r13)
+	mfspr	r10,SPRN_DAR
+	mfspr	r9,SPRN_DSISR
+	srdi	r10,r10,60
+	rlwimi	r10,r9,16,0x20
+	mfcr	r9
+	cmpwi	r10,0x2c
 	beq	.do_stab_bolted_iSeries
-	mtcrf	0x80,r12
-	mfspr	r12,SPRN_SPRG_SCRATCH1
-END_FTR_SECTION_IFCLR(CPU_FTR_SLB)
+	ld	r10,PACA_EXSLB+EX_R10(r13)
+	std	r11,PACA_EXGEN+EX_R11(r13)
+	ld	r11,PACA_EXSLB+EX_R9(r13)
+	std	r12,PACA_EXGEN+EX_R12(r13)
+	mfspr	r12,SPRN_SPRG_SCRATCH0
+	std	r10,PACA_EXGEN+EX_R10(r13)
+	std	r11,PACA_EXGEN+EX_R9(r13)
+	std	r12,PACA_EXGEN+EX_R13(r13)
+	EXCEPTION_PROLOG_ISERIES_1
+FTR_SECTION_ELSE
 	EXCEPTION_PROLOG_1(PACA_EXGEN)
 	EXCEPTION_PROLOG_ISERIES_1
+ALT_FTR_SECTION_END_IFCLR(CPU_FTR_SLB)
 	b	data_access_common
 
 .do_stab_bolted_iSeries:
-	mtcrf	0x80,r12
-	mfspr	r12,SPRN_SPRG_SCRATCH1
-	EXCEPTION_PROLOG_1(PACA_EXSLB)
+	std	r11,PACA_EXSLB+EX_R11(r13)
+	std	r12,PACA_EXSLB+EX_R12(r13)
+	mfspr	r10,SPRN_SPRG_SCRATCH0
+	std	r10,PACA_EXSLB+EX_R13(r13)
 	EXCEPTION_PROLOG_ISERIES_1
 	b	.do_stab_bolted
 
Index: linux-work/arch/powerpc/include/asm/reg.h
===================================================================
--- linux-work.orig/arch/powerpc/include/asm/reg.h	2009-07-15 17:42:43.000000000 +1000
+++ linux-work/arch/powerpc/include/asm/reg.h	2009-07-17 12:33:37.000000000 +1000
@@ -654,7 +654,7 @@
  * 64-bit server:
  *	- SPRG0 unused (reserved for HV on Power4)
  *	- SPRG1 scratch for exception vectors
- *	- SPRG2 scratch for exception vectors
+ *	- SPRG2 unused
  *
  * All 32-bit:
  *	- SPRG3 current thread_info pointer
@@ -707,7 +707,6 @@
 
 #ifdef CONFIG_PPC_BOOK3S_64
 #define SPRN_SPRG_SCRATCH0	SPRN_SPRG1
-#define SPRN_SPRG_SCRATCH1	SPRN_SPRG2
 #endif
 
 #ifdef CONFIG_PPC_BOOK3S_32
