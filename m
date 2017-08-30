Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xhwhX3nNszDqH0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Aug 2017 16:34:20 +1000 (AEST)
Date: Wed, 30 Aug 2017 16:34:09 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v3 18/17] powerpc: Emulate load/store floating point as
 integer word instructions
Message-ID: <20170830063409.GE27329@fergus.ozlabs.ibm.com>
References: <1504066360-30128-1-git-send-email-paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1504066360-30128-1-git-send-email-paulus@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This adds emulation for the lfiwax, lfiwzx and stfiwx instructions.
This necessitated adding a new flag to indicate whether a floating
point or an integer conversion was needed for LOAD_FP and STORE_FP,
so this moves the size field in op->type up 4 bits.

Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/include/asm/sstep.h |  5 ++--
 arch/powerpc/lib/sstep.c         | 60 ++++++++++++++++++++++++++++++----------
 2 files changed, 48 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/include/asm/sstep.h b/arch/powerpc/include/asm/sstep.h
index 309d1c5..ab9d849 100644
--- a/arch/powerpc/include/asm/sstep.h
+++ b/arch/powerpc/include/asm/sstep.h
@@ -68,6 +68,7 @@ enum instruction_type {
 #define SIGNEXT		0x20
 #define UPDATE		0x40	/* matches bit in opcode 31 instructions */
 #define BYTEREV		0x80
+#define FPCONV		0x100
 
 /* Barrier type field, ORed in with type */
 #define BARRIER_MASK	0xe0
@@ -93,8 +94,8 @@ enum instruction_type {
 #define VSX_CHECK_VEC	8	/* check MSR_VEC not MSR_VSX for reg >= 32 */
 
 /* Size field in type word */
-#define SIZE(n)		((n) << 8)
-#define GETSIZE(w)	((w) >> 8)
+#define SIZE(n)		((n) << 12)
+#define GETSIZE(w)	((w) >> 12)
 
 #define MKOP(t, f, s)	((t) | (f) | SIZE(s))
 
diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
index 24031ca..2f6897c 100644
--- a/arch/powerpc/lib/sstep.c
+++ b/arch/powerpc/lib/sstep.c
@@ -457,19 +457,23 @@ NOKPROBE_SYMBOL(write_mem);
  * These access either the real FP register or the image in the
  * thread_struct, depending on regs->msr & MSR_FP.
  */
-static int do_fp_load(int rn, unsigned long ea, int nb, struct pt_regs *regs,
-		      bool cross_endian)
+static int do_fp_load(struct instruction_op *op, unsigned long ea,
+		      struct pt_regs *regs, bool cross_endian)
 {
-	int err;
+	int err, rn, nb;
 	union {
+		int i;
+		unsigned int u;
 		float f;
 		double d[2];
 		unsigned long l[2];
 		u8 b[2 * sizeof(double)];
 	} u;
 
+	nb = GETSIZE(op->type);
 	if (!address_ok(regs, ea, nb))
 		return -EFAULT;
+	rn = op->reg;
 	err = copy_mem_in(u.b, ea, nb, regs);
 	if (err)
 		return err;
@@ -479,8 +483,14 @@ static int do_fp_load(int rn, unsigned long ea, int nb, struct pt_regs *regs,
 			do_byte_reverse(&u.b[8], 8);
 	}
 	preempt_disable();
-	if (nb == 4)
-		conv_sp_to_dp(&u.f, &u.d[0]);
+	if (nb == 4) {
+		if (op->type & FPCONV)
+			conv_sp_to_dp(&u.f, &u.d[0]);
+		else if (op->type & SIGNEXT)
+			u.l[0] = u.i;
+		else
+			u.l[0] = u.u;
+	}
 	if (regs->msr & MSR_FP)
 		put_fpr(rn, &u.d[0]);
 	else
@@ -498,25 +508,33 @@ static int do_fp_load(int rn, unsigned long ea, int nb, struct pt_regs *regs,
 }
 NOKPROBE_SYMBOL(do_fp_load);
 
-static int do_fp_store(int rn, unsigned long ea, int nb, struct pt_regs *regs,
-		       bool cross_endian)
+static int do_fp_store(struct instruction_op *op, unsigned long ea,
+		       struct pt_regs *regs, bool cross_endian)
 {
+	int rn, nb;
 	union {
+		unsigned int u;
 		float f;
 		double d[2];
 		unsigned long l[2];
 		u8 b[2 * sizeof(double)];
 	} u;
 
+	nb = GETSIZE(op->type);
 	if (!address_ok(regs, ea, nb))
 		return -EFAULT;
+	rn = op->reg;
 	preempt_disable();
 	if (regs->msr & MSR_FP)
 		get_fpr(rn, &u.d[0]);
 	else
 		u.l[0] = current->thread.TS_FPR(rn);
-	if (nb == 4)
-		conv_dp_to_sp(&u.d[0], &u.f);
+	if (nb == 4) {
+		if (op->type & FPCONV)
+			conv_dp_to_sp(&u.d[0], &u.f);
+		else
+			u.u = u.l[0];
+	}
 	if (nb == 16) {
 		rn |= 1;
 		if (regs->msr & MSR_FP)
@@ -2049,7 +2067,7 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
 #ifdef CONFIG_PPC_FPU
 		case 535:	/* lfsx */
 		case 567:	/* lfsux */
-			op->type = MKOP(LOAD_FP, u, 4);
+			op->type = MKOP(LOAD_FP, u | FPCONV, 4);
 			break;
 
 		case 599:	/* lfdx */
@@ -2059,7 +2077,7 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
 
 		case 663:	/* stfsx */
 		case 695:	/* stfsux */
-			op->type = MKOP(STORE_FP, u, 4);
+			op->type = MKOP(STORE_FP, u | FPCONV, 4);
 			break;
 
 		case 727:	/* stfdx */
@@ -2072,9 +2090,21 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
 			op->type = MKOP(LOAD_FP, 0, 16);
 			break;
 
+		case 855:	/* lfiwax */
+			op->type = MKOP(LOAD_FP, SIGNEXT, 4);
+			break;
+
+		case 887:	/* lfiwzx */
+			op->type = MKOP(LOAD_FP, 0, 4);
+			break;
+
 		case 919:	/* stfdpx */
 			op->type = MKOP(STORE_FP, 0, 16);
 			break;
+
+		case 983:	/* stfiwx */
+			op->type = MKOP(STORE_FP, 0, 4);
+			break;
 #endif /* __powerpc64 */
 #endif /* CONFIG_PPC_FPU */
 
@@ -2352,7 +2382,7 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
 #ifdef CONFIG_PPC_FPU
 	case 48:	/* lfs */
 	case 49:	/* lfsu */
-		op->type = MKOP(LOAD_FP, u, 4);
+		op->type = MKOP(LOAD_FP, u | FPCONV, 4);
 		op->ea = dform_ea(instr, regs);
 		break;
 
@@ -2364,7 +2394,7 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
 
 	case 52:	/* stfs */
 	case 53:	/* stfsu */
-		op->type = MKOP(STORE_FP, u, 4);
+		op->type = MKOP(STORE_FP, u | FPCONV, 4);
 		op->ea = dform_ea(instr, regs);
 		break;
 
@@ -2792,7 +2822,7 @@ int emulate_loadstore(struct pt_regs *regs, struct instruction_op *op)
 		 */
 		if (!(regs->msr & MSR_PR) && !(regs->msr & MSR_FP))
 			return 0;
-		err = do_fp_load(op->reg, ea, size, regs, cross_endian);
+		err = do_fp_load(op, ea, regs, cross_endian);
 		break;
 #endif
 #ifdef CONFIG_ALTIVEC
@@ -2862,7 +2892,7 @@ int emulate_loadstore(struct pt_regs *regs, struct instruction_op *op)
 	case STORE_FP:
 		if (!(regs->msr & MSR_PR) && !(regs->msr & MSR_FP))
 			return 0;
-		err = do_fp_store(op->reg, ea, size, regs, cross_endian);
+		err = do_fp_store(op, ea, regs, cross_endian);
 		break;
 #endif
 #ifdef CONFIG_ALTIVEC
-- 
2.7.4
