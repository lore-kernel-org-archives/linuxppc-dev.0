Return-Path: <ravi.bangoria@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vN4Yk54CXzDqKv
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2017 01:29:30 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1EESmkL017300
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 09:29:27 -0500
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0b-001b2d01.pphosted.com with ESMTP id 28m188etmm-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 09:29:25 -0500
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ravi.bangoria@linux.vnet.ibm.com>;
 Wed, 15 Feb 2017 00:29:22 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 0B3EB3578052
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2017 01:29:20 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1EETCJh23724252
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2017 01:29:20 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1EESkTp002615
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2017 01:28:48 +1100
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 mpe@ellerman.id.au
Cc: benh@kernel.crashing.org, paulus@samba.org, lsorense@csclub.uwaterloo.ca,
 oohall@gmail.com, naveen.n.rao@linux.vnet.ibm.com, ast@kernel.org,
 aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com,
 anton@samba.org, paul.gortmaker@windriver.com,
 bauerman@linux.vnet.ibm.com, viro@zeniv.linux.org.uk,
 christophe.leroy@c-s.fr, duwe@lst.de, oss@buserror.net,
 Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: [PATCH v4 1/2] powerpc: Emulation support for load/store instructions
 on LE
Date: Tue, 14 Feb 2017 19:58:07 +0530
In-Reply-To: <1487082488-5624-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
References: <1487082488-5624-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
Message-Id: <1487082488-5624-2-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
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
