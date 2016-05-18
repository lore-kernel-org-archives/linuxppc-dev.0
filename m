Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r8bsh2rfqzDqBh
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 May 2016 11:17:44 +1000 (AEST)
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3r8bsg37nRz9vL9
 for <linuxppc-dev@ozlabs.org>; Wed, 18 May 2016 11:17:43 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id y7so3414098pfb.0
 for <linuxppc-dev@ozlabs.org>; Tue, 17 May 2016 18:17:43 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@ozlabs.org
Cc: mpe@ellerman.id.au,
	Daniel Axtens <dja@axtens.net>
Subject: [PATCH 2/4] powerpc: Introduce asm-prototypes.h
Date: Wed, 18 May 2016 11:16:50 +1000
Message-Id: <1463534212-4879-2-git-send-email-dja@axtens.net>
In-Reply-To: <1463534212-4879-1-git-send-email-dja@axtens.net>
References: <1463534212-4879-1-git-send-email-dja@axtens.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Sparse picked up a number of functions that are implemented in C and
then only referred to in asm code.

This introduces asm-prototypes.h, which provides a place for
prototypes of these functions.

This silences some sparse warnings.

Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 arch/powerpc/include/asm/asm-prototypes.h         | 79 +++++++++++++++++++++++
 arch/powerpc/kernel/machine_kexec_64.c            |  1 +
 arch/powerpc/kernel/smp.c                         |  1 +
 arch/powerpc/kernel/traps.c                       |  1 +
 arch/powerpc/lib/vmx-helper.c                     |  1 +
 arch/powerpc/platforms/powernv/opal-tracepoints.c |  1 +
 arch/powerpc/platforms/pseries/lpar.c             |  1 +
 7 files changed, 85 insertions(+)
 create mode 100644 arch/powerpc/include/asm/asm-prototypes.h

diff --git a/arch/powerpc/include/asm/asm-prototypes.h b/arch/powerpc/include/asm/asm-prototypes.h
new file mode 100644
index 000000000000..6ee0a9d80bbc
--- /dev/null
+++ b/arch/powerpc/include/asm/asm-prototypes.h
@@ -0,0 +1,79 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * Copyright IBM Corp. 2016
+ *
+ * Authors: Daniel Axtens <dja@axtens.net>
+ */
+
+/*
+ * This file is for prototypes of C functions that are only called
+ * from asm, and any associated variables.
+ */
+
+#include <linux/threads.h>
+#include <linux/kprobes.h>
+
+/* SMP */
+extern struct thread_info *current_set[NR_CPUS];
+extern struct thread_info *secondary_ti;
+void start_secondary(void *unused);
+
+/* kexec */
+struct paca_struct;
+struct kimage;
+extern struct paca_struct kexec_paca;
+void kexec_copy_flush(struct kimage *image);
+
+/* pSeries hcall tracing */
+extern struct static_key hcall_tracepoint_key;
+void __trace_hcall_entry(unsigned long opcode, unsigned long *args);
+void __trace_hcall_exit(long opcode, unsigned long retval,
+			unsigned long *retbuf);
+/* OPAL tracing */
+#ifdef HAVE_JUMP_LABEL
+extern struct static_key opal_tracepoint_key;
+#endif
+
+void __trace_opal_entry(unsigned long opcode, unsigned long *args);
+void __trace_opal_exit(long opcode, unsigned long retval);
+
+/* VMX copying */
+int enter_vmx_usercopy(void);
+int exit_vmx_usercopy(void);
+int enter_vmx_copy(void);
+void * exit_vmx_copy(void *dest);
+
+/* Traps */
+long machine_check_early(struct pt_regs *regs);
+long hmi_exception_realmode(struct pt_regs *regs);
+void SMIException(struct pt_regs *regs);
+void handle_hmi_exception(struct pt_regs *regs);
+void instruction_breakpoint_exception(struct pt_regs *regs);
+void RunModeException(struct pt_regs *regs);
+void __kprobes single_step_exception(struct pt_regs *regs);
+void __kprobes program_check_exception(struct pt_regs *regs);
+void alignment_exception(struct pt_regs *regs);
+void StackOverflow(struct pt_regs *regs);
+void nonrecoverable_exception(struct pt_regs *regs);
+void kernel_fp_unavailable_exception(struct pt_regs *regs);
+void altivec_unavailable_exception(struct pt_regs *regs);
+void vsx_unavailable_exception(struct pt_regs *regs);
+void fp_unavailable_tm(struct pt_regs *regs);
+void altivec_unavailable_tm(struct pt_regs *regs);
+void vsx_unavailable_tm(struct pt_regs *regs);
+void facility_unavailable_exception(struct pt_regs *regs);
+void TAUException(struct pt_regs *regs);
+void altivec_assist_exception(struct pt_regs *regs);
+void unrecoverable_exception(struct pt_regs *regs);
+void kernel_bad_stack(struct pt_regs *regs);
+void system_reset_exception(struct pt_regs *regs);
+void machine_check_exception(struct pt_regs *regs);
+void __kprobes emulation_assist_interrupt(struct pt_regs *regs);
diff --git a/arch/powerpc/kernel/machine_kexec_64.c b/arch/powerpc/kernel/machine_kexec_64.c
index b8c202d63ecb..50bf55135ef8 100644
--- a/arch/powerpc/kernel/machine_kexec_64.c
+++ b/arch/powerpc/kernel/machine_kexec_64.c
@@ -29,6 +29,7 @@
 #include <asm/prom.h>
 #include <asm/smp.h>
 #include <asm/hw_breakpoint.h>
