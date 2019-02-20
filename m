Return-Path: <SRS0=+mMX=Q3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D4CC43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 07:00:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B6012087B
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 07:00:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B6012087B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4447m71QXBzDqHv
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 18:00:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=sandipan@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4447hC4PxSzDqGT
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Feb 2019 17:57:15 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1K6pIlo115688
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Feb 2019 01:57:13 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2qs200r72c-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Feb 2019 01:57:13 -0500
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sandipan@linux.ibm.com>;
 Wed, 20 Feb 2019 06:57:11 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 20 Feb 2019 06:57:07 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x1K6v6Gl40108092
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 20 Feb 2019 06:57:06 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1465CAE051;
 Wed, 20 Feb 2019 06:57:06 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DF556AE045;
 Wed, 20 Feb 2019 06:57:04 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.195.22.129])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 20 Feb 2019 06:57:04 +0000 (GMT)
From: Sandipan Das <sandipan@linux.ibm.com>
To: mpe@ellerman.id.au
Subject: [PATCH 1/3] powerpc: sstep: Add tests for compute type instructions
Date: Wed, 20 Feb 2019 12:26:58 +0530
X-Mailer: git-send-email 2.19.2
In-Reply-To: <cover.1550645549.git.sandipan@linux.ibm.com>
References: <cover.1550645549.git.sandipan@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19022006-0028-0000-0000-0000034AAD28
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022006-0029-0000-0000-00002408EBA3
Message-Id: <df7e1d69a6ac2ec3db8bb5481431d8ad8a28157a.1550645549.git.sandipan@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-20_06:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902200048
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: naveen.n.rao@linux.ibm.com, paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
 ravi.bangoria@linux.ibm.com, dja@axtens.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This enhances the current selftest framework for validating
the in-kernel instruction emulation infrastructure by adding
support for compute type instructions i.e. integer ALU-based
instructions. Originally, this framework was limited to only
testing load and store instructions.

While most of the GPRs can be validated, support for SPRs is
limited to LR, CR and XER for now.

When writing the test cases, one must ensure that the Stack
Pointer (GPR1) or the Thread Pointer (GPR13) are not touched
by any means as these are vital non-volatile registers.

Signed-off-by: Sandipan Das <sandipan@linux.ibm.com>
---
 arch/powerpc/lib/Makefile                     |   3 +-
 arch/powerpc/lib/test_emulate_step.c          | 167 +++++++++++++++++-
 .../lib/test_emulate_step_exec_instr.S        | 150 ++++++++++++++++
 3 files changed, 315 insertions(+), 5 deletions(-)
 create mode 100644 arch/powerpc/lib/test_emulate_step_exec_instr.S

diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
index 3bf9fc6fd36c..79396e184bca 100644
--- a/arch/powerpc/lib/Makefile
+++ b/arch/powerpc/lib/Makefile
@@ -30,7 +30,8 @@ obj64-y	+= copypage_64.o copyuser_64.o mem_64.o hweight_64.o \
 
 obj64-$(CONFIG_SMP)	+= locks.o
 obj64-$(CONFIG_ALTIVEC)	+= vmx-helper.o
-obj64-$(CONFIG_KPROBES_SANITY_TEST) += test_emulate_step.o
+obj64-$(CONFIG_KPROBES_SANITY_TEST)	+= test_emulate_step.o \
+					   test_emulate_step_exec_instr.o
 
 obj-y			+= checksum_$(BITS).o checksum_wrappers.o \
 			   string_$(BITS).o memcmp_$(BITS).o
