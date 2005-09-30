Return-Path: <sfr@canb.auug.org.au>
Date: Fri, 30 Sep 2005 23:52:34 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Message-Id: <20050930235234.2c07aeec.sfr@canb.auug.org.au>
In-Reply-To: <20050930233602.138b6e27.sfr@canb.auug.org.au>
References: <20050930233602.138b6e27.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc64-dev <linuxppc64-dev@ozlabs.org>, ppc-dev <linuxppc-dev@ozlabs.org>
Subject: [PATCH 3/9] powerpc: remove old vector.S files
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Update old kernel/Makefiles to cope

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

---

 arch/ppc/kernel/Makefile   |    1 
 arch/ppc/kernel/vector.S   |  217 --------------------------------------------
 arch/ppc64/kernel/Makefile |    1 
 arch/ppc64/kernel/vector.S |  172 -----------------------------------
 4 files changed, 2 insertions(+), 389 deletions(-)
 delete mode 100644 arch/ppc/kernel/vector.S
 delete mode 100644 arch/ppc64/kernel/vector.S

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

dcff1b170b43d9b8cb83e275cb3451dfd261c23e
diff --git a/arch/ppc/kernel/Makefile b/arch/ppc/kernel/Makefile
--- a/arch/ppc/kernel/Makefile
+++ b/arch/ppc/kernel/Makefile
@@ -38,6 +38,7 @@ endif
 
 # These are here while we do the architecture merge
 vecemu-y			+= ../../powerpc/kernel/vecemu.o
+vector-y			+= ../../powerpc/kernel/vector.o
 
 else
 obj-y				:= entry.o irq.o idle.o time.o misc.o \
