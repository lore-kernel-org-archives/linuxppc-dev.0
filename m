Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, rusty@rustcorp.com.au,
 ulrich.weigand@de.ibm.com, amodra@gmail.com, mikey@neuling.org,
 mjw@linux.vnet.ibm.com
Subject: [PATCH 16/33] powerpc: Fix unsafe accesses to parameter area in ELFv2
Date: Tue, 25 Mar 2014 22:44:22 +1100
Message-Id: <1395747879-5948-17-git-send-email-anton@samba.org>
In-Reply-To: <1395747879-5948-1-git-send-email-anton@samba.org>
References: <1395747879-5948-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Ulrich Weigand <ulrich.weigand@de.ibm.com>

Some of the assembler files in lib/ make use of the fact that in the
ELFv1 ABI, the caller guarantees to provide stack space to save the
parameter registers r3 ... r10.  This guarantee is no longer present
in ELFv2 for functions that have no variable argument list and no
more than 8 arguments.

Change the affected routines to temporarily store registers in the
red zone and/or the top of their own stack frame (in the space
provided to save r31 .. r29, which is actually not used in these
routines).

In opal_query_takeover, simply always allocate a stack frame;
the routine is not performance critical.

Signed-off-by: Ulrich Weigand <ulrich.weigand@de.ibm.com>
Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/lib/copypage_power7.S             |  8 ++++----
 arch/powerpc/lib/copyuser_power7.S             | 24 ++++++++++++------------
 arch/powerpc/lib/memcpy_64.S                   |  8 ++++----
 arch/powerpc/lib/memcpy_power7.S               | 20 ++++++++++----------
 arch/powerpc/platforms/powernv/opal-takeover.S |  2 ++
 5 files changed, 32 insertions(+), 30 deletions(-)

diff --git a/arch/powerpc/lib/copypage_power7.S b/arch/powerpc/lib/copypage_power7.S
index affc6d3..d7dafb3 100644
--- a/arch/powerpc/lib/copypage_power7.S
+++ b/arch/powerpc/lib/copypage_power7.S
@@ -56,15 +56,15 @@ _GLOBAL(copypage_power7)
 
 #ifdef CONFIG_ALTIVEC
 	mflr	r0
-	std	r3,STK_PARAM(R3)(r1)
-	std	r4,STK_PARAM(R4)(r1)
+	std	r3,-STACKFRAMESIZE+STK_REG(R31)(r1)
+	std	r4,-STACKFRAMESIZE+STK_REG(R30)(r1)
 	std	r0,16(r1)
 	stdu	r1,-STACKFRAMESIZE(r1)
 	bl	enter_vmx_copy
 	cmpwi	r3,0
 	ld	r0,STACKFRAMESIZE+16(r1)
-	ld	r3,STACKFRAMESIZE+STK_PARAM(R3)(r1)
-	ld	r4,STACKFRAMESIZE+STK_PARAM(R4)(r1)
+	ld	r3,STK_REG(R31)(r1)
+	ld	r4,STK_REG(R30)(r1)
 	mtlr	r0
 
 	li	r0,(PAGE_SIZE/128)
diff --git a/arch/powerpc/lib/copyuser_power7.S b/arch/powerpc/lib/copyuser_power7.S
index db0fcbc..c46c876 100644
--- a/arch/powerpc/lib/copyuser_power7.S
+++ b/arch/powerpc/lib/copyuser_power7.S
@@ -85,9 +85,9 @@
 .Lexit:
 	addi	r1,r1,STACKFRAMESIZE
 .Ldo_err1:
-	ld	r3,STK_PARAM(R3)(r1)
-	ld	r4,STK_PARAM(R4)(r1)
-	ld	r5,STK_PARAM(R5)(r1)
+	ld	r3,-STACKFRAMESIZE+STK_REG(R31)(r1)
+	ld	r4,-STACKFRAMESIZE+STK_REG(R30)(r1)
+	ld	r5,-STACKFRAMESIZE+STK_REG(R29)(r1)
 	b	__copy_tofrom_user_base
 
 
@@ -96,18 +96,18 @@ _GLOBAL(__copy_tofrom_user_power7)
 	cmpldi	r5,16
 	cmpldi	cr1,r5,4096
 
