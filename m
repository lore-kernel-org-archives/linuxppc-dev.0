Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xcS1F68xjzDqgQ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Aug 2017 09:48:17 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 3xcS1F4CFBz9sR9
 for <linuxppc-dev@ozlabs.org>; Wed, 23 Aug 2017 09:48:17 +1000 (AEST)
From: Paul Mackerras <paulus@ozlabs.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH RFC 6/7] powerpc: Emulate load/store floating double pair
 instructions
Date: Wed, 23 Aug 2017 09:48:02 +1000
Message-Id: <1503445683-12011-7-git-send-email-paulus@ozlabs.org>
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

This adds lfdp[x] and stfdp[x] to the set of instructions that
analyse_instr() and emulate_step() understand.

Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/lib/sstep.c | 76 ++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 60 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
index b637496..c05d5c4 100644
--- a/arch/powerpc/lib/sstep.c
+++ b/arch/powerpc/lib/sstep.c
@@ -414,9 +414,9 @@ static int do_fp_load(int rn, unsigned long ea, int nb, struct pt_regs *regs)
 	int err;
 	union {
 		float f;
-		double d;
-		unsigned long l;
-		u8 b[sizeof(double)];
+		double d[2];
+		unsigned long l[2];
+		u8 b[2 * sizeof(double)];
 	} u;
 
 	if (!address_ok(regs, ea, nb))
@@ -426,11 +426,19 @@ static int do_fp_load(int rn, unsigned long ea, int nb, struct pt_regs *regs)
 		return err;
 	preempt_disable();
 	if (nb == 4)
-		conv_sp_to_dp(&u.f, &u.d);
+		conv_sp_to_dp(&u.f, &u.d[0]);
 	if (regs->msr & MSR_FP)
-		put_fpr(rn, &u.d);
+		put_fpr(rn, &u.d[0]);
 	else
-		current->thread.TS_FPR(rn) = u.l;
+		current->thread.TS_FPR(rn) = u.l[0];
+	if (nb == 16) {
+		/* lfdp */
+		rn |= 1;
+		if (regs->msr & MSR_FP)
+			put_fpr(rn, &u.d[1]);
+		else
+			current->thread.TS_FPR(rn) = u.l[1];
+	}
 	preempt_enable();
 	return 0;
 }
@@ -440,20 +448,27 @@ static int do_fp_store(int rn, unsigned long ea, int nb, struct pt_regs *regs)
 {
 	union {
 		float f;
-		double d;
-		unsigned long l;
-		u8 b[sizeof(double)];
+		double d[2];
+		unsigned long l[2];
+		u8 b[2 * sizeof(double)];
 	} u;
 
 	if (!address_ok(regs, ea, nb))
 		return -EFAULT;
 	preempt_disable();
 	if (regs->msr & MSR_FP)
-		get_fpr(rn, &u.d);
+		get_fpr(rn, &u.d[0]);
 	else
-		u.l = current->thread.TS_FPR(rn);
+		u.l[0] = current->thread.TS_FPR(rn);
 	if (nb == 4)
-		conv_dp_to_sp(&u.d, &u.f);
+		conv_dp_to_sp(&u.d[0], &u.f);
+	if (nb == 16) {
+		rn |= 1;
+		if (regs->msr & MSR_FP)
+			get_fpr(rn, &u.d[1]);
+		else
+			u.l[1] = current->thread.TS_FPR(rn);
+	}
 	preempt_enable();
 	return copy_mem_out(u.b, ea, nb);
 }
@@ -1837,7 +1852,21 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
 				goto fpunavail;
 			op->type = MKOP(STORE_FP, u, 8);
 			break;
-#endif
+
+#ifdef __powerpc64__
+		case 791:	/* lfdpx */
+			if (!(regs->msr & MSR_FP))
+				goto fpunavail;
+			op->type = MKOP(LOAD_FP, 0, 16);
+			break;
+
+		case 919:	/* stfdpx */
+			if (!(regs->msr & MSR_FP))
+				goto fpunavail;
+			op->type = MKOP(STORE_FP, 0, 16);
+			break;
+#endif /* __powerpc64 */
+#endif /* CONFIG_PPC_FPU */
 
 #ifdef __powerpc64__
 		case 660:	/* stdbrx */
@@ -1855,7 +1884,7 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
 			op->val = byterev_4(regs->gpr[rd]);
 			break;
 
-		case 725:
+		case 725:	/* stswi */
 			if (rb == 0)
 				rb = 32;	/* # bytes to store */
 			op->type = MKOP(STORE_MULTI, 0, rb);
@@ -2239,9 +2268,16 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
 #endif
 
 #ifdef CONFIG_VSX
-	case 57:	/* lxsd, lxssp */
+	case 57:	/* lfdp, lxsd, lxssp */
 		op->ea = dsform_ea(instr, regs);
 		switch (instr & 3) {
+		case 0:		/* lfdp */
+			if (!(regs->msr & MSR_FP))
+				goto fpunavail;
+			if (rd & 1)
+				break;		/* reg must be even */
+			op->type = MKOP(LOAD_FP, 0, 16);
+			break;
 		case 2:		/* lxsd */
 			if (!(regs->msr & MSR_VSX))
 				goto vsxunavail;
@@ -2279,8 +2315,16 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
 #endif
 
 #ifdef CONFIG_VSX
-	case 61:	/* lxv, stxsd, stxssp, stxv */
+	case 61:	/* stfdp, lxv, stxsd, stxssp, stxv */
 		switch (instr & 7) {
+		case 0:		/* stfdp with LSB of DS field = 0 */
+		case 4:		/* stfdp with LSB of DS field = 1 */
+			op->ea = dsform_ea(instr, regs);
+			if (!(regs->msr & MSR_FP))
+				goto fpunavail;
+			op->type = MKOP(STORE_FP, 0, 16);
+			break;
+
 		case 1:		/* lxv */
 			op->ea = dqform_ea(instr, regs);
 			if (!(instr & 8)) {
-- 
2.7.4
