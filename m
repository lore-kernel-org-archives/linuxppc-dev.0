Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xdrDW0rKPzDqXy
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Aug 2017 16:02:51 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 3xdrDV62jlz9sxR
 for <linuxppc-dev@ozlabs.org>; Fri, 25 Aug 2017 16:02:50 +1000 (AEST)
From: Paul Mackerras <paulus@ozlabs.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v2 04/10] powerpc: Add emulation for the addpcis instruction
Date: Fri, 25 Aug 2017 15:41:56 +1000
Message-Id: <1503639722-19121-5-git-send-email-paulus@ozlabs.org>
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

The addpcis instruction puts the sum of the next instruction address
plus a constant into a register.  Since the result depends on the
address of the instruction, it will give an incorrect result if it
is single-stepped out of line, which is what the *probes subsystem
will currently do if a probe is placed on an addpcis instruction.
This fixes the problem by adding emulation of it to analyse_instr().

Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/lib/sstep.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
index 7921b2a..d9b3b63 100644
--- a/arch/powerpc/lib/sstep.c
+++ b/arch/powerpc/lib/sstep.c
@@ -1024,9 +1024,6 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
 			op->ccval = (regs->ccr & ~(1UL << (31 - rd))) |
 				(val << (31 - rd));
 			return 1;
-		default:
-			op->type = UNKNOWN;
-			return 0;
 		}
 		break;
 	case 31:
@@ -1126,6 +1123,17 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
 		op->val = imm;
 		goto compute_done;
 
+	case 19:
+		if (((instr >> 1) & 0x1f) == 2) {
+			/* addpcis */
+			imm = (short) (instr & 0xffc1);	/* d0 + d2 fields */
+			imm |= (instr >> 15) & 0x3e;	/* d1 field */
+			op->val = regs->nip + (imm << 16) + 4;
+			goto compute_done;
+		}
+		op->type = UNKNOWN;
+		return 0;
+
 	case 20:	/* rlwimi */
 		mb = (instr >> 6) & 0x1f;
 		me = (instr >> 1) & 0x1f;
-- 
2.7.4
