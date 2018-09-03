Return-Path: <sandipan@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 423ttf3kdXzF37r
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Sep 2018 01:19:51 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w83FJ82U137492
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Sep 2018 11:19:49 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2m964fkj13-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Sep 2018 11:19:48 -0400
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sandipan@linux.ibm.com>;
 Mon, 3 Sep 2018 16:19:47 +0100
From: Sandipan Das <sandipan@linux.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org, anton@samba.org,
 naveen.n.rao@linux.vnet.ibm.com, ravi.bangoria@linux.ibm.com
Subject: [PATCH 1/6] powerpc sstep: Add maddhd, maddhdu,
 maddld instruction emulation
Date: Mon,  3 Sep 2018 20:49:33 +0530
In-Reply-To: <cover.1535609090.git.sandipan@linux.ibm.com>
References: <cover.1535609090.git.sandipan@linux.ibm.com>
In-Reply-To: <cover.1535609090.git.sandipan@linux.ibm.com>
References: <cover.1535609090.git.sandipan@linux.ibm.com>
Message-Id: <2962112510464de01b24f9e1014909fde3380d52.1535609090.git.sandipan@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This adds emulation support for the following integer instructions:
  * Multiply-Add High Doubleword (maddhd)
  * Multiply-Add High Doubleword Unsigned (maddhdu)
  * Multiply-Add Low Doubleword (maddld)

Signed-off-by: Sandipan Das <sandipan@linux.ibm.com>
---
 arch/powerpc/lib/sstep.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
index d81568f783e5..b40ec18515bd 100644
--- a/arch/powerpc/lib/sstep.c
+++ b/arch/powerpc/lib/sstep.c
@@ -1169,7 +1169,7 @@ static nokprobe_inline int trap_compare(long v1, long v2)
 int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
 		  unsigned int instr)
 {
-	unsigned int opcode, ra, rb, rd, spr, u;
+	unsigned int opcode, ra, rb, rc, rd, spr, u;
 	unsigned long int imm;
 	unsigned long int val, val2;
 	unsigned int mb, me, sh;
@@ -1292,6 +1292,7 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
 	rd = (instr >> 21) & 0x1f;
 	ra = (instr >> 16) & 0x1f;
 	rb = (instr >> 11) & 0x1f;
+	rc = (instr >> 6) & 0x1f;
 
 	switch (opcode) {
 #ifdef __powerpc64__
@@ -1305,6 +1306,38 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
 			goto trap;
 		return 1;
 
+#ifdef __powerpc64__
+	case 4:
+		if (!cpu_has_feature(CPU_FTR_ARCH_300))
+			return -1;
+
+		switch (instr & 0x3f) {
+		case 48:	/* maddhd */
+			asm("maddhd %0,%1,%2,%3" : "=r" (op->val) :
+			    "r" (regs->gpr[ra]), "r" (regs->gpr[rb]),
+			    "r" (regs->gpr[rc]));
+			goto compute_done;
+
+		case 49:	/* maddhdu */
+			asm("maddhdu %0,%1,%2,%3" : "=r" (op->val) :
+			    "r" (regs->gpr[ra]), "r" (regs->gpr[rb]),
+			    "r" (regs->gpr[rc]));
+			goto compute_done;
+
+		case 51:	/* maddld */
+			asm("maddld %0,%1,%2,%3" : "=r" (op->val) :
+			    "r" (regs->gpr[ra]), "r" (regs->gpr[rb]),
+			    "r" (regs->gpr[rc]));
+			goto compute_done;
+		}
+
+		/*
+		 * There are other instructions from ISA 3.0 with the same
+		 * primary opcode which do not have emulation support yet.
+		 */
+		return -1;
+#endif
+
 	case 7:		/* mulli */
 		op->val = regs->gpr[ra] * (short) instr;
 		goto compute_done;
-- 
2.14.4
