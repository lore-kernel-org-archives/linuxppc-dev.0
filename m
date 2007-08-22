Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 66418DDF00
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Aug 2007 07:32:48 +1000 (EST)
Date: Wed, 22 Aug 2007 16:32:54 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: RFC: SPE misalignment handling framework
Message-ID: <Pine.LNX.4.64.0708221630450.5085@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is just to see if the modification to fix_alignment is ok with
people. Still need to fill in the actual implementation of emulate_spe().

diff --git a/arch/powerpc/kernel/align.c b/arch/powerpc/kernel/align.c
index 4c47f9c..a9fcf25 100644
--- a/arch/powerpc/kernel/align.c
+++ b/arch/powerpc/kernel/align.c
@@ -189,6 +189,76 @@ static struct aligninfo aligninfo[128] = {
 	INVALID,		/* 11 1 1111 */
 };

+#ifdef CONFIG_SPE
+static struct aligninfo spe_aligninfo[64] = {
+	{ 8, LD },		/* 0 00 00 0: evlddx */
+	{ 8, LD },		/* 0 00 00 1: evldd */
+	{ 8, LD },		/* 0 00 01 0: evldwx */
+	{ 8, LD },		/* 0 00 01 1: evldw */
+	{ 8, LD },		/* 0 00 10 0: evldhx */
+	{ 8, LD },		/* 0 00 10 1: evldh */
+	INVALID,		/* 0 00 11 0 */
+	INVALID,		/* 0 00 11 1 */
+	{ 2, LD },		/* 0 01 00 0: evlhhesplatx */
+	{ 2, LD },		/* 0 01 00 1: evlhhesplat */
+	INVALID,		/* 0 01 01 0 */
+	INVALID,		/* 0 01 01 1 */
+	{ 2, LD },		/* 0 01 10 0: evlhhousplatx */
+	{ 2, LD },		/* 0 01 10 1: evlhhousplat */
+	{ 2, LD },		/* 0 01 11 0: evlhhossplatx */
+	{ 2, LD },		/* 0 01 11 1: evlhhossplat */
+	{ 4, LD },		/* 0 10 00 0: evlwhex */
+	{ 4, LD },		/* 0 10 00 1: evlwhe */
+	INVALID,		/* 0 10 01 0 */
+	INVALID,		/* 0 10 01 1 */
+	{ 4, LD },		/* 0 10 10 0: evlwhoux */
+	{ 4, LD },		/* 0 10 10 1: evlwhou */
+	{ 4, LD },		/* 0 10 11 0: evlwhosx */
+	{ 4, LD },		/* 0 10 11 1: evlwhos */
+	{ 4, LD },		/* 0 11 00 0: evlwwsplatx */
+	{ 4, LD },		/* 0 11 00 1: evlwwsplat */
+	INVALID,		/* 0 11 01 0 */
+	INVALID,		/* 0 11 01 1 */
+	{ 4, LD },		/* 0 11 10 0: evlwhsplatx */
+	{ 4, LD },		/* 0 11 10 1: evlwhsplat */
+	INVALID,		/* 0 11 11 0 */
+	INVALID,		/* 0 11 11 1 */
+
+	{ 8, ST },		/* 1 00 00 0: evstddx */
+	{ 8, ST },		/* 1 00 00 1: evstdd */
+	{ 8, ST },		/* 1 00 01 0: evstdwx */
+	{ 8, ST },		/* 1 00 01 1: evstdw */
+	{ 8, ST },		/* 1 00 10 0: evstdhx */
+	{ 8, ST },		/* 1 00 10 1: evstdh */
+	INVALID,		/* 1 00 11 0 */
+	INVALID,		/* 1 00 11 1 */
+	INVALID,		/* 1 01 00 0 */
+	INVALID,		/* 1 01 00 1 */
+	INVALID,		/* 1 01 01 0 */
+	INVALID,		/* 1 01 01 1 */
+	INVALID,		/* 1 01 10 0 */
+	INVALID,		/* 1 01 10 1 */
+	INVALID,		/* 1 01 11 0 */
+	INVALID,		/* 1 01 11 1 */
+	{ 4, ST },		/* 1 10 00 0: evstwhex */
+	{ 4, ST },		/* 1 10 00 1: evstwhe */
+	INVALID,		/* 1 10 01 0 */
+	INVALID,		/* 1 10 01 1 */
+	{ 4, ST },		/* 1 10 10 0: evstwhoux */
+	{ 4, ST },		/* 1 10 10 1: evstwhou */
+	INVALID,		/* 1 10 11 0 */
+	INVALID,		/* 1 10 11 1 */
+	{ 4, ST },		/* 1 11 00 0: evstwwex */
+	{ 4, ST },		/* 1 11 00 1: evstwwe */
+	INVALID,		/* 1 11 01 0 */
+	INVALID,		/* 1 11 01 1 */
+	{ 4, ST },		/* 1 11 10 0: evstwwox */
+	{ 4, ST },		/* 1 11 10 1: evstwwo */
+	INVALID,		/* 1 11 11 0 */
+	INVALID,		/* 1 11 11 1 */
+};
+#endif
+
 /*
  * Create a DSISR value from the instruction
  */
