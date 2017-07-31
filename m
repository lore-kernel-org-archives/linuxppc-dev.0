Return-Path: <matthew.brown.dev@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xLLgN527nzDqyL
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Jul 2017 10:58:56 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id 72so4258883pfl.4
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Jul 2017 17:58:56 -0700 (PDT)
Received: from matt.ozlabs.ibm.com ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id d127sm46851127pfa.171.2017.07.30.17.58.53
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 30 Jul 2017 17:58:54 -0700 (PDT)
From: Matt Brown <matthew.brown.dev@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4 2/5] powerpc/lib/sstep: Add popcnt instruction emulation
Date: Mon, 31 Jul 2017 10:58:23 +1000
Message-Id: <20170731005826.32044-2-matthew.brown.dev@gmail.com>
In-Reply-To: <20170731005826.32044-1-matthew.brown.dev@gmail.com>
References: <20170731005826.32044-1-matthew.brown.dev@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This adds emulations for the popcntb, popcntw, and popcntd instructions.
Tested for correctness against the popcnt{b,w,d} instructions on ppc64le.

Signed-off-by: Matt Brown <matthew.brown.dev@gmail.com>
---
v4:
	- change ifdef macro from __powerpc64__ to CONFIG_PPC64
	- slight optimisations 
	(now identical to the popcntb implementation in kernel/traps.c)
v3:
	- optimised using the Giles-Miller method of side-ways addition
v2:
	- fixed opcodes
	- fixed typecasting
	- fixed bitshifting error for both 32 and 64bit arch
---
 arch/powerpc/lib/sstep.c | 42 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
index 87d277f..2fd7377 100644
--- a/arch/powerpc/lib/sstep.c
+++ b/arch/powerpc/lib/sstep.c
@@ -612,6 +612,34 @@ static nokprobe_inline void do_cmpb(struct pt_regs *regs, unsigned long v1,
 	regs->gpr[rd] = out_val;
 }
 
+/*
+ * The size parameter is used to adjust the equivalent popcnt instruction.
+ * popcntb = 8, popcntw = 32, popcntd = 64
+ */
+static nokprobe_inline void do_popcnt(struct pt_regs *regs, unsigned long v1,
+				int size, int ra)
+{
+	unsigned long long out = v1;
+
+	out -= (out >> 1) & 0x5555555555555555;
+	out = (0x3333333333333333 & out) + (0x3333333333333333 & (out >> 2));
+	out = (out + (out >> 4)) & 0x0f0f0f0f0f0f0f0f;
+
+	if (size == 8) {	/* popcntb */
+		regs->gpr[ra] = out;
+		return;
+	}
+	out += out >> 8;
+	out += out >> 16;
+	if (size == 32) {	/* popcntw */
+		regs->gpr[ra] = out & 0x0000003f0000003f;
+		return;
+	}
+
+	out = (out + (out >> 32)) & 0x7f;
+	regs->gpr[ra] = out;	/* popcntd */
+}
+
 static nokprobe_inline int trap_compare(long v1, long v2)
 {
 	int ret = 0;
@@ -1194,6 +1222,10 @@ int analyse_instr(struct instruction_op *op, struct pt_regs *regs,
 			regs->gpr[ra] = regs->gpr[rd] & ~regs->gpr[rb];
 			goto logical_done;
 
+		case 122:	/* popcntb */
+			do_popcnt(regs, regs->gpr[rd], 8, ra);
+			goto logical_done;
+
 		case 124:	/* nor */
 			regs->gpr[ra] = ~(regs->gpr[rd] | regs->gpr[rb]);
 			goto logical_done;
@@ -1206,6 +1238,10 @@ int analyse_instr(struct instruction_op *op, struct pt_regs *regs,
 			regs->gpr[ra] = regs->gpr[rd] ^ regs->gpr[rb];
 			goto logical_done;
 
+		case 378:	/* popcntw */
+			do_popcnt(regs, regs->gpr[rd], 32, ra);
+			goto logical_done;
+
 		case 412:	/* orc */
 			regs->gpr[ra] = regs->gpr[rd] | ~regs->gpr[rb];
 			goto logical_done;
@@ -1217,7 +1253,11 @@ int analyse_instr(struct instruction_op *op, struct pt_regs *regs,
 		case 476:	/* nand */
 			regs->gpr[ra] = ~(regs->gpr[rd] & regs->gpr[rb]);
 			goto logical_done;
-
+#ifdef CONFIG_PPC64
+		case 506:	/* popcntd */
+			do_popcnt(regs, regs->gpr[rd], 64, ra);
+			goto logical_done;
+#endif
 		case 922:	/* extsh */
 			regs->gpr[ra] = (signed short) regs->gpr[rd];
 			goto logical_done;
-- 
2.9.3
