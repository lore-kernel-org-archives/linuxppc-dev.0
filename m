Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xlz6j5XShzDqjy
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Sep 2017 15:34:05 +1000 (AEST)
Date: Mon, 4 Sep 2017 15:34:02 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Implement cross-endian emulation of larx and stcx
 instructions
Message-ID: <20170904053402.GB16532@fergus.ozlabs.ibm.com>
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

This adds byte-swapping of the values loaded or stored by the
load with reservation (larx) and store conditional (stcx)
instructions when the execution environment being emulated has
the opposite endianness to the kernel.  This should have been done
in commit d955189ae427 ("powerpc: Handle opposite-endian processes
in emulation code", 2017-08-30) but was missed then.

Since op->reg is used quite frequently in emulate_loadstore(),
this puts op->reg into rd at the beginning of the function and
replaces subsequent uses of op->reg with rd.

This does not affect alignment interrupt handling, since these
instructions cannot be emulated when the address is not aligned,
because we have no way to do atomic unaligned accesses, in
general.

Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/lib/sstep.c | 47 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 30 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
index fb9f58b..0590417 100644
--- a/arch/powerpc/lib/sstep.c
+++ b/arch/powerpc/lib/sstep.c
@@ -2719,6 +2719,7 @@ int emulate_loadstore(struct pt_regs *regs, struct instruction_op *op)
 	type = op->type & INSTR_TYPE_MASK;
 	cross_endian = (regs->msr & MSR_LE) != (MSR_KERNEL & MSR_LE);
 	ea = truncate_if_32bit(regs->msr, op->ea);
+	rd = op->reg;
 
 	switch (type) {
 	case LARX:
@@ -2745,7 +2746,12 @@ int emulate_loadstore(struct pt_regs *regs, struct instruction_op *op)
 			__get_user_asmx(val, ea, err, "ldarx");
 			break;
 		case 16:
-			err = do_lqarx(ea, &regs->gpr[op->reg]);
+			err = do_lqarx(ea, &regs->gpr[rd]);
+			if (unlikely(cross_endian)) {
+				val = byterev_8(regs->gpr[rd]);
+				regs->gpr[rd] = byterev_8(regs->gpr[rd + 1]);
+				regs->gpr[rd + 1] = val;
+			}
 			break;
 #endif
 		default:
@@ -2755,8 +2761,11 @@ int emulate_loadstore(struct pt_regs *regs, struct instruction_op *op)
 			regs->dar = ea;
 			break;
 		}
-		if (size < 16)
-			regs->gpr[op->reg] = val;
+		if (size < 16) {
+			if (unlikely(cross_endian))
+				val = byterev_8(val);
+			regs->gpr[rd] = val;
+		}
 		break;
 
 	case STCX:
@@ -2764,6 +2773,8 @@ int emulate_loadstore(struct pt_regs *regs, struct instruction_op *op)
 			return -EACCES;		/* can't handle misaligned */
 		if (!address_ok(regs, ea, size))
 			return -EFAULT;
+		if (unlikely(cross_endian))
+			do_byterev(&op->val, size);
 		err = 0;
 		switch (size) {
 #ifdef __powerpc64__
@@ -2782,8 +2793,12 @@ int emulate_loadstore(struct pt_regs *regs, struct instruction_op *op)
 			__put_user_asmx(op->val, ea, err, "stdcx.", cr);
 			break;
 		case 16:
-			err = do_stqcx(ea, regs->gpr[op->reg],
-				       regs->gpr[op->reg + 1], &cr);
+			if (unlikely(cross_endian))
+				err = do_stqcx(ea, byterev_8(regs->gpr[rd + 1]),
+					       op->val, &cr);
+			else
+				err = do_stqcx(ea, op->val, regs->gpr[rd + 1],
+					       &cr);
 			break;
 #endif
 		default:
@@ -2800,16 +2815,16 @@ int emulate_loadstore(struct pt_regs *regs, struct instruction_op *op)
 	case LOAD:
 #ifdef __powerpc64__
 		if (size == 16) {
-			err = emulate_lq(regs, ea, op->reg, cross_endian);
+			err = emulate_lq(regs, ea, rd, cross_endian);
 			break;
 		}
 #endif
-		err = read_mem(&regs->gpr[op->reg], ea, size, regs);
+		err = read_mem(&regs->gpr[rd], ea, size, regs);
 		if (!err) {
 			if (op->type & SIGNEXT)
-				do_signext(&regs->gpr[op->reg], size);
+				do_signext(&regs->gpr[rd], size);
 			if ((op->type & BYTEREV) == (cross_endian ? 0 : BYTEREV))
-				do_byterev(&regs->gpr[op->reg], size);
+				do_byterev(&regs->gpr[rd], size);
 		}
 		break;
 
@@ -2830,7 +2845,7 @@ int emulate_loadstore(struct pt_regs *regs, struct instruction_op *op)
 	case LOAD_VMX:
 		if (!(regs->msr & MSR_PR) && !(regs->msr & MSR_VEC))
 			return 0;
-		err = do_vec_load(op->reg, ea, size, regs, cross_endian);
+		err = do_vec_load(rd, ea, size, regs, cross_endian);
 		break;
 #endif
 #ifdef CONFIG_VSX
@@ -2841,7 +2856,7 @@ int emulate_loadstore(struct pt_regs *regs, struct instruction_op *op)
 		 * Some VSX instructions check the MSR_VEC bit rather than MSR_VSX
 		 * when the target of the instruction is a vector register.
 		 */
-		if (op->reg >= 32 && (op->vsx_flags & VSX_CHECK_VEC))
+		if (rd >= 32 && (op->vsx_flags & VSX_CHECK_VEC))
 			msrbit = MSR_VEC;
 		if (!(regs->msr & MSR_PR) && !(regs->msr & msrbit))
 			return 0;
@@ -2852,7 +2867,6 @@ int emulate_loadstore(struct pt_regs *regs, struct instruction_op *op)
 	case LOAD_MULTI:
 		if (!address_ok(regs, ea, size))
 			return -EFAULT;
-		rd = op->reg;
 		for (i = 0; i < size; i += 4) {
 			unsigned int v32 = 0;
 
@@ -2874,12 +2888,12 @@ int emulate_loadstore(struct pt_regs *regs, struct instruction_op *op)
 	case STORE:
 #ifdef __powerpc64__
 		if (size == 16) {
-			err = emulate_stq(regs, ea, op->reg, cross_endian);
+			err = emulate_stq(regs, ea, rd, cross_endian);
 			break;
 		}
 #endif
 		if ((op->type & UPDATE) && size == sizeof(long) &&
-		    op->reg == 1 && op->update_reg == 1 &&
+		    rd == 1 && op->update_reg == 1 &&
 		    !(regs->msr & MSR_PR) &&
 		    ea >= regs->gpr[1] - STACK_INT_FRAME_SIZE) {
 			err = handle_stack_update(ea, regs);
@@ -2901,7 +2915,7 @@ int emulate_loadstore(struct pt_regs *regs, struct instruction_op *op)
 	case STORE_VMX:
 		if (!(regs->msr & MSR_PR) && !(regs->msr & MSR_VEC))
 			return 0;
-		err = do_vec_store(op->reg, ea, size, regs, cross_endian);
+		err = do_vec_store(rd, ea, size, regs, cross_endian);
 		break;
 #endif
 #ifdef CONFIG_VSX
@@ -2912,7 +2926,7 @@ int emulate_loadstore(struct pt_regs *regs, struct instruction_op *op)
 		 * Some VSX instructions check the MSR_VEC bit rather than MSR_VSX
 		 * when the target of the instruction is a vector register.
 		 */
-		if (op->reg >= 32 && (op->vsx_flags & VSX_CHECK_VEC))
+		if (rd >= 32 && (op->vsx_flags & VSX_CHECK_VEC))
 			msrbit = MSR_VEC;
 		if (!(regs->msr & MSR_PR) && !(regs->msr & msrbit))
 			return 0;
@@ -2923,7 +2937,6 @@ int emulate_loadstore(struct pt_regs *regs, struct instruction_op *op)
 	case STORE_MULTI:
 		if (!address_ok(regs, ea, size))
 			return -EFAULT;
-		rd = op->reg;
 		for (i = 0; i < size; i += 4) {
 			unsigned int v32 = regs->gpr[rd];
 
-- 
2.7.4
