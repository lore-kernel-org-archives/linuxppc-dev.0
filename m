Return-Path: <anton@samba.org>
Date: Fri, 28 Mar 2014 17:01:23 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, tommusta@gmail.com
Subject: [PATCH] powerpc: Add lq/stq emulation
Message-ID: <20140328170123.2df45d19@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Recent CPUs support quad word load and store instructions. Add
support to the alignment handler for them.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: b/arch/powerpc/include/asm/emulated_ops.h
===================================================================
--- a/arch/powerpc/include/asm/emulated_ops.h
+++ b/arch/powerpc/include/asm/emulated_ops.h
@@ -54,6 +54,7 @@ extern struct ppc_emulated {
 #ifdef CONFIG_PPC64
 	struct ppc_emulated_entry mfdscr;
 	struct ppc_emulated_entry mtdscr;
+	struct ppc_emulated_entry lq_stq;
 #endif
 } ppc_emulated;
 
Index: b/arch/powerpc/kernel/align.c
===================================================================
--- a/arch/powerpc/kernel/align.c
+++ b/arch/powerpc/kernel/align.c
@@ -73,7 +73,7 @@ static struct aligninfo aligninfo[128] =
 	{ 8, LD+F },		/* 00 0 1001: lfd */
 	{ 4, ST+F+S },		/* 00 0 1010: stfs */
 	{ 8, ST+F },		/* 00 0 1011: stfd */
-	INVALID,		/* 00 0 1100 */
+	{ 16, LD },		/* 00 0 1100: lq */
 	{ 8, LD },		/* 00 0 1101: ld/ldu/lwa */
 	INVALID,		/* 00 0 1110 */
 	{ 8, ST },		/* 00 0 1111: std/stdu */
@@ -140,7 +140,7 @@ static struct aligninfo aligninfo[128] =
 	{ 2, LD+SW },		/* 10 0 1100: lhbrx */
 	{ 4, LD+SE },		/* 10 0 1101  lwa */
 	{ 2, ST+SW },		/* 10 0 1110: sthbrx */
-	INVALID,		/* 10 0 1111 */
+	{ 16, ST },		/* 10 0 1111: stq */
 	INVALID,		/* 10 1 0000 */
 	INVALID,		/* 10 1 0001 */
 	INVALID,		/* 10 1 0010 */
@@ -385,8 +385,6 @@ static int emulate_fp_pair(unsigned char
 	char *ptr1 = (char *) &current->thread.TS_FPR(reg+1);
 	int i, ret, sw = 0;
 
-	if (!(flags & F))
-		return 0;
 	if (reg & 1)
 		return 0;	/* invalid form: FRS/FRT must be even */
 	if (flags & SW)
@@ -406,6 +404,32 @@ static int emulate_fp_pair(unsigned char
 	return 1;	/* exception handled and fixed up */
 }
 
+static int emulate_lq_stq(struct pt_regs *regs, unsigned char __user *addr,
+			  unsigned int reg, unsigned int flags)
+{
+	char *ptr0 = (char *)&regs->gpr[reg];
+	char *ptr1 = (char *)&regs->gpr[reg+1];
+	int i, ret, sw = 0;
+
+	if (reg & 1)
+		return 0;	/* invalid form: GPR must be even */
+	if (flags & SW)
+		sw = 7;
+	ret = 0;
+	for (i = 0; i < 8; ++i) {
+		if (!(flags & ST)) {
+			ret |= __get_user(ptr0[i^sw], addr + i);
+			ret |= __get_user(ptr1[i^sw], addr + i + 8);
+		} else {
+			ret |= __put_user(ptr0[i^sw], addr + i);
+			ret |= __put_user(ptr1[i^sw], addr + i + 8);
+		}
+	}
+	if (ret)
+		return -EFAULT;
+	return 1;	/* exception handled and fixed up */
+}
+
 #ifdef CONFIG_SPE
 
 static struct aligninfo spe_aligninfo[32] = {
@@ -914,10 +938,20 @@ int fix_alignment(struct pt_regs *regs)
 		flush_fp_to_thread(current);
 	}
 
-	/* Special case for 16-byte FP loads and stores */
-	if (nb == 16) {
-		PPC_WARN_ALIGNMENT(fp_pair, regs);
-		return emulate_fp_pair(addr, reg, flags);
+	if ((nb == 16)) {
+		if (flags & F) {
+			/* Special case for 16-byte FP loads and stores */
+			PPC_WARN_ALIGNMENT(fp_pair, regs);
+			return emulate_fp_pair(addr, reg, flags);
+		} else {
+#ifdef CONFIG_PPC64
+			/* Special case for 16-byte loads and stores */
+			PPC_WARN_ALIGNMENT(lq_stq, regs);
+			return emulate_lq_stq(regs, addr, reg, flags);
+#else
+			return 0;
+#endif
+		}
 	}
 
 	PPC_WARN_ALIGNMENT(unaligned, regs);
Index: b/arch/powerpc/kernel/traps.c
===================================================================
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -1868,6 +1868,7 @@ struct ppc_emulated ppc_emulated = {
 #ifdef CONFIG_PPC64
 	WARN_EMULATED_SETUP(mfdscr),
 	WARN_EMULATED_SETUP(mtdscr),
+	WARN_EMULATED_SETUP(lq_stq),
 #endif
 };
 
