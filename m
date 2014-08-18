Return-Path: <paulus@samba.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5FBE11A003D
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Aug 2014 22:13:35 +1000 (EST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id E8F3E1400A8
 for <linuxppc-dev@ozlabs.org>; Mon, 18 Aug 2014 22:13:34 +1000 (EST)
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/3] powerpc: Split out instruction analysis part of
 emulate_step()
Date: Mon, 18 Aug 2014 22:13:10 +1000
Message-Id: <1408363992-7929-2-git-send-email-paulus@samba.org>
In-Reply-To: <1408363992-7929-1-git-send-email-paulus@samba.org>
References: <1408363992-7929-1-git-send-email-paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This splits out the instruction analysis part of emulate_step() into
a separate analyse_instr() function, which decodes the instruction,
but doesn't execute any load or store instructions.  It does execute
integer instructions and branches which can be executed purely by
updating register values in the pt_regs struct.  For other instructions,
it returns the instruction type and other details in a new
instruction_op struct.  emulate_step() then uses that information
to execute loads, stores, cache operations, mfmsr, mtmsr[d], and
(on 64-bit) sc instructions.

The reason for doing this is so that the KVM code can use it instead
of having its own separate instruction emulation code.  Possibly the
alignment interrupt handler could also use this.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/include/asm/sstep.h |  61 +++
 arch/powerpc/lib/sstep.c         | 893 +++++++++++++++++++++++----------------
 2 files changed, 594 insertions(+), 360 deletions(-)

diff --git a/arch/powerpc/include/asm/sstep.h b/arch/powerpc/include/asm/sstep.h
index f593b0f..1a693b1 100644
--- a/arch/powerpc/include/asm/sstep.h
+++ b/arch/powerpc/include/asm/sstep.h
@@ -25,3 +25,64 @@ struct pt_regs;
 
 /* Emulate instructions that cause a transfer of control. */
 extern int emulate_step(struct pt_regs *regs, unsigned int instr);
+
+enum instruction_type {
+	COMPUTE,		/* arith/logical/CR op, etc. */
+	LOAD,
+	LOAD_MULTI,
+	LOAD_FP,
+	LOAD_VMX,
+	LOAD_VSX,
+	STORE,
+	STORE_MULTI,
+	STORE_FP,
+	STORE_VMX,
+	STORE_VSX,
+	LARX,
+	STCX,
+	BRANCH,
+	MFSPR,
+	MTSPR,
+	CACHEOP,
+	BARRIER,
+	SYSCALL,
+	MFMSR,
+	MTMSR,
+	RFI,
+	INTERRUPT,
+	UNKNOWN
+};
+
+#define INSTR_TYPE_MASK	0x1f
+
+/* Load/store flags, ORed in with type */
+#define SIGNEXT		0x20
+#define UPDATE		0x40	/* matches bit in opcode 31 instructions */
+#define BYTEREV		0x80
+
+/* Cacheop values, ORed in with type */
+#define CACHEOP_MASK	0x700
+#define DCBST		0
+#define DCBF		0x100
+#define DCBTST		0x200
+#define DCBT		0x300
+
+/* Size field in type word */
+#define SIZE(n)		((n) << 8)
+#define GETSIZE(w)	((w) >> 8)
+
+#define MKOP(t, f, s)	((t) | (f) | SIZE(s))
+
+struct instruction_op {
+	int type;
+	int reg;
+	unsigned long val;
+	/* For LOAD/STORE/LARX/STCX */
+	unsigned long ea;
+	int update_reg;
+	/* For MFSPR */
+	int spr;
+};
+
+extern int analyse_instr(struct instruction_op *op, struct pt_regs *regs,
+			 unsigned int instr);
diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
index 5c09f36..4f2a7d0 100644
--- a/arch/powerpc/lib/sstep.c
+++ b/arch/powerpc/lib/sstep.c
@@ -98,13 +98,8 @@ static unsigned long __kprobes dform_ea(unsigned int instr, struct pt_regs *regs
 
 	ra = (instr >> 16) & 0x1f;
 	ea = (signed short) instr;		/* sign-extend */
-	if (ra) {
+	if (ra)
 		ea += regs->gpr[ra];
-		if (instr & 0x04000000) {		/* update forms */
-			if ((instr>>26) != 47) 		/* stmw is not an update form */
-				regs->gpr[ra] = ea;
-		}
-	}
 
 	return truncate_if_32bit(regs->msr, ea);
 }
@@ -120,11 +115,8 @@ static unsigned long __kprobes dsform_ea(unsigned int instr, struct pt_regs *reg
 
 	ra = (instr >> 16) & 0x1f;
 	ea = (signed short) (instr & ~3);	/* sign-extend */
-	if (ra) {
+	if (ra)
 		ea += regs->gpr[ra];
-		if ((instr & 3) == 1)		/* update forms */
-			regs->gpr[ra] = ea;
-	}
 
 	return truncate_if_32bit(regs->msr, ea);
 }
