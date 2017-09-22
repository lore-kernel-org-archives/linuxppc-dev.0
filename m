Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xz75123ZczDsM5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Sep 2017 19:11:17 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v8M9ATlf030856
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Sep 2017 05:11:14 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2d4pnkb7gp-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Sep 2017 05:11:14 -0400
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Fri, 22 Sep 2017 19:11:12 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v8M9B8Fg37617796
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Sep 2017 19:11:08 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v8M9Axm5020588
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Sep 2017 19:10:59 +1000
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 3/6] powerpc/kprobes: Clean up jprobe detection in
 livepatch handler
Date: Fri, 22 Sep 2017 14:40:45 +0530
In-Reply-To: <9e98f74834af349564b71bc8443bdad55d6e37c6.1505934128.git.naveen.n.rao@linux.vnet.ibm.com>
References: <9e98f74834af349564b71bc8443bdad55d6e37c6.1505934128.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1505934128.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1505934128.git.naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <cbbac4a5801024513912b730bbbfc44a8002d434.1505934128.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In commit c05b8c4474c03 ("powerpc/kprobes: Skip livepatch_handler() for
jprobes"), we added a helper is_current_kprobe_addr() to help detect if
the modified regs->nip was due to a jprobe or livepatch. Masami felt
that the function name was not quite clear. To that end, this patch
renames is_current_kprobe_addr() to __is_active_jprobe() and adds a
comment to (hopefully) better clarify the purpose of this helper. The
helper has also now been moved to kprobes-ftrace.c so that it is only
available for KPROBES_ON_FTRACE.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/kprobes.h             |  2 +-
 arch/powerpc/kernel/kprobes-ftrace.c           | 11 +++++++++++
 arch/powerpc/kernel/kprobes.c                  |  6 ------
 arch/powerpc/kernel/trace/ftrace_64_mprofile.S |  4 ++--
 4 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/include/asm/kprobes.h b/arch/powerpc/include/asm/kprobes.h
index 8814a7249ceb..9f3be5c8a4a3 100644
--- a/arch/powerpc/include/asm/kprobes.h
+++ b/arch/powerpc/include/asm/kprobes.h
@@ -103,8 +103,8 @@ extern int kprobe_exceptions_notify(struct notifier_block *self,
 extern int kprobe_fault_handler(struct pt_regs *regs, int trapnr);
 extern int kprobe_handler(struct pt_regs *regs);
 extern int kprobe_post_handler(struct pt_regs *regs);
-extern int is_current_kprobe_addr(unsigned long addr);
 #ifdef CONFIG_KPROBES_ON_FTRACE
+extern int __is_active_jprobe(unsigned long addr);
 extern int skip_singlestep(struct kprobe *p, struct pt_regs *regs,
 			   struct kprobe_ctlblk *kcb);
 #else
diff --git a/arch/powerpc/kernel/kprobes-ftrace.c b/arch/powerpc/kernel/kprobes-ftrace.c
index 6c089d9757c9..48f675a73cff 100644
--- a/arch/powerpc/kernel/kprobes-ftrace.c
+++ b/arch/powerpc/kernel/kprobes-ftrace.c
@@ -25,6 +25,17 @@
 #include <linux/preempt.h>
 #include <linux/ftrace.h>
 
+/*
+ * This is called from ftrace code after invoking registered handlers to
+ * disambiguate regs->nip changes done by jprobes and livepatch. We check if
+ * there is an active jprobe at the provided address (mcount location).
+ */
+int __is_active_jprobe(unsigned long addr)
+{
+	struct kprobe *p = kprobe_running();
+	return (p && (unsigned long)p->addr == addr) ? 1 : 0;
+}
+
 static nokprobe_inline
 int __skip_singlestep(struct kprobe *p, struct pt_regs *regs,
 		      struct kprobe_ctlblk *kcb, unsigned long orig_nip)
diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
index 4c1702423676..48a81614f629 100644
--- a/arch/powerpc/kernel/kprobes.c
+++ b/arch/powerpc/kernel/kprobes.c
@@ -43,12 +43,6 @@ DEFINE_PER_CPU(struct kprobe_ctlblk, kprobe_ctlblk);
 
 struct kretprobe_blackpoint kretprobe_blacklist[] = {{NULL, NULL}};
 
-int is_current_kprobe_addr(unsigned long addr)
-{
-	struct kprobe *p = kprobe_running();
-	return (p && (unsigned long)p->addr == addr) ? 1 : 0;
-}
-
 bool arch_within_kprobe_blacklist(unsigned long addr)
 {
 	return  (addr >= (unsigned long)__kprobes_text_start &&
diff --git a/arch/powerpc/kernel/trace/ftrace_64_mprofile.S b/arch/powerpc/kernel/trace/ftrace_64_mprofile.S
index c98e90b4ea7b..c1cfcce0551d 100644
--- a/arch/powerpc/kernel/trace/ftrace_64_mprofile.S
+++ b/arch/powerpc/kernel/trace/ftrace_64_mprofile.S
@@ -110,9 +110,9 @@ ftrace_call:
 	/* NIP has not been altered, skip over further checks */
 	beq	1f
 
-	/* Check if there is an active kprobe on us */
+	/* Check if there is an active jprobe on us */
 	subi	r3, r14, 4
-	bl	is_current_kprobe_addr
+	bl	__is_active_jprobe
 	nop
 
 	/*
-- 
2.14.1
