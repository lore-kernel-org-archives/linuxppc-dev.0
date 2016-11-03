Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t8YK169RHzDvQZ
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Nov 2016 16:23:17 +1100 (AEDT)
Date: Thu, 3 Nov 2016 16:19:49 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/4] powerpc/64: Make exception table clearer in
 __copy_tofrom_user_base
Message-ID: <20161103051949.GC8368@fergus.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This aims to make the generation of exception table entries for the
loads and stores in __copy_tofrom_user_base clearer and easier to
verify.  Instead of having a series of local labels on the loads
and stores, with a series of corresponding labels later for the
exception handlers, we now use macros to generate exception table
entries at the point of each load and store that could potentially
trap.  We do this with the macros extable, lex (load exception),
and stex (store exception).  These macros are used right before
the load or store to which they apply.

Some complexity is introduced by the fact that we have some more work
to do after hitting an exception.  After an exception on a load, we
need to clear the rest of the destination buffer (if possible), and
then return the number of bytes not copied.  After an exception on a
store, we only need to return the number of bytes not copied.  In
either case, the fixup code uses r3 as the current pointer into the
destination buffer, that is, the address of the first byte of the
destination that has not been modified.  However, at various points
in the copy loops, r3 can be 4, 8, 16 or 24 bytes behind that point.

To express this offset in an understandable way, we define a symbol
r3_offset which is updated at various points so that it equal to the
difference between the address of the first unmodified byte of the
destination and the value at r3.  (In fact it only needs to be
accurate at the point of each lex or stex macro invocation.)

The rules for updating r3_offset are as follows:

* It starts out at 0
* An addi r3,r3,N instruction decreases r3_offset by N
* A store instruction (stb, sth, stw, std) to N(r3)
  increases r3_offset by the width of the store (1, 2, 4, 8)
* A store with update instruction (stbu, sthu, stwu, stdu) to N(r3)
  sets r3_offset to the width of the store.

There is some trickiness to the way that the lex and stex macros and
the associated exception handlers work.  I would have liked to use
the current value of r3_offset in the name of the symbol used as
the exception handler, as in "extable .Lld_exc_$(r3_offset)" and then
have symbols .Lld_exc_0, .Lld_exc_8, .Lld_exc_16 etc. corresponding
to the offsets that needed to be added to r3.  However, I couldn't
see a way to do that with gas.

Instead, the exception handler address is .Lld_exc - r3_offset or
.Lst_exc - r3_offset, that is, the distance ahead of .Lld_exc/.Lst_exc
that we start executing is equal to the amount that we need to add to
r3.  This works because r3_offset is always a small multiple of 4,
and our instructions are 4 bytes long.  This means that before
.Lld_exc and .Lst_exc, we have a sequence of instructions that
increments r3 by 4, 8, 16 or 24 depending on where we start.  The
sequence increments r3 by 4 per instruction (on average).

We also replace the exception table for the 4k copy loop by a
macro per load or store.  These loads and stores all use exactly
the same exception handler, which simply resets the argument registers
r3, r4 and r5 to there original values and re-does the whole copy
using the slower loop.

Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/lib/copyuser_64.S | 579 +++++++++++++++++------------------------
 1 file changed, 239 insertions(+), 340 deletions(-)

diff --git a/arch/powerpc/lib/copyuser_64.S b/arch/powerpc/lib/copyuser_64.S
index 60386b2..1c5247c 100644
--- a/arch/powerpc/lib/copyuser_64.S
+++ b/arch/powerpc/lib/copyuser_64.S
@@ -18,6 +18,36 @@
 #define sHd sld		/* Shift towards high-numbered address. */
 #endif
 
