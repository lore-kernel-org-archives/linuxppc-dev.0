Return-Path: <SRS0=Z4Cu=QL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75864C282D7
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 04:24:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE4FC2083B
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 04:24:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE4FC2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43tF3p1Q6DzDqF1
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 15:24:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=sandipan@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43tDwx6FW0zDqDC
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Feb 2019 15:18:57 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x14494G9030816
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 3 Feb 2019 23:18:55 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2qe4y8q3h5-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 03 Feb 2019 23:18:55 -0500
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sandipan@linux.ibm.com>;
 Mon, 4 Feb 2019 04:18:53 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 4 Feb 2019 04:18:52 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x144Io394325666
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 4 Feb 2019 04:18:51 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D7803A4060;
 Mon,  4 Feb 2019 04:18:50 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9CB5BA405C;
 Mon,  4 Feb 2019 04:18:49 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.195.22.129])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon,  4 Feb 2019 04:18:49 +0000 (GMT)
From: Sandipan Das <sandipan@linux.ibm.com>
To: mpe@ellerman.id.au
Subject: [RFC PATCH 3/5] powerpc: sstep: Add instruction emulation selftests
Date: Mon,  4 Feb 2019 09:48:37 +0530
X-Mailer: git-send-email 2.19.2
In-Reply-To: <cover.1549253769.git.sandipan@linux.ibm.com>
References: <cover.1549253769.git.sandipan@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19020404-0028-0000-0000-00000343B10C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19020404-0029-0000-0000-00002401B442
Message-Id: <196d2330aef453b4eb3cb66febeb79110aadd567.1549253769.git.sandipan@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-04_03:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902040033
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
 ravi.bangoria@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This adds a selftest framework for the in-kernel instruction
emulation infrastructure. This currently does not support the
load/store and branch instructions and is limited to integer
ALU instructions. Support for SPRs is also limited to LR, CR
and XER for now.

Tests run at boot time if CONFIG_DEBUG_KERNEL, CONFIG_PPC64
and CONFIG_EMULATE_STEP_SELFTEST were set before the kernel
build.

When writing the tests, one must not use any instructions
that might overwrite the Stack Pointer (GPR1) or the Thread
Pointer (GPR13).

Signed-off-by: Sandipan Das <sandipan@linux.ibm.com>
---
 arch/powerpc/Kconfig.debug         |   5 +
 arch/powerpc/lib/Makefile          |   1 +
 arch/powerpc/lib/exec_test_instr.S | 150 +++++++++++++++++++++++++++
 arch/powerpc/lib/sstep_tests.c     | 158 +++++++++++++++++++++++++++++
 4 files changed, 314 insertions(+)
 create mode 100644 arch/powerpc/lib/exec_test_instr.S
 create mode 100644 arch/powerpc/lib/sstep_tests.c

diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
index f4961fbcb48d..d75c165538e9 100644
--- a/arch/powerpc/Kconfig.debug
+++ b/arch/powerpc/Kconfig.debug
@@ -56,6 +56,11 @@ config CODE_PATCHING_SELFTEST
 	bool "Run self-tests of the code-patching code"
 	depends on DEBUG_KERNEL
 
+config EMULATE_STEP_SELFTEST
+	bool "Run self-tests of the instruction emulation code"
+	depends on PPC64 && DEBUG_KERNEL
+	default n
+
 config JUMP_LABEL_FEATURE_CHECKS
 	bool "Enable use of jump label for cpu/mmu_has_feature()"
 	depends on JUMP_LABEL
diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
index 3bf9fc6fd36c..c4485e004838 100644
--- a/arch/powerpc/lib/Makefile
+++ b/arch/powerpc/lib/Makefile
@@ -31,6 +31,7 @@ obj64-y	+= copypage_64.o copyuser_64.o mem_64.o hweight_64.o \
 obj64-$(CONFIG_SMP)	+= locks.o
 obj64-$(CONFIG_ALTIVEC)	+= vmx-helper.o
 obj64-$(CONFIG_KPROBES_SANITY_TEST) += test_emulate_step.o
+obj64-$(CONFIG_EMULATE_STEP_SELFTEST)	+= exec_test_instr.o sstep_tests.o
 
 obj-y			+= checksum_$(BITS).o checksum_wrappers.o \
 			   string_$(BITS).o memcmp_$(BITS).o
