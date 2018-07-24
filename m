Return-Path: <muriloo@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41ZpLK4xyDzDrTH
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jul 2018 05:28:25 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w6OJOWbs138838
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jul 2018 15:28:22 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2kea81g4ya-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jul 2018 15:28:21 -0400
Received: from localhost
 by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <muriloo@linux.ibm.com>;
 Tue, 24 Jul 2018 15:28:20 -0400
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
Subject: [PATCH 7/7] powerpc/traps: Show instructions on exceptions
Date: Tue, 24 Jul 2018 16:27:20 -0300
In-Reply-To: <20180724192720.32417-1-muriloo@linux.ibm.com>
References: <20180724192720.32417-1-muriloo@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20180724192720.32417-8-muriloo@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Move show_instructions() declaration to arch/powerpc/include/asm/stacktrace.h
and include asm/stracktrace.h in arch/powerpc/kernel/process.c, which contains
the implementation.

Modify show_instructions() not to call __kernel_text_address(), allowing
userspace instruction dump.  probe_kernel_address(), which returns -EFAULT if
something goes wrong, is still being called.

Call show_instructions() in arch/powerpc/kernel/traps.c to dump instructions at
faulty location, useful to debugging.

Before this patch, an unhandled signal message looked like:

    Jul 24 09:57:00 localhost kernel: pandafault[10524]: segfault (11) at 00000000100007d0 nip 000000001000061c lr 00007fffbd295100 code 2 in pandafault[10000000+10000]

After this patch, it looks like:

    Jul 24 09:57:00 localhost kernel: pandafault[10524]: segfault (11) at 00000000100007d0 nip 000000001000061c lr 00007fffbd295100 code 2 in pandafault[10000000+10000]
    Jul 24 09:57:00 localhost kernel: Instruction dump:
    Jul 24 09:57:00 localhost kernel: 4bfffeec 4bfffee8 3c401002 38427f00 fbe1fff8 f821ffc1 7c3f0b78 3d22fffe
    Jul 24 09:57:00 localhost kernel: 392988d0 f93f0020 e93f0020 39400048 <99490000> 39200000 7d234b78 383f0040

Signed-off-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
---
 arch/powerpc/include/asm/stacktrace.h | 7 +++++++
 arch/powerpc/kernel/process.c         | 6 +++---
 arch/powerpc/kernel/traps.c           | 3 +++
 3 files changed, 13 insertions(+), 3 deletions(-)
 create mode 100644 arch/powerpc/include/asm/stacktrace.h

diff --git a/arch/powerpc/include/asm/stacktrace.h b/arch/powerpc/include/asm/stacktrace.h
new file mode 100644
index 000000000000..46e5ef451578
--- /dev/null
+++ b/arch/powerpc/include/asm/stacktrace.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_POWERPC_STACKTRACE_H
+#define _ASM_POWERPC_STACKTRACE_H
+
+void show_instructions(struct pt_regs *regs);
+
+#endif /* _ASM_POWERPC_STACKTRACE_H */
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index b1af3390249c..ee1d63e03c52 100644
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
@@ -1283,8 +1284,7 @@ static void show_instructions(struct pt_regs *regs)
 			pc = (unsigned long)phys_to_virt(pc);
 #endif
 
-		if (!__kernel_text_address(pc) ||
-		     probe_kernel_address((unsigned int __user *)pc, instr)) {
+		if (probe_kernel_address((unsigned int __user *)pc, instr)) {
 			pr_cont("XXXXXXXX ");
 		} else {
 			if (regs->nip == pc)
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index e55ee639d010..3beca17ac1b1 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -70,6 +70,7 @@
 #include <asm/hmi.h>
 #include <sysdev/fsl_pci.h>
 #include <asm/kprobes.h>
+#include <asm/stacktrace.h>
 
 #if defined(CONFIG_DEBUGGER) || defined(CONFIG_KEXEC_CORE)
 int (*__debugger)(struct pt_regs *regs) __read_mostly;
@@ -357,6 +358,8 @@ static void show_signal_msg(int signr, struct pt_regs *regs, int code,
 	print_vma_addr(KERN_CONT " in ", regs->nip);
 
 	pr_cont("\n");
+
+	show_instructions(regs);
 }
 
 void _exception_pkey(int signr, struct pt_regs *regs, int code,
-- 
2.17.1
