Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xdrDW75gKzDrS9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Aug 2017 16:02:51 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 3xdrDW5Vq5z9sRW
 for <linuxppc-dev@ozlabs.org>; Fri, 25 Aug 2017 16:02:51 +1000 (AEST)
From: Paul Mackerras <paulus@ozlabs.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v2 10/10] powerpc/64: Fix update forms of loads and stores to
 write 64-bit EA
Date: Fri, 25 Aug 2017 15:42:02 +1000
Message-Id: <1503639722-19121-11-git-send-email-paulus@ozlabs.org>
In-Reply-To: <1503639722-19121-1-git-send-email-paulus@ozlabs.org>
References: <1503639722-19121-1-git-send-email-paulus@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When a 64-bit processor is executing in 32-bit mode, the update forms
of load and store instructions are required by the architecture to
write the full 64-bit effective address into the RA register, though
only the bottom 32 bits are used to address memory.  Currently,
the instruction emulation code writes the truncated address to the
RA register.  This fixes it by keeping the full 64-bit EA in the
instruction_op structure, truncating the address in emulate_step()
where it is used to address memory, rather than in the address
computations in analyse_instr().

Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/include/asm/sstep.h |  4 +-
 arch/powerpc/lib/sstep.c         | 99 +++++++++++++++++++++-------------------
 2 files changed, 54 insertions(+), 49 deletions(-)

