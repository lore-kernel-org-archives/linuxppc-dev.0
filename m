Return-Path: <SRS0=9RGo=SD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02299C43381
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Apr 2019 06:04:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C3B12084B
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Apr 2019 06:04:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=neuling.org header.i=@neuling.org header.b="ddE7QlEC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C3B12084B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=neuling.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44XhdK5KntzDqNn
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Apr 2019 17:04:53 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44XhbX6MvgzDq6B
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Apr 2019 17:03:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=neuling.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=neuling.org header.i=@neuling.org header.b="ddE7QlEC"; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 44XhbX5Jp4z8tQ0;
 Mon,  1 Apr 2019 17:03:20 +1100 (AEDT)
Received: from spoke.localdomain (localhost [127.0.0.1])
 by ozlabs.org (Postfix) with ESMTP id 44XhbX0xmjz9sQt;
 Mon,  1 Apr 2019 17:03:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=neuling.org;
 s=201811; t=1554098600;
 bh=XzW6R2jhqKzB49LIZTPiI4e6q8pRs5OZvb/OBmvFhiQ=;
 h=From:To:Cc:Subject:Date:From;
 b=ddE7QlECtRkvkpbub00z5od4qTFZ8K9k09Mpy7yk7Rs6HBNX9FMaXYz8WyyN8xlmk
 Y/WOY9moH+3ywT9B4PNyp3GtoIa7PY78mxssshmLwDlffTZwYAeV61o66uS7Kwi9ry
 WaBXQ3uPY38dcHHOMzNY8vwW0QuSmuLX06mQfa1ntTbuWeiuwc9u/pdb3GcnLb8yoq
 fPQT0AdMrc7DfkL4OJ1UK4lfX0DxaapT3xg8oAOWQT1yaqbHp0JLXC/21CRZgiFey3
 BS2upL8LtjsemOWZNx4l5cL4HMq53cGg0UK32KDRJO6/Cuo8OkvHlURvHrlQLNs5Ud
 7myBGMiIK9m0w==
Received: by spoke.localdomain (Postfix, from userid 1000)
 id 14F072A0352; Mon,  1 Apr 2019 17:03:20 +1100 (AEDT)
From: Michael Neuling <mikey@neuling.org>
To: mpe@ellerman.id.au
Subject: [PATCH v2] powerpc: Add force enable of DAWR on P9 option
Date: Mon,  1 Apr 2019 17:03:12 +1100
Message-Id: <20190401060312.22670-1-mikey@neuling.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: mikey@neuling.org, linuxppc-dev@lists.ozlabs.org,
 Cameron Kaiser <spectre@floodgap.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This adds a flag so that the DAWR can be enabled on P9 via:
  echo Y > /sys/kernel/debug/powerpc/dawr_enable_dangerous

The DAWR was previously force disabled on POWER9 in:
  9654153158 powerpc: Disable DAWR in the base POWER9 CPU features
Also see Documentation/powerpc/DAWR-POWER9.txt

This is a dangerous setting, USE AT YOUR OWN RISK.

Some users may not care about a bad user crashing their box
(ie. single user/desktop systems) and really want the DAWR.  This
allows them to force enable DAWR.

This flag can also be used to disable DAWR access. Once this is
cleared, all DAWR access should be cleared immediately and your
machine once again safe from crashing.

Userspace may get confused by toggling this. If DAWR is force
enabled/disabled between getting the number of breakpoints (via
PTRACE_GETHWDBGINFO) and setting the breakpoint, userspace will get an
inconsistent view of what's available. Similarly for guests.

For the DAWR to be enabled in a KVM guest, the DAWR needs to be force
enabled in the host AND the guest. For this reason, this won't work on
POWERVM as it doesn't allow the HCALL to work. Writes of 'Y' to the
dawr_enable_dangerous file will fail if the hypervisor doesn't support
writing the DAWR.

To double check the DAWR is working, run this kernel selftest:
  tools/testing/selftests/powerpc/ptrace/ptrace-hwbreak.c
Any errors/failures/skips mean something is wrong.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
v2:
  Fix compile errors found by kbuild test robot.
