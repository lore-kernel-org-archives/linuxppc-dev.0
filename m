Return-Path: <matthew.brown.dev@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x7LnZ4x7XzDqk8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Jul 2017 13:26:10 +1000 (AEST)
Received: by mail-pg0-x241.google.com with SMTP id d193so5257500pgc.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Jul 2017 20:26:10 -0700 (PDT)
From: Matt Brown <matthew.brown.dev@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: anton@samba.org
Subject: [PATCH 2/5] powerpc/lib/sstep: Add popcnt instruction emulation
Date: Thu, 13 Jul 2017 13:25:45 +1000
Message-Id: <20170713032548.451-2-matthew.brown.dev@gmail.com>
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

This adds emulations for the popcntb, popcntw, and popcntd instructions.

Signed-off-by: Matt Brown <matthew.brown.dev@gmail.com>
---
 arch/powerpc/lib/sstep.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
index f3e9ba8..cf69987 100644
--- a/arch/powerpc/lib/sstep.c
+++ b/arch/powerpc/lib/sstep.c
@@ -613,6 +613,30 @@ static nokprobe_inline void do_cmpb(struct pt_regs *regs, unsigned long v1,
 	regs->gpr[rd] = out_val;
 }
 
+/*
+ * The size parameter is used to ajust the equivalent popcnt instruction.
+ * popcntb = 8, popcntw = 32, popcntd = 64
+ */
+static nokprobe_inline void do_popcnt(struct pt_regs *regs, unsigned long v1,
+				int size, int ra)
+{
+	unsigned int out_val, mask, n;
+	int i, j;
+
+	out_val = 0;
+
+	for (i = 0; i < (64 / size); i++) {
+		n = 0;
+		for (j = 0; j < size; j++) {
+			mask = 1 << (j + (i * size));
+			if (v1 & mask)
+				n++;
+		}
+		out_val |= n << (i * size);
+	}
+	regs->gpr[ra] = out_val;
+}
+
 static nokprobe_inline int trap_compare(long v1, long v2)
 {
 	int ret = 0;
@@ -1234,6 +1258,21 @@ int analyse_instr(struct instruction_op *op, struct pt_regs *regs,
 			regs->gpr[ra] = (signed int) regs->gpr[rd];
 			goto logical_done;
 #endif
+		case 299528:	/* popcntb */
+			val = regs->gpr[rd];
+			do_popcnt(regs, val, 8, ra);
+			goto logical_done;
+
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
 
 /*
  * Shift instructions
-- 
2.9.3
