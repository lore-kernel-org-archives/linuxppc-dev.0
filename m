Return-Path: <matthew.brown.dev@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xGkNw4rkSzDqvB
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jul 2017 13:33:52 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id y129so13381393pgy.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Jul 2017 20:33:52 -0700 (PDT)
Received: from matt.ozlabs.ibm.com ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id 13sm18671389pfm.123.2017.07.24.20.33.49
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 24 Jul 2017 20:33:50 -0700 (PDT)
From: Matt Brown <matthew.brown.dev@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 4/5] powerpc/lib/sstep: Add prty instruction emulation
Date: Tue, 25 Jul 2017 13:33:19 +1000
Message-Id: <20170725033320.17893-4-matthew.brown.dev@gmail.com>
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

This adds emulation for the prtyw and prtyd instructions.
Tested for logical correctness against the prtyw and prtyd instructions
on ppc64le.

Signed-off-by: Matt Brown <matthew.brown.dev@gmail.com>
---
v3:
	- optimised using the Giles-Miller method of side-ways addition
v2:
	- fixed opcodes
	- fixed bitshifting and typecast errors
	- merged do_prtyw and do_prtyd into single function
---
 arch/powerpc/lib/sstep.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
index 6a79618..0bcf631 100644
--- a/arch/powerpc/lib/sstep.c
+++ b/arch/powerpc/lib/sstep.c
@@ -655,6 +655,25 @@ static nokprobe_inline void do_bpermd(struct pt_regs *regs, unsigned long v1,
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
+	unsigned long long res = v;
+
+	res = (0x0001000100010001 & res) + (0x0001000100010001 & (res >> 8));
+	res = (0x0000000700000007 & res) + (0x0000000700000007 & (res >> 16));
+	if (size == 32) {		/* prtyw */
+		regs->gpr[ra] = (0x0000000100000001 & res);
+		return;
+	}
+
+	res = (0x000000000000000f & res) + (0x000000000000000f & (res >> 32));
+	regs->gpr[ra] = res & 1;	/*prtyd */
+}
 
 static nokprobe_inline int trap_compare(long v1, long v2)
 {
@@ -1245,6 +1264,14 @@ int analyse_instr(struct instruction_op *op, struct pt_regs *regs,
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
