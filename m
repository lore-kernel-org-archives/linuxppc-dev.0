Return-Path: <matthew.brown.dev@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x7LnW1h4dzDqk6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Jul 2017 13:26:07 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id q85so5473933pfq.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Jul 2017 20:26:07 -0700 (PDT)
From: Matt Brown <matthew.brown.dev@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: anton@samba.org
Subject: [PATCH 1/5] powerpc/lib/sstep: Add cmpb instruction emulation
Date: Thu, 13 Jul 2017 13:25:44 +1000
Message-Id: <20170713032548.451-1-matthew.brown.dev@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds emulation of the cmpb instruction, enabling xmon to
emulate this instruction.

Signed-off-by: Matt Brown <matthew.brown.dev@gmail.com>
---
 arch/powerpc/lib/sstep.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
index 33117f8..f3e9ba8 100644
--- a/arch/powerpc/lib/sstep.c
+++ b/arch/powerpc/lib/sstep.c
@@ -596,6 +596,23 @@ static nokprobe_inline void do_cmp_unsigned(struct pt_regs *regs, unsigned long
 	regs->ccr = (regs->ccr & ~(0xf << shift)) | (crval << shift);
 }
 
+static nokprobe_inline void do_cmpb(struct pt_regs *regs, unsigned long v1,
+				unsigned long v2, int rd)
+{
+	unsigned long out_val, mask;
+	int i;
+
+	out_val = 0;
+	for (i = 0; i < 8; i++) {
+		mask = 0xff << (i * 8);
+
+		if ((v1 & mask) == (v2 & mask))
+			out_val |= mask;
+	}
+
+	regs->gpr[rd] = out_val;
+}
+
 static nokprobe_inline int trap_compare(long v1, long v2)
 {
 	int ret = 0;
@@ -1049,6 +1066,13 @@ int analyse_instr(struct instruction_op *op, struct pt_regs *regs,
 			do_cmp_unsigned(regs, val, val2, rd >> 2);
 			goto instr_done;
 
+		case 19173952: /* cmpb */
+			val = regs->gpr[rd];
+			val2 = regs->gpr[rb];
+
+			do_cmpb(regs, val, val2, ra);
+			goto instr_done;
+
 /*
  * Arithmetic instructions
  */
-- 
2.9.3
