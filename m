Return-Path: <ravi.bangoria@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vMxdX1hRTzDqN9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 20:17:20 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1E9E42j078744
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 04:17:17 -0500
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [125.16.236.7])
 by mx0b-001b2d01.pphosted.com with ESMTP id 28kvene4fs-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 04:17:16 -0500
Received: from localhost
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ravi.bangoria@linux.vnet.ibm.com>;
 Tue, 14 Feb 2017 14:47:03 +0530
Received: from d28relay10.in.ibm.com (d28relay10.in.ibm.com [9.184.220.161])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id C3388E005E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 14:48:31 +0530 (IST)
Received: from d28av08.in.ibm.com (d28av08.in.ibm.com [9.184.220.148])
 by d28relay10.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1E9Fx9I13238500
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 14:45:59 +0530
Received: from d28av08.in.ibm.com (localhost [127.0.0.1])
 by d28av08.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1E9Gt4s021013
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
Subject: [PATCH v3 2/2] powerpc: emulate_step tests for load/store instructions
Date: Tue, 14 Feb 2017 14:46:43 +0530
In-Reply-To: <1487063803-10848-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
References: <1487063803-10848-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
Message-Id: <1487063803-10848-3-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add new selftest that test emulate_step for Normal, Floating Point,
Vector and Vector Scalar - load/store instructions. Test should run
at boot time if CONFIG_KPROBES_SANITY_TEST and CONFIG_PPC64 is set.

Sample log:

  [    0.762063] emulate_step smoke test: start.
  [    0.762219] emulate_step smoke test: ld             : PASS
  [    0.762434] emulate_step smoke test: lwz            : PASS
  [    0.762653] emulate_step smoke test: lwzx           : PASS
  [    0.762867] emulate_step smoke test: std            : PASS
  [    0.763082] emulate_step smoke test: ldarx / stdcx. : PASS
  [    0.763302] emulate_step smoke test: lfsx           : PASS
  [    0.763514] emulate_step smoke test: stfsx          : PASS
  [    0.763727] emulate_step smoke test: lfdx           : PASS
  [    0.763942] emulate_step smoke test: stfdx          : PASS
  [    0.764134] emulate_step smoke test: lvx            : PASS
  [    0.764349] emulate_step smoke test: stvx           : PASS
  [    0.764575] emulate_step smoke test: lxvd2x         : PASS
  [    0.764788] emulate_step smoke test: stxvd2x        : PASS
  [    0.764997] emulate_step smoke test: complete.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/ppc-opcode.h |   7 +
 arch/powerpc/include/asm/sstep.h      |   8 +
 arch/powerpc/kernel/kprobes.c         |   2 +
 arch/powerpc/lib/Makefile             |   4 +
 arch/powerpc/lib/test_emulate_step.c  | 439 ++++++++++++++++++++++++++++++++++
 5 files changed, 460 insertions(+)
 create mode 100644 arch/powerpc/lib/test_emulate_step.c

diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include/asm/ppc-opcode.h
index d99bd44..e7d6d86 100644
--- a/arch/powerpc/include/asm/ppc-opcode.h
+++ b/arch/powerpc/include/asm/ppc-opcode.h
@@ -284,6 +284,13 @@
 #define PPC_INST_BRANCH_COND		0x40800000
 #define PPC_INST_LBZCIX			0x7c0006aa
 #define PPC_INST_STBCIX			0x7c0007aa
+#define PPC_INST_LWZX			0x7c00002e
+#define PPC_INST_LFSX			0x7c00042e
+#define PPC_INST_STFSX			0x7c00052e
+#define PPC_INST_LFDX			0x7c0004ae
+#define PPC_INST_STFDX			0x7c0005ae
+#define PPC_INST_LVX			0x7c0000ce
+#define PPC_INST_STVX			0x7c0001ce
 
 /* macros to insert fields into opcodes */
 #define ___PPC_RA(a)	(((a) & 0x1f) << 16)