diff --git a/arch/powerpc/lib/exec_test_instr.S b/arch/powerpc/lib/exec_test_instr.S
new file mode 100644
index 000000000000..217e83415eaf
--- /dev/null
+++ b/arch/powerpc/lib/exec_test_instr.S
@@ -0,0 +1,150 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Non-emulated single-stepping support limited to basic integer ops for
+ * validating the instruction emulation infrastructure.
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
diff --git a/arch/powerpc/lib/sstep_tests.c b/arch/powerpc/lib/sstep_tests.c
new file mode 100644
index 000000000000..a610c778044d
--- /dev/null
+++ b/arch/powerpc/lib/sstep_tests.c
@@ -0,0 +1,158 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Selftests for the instruction emulation infrastructure.
+ *
+ * Copyright (C) 2019 IBM Corporation
+ */
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/ptrace.h>
+
+#include <asm/code-patching.h>
+#include <asm/ppc-opcode.h>
+#include <asm/sstep.h>
+
+#define MAX_SUBTESTS	16
+#define MAX_INSNS	32
+
+#define PASS	1
+#define FAIL	0
+
+#define IGNORE_GPR(n)	(0x1UL << (n))
+#define IGNORE_XER	(0x1UL << 32)
+#define IGNORE_CCR	(0x1UL << 33)
+
+struct sstep_test {
+	const char *mnemonic;
+	struct {
+		const char *descr;
+		unsigned long flags;
+		unsigned int instr;
+		struct pt_regs regs;
+	} subtests[MAX_SUBTESTS + 1];
+};
+
+static struct sstep_test tests[] = {
+	{
+		.mnemonic = "nop",
+		.subtests =
+		{
+			{
+				.descr = "R0 = LONG_MAX",
+				.instr = PPC_INST_NOP | ___PPC_RA(0) | ___PPC_RS(0) | __PPC_UI(0x0),
+				.regs =
+				{
+					.gpr[0] = LONG_MAX,
+				}
+			}
+		}
+	},
+};
+
+int emulate_instr(struct pt_regs *regs, unsigned int instr)
+{
+	struct instruction_op op;
+
+	if (!regs || !instr)
+		return -EINVAL;
+
+	if (analyse_instr(&op, regs, instr) != 1 || GETTYPE(op.type) != COMPUTE) {
+		pr_info("emulation failed or not supported, opcode = 0x%08x\n", instr);
+		return -EFAULT;
+	}
+
+	emulate_update_regs(regs, &op);
+	return 0;
+}
+
+int execute_instr(struct pt_regs *regs, unsigned int instr)
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
+		pr_info("execution failed, opcode = 0x%08x\n", instr);
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
+static int __init run_sstep_tests(void)
+{
+	bool ignore_gpr;
+	bool ignore_xer;
+	bool ignore_ccr;
+	unsigned int instr;
+	unsigned long flags;
+	struct pt_regs a, b;
+	const char *mnemonic, *descr;
+	unsigned int i, j, k, result;
+
+	for (i = 0; i < ARRAY_SIZE(tests); i++) {
+		mnemonic = tests[i].mnemonic;
+
+		for (j = 0; j < MAX_SUBTESTS && tests[i].subtests[j].descr; j++) {
+			descr = tests[i].subtests[j].descr;
+			instr = tests[i].subtests[j].instr;
+			flags = tests[i].subtests[j].flags;
+			ignore_xer = flags & IGNORE_XER;
+			ignore_ccr = flags & IGNORE_CCR;
+			result = PASS;
+
+			memcpy(&a, &tests[i].subtests[j].regs, sizeof(struct pt_regs));
+			memcpy(&b, &tests[i].subtests[j].regs, sizeof(struct pt_regs));
+
+			/*
+			 * Set a compatible MSR value explicitly to ensure
+			 * that XER and CR bits are updated appropriately
+			 */
+			a.msr = b.msr = MSR_KERNEL;
+
+			if (emulate_instr(&a, instr) || execute_instr(&b, instr)) {
+				result = FAIL;
+				goto print;
+			}
+
+			/* Verify GPR values */
+			for (k = 0; k < 32; k++) {
+				ignore_gpr = flags & IGNORE_GPR(k);
+				if (!ignore_gpr && a.gpr[k] != b.gpr[k]) {
+					result = FAIL;
+					pr_info("GPR%u got = 0x%016lx, exp = 0x%016lx\n", k, a.gpr[k], b.gpr[k]);
+				}
+			}
+
+			/* Verify LR value */
+			if (a.link != b.link) {
+				result = FAIL;
+				pr_info("LR got = 0x%016lx, exp = 0x%016lx\n", a.link, b.link);
+			}
+
+			/* Verify XER value */
+			if (!ignore_xer && a.xer != b.xer) {
+				result = FAIL;
+				pr_info("XER got = 0x%016lx, exp = 0x%016lx\n", a.xer, b.xer);
+			}
+
+			/* Verify CR value */
+			if (!ignore_ccr && a.ccr != b.ccr) {
+				result = FAIL;
+				pr_info("CR got = 0x%08lx, exp = 0x%08lx\n", a.ccr, b.ccr);
+			}
+
+print:
+			pr_info("%-8s: %-50s [%s]", mnemonic, descr, result ? "PASS" : "FAIL");
+		}
+	}
+
+	return 0;
+}
+late_initcall(run_sstep_tests);
-- 
2.19.2