+#include <asm/asm-prototypes.h>
 
 #ifdef CONFIG_PPC_BOOK3E
 int default_machine_kexec_prepare(struct kimage *image)
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 55c924b65f71..f1adc3c4f4ca 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -53,6 +53,7 @@
 #include <asm/vdso.h>
 #include <asm/debug.h>
 #include <asm/kexec.h>
+#include <asm/asm-prototypes.h>
 
 #ifdef DEBUG
 #include <asm/udbg.h>
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 9229ba63c370..11d15e7270e0 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -60,6 +60,7 @@
 #include <asm/switch_to.h>
 #include <asm/tm.h>
 #include <asm/debug.h>
+#include <asm/asm-prototypes.h>
 #include <sysdev/fsl_pci.h>
 
 #if defined(CONFIG_DEBUGGER) || defined(CONFIG_KEXEC)
diff --git a/arch/powerpc/lib/vmx-helper.c b/arch/powerpc/lib/vmx-helper.c
index b27e030fc9f8..bf925cdcaca9 100644
--- a/arch/powerpc/lib/vmx-helper.c
+++ b/arch/powerpc/lib/vmx-helper.c
@@ -21,6 +21,7 @@
 #include <linux/uaccess.h>
 #include <linux/hardirq.h>
 #include <asm/switch_to.h>
+#include <asm/asm-prototypes.h>
 
 int enter_vmx_usercopy(void)
 {
diff --git a/arch/powerpc/platforms/powernv/opal-tracepoints.c b/arch/powerpc/platforms/powernv/opal-tracepoints.c
index e11273b2386d..1e496b780efd 100644
--- a/arch/powerpc/platforms/powernv/opal-tracepoints.c
+++ b/arch/powerpc/platforms/powernv/opal-tracepoints.c
@@ -1,6 +1,7 @@
 #include <linux/percpu.h>
 #include <linux/jump_label.h>
 #include <asm/trace.h>
+#include <asm/asm-prototypes.h>
 
 #ifdef HAVE_JUMP_LABEL
 struct static_key opal_tracepoint_key = STATIC_KEY_INIT;
diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index 7f6100d91b4b..03ff9867a610 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -45,6 +45,7 @@
 #include <asm/plpar_wrappers.h>
 #include <asm/kexec.h>
 #include <asm/fadump.h>
+#include <asm/asm-prototypes.h>
 
 #include "pseries.h"
 
-- 
2.5.0
