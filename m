Return-Path: <mhiramat@redhat.com>
Received: from mx2.redhat.com (mx2.redhat.com [66.187.237.31])
	by ozlabs.org (Postfix) with ESMTP id EE207DDE00
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Mar 2009 08:09:38 +1100 (EST)
Message-ID: <49C2B4BF.4080904@redhat.com>
Date: Thu, 19 Mar 2009 17:10:23 -0400
From: Masami Hiramatsu <mhiramat@redhat.com>
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>, linuxppc-dev@ozlabs.org
Subject: [RFC][PATCH -tip 4/9] power: add kernel_trap_sp()
Content-Type: text/plain; charset=ISO-8859-1
Cc: systemtap-ml <systemtap@sources.redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add kernel_trap_sp() on powerpc, based on systemtap's runtime/regs.h.

Signed-off-by: Masami Hiramatsu <mhiramat@redhat.com>
---
 arch/powerpc/include/asm/ptrace.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/ptrace.h b/arch/powerpc/include/asm/ptrace.h
index c9c678f..0ac366c 100644
--- a/arch/powerpc/include/asm/ptrace.h
+++ b/arch/powerpc/include/asm/ptrace.h
@@ -83,6 +83,7 @@ struct pt_regs {

 #define instruction_pointer(regs) ((regs)->nip)
 #define user_stack_pointer(regs) ((regs)->gpr[1])
+#define kernel_trap_sp(regs) (user_stack_pointer(regs))
 #define regs_return_value(regs) ((regs)->gpr[3])

 #ifdef CONFIG_SMP
-- 
Masami Hiramatsu

Software Engineer
Hitachi Computer Products (America) Inc.
Software Solutions Division

e-mail: mhiramat@redhat.com
