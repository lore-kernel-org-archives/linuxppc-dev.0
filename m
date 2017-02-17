Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vPsJ90kY1zDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Feb 2017 23:08:57 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: anton@samba.org,
	amodra@gmail.com
Subject: [RFC PATCH] powerpc: Fix dubious r0 usage
Date: Fri, 17 Feb 2017 23:08:53 +1100
Message-Id: <1487333333-17221-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Bleeding edge binutils no longer accepts r0 in places where the CPU
interprets the value as a literal 0.

This fixes the cases caught by a vanilla 64-bit and 32-bit build. There
may be others that are hidden behind other CONFIG options.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/ppc_asm.h  |  2 +-
 arch/powerpc/kernel/l2cr_6xx.S      |  4 +--
 arch/powerpc/lib/copypage_power7.S  | 14 ++++----
 arch/powerpc/lib/copyuser_power7.S  | 66 ++++++++++++++++++-------------------
 arch/powerpc/lib/memcpy_power7.S    | 66 ++++++++++++++++++-------------------
 arch/powerpc/lib/string_64.S        |  2 +-
 arch/powerpc/purgatory/trampoline.S |  2 +-
 7 files changed, 78 insertions(+), 78 deletions(-)

diff --git a/arch/powerpc/include/asm/ppc_asm.h b/arch/powerpc/include/asm/ppc_asm.h
index 025833b8df9f..c98324addc08 100644
--- a/arch/powerpc/include/asm/ppc_asm.h
+++ b/arch/powerpc/include/asm/ppc_asm.h
@@ -439,7 +439,7 @@ END_FTR_SECTION_IFCLR(CPU_FTR_601)
 .machine push ;					\
 .machine "power4" ;				\
        lis     scratch,0x60000000@h;		\
-       dcbt    r0,scratch,0b01010;		\
+       dcbt    0,scratch,0b01010;		\
 .machine pop
 
 /*
diff --git a/arch/powerpc/kernel/l2cr_6xx.S b/arch/powerpc/kernel/l2cr_6xx.S
index 97ec8557f974..6408f09dbbd9 100644
--- a/arch/powerpc/kernel/l2cr_6xx.S
+++ b/arch/powerpc/kernel/l2cr_6xx.S
@@ -181,7 +181,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_SPEC7450)
 	mtctr	r4
 	li	r4,0
 1:
-	lwzx	r0,r0,r4
+	lwzx	r0,0,r4
 	addi	r4,r4,32		/* Go to start of next cache line */
 	bdnz	1b
 	isync
@@ -328,7 +328,7 @@ END_FTR_SECTION_IFCLR(CPU_FTR_L3CR)
 	mtctr	r4
 	li	r4,0
 1:
-	lwzx	r0,r0,r4
+	lwzx	r0,0,r4
 	dcbf	0,r4
 	addi	r4,r4,32		/* Go to start of next cache line */
 	bdnz	1b
diff --git a/arch/powerpc/lib/copypage_power7.S b/arch/powerpc/lib/copypage_power7.S
index a84d333ecb09..ca5fc8fa7efc 100644
--- a/arch/powerpc/lib/copypage_power7.S
+++ b/arch/powerpc/lib/copypage_power7.S
@@ -45,13 +45,13 @@ _GLOBAL(copypage_power7)
 .machine push
 .machine "power4"
 	/* setup read stream 0  */
-	dcbt	r0,r4,0b01000  	/* addr from */
-	dcbt	r0,r7,0b01010   /* length and depth from */
+	dcbt	0,r4,0b01000  	/* addr from */
+	dcbt	0,r7,0b01010   /* length and depth from */
 	/* setup write stream 1 */
-	dcbtst	r0,r9,0b01000   /* addr to */
-	dcbtst	r0,r10,0b01010  /* length and depth to */
+	dcbtst	0,r9,0b01000   /* addr to */
+	dcbtst	0,r10,0b01010  /* length and depth to */
 	eieio
-	dcbt	r0,r8,0b01010	/* all streams GO */
+	dcbt	0,r8,0b01010	/* all streams GO */
 .machine pop
 
 #ifdef CONFIG_ALTIVEC
@@ -83,7 +83,7 @@ _GLOBAL(copypage_power7)
 	li	r12,112
 
 	.align	5
-1:	lvx	v7,r0,r4
+1:	lvx	v7,0,r4
 	lvx	v6,r4,r6
 	lvx	v5,r4,r7
 	lvx	v4,r4,r8
@@ -92,7 +92,7 @@ _GLOBAL(copypage_power7)
 	lvx	v1,r4,r11
 	lvx	v0,r4,r12
 	addi	r4,r4,128
