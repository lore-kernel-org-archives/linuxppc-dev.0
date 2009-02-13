Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.125]) by ozlabs.org (Postfix) with ESMTP id 2DD7BDDFC2
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Feb 2009 02:01:48 +1100 (EST)
Message-Id: <20090213150147.180922180@goodmis.org>
References: <20090213150055.947823726@goodmis.org>
Date: Fri, 13 Feb 2009 10:00:57 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linuxppc-dev@ozlabs.org
Subject: [PATCH 2/2] powerpc, ftrace: use create_branch lib function
Cc: Steven Rostedt <srostedt@redhat.com>, Paul Mackerras <paulus@samba.org>,
	Frederic Weisbecker <fweisbec@gmail.com>, Ingo Molnar <mingo@elte.hu>,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Steven Rostedt <srostedt@redhat.com>

Impact: clean up, remove duplicate code

When ftrace was first ported to PowerPC, there existed a
create_function_call that would create the instruction to make a call
to a given address. Unfortunately, this call expected to write to
the address it was given, and since it used the address to calculate
the offset, it could not be faked.

ftrace needed a way to create the instruction without actually writing
that instruction to the text section. So ftrace had to implement its
own code.

Now we have create_branch in the code patching library, which does
exactly what ftrace needs. This patch replaces ftrace's implementation
with the library function.

Signed-off-by: Steven Rostedt <srostedt@redhat.com>
---
 arch/powerpc/kernel/ftrace.c |   14 +-------------
 1 files changed, 1 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/kernel/ftrace.c b/arch/powerpc/kernel/ftrace.c
index 610c852..4c75a1c 100644
--- a/arch/powerpc/kernel/ftrace.c
+++ b/arch/powerpc/kernel/ftrace.c
@@ -31,11 +31,6 @@
 #endif
 
 #ifdef CONFIG_DYNAMIC_FTRACE
-static unsigned int ftrace_calc_offset(long ip, long addr)
-{
-	return (int)(addr - ip);
-}
-
 static unsigned int ftrace_nop_replace(void)
 {
 	return PPC_NOP_INSTR;
@@ -46,17 +41,10 @@ ftrace_call_replace(unsigned long ip, unsigned long addr, int link)
 {
 	unsigned int op;
 
-	/*
-	 * It would be nice to just use create_function_call, but that will
-	 * update the code itself. Here we need to just return the
-	 * instruction that is going to be modified, without modifying the
-	 * code.
-	 */
 	addr = GET_ADDR(addr);
 
 	/* if (link) set op to 'bl' else 'b' */
-	op = 0x48000000 | (link ? 1 : 0);
-	op |= (ftrace_calc_offset(ip, addr) & 0x03fffffc);
+	op = create_branch((unsigned int *)ip, addr, link ? 1 : 0);
 
 	return op;
 }
-- 
1.5.6.5

-- 
