Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xxKKk4gz7zDq8f
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Sep 2017 20:46:02 +1000 (AEST)
From: Anton Blanchard <anton@ozlabs.org>
To: benh@kernel.crashing.org,
	paulus@samba.org,
	mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/2] powerpc/sstep: Fix issues with mcrf
Date: Tue, 19 Sep 2017 20:45:53 +1000
Message-Id: <20170919104553.5146-2-anton@ozlabs.org>
In-Reply-To: <20170919104553.5146-1-anton@ozlabs.org>
References: <20170919104553.5146-1-anton@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Anton Blanchard <anton@samba.org>

mcrf broke when we changed analyse_instr() to not modify the register
state. The instruction writes to the CR, so we need to store the result
in op->ccval, not op->val.

Fixes: 3cdfcbfd32b9 ("powerpc: Change analyse_instr so it doesn't modify *regs")
Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/lib/sstep.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
index 9d72e5900320..c4cda1afb49d 100644
--- a/arch/powerpc/lib/sstep.c
+++ b/arch/powerpc/lib/sstep.c
@@ -1513,10 +1513,10 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
 			op->type = COMPUTE + SETCC;
 			imm = 0xf0000000UL;
 			val = regs->gpr[rd];
-			op->val = regs->ccr;
+			op->ccval = regs->ccr;
 			for (sh = 0; sh < 8; ++sh) {
 				if (instr & (0x80000 >> sh))
-					op->val = (op->val & ~imm) |
+					op->ccval = (op->ccval & ~imm) |
 						(val & imm);
 				imm >>= 4;
 			}
-- 
2.11.0
