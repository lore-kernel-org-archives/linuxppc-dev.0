Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2E1101A0018
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jun 2014 13:23:39 +1000 (EST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc/kprobes: Fix jprobes on ABI v2 (LE)
Date: Mon, 23 Jun 2014 13:23:31 +1000
Message-Id: <1403493811-28172-1-git-send-email-mpe@ellerman.id.au>
Cc: Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In commit 721aeaa9 "Build little endian ppc64 kernel with ABIv2", we
missed some updates required in the kprobes code to make jprobes work
when the kernel is built with ABI v2.

Firstly update arch_deref_entry_point() to do the right thing. Now that
we have added ppc_global_function_entry() we can just always use that, it
will do the right thing for 32 & 64 bit and ABI v1 & v2.

Secondly we need to update the code that sets up the register state before
calling the jprobe handler. On ABI v1 we setup r2 to hold the TOC, on ABI
v2 we need to populate r12 with the function entry point address.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
Obviously depends on my previous patch to add ppc_global_function_entry().

 arch/powerpc/kernel/kprobes.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
index 90fab64..2f72af8 100644
--- a/arch/powerpc/kernel/kprobes.c
+++ b/arch/powerpc/kernel/kprobes.c
@@ -32,6 +32,7 @@
 #include <linux/module.h>
 #include <linux/kdebug.h>
 #include <linux/slab.h>
+#include <asm/code-patching.h>
 #include <asm/cacheflush.h>
 #include <asm/sstep.h>
 #include <asm/uaccess.h>
@@ -491,12 +492,10 @@ int __kprobes kprobe_exceptions_notify(struct notifier_block *self,
 	return ret;
 }
 
-#ifdef CONFIG_PPC64
 unsigned long arch_deref_entry_point(void *entry)
 {
-	return ((func_descr_t *)entry)->entry;
+	return ppc_global_function_entry(entry);
 }
-#endif
 
 int __kprobes setjmp_pre_handler(struct kprobe *p, struct pt_regs *regs)
 {
@@ -508,8 +507,12 @@ int __kprobes setjmp_pre_handler(struct kprobe *p, struct pt_regs *regs)
 	/* setup return addr to the jprobe handler routine */
 	regs->nip = arch_deref_entry_point(jp->entry);
 #ifdef CONFIG_PPC64
+#if defined(_CALL_ELF) && _CALL_ELF == 2
+	regs->gpr[12] = (unsigned long)jp->entry;
+#else
 	regs->gpr[2] = (unsigned long)(((func_descr_t *)jp->entry)->toc);
 #endif
+#endif
 
 	return 1;
 }
-- 
1.9.1
