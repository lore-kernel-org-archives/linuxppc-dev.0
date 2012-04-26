Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
 [71.74.56.122]) by ozlabs.org (Postfix) with ESMTP id 7151DB6FB9
 for <linuxppc-dev@ozlabs.org>; Fri, 27 Apr 2012 04:35:11 +1000 (EST)
Message-Id: <20120426183509.157684433@goodmis.org>
Date: Thu, 26 Apr 2012 14:31:19 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linuxppc-dev@ozlabs.org
Subject: [PATCH 3/3][RFC] ftrace/ppc: Use patch_instruction instead of
 probe_kernel_write()
References: <20120426183116.857877522@goodmis.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Steven Rostedt <srostedt@redhat.com>

The patch_instruction() interface is made to modify kernel text. It is
safer to use that then the probe_kernel_write() when modifying kernel
code.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 arch/powerpc/kernel/ftrace.c |   17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/kernel/ftrace.c b/arch/powerpc/kernel/ftrace.c
index 84a5ddd..4e376bc 100644
--- a/arch/powerpc/kernel/ftrace.c
+++ b/arch/powerpc/kernel/ftrace.c
@@ -63,11 +63,9 @@ ftrace_modify_code(unsigned long ip, unsigned int old, unsigned int new)
 		return -EINVAL;
 
 	/* replace the text with the new text */
-	if (probe_kernel_write((void *)ip, &new, MCOUNT_INSN_SIZE))
+	if (patch_instruction((unsigned int *)ip, new))
 		return -EPERM;
 
-	flush_icache_range(ip, ip + 8);
-
 	return 0;
 }
 
@@ -212,12 +210,9 @@ __ftrace_make_nop(struct module *mod,
 	 */
 	op = 0x48000008;	/* b +8 */
 
-	if (probe_kernel_write((void *)ip, &op, MCOUNT_INSN_SIZE))
+	if (patch_instruction((unsigned int *)ip, op))
 		return -EPERM;
 
-
-	flush_icache_range(ip, ip + 8);
-
 	return 0;
 }
 
@@ -286,11 +281,9 @@ __ftrace_make_nop(struct module *mod,
 
 	op = PPC_INST_NOP;
 
-	if (probe_kernel_write((void *)ip, &op, MCOUNT_INSN_SIZE))
+	if (patch_instruction((unsigned int *)ip, op))
 		return -EPERM;
 
-	flush_icache_range(ip, ip + 8);
-
 	return 0;
 }
 #endif /* PPC64 */
@@ -426,11 +419,9 @@ __ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
 
 	pr_devel("write to %lx\n", rec->ip);
 
-	if (probe_kernel_write((void *)ip, &op, MCOUNT_INSN_SIZE))
+	if (patch_instruction((unsigned int *)ip, op))
 		return -EPERM;
 
-	flush_icache_range(ip, ip + 8);
-
 	return 0;
 }
 #endif /* CONFIG_PPC64 */
-- 
1.7.9.5
