Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wp3FG6LTRzDqKv
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jun 2017 09:46:42 +1000 (AEST)
From: Anton Blanchard <anton@ozlabs.org>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 ravi.bangoria@linux.vnet.ibm.com, npiggin@gmail.com,
 naveen.n.rao@linux.vnet.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/2] powerpc: Fix emulation of mcrf in emulate_step()
Date: Thu, 15 Jun 2017 09:46:38 +1000
Message-Id: <20170614234639.11997-1-anton@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Anton Blanchard <anton@samba.org>

The mcrf emulation code was looking at the CR fields in the reverse
order. It also relied on reserved fields being zero which is somewhat
fragile, so fix that too.

Cc: stable@vger.kernel.org
Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/lib/sstep.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
index 33117f8a0882..fb84f51b1f0b 100644
--- a/arch/powerpc/lib/sstep.c
+++ b/arch/powerpc/lib/sstep.c
@@ -683,8 +683,10 @@ int analyse_instr(struct instruction_op *op, struct pt_regs *regs,
 	case 19:
 		switch ((instr >> 1) & 0x3ff) {
 		case 0:		/* mcrf */
-			rd = (instr >> 21) & 0x1c;
-			ra = (instr >> 16) & 0x1c;
+			rd = 7 - ((instr >> 23) & 0x7);
+			ra = 7 - ((instr >> 18) & 0x7);
+			rd *= 4;
+			ra *= 4;
 			val = (regs->ccr >> ra) & 0xf;
 			regs->ccr = (regs->ccr & ~(0xfUL << rd)) | (val << rd);
 			goto instr_done;
-- 
2.11.0
