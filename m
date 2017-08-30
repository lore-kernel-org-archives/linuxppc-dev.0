Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xhsYG1cRkzDqGX
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Aug 2017 14:12:50 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 3xhsYF6xrZz9sPt
 for <linuxppc-dev@ozlabs.org>; Wed, 30 Aug 2017 14:12:49 +1000 (AEST)
From: Paul Mackerras <paulus@ozlabs.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v3 03/17] powerpc: Don't check MSR FP/VMX/VSX enable bits in
 analyse_instr()
Date: Wed, 30 Aug 2017 14:12:26 +1000
Message-Id: <1504066360-30128-4-git-send-email-paulus@ozlabs.org>
In-Reply-To: <1504066360-30128-1-git-send-email-paulus@ozlabs.org>
References: <1504066360-30128-1-git-send-email-paulus@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This removes the checks for the FP/VMX/VSX enable bits in the MSR
from analyse_instr() and adds them to emulate_step() instead.

The reason for this is that we may want to use analyse_instr() in
a situation where the FP/VMX/VSX register values are stored in the
current thread_struct and the FP/VMX/VSX enable bits in the MSR
image in the pt_regs are zero.  Since analyse_instr() doesn't make
any changes to register state, it is reasonable for it to indicate
what the effect of an instruction would be even though the relevant
enable bit is off.

Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/lib/sstep.c | 54 +++++++++++-------------------------------------
 1 file changed, 12 insertions(+), 42 deletions(-)

diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
index 8e581c6..13733b7 100644
--- a/arch/powerpc/lib/sstep.c
+++ b/arch/powerpc/lib/sstep.c
@@ -1505,15 +1505,11 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
 #ifdef CONFIG_ALTIVEC
 		case 103:	/* lvx */
 		case 359:	/* lvxl */
-			if (!(regs->msr & MSR_VEC))
-				goto vecunavail;
 			op->type = MKOP(LOAD_VMX, 0, 16);
 			break;
 
 		case 231:	/* stvx */
 		case 487:	/* stvxl */
-			if (!(regs->msr & MSR_VEC))
-				goto vecunavail;
 			op->type = MKOP(STORE_VMX, 0, 16);
 			break;
 #endif /* CONFIG_ALTIVEC */
@@ -1584,29 +1580,21 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
 #ifdef CONFIG_PPC_FPU
 		case 535:	/* lfsx */
 		case 567:	/* lfsux */
-			if (!(regs->msr & MSR_FP))
-				goto fpunavail;
 			op->type = MKOP(LOAD_FP, u, 4);
 			break;
 
 		case 599:	/* lfdx */
 		case 631:	/* lfdux */
-			if (!(regs->msr & MSR_FP))
-				goto fpunavail;
 			op->type = MKOP(LOAD_FP, u, 8);
 			break;
 
 		case 663:	/* stfsx */
 		case 695:	/* stfsux */
-			if (!(regs->msr & MSR_FP))
-				goto fpunavail;
 			op->type = MKOP(STORE_FP, u, 4);
 			break;
 
 		case 727:	/* stfdx */
 		case 759:	/* stfdux */
-			if (!(regs->msr & MSR_FP))
-				goto fpunavail;
 			op->type = MKOP(STORE_FP, u, 8);
 			break;
 #endif
@@ -1649,16 +1637,12 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
 #ifdef CONFIG_VSX
 		case 844:	/* lxvd2x */
 		case 876:	/* lxvd2ux */
-			if (!(regs->msr & MSR_VSX))
-				goto vsxunavail;
 			op->reg = rd | ((instr & 1) << 5);
 			op->type = MKOP(LOAD_VSX, u, 16);
 			break;
 
 		case 972:	/* stxvd2x */
 		case 1004:	/* stxvd2ux */
-			if (!(regs->msr & MSR_VSX))
-				goto vsxunavail;
 			op->reg = rd | ((instr & 1) << 5);
 			op->type = MKOP(STORE_VSX, u, 16);
 			break;
@@ -1724,32 +1708,24 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
 #ifdef CONFIG_PPC_FPU
 	case 48:	/* lfs */
 	case 49:	/* lfsu */
