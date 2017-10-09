Return-Path: <sandipan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y9csQ5BWnzDqlv
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Oct 2017 22:07:38 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v99B7ZSk083711
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Oct 2017 07:07:35 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2dg5xwpdc3-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Oct 2017 07:07:35 -0400
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sandipan@linux.vnet.ibm.com>;
 Mon, 9 Oct 2017 12:07:33 +0100
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v99B7TjQ29687984
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Oct 2017 11:07:31 GMT
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v99B7XA2022852
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Oct 2017 22:07:33 +1100
From: Sandipan Das <sandipan@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: naveen.n.rao@linux.vnet.ibm.com, paulus@samba.org, anton@samba.org,
 segher@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/lib/sstep: Fix count leading zeros instructions
Date: Mon,  9 Oct 2017 16:37:26 +0530
Message-Id: <20171009110726.28551-1-sandipan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

According to the GCC documentation, the behaviour of __builtin_clz()
and __builtin_clzl() is undefined if the value of the input argument
is zero. Without handling this special case, these builtins have been
used for emulating the following instructions:
  * Count Leading Zeros Word (cntlzw[.])
  * Count Leading Zeros Doubleword (cntlzd[.])

This fixes the emulated behaviour of these instructions by adding an
additional check for this special case.

Signed-off-by: Sandipan Das <sandipan@linux.vnet.ibm.com>
---
 arch/powerpc/lib/sstep.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
index 0f7e41bd7e88..ebbc0b92650c 100644
--- a/arch/powerpc/lib/sstep.c
+++ b/arch/powerpc/lib/sstep.c
@@ -1717,11 +1717,19 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
  * Logical instructions
  */
 		case 26:	/* cntlzw */
-			op->val = __builtin_clz((unsigned int) regs->gpr[rd]);
+			val = (unsigned int) regs->gpr[rd];
+			if (val == 0)
+				op->val = 32;
+			else
+				op->val = __builtin_clz(val);
 			goto logical_done;
 #ifdef __powerpc64__
 		case 58:	/* cntlzd */
-			op->val = __builtin_clzl(regs->gpr[rd]);
+			val = regs->gpr[rd];
+			if (val == 0)
+				op->val = 64;
+			else
+				op->val = __builtin_clzl(val);
 			goto logical_done;
 #endif
 		case 28:	/* and */
-- 
2.13.6
