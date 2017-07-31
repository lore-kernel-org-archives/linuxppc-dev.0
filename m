Return-Path: <matthew.brown.dev@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xLLgf2PlfzDrKH
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Jul 2017 10:59:10 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id 72so4259139pfl.4
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Jul 2017 17:59:10 -0700 (PDT)
Received: from matt.ozlabs.ibm.com ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id d127sm46851127pfa.171.2017.07.30.17.59.06
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 30 Jul 2017 17:59:07 -0700 (PDT)
From: Matt Brown <matthew.brown.dev@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4 5/5] powerpc/lib/sstep: Add isel instruction emulation
Date: Mon, 31 Jul 2017 10:58:26 +1000
Message-Id: <20170731005826.32044-5-matthew.brown.dev@gmail.com>
In-Reply-To: <20170731005826.32044-1-matthew.brown.dev@gmail.com>
References: <20170731005826.32044-1-matthew.brown.dev@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This adds emulation for the isel instruction.
Tested for correctness against the isel instruction and its extended
mnemonics (lt, gt, eq) on ppc64le.

Signed-off-by: Matt Brown <matthew.brown.dev@gmail.com>
---
v4:
	- simplify if statement to ternary op
	(same as isel emulation in kernel/traps.c)
v2:
	- fixed opcode
	- fixed definition to include the 'if RA=0, a=0' clause
	- fixed ccr bitshifting error
---
 arch/powerpc/lib/sstep.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
index af4eef9..473bab5 100644
--- a/arch/powerpc/lib/sstep.c
+++ b/arch/powerpc/lib/sstep.c
@@ -1240,6 +1240,14 @@ int analyse_instr(struct instruction_op *op, struct pt_regs *regs,
 /*
  * Logical instructions
  */
+		case 15:	/* isel */
+			mb = (instr >> 6) & 0x1f; /* bc */
+			val = (regs->ccr >> (31 - mb)) & 1;
+			val2 = (ra) ? regs->gpr[ra] : 0;
+
+			regs->gpr[rd] = (val) ? val2 : regs->gpr[rb];
+			goto logical_done;
+
 		case 26:	/* cntlzw */
 			asm("cntlzw %0,%1" : "=r" (regs->gpr[ra]) :
 			    "r" (regs->gpr[rd]));
-- 
2.9.3