---
 Documentation/powerpc/DAWR-POWER9.txt    | 32 ++++++++++++
 arch/powerpc/include/asm/hw_breakpoint.h |  8 +++
 arch/powerpc/kernel/hw_breakpoint.c      | 62 +++++++++++++++++++++++-
 arch/powerpc/kernel/process.c            |  9 ++--
 arch/powerpc/kernel/ptrace.c             |  3 +-
 arch/powerpc/kvm/book3s_hv.c             |  3 +-
 arch/powerpc/kvm/book3s_hv_rmhandlers.S  | 23 +++++----
 7 files changed, 123 insertions(+), 17 deletions(-)

diff --git a/Documentation/powerpc/DAWR-POWER9.txt b/Documentation/powerpc/DAWR-POWER9.txt
index 2feaa66196..bdec036509 100644
--- a/Documentation/powerpc/DAWR-POWER9.txt
+++ b/Documentation/powerpc/DAWR-POWER9.txt
@@ -56,3 +56,35 @@ POWER9. Loads and stores to the watchpoint locations will not be
 trapped in GDB. The watchpoint is remembered, so if the guest is
 migrated back to the POWER8 host, it will start working again.
 
+Force enabling the DAWR
+=============================
+Kernels (since ~v5.2) have an option to force enable the DAWR via:
+
+  echo Y > /sys/kernel/debug/powerpc/dawr_enable_dangerous
+
+This enables the DAWR even on POWER9.
+
+This is a dangerous setting, USE AT YOUR OWN RISK.
+
+Some users may not care about a bad user crashing their box
+(ie. single user/desktop systems) and really want the DAWR.  This
+allows them to force enable DAWR.
+
+This flag can also be used to disable DAWR access. Once this is
+cleared, all DAWR access should be cleared immediately and your
+machine once again safe from crashing.
+
+Userspace may get confused by toggling this. If DAWR is force
+enabled/disabled between getting the number of breakpoints (via
+PTRACE_GETHWDBGINFO) and setting the breakpoint, userspace will get an
+inconsistent view of what's available. Similarly for guests.
+
+For the DAWR to be enabled in a KVM guest, the DAWR needs to be force
+enabled in the host AND the guest. For this reason, this won't work on
+POWERVM as it doesn't allow the HCALL to work. Writes of 'Y' to the
+dawr_enable_dangerous file will fail if the hypervisor doesn't support
+writing the DAWR.
+
+To double check the DAWR is working, run this kernel selftest:
+  tools/testing/selftests/powerpc/ptrace/ptrace-hwbreak.c
+Any errors/failures/skips mean something is wrong.
diff --git a/arch/powerpc/include/asm/hw_breakpoint.h b/arch/powerpc/include/asm/hw_breakpoint.h
index ece4dc89c9..0fe8c1e46b 100644
--- a/arch/powerpc/include/asm/hw_breakpoint.h
+++ b/arch/powerpc/include/asm/hw_breakpoint.h
@@ -90,10 +90,18 @@ static inline void hw_breakpoint_disable(void)
 extern void thread_change_pc(struct task_struct *tsk, struct pt_regs *regs);
 int hw_breakpoint_handler(struct die_args *args);
 
+extern int set_dawr(struct arch_hw_breakpoint *brk);
+extern bool dawr_force_enable;
+static inline bool dawr_enabled(void)
+{
+	return dawr_force_enable;
+}
+
 #else	/* CONFIG_HAVE_HW_BREAKPOINT */
 static inline void hw_breakpoint_disable(void) { }
 static inline void thread_change_pc(struct task_struct *tsk,
 					struct pt_regs *regs) { }
+static inline bool dawr_enabled(void) { return false; }
 #endif	/* CONFIG_HAVE_HW_BREAKPOINT */
 #endif	/* __KERNEL__ */
 #endif	/* _PPC_BOOK3S_64_HW_BREAKPOINT_H */
diff --git a/arch/powerpc/kernel/hw_breakpoint.c b/arch/powerpc/kernel/hw_breakpoint.c
index fec8a67731..da307dd93e 100644
--- a/arch/powerpc/kernel/hw_breakpoint.c
+++ b/arch/powerpc/kernel/hw_breakpoint.c
@@ -29,11 +29,15 @@
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/smp.h>
+#include <linux/debugfs.h>
+#include <linux/init.h>
 
 #include <asm/hw_breakpoint.h>
 #include <asm/processor.h>
 #include <asm/sstep.h>
 #include <asm/debug.h>