+/*
+ * These macros are used to generate exception table entries.
+ * The exception handlers below use the original arguments
+ * (stored on the stack) and the point where we're up to in
+ * the destination buffer, i.e. the address of the first
+ * unmodified byte.  Generally r3 points into the destination
+ * buffer, but the first unmodified byte is at a variable
+ * offset from r3.  In the code below, the symbol r3_offset
+ * is set to indicate the current offset at each point in
+ * the code.  This offset is then used as a negative offset
+ * from the exception handler code, and those instructions
+ * before the exception handlers are addi instructions that
+ * adjust r3 to point to the correct place.
+ */
+	.macro	extable	handler
+100:
+	.section __ex_table,"a"
+	.align 3
+	.llong 100b,\handler
+	.previous
+	.endm
+
+	.macro	lex		/* exception handler for load */
+	extable	.Lld_exc - r3_offset
+	.endm
+
+	.macro	stex		/* exception handler for store */
+	extable	.Lst_exc - r3_offset
+	.endm
+
 	.align	7
 _GLOBAL_TOC(__copy_tofrom_user)
 BEGIN_FTR_SECTION
@@ -26,7 +56,7 @@ FTR_SECTION_ELSE
 	b	__copy_tofrom_user_power7
 ALT_FTR_SECTION_END_IFCLR(CPU_FTR_VMX_COPY)
 _GLOBAL(__copy_tofrom_user_base)
-	/* first check for a whole page copy on a page boundary */
+	/* first check for a 4kB copy on a 4kB boundary */
 	cmpldi	cr1,r5,16
 	cmpdi	cr6,r5,4096
 	or	r0,r3,r4
@@ -55,6 +85,7 @@ ALT_FTR_SECTION_END(CPU_FTR_UNALIGNED_LD_STD | CPU_FTR_CP_USE_DCBTZ, \
 		    CPU_FTR_UNALIGNED_LD_STD)
 .Ldst_aligned:
 	addi	r3,r3,-16
+r3_offset = 16
 BEGIN_FTR_SECTION
 	andi.	r0,r4,7
 	bne	.Lsrc_unaligned
@@ -62,57 +93,69 @@ END_FTR_SECTION_IFCLR(CPU_FTR_UNALIGNED_LD_STD)
 	blt	cr1,.Ldo_tail		/* if < 16 bytes to copy */
 	srdi	r0,r5,5
 	cmpdi	cr1,r0,0
-20:	ld	r7,0(r4)
-220:	ld	r6,8(r4)
+lex;	ld	r7,0(r4)
+lex;	ld	r6,8(r4)
 	addi	r4,r4,16
 	mtctr	r0
 	andi.	r0,r5,0x10
 	beq	22f
 	addi	r3,r3,16
+r3_offset = 0
 	addi	r4,r4,-16
 	mr	r9,r7
 	mr	r8,r6
 	beq	cr1,72f
-21:	ld	r7,16(r4)
-221:	ld	r6,24(r4)
+21:
+lex;	ld	r7,16(r4)
+lex;	ld	r6,24(r4)
 	addi	r4,r4,32
-70:	std	r9,0(r3)
-270:	std	r8,8(r3)
-22:	ld	r9,0(r4)
-222:	ld	r8,8(r4)
-71:	std	r7,16(r3)
-271:	std	r6,24(r3)
+stex;	std	r9,0(r3)
+r3_offset = 8
+stex;	std	r8,8(r3)
+r3_offset = 16
+22:
+lex;	ld	r9,0(r4)
+lex;	ld	r8,8(r4)
+stex;	std	r7,16(r3)
+r3_offset = 24
+stex;	std	r6,24(r3)
 	addi	r3,r3,32
+r3_offset = 0
 	bdnz	21b
-72:	std	r9,0(r3)
-272:	std	r8,8(r3)
+72:
+stex;	std	r9,0(r3)
+r3_offset = 8
+stex;	std	r8,8(r3)
+r3_offset = 16
 	andi.	r5,r5,0xf
 	beq+	3f
 	addi	r4,r4,16
 .Ldo_tail:
 	addi	r3,r3,16
+r3_offset = 0
 	bf	cr7*4+0,246f
-244:	ld	r9,0(r4)
+lex;	ld	r9,0(r4)
 	addi	r4,r4,8
-245:	std	r9,0(r3)
+stex;	std	r9,0(r3)
 	addi	r3,r3,8
 246:	bf	cr7*4+1,1f
