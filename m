Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 851B9DDF17
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2007 12:55:13 +1100 (EST)
Date: Wed, 21 Mar 2007 21:09:26 -0500
To: paulus@samba.org
Subject: [PATCH] Use mtocrf in asm when CONFIG_POWER4_ONLY=y
Message-ID: <20070322020925.GA13114@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org, anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

mtocrf is a faster single-entry mtcrf available in PPC 2.00 and later
processors. It can make quite a difference in performance on some
implementations, so use it for CONFIG_POWER4_ONLY=y builds.


Signed-off-by: Olof Johansson <olof@lixom.net>

Index: linux-2.6/arch/powerpc/lib/mem_64.S
===================================================================
--- linux-2.6.orig/arch/powerpc/lib/mem_64.S
+++ linux-2.6/arch/powerpc/lib/mem_64.S
@@ -19,7 +19,7 @@ _GLOBAL(memset)
 	rlwimi	r4,r4,16,0,15
 	cmplw	cr1,r5,r0		/* do we get that far? */
 	rldimi	r4,r4,32,0
-	mtcrf	1,r0
+	PPC_MTOCRF	1,r0
 	mr	r6,r3
 	blt	cr1,8f
 	beq+	3f			/* if already 8-byte aligned */
@@ -49,7 +49,7 @@ _GLOBAL(memset)
 	bdnz	4b
 5:	srwi.	r0,r5,3
 	clrlwi	r5,r5,29
-	mtcrf	1,r0
+	PPC_MTOCRF	1,r0
 	beq	8f
 	bf	29,6f
 	std	r4,0(r6)
@@ -65,7 +65,7 @@ _GLOBAL(memset)
 	std	r4,0(r6)
 	addi	r6,r6,8
 8:	cmpwi	r5,0
-	mtcrf	1,r5
+	PPC_MTOCRF	1,r5
 	beqlr+
 	bf	29,9f
 	stw	r4,0(r6)
Index: linux-2.6/arch/powerpc/lib/copyuser_64.S
===================================================================
--- linux-2.6.orig/arch/powerpc/lib/copyuser_64.S
+++ linux-2.6/arch/powerpc/lib/copyuser_64.S
@@ -24,7 +24,7 @@ _GLOBAL(__copy_tofrom_user)
 	dcbt	0,r4
 	beq	.Lcopy_page_4K
 	andi.	r6,r6,7
-	mtcrf	0x01,r5
+	PPC_MTOCRF	0x01,r5
 	blt	cr1,.Lshort_copy
 	bne	.Ldst_unaligned
 .Ldst_aligned:
@@ -135,7 +135,7 @@ _GLOBAL(__copy_tofrom_user)
 	b	.Ldo_tail
 
 .Ldst_unaligned:
-	mtcrf	0x01,r6		/* put #bytes to 8B bdry into cr7 */
+	PPC_MTOCRF	0x01,r6		/* put #bytes to 8B bdry into cr7 */
 	subf	r5,r6,r5
 	li	r7,0
 	cmpldi	r1,r5,16
@@ -150,7 +150,7 @@ _GLOBAL(__copy_tofrom_user)
 2:	bf	cr7*4+1,3f
 37:	lwzx	r0,r7,r4
 83:	stwx	r0,r7,r3
-3:	mtcrf	0x01,r5
+3:	PPC_MTOCRF	0x01,r5
 	add	r4,r6,r4
 	add	r3,r6,r3
 	b	.Ldst_aligned
Index: linux-2.6/arch/powerpc/lib/memcpy_64.S
===================================================================
--- linux-2.6.orig/arch/powerpc/lib/memcpy_64.S
+++ linux-2.6/arch/powerpc/lib/memcpy_64.S
@@ -12,7 +12,7 @@
 	.align	7
 _GLOBAL(memcpy)
 	std	r3,48(r1)	/* save destination pointer for return value */
-	mtcrf	0x01,r5
+	PPC_MTOCRF	0x01,r5
 	cmpldi	cr1,r5,16
 	neg	r6,r3		# LS 3 bits = # bytes to 8-byte dest bdry
 	andi.	r6,r6,7
@@ -128,7 +128,7 @@ _GLOBAL(memcpy)
 	b	.Ldo_tail
 
 .Ldst_unaligned:
-	mtcrf	0x01,r6		# put #bytes to 8B bdry into cr7
+	PPC_MTOCRF	0x01,r6		# put #bytes to 8B bdry into cr7
 	subf	r5,r6,r5
 	li	r7,0
 	cmpldi	r1,r5,16
@@ -143,7 +143,7 @@ _GLOBAL(memcpy)
 2:	bf	cr7*4+1,3f
 	lwzx	r0,r7,r4
 	stwx	r0,r7,r3
-3:	mtcrf	0x01,r5
+3:	PPC_MTOCRF	0x01,r5
 	add	r4,r6,r4
 	add	r3,r6,r3
 	b	.Ldst_aligned
Index: linux-2.6/include/asm-powerpc/asm-compat.h
===================================================================
--- linux-2.6.orig/include/asm-powerpc/asm-compat.h
+++ linux-2.6/include/asm-powerpc/asm-compat.h
@@ -78,6 +78,15 @@
 #define PPC_STLCX	stringify_in_c(stdcx.)
 #define PPC_CNTLZL	stringify_in_c(cntlzd)
 
+/* Move to CR, single-entry optimized version. Only available
+ * on POWER4 and later.
+ */
+#ifdef CONFIG_POWER4_ONLY
+#define PPC_MTOCRF      stringify_in_c(mtocrf)
+#else
+#define PPC_MTOCRF      stringify_in_c(mtcrf)
+#endif
+
 #else /* 32-bit */
 
 /* operations for longs and pointers */
@@ -89,6 +100,7 @@
 #define PPC_LLARX	stringify_in_c(lwarx)
 #define PPC_STLCX	stringify_in_c(stwcx.)
 #define PPC_CNTLZL	stringify_in_c(cntlzw)
+#define PPC_MTOCRF      stringify_in_c(mtcrf)
 
 #endif
 
