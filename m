Return-Path: <anton@samba.org>
Date: Wed, 18 Apr 2012 22:21:52 +1000
From: Anton Blanchard <anton@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 4/4] powerpc: Remove CONFIG_POWER4_ONLY
Message-ID: <20120418222152.70fbee35@kryten>
In-Reply-To: <1334732224.1159.4.camel@pasglop>
References: <20120418144254.3286ce94@kryten> <20120418144629.3f02e897@kryten>
 <1334731564.1159.2.camel@pasglop> <20120418165116.4bdcbbfe@kryten>
 <1334732224.1159.4.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Remove CONFIG_POWER4_ONLY, the option is badly named and only does two
things:

- It wraps the MMU segment table code. With feature fixups there is
  little downside to compiling this in.

- It uses the newer mtocrf instruction in various assembly functions.
  Instead of making this a compile option just do it at runtime via
  a feature fixup.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

v2: Use CPU_FTR_NOEXECUTE to select the newer mtocrf

Index: linux-build/arch/powerpc/configs/g5_defconfig
===================================================================
--- linux-build.orig/arch/powerpc/configs/g5_defconfig	2012-04-18 22:12:59.292790202 +1000
+++ linux-build/arch/powerpc/configs/g5_defconfig	2012-04-18 22:13:13.029035714 +1000
@@ -1,5 +1,4 @@
 CONFIG_PPC64=y
-CONFIG_POWER4_ONLY=y
 CONFIG_ALTIVEC=y
 CONFIG_SMP=y
 CONFIG_NR_CPUS=4
Index: linux-build/arch/powerpc/configs/maple_defconfig
===================================================================
--- linux-build.orig/arch/powerpc/configs/maple_defconfig	2012-04-18 22:12:59.264789702 +1000
+++ linux-build/arch/powerpc/configs/maple_defconfig	2012-04-18 22:13:13.029035714 +1000
@@ -1,5 +1,4 @@
 CONFIG_PPC64=y
-CONFIG_POWER4_ONLY=y
 CONFIG_SMP=y
 CONFIG_NR_CPUS=4
 CONFIG_EXPERIMENTAL=y
Index: linux-build/arch/powerpc/configs/pasemi_defconfig
===================================================================
--- linux-build.orig/arch/powerpc/configs/pasemi_defconfig	2012-04-18 22:12:59.280789988 +1000
+++ linux-build/arch/powerpc/configs/pasemi_defconfig	2012-04-18 22:13:13.029035714 +1000
@@ -1,5 +1,4 @@
 CONFIG_PPC64=y
-CONFIG_POWER4_ONLY=y
 CONFIG_ALTIVEC=y
 # CONFIG_VIRT_CPU_ACCOUNTING is not set
 CONFIG_SMP=y
Index: linux-build/arch/powerpc/kernel/exceptions-64s.S
===================================================================
--- linux-build.orig/arch/powerpc/kernel/exceptions-64s.S	2012-04-18 22:12:59.252789487 +1000
+++ linux-build/arch/powerpc/kernel/exceptions-64s.S	2012-04-18 22:13:13.029035714 +1000
@@ -94,12 +94,10 @@ machine_check_pSeries_1:
 data_access_pSeries:
 	HMT_MEDIUM
 	SET_SCRATCH0(r13)
-#ifndef CONFIG_POWER4_ONLY
 BEGIN_FTR_SECTION
 	b	data_access_check_stab
 data_access_not_stab:
 END_MMU_FTR_SECTION_IFCLR(MMU_FTR_SLB)
-#endif
 	EXCEPTION_PROLOG_PSERIES(PACA_EXGEN, data_access_common, EXC_STD,
 				 KVMTEST, 0x300)
 
@@ -301,7 +299,6 @@ machine_check_fwnmi:
 				 EXC_STD, KVMTEST, 0x200)
 	KVM_HANDLER_SKIP(PACA_EXMC, EXC_STD, 0x200)
 
-#ifndef CONFIG_POWER4_ONLY
 	/* moved from 0x300 */
 data_access_check_stab:
 	GET_PACA(r13)
@@ -328,7 +325,6 @@ do_stab_bolted_pSeries:
 	GET_SCRATCH0(r10)
 	std	r10,PACA_EXSLB+EX_R13(r13)
 	EXCEPTION_PROLOG_PSERIES_1(.do_stab_bolted, EXC_STD)