-	stvx	v7,r0,r3
+	stvx	v7,0,r3
 	stvx	v6,r3,r6
 	stvx	v5,r3,r7
 	stvx	v4,r3,r8
diff --git a/arch/powerpc/lib/copyuser_power7.S b/arch/powerpc/lib/copyuser_power7.S
index a24b4039352c..a95fef3bed10 100644
--- a/arch/powerpc/lib/copyuser_power7.S
+++ b/arch/powerpc/lib/copyuser_power7.S
@@ -315,13 +315,13 @@ err1;	stb	r0,0(r3)
 .machine push
 .machine "power4"
 	/* setup read stream 0 */
-	dcbt	r0,r6,0b01000   /* addr from */
-	dcbt	r0,r7,0b01010   /* length and depth from */
+	dcbt	0,r6,0b01000   /* addr from */
+	dcbt	0,r7,0b01010   /* length and depth from */
 	/* setup write stream 1 */
-	dcbtst	r0,r9,0b01000   /* addr to */
-	dcbtst	r0,r10,0b01010  /* length and depth to */
+	dcbtst	0,r9,0b01000   /* addr to */
+	dcbtst	0,r10,0b01010  /* length and depth to */
 	eieio
-	dcbt	r0,r8,0b01010	/* all streams GO */
+	dcbt	0,r8,0b01010	/* all streams GO */
 .machine pop
 
 	beq	cr1,.Lunwind_stack_nonvmx_copy
@@ -376,26 +376,26 @@ err3;	std	r0,0(r3)
 	li	r11,48
 
 	bf	cr7*4+3,5f
-err3;	lvx	v1,r0,r4
+err3;	lvx	v1,0,r4
 	addi	r4,r4,16
-err3;	stvx	v1,r0,r3
+err3;	stvx	v1,0,r3
 	addi	r3,r3,16
 
 5:	bf	cr7*4+2,6f
-err3;	lvx	v1,r0,r4
+err3;	lvx	v1,0,r4
 err3;	lvx	v0,r4,r9
 	addi	r4,r4,32
-err3;	stvx	v1,r0,r3
+err3;	stvx	v1,0,r3
 err3;	stvx	v0,r3,r9
 	addi	r3,r3,32
 
 6:	bf	cr7*4+1,7f
-err3;	lvx	v3,r0,r4
+err3;	lvx	v3,0,r4
 err3;	lvx	v2,r4,r9
 err3;	lvx	v1,r4,r10
 err3;	lvx	v0,r4,r11
 	addi	r4,r4,64
-err3;	stvx	v3,r0,r3
+err3;	stvx	v3,0,r3
 err3;	stvx	v2,r3,r9
 err3;	stvx	v1,r3,r10
 err3;	stvx	v0,r3,r11
@@ -421,7 +421,7 @@ err3;	stvx	v0,r3,r11
 	 */
 	.align	5
 8:
-err4;	lvx	v7,r0,r4
+err4;	lvx	v7,0,r4
 err4;	lvx	v6,r4,r9
 err4;	lvx	v5,r4,r10
 err4;	lvx	v4,r4,r11
@@ -430,7 +430,7 @@ err4;	lvx	v2,r4,r14
 err4;	lvx	v1,r4,r15
 err4;	lvx	v0,r4,r16
 	addi	r4,r4,128
-err4;	stvx	v7,r0,r3
+err4;	stvx	v7,0,r3
 err4;	stvx	v6,r3,r9
 err4;	stvx	v5,r3,r10
 err4;	stvx	v4,r3,r11
@@ -451,29 +451,29 @@ err4;	stvx	v0,r3,r16
 	mtocrf	0x01,r6
 
 	bf	cr7*4+1,9f
-err3;	lvx	v3,r0,r4
+err3;	lvx	v3,0,r4
 err3;	lvx	v2,r4,r9
 err3;	lvx	v1,r4,r10
 err3;	lvx	v0,r4,r11
 	addi	r4,r4,64
-err3;	stvx	v3,r0,r3
+err3;	stvx	v3,0,r3
 err3;	stvx	v2,r3,r9
 err3;	stvx	v1,r3,r10
 err3;	stvx	v0,r3,r11
 	addi	r3,r3,64
 
 9:	bf	cr7*4+2,10f
-err3;	lvx	v1,r0,r4
+err3;	lvx	v1,0,r4
 err3;	lvx	v0,r4,r9
 	addi	r4,r4,32
-err3;	stvx	v1,r0,r3
+err3;	stvx	v1,0,r3
 err3;	stvx	v0,r3,r9
 	addi	r3,r3,32
 
 10:	bf	cr7*4+3,11f
