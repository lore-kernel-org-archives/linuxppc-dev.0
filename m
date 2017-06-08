Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wkFjM1jvvzDqNq
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Jun 2017 05:24:22 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v58JODU3131935
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 8 Jun 2017 15:24:21 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2axxrdydhh-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Jun 2017 15:24:20 -0400
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Fri, 9 Jun 2017 05:24:18 +1000
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v58JO7PD61997238
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 Jun 2017 05:24:15 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v58JNgKQ007604
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 Jun 2017 05:23:42 +1000
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Ingo Molnar <mingo@kernel.org>
Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] kernel/kprobes: Add test to validate pt_regs
Date: Fri,  9 Jun 2017 00:53:08 +0530
Message-Id: <20170608192308.22278-1-naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add a test to verify that the registers passed in pt_regs on kprobe
(trap), optprobe (jump) and kprobe_on_ftrace (ftrace_caller) are
accurate. The tests are exercized if KPROBES_SANITY_TEST is enabled.

Implemented for powerpc64. Other architectures will have to implement
the relevant arch_* helpers and define HAVE_KPROBES_REGS_SANITY_TEST.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/kprobes.h  |   4 +
 arch/powerpc/lib/Makefile           |   3 +-
 arch/powerpc/lib/test_kprobe_regs.S |  62 ++++++++++++
 arch/powerpc/lib/test_kprobes.c     | 115 ++++++++++++++++++++++
 include/linux/kprobes.h             |  11 +++
 kernel/test_kprobes.c               | 183 ++++++++++++++++++++++++++++++++++++
 6 files changed, 377 insertions(+), 1 deletion(-)
 create mode 100644 arch/powerpc/lib/test_kprobe_regs.S
 create mode 100644 arch/powerpc/lib/test_kprobes.c

diff --git a/arch/powerpc/include/asm/kprobes.h b/arch/powerpc/include/asm/kprobes.h
index 566da372e02b..10c91d3132a1 100644
--- a/arch/powerpc/include/asm/kprobes.h
+++ b/arch/powerpc/include/asm/kprobes.h
@@ -124,6 +124,10 @@ static inline int skip_singlestep(struct kprobe *p, struct pt_regs *regs,
 	return 0;
 }
 #endif
+#if defined(CONFIG_KPROBES_SANITY_TEST) && defined(CONFIG_PPC64)
+#define HAVE_KPROBES_REGS_SANITY_TEST
+void arch_kprobe_regs_set_ptregs(struct pt_regs *regs);
+#endif
 #else
 static inline int kprobe_handler(struct pt_regs *regs) { return 0; }
 static inline int kprobe_post_handler(struct pt_regs *regs) { return 0; }
diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
index 3c3146ba62da..8a0bb8e20179 100644
--- a/arch/powerpc/lib/Makefile
+++ b/arch/powerpc/lib/Makefile
@@ -27,7 +27,8 @@ obj64-y	+= copypage_64.o copyuser_64.o mem_64.o hweight_64.o \
 
 obj64-$(CONFIG_SMP)	+= locks.o
 obj64-$(CONFIG_ALTIVEC)	+= vmx-helper.o
-obj64-$(CONFIG_KPROBES_SANITY_TEST) += test_emulate_step.o
+obj64-$(CONFIG_KPROBES_SANITY_TEST) += test_emulate_step.o test_kprobe_regs.o \
+				       test_kprobes.o
 
 obj-y			+= checksum_$(BITS).o checksum_wrappers.o
 
