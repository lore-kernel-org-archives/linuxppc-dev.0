Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xhsYH1zPbzDqGG
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Aug 2017 14:12:51 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 3xhsYG6s9sz9sQl
 for <linuxppc-dev@ozlabs.org>; Wed, 30 Aug 2017 14:12:50 +1000 (AEST)
From: Paul Mackerras <paulus@ozlabs.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v3 07/17] powerpc: Don't update CR0 in emulation of popcnt,
 prty, bpermd instructions
Date: Wed, 30 Aug 2017 14:12:30 +1000
Message-Id: <1504066360-30128-8-git-send-email-paulus@ozlabs.org>
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

The architecture shows the least-significant bit of the instruction
word as reserved for the popcnt[bwd], prty[wd] and bpermd
instructions, that is, these instructions never update CR0.
Therefore this changes the emulation of these instructions to
skip the CR0 update.

Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/lib/sstep.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
index 522bc7b..114e597 100644
--- a/arch/powerpc/lib/sstep.c
+++ b/arch/powerpc/lib/sstep.c
@@ -1469,7 +1469,7 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
 
 		case 122:	/* popcntb */
 			do_popcnt(regs, op, regs->gpr[rd], 8);
-			goto logical_done;
+			goto logical_done_nocc;
 
 		case 124:	/* nor */
 			op->val = ~(regs->gpr[rd] | regs->gpr[rb]);
@@ -1477,15 +1477,15 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
 
 		case 154:	/* prtyw */
 			do_prty(regs, op, regs->gpr[rd], 32);
-			goto logical_done;
+			goto logical_done_nocc;
 
 		case 186:	/* prtyd */
 			do_prty(regs, op, regs->gpr[rd], 64);
-			goto logical_done;
+			goto logical_done_nocc;
 #ifdef CONFIG_PPC64
 		case 252:	/* bpermd */
 			do_bpermd(regs, op, regs->gpr[rd], regs->gpr[rb]);
-			goto logical_done;
+			goto logical_done_nocc;
 #endif
 		case 284:	/* xor */
 			op->val = ~(regs->gpr[rd] ^ regs->gpr[rb]);
@@ -1497,7 +1497,7 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
 
 		case 378:	/* popcntw */
 			do_popcnt(regs, op, regs->gpr[rd], 32);
-			goto logical_done;
+			goto logical_done_nocc;
 
 		case 412:	/* orc */
 			op->val = regs->gpr[rd] | ~regs->gpr[rb];
@@ -1513,7 +1513,7 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
 #ifdef CONFIG_PPC64
 		case 506:	/* popcntd */
 			do_popcnt(regs, op, regs->gpr[rd], 64);
-			goto logical_done;
+			goto logical_done_nocc;
 #endif
 		case 922:	/* extsh */
 			op->val = (signed short) regs->gpr[rd];
-- 
2.7.4
