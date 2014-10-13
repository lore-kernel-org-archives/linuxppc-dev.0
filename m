Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 396D31A07E6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Oct 2014 19:41:44 +1100 (EST)
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 zhong@linux.vnet.ibm.com
Subject: [PATCH 2/3] powerpc: Rename __get_SP() to current_stack_pointer()
Date: Mon, 13 Oct 2014 19:41:39 +1100
Message-Id: <1413189700-30322-2-git-send-email-anton@samba.org>
In-Reply-To: <1413189700-30322-1-git-send-email-anton@samba.org>
References: <1413189700-30322-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael points out that __get_SP() is a pretty horrible
function name. Let's give it a better name.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/include/asm/perf_event.h | 2 +-
 arch/powerpc/include/asm/reg.h        | 2 +-
 arch/powerpc/kernel/irq.c             | 2 +-
 arch/powerpc/kernel/misc.S            | 2 +-
 arch/powerpc/kernel/ppc_ksyms.c       | 2 +-
 arch/powerpc/kernel/process.c         | 2 +-
 arch/powerpc/kernel/stacktrace.c      | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/perf_event.h b/arch/powerpc/include/asm/perf_event.h
index b058568..8bf1b63 100644
--- a/arch/powerpc/include/asm/perf_event.h
+++ b/arch/powerpc/include/asm/perf_event.h
@@ -34,7 +34,7 @@
 	do {							\
 		(regs)->result = 0;				\
 		(regs)->nip = __ip;				\
-		(regs)->gpr[1] = __get_SP();			\
+		(regs)->gpr[1] = current_stack_pointer();	\
 		asm volatile("mfmsr %0" : "=r" ((regs)->msr));	\
 	} while (0)
 #endif
diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index e539d7e..c998279 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -1265,7 +1265,7 @@ static inline unsigned long mfvtb (void)
 
 #define proc_trap()	asm volatile("trap")
 
-extern unsigned long __get_SP(void);
+extern unsigned long current_stack_pointer(void);
 
 extern unsigned long scom970_read(unsigned int address);
 extern void scom970_write(unsigned int address, unsigned long value);
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 8eb857f..c143835 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -466,7 +466,7 @@ static inline void check_stack_overflow(void)
 #ifdef CONFIG_DEBUG_STACKOVERFLOW
 	long sp;
 
-	sp = __get_SP() & (THREAD_SIZE-1);
+	sp = current_stack_pointer() & (THREAD_SIZE-1);
 
 	/* check for stack overflow: is there less than 2KB free? */
 	if (unlikely(sp < (sizeof(struct thread_info) + 2048))) {
diff --git a/arch/powerpc/kernel/misc.S b/arch/powerpc/kernel/misc.S
index 120deb7..0d43219 100644
--- a/arch/powerpc/kernel/misc.S
+++ b/arch/powerpc/kernel/misc.S
@@ -115,6 +115,6 @@ _GLOBAL(longjmp)
 	mr	r3,r4
 	blr
 
-_GLOBAL(__get_SP)
+_GLOBAL(current_stack_pointer)
 	PPC_LL	r3,0(r1)
 	blr
diff --git a/arch/powerpc/kernel/ppc_ksyms.c b/arch/powerpc/kernel/ppc_ksyms.c
index 9d84efb..202963e 100644
--- a/arch/powerpc/kernel/ppc_ksyms.c
+++ b/arch/powerpc/kernel/ppc_ksyms.c
@@ -42,4 +42,4 @@ EXPORT_SYMBOL(giveup_spe);
 EXPORT_SYMBOL(epapr_hypercall_start);
 #endif
 
-EXPORT_SYMBOL(__get_SP);
+EXPORT_SYMBOL(current_stack_pointer);
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 3cc6439..923cd2d 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1545,7 +1545,7 @@ void show_stack(struct task_struct *tsk, unsigned long *stack)
 		tsk = current;
 	if (sp == 0) {
 		if (tsk == current)
-			sp = __get_SP();
+			sp = current_stack_pointer();
 		else
 			sp = tsk->thread.ksp;
 	}
diff --git a/arch/powerpc/kernel/stacktrace.c b/arch/powerpc/kernel/stacktrace.c
index 7f65bae..ea43a34 100644
--- a/arch/powerpc/kernel/stacktrace.c
+++ b/arch/powerpc/kernel/stacktrace.c
@@ -50,7 +50,7 @@ void save_stack_trace(struct stack_trace *trace)
 {
 	unsigned long sp;
 
-	sp = __get_SP();
+	sp = current_stack_pointer();
 
 	save_context_stack(trace, sp, current, 1);
 }
-- 
1.9.1
