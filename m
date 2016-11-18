Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tKwyj5k4HzDvrt
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Nov 2016 22:39:57 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAIBdV5a015587
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Nov 2016 06:39:55 -0500
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0b-001b2d01.pphosted.com with ESMTP id 26t0ay1vpx-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Nov 2016 06:39:55 -0500
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Fri, 18 Nov 2016 21:39:52 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id EC6C73578052
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Nov 2016 22:39:48 +1100 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uAIBdmPk33292482
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Nov 2016 22:39:48 +1100
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uAIBdmPE011393
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Nov 2016 22:39:48 +1100
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Masami Hiramatsu <mhiramat@kernel.org>
Cc: Anton Blanchard <anton@samba.org>, linuxppc-dev@lists.ozlabs.org,
 Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Subject: [PATCH] powerpc: kprobes: invoke handlers directly
Date: Fri, 18 Nov 2016 17:09:26 +0530
Message-Id: <20161118113926.31350-1-naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

... rather than through notify_die(), to reduce path taken for handling
kprobes. Similar to commit 6f6343f53d13 ("kprobes/x86: Call exception
handlers directly from do_int3/do_debug").

While at it, rename post_kprobe_handler() to kprobe_post_handler() for
more uniform naming.

Reported-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/kprobes.h |  2 ++
 arch/powerpc/kernel/kprobes.c      | 29 +++++++----------------------
 arch/powerpc/kernel/traps.c        | 20 ++++++++++++++++++++
 3 files changed, 29 insertions(+), 22 deletions(-)

diff --git a/arch/powerpc/include/asm/kprobes.h b/arch/powerpc/include/asm/kprobes.h
index 2c9759bd..47c60d0 100644
--- a/arch/powerpc/include/asm/kprobes.h
+++ b/arch/powerpc/include/asm/kprobes.h
@@ -126,6 +126,8 @@ struct kprobe_ctlblk {
 
 extern int kprobe_exceptions_notify(struct notifier_block *self,
 					unsigned long val, void *data);
+extern int kprobe_handler(struct pt_regs *regs);
+extern int kprobe_post_handler(struct pt_regs *regs);
 extern int kprobe_fault_handler(struct pt_regs *regs, int trapnr);
 #endif /* __KERNEL__ */
 #endif	/* _ASM_POWERPC_KPROBES_H */
diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
index 9479d8e..ad108b8 100644
--- a/arch/powerpc/kernel/kprobes.c
+++ b/arch/powerpc/kernel/kprobes.c
@@ -140,13 +140,16 @@ void __kprobes arch_prepare_kretprobe(struct kretprobe_instance *ri,
 	regs->link = (unsigned long)kretprobe_trampoline;
 }
 
-static int __kprobes kprobe_handler(struct pt_regs *regs)
+int __kprobes kprobe_handler(struct pt_regs *regs)
 {
 	struct kprobe *p;
 	int ret = 0;
 	unsigned int *addr = (unsigned int *)regs->nip;
 	struct kprobe_ctlblk *kcb;
 
+	if (user_mode(regs))
+		return 0;
+
 	/*
 	 * We don't want to be preempted for the entire
 	 * duration of kprobe processing
@@ -359,12 +362,12 @@ static int __kprobes trampoline_probe_handler(struct kprobe *p,
  * single-stepped a copy of the instruction.  The address of this
  * copy is p->ainsn.insn.
  */
-static int __kprobes post_kprobe_handler(struct pt_regs *regs)
+int __kprobes kprobe_post_handler(struct pt_regs *regs)
 {
 	struct kprobe *cur = kprobe_running();
 	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
 
-	if (!cur)
+	if (!cur || user_mode(regs))
 		return 0;
 
 	/* make sure we got here for instruction we have a kprobe on */
@@ -470,25 +473,7 @@ int __kprobes kprobe_fault_handler(struct pt_regs *regs, int trapnr)
 int __kprobes kprobe_exceptions_notify(struct notifier_block *self,
 				       unsigned long val, void *data)
 {
-	struct die_args *args = (struct die_args *)data;
-	int ret = NOTIFY_DONE;
-
-	if (args->regs && user_mode(args->regs))
-		return ret;
-
-	switch (val) {
-	case DIE_BPT:
-		if (kprobe_handler(args->regs))
-			ret = NOTIFY_STOP;
-		break;
-	case DIE_SSTEP:
-		if (post_kprobe_handler(args->regs))
-			ret = NOTIFY_STOP;
-		break;
-	default:
-		break;
-	}
-	return ret;
+	return NOTIFY_DONE;
 }
 
 unsigned long arch_deref_entry_point(void *entry)
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 91d278c..dbcdf48 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -824,6 +824,11 @@ void single_step_exception(struct pt_regs *regs)
 
 	clear_single_step(regs);
 
+#ifdef CONFIG_KPROBES
+	if (kprobe_post_handler(regs))
+		return;
+#endif
+
 	if (notify_die(DIE_SSTEP, "single_step", regs, 5,
 					5, SIGTRAP) == NOTIFY_STOP)
 		goto bail;
@@ -1177,6 +1182,11 @@ void program_check_exception(struct pt_regs *regs)
 		if (debugger_bpt(regs))
 			goto bail;
 
+#ifdef CONFIG_KPROBES
+		if (kprobe_handler(regs))
+			goto bail;
+#endif
+
 		/* trap exception */
 		if (notify_die(DIE_BPT, "breakpoint", regs, 5, 5, SIGTRAP)
 				== NOTIFY_STOP)
@@ -1745,6 +1755,11 @@ void DebugException(struct pt_regs *regs, unsigned long debug_status)
 			return;
 		}
 
+#ifdef CONFIG_KPROBES
+		if (kprobe_post_handler(regs))
+			return;
+#endif
+
 		if (notify_die(DIE_SSTEP, "block_step", regs, 5,
 			       5, SIGTRAP) == NOTIFY_STOP) {
 			return;
@@ -1759,6 +1774,11 @@ void DebugException(struct pt_regs *regs, unsigned long debug_status)
 		/* Clear the instruction completion event */
 		mtspr(SPRN_DBSR, DBSR_IC);
 
+#ifdef CONFIG_KPROBES
+		if (kprobe_post_handler(regs))
+			return;
+#endif
+
 		if (notify_die(DIE_SSTEP, "single_step", regs, 5,
 			       5, SIGTRAP) == NOTIFY_STOP) {
 			return;
-- 
2.10.2