-23:	lwz	r9,0(r4)
+lex;	lwz	r9,0(r4)
 	addi	r4,r4,4
-73:	stw	r9,0(r3)
+stex;	stw	r9,0(r3)
 	addi	r3,r3,4
 1:	bf	cr7*4+2,2f
-44:	lhz	r9,0(r4)
+lex;	lhz	r9,0(r4)
 	addi	r4,r4,2
-74:	sth	r9,0(r3)
+stex;	sth	r9,0(r3)
 	addi	r3,r3,2
 2:	bf	cr7*4+3,3f
-45:	lbz	r9,0(r4)
-75:	stb	r9,0(r3)
+lex;	lbz	r9,0(r4)
+stex;	stb	r9,0(r3)
 3:	li	r3,0
 	blr
 
 .Lsrc_unaligned:
+r3_offset = 16
 	srdi	r6,r5,3
 	addi	r5,r5,-16
 	subf	r4,r0,r4
@@ -125,58 +168,69 @@ END_FTR_SECTION_IFCLR(CPU_FTR_UNALIGNED_LD_STD)
 	add	r5,r5,r0
 	bt	cr7*4+0,28f
 
-24:	ld	r9,0(r4)	/* 3+2n loads, 2+2n stores */
-25:	ld	r0,8(r4)
+lex;	ld	r9,0(r4)	/* 3+2n loads, 2+2n stores */
+lex;	ld	r0,8(r4)
 	sLd	r6,r9,r10
-26:	ldu	r9,16(r4)
+lex;	ldu	r9,16(r4)
 	sHd	r7,r0,r11
 	sLd	r8,r0,r10
 	or	r7,r7,r6
 	blt	cr6,79f
-27:	ld	r0,8(r4)
+lex;	ld	r0,8(r4)
 	b	2f
 
-28:	ld	r0,0(r4)	/* 4+2n loads, 3+2n stores */
-29:	ldu	r9,8(r4)
+28:
+lex;	ld	r0,0(r4)	/* 4+2n loads, 3+2n stores */
+lex;	ldu	r9,8(r4)
 	sLd	r8,r0,r10
 	addi	r3,r3,-8
+r3_offset = 24
 	blt	cr6,5f
-30:	ld	r0,8(r4)
+lex;	ld	r0,8(r4)
 	sHd	r12,r9,r11
 	sLd	r6,r9,r10
-31:	ldu	r9,16(r4)
+lex;	ldu	r9,16(r4)
 	or	r12,r8,r12
 	sHd	r7,r0,r11
 	sLd	r8,r0,r10
 	addi	r3,r3,16
+r3_offset = 8
 	beq	cr6,78f
 
 1:	or	r7,r7,r6
-32:	ld	r0,8(r4)
-76:	std	r12,8(r3)
+lex;	ld	r0,8(r4)
+stex;	std	r12,8(r3)
+r3_offset = 16
 2:	sHd	r12,r9,r11
 	sLd	r6,r9,r10
-33:	ldu	r9,16(r4)
+lex;	ldu	r9,16(r4)
 	or	r12,r8,r12
-77:	stdu	r7,16(r3)
+stex;	stdu	r7,16(r3)
+r3_offset = 8
 	sHd	r7,r0,r11
 	sLd	r8,r0,r10
 	bdnz	1b
 
-78:	std	r12,8(r3)
+78:
+stex;	std	r12,8(r3)
+r3_offset = 16
 	or	r7,r7,r6
-79:	std	r7,16(r3)
+79:
+stex;	std	r7,16(r3)
+r3_offset = 24
 5:	sHd	r12,r9,r11
 	or	r12,r8,r12
-80:	std	r12,24(r3)
+stex;	std	r12,24(r3)
+r3_offset = 32
 	bne	6f
 	li	r3,0
 	blr
 6:	cmpwi	cr1,r5,8
 	addi	r3,r3,32
+r3_offset = 0
 	sLd	r9,r9,r10
 	ble	cr1,7f
-34:	ld	r0,8(r4)
+lex;	ld	r0,8(r4)
 	sHd	r7,r0,r11
 	or	r9,r7,r9
 7:
