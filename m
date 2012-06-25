Return-Path: <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <michael@ellerman.id.au>
From: Michael Neuling <mikey@neuling.org>
Date: Tue, 26 Jun 2012 09:33:16 +1000
Subject: [PATCH 9/18] powerpc: change mtcrf to use real register names
In-Reply-To: <1340667187.357853.615199632713.qpush@ale>
Message-Id: <20120625233316.9A97ED43683@localhost.localdomain>
Cc: mikey@neuling.org, matt@ozlabs.org, linuxppc-dev@ozlabs.org,
 schwab@linux-m68k.org, Anton Blanchard <anton@samba.org>,
 Olof Johannsson <olof@lixom.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

mtocrf define is just a wrapper around the real instructions so we can
just use real register names here (ie. lower case).

Also remove braces in macro so this is possible.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---

 arch/powerpc/include/asm/asm-compat.h |    2 +-
 arch/powerpc/include/asm/ppc_asm.h    |    4 ++--
 arch/powerpc/lib/copyuser_64.S        |    6 +++---
 arch/powerpc/lib/mem_64.S             |    6 +++---
 arch/powerpc/lib/memcpy_64.S          |    6 +++---
 5 files changed, 12 insertions(+), 12 deletions(-)

Index: b/arch/powerpc/include/asm/asm-compat.h
===================================================================
--- a/arch/powerpc/include/asm/asm-compat.h
+++ b/arch/powerpc/include/asm/asm-compat.h
@@ -29,7 +29,7 @@
 #define PPC_LLARX(t, a, b, eh)	PPC_LDARX(t, a, b, eh)
 #define PPC_STLCX	stringify_in_c(stdcx.)
 #define PPC_CNTLZL	stringify_in_c(cntlzd)
-#define PPC_MTOCRF(FXM, RS) MTOCRF((FXM), (RS))
+#define PPC_MTOCRF(FXM, RS) MTOCRF((FXM), RS)
 #define PPC_LR_STKOFF	16
 #define PPC_MIN_STKFRM	112
 #else /* 32-bit */
Index: b/arch/powerpc/include/asm/ppc_asm.h
===================================================================
--- a/arch/powerpc/include/asm/ppc_asm.h
+++ b/arch/powerpc/include/asm/ppc_asm.h
@@ -384,9 +384,9 @@ END_FTR_SECTION_IFCLR(CPU_FTR_601)
 #ifdef CONFIG_PPC64
 #define MTOCRF(FXM, RS)			\
 	BEGIN_FTR_SECTION_NESTED(848);	\
-	mtcrf	(FXM), (RS);		\
+	mtcrf	(FXM), RS;		\
 	FTR_SECTION_ELSE_NESTED(848);	\
-	mtocrf (FXM), (RS);		\
+	mtocrf (FXM), RS;		\
 	ALT_FTR_SECTION_END_NESTED_IFCLR(CPU_FTR_NOEXECUTE, 848)
 #endif
 
Index: b/arch/powerpc/lib/copyuser_64.S
===================================================================
--- a/arch/powerpc/lib/copyuser_64.S
+++ b/arch/powerpc/lib/copyuser_64.S
@@ -30,7 +30,7 @@ _GLOBAL(__copy_tofrom_user_base)
 	dcbt	0,r4
 	beq	.Lcopy_page_4K
 	andi.	r6,r6,7
-	PPC_MTOCRF(0x01,R5)
+	PPC_MTOCRF(0x01,r5)
 	blt	cr1,.Lshort_copy
 /* Below we want to nop out the bne if we're on a CPU that has the
  * CPU_FTR_UNALIGNED_LD_STD bit set and the CPU_FTR_CP_USE_DCBTZ bit
@@ -186,7 +186,7 @@ END_FTR_SECTION_IFCLR(CPU_FTR_UNALIGNED_
 	blr
 
 .Ldst_unaligned:
-	PPC_MTOCRF(0x01,R6)		/* put #bytes to 8B bdry into cr7 */
+	PPC_MTOCRF(0x01,r6)		/* put #bytes to 8B bdry into cr7 */
 	subf	r5,r6,r5
 	li	r7,0
 	cmpldi	cr1,r5,16
@@ -201,7 +201,7 @@ END_FTR_SECTION_IFCLR(CPU_FTR_UNALIGNED_
 2:	bf	cr7*4+1,3f
 37:	lwzx	r0,r7,r4
 83:	stwx	r0,r7,r3
-3:	PPC_MTOCRF(0x01,R5)
+3:	PPC_MTOCRF(0x01,r5)
 	add	r4,r6,r4
 	add	r3,r6,r3
 	b	.Ldst_aligned
Index: b/arch/powerpc/lib/mem_64.S
===================================================================
--- a/arch/powerpc/lib/mem_64.S
+++ b/arch/powerpc/lib/mem_64.S
@@ -19,7 +19,7 @@ _GLOBAL(memset)
 	rlwimi	r4,r4,16,0,15
 	cmplw	cr1,r5,r0		/* do we get that far? */
 	rldimi	r4,r4,32,0
-	PPC_MTOCRF(1,R0)
+	PPC_MTOCRF(1,r0)
 	mr	r6,r3
 	blt	cr1,8f
 	beq+	3f			/* if already 8-byte aligned */
@@ -49,7 +49,7 @@ _GLOBAL(memset)
 	bdnz	4b
 5:	srwi.	r0,r5,3
 	clrlwi	r5,r5,29
-	PPC_MTOCRF(1,R0)
+	PPC_MTOCRF(1,r0)
 	beq	8f
 	bf	29,6f
 	std	r4,0(r6)
@@ -65,7 +65,7 @@ _GLOBAL(memset)
 	std	r4,0(r6)
 	addi	r6,r6,8
 8:	cmpwi	r5,0
-	PPC_MTOCRF(1,R5)
+	PPC_MTOCRF(1,r5)
 	beqlr+
 	bf	29,9f
 	stw	r4,0(r6)
Index: b/arch/powerpc/lib/memcpy_64.S
===================================================================
--- a/arch/powerpc/lib/memcpy_64.S
+++ b/arch/powerpc/lib/memcpy_64.S
@@ -16,7 +16,7 @@ BEGIN_FTR_SECTION
 FTR_SECTION_ELSE
 	b	memcpy_power7
 ALT_FTR_SECTION_END_IFCLR(CPU_FTR_VMX_COPY)
-	PPC_MTOCRF(0x01,R5)
+	PPC_MTOCRF(0x01,r5)
 	cmpldi	cr1,r5,16
 	neg	r6,r3		# LS 3 bits = # bytes to 8-byte dest bdry
 	andi.	r6,r6,7
@@ -158,7 +158,7 @@ END_FTR_SECTION_IFCLR(CPU_FTR_UNALIGNED_
 	blr
 
 .Ldst_unaligned:
-	PPC_MTOCRF(0x01,R6)		# put #bytes to 8B bdry into cr7
+	PPC_MTOCRF(0x01,r6)		# put #bytes to 8B bdry into cr7
 	subf	r5,r6,r5
 	li	r7,0
 	cmpldi	cr1,r5,16
@@ -173,7 +173,7 @@ END_FTR_SECTION_IFCLR(CPU_FTR_UNALIGNED_
 2:	bf	cr7*4+1,3f
 	lwzx	r0,r7,r4
 	stwx	r0,r7,r3
-3:	PPC_MTOCRF(0x01,R5)
+3:	PPC_MTOCRF(0x01,r5)
 	add	r4,r6,r4
 	add	r3,r6,r3
 	b	.Ldst_aligned
