Return-Path: <matthew.brown.dev@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x7Lnc5hH8zDqkP
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Jul 2017 13:26:12 +1000 (AEST)
Received: by mail-pg0-x244.google.com with SMTP id y129so5265136pgy.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Jul 2017 20:26:12 -0700 (PDT)
From: Matt Brown <matthew.brown.dev@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: anton@samba.org
Subject: [PATCH 3/5] powerpc/lib/sstep: Add bpermd instruction emulation
Date: Thu, 13 Jul 2017 13:25:46 +1000
Message-Id: <20170713032548.451-3-matthew.brown.dev@gmail.com>
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

This adds emulation for the bpermd instruction.

Signed-off-by: Matt Brown <matthew.brown.dev@gmail.com>
---
 arch/powerpc/lib/sstep.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
index cf69987..603654d 100644
--- a/arch/powerpc/lib/sstep.c
+++ b/arch/powerpc/lib/sstep.c
@@ -637,6 +637,21 @@ static nokprobe_inline void do_popcnt(struct pt_regs *regs, unsigned long v1,
 	regs->gpr[ra] = out_val;
 }
 
+static nokprobe_inline void do_bpermd(struct pt_regs *regs, unsigned long v1,
+				unsigned long v2, int ra)
+{
+	unsigned int idx, i;
+	unsigned char perm;
+
+	perm = 0x0;
+	for (i = 0; i < 8; i++) {
+		idx = (v1 >> (i * 8)) & 0xff;
+		if (idx < 64)
+			perm |= (v2 & (1 << idx)) >> (idx - i);
+	}
+	regs->gpr[ra] = 0 | perm;
+}
+
 static nokprobe_inline int trap_compare(long v1, long v2)
 {
 	int ret = 0;
@@ -1274,6 +1289,14 @@ int analyse_instr(struct instruction_op *op, struct pt_regs *regs,
 			goto logical_done;
 #endif
 
+#ifdef __powerpc64__
+		case 2396736:	/* bpermd */
+			val = regs->gpr[rd];
+			val2 = regs->gpr[rb];
+			do_bpermd(regs, val, val2, ra);
+			goto logical_done;
+#endif
+
 /*
  * Shift instructions
  */
-- 
2.9.3