@@ -184,7 +238,7 @@ END_FTR_SECTION_IFCLR(CPU_FTR_UNALIGNED_LD_STD)
 #ifdef __BIG_ENDIAN__
 	rotldi	r9,r9,32
 #endif
-94:	stw	r9,0(r3)
+stex;	stw	r9,0(r3)
 #ifdef __LITTLE_ENDIAN__
 	rotrdi	r9,r9,32
 #endif
@@ -193,7 +247,7 @@ END_FTR_SECTION_IFCLR(CPU_FTR_UNALIGNED_LD_STD)
 #ifdef __BIG_ENDIAN__
 	rotldi	r9,r9,16
 #endif
-95:	sth	r9,0(r3)
+stex;	sth	r9,0(r3)
 #ifdef __LITTLE_ENDIAN__
 	rotrdi	r9,r9,16
 #endif
@@ -202,7 +256,7 @@ END_FTR_SECTION_IFCLR(CPU_FTR_UNALIGNED_LD_STD)
 #ifdef __BIG_ENDIAN__
 	rotldi	r9,r9,8
 #endif
-96:	stb	r9,0(r3)
+stex;	stb	r9,0(r3)
 #ifdef __LITTLE_ENDIAN__
 	rotrdi	r9,r9,8
 #endif
@@ -210,47 +264,55 @@ END_FTR_SECTION_IFCLR(CPU_FTR_UNALIGNED_LD_STD)
 	blr
 
 .Ldst_unaligned:
+r3_offset = 0
 	PPC_MTOCRF(0x01,r6)		/* put #bytes to 8B bdry into cr7 */
 	subf	r5,r6,r5
 	li	r7,0
 	cmpldi	cr1,r5,16
 	bf	cr7*4+3,1f
-35:	lbz	r0,0(r4)
-81:	stb	r0,0(r3)
+	extable	.Lld_exc_r7
+	lbz	r0,0(r4)
+	extable	.Lst_exc_r7
+	stb	r0,0(r3)
 	addi	r7,r7,1
 1:	bf	cr7*4+2,2f
-36:	lhzx	r0,r7,r4
-82:	sthx	r0,r7,r3
+	extable	.Lld_exc_r7
+	lhzx	r0,r7,r4
+	extable	.Lst_exc_r7
+	sthx	r0,r7,r3
 	addi	r7,r7,2
 2:	bf	cr7*4+1,3f
-37:	lwzx	r0,r7,r4
-83:	stwx	r0,r7,r3
+	extable	.Lld_exc_r7
+	lwzx	r0,r7,r4
+	extable	.Lst_exc_r7
+	stwx	r0,r7,r3
 3:	PPC_MTOCRF(0x01,r5)
 	add	r4,r6,r4
 	add	r3,r6,r3
 	b	.Ldst_aligned
 
 .Lshort_copy:
+r3_offset = 0
 	bf	cr7*4+0,1f
-38:	lwz	r0,0(r4)
-39:	lwz	r9,4(r4)
+lex;	lwz	r0,0(r4)
+lex;	lwz	r9,4(r4)
 	addi	r4,r4,8
-84:	stw	r0,0(r3)
-85:	stw	r9,4(r3)
+stex;	stw	r0,0(r3)
+stex;	stw	r9,4(r3)
 	addi	r3,r3,8
 1:	bf	cr7*4+1,2f
-40:	lwz	r0,0(r4)
+lex;	lwz	r0,0(r4)
 	addi	r4,r4,4
-86:	stw	r0,0(r3)
+stex;	stw	r0,0(r3)
 	addi	r3,r3,4
 2:	bf	cr7*4+2,3f
-41:	lhz	r0,0(r4)
+lex;	lhz	r0,0(r4)
 	addi	r4,r4,2
-87:	sth	r0,0(r3)
+stex;	sth	r0,0(r3)
 	addi	r3,r3,2
 3:	bf	cr7*4+3,4f
