Return-Path: <sandipan@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 423ttr1DBGzF37r
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Sep 2018 01:20:04 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w83FJ49x009565
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Sep 2018 11:20:01 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2m94gs7mw6-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Sep 2018 11:20:01 -0400
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sandipan@linux.ibm.com>;
 Mon, 3 Sep 2018 16:19:59 +0100
From: Sandipan Das <sandipan@linux.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org, anton@samba.org,
 naveen.n.rao@linux.vnet.ibm.com, ravi.bangoria@linux.ibm.com
Subject: [PATCH 6/6] powerpc sstep: Add modsd, modud instruction emulation
Date: Mon,  3 Sep 2018 20:49:38 +0530
In-Reply-To: <cover.1535609090.git.sandipan@linux.ibm.com>
References: <cover.1535609090.git.sandipan@linux.ibm.com>
In-Reply-To: <cover.1535609090.git.sandipan@linux.ibm.com>
References: <cover.1535609090.git.sandipan@linux.ibm.com>
Message-Id: <15e572f61bb5c74b01210b9245ce2750a31d6002.1535609090.git.sandipan@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This adds emulation support for the following integer instructions:
  * Modulo Signed Doubleword (modsd)
  * Modulo Unsigned Doubleword (modud)

Signed-off-by: Sandipan Das <sandipan@linux.ibm.com>
---
 arch/powerpc/lib/sstep.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
index ddc2de28e00a..b3b508d175fb 100644
--- a/arch/powerpc/lib/sstep.c
+++ b/arch/powerpc/lib/sstep.c
@@ -1704,7 +1704,13 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
 				(int) regs->gpr[rb];
 
 			goto arith_done;
-
+#ifdef __powerpc64__
+		case 265:	/* modud */
+			if (!cpu_has_feature(CPU_FTR_ARCH_300))
+				return -1;
+			op->val = regs->gpr[ra] % regs->gpr[rb];
+			goto compute_done;
+#endif
 		case 266:	/* add */
 			op->val = regs->gpr[ra] + regs->gpr[rb];
 			goto arith_done;
@@ -1753,7 +1759,14 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
 			}
 
 			return -1;
-
+#ifdef __powerpc64__
+		case 777:	/* modsd */
+			if (!cpu_has_feature(CPU_FTR_ARCH_300))
+				return -1;
+			op->val = (long int) regs->gpr[ra] %
+				(long int) regs->gpr[rb];
+			goto compute_done;
+#endif
 		case 779:	/* modsw */
 			if (!cpu_has_feature(CPU_FTR_ARCH_300))
 				return -1;
-- 
2.14.4
