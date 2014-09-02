Return-Path: <paulus@samba.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 21C0F1A01E0
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Sep 2014 14:35:21 +1000 (EST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id D83341400DE
 for <linuxppc-dev@ozlabs.org>; Tue,  2 Sep 2014 14:35:20 +1000 (EST)
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/3] powerpc: Emulate icbi,
 mcrf and conditional-trap instructions
Date: Tue,  2 Sep 2014 14:35:08 +1000
Message-Id: <1409632509-32510-3-git-send-email-paulus@samba.org>
In-Reply-To: <1409632509-32510-1-git-send-email-paulus@samba.org>
References: <1409632509-32510-1-git-send-email-paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This extends the instruction emulation done by analyse_instr() and
emulate_step() to handle a few more instructions that are found in
the kernel.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/include/asm/sstep.h |  1 +
 arch/powerpc/lib/sstep.c         | 60 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+)

diff --git a/arch/powerpc/include/asm/sstep.h b/arch/powerpc/include/asm/sstep.h
index 1a693b1..d3a42cc 100644
--- a/arch/powerpc/include/asm/sstep.h
+++ b/arch/powerpc/include/asm/sstep.h
@@ -66,6 +66,7 @@ enum instruction_type {
 #define DCBF		0x100
 #define DCBTST		0x200
 #define DCBT		0x300
+#define ICBI		0x400
 
 /* Size field in type word */
 #define SIZE(n)		((n) << 8)
diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
index 3726a03..209a506 100644
--- a/arch/powerpc/lib/sstep.c
+++ b/arch/powerpc/lib/sstep.c
@@ -600,6 +600,23 @@ static void __kprobes do_cmp_unsigned(struct pt_regs *regs, unsigned long v1,
 	regs->ccr = (regs->ccr & ~(0xf << shift)) | (crval << shift);
 }
 
+static int __kprobes trap_compare(long v1, long v2)
+{
+	int ret = 0;
+
+	if (v1 < v2)
+		ret |= 0x10;
+	else if (v1 > v2)
+		ret |= 0x08;
+	else
+		ret |= 0x04;
+	if ((unsigned long)v1 < (unsigned long)v2)
+		ret |= 0x02;
+	else if ((unsigned long)v1 > (unsigned long)v2)
+		ret |= 0x01;
+	return ret;
+}
+
 /*
  * Elements of 32-bit rotate and mask instructions.
  */
@@ -669,6 +686,13 @@ int __kprobes analyse_instr(struct instruction_op *op, struct pt_regs *regs,
 		return 1;
 	case 19:
 		switch ((instr >> 1) & 0x3ff) {
+		case 0:		/* mcrf */
+			rd = (instr >> 21) & 0x1c;
+			ra = (instr >> 16) & 0x1c;
+			val = (regs->ccr >> ra) & 0xf;
+			regs->ccr = (regs->ccr & ~(0xfUL << rd)) | (val << rd);
+			goto instr_done;
+
 		case 16:	/* bclr */
 		case 528:	/* bcctr */
 			op->type = BRANCH;
@@ -745,6 +769,17 @@ int __kprobes analyse_instr(struct instruction_op *op, struct pt_regs *regs,
 	rb = (instr >> 11) & 0x1f;
 
 	switch (opcode) {
+#ifdef __powerpc64__
+	case 2:		/* tdi */
+		if (rd & trap_compare(regs->gpr[ra], (short) instr))
+			goto trap;
+		goto instr_done;
+#endif
+	case 3:		/* twi */
+		if (rd & trap_compare((int)regs->gpr[ra], (short) instr))
+			goto trap;
+		goto instr_done;
+
 	case 7:		/* mulli */
 		regs->gpr[rd] = regs->gpr[ra] * (short) instr;
 		goto instr_done;
@@ -893,6 +928,18 @@ int __kprobes analyse_instr(struct instruction_op *op, struct pt_regs *regs,
 
 	case 31:
 		switch ((instr >> 1) & 0x3ff) {
+		case 4:		/* tw */
+			if (rd == 0x1f ||
+			    (rd & trap_compare((int)regs->gpr[ra],
+					       (int)regs->gpr[rb])))
+				goto trap;
+			goto instr_done;
+#ifdef __powerpc64__
+		case 68:	/* td */
+			if (rd & trap_compare(regs->gpr[ra], regs->gpr[rb]))
+				goto trap;
+			goto instr_done;
+#endif
 		case 83:	/* mfmsr */
 			if (regs->msr & MSR_PR)
 				goto priv;
@@ -1269,6 +1316,11 @@ int __kprobes analyse_instr(struct instruction_op *op, struct pt_regs *regs,
 			op->ea = xform_ea(instr, regs);
 			op->reg = rd;
 			return 0;
+
+		case 982:	/* icbi */
+			op->type = MKOP(CACHEOP, ICBI, 0);
+			op->ea = xform_ea(instr, regs);
+			return 0;
 		}
 		break;
 	}
@@ -1597,6 +1649,11 @@ int __kprobes analyse_instr(struct instruction_op *op, struct pt_regs *regs,
 	op->val = SRR1_PROGPRIV;
 	return 0;
 
+ trap:
+	op->type = INTERRUPT | 0x700;
+	op->val = SRR1_PROGTRAP;
+	return 0;
+
 #ifdef CONFIG_PPC_FPU
  fpunavail:
 	op->type = INTERRUPT | 0x800;
@@ -1714,6 +1771,9 @@ int __kprobes emulate_step(struct pt_regs *regs, unsigned int instr)
 			if (op.reg == 0)
 				prefetch((void *) op.ea);
 			break;
+		case ICBI:
+			__cacheop_user_asmx(op.ea, err, "icbi");
+			break;
 		}
 		if (err)
 			return 0;
-- 
2.1.0.rc1