-	std	r3,STK_PARAM(R3)(r1)
-	std	r4,STK_PARAM(R4)(r1)
-	std	r5,STK_PARAM(R5)(r1)
+	std	r3,-STACKFRAMESIZE+STK_REG(R31)(r1)
+	std	r4,-STACKFRAMESIZE+STK_REG(R30)(r1)
+	std	r5,-STACKFRAMESIZE+STK_REG(R29)(r1)
 
 	blt	.Lshort_copy
 	bgt	cr1,.Lvmx_copy
 #else
 	cmpldi	r5,16
 
-	std	r3,STK_PARAM(R3)(r1)
-	std	r4,STK_PARAM(R4)(r1)
-	std	r5,STK_PARAM(R5)(r1)
+	std	r3,-STACKFRAMESIZE+STK_REG(R31)(r1)
+	std	r4,-STACKFRAMESIZE+STK_REG(R30)(r1)
+	std	r5,-STACKFRAMESIZE+STK_REG(R29)(r1)
 
 	blt	.Lshort_copy
 #endif
@@ -298,9 +298,9 @@ err1;	stb	r0,0(r3)
 	bl	enter_vmx_usercopy
 	cmpwi	cr1,r3,0
 	ld	r0,STACKFRAMESIZE+16(r1)
-	ld	r3,STACKFRAMESIZE+STK_PARAM(R3)(r1)
-	ld	r4,STACKFRAMESIZE+STK_PARAM(R4)(r1)
-	ld	r5,STACKFRAMESIZE+STK_PARAM(R5)(r1)
+	ld	r3,STK_REG(R31)(r1)
+	ld	r4,STK_REG(R30)(r1)
+	ld	r5,STK_REG(R29)(r1)
 	mtlr	r0
 
 	/*
diff --git a/arch/powerpc/lib/memcpy_64.S b/arch/powerpc/lib/memcpy_64.S
index 01da956..9d3960c 100644
--- a/arch/powerpc/lib/memcpy_64.S
+++ b/arch/powerpc/lib/memcpy_64.S
@@ -12,7 +12,7 @@
 	.align	7
 _GLOBAL(memcpy)
 BEGIN_FTR_SECTION
-	std	r3,STK_PARAM(R3)(r1)	/* save destination pointer for return value */
+	std	r3,-STACKFRAMESIZE+STK_REG(R31)(r1)	/* save destination pointer for return value */
 FTR_SECTION_ELSE
 #ifndef SELFTEST
 	b	memcpy_power7
@@ -73,7 +73,7 @@ END_FTR_SECTION_IFCLR(CPU_FTR_UNALIGNED_LD_STD)
 2:	bf	cr7*4+3,3f
 	lbz	r9,8(r4)
 	stb	r9,0(r3)
-3:	ld	r3,STK_PARAM(R3)(r1)	/* return dest pointer */
+3:	ld	r3,-STACKFRAMESIZE+STK_REG(R31)(r1)	/* return dest pointer */
 	blr
 
 .Lsrc_unaligned:
@@ -156,7 +156,7 @@ END_FTR_SECTION_IFCLR(CPU_FTR_UNALIGNED_LD_STD)
 2:	bf	cr7*4+3,3f
 	rotldi	r9,r9,8
 	stb	r9,0(r3)
-3:	ld	r3,STK_PARAM(R3)(r1)	/* return dest pointer */
+3:	ld	r3,-STACKFRAMESIZE+STK_REG(R31)(r1)	/* return dest pointer */
 	blr
 
 .Ldst_unaligned:
@@ -201,5 +201,5 @@ END_FTR_SECTION_IFCLR(CPU_FTR_UNALIGNED_LD_STD)
 3:	bf	cr7*4+3,4f
 	lbz	r0,0(r4)
 	stb	r0,0(r3)
-4:	ld	r3,STK_PARAM(R3)(r1)	/* return dest pointer */
+4:	ld	r3,-STACKFRAMESIZE+STK_REG(R31)(r1)	/* return dest pointer */
 	blr
diff --git a/arch/powerpc/lib/memcpy_power7.S b/arch/powerpc/lib/memcpy_power7.S
index 87d8eec..2ff5c14 100644
--- a/arch/powerpc/lib/memcpy_power7.S
+++ b/arch/powerpc/lib/memcpy_power7.S
@@ -33,14 +33,14 @@ _GLOBAL(memcpy_power7)
 	cmpldi	r5,16
 	cmpldi	cr1,r5,4096
 
