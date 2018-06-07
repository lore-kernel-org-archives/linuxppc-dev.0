Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 411gnD1bSZzF0WH
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jun 2018 19:52:16 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w579n88q108029
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Jun 2018 05:52:13 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2jeyd60jek-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 Jun 2018 05:52:13 -0400
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 7 Jun 2018 10:52:11 +0100
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Segher Boessenkool <segher@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3] powerpc: Add support for function error injection
Date: Thu,  7 Jun 2018 15:22:02 +0530
Message-Id: <20180607095202.29189-1-naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We implement regs_set_return_value() and override_function_with_return()
for this purpose.

On powerpc, a return from a function (blr) just branches to the location
contained in the link register. So, we can just update pt_regs rather
than redirecting execution to a dummy function that returns.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
The only change is to add a comment in override_function_with_return() 
to clarify that we don't need to worry about 32-bit userspace while 
emulating 'blr'.

- Naveen

 arch/powerpc/Kconfig                       |  1 +
 arch/powerpc/include/asm/error-injection.h | 13 +++++++++++++
 arch/powerpc/include/asm/ptrace.h          |  5 +++++
 arch/powerpc/lib/Makefile                  |  2 ++
 arch/powerpc/lib/error-inject.c            | 16 ++++++++++++++++
 5 files changed, 37 insertions(+)
 create mode 100644 arch/powerpc/include/asm/error-injection.h
 create mode 100644 arch/powerpc/lib/error-inject.c

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 076fe3094856..00dad3c759a0 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -187,6 +187,7 @@ config PPC
 	select HAVE_EBPF_JIT			if PPC64
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS	if !(CPU_LITTLE_ENDIAN && POWER7_CPU)
 	select HAVE_FTRACE_MCOUNT_RECORD
+	select HAVE_FUNCTION_ERROR_INJECTION
 	select HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_FUNCTION_TRACER
 	select HAVE_GCC_PLUGINS
diff --git a/arch/powerpc/include/asm/error-injection.h b/arch/powerpc/include/asm/error-injection.h
new file mode 100644
index 000000000000..740c3075bdf4
--- /dev/null
+++ b/arch/powerpc/include/asm/error-injection.h
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#ifndef _ASM_ERROR_INJECTION_H
+#define _ASM_ERROR_INJECTION_H
+
+#include <linux/compiler.h>
+#include <linux/linkage.h>
+#include <asm/ptrace.h>
+#include <asm-generic/error-injection.h>
+
+void override_function_with_return(struct pt_regs *regs);
+
+#endif /* _ASM_ERROR_INJECTION_H */
diff --git a/arch/powerpc/include/asm/ptrace.h b/arch/powerpc/include/asm/ptrace.h
index e4923686e43a..c0705296c2f0 100644
--- a/arch/powerpc/include/asm/ptrace.h
+++ b/arch/powerpc/include/asm/ptrace.h
@@ -101,6 +101,11 @@ static inline long regs_return_value(struct pt_regs *regs)
 		return -regs->gpr[3];
 }
 
+static inline void regs_set_return_value(struct pt_regs *regs, unsigned long rc)
+{
+	regs->gpr[3] = rc;
+}
+
 #ifdef __powerpc64__
 #define user_mode(regs) ((((regs)->msr) >> MSR_PR_LG) & 0x1)
 #else
diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
index d0ca13ad8231..dd43c5a53396 100644
--- a/arch/powerpc/lib/Makefile
+++ b/arch/powerpc/lib/Makefile
@@ -14,6 +14,8 @@ obj-y += string.o alloc.o code-patching.o feature-fixups.o
 
 obj-$(CONFIG_PPC32)	+= div64.o copy_32.o crtsavres.o
 
+obj-$(CONFIG_FUNCTION_ERROR_INJECTION)	+= error-inject.o
+
 # See corresponding test in arch/powerpc/Makefile
 # 64-bit linker creates .sfpr on demand for final link (vmlinux),
 # so it is only needed for modules, and only for older linkers which
diff --git a/arch/powerpc/lib/error-inject.c b/arch/powerpc/lib/error-inject.c
new file mode 100644
index 000000000000..407b992fb02f
--- /dev/null
+++ b/arch/powerpc/lib/error-inject.c
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include <linux/error-injection.h>
+#include <linux/kprobes.h>
+#include <linux/uaccess.h>
+
+void override_function_with_return(struct pt_regs *regs)
+{
+	/*
+	 * Emulate 'blr'. 'regs' represents the state on entry of a predefined
+	 * function in the kernel/module, captured on a kprobe. We don't need
+	 * to worry about 32-bit userspace on a 64-bit kernel.
+	 */
+	regs->nip = regs->link;
+}
+NOKPROBE_SYMBOL(override_function_with_return);
-- 
2.17.0
