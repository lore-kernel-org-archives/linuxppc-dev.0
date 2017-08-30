Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xhsYH0T1LzDqGV
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Aug 2017 14:12:51 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 3xhsYG5LZ5z9sP5
 for <linuxppc-dev@ozlabs.org>; Wed, 30 Aug 2017 14:12:50 +1000 (AEST)
From: Paul Mackerras <paulus@ozlabs.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v3 06/17] powerpc: Fix emulation of the isel instruction
Date: Wed, 30 Aug 2017 14:12:29 +1000
Message-Id: <1504066360-30128-7-git-send-email-paulus@ozlabs.org>
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

The case added for the isel instruction was added inside a switch
statement which uses the 10-bit minor opcode field in the 0x7fe
bits of the instruction word.  However, for the isel instruction,
the minor opcode field is only the 0x3e bits, and the 0x7c0 bits
are used for the "BC" field, which indicates which CR bit to use
to select the result.

Therefore, for the isel emulation to work correctly when BC != 0,
we need to match on ((instr >> 1) & 0x1f) == 15).  To do this, we
pull the isel case out of the switch statement and put it in an
if statement of its own.

Fixes: e27f71e5ff3c ("powerpc/lib/sstep: Add isel instruction emulation")
Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/lib/sstep.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
index e20f2b4..522bc7b 100644
--- a/arch/powerpc/lib/sstep.c
+++ b/arch/powerpc/lib/sstep.c
@@ -1216,6 +1216,16 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
 		return 0;
 
 	case 31:
+		/* isel occupies 32 minor opcodes */
+		if (((instr >> 1) & 0x1f) == 15) {
+			mb = (instr >> 6) & 0x1f; /* bc field */
+			val = (regs->ccr >> (31 - mb)) & 1;
+			val2 = (ra) ? regs->gpr[ra] : 0;
+
+			op->val = (val) ? val2 : regs->gpr[rb];
+			goto compute_done;
+		}
+
 		switch ((instr >> 1) & 0x3ff) {
 		case 4:		/* tw */
 			if (rd == 0x1f ||
@@ -1441,14 +1451,6 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
 /*
  * Logical instructions
  */
-		case 15:	/* isel */
-			mb = (instr >> 6) & 0x1f; /* bc */
-			val = (regs->ccr >> (31 - mb)) & 1;
-			val2 = (ra) ? regs->gpr[ra] : 0;
-
-			op->val = (val) ? val2 : regs->gpr[rb];
-			goto compute_done;
-
 		case 26:	/* cntlzw */
 			op->val = __builtin_clz((unsigned int) regs->gpr[rd]);
 			goto logical_done;
-- 
2.7.4
