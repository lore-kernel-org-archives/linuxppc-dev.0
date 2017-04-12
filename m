Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w31SK34hHzDqGv
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 21:10:57 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3CB4o8n142640
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 07:10:52 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0b-001b2d01.pphosted.com with ESMTP id 29rxx3vads-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 07:10:52 -0400
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 12 Apr 2017 21:10:43 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3CBAVLg34013242
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 21:10:39 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3CBA5IP001471
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 21:10:06 +1000
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/5] powerpc: kprobes: add support for KPROBES_ON_FTRACE
Date: Wed, 12 Apr 2017 16:39:25 +0530
In-Reply-To: <cover.1491994965.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1491994965.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1491994965.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1491994965.git.naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <e0341fcc7a75e186f5e55ca749f586a7ce109b7d.1491994966.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Allow kprobes to be placed on ftrace _mcount() call sites. This
optimization avoids the use of a trap, by riding on ftrace
infrastructure.

This depends on HAVE_DYNAMIC_FTRACE_WITH_REGS which depends on
MPROFILE_KERNEL, which is only currently enabled on powerpc64le with
newer toolchains.

Based on the x86 code by Masami.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 .../debug/kprobes-on-ftrace/arch-support.txt       |   2 +-
 arch/powerpc/Kconfig                               |   1 +
 arch/powerpc/include/asm/kprobes.h                 |  10 ++
 arch/powerpc/kernel/Makefile                       |   3 +
 arch/powerpc/kernel/kprobes-ftrace.c               | 104 +++++++++++++++++++++
 arch/powerpc/kernel/kprobes.c                      |   8 +-
 6 files changed, 126 insertions(+), 2 deletions(-)
 create mode 100644 arch/powerpc/kernel/kprobes-ftrace.c

diff --git a/Documentation/features/debug/kprobes-on-ftrace/arch-support.txt b/Documentation/features/debug/kprobes-on-ftrace/arch-support.txt
index 40f44d041fb4..930430c6aef6 100644
--- a/Documentation/features/debug/kprobes-on-ftrace/arch-support.txt
+++ b/Documentation/features/debug/kprobes-on-ftrace/arch-support.txt
@@ -27,7 +27,7 @@
     |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: | TODO |
-    |     powerpc: | TODO |
+    |     powerpc: |  ok  |
     |        s390: | TODO |
     |       score: | TODO |
     |          sh: | TODO |
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 9ff731f50a29..a55a776a1a43 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -142,6 +142,7 @@ config PPC
 	select HAVE_IRQ_EXIT_ON_IRQ_STACK
 	select HAVE_KERNEL_GZIP
 	select HAVE_KPROBES
+	select HAVE_KPROBES_ON_FTRACE
 	select HAVE_KRETPROBES
 	select HAVE_LIVEPATCH			if HAVE_DYNAMIC_FTRACE_WITH_REGS
 	select HAVE_MEMBLOCK
