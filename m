Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wp3FK0L1czDqKv
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jun 2017 09:46:45 +1000 (AEST)
From: Anton Blanchard <anton@ozlabs.org>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 ravi.bangoria@linux.vnet.ibm.com, npiggin@gmail.com,
 naveen.n.rao@linux.vnet.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/2] powerpc: Fix emulation of mfocrf in emulate_step()
Date: Thu, 15 Jun 2017 09:46:39 +1000
Message-Id: <20170614234639.11997-2-anton@ozlabs.org>
In-Reply-To: <20170614234639.11997-1-anton@ozlabs.org>
References: <20170614234639.11997-1-anton@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Anton Blanchard <anton@samba.org>

>From POWER4 onwards, mfocrf() only places the specified CR field into
the destination GPR, and the rest of it is set to 0. The PowerPC AS
from version 3.0 now requires this behaviour.

The emulation code currently puts the entire CR into the destination GPR.
Fix it.

Cc: stable@vger.kernel.org
Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/lib/sstep.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
index fb84f51b1f0b..ee33327686ae 100644
--- a/arch/powerpc/lib/sstep.c
+++ b/arch/powerpc/lib/sstep.c
@@ -966,6 +966,19 @@ int analyse_instr(struct instruction_op *op, struct pt_regs *regs,
 #endif
 
 		case 19:	/* mfcr */
+			if ((instr >> 20) & 1) {
+				imm = 0xf0000000UL;
+				for (sh = 0; sh < 8; ++sh) {
+					if (instr & (0x80000 >> sh)) {
+						regs->gpr[rd] = regs->ccr & imm;
+						break;
+					}
+					imm >>= 4;
+				}
+
+				goto instr_done;
+			}
+
 			regs->gpr[rd] = regs->ccr;
 			regs->gpr[rd] &= 0xffffffffUL;
 			goto instr_done;
-- 
2.11.0