-#endif /* CONFIG_POWER4_ONLY */
 
 	KVM_HANDLER_SKIP(PACA_EXGEN, EXC_STD, 0x300)
 	KVM_HANDLER_SKIP(PACA_EXSLB, EXC_STD, 0x380)
Index: linux-build/arch/powerpc/platforms/Kconfig.cputype
===================================================================
--- linux-build.orig/arch/powerpc/platforms/Kconfig.cputype	2012-04-18 22:12:59.312790560 +1000
+++ linux-build/arch/powerpc/platforms/Kconfig.cputype	2012-04-18 22:13:13.029035714 +1000
@@ -116,15 +116,6 @@ config PPC_BOOK3E
 	def_bool y
 	depends on PPC_BOOK3E_64
 
-config POWER4_ONLY
-	bool "Optimize for POWER4"
-	depends on PPC64 && PPC_BOOK3S
-	default n
-	---help---
-	  Cause the compiler to optimize for POWER4/POWER5/PPC970 processors.
-	  The resulting binary will not work on POWER3 or RS64 processors
-	  when compiled with binutils 2.15 or later.
-
 config 6xx
 	def_bool y
 	depends on PPC32 && PPC_BOOK3S
Index: linux-build/arch/powerpc/include/asm/asm-compat.h
===================================================================
--- linux-build.orig/arch/powerpc/include/asm/asm-compat.h	2012-04-18 22:12:59.236789201 +1000
+++ linux-build/arch/powerpc/include/asm/asm-compat.h	2012-04-18 22:13:13.033035785 +1000
@@ -29,18 +29,9 @@
 #define PPC_LLARX(t, a, b, eh)	PPC_LDARX(t, a, b, eh)
 #define PPC_STLCX	stringify_in_c(stdcx.)
 #define PPC_CNTLZL	stringify_in_c(cntlzd)
+#define PPC_MTOCRF(FXM, RS) MTOCRF((FXM), (RS))
 #define PPC_LR_STKOFF	16
 #define PPC_MIN_STKFRM	112
-
-/* Move to CR, single-entry optimized version. Only available
- * on POWER4 and later.
- */
-#ifdef CONFIG_POWER4_ONLY
-#define PPC_MTOCRF	stringify_in_c(mtocrf)
-#else
-#define PPC_MTOCRF	stringify_in_c(mtcrf)
-#endif
-
 #else /* 32-bit */
 
 /* operations for longs and pointers */
Index: linux-build/arch/powerpc/lib/copyuser_64.S
===================================================================
--- linux-build.orig/arch/powerpc/lib/copyuser_64.S	2012-04-18 22:12:59.180788200 +1000
+++ linux-build/arch/powerpc/lib/copyuser_64.S	2012-04-18 22:13:13.033035785 +1000
@@ -30,7 +30,7 @@ _GLOBAL(__copy_tofrom_user_base)
 	dcbt	0,r4
 	beq	.Lcopy_page_4K
 	andi.	r6,r6,7
-	PPC_MTOCRF	0x01,r5
+	PPC_MTOCRF(0x01,r5)
 	blt	cr1,.Lshort_copy
 /* Below we want to nop out the bne if we're on a CPU that has the
  * CPU_FTR_UNALIGNED_LD_STD bit set and the CPU_FTR_CP_USE_DCBTZ bit
@@ -186,7 +186,7 @@ END_FTR_SECTION_IFCLR(CPU_FTR_UNALIGNED_
 	blr
 
 .Ldst_unaligned:
-	PPC_MTOCRF	0x01,r6		/* put #bytes to 8B bdry into cr7 */
+	PPC_MTOCRF(0x01,r6)		/* put #bytes to 8B bdry into cr7 */
 	subf	r5,r6,r5
 	li	r7,0
 	cmpldi	cr1,r5,16
