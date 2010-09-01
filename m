Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 5EC5DB71AF
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  2 Sep 2010 03:21:23 +1000 (EST)
Date: Wed, 1 Sep 2010 13:21:21 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: mtmsrd not defined
Message-ID: <20100901132121.27ddd792@opus.seanm.ca>
In-Reply-To: <04187CA6-D0DE-45B3-819F-DE26BFD9FF16@kernel.crashing.org>
References: <20100822180958.6305f5b1@lappy.seanm.ca>
	<1282516494.22370.440.camel@pasglop>
	<20100822184844.37c30d5e@lappy.seanm.ca>
	<D9007E15-F764-450D-9B20-6506F0051BA7@kernel.crashing.org>
	<20100831134605.1fca5fdf@lappy.seanm.ca>
	<20100831225525.1c9bd5a8@lappy.seanm.ca>
	<20100901080214.GA4722@brick.ozlabs.ibm.com>
	<04187CA6-D0DE-45B3-819F-DE26BFD9FF16@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ok, I didn't catch all the cases the first time :( Since the errors
seemed to come from copy_32.S, I didn't spend much time on sstep.c.

Here is an updated patch the fixes the mtmsrd problem and maps out the
floating point.

Cheers,
   Sean

Replace the BOOK3S_64 specific mtmsrd with the generic MTMSRD macro.
Only enable ldstfp when CONFIG_PPC_FPU is set.

Signed-off-by: Sean MacLennan <smaclennan@pikatech.com>
---
diff --git a/arch/powerpc/lib/copy_32.S b/arch/powerpc/lib/copy_32.S
index 74a7f41..55f19f9 100644
--- a/arch/powerpc/lib/copy_32.S
+++ b/arch/powerpc/lib/copy_32.S
@@ -62,7 +62,7 @@
 
 	.text
 	.stabs	"arch/powerpc/lib/",N_SO,0,0,0f
-	.stabs	"copy32.S",N_SO,0,0,0f
+	.stabs	"copy_32.S",N_SO,0,0,0f
 0:
 
 CACHELINE_BYTES = L1_CACHE_BYTES
diff --git a/arch/powerpc/lib/ldstfp.S b/arch/powerpc/lib/ldstfp.S
index f644863..6a85380 100644
--- a/arch/powerpc/lib/ldstfp.S
+++ b/arch/powerpc/lib/ldstfp.S
@@ -17,6 +17,8 @@
 #include <asm/asm-offsets.h>
 #include <linux/errno.h>
 
+#ifdef CONFIG_PPC_FPU
+
 #define STKFRM	(PPC_MIN_STKFRM + 16)
 
 	.macro	extab	instr,handler
@@ -81,7 +83,7 @@ _GLOBAL(do_lfs)
 	mfmsr	r6
 	ori	r7,r6,MSR_FP
 	cmpwi	cr7,r3,0
-	mtmsrd	r7
+	MTMSRD(r7)
 	isync
 	beq	cr7,1f
 	stfd	fr0,STKFRM-16(r1)
@@ -93,7 +95,7 @@ _GLOBAL(do_lfs)
 	lfd	fr0,STKFRM-16(r1)
 4:	PPC_LL	r0,STKFRM+PPC_LR_STKOFF(r1)
 	mtlr	r0
-	mtmsrd	r6
+	MTMSRD(r6)
 	isync
 	mr	r3,r9
 	addi	r1,r1,STKFRM
@@ -108,7 +110,7 @@ _GLOBAL(do_lfd)
 	mfmsr	r6
 	ori	r7,r6,MSR_FP
 	cmpwi	cr7,r3,0
-	mtmsrd	r7
+	MTMSRD(r7)
 	isync
 	beq	cr7,1f
 	stfd	fr0,STKFRM-16(r1)
@@ -120,7 +122,7 @@ _GLOBAL(do_lfd)
 	lfd	fr0,STKFRM-16(r1)
 4:	PPC_LL	r0,STKFRM+PPC_LR_STKOFF(r1)
 	mtlr	r0
