Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xcS1D2jw4zDqhL
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Aug 2017 09:48:16 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 3xcS1C4hFrz9s9Y
 for <linuxppc-dev@ozlabs.org>; Wed, 23 Aug 2017 09:48:15 +1000 (AEST)
From: Paul Mackerras <paulus@ozlabs.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH RFC 1/7] powerpc: Extend instruction emulation infrastructure
Date: Wed, 23 Aug 2017 09:47:57 +1000
Message-Id: <1503445683-12011-2-git-send-email-paulus@ozlabs.org>
In-Reply-To: <1503445683-12011-1-git-send-email-paulus@ozlabs.org>
References: <1503445683-12011-1-git-send-email-paulus@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This extends the instruction emulation infrastructure in sstep.c to
handle all the load and store instructions defined in the Power ISA
v3.0, except for the atomic memory operations, ldmx (which was never
implemented), lfdp/stfdp, and the vector element load/stores.

The instructions added are:

Integer loads and stores: lbarx, lharx, lqarx, stbcx., sthcx., stqcx.,
lq, stq.

VSX loads and stores: lxsiwzx, lxsiwax, stxsiwx, lxvx, lxvl, lxvll,
lxvdsx, lxvwsx, stxvx, stxvl, stxvll, lxsspx, lxsdx, stxsspx, stxsdx,
lxvw4x, lxsibzx, lxvh8x, lxsihzx, lxvb16x, stxvw4x, stxsibx, stxvh8x,
stxsihx, stxvb16x, lxsd, lxssp, lxv, stxsd, stxssp, stxv.

These instructions are handled both in the analyse_instr phase and in
the emulate_step phase.

The code for lxvd2ux and stxvd2ux has been taken out, as those
instructions were never implemented in any processor and have been
taken out of the architecture, and their opcodes have been reused for
other instructions in POWER9 (lxvb16x and stxvb16x).

The emulation for the VSX loads and stores uses helper functions
which don't access registers or memory directly, which can hopefully
be reused by KVM later.

Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/include/asm/sstep.h |  20 ++
 arch/powerpc/lib/Makefile        |   2 +-
 arch/powerpc/lib/ldstfp.S        |  68 ++--
 arch/powerpc/lib/quad.S          |  62 ++++
 arch/powerpc/lib/sstep.c         | 688 ++++++++++++++++++++++++++++++++++++---
 5 files changed, 780 insertions(+), 60 deletions(-)
 create mode 100644 arch/powerpc/lib/quad.S