+#include <asm/debugfs.h>
+#include <asm/hvcall.h>
 #include <linux/uaccess.h>
 
 /*
@@ -174,7 +178,7 @@ int hw_breakpoint_arch_parse(struct perf_event *bp,
 	if (!ppc_breakpoint_available())
 		return -ENODEV;
 	length_max = 8; /* DABR */
-	if (cpu_has_feature(CPU_FTR_DAWR)) {
+	if (dawr_enabled()) {
 		length_max = 512 ; /* 64 doublewords */
 		/* DAWR region can't cross 512 boundary */
 		if ((attr->bp_addr >> 9) !=
@@ -376,3 +380,59 @@ void hw_breakpoint_pmu_read(struct perf_event *bp)
 {
 	/* TODO */
 }
+
+bool dawr_force_enable;
+EXPORT_SYMBOL_GPL(dawr_force_enable);
+
+static ssize_t dawr_write_file_bool(struct file *file,
+				    const char __user *user_buf,
+				    size_t count, loff_t *ppos)
+{
+	struct arch_hw_breakpoint null_brk = {0, 0, 0};
+	size_t rc;
+
+	/* Send error to user if they hypervisor won't allow us to write DAWR */
+	if ((!dawr_force_enable) &&
+	    (firmware_has_feature(FW_FEATURE_LPAR)) &&
+	    (set_dawr(&null_brk) != H_SUCCESS))
+		return -1;
+
+	rc = debugfs_write_file_bool(file, user_buf, count, ppos);
+	if (rc)
+		return rc;
+
+	/* If we are clearing, make sure all CPUs have the DAWR cleared */
+	if (!dawr_force_enable)
+		smp_call_function((smp_call_func_t)set_dawr, &null_brk, 0);
+
+	return rc;
+}
+
+static const struct file_operations dawr_enable_fops = {
+	.read =		debugfs_read_file_bool,
+	.write =	dawr_write_file_bool,
+	.open =		simple_open,
+	.llseek =	default_llseek,
+};
+
+static int __init dawr_force_setup(void)
+{
+	dawr_force_enable = false;
+
+	if (cpu_has_feature(CPU_FTR_DAWR)) {
+		/* Don't setup sysfs file for user control on P8 */
+		dawr_force_enable = true;
+		return 0;
+	}
+
+	if (PVR_VER(mfspr(SPRN_PVR)) == PVR_POWER9) {
+		/* Turn DAWR off by default, but allow admin to turn it on */
+		dawr_force_enable = false;
+		debugfs_create_file_unsafe("dawr_enable_dangerous", 0600,
+					   powerpc_debugfs_root,
+					   &dawr_force_enable,
+					   &dawr_enable_fops);
+	}
+	return 0;
+}
+arch_initcall(dawr_force_setup);
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index dd9e0d5386..225705aac8 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -67,6 +67,7 @@
 #include <asm/cpu_has_feature.h>
 #include <asm/asm-prototypes.h>
 #include <asm/stacktrace.h>
+#include <asm/hw_breakpoint.h>
 
 #include <linux/kprobes.h>
 #include <linux/kdebug.h>
@@ -784,7 +785,7 @@ static inline int set_dabr(struct arch_hw_breakpoint *brk)
 	return __set_dabr(dabr, dabrx);
 }
 
-static inline int set_dawr(struct arch_hw_breakpoint *brk)
+int set_dawr(struct arch_hw_breakpoint *brk)
 {
 	unsigned long dawr, dawrx, mrd;
 
@@ -816,7 +817,7 @@ void __set_breakpoint(struct arch_hw_breakpoint *brk)
 {
 	memcpy(this_cpu_ptr(&current_brk), brk, sizeof(*brk));
 
-	if (cpu_has_feature(CPU_FTR_DAWR))
+	if (dawr_enabled())
 		// Power8 or later
 		set_dawr(brk);
 	else if (!cpu_has_feature(CPU_FTR_ARCH_207S))
@@ -830,8 +831,8 @@ void __set_breakpoint(struct arch_hw_breakpoint *brk)
 /* Check if we have DAWR or DABR hardware */
 bool ppc_breakpoint_available(void)
 {
-	if (cpu_has_feature(CPU_FTR_DAWR))
-		return true; /* POWER8 DAWR */
+	if (dawr_enabled())
+		return true; /* POWER8 DAWR or POWER9 forced DAWR */
 	if (cpu_has_feature(CPU_FTR_ARCH_207S))
 		return false; /* POWER9 with DAWR disabled */
 	/* DABR: Everything but POWER8 and POWER9 */
diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index d9ac7d9465..684b0b315c 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -43,6 +43,7 @@
 #include <asm/tm.h>
 #include <asm/asm-prototypes.h>
 #include <asm/debug.h>
+#include <asm/hw_breakpoint.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/syscalls.h>
@@ -3088,7 +3089,7 @@ long arch_ptrace(struct task_struct *child, long request,
 		dbginfo.sizeof_condition = 0;
 #ifdef CONFIG_HAVE_HW_BREAKPOINT
 		dbginfo.features = PPC_DEBUG_FEATURE_DATA_BP_RANGE;
-		if (cpu_has_feature(CPU_FTR_DAWR))
+		if (dawr_enabled())
 			dbginfo.features |= PPC_DEBUG_FEATURE_DATA_BP_DAWR;
 #else
 		dbginfo.features = 0;
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 06964350b9..0fab0a2010 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -74,6 +74,7 @@
 #include <asm/opal.h>
 #include <asm/xics.h>
 #include <asm/xive.h>
+#include <asm/hw_breakpoint.h>
 
 #include "book3s.h"
 
@@ -3374,7 +3375,7 @@ static int kvmhv_load_hv_regs_and_go(struct kvm_vcpu *vcpu, u64 time_limit,
 	mtspr(SPRN_PURR, vcpu->arch.purr);
 	mtspr(SPRN_SPURR, vcpu->arch.spurr);
 
-	if (cpu_has_feature(CPU_FTR_DAWR)) {
+	if (dawr_enabled()) {
 		mtspr(SPRN_DAWR, vcpu->arch.dawr);
 		mtspr(SPRN_DAWRX, vcpu->arch.dawrx);
 	}
diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index 3a5e719ef0..139027c62d 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -822,18 +822,21 @@ END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_207S)
 	mtspr	SPRN_IAMR, r5
 	mtspr	SPRN_PSPB, r6
 	mtspr	SPRN_FSCR, r7
-	ld	r5, VCPU_DAWR(r4)
-	ld	r6, VCPU_DAWRX(r4)
-	ld	r7, VCPU_CIABR(r4)
-	ld	r8, VCPU_TAR(r4)
 	/*
 	 * Handle broken DAWR case by not writing it. This means we
 	 * can still store the DAWR register for migration.
 	 */
-BEGIN_FTR_SECTION
+	LOAD_REG_ADDR(r5, dawr_force_enable)
+	lbz	r5, 0(r5)
+	cmpdi	r5, 0
+	beq	1f
+	ld	r5, VCPU_DAWR(r4)
+	ld	r6, VCPU_DAWRX(r4)
 	mtspr	SPRN_DAWR, r5
 	mtspr	SPRN_DAWRX, r6
-END_FTR_SECTION_IFSET(CPU_FTR_DAWR)
+1:
+	ld	r7, VCPU_CIABR(r4)
+	ld	r8, VCPU_TAR(r4)
 	mtspr	SPRN_CIABR, r7
 	mtspr	SPRN_TAR, r8
 	ld	r5, VCPU_IC(r4)
@@ -2513,11 +2516,11 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
 	blr
 
 2:
-BEGIN_FTR_SECTION
-	/* POWER9 with disabled DAWR */
+	LOAD_REG_ADDR(r11, dawr_force_enable)
+	lbz	r11, 0(r11)
+	cmpdi	r11, 0
 	li	r3, H_HARDWARE
-	blr
-END_FTR_SECTION_IFCLR(CPU_FTR_DAWR)
+	beqlr
 	/* Emulate H_SET_DABR/X on P8 for the sake of compat mode guests */
 	rlwimi	r5, r4, 5, DAWRX_DR | DAWRX_DW
 	rlwimi	r5, r4, 2, DAWRX_WT
-- 
2.20.1