-42:	lbz	r0,0(r4)
-88:	stb	r0,0(r3)
+lex;	lbz	r0,0(r4)
+stex;	stb	r0,0(r3)
 4:	li	r3,0
 	blr
 
@@ -258,48 +320,34 @@ END_FTR_SECTION_IFCLR(CPU_FTR_UNALIGNED_LD_STD)
  * exception handlers follow
  * we have to return the number of bytes not copied
  * for an exception on a load, we set the rest of the destination to 0
+ * Note that the number of bytes of instructions for adjusting r3 needs
+ * to equal the amount of the adjustment, due to the trick of using
+ * .Lld_exc - r3_offset as the handler address.
  */
 
-136:
-137:
+.Lld_exc_r7:
 	add	r3,r3,r7
-	b	1f
-130:
-131:
+	b	.Lld_exc
+
+	/* adjust by 24 */
 	addi	r3,r3,8
-120:
-320:
-122:
-322:
-124:
-125:
-126:
-127:
-128:
-129:
-133:
+	nop
+	/* adjust by 16 */
 	addi	r3,r3,8
-132:
+	nop
+	/* adjust by 8 */
 	addi	r3,r3,8
-121:
-321:
-344:
-134:
-135:
-138:
-139:
-140:
-141:
-142:
-123:
-144:
-145:
+	nop
 
 /*
- * here we have had a fault on a load and r3 points to the first
- * unmodified byte of the destination
+ * Here we have had a fault on a load and r3 points to the first
+ * unmodified byte of the destination.  We use the original arguments
+ * and r3 to work out how much wasn't copied.  Since we load some
+ * distance ahead of the stores, we continue copying byte-by-byte until
+ * we hit the load fault again in order to copy as much as possible.
  */
-1:	ld	r6,-24(r1)
+.Lld_exc:
+	ld	r6,-24(r1)
 	ld	r4,-16(r1)
 	ld	r5,-8(r1)
 	subf	r6,r6,r3
@@ -310,9 +358,11 @@ END_FTR_SECTION_IFCLR(CPU_FTR_UNALIGNED_LD_STD)
  * first see if we can copy any more bytes before hitting another exception
  */
 	mtctr	r5
+r3_offset = 0
+	extable	.Lclear_rest
 43:	lbz	r0,0(r4)
 	addi	r4,r4,1
-89:	stb	r0,0(r3)
+stex;	stb	r0,0(r3)
 	addi	r3,r3,1
 	bdnz	43b
 	li	r3,0		/* huh? all copied successfully this time? */
@@ -321,13 +371,15 @@ END_FTR_SECTION_IFCLR(CPU_FTR_UNALIGNED_LD_STD)
 /*
  * here we have trapped again, need to clear ctr bytes starting at r3
  */
-143:	mfctr	r5
+.Lclear_rest:
+	mfctr	r5
 	li	r0,0
 	mr	r4,r3
 	mr	r3,r5		/* return the number of bytes not copied */
 1:	andi.	r9,r4,7
 	beq	3f
-90:	stb	r0,0(r4)
+	extable	99f
+	stb	r0,0(r4)
 	addic.	r5,r5,-1
 	addi	r4,r4,1
 	bne	1b
@@ -337,133 +389,54 @@ END_FTR_SECTION_IFCLR(CPU_FTR_UNALIGNED_LD_STD)
 	andi.	r5,r5,7
 	blt	cr1,93f
 	mtctr	r9
+	extable	99f
 91:	std	r0,0(r4)
 	addi	r4,r4,8
 	bdnz	91b
 93:	beqlr
 	mtctr	r5	
+	extable	99f
 92:	stb	r0,0(r4)
 	addi	r4,r4,1
 	bdnz	92b
-	blr
+99:	blr
 
 /*
  * exception handlers for stores: we just need to work
  * out how many bytes weren't copied
+ * Note that the number of bytes of instructions for adjusting r3 needs
+ * to equal the amount of the adjustment, due to the trick of using
+ * .Lst_exc - r3_offset as the handler address.
  */
-182:
-183:
+.Lst_exc_r7:
 	add	r3,r3,r7