diff --git a/arch/ppc/kernel/vector.S b/arch/ppc/kernel/vector.S
deleted file mode 100644
--- a/arch/ppc/kernel/vector.S
+++ /dev/null
@@ -1,217 +0,0 @@
-#include <asm/ppc_asm.h>
-#include <asm/processor.h>
-
-/*
- * The routines below are in assembler so we can closely control the
- * usage of floating-point registers.  These routines must be called
- * with preempt disabled.
- */
-	.data
-fpzero:
-	.long	0
-fpone:
-	.long	0x3f800000	/* 1.0 in single-precision FP */
-fphalf:
-	.long	0x3f000000	/* 0.5 in single-precision FP */
-
-	.text
-/*
- * Internal routine to enable floating point and set FPSCR to 0.
- * Don't call it from C; it doesn't use the normal calling convention.
- */
-fpenable:
-	mfmsr	r10
-	ori	r11,r10,MSR_FP
-	mtmsr	r11
-	isync
-	stfd	fr0,24(r1)
-	stfd	fr1,16(r1)
-	stfd	fr31,8(r1)
-	lis	r11,fpzero@ha
-	mffs	fr31
-	lfs	fr1,fpzero@l(r11)
-	mtfsf	0xff,fr1
-	blr
-
-fpdisable:
-	mtfsf	0xff,fr31
-	lfd	fr31,8(r1)
-	lfd	fr1,16(r1)
-	lfd	fr0,24(r1)
-	mtmsr	r10
-	isync
-	blr
-
-/*
- * Vector add, floating point.
- */
-	.globl	vaddfp
-vaddfp:
-	stwu	r1,-32(r1)
-	mflr	r0
-	stw	r0,36(r1)
-	bl	fpenable
-	li	r0,4
-	mtctr	r0
-	li	r6,0
-1:	lfsx	fr0,r4,r6
-	lfsx	fr1,r5,r6
-	fadds	fr0,fr0,fr1
-	stfsx	fr0,r3,r6
-	addi	r6,r6,4
-	bdnz	1b
-	bl	fpdisable
-	lwz	r0,36(r1)
-	mtlr	r0
-	addi	r1,r1,32
-	blr
-
-/*
- * Vector subtract, floating point.
- */
-	.globl	vsubfp
-vsubfp:
-	stwu	r1,-32(r1)
-	mflr	r0
-	stw	r0,36(r1)
-	bl	fpenable
-	li	r0,4
-	mtctr	r0
-	li	r6,0
-1:	lfsx	fr0,r4,r6
-	lfsx	fr1,r5,r6
-	fsubs	fr0,fr0,fr1
-	stfsx	fr0,r3,r6
-	addi	r6,r6,4
-	bdnz	1b
-	bl	fpdisable
-	lwz	r0,36(r1)
-	mtlr	r0
-	addi	r1,r1,32
-	blr
-
-/*
- * Vector multiply and add, floating point.
- */
-	.globl	vmaddfp
-vmaddfp:
-	stwu	r1,-48(r1)
-	mflr	r0
-	stw	r0,52(r1)
-	bl	fpenable
-	stfd	fr2,32(r1)
-	li	r0,4
-	mtctr	r0
-	li	r7,0
-1:	lfsx	fr0,r4,r7
-	lfsx	fr1,r5,r7
-	lfsx	fr2,r6,r7
-	fmadds	fr0,fr0,fr2,fr1
-	stfsx	fr0,r3,r7
-	addi	r7,r7,4
-	bdnz	1b
-	lfd	fr2,32(r1)
-	bl	fpdisable
-	lwz	r0,52(r1)
-	mtlr	r0
-	addi	r1,r1,48
-	blr
-
-/*
- * Vector negative multiply and subtract, floating point.
- */
-	.globl	vnmsubfp
-vnmsubfp:
-	stwu	r1,-48(r1)
-	mflr	r0
-	stw	r0,52(r1)
-	bl	fpenable
-	stfd	fr2,32(r1)
-	li	r0,4
-	mtctr	r0
-	li	r7,0
-1:	lfsx	fr0,r4,r7
-	lfsx	fr1,r5,r7
-	lfsx	fr2,r6,r7
-	fnmsubs	fr0,fr0,fr2,fr1
-	stfsx	fr0,r3,r7
-	addi	r7,r7,4
-	bdnz	1b
-	lfd	fr2,32(r1)
-	bl	fpdisable
-	lwz	r0,52(r1)
-	mtlr	r0
-	addi	r1,r1,48
-	blr
-
-/*
- * Vector reciprocal estimate.  We just compute 1.0/x.
- * r3 -> destination, r4 -> source.
- */
-	.globl	vrefp
-vrefp:
-	stwu	r1,-32(r1)
-	mflr	r0
-	stw	r0,36(r1)
-	bl	fpenable
-	lis	r9,fpone@ha
-	li	r0,4
-	lfs	fr1,fpone@l(r9)
-	mtctr	r0
-	li	r6,0
-1:	lfsx	fr0,r4,r6
-	fdivs	fr0,fr1,fr0
-	stfsx	fr0,r3,r6
-	addi	r6,r6,4
-	bdnz	1b
-	bl	fpdisable
-	lwz	r0,36(r1)
-	mtlr	r0
-	addi	r1,r1,32
-	blr
-
-/*
- * Vector reciprocal square-root estimate, floating point.
- * We use the frsqrte instruction for the initial estimate followed
- * by 2 iterations of Newton-Raphson to get sufficient accuracy.
- * r3 -> destination, r4 -> source.
- */
-	.globl	vrsqrtefp
-vrsqrtefp:
-	stwu	r1,-48(r1)
-	mflr	r0
-	stw	r0,52(r1)
-	bl	fpenable
-	stfd	fr2,32(r1)
-	stfd	fr3,40(r1)
-	stfd	fr4,48(r1)
-	stfd	fr5,56(r1)
-	lis	r9,fpone@ha
-	lis	r8,fphalf@ha
-	li	r0,4
-	lfs	fr4,fpone@l(r9)
-	lfs	fr5,fphalf@l(r8)
-	mtctr	r0
-	li	r6,0
-1:	lfsx	fr0,r4,r6
-	frsqrte	fr1,fr0		/* r = frsqrte(s) */
-	fmuls	fr3,fr1,fr0	/* r * s */
-	fmuls	fr2,fr1,fr5	/* r * 0.5 */
-	fnmsubs	fr3,fr1,fr3,fr4	/* 1 - s * r * r */
-	fmadds	fr1,fr2,fr3,fr1	/* r = r + 0.5 * r * (1 - s * r * r) */
-	fmuls	fr3,fr1,fr0	/* r * s */
-	fmuls	fr2,fr1,fr5	/* r * 0.5 */
-	fnmsubs	fr3,fr1,fr3,fr4	/* 1 - s * r * r */
-	fmadds	fr1,fr2,fr3,fr1	/* r = r + 0.5 * r * (1 - s * r * r) */
-	stfsx	fr1,r3,r6
-	addi	r6,r6,4
-	bdnz	1b
-	lfd	fr5,56(r1)
-	lfd	fr4,48(r1)
-	lfd	fr3,40(r1)
-	lfd	fr2,32(r1)
-	bl	fpdisable
-	lwz	r0,36(r1)
-	mtlr	r0
-	addi	r1,r1,32
-	blr
diff --git a/arch/ppc64/kernel/Makefile b/arch/ppc64/kernel/Makefile
--- a/arch/ppc64/kernel/Makefile
+++ b/arch/ppc64/kernel/Makefile
@@ -76,3 +76,4 @@ endif
 
 # These are here while we do the architecture merge
 vecemu-y			+= ../../powerpc/kernel/vecemu.o