-		if (!(regs->msr & MSR_FP))
-			goto fpunavail;
 		op->type = MKOP(LOAD_FP, u, 4);
 		op->ea = dform_ea(instr, regs);
 		break;
 
 	case 50:	/* lfd */
 	case 51:	/* lfdu */
-		if (!(regs->msr & MSR_FP))
-			goto fpunavail;
 		op->type = MKOP(LOAD_FP, u, 8);
 		op->ea = dform_ea(instr, regs);
 		break;
 
 	case 52:	/* stfs */
 	case 53:	/* stfsu */
-		if (!(regs->msr & MSR_FP))
-			goto fpunavail;
 		op->type = MKOP(STORE_FP, u, 4);
 		op->ea = dform_ea(instr, regs);
 		break;
 
 	case 54:	/* stfd */
 	case 55:	/* stfdu */
-		if (!(regs->msr & MSR_FP))
-			goto fpunavail;
 		op->type = MKOP(STORE_FP, u, 8);
 		op->ea = dform_ea(instr, regs);
 		break;
@@ -1812,24 +1788,6 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
 	op->type = INTERRUPT | 0x700;
 	op->val = SRR1_PROGTRAP;
 	return 0;
-
-#ifdef CONFIG_PPC_FPU
- fpunavail:
-	op->type = INTERRUPT | 0x800;
-	return 0;
-#endif
-
-#ifdef CONFIG_ALTIVEC
- vecunavail:
-	op->type = INTERRUPT | 0xf20;
-	return 0;
-#endif
-
-#ifdef CONFIG_VSX
- vsxunavail:
-	op->type = INTERRUPT | 0xf40;
-	return 0;
-#endif
 }
 EXPORT_SYMBOL_GPL(analyse_instr);
 NOKPROBE_SYMBOL(analyse_instr);
@@ -2087,6 +2045,8 @@ int emulate_step(struct pt_regs *regs, unsigned int instr)
 
 #ifdef CONFIG_PPC_FPU
 	case LOAD_FP:
+		if (!(regs->msr & MSR_FP))
+			return 0;
 		if (size == 4)
 			err = do_fp_load(op.reg, do_lfs, op.ea, size, regs);
 		else
@@ -2095,11 +2055,15 @@ int emulate_step(struct pt_regs *regs, unsigned int instr)
 #endif
 #ifdef CONFIG_ALTIVEC
 	case LOAD_VMX:
+		if (!(regs->msr & MSR_VEC))
+			return 0;
 		err = do_vec_load(op.reg, do_lvx, op.ea & ~0xfUL, regs);
 		goto ldst_done;
 #endif
 #ifdef CONFIG_VSX
 	case LOAD_VSX:
+		if (!(regs->msr & MSR_VSX))
+			return 0;
 		err = do_vsx_load(op.reg, do_lxvd2x, op.ea, regs);
 		goto ldst_done;
 #endif
@@ -2134,6 +2098,8 @@ int emulate_step(struct pt_regs *regs, unsigned int instr)
 
 #ifdef CONFIG_PPC_FPU
 	case STORE_FP:
+		if (!(regs->msr & MSR_FP))
+			return 0;
 		if (size == 4)
 			err = do_fp_store(op.reg, do_stfs, op.ea, size, regs);
 		else
@@ -2142,11 +2108,15 @@ int emulate_step(struct pt_regs *regs, unsigned int instr)
 #endif
 #ifdef CONFIG_ALTIVEC
 	case STORE_VMX:
+		if (!(regs->msr & MSR_VEC))
+			return 0;
 		err = do_vec_store(op.reg, do_stvx, op.ea & ~0xfUL, regs);
 		goto ldst_done;
 #endif
 #ifdef CONFIG_VSX
 	case STORE_VSX:
+		if (!(regs->msr & MSR_VSX))
+			return 0;
 		err = do_vsx_store(op.reg, do_stxvd2x, op.ea, regs);
 		goto ldst_done;
 #endif
-- 
2.7.4