-	b	1f
-371:
-180:
+	b	.Lst_exc
+
+	/* adjust by 24 */
 	addi	r3,r3,8
-171:
-177:
-179:
+	nop
+	/* adjust by 16 */
 	addi	r3,r3,8
-370:
-372:
-176:
-178:
+	nop
+	/* adjust by 8 */
 	addi	r3,r3,4
-185:
+	/* adjust by 4 */
 	addi	r3,r3,4
-170:
-172:
-345:
-173:
-174:
-175:
-181:
-184:
-186:
-187:
-188:
-189:	
-194:
-195:
-196:
-1:
+.Lst_exc:
 	ld	r6,-24(r1)
 	ld	r5,-8(r1)
 	add	r6,r6,r5
-	subf	r3,r3,r6	/* #bytes not copied */
-190:
-191:
-192:
-	blr			/* #bytes not copied in r3 */
-
-	.section __ex_table,"a"
-	.align	3
-	.llong	20b,120b
-	.llong	220b,320b
-	.llong	21b,121b
-	.llong	221b,321b
-	.llong	70b,170b
-	.llong	270b,370b
-	.llong	22b,122b
-	.llong	222b,322b
-	.llong	71b,171b
-	.llong	271b,371b
-	.llong	72b,172b
-	.llong	272b,372b
-	.llong	244b,344b
-	.llong	245b,345b
-	.llong	23b,123b
-	.llong	73b,173b
-	.llong	44b,144b
-	.llong	74b,174b
-	.llong	45b,145b
-	.llong	75b,175b
-	.llong	24b,124b
-	.llong	25b,125b
-	.llong	26b,126b
-	.llong	27b,127b
-	.llong	28b,128b
-	.llong	29b,129b
-	.llong	30b,130b
-	.llong	31b,131b
-	.llong	32b,132b
-	.llong	76b,176b
-	.llong	33b,133b
-	.llong	77b,177b
-	.llong	78b,178b
-	.llong	79b,179b
-	.llong	80b,180b
-	.llong	34b,134b
-	.llong	94b,194b
-	.llong	95b,195b
-	.llong	96b,196b
-	.llong	35b,135b
-	.llong	81b,181b
-	.llong	36b,136b
-	.llong	82b,182b
-	.llong	37b,137b
-	.llong	83b,183b
-	.llong	38b,138b
-	.llong	39b,139b
-	.llong	84b,184b
-	.llong	85b,185b
-	.llong	40b,140b
-	.llong	86b,186b
-	.llong	41b,141b
-	.llong	87b,187b
-	.llong	42b,142b
-	.llong	88b,188b
-	.llong	43b,143b
-	.llong	89b,189b
-	.llong	90b,190b
-	.llong	91b,191b
-	.llong	92b,192b
-	
-	.text
+	subf	r3,r3,r6	/* #bytes not copied in r3 */
+	blr
 
 /*
  * Routine to copy a whole page of data, optimized for POWER4.
  * On POWER4 it is more than 50% faster than the simple loop
  * above (following the .Ldst_aligned label).
  */
+	.macro	exc
+	extable	.Labort
+	.endm
 .Lcopy_page_4K:
 	std	r31,-32(1)
 	std	r30,-40(1)
@@ -482,86 +455,86 @@ END_FTR_SECTION_IFCLR(CPU_FTR_UNALIGNED_LD_STD)
 	li	r0,5
 0:	addi	r5,r5,-24
 	mtctr	r0
-20:	ld	r22,640(4)
-21:	ld	r21,512(4)
-22:	ld	r20,384(4)
-23:	ld	r11,256(4)
-24:	ld	r9,128(4)
-25:	ld	r7,0(4)
-26:	ld	r25,648(4)
-27:	ld	r24,520(4)
-28:	ld	r23,392(4)
-29:	ld	r10,264(4)
-30:	ld	r8,136(4)
-31:	ldu	r6,8(4)
+exc;	ld	r22,640(4)
+exc;	ld	r21,512(4)
+exc;	ld	r20,384(4)
+exc;	ld	r11,256(4)
+exc;	ld	r9,128(4)
+exc;	ld	r7,0(4)
+exc;	ld	r25,648(4)
+exc;	ld	r24,520(4)
+exc;	ld	r23,392(4)
+exc;	ld	r10,264(4)
+exc;	ld	r8,136(4)
+exc;	ldu	r6,8(4)
 	cmpwi	r5,24
 1:
