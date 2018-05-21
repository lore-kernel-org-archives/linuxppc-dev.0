Return-Path: <ravi.bangoria@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40q5FN0nlwzF0dS
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 May 2018 14:21:27 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4L4J4H9065015
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 May 2018 00:21:25 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2j3jk3ygp1-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 May 2018 00:21:25 -0400
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ravi.bangoria@linux.ibm.com>;
 Mon, 21 May 2018 05:21:23 +0100
From: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To: mpe@ellerman.id.au, mikey@neuling.org
Cc: benh@kernel.crashing.org, paulus@samba.org,
 naveen.n.rao@linux.vnet.ibm.com, matthew.brown.dev@gmail.com,
 cyrilbur@gmail.com, anton@samba.org, sandipan@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: [PATCH 1/3] powerpc/sstep: Introduce GETTYPE macro
Date: Mon, 21 May 2018 09:51:06 +0530
In-Reply-To: <20180521042108.8318-1-ravi.bangoria@linux.ibm.com>
References: <20180521042108.8318-1-ravi.bangoria@linux.ibm.com>
Message-Id: <20180521042108.8318-2-ravi.bangoria@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Replace 'op->type & INSTR_TYPE_MASK' expression with GETTYPE(op->type)
macro.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
 arch/powerpc/include/asm/sstep.h | 2 ++
 arch/powerpc/kernel/align.c      | 2 +-
 arch/powerpc/lib/sstep.c         | 6 +++---
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/sstep.h b/arch/powerpc/include/asm/sstep.h
index ab9d849644d0..9a2dfee26f9f 100644
--- a/arch/powerpc/include/asm/sstep.h
+++ b/arch/powerpc/include/asm/sstep.h
@@ -97,6 +97,8 @@ enum instruction_type {
 #define SIZE(n)		((n) << 12)
 #define GETSIZE(w)	((w) >> 12)
 
+#define GETTYPE(t)	((t) & INSTR_TYPE_MASK)
+
 #define MKOP(t, f, s)	((t) | (f) | SIZE(s))
 
 struct instruction_op {
diff --git a/arch/powerpc/kernel/align.c b/arch/powerpc/kernel/align.c
index 3e6c0744c174..11550a3d1ac2 100644
--- a/arch/powerpc/kernel/align.c
+++ b/arch/powerpc/kernel/align.c
@@ -339,7 +339,7 @@ int fix_alignment(struct pt_regs *regs)
 	if (r < 0)
 		return -EINVAL;
 
-	type = op.type & INSTR_TYPE_MASK;
+	type = GETTYPE(op.type);
 	if (!OP_IS_LOAD_STORE(type)) {
 		if (op.type != CACHEOP + DCBZ)
 			return -EINVAL;
diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
index 34d68f1b1b40..db6bba259d91 100644
--- a/arch/powerpc/lib/sstep.c
+++ b/arch/powerpc/lib/sstep.c
@@ -2641,7 +2641,7 @@ void emulate_update_regs(struct pt_regs *regs, struct instruction_op *op)
 	unsigned long next_pc;
 
 	next_pc = truncate_if_32bit(regs->msr, regs->nip + 4);
-	switch (op->type & INSTR_TYPE_MASK) {
+	switch (GETTYPE(op->type)) {
 	case COMPUTE:
 		if (op->type & SETREG)
 			regs->gpr[op->reg] = op->val;
@@ -2739,7 +2739,7 @@ int emulate_loadstore(struct pt_regs *regs, struct instruction_op *op)
 
 	err = 0;
 	size = GETSIZE(op->type);
-	type = op->type & INSTR_TYPE_MASK;
+	type = GETTYPE(op->type);
 	cross_endian = (regs->msr & MSR_LE) != (MSR_KERNEL & MSR_LE);
 	ea = truncate_if_32bit(regs->msr, op->ea);
 
@@ -3001,7 +3001,7 @@ int emulate_step(struct pt_regs *regs, unsigned int instr)
 	}
 
 	err = 0;
-	type = op.type & INSTR_TYPE_MASK;
+	type = GETTYPE(op.type);
 
 	if (OP_IS_LOAD_STORE(type)) {
 		err = emulate_loadstore(regs, &op);
-- 
2.16.2
