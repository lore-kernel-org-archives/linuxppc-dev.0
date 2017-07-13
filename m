Return-Path: <matthew.brown.dev@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x7Lnf3NXSzDqk8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Jul 2017 13:26:14 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id z6so5490240pfk.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Jul 2017 20:26:14 -0700 (PDT)
From: Matt Brown <matthew.brown.dev@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: anton@samba.org
Subject: [PATCH 4/5] powerpc/lib/sstep: Add prty instruction emulation
Date: Thu, 13 Jul 2017 13:25:47 +1000
Message-Id: <20170713032548.451-4-matthew.brown.dev@gmail.com>
In-Reply-To: <20170713032548.451-1-matthew.brown.dev@gmail.com>
References: <20170713032548.451-1-matthew.brown.dev@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This add emulation for the prtyw and prtyd instructions.

Signed-off-by: Matt Brown <matthew.brown.dev@gmail.com>
---
 arch/powerpc/lib/sstep.c | 58 +++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 52 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
index 603654d..3228783 100644
--- a/arch/powerpc/lib/sstep.c
+++ b/arch/powerpc/lib/sstep.c
@@ -652,6 +652,42 @@ static nokprobe_inline void do_bpermd(struct pt_regs *regs, unsigned long v1,
 	regs->gpr[ra] = 0 | perm;
 }
 
+static nokprobe_inline void do_prtyw(struct pt_regs *regs, unsigned long v,
+				int ra)
+{
+	unsigned long low, high, out;
+	unsigned int i;
+
+	high = 0;
+	low = 0;
+	out = 0;
+
+	for (i = 0; i < 8; i++) {
+		if (v & (1 << (i * 8)))
+			(i < 4) ? (low++) : (high++);
+	}
+
+	if (low % 2)
+		out |= low;
+	if (high % 2)
+		out |= (high << 32);
+
+	regs->gpr[ra] = out;
+}
+
+static nokprobe_inline void do_prtyd(struct pt_regs *regs, unsigned long v,
+				int ra)
+{
+	unsigned int count, i;
+
+	count = 0;
+	for (i = 0; i < 8; i++) {
+		if (v & (1 << (i * 8)))
+			count++;
+	}
+	regs->gpr[ra] = count % 2;
+}
+
 static nokprobe_inline int trap_compare(long v1, long v2)
 {
 	int ret = 0;
@@ -1278,16 +1314,15 @@ int analyse_instr(struct instruction_op *op, struct pt_regs *regs,
 			do_popcnt(regs, val, 8, ra);
 			goto logical_done;
 
-		case 17076744:	/* popcntw */
+		case 2101768:	/* prtyw */
 			val = regs->gpr[rd];
-			do_popcnt(regs, val, 32, ra);
+			do_prtyw(regs, val, ra);
 			goto logical_done;
-#ifdef __powerpc64__
-		case 19173896:	/* popcntd */
+
+		case 2134536:	/* prtyd */
 			val = regs->gpr[rd];
-			do_popcnt(regs, val, 64, ra);
+			do_prtyd(regs, val, ra);
 			goto logical_done;
-#endif
 
 #ifdef __powerpc64__
 		case 2396736:	/* bpermd */
@@ -1297,6 +1332,17 @@ int analyse_instr(struct instruction_op *op, struct pt_regs *regs,
 			goto logical_done;
 #endif
 
+		case 17076744:	/* popcntw */
+			val = regs->gpr[rd];
+			do_popcnt(regs, val, 32, ra);
+			goto logical_done;
+#ifdef __powerpc64__
+		case 19173896:	/* popcntd */
+			val = regs->gpr[rd];
+			do_popcnt(regs, val, 64, ra);
+			goto logical_done;
+#endif
+
 /*
  * Shift instructions
  */
-- 
2.9.3