diff --git a/arch/powerpc/include/asm/sstep.h b/arch/powerpc/include/asm/sstep.h
index 5a3d3d4..9bf44e2 100644
--- a/arch/powerpc/include/asm/sstep.h
+++ b/arch/powerpc/include/asm/sstep.h
@@ -25,7 +25,7 @@ struct pt_regs;
 
 enum instruction_type {
 	COMPUTE,		/* arith/logical/CR op, etc. */
-	LOAD,
+	LOAD,			/* load and store types need to be contiguous */
 	LOAD_MULTI,
 	LOAD_FP,
 	LOAD_VMX,
@@ -52,6 +52,8 @@ enum instruction_type {
 
 #define INSTR_TYPE_MASK	0x1f
 
+#define OP_IS_LOAD_STORE(type)	(LOAD <= (type) && (type) <= STCX)
+
 /* Compute flags, ORed in with type */
 #define SETREG		0x20
 #define SETCC		0x40
diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
index 7afb8ef..b8d1d46 100644
--- a/arch/powerpc/lib/sstep.c
+++ b/arch/powerpc/lib/sstep.c
@@ -125,7 +125,7 @@ static nokprobe_inline unsigned long dform_ea(unsigned int instr,
 	if (ra)
 		ea += regs->gpr[ra];
 
-	return truncate_if_32bit(regs->msr, ea);
+	return ea;
 }
 
 #ifdef __powerpc64__
@@ -143,7 +143,7 @@ static nokprobe_inline unsigned long dsform_ea(unsigned int instr,
 	if (ra)
 		ea += regs->gpr[ra];
 
-	return truncate_if_32bit(regs->msr, ea);
+	return ea;
 }
 
 /*
@@ -160,7 +160,7 @@ static nokprobe_inline unsigned long dqform_ea(unsigned int instr,
 	if (ra)
 		ea += regs->gpr[ra];
 
-	return truncate_if_32bit(regs->msr, ea);
+	return ea;
 }
 #endif /* __powerpc64 */
 
@@ -179,7 +179,7 @@ static nokprobe_inline unsigned long xform_ea(unsigned int instr,
 	if (ra)
 		ea += regs->gpr[ra];
 
-	return truncate_if_32bit(regs->msr, ea);
+	return ea;
 }
 
 /*
@@ -2007,10 +2007,7 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
 			if (rb == 0)
 				rb = 32;	/* # bytes to load */
 			op->type = MKOP(LOAD_MULTI, 0, rb);
-			op->ea = 0;
-			if (ra)
-				op->ea = truncate_if_32bit(regs->msr,
-							   regs->gpr[ra]);
+			op->ea = ra ? regs->gpr[ra] : 0;
 			break;
 
 #ifdef CONFIG_PPC_FPU
@@ -2077,10 +2074,7 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
 			if (rb == 0)
 				rb = 32;	/* # bytes to store */
 			op->type = MKOP(STORE_MULTI, 0, rb);
-			op->ea = 0;
-			if (ra)
-				op->ea = truncate_if_32bit(regs->msr,
-							   regs->gpr[ra]);
+			op->ea = ra ? regs->gpr[ra] : 0;
 			break;
 
 		case 790:	/* lhbrx */
@@ -2787,10 +2781,11 @@ void emulate_update_regs(struct pt_regs *regs, struct instruction_op *op)
 int emulate_step(struct pt_regs *regs, unsigned int instr)
 {
 	struct instruction_op op;
-	int r, err, size;
+	int r, err, size, type;
 	unsigned long val;
 	unsigned int cr;
 	int i, rd, nb;
+	unsigned long ea;
 	bool cross_endian;
 
 	r = analyse_instr(&op, regs, instr);
@@ -2803,28 +2798,36 @@ int emulate_step(struct pt_regs *regs, unsigned int instr)
 
 	err = 0;
 	size = GETSIZE(op.type);
+	type = op.type & INSTR_TYPE_MASK;
 	cross_endian = (regs->msr & MSR_LE) != (MSR_KERNEL & MSR_LE);
-	switch (op.type & INSTR_TYPE_MASK) {
+
+	ea = op.ea;
+#ifdef __powerpc64__
+	if (OP_IS_LOAD_STORE(type) || type == CACHEOP)
+		ea = truncate_if_32bit(regs->msr, op.ea);
+#endif
+
+	switch (type) {
 	case CACHEOP:
-		if (!address_ok(regs, op.ea, 8))
+		if (!address_ok(regs, ea, 8))
 			return 0;
 		switch (op.type & CACHEOP_MASK) {
 		case DCBST:
-			__cacheop_user_asmx(op.ea, err, "dcbst");
+			__cacheop_user_asmx(ea, err, "dcbst");
 			break;
 		case DCBF:
-			__cacheop_user_asmx(op.ea, err, "dcbf");
+			__cacheop_user_asmx(ea, err, "dcbf");
 			break;
 		case DCBTST:
 			if (op.reg == 0)
-				prefetchw((void *) op.ea);
+				prefetchw((void *) ea);
 			break;
 		case DCBT:
 			if (op.reg == 0)
-				prefetch((void *) op.ea);
+				prefetch((void *) ea);
 			break;
 		case ICBI:
-			__cacheop_user_asmx(op.ea, err, "icbi");
+			__cacheop_user_asmx(ea, err, "icbi");
 			break;
 		}
 		if (err)
@@ -2832,29 +2835,29 @@ int emulate_step(struct pt_regs *regs, unsigned int instr)
 		goto instr_done;
 
 	case LARX:
-		if (op.ea & (size - 1))
+		if (ea & (size - 1))
 			break;		/* can't handle misaligned */
-		if (!address_ok(regs, op.ea, size))
+		if (!address_ok(regs, ea, size))
 			return 0;
 		err = 0;
 		switch (size) {
 #ifdef __powerpc64__
 		case 1:
-			__get_user_asmx(val, op.ea, err, "lbarx");
+			__get_user_asmx(val, ea, err, "lbarx");
 			break;
 		case 2:
-			__get_user_asmx(val, op.ea, err, "lharx");
+			__get_user_asmx(val, ea, err, "lharx");
 			break;
 #endif
 		case 4:
-			__get_user_asmx(val, op.ea, err, "lwarx");
+			__get_user_asmx(val, ea, err, "lwarx");
 			break;
 #ifdef __powerpc64__
 		case 8:
-			__get_user_asmx(val, op.ea, err, "ldarx");
+			__get_user_asmx(val, ea, err, "ldarx");
 			break;
 		case 16:
-			err = do_lqarx(op.ea, &regs->gpr[op.reg]);
+			err = do_lqarx(ea, &regs->gpr[op.reg]);
 			goto ldst_done;
 #endif
 		default:
@@ -2865,29 +2868,29 @@ int emulate_step(struct pt_regs *regs, unsigned int instr)
 		goto ldst_done;
 
 	case STCX:
-		if (op.ea & (size - 1))
+		if (ea & (size - 1))
 			break;		/* can't handle misaligned */
-		if (!address_ok(regs, op.ea, size))
+		if (!address_ok(regs, ea, size))
 			return 0;
 		err = 0;
 		switch (size) {
 #ifdef __powerpc64__
 		case 1:
-			__put_user_asmx(op.val, op.ea, err, "stbcx.", cr);
+			__put_user_asmx(op.val, ea, err, "stbcx.", cr);
 			break;
 		case 2:
-			__put_user_asmx(op.val, op.ea, err, "stbcx.", cr);
+			__put_user_asmx(op.val, ea, err, "stbcx.", cr);
 			break;
 #endif
 		case 4:
-			__put_user_asmx(op.val, op.ea, err, "stwcx.", cr);
+			__put_user_asmx(op.val, ea, err, "stwcx.", cr);
 			break;
 #ifdef __powerpc64__
 		case 8:
-			__put_user_asmx(op.val, op.ea, err, "stdcx.", cr);
+			__put_user_asmx(op.val, ea, err, "stdcx.", cr);
 			break;
 		case 16:
-			err = do_stqcx(op.ea, regs->gpr[op.reg],
+			err = do_stqcx(ea, regs->gpr[op.reg],
 				       regs->gpr[op.reg + 1], &cr);
 			break;
 #endif
@@ -2903,11 +2906,11 @@ int emulate_step(struct pt_regs *regs, unsigned int instr)
 	case LOAD:
 #ifdef __powerpc64__
 		if (size == 16) {
-			err = emulate_lq(regs, op.ea, op.reg, cross_endian);
+			err = emulate_lq(regs, ea, op.reg, cross_endian);
 			goto ldst_done;
 		}
 #endif
-		err = read_mem(&regs->gpr[op.reg], op.ea, size, regs);
+		err = read_mem(&regs->gpr[op.reg], ea, size, regs);
 		if (!err) {
 			if (op.type & SIGNEXT)
 				do_signext(&regs->gpr[op.reg], size);
@@ -2918,12 +2921,12 @@ int emulate_step(struct pt_regs *regs, unsigned int instr)
 
 #ifdef CONFIG_PPC_FPU
 	case LOAD_FP:
-		err = do_fp_load(op.reg, op.ea, size, regs, cross_endian);
+		err = do_fp_load(op.reg, ea, size, regs, cross_endian);
 		goto ldst_done;
 #endif
 #ifdef CONFIG_ALTIVEC
 	case LOAD_VMX:
-		err = do_vec_load(op.reg, op.ea, size, regs, cross_endian);
+		err = do_vec_load(op.reg, ea, size, regs, cross_endian);
 		goto ldst_done;
 #endif
 #ifdef CONFIG_VSX
@@ -2939,13 +2942,13 @@ int emulate_step(struct pt_regs *regs, unsigned int instr)
 			nb = size - i;
 			if (nb > 4)
 				nb = 4;
-			err = copy_mem_in((u8 *) &v32, op.ea, nb);
+			err = copy_mem_in((u8 *) &v32, ea, nb);
 			if (err)
 				return 0;
 			if (unlikely(cross_endian))
 				v32 = byterev_4(v32);
 			regs->gpr[rd] = v32;
-			op.ea += 4;
+			ea += 4;
 			++rd;
 		}
 		goto instr_done;
@@ -2953,30 +2956,30 @@ int emulate_step(struct pt_regs *regs, unsigned int instr)
 	case STORE:
 #ifdef __powerpc64__
 		if (size == 16) {
-			err = emulate_stq(regs, op.ea, op.reg, cross_endian);
+			err = emulate_stq(regs, ea, op.reg, cross_endian);
 			goto ldst_done;
 		}
 #endif
 		if ((op.type & UPDATE) && size == sizeof(long) &&
 		    op.reg == 1 && op.update_reg == 1 &&
 		    !(regs->msr & MSR_PR) &&
-		    op.ea >= regs->gpr[1] - STACK_INT_FRAME_SIZE) {
-			err = handle_stack_update(op.ea, regs);
+		    ea >= regs->gpr[1] - STACK_INT_FRAME_SIZE) {
+			err = handle_stack_update(ea, regs);
 			goto ldst_done;
 		}
 		if (unlikely(cross_endian))
 			do_byterev(&op.val, size);
-		err = write_mem(op.val, op.ea, size, regs);
+		err = write_mem(op.val, ea, size, regs);
 		goto ldst_done;
 
 #ifdef CONFIG_PPC_FPU
 	case STORE_FP:
-		err = do_fp_store(op.reg, op.ea, size, regs, cross_endian);
+		err = do_fp_store(op.reg, ea, size, regs, cross_endian);
 		goto ldst_done;
 #endif
 #ifdef CONFIG_ALTIVEC
 	case STORE_VMX:
-		err = do_vec_store(op.reg, op.ea, size, regs, cross_endian);
+		err = do_vec_store(op.reg, ea, size, regs, cross_endian);
 		goto ldst_done;
 #endif
 #ifdef CONFIG_VSX
@@ -2994,10 +2997,10 @@ int emulate_step(struct pt_regs *regs, unsigned int instr)
 				nb = 4;
 			if (unlikely(cross_endian))
 				v32 = byterev_4(v32);
-			err = copy_mem_out((u8 *) &v32, op.ea, nb);
+			err = copy_mem_out((u8 *) &v32, ea, nb);
 			if (err)
 				return 0;
-			op.ea += 4;
+			ea += 4;
 			++rd;
 		}
 		goto instr_done;
-- 
2.7.4
