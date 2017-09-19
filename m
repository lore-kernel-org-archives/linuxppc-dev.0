Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xxKKg3lD1zDq8f
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Sep 2017 20:45:59 +1000 (AEST)
From: Anton Blanchard <anton@ozlabs.org>
To: benh@kernel.crashing.org,
	paulus@samba.org,
	mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/2] powerpc/sstep: Fix issues with set_cr0()
Date: Tue, 19 Sep 2017 20:45:52 +1000
Message-Id: <20170919104553.5146-1-anton@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Anton Blanchard <anton@samba.org>

set_cr0() broke when we changed analyse_instr() to not modify the
register state. Instead of looking at regs->gpr[x] which has not
been updated yet, we need to look at op->val.

Fixes: 3cdfcbfd32b9 ("powerpc: Change analyse_instr so it doesn't modify *regs")
Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/lib/sstep.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
index fb9f58b868e7..9d72e5900320 100644
--- a/arch/powerpc/lib/sstep.c
+++ b/arch/powerpc/lib/sstep.c
@@ -944,9 +944,9 @@ NOKPROBE_SYMBOL(emulate_dcbz);
 		: "r" (addr), "i" (-EFAULT), "0" (err))
 
 static nokprobe_inline void set_cr0(const struct pt_regs *regs,
-				    struct instruction_op *op, int rd)
+				    struct instruction_op *op)
 {
-	long val = regs->gpr[rd];
+	long val = op->val;
 
 	op->type |= SETCC;
 	op->ccval = (regs->ccr & 0x0fffffff) | ((regs->xer >> 3) & 0x10000000);
@@ -1326,7 +1326,7 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
 	case 13:	/* addic. */
 		imm = (short) instr;
 		add_with_carry(regs, op, rd, regs->gpr[ra], imm, 0);
-		set_cr0(regs, op, rd);
+		set_cr0(regs, op);
 		return 1;
 
 	case 14:	/* addi */
@@ -1397,13 +1397,13 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
 
 	case 28:	/* andi. */
 		op->val = regs->gpr[rd] & (unsigned short) instr;
-		set_cr0(regs, op, ra);
+		set_cr0(regs, op);
 		goto logical_done_nocc;
 
 	case 29:	/* andis. */
 		imm = (unsigned short) instr;
 		op->val = regs->gpr[rd] & (imm << 16);
-		set_cr0(regs, op, ra);
+		set_cr0(regs, op);
 		goto logical_done_nocc;
 
 #ifdef __powerpc64__
@@ -2526,7 +2526,7 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
 
  logical_done:
 	if (instr & 1)
-		set_cr0(regs, op, ra);
+		set_cr0(regs, op);
  logical_done_nocc:
 	op->reg = ra;
 	op->type |= SETREG;
@@ -2534,7 +2534,7 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
 
  arith_done:
 	if (instr & 1)
-		set_cr0(regs, op, rd);
+		set_cr0(regs, op);
  compute_done:
 	op->reg = rd;
 	op->type |= SETREG;
-- 
2.11.0