-32:	std	r22,648(3)
-33:	std	r21,520(3)
-34:	std	r20,392(3)
-35:	std	r11,264(3)
-36:	std	r9,136(3)
-37:	std	r7,8(3)
-38:	ld	r28,648(4)
-39:	ld	r27,520(4)
-40:	ld	r26,392(4)
-41:	ld	r31,264(4)
-42:	ld	r30,136(4)
-43:	ld	r29,8(4)
-44:	std	r25,656(3)
-45:	std	r24,528(3)
-46:	std	r23,400(3)
-47:	std	r10,272(3)
-48:	std	r8,144(3)
-49:	std	r6,16(3)
-50:	ld	r22,656(4)
-51:	ld	r21,528(4)
-52:	ld	r20,400(4)
-53:	ld	r11,272(4)
-54:	ld	r9,144(4)
-55:	ld	r7,16(4)
-56:	std	r28,664(3)
-57:	std	r27,536(3)
-58:	std	r26,408(3)
-59:	std	r31,280(3)
-60:	std	r30,152(3)
-61:	stdu	r29,24(3)
-62:	ld	r25,664(4)
-63:	ld	r24,536(4)
-64:	ld	r23,408(4)
-65:	ld	r10,280(4)
-66:	ld	r8,152(4)
-67:	ldu	r6,24(4)
+exc;	std	r22,648(3)
+exc;	std	r21,520(3)
+exc;	std	r20,392(3)
+exc;	std	r11,264(3)
+exc;	std	r9,136(3)
+exc;	std	r7,8(3)
+exc;	ld	r28,648(4)
+exc;	ld	r27,520(4)
+exc;	ld	r26,392(4)
+exc;	ld	r31,264(4)
+exc;	ld	r30,136(4)
+exc;	ld	r29,8(4)
+exc;	std	r25,656(3)
+exc;	std	r24,528(3)
+exc;	std	r23,400(3)
+exc;	std	r10,272(3)
+exc;	std	r8,144(3)
+exc;	std	r6,16(3)
+exc;	ld	r22,656(4)
+exc;	ld	r21,528(4)
+exc;	ld	r20,400(4)
+exc;	ld	r11,272(4)
+exc;	ld	r9,144(4)
+exc;	ld	r7,16(4)
+exc;	std	r28,664(3)
+exc;	std	r27,536(3)
+exc;	std	r26,408(3)
+exc;	std	r31,280(3)
+exc;	std	r30,152(3)
+exc;	stdu	r29,24(3)
+exc;	ld	r25,664(4)
+exc;	ld	r24,536(4)
+exc;	ld	r23,408(4)
+exc;	ld	r10,280(4)
+exc;	ld	r8,152(4)
+exc;	ldu	r6,24(4)
 	bdnz	1b
-68:	std	r22,648(3)
-69:	std	r21,520(3)
-70:	std	r20,392(3)
-71:	std	r11,264(3)
-72:	std	r9,136(3)
-73:	std	r7,8(3)
-74:	addi	r4,r4,640
-75:	addi	r3,r3,648
+exc;	std	r22,648(3)
+exc;	std	r21,520(3)
+exc;	std	r20,392(3)
+exc;	std	r11,264(3)
+exc;	std	r9,136(3)
+exc;	std	r7,8(3)
+	addi	r4,r4,640
+	addi	r3,r3,648
 	bge	0b
 	mtctr	r5
-76:	ld	r7,0(4)
-77:	ld	r8,8(4)
-78:	ldu	r9,16(4)
+exc;	ld	r7,0(4)
+exc;	ld	r8,8(4)
+exc;	ldu	r9,16(4)
 3:
