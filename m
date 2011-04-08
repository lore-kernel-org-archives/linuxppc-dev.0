Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <0da62e04f0101a8f78f95f8c6859e3dafd76020c.1302249358.git.michael@ellerman.id.au>
In-Reply-To: <ca7cc2a36bbf492c11cd98d3d1dea0835731c75f.1302249358.git.michael@ellerman.id.au>
References: <ca7cc2a36bbf492c11cd98d3d1dea0835731c75f.1302249358.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 3/3] powerpc: Use MSR_64BIT in sstep.c, fix kprobes on BOOK3E
Date: Fri,  8 Apr 2011 17:56:04 +1000 (EST)
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We check MSR_SF a lot in sstep.c, to decide if we need to emulate the
truncation of values when running in 32-bit mode. Factor out that code
into a helper, and convert it and the other uses to use MSR_64BIT.

This fixes a bug on BOOK3E where kprobes would end up returning to a
32-bit address, because regs->nip was truncated, because (msr & MSR_SF)
was false.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/lib/sstep.c |   61 ++++++++++++++++++++-------------------------
 1 files changed, 27 insertions(+), 34 deletions(-)

diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
index ae5189a..0e5e540 100644
--- a/arch/powerpc/lib/sstep.c
+++ b/arch/powerpc/lib/sstep.c
@@ -45,6 +45,18 @@ extern int do_stxvd2x(int rn, unsigned long ea);
 #endif
 
 /*
+ * Emulate the truncation of 64 bit values in 32-bit mode.
+ */
+static unsigned long truncate_if_32bit(unsigned long msr, unsigned long val)
+{
+#ifdef __powerpc64__
+	if ((msr & MSR_64BIT) == 0)
+		val &= 0xffffffffUL;
+#endif
+	return val;
+}
+
+/*
  * Determine whether a conditional branch instruction would branch.
  */
 static int __kprobes branch_taken(unsigned int instr, struct pt_regs *regs)
@@ -90,11 +102,8 @@ static unsigned long __kprobes dform_ea(unsigned int instr, struct pt_regs *regs
 		if (instr & 0x04000000)		/* update forms */
 			regs->gpr[ra] = ea;
 	}
-#ifdef __powerpc64__
-	if (!(regs->msr & MSR_SF))
-		ea &= 0xffffffffUL;
-#endif
-	return ea;
+
+	return truncate_if_32bit(regs->msr, ea);
 }
 
 #ifdef __powerpc64__
@@ -113,9 +122,8 @@ static unsigned long __kprobes dsform_ea(unsigned int instr, struct pt_regs *reg
 		if ((instr & 3) == 1)		/* update forms */
 			regs->gpr[ra] = ea;
 	}
-	if (!(regs->msr & MSR_SF))
-		ea &= 0xffffffffUL;
-	return ea;
+
+	return truncate_if_32bit(regs->msr, ea);
 }
 #endif /* __powerpc64 */
 
@@ -136,11 +144,8 @@ static unsigned long __kprobes xform_ea(unsigned int instr, struct pt_regs *regs
 		if (do_update)		/* update forms */
 			regs->gpr[ra] = ea;
 	}
-#ifdef __powerpc64__
-	if (!(regs->msr & MSR_SF))
-		ea &= 0xffffffffUL;
-#endif
-	return ea;
+
+	return truncate_if_32bit(regs->msr, ea);
 }
 
 /*
@@ -466,7 +471,7 @@ static void __kprobes set_cr0(struct pt_regs *regs, int rd)
 
 	regs->ccr = (regs->ccr & 0x0fffffff) | ((regs->xer >> 3) & 0x10000000);
 #ifdef __powerpc64__
-	if (!(regs->msr & MSR_SF))
+	if (!(regs->msr & MSR_64BIT))
 		val = (int) val;
 #endif
 	if (val < 0)
@@ -487,7 +492,7 @@ static void __kprobes add_with_carry(struct pt_regs *regs, int rd,
 		++val;
 	regs->gpr[rd] = val;
 #ifdef __powerpc64__
-	if (!(regs->msr & MSR_SF)) {
+	if (!(regs->msr & MSR_64BIT)) {
 		val = (unsigned int) val;
 		val1 = (unsigned int) val1;
 	}
@@ -570,8 +575,7 @@ int __kprobes emulate_step(struct pt_regs *regs, unsigned int instr)
 		if ((instr & 2) == 0)
 			imm += regs->nip;
 		regs->nip += 4;
-		if ((regs->msr & MSR_SF) == 0)
-			regs->nip &= 0xffffffffUL;
+		regs->nip = truncate_if_32bit(regs->msr, regs->nip);
 		if (instr & 1)
 			regs->link = regs->nip;
 		if (branch_taken(instr, regs))
@@ -604,13 +608,9 @@ int __kprobes emulate_step(struct pt_regs *regs, unsigned int instr)
 			imm -= 0x04000000;
 		if ((instr & 2) == 0)
 			imm += regs->nip;
-		if (instr & 1) {
-			regs->link = regs->nip + 4;
-			if ((regs->msr & MSR_SF) == 0)
-				regs->link &= 0xffffffffUL;
-		}
-		if ((regs->msr & MSR_SF) == 0)
-			imm &= 0xffffffffUL;
+		if (instr & 1)
+			regs->link = truncate_if_32bit(regs->msr, regs->nip + 4);
+		imm = truncate_if_32bit(regs->msr, imm);
 		regs->nip = imm;
 		return 1;
 	case 19:
@@ -618,11 +618,8 @@ int __kprobes emulate_step(struct pt_regs *regs, unsigned int instr)
 		case 16:	/* bclr */
 		case 528:	/* bcctr */
 			imm = (instr & 0x400)? regs->ctr: regs->link;
-			regs->nip += 4;
-			if ((regs->msr & MSR_SF) == 0) {
-				regs->nip &= 0xffffffffUL;
-				imm &= 0xffffffffUL;
-			}
+			regs->nip = truncate_if_32bit(regs->msr, regs->nip + 4);
+			imm = truncate_if_32bit(regs->msr, imm);
 			if (instr & 1)
 				regs->link = regs->nip;
 			if (branch_taken(instr, regs))
@@ -1616,11 +1613,7 @@ int __kprobes emulate_step(struct pt_regs *regs, unsigned int instr)
 		return 0;	/* invoke DSI if -EFAULT? */
 	}
  instr_done:
-	regs->nip += 4;
-#ifdef __powerpc64__
-	if ((regs->msr & MSR_SF) == 0)
-		regs->nip &= 0xffffffffUL;
-#endif
+	regs->nip = truncate_if_32bit(regs->msr, regs->nip + 4);
 	return 1;
 
  logical_done:
-- 
1.7.1
