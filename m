Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xxfKy1fXFzDqNm
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Sep 2017 09:32:22 +1000 (AEST)
From: Anton Blanchard <anton@ozlabs.org>
To: benh@kernel.crashing.org,
	paulus@samba.org,
	mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/sstep: mullw should calculate a 64 bit signed result
Date: Wed, 20 Sep 2017 09:32:19 +1000
Message-Id: <20170919233219.26184-1-anton@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Anton Blanchard <anton@samba.org>

mullw should do a 32 bit signed multiply and create a 64 bit signed
result. It currently truncates the result to 32 bits.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/lib/sstep.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
index c4cda1afb49d..5e8418c28bd8 100644
--- a/arch/powerpc/lib/sstep.c
+++ b/arch/powerpc/lib/sstep.c
@@ -1651,8 +1651,9 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
 			goto arith_done;
 
 		case 235:	/* mullw */
-			op->val = (unsigned int) regs->gpr[ra] *
-				(unsigned int) regs->gpr[rb];
+			op->val = (long)(int) regs->gpr[ra] *
+				(int) regs->gpr[rb];
+
 			goto arith_done;
 
 		case 266:	/* add */
-- 
2.11.0