-	mtmsrd	r6
+	MTMSRD(r6)
 	isync
 	mr	r3,r9
 	addi	r1,r1,STKFRM
@@ -135,7 +137,7 @@ _GLOBAL(do_stfs)
 	mfmsr	r6
 	ori	r7,r6,MSR_FP
 	cmpwi	cr7,r3,0
-	mtmsrd	r7
+	MTMSRD(r7)
 	isync
 	beq	cr7,1f
 	stfd	fr0,STKFRM-16(r1)
@@ -147,7 +149,7 @@ _GLOBAL(do_stfs)
 	lfd	fr0,STKFRM-16(r1)
 4:	PPC_LL	r0,STKFRM+PPC_LR_STKOFF(r1)
 	mtlr	r0
-	mtmsrd	r6
+	MTMSRD(r6)
 	isync
 	mr	r3,r9
 	addi	r1,r1,STKFRM
@@ -162,7 +164,7 @@ _GLOBAL(do_stfd)
 	mfmsr	r6
 	ori	r7,r6,MSR_FP
 	cmpwi	cr7,r3,0
-	mtmsrd	r7
+	MTMSRD(r7)
 	isync
 	beq	cr7,1f
 	stfd	fr0,STKFRM-16(r1)
@@ -174,7 +176,7 @@ _GLOBAL(do_stfd)
 	lfd	fr0,STKFRM-16(r1)
 4:	PPC_LL	r0,STKFRM+PPC_LR_STKOFF(r1)
 	mtlr	r0
-	mtmsrd	r6
+	MTMSRD(r6)
 	isync
 	mr	r3,r9
 	addi	r1,r1,STKFRM
@@ -229,7 +231,7 @@ _GLOBAL(do_lvx)
 	oris	r7,r6,MSR_VEC@h
 	cmpwi	cr7,r3,0
 	li	r8,STKFRM-16
-	mtmsrd	r7
+	MTMSRD(r7)
 	isync
 	beq	cr7,1f
 	stvx	vr0,r1,r8
@@ -241,7 +243,7 @@ _GLOBAL(do_lvx)
 	lvx	vr0,r1,r8
 4:	PPC_LL	r0,STKFRM+PPC_LR_STKOFF(r1)
 	mtlr	r0
-	mtmsrd	r6
+	MTMSRD(r6)
 	isync
 	mr	r3,r9
 	addi	r1,r1,STKFRM
@@ -257,7 +259,7 @@ _GLOBAL(do_stvx)
 	oris	r7,r6,MSR_VEC@h
 	cmpwi	cr7,r3,0
 	li	r8,STKFRM-16
-	mtmsrd	r7
+	MTMSRD(r7)
 	isync
 	beq	cr7,1f
 	stvx	vr0,r1,r8
@@ -269,7 +271,7 @@ _GLOBAL(do_stvx)
 	lvx	vr0,r1,r8
 4:	PPC_LL	r0,STKFRM+PPC_LR_STKOFF(r1)
 	mtlr	r0
-	mtmsrd	r6
+	MTMSRD(r6)
 	isync
 	mr	r3,r9
 	addi	r1,r1,STKFRM
@@ -325,7 +327,7 @@ _GLOBAL(do_lxvd2x)
 	oris	r7,r6,MSR_VSX@h
 	cmpwi	cr7,r3,0
 	li	r8,STKFRM-16
-	mtmsrd	r7
+	MTMSRD(r7)
 	isync
 	beq	cr7,1f
 	STXVD2X(0,r1,r8)
@@ -337,7 +339,7 @@ _GLOBAL(do_lxvd2x)
 	LXVD2X(0,r1,r8)
 4:	PPC_LL	r0,STKFRM+PPC_LR_STKOFF(r1)
 	mtlr	r0
-	mtmsrd	r6
+	MTMSRD(r6)
 	isync
 	mr	r3,r9
 	addi	r1,r1,STKFRM
