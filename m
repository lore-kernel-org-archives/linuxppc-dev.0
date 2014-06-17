Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3771E1A027E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jun 2014 16:15:41 +1000 (EST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 5/5] powerpc/ftrace: Use pr_fmt() to namespace error messages
Date: Tue, 17 Jun 2014 16:15:36 +1000
Message-Id: <1402985736-32180-5-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1402985736-32180-1-git-send-email-mpe@ellerman.id.au>
References: <1402985736-32180-1-git-send-email-mpe@ellerman.id.au>
Cc: Anton Blanchard <anton@samba.org>, dcb314@hotmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The printks() in our ftrace code have no prefix, so they appear on the
console with very little context, eg:

  Branch out of range

Use pr_fmt() & pr_err() to add a prefix. While we're at it, collapse a
few split lines that don't need to be, and add a missing newline to one
message.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/ftrace.c | 43 ++++++++++++++++++++-----------------------
 1 file changed, 20 insertions(+), 23 deletions(-)

diff --git a/arch/powerpc/kernel/ftrace.c b/arch/powerpc/kernel/ftrace.c
index 96efc66..d178834 100644
--- a/arch/powerpc/kernel/ftrace.c
+++ b/arch/powerpc/kernel/ftrace.c
@@ -10,6 +10,8 @@
  *
  */
 
+#define pr_fmt(fmt) "ftrace-powerpc: " fmt
+
 #include <linux/spinlock.h>
 #include <linux/hardirq.h>
 #include <linux/uaccess.h>