-err3;	lvx	v1,r0,r4
+err3;	lvx	v1,0,r4
 	addi	r4,r4,16
-err3;	stvx	v1,r0,r3
+err3;	stvx	v1,0,r3
 	addi	r3,r3,16
 
 	/* Up to 15B to go */
@@ -553,25 +553,25 @@ err3;	lvx	v0,0,r4
 	addi	r4,r4,16
 
 	bf	cr7*4+3,5f
-err3;	lvx	v1,r0,r4
+err3;	lvx	v1,0,r4
 	VPERM(v8,v0,v1,v16)
 	addi	r4,r4,16
-err3;	stvx	v8,r0,r3
+err3;	stvx	v8,0,r3
 	addi	r3,r3,16
 	vor	v0,v1,v1
 
 5:	bf	cr7*4+2,6f
-err3;	lvx	v1,r0,r4
+err3;	lvx	v1,0,r4
 	VPERM(v8,v0,v1,v16)
 err3;	lvx	v0,r4,r9
 	VPERM(v9,v1,v0,v16)
 	addi	r4,r4,32
-err3;	stvx	v8,r0,r3
+err3;	stvx	v8,0,r3
 err3;	stvx	v9,r3,r9
 	addi	r3,r3,32
 
 6:	bf	cr7*4+1,7f
-err3;	lvx	v3,r0,r4
+err3;	lvx	v3,0,r4
 	VPERM(v8,v0,v3,v16)
 err3;	lvx	v2,r4,r9
 	VPERM(v9,v3,v2,v16)
@@ -580,7 +580,7 @@ err3;	lvx	v1,r4,r10
 err3;	lvx	v0,r4,r11
 	VPERM(v11,v1,v0,v16)
 	addi	r4,r4,64
-err3;	stvx	v8,r0,r3
+err3;	stvx	v8,0,r3
 err3;	stvx	v9,r3,r9
 err3;	stvx	v10,r3,r10
 err3;	stvx	v11,r3,r11
@@ -606,7 +606,7 @@ err3;	stvx	v11,r3,r11
 	 */
 	.align	5
 8:
-err4;	lvx	v7,r0,r4
+err4;	lvx	v7,0,r4
 	VPERM(v8,v0,v7,v16)
 err4;	lvx	v6,r4,r9
 	VPERM(v9,v7,v6,v16)
@@ -623,7 +623,7 @@ err4;	lvx	v1,r4,r15
 err4;	lvx	v0,r4,r16
 	VPERM(v15,v1,v0,v16)
 	addi	r4,r4,128
-err4;	stvx	v8,r0,r3
+err4;	stvx	v8,0,r3
 err4;	stvx	v9,r3,r9
 err4;	stvx	v10,r3,r10
 err4;	stvx	v11,r3,r11
@@ -644,7 +644,7 @@ err4;	stvx	v15,r3,r16
 	mtocrf	0x01,r6
 
 	bf	cr7*4+1,9f
-err3;	lvx	v3,r0,r4
+err3;	lvx	v3,0,r4
 	VPERM(v8,v0,v3,v16)
 err3;	lvx	v2,r4,r9
 	VPERM(v9,v3,v2,v16)
@@ -653,27 +653,27 @@ err3;	lvx	v1,r4,r10
 err3;	lvx	v0,r4,r11
 	VPERM(v11,v1,v0,v16)
 	addi	r4,r4,64
-err3;	stvx	v8,r0,r3
+err3;	stvx	v8,0,r3
 err3;	stvx	v9,r3,r9
 err3;	stvx	v10,r3,r10
 err3;	stvx	v11,r3,r11
 	addi	r3,r3,64
 
 9:	bf	cr7*4+2,10f
-err3;	lvx	v1,r0,r4
+err3;	lvx	v1,0,r4
 	VPERM(v8,v0,v1,v16)
 err3;	lvx	v0,r4,r9
 	VPERM(v9,v1,v0,v16)
 	addi	r4,r4,32
-err3;	stvx	v8,r0,r3
+err3;	stvx	v8,0,r3
 err3;	stvx	v9,r3,r9
 	addi	r3,r3,32
 
 10:	bf	cr7*4+3,11f
-err3;	lvx	v1,r0,r4
+err3;	lvx	v1,0,r4
 	VPERM(v8,v0,v1,v16)
 	addi	r4,r4,16
-err3;	stvx	v8,r0,r3
+err3;	stvx	v8,0,r3
 	addi	r3,r3,16
 
 	/* Up to 15B to go */