@@ -353,7 +355,7 @@ _GLOBAL(do_stxvd2x)
 	oris	r7,r6,MSR_VSX@h
 	cmpwi	cr7,r3,0
 	li	r8,STKFRM-16
-	mtmsrd	r7
+	MTMSRD(r7)
 	isync
 	beq	cr7,1f
 	STXVD2X(0,r1,r8)
@@ -365,7 +367,7 @@ _GLOBAL(do_stxvd2x)
 	LXVD2X(0,r1,r8)
 4:	PPC_LL	r0,STKFRM+PPC_LR_STKOFF(r1)
 	mtlr	r0
-	mtmsrd	r6
+	MTMSRD(r6)
 	isync
 	mr	r3,r9
 	addi	r1,r1,STKFRM
@@ -373,3 +375,5 @@ _GLOBAL(do_stxvd2x)
 	extab	2b,3b
 
 #endif /* CONFIG_VSX */
+
+#endif	/* CONFIG_PPC_FPU */
diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
index e0a9858..ae5189a 100644
--- a/arch/powerpc/lib/sstep.c
+++ b/arch/powerpc/lib/sstep.c
@@ -30,6 +30,7 @@ extern char system_call_common[];
 #define XER_OV		0x40000000U
 #define XER_CA		0x20000000U
 
+#ifdef CONFIG_PPC_FPU
 /*
  * Functions in ldstfp.S
  */
@@ -41,6 +42,7 @@ extern int do_lvx(int rn, unsigned long ea);
 extern int do_stvx(int rn, unsigned long ea);
 extern int do_lxvd2x(int rn, unsigned long ea);
 extern int do_stxvd2x(int rn, unsigned long ea);
+#endif
 
 /*
  * Determine whether a conditional branch instruction would branch.
@@ -290,6 +292,7 @@ static int __kprobes write_mem(unsigned long val, unsigned long ea, int nb,
 	return write_mem_unaligned(val, ea, nb, regs);
 }
 
+#ifdef CONFIG_PPC_FPU
 /*
  * Check the address and alignment, and call func to do the actual
  * load or store.
@@ -351,6 +354,7 @@ static int __kprobes do_fp_store(int rn, int (*func)(int, unsigned long),
 	}
 	return err;
 }
+#endif
 
 #ifdef CONFIG_ALTIVEC
 /* For Altivec/VMX, no need to worry about alignment */
@@ -1393,6 +1397,7 @@ int __kprobes emulate_step(struct pt_regs *regs, unsigned int instr)
 				regs->gpr[rd] = byterev_4(val);
 			goto ldst_done;
 
+#ifdef CONFIG_PPC_CPU
 		case 535:	/* lfsx */
 		case 567:	/* lfsux */
 			if (!(regs->msr & MSR_FP))
@@ -1424,6 +1429,7 @@ int __kprobes emulate_step(struct pt_regs *regs, unsigned int instr)
 			ea = xform_ea(instr, regs, u);
 			err = do_fp_store(rd, do_stfd, ea, 8, regs);
 			goto ldst_done;
+#endif
 
 #ifdef __powerpc64__
 		case 660:	/* stdbrx */
@@ -1534,6 +1540,7 @@ int __kprobes emulate_step(struct pt_regs *regs, unsigned int instr)
 		} while (++rd < 32);
 		goto instr_done;
 
+#ifdef CONFIG_PPC_FPU
 	case 48:	/* lfs */
 	case 49:	/* lfsu */
 		if (!(regs->msr & MSR_FP))
@@ -1565,6 +1572,7 @@ int __kprobes emulate_step(struct pt_regs *regs, unsigned int instr)
 		ea = dform_ea(instr, regs);
 		err = do_fp_store(rd, do_stfd, ea, 8, regs);
 		goto ldst_done;
+#endif
 
 #ifdef __powerpc64__
 	case 58:	/* ld[u], lwa */