@@ -115,7 +117,7 @@ __ftrace_make_nop(struct module *mod,
 
 	/* Make sure that that this is still a 24bit jump */
 	if (!is_bl_op(op)) {
-		printk(KERN_ERR "Not expected bl: opcode is %x\n", op);
+		pr_err("Not expected bl: opcode is %x\n", op);
 		return -EINVAL;
 	}
 
@@ -125,12 +127,12 @@ __ftrace_make_nop(struct module *mod,
 	pr_devel("ip:%lx jumps to %p", ip, tramp);
 
 	if (!is_module_trampoline(tramp)) {
-		printk(KERN_ERR "Not a trampoline\n");
+		pr_err("Not a trampoline\n");
 		return -EINVAL;
 	}
 
 	if (module_trampoline_target(mod, tramp, &ptr)) {
-		printk(KERN_ERR "Failed to get trampoline target\n");
+		pr_err("Failed to get trampoline target\n");
 		return -EFAULT;
 	}
 
@@ -139,8 +141,7 @@ __ftrace_make_nop(struct module *mod,
 	entry = ppc_global_function_entry((void *)addr);
 	/* This should match what was called */
 	if (ptr != entry) {
-		printk(KERN_ERR "addr %lx does not match expected %lx\n",
-			ptr, entry);
+		pr_err("addr %lx does not match expected %lx\n", ptr, entry);
 		return -EINVAL;
 	}
 
@@ -180,7 +181,7 @@ __ftrace_make_nop(struct module *mod,
 
 	/* Make sure that that this is still a 24bit jump */
 	if (!is_bl_op(op)) {
-		printk(KERN_ERR "Not expected bl: opcode is %x\n", op);
+		pr_err("Not expected bl: opcode is %x\n", op);
 		return -EINVAL;
 	}
 
@@ -199,7 +200,7 @@ __ftrace_make_nop(struct module *mod,
 
 	/* Find where the trampoline jumps to */
 	if (probe_kernel_read(jmp, (void *)tramp, sizeof(jmp))) {
-		printk(KERN_ERR "Failed to read %lx\n", tramp);
+		pr_err("Failed to read %lx\n", tramp);
 		return -EFAULT;
 	}
 
@@ -210,7 +211,7 @@ __ftrace_make_nop(struct module *mod,
 	    ((jmp[1] & 0xffff0000) != 0x398c0000) ||
 	    (jmp[2] != 0x7d8903a6) ||
 	    (jmp[3] != 0x4e800420)) {
-		printk(KERN_ERR "Not a trampoline\n");
+		pr_err("Not a trampoline\n");
 		return -EINVAL;
 	}
 
@@ -222,8 +223,7 @@ __ftrace_make_nop(struct module *mod,
 	pr_devel(" %lx ", tramp);
 
 	if (tramp != addr) {
-		printk(KERN_ERR
-		       "Trampoline location %08lx does not match addr\n",
+		pr_err("Trampoline location %08lx does not match addr\n",
 		       tramp);
 		return -EINVAL;
 	}
@@ -264,15 +264,13 @@ int ftrace_make_nop(struct module *mod,
 	 */
 	if (!rec->arch.mod) {
 		if (!mod) {
-			printk(KERN_ERR "No module loaded addr=%lx\n",
-			       addr);
+			pr_err("No module loaded addr=%lx\n", addr);
 			return -EFAULT;
 		}
 		rec->arch.mod = mod;
 	} else if (mod) {
 		if (mod != rec->arch.mod) {
-			printk(KERN_ERR
-			       "Record mod %p not equal to passed in mod %p\n",
+			pr_err("Record mod %p not equal to passed in mod %p\n",
 			       rec->arch.mod, mod);
 			return -EINVAL;
 		}
@@ -309,25 +307,24 @@ __ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
 	 * just mask it out when doing the compare.
 	 */
 	if ((op[0] != 0x48000008) || ((op[1] & 0xffff0000) != 0xe8410000)) {
-		printk(KERN_ERR "Unexpected call sequence: %x %x\n",
-			op[0], op[1]);
+		pr_err("Unexpected call sequence: %x %x\n", op[0], op[1]);
 		return -EINVAL;
 	}
 
 	/* If we never set up a trampoline to ftrace_caller, then bail */
 	if (!rec->arch.mod->arch.tramp) {
-		printk(KERN_ERR "No ftrace trampoline\n");
+		pr_err("No ftrace trampoline\n");
 		return -EINVAL;
 	}
 
 	/* Ensure branch is within 24 bits */
 	if (!create_branch(ip, rec->arch.mod->arch.tramp, BRANCH_SET_LINK)) {
-		printk(KERN_ERR "Branch out of range");
+		pr_err("Branch out of range\n");
 		return -EINVAL;
 	}
 
 	if (patch_branch(ip, rec->arch.mod->arch.tramp, BRANCH_SET_LINK)) {
-		printk(KERN_ERR "REL24 out of range!\n");
+		pr_err("REL24 out of range!\n");
 		return -EINVAL;
 	}
 
@@ -346,13 +343,13 @@ __ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
 
 	/* It should be pointing to a nop */
 	if (op != PPC_INST_NOP) {
-		printk(KERN_ERR "Expected NOP but have %x\n", op);
+		pr_err("Expected NOP but have %x\n", op);
 		return -EINVAL;
 	}
 
 	/* If we never set up a trampoline to ftrace_caller, then bail */
 	if (!rec->arch.mod->arch.tramp) {
-		printk(KERN_ERR "No ftrace trampoline\n");
+		pr_err("No ftrace trampoline\n");
 		return -EINVAL;
 	}
 
@@ -360,7 +357,7 @@ __ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
 	op = create_branch((unsigned int *)ip,
 			   rec->arch.mod->arch.tramp, BRANCH_SET_LINK);
 	if (!op) {
-		printk(KERN_ERR "REL24 out of range!\n");
+		pr_err("REL24 out of range!\n");
 		return -EINVAL;
 	}
 
@@ -398,7 +395,7 @@ int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
 	 * already have a module defined.
 	 */
 	if (!rec->arch.mod) {
-		printk(KERN_ERR "No module loaded\n");
+		pr_err("No module loaded\n");
 		return -EINVAL;
 	}
 
-- 
1.9.1
