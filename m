Return-Path: <matthew.brown.dev@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xGkNn4qjpzDqpx
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jul 2017 13:33:45 +1000 (AEST)
Received: by mail-pg0-x243.google.com with SMTP id s4so13414973pgr.5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Jul 2017 20:33:45 -0700 (PDT)
Received: from matt.ozlabs.ibm.com ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id 13sm18671389pfm.123.2017.07.24.20.33.42
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 24 Jul 2017 20:33:43 -0700 (PDT)
From: Matt Brown <matthew.brown.dev@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 2/5] powerpc/lib/sstep: Add popcnt instruction emulation
Date: Tue, 25 Jul 2017 13:33:17 +1000
Message-Id: <20170725033320.17893-2-matthew.brown.dev@gmail.com>
In-Reply-To: <20170725033320.17893-1-matthew.brown.dev@gmail.com>
References: <20170725033320.17893-1-matthew.brown.dev@gmail.com>
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
v3:
	- optimised using the Giles-Miller method of side-ways addition
v2:
	- fixed opcodes
	- fixed typecasting
	- fixed bitshifting error for both 32 and 64bit arch
---
 arch/powerpc/lib/sstep.c | 40 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
index 87d277f..c1f9cdb 100644
--- a/arch/powerpc/lib/sstep.c
+++ b/arch/powerpc/lib/sstep.c
@@ -612,6 +612,32 @@ static nokprobe_inline void do_cmpb(struct pt_regs *regs, unsigned long v1,
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
+	out = (0x5555555555555555 & out) + (0x5555555555555555 & (out >> 1));
+	out = (0x3333333333333333 & out) + (0x3333333333333333 & (out >> 2));
+	out = (0x0f0f0f0f0f0f0f0f & out) + (0x0f0f0f0f0f0f0f0f & (out >> 4));
+	if (size == 8) {	/* popcntb */
+		regs->gpr[ra] = out;
+		return;
+	}
+	out = (0x001f001f001f001f & out) + (0x001f001f001f001f & (out >> 8));
+	out = (0x0000003f0000003f & out) + (0x0000003f0000003f & (out >> 16));
+	if (size == 32) {	/* popcntw */
+		regs->gpr[ra] = out;
+		return;
+	}
+	out = (0x000000000000007f & out) + (0x000000000000007f & (out >> 32));
+	regs->gpr[ra] = out;	/* popcntd */
+}
+
 static nokprobe_inline int trap_compare(long v1, long v2)
 {
 	int ret = 0;
@@ -1194,6 +1220,10 @@ int analyse_instr(struct instruction_op *op, struct pt_regs *regs,
 			regs->gpr[ra] = regs->gpr[rd] & ~regs->gpr[rb];
 			goto logical_done;
 
+		case 122:	/* popcntb */
+			do_popcnt(regs, regs->gpr[rd], 8, ra);
+			goto logical_done;
+
 		case 124:	/* nor */
 			regs->gpr[ra] = ~(regs->gpr[rd] | regs->gpr[rb]);
 			goto logical_done;
@@ -1206,6 +1236,10 @@ int analyse_instr(struct instruction_op *op, struct pt_regs *regs,
 			regs->gpr[ra] = regs->gpr[rd] ^ regs->gpr[rb];
 			goto logical_done;
 
+		case 378:	/* popcntw */
+			do_popcnt(regs, regs->gpr[rd], 32, ra);
+			goto logical_done;
+
 		case 412:	/* orc */
 			regs->gpr[ra] = regs->gpr[rd] | ~regs->gpr[rb];
 			goto logical_done;
@@ -1217,7 +1251,11 @@ int analyse_instr(struct instruction_op *op, struct pt_regs *regs,
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
