Return-Path: <paulus@samba.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E09411A0188
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Aug 2014 22:13:35 +1000 (EST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 9F51B1400A8
 for <linuxppc-dev@ozlabs.org>; Mon, 18 Aug 2014 22:13:35 +1000 (EST)
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 3/3] powerpc: Implement emulation of string loads and stores
Date: Mon, 18 Aug 2014 22:13:12 +1000
Message-Id: <1408363992-7929-4-git-send-email-paulus@samba.org>
In-Reply-To: <1408363992-7929-1-git-send-email-paulus@samba.org>
References: <1408363992-7929-1-git-send-email-paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The size field of the op.type word is now the total number of bytes
to be loaded or stored.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/lib/sstep.c | 59 ++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 49 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
index 57e2873..39ed4b7 100644
--- a/arch/powerpc/lib/sstep.c
+++ b/arch/powerpc/lib/sstep.c
@@ -1433,11 +1433,24 @@ int __kprobes analyse_instr(struct instruction_op *op, struct pt_regs *regs,
 			break;
 
 #endif
+		case 533:	/* lswx */
+			op->type = MKOP(LOAD_MULTI, 0, regs->xer & 0x7f);
+			break;
 
 		case 534:	/* lwbrx */
 			op->type = MKOP(LOAD, BYTEREV, 4);
 			break;
 
+		case 597:	/* lswi */
+			if (rb == 0)
+				rb = 32;	/* # bytes to load */
+			op->type = MKOP(LOAD_MULTI, 0, rb);
+			op->ea = 0;
+			if (ra)
+				op->ea = truncate_if_32bit(regs->msr,
+							   regs->gpr[ra]);
+			break;
+
 #ifdef CONFIG_PPC_FPU
 		case 535:	/* lfsx */
 		case 567:	/* lfsux */
@@ -1475,11 +1488,25 @@ int __kprobes analyse_instr(struct instruction_op *op, struct pt_regs *regs,
 			break;
 
 #endif
+		case 661:	/* stswx */
+			op->type = MKOP(STORE_MULTI, 0, regs->xer & 0x7f);
+			break;
+
 		case 662:	/* stwbrx */
 			op->type = MKOP(STORE, BYTEREV, 4);
 			op->val = byterev_4(regs->gpr[rd]);
 			break;
 
+		case 725:
+			if (rb == 0)
+				rb = 32;	/* # bytes to store */
+			op->type = MKOP(STORE_MULTI, 0, rb);
+			op->ea = 0;
+			if (ra)
+				op->ea = truncate_if_32bit(regs->msr,
+							   regs->gpr[ra]);
+			break;
+
 		case 790:	/* lhbrx */
 			op->type = MKOP(LOAD, BYTEREV, 2);
 			break;
@@ -1553,15 +1580,14 @@ int __kprobes analyse_instr(struct instruction_op *op, struct pt_regs *regs,
 		break;
 
 	case 46:	/* lmw */
-		ra = (instr >> 16) & 0x1f;
 		if (ra >= rd)
 			break;		/* invalid form, ra in range to load */
-		op->type = MKOP(LOAD_MULTI, 0, 4);
+		op->type = MKOP(LOAD_MULTI, 0, 4 * (32 - rd));
 		op->ea = dform_ea(instr, regs);
 		break;
 
 	case 47:	/* stmw */
-		op->type = MKOP(STORE_MULTI, 0, 4);
+		op->type = MKOP(STORE_MULTI, 0, 4 * (32 - rd));
 		op->ea = dform_ea(instr, regs);
 		break;
 
@@ -1744,7 +1770,7 @@ int __kprobes emulate_step(struct pt_regs *regs, unsigned int instr)
 	int r, err, size;
 	unsigned long val;
 	unsigned int cr;
-	int rd;
+	int i, rd, nb;
 
 	r = analyse_instr(&op, regs, instr);
 	if (r != 0)
@@ -1864,12 +1890,18 @@ int __kprobes emulate_step(struct pt_regs *regs, unsigned int instr)
 		if (regs->msr & MSR_LE)
 			return 0;
 		rd = op.reg;
-		do {
-			err = read_mem(&regs->gpr[rd], op.ea, 4, regs);
+		for (i = 0; i < size; i += 4) {
+			nb = size - i;
+			if (nb > 4)
+				nb = 4;
+			err = read_mem(&regs->gpr[rd], op.ea, nb, regs);
 			if (err)
 				return 0;
+			if (nb < 4)	/* left-justify last bytes */
+				regs->gpr[rd] <<= 32 - 8 * nb;
 			op.ea += 4;
-		} while (++rd < 32);
+			++rd;
+		}
 		goto instr_done;
 
 	case STORE:
@@ -1910,12 +1942,19 @@ int __kprobes emulate_step(struct pt_regs *regs, unsigned int instr)
 		if (regs->msr & MSR_LE)
 			return 0;
 		rd = op.reg;
-		do {
-			err = write_mem(regs->gpr[rd], op.ea, 4, regs);
+		for (i = 0; i < size; i += 4) {
+			val = regs->gpr[rd];
+			nb = size - i;
+			if (nb > 4)
+				nb = 4;
+			else
+				val >>= 32 - 8 * nb;
+			err = write_mem(val, op.ea, nb, regs);
 			if (err)
 				return 0;
 			op.ea += 4;
-		} while (++rd < 32);
+			++rd;
+		}
 		goto instr_done;
 
 	case MFMSR:
-- 
2.1.0.rc1
