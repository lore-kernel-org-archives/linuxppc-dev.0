Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.124]) by ozlabs.org (Postfix) with ESMTP id 4F60FDDE1C
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Nov 2008 08:23:36 +1100 (EST)
Message-Id: <20081119212334.093013344@goodmis.org>
References: <20081119212204.318400312@goodmis.org>
Date: Wed, 19 Nov 2008 16:22:10 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 6/9] powerpc: ftrace, use probe_kernel API to modify code
Cc: Andrew Morton <akpm@linux-foundation.org>, Milton Miller <miltonm@bga.com>,
	linuxppc-dev@ozlabs.org, Steven Rostedt <srostedt@redhat.com>,
	Paul Mackerras <paulus@samba.org>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@elte.hu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Impact: use cleaner probe_kernel API over assembly

Using probe_kernel_read/write interface is a much cleaner approach
than the current assembly version.

Signed-off-by: Steven Rostedt <srostedt@redhat.com>
---
 arch/powerpc/kernel/ftrace.c |   53 ++++++++++++++++-------------------------
 1 files changed, 21 insertions(+), 32 deletions(-)

diff --git a/arch/powerpc/kernel/ftrace.c b/arch/powerpc/kernel/ftrace.c
index 24c023a..1adfbb2 100644
--- a/arch/powerpc/kernel/ftrace.c
+++ b/arch/powerpc/kernel/ftrace.c
@@ -9,6 +9,7 @@
 
 #include <linux/spinlock.h>
 #include <linux/hardirq.h>
+#include <linux/uaccess.h>
 #include <linux/ftrace.h>
 #include <linux/percpu.h>
 #include <linux/init.h>
@@ -72,45 +73,33 @@ static int
 ftrace_modify_code(unsigned long ip, unsigned char *old_code,
 		   unsigned char *new_code)
 {
-	unsigned replaced;
-	unsigned old = *(unsigned *)old_code;
-	unsigned new = *(unsigned *)new_code;
-	int faulted = 0;
+	unsigned char replaced[MCOUNT_INSN_SIZE];
 
 	/*
 	 * Note: Due to modules and __init, code can
 	 *  disappear and change, we need to protect against faulting
-	 *  as well as code changing.
+	 *  as well as code changing. We do this by using the
+	 *  probe_kernel_* functions.
 	 *
 	 * No real locking needed, this code is run through
-	 * kstop_machine.
+	 * kstop_machine, or before SMP starts.
 	 */
-	asm volatile (
-		"1: lwz		%1, 0(%2)\n"
-		"   cmpw	%1, %5\n"
-		"   bne		2f\n"
-		"   stwu	%3, 0(%2)\n"
-		"2:\n"
-		".section .fixup, \"ax\"\n"
-		"3:	li %0, 1\n"
-		"	b 2b\n"
-		".previous\n"
-		".section __ex_table,\"a\"\n"
-		_ASM_ALIGN "\n"
-		_ASM_PTR "1b, 3b\n"
-		".previous"
-		: "=r"(faulted), "=r"(replaced)
-		: "r"(ip), "r"(new),
-		  "0"(faulted), "r"(old)
-		: "memory");
-
-	if (replaced != old && replaced != new)
-		faulted = 2;
-
-	if (!faulted)
-		flush_icache_range(ip, ip + 8);
-
-	return faulted;
+
+	/* read the text we want to modify */
+	if (probe_kernel_read(replaced, (void *)ip, MCOUNT_INSN_SIZE))
+		return -EFAULT;
+
+	/* Make sure it is what we expect it to be */
+	if (memcmp(replaced, old_code, MCOUNT_INSN_SIZE) != 0)
+		return -EINVAL;
+
+	/* replace the text with the new text */
+	if (probe_kernel_write((void *)ip, new_code, MCOUNT_INSN_SIZE))
+		return -EPERM;
+
+	flush_icache_range(ip, ip + 8);
+
+	return 0;
 }
 
 static int test_24bit_addr(unsigned long ip, unsigned long addr)
-- 
1.5.6.5

-- 
