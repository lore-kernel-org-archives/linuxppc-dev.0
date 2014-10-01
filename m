Return-Path: <anton@samba.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C5AF01A1A13
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Oct 2014 17:11:40 +1000 (EST)
Date: Wed, 1 Oct 2014 17:11:39 +1000
From: Anton Blanchard <anton@samba.org>
To: zhong@linux.vnet.ibm.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au
Subject: [PATCH] powerpc: Rename __get_SP() to current_stack_pointer()
Message-ID: <20141001171139.0378b0bc@kryten>
In-Reply-To: <20141001151000.0d754938@kryten>
References: <20141001151000.0d754938@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
 arch/powerpc/kernel/process.c         | 2 +-
 arch/powerpc/kernel/stacktrace.c      | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/perf_event.h b/arch/powerpc/include/asm/perf_event.h
index 0bb2372..fc53598 100644
--- a/arch/powerpc/include/asm/perf_event.h
+++ b/arch/powerpc/include/asm/perf_event.h
@@ -34,7 +34,7 @@
 	do {							\
 		(regs)->result = 0;				\
 		(regs)->nip = __ip;				\
-		(regs)->gpr[1] = *(unsigned long *)__get_SP();	\
+		(regs)->gpr[1] = *(unsigned long *)current_stack_pointer(); \
 		asm volatile("mfmsr %0" : "=r" ((regs)->msr));	\
 	} while (0)
 #endif
diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 0f973c0..d8974b5 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -1264,7 +1264,7 @@ static inline unsigned long mfvtb (void)
 
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
