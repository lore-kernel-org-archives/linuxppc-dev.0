Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 12 Aug 2008 17:03:26 +1000
Subject: [PATCH] powerpc: Fix loss of vdso on fork on 32bit
Message-Id: <20080812070350.A3FAFDDF18@ozlabs.org>
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

When we fork, init_new_context() improperly resets the vdso_base
of the new context to 0. That means that the new process loses
access to the vdso for signal trampolines.

The initialization should be unnecessary anyway as the context
on a fresh mm should be 0 in the first place and binfmt_elf
will initialize that value for a newly loaded process.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

 arch/powerpc/include/asm/mmu_context.h |    1 -
 1 file changed, 1 deletion(-)

--- linux-work.orig/arch/powerpc/include/asm/mmu_context.h	2008-08-12 17:01:06.000000000 +1000
+++ linux-work/arch/powerpc/include/asm/mmu_context.h	2008-08-12 17:01:08.000000000 +1000
@@ -147,7 +147,6 @@ static inline void get_mmu_context(struc
 static inline int init_new_context(struct task_struct *t, struct mm_struct *mm)
 {
 	mm->context.id = NO_CONTEXT;
-	mm->context.vdso_base = 0;
 	return 0;
 }
 
