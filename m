Return-Path: <prasannatsmkumar@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tWvD11K5bzDvhQ
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Dec 2016 03:56:00 +1100 (AEDT)
Received: by mail-pf0-x243.google.com with SMTP id 144so15887918pfv.0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 04 Dec 2016 08:56:00 -0800 (PST)
From: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org
Cc: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Subject: [PATCH] PPC: sstep.c: Add modsw, moduw instruction emulation
Date: Sun,  4 Dec 2016 22:25:21 +0530
Message-Id: <20161204165521.10045-1-prasannatsmkumar@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add modsw and moduw instruction emulation support to analyse_instr.

Signed-off-by: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
---
 arch/powerpc/lib/sstep.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
index 9c78a9c..5acef72 100644
--- a/arch/powerpc/lib/sstep.c
+++ b/arch/powerpc/lib/sstep.c
@@ -1148,6 +1148,15 @@ int __kprobes analyse_instr(struct instruction_op *op, struct pt_regs *regs,
 				(int) regs->gpr[rb];
 			goto arith_done;
 
+		case 779:	/* modsw */
+			regs->gpr[rd] = (int) regs->gpr[ra] %
+				(int) regs->gpr[rb];
+			goto arith_done;
+
+		case 267:	/* moduw */
+			regs->gpr[rd] = (unsigned int) regs->gpr[ra] %
+				(unsigned int) regs->gpr[rb];
+			goto arith_done;
 
 /*
  * Logical instructions
-- 
2.9.3
