Return-Path: <matthew.brown.dev@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xG33b5T10zDrG1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Jul 2017 11:01:31 +1000 (AEST)
Received: by mail-pg0-x241.google.com with SMTP id z1so10264866pgs.0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Jul 2017 18:01:31 -0700 (PDT)
Received: from matt.ozlabs.ibm.com ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id i5sm22043976pgk.61.2017.07.23.18.01.28
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 23 Jul 2017 18:01:29 -0700 (PDT)
From: Matt Brown <matthew.brown.dev@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 5/5] powerpc/lib/sstep: Add isel instruction emulation
Date: Mon, 24 Jul 2017 11:01:09 +1000
Message-Id: <20170724010109.21263-5-matthew.brown.dev@gmail.com>
In-Reply-To: <20170724010109.21263-1-matthew.brown.dev@gmail.com>
References: <20170724010109.21263-1-matthew.brown.dev@gmail.com>
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
index b08eb96..e1f4ec6 100644
--- a/arch/powerpc/lib/sstep.c
+++ b/arch/powerpc/lib/sstep.c
@@ -1246,6 +1246,17 @@ int analyse_instr(struct instruction_op *op, struct pt_regs *regs,
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
