Return-Path: <anton@samba.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 643431A0428
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Oct 2014 15:10:00 +1000 (EST)
Date: Wed, 1 Oct 2014 15:10:00 +1000
From: Anton Blanchard <anton@samba.org>
To: zhong@linux.vnet.ibm.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au
Subject: [PATCH] powerpc: Reimplement __get_SP() as a function not a define
Message-ID: <20141001151000.0d754938@kryten>
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

Li Zhong points out an issue with our current __get_SP()
implementation. If ftrace function tracing is enabled (ie -pg
profiling using _mcount) we spill a stack frame on 64bit all the
time.

If a function calls __get_SP() and later calls a function that is
tail call optimised, we will pop the stack frame and the value
returned by __get_SP() is no longer valid. An example from Li can
be found in save_stack_trace -> save_context_stack:

c0000000000432c0 <.save_stack_trace>:
c0000000000432c0:       mflr    r0
c0000000000432c4:       std     r0,16(r1)
c0000000000432c8:       stdu    r1,-128(r1) <-- stack frame for _mcount
c0000000000432cc:       std     r3,112(r1)
c0000000000432d0:       bl      <._mcount>
c0000000000432d4:       nop

c0000000000432d8:       mr      r4,r1 <-- __get_SP()

c0000000000432dc:       ld      r5,632(r13)
c0000000000432e0:       ld      r3,112(r1)
c0000000000432e4:       li      r6,1

c0000000000432e8:       addi    r1,r1,128 <-- pop stack frame

c0000000000432ec:       ld      r0,16(r1)
c0000000000432f0:       mtlr    r0
c0000000000432f4:       b       <.save_context_stack> <-- tail call optimized

save_context_stack ends up with a stack pointer below the current
one, and it is likely to be scribbled over.

Fix this by making __get_SP() a function which returns the
callers stack frame. Also replace inline assembly which grabs
the stack pointer in save_stack_trace and show_stack with
__get_SP().

Reported-by: Li Zhong <zhong@linux.vnet.ibm.com>
Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/include/asm/reg.h   | 3 +--
 arch/powerpc/kernel/misc.S       | 4 ++++
 arch/powerpc/kernel/process.c    | 2 +-
 arch/powerpc/kernel/stacktrace.c | 2 +-
 4 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 0c05059..0f973c0 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -1264,8 +1264,7 @@ static inline unsigned long mfvtb (void)
 
 #define proc_trap()	asm volatile("trap")
 
-#define __get_SP()	({unsigned long sp; \
-			asm volatile("mr %0,1": "=r" (sp)); sp;})
+extern unsigned long __get_SP(void);
 
 extern unsigned long scom970_read(unsigned int address);
 extern void scom970_write(unsigned int address, unsigned long value);
diff --git a/arch/powerpc/kernel/misc.S b/arch/powerpc/kernel/misc.S
index 7ce26d4..120deb7 100644
--- a/arch/powerpc/kernel/misc.S
+++ b/arch/powerpc/kernel/misc.S
@@ -114,3 +114,7 @@ _GLOBAL(longjmp)
 	mtlr	r0
 	mr	r3,r4
 	blr
+
+_GLOBAL(__get_SP)
+	PPC_LL	r3,0(r1)
+	blr
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index aa1df89..3cc6439 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1545,7 +1545,7 @@ void show_stack(struct task_struct *tsk, unsigned long *stack)
 		tsk = current;
 	if (sp == 0) {
 		if (tsk == current)
-			asm("mr %0,1" : "=r" (sp));
+			sp = __get_SP();
 		else
 			sp = tsk->thread.ksp;
 	}
diff --git a/arch/powerpc/kernel/stacktrace.c b/arch/powerpc/kernel/stacktrace.c
index 3d30ef1..7f65bae 100644
--- a/arch/powerpc/kernel/stacktrace.c
+++ b/arch/powerpc/kernel/stacktrace.c
@@ -50,7 +50,7 @@ void save_stack_trace(struct stack_trace *trace)
 {
 	unsigned long sp;
 
-	asm("mr %0,1" : "=r" (sp));
+	sp = __get_SP();
 
 	save_context_stack(trace, sp, current, 1);
 }
-- 
1.9.1
