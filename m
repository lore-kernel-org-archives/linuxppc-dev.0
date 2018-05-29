Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40wCrv2NBfzDr4h
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 May 2018 22:36:30 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4TCZ2Hj126352
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 May 2018 08:36:28 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2j95wquc78-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 May 2018 08:36:27 -0400
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Tue, 29 May 2018 13:36:26 +0100
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Ingo Molnar <mingo@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Masami Hiramatsu <mhiramat@kernel.org>, Josef Bacik <jbacik@fb.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] powerpc: Add support for function error injection
Date: Tue, 29 May 2018 18:06:03 +0530
In-Reply-To: <cover.1527596631.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1527596631.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1527596631.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1527596631.git.naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <5ad23690185a90a887514d702ecb45783090d7c0.1527596631.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/Kconfig                       | 1 +
 arch/powerpc/include/asm/error-injection.h | 9 +++++++++
 arch/powerpc/include/asm/ptrace.h          | 5 +++++
 3 files changed, 15 insertions(+)
 create mode 100644 arch/powerpc/include/asm/error-injection.h

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 23247fa551e7..ed1ab693f945 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -194,6 +194,7 @@ config PPC
 	select HAVE_EBPF_JIT			if PPC64
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS	if !(CPU_LITTLE_ENDIAN && POWER7_CPU)
 	select HAVE_FTRACE_MCOUNT_RECORD
+	select HAVE_FUNCTION_ERROR_INJECTION
 	select HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_FUNCTION_TRACER
 	select HAVE_GCC_PLUGINS
diff --git a/arch/powerpc/include/asm/error-injection.h b/arch/powerpc/include/asm/error-injection.h
new file mode 100644
index 000000000000..b596eca04ef9
--- /dev/null
+++ b/arch/powerpc/include/asm/error-injection.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_ERROR_INJECTION_H
+#define _ASM_ERROR_INJECTION_H
+
+#include <asm-generic/error-injection.h>
+
+#define ARCH_FUNC_RET	"blr"
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
-- 
2.17.0