diff --git a/arch/powerpc/lib/test_kprobe_regs.S b/arch/powerpc/lib/test_kprobe_regs.S
new file mode 100644
index 000000000000..4e95eca6dcd3
--- /dev/null
+++ b/arch/powerpc/lib/test_kprobe_regs.S
@@ -0,0 +1,62 @@
+/*
+ * test_kprobe_regs: architectural helpers for validating pt_regs
+ *		     received on a kprobe.
+ *
+ * Copyright 2017 Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
+ *		  IBM Corporation
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; version 2
+ * of the License.
+ */
+
+#include <asm/ppc_asm.h>
+#include <asm/asm-offsets.h>
+#include <asm/ptrace.h>
+
+_GLOBAL(arch_kprobe_regs_function)
+	mflr	r0
+	std	r0, LRSAVE(r1)
+	stdu	r1, -SWITCH_FRAME_SIZE(r1)
+
+	/* Tell pre handler about our pt_regs location */
+	addi	r3, r1, STACK_FRAME_OVERHEAD
+	bl	arch_kprobe_regs_set_ptregs
+
+	/* Load back our true LR */
+	ld	r0, (SWITCH_FRAME_SIZE + LRSAVE)(r1)
+	mtlr	r0
+
+	/* Save all SPRs that we care about */
+	mfctr	r0
+	std	r0, _CTR(r1)
+	mflr	r0
+	std	r0, _LINK(r1)
+	mfspr	r0, SPRN_XER
+	std	r0, _XER(r1)
+	mfcr	r0
+	std	r0, _CCR(r1)
+
+	/* Now, save all GPRs */
+	SAVE_2GPRS(0, r1)
+	SAVE_10GPRS(2, r1)
+	SAVE_10GPRS(12, r1)
+	SAVE_10GPRS(22, r1)
+
+	/* We're now ready to be probed */
+.global arch_kprobe_regs_probepoint
+arch_kprobe_regs_probepoint:
+	nop
+
+#ifdef CONFIG_KPROBES_ON_FTRACE
+	/* Let's also test KPROBES_ON_FTRACE */
+	bl	kprobe_regs_kp_on_ftrace_target
+	nop
+#endif
+
+	/* All done */
+	addi	r1, r1, SWITCH_FRAME_SIZE
+	ld	r0, LRSAVE(r1)
+	mtlr	r0
+	blr
diff --git a/arch/powerpc/lib/test_kprobes.c b/arch/powerpc/lib/test_kprobes.c
new file mode 100644
index 000000000000..23f7a7ffcdd6
--- /dev/null
+++ b/arch/powerpc/lib/test_kprobes.c
@@ -0,0 +1,115 @@
+/*
+ * test_kprobes: architectural helpers for validating pt_regs
+ *		 received on a kprobe.
+ *
+ * Copyright 2017 Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
+ *		  IBM Corporation
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; version 2
+ * of the License.
+ */
+
+#define pr_fmt(fmt) "Kprobe smoke test (regs): " fmt
+
+#include <asm/ptrace.h>
+#include <linux/kernel.h>
+#include <linux/kprobes.h>
+
+static struct pt_regs *r;
+
+void arch_kprobe_regs_set_ptregs(struct pt_regs *regs)
+{
+	r = regs;
+}
+
+static int validate_regs(struct kprobe *p, struct pt_regs *regs,
+					int kp_on_ftrace, int post_handler)
+{
+	int i, ret = 1;
+
+	if (!r) {
+		pr_err("pt_regs not setup!\n");
+		return 0;
+	}
+
+	if (regs->gpr[1] + STACK_FRAME_OVERHEAD != (unsigned long)r) {
+		/* We'll continue since this may just indicate an incorrect r1 */
+		pr_err("pt_regs pointer/r1 doesn't point where we expect!\n");
+		ret = 0;
+	}
+
+	for (i = 0; i < 32; i++) {
+		/* KPROBES_ON_FTRACE may have stomped r0 in the prologue */
+		if (r->gpr[i] != regs->gpr[i] && (!kp_on_ftrace || i != 0)) {
+			pr_err("gpr[%d] expected: 0x%lx, received: 0x%lx\n",
+						i, r->gpr[i], regs->gpr[i]);
+			ret = 0;
+		}
+	}
+
+	if (r->ctr != regs->ctr) {
+		pr_err("ctr expected: 0x%lx, received: 0x%lx\n",
+					r->ctr, regs->ctr);
+		ret = 0;
+	}
+
+	if (r->link != regs->link && !kp_on_ftrace) {
+		pr_err("link expected: 0x%lx, received: 0x%lx\n",
+					r->link, regs->link);
+		ret = 0;
+	}
+
+	/* KPROBES_ON_FTRACE *must* have clobbered link */
+	if (r->link == regs->link && kp_on_ftrace) {
+		pr_err("link register not clobbered for KPROBES_ON_FTRACE!\n");
+		ret = 0;
+	}
+
+	if (r->xer != regs->xer) {
+		pr_err("xer expected: 0x%lx, received: 0x%lx\n",
+					r->xer, regs->xer);
+		ret = 0;
+	}
+
+	if (r->ccr != regs->ccr) {
+		pr_err("ccr expected: 0x%lx, received: 0x%lx\n",
+					r->ccr, regs->ccr);
+		ret = 0;
+	}
+
+	if (!post_handler && regs->nip != (unsigned long)p->addr) {
+		pr_err("nip expected: 0x%lx, received: 0x%lx\n",
+					(unsigned long)p->addr, regs->nip);
+		ret = 0;
+	}
+
+	if (post_handler &&
+		regs->nip != (unsigned long)p->addr + sizeof(kprobe_opcode_t)) {
+		pr_err("post_handler: nip expected: 0x%lx, received: 0x%lx\n",
+				(unsigned long)p->addr + sizeof(kprobe_opcode_t),
+				regs->nip);
+		ret = 0;
+	}
+
+	return ret;
+}
+
+int arch_kprobe_regs_pre_handler(struct kprobe *p, struct pt_regs *regs)
+{
+	return validate_regs(p, regs, 0, 0);
+}
+
+int arch_kprobe_regs_post_handler(struct kprobe *p, struct pt_regs *regs,
+							unsigned long flags)
+{
+	return validate_regs(p, regs, 0, 1);
+}
+
+#ifdef CONFIG_KPROBES_ON_FTRACE
+int arch_kp_on_ftrace_pre_handler(struct kprobe *p, struct pt_regs *regs)
+{
+	return validate_regs(p, regs, 1, 0);
+}
+#endif
diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index 541df0b5b815..adfbb5b27acd 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -253,6 +253,17 @@ static inline void kretprobe_assert(struct kretprobe_instance *ri,
 
 #ifdef CONFIG_KPROBES_SANITY_TEST
 extern int init_test_probes(void);
+#ifdef HAVE_KPROBES_REGS_SANITY_TEST
+extern void arch_kprobe_regs_function(void);
+extern void arch_kprobe_regs_probepoint(void);
+extern int arch_kprobe_regs_pre_handler(struct kprobe *p, struct pt_regs *regs);
+extern int arch_kprobe_regs_post_handler(struct kprobe *p, struct pt_regs *regs,
+						unsigned long flags);
+#ifdef CONFIG_KPROBES_ON_FTRACE
+extern void kprobe_regs_kp_on_ftrace_target(void);
+extern int arch_kp_on_ftrace_pre_handler(struct kprobe *p, struct pt_regs *regs);
+#endif
+#endif
 #else
 static inline int init_test_probes(void)
 {
diff --git a/kernel/test_kprobes.c b/kernel/test_kprobes.c
index 0dbab6d1acb4..92011726cc69 100644
--- a/kernel/test_kprobes.c
+++ b/kernel/test_kprobes.c
@@ -19,6 +19,7 @@
 #include <linux/kernel.h>
 #include <linux/kprobes.h>
 #include <linux/random.h>
+#include <linux/workqueue.h>
 
 #define div_factor 3
 
@@ -334,6 +335,166 @@ static int test_kretprobes(void)
 }
 #endif /* CONFIG_KRETPROBES */
 
+#ifdef HAVE_KPROBES_REGS_SANITY_TEST
+static int kprobe_regs_pre_handler(struct kprobe *p, struct pt_regs *regs)
+{
+	/* architectural helper returns 0 if validation fails */
+	preh_val = arch_kprobe_regs_pre_handler(p, regs);
+	return 0;
+}
+
+static void kprobe_regs_post_handler(struct kprobe *p, struct pt_regs *regs,
+						unsigned long flags)
+{
+	posth_val = arch_kprobe_regs_post_handler(p, regs, flags);
+}
+
+static struct kprobe kpr = {
+	.symbol_name = "arch_kprobe_regs_probepoint",
+	.pre_handler = kprobe_regs_pre_handler,
+	.post_handler = kprobe_regs_post_handler,
+};
+
+static int test_kprobe_regs(void)
+{
+	int ret;
+	kprobe_opcode_t *addr;
+
+	preh_val = 0;
+	posth_val = 0;
+
+	ret = register_kprobe(&kpr);
+	if (ret < 0) {
+		pr_err("register_kprobe returned %d\n", ret);
+		return ret;
+	}
+
+	/* Let's see if this probe was optimized */
+	addr = kprobe_lookup_name(kpr.symbol_name, 0);
+	if (addr && *addr != BREAKPOINT_INSTRUCTION) {
+		pr_err("kprobe with post_handler optimized\n");
+		unregister_kprobe(&kpr);
+		return -1;
+	}
+
+	arch_kprobe_regs_function();
+	unregister_kprobe(&kpr);
+
+	if (preh_val == 0) {
+		pr_err("kprobe pre_handler regs validation failed\n");
+		handler_errors++;
+	}
+
+	if (posth_val == 0) {
+		pr_err("kprobe post_handler not called\n");
+		handler_errors++;
+	}
+
+	return 0;
+}
+
+#ifdef CONFIG_KPROBES_ON_FTRACE
+void kprobe_regs_kp_on_ftrace_target(void)
+{
+	posth_val = preh_val + div_factor;
+}
+
+static int kp_on_ftrace_pre_handler(struct kprobe *p, struct pt_regs *regs)
+{
+	/* architectural helper returns 0 if validation fails */
+	preh_val = arch_kp_on_ftrace_pre_handler(p, regs);
+	return 0;
+}
+
+static struct kprobe kprf = {
+	.symbol_name = "kprobe_regs_kp_on_ftrace_target",
+	.pre_handler = kp_on_ftrace_pre_handler,
+};
+
+static int test_kp_on_ftrace_regs(void)
+{
+	int ret;
+
+	preh_val = 0;
+
+	ret = register_kprobe(&kprf);
+	if (ret < 0) {
+		pr_err("register_kprobe returned %d\n", ret);
+		return ret;
+	}
+
+	arch_kprobe_regs_function();
+	unregister_kprobe(&kprf);
+
+	if (preh_val == 0) {
+		pr_err("kp_on_ftrace pre_handler regs validation failed\n");
+		handler_errors++;
+	}
+
+	return 0;
+}
+#endif
+
+#ifdef CONFIG_OPTPROBES
+static void test_optprobe_regs(struct work_struct *work);
+static DECLARE_DELAYED_WORK(test_optprobe_regs_work, test_optprobe_regs);
+int kprobe_registered;
+
+static struct kprobe kpor = {
+	.symbol_name = "arch_kprobe_regs_probepoint",
+	.pre_handler = kprobe_regs_pre_handler,
+};
+
+static void test_optprobe_regs_setup(void)
+{
+	int ret;
+
+	ret = register_kprobe(&kpor);
+	if (ret < 0) {
+		pr_err("register_kprobe returned %d\n", ret);
+		return;
+	}
+
+	kprobe_registered = 1;
+}
+
+static void test_optprobe_regs(struct work_struct *work)
+{
+	kprobe_opcode_t *addr;
+
+	if (!kprobe_registered) {
+		errors++;
+		goto summary;
+	}
+
+	/* Let's see if this probe was optimized */
+	addr = kprobe_lookup_name(kpor.symbol_name, 0);
+	if (addr && *addr == BREAKPOINT_INSTRUCTION) {
+		pr_info("kprobe not optimized yet... skipping optprobe test\n");
+		unregister_kprobe(&kpor);
+		goto summary;
+	}
+
+	preh_val = 0;
+	arch_kprobe_regs_function();
+	unregister_kprobe(&kpor);
+
+	if (preh_val == 0) {
+		pr_err("optprobe pre_handler regs validation failed\n");
+		handler_errors++;
+	}
+
+summary:
+	if (errors)
+		pr_err("BUG: %d out of %d tests failed\n", errors, num_tests);
+	else if (handler_errors)
+		pr_err("BUG: %d error(s) running handlers\n", handler_errors);
+	else
+		pr_info("passed successfully\n");
+}
+#endif
+#endif
+
 int init_test_probes(void)
 {
 	int ret;
@@ -378,12 +539,34 @@ int init_test_probes(void)
 		errors++;
 #endif /* CONFIG_KRETPROBES */
 
+#ifdef HAVE_KPROBES_REGS_SANITY_TEST
+	num_tests++;
+	ret = test_kprobe_regs();
+	if (ret < 0)
+		errors++;
+
+#ifdef CONFIG_KPROBES_ON_FTRACE
+	num_tests++;
+	ret = test_kp_on_ftrace_regs();
+	if (ret < 0)
+		errors++;
+#endif
+
+#ifdef CONFIG_OPTPROBES
+	num_tests++;
+	test_optprobe_regs_setup();
+	schedule_delayed_work(&test_optprobe_regs_work, 10);
+#endif
+#endif
+
+#if !defined(HAVE_KPROBES_REGS_SANITY_TEST) || !defined(CONFIG_OPTPROBES)
 	if (errors)
 		pr_err("BUG: %d out of %d tests failed\n", errors, num_tests);
 	else if (handler_errors)
 		pr_err("BUG: %d error(s) running handlers\n", handler_errors);
 	else
 		pr_info("passed successfully\n");
+#endif
 
 	return 0;
 }
-- 
2.12.2
