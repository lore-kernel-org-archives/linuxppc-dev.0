Return-Path: <sandipan@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 423ttp1TtvzF37s
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Sep 2018 01:20:02 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w83FInuM071165
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Sep 2018 11:20:00 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2m96v41mt1-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Sep 2018 11:20:00 -0400
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sandipan@linux.ibm.com>;
 Mon, 3 Sep 2018 16:19:58 +0100
From: Sandipan Das <sandipan@linux.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org, anton@samba.org,
 naveen.n.rao@linux.vnet.ibm.com, ravi.bangoria@linux.ibm.com,
 PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Subject: [PATCH 5/6] powerpc sstep: Add modsw, moduw instruction emulation
Date: Mon,  3 Sep 2018 20:49:37 +0530
In-Reply-To: <cover.1535609090.git.sandipan@linux.ibm.com>
References: <cover.1535609090.git.sandipan@linux.ibm.com>
In-Reply-To: <cover.1535609090.git.sandipan@linux.ibm.com>
References: <cover.1535609090.git.sandipan@linux.ibm.com>
Message-Id: <f076148fadebfc7fb403ec4004c5d13154f1540b.1535609090.git.sandipan@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>

This adds emulation support for the following integer instructions:
  * Modulo Signed Word (modsw)
  * Modulo Unsigned Word (moduw)

Signed-off-by: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Signed-off-by: Sandipan Das <sandipan@linux.ibm.com>
---
 arch/powerpc/lib/sstep.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
index 828677df47b2..ddc2de28e00a 100644
--- a/arch/powerpc/lib/sstep.c
+++ b/arch/powerpc/lib/sstep.c
@@ -1708,6 +1708,13 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
 		case 266:	/* add */
 			op->val = regs->gpr[ra] + regs->gpr[rb];
 			goto arith_done;
+
+		case 267:	/* moduw */
+			if (!cpu_has_feature(CPU_FTR_ARCH_300))
+				return -1;
+			op->val = (unsigned int) regs->gpr[ra] %
+				(unsigned int) regs->gpr[rb];
+			goto compute_done;
 #ifdef __powerpc64__
 		case 457:	/* divdu */
 			op->val = regs->gpr[ra] / regs->gpr[rb];
@@ -1747,6 +1754,13 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
 
 			return -1;
 
+		case 779:	/* modsw */
+			if (!cpu_has_feature(CPU_FTR_ARCH_300))
+				return -1;
+			op->val = (int) regs->gpr[ra] %
+				(int) regs->gpr[rb];
+			goto compute_done;
+
 
 /*
  * Logical instructions
-- 
2.14.4