diff --git a/arch/powerpc/lib/test_emulate_step.c b/arch/powerpc/lib/test_emulate_step.c
index 6c47daa61614..3d7f7bae51cc 100644
--- a/arch/powerpc/lib/test_emulate_step.c
+++ b/arch/powerpc/lib/test_emulate_step.c
@@ -1,5 +1,5 @@
 /*
- * Simple sanity test for emulate_step load/store instructions.
+ * Simple sanity tests for instruction emulation infrastructure.
  *
  * Copyright IBM Corp. 2016
  *
@@ -14,6 +14,7 @@
 #include <linux/ptrace.h>
 #include <asm/sstep.h>
 #include <asm/ppc-opcode.h>
+#include <asm/code-patching.h>
 
 #define IMM_L(i)		((uintptr_t)(i) & 0xffff)
 
@@ -49,6 +50,11 @@
 #define TEST_LXVD2X(s, a, b)	(PPC_INST_LXVD2X | VSX_XX1((s), R##a, R##b))
 #define TEST_STXVD2X(s, a, b)	(PPC_INST_STXVD2X | VSX_XX1((s), R##a, R##b))
 
+#define MAX_SUBTESTS	16
+
+#define IGNORE_GPR(n)	(0x1UL << (n))
+#define IGNORE_XER	(0x1UL << 32)
+#define IGNORE_CCR	(0x1UL << 33)
 
 static void __init init_pt_regs(struct pt_regs *regs)
 {
@@ -72,9 +78,15 @@ static void __init init_pt_regs(struct pt_regs *regs)
 	msr_cached = true;
 }
 
-static void __init show_result(char *ins, char *result)
+static void __init show_result(char *mnemonic, char *result)
 {
-	pr_info("%-14s : %s\n", ins, result);
+	pr_info("%-14s : %s\n", mnemonic, result);
+}
+
+static void __init show_result_with_descr(char *mnemonic, char *descr,
+					  char *result)
+{
+	pr_info("%-14s : %-50s %s\n", mnemonic, descr, result);
 }
 
 static void __init test_ld(void)
@@ -426,7 +438,7 @@ static void __init test_lxvd2x_stxvd2x(void)
 }
 #endif /* CONFIG_VSX */
 
