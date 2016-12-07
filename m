Return-Path: <prasannatsmkumar@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tYmCF02XszDw2b
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Dec 2016 04:46:48 +1100 (AEDT)
Received: by mail-pf0-x242.google.com with SMTP id c4so20928286pfb.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 07 Dec 2016 09:46:48 -0800 (PST)
From: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 naveen.n.rao@linux.vnet.ibm.com, ananth@in.ibm.com,
 linuxppc-dev@lists.ozlabs.org
Cc: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Subject: [PATCH v2] powerpc: sstep.c: Add modsw, moduw instruction emulation
Date: Wed,  7 Dec 2016 23:15:15 +0530
Message-Id: <20161207174515.7628-1-prasannatsmkumar@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add modsw and moduw instruction emulation support to analyse_instr.
modsw is an x-form instruction that calculates signed modulo of values
stored in registers. moduw is similar to modsw but it works with
unsigned values.

Changes in v2:
Don't update CR register as the instruction does not touch that
Arrange extended opcode in numerical order

Signed-off-by: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
---
 arch/powerpc/lib/sstep.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
index 9c78a9c..b0acdbc 100644
--- a/arch/powerpc/lib/sstep.c
+++ b/arch/powerpc/lib/sstep.c
@@ -1128,6 +1128,11 @@ int __kprobes analyse_instr(struct instruction_op *op, struct pt_regs *regs,
 		case 266:	/* add */
 			regs->gpr[rd] = regs->gpr[ra] + regs->gpr[rb];
 			goto arith_done;
+
+		case 267:	/* moduw */
+			regs->gpr[rd] = (unsigned int) regs->gpr[ra] %
+				(unsigned int) regs->gpr[rb];
+			goto instr_done;
 #ifdef __powerpc64__
 		case 457:	/* divdu */
 			regs->gpr[rd] = regs->gpr[ra] / regs->gpr[rb];
@@ -1148,6 +1153,10 @@ int __kprobes analyse_instr(struct instruction_op *op, struct pt_regs *regs,
 				(int) regs->gpr[rb];
 			goto arith_done;
 
+		case 779:	/* modsw */
+			regs->gpr[rd] = (int) regs->gpr[ra] %
+				(int) regs->gpr[rb];
+			goto instr_done;
 
 /*
  * Logical instructions
-- 
2.9.3