diff --git a/arch/powerpc/include/asm/sstep.h b/arch/powerpc/include/asm/sstep.h
index d3a42cc..863e1e4 100644
--- a/arch/powerpc/include/asm/sstep.h
+++ b/arch/powerpc/include/asm/sstep.h
@@ -68,6 +68,11 @@ enum instruction_type {
 #define DCBT		0x300
 #define ICBI		0x400
 
+/* VSX flags values */
+#define VSX_FPCONV	1	/* do floating point SP/DP conversion */
+#define VSX_SPLAT	2	/* store loaded value into all elements */
+#define VSX_LDLEFT	4	/* load VSX register from left */
+
 /* Size field in type word */
 #define SIZE(n)		((n) << 8)
 #define GETSIZE(w)	((w) >> 8)
@@ -83,7 +88,22 @@ struct instruction_op {
 	int update_reg;
 	/* For MFSPR */
 	int spr;
+	u8 element_size;	/* for VSX/VMX loads/stores */
+	u8 vsx_flags;
+};
+
+union vsx_reg {
+	u8	b[16];
+	u16	h[8];
+	u32	w[4];
+	unsigned long d[2];
+	float	fp[4];
+	double	dp[2];
 };
 
 extern int analyse_instr(struct instruction_op *op, struct pt_regs *regs,
 			 unsigned int instr);
+extern void emulate_vsx_load(struct instruction_op *op, union vsx_reg *reg,
+			     const void *mem);
+extern void emulate_vsx_store(struct instruction_op *op, const union vsx_reg *reg,
+			      void *mem);
diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
index 3c3146b..7921fed 100644
--- a/arch/powerpc/lib/Makefile
+++ b/arch/powerpc/lib/Makefile
@@ -31,7 +31,7 @@ obj64-$(CONFIG_KPROBES_SANITY_TEST) += test_emulate_step.o
 
 obj-y			+= checksum_$(BITS).o checksum_wrappers.o
 
-obj-$(CONFIG_PPC_EMULATE_SSTEP)	+= sstep.o ldstfp.o
+obj-$(CONFIG_PPC_EMULATE_SSTEP)	+= sstep.o ldstfp.o quad.o
 
 obj-$(CONFIG_PPC_LIB_RHEAP) += rheap.o
 
diff --git a/arch/powerpc/lib/ldstfp.S b/arch/powerpc/lib/ldstfp.S
index a58777c..0a67374 100644
--- a/arch/powerpc/lib/ldstfp.S
+++ b/arch/powerpc/lib/ldstfp.S
@@ -178,10 +178,10 @@ _GLOBAL(do_stfd)
 	EX_TABLE(2b,3b)
 
 #ifdef CONFIG_ALTIVEC
-/* Get the contents of vrN into v0; N is in r3. */
+/* Get the contents of vrN into v0; N is in r3. Doesn't touch r3 or r4. */
 _GLOBAL(get_vr)
 	mflr	r0
-	rlwinm	r3,r3,3,0xf8
+	rlwinm	r6,r3,3,0xf8
 	bcl	20,31,1f
 	blr			/* v0 is already in v0 */
 	nop
@@ -192,15 +192,15 @@ reg = 1
 reg = reg + 1
 	.endr
 1:	mflr	r5
-	add	r5,r3,r5
+	add	r5,r6,r5
 	mtctr	r5
 	mtlr	r0
 	bctr
 
-/* Put the contents of v0 into vrN; N is in r3. */
+/* Put the contents of v0 into vrN; N is in r3. Doesn't touch r3 or r4. */
 _GLOBAL(put_vr)
 	mflr	r0
-	rlwinm	r3,r3,3,0xf8
+	rlwinm	r6,r3,3,0xf8
 	bcl	20,31,1f
 	blr			/* v0 is already in v0 */
 	nop
@@ -211,7 +211,7 @@ reg = 1
 reg = reg + 1
 	.endr
 1:	mflr	r5
-	add	r5,r3,r5
+	add	r5,r6,r5
 	mtctr	r5
 	mtlr	r0
 	bctr
@@ -313,7 +313,7 @@ reg = reg + 1
 	bctr
 
 /* Load VSX reg N from vector doubleword *p.  N is in r3, p in r4. */
-_GLOBAL(do_lxvd2x)
+_GLOBAL(load_vsrn)
 	PPC_STLU r1,-STKFRM(r1)
 	mflr	r0
 	PPC_STL	r0,STKFRM+PPC_LR_STKOFF(r1)
@@ -325,41 +325,38 @@ _GLOBAL(do_lxvd2x)
 	isync
 	beq	cr7,1f
 	STXVD2X(0,R1,R8)
-1:	li	r9,-EFAULT
-2:	LXVD2X(0,R0,R4)
-	li	r9,0
-3:	beq	cr7,4f
+1:	LXVD2X(0,R0,R4)
+#ifdef __LITTLE_ENDIAN__
+	XXSWAPD(0,0)
+#endif
+	beq	cr7,4f
 	bl	put_vsr
 	LXVD2X(0,R1,R8)
 4:	PPC_LL	r0,STKFRM+PPC_LR_STKOFF(r1)
 	mtlr	r0
 	MTMSRD(r6)
 	isync
-	mr	r3,r9
 	addi	r1,r1,STKFRM
 	blr
-	EX_TABLE(2b,3b)
 
 /* Store VSX reg N to vector doubleword *p.  N is in r3, p in r4. */
-_GLOBAL(do_stxvd2x)
+_GLOBAL(store_vsrn)
 	PPC_STLU r1,-STKFRM(r1)
 	mflr	r0
 	PPC_STL	r0,STKFRM+PPC_LR_STKOFF(r1)
 	mfmsr	r6
 	oris	r7,r6,MSR_VSX@h
-	cmpwi	cr7,r3,0
 	li	r8,STKFRM-16
 	MTMSRD(r7)
 	isync
-	beq	cr7,1f
 	STXVD2X(0,R1,R8)
 	bl	get_vsr
-1:	li	r9,-EFAULT
-2:	STXVD2X(0,R0,R4)
-	li	r9,0
-3:	beq	cr7,4f
+#ifdef __LITTLE_ENDIAN__
+	XXSWAPD(0,0)
+#endif
+	STXVD2X(0,R0,R4)
 	LXVD2X(0,R1,R8)
-4:	PPC_LL	r0,STKFRM+PPC_LR_STKOFF(r1)
+	PPC_LL	r0,STKFRM+PPC_LR_STKOFF(r1)
 	mtlr	r0
 	MTMSRD(r6)
 	isync
@@ -368,6 +365,35 @@ _GLOBAL(do_stxvd2x)
 	blr
 	EX_TABLE(2b,3b)
 
+/* Convert single-precision to double, without disturbing FPRs. */
+/* conv_sp_to_dp(float *sp, double *dp) */
+_GLOBAL(conv_sp_to_dp)
+	mfmsr	r6
+	ori	r7, r6, MSR_FP
+	MTMSRD(r7)
+	isync
+	stfd	fr0, -16(r1)
+	lfs	fr0, 0(r3)
+	stfd	fr0, 0(r4)
+	lfd	fr0, -16(r1)
+	MTMSRD(r6)
+	isync
+	blr
+
+/* Convert single-precision to double, without disturbing FPRs. */
+/* conv_sp_to_dp(double *dp, float *sp) */
+_GLOBAL(conv_dp_to_sp)
+	mfmsr	r6
+	ori	r7, r6, MSR_FP
+	MTMSRD(r7)
+	isync
+	stfd	fr0, -16(r1)
+	lfd	fr0, 0(r3)
+	stfs	fr0, 0(r4)
+	lfd	fr0, -16(r1)
+	MTMSRD(r6)
+	isync
+	blr
 #endif /* CONFIG_VSX */
 
 #endif	/* CONFIG_PPC_FPU */
diff --git a/arch/powerpc/lib/quad.S b/arch/powerpc/lib/quad.S
new file mode 100644
index 0000000..2cc77dc
--- /dev/null
+++ b/arch/powerpc/lib/quad.S
@@ -0,0 +1,62 @@
+/*
+ * Quadword loads and stores
+ * for use in instruction emulation.
+ *
+ * Copyright 2017 Paul Mackerras, IBM Corp. <paulus@au1.ibm.com>
+ *
+ *  This program is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU General Public License
+ *  as published by the Free Software Foundation; either version
+ *  2 of the License, or (at your option) any later version.
+ */
+
+#include <asm/processor.h>
+#include <asm/ppc_asm.h>
+#include <asm/ppc-opcode.h>
+#include <asm/reg.h>
+#include <asm/asm-offsets.h>
+#include <linux/errno.h>
+
+/* do_lq(unsigned long ea, unsigned long *regs) */
+_GLOBAL(do_lq)
+1:	lq	r6, 0(r3)
+	std	r6, 0(r4)
+	std	r7, 8(r4)
+	li	r3, 0
+	blr
+2:	li	r3, -EFAULT
+	blr
+	EX_TABLE(1b, 2b)
+
+/* do_stq(unsigned long ea, unsigned long val0, unsigned long val1) */
+_GLOBAL(do_stq)
+1:	stq	r4, 0(r3)
+	li	r3, 0
+	blr
+2:	li	r3, -EFAULT
+	blr
+	EX_TABLE(1b, 2b)
+
+/* do_lqarx(unsigned long ea, unsigned long *regs) */
+_GLOBAL(do_lqarx)
+1:	lqarx	r6, 0, r3
+	std	r6, 0(r4)
+	std	r7, 8(r4)
+	li	r3, 0
+	blr
+2:	li	r3, -EFAULT
+	blr
+	EX_TABLE(1b, 2b)
+
+/* do_stqcx(unsigned long ea, unsigned long val0, unsigned long val1,
+	    unsigned int *crp) */
+
+_GLOBAL(do_stqcx)
+1:	stqcx.	r4, 0, r3
+	mfcr	r5
+	stw	r5, 0(r6)
+	li	r3, 0
+	blr
+2:	li	r3, -EFAULT
+	blr
+	EX_TABLE(1b, 2b)
diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
index ee33327..6f54812 100644
--- a/arch/powerpc/lib/sstep.c
+++ b/arch/powerpc/lib/sstep.c
@@ -42,8 +42,29 @@ extern int do_stfs(int rn, unsigned long ea);
 extern int do_stfd(int rn, unsigned long ea);
 extern int do_lvx(int rn, unsigned long ea);
 extern int do_stvx(int rn, unsigned long ea);
-extern int do_lxvd2x(int rn, unsigned long ea);
-extern int do_stxvd2x(int rn, unsigned long ea);
+extern void load_vsrn(int vsr, const void *p);
+extern void store_vsrn(int vsr, void *p);
+extern void conv_sp_to_dp(const float *sp, double *dp);
+extern void conv_dp_to_sp(const double *dp, float *sp);
+#endif
+
+#ifdef __powerpc64__
+/*
+ * Functions in quad.S
+ */
+extern int do_lq(unsigned long ea, unsigned long *regs);
+extern int do_stq(unsigned long ea, unsigned long val0, unsigned long val1);
+extern int do_lqarx(unsigned long ea, unsigned long *regs);
+extern int do_stqcx(unsigned long ea, unsigned long val0, unsigned long val1,
+		    unsigned int *crp);
+#endif
+
+#ifdef __LITTLE_ENDIAN__
+#define IS_LE	1
+#define IS_BE	0
+#else
+#define IS_LE	0
+#define IS_BE	1
 #endif
 
 /*
@@ -121,6 +142,22 @@ static nokprobe_inline unsigned long dsform_ea(unsigned int instr, struct pt_reg
 
 	return truncate_if_32bit(regs->msr, ea);
 }
+
+/*
+ * Calculate effective address for a DQ-form instruction
+ */
+static nokprobe_inline unsigned long dqform_ea(unsigned int instr, struct pt_regs *regs)
+{
+	int ra;
+	unsigned long ea;
+
+	ra = (instr >> 16) & 0x1f;
+	ea = (signed short) (instr & ~0xf);	/* sign-extend */
+	if (ra)
+		ea += regs->gpr[ra];
+
+	return truncate_if_32bit(regs->msr, ea);
+}
 #endif /* __powerpc64 */
 
 /*
@@ -450,43 +487,197 @@ static nokprobe_inline int do_vec_store(int rn, int (*func)(int, unsigned long),
 }
 #endif /* CONFIG_ALTIVEC */
 
-#ifdef CONFIG_VSX
-static nokprobe_inline int do_vsx_load(int rn, int (*func)(int, unsigned long),
-				 unsigned long ea, struct pt_regs *regs)
+#ifdef __powerpc64__
+static nokprobe_inline int emulate_lq(struct pt_regs *regs, unsigned long ea,
+				      int reg)
 {
 	int err;
-	unsigned long val[2];
 
 	if (!address_ok(regs, ea, 16))
 		return -EFAULT;
-	if ((ea & 3) == 0)
-		return (*func)(rn, ea);
-	err = read_mem_unaligned(&val[0], ea, 8, regs);
-	if (!err)
-		err = read_mem_unaligned(&val[1], ea + 8, 8, regs);
+	/* if aligned, should be atomic */
+	if ((ea & 0xf) == 0)
+		return do_lq(ea, &regs->gpr[reg]);
+
+	err = read_mem(&regs->gpr[reg + IS_LE], ea, 8, regs);
 	if (!err)
-		err = (*func)(rn, (unsigned long) &val[0]);
+		err = read_mem(&regs->gpr[reg + IS_BE], ea + 8, 8, regs);
 	return err;
 }
 
-static nokprobe_inline int do_vsx_store(int rn, int (*func)(int, unsigned long),
-				 unsigned long ea, struct pt_regs *regs)
+static nokprobe_inline int emulate_stq(struct pt_regs *regs, unsigned long ea,
+				       int reg)
 {
 	int err;
-	unsigned long val[2];
 
 	if (!address_ok(regs, ea, 16))
 		return -EFAULT;
-	if ((ea & 3) == 0)
-		return (*func)(rn, ea);
-	err = (*func)(rn, (unsigned long) &val[0]);
-	if (err)
-		return err;
-	err = write_mem_unaligned(val[0], ea, 8, regs);
+	/* if aligned, should be atomic */
+	if ((ea & 0xf) == 0)
+		return do_stq(ea, regs->gpr[reg], regs->gpr[reg + 1]);
+
+	err = write_mem(regs->gpr[reg + IS_LE], ea, 8, regs);
 	if (!err)
-		err = write_mem_unaligned(val[1], ea + 8, 8, regs);
+		err = write_mem(regs->gpr[reg + IS_BE], ea + 8, 8, regs);
 	return err;
 }
+#endif /* __powerpc64 */
+
+#ifdef CONFIG_VSX
+void emulate_vsx_load(struct instruction_op *op, union vsx_reg *reg,
+		      const void *mem)
+{
+	int size, read_size;
+	int i, j;
+	union vsx_reg buf;
+	const unsigned int *wp;
+	const unsigned short *hp;
+	const unsigned char *bp;
+
+	size = GETSIZE(op->type);
+	buf.d[0] = buf.d[1] = 0;
+
+	switch (op->element_size) {
+	case 16:
+		/* whole vector; lxv[x] or lxvl[l] */
+		if (size == 0)
+			break;
+		memcpy(&buf, mem, size);
+		if (IS_LE && (op->vsx_flags & VSX_LDLEFT)) {
+			/* reverse 16 bytes */
+			unsigned long tmp;
+			tmp = byterev_8(buf.d[0]);
+			buf.d[0] = byterev_8(buf.d[1]);
+			buf.d[1] = tmp;
+		}
+		break;
+	case 8:
+		/* scalar loads, lxvd2x, lxvdsx */
+		read_size = (size >= 8) ? 8 : size;
+		i = IS_LE ? 8 : 8 - read_size;
+		memcpy(&buf.b[i], mem, read_size);
+		if (size < 8) {
+			if (op->type & SIGNEXT) {
+				/* size == 4 is the only case here */
+				buf.d[IS_LE] = (signed int) buf.d[IS_LE];
+			} else if (op->vsx_flags & VSX_FPCONV) {
+				preempt_disable();
+				conv_sp_to_dp(&buf.fp[1 + IS_LE],
+					      &buf.dp[IS_LE]);
+				preempt_enable();
+			}
+		} else {
+			if (size == 16)
+				buf.d[IS_BE] = *(unsigned long *)(mem + 8);
+			else if (op->vsx_flags & VSX_SPLAT)
+				buf.d[IS_BE] = buf.d[IS_LE];
+		}
+		break;
+	case 4:
+		/* lxvw4x, lxvwsx */
+		wp = mem;
+		for (j = 0; j < size / 4; ++j) {
+			i = IS_LE ? 3 - j : j;
+			buf.w[i] = *wp++;
+		}
+		if (op->vsx_flags & VSX_SPLAT) {
+			u32 val = buf.w[IS_LE ? 3 : 0];
+			for (; j < 4; ++j) {
+				i = IS_LE ? 3 - j : j;
+				buf.w[i] = val;
+			}
+		}
+		break;
+	case 2:
+		/* lxvh8x */
+		hp = mem;
+		for (j = 0; j < size / 2; ++j) {
+			i = IS_LE ? 7 - j : j;
+			buf.h[i] = *hp++;
+		}
+		break;
+	case 1:
+		/* lxvb16x */
+		bp = mem;
+		for (j = 0; j < size; ++j) {
+			i = IS_LE ? 15 - j : j;
+			buf.b[i] = *bp++;
+		}
+		break;
+	}
+	*reg = buf;
+}
+EXPORT_SYMBOL_GPL(emulate_vsx_load);
+NOKPROBE_SYMBOL(emulate_vsx_load);
+
+void emulate_vsx_store(struct instruction_op *op, const union vsx_reg *reg,
+		       void *mem)
+{
+	int size, write_size;
+	int i, j;
+	union vsx_reg buf;
+	unsigned int *wp;
+	unsigned short *hp;
+	unsigned char *bp;
+
+	size = GETSIZE(op->type);
+
+	switch (op->element_size) {
+	case 16:
+		/* stxv, stxvx, stxvl, stxvll */
+		if (size == 0)
+			break;
+		if (IS_LE && (op->vsx_flags & VSX_LDLEFT)) {
+			/* reverse 16 bytes */
+			buf.d[0] = byterev_8(reg->d[1]);
+			buf.d[1] = byterev_8(reg->d[0]);
+			reg = &buf;
+		}
+		memcpy(mem, reg, size);
+		break;
+	case 8:
+		/* scalar stores, stxvd2x */
+		write_size = (size >= 8) ? 8 : size;
+		i = IS_LE ? 8 : 8 - write_size;
+		if (size < 8 && op->vsx_flags & VSX_FPCONV) {
+			buf.d[0] = buf.d[1] = 0;
+			preempt_disable();
+			conv_dp_to_sp(&reg->dp[IS_LE], &buf.fp[1 + IS_LE]);
+			preempt_enable();
+			reg = &buf;
+		}
+		memcpy(mem, &reg->b[i], write_size);
+		if (size == 16)
+			memcpy(mem + 8, &reg->d[IS_BE], 8);
+		break;
+	case 4:
+		/* stxvw4x */
+		wp = mem;
+		for (j = 0; j < size / 4; ++j) {
+			i = IS_LE ? 3 - j : j;
+			*wp++ = reg->w[i];
+		}
+		break;
+	case 2:
+		/* stxvh8x */
+		hp = mem;
+		for (j = 0; j < size / 2; ++j) {
+			i = IS_LE ? 7 - j : j;
+			*hp++ = reg->h[i];
+		}
+		break;
+	case 1:
+		/* stvxb16x */
+		bp = mem;
+		for (j = 0; j < size; ++j) {
+			i = IS_LE ? 15 - j : j;
+			*bp++ = reg->b[i];
+		}
+		break;
+	}
+}
+EXPORT_SYMBOL_GPL(emulate_vsx_store);
+NOKPROBE_SYMBOL(emulate_vsx_store);
 #endif /* CONFIG_VSX */
 
 #define __put_user_asmx(x, addr, err, op, cr)		\
@@ -1337,14 +1528,15 @@ int analyse_instr(struct instruction_op *op, struct pt_regs *regs,
 		break;
 	}
 
-	/*
-	 * Loads and stores.
-	 */
+/*
+ * Loads and stores.
+ */
 	op->type = UNKNOWN;
 	op->update_reg = ra;
 	op->reg = rd;
 	op->val = regs->gpr[rd];
 	u = (instr >> 20) & UPDATE;
+	op->vsx_flags = 0;
 
 	switch (opcode) {
 	case 31:
@@ -1368,9 +1560,30 @@ int analyse_instr(struct instruction_op *op, struct pt_regs *regs,
 			op->type = MKOP(STCX, 0, 8);
 			break;
 
-		case 21:	/* ldx */
-		case 53:	/* ldux */
-			op->type = MKOP(LOAD, u, 8);
+		case 52:	/* lbarx */
+			op->type = MKOP(LARX, 0, 1);
+			break;
+
+		case 694:	/* stbcx. */
+			op->type = MKOP(STCX, 0, 1);
+			break;
+
+		case 116:	/* lharx */
+			op->type = MKOP(LARX, 0, 2);
+			break;
+
+		case 726:	/* sthcx. */
+			op->type = MKOP(STCX, 0, 2);
+			break;
+
+		case 276:	/* lqarx */
+			if (!((rd & 1) || rd == ra || rd == rb))
+				op->type = MKOP(LARX, 0, 16);
+			break;
+
+		case 182:	/* stqcx. */
+			if (!(rd & 1))
+				op->type = MKOP(STCX, 0, 16);
 			break;
 #endif
 
@@ -1390,6 +1603,7 @@ int analyse_instr(struct instruction_op *op, struct pt_regs *regs,
 			if (!(regs->msr & MSR_VEC))
 				goto vecunavail;
 			op->type = MKOP(LOAD_VMX, 0, 16);
+			op->element_size = 16;
 			break;
 
 		case 231:	/* stvx */
@@ -1401,6 +1615,11 @@ int analyse_instr(struct instruction_op *op, struct pt_regs *regs,
 #endif /* CONFIG_ALTIVEC */
 
 #ifdef __powerpc64__
+		case 21:	/* ldx */
+		case 53:	/* ldux */
+			op->type = MKOP(LOAD, u, 8);
+			break;
+
 		case 149:	/* stdx */
 		case 181:	/* stdux */
 			op->type = MKOP(STORE, u, 8);
@@ -1529,20 +1748,267 @@ int analyse_instr(struct instruction_op *op, struct pt_regs *regs,
 			break;
 
 #ifdef CONFIG_VSX
+		case 12:	/* lxsiwzx */
+			if (!(regs->msr & MSR_VSX))
+				goto vsxunavail;
+			op->reg = rd | ((instr & 1) << 5);
+			op->type = MKOP(LOAD_VSX, 0, 4);
+			op->element_size = 8;
+			break;
+
+		case 76:	/* lxsiwax */
+			if (!(regs->msr & MSR_VSX))
+				goto vsxunavail;
+			op->reg = rd | ((instr & 1) << 5);
+			op->type = MKOP(LOAD_VSX, SIGNEXT, 4);
+			op->element_size = 8;
+			break;
+
+		case 140:	/* stxsiwx */
+			if (!(regs->msr & MSR_VSX))
+				goto vsxunavail;
+			op->reg = rd | ((instr & 1) << 5);
+			op->type = MKOP(STORE_VSX, 0, 4);
+			op->element_size = 8;
+			break;
+
+		case 268:	/* lxvx */
+			if (!(instr & 1)) {
+				if (!(regs->msr & MSR_VSX))
+					goto vsxunavail;
+			} else {
+				if (!(regs->msr & MSR_VEC))
+					goto vecunavail;
+				op->reg = rd + 32;
+			}
+			op->type = MKOP(LOAD_VSX, 0, 16);
+			op->element_size = 16;
+			break;
+
+		case 269:	/* lxvl */
+		case 301: {	/* lxvll */
+			int nb;
+			if (!(instr & 1)) {
+				if (!(regs->msr & MSR_VSX))
+					goto vsxunavail;
+			} else {
+				if (!(regs->msr & MSR_VEC))
+					goto vecunavail;
+				op->reg = rd + 32;
+			}
+			op->ea = ra ? regs->gpr[ra] : 0;
+			nb = regs->gpr[rb] & 0xff;
+			if (nb > 16)
+				nb = 16;
+			op->type = MKOP(LOAD_VSX, 0, nb);
+			op->element_size = 16;
+			op->vsx_flags = (instr & 0x20) ? VSX_LDLEFT : 0;
+			break;
+		}
+		case 332:	/* lxvdsx */
+			if (!(regs->msr & MSR_VSX))
+				goto vsxunavail;
+			op->reg = rd | ((instr & 1) << 5);
+			op->type = MKOP(LOAD_VSX, 0, 8);
+			op->element_size = 8;
+			op->vsx_flags = VSX_SPLAT;
+			break;
+
+		case 364:	/* lxvwsx */
+			if (!(instr & 1)) {
+				if (!(regs->msr & MSR_VSX))
+					goto vsxunavail;
+			} else {
+				if (!(regs->msr & MSR_VEC))
+					goto vecunavail;
+				op->reg = rd + 32;
+			}
+			op->type = MKOP(LOAD_VSX, 0, 4);
+			op->element_size = 4;
+			op->vsx_flags = VSX_SPLAT;
+			break;
+
+		case 396:	/* stxvx */
+			if (!(instr & 1)) {
+				if (!(regs->msr & MSR_VSX))
+					goto vsxunavail;
+			} else {
+				if (!(regs->msr & MSR_VEC))
+					goto vecunavail;
+				op->reg = rd + 32;
+			}
+			op->type = MKOP(STORE_VSX, 0, 16);
+			op->element_size = 16;
+			break;
+
+		case 397:	/* stxvl */
+		case 429: {	/* stxvll */
+			int nb;
+			if (!(instr & 1)) {
+				if (!(regs->msr & MSR_VSX))
+					goto vsxunavail;
+			} else {
+				if (!(regs->msr & MSR_VEC))
+					goto vecunavail;
+				op->reg = rd + 32;
+			}
+			op->ea = ra ? regs->gpr[ra] : 0;
+			nb = regs->gpr[rb] & 0xff;
+			if (nb > 16)
+				nb = 16;
+			op->type = MKOP(STORE_VSX, 0, nb);
+			op->element_size = 16;
+			op->vsx_flags = (instr & 0x20) ? VSX_LDLEFT : 0;
+			break;
+		}
+		case 524:	/* lxsspx */
+			if (!(regs->msr & MSR_VSX))
+				goto vsxunavail;
+			op->reg = rd | ((instr & 1) << 5);
+			op->type = MKOP(LOAD_VSX, 0, 4);
+			op->element_size = 8;
+			op->vsx_flags = VSX_FPCONV;
+			break;
+
+		case 588:	/* lxsdx */
+			if (!(regs->msr & MSR_VSX))
+				goto vsxunavail;
+			op->reg = rd | ((instr & 1) << 5);
+			op->type = MKOP(LOAD_VSX, 0, 8);
+			op->element_size = 8;
+			break;
+
+		case 652:	/* stxsspx */
+			if (!(regs->msr & MSR_VSX))
+				goto vsxunavail;
+			op->reg = rd | ((instr & 1) << 5);
+			op->type = MKOP(STORE_VSX, 0, 4);
+			op->element_size = 8;
+			op->vsx_flags = VSX_FPCONV;
+			break;
+
+		case 716:	/* stxsdx */
+			if (!(regs->msr & MSR_VSX))
+				goto vsxunavail;
+			op->reg = rd | ((instr & 1) << 5);
+			op->type = MKOP(STORE_VSX, 0, 8);
+			op->element_size = 8;
+			break;
+
+		case 780:	/* lxvw4x */
+			if (!(regs->msr & MSR_VSX))
+				goto vsxunavail;
+			op->reg = rd | ((instr & 1) << 5);
+			op->type = MKOP(LOAD_VSX, 0, 16);
+			op->element_size = 4;
+			break;
+
+		case 781:	/* lxsibzx */
+			if (!(regs->msr & MSR_VSX))
+				goto vsxunavail;
+			op->reg = rd | ((instr & 1) << 5);
+			op->type = MKOP(LOAD_VSX, 0, 1);
+			op->element_size = 8;
+			break;
+
+		case 812:	/* lxvh8x */
+			if (!(regs->msr & MSR_VSX))
+				goto vsxunavail;
+			op->reg = rd | ((instr & 1) << 5);
+			op->type = MKOP(LOAD_VSX, 0, 16);
+			op->element_size = 2;
+			break;
+
+		case 813:	/* lxsihzx */
+			if (!(regs->msr & MSR_VSX))
+				goto vsxunavail;
+			op->reg = rd | ((instr & 1) << 5);
+			op->type = MKOP(LOAD_VSX, 0, 2);
+			op->element_size = 8;
+			break;
+
 		case 844:	/* lxvd2x */
-		case 876:	/* lxvd2ux */
 			if (!(regs->msr & MSR_VSX))
 				goto vsxunavail;
 			op->reg = rd | ((instr & 1) << 5);
-			op->type = MKOP(LOAD_VSX, u, 16);
+			op->type = MKOP(LOAD_VSX, 0, 16);
+			op->element_size = 8;
+			break;
+
+		case 876:	/* lxvb16x */
+			if (!(regs->msr & MSR_VSX))
+				goto vsxunavail;
+			op->reg = rd | ((instr & 1) << 5);
+			op->type = MKOP(LOAD_VSX, 0, 16);
+			op->element_size = 1;
+			break;
+
+		case 908:	/* stxvw4x */
+			if (!(regs->msr & MSR_VSX))
+				goto vsxunavail;
+			op->reg = rd | ((instr & 1) << 5);
+			op->type = MKOP(STORE_VSX, 0, 16);
+			op->element_size = 4;
+			break;
+
+		case 909:	/* stxsibx */
+			if (!(instr & 1)) {
+				if (!(regs->msr & MSR_VSX))
+					goto vsxunavail;
+			} else {
+				if (!(regs->msr & MSR_VEC))
+					goto vecunavail;
+				op->reg = rd + 32;
+			}
+			op->type = MKOP(STORE_VSX, 0, 1);
+			op->element_size = 8;
+			break;
+
+		case 940:	/* stxvh8x */
+			if (!(instr & 1)) {
+				if (!(regs->msr & MSR_VSX))
+					goto vsxunavail;
+			} else {
+				if (!(regs->msr & MSR_VEC))
+					goto vecunavail;
+				op->reg = rd + 32;
+			}
+			op->type = MKOP(STORE_VSX, 0, 16);
+			op->element_size = 2;
+			break;
+
+		case 941:	/* stxsihx */
+			if (!(instr & 1)) {
+				if (!(regs->msr & MSR_VSX))
+					goto vsxunavail;
+			} else {
+				if (!(regs->msr & MSR_VEC))
+					goto vecunavail;
+				op->reg = rd + 32;
+			}
+			op->type = MKOP(STORE_VSX, 0, 2);
+			op->element_size = 8;
 			break;
 
 		case 972:	/* stxvd2x */
-		case 1004:	/* stxvd2ux */
 			if (!(regs->msr & MSR_VSX))
 				goto vsxunavail;
 			op->reg = rd | ((instr & 1) << 5);
-			op->type = MKOP(STORE_VSX, u, 16);
+			op->type = MKOP(STORE_VSX, 0, 16);
+			op->element_size = 8;
+			break;
+
+		case 1004:	/* stxvb16x */
+			if (!(instr & 1)) {
+				if (!(regs->msr & MSR_VSX))
+					goto vsxunavail;
+			} else {
+				if (!(regs->msr & MSR_VEC))
+					goto vecunavail;
+				op->reg = rd + 32;
+			}
+			op->type = MKOP(STORE_VSX, 0, 16);
+			op->element_size = 1;
 			break;
 
 #endif /* CONFIG_VSX */
@@ -1638,6 +2104,37 @@ int analyse_instr(struct instruction_op *op, struct pt_regs *regs,
 #endif
 
 #ifdef __powerpc64__
+	case 56:	/* lq */
+		if (!((rd & 1) || (rd == ra)))
+			op->type = MKOP(LOAD, 0, 16);
+		op->ea = dqform_ea(instr, regs);
+		break;
+#endif
+
+#ifdef CONFIG_VSX
+	case 57:	/* lxsd, lxssp */
+		op->ea = dsform_ea(instr, regs);
+		switch (instr & 3) {
+		case 2:		/* lxsd */
+			if (!(regs->msr & MSR_VSX))
+				goto vsxunavail;
+			op->reg = rd + 32;
+			op->type = MKOP(LOAD_VSX, 0, 8);
+			op->element_size = 8;
+			break;
+		case 3:		/* lxssp */
+			if (!(regs->msr & MSR_VSX))
+				goto vsxunavail;
+			op->reg = rd + 32;
+			op->type = MKOP(LOAD_VSX, 0, 4);
+			op->element_size = 8;
+			op->vsx_flags = VSX_FPCONV;
+			break;
+		}
+		break;
+#endif /* CONFIG_VSX */
+
+#ifdef __powerpc64__
 	case 58:	/* ld[u], lwa */
 		op->ea = dsform_ea(instr, regs);
 		switch (instr & 3) {
@@ -1652,7 +2149,64 @@ int analyse_instr(struct instruction_op *op, struct pt_regs *regs,
 			break;
 		}
 		break;
+#endif
+
+#ifdef CONFIG_VSX
+	case 61:	/* lxv, stxsd, stxssp, stxv */
+		switch (instr & 7) {
+		case 1:		/* lxv */
+			op->ea = dqform_ea(instr, regs);
+			if (!(instr & 8)) {
+				if (!(regs->msr & MSR_VSX))
+					goto vsxunavail;
+			} else {
+				if (!(regs->msr & MSR_VEC))
+					goto vecunavail;
+				op->reg = rd + 32;
+			}
+			op->type = MKOP(LOAD_VSX, 0, 16);
+			op->element_size = 16;
+			break;
+
+		case 2:		/* stxsd with LSB of DS field = 0 */
+		case 6:		/* stxsd with LSB of DS field = 1 */
+			op->ea = dsform_ea(instr, regs);
+			if (!(regs->msr & MSR_VEC))
+				goto vecunavail;
+			op->reg = rd + 32;
+			op->type = MKOP(STORE_VSX, 0, 8);
+			op->element_size = 8;
+			break;
+
+		case 3:		/* stxssp with LSB of DS field = 0 */
+		case 7:		/* stxssp with LSB of DS field = 1 */
+			op->ea = dsform_ea(instr, regs);
+			if (!(regs->msr & MSR_VEC))
+				goto vecunavail;
+			op->reg = rd + 32;
+			op->type = MKOP(STORE_VSX, 0, 4);
+			op->element_size = 8;
+			op->vsx_flags = VSX_FPCONV;
+			break;
+
+		case 5:		/* stxv */
+			op->ea = dqform_ea(instr, regs);
+			if (!(instr & 8)) {
+				if (!(regs->msr & MSR_VSX))
+					goto vsxunavail;
+			} else {
+				if (!(regs->msr & MSR_VEC))
+					goto vecunavail;
+				op->reg = rd + 32;
+			}
+			op->type = MKOP(STORE_VSX, 0, 16);
+			op->element_size = 16;
+			break;
+		}
+		break;
+#endif /* CONFIG_VSX */
 
+#ifdef __powerpc64__
 	case 62:	/* std[u] */
 		op->ea = dsform_ea(instr, regs);
 		switch (instr & 3) {
@@ -1662,6 +2216,10 @@ int analyse_instr(struct instruction_op *op, struct pt_regs *regs,
 		case 1:		/* stdu */
 			op->type = MKOP(STORE, UPDATE, 8);
 			break;
+		case 2:		/* stq */
+			if (!(rd & 1))
+				op->type = MKOP(STORE, 0, 16);
+			break;
 		}
 		break;
 #endif /* __powerpc64__ */
@@ -1825,6 +2383,14 @@ int emulate_step(struct pt_regs *regs, unsigned int instr)
 			return 0;
 		err = 0;
 		switch (size) {
+#ifdef __powerpc64__
+		case 1:
+			__get_user_asmx(val, op.ea, err, "lbarx");
+			break;
+		case 2:
+			__get_user_asmx(val, op.ea, err, "lharx");
+			break;
+#endif
 		case 4:
 			__get_user_asmx(val, op.ea, err, "lwarx");
 			break;
@@ -1832,6 +2398,9 @@ int emulate_step(struct pt_regs *regs, unsigned int instr)
 		case 8:
 			__get_user_asmx(val, op.ea, err, "ldarx");
 			break;
+		case 16:
+			err = do_lqarx(op.ea, &regs->gpr[op.reg]);
+			goto ldst_done;
 #endif
 		default:
 			return 0;
@@ -1847,6 +2416,14 @@ int emulate_step(struct pt_regs *regs, unsigned int instr)
 			return 0;
 		err = 0;
 		switch (size) {
+#ifdef __powerpc64__
+		case 1:
+			__put_user_asmx(op.val, op.ea, err, "stbcx.", cr);
+			break;
+		case 2:
+			__put_user_asmx(op.val, op.ea, err, "stbcx.", cr);
+			break;
+#endif
 		case 4:
 			__put_user_asmx(op.val, op.ea, err, "stwcx.", cr);
 			break;
@@ -1854,6 +2431,10 @@ int emulate_step(struct pt_regs *regs, unsigned int instr)
 		case 8:
 			__put_user_asmx(op.val, op.ea, err, "stdcx.", cr);
 			break;
+		case 16:
+			err = do_stqcx(op.ea, regs->gpr[op.reg],
+				       regs->gpr[op.reg + 1], &cr);
+			break;
 #endif
 		default:
 			return 0;
@@ -1865,6 +2446,12 @@ int emulate_step(struct pt_regs *regs, unsigned int instr)
 		goto ldst_done;
 
 	case LOAD:
+#ifdef __powerpc64__
+		if (size == 16) {
+			err = emulate_lq(regs, op.ea, op.reg);
+			goto ldst_done;
+		}
+#endif
 		err = read_mem(&regs->gpr[op.reg], op.ea, size, regs);
 		if (!err) {
 			if (op.type & SIGNEXT)
@@ -1884,13 +2471,22 @@ int emulate_step(struct pt_regs *regs, unsigned int instr)
 #endif
 #ifdef CONFIG_ALTIVEC
 	case LOAD_VMX:
-		err = do_vec_load(op.reg, do_lvx, op.ea & ~0xfUL, regs);
+		err = do_vec_load(op.reg, do_lvx, op.ea, regs);
 		goto ldst_done;
 #endif
 #ifdef CONFIG_VSX
-	case LOAD_VSX:
-		err = do_vsx_load(op.reg, do_lxvd2x, op.ea, regs);
+	case LOAD_VSX: {
+		char mem[16];
+		union vsx_reg buf;
+
+		if (!address_ok(regs, op.ea, size) ||
+		    __copy_from_user(mem, (void __user *)op.ea, size))
+			return 0;
+
+		emulate_vsx_load(&op, &buf, mem);
+		load_vsrn(op.reg, &buf);
 		goto ldst_done;
+	}
 #endif
 	case LOAD_MULTI:
 		if (regs->msr & MSR_LE)
@@ -1911,6 +2507,12 @@ int emulate_step(struct pt_regs *regs, unsigned int instr)
 		goto instr_done;
 
 	case STORE:
+#ifdef __powerpc64__
+		if (size == 16) {
+			err = emulate_stq(regs, op.ea, op.reg);
+			goto ldst_done;
+		}
+#endif
 		if ((op.type & UPDATE) && size == sizeof(long) &&
 		    op.reg == 1 && op.update_reg == 1 &&
 		    !(regs->msr & MSR_PR) &&
@@ -1931,13 +2533,23 @@ int emulate_step(struct pt_regs *regs, unsigned int instr)
 #endif
 #ifdef CONFIG_ALTIVEC
 	case STORE_VMX:
-		err = do_vec_store(op.reg, do_stvx, op.ea & ~0xfUL, regs);
+		err = do_vec_store(op.reg, do_stvx, op.ea, regs);
 		goto ldst_done;
 #endif
 #ifdef CONFIG_VSX
-	case STORE_VSX:
-		err = do_vsx_store(op.reg, do_stxvd2x, op.ea, regs);
+	case STORE_VSX: {
+		char mem[16];
+		union vsx_reg buf;
+
+		if (!address_ok(regs, op.ea, size))
+			return 0;
+
+		store_vsrn(op.reg, &buf);
+		emulate_vsx_store(&op, &buf, mem);
+		if (__copy_to_user((void __user *)op.ea, mem, size))
+			return 0;
 		goto ldst_done;
+	}
 #endif
 	case STORE_MULTI:
 		if (regs->msr & MSR_LE)
-- 
2.7.4