diff --git a/arch/powerpc/include/asm/sstep.h b/arch/powerpc/include/asm/sstep.h
index d3a42cc..d6d3630 100644
--- a/arch/powerpc/include/asm/sstep.h
+++ b/arch/powerpc/include/asm/sstep.h
@@ -87,3 +87,11 @@ struct instruction_op {
 
 extern int analyse_instr(struct instruction_op *op, struct pt_regs *regs,
 			 unsigned int instr);
+
+#if defined(CONFIG_KPROBES_SANITY_TEST) && defined(CONFIG_PPC64)
+void test_emulate_step(void);
+#else
+static inline void test_emulate_step(void)
+{
+}
+#endif
diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
index fce05a3..5c5ae66 100644
--- a/arch/powerpc/kernel/kprobes.c
+++ b/arch/powerpc/kernel/kprobes.c
@@ -528,6 +528,8 @@ int __kprobes longjmp_break_handler(struct kprobe *p, struct pt_regs *regs)
 
 int __init arch_init_kprobes(void)
 {
+	test_emulate_step();
+
 	return register_kprobe(&trampoline_p);
 }
 
diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
index 0e649d7..ddc879d 100644
--- a/arch/powerpc/lib/Makefile
+++ b/arch/powerpc/lib/Makefile
@@ -33,3 +33,7 @@ obj-$(CONFIG_ALTIVEC)	+= xor_vmx.o
 CFLAGS_xor_vmx.o += -maltivec $(call cc-option,-mabi=altivec)
 
 obj-$(CONFIG_PPC64) += $(obj64-y)
+
+ifeq ($(CONFIG_PPC64), y)
+obj-$(CONFIG_KPROBES_SANITY_TEST) += test_emulate_step.o
+endif
diff --git a/arch/powerpc/lib/test_emulate_step.c b/arch/powerpc/lib/test_emulate_step.c
new file mode 100644
index 0000000..887d1db
--- /dev/null
+++ b/arch/powerpc/lib/test_emulate_step.c
@@ -0,0 +1,439 @@
+/*
+ * test_emulate_step.c - simple sanity test for emulate_step load/store
+ *			 instructions
+ *
+ * Copyright IBM Corp. 2016
+ *
+ * This program is free software;  you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it would be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See
+ * the GNU General Public License for more details.
+ */
+
+#define pr_fmt(fmt) "emulate_step smoke test: " fmt
+
+#include <linux/ptrace.h>
+#include <asm/sstep.h>
+#include <asm/ppc-opcode.h>
+
+#define IMM_L(i)		((uintptr_t)(i) & 0xffff)
+
+/*
+ * Defined with TEST_ prefix so it does not conflict with other
+ * definitions.
+ */
+#define TEST_LD(r, base, i)	(PPC_INST_LD | ___PPC_RT(r) |		\
+					___PPC_RA(base) | IMM_L(i))
+#define TEST_LWZ(r, base, i)	(PPC_INST_LWZ | ___PPC_RT(r) |		\
+					___PPC_RA(base) | IMM_L(i))
+#define TEST_LWZX(t, a, b)	(PPC_INST_LWZX | ___PPC_RT(t) |		\
+					___PPC_RA(a) | ___PPC_RB(b))
+#define TEST_STD(r, base, i)	(PPC_INST_STD | ___PPC_RS(r) |		\
+					___PPC_RA(base) | ((i) & 0xfffc))
+#define TEST_LDARX(t, a, b, eh)	(PPC_INST_LDARX | ___PPC_RT(t) |	\
+					___PPC_RA(a) | ___PPC_RB(b) |	\
+					__PPC_EH(eh))
+#define TEST_STDCX(s, a, b)	(PPC_INST_STDCX | ___PPC_RS(s) |	\
+					___PPC_RA(a) | ___PPC_RB(b))
+#define TEST_LFSX(t, a, b)	(PPC_INST_LFSX | ___PPC_RT(t) |		\
+					___PPC_RA(a) | ___PPC_RB(b))
+#define TEST_STFSX(s, a, b)	(PPC_INST_STFSX | ___PPC_RS(s) |	\
+					___PPC_RA(a) | ___PPC_RB(b))
+#define TEST_LFDX(t, a, b)	(PPC_INST_LFDX | ___PPC_RT(t) |		\
+					___PPC_RA(a) | ___PPC_RB(b))
+#define TEST_STFDX(s, a, b)	(PPC_INST_STFDX | ___PPC_RS(s) |	\
+					___PPC_RA(a) | ___PPC_RB(b))
+#define TEST_LVX(t, a, b)	(PPC_INST_LVX | ___PPC_RT(t) |		\
+					___PPC_RA(a) | ___PPC_RB(b))
+#define TEST_STVX(s, a, b)	(PPC_INST_STVX | ___PPC_RS(s) |		\
+					___PPC_RA(a) | ___PPC_RB(b))
+#define TEST_LXVD2X(s, a, b)	(PPC_INST_LXVD2X | VSX_XX1((s), R##a, R##b))
+#define TEST_STXVD2X(s, a, b)	(PPC_INST_STXVD2X | VSX_XX1((s), R##a, R##b))
+
+
+static void init_pt_regs(struct pt_regs *regs)
+{
+	static unsigned long msr;
+	static bool msr_cached;
+
+	memset(regs, 0, sizeof(struct pt_regs));
+
+	if (likely(msr_cached)) {
+		regs->msr = msr;
+		return;
+	}
+
+	asm volatile("mfmsr %0" : "=r"(regs->msr));
+
+	regs->msr |= MSR_FP;
+	regs->msr |= MSR_VEC;
+	regs->msr |= MSR_VSX;
+
+	msr = regs->msr;
+	msr_cached = true;
+}
+
+static void show_result(char *ins, char *result)
+{
+	pr_info("%-14s : %s\n", ins, result);
+}
+
+static void test_ld(void)
+{
+	struct pt_regs regs;
+	unsigned long a = 0x23;
+	int stepped = -1;
+
+	init_pt_regs(&regs);
+	regs.gpr[3] = (unsigned long) &a;
+
+	/* ld r5, 0(r3) */
+	stepped = emulate_step(&regs, TEST_LD(5, 3, 0));
+
+	if (stepped == 1 && regs.gpr[5] == a)
+		show_result("ld", "PASS");
+	else
+		show_result("ld", "FAIL");
+}
+
+static void test_lwz(void)
+{
+	struct pt_regs regs;
+	unsigned int a = 0x4545;
+	int stepped = -1;
+
+	init_pt_regs(&regs);
+	regs.gpr[3] = (unsigned long) &a;
+
+	/* lwz r5, 0(r3) */
+	stepped = emulate_step(&regs, TEST_LWZ(5, 3, 0));
+
+	if (stepped == 1 && regs.gpr[5] == a)
+		show_result("lwz", "PASS");
+	else
+		show_result("lwz", "FAIL");
+}
+
+static void test_lwzx(void)
+{
+	struct pt_regs regs;
+	unsigned int a[3] = {0x0, 0x0, 0x1234};
+	int stepped = -1;
+
+	init_pt_regs(&regs);
+	regs.gpr[3] = (unsigned long) a;
+	regs.gpr[4] = 8;
+	regs.gpr[5] = 0x8765;
+
+	/* lwzx r5, r3, r4 */
+	stepped = emulate_step(&regs, TEST_LWZX(5, 3, 4));
+	if (stepped == 1 && regs.gpr[5] == a[2])
+		show_result("lwzx", "PASS");
+	else
+		show_result("lwzx", "FAIL");
+}
+
+static void test_std(void)
+{
+	struct pt_regs regs;
+	unsigned long a = 0x1234;
+	int stepped = -1;
+
+	init_pt_regs(&regs);
+	regs.gpr[3] = (unsigned long) &a;
+	regs.gpr[5] = 0x5678;
+
+	/* std r5, 0(r3) */
+	stepped = emulate_step(&regs, TEST_STD(5, 3, 0));
+	if (stepped == 1 || regs.gpr[5] == a)
+		show_result("std", "PASS");
+	else
+		show_result("std", "FAIL");
+}
+
+static void test_ldarx_stdcx(void)
+{
+	struct pt_regs regs;
+	unsigned long a = 0x1234;
+	int stepped = -1;
+	unsigned long cr0_eq = 0x1 << 29; /* eq bit of CR0 */
+
+	init_pt_regs(&regs);
+	asm volatile("mfcr %0" : "=r"(regs.ccr));
+
+
+	/*** ldarx ***/
+
+	regs.gpr[3] = (unsigned long) &a;
+	regs.gpr[4] = 0;
+	regs.gpr[5] = 0x5678;
+
+	/* ldarx r5, r3, r4, 0 */
+	stepped = emulate_step(&regs, TEST_LDARX(5, 3, 4, 0));
+
+	/*
+	 * Don't touch 'a' here. Touching 'a' can do Load/store
+	 * of 'a' which result in failure of subsequent stdcx.
+	 * Instead, use hardcoded value for comparison.
+	 */
+	if (stepped <= 0 || regs.gpr[5] != 0x1234) {
+		show_result("ldarx / stdcx.", "FAIL (ldarx)");
+		return;
+	}
+
+
+	/*** stdcx. ***/
+
+	regs.gpr[5] = 0x9ABC;
+
+	/* stdcx. r5, r3, r4 */
+	stepped = emulate_step(&regs, TEST_STDCX(5, 3, 4));
+
+	/*
+	 * Two possible scenarios that indicates successful emulation
+	 * of stdcx. :
+	 *  1. Reservation is active and store is performed. In this
+	 *     case cr0.eq bit will be set to 1.
+	 *  2. Reservation is not active and store is not performed.
+	 *     In this case cr0.eq bit will be set to 0.
+	 */
+	if (stepped == 1 && ((regs.gpr[5] == a && (regs.ccr & cr0_eq))
+			|| (regs.gpr[5] != a && !(regs.ccr & cr0_eq))))
+		show_result("ldarx / stdcx.", "PASS");
+	else
+		show_result("ldarx / stdcx.", "FAIL (stdcx.)");
+}
+
+#ifdef CONFIG_PPC_FPU
+static void test_lfsx_stfsx(void)
+{
+	struct pt_regs regs;
+	union {
+		float a;
+		int b;
+	} c;
+	int cached_b;
+	int stepped = -1;
+
+	init_pt_regs(&regs);
+
+
+	/*** lfsx ***/
+
+	c.a = 123.45;
+	cached_b = c.b;
+
+	regs.gpr[3] = (unsigned long) &c.a;
+	regs.gpr[4] = 0;
+
+	/* lfsx frt10, r3, r4 */
+	stepped = emulate_step(&regs, TEST_LFSX(10, 3, 4));
+
+	if (stepped == 1)
+		show_result("lfsx", "PASS");
+	else
+		show_result("lfsx", "FAIL");
+
+
+	/*** stfsx ***/
+
+	c.a = 678.91;
+
+	/* stfsx frs10, r3, r4 */
+	stepped = emulate_step(&regs, TEST_STFSX(10, 3, 4));
+
+	if (stepped == 1 && c.b == cached_b)
+		show_result("stfsx", "PASS");
+	else
+		show_result("stfsx", "FAIL");
+}
+
+static void test_lfdx_stfdx(void)
+{
+	struct pt_regs regs;
+	union {
+		double a;
+		long b;
+	} c;
+	long cached_b;
+	int stepped = -1;
+
+	init_pt_regs(&regs);
+
+
+	/*** lfdx ***/
+
+	c.a = 123456.78;
+	cached_b = c.b;
+
+	regs.gpr[3] = (unsigned long) &c.a;
+	regs.gpr[4] = 0;
+
+	/* lfdx frt10, r3, r4 */
+	stepped = emulate_step(&regs, TEST_LFDX(10, 3, 4));
+
+	if (stepped == 1)
+		show_result("lfdx", "PASS");
+	else
+		show_result("lfdx", "FAIL");
+
+
+	/*** stfdx ***/
+
+	c.a = 987654.32;
+
+	/* stfdx frs10, r3, r4 */
+	stepped = emulate_step(&regs, TEST_STFDX(10, 3, 4));
+
+	if (stepped == 1 && c.b == cached_b)
+		show_result("stfdx", "PASS");
+	else
+		show_result("stfdx", "FAIL");
+}
+#else
+static void test_lfsx_stfsx(void)
+{
+	show_result("lfsx", "SKIP (CONFIG_PPC_FPU is not set)");
+	show_result("stfsx", "SKIP (CONFIG_PPC_FPU is not set)");
+}
+
+static void test_lfdx_stfdx(void)
+{
+	show_result("lfdx", "SKIP (CONFIG_PPC_FPU is not set)");
+	show_result("stfdx", "SKIP (CONFIG_PPC_FPU is not set)");
+}
+#endif /* CONFIG_PPC_FPU */
+
+#ifdef CONFIG_ALTIVEC
+static void test_lvx_stvx(void)
+{
+	struct pt_regs regs;
+	union {
+		vector128 a;
+		u32 b[4];
+	} c;
+	u32 cached_b[4];
+	int stepped = -1;
+
+	init_pt_regs(&regs);
+
+
+	/*** lvx ***/
+
+	cached_b[0] = c.b[0] = 923745;
+	cached_b[1] = c.b[1] = 2139478;
+	cached_b[2] = c.b[2] = 9012;
+	cached_b[3] = c.b[3] = 982134;
+
+	regs.gpr[3] = (unsigned long) &c.a;
+	regs.gpr[4] = 0;
+
+	/* lvx vrt10, r3, r4 */
+	stepped = emulate_step(&regs, TEST_LVX(10, 3, 4));
+
+	if (stepped == 1)
+		show_result("lvx", "PASS");
+	else
+		show_result("lvx", "FAIL");
+
+
+	/*** stvx ***/
+
+	c.b[0] = 4987513;
+	c.b[1] = 84313948;
+	c.b[2] = 71;
+	c.b[3] = 498532;
+
+	/* stvx vrs10, r3, r4 */
+	stepped = emulate_step(&regs, TEST_STVX(10, 3, 4));
+
+	if (stepped == 1 && cached_b[0] == c.b[0] && cached_b[1] == c.b[1] &&
+	    cached_b[2] == c.b[2] && cached_b[3] == c.b[3])
+		show_result("stvx", "PASS");
+	else
+		show_result("stvx", "FAIL");
+}
+#else
+static void test_lvx_stvx(void)
+{
+	show_result("lvx", "SKIP (CONFIG_ALTIVEC is not set)");
+	show_result("stvx", "SKIP (CONFIG_ALTIVEC is not set)");
+}
+#endif /* CONFIG_ALTIVEC */
+
+#ifdef CONFIG_VSX
+static void test_lxvd2x_stxvd2x(void)
+{
+	struct pt_regs regs;
+	union {
+		vector128 a;
+		u32 b[4];
+	} c;
+	u32 cached_b[4];
+	int stepped = -1;
+
+	init_pt_regs(&regs);
+
+
+	/*** lxvd2x ***/
+
+	cached_b[0] = c.b[0] = 18233;
+	cached_b[1] = c.b[1] = 34863571;
+	cached_b[2] = c.b[2] = 834;
+	cached_b[3] = c.b[3] = 6138911;
+
+	regs.gpr[3] = (unsigned long) &c.a;
+	regs.gpr[4] = 0;
+
+	/* lxvd2x vsr39, r3, r4 */
+	stepped = emulate_step(&regs, TEST_LXVD2X(39, 3, 4));
+
+	if (stepped == 1)
+		show_result("lxvd2x", "PASS");
+	else
+		show_result("lxvd2x", "FAIL");
+
+
+	/*** stxvd2x ***/
+
+	c.b[0] = 21379463;
+	c.b[1] = 87;
+	c.b[2] = 374234;
+	c.b[3] = 4;
+
+	/* stxvd2x vsr39, r3, r4 */
+	stepped = emulate_step(&regs, TEST_STXVD2X(39, 3, 4));
+
+	if (stepped == 1 && cached_b[0] == c.b[0] && cached_b[1] == c.b[1] &&
+	    cached_b[2] == c.b[2] && cached_b[3] == c.b[3])
+		show_result("stxvd2x", "PASS");
+	else
+		show_result("stxvd2x", "FAIL");
+}
+#else
+static void test_lxvd2x_stxvd2x(void)
+{
+	show_result("lxvd2x", "SKIP (CONFIG_VSX is not set)");
+	show_result("stxvd2x", "SKIP (CONFIG_VSX is not set)");
+}
+#endif /* CONFIG_VSX */
+
+void test_emulate_step(void)
+{
+	pr_info("start.\n");
+	test_ld();
+	test_lwz();
+	test_lwzx();
+	test_std();
+	test_ldarx_stdcx();
+	test_lfsx_stfsx();
+	test_lfdx_stfdx();
+	test_lvx_stvx();
+	test_lxvd2x_stxvd2x();
+	pr_info("complete.\n");
+}
-- 
1.8.3.1