@@ -201,7 +201,7 @@ END_FTR_SECTION_IFCLR(CPU_FTR_UNALIGNED_
 2:	bf	cr7*4+1,3f
 37:	lwzx	r0,r7,r4
 83:	stwx	r0,r7,r3
-3:	PPC_MTOCRF	0x01,r5
+3:	PPC_MTOCRF(0x01,r5)
 	add	r4,r6,r4
 	add	r3,r6,r3
 	b	.Ldst_aligned
Index: linux-build/arch/powerpc/lib/memcpy_64.S
===================================================================
--- linux-build.orig/arch/powerpc/lib/memcpy_64.S	2012-04-18 22:12:59.208788700 +1000
+++ linux-build/arch/powerpc/lib/memcpy_64.S	2012-04-18 22:13:13.033035785 +1000
@@ -12,7 +12,7 @@
 	.align	7
 _GLOBAL(memcpy)
 	std	r3,48(r1)	/* save destination pointer for return value */
-	PPC_MTOCRF	0x01,r5
+	PPC_MTOCRF(0x01,r5)
 	cmpldi	cr1,r5,16
 	neg	r6,r3		# LS 3 bits = # bytes to 8-byte dest bdry
 	andi.	r6,r6,7
@@ -154,7 +154,7 @@ END_FTR_SECTION_IFCLR(CPU_FTR_UNALIGNED_
 	blr
 
 .Ldst_unaligned:
-	PPC_MTOCRF	0x01,r6		# put #bytes to 8B bdry into cr7
+	PPC_MTOCRF(0x01,r6)		# put #bytes to 8B bdry into cr7
 	subf	r5,r6,r5
 	li	r7,0
 	cmpldi	cr1,r5,16
@@ -169,7 +169,7 @@ END_FTR_SECTION_IFCLR(CPU_FTR_UNALIGNED_
 2:	bf	cr7*4+1,3f
 	lwzx	r0,r7,r4
 	stwx	r0,r7,r3
-3:	PPC_MTOCRF	0x01,r5
+3:	PPC_MTOCRF(0x01,r5)
 	add	r4,r6,r4
 	add	r3,r6,r3
 	b	.Ldst_aligned
Index: linux-build/arch/powerpc/lib/mem_64.S
===================================================================
--- linux-build.orig/arch/powerpc/lib/mem_64.S	2012-04-18 22:12:59.192788415 +1000
+++ linux-build/arch/powerpc/lib/mem_64.S	2012-04-18 22:13:13.033035785 +1000
@@ -19,7 +19,7 @@ _GLOBAL(memset)
 	rlwimi	r4,r4,16,0,15
 	cmplw	cr1,r5,r0		/* do we get that far? */
 	rldimi	r4,r4,32,0
-	PPC_MTOCRF	1,r0
+	PPC_MTOCRF(1,r0)
 	mr	r6,r3
 	blt	cr1,8f
 	beq+	3f			/* if already 8-byte aligned */
@@ -49,7 +49,7 @@ _GLOBAL(memset)
 	bdnz	4b
 5:	srwi.	r0,r5,3
 	clrlwi	r5,r5,29
-	PPC_MTOCRF	1,r0
+	PPC_MTOCRF(1,r0)
 	beq	8f
 	bf	29,6f
 	std	r4,0(r6)
@@ -65,7 +65,7 @@ _GLOBAL(memset)
 	std	r4,0(r6)
 	addi	r6,r6,8
 8:	cmpwi	r5,0
-	PPC_MTOCRF	1,r5
+	PPC_MTOCRF(1,r5)
 	beqlr+
 	bf	29,9f
 	stw	r4,0(r6)
Index: linux-build/arch/powerpc/include/asm/ppc_asm.h
===================================================================
--- linux-build.orig/arch/powerpc/include/asm/ppc_asm.h	2012-04-18 22:12:59.220788915 +1000
+++ linux-build/arch/powerpc/include/asm/ppc_asm.h	2012-04-18 22:13:13.033035785 +1000
@@ -369,7 +369,15 @@ BEGIN_FTR_SECTION			\
 END_FTR_SECTION_IFCLR(CPU_FTR_601)
 #endif
 
-	
+#ifdef CONFIG_PPC64
+#define MTOCRF(FXM, RS)			\
+	BEGIN_FTR_SECTION_NESTED(848);	\
+	mtcrf	(FXM), (RS);		\
+	FTR_SECTION_ELSE_NESTED(848);	\
+	mtocrf (FXM), (RS);		\
+	ALT_FTR_SECTION_END_NESTED_IFCLR(CPU_FTR_NOEXECUTE, 848)
+#endif
+
 /*
  * This instruction is not implemented on the PPC 603 or 601; however, on
  * the 403GCX and 405GP tlbia IS defined and tlbie is not.
