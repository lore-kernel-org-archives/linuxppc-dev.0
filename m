Return-Path: <ananth@in.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 46655DDE01
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Apr 2007 15:53:08 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l3I5ruPx001498
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Apr 2007 01:53:56 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l3I5r4qj551966
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Apr 2007 01:53:04 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l3I5r4eZ022465
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Apr 2007 01:53:04 -0400
Date: Wed, 18 Apr 2007 11:26:38 +0530
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] Emulate more instructions in software
Message-ID: <20070418055638.GA16650@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
Reply-To: ananth@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Emulate a few more instructions in software - especially useful during
singlestepping (xmon/kprobes).

Instructions emulated with this patch are mfcr/mtcr rX, mfxer/mtxer rX,
mflr/mtlr rX, mfctr/mtctr rX and mr rA,rB.


Signed-off-by: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
---
 arch/powerpc/lib/sstep.c |   45 ++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 44 insertions(+), 1 deletion(-)

Index: linux-2.6.21-rc7/arch/powerpc/lib/sstep.c
===================================================================
--- linux-2.6.21-rc7.orig/arch/powerpc/lib/sstep.c
+++ linux-2.6.21-rc7/arch/powerpc/lib/sstep.c
@@ -54,7 +54,7 @@ static int __kprobes branch_taken(unsign
  */
 int __kprobes emulate_step(struct pt_regs *regs, unsigned int instr)
 {
-	unsigned int opcode, rd;
+	unsigned int opcode, rs, rb, rd, spr;
 	unsigned long int imm;
 
 	opcode = instr >> 26;
@@ -152,6 +152,49 @@ int __kprobes emulate_step(struct pt_reg
 				regs->nip &= 0xffffffffUL;
 			return 1;
 #endif
+		case 0x26:	/* mfcr */
+			regs->gpr[rd] = regs->ccr;
+			regs->gpr[rd] &= 0xffffffffUL;
+			goto mtspr_out;
+		case 0x2a6:	/* mfspr */
+			spr = (instr >> 11) & 0x3ff;
+			switch (spr) {
+			case 0x20:	/* mfxer */
+				regs->gpr[rd] = regs->xer;
+				regs->gpr[rd] &= 0xffffffffUL;
+				goto mtspr_out;
+			case 0x100:	/* mflr */
+				regs->gpr[rd] = regs->link;
+				goto mtspr_out;
+			case 0x120:	/* mfctr */
+				regs->gpr[rd] = regs->ctr;
+				goto mtspr_out;
+			}
+			break;
+		case 0x378:	/* orx */
+			rs = (instr >> 21) & 0x1f;
+			rb = (instr >> 11) & 0x1f;
+			if (rs == rb) {		/* mr */
+				rd = (instr >> 16) & 0x1f;
+				regs->gpr[rd] = regs->gpr[rs];
+				goto mtspr_out;
+			}
+			break;
+		case 0x3a6:	/* mtspr */
+			spr = (instr >> 11) & 0x3ff;
+			switch (spr) {
+			case 0x20:	/* mtxer */
+				regs->xer = (regs->gpr[rd] & 0xffffffffUL);
+				goto mtspr_out;
+			case 0x100:	/* mtlr */
+				regs->link = regs->gpr[rd];
+				goto mtspr_out;
+			case 0x120:	/* mtctr */
+				regs->ctr = regs->gpr[rd];
+mtspr_out:
+				regs->nip += 4;
+				return 1;
+			}
 		}
 	}
 	return 0;