diff --git a/arch/powerpc/lib/memcpy_power7.S b/arch/powerpc/lib/memcpy_power7.S
index 786234fd4e91..193909abd18b 100644
--- a/arch/powerpc/lib/memcpy_power7.S
+++ b/arch/powerpc/lib/memcpy_power7.S
@@ -261,12 +261,12 @@ _GLOBAL(memcpy_power7)
 
 .machine push
 .machine "power4"
-	dcbt	r0,r6,0b01000
-	dcbt	r0,r7,0b01010
-	dcbtst	r0,r9,0b01000
-	dcbtst	r0,r10,0b01010
+	dcbt	0,r6,0b01000
+	dcbt	0,r7,0b01010
+	dcbtst	0,r9,0b01000
+	dcbtst	0,r10,0b01010
 	eieio
-	dcbt	r0,r8,0b01010	/* GO */
+	dcbt	0,r8,0b01010	/* GO */
 .machine pop
 
 	beq	cr1,.Lunwind_stack_nonvmx_copy
@@ -321,26 +321,26 @@ _GLOBAL(memcpy_power7)
 	li	r11,48
 
 	bf	cr7*4+3,5f
-	lvx	v1,r0,r4
+	lvx	v1,0,r4
 	addi	r4,r4,16
-	stvx	v1,r0,r3
+	stvx	v1,0,r3
 	addi	r3,r3,16
 
 5:	bf	cr7*4+2,6f
-	lvx	v1,r0,r4
+	lvx	v1,0,r4
 	lvx	v0,r4,r9
 	addi	r4,r4,32
-	stvx	v1,r0,r3
+	stvx	v1,0,r3
 	stvx	v0,r3,r9
 	addi	r3,r3,32
 
 6:	bf	cr7*4+1,7f
-	lvx	v3,r0,r4
+	lvx	v3,0,r4
 	lvx	v2,r4,r9
 	lvx	v1,r4,r10
 	lvx	v0,r4,r11
 	addi	r4,r4,64
-	stvx	v3,r0,r3
+	stvx	v3,0,r3
 	stvx	v2,r3,r9
 	stvx	v1,r3,r10
 	stvx	v0,r3,r11
@@ -366,7 +366,7 @@ _GLOBAL(memcpy_power7)
 	 */
 	.align	5
 8:
-	lvx	v7,r0,r4
+	lvx	v7,0,r4
 	lvx	v6,r4,r9
 	lvx	v5,r4,r10
 	lvx	v4,r4,r11
@@ -375,7 +375,7 @@ _GLOBAL(memcpy_power7)
 	lvx	v1,r4,r15
 	lvx	v0,r4,r16
 	addi	r4,r4,128
-	stvx	v7,r0,r3
+	stvx	v7,0,r3
 	stvx	v6,r3,r9
 	stvx	v5,r3,r10
 	stvx	v4,r3,r11
@@ -396,29 +396,29 @@ _GLOBAL(memcpy_power7)
 	mtocrf	0x01,r6
 
 	bf	cr7*4+1,9f
-	lvx	v3,r0,r4
+	lvx	v3,0,r4
 	lvx	v2,r4,r9
 	lvx	v1,r4,r10
 	lvx	v0,r4,r11
 	addi	r4,r4,64
-	stvx	v3,r0,r3
+	stvx	v3,0,r3
 	stvx	v2,r3,r9
 	stvx	v1,r3,r10
 	stvx	v0,r3,r11
 	addi	r3,r3,64
 
 9:	bf	cr7*4+2,10f
-	lvx	v1,r0,r4
+	lvx	v1,0,r4
 	lvx	v0,r4,r9
 	addi	r4,r4,32
-	stvx	v1,r0,r3
+	stvx	v1,0,r3
 	stvx	v0,r3,r9
 	addi	r3,r3,32
 
 10:	bf	cr7*4+3,11f
-	lvx	v1,r0,r4
+	lvx	v1,0,r4
 	addi	r4,r4,16
-	stvx	v1,r0,r3
+	stvx	v1,0,r3
 	addi	r3,r3,16
 
 	/* Up to 15B to go */
@@ -499,25 +499,25 @@ _GLOBAL(memcpy_power7)
 	addi	r4,r4,16
 
 	bf	cr7*4+3,5f
-	lvx	v1,r0,r4
+	lvx	v1,0,r4
 	VPERM(v8,v0,v1,v16)
 	addi	r4,r4,16
-	stvx	v8,r0,r3
+	stvx	v8,0,r3
 	addi	r3,r3,16
 	vor	v0,v1,v1
 
 5:	bf	cr7*4+2,6f
-	lvx	v1,r0,r4
+	lvx	v1,0,r4
 	VPERM(v8,v0,v1,v16)
 	lvx	v0,r4,r9
 	VPERM(v9,v1,v0,v16)
 	addi	r4,r4,32
