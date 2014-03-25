Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, rusty@rustcorp.com.au,
 ulrich.weigand@de.ibm.com, amodra@gmail.com, mikey@neuling.org,
 mjw@linux.vnet.ibm.com
Subject: [PATCH 14/33] powerpc: Fix kernel thread creation on ABIv2
Date: Tue, 25 Mar 2014 22:44:20 +1100
Message-Id: <1395747879-5948-15-git-send-email-anton@samba.org>
In-Reply-To: <1395747879-5948-1-git-send-email-anton@samba.org>
References: <1395747879-5948-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Change how we setup registers for ret_from_kernel_thread. In
ABIv1, instead of passing a function descriptor in, dereference
it and pass the target in directly.

Use ppc_global_function_entry to get it right on both ABIv1 and ABIv2.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/kernel/entry_64.S |  4 +++-
 arch/powerpc/kernel/process.c  | 17 +++++------------
 2 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index d23d752..cf4f6e6 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -378,9 +378,11 @@ _GLOBAL(ret_from_fork)
 _GLOBAL(ret_from_kernel_thread)
 	bl	schedule_tail
 	REST_NVGPRS(r1)
-	ld	r14, 0(r14)
 	mtlr	r14
 	mr	r3,r15
+#if defined(_CALL_ELF) && _CALL_ELF == 2
+	mr	r12,r14
+#endif
 	blrl
 	li	r3,0
 	b	syscall_exit
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index af064d2..4fcb298 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -54,6 +54,7 @@
 #ifdef CONFIG_PPC64
 #include <asm/firmware.h>
 #endif
+#include <asm/code-patching.h>
 #include <linux/kprobes.h>
 #include <linux/kdebug.h>
 
@@ -1086,7 +1087,9 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 		struct thread_info *ti = (void *)task_stack_page(p);
 		memset(childregs, 0, sizeof(struct pt_regs));
 		childregs->gpr[1] = sp + sizeof(struct pt_regs);
-		childregs->gpr[14] = usp;	/* function */
+		/* function */
+		if (usp)
+			childregs->gpr[14] = ppc_function_entry((void *)usp);
 #ifdef CONFIG_PPC64
 		clear_tsk_thread_flag(p, TIF_32BIT);
 		childregs->softe = 1;
@@ -1165,17 +1168,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 	if (cpu_has_feature(CPU_FTR_HAS_PPR))
 		p->thread.ppr = INIT_PPR;
 #endif
-	/*
-	 * The PPC64 ABI makes use of a TOC to contain function 
-	 * pointers.  The function (ret_from_except) is actually a pointer
-	 * to the TOC entry.  The first entry is a pointer to the actual
-	 * function.
-	 */
-#ifdef CONFIG_PPC64
-	kregs->nip = *((unsigned long *)f);
-#else
-	kregs->nip = (unsigned long)f;
-#endif
+	kregs->nip = ppc_function_entry(f);
 	return 0;
 }
 
-- 
1.8.3.2