@@ -392,6 +462,103 @@ static int emulate_fp_pair(struct pt_regs *regs, unsigned char __user *addr,
 	return 1;	/* exception handled and fixed up */
 }

+#ifdef CONFIG_SPE
+/*
+ * Emulate SPE loads and stores.
+ * Only Book-E has these instructions, and it does true little-endian,
+ * so we don't need the address swizzling.
+ */
+static int emulate_spe(struct pt_regs *regs, unsigned char __user *addr,
+		       unsigned int reg, unsigned int nb,
+		       unsigned int flags, unsigned int instr)
+{
+	int i, ret;
+
+	/* userland only */
+	if (unlikely(!user_mode(regs)))
+		return 0;
+
+	flush_spe_to_thread(current);
+
+
+	return 1;
+}
+#endif /* CONFIG_SPE */

 /*
  * Called on alignment exception. Attempts to fixup
@@ -408,7 +575,7 @@ int fix_alignment(struct pt_regs *regs)
 	unsigned int dsisr;
 	unsigned char __user *addr;
 	unsigned long p, swiz;
-	int ret, t;
+	int ret, t, is_spe = 0;
 	union {
 		u64 ll;
 		double dd;
@@ -445,17 +612,31 @@ int fix_alignment(struct pt_regs *regs)
 		if (cpu_has_feature(CPU_FTR_REAL_LE) && (regs->msr & MSR_LE))
 			instr = cpu_to_le32(instr);
 		dsisr = make_dsisr(instr);
+#ifdef CONFIG_SPE
+		if ((instr >> 26) == 0x4)
+			is_spe = 1;
+#endif
 	}

 	/* extract the operation and registers from the dsisr */
 	reg = (dsisr >> 5) & 0x1f;	/* source/dest register */
 	areg = dsisr & 0x1f;		/* register to update */
-	instr = (dsisr >> 10) & 0x7f;
-	instr |= (dsisr >> 13) & 0x60;
+	if (!is_spe) {
+		instr = (dsisr >> 10) & 0x7f;
+		instr |= (dsisr >> 13) & 0x60;

-	/* Lookup the operation in our table */
-	nb = aligninfo[instr].len;
-	flags = aligninfo[instr].flags;
+		/* Lookup the operation in our table */
+		nb = aligninfo[instr].len;
+		flags = aligninfo[instr].flags;
+	}
+#ifdef CONFIG_SPE
+	else {
+		instr &= 0x3f;
+		/* Lookup the operation in our table */
+		nb = spe_aligninfo[instr].len;
+		flags = spe_aligninfo[instr].flags;
+	}
+#endif

 	/* Byteswap little endian loads and stores */
 	swiz = 0;
@@ -507,6 +688,14 @@ int fix_alignment(struct pt_regs *regs)
 		flush_fp_to_thread(current);
 	}

+#ifdef CONFIG_SPE
+	/* Force the fprs into the save area so we can reference them */
+	if (is_spe) {
+		return emulate_spe(regs, addr, reg, nb, flags, instr);
+
+	}
+#endif
+
 	/* Special case for 16-byte FP loads and stores */
 	if (nb == 16)
 		return emulate_fp_pair(regs, addr, reg, flags);
