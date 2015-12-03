Return-Path: <anton@samba.org>
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::147:1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3DA4B1A017D
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Dec 2015 22:31:26 +1100 (AEDT)
Date: Thu, 3 Dec 2015 22:31:06 +1100
From: Anton Blanchard <anton@samba.org>
To: Michael Ellerman <mpe@ellerman.id.au>, benh@kernel.crashing.org,
 paulus@samba.org
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/vdso: Remove sys_ni_syscall and sys_call_table
 prototypes
Message-ID: <20151203223106.47b2be5b@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Prototypes for sys_ni_syscall and sys_call_table are available
in header files, so remove the prototypes in c code.

This was noticed when building with -flto, because the prototype for
sys_ni_syscall doesn't match the function and we get a compiler error.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

diff --git a/arch/powerpc/include/asm/syscall.h b/arch/powerpc/include/asm/syscall.h
index ab9f3f0..d65f0cc 100644
--- a/arch/powerpc/include/asm/syscall.h
+++ b/arch/powerpc/include/asm/syscall.h
@@ -17,10 +17,7 @@
 #include <linux/sched.h>
 #include <linux/thread_info.h>
 
-/* ftrace syscalls requires exporting the sys_call_table */
-#ifdef CONFIG_FTRACE_SYSCALLS
 extern const unsigned long sys_call_table[];
-#endif /* CONFIG_FTRACE_SYSCALLS */
 
 static inline int syscall_get_nr(struct task_struct *task, struct pt_regs *regs)
 {
diff --git a/arch/powerpc/kernel/vdso.c b/arch/powerpc/kernel/vdso.c
index b457bfa..16d2d52 100644
--- a/arch/powerpc/kernel/vdso.c
+++ b/arch/powerpc/kernel/vdso.c
@@ -21,6 +21,7 @@
 #include <linux/elf.h>
 #include <linux/security.h>
 #include <linux/memblock.h>
+#include <linux/syscalls.h>
 
 #include <asm/pgtable.h>
 #include <asm/processor.h>
@@ -34,6 +35,7 @@
 #include <asm/vdso.h>
 #include <asm/vdso_datapage.h>
 #include <asm/setup.h>
+#include <asm/syscall.h>
 
 #undef DEBUG
 
@@ -667,9 +669,6 @@ static __init int vdso_setup(void)
 static void __init vdso_setup_syscall_map(void)
 {
 	unsigned int i;
-	extern unsigned long *sys_call_table;
-	extern unsigned long sys_ni_syscall;
-
 
 	for (i = 0; i < __NR_syscalls; i++) {
 #ifdef CONFIG_PPC64