@@ -133,8 +125,8 @@ static unsigned long __kprobes dsform_ea(unsigned int instr, struct pt_regs *reg
 /*
  * Calculate effective address for an X-form instruction
  */
-static unsigned long __kprobes xform_ea(unsigned int instr, struct pt_regs *regs,
-				     int do_update)
+static unsigned long __kprobes xform_ea(unsigned int instr,
+					struct pt_regs *regs)
 {
 	int ra, rb;
 	unsigned long ea;
@@ -142,11 +134,8 @@ static unsigned long __kprobes xform_ea(unsigned int instr, struct pt_regs *regs
 	ra = (instr >> 16) & 0x1f;
 	rb = (instr >> 11) & 0x1f;
 	ea = regs->gpr[rb];
-	if (ra) {
+	if (ra)
 		ea += regs->gpr[ra];
-		if (do_update)		/* update forms */
-			regs->gpr[ra] = ea;
-	}
 
 	return truncate_if_32bit(regs->msr, ea);
 }
@@ -627,26 +616,27 @@ static void __kprobes do_cmp_unsigned(struct pt_regs *regs, unsigned long v1,
 #define ROTATE(x, n)	((n) ? (((x) << (n)) | ((x) >> (8 * sizeof(long) - (n)))) : (x))
 
 /*
- * Emulate instructions that cause a transfer of control,
- * loads and stores, and a few other instructions.
- * Returns 1 if the step was emulated, 0 if not,
- * or -1 if the instruction is one that should not be stepped,
- * such as an rfid, or a mtmsrd that would clear MSR_RI.
+ * Decode an instruction, and execute it if that can be done just by
+ * modifying *regs (i.e. integer arithmetic and logical instructions,
+ * branches, and barrier instructions).
+ * Returns 1 if the instruction has been executed, or 0 if not.
+ * Sets *op to indicate what the instruction does.
  */
-int __kprobes emulate_step(struct pt_regs *regs, unsigned int instr)
+int __kprobes analyse_instr(struct instruction_op *op, struct pt_regs *regs,
+			    unsigned int instr)
 {
 	unsigned int opcode, ra, rb, rd, spr, u;
 	unsigned long int imm;
 	unsigned long int val, val2;
-	unsigned long int ea;
-	unsigned int cr, mb, me, sh;
-	int err;
-	unsigned long old_ra, val3;
+	unsigned int mb, me, sh;
 	long ival;
 
+	op->type = COMPUTE;
+
 	opcode = instr >> 26;
 	switch (opcode) {
 	case 16:	/* bc */
+		op->type = BRANCH;
 		imm = (signed short)(instr & 0xfffc);
 		if ((instr & 2) == 0)
 			imm += regs->nip;
@@ -659,26 +649,14 @@ int __kprobes emulate_step(struct pt_regs *regs, unsigned int instr)
 		return 1;
 #ifdef CONFIG_PPC64
 	case 17:	/* sc */
-		/*
-		 * N.B. this uses knowledge about how the syscall
-		 * entry code works.  If that is changed, this will
-		 * need to be changed also.
-		 */
-		if (regs->gpr[0] == 0x1ebe &&
-		    cpu_has_feature(CPU_FTR_REAL_LE)) {
-			regs->msr ^= MSR_LE;
-			goto instr_done;
-		}
-		regs->gpr[9] = regs->gpr[13];
-		regs->gpr[10] = MSR_KERNEL;
-		regs->gpr[11] = regs->nip + 4;
-		regs->gpr[12] = regs->msr & MSR_MASK;
-		regs->gpr[13] = (unsigned long) get_paca();
-		regs->nip = (unsigned long) &system_call_common;
-		regs->msr = MSR_KERNEL;
-		return 1;
+		if ((instr & 0xfe2) == 2)
+			op->type = SYSCALL;
+		else
+			op->type = UNKNOWN;
+		return 0;
 #endif
 	case 18:	/* b */
+		op->type = BRANCH;
 		imm = instr & 0x03fffffc;
 		if (imm & 0x02000000)
 			imm -= 0x04000000;
@@ -693,6 +671,7 @@ int __kprobes emulate_step(struct pt_regs *regs, unsigned int instr)
 		switch ((instr >> 1) & 0x3ff) {
 		case 16:	/* bclr */
 		case 528:	/* bcctr */
+			op->type = BRANCH;
 			imm = (instr & 0x400)? regs->ctr: regs->link;
 			regs->nip = truncate_if_32bit(regs->msr, regs->nip + 4);
 			imm = truncate_if_32bit(regs->msr, imm);
@@ -703,9 +682,13 @@ int __kprobes emulate_step(struct pt_regs *regs, unsigned int instr)
 			return 1;
 
 		case 18:	/* rfid, scary */
-			return -1;
+			if (regs->msr & MSR_PR)
+				goto priv;
+			op->type = RFI;
+			return 0;
 
 		case 150:	/* isync */
+			op->type = BARRIER;
 			isync();
 			goto instr_done;
 
@@ -731,6 +714,7 @@ int __kprobes emulate_step(struct pt_regs *regs, unsigned int instr)
 	case 31:
 		switch ((instr >> 1) & 0x3ff) {
 		case 598:	/* sync */
+			op->type = BARRIER;
 #ifdef __powerpc64__
 			switch ((instr >> 21) & 3) {
 			case 1:		/* lwsync */
@@ -745,6 +729,7 @@ int __kprobes emulate_step(struct pt_regs *regs, unsigned int instr)
 			goto instr_done;
 
 		case 854:	/* eieio */
+			op->type = BARRIER;
 			eieio();
 			goto instr_done;
 		}
@@ -910,33 +895,30 @@ int __kprobes emulate_step(struct pt_regs *regs, unsigned int instr)
 		switch ((instr >> 1) & 0x3ff) {
 		case 83:	/* mfmsr */
 			if (regs->msr & MSR_PR)
-				break;
-			regs->gpr[rd] = regs->msr & MSR_MASK;
-			goto instr_done;
+				goto priv;
+			op->type = MFMSR;
+			op->reg = rd;
+			return 0;
 		case 146:	/* mtmsr */
 			if (regs->msr & MSR_PR)
-				break;
-			imm = regs->gpr[rd];
-			if ((imm & MSR_RI) == 0)
-				/* can't step mtmsr that would clear MSR_RI */
-				return -1;
-			regs->msr = imm;
-			goto instr_done;
+				goto priv;
+			op->type = MTMSR;
+			op->reg = rd;
+			op->val = 0xffffffff & ~(MSR_ME | MSR_LE);
+			return 0;
 #ifdef CONFIG_PPC64
 		case 178:	/* mtmsrd */
-			/* only MSR_EE and MSR_RI get changed if bit 15 set */
-			/* mtmsrd doesn't change MSR_HV and MSR_ME */
 			if (regs->msr & MSR_PR)
-				break;
-			imm = (instr & 0x10000)? 0x8002: 0xefffffffffffefffUL;
-			imm = (regs->msr & MSR_MASK & ~imm)
-				| (regs->gpr[rd] & imm);
-			if ((imm & MSR_RI) == 0)
-				/* can't step mtmsrd that would clear MSR_RI */
-				return -1;
-			regs->msr = imm;
-			goto instr_done;
+				goto priv;
+			op->type = MTMSR;
+			op->reg = rd;
+			/* only MSR_EE and MSR_RI get changed if bit 15 set */
+			/* mtmsrd doesn't change MSR_HV, MSR_ME or MSR_LE */
+			imm = (instr & 0x10000)? 0x8002: 0xefffffffffffeffeUL;
+			op->val = imm;
+			return 0;
 #endif
+
 		case 19:	/* mfcr */
 			regs->gpr[rd] = regs->ccr;
 			regs->gpr[rd] &= 0xffffffffUL;
@@ -954,33 +936,43 @@ int __kprobes emulate_step(struct pt_regs *regs, unsigned int instr)
 			goto instr_done;
 
 		case 339:	/* mfspr */
-			spr = (instr >> 11) & 0x3ff;
+			spr = ((instr >> 16) & 0x1f) | ((instr >> 6) & 0x3e0);
 			switch (spr) {
-			case 0x20:	/* mfxer */
+			case SPRN_XER:	/* mfxer */
 				regs->gpr[rd] = regs->xer;
 				regs->gpr[rd] &= 0xffffffffUL;
 				goto instr_done;
-			case 0x100:	/* mflr */
+			case SPRN_LR:	/* mflr */
 				regs->gpr[rd] = regs->link;
 				goto instr_done;
-			case 0x120:	/* mfctr */
+			case SPRN_CTR:	/* mfctr */
 				regs->gpr[rd] = regs->ctr;
 				goto instr_done;
+			default:
+				op->type = MFSPR;
+				op->reg = rd;
+				op->spr = spr;
+				return 0;
 			}
 			break;
 
 		case 467:	/* mtspr */
-			spr = (instr >> 11) & 0x3ff;
+			spr = ((instr >> 16) & 0x1f) | ((instr >> 6) & 0x3e0);
 			switch (spr) {
-			case 0x20:	/* mtxer */
+			case SPRN_XER:	/* mtxer */
 				regs->xer = (regs->gpr[rd] & 0xffffffffUL);
 				goto instr_done;
-			case 0x100:	/* mtlr */
+			case SPRN_LR:	/* mtlr */
 				regs->link = regs->gpr[rd];
 				goto instr_done;
-			case 0x120:	/* mtctr */
+			case SPRN_CTR:	/* mtctr */
 				regs->ctr = regs->gpr[rd];
 				goto instr_done;
+			default:
+				op->type = MTSPR;
+				op->val = regs->gpr[rd];
+				op->spr = spr;
+				return 0;
 			}
 			break;
 
@@ -1257,294 +1249,210 @@ int __kprobes emulate_step(struct pt_regs *regs, unsigned int instr)
  * Cache instructions
  */
 		case 54:	/* dcbst */
-			ea = xform_ea(instr, regs, 0);
-			if (!address_ok(regs, ea, 8))
-				return 0;
-			err = 0;
-			__cacheop_user_asmx(ea, err, "dcbst");
-			if (err)
-				return 0;
-			goto instr_done;
+			op->type = MKOP(CACHEOP, DCBST, 0);
+			op->ea = xform_ea(instr, regs);
+			return 0;
 
 		case 86:	/* dcbf */
-			ea = xform_ea(instr, regs, 0);
-			if (!address_ok(regs, ea, 8))
-				return 0;
-			err = 0;
-			__cacheop_user_asmx(ea, err, "dcbf");
-			if (err)
-				return 0;
-			goto instr_done;
+			op->type = MKOP(CACHEOP, DCBF, 0);
+			op->ea = xform_ea(instr, regs);
+			return 0;
 
 		case 246:	/* dcbtst */
-			if (rd == 0) {
-				ea = xform_ea(instr, regs, 0);
-				prefetchw((void *) ea);
-			}
-			goto instr_done;
+			op->type = MKOP(CACHEOP, DCBTST, 0);
+			op->ea = xform_ea(instr, regs);
+			op->reg = rd;
+			return 0;
 
 		case 278:	/* dcbt */
-			if (rd == 0) {
-				ea = xform_ea(instr, regs, 0);
-				prefetch((void *) ea);
-			}
-			goto instr_done;
-
+			op->type = MKOP(CACHEOP, DCBTST, 0);
+			op->ea = xform_ea(instr, regs);
+			op->reg = rd;
+			return 0;
 		}
 		break;
 	}
 
 	/*
-	 * Following cases are for loads and stores, so bail out
-	 * if we're in little-endian mode.
+	 * Loads and stores.
 	 */
-	if (regs->msr & MSR_LE)
-		return 0;
-
-	/*
-	 * Save register RA in case it's an update form load or store
-	 * and the access faults.
-	 */
-	old_ra = regs->gpr[ra];
+	op->type = UNKNOWN;
+	op->update_reg = ra;
+	op->reg = rd;
+	op->val = regs->gpr[rd];
+	u = (instr >> 20) & UPDATE;
 
 	switch (opcode) {
 	case 31:
-		u = instr & 0x40;
+		u = instr & UPDATE;
+		op->ea = xform_ea(instr, regs);
 		switch ((instr >> 1) & 0x3ff) {
 		case 20:	/* lwarx */
-			ea = xform_ea(instr, regs, 0);
-			if (ea & 3)
-				break;		/* can't handle misaligned */
-			err = -EFAULT;
-			if (!address_ok(regs, ea, 4))
-				goto ldst_done;
-			err = 0;
-			__get_user_asmx(val, ea, err, "lwarx");
-			if (!err)
-				regs->gpr[rd] = val;
-			goto ldst_done;
+			op->type = MKOP(LARX, 0, 4);
+			break;
 
 		case 150:	/* stwcx. */
-			ea = xform_ea(instr, regs, 0);
-			if (ea & 3)
-				break;		/* can't handle misaligned */
-			err = -EFAULT;
-			if (!address_ok(regs, ea, 4))
-				goto ldst_done;
-			err = 0;
-			__put_user_asmx(regs->gpr[rd], ea, err, "stwcx.", cr);
-			if (!err)
-				regs->ccr = (regs->ccr & 0x0fffffff) |
-					(cr & 0xe0000000) |
-					((regs->xer >> 3) & 0x10000000);
-			goto ldst_done;
+			op->type = MKOP(STCX, 0, 4);
+			break;
 
 #ifdef __powerpc64__
 		case 84:	/* ldarx */
-			ea = xform_ea(instr, regs, 0);
-			if (ea & 7)
-				break;		/* can't handle misaligned */
-			err = -EFAULT;
-			if (!address_ok(regs, ea, 8))
-				goto ldst_done;
-			err = 0;
-			__get_user_asmx(val, ea, err, "ldarx");
-			if (!err)
-				regs->gpr[rd] = val;
-			goto ldst_done;
+			op->type = MKOP(LARX, 0, 8);
+			break;
 
 		case 214:	/* stdcx. */
-			ea = xform_ea(instr, regs, 0);
-			if (ea & 7)
-				break;		/* can't handle misaligned */
-			err = -EFAULT;
-			if (!address_ok(regs, ea, 8))
-				goto ldst_done;
-			err = 0;
-			__put_user_asmx(regs->gpr[rd], ea, err, "stdcx.", cr);
-			if (!err)
-				regs->ccr = (regs->ccr & 0x0fffffff) |
-					(cr & 0xe0000000) |
-					((regs->xer >> 3) & 0x10000000);
-			goto ldst_done;
+			op->type = MKOP(STCX, 0, 8);
+			break;
 
 		case 21:	/* ldx */
 		case 53:	/* ldux */
-			err = read_mem(&regs->gpr[rd], xform_ea(instr, regs, u),
-				       8, regs);
-			goto ldst_done;
+			op->type = MKOP(LOAD, u, 8);
+			break;
 #endif
 
 		case 23:	/* lwzx */
 		case 55:	/* lwzux */
-			err = read_mem(&regs->gpr[rd], xform_ea(instr, regs, u),
-				       4, regs);
-			goto ldst_done;
+			op->type = MKOP(LOAD, u, 4);
+			break;
 
 		case 87:	/* lbzx */
 		case 119:	/* lbzux */
-			err = read_mem(&regs->gpr[rd], xform_ea(instr, regs, u),
-				       1, regs);
-			goto ldst_done;
+			op->type = MKOP(LOAD, u, 1);
+			break;
 
 #ifdef CONFIG_ALTIVEC
 		case 103:	/* lvx */
 		case 359:	/* lvxl */
 			if (!(regs->msr & MSR_VEC))
-				break;
-			ea = xform_ea(instr, regs, 0);
-			err = do_vec_load(rd, do_lvx, ea, regs);
-			goto ldst_done;
+				goto vecunavail;
+			op->type = MKOP(LOAD_VMX, 0, 16);
+			break;
 
 		case 231:	/* stvx */
 		case 487:	/* stvxl */
 			if (!(regs->msr & MSR_VEC))
-				break;
-			ea = xform_ea(instr, regs, 0);
-			err = do_vec_store(rd, do_stvx, ea, regs);
-			goto ldst_done;
+				goto vecunavail;
+			op->type = MKOP(STORE_VMX, 0, 16);
+			break;
 #endif /* CONFIG_ALTIVEC */
 
 #ifdef __powerpc64__
 		case 149:	/* stdx */
 		case 181:	/* stdux */
-			val = regs->gpr[rd];
-			err = write_mem(val, xform_ea(instr, regs, u), 8, regs);
-			goto ldst_done;
+			op->type = MKOP(STORE, u, 8);
+			break;
 #endif
 
 		case 151:	/* stwx */
 		case 183:	/* stwux */
-			val = regs->gpr[rd];
-			err = write_mem(val, xform_ea(instr, regs, u), 4, regs);
-			goto ldst_done;
+			op->type = MKOP(STORE, u, 4);
+			break;
 
 		case 215:	/* stbx */
 		case 247:	/* stbux */
-			val = regs->gpr[rd];
-			err = write_mem(val, xform_ea(instr, regs, u), 1, regs);
-			goto ldst_done;
+			op->type = MKOP(STORE, u, 1);
+			break;
 
 		case 279:	/* lhzx */
 		case 311:	/* lhzux */
-			err = read_mem(&regs->gpr[rd], xform_ea(instr, regs, u),
-				       2, regs);
-			goto ldst_done;
+			op->type = MKOP(LOAD, u, 2);
+			break;
 
 #ifdef __powerpc64__
 		case 341:	/* lwax */
 		case 373:	/* lwaux */
-			err = read_mem(&regs->gpr[rd], xform_ea(instr, regs, u),
-				       4, regs);
-			if (!err)
-				regs->gpr[rd] = (signed int) regs->gpr[rd];
-			goto ldst_done;
+			op->type = MKOP(LOAD, SIGNEXT | u, 4);
+			break;
 #endif
 
 		case 343:	/* lhax */
 		case 375:	/* lhaux */
-			err = read_mem(&regs->gpr[rd], xform_ea(instr, regs, u),
-				       2, regs);
-			if (!err)
-				regs->gpr[rd] = (signed short) regs->gpr[rd];
-			goto ldst_done;
+			op->type = MKOP(LOAD, SIGNEXT | u, 2);
+			break;
 
 		case 407:	/* sthx */
 		case 439:	/* sthux */
-			val = regs->gpr[rd];
-			err = write_mem(val, xform_ea(instr, regs, u), 2, regs);
-			goto ldst_done;
+			op->type = MKOP(STORE, u, 2);
+			break;
 
 #ifdef __powerpc64__
 		case 532:	/* ldbrx */
-			err = read_mem(&val, xform_ea(instr, regs, 0), 8, regs);
-			if (!err)
-				regs->gpr[rd] = byterev_8(val);
-			goto ldst_done;
+			op->type = MKOP(LOAD, BYTEREV, 8);
+			break;
 
 #endif
 
 		case 534:	/* lwbrx */
-			err = read_mem(&val, xform_ea(instr, regs, 0), 4, regs);
-			if (!err)
-				regs->gpr[rd] = byterev_4(val);
-			goto ldst_done;
+			op->type = MKOP(LOAD, BYTEREV, 4);
+			break;
 
 #ifdef CONFIG_PPC_FPU
 		case 535:	/* lfsx */
 		case 567:	/* lfsux */
 			if (!(regs->msr & MSR_FP))
-				break;
-			ea = xform_ea(instr, regs, u);
-			err = do_fp_load(rd, do_lfs, ea, 4, regs);
-			goto ldst_done;
+				goto fpunavail;
+			op->type = MKOP(LOAD_FP, u, 4);
+			break;
 
 		case 599:	/* lfdx */
 		case 631:	/* lfdux */
 			if (!(regs->msr & MSR_FP))
-				break;
-			ea = xform_ea(instr, regs, u);
-			err = do_fp_load(rd, do_lfd, ea, 8, regs);
-			goto ldst_done;
+				goto fpunavail;
+			op->type = MKOP(LOAD_FP, u, 8);
+			break;
 
 		case 663:	/* stfsx */
 		case 695:	/* stfsux */
 			if (!(regs->msr & MSR_FP))
-				break;
-			ea = xform_ea(instr, regs, u);
-			err = do_fp_store(rd, do_stfs, ea, 4, regs);
-			goto ldst_done;
+				goto fpunavail;
+			op->type = MKOP(STORE_FP, u, 4);
+			break;
 
 		case 727:	/* stfdx */
 		case 759:	/* stfdux */
 			if (!(regs->msr & MSR_FP))
-				break;
-			ea = xform_ea(instr, regs, u);
-			err = do_fp_store(rd, do_stfd, ea, 8, regs);
-			goto ldst_done;
+				goto fpunavail;
+			op->type = MKOP(STORE_FP, u, 8);
+			break;
 #endif
 
 #ifdef __powerpc64__
 		case 660:	/* stdbrx */
-			val = byterev_8(regs->gpr[rd]);
-			err = write_mem(val, xform_ea(instr, regs, 0), 8, regs);
-			goto ldst_done;
+			op->type = MKOP(STORE, BYTEREV, 8);
+			op->val = byterev_8(regs->gpr[rd]);
+			break;
 
 #endif
 		case 662:	/* stwbrx */
-			val = byterev_4(regs->gpr[rd]);
-			err = write_mem(val, xform_ea(instr, regs, 0), 4, regs);
-			goto ldst_done;
+			op->type = MKOP(STORE, BYTEREV, 4);
+			op->val = byterev_4(regs->gpr[rd]);
+			break;
 
 		case 790:	/* lhbrx */
-			err = read_mem(&val, xform_ea(instr, regs, 0), 2, regs);
-			if (!err)
-				regs->gpr[rd] = byterev_2(val);
-			goto ldst_done;
+			op->type = MKOP(LOAD, BYTEREV, 2);
+			break;
 
 		case 918:	/* sthbrx */
-			val = byterev_2(regs->gpr[rd]);
-			err = write_mem(val, xform_ea(instr, regs, 0), 2, regs);
-			goto ldst_done;
+			op->type = MKOP(STORE, BYTEREV, 2);
+			op->val = byterev_2(regs->gpr[rd]);
+			break;
 
 #ifdef CONFIG_VSX
 		case 844:	/* lxvd2x */
 		case 876:	/* lxvd2ux */
 			if (!(regs->msr & MSR_VSX))
-				break;
-			rd |= (instr & 1) << 5;
-			ea = xform_ea(instr, regs, u);
-			err = do_vsx_load(rd, do_lxvd2x, ea, regs);
-			goto ldst_done;
+				goto vsxunavail;
+			op->reg = rd | ((instr & 1) << 5);
+			op->type = MKOP(LOAD_VSX, u, 16);
+			break;
 
 		case 972:	/* stxvd2x */
 		case 1004:	/* stxvd2ux */
 			if (!(regs->msr & MSR_VSX))
-				break;
-			rd |= (instr & 1) << 5;
-			ea = xform_ea(instr, regs, u);
-			err = do_vsx_store(rd, do_stxvd2x, ea, regs);
-			goto ldst_done;
+				goto vsxunavail;
+			op->reg = rd | ((instr & 1) << 5);
+			op->type = MKOP(STORE_VSX, u, 16);
+			break;
 
 #endif /* CONFIG_VSX */
 		}
@@ -1552,178 +1460,124 @@ int __kprobes emulate_step(struct pt_regs *regs, unsigned int instr)
 
 	case 32:	/* lwz */
 	case 33:	/* lwzu */
-		err = read_mem(&regs->gpr[rd], dform_ea(instr, regs), 4, regs);
-		goto ldst_done;
+		op->type = MKOP(LOAD, u, 4);
+		op->ea = dform_ea(instr, regs);
+		break;
 
 	case 34:	/* lbz */
 	case 35:	/* lbzu */
-		err = read_mem(&regs->gpr[rd], dform_ea(instr, regs), 1, regs);
-		goto ldst_done;
+		op->type = MKOP(LOAD, u, 1);
+		op->ea = dform_ea(instr, regs);
+		break;
 
 	case 36:	/* stw */
-		val = regs->gpr[rd];
-		err = write_mem(val, dform_ea(instr, regs), 4, regs);
-		goto ldst_done;
-
 	case 37:	/* stwu */
-		val = regs->gpr[rd];
-		val3 = dform_ea(instr, regs);
-		/*
-		 * For PPC32 we always use stwu to change stack point with r1. So
-		 * this emulated store may corrupt the exception frame, now we
-		 * have to provide the exception frame trampoline, which is pushed
-		 * below the kprobed function stack. So we only update gpr[1] but
-		 * don't emulate the real store operation. We will do real store
-		 * operation safely in exception return code by checking this flag.
-		 */
-		if ((ra == 1) && !(regs->msr & MSR_PR) \
-			&& (val3 >= (regs->gpr[1] - STACK_INT_FRAME_SIZE))) {
-#ifdef CONFIG_PPC32
-			/*
-			 * Check if we will touch kernel sack overflow
-			 */
-			if (val3 - STACK_INT_FRAME_SIZE <= current->thread.ksp_limit) {
-				printk(KERN_CRIT "Can't kprobe this since Kernel stack overflow.\n");
-				err = -EINVAL;
-				break;
-			}
-#endif /* CONFIG_PPC32 */
-			/*
-			 * Check if we already set since that means we'll
-			 * lose the previous value.
-			 */
-			WARN_ON(test_thread_flag(TIF_EMULATE_STACK_STORE));
-			set_thread_flag(TIF_EMULATE_STACK_STORE);
-			err = 0;
-		} else
-			err = write_mem(val, val3, 4, regs);
-		goto ldst_done;
+		op->type = MKOP(STORE, u, 4);
+		op->ea = dform_ea(instr, regs);
+		break;
 
 	case 38:	/* stb */
 	case 39:	/* stbu */
-		val = regs->gpr[rd];
-		err = write_mem(val, dform_ea(instr, regs), 1, regs);
-		goto ldst_done;
+		op->type = MKOP(STORE, u, 1);
+		op->ea = dform_ea(instr, regs);
+		break;
 
 	case 40:	/* lhz */
 	case 41:	/* lhzu */
-		err = read_mem(&regs->gpr[rd], dform_ea(instr, regs), 2, regs);
-		goto ldst_done;
+		op->type = MKOP(LOAD, u, 2);
+		op->ea = dform_ea(instr, regs);
+		break;
 
 	case 42:	/* lha */
 	case 43:	/* lhau */
-		err = read_mem(&regs->gpr[rd], dform_ea(instr, regs), 2, regs);
-		if (!err)
-			regs->gpr[rd] = (signed short) regs->gpr[rd];
-		goto ldst_done;
+		op->type = MKOP(LOAD, SIGNEXT | u, 2);
+		op->ea = dform_ea(instr, regs);
+		break;
 
 	case 44:	/* sth */
 	case 45:	/* sthu */
-		val = regs->gpr[rd];
-		err = write_mem(val, dform_ea(instr, regs), 2, regs);
-		goto ldst_done;
+		op->type = MKOP(STORE, u, 2);
+		op->ea = dform_ea(instr, regs);
+		break;
 
 	case 46:	/* lmw */
 		ra = (instr >> 16) & 0x1f;
 		if (ra >= rd)
 			break;		/* invalid form, ra in range to load */
-		ea = dform_ea(instr, regs);
-		do {
-			err = read_mem(&regs->gpr[rd], ea, 4, regs);
-			if (err)
-				return 0;
-			ea += 4;
-		} while (++rd < 32);
-		goto instr_done;
+		op->type = MKOP(LOAD_MULTI, 0, 4);
+		op->ea = dform_ea(instr, regs);
+		break;
 
 	case 47:	/* stmw */
-		ea = dform_ea(instr, regs);
-		do {
-			err = write_mem(regs->gpr[rd], ea, 4, regs);
-			if (err)
-				return 0;
-			ea += 4;
-		} while (++rd < 32);
-		goto instr_done;
+		op->type = MKOP(STORE_MULTI, 0, 4);
+		op->ea = dform_ea(instr, regs);
+		break;
 
 #ifdef CONFIG_PPC_FPU
 	case 48:	/* lfs */
 	case 49:	/* lfsu */
 		if (!(regs->msr & MSR_FP))
-			break;
-		ea = dform_ea(instr, regs);
-		err = do_fp_load(rd, do_lfs, ea, 4, regs);
-		goto ldst_done;
+			goto fpunavail;
+		op->type = MKOP(LOAD_FP, u, 4);
+		op->ea = dform_ea(instr, regs);
+		break;
 
 	case 50:	/* lfd */
 	case 51:	/* lfdu */
 		if (!(regs->msr & MSR_FP))
-			break;
-		ea = dform_ea(instr, regs);
-		err = do_fp_load(rd, do_lfd, ea, 8, regs);
-		goto ldst_done;
+			goto fpunavail;
+		op->type = MKOP(LOAD_FP, u, 8);
+		op->ea = dform_ea(instr, regs);
+		break;
 
 	case 52:	/* stfs */
 	case 53:	/* stfsu */
 		if (!(regs->msr & MSR_FP))
-			break;
-		ea = dform_ea(instr, regs);
-		err = do_fp_store(rd, do_stfs, ea, 4, regs);
-		goto ldst_done;
+			goto fpunavail;
+		op->type = MKOP(STORE_FP, u, 4);
+		op->ea = dform_ea(instr, regs);
+		break;
 
 	case 54:	/* stfd */
 	case 55:	/* stfdu */
 		if (!(regs->msr & MSR_FP))
-			break;
-		ea = dform_ea(instr, regs);
-		err = do_fp_store(rd, do_stfd, ea, 8, regs);
-		goto ldst_done;
+			goto fpunavail;
+		op->type = MKOP(STORE_FP, u, 8);
+		op->ea = dform_ea(instr, regs);
+		break;
 #endif
 
 #ifdef __powerpc64__
 	case 58:	/* ld[u], lwa */
+		op->ea = dsform_ea(instr, regs);
 		switch (instr & 3) {
 		case 0:		/* ld */
-			err = read_mem(&regs->gpr[rd], dsform_ea(instr, regs),
-				       8, regs);
-			goto ldst_done;
+			op->type = MKOP(LOAD, 0, 8);
+			break;
 		case 1:		/* ldu */
-			err = read_mem(&regs->gpr[rd], dsform_ea(instr, regs),
-				       8, regs);
-			goto ldst_done;
+			op->type = MKOP(LOAD, UPDATE, 8);
+			break;
 		case 2:		/* lwa */
-			err = read_mem(&regs->gpr[rd], dsform_ea(instr, regs),
-				       4, regs);
-			if (!err)
-				regs->gpr[rd] = (signed int) regs->gpr[rd];
-			goto ldst_done;
+			op->type = MKOP(LOAD, SIGNEXT, 4);
+			break;
 		}
 		break;
 
 	case 62:	/* std[u] */
-		val = regs->gpr[rd];
+		op->ea = dsform_ea(instr, regs);
 		switch (instr & 3) {
 		case 0:		/* std */
-			err = write_mem(val, dsform_ea(instr, regs), 8, regs);
-			goto ldst_done;
+			op->type = MKOP(STORE, 0, 8);
+			break;
 		case 1:		/* stdu */
-			err = write_mem(val, dsform_ea(instr, regs), 8, regs);
-			goto ldst_done;
+			op->type = MKOP(STORE, UPDATE, 8);
+			break;
 		}
 		break;
 #endif /* __powerpc64__ */
 
 	}
-	err = -EINVAL;
-
- ldst_done:
-	if (err) {
-		regs->gpr[ra] = old_ra;
-		return 0;	/* invoke DSI if -EFAULT? */
-	}
- instr_done:
-	regs->nip = truncate_if_32bit(regs->msr, regs->nip + 4);
-	return 1;
+	return 0;
 
  logical_done:
 	if (instr & 1)
@@ -1733,5 +1587,324 @@ int __kprobes emulate_step(struct pt_regs *regs, unsigned int instr)
  arith_done:
 	if (instr & 1)
 		set_cr0(regs, rd);
-	goto instr_done;
+
+ instr_done:
+	regs->nip = truncate_if_32bit(regs->msr, regs->nip + 4);
+	return 1;
+
+ priv:
+	op->type = INTERRUPT | 0x700;
+	op->val = SRR1_PROGPRIV;
+	return 0;
+
+#ifdef CONFIG_PPC_FPU
+ fpunavail:
+	op->type = INTERRUPT | 0x800;
+	return 0;
+#endif
+
+#ifdef CONFIG_ALTIVEC
+ vecunavail:
+	op->type = INTERRUPT | 0xf20;
+	return 0;
+#endif
+
+#ifdef CONFIG_VSX
+ vsxunavail:
+	op->type = INTERRUPT | 0xf40;
+	return 0;
+#endif
+}
+EXPORT_SYMBOL_GPL(analyse_instr);
+
+/*
+ * For PPC32 we always use stwu with r1 to change the stack pointer.
+ * So this emulated store may corrupt the exception frame, now we
+ * have to provide the exception frame trampoline, which is pushed
+ * below the kprobed function stack. So we only update gpr[1] but
+ * don't emulate the real store operation. We will do real store
+ * operation safely in exception return code by checking this flag.
+ */
+static __kprobes int handle_stack_update(unsigned long ea, struct pt_regs *regs)
+{
+#ifdef CONFIG_PPC32
+	/*
+	 * Check if we will touch kernel stack overflow
+	 */
+	if (ea - STACK_INT_FRAME_SIZE <= current->thread.ksp_limit) {
+		printk(KERN_CRIT "Can't kprobe this since kernel stack would overflow.\n");
+		return -EINVAL;
+	}
+#endif /* CONFIG_PPC32 */
+	/*
+	 * Check if we already set since that means we'll
+	 * lose the previous value.
+	 */
+	WARN_ON(test_thread_flag(TIF_EMULATE_STACK_STORE));
+	set_thread_flag(TIF_EMULATE_STACK_STORE);
+	return 0;
+}
+
+static __kprobes void do_signext(unsigned long *valp, int size)
+{
+	switch (size) {
+	case 2:
+		*valp = (signed short) *valp;
+		break;
+	case 4:
+		*valp = (signed int) *valp;
+		break;
+	}
+}
+
+static __kprobes void do_byterev(unsigned long *valp, int size)
+{
+	switch (size) {
+	case 2:
+		*valp = byterev_2(*valp);
+		break;
+	case 4:
+		*valp = byterev_4(*valp);
+		break;
+#ifdef __powerpc64__
+	case 8:
+		*valp = byterev_8(*valp);
+		break;
+#endif
+	}
+}
+
+/*
+ * Emulate instructions that cause a transfer of control,
+ * loads and stores, and a few other instructions.
+ * Returns 1 if the step was emulated, 0 if not,
+ * or -1 if the instruction is one that should not be stepped,
+ * such as an rfid, or a mtmsrd that would clear MSR_RI.
+ */
+int __kprobes emulate_step(struct pt_regs *regs, unsigned int instr)
+{
+	struct instruction_op op;
+	int r, err, size;
+	unsigned long val;
+	unsigned int cr;
+	int rd;
+
+	r = analyse_instr(&op, regs, instr);
+	if (r != 0)
+		return r;
+
+	err = 0;
+	size = GETSIZE(op.type);
+	switch (op.type & INSTR_TYPE_MASK) {
+	case CACHEOP:
+		if (!address_ok(regs, op.ea, 8))
+			return 0;
+		switch (op.type & CACHEOP_MASK) {
+		case DCBST:
+			__cacheop_user_asmx(op.ea, err, "dcbst");
+			break;
+		case DCBF:
+			__cacheop_user_asmx(op.ea, err, "dcbf");
+			break;
+		case DCBTST:
+			if (op.reg == 0)
+				prefetchw((void *) op.ea);
+			break;
+		case DCBT:
+			if (op.reg == 0)
+				prefetch((void *) op.ea);
+			break;
+		}
+		if (err)
+			return 0;
+		goto instr_done;
+
+	case LARX:
+		if (regs->msr & MSR_LE)
+			return 0;
+		if (op.ea & (size - 1))
+			break;		/* can't handle misaligned */
+		err = -EFAULT;
+		if (!address_ok(regs, op.ea, size))
+			goto ldst_done;
+		err = 0;
+		switch (size) {
+		case 4:
+			__get_user_asmx(val, op.ea, err, "lwarx");
+			break;
+		case 8:
+			__get_user_asmx(val, op.ea, err, "ldarx");
+			break;
+		default:
+			return 0;
+		}
+		if (!err)
+			regs->gpr[op.reg] = val;
+		goto ldst_done;
+
+	case STCX:
+		if (regs->msr & MSR_LE)
+			return 0;
+		if (op.ea & (size - 1))
+			break;		/* can't handle misaligned */
+		err = -EFAULT;
+		if (!address_ok(regs, op.ea, size))
+			goto ldst_done;
+		err = 0;
+		switch (size) {
+		case 4:
+			__put_user_asmx(op.val, op.ea, err, "stwcx.", cr);
+			break;
+		case 8:
+			__put_user_asmx(op.val, op.ea, err, "stdcx.", cr);
+			break;
+		default:
+			return 0;
+		}
+		if (!err)
+			regs->ccr = (regs->ccr & 0x0fffffff) |
+				(cr & 0xe0000000) |
+				((regs->xer >> 3) & 0x10000000);
+		goto ldst_done;
+
+	case LOAD:
+		if (regs->msr & MSR_LE)
+			return 0;
+		err = read_mem(&regs->gpr[op.reg], op.ea, size, regs);
+		if (!err) {
+			if (op.type & SIGNEXT)
+				do_signext(&regs->gpr[op.reg], size);
+			if (op.type & BYTEREV)
+				do_byterev(&regs->gpr[op.reg], size);
+		}
+		goto ldst_done;
+
+	case LOAD_FP:
+		if (regs->msr & MSR_LE)
+			return 0;
+		if (size == 4)
+			err = do_fp_load(op.reg, do_lfs, op.ea, size, regs);
+		else
+			err = do_fp_load(op.reg, do_lfd, op.ea, size, regs);
+		goto ldst_done;
+
+	case LOAD_VMX:
+		if (regs->msr & MSR_LE)
+			return 0;
+		err = do_vec_load(op.reg, do_lvx, op.ea & ~0xfUL, regs);
+		goto ldst_done;
+#ifdef CONFIG_VSX
+	case LOAD_VSX:
+		if (regs->msr & MSR_LE)
+			return 0;
+		err = do_vsx_load(op.reg, do_lxvd2x, op.ea, regs);
+		goto ldst_done;
+#endif
+	case LOAD_MULTI:
+		if (regs->msr & MSR_LE)
+			return 0;
+		rd = op.reg;
+		do {
+			err = read_mem(&regs->gpr[rd], op.ea, 4, regs);
+			if (err)
+				return 0;
+			op.ea += 4;
+		} while (++rd < 32);
+		goto instr_done;
+
+	case STORE:
+		if (regs->msr & MSR_LE)
+			return 0;
+		if ((op.type & UPDATE) && size == sizeof(long) &&
+		    op.reg == 1 && op.update_reg == 1 &&
+		    !(regs->msr & MSR_PR) &&
+		    op.ea >= regs->gpr[1] - STACK_INT_FRAME_SIZE) {
+			err = handle_stack_update(op.ea, regs);
+			goto ldst_done;
+		}
+		err = write_mem(op.val, op.ea, size, regs);
+		goto ldst_done;
+
+	case STORE_FP:
+		if (regs->msr & MSR_LE)
+			return 0;
+		if (size == 4)
+			err = do_fp_store(op.reg, do_stfs, op.ea, size, regs);
+		else
+			err = do_fp_store(op.reg, do_stfd, op.ea, size, regs);
+		goto ldst_done;
+
+	case STORE_VMX:
+		if (regs->msr & MSR_LE)
+			return 0;
+		err = do_vec_store(op.reg, do_stvx, op.ea & ~0xfUL, regs);
+		goto ldst_done;
+#ifdef CONFIG_VSX
+	case STORE_VSX:
+		if (regs->msr & MSR_LE)
+			return 0;
+		err = do_vsx_store(op.reg, do_stxvd2x, op.ea, regs);
+		goto ldst_done;
+#endif
+	case STORE_MULTI:
+		if (regs->msr & MSR_LE)
+			return 0;
+		rd = op.reg;
+		do {
+			err = write_mem(regs->gpr[rd], op.ea, 4, regs);
+			if (err)
+				return 0;
+			op.ea += 4;
+		} while (++rd < 32);
+		goto instr_done;
+
+	case MFMSR:
+		regs->gpr[op.reg] = regs->msr & MSR_MASK;
+		goto instr_done;
+
+	case MTMSR:
+		val = regs->gpr[op.reg];
+		if ((val & MSR_RI) == 0)
+			/* can't step mtmsr[d] that would clear MSR_RI */
+			return -1;
+		/* here op.val is the mask of bits to change */
+		regs->msr = (regs->msr & ~op.val) | (val & op.val);
+		goto instr_done;
+
+#ifdef CONFIG_PPC64
+	case SYSCALL:	/* sc */
+		/*
+		 * N.B. this uses knowledge about how the syscall
+		 * entry code works.  If that is changed, this will
+		 * need to be changed also.
+		 */
+		if (regs->gpr[0] == 0x1ebe &&
+		    cpu_has_feature(CPU_FTR_REAL_LE)) {
+			regs->msr ^= MSR_LE;
+			goto instr_done;
+		}
+		regs->gpr[9] = regs->gpr[13];
+		regs->gpr[10] = MSR_KERNEL;
+		regs->gpr[11] = regs->nip + 4;
+		regs->gpr[12] = regs->msr & MSR_MASK;
+		regs->gpr[13] = (unsigned long) get_paca();
+		regs->nip = (unsigned long) &system_call_common;
+		regs->msr = MSR_KERNEL;
+		return 1;
+
+	case RFI:
+		return -1;
+#endif
+	}
+	return 0;
+
+ ldst_done:
+	if (err)
+		return 0;
+	if (op.type & UPDATE)
+		regs->gpr[op.update_reg] = op.ea;
+
+ instr_done:
+	regs->nip = truncate_if_32bit(regs->msr, regs->nip + 4);
+	return 1;
 }
-- 
2.1.0.rc1
