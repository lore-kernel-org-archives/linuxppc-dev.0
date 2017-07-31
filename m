Return-Path: <matthew.brown.dev@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xLLgV0spCzDrKQ
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Jul 2017 10:59:02 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id k72so21349542pfj.0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Jul 2017 17:59:02 -0700 (PDT)
Received: from matt.ozlabs.ibm.com ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id d127sm46851127pfa.171.2017.07.30.17.58.59
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 30 Jul 2017 17:59:00 -0700 (PDT)
From: Matt Brown <matthew.brown.dev@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4 3/5] powerpc/lib/sstep: Add bpermd instruction emulation
Date: Mon, 31 Jul 2017 10:58:24 +1000
Message-Id: <20170731005826.32044-3-matthew.brown.dev@gmail.com>
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

This adds emulation for the bpermd instruction.
Tested for correctness against the bpermd instruction on ppc64le.

Signed-off-by: Matt Brown <matthew.brown.dev@gmail.com>
---
v4:
	- change ifdef macro from __powerpc64__ to CONFIG_PPC64
v2:
	- fixed opcode
	- added ifdef tags to do_bpermd func
	- fixed bitshifting errors
---
 arch/powerpc/lib/sstep.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
index 2fd7377..c9fd613 100644
--- a/arch/powerpc/lib/sstep.c
+++ b/arch/powerpc/lib/sstep.c
@@ -640,6 +640,24 @@ static nokprobe_inline void do_popcnt(struct pt_regs *regs, unsigned long v1,
 	regs->gpr[ra] = out;	/* popcntd */
 }
 
+#ifdef CONFIG_PPC64
+static nokprobe_inline void do_bpermd(struct pt_regs *regs, unsigned long v1,
+				unsigned long v2, int ra)
+{
+	unsigned char perm, idx;
+	unsigned int i;
+
+	perm = 0;
+	for (i = 0; i < 8; i++) {
+		idx = (v1 >> (i * 8)) & 0xff;
+		if (idx < 64)
+			if (v2 & PPC_BIT(idx))
+				perm |= 1 << i;
+	}
+	regs->gpr[ra] = perm;
+}
+#endif /* CONFIG_PPC64 */
+
 static nokprobe_inline int trap_compare(long v1, long v2)
 {
 	int ret = 0;
@@ -1229,7 +1247,11 @@ int analyse_instr(struct instruction_op *op, struct pt_regs *regs,
 		case 124:	/* nor */
 			regs->gpr[ra] = ~(regs->gpr[rd] | regs->gpr[rb]);
 			goto logical_done;
-
+#ifdef CONFIG_PPC64
+		case 252:	/* bpermd */
+			do_bpermd(regs, regs->gpr[rd], regs->gpr[rb], ra);
+			goto logical_done;
+#endif
 		case 284:	/* xor */
 			regs->gpr[ra] = ~(regs->gpr[rd] ^ regs->gpr[rb]);
 			goto logical_done;
-- 
2.9.3
