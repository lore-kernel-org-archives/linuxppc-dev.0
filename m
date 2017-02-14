Return-Path: <ravi.bangoria@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vMxdN5Pm4zDqLk
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 20:17:12 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1E9E2d6046137
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 04:17:10 -0500
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [125.16.236.7])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28kxysrd5q-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 04:17:10 -0500
Received: from localhost
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ravi.bangoria@linux.vnet.ibm.com>;
 Tue, 14 Feb 2017 14:47:01 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 9F9C13940033
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 14:46:59 +0530 (IST)
Received: from d28av08.in.ibm.com (d28av08.in.ibm.com [9.184.220.148])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1E9Gx1o39977100
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 14:46:59 +0530
Received: from d28av08.in.ibm.com (localhost [127.0.0.1])
 by d28av08.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1E9GtOb021010
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 14:46:59 +0530
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 mpe@ellerman.id.au
Cc: benh@kernel.crashing.org, paulus@samba.org, lsorense@csclub.uwaterloo.ca,
 oohall@gmail.com, naveen.n.rao@linux.vnet.ibm.com, ast@kernel.org,
 chris@distroguy.com, aneesh.kumar@linux.vnet.ibm.com,
 bsingharora@gmail.com, anton@samba.org, paul.gortmaker@windriver.com,
 bauerman@linux.vnet.ibm.com, viro@zeniv.linux.org.uk,
 christophe.leroy@c-s.fr, duwe@lst.de, oss@buserror.net,
 Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: [PATCH v3 1/2] powerpc: Emulation support for load/store instructions
 on LE
Date: Tue, 14 Feb 2017 14:46:42 +0530
In-Reply-To: <1487063803-10848-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
References: <1487063803-10848-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
Message-Id: <1487063803-10848-2-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
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
 arch/powerpc/lib/sstep.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
index 846dba2..9c542ec 100644
--- a/arch/powerpc/lib/sstep.c
+++ b/arch/powerpc/lib/sstep.c
@@ -1799,8 +1799,6 @@ int __kprobes emulate_step(struct pt_regs *regs, unsigned int instr)
 		goto instr_done;
 
 	case LARX:
-		if (regs->msr & MSR_LE)
-			return 0;
 		if (op.ea & (size - 1))
 			break;		/* can't handle misaligned */
 		if (!address_ok(regs, op.ea, size))
@@ -1823,8 +1821,6 @@ int __kprobes emulate_step(struct pt_regs *regs, unsigned int instr)
 		goto ldst_done;
 
 	case STCX:
-		if (regs->msr & MSR_LE)
-			return 0;
 		if (op.ea & (size - 1))
 			break;		/* can't handle misaligned */
 		if (!address_ok(regs, op.ea, size))
@@ -1849,8 +1845,6 @@ int __kprobes emulate_step(struct pt_regs *regs, unsigned int instr)
 		goto ldst_done;
 
 	case LOAD:
-		if (regs->msr & MSR_LE)
-			return 0;
 		err = read_mem(&regs->gpr[op.reg], op.ea, size, regs);
 		if (!err) {
 			if (op.type & SIGNEXT)
@@ -1862,8 +1856,6 @@ int __kprobes emulate_step(struct pt_regs *regs, unsigned int instr)
 
 #ifdef CONFIG_PPC_FPU
 	case LOAD_FP:
-		if (regs->msr & MSR_LE)
-			return 0;
 		if (size == 4)
 			err = do_fp_load(op.reg, do_lfs, op.ea, size, regs);
 		else
@@ -1872,15 +1864,11 @@ int __kprobes emulate_step(struct pt_regs *regs, unsigned int instr)
 #endif
 #ifdef CONFIG_ALTIVEC
 	case LOAD_VMX:
-		if (regs->msr & MSR_LE)
-			return 0;
 		err = do_vec_load(op.reg, do_lvx, op.ea & ~0xfUL, regs);
 		goto ldst_done;
 #endif
 #ifdef CONFIG_VSX
 	case LOAD_VSX:
-		if (regs->msr & MSR_LE)
-			return 0;
 		err = do_vsx_load(op.reg, do_lxvd2x, op.ea, regs);
 		goto ldst_done;
 #endif
@@ -1903,8 +1891,6 @@ int __kprobes emulate_step(struct pt_regs *regs, unsigned int instr)
 		goto instr_done;
 
 	case STORE:
-		if (regs->msr & MSR_LE)
-			return 0;
 		if ((op.type & UPDATE) && size == sizeof(long) &&
 		    op.reg == 1 && op.update_reg == 1 &&
 		    !(regs->msr & MSR_PR) &&
@@ -1917,8 +1903,6 @@ int __kprobes emulate_step(struct pt_regs *regs, unsigned int instr)
 
 #ifdef CONFIG_PPC_FPU
 	case STORE_FP:
-		if (regs->msr & MSR_LE)
-			return 0;
 		if (size == 4)
 			err = do_fp_store(op.reg, do_stfs, op.ea, size, regs);
 		else
@@ -1927,15 +1911,11 @@ int __kprobes emulate_step(struct pt_regs *regs, unsigned int instr)
 #endif
 #ifdef CONFIG_ALTIVEC
 	case STORE_VMX:
-		if (regs->msr & MSR_LE)
-			return 0;
 		err = do_vec_store(op.reg, do_stvx, op.ea & ~0xfUL, regs);
 		goto ldst_done;
 #endif
 #ifdef CONFIG_VSX
 	case STORE_VSX:
-		if (regs->msr & MSR_LE)
-			return 0;
 		err = do_vsx_store(op.reg, do_stxvd2x, op.ea, regs);
 		goto ldst_done;
 #endif
-- 
1.8.3.1
