Return-Path: <matthew.brown.dev@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xG33T2WfrzDrHD
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Jul 2017 11:01:25 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id s4so10278054pgr.5
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Jul 2017 18:01:25 -0700 (PDT)
Received: from matt.ozlabs.ibm.com ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id i5sm22043976pgk.61.2017.07.23.18.01.21
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 23 Jul 2017 18:01:22 -0700 (PDT)
From: Matt Brown <matthew.brown.dev@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 1/5] powerpc/lib/sstep: Add cmpb instruction emulation
Date: Mon, 24 Jul 2017 11:01:05 +1000
Message-Id: <20170724010109.21263-1-matthew.brown.dev@gmail.com>
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
Tested for correctness against the cmpb asm instruction on ppc64le.

Signed-off-by: Matt Brown <matthew.brown.dev@gmail.com>
---
v2: 
	- fixed opcode
	- fixed mask typecasting
---
 arch/powerpc/lib/sstep.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
index 33117f8..87d277f 100644
--- a/arch/powerpc/lib/sstep.c
+++ b/arch/powerpc/lib/sstep.c
@@ -596,6 +596,22 @@ static nokprobe_inline void do_cmp_unsigned(struct pt_regs *regs, unsigned long
 	regs->ccr = (regs->ccr & ~(0xf << shift)) | (crval << shift);
 }
 
+static nokprobe_inline void do_cmpb(struct pt_regs *regs, unsigned long v1,
+				unsigned long v2, int rd)
+{
+	unsigned long long out_val, mask;
+	int i;
+
+	out_val = 0;
+	for (i = 0; i < 8; i++) {
+		mask = 0xffUL << (i * 8);
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
@@ -1049,6 +1065,10 @@ int analyse_instr(struct instruction_op *op, struct pt_regs *regs,
 			do_cmp_unsigned(regs, val, val2, rd >> 2);
 			goto instr_done;
 
+		case 508: /* cmpb */
+			do_cmpb(regs, regs->gpr[rd], regs->gpr[rb], ra);
+			goto instr_done;
+
 /*
  * Arithmetic instructions
  */
-- 
2.9.3
