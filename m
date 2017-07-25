Return-Path: <matthew.brown.dev@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xGkNz4vFgzDrFG
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jul 2017 13:33:55 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id d193so13362391pgc.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Jul 2017 20:33:55 -0700 (PDT)
Received: from matt.ozlabs.ibm.com ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id 13sm18671389pfm.123.2017.07.24.20.33.52
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 24 Jul 2017 20:33:53 -0700 (PDT)
From: Matt Brown <matthew.brown.dev@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 5/5] powerpc/lib/sstep: Add isel instruction emulation
Date: Tue, 25 Jul 2017 13:33:20 +1000
Message-Id: <20170725033320.17893-5-matthew.brown.dev@gmail.com>
In-Reply-To: <20170725033320.17893-1-matthew.brown.dev@gmail.com>
References: <20170725033320.17893-1-matthew.brown.dev@gmail.com>
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
v2:
	- fixed opcode
	- fixed definition to include the 'if RA=0, a=0' clause
	- fixed ccr bitshifting error
---
 arch/powerpc/lib/sstep.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
index 0bcf631..de3d558 100644
--- a/arch/powerpc/lib/sstep.c
+++ b/arch/powerpc/lib/sstep.c
@@ -1239,6 +1239,17 @@ int analyse_instr(struct instruction_op *op, struct pt_regs *regs,
 /*
  * Logical instructions
  */
+		case 15:	/* isel */
+			mb = (instr >> 6) & 0x1f; /* bc */
+			val = (regs->ccr >> (31 - mb)) & 1;
+			val2 = (ra) ? regs->gpr[ra] : 0;
+
+			if (val)
+				regs->gpr[rd] = val2;
+			else
+				regs->gpr[rd] = regs->gpr[rb];
+			goto logical_done;
+
 		case 26:	/* cntlzw */
 			asm("cntlzw %0,%1" : "=r" (regs->gpr[ra]) :
 			    "r" (regs->gpr[rd]));
-- 
2.9.3