-	stvx	v8,r0,r3
+	stvx	v8,0,r3
 	stvx	v9,r3,r9
 	addi	r3,r3,32
 
 6:	bf	cr7*4+1,7f
-	lvx	v3,r0,r4
+	lvx	v3,0,r4
 	VPERM(v8,v0,v3,v16)
 	lvx	v2,r4,r9
 	VPERM(v9,v3,v2,v16)
@@ -526,7 +526,7 @@ _GLOBAL(memcpy_power7)
 	lvx	v0,r4,r11
 	VPERM(v11,v1,v0,v16)
 	addi	r4,r4,64
-	stvx	v8,r0,r3
+	stvx	v8,0,r3
 	stvx	v9,r3,r9
 	stvx	v10,r3,r10
 	stvx	v11,r3,r11
@@ -552,7 +552,7 @@ _GLOBAL(memcpy_power7)
 	 */
 	.align	5
 8:
-	lvx	v7,r0,r4
+	lvx	v7,0,r4
 	VPERM(v8,v0,v7,v16)
 	lvx	v6,r4,r9
 	VPERM(v9,v7,v6,v16)
@@ -569,7 +569,7 @@ _GLOBAL(memcpy_power7)
 	lvx	v0,r4,r16
 	VPERM(v15,v1,v0,v16)
 	addi	r4,r4,128
-	stvx	v8,r0,r3
+	stvx	v8,0,r3
 	stvx	v9,r3,r9
 	stvx	v10,r3,r10
 	stvx	v11,r3,r11
@@ -590,7 +590,7 @@ _GLOBAL(memcpy_power7)
 	mtocrf	0x01,r6
 
 	bf	cr7*4+1,9f
-	lvx	v3,r0,r4
+	lvx	v3,0,r4
 	VPERM(v8,v0,v3,v16)
 	lvx	v2,r4,r9
 	VPERM(v9,v3,v2,v16)
@@ -599,27 +599,27 @@ _GLOBAL(memcpy_power7)
 	lvx	v0,r4,r11
 	VPERM(v11,v1,v0,v16)
 	addi	r4,r4,64
-	stvx	v8,r0,r3
+	stvx	v8,0,r3
 	stvx	v9,r3,r9
 	stvx	v10,r3,r10
 	stvx	v11,r3,r11
 	addi	r3,r3,64
 
 9:	bf	cr7*4+2,10f
-	lvx	v1,r0,r4
+	lvx	v1,0,r4
 	VPERM(v8,v0,v1,v16)
 	lvx	v0,r4,r9
 	VPERM(v9,v1,v0,v16)
 	addi	r4,r4,32
-	stvx	v8,r0,r3
+	stvx	v8,0,r3
 	stvx	v9,r3,r9
 	addi	r3,r3,32
 
 10:	bf	cr7*4+3,11f
-	lvx	v1,r0,r4
+	lvx	v1,0,r4
 	VPERM(v8,v0,v1,v16)
 	addi	r4,r4,16
-	stvx	v8,r0,r3
+	stvx	v8,0,r3
 	addi	r3,r3,16
 
 	/* Up to 15B to go */
diff --git a/arch/powerpc/lib/string_64.S b/arch/powerpc/lib/string_64.S
index c100f4d5d5d0..7c1402e60063 100644
--- a/arch/powerpc/lib/string_64.S
+++ b/arch/powerpc/lib/string_64.S
@@ -184,7 +184,7 @@ err1;	std	r0,8(r3)
 	mtctr	r6
 	mr	r8,r3
 14:
-err1;	dcbz	r0,r3
+err1;	dcbz	0,r3
 	add	r3,r3,r9
 	bdnz	14b
 
diff --git a/arch/powerpc/purgatory/trampoline.S b/arch/powerpc/purgatory/trampoline.S
index f9760ccf4032..0017d2bf4036 100644
--- a/arch/powerpc/purgatory/trampoline.S
+++ b/arch/powerpc/purgatory/trampoline.S
@@ -67,7 +67,7 @@ master:
 	mr	%r16,%r3	/* save dt address in reg16 */
 	li	%r4,20
 	LWZX_BE	%r6,%r3,%r4	/* fetch __be32 version number at byte 20 */
-	cmpwi	%r0,%r6,2	/* v2 or later? */
+	cmpwi	0,%r6,2		/* v2 or later? */
 	blt	1f
 	li	%r4,28
 	STWX_BE	%r17,%r3,%r4	/* Store my cpu as __be32 at byte 28 */
-- 
2.7.4