diff --git a/arch/powerpc/include/asm/kprobes.h b/arch/powerpc/include/asm/kprobes.h
index a843884aafaf..a83821f33ea3 100644
--- a/arch/powerpc/include/asm/kprobes.h
+++ b/arch/powerpc/include/asm/kprobes.h
@@ -103,6 +103,16 @@ extern int kprobe_exceptions_notify(struct notifier_block *self,
 extern int kprobe_fault_handler(struct pt_regs *regs, int trapnr);
 extern int kprobe_handler(struct pt_regs *regs);
 extern int kprobe_post_handler(struct pt_regs *regs);
+#ifdef CONFIG_KPROBES_ON_FTRACE
+extern int skip_singlestep(struct kprobe *p, struct pt_regs *regs,
+			   struct kprobe_ctlblk *kcb);
+#else
+static inline int skip_singlestep(struct kprobe *p, struct pt_regs *regs,
+				  struct kprobe_ctlblk *kcb)
+{
+	return 0;
+}
+#endif
 #else
 static inline int kprobe_handler(struct pt_regs *regs) { return 0; }
 static inline int kprobe_post_handler(struct pt_regs *regs) { return 0; }
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 811f441a125f..3e461637b64d 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -97,6 +97,7 @@ obj-$(CONFIG_BOOTX_TEXT)	+= btext.o
 obj-$(CONFIG_SMP)		+= smp.o
 obj-$(CONFIG_KPROBES)		+= kprobes.o
 obj-$(CONFIG_OPTPROBES)		+= optprobes.o optprobes_head.o
+obj-$(CONFIG_KPROBES_ON_FTRACE)	+= kprobes-ftrace.o
 obj-$(CONFIG_UPROBES)		+= uprobes.o
 obj-$(CONFIG_PPC_UDBG_16550)	+= legacy_serial.o udbg_16550.o
 obj-$(CONFIG_STACKTRACE)	+= stacktrace.o
@@ -150,6 +151,8 @@ GCOV_PROFILE_machine_kexec_32.o := n
 UBSAN_SANITIZE_machine_kexec_32.o := n
 GCOV_PROFILE_kprobes.o := n
 UBSAN_SANITIZE_kprobes.o := n
+GCOV_PROFILE_kprobes-ftrace.o := n
+UBSAN_SANITIZE_kprobes-ftrace.o := n
 UBSAN_SANITIZE_vdso.o := n
 
 extra-$(CONFIG_PPC_FPU)		+= fpu.o
diff --git a/arch/powerpc/kernel/kprobes-ftrace.c b/arch/powerpc/kernel/kprobes-ftrace.c
new file mode 100644
index 000000000000..6c089d9757c9
--- /dev/null
+++ b/arch/powerpc/kernel/kprobes-ftrace.c
@@ -0,0 +1,104 @@
+/*
+ * Dynamic Ftrace based Kprobes Optimization
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ *
+ * Copyright (C) Hitachi Ltd., 2012
+ * Copyright 2016 Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
+ *		  IBM Corporation
+ */
+#include <linux/kprobes.h>
+#include <linux/ptrace.h>
+#include <linux/hardirq.h>
+#include <linux/preempt.h>
+#include <linux/ftrace.h>
+
+static nokprobe_inline
+int __skip_singlestep(struct kprobe *p, struct pt_regs *regs,
+		      struct kprobe_ctlblk *kcb, unsigned long orig_nip)
+{
+	/*
+	 * Emulate singlestep (and also recover regs->nip)
+	 * as if there is a nop
+	 */
+	regs->nip = (unsigned long)p->addr + MCOUNT_INSN_SIZE;
+	if (unlikely(p->post_handler)) {
+		kcb->kprobe_status = KPROBE_HIT_SSDONE;
+		p->post_handler(p, regs, 0);
+	}
+	__this_cpu_write(current_kprobe, NULL);
+	if (orig_nip)
+		regs->nip = orig_nip;
+	return 1;
+}
+
+int skip_singlestep(struct kprobe *p, struct pt_regs *regs,
+		    struct kprobe_ctlblk *kcb)
+{
+	if (kprobe_ftrace(p))
+		return __skip_singlestep(p, regs, kcb, 0);
+	else
+		return 0;
+}
+NOKPROBE_SYMBOL(skip_singlestep);
+
+/* Ftrace callback handler for kprobes */
+void kprobe_ftrace_handler(unsigned long nip, unsigned long parent_nip,
+			   struct ftrace_ops *ops, struct pt_regs *regs)
+{
+	struct kprobe *p;
+	struct kprobe_ctlblk *kcb;
+	unsigned long flags;
+
+	/* Disable irq for emulating a breakpoint and avoiding preempt */
+	local_irq_save(flags);
+	hard_irq_disable();
+
+	p = get_kprobe((kprobe_opcode_t *)nip);
+	if (unlikely(!p) || kprobe_disabled(p))
+		goto end;
+
+	kcb = get_kprobe_ctlblk();
+	if (kprobe_running()) {
+		kprobes_inc_nmissed_count(p);
+	} else {
+		unsigned long orig_nip = regs->nip;
+
+		/*
+		 * On powerpc, NIP is *before* this instruction for the
+		 * pre handler
+		 */
+		regs->nip -= MCOUNT_INSN_SIZE;
+
+		__this_cpu_write(current_kprobe, p);
+		kcb->kprobe_status = KPROBE_HIT_ACTIVE;
+		if (!p->pre_handler || !p->pre_handler(p, regs))
+			__skip_singlestep(p, regs, kcb, orig_nip);
+		/*
+		 * If pre_handler returns !0, it sets regs->nip and
+		 * resets current kprobe.
+		 */
+	}
+end:
+	local_irq_restore(flags);
+}
+NOKPROBE_SYMBOL(kprobe_ftrace_handler);
+
+int arch_prepare_kprobe_ftrace(struct kprobe *p)
+{
+	p->ainsn.insn = NULL;
+	p->ainsn.boostable = -1;
+	return 0;
+}
diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
index 005bd4a75902..b78b274e1d6e 100644
--- a/arch/powerpc/kernel/kprobes.c
+++ b/arch/powerpc/kernel/kprobes.c
@@ -192,7 +192,11 @@ static void __kprobes set_current_kprobe(struct kprobe *p, struct pt_regs *regs,
 bool arch_function_offset_within_entry(unsigned long offset)
 {
 #ifdef PPC64_ELF_ABI_v2
+#ifdef CONFIG_KPROBES_ON_FTRACE
+	return offset <= 16;
+#else
 	return offset <= 8;
+#endif
 #else
 	return !offset;
 #endif
@@ -300,7 +304,9 @@ int __kprobes kprobe_handler(struct pt_regs *regs)
 			}
 			p = __this_cpu_read(current_kprobe);
 			if (p->break_handler && p->break_handler(p, regs)) {
-				goto ss_probe;
+				if (!skip_singlestep(p, regs, kcb))
+					goto ss_probe;
+				ret = 1;
 			}
 		}
 		goto no_kprobe;
-- 
2.12.1