-79:	ld	r10,8(4)
-80:	std	r7,8(3)
-81:	ld	r7,16(4)
-82:	std	r8,16(3)
-83:	ld	r8,24(4)
-84:	std	r9,24(3)
-85:	ldu	r9,32(4)
-86:	stdu	r10,32(3)
+exc;	ld	r10,8(4)
+exc;	std	r7,8(3)
+exc;	ld	r7,16(4)
+exc;	std	r8,16(3)
+exc;	ld	r8,24(4)
+exc;	std	r9,24(3)
+exc;	ldu	r9,32(4)
+exc;	stdu	r10,32(3)
 	bdnz	3b
 4:
-87:	ld	r10,8(4)
-88:	std	r7,8(3)
-89:	std	r8,16(3)
-90:	std	r9,24(3)
-91:	std	r10,32(3)
+exc;	ld	r10,8(4)
+exc;	std	r7,8(3)
+exc;	std	r8,16(3)
+exc;	std	r9,24(3)
+exc;	std	r10,32(3)
 9:	ld	r20,-120(1)
 	ld	r21,-112(1)
 	ld	r22,-104(1)
@@ -581,7 +554,8 @@ END_FTR_SECTION_IFCLR(CPU_FTR_UNALIGNED_LD_STD)
  * on an exception, reset to the beginning and jump back into the
  * standard __copy_tofrom_user
  */
-100:	ld	r20,-120(1)
+.Labort:
+	ld	r20,-120(1)
 	ld	r21,-112(1)
 	ld	r22,-104(1)
 	ld	r23,-96(1)
@@ -597,79 +571,4 @@ END_FTR_SECTION_IFCLR(CPU_FTR_UNALIGNED_LD_STD)
 	ld	r4,-16(r1)
 	li	r5,4096
 	b	.Ldst_aligned
-
-	.section __ex_table,"a"
-	.align	3
-	.llong	20b,100b
-	.llong	21b,100b
-	.llong	22b,100b
-	.llong	23b,100b
-	.llong	24b,100b
-	.llong	25b,100b
-	.llong	26b,100b
-	.llong	27b,100b
-	.llong	28b,100b
-	.llong	29b,100b
-	.llong	30b,100b
-	.llong	31b,100b
-	.llong	32b,100b
-	.llong	33b,100b
-	.llong	34b,100b
-	.llong	35b,100b
-	.llong	36b,100b
-	.llong	37b,100b
-	.llong	38b,100b
-	.llong	39b,100b
-	.llong	40b,100b
-	.llong	41b,100b
-	.llong	42b,100b
-	.llong	43b,100b
-	.llong	44b,100b
-	.llong	45b,100b
-	.llong	46b,100b
-	.llong	47b,100b
-	.llong	48b,100b
-	.llong	49b,100b
-	.llong	50b,100b
-	.llong	51b,100b
-	.llong	52b,100b
-	.llong	53b,100b
-	.llong	54b,100b
-	.llong	55b,100b
-	.llong	56b,100b
-	.llong	57b,100b
-	.llong	58b,100b
-	.llong	59b,100b
-	.llong	60b,100b
-	.llong	61b,100b
-	.llong	62b,100b
-	.llong	63b,100b
-	.llong	64b,100b
-	.llong	65b,100b
-	.llong	66b,100b
-	.llong	67b,100b
-	.llong	68b,100b
-	.llong	69b,100b
-	.llong	70b,100b
-	.llong	71b,100b
-	.llong	72b,100b
-	.llong	73b,100b
-	.llong	74b,100b
-	.llong	75b,100b
-	.llong	76b,100b
-	.llong	77b,100b
-	.llong	78b,100b
-	.llong	79b,100b
-	.llong	80b,100b
-	.llong	81b,100b
-	.llong	82b,100b
-	.llong	83b,100b
-	.llong	84b,100b
-	.llong	85b,100b
-	.llong	86b,100b
-	.llong	87b,100b
-	.llong	88b,100b
-	.llong	89b,100b
-	.llong	90b,100b
-	.llong	91b,100b
 EXPORT_SYMBOL(__copy_tofrom_user)
-- 
2.7.4
