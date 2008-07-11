Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: benh@kernel.crashing.org
MIME-Version: 1.0
Subject: [PATCH] powerpc: Add VSX load/store alignment exception handler
References: <18384.1215757752@neuling.org>
Date: Fri, 11 Jul 2008 16:31:09 +1000
Message-ID: <18822.1215757869@neuling.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

VSX loads and stores will take an alignment exception when the address
is not on a 4 byte boundary.  

This add support for these alignment exceptions and will emulate the
requested load or store.  

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
benh: for your 2.6.27 tree

 arch/powerpc/kernel/align.c |   58 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 57 insertions(+), 1 deletion(-)

Index: linux-2.6-ozlabs/arch/powerpc/kernel/align.c
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/kernel/align.c
+++ linux-2.6-ozlabs/arch/powerpc/kernel/align.c
@@ -48,6 +48,7 @@ struct aligninfo {
 #define HARD	0x80	/* string, stwcx. */
 #define E4	0x40	/* SPE endianness is word */
 #define E8	0x80	/* SPE endianness is double word */
+#define SPLT	0x80	/* VSX SPLAT load */
 
 /* DSISR bits reported for a DCBZ instruction: */
 #define DCBZ	0x5f	/* 8xx/82xx dcbz faults when cache not enabled */
@@ -637,6 +638,36 @@ static int emulate_spe(struct pt_regs *r
 }
 #endif /* CONFIG_SPE */
 
+#ifdef CONFIG_VSX
+/*
+ * Emulate VSX instructions...
+ */
+static int emulate_vsx(unsigned char __user *addr, unsigned int reg,
+		       unsigned int areg, struct pt_regs *regs,
+		       unsigned int flags, unsigned int length)
+{
+	char *ptr = (char *) &current->thread.TS_FPR(reg);
+	int ret;
+
+	flush_vsx_to_thread(current);
+
+	if (flags & ST)
+		ret = __copy_to_user(addr, ptr, length);
+        else {
+		if (flags & SPLT){
+			ret = __copy_from_user(ptr, addr, length);
+			ptr += length;
+		}
+		ret |= __copy_from_user(ptr, addr, length);
+	}
+	if (flags & U)
+		regs->gpr[areg] = regs->dar;
+	if (ret)
+		return -EFAULT;
+	return 1;
+}
+#endif
+
 /*
  * Called on alignment exception. Attempts to fixup
  *
@@ -647,7 +678,7 @@ static int emulate_spe(struct pt_regs *r
 
 int fix_alignment(struct pt_regs *regs)
 {
-	unsigned int instr, nb, flags;
+	unsigned int instr, nb, flags, instruction = 0;
 	unsigned int reg, areg;
 	unsigned int dsisr;
 	unsigned char __user *addr;
@@ -689,6 +720,7 @@ int fix_alignment(struct pt_regs *regs)
 		if (cpu_has_feature(CPU_FTR_REAL_LE) && (regs->msr & MSR_LE))
 			instr = cpu_to_le32(instr);
 		dsisr = make_dsisr(instr);
+		instruction = instr;
 	}
 
 	/* extract the operation and registers from the dsisr */
@@ -728,6 +760,30 @@ int fix_alignment(struct pt_regs *regs)
 	/* DAR has the operand effective address */
 	addr = (unsigned char __user *)regs->dar;
 
+#ifdef CONFIG_VSX
+	if ((instruction & 0xfc00003e) == 0x7c000018) {
+		/* Additional register addressing bit (64 VSX vs 32 FPR/GPR */
+		reg |= (instruction & 0x1) << 5;
+		/* Simple inline decoder instead of a table */
+		if (instruction & 0x200)
+			nb = 16;
+		else if (instruction & 0x080)
+			nb = 8;
+		else
+			nb = 4;
+		flags = 0;
+		if (instruction & 0x100)
+			flags |= ST;
+		if (instruction & 0x040)
+			flags |= U;
+		/* splat load needs a special decoder */
+		if ((instruction & 0x400) == 0){
+			flags |= SPLT;
+			nb = 8;
+		}
+		return emulate_vsx(addr, reg, areg, regs, flags, nb);
+	}
+#endif
 	/* A size of 0 indicates an instruction we don't support, with
 	 * the exception of DCBZ which is handled as a special case here
 	 */
