Return-Path: <pedromfc@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 411qBD1XwWzF34D
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jun 2018 01:25:49 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w57FOi76076332
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Jun 2018 11:25:48 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2jf5q15em6-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 Jun 2018 11:25:47 -0400
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <pedromfc@linux.vnet.ibm.com>;
 Thu, 7 Jun 2018 09:25:47 -0600
Received: from b03ledav005.gho.boulder.ibm.com
 (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w57FPi2153805100
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Jun 2018 08:25:44 -0700
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A4989BE059
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jun 2018 09:25:44 -0600 (MDT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6F1F3BE05A
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jun 2018 09:25:44 -0600 (MDT)
Received: from pedro.localdomain (unknown [9.18.235.95])
 by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jun 2018 09:25:44 -0600 (MDT)
From: Pedro Franco de Carvalho <pedromfc@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH 2/5] powerpc: Flush checkpointed gpr state for 32-bit
 processes in ptrace
Date: Thu,  7 Jun 2018 12:25:31 -0300
In-Reply-To: <20180607152534.29427-1-pedromfc@linux.vnet.ibm.com>
References: <20180607152534.29427-1-pedromfc@linux.vnet.ibm.com>
Message-Id: <20180607152534.29427-3-pedromfc@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently ptrace doesn't flush the register state when the
checkpointed GPRs of a 32-bit thread are accessed. This can cause core
dumps to have stale data in the checkpointed GPR note.
---
 arch/powerpc/kernel/ptrace.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index 6618570c6d56..be8ca03a0bd5 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -2124,6 +2124,16 @@ static int tm_cgpr32_get(struct task_struct *target,
 		     unsigned int pos, unsigned int count,
 		     void *kbuf, void __user *ubuf)
 {
+	if (!cpu_has_feature(CPU_FTR_TM))
+		return -ENODEV;
+
+	if (!MSR_TM_ACTIVE(target->thread.regs->msr))
+		return -ENODATA;
+
+	flush_tmregs_to_thread(target);
+	flush_fp_to_thread(target);
+	flush_altivec_to_thread(target);
+
 	return gpr32_get_common(target, regset, pos, count, kbuf, ubuf,
 			&target->thread.ckpt_regs.gpr[0]);
 }
@@ -2133,6 +2143,16 @@ static int tm_cgpr32_set(struct task_struct *target,
 		     unsigned int pos, unsigned int count,
 		     const void *kbuf, const void __user *ubuf)
 {
+	if (!cpu_has_feature(CPU_FTR_TM))
+		return -ENODEV;
+
+	if (!MSR_TM_ACTIVE(target->thread.regs->msr))
+		return -ENODATA;
+
+	flush_tmregs_to_thread(target);
+	flush_fp_to_thread(target);
+	flush_altivec_to_thread(target);
+
 	return gpr32_set_common(target, regset, pos, count, kbuf, ubuf,
 			&target->thread.ckpt_regs.gpr[0]);
 }
-- 
2.13.6
