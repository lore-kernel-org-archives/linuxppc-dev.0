Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xst0K2gGSzDqp3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Sep 2017 06:04:01 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v8DK3wRD107205
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Sep 2017 16:03:58 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2cy9umehw9-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Sep 2017 16:03:57 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 14 Sep 2017 06:03:50 +1000
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v8DK3mno41287682
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Sep 2017 06:03:48 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v8DK3l4X024886
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Sep 2017 06:03:48 +1000
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Anton Blanchard <anton@samba.org>
Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH] powerpc/uprobes: Fixup si_addr if we took an exception
 while single stepping
Date: Thu, 14 Sep 2017 01:33:30 +0530
Message-Id: <20170913200330.15606-1-naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If the single-stepped instruction causes an exception, we may end up
setting siginfo.si_addr to the address of the uprobe xol area. This is
not desirable since the address won't make sense for the process if it
wants to handle the exception. Fixup the si_addr field in such cases.

Reported-by: Anton Blanchard <anton@samba.org>
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/uprobes.h |  7 +++++++
 arch/powerpc/kernel/traps.c        |  4 ++++
 arch/powerpc/kernel/uprobes.c      | 17 +++++++++++++++++
 3 files changed, 28 insertions(+)

diff --git a/arch/powerpc/include/asm/uprobes.h b/arch/powerpc/include/asm/uprobes.h
index 7422a999a39a..13fc6af3c1fd 100644
--- a/arch/powerpc/include/asm/uprobes.h
+++ b/arch/powerpc/include/asm/uprobes.h
@@ -23,6 +23,7 @@
  */
 
 #include <linux/notifier.h>
+#include <asm/siginfo.h>
 #include <asm/probes.h>
 
 typedef ppc_opcode_t uprobe_opcode_t;
@@ -45,4 +46,10 @@ struct arch_uprobe_task {
 	unsigned long	saved_trap_nr;
 };
 
+#ifdef CONFIG_UPROBES
+extern void uprobe_fixup_exception(struct pt_regs *regs, siginfo_t *info);
+#else
+static inline void uprobe_fixup_exception(struct pt_regs *regs, siginfo_t *info) { }
+#endif
+
 #endif	/* _ASM_UPROBES_H */
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index ec74e203ee04..1bb858a37029 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -66,6 +66,7 @@
 #include <asm/hmi.h>
 #include <sysdev/fsl_pci.h>
 #include <asm/kprobes.h>
+#include <asm/uprobes.h>
 
 #if defined(CONFIG_DEBUGGER) || defined(CONFIG_KEXEC_CORE)
 int (*__debugger)(struct pt_regs *regs) __read_mostly;
@@ -292,6 +293,9 @@ void _exception(int signr, struct pt_regs *regs, int code, unsigned long addr)
 	info.si_signo = signr;
 	info.si_code = code;
 	info.si_addr = (void __user *) addr;
+
+	uprobe_fixup_exception(regs, &info);
+
 	force_sig_info(signr, &info, current);
 }
 
diff --git a/arch/powerpc/kernel/uprobes.c b/arch/powerpc/kernel/uprobes.c
index 5d105b8eeece..a361a56e6210 100644
--- a/arch/powerpc/kernel/uprobes.c
+++ b/arch/powerpc/kernel/uprobes.c
@@ -25,6 +25,7 @@
 #include <linux/uprobes.h>
 #include <linux/uaccess.h>
 #include <linux/kdebug.h>
+#include <linux/signal.h>
 
 #include <asm/sstep.h>
 
@@ -214,3 +215,19 @@ bool arch_uretprobe_is_alive(struct return_instance *ret, enum rp_check ctx,
 	else
 		return regs->gpr[1] < ret->stack;
 }
+
+void uprobe_fixup_exception(struct pt_regs *regs, siginfo_t *info)
+{
+	struct task_struct *t = current;
+	struct uprobe_task *utask = t->utask;
+
+	if (likely(!utask || !utask->active_uprobe))
+		return;
+
+	/*
+	 * We reset si_addr here.
+	 * regs->nip is reset during our way back through uprobe_deny_signal()
+	 */
+	if (info->si_addr == (void __user *) utask->xol_vaddr)
+		info->si_addr = (void __user *) utask->vaddr;
+}
-- 
2.14.1
