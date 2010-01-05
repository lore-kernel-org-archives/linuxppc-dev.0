Return-Path: <mhiramat@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id 1EEC8B6EF4
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Jan 2010 09:42:43 +1100 (EST)
From: Masami Hiramatsu <mhiramat@redhat.com>
Subject: [PATCH -tip 3/8] x86/ptrace: Remove unused regs_get_argument_nth API
To: Ingo Molnar <mingo@elte.hu>, lkml<linux-kernel@vger.kernel.org>
Date: Tue, 05 Jan 2010 17:46:56 -0500
Message-ID: <20100105224656.19431.92588.stgit@dhcp-100-2-132.bos.redhat.com>
In-Reply-To: <20100105224634.19431.3259.stgit@dhcp-100-2-132.bos.redhat.com>
References: <20100105224634.19431.3259.stgit@dhcp-100-2-132.bos.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: DLE <dle-develop@lists.sourceforge.net>,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
	Oleg Nesterov <oleg@redhat.com>, Steven Rostedt <rostedt@goodmis.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	linuxppc-dev@ozlabs.org, Michael Neuling <mikey@neuling.org>,
	systemtap <systemtap@sources.redhat.com>,
	Ingo Molnar <mingo@elte.hu>, Roland McGrath <roland@redhat.com>,
	Masami Hiramatsu <mhiramat@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Because of dropping function argument syntax from kprobe-tracer,
we don't need this API anymore.

Signed-off-by: Masami Hiramatsu <mhiramat@redhat.com>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Roland McGrath <roland@redhat.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Michael Neuling <mikey@neuling.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: linuxppc-dev@ozlabs.org
---

 arch/x86/include/asm/ptrace.h |    4 ----
 arch/x86/kernel/ptrace.c      |   24 ------------------------
 2 files changed, 0 insertions(+), 28 deletions(-)

diff --git a/arch/x86/include/asm/ptrace.h b/arch/x86/include/asm/ptrace.h
index 9d369f6..2010280 100644
--- a/arch/x86/include/asm/ptrace.h
+++ b/arch/x86/include/asm/ptrace.h
@@ -274,10 +274,6 @@ static inline unsigned long regs_get_kernel_stack_nth(struct pt_regs *regs,
 		return 0;
 }
 
-/* Get Nth argument at function call */
-extern unsigned long regs_get_argument_nth(struct pt_regs *regs,
-					   unsigned int n);
-
 /*
  * These are defined as per linux/ptrace.h, which see.
  */
diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
index 017d937..73554a3 100644
--- a/arch/x86/kernel/ptrace.c
+++ b/arch/x86/kernel/ptrace.c
@@ -140,30 +140,6 @@ static const int arg_offs_table[] = {
 #endif
 };
 
-/**
- * regs_get_argument_nth() - get Nth argument at function call
- * @regs:	pt_regs which contains registers at function entry.
- * @n:		argument number.
- *
- * regs_get_argument_nth() returns @n th argument of a function call.
- * Since usually the kernel stack will be changed right after function entry,
- * you must use this at function entry. If the @n th entry is NOT in the
- * kernel stack or pt_regs, this returns 0.
- */
-unsigned long regs_get_argument_nth(struct pt_regs *regs, unsigned int n)
-{
-	if (n < ARRAY_SIZE(arg_offs_table))
-		return *(unsigned long *)((char *)regs + arg_offs_table[n]);
-	else {
-		/*
-		 * The typical case: arg n is on the stack.
-		 * (Note: stack[0] = return address, so skip it)
-		 */
-		n -= ARRAY_SIZE(arg_offs_table);
-		return regs_get_kernel_stack_nth(regs, 1 + n);
-	}
-}
-
 /*
  * does not yet catch signals sent when the child dies.
  * in exit.c or in signal.c.


-- 
Masami Hiramatsu

Software Engineer
Hitachi Computer Products (America), Inc.
Software Solutions Division

e-mail: mhiramat@redhat.com
