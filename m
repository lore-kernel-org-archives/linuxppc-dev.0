Return-Path: <ravi.bangoria@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3szzVv4f49zDvV5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Oct 2016 17:32:07 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u9K6VtAe095411
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Oct 2016 02:32:05 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0a-001b2d01.pphosted.com with ESMTP id 266mej1hr7-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Oct 2016 02:32:05 -0400
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ravi.bangoria@linux.vnet.ibm.com>;
 Thu, 20 Oct 2016 16:32:03 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id AA2F22CE8046
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Oct 2016 17:32:00 +1100 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u9K6W0ex17498120
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Oct 2016 17:32:00 +1100
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u9K6VxD4026390
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Oct 2016 17:32:00 +1100
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 mpe@ellerman.id.au
Cc: anton@samba.org, benh@kernel.crashing.org, paulus@samba.org,
 oohall@gmail.com, lsorense@csclub.uwaterloo.ca,
 naveen.n.rao@linux.vnet.ibm.com, stable@vger.kernel.org,
 Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: [RFC] ppc64le: Enable emulation support for simple Load/Store
 instructions
Date: Thu, 20 Oct 2016 12:01:55 +0530
Message-Id: <1476945115-4723-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

emulate_step() uses a number of underlying kernel functions that were
initially not enabled for LE. This has been rectified since. So, fix
emulate_step() for LE for the corresponding instructions.

Reported-by: Anton Blanchard <anton@samba.org>
Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
---
Note: This patch only enables LOAD, STORE, LARX and STCX instructions.
      I'll send a subsequent patch for other types like LOAD_FP,
      LOAD_VMX etc.

 arch/powerpc/lib/sstep.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
index 3362299..82323ef 100644
--- a/arch/powerpc/lib/sstep.c
+++ b/arch/powerpc/lib/sstep.c
@@ -1807,8 +1807,6 @@ int __kprobes emulate_step(struct pt_regs *regs, unsigned int instr)
 		goto instr_done;
 
 	case LARX:
-		if (regs->msr & MSR_LE)
-			return 0;
 		if (op.ea & (size - 1))
 			break;		/* can't handle misaligned */
 		err = -EFAULT;
@@ -1832,8 +1830,6 @@ int __kprobes emulate_step(struct pt_regs *regs, unsigned int instr)
 		goto ldst_done;
 
 	case STCX:
-		if (regs->msr & MSR_LE)
-			return 0;
 		if (op.ea & (size - 1))
 			break;		/* can't handle misaligned */
 		err = -EFAULT;
@@ -1859,8 +1855,6 @@ int __kprobes emulate_step(struct pt_regs *regs, unsigned int instr)
 		goto ldst_done;
 
 	case LOAD:
-		if (regs->msr & MSR_LE)
-			return 0;
 		err = read_mem(&regs->gpr[op.reg], op.ea, size, regs);
 		if (!err) {
 			if (op.type & SIGNEXT)
@@ -1913,8 +1907,6 @@ int __kprobes emulate_step(struct pt_regs *regs, unsigned int instr)
 		goto instr_done;
 
 	case STORE:
-		if (regs->msr & MSR_LE)
-			return 0;
 		if ((op.type & UPDATE) && size == sizeof(long) &&
 		    op.reg == 1 && op.update_reg == 1 &&
 		    !(regs->msr & MSR_PR) &&
-- 
1.8.3.1