-static int __init test_emulate_step(void)
+static void __init run_tests_load_store(void)
 {
 	test_ld();
 	test_lwz();
@@ -437,6 +449,153 @@ static int __init test_emulate_step(void)
 	test_lfdx_stfdx();
 	test_lvx_stvx();
 	test_lxvd2x_stxvd2x();
+}
+
+struct compute_test {
+	char *mnemonic;
+	struct {
+		char *descr;
+		unsigned long flags;
+		unsigned int instr;
+		struct pt_regs regs;
+	} subtests[MAX_SUBTESTS + 1];
+};
+
+static struct compute_test compute_tests[] = {
+	{
+		.mnemonic = "nop",
+		.subtests = {
+			{
+				.descr = "R0 = LONG_MAX",
+				.instr = PPC_INST_NOP,
+				.regs = {
+					.gpr[0] = LONG_MAX,
+				}
+			}
+		}
+	}
+};
+
+static int __init emulate_compute_instr(struct pt_regs *regs,
+					unsigned int instr)
+{
+	struct instruction_op op;
+
+	if (!regs || !instr)
+		return -EINVAL;
+
+	if (analyse_instr(&op, regs, instr) != 1 ||
+	    GETTYPE(op.type) != COMPUTE) {
+		pr_info("emulation failed, instruction = 0x%08x\n", instr);
+		return -EFAULT;
+	}
+
+	emulate_update_regs(regs, &op);
+	return 0;
+}
+
+static int __init execute_compute_instr(struct pt_regs *regs,
+					unsigned int instr)
+{
+	extern unsigned int exec_instr_execute[];
+	extern int exec_instr(struct pt_regs *regs);
+
+	if (!regs || !instr)
+		return -EINVAL;
+
+	/* Patch the NOP with the actual instruction */
+	patch_instruction(&exec_instr_execute[0], instr);
+	if (exec_instr(regs)) {
+		pr_info("execution failed, instruction = 0x%08x\n", instr);
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
+#define gpr_mismatch(gprn, exp, got)	\
+	pr_info("GPR%u mismatch, exp = 0x%016lx, got = 0x%016lx\n",	\
+		gprn, exp, got)
+
+#define reg_mismatch(name, exp, got)	\
+	pr_info("%s mismatch, exp = 0x%016lx, got = 0x%016lx\n",	\
+		name, exp, got)
+
+static void __init run_tests_compute(void)
+{
+	unsigned long flags;
+	struct compute_test *test;
+	struct pt_regs *regs, exp, got;
+	unsigned int i, j, k, instr;
+	bool ignore_gpr, ignore_xer, ignore_ccr, passed;
+
+	for (i = 0; i < ARRAY_SIZE(compute_tests); i++) {
+		test = &compute_tests[i];
+
+		for (j = 0; j < MAX_SUBTESTS && test->subtests[j].descr; j++) {
+			instr = test->subtests[j].instr;
+			flags = test->subtests[j].flags;
+			regs = &test->subtests[j].regs;
+			ignore_xer = flags & IGNORE_XER;
+			ignore_ccr = flags & IGNORE_CCR;
+			passed = true;
+
+			memcpy(&exp, regs, sizeof(struct pt_regs));
+			memcpy(&got, regs, sizeof(struct pt_regs));
+
+			/*
+			 * Set a compatible MSR value explicitly to ensure
+			 * that XER and CR bits are updated appropriately
+			 */
+			exp.msr = MSR_KERNEL;
+			got.msr = MSR_KERNEL;
+
+			if (emulate_compute_instr(&got, instr) ||
+			    execute_compute_instr(&exp, instr)) {
+				passed = false;
+				goto print;
+			}
+
+			/* Verify GPR values */
+			for (k = 0; k < 32; k++) {
+				ignore_gpr = flags & IGNORE_GPR(k);
+				if (!ignore_gpr && exp.gpr[k] != got.gpr[k]) {
+					passed = false;
+					gpr_mismatch(k, exp.gpr[k], got.gpr[k]);
+				}
+			}
+
+			/* Verify LR value */
+			if (exp.link != got.link) {
+				passed = false;
+				reg_mismatch("LR", exp.link, got.link);
+			}
+
+			/* Verify XER value */
+			if (!ignore_xer && exp.xer != got.xer) {
+				passed = false;
+				reg_mismatch("XER", exp.xer, got.xer);
+			}
+
+			/* Verify CR value */
+			if (!ignore_ccr && exp.ccr != got.ccr) {
+				passed = false;
+				reg_mismatch("CR", exp.ccr, got.ccr);
+			}
+
+print:
+			show_result_with_descr(test->mnemonic,
+					       test->subtests[j].descr,
+					       passed ? "PASS" : "FAIL");
+		}
+	}
+}
+
+static int __init test_emulate_step(void)
+{
+	printk(KERN_INFO "Running instruction emulation self-tests ...\n");
+	run_tests_load_store();
+	run_tests_compute();
 
 	return 0;
 }
diff --git a/arch/powerpc/lib/test_emulate_step_exec_instr.S b/arch/powerpc/lib/test_emulate_step_exec_instr.S
new file mode 100644
index 000000000000..84cef7d78d9d
--- /dev/null
+++ b/arch/powerpc/lib/test_emulate_step_exec_instr.S
@@ -0,0 +1,150 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Non-emulated single-stepping support (currently limited to basic integer
+ * computations) used to validate the instruction emulation infrastructure.
+ *
+ * Copyright (C) 2019 IBM Corporation
+ */
+
+#include <asm/asm-offsets.h>
+#include <asm/ppc_asm.h>
+#include <linux/errno.h>
+
+/* int exec_instr(struct pt_regs *regs) */
+_GLOBAL(exec_instr)
+
+	/*
+	 * Stack frame layout (INT_FRAME_SIZE bytes)
+	 *   In-memory pt_regs	(SP + STACK_FRAME_OVERHEAD)
+	 *   Scratch space	(SP + 8)
+	 *   Back chain		(SP + 0)
+	 */
+
+	/*
+	 * Allocate a new stack frame with enough space to hold the register
+	 * states in an in-memory pt_regs and also create the back chain to
+	 * the caller's stack frame.
+	 */
+	stdu	r1, -INT_FRAME_SIZE(r1)
+
+	/*
+	 * Save non-volatile GPRs on stack. This includes TOC pointer (GPR2)
+	 * and local variables (GPR14 to GPR31). The register for the pt_regs
+	 * parameter (GPR3) is saved additionally to ensure that the resulting
+	 * register state can still be saved even if GPR3 gets overwritten
+	 * when loading the initial register state for the test instruction.
+	 * The stack pointer (GPR1) and the thread pointer (GPR13) are not
+	 * saved as these should not be modified anyway.
+	 */
+	SAVE_2GPRS(2, r1)
+	SAVE_NVGPRS(r1)
+
+	/*
+	 * Save LR on stack to ensure that the return address is available
+	 * even if it gets overwritten by the test instruction.
+	 */
+	mflr	r0
+	std	r0, _LINK(r1)
+
+	/*
+	 * Save CR on stack. For simplicity, the entire register is saved
+	 * even though only fields 2 to 4 are non-volatile.
+	 */
+	mfcr	r0
+	std	r0, _CCR(r1)
+
+	/*
+	 * Load register state for the test instruction without touching the
+	 * critical non-volatile registers. The register state is passed as a
+	 * pointer to a pt_regs instance.
+	 */
+	subi	r31, r3, GPR0
+
+	/* Load LR from pt_regs */
+	ld	r0, _LINK(r31)
+	mtlr	r0
+
+	/* Load CR from pt_regs */
+	ld	r0, _CCR(r31)
+	mtcr	r0
+
+	/* Load XER from pt_regs */
+	ld	r0, _XER(r31)
+	mtxer	r0
+
+	/* Load GPRs from pt_regs */
+	REST_GPR(0, r31)
+	REST_10GPRS(2, r31)
+	REST_GPR(12, r31)
+	REST_NVGPRS(r31)
+
+	.global	exec_instr_execute
+exec_instr_execute:
+	/* Placeholder for the test instruction */
+1:	nop
+
+	/*
+	 * Since GPR3 is overwritten, temporarily restore it back to its
+	 * original state, i.e. the pointer to pt_regs, to ensure that the
+	 * resulting register state can be saved. Before doing this, a copy
+	 * of it is created in the scratch space which is used later on to
+	 * save it to pt_regs.
+	 */
+	std	r3, 8(r1)
+	REST_GPR(3, r1)
+
+	/* Save resulting GPR state to pt_regs */
+	subi	r3, r3, GPR0
+	SAVE_GPR(0, r3)
+	SAVE_GPR(2, r3)
+	SAVE_8GPRS(4, r3)
+	SAVE_GPR(12, r3)
+	SAVE_NVGPRS(r3)
+
+	/* Save resulting LR to pt_regs */
+	mflr	r0
+	std	r0, _LINK(r3)
+
+	/* Save resulting CR to pt_regs */
+	mfcr	r0
+	std	r0, _CCR(r3)
+
+	/* Save resulting XER to pt_regs */
+	mfxer	r0
+	std	r0, _XER(r3)
+
+	/* Restore resulting GPR3 from scratch space and save it to pt_regs */
+	ld	r0, 8(r1)
+	std	r0, GPR3(r3)
+
+	/* Set return value to denote execution success */
+	li	r3, 0
+
+	/* Continue */
+	b	3f
+
+	/* Set return value to denote execution failure */
+2:	li	r3, -EFAULT
+
+	/* Restore the non-volatile GPRs from stack */
+3:	REST_GPR(2, r1)
+	REST_NVGPRS(r1)
+
+	/* Restore LR from stack to be able to return */
+	ld	r0, _LINK(r1)
+	mtlr	r0
+
+	/* Restore CR from stack */
+	ld	r0, _CCR(r1)
+	mtcr	r0
+
+	/* Tear down stack frame */
+	addi	r1, r1, INT_FRAME_SIZE
+
+	/* Return */
+	blr
+
+	/* Setup exception table */
+	EX_TABLE(1b, 2b)
+
+_ASM_NOKPROBE_SYMBOL(exec_instr)
-- 
2.19.2

