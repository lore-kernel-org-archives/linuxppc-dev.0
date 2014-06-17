Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9CFDF1A0168
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jun 2014 16:15:40 +1000 (EST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 4/5] powerpc/ftrace: Fix nop of modules on 64bit LE (ABIv2)
Date: Tue, 17 Jun 2014 16:15:35 +1000
Message-Id: <1402985736-32180-4-git-send-email-mpe@ellerman.id.au>
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

There is a bug in the handling of the function entry when we are nopping
out a branch from a module in ftrace.

We compare the result of module_trampoline_target() with the value of
ppc_function_entry(), and expect them to be true. But they never will
be.

module_trampoline_target() will always return the global entry point of
the function, whereas ppc_function_entry() will always return the local.

Fix it by using the newly added ppc_global_function_entry().

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/ftrace.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/ftrace.c b/arch/powerpc/kernel/ftrace.c
index 8fc0c17..96efc66 100644
--- a/arch/powerpc/kernel/ftrace.c
+++ b/arch/powerpc/kernel/ftrace.c
@@ -105,7 +105,7 @@ __ftrace_make_nop(struct module *mod,
 		  struct dyn_ftrace *rec, unsigned long addr)
 {
 	unsigned int op;
-	unsigned long ptr;
+	unsigned long entry, ptr;
 	unsigned long ip = rec->ip;
 	void *tramp;
 
@@ -136,10 +136,11 @@ __ftrace_make_nop(struct module *mod,
 
 	pr_devel("trampoline target %lx", ptr);
 
+	entry = ppc_global_function_entry((void *)addr);
 	/* This should match what was called */
-	if (ptr != ppc_function_entry((void *)addr)) {
+	if (ptr != entry) {
 		printk(KERN_ERR "addr %lx does not match expected %lx\n",
-			ptr, ppc_function_entry((void *)addr));
+			ptr, entry);
 		return -EINVAL;
 	}
 
-- 
1.9.1
