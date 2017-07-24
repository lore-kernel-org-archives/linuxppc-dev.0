Return-Path: <matthew.brown.dev@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xG33Z2WDWzDqxy
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Jul 2017 11:01:30 +1000 (AEST)
Received: by mail-pg0-x243.google.com with SMTP id g14so5590789pgu.4
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Jul 2017 18:01:30 -0700 (PDT)
Received: from matt.ozlabs.ibm.com ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id i5sm22043976pgk.61.2017.07.23.18.01.27
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 23 Jul 2017 18:01:27 -0700 (PDT)
From: Matt Brown <matthew.brown.dev@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 4/5] powerpc/lib/sstep: Add prty instruction emulation
Date: Mon, 24 Jul 2017 11:01:08 +1000
Message-Id: <20170724010109.21263-4-matthew.brown.dev@gmail.com>
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

This add emulation for the prtyw and prtyd instructions.
Tested for logical correctness against the prtyw and prtyd instructions
on ppc64le.

Signed-off-by: Matt Brown <matthew.brown.dev@gmail.com>
---
v2:
	- fixed opcodes
	- fixed bitshifting and typecast errors
	- merged do_prtyw and do_prtyd into single function
---
 arch/powerpc/lib/sstep.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
index a756f44..1820fd6 100644
--- a/arch/powerpc/lib/sstep.c
+++ b/arch/powerpc/lib/sstep.c
@@ -658,6 +658,29 @@ static nokprobe_inline void do_bpermd(struct pt_regs *regs, unsigned long v1,
 	regs->gpr[ra] = perm;
 }
 #endif /* __powerpc64__ */
+/*
+ * The size parameter adjusts the equivalent prty instruction.
+ * prtyw = 32, prtyd = 64
+ */
+static nokprobe_inline void do_prty(struct pt_regs *regs, unsigned long v,
+				int size, int ra)
+{
+	unsigned long long high, low;
+	unsigned int i;
+
+	high = 0;
+	low = 0;
+
+	for (i = 0; i < 8; i++) {
+		if (v & (1UL << (i * 8)))
+			(i < 4) ? (low++) : (high++);
+	}
+
+	if (size == 32)
+		regs->gpr[ra] = ((high & 1) << 32) | (low & 1);
+	else
+		regs->gpr[ra] = (high + low) & 1;
+}
 
 static nokprobe_inline int trap_compare(long v1, long v2)
 {
@@ -1248,6 +1271,14 @@ int analyse_instr(struct instruction_op *op, struct pt_regs *regs,
 		case 124:	/* nor */
 			regs->gpr[ra] = ~(regs->gpr[rd] | regs->gpr[rb]);
 			goto logical_done;
+
+		case 154:	/* prtyw */
+			do_prty(regs, regs->gpr[rd], 32, ra);
+			goto logical_done;
+
+		case 186:	/* prtyd */
+			do_prty(regs, regs->gpr[rd], 64, ra);
+			goto logical_done;
 #ifdef __powerpc64__
 		case 252:	/* bpermd */
 			do_bpermd(regs, regs->gpr[rd], regs->gpr[rb], ra);
-- 
2.9.3
