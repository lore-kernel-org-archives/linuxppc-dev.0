Return-Path: <muriloo@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41cXDv2QhSzF0jn
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Jul 2018 00:59:43 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w6RExFjf027958
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jul 2018 10:59:40 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2kg4uvt5yh-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jul 2018 10:59:40 -0400
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <muriloo@linux.ibm.com>;
 Fri, 27 Jul 2018 10:59:39 -0400
From: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: "Alastair D'Silva" <alastair@d-silva.org>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Christophe Leroy <christophe.leroy@c-s.fr>, Cyril Bur <cyrilbur@gmail.com>,
 "Eric W . Biederman" <ebiederm@xmission.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling <mikey@neuling.org>,
 Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Paul Mackerras <paulus@samba.org>,
 Simon Guo <wei.guo.simon@gmail.com>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 "Tobin C . Harding" <me@tobin.cc>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 08/10] powerpc: Add stacktrace.h header
Date: Fri, 27 Jul 2018 11:58:09 -0300
In-Reply-To: <20180727145811.12334-1-muriloo@linux.ibm.com>
References: <20180727145811.12334-1-muriloo@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20180727145811.12334-9-muriloo@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Move show_instructions() declaration to
arch/powerpc/include/asm/stacktrace.h and include asm/stracktrace.h in
arch/powerpc/kernel/process.c, which contains the implementation.

This allows show_instructions() to be called on, for example,
show_signal_msg().

Signed-off-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
---
 arch/powerpc/include/asm/stacktrace.h | 13 +++++++++++++
 arch/powerpc/kernel/process.c         |  3 ++-
 2 files changed, 15 insertions(+), 1 deletion(-)
 create mode 100644 arch/powerpc/include/asm/stacktrace.h

diff --git a/arch/powerpc/include/asm/stacktrace.h b/arch/powerpc/include/asm/stacktrace.h
new file mode 100644
index 000000000000..217ebc52ff97
--- /dev/null
+++ b/arch/powerpc/include/asm/stacktrace.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Stack trace functions.
+ *
+ * Copyright 2018, Murilo Opsfelder Araujo, IBM Corporation.
+ */
+
+#ifndef _ASM_POWERPC_STACKTRACE_H
+#define _ASM_POWERPC_STACKTRACE_H
+
+void show_instructions(struct pt_regs *regs);
+
+#endif /* _ASM_POWERPC_STACKTRACE_H */
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 04960796fcce..709bfb524b84 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -52,6 +52,7 @@
 #include <asm/machdep.h>
 #include <asm/time.h>
 #include <asm/runlatch.h>
+#include <asm/stacktrace.h>
 #include <asm/syscalls.h>
 #include <asm/switch_to.h>
 #include <asm/tm.h>
@@ -1261,7 +1262,7 @@ struct task_struct *__switch_to(struct task_struct *prev,
 
 static int instructions_to_print = 16;
 
-static void show_instructions(struct pt_regs *regs)
+void show_instructions(struct pt_regs *regs)
 {
 	int i;
 	unsigned long pc = regs->nip - (instructions_to_print * 3 / 4 *
-- 
2.17.1