-	std	r3,STK_PARAM(R1)(r1)
+	std	r3,-STACKFRAMESIZE+STK_REG(R31)(r1)
 
 	blt	.Lshort_copy
 	bgt	cr1,.Lvmx_copy
 #else
 	cmpldi	r5,16
 
-	std	r3,STK_PARAM(R1)(r1)
+	std	r3,-STACKFRAMESIZE+STK_REG(R31)(r1)
 
 	blt	.Lshort_copy
 #endif
@@ -216,7 +216,7 @@ _GLOBAL(memcpy_power7)
 	lbz	r0,0(r4)
 	stb	r0,0(r3)
 
-15:	ld	r3,STK_PARAM(R3)(r1)
+15:	ld	r3,-STACKFRAMESIZE+STK_REG(R31)(r1)
 	blr
 
 .Lunwind_stack_nonvmx_copy:
@@ -226,16 +226,16 @@ _GLOBAL(memcpy_power7)
 #ifdef CONFIG_ALTIVEC
 .Lvmx_copy:
 	mflr	r0
-	std	r4,STK_PARAM(R4)(r1)
-	std	r5,STK_PARAM(R5)(r1)
+	std	r4,-STACKFRAMESIZE+STK_REG(R30)(r1)
+	std	r5,-STACKFRAMESIZE+STK_REG(R29)(r1)
 	std	r0,16(r1)
 	stdu	r1,-STACKFRAMESIZE(r1)
 	bl	enter_vmx_copy
 	cmpwi	cr1,r3,0
 	ld	r0,STACKFRAMESIZE+16(r1)
-	ld	r3,STACKFRAMESIZE+STK_PARAM(R3)(r1)
-	ld	r4,STACKFRAMESIZE+STK_PARAM(R4)(r1)
-	ld	r5,STACKFRAMESIZE+STK_PARAM(R5)(r1)
+	ld	r3,STK_REG(R31)(r1)
+	ld	r4,STK_REG(R30)(r1)
+	ld	r5,STK_REG(R29)(r1)
 	mtlr	r0
 
 	/*
@@ -447,7 +447,7 @@ _GLOBAL(memcpy_power7)
 	stb	r0,0(r3)
 
 15:	addi	r1,r1,STACKFRAMESIZE
-	ld	r3,STK_PARAM(R3)(r1)
+	ld	r3,-STACKFRAMESIZE+STK_REG(R31)(r1)
 	b	exit_vmx_copy		/* tail call optimise */
 
 .Lvmx_unaligned_copy:
@@ -651,6 +651,6 @@ _GLOBAL(memcpy_power7)
 	stb	r0,0(r3)
 
 15:	addi	r1,r1,STACKFRAMESIZE
-	ld	r3,STK_PARAM(R3)(r1)
+	ld	r3,-STACKFRAMESIZE+STK_REG(R31)(r1)
 	b	exit_vmx_copy		/* tail call optimise */
 #endif /* CONFiG_ALTIVEC */
diff --git a/arch/powerpc/platforms/powernv/opal-takeover.S b/arch/powerpc/platforms/powernv/opal-takeover.S
index 3cd2628..11a3169 100644
--- a/arch/powerpc/platforms/powernv/opal-takeover.S
+++ b/arch/powerpc/platforms/powernv/opal-takeover.S
@@ -21,11 +21,13 @@
 _GLOBAL(opal_query_takeover)
 	mfcr	r0
 	stw	r0,8(r1)
+	stdu	r1,-STACKFRAMESIZE(r1)
 	std	r3,STK_PARAM(R3)(r1)
 	std	r4,STK_PARAM(R4)(r1)
 	li	r3,H_HAL_TAKEOVER
 	li	r4,H_HAL_TAKEOVER_QUERY_MAGIC
 	HVSC
+	addi	r1,r1,STACKFRAMESIZE
 	ld	r10,STK_PARAM(R3)(r1)
 	std	r4,0(r10)
 	ld	r10,STK_PARAM(R4)(r1)
-- 
1.8.3.2