+vector-y			+= ../../powerpc/kernel/vector.o
diff --git a/arch/ppc64/kernel/vector.S b/arch/ppc64/kernel/vector.S
deleted file mode 100644
--- a/arch/ppc64/kernel/vector.S
+++ /dev/null
@@ -1,172 +0,0 @@
-#include <asm/ppc_asm.h>
-#include <asm/processor.h>
-
-/*
- * The routines below are in assembler so we can closely control the
- * usage of floating-point registers.  These routines must be called
- * with preempt disabled.
- */
-	.section ".toc","aw"
-fpzero:
-	.tc	FD_0_0[TC],0
-fpone:
-	.tc	FD_3ff00000_0[TC],0x3ff0000000000000	/* 1.0 */
-fphalf:
-	.tc	FD_3fe00000_0[TC],0x3fe0000000000000	/* 0.5 */
-
-	.text
-/*
- * Internal routine to enable floating point and set FPSCR to 0.
- * Don't call it from C; it doesn't use the normal calling convention.
- */
-fpenable:
-	mfmsr	r10
-	ori	r11,r10,MSR_FP
-	mtmsr	r11
-	isync
-	stfd	fr31,-8(r1)
-	stfd	fr0,-16(r1)
-	stfd	fr1,-24(r1)
-	mffs	fr31
-	lfd	fr1,fpzero@toc(r2)
-	mtfsf	0xff,fr1
-	blr
-
-fpdisable:
-	mtlr	r12
-	mtfsf	0xff,fr31
-	lfd	fr1,-24(r1)
-	lfd	fr0,-16(r1)
-	lfd	fr31,-8(r1)
-	mtmsr	r10
-	isync
-	blr
-
-/*
- * Vector add, floating point.
- */
-_GLOBAL(vaddfp)
-	mflr	r12
-	bl	fpenable
-	li	r0,4
-	mtctr	r0
-	li	r6,0
-1:	lfsx	fr0,r4,r6
-	lfsx	fr1,r5,r6
-	fadds	fr0,fr0,fr1
-	stfsx	fr0,r3,r6
-	addi	r6,r6,4
-	bdnz	1b
-	b	fpdisable
-
-/*
- * Vector subtract, floating point.
- */
-_GLOBAL(vsubfp)
-	mflr	r12
-	bl	fpenable
-	li	r0,4
-	mtctr	r0
-	li	r6,0
-1:	lfsx	fr0,r4,r6
-	lfsx	fr1,r5,r6
-	fsubs	fr0,fr0,fr1
-	stfsx	fr0,r3,r6
-	addi	r6,r6,4
-	bdnz	1b
-	b	fpdisable
-
-/*
- * Vector multiply and add, floating point.
- */
-_GLOBAL(vmaddfp)
-	mflr	r12
-	bl	fpenable
-	stfd	fr2,-32(r1)
-	li	r0,4
-	mtctr	r0
-	li	r7,0
-1:	lfsx	fr0,r4,r7
-	lfsx	fr1,r5,r7
-	lfsx	fr2,r6,r7
-	fmadds	fr0,fr0,fr2,fr1
-	stfsx	fr0,r3,r7
-	addi	r7,r7,4
-	bdnz	1b
-	lfd	fr2,-32(r1)
-	b	fpdisable
-
-/*
- * Vector negative multiply and subtract, floating point.
- */
-_GLOBAL(vnmsubfp)
-	mflr	r12
-	bl	fpenable
-	stfd	fr2,-32(r1)
-	li	r0,4
-	mtctr	r0
-	li	r7,0
-1:	lfsx	fr0,r4,r7
-	lfsx	fr1,r5,r7
-	lfsx	fr2,r6,r7
-	fnmsubs	fr0,fr0,fr2,fr1
-	stfsx	fr0,r3,r7
-	addi	r7,r7,4
-	bdnz	1b
-	lfd	fr2,-32(r1)
-	b	fpdisable
-
-/*
- * Vector reciprocal estimate.  We just compute 1.0/x.
- * r3 -> destination, r4 -> source.
- */
-_GLOBAL(vrefp)
-	mflr	r12
-	bl	fpenable
-	li	r0,4
-	lfd	fr1,fpone@toc(r2)
-	mtctr	r0
-	li	r6,0
-1:	lfsx	fr0,r4,r6
-	fdivs	fr0,fr1,fr0
-	stfsx	fr0,r3,r6
-	addi	r6,r6,4
-	bdnz	1b
-	b	fpdisable
-
-/*
- * Vector reciprocal square-root estimate, floating point.
- * We use the frsqrte instruction for the initial estimate followed
- * by 2 iterations of Newton-Raphson to get sufficient accuracy.
- * r3 -> destination, r4 -> source.
- */
-_GLOBAL(vrsqrtefp)
-	mflr	r12
-	bl	fpenable
-	stfd	fr2,-32(r1)
-	stfd	fr3,-40(r1)
-	stfd	fr4,-48(r1)
-	stfd	fr5,-56(r1)
-	li	r0,4
-	lfd	fr4,fpone@toc(r2)
-	lfd	fr5,fphalf@toc(r2)
-	mtctr	r0
-	li	r6,0
-1:	lfsx	fr0,r4,r6
-	frsqrte	fr1,fr0		/* r = frsqrte(s) */
-	fmuls	fr3,fr1,fr0	/* r * s */
-	fmuls	fr2,fr1,fr5	/* r * 0.5 */
-	fnmsubs	fr3,fr1,fr3,fr4	/* 1 - s * r * r */
-	fmadds	fr1,fr2,fr3,fr1	/* r = r + 0.5 * r * (1 - s * r * r) */
-	fmuls	fr3,fr1,fr0	/* r * s */
-	fmuls	fr2,fr1,fr5	/* r * 0.5 */
-	fnmsubs	fr3,fr1,fr3,fr4	/* 1 - s * r * r */
-	fmadds	fr1,fr2,fr3,fr1	/* r = r + 0.5 * r * (1 - s * r * r) */
-	stfsx	fr1,r3,r6
-	addi	r6,r6,4
-	bdnz	1b
-	lfd	fr5,-56(r1)
-	lfd	fr4,-48(r1)
-	lfd	fr3,-40(r1)
-	lfd	fr2,-32(r1)
-	b	fpdisable
