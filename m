Return-Path: <Marcin.Nowakowski@imgtec.com>
Received: from mailapp01.imgtec.com (mailapp01.imgtec.com [195.59.15.196])
 by lists.ozlabs.org (Postfix) with ESMTP id 3sb6Ll3P8vzDsXV
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Sep 2016 17:27:43 +1000 (AEST)
From: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
To: <linux-kernel@vger.kernel.org>
CC: Marcin Nowakowski <marcin.nowakowski@imgtec.com>, Steven Rostedt
 <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael
 Ellerman <mpe@ellerman.id.au>, <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH v2 08/11] powerpc/tracing: fix compat syscall handling
Date: Fri, 16 Sep 2016 09:11:24 +0200
Message-ID: <1474009887-7225-9-git-send-email-marcin.nowakowski@imgtec.com>
In-Reply-To: <1474009887-7225-1-git-send-email-marcin.nowakowski@imgtec.com>
References: <1474009887-7225-1-git-send-email-marcin.nowakowski@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Adapt the code to make use of new syscall handling interface

Signed-off-by: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/include/asm/ftrace.h | 11 +++++++++++
 arch/powerpc/kernel/ftrace.c      |  4 ++++
 2 files changed, 15 insertions(+)

diff --git a/arch/powerpc/include/asm/ftrace.h b/arch/powerpc/include/asm/ftrace.h
index 9697a73..d2ea3b6 100644
--- a/arch/powerpc/include/asm/ftrace.h
+++ b/arch/powerpc/include/asm/ftrace.h
@@ -86,6 +86,17 @@ static inline bool arch_syscall_match_sym_name(const char *sym, const char *name
 	return !strcmp(sym + prefix_len + 1, name + prefix_len);
 }
 #endif
+
+#if defined(CONFIG_COMPAT)
+#include <linux/compat.h>
+#include <asm/compat.h>
+
+#define ARCH_COMPAT_SYSCALL_NUMBERS_OVERLAP 1
+static inline bool arch_trace_is_compat_syscall(struct pt_regs *regs)
+{
+	return in_compat_syscall();
+}
+#endif /* CONFIG_COMPAT */
 #endif /* CONFIG_FTRACE_SYSCALLS && !__ASSEMBLY__ */
 
 #endif /* _ASM_POWERPC_FTRACE */
diff --git a/arch/powerpc/kernel/ftrace.c b/arch/powerpc/kernel/ftrace.c
index 71f4d07..0764fa5 100644
--- a/arch/powerpc/kernel/ftrace.c
+++ b/arch/powerpc/kernel/ftrace.c
@@ -605,6 +605,10 @@ out:
 #if defined(CONFIG_FTRACE_SYSCALLS) && defined(CONFIG_PPC64)
 unsigned long __init arch_syscall_addr(int nr, bool compat)
 {
+#ifdef CONFIG_COMPAT
+	if (compat)
+		return sys_call_table[nr*2+1];
+#endif
 	return sys_call_table[nr*2];
 }
 #endif /* CONFIG_FTRACE_SYSCALLS && CONFIG_PPC64 */
-- 
2.7.4
