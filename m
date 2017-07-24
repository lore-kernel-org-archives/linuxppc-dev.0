Return-Path: <matthew.brown.dev@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xG33W5WyYzDrH7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Jul 2017 11:01:27 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id 1so1107418pfi.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Jul 2017 18:01:27 -0700 (PDT)
Received: from matt.ozlabs.ibm.com ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id i5sm22043976pgk.61.2017.07.23.18.01.23
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 23 Jul 2017 18:01:24 -0700 (PDT)
From: Matt Brown <matthew.brown.dev@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 2/5] powerpc/lib/sstep: Add popcnt instruction emulation
Date: Mon, 24 Jul 2017 11:01:06 +1000
Message-Id: <20170724010109.21263-2-matthew.brown.dev@gmail.com>
In-Reply-To: <20170724010109.21263-1-matthew.brown.dev@gmail.com>
References: <20170724010109.21263-1-matthew.brown.dev@gmail.com>
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
v2:
	- fixed opcodes
	- fixed typecasting
	- fixed bitshifting error for both 32 and 64bit arch
---
 arch/powerpc/lib/sstep.c | 43 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
index 87d277f..e6a16a3 100644
--- a/arch/powerpc/lib/sstep.c
+++ b/arch/powerpc/lib/sstep.c
@@ -612,6 +612,35 @@ static nokprobe_inline void do_cmpb(struct pt_regs *regs, unsigned long v1,
 	regs->gpr[rd] = out_val;
 }
 
+/*
+ * The size parameter is used to adjust the equivalent popcnt instruction.
+ * popcntb = 8, popcntw = 32, popcntd = 64
+ */
+static nokprobe_inline void do_popcnt(struct pt_regs *regs, unsigned long v1,
+				int size, int ra)
+{
+	unsigned long long high, low, mask;
+	unsigned int n;
+	int i, j;
+
+	high = 0;
+	low = 0;
+
+	for (i = 0; i < (64 / size); i++) {
+		n = 0;
+		for (j = 0; j < size; j++) {
+			mask = 1UL << (j + (i * size));
+			if (v1 & mask)
+				n++;
+		}
+		if ((i * size) < 32)
+			low |= n << (i * size);
+		else
+			high |= n << ((i * size) - 32);
+	}
+	regs->gpr[ra] = (high << 32) | low;
+}
+
 static nokprobe_inline int trap_compare(long v1, long v2)
 {
 	int ret = 0;
@@ -1194,6 +1223,10 @@ int analyse_instr(struct instruction_op *op, struct pt_regs *regs,
 			regs->gpr[ra] = regs->gpr[rd] & ~regs->gpr[rb];
 			goto logical_done;
 
+		case 122:	/* popcntb */
+			do_popcnt(regs, regs->gpr[rd], 8, ra);
+			goto logical_done;
+
 		case 124:	/* nor */
 			regs->gpr[ra] = ~(regs->gpr[rd] | regs->gpr[rb]);
 			goto logical_done;
@@ -1206,6 +1239,10 @@ int analyse_instr(struct instruction_op *op, struct pt_regs *regs,
 			regs->gpr[ra] = regs->gpr[rd] ^ regs->gpr[rb];
 			goto logical_done;
 
+		case 378:	/* popcntw */
+			do_popcnt(regs, regs->gpr[rd], 32, ra);
+			goto logical_done;
+
 		case 412:	/* orc */
 			regs->gpr[ra] = regs->gpr[rd] | ~regs->gpr[rb];
 			goto logical_done;
@@ -1217,7 +1254,11 @@ int analyse_instr(struct instruction_op *op, struct pt_regs *regs,
 		case 476:	/* nand */
 			regs->gpr[ra] = ~(regs->gpr[rd] & regs->gpr[rb]);
 			goto logical_done;
-
+#ifdef __powerpc64__
+		case 506:	/* popcntd */
+			do_popcnt(regs, regs->gpr[rd], 64, ra);
+			goto logical_done;
+#endif
 		case 922:	/* extsh */
 			regs->gpr[ra] = (signed short) regs->gpr[rd];
 			goto logical_done;
-- 
2.9.3
